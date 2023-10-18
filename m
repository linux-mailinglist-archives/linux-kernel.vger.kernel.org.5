Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CD47CEB92
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjJRXHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRXHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:07:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EF4116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:07:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5079fa1bbf8so7287056e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697670420; x=1698275220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LvRlSdXve8vHq+1t3BIUEFBdp86rzaUM1bfVMcoReYE=;
        b=a5dyPq1s7GNxdiNmv/46Cix5pr+qzZtX20NhNq/xMNHgSYMLl3w+Eb9o9BCKRpe92/
         cJApv7O15B4Dl2NT7HxYTrYdAs5Sqx5DZBrDFoSOQrbvaQJS2SxVHpfRjKnq0LtYBBlX
         +mpTI+otJaKYrIoi+tWL2ydsyCZ8UfvuYN7hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670420; x=1698275220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvRlSdXve8vHq+1t3BIUEFBdp86rzaUM1bfVMcoReYE=;
        b=CtbAQsLRaCgNYuB4dTGr7yiHKiTPvY+8bqG2Yykcy+pj773XufFAZveX/pAAE0hg4t
         LNIYfdk+GtJAtbvH/2AZJgfEblI+ksmCDw1gkL6aqPrGCR2wVleDOyhR501sjxivxNPE
         kuFypOaZV9ztQVSWehc2J743mRuxRRQ1whvaZuwFcwx3SHtWU1v8JLSi2ReZVVulmbNc
         qLPYQuPbShPLXEysxODFj7DWKzlhzt1ULrN4JBCcajP/aPcpx9TILh+nhh87CjVvAPOD
         NW53xjr8untCCUIFaz8kILKsc16KQM74FnHm42Rx+PHNwgpE36927gCO8fCsPdDRBdv0
         mi9A==
X-Gm-Message-State: AOJu0YzHpFMpXUgAtTXan4immxR3eAnMxPC2omZhUJDMrO5qFDYOTEbA
        0Lhi/gQLsDTIAoMK3AhZAjNYMBELKp9p0OIozHB3e/Yq
X-Google-Smtp-Source: AGHT+IHcGNTmIoX/ZSMZhHi1xRNu7ZmhQBao06q6/7hyREPCEgeW2Pecok1aTb8VXcVJCOsPcmOi+Q==
X-Received: by 2002:ac2:5472:0:b0:503:264b:efc9 with SMTP id e18-20020ac25472000000b00503264befc9mr269931lfn.18.1697670420009;
        Wed, 18 Oct 2023 16:07:00 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id b42-20020a509f2d000000b0053e43492ef1sm3543495edf.65.2023.10.18.16.06.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 16:06:59 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so12446234a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:06:59 -0700 (PDT)
X-Received: by 2002:a17:907:3f04:b0:9be:77cd:4c2c with SMTP id
 hq4-20020a1709073f0400b009be77cd4c2cmr451577ejc.28.1697670418807; Wed, 18 Oct
 2023 16:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com> <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
In-Reply-To: <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 16:06:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whA4+rg5D548K0fpJ+XpgDug2TvVBfsGpKJUid53FZgEg@mail.gmail.com>
Message-ID: <CAHk-=whA4+rg5D548K0fpJ+XpgDug2TvVBfsGpKJUid53FZgEg@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>, peterz@infradead.org
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 at 15:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> See for example __count_vm_event() vs count_vm_event().
>
> In fact, that particular use isn't even in an interrupt-safe context,
> that's an example of literally "I'd rather be fast that correct for
> certain statistics that aren't all that important".

.. just to clarify - I don't think the VM statistics code isn't even
updated from interrupts, but it is still incorrect to do
"raw_cpu_add()" even in just process context, because on architectures
where it results in separate load-op-store  instructions, you can get
preempted in the middle, and now your loaded value is some old stale
one. So when you get back, somebody else might have updated the count,
but you'll still end up doing the store using the stale value.

For VM statistics like the BALLOON_MIGRATE, nobody cares. The stats
may be incorrect, but they aren't a correctness issue, and they'll be
in the right ballpark because the race is not generally hit.

So "interrupt safe" here is not necessarily about actual interrupts
themselves directly. You *can* have that too, but it can also be about
just an interrupt causing preemption.

Anyway, again, none of this is relevant on x86, since the
single-instruction rmw percpu sequence is obviously non-interruptible,

The one oddity on x86 is that because 'xchg' always has an implied
lock, so there we *do* have a multi-instruction sequence.

And then - and *ONLY* then - the raw-vs-this matters even on x86:
"raw" just does a "load-store" pair, while "this" does a cmpxchg loop
(the latter of which is safe for both irq use and preemption because
the cmpxchg obviously re-checks the original value).

But even in that xchg case, the "volatile" part of the asm is a
complete red herring and shouldn't exist.

                Linus
