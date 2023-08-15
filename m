Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A66B77D3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjHOUQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjHOUP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:15:57 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDDCC7;
        Tue, 15 Aug 2023 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692130556; x=1723666556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Ij07SyVS74pwvfzrHiuSb1DxM5+2AJnxh6YxneYOs0=;
  b=NXt1FGbzEBNpQe0iZG9sbFZBBirYvR+Yr3x5yfp1shgr22ZWcc9WXTyk
   HE3Xh8AuDFc/Xh2RBwIgYAsMWOGWDY5ISZysygfRXnh+oS3cppZ78n094
   VSZBWXFAowMXas0u1voXREbI7LC4Bv9utBJUuzpcjSp+jM2ooC/TMkU23
   A=;
X-IronPort-AV: E=Sophos;i="6.01,175,1684800000"; 
   d="scan'208";a="22699422"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 20:15:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-189d700f.us-west-2.amazon.com (Postfix) with ESMTPS id 0ED1040D6E;
        Tue, 15 Aug 2023 20:15:56 +0000 (UTC)
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 15 Aug 2023 20:15:55 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 15 Aug 2023 20:15:55 +0000
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <gregkh@linuxfoundation.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <jgross@suse.com>, <sjpark@amazon.com>, <hailmo@amazon.com>,
        <kuniyu@amazon.com>, <shaoyi@amazon.com>
Subject: Re: Linux 5.4.252 FPU initialization warnings in stable kernels 5.4/5.10
Date:   Tue, 15 Aug 2023 20:15:39 +0000
Message-ID: <20230815201539.19015-1-shaoyi@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023080814-relax-divisible-dea4@gregkh>
References: <2023080814-relax-divisible-dea4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.189.91.91]
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas/Greg

We are seeing “get of unsupported state” warnings during FPU initialization in the v5.4.252 and v5.10.189
kernel booted on AWS EC2 instances with Intel processors based on Nitro system. These warnings are observed 
in EC2 c5.18xlarge instance: 

[    1.204495] ------------[ cut here ]------------
[    1.204495] get of unsupported state
[    1.204495] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:879 get_xsave_addr+0x81/0x90
[    1.204495] Modules linked in:
[    1.204495] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.252 #10
[    1.204495] Hardware name: Amazon EC2 c5.18xlarge/, BIOS 1.0 10/16/2017
[    1.204495] RIP: 0010:get_xsave_addr+0x81/0x90
[    1.204495] Code: 5b c3 48 83 c4 08 31 c0 5b c3 80 3d 7c f0 78 01 00 75 c1 48 c7 c7 34 be 03 b2 89 4c 24 04 c6 05 68 f0 78 01 01 e8 ef 41 05 00 <0f> 0b 48 63 4c 24 04 eb a1 31 c0 c3 0f 1f 00 0f 1f 44 00 00 41 54
[    1.204495] RSP: 0000:ffffffffb2603ed0 EFLAGS: 00010282
[    1.204495] RAX: 0000000000000000 RBX: ffffffffb27ebe80 RCX: 0000000047cb2486
[    1.204495] RDX: 0000000000000018 RSI: ffffffffb39e99a0 RDI: ffffffffb39e756c
[    1.204495] RBP: ffffffffb27ebd40 R08: 7520666f20746567 R09: 74726f707075736e
[    1.204495] R10: 00000000000962fc R11: 6574617473206465 R12: ffffffffb2d89b60
[    1.204495] R13: 0000000000000246 R14: 0000000000000000 R15: 0000000000000000
[    1.204495] FS:  0000000000000000(0000) GS:ffff96d031400000(0000) knlGS:0000000000000000
[    1.204495] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.204495] CR2: ffff96e277fff000 CR3: 000000103060a001 CR4: 00000000007200b0
[    1.204495] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.204495] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.204495] Call Trace:
[    1.204495]  ? __warn+0x85/0xd0
[    1.204495]  ? get_xsave_addr+0x81/0x90
[    1.204495]  ? report_bug+0xb6/0x130
[    1.204495]  ? get_xsave_addr+0x81/0x90
[    1.204495]  ? fixup_bug.part.12+0x18/0x30
[    1.204495]  ? do_error_trap+0x95/0xb0
[    1.204495]  ? do_invalid_op+0x36/0x40
[    1.204495]  ? get_xsave_addr+0x81/0x90
[    1.204495]  ? invalid_op+0x1e/0x30
[    1.204495]  ? get_xsave_addr+0x81/0x90
[    1.204495]  identify_cpu+0x422/0x510
[    1.204495]  identify_boot_cpu+0xc/0x94
[    1.204495]  arch_cpu_finalize_init+0x5/0x47
[    1.204495]  start_kernel+0x468/0x511
[    1.204495]  secondary_startup_64+0xa4/0xb0
[    1.204495] ---[ end trace dffac81ff531fcf2 ]---

