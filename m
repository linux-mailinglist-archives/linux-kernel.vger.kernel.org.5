Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470E0808950
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442007AbjLGNgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441947AbjLGNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:36:35 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5D10E9;
        Thu,  7 Dec 2023 05:36:41 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so651660a12.0;
        Thu, 07 Dec 2023 05:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701956201; x=1702561001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VjSQyuSgVvJ/v1Bs+z8zb7EPthGUs1fJmqCPvPc17Jc=;
        b=SFmElmRpR0e3Fx4Kyt33ra6gciua88FBgArZWAwAca6o5HRysUcC62nEO+Nu0eKuh6
         N/IedmoDJg2IMBRhNA7DJ98xG77axvve9KMrFGJTZqxWdbrjSHinJeqhpyE0evsXph2b
         NMgKTxZMxdvpwapjz2KYvleQhkvV40sI7uayN8SQqSpzy3Z9hxypVouxleaaox9SKMHn
         8RU5YVeA2mX8ug5agFlta7SQ/RAAKsKnAG2Y76THgbf/0p+C84cfbJkF2/FJ4XVISbmb
         /lFCxyPiDH5Z60qFEP9K0ibmSV2LWsfVXhby+/EEfapvnMNL3pifIPsbw78cxsFtEDyT
         vh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956201; x=1702561001;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjSQyuSgVvJ/v1Bs+z8zb7EPthGUs1fJmqCPvPc17Jc=;
        b=GNE+tOWaIIbMH7hCqO1LoLJ3kbaBlYQmNezSveVWWqoHJ8wcmY1uAWI4aSz9CW2plT
         z/q7+WFojnUjRrw+jZKIqUYGw/q6A2Gw/S4luYx7mOWL4QbbM86jJ2Jnobc2kQAxurd0
         DwRyPWAcESK9adFV+DnUgFx3O+mnovYK4o+XiHLYBDIPiqPHGmCoHYQFVOhCipQO9cXE
         XLCFju38xNQYXWNUKAlnWpnFRWURv4wqFFT593R116MpWWMOrVqOeyvJZshVwCm3TV3a
         zIUDwy8SQmSR6UUxogWEs6yVpr8WD68eKoons+En8ZTkielQ4/HV4EdM+H0dmOSp1qZT
         xh0g==
X-Gm-Message-State: AOJu0YxEJbHdtEl2byz4b8uOId2oWM1ISvANbOiArMnBfFKnI4Nv0GwM
        8Ywe1hade99euNiJ/pDSApENVtEVMR6x+aXKz0gSA89TTt7ZBl5YueE=
X-Google-Smtp-Source: AGHT+IHo/qPLG2H/4BL+OPGDtxBQTSHt9k2BhKOF/IU5s15zvDYUB/DkOWSfgbWcTjkXEKmzl0OkTiGNH6T5dwBCKTY=
X-Received: by 2002:a17:90a:a406:b0:27e:1ea0:c6fc with SMTP id
 y6-20020a17090aa40600b0027e1ea0c6fcmr2218828pjp.6.1701956201090; Thu, 07 Dec
 2023 05:36:41 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Thu, 7 Dec 2023 21:36:29 +0800
Message-ID: <CABOYnLxJzspevWrZLOt+6jkybyUEHfYz8MFZbTuRcyyjnExiKA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ip_route_output_key_hash_rcu (4)
To:     syzbot+549e451574ba8bfd0fd6@syzkaller.appspotmail.com
Cc:     davem@davemloft.net, glider@google.com, kuba@kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org,
        Eric Dumazet <edumazet@google.com>
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

Hello

I reproduced this bug in the latest upstream linux with repro.c and repro.txt

When fuzzing the latest upstream linux 6.7-rc4,  the following crash
was triggered.
HEAD commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei Lee <xrivendell7@gmail.com>

console_log: https://gist.github.com/xrivendell7/195eb3c1946ea466f9d8f5977b90c6ed#file-console_log
report: https://gist.github.com/xrivendell7/195eb3c1946ea466f9d8f5977b90c6ed#file-report
kernel commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=ce27066613dacbb6
repro.c: https://gist.github.com/xrivendell7/195eb3c1946ea466f9d8f5977b90c6ed#file-repro-c
repro.txt: https://gist.github.com/xrivendell7/195eb3c1946ea466f9d8f5977b90c6ed#file-repro-txt

