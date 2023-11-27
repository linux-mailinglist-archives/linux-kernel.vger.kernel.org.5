Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F67FA29D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjK0O2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjK0O2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:28:09 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B46E3268;
        Mon, 27 Nov 2023 06:07:19 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db40898721fso3933932276.3;
        Mon, 27 Nov 2023 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701094038; x=1701698838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z8oeFhCs7kIEK8abIOdKBsPggO+UU8nmR04lsK3QyLs=;
        b=BFJifH+M3YypRNQI2tSO/osf5/IfaELJVE7grWsnctEzXOZhGSzZrhGa198EXbpZy7
         D4zCD0SV9aIcIx85qQ8mcVl6jxpVvHF8DuxwAQphZ3Buk+e3tohlJ5lohDn9+uSL+YxG
         VNkzqYjxsA3UtiyoVvxQsE0doho4M6wQQIWkp7TCUZKvcuzsj4P0YK7WTgExf5TuVCh4
         NDjbExRvogiElsmQTwdRkc40od1ZYLrzwySVtr9DgdCPsk95EOaJUIw6CGDie7RzZFcW
         QwXnXgbk0gGPiyc1ceuw/3nwoP1MwASz81NEb35ceHWcL/mbq0uveQ31GQKIbKOj8P+V
         tvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094038; x=1701698838;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8oeFhCs7kIEK8abIOdKBsPggO+UU8nmR04lsK3QyLs=;
        b=NWz0CYeGjgrlV2bh2765gp+b2saRb+Tx55hYltiadtxW7oSlLf6HyOKPhIONzSI/BB
         u6k+lB4wVJPpgqIz7PMG6RZU8/akUe87eh6eh5WshtRQ9lCeHz1KKWQ2dfvNasoqJSiZ
         MSxYTN4EDRpRZVMyyAhk1wvXsgJFoe81h8fsOJf6ssMfKBVi2+hGI0RAGkO3+O6pfnGr
         cN48yHkvAMvE98EsFOoyYhnkAiEX4xjcqJfT3BBZuTK1GyxrQAj/PrlEnvyJzEPQMDcE
         vYcKX/3dLz81oVe/77Ldw2o7CbzeaxFtTedsiEze4Qu+23/M4HsyntHjmj0fEMrFybkE
         T2mg==
X-Gm-Message-State: AOJu0Yyj7bHwlelO936DKlXEQkdgqkve3SiR+DFxcnZzMGGiaCGXBlOI
        zUPiTtsWYMU5ZUDJTgslybb7NR85/DLm00BQe9ypZ9GjBw==
X-Google-Smtp-Source: AGHT+IGVZIL/uQ8SCfn15D9a6GMSq6qYaiV2lp0Yk6fvYWVJCeiSK9GCYfnkwschuaDxOJ5Nn/nPv/bRHk7RpB8Es5U=
X-Received: by 2002:a25:25cd:0:b0:da3:b87b:5b75 with SMTP id
 l196-20020a2525cd000000b00da3b87b5b75mr11682722ybl.64.1701094038084; Mon, 27
 Nov 2023 06:07:18 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 27 Nov 2023 15:07:07 +0100
Message-ID: <CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com>
Subject: [Bug Report] bpf: zero access_size of stack causes array indix oob in check_stack_range_initialized()
To:     Andrei Matei <andreimatei1@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following program (reduced) can cause array OOB during verifying time.

What happening is that we pass a stack pointer
fp(smin=smin32=-7,smax=smax32=248), and a size reg whose min value
could be zero, to a helper. In check_mem_size_reg(), we have:

     if (reg->umin_value == 0) {
         err = check_helper_mem_access(env, regno - 1, 0,
                           zero_size_allowed,
                           meta);
         if (err)
             return err;
     }

The stack pointer with smax=248 should be rejected, but it's not
because in check_stack_access_within_bound():

         if (access_size > 0)
             max_off = reg->smax_value + off + access_size - 1;
         else
             max_off = min_off;

The max_off is set to min_off because access_size is zero. In
check_stack_range_initialized(), the slot could be -1 when `i` is 0:
     for (i = min_off; i < max_off + access_size; i++) {
         u8 *stype;

         slot = -i - 1;
         spi = slot / BPF_REG_SIZE;

Andrei, sorry to email you again, but this is introduced in
`01f810ace9ed3`. Should we handle zero access_size correctly in
check_stack_access_within_bound()?

Here are the reduced program, the verifier log after removing the
guilty instruction, and the kernel config I used:

C repro: https://pastebin.com/raw/Dx653LrQ
Verifier log: https://pastebin.com/raw/q19gaMdr
Build config: https://pastebin.com/raw/41uDYmYr

================================================================================
UBSAN: array-index-out-of-bounds in kernel/bpf/verifier.c:7051:39
index -1 is out of range for type 'u8 [8]'
CPU: 0 PID: 8339 Comm: poc Not tainted 6.7.0-rc2-g727d3a2bd1b6 #34
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0xa0/0xe0 lib/ubsan.c:348
 check_stack_range_initialized+0xb06/0x1080 kernel/bpf/verifier.c:7051
 check_helper_mem_access+0x139/0x960 kernel/bpf/verifier.c:7156
 check_mem_size_reg+0x11d/0x1e0 kernel/bpf/verifier.c:7230
 check_func_arg kernel/bpf/verifier.c:8633 [inline]
 check_helper_call.isra.0+0xfc9/0x8530 kernel/bpf/verifier.c:9972
 do_check kernel/bpf/verifier.c:17356 [inline]
 do_check_common+0x4991/0xddb0 kernel/bpf/verifier.c:19899
 do_check_main kernel/bpf/verifier.c:19990 [inline]
 bpf_check+0x3f02/0xa6a0 kernel/bpf/verifier.c:20627
 bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
 __sys_bpf+0xfc8/0x4400 kernel/bpf/syscall.c:5384
 __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
 __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5486
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
