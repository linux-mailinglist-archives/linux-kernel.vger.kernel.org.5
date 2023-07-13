Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A53752B65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjGMUKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjGMUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271BB2709;
        Thu, 13 Jul 2023 13:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A698761B5F;
        Thu, 13 Jul 2023 20:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 120C9C433CC;
        Thu, 13 Jul 2023 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689279022;
        bh=lOcxPAn7eW8rV5VQ5ki2zUL6NoKylKlp4dLBNIixKAE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uBS5rfT+Db8Tt5JpaNjmHcNM3Zrb2s9NRMvWHmIEbjv0L5mGLw82jDpcU9c7TeFEG
         m1UvrV9Kij7FzvP8/gqs8/eWehrz1nHRow9wsD6W/mveKARl0mezBxXEcAOU/gMhtT
         8IlRBJZym1IXnIgsSrbMKi34H5B9iFKlmKeDOiW2MetIIlzRqQXRTb7aJdkAreQeZb
         1GBRnyCutOTvXsu0/tSTHIx4B795Dn5R5HYb9rOfG54sdlEChu5M8fcN6XY42pCk4V
         upTI/SHICikH2tX5wt8rxgv//ym443lq4/ZRj9QZzDslT05cFiVMeJph1ZC209jc1S
         XqL6CMbjfI0Ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7077E29F42;
        Thu, 13 Jul 2023 20:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] Bluetooth: btmtk: Fix kernel crash when processing
 coredump
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168927902193.26469.1216998273378842695.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Jul 2023 20:10:21 +0000
References: <20230713071105.26248-1-chris.lu@mediatek.com>
In-Reply-To: <20230713071105.26248-1-chris.lu@mediatek.com>
To:     Chris Lu <chris.lu@mediatek.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        sean.wang@mediatek.com, aaron.hou@mediatek.com,
        steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
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

On Thu, 13 Jul 2023 15:11:06 +0800 you wrote:
> There may be a potential kernel crash risk if 'skb->len
> - MTK_COREDUMP_END_LEN' value is less than 0 when doing
> memcmp in btmtk_process_coredump().
> Check the value is valid before doing memcmp.
> 
> [215.021695] Unable to handle kernel paging request at
>              virtual address ffffff939fffd3c5
> [215.021781] Mem abort info:
> [215.021805]   ESR = 0x96000005
> [215.021833]   EC = 0x25: DABT (current EL), IL = 32 bits
> [215.021861]   SET = 0, FnV = 0
> [215.021875]   EA = 0, S1PTW = 0
> [215.021886] Data abort info:
> [215.021899]   ISV = 0, ISS = 0x00000005
> [215.021912]   CM = 0, WnR = 0
> [215.021929] swapper pgtable: 4k pages, 39-bit VAs,
>              pgdp=00000000410de000
> [215.021943] [ffffff939fffd3c5] pgd=0000000000000000,
>              p4d=0000000000000000, pud=0000000000000000
> [215.021979] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [215.022496] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.186#3
>              (HASH:ad23 4)
> [215.022511] Hardware name: MediaTek Tomato board (DT)
> [215.022530] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
> [215.022556] pc : __pi_memcmp+0xd0/0x1b8
> [215.022579] lr : btmtk_process_coredump+0xb0/0x5f8 [btmtk]
> [215.022593] sp : ffffffc010003d40
> [215.022607] x29: ffffffc010003d40 x28: 0000000000000006
> [215.022633] x27: ffffffda696350c0 x26: 0000000000000002
> [215.022659] x25: 00000000000003ff x24: ffffff9360cca804
> [215.022685] x23: 0000000000000000 x22: ffffff9365638500
> [215.022710] x21: ffffff9365638700 x20: 0000000000000000
> [215.022736] x19: ffffff936002e000 x18: 0000000000000000
> [215.022761] x17: 0000000000000180 x16: ffffffda6881b8b4
> [215.022787] x15: 0000000000000001 x14: 0000000000002d00
> [215.022812] x13: 0000000000060000 x12: 0000000000000181
> [215.022837] x11: 0000000000000006 x10: fffffffffffffffd
> [215.022862] x9 : 0000000000000006 x8 : 0000000000000003
> [215.022887] x7 : 0000000000000000 x6 : 0000000000000000
> [215.022913] x5 : ffffff93656387b8 x4 : 0000000000000000
> [215.022938] x3 : ffffffc010003c18 x2 : 0000000000000006
> [215.022963] x1 : ffffffda09d4124a x0 : ffffff939fffd3c5
> [215.022989] Call trace:
> [215.023012]  __pi_memcmp+0xd0/0x1b8
> [215.023053]  btusb_recv_acl_mtk+0x64/0x90 [btusb (HASH:dc6b 5)]
> [215.023087]  btusb_recv_bulk+0x118/0x170 [btusb (HASH:dc6b 5)]
> [215.023121]  btusb_bulk_complete+0x8c/0x148 [btusb (HASH:dc6b 5)]
> [215.023144]  __usb_hcd_giveback_urb+0xbc/0x148
> [215.023164]  usb_giveback_urb_bh+0xb4/0x190
> [215.023184]  tasklet_action_common+0x98/0x1a0
> [215.023201]  tasklet_action+0x2c/0x38
> [215.023220]  __do_softirq+0xe0/0x38c
> [215.023241]  invoke_softirq+0x34/0x6c
> [215.023258]  irq_exit+0x6c/0xb0
> [215.023279]  __handle_domain_irq+0x98/0xd4
> [215.023296]  gic_handle_irq+0x5c/0x11c
> [215.023313]  el1_irq+0xd0/0x180
> [215.023332]  cpuidle_enter_state+0xac/0x338
> [215.023349]  cpuidle_enter+0x40/0x70
> [215.023366]  do_idle+0x150/0x278
> [215.023384]  cpu_startup_entry+0x2c/0x58
> [215.023401]  rest_init+0xdc/0xec
> [215.023419]  arch_call_rest_init+0x18/0x24
> [215.023435]  start_kernel+0x334/0x400
> [215.023460] Code: 91002129 eb09010a 9a89810b cb0b0042 (38401403)
> [215.023478] ---[ end trace 28668fd20c7a90cd ]
> 
> [...]

Here is the summary with links:
  - [v6] Bluetooth: btmtk: Fix kernel crash when processing coredump
    https://git.kernel.org/bluetooth/bluetooth-next/c/2ba6216b8b37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