In the lasted kernel: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8 the
crash likes below:
[  209.523497][ T8593] =====================================================
[  209.530316][ T8593] BUG: KMSAN: uninit-value in
ip_route_output_key_hash_rcu+0x1ee8/0x3810
[  209.533357][ T8593]  ip_route_output_key_hash_rcu+0x1ee8/0x3810
[  209.535524][ T8593]  ip_route_output_flow+0x14f/0x320
[  209.537312][ T8593]  ip_tunnel_xmit+0x1450/0x3e80
[  209.538995][ T8593]  ipgre_xmit+0xd1c/0xe20
[  209.540511][ T8593]  dev_hard_start_xmit+0x247/0xa10
[  209.542211][ T8593]  __dev_queue_xmit+0x33b8/0x5130
[  209.543742][ T8593]  __bpf_redirect+0xdd7/0x1600
[  209.545235][ T8593]  bpf_clone_redirect+0x328/0x470
[  209.546807][ T8593]  ___bpf_prog_run+0x2180/0xdb80
[  209.548288][ T8593]  __bpf_prog_run512+0xb5/0xe0
[  209.549864][ T8593]  bpf_test_run+0x482/0xb00
[  209.551178][ T8593]  bpf_prog_test_run_skb+0x14e5/0x1f20
[  209.552612][ T8593]  bpf_prog_test_run+0x6af/0xac0
[  209.553902][ T8593]  __sys_bpf+0x649/0xd60
[  209.555000][ T8593]  __x64_sys_bpf+0xa0/0xe0
[  209.556114][ T8593]  do_syscall_64+0x44/0x110
[  209.557249][ T8593]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  209.558676][ T8593]
[  209.559232][ T8593] Uninit was stored to memory at:
[  209.560528][ T8593]  ip_tunnel_xmit+0x1161/0x3e80
[  209.561676][ T8593]  ipgre_xmit+0xd1c/0xe20
[  209.562711][ T8593]  dev_hard_start_xmit+0x247/0xa10
[  209.563864][ T8593]  __dev_queue_xmit+0x33b8/0x5130
[  209.564963][ T8593]  __bpf_redirect+0xdd7/0x1600
[  209.566044][ T8593]  bpf_clone_redirect+0x328/0x470
[  209.567151][ T8593]  ___bpf_prog_run+0x2180/0xdb80
[  209.568184][ T8593]  __bpf_prog_run512+0xb5/0xe0
[  209.569187][ T8593]  bpf_test_run+0x482/0xb00
[  209.570201][ T8593]  bpf_prog_test_run_skb+0x14e5/0x1f20
[  209.571308][ T8593]  bpf_prog_test_run+0x6af/0xac0
[  209.572284][ T8593]  __sys_bpf+0x649/0xd60
[  209.573131][ T8593]  __x64_sys_bpf+0xa0/0xe0
[  209.574010][ T8593]  do_syscall_64+0x44/0x110
[  209.574902][ T8593]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  209.576008][ T8593]
[  209.576456][ T8593] Uninit was created at:
[  209.577301][ T8593]  slab_post_alloc_hook+0x129/0xa70
[  209.578284][ T8593]  kmem_cache_alloc_node+0x5e9/0xb10
[  209.579233][ T8593]  kmalloc_reserve+0x13d/0x4a0
[  209.580177][ T8593]  pskb_expand_head+0x226/0x1a00
[  209.581096][ T8593]  skb_ensure_writable+0x3d3/0x460
[  209.582015][ T8593]  bpf_clone_redirect+0x17f/0x470
[  209.582963][ T8593]  ___bpf_prog_run+0x2180/0xdb80
[  209.583859][ T8593]  __bpf_prog_run512+0xb5/0xe0
[  209.584725][ T8593]  bpf_test_run+0x482/0xb00
[  209.585556][ T8593]  bpf_prog_test_run_skb+0x14e5/0x1f20
[  209.586527][ T8593]  bpf_prog_test_run+0x6af/0xac0
[  209.587347][ T8593]  __sys_bpf+0x649/0xd60
[  209.588058][ T8593]  __x64_sys_bpf+0xa0/0xe0
[  209.588802][ T8593]  do_syscall_64+0x44/0x110
[  209.589613][ T8593]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
