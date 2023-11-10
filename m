Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5187E805A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344954AbjKJSJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbjKJSGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:06:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65709A256
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 00:40:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1B02C433C9;
        Fri, 10 Nov 2023 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699605629;
        bh=saabdHyMdvYng2Dm3AITfV8opude96FOgCmZKQQ9Eew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a7GDCKJXsxeZRLI4Kdg05bO/fVQCEWG0xKShB+lG5QpJOLheLL9wPxRJvtSaIFCBz
         xx55YTy6+GYLQXEqALeON+ZnzpFKYRLfpCXK7p9dzuBONrM8gT8TgLJKNWwHltfN1S
         IQ08kx8R6YYKXktp4anXEQOHrCxp9p9k2NSS9CxA+dkphakXtjGzV1SrDuQZpbfN1a
         lci16sUuG8TmkCQ88IFXgMZrbMKDKWTFR6HPadG2fNRdLveksmr86MJcIF5Vsg1VLV
         IVGmoHaop+U2L94HNAfvjJaiIK9liCkHiGR0yKGlaDncsrXEIgCWTUcVg4fxg1iKIa
         HKoD/N6+2knpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3AA8C4166E;
        Fri, 10 Nov 2023 08:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] ptp: Fixes a null pointer dereference in ptp_ioctl
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169960562886.22093.15188059654948446469.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Nov 2023 08:40:28 +0000
References: <DB3PR10MB6835D68E7E632532155AE585E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB3PR10MB6835D68E7E632532155AE585E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     richardcochran@gmail.com, netdev@vger.kernel.org, eadavis@qq.com,
        davem@davemloft.net, reibax@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  8 Nov 2023 02:18:36 +0530 you wrote:
> Syzkaller found a null pointer dereference in ptp_ioctl
> originating from the lack of a null check for tsevq.
> 
> ```
> general protection fault, probably for non-canonical
> 	address 0xdffffc000000020b: 0000 [#1] PREEMPT SMP KASAN
> KASAN: probably user-memory-access in range
> 	[0x0000000000001058-0x000000000000105f]
> CPU: 0 PID: 5053 Comm: syz-executor353 Not tainted
> 	6.6.0-syzkaller-10396-g4652b8e4f3ff #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> 	BIOS Google 10/09/2023
> RIP: 0010:ptp_ioctl+0xcb7/0x1d10 drivers/ptp/ptp_chardev.c:476
> ...
> Call Trace:
>  <TASK>
>  posix_clock_ioctl+0xf8/0x160 kernel/time/posix-clock.c:86
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl fs/ioctl.c:857 [inline]
>  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> ```
> 
> [...]

Here is the summary with links:
  - [RESEND] ptp: Fixes a null pointer dereference in ptp_ioctl
    https://git.kernel.org/netdev/net/c/8a4f030dbced

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


