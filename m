Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119C37EA276
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjKMR5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMR53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:57:29 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EC5F7;
        Mon, 13 Nov 2023 09:57:25 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4D6820007;
        Mon, 13 Nov 2023 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699898243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WH24bviU1ZhufeHfDAFuXnvRWpHec4/VwB66bIsKjs=;
        b=BU6U1zcqFsfoFvYirJ7S+4qslwzBBeP6jWjmB55Qp61Gd6CbIx0fkb7zCAZOPVpnHYnd7c
        fx9tYY3ReFxCZ17mmQ3X/lA9QCqlTguXSunfo2LHyOeC8E4J0Am3M/0qhcc833okUE6zxe
        1twU34ht/2iGur9UZMVRzWwCuNLyBm6AVpTggqF9hzf5h9fVLOyB2guib436j6NuSo6j/1
        tC29fagp8OYoV67L4kKFUW9AGTayvEwIZcvh+iubd0TwVKev+SePESH11cSx+z5l0d6Nn9
        siSOdhOOJQ1JMGazfFrKeUOF4VrmgzCmZum1cSDGLVtUyrYIphRIVmR6dLR2fw==
Date:   Mon, 13 Nov 2023 18:57:20 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] driver core: Remove warning on driver unbinding
Message-ID: <20231113185720.5f567046@bootlin.com>
In-Reply-To: <CAGETcx-Mp0uKBF_BWFFBUm=eVOp8xhxF3+znFB8vTaFwpJWTnw@mail.gmail.com>
References: <20231110080241.702999-1-herve.codina@bootlin.com>
        <CAGETcx-Mp0uKBF_BWFFBUm=eVOp8xhxF3+znFB8vTaFwpJWTnw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Fri, 10 Nov 2023 17:42:26 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Fri, Nov 10, 2023 at 12:02 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > During driver unbinding, __device_links_no_driver() can raise the
> > following warning:
> >    --- 8< ---
> >    WARNING: CPU: 0 PID: 166 at drivers/base/core.c:1426 __device_links_no_driver+0xac/0xb4
> >    ...
> >    Call trace:
> >    __device_links_no_driver+0xac/0xb4
> >    device_links_driver_cleanup+0xa8/0xf0
> >    device_release_driver_internal+0x204/0x240
> >    device_release_driver+0x18/0x24
> >    bus_remove_device+0xcc/0x10c
> >    device_del+0x158/0x414
> >    platform_device_del.part.0+0x1c/0x88
> >    platform_device_unregister+0x24/0x40
> >    of_platform_device_destroy+0xfc/0x10c
> >    device_for_each_child_reverse+0x64/0xb4
> >    devm_of_platform_populate_release+0x4c/0x84
> >    release_nodes+0x5c/0x90
> >    devres_release_all+0x8c/0xdc
> >    device_unbind_cleanup+0x18/0x68
> >    device_release_driver_internal+0x20c/0x240
> >    device_links_unbind_consumers+0xe0/0x108
> >    device_release_driver_internal+0xf0/0x240
> >    driver_detach+0x50/0x9c
> >    bus_remove_driver+0x6c/0xbc
> >    driver_unregister+0x30/0x60
> >    ...
> >    --- 8< ---
> >
> > This warning is raised because, during device removal, we unlink a
> > consumer while its supplier links.status is DL_DEV_UNBINDING.
> > Even if the link is not a SYNC_STATE_ONLY, the warning should not
> > appear in that case.
> >
> > Filter out this warning in case of the supplier driver is unbinding.
> >
> > Fixes: 8c3e315d4296 ("driver core: Update device link status correctly for SYNC_STATE_ONLY links")  
> 
> Wrong Fixes tag. I just added the SYNC_STATE_ONLY exception. The issue
> has been there since before.

This commit adds the check
  if (link->supplier->links.status == DL_DEV_DRIVER_BOUND)
to set the link.status to DL_STATE_CONSUMER_PROBE or DL_STATE_DORMANT.

Also this commit adds the warning on !(link->flags & DL_FLAG_SYNC_STATE_ONLY)

> 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/base/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 17f2568e0a79..f4b09691998e 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1423,7 +1423,8 @@ static void __device_links_no_driver(struct device *dev)
> >                 if (link->supplier->links.status == DL_DEV_DRIVER_BOUND) {
> >                         WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> >                 } else {
> > -                       WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY));
> > +                       WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY) &&
> > +                               link->supplier->links.status != DL_DEV_UNBINDING);  
> 
> Don't delete the warning please. Make it better so it doesn't warn
> when it shouldn't.
> 
> This combined with the other patches you sent make me think this is
> more of an issue in the device removal ordering than an actual issue
> with the warning. I'm not fully convinced the warning is incorrect
> yet.
> 

When link->supplier->links.status == DL_DEV_UNBINDING, 
what should be the link->status set ?
DL_STATE_DORMANT seems correct in that case.

Removing or not the warning in that case depends on the answer to:
Is DL_FLAG_SYNC_STATE_ONLY should be set in link->flags on all calls to
__device_links_no_driver() with link->supplier->links.status set to
DL_DEV_UNBINDING ?

I lack the knowledge to answer perfectly to this question.
Can you help me on this point ?

Best regards,
Hervé
