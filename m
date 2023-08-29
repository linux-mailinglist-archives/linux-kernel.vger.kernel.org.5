Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ABA78CD95
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbjH2Uh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjH2UhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:37:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F7F1BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:37:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4013454fa93so42682355e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693341436; x=1693946236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b9S6gsTe8EE/vB/KQ1UXEcpZWjCRPVhy5v1HBZYSJ3k=;
        b=KsarDJKco2sL8dsCPQM7JILqkYAaIdBB15GBnZScNdaNZN5g8TxmO7v/hKBDy8JFAC
         GE9m73ts0QPMYL2w7nEm4vpXHKL5kxrML6H7XHyO4BexshPWkCwDgIEMQQpdi2GtRKlP
         fWJ9TcjCryQak/8xrq10xV9OvvuVjdRH9jcFOGAoyoZOqqp/FUx6nqQUxzCvvzTwwKDk
         w3is2462dnCm82HkYkl5fVz+bxKlnegxbzZ+khEJG69LnnrrKnIhUm6AcwFnLY1Gilas
         ffzJuJDuWqGAUKNEwiK5AAxKDwNpSEa6GfTLky/SgGIiq8QQjECaMdYpB2dsY1YV31Pe
         ILhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341436; x=1693946236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9S6gsTe8EE/vB/KQ1UXEcpZWjCRPVhy5v1HBZYSJ3k=;
        b=lSwCvODprLysdhdkiS7ipu7FsMAd8sXwKB8tIxJPU2coM/6oWctLUCUoFpJo9ttZWs
         P4Fh4B6A/ZPs66oW8tBgXAy4CvTKKmTZtP3+F84j6Koorp+dGoecsRHLbrwj7eYtT+Wa
         74OXXMzqq+aS5VImE8yVeiVQ2JPG3S6Cu7B6jMgln/r6NTN7Gl9+bwqg01y6RnTq82a+
         gA2bjXEjhMwV02H4DfJDHxYrxOVsiGWMfrV/c5Ky2mR5/Ca9Lg4s61kShgay4KcI2p9Q
         lLFvpdtpcXd4C/WASEGatcPEkGtoczo6UZJiMOBLKHonK9jVYjDHazrwhALXXizEfHAX
         558A==
X-Gm-Message-State: AOJu0Yw+ecMsTD4eN2UOsYssLCINSOwkpcEFq5rskDyO8hTONHy2LLzP
        2IDa2v3WDd/wzNJQ8uEatljHOiDGS+DAcFtJLOtmew==
X-Google-Smtp-Source: AGHT+IGjSCEG9tjNO8+PfpKB89mTn01sGYwsK8E2fhpWaKbGveLM04NNNt+vyVN9QcwARa5GJSvMOTPl2XQLvZkWi+k=
X-Received: by 2002:a05:600c:2256:b0:400:6bee:f4fe with SMTP id
 a22-20020a05600c225600b004006beef4femr292329wmm.21.1693341435698; Tue, 29 Aug
 2023 13:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d87a7f06040c970c@google.com> <2e260b7c-2a89-2d0c-afb5-708c34230db2@linux.dev>
 <CANpmjNOG4f-NnGX6rpA-X8JtRtTkUH8PiLvMj_WJsp+sbq6PNg@mail.gmail.com> <f09d1d92-3e32-46a6-d20d-41bf74268d0c@iogearbox.net>
In-Reply-To: <f09d1d92-3e32-46a6-d20d-41bf74268d0c@iogearbox.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 29 Aug 2023 22:36:38 +0200
Message-ID: <CANpmjNMiNw8Cwe0Rk2jWD7Ju-e-jAXgdnuwvvsPR1QYq=4HcwQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in bpf_percpu_array_update /
 bpf_percpu_array_update (2)
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     yonghong.song@linux.dev,
        syzbot <syzbot+97522333291430dd277f@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 22:04, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/29/23 8:53 PM, Marco Elver wrote:
> > On Tue, 29 Aug 2023 at 20:30, Yonghong Song <yonghong.song@linux.dev> wrote:
> >> On 8/29/23 5:39 AM, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    727dbda16b83 Merge tag 'hardening-v6.6-rc1' of git://git.k..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=136f39dfa80000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=dea9c2ce3f646a25
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=97522333291430dd277f
> >>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >>>
> >>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>
> >>> Downloadable assets:
> >>> disk image: https://storage.googleapis.com/syzbot-assets/9923a023ab11/disk-727dbda1.raw.xz
> >>> vmlinux: https://storage.googleapis.com/syzbot-assets/650dbc695d77/vmlinux-727dbda1.xz
> >>> kernel image: https://storage.googleapis.com/syzbot-assets/361da71276bf/bzImage-727dbda1.xz
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>> Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com
> >>>
> >>> ==================================================================
> >>> BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update
> >>>
> >>> write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
> >>>    bpf_long_memcpy include/linux/bpf.h:428 [inline]
> >>>    bpf_obj_memcpy include/linux/bpf.h:441 [inline]
> >>>    copy_map_value_long include/linux/bpf.h:464 [inline]
> >>>    bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
> >>>    bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
> >>>    generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
> >>>    bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
> >>>    __sys_bpf+0x28a/0x780
> >>>    __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
> >>>    __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
> >>>    __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
> >>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >>>
> >>> write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
> >>>    bpf_long_memcpy include/linux/bpf.h:428 [inline]
> >>>    bpf_obj_memcpy include/linux/bpf.h:441 [inline]
> >>>    copy_map_value_long include/linux/bpf.h:464 [inline]
> >>>    bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
> >>>    bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
> >>>    generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
> >>>    bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
> >>>    __sys_bpf+0x28a/0x780
> >>>    __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
> >>>    __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
> >>>    __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
> >>>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >>>    do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >>>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >>>
> >>> value changed: 0x0000000000000000 -> 0xfffffff000002788
> >>>
> >>> Reported by Kernel Concurrency Sanitizer on:
> >>> CPU: 0 PID: 8268 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-00453-g727dbda16b83 #0
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> >>> ==================================================================
> >>
> >> This case is with two tasks doing bpf_map batch update together for the
> >> same map and key.
> >>     > write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
> >>     > write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
> >>
> >> So concurrency is introduced by user applications.
> >> In my opinion, this probably not an issue from kernel perspective.
> >
> > Perhaps not, but I recall there being a discussion about making KCSAN
> > aware of memory accesses done by BPF programs (memcpy being a tiny
> > subset of those). Not sure if the above data race qualifies as
> > something we might want to still detect, i.e. a kernel dev testing
> > their kernel might be interested in such a report.
> >
> > Regardless, in this case we should teach syzkaller to ignore KCSAN
> > data races that originate from bpf user operations whatever the
> > origin.
>
> I presume KCSAN could be silenced here via READ_ONCE/WRITE_ONCE conversion?
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f58895830ada..32c4a37045f2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -424,8 +424,11 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
>         long *ldst = dst;
>
>         size /= sizeof(long);
> -       while (size--)
> -               *ldst++ = *lsrc++;
> +       while (size--) {
> +               WRITE_ONCE(*ldst, READ_ONCE(*lsrc));
> +               ldst++;
> +               lsrc++;
> +       }

In this case, maybe data_race(*ldst++ = *lsrc++) would be more
appropriate and efficient. Unlikely that READ_ONCE()/WRITE_ONCE() here
helps make this any safer, i.e. the memcpy is still not atomic and if
it's a bug on the user's side, it'll corrupt data either way.
