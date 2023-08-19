Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B28278190E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjHSKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjHSKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1696549E92;
        Sat, 19 Aug 2023 03:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A836160B09;
        Sat, 19 Aug 2023 10:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE61C433C8;
        Sat, 19 Aug 2023 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692440877;
        bh=kHtlWNGcrxnYlVE9OS783R8jqaKBtywz8/2kTx1r7Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=01qjPJeVdLQYdLSOj2Ko5KsuRssGSMcZpDa9MCUc7my3/n0eLH55VLY2zLf0bpQhI
         eGq2PvoNPgI0gYlcp0rEsPz/ibnVvl33YndjuouP1pggKjx/u5MgJW0p69MSINSS51
         3lc5V9icPzE8coL4IEB0Ho3Ij7Bvb9Y+rRh+Bigk=
Date:   Sat, 19 Aug 2023 12:27:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     coolrrsh@gmail.com
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Subject: Re: [PATCH] UBSAN: shift-out-of-bounds in set_flicker
Message-ID: <2023081910-sadden-rebate-16c3@gregkh>
References: <20230818164522.12806-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818164522.12806-1-coolrrsh@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:15:22PM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> Syzkaller reported the following issue:
> 
> UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
> shift exponent 245 is too large for 32-bit type 'int'
> CPU: 1 PID: 25 Comm: kworker/1:1 
> Not tainted 6.5.0-rc4-syzkaller-00118-g55c3e571d2a0 #0
> Hardware name: 
> Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x27a/0x600 lib/ubsan.c:387
>  set_flicker.cold+0x1b/0x20 drivers/media/usb/gspca/cpia1.c:1031
>  sd_s_ctrl+0x2c6/0xbf0 drivers/media/usb/gspca/cpia1.c:1782
>  __v4l2_ctrl_handler_setup+0x511/0x710 
> drivers/media/v4l2-core/v4l2-ctrls-core.c:2481
>  v4l2_ctrl_handler_setup 
> drivers/media/v4l2-core/v4l2-ctrls-core.c:2498 [inline]
>  v4l2_ctrl_handler_setup+0x50/0xa0 
> drivers/media/v4l2-core/v4l2-ctrls-core.c:2490
>  gspca_set_default_mode drivers/media/usb/gspca/gspca.c:908 [inline]
>  gspca_dev_probe2+0xdd6/0x1b20 drivers/media/usb/gspca/gspca.c:1541
>  gspca_dev_probe+0x18b/0x270 drivers/media/usb/gspca/gspca.c:1610
>  usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:579 [inline]
>  really_probe+0x234/0xc90 drivers/base/dd.c:658
>  __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:798
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
>  __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:956
>  bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
>  __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
>  bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
>  device_add+0x11f1/0x1b40 drivers/base/core.c:3625
>  usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
>  usb_generic_driver_probe+0xca/0x130 drivers/usb/core/generic.c:238
>  usb_probe_device+0xda/0x2c0 drivers/usb/core/driver.c:293
>  call_driver_probe drivers/base/dd.c:579 [inline]
>  really_probe+0x234/0xc90 drivers/base/dd.c:658
>  __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:798
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
>  __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:956
>  bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
>  __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
>  bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
>  device_add+0x11f1/0x1b40 drivers/base/core.c:3625
>  usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
>  hub_port_connect drivers/usb/core/hub.c:5440 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
>  port_event drivers/usb/core/hub.c:5740 [inline]
>  hub_event+0x2e62/0x4f30 drivers/usb/core/hub.c:5822
>  process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
>  process_scheduled_works kernel/workqueue.c:2664 [inline]
>  worker_thread+0x896/0x1110 kernel/workqueue.c:2750
>  kthread+0x33a/0x430 kernel/kthread.c:389
>  ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>  </TASK>
> 
> shift-out-of-bounds error was triggered when sd->params.exposure.gain 
> is right shifted beyond the bit range of int. Therefore added the 
> conditional check before the shift operation.
> 
> Tested via syzbot.
> 
> Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
> 
> dashboard link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> ---
>  drivers/media/usb/gspca/cpia1.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
> index 46ed95483e22..bb22be99ea8c 100644
> --- a/drivers/media/usb/gspca/cpia1.c
> +++ b/drivers/media/usb/gspca/cpia1.c
> @@ -1028,7 +1028,9 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
>  			sd->params.exposure.expMode = 2;
>  			sd->exposure_status = EXPOSURE_NORMAL;
>  		}
> +		if(sd->params.exposure.gain < 32){
>  		currentexp = currentexp << sd->params.exposure.gain;
> +		}
>  		sd->params.exposure.gain = 0;
>  		/* round down current exposure to nearest value */
>  		startexp = (currentexp + ROUND_UP_EXP_FOR_FLICKER) / cj;

Always run scripts/checkpatch.pl on your change to prevent grumpy
mantainers and bots from asking why you didn't run scripts/checkpatch.pl
on your change.

