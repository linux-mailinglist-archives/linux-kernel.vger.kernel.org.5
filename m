Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440B6752B64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjGMUK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjGMUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37012273E;
        Thu, 13 Jul 2023 13:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B95F161B63;
        Thu, 13 Jul 2023 20:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FAB3C433CD;
        Thu, 13 Jul 2023 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689279022;
        bh=/T0RGImw5OHbBJqaqZIGtDVaNfpbb1jTUyvOzVCwqwc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qptsmUk/s9g37BNrYb553GLnStu/I0oyNyzlTqBV+ZvSkkie6WljdpBaEnUkXiaiV
         VcHFdVS4aqekHNY8Ym02sxxD7FvT45Neat3KDUUcNIzTlnVIVb/CIliblIZZCGg3IW
         mJiSO+b9VSu5La1Jv/xK6m/E8Z1vIUQ1oOmug8tmKbXu4qUmtVVaJF9M1zD+epXXwM
         6qQE7nviXikgLC+OqNftvbF76FaeDKcieg15zpjiL4aVvbuCzRitSH+jYOkhJL9bfm
         jAtkaoIXdtW4W1GHJMyTKYIpBMTC4y+ZTPPjeiZvv4xZaInXwAaQHUOwxMvvNelosV
         IjpMwxGrIrlOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 024D9F83708;
        Thu, 13 Jul 2023 20:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix hci_suspend_sync crash
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168927902200.26469.6694434190230470998.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Jul 2023 20:10:22 +0000
References: <20230705210647.1.I636c21e4dc8fe3352f4d7aef26c0ec3857e24ca0@changeid>
In-Reply-To: <20230705210647.1.I636c21e4dc8fe3352f4d7aef26c0ec3857e24ca0@changeid>
To:     Ying Hsu <yinghsu@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, marcel@holtmann.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Jul 2023 21:06:47 +0000 you wrote:
> If hci_unregister_dev() frees the hci_dev object but hci_suspend_notifier
> may still be accessing it, it can cause the program to crash.
> Here's the call trace:
>   <4>[102152.653246] Call Trace:
>   <4>[102152.653254]  hci_suspend_sync+0x109/0x301 [bluetooth]
>   <4>[102152.653259]  hci_suspend_dev+0x78/0xcd [bluetooth]
>   <4>[102152.653263]  hci_suspend_notifier+0x42/0x7a [bluetooth]
>   <4>[102152.653268]  notifier_call_chain+0x43/0x6b
>   <4>[102152.653271]  __blocking_notifier_call_chain+0x48/0x69
>   <4>[102152.653273]  __pm_notifier_call_chain+0x22/0x39
>   <4>[102152.653276]  pm_suspend+0x287/0x57c
>   <4>[102152.653278]  state_store+0xae/0xe5
>   <4>[102152.653281]  kernfs_fop_write+0x109/0x173
>   <4>[102152.653284]  __vfs_write+0x16f/0x1a2
>   <4>[102152.653287]  ? selinux_file_permission+0xca/0x16f
>   <4>[102152.653289]  ? security_file_permission+0x36/0x109
>   <4>[102152.653291]  vfs_write+0x114/0x21d
>   <4>[102152.653293]  __x64_sys_write+0x7b/0xdb
>   <4>[102152.653296]  do_syscall_64+0x59/0x194
>   <4>[102152.653299]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix hci_suspend_sync crash
    https://git.kernel.org/bluetooth/bluetooth-next/c/0c9bf63ad8ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


