Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01A78030D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356858AbjHRBWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356938AbjHRBWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:22:03 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAA7448D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:21:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-565f8b23151so85426a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692321685; x=1692926485;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HgV6QkCXuVGaj9r0bY3pZeAJ8G99Uwd4RPEeNO69yg=;
        b=IPqgAMfBdYYudPJZ3jiKRcp3VbazelPGKFQVhZG2NUyZUiny65YCFU46ZNvyNYPQSR
         79XlMozAxk4vMjyLE/LI/e+Bky+IbXZ1nP3+uEdyKqdPIFtbxa8fYxQbQ/+vhYamcWmd
         6d4okcffkYW1FfbHsVdOyrfOjaPxKNGbnyisdD7TQzgvJY9sAH16UxU4r84WeYuNVKJi
         6j+laNxgU8MVGQjnn5vrXzgTwadNfCAZM1VpScJ2wbS2SpgJaWNOyLpiDlIcmtkGg+kN
         EyuTjfXSsL6OwMZs41R3jNIj5P7YDOPEA/z8brP9nJBbx4wzur271I+1ul0hEF4Nnv2x
         5OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692321685; x=1692926485;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HgV6QkCXuVGaj9r0bY3pZeAJ8G99Uwd4RPEeNO69yg=;
        b=PetZjWE2rcVpZJpUsnL99LDGLgyFme3CVk63Gn/Rt81CY9NP2Sw40XS/dK61gdalAt
         r25fJcFLxhovcAUHq35ms33dVkv2EoYZ4aPPoEEOROjJPmpz50c/l7sGq6bwG51dce5m
         cn1NUznv2n6ECvziRxxWtqGEQ5gdmMepAbXemeYp/5X0gu4U2oO/Glamz62LuW9kP03b
         VDbCkqwhYH1DGglV3zIz3T9Kn29F5aax2DfEbfvqYGBbIUet4AFJCzlZ501p9Z2f4dFn
         29ypFeMzupFqTik6PLxPBtpCrOvjtUM7pF/1cDh3xnBICEnr7ThsDcjUBGqT3jaLnWyA
         4RCA==
X-Gm-Message-State: AOJu0YxtjgkCbO47bV11ByZ5vgNJF6RQPqWxFJzaPSwROvOcg2prCUe5
        bbD1RGzh58Bcu49Q45WhZbePgIFyAWeOXqqX7cI=
X-Google-Smtp-Source: AGHT+IHz9skIyACs/5ZpVcrRBMRJ3gozd8Eigs/K1LrxV18BUJnanVhXoQ5J7YF6JICU1sl9UWwMeg==
X-Received: by 2002:a05:6a21:9989:b0:112:cf5:d5cc with SMTP id ve9-20020a056a21998900b001120cf5d5ccmr1741595pzb.1.1692321684715;
        Thu, 17 Aug 2023 18:21:24 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b0068746ab9aebsm387139pfo.14.2023.08.17.18.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 18:21:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Breno Leitao <leitao@debian.org>, kernel-team@meta.com
In-Reply-To: <ZN0p5_W-Q9mAHBVY@slm.duckdns.org>
References: <ZN0p5_W-Q9mAHBVY@slm.duckdns.org>
Subject: Re: [PATCH for-6.6/block] blk-cgroup: Fix NULL deref caused by
 blkg_policy_data being installed before init
Message-Id: <169232168362.702027.10446286850922079635.b4-ty@kernel.dk>
Date:   Thu, 17 Aug 2023 19:21:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug 2023 09:56:23 -1000, Tejun Heo wrote:
> blk-iocost sometimes causes the following crash:
> 
>   BUG: kernel NULL pointer dereference, address: 00000000000000e0
>   ...
>   RIP: 0010:_raw_spin_lock+0x17/0x30
>   Code: be 01 02 00 00 e8 79 38 39 ff 31 d2 89 d0 5d c3 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 65 ff 05 48 d0 34 7e b9 01 00 00 00 31 c0 <f0> 0f b1 0f 75 02 5d c3 89 c6 e8 ea 04 00 00 5d c3 0f 1f 84 00 00
>   RSP: 0018:ffffc900023b3d40 EFLAGS: 00010046
>   RAX: 0000000000000000 RBX: 00000000000000e0 RCX: 0000000000000001
>   RDX: ffffc900023b3d20 RSI: ffffc900023b3cf0 RDI: 00000000000000e0
>   RBP: ffffc900023b3d40 R08: ffffc900023b3c10 R09: 0000000000000003
>   R10: 0000000000000064 R11: 000000000000000a R12: ffff888102337000
>   R13: fffffffffffffff2 R14: ffff88810af408c8 R15: ffff8881070c3600
>   FS:  00007faaaf364fc0(0000) GS:ffff88842fdc0000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00000000000000e0 CR3: 00000001097b1000 CR4: 0000000000350ea0
>   Call Trace:
>    <TASK>
>    ioc_weight_write+0x13d/0x410
>    cgroup_file_write+0x7a/0x130
>    kernfs_fop_write_iter+0xf5/0x170
>    vfs_write+0x298/0x370
>    ksys_write+0x5f/0xb0
>    __x64_sys_write+0x1b/0x20
>    do_syscall_64+0x3d/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Fix NULL deref caused by blkg_policy_data being installed before init
      commit: ec14a87ee1999b19d8b7ed0fa95fea80644624ae

Best regards,
-- 
Jens Axboe



