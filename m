Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8A9808924
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379555AbjLGN1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLGN1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:27:51 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4ECD5E;
        Thu,  7 Dec 2023 05:27:58 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1d1e1edb10bso7683565ad.1;
        Thu, 07 Dec 2023 05:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701955678; x=1702560478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qy8bCqLkc/ug6mEJ+c+F03iEuHRroYlHNOEVG+qZwYo=;
        b=RiJb+HL5+viDEhmHm9O3FUeHqM/qPXpEZra2WZGCZoQBcKogQTDPdLLT8d7MfrmgLo
         FZtBVVEEPDGp8XGnRrkkW2LrTM4AeoKewUPnGNKWxsio2I/+Z2zrNwfhAAaouf5DKvFy
         th+qIB0fLfSznYqv1se3caQcIhL0LaAIuy5HCIbTCCn6yS2ILOEz6ulurAE9gli89TEP
         vczBVbmXIVDgVzwoZbJhU4m15b7auJUgCfvKSLmQ7Xt+DfNS2PaXsNpeN1ru/qv1FNcF
         Db5K4DBhvkZmFId3SBj4+/KsWR60QblA4uJ0t1VOlIX60LOD6RlGXFMIfTEhplR1kgIa
         LVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955678; x=1702560478;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qy8bCqLkc/ug6mEJ+c+F03iEuHRroYlHNOEVG+qZwYo=;
        b=d7TQFF4eCpCzJH4XAUuKop47qkVv1nMPAp3fuHVhxjGnAdf/Fzco+pOGdIv/8D96Bv
         2tJBvWDUABRKvx2IN/75Jezub1cL6g0L0zx/lKN4vrVpUS+7DlN0oocU2jVdWdlO0f7W
         KwDef0Z0hVXxkYaKzouhaaJb8JZwjTye0FZmCQsEY4bsW9yARqZcsUQIV3nTu6EMUuBy
         hPOn/qQqxIMvXobEbWgodnPkCWny13YpxYAIWzdSBBQfwQ2phwWgw4Bhwv16OTsE7vUn
         zLCGAy+akaDKtMV78iHvqhxsudcRAIR1OtP453/wZwACwpgfvI3tMs22Am1dBHGtAl0r
         bJ2g==
X-Gm-Message-State: AOJu0YybVIIpaOjeWuqIi44tMwtP4JJ3i2lhV7vYU8N/tkBzUb5Idtfu
        7R2qqk4/L6PFSpXi6v30aZlZWwdU0vQwkt9OvHo=
X-Google-Smtp-Source: AGHT+IGfa/eq5WVyw2kvM/MNxsedwjFAeSez7k2ZHxr2vnCrTUNYeb6zx7OQHUPai83QwolE7eWhPDPODQO3E4b3Lzo=
X-Received: by 2002:a17:903:32d0:b0:1d0:9c03:a7c9 with SMTP id
 i16-20020a17090332d000b001d09c03a7c9mr2471428plr.97.1701955677729; Thu, 07
 Dec 2023 05:27:57 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Thu, 7 Dec 2023 21:27:46 +0800
Message-ID: <CABOYnLyH=PmSoP8=PdkyK5VG1vhiG8fHKg2Xie4oBrVeYbdhHw@mail.gmail.com>
Subject: KMSAN: uninit-value in ip_tunnel_xmit
To:     davem@davemloft.net
Cc:     dsahern@kernel.org, Eric Dumazet <edumazet@google.com>,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        syzbot+4a2c52677a8a1aa283cb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When fuzzing the latest upstream linux 6.7-rc4,  the following crash
was triggered.
HEAD commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei Lee <xrivendell7@gmail.com>

console_log: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b6583#file-console_log
report: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b6583#file-report
kernel commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=ce27066613dacbb6
repro.c: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b6583#file-repro-c
repro.txt: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b6583#file-repro-txt

In the lasted kernel: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8 the
[  199.471467][ T8590] =====================================================
[  199.475015][ T8590] BUG: KMSAN: uninit-value in ip_tunnel_xmit+0x857/0x3e80
[  199.478180][ T8590]  ip_tunnel_xmit+0x857/0x3e80
[  199.480541][ T8590]  ipgre_xmit+0xd1c/0xe20
[  199.482393][ T8590]  dev_hard_start_xmit+0x247/0xa10
[  199.484530][ T8590]  __dev_queue_xmit+0x33b8/0x5130
[  199.486433][ T8590]  __bpf_redirect+0xdd7/0x1600
[  199.488258][ T8590]  bpf_clone_redirect+0x328/0x470
[  199.490250][ T8590]  ___bpf_prog_run+0x2180/0xdb80
[  199.491997][ T8590]  __bpf_prog_run512+0xb5/0xe0
[  199.493691][ T8590]  bpf_test_run+0x482/0xb00
[  199.495215][ T8590]  bpf_prog_test_run_skb+0x14e5/0x1f20
[  199.497026][ T8590]  bpf_prog_test_run+0x6af/0xac0
[  199.498701][ T8590]  __sys_bpf+0x649/0xd60
[  199.500029][ T8590]  __x64_sys_bpf+0xa0/0xe0
[  199.501411][ T8590]  do_syscall_64+0x44/0x110
[  199.502757][ T8590]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  199.504463][ T8590]
[  199.505159][ T8590] Uninit was created at:
[  199.506344][ T8590]  slab_post_alloc_hook+0x129/0xa70
[  199.507690][ T8590]  kmem_cache_alloc_node+0x5e9/0xb10
[  199.509191][ T8590]  kmalloc_reserve+0x13d/0x4a0
[  199.510411][ T8590]  pskb_expand_head+0x226/0x1a00
[  199.511657][ T8590]  skb_ensure_writable+0x3d3/0x460
[  199.512905][ T8590]  bpf_clone_redirect+0x17f/0x470
[  199.514135][ T8590]  ___bpf_prog_run+0x2180/0xdb80
[  199.515325][ T8590]  __bpf_prog_run512+0xb5/0xe0
[  199.516479][ T8590]  bpf_test_run+0x482/0xb00
[  199.517580][ T8590]  bpf_prog_test_run_skb+0x14e5/0x1f20
[  199.518901][ T8590]  bpf_prog_test_run+0x6af/0xac0
[  199.520015][ T8590]  __sys_bpf+0x649/0xd60
[  199.520996][ T8590]  __x64_sys_bpf+0xa0/0xe0
[  199.521949][ T8590]  do_syscall_64+0x44/0x110
[  199.522926][ T8590]  entry_SYSCALL_64_after_hwframe+0x63/0x6b

and I notice the problem is reported at 2018/2020 and seems fixed twice.

https://syzkaller.appspot.com/bug?id=f62d236e2fceaeb104f4e8f77d2324ef9da4b41b
https://syzkaller.appspot.com/bug?extid=4a2c52677a8a1aa283cb



If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
