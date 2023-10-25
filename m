Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3567D678C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbjJYJwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343610AbjJYJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:52:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C466DDE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:52:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C3432F4;
        Wed, 25 Oct 2023 02:53:11 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55DE63F738;
        Wed, 25 Oct 2023 02:52:27 -0700 (PDT)
Date:   Wed, 25 Oct 2023 10:50:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 1/4] firmware: arm_ffa: Allow FF-A initialisation even
 when notification fails
Message-ID: <20231025095053.i7bpswi6x6ckqdnr@bogus>
References: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
 <20231024-ffa-notification-fixes-v1-1-d552c0ec260d@arm.com>
 <CAHUa44GvCeihX8KQkXELOAkZpYVq6=3M06MT8GEd3COA3GPhTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44GvCeihX8KQkXELOAkZpYVq6=3M06MT8GEd3COA3GPhTw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:10:11AM +0200, Jens Wiklander wrote:
> On Tue, Oct 24, 2023 at 12:56 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > FF-A notifications are optional feature in the specification. Currently
> > we allow to continue if the firmware reports no support for the
> > notifications. However, we fail to continue and complete the FF-A
> > driver initialisation if the notification setup fails for any reason.
> >
> > Let us allow the FF-A driver to complete the initialisation even if the
> > notification fails to setup. We will just flag the error and continue
> > to provide other features in the driver.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_ffa/driver.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> > index 07b72c679247..b4ba52d674e5 100644
> > --- a/drivers/firmware/arm_ffa/driver.c
> > +++ b/drivers/firmware/arm_ffa/driver.c
[..]
> > @@ -1426,10 +1426,11 @@ static int ffa_notifications_setup(void)
> >         ret = ffa_sched_recv_cb_update(drv_info->vm_id, ffa_self_notif_handle,
> >                                        drv_info, true);
> >         if (!ret)
> > -               return ret;
> > +               return;
> >  cleanup:
> > +       pr_info("Notification setup failed %d, not enabled\n", ret);
> >         ffa_notifications_cleanup();
> > -       return ret;
> > +       return;
>
> This return is redundant.
>

Thanks, will fix it.

--
Regards,
Sudeep
