Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41677804C82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbjLEIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjLEIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:34:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABEA183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:34:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38ACC433C7;
        Tue,  5 Dec 2023 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701765260;
        bh=S+jEnDi0DYvRicPHFkbDYYg7tscTh0rePei/TRXtL1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWk68OgCMcIzQjusJMpMiQc3iNYpt50iIcoH/RrCoIZbjt3/+l1WgSM3adTU/TmpY
         1hEiyxDCKdpY7832J6k5NtCdAxmB5v7DYOvN7cyl9uaidtbZSZN1lGJy1t/KxfzgoZ
         IH+j8nykya/tFwzt7alyVVg/gZpRPzgC2SuZp4R8rfUFIwhtimVYrl49oTe99rqmZa
         9y8jMGeOaudT9pN4rYTo+MezQsy/bQvq5Az3dhJp6hVR5dqCQpZvI+PBqokSqbfPcX
         Afm5EYzneVJNQzhUDyS40vN8y5SGGkwm3iFBEhqmQTa1xPVIZZfrvyx8Q+n6JlWrbu
         EhftncYt8TjOw==
Date:   Tue, 5 Dec 2023 08:34:15 +0000
From:   Simon Horman <horms@kernel.org>
To:     "D. Wythe" <alibuda@linux.alibaba.com>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        dxu@dxuuu.xyz, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ast@kernel.org
Subject: Re: [PATCH net] net/netfilter: bpf: fix bad registration on nf_defrag
Message-ID: <20231205083415.GQ50400@kernel.org>
References: <1701329003-14564-1-git-send-email-alibuda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701329003-14564-1-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 03:23:23PM +0800, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We should pass a pointer to global_hook to the get_proto_defrag_hook()
> instead of its value, since the passed value won't be updated even if
> the request module was loaded successfully.
> 
> Log:
> 
> [   54.915713] nf_defrag_ipv4 has bad registration
> [   54.915779] WARNING: CPU: 3 PID: 6323 at net/netfilter/nf_bpf_link.c:62 get_proto_defrag_hook+0x137/0x160
> [   54.915835] CPU: 3 PID: 6323 Comm: fentry Kdump: loaded Tainted: G            E      6.7.0-rc2+ #35
> [   54.915839] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [   54.915841] RIP: 0010:get_proto_defrag_hook+0x137/0x160
> [   54.915844] Code: 4f 8c e8 2c cf 68 ff 80 3d db 83 9a 01 00 0f 85 74 ff ff ff 48 89 ee 48 c7 c7 8f 12 4f 8c c6 05 c4 83 9a 01 01 e8 09 ee 5f ff <0f> 0b e9 57 ff ff ff 49 8b 3c 24 4c 63 e5 e8 36 28 6c ff 4c 89 e0
> [   54.915849] RSP: 0018:ffffb676003fbdb0 EFLAGS: 00010286
> [   54.915852] RAX: 0000000000000023 RBX: ffff9596503d5600 RCX: ffff95996fce08c8
> [   54.915854] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff95996fce08c0
> [   54.915855] RBP: ffffffff8c4f12de R08: 0000000000000000 R09: 00000000fffeffff
> [   54.915859] R10: ffffb676003fbc70 R11: ffffffff8d363ae8 R12: 0000000000000000
> [   54.915861] R13: ffffffff8e1f75c0 R14: ffffb676003c9000 R15: 00007ffd15e78ef0
> [   54.915864] FS:  00007fb6e9cab740(0000) GS:ffff95996fcc0000(0000) knlGS:0000000000000000
> [   54.915867] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.915868] CR2: 00007ffd15e75c40 CR3: 0000000101e62006 CR4: 0000000000360ef0
> [   54.915870] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   54.915871] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   54.915873] Call Trace:
> [   54.915891]  <TASK>
> [   54.915894]  ? __warn+0x84/0x140
> [   54.915905]  ? get_proto_defrag_hook+0x137/0x160
> [   54.915908]  ? __report_bug+0xea/0x100
> [   54.915925]  ? report_bug+0x2b/0x80
> [   54.915928]  ? handle_bug+0x3c/0x70
> [   54.915939]  ? exc_invalid_op+0x18/0x70
> [   54.915942]  ? asm_exc_invalid_op+0x1a/0x20
> [   54.915948]  ? get_proto_defrag_hook+0x137/0x160
> [   54.915950]  bpf_nf_link_attach+0x1eb/0x240
> [   54.915953]  link_create+0x173/0x290
> [   54.915969]  __sys_bpf+0x588/0x8f0
> [   54.915974]  __x64_sys_bpf+0x20/0x30
> [   54.915977]  do_syscall_64+0x45/0xf0
> [   54.915989]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   54.915998] RIP: 0033:0x7fb6e9daa51d
> [   54.916001] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 89 0c 00 f7 d8 64 89 01 48
> [   54.916003] RSP: 002b:00007ffd15e78ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> [   54.916006] RAX: ffffffffffffffda RBX: 00007ffd15e78fc0 RCX: 00007fb6e9daa51d
> [   54.916007] RDX: 0000000000000040 RSI: 00007ffd15e78ef0 RDI: 000000000000001c
> [   54.916009] RBP: 000000000000002d R08: 00007fb6e9e73a60 R09: 0000000000000001
> [   54.916010] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> [   54.916012] R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
> [   54.916014]  </TASK>
> [   54.916015] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>

