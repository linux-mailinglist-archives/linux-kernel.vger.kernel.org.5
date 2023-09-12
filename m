Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6BC79D5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjILQIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbjILQIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:08:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1F361725
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:08:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1FBBC15;
        Tue, 12 Sep 2023 09:08:55 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81A803F738;
        Tue, 12 Sep 2023 09:08:17 -0700 (PDT)
Date:   Tue, 12 Sep 2023 17:08:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: Re: [PATCH RFT 03/12] firmware: arm_ffa: Implement the notification
 bind and unbind interface
Message-ID: <20230912160814.maooz77hthnja2py@bogus>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
 <20230803-ffa_v1-1_notif-v1-3-6613ff2b1f81@arm.com>
 <20230912132353.GB4160483@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912132353.GB4160483@rayden>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:23:53PM +0200, Jens Wiklander wrote:
> On Thu, Aug 03, 2023 at 08:02:07PM +0100, Sudeep Holla wrote:
> > A receiver endpoint must bind a notification to any sender endpoint
> > before the latter can signal the notification to the former. The receiver
> > assigns one or more doorbells to a specific sender. Only the sender can
> > ring these doorbells.
> > 
> > A receiver uses the FFA_NOTIFICATION_BIND interface to bind one or more
> > notifications to the sender. A receiver un-binds a notification from a
> > sender endpoint to stop the notification from being signaled. It uses
> > the FFA_NOTIFICATION_UNBIND interface to do this.
> > 
> > Allow the FF-A driver to be able to bind and unbind a given notification
> > ID to a specific partition ID. This will be used to register and
> > unregister notification callbacks from the FF-A client drivers.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 022c893c9e06..a76e5d3a2422 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
> > @@ -575,6 +575,35 @@ static int ffa_notification_bitmap_destroy(void)
> >  	return 0;
> >  }
> >  
> > +#define NOTIFICATION_LOW_MASK		GENMASK(31, 0)
> > +#define NOTIFICATION_HIGH_MASK		GENMASK(63, 32)
> > +#define NOTIFICATION_BITMAP_HIGH(x)	\
> > +		((u32)(FIELD_GET(NOTIFICATION_HIGH_MASK, (x))))
> > +#define NOTIFICATION_BITMAP_LOW(x)	\
> > +		((u32)(FIELD_GET(NOTIFICATION_LOW_MASK, (x))))
> > +
> > +static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
> > +					u32 flags, bool is_bind)
> > +{
> > +	ffa_value_t ret;
> > +	u32 func, src_dst_ids = PACK_TARGET_INFO(dst_id, drv_info->vm_id);
> dst_id and drv_info->vm_id should be swapped in the argument to
> PACK_TARGET_INFO().
> 

Thanks a lot for having a look at the series. I see Olivier or someone
have already pointed this in private and I seem to have it fixed locally
already.

-- 
Regards,
Sudeep
