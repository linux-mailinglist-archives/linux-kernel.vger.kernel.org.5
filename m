Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18737FD274
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjK2J00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2J0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:26:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0DE1A5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:26:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-409299277bbso49245525e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701249989; x=1701854789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8O/nuwsdKGU52NreHcZxhpgEp8dykxw7lGHzNqJuX8=;
        b=rRMQV7eM2OlagwsQhRE63Fg5wggExEpVYFU0cReIMYyZvq2JVmpejeQiviLOvkjqlG
         OKj1Q0tEiUIzJ2+ld8psMTJUyv30dcQM9G5pxkxs3vaw9tc2eGPK++2NBPb/LR1alYpP
         aBMIROERsi0xB/suS1/RiBpPzyaSoz2UGHGILhUF8xAmHRwdCmEhhBvvskB1bGUsfrE8
         /MAzTSdwt+9JNRIP20D/IV3LHlhjYIwes93+cgr5VLDjpp45Rw373eylujkE2iaBv0VS
         hhWyk/XWGuec9grTKmVjm/00xTsl6ZNnSMmFQcIMPu2jj5uEeZ5roFM9+xB9wB1EjosE
         TwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249989; x=1701854789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8O/nuwsdKGU52NreHcZxhpgEp8dykxw7lGHzNqJuX8=;
        b=kY5bEmnKPaxInpQXCavxOh9pEurUpdrmy/YlrsAsC+EYfpUoV/VQ4imBFz1n6jc6iq
         OqE1Y4sFD/8Ecs0YXJyhVoOo2VKemLL//0/WSLZ0AFFsMLOJmGvQIgoHUh3zmDU2x98A
         6FEIoNs8eHUcK8wQpbVBpr66Cm5sE6aKNVCj7B69T4zDrfQ5qN4C6BcOtCrmp0Uro8MV
         WU/UCGxBqCHAM/sXoQLav9YFi9NVgNwMg0+nJmPe/PfXQMRRhqqc/QXvtO2dUzDl0TFh
         +Wf/gmJjpUvCcbc/ulOsZD10Hb3GqUow6ft69mYmgaJishX6juiAb4MHM4BaObFT1JkA
         B9pQ==
X-Gm-Message-State: AOJu0YxTVlUgzou9KTNW6xS0v85/sEV5EYTi1jE45X4X7CpRcejyTrlA
        PUCcG+bcZS2PFScvUopEozQihQ==
X-Google-Smtp-Source: AGHT+IHkcagKEtwdXNV8l2UAjzC9Tph2HoH0JeWCCI53NSslDZsHp7jzdeo924Ha5Yxg7Zszd9hFuQ==
X-Received: by 2002:a05:600c:4f16:b0:40a:20f3:d126 with SMTP id l22-20020a05600c4f1600b0040a20f3d126mr11812689wmq.6.1701249989220;
        Wed, 29 Nov 2023 01:26:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d42c8000000b00332fa6cc8acsm10098442wrr.87.2023.11.29.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:26:28 -0800 (PST)
Date:   Wed, 29 Nov 2023 12:26:24 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
        gost.dev@samsung.com, nitheshshetty@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Message-ID: <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
 <20231128122958.2235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128122958.2235-1-nj.shetty@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:59:56PM +0530, Nitesh Shetty wrote:
> This fixes the smatch warning, "nvme_loop_create_ctrl() warn:
> 'opts->queue_size - 1' 18446744073709551615 can't fit into 65535
> 'ctrl->ctrl.sqsize'"
> We don't need size_t for queue_size, u16 should serve the purpose,
> as max size is limited to NVMF_DEF_QUEUE_SIZE(1024).
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>

Huh...  I'm sorry I wasn't necessarily aware that I had published this
Smatch warning.  I feel like it has a high rate of false positives.

Generally with Smatch warnings, I'm not going to try silence every
false positive.  And I had one complaint recently that I was too focused
on silencing false positives instead of discovering new bugs...

The other thing about static analysis is that static checker developers
want 0% false positives and kernel developers want 100% false positives.
I'm a kernel developer so in code that I have looked at the rate of
false positives is very close to 100%.  Only new code has valid
warnings.

Here is what this code looks like:

drivers/nvme/target/loop.c
   573          if (opts->queue_size > ctrl->ctrl.maxcmd) {
   574                  /* warn if maxcmd is lower than queue_size */
   575                  dev_warn(ctrl->ctrl.device,
   576                          "queue_size %zu > ctrl maxcmd %u, clamping down\n",
   577                          opts->queue_size, ctrl->ctrl.maxcmd);
   578                  opts->queue_size = ctrl->ctrl.maxcmd;
   579          }
   580          ctrl->ctrl.sqsize = opts->queue_size - 1;

Smatch thinks that opts->queue_size is a value that comes from the user
in the 16-47 range.  But the bug is that Smatch thinks that
ctrl->ctrl.maxcmd is zero.  16 is greater than zero so we do the
opts->queue_size = ctrl->ctrl.maxcmd; assignment.  Then zero minus one
is ULONG_MAX so that's a very high number.

Smatch is just wrong in this case.  Let me try figure out what went
wrong.  The ctrl->ctrl.maxcmd = 0 comes from:

	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);

It's supposed to get set to unknown in nvme_loop_configure_admin_queue().
The database has the correct data.

$ smdb.py return_states nvme_loop_configure_admin_queue | grep maxcmd
drivers/nvme/target/loop.c | nvme_loop_configure_admin_queue | 229 |             0|       PARAM_SET |  0 |       $->ctrl.maxcmd |             0-u16max |
drivers/nvme/target/loop.c | nvme_loop_configure_admin_queue | 231 | s32min-(-1),1-s32max|       PARAM_ADD |  0 |       $->ctrl.maxcmd |             0-u16max |

But the issue is that Smatch thinks that nvme_loop_configure_admin_queue()
always fails with -12.  The reason for that is because Smatch thinks
that ctrl->ctrl.ops is NULL but the function can only succeed when it's
non-NULL.

The ctrl->ops assignment happens in nvme_init_ctrl() and it should have
been easy to track.  I am not sure what went wrong there.  I'll take a
look at that and fix it.

regards,
dan carpenter