The issue can be easily reproduced on both virtualized and bare metal instances but interesting thing is 
it can’t be found in other latest stable kernels v4.14, v4.19, v5.15 and newer. We tried to bisect between v5.4.251 and v5.4.252 and 
were able to find below commit to be the culprit. Also, reverting it in v5.4.252 and v5.10.189 resolved above warnings completely. 

    x86/fpu: Move FPU initialization into arch_cpu_finalize_init() 
    commit b81fac906a8f9e682e513ddd95697ec7a20878d4 upstream

We used to speculate the fix might be similar to commit 3f8968f1f0ad (“x86/xen: Fix secondary processors' FPU initialization”) but 
since only kernel 5.4/5.10  are impacted, we’re not quite sure how this commit affects them in practice. Could you please take a look and share your insights?

Also put stack traces from v5.10.189: 

[    1.210910] ------------[ cut here ]------------
[    1.210910] get of unsupported state
[    1.210910] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:974 get_xsave_addr+0x89/0xa0
[    1.210910] Modules linked in:
[    1.210910] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.189 #4
[    1.210910] Hardware name: Amazon EC2 c5.18xlarge/, BIOS 1.0 10/16/2017
[    1.210910] RIP: 0010:get_xsave_addr+0x89/0xa0
[    1.210910] Code: c4 08 31 c0 5b e9 17 a4 bc 00 80 3d e7 75 eb 01 00 75 b9 48 c7 c7 b7 f4 09 ab 89 4c 24 04 c6 05 d3 75 eb 01 01 e8 17 98 05 00 <0f> 0b 48 63 4c 24 04 eb 99 31 c0 e9 e7 a3 bc 00 0f 1f 80 00 00 00
[    1.210910] RSP: 0000:ffffffffab603ec8 EFLAGS: 00010286
[    1.210910] RAX: 0000000000000000 RBX: ffffffffabf25bc0 RCX: 00000000fffeffff
[    1.210910] RDX: ffffffffab603cd0 RSI: 00000000fffeffff RDI: ffffffffad1a3dec
[    1.210910] RBP: ffffffffabf25a60 R08: 0000000000000000 R09: 0000000000000001
[    1.210910] R10: 0000000000000000 R11: ffffffffab603cc8 R12: ffffffffac539b40
[    1.210910] R13: 0000000000000246 R14: 0000000000000000 R15: 0000000000000000
[    1.210910] FS:  0000000000000000(0000) GS:ffff9150f1600000(0000) knlGS:0000000000000000
[    1.210910] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.210910] CR2: ffff915702801000 CR3: 0000001780610001 CR4: 00000000007300b0
[    1.210910] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.210910] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    1.210910] Call Trace:
[    1.210910]  ? __warn+0x7d/0xe0
[    1.210910]  ? get_xsave_addr+0x89/0xa0
[    1.210910]  ? report_bug+0xbb/0x140
[    1.210910]  ? handle_bug+0x3f/0x70
[    1.210910]  ? exc_invalid_op+0x13/0x60
[    1.210910]  ? asm_exc_invalid_op+0x12/0x20
[    1.210910]  ? get_xsave_addr+0x89/0xa0
[    1.210910]  ? get_xsave_addr+0x89/0xa0
[    1.210910]  identify_cpu+0x42a/0x550
[    1.210910]  identify_boot_cpu+0xc/0x94
[    1.210910]  arch_cpu_finalize_init+0x5/0x47
[    1.210910]  start_kernel+0x4bc/0x56b
[    1.210910]  secondary_startup_64_no_verify+0xb0/0xbb
[    1.210910] ---[ end trace 14850c6f8ee0875d ]---


Thanks,
Shaoying
