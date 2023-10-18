Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA697CEB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjJRWka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRWk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:40:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEAA119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:40:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so12186575a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697668825; x=1698273625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQSN/8AyNe3sAydXX0IQmaasInOgjPE21LKV/uZBmFs=;
        b=fjReqgnIB3MnFYnlXAfnW45VENvYQUpfeIAQUpNYpA6JenM7Vhb7MBHqoID3n+Q/Ev
         mcHPGu5wXc08eFYyG0cow2qGmn0TpEs1CpoCxI9ru6G/qk8XVEAnWx3GSQX1anPiGjfi
         M93eLqvZeFTI/fFiDJxF7o6SgobphCNPRxc8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668825; x=1698273625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQSN/8AyNe3sAydXX0IQmaasInOgjPE21LKV/uZBmFs=;
        b=QRIYPT6a5ClXeicvLoq5u99XUE1thkV+JCgSqyqobTan3NdSH+I0Hhj/QaP8LKZk66
         UbQqTxtJQhrWN9AD/gqlyFLVwuVK48ZY6Hb+l4pOor9mNamxJ8w/VumTLUnj5+b5Fo/7
         Sr/5pNoZGKGDX3gbtc9kEjeeTkQ1yTrHXh84aCqxLD0nemISkvpoX8M4OMvl0etAkqO6
         zjEsC+tkfiNsmSfyvmNHqKd6wxv5SrOkCKBHsiUp3CHPNw1cRh9vAtOtdlmPeXg7r6B9
         VWIB5BAw4Mwbu6rw7kYFQHkC+g1wdqSpksyE3C1g2loDMj5v/82vG2xczc53A2Bo0eey
         308Q==
X-Gm-Message-State: AOJu0YzUUNjX8FJCzQJAGU1ngDRzzTWKfRNjO/aUH8CY6vbdk2CQ61wP
        W1jSY0Uv8yaqnztYFEu7+FjPUuMrCwqOz1n0OVQYBS99
X-Google-Smtp-Source: AGHT+IHnEWjvGCzbvWbO6bhWAEtoM/H1JiYZP9yGZGNf8tgE8v6RlswtL22ej9lS104RI8qc38pEig==
X-Received: by 2002:a17:907:6096:b0:9b2:ccd8:2d2b with SMTP id ht22-20020a170907609600b009b2ccd82d2bmr399718ejc.77.1697668825048;
        Wed, 18 Oct 2023 15:40:25 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id qk17-20020a170906d9d100b009a198078c53sm2421978ejb.214.2023.10.18.15.40.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 15:40:23 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-99c1c66876aso1193285666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:40:23 -0700 (PDT)
X-Received: by 2002:a17:906:dc92:b0:9af:9c4f:b579 with SMTP id
 cs18-20020a170906dc9200b009af9c4fb579mr437316ejc.18.1697668823207; Wed, 18
 Oct 2023 15:40:23 -0700 (PDT)
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
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com> <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
In-Reply-To: <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 15:40:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
Message-ID: <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
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

On Wed, 18 Oct 2023 at 14:40, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> The ones in "raw" form are not IRQ safe and these are implemented
> without volatile qualifier.

You are misreading it.

Both *are* irq safe - on x86.

The difference between "this_cpu_xyz()" and "raw_cpu_xyz()" is that on
*other* architectures, "raw_cpu_xyz():" can be a lot more efficient,
because other architectures may need to do extra work to make the
"this" version be atomic on a particular CPU.

See for example __count_vm_event() vs count_vm_event().

In fact, that particular use isn't even in an interrupt-safe context,
that's an example of literally "I'd rather be fast that correct for
certain statistics that aren't all that important".

They two versions generate the same code on x86, but on other
architectures, __count_vm_event() can *much* simpler and faster
because it doesn't disable interrupts or do other special things.

But on x86, the whole "interrupt safety" is a complete red herring.
Both of them generate the exact same instruction.

On x86, the "volatile" is actually for a completely different reason:
to avoid too much CSE by the compiler.

See  commit b59167ac7baf ("x86/percpu: Fix this_cpu_read()").

In fact, that commit went overboard, and just added "volatile" to
*every* percpu read.

So then people complained about *that*, and PeterZ did commit
0b9ccc0a9b14 ("x86/percpu: Differentiate this_cpu_{}() and
__this_cpu_{}()"), which basically made that "qual or not" be a macro
choice.

And in the process, it now got added to all the RMW ops, that didn't
actually need it or want it in the first place, since they won't be
CSE'd, since they depend on the input.

So that commit basically generalized the whole thing entirely
pointlessly, and caused your current confusion.

End result: we should remove 'volatile' from the RMW ops. It doesn't
do anything on x86. All it does is make us have two subtly different
versions that we don't care about the difference.

End result two: we should make it clear that "this_cpu_read()" vs
"raw_cpu_read()" are *NOT* about interrupts. Even on architectures
where the RMW ops need to have irq protection (so that they are atomic
wrt interrupts also modifying the value), the *READ* operation
obviously has no such issue.

For the raw_cpu_read() vs this_cpu_read() case, the only issue is
whether you can CSE the result.

And in 99% of all cases, you can - and want to - CSE it. But as that
commit b59167ac7baf shows, sometimes you cannot.

Side note: the code that caused that problem is this:

  __always_inline void __cyc2ns_read(struct cyc2ns_data *data)
  {
        int seq, idx;

        do {
                seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
                ...
        } while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
  }

where the issue is that the this_cpu_read() of that sequence number
needs to be ordered.

Honestly, that code is just buggy and bad.  We should never have
"fixed" it by changing the semantics of this_cpu_read() in the first
place.

The problem is that it re-implements its own locking model, and as so
often happens when people do that, they do it completely wrongly.

Look at the *REAL* sequence counter code in <linux/seqlock.h>. Notice
how in raw_read_seqcount_begin() we have

        unsigned _seq = __read_seqcount_begin(s);
        smp_rmb();

because it actually does the proper barriers. Notice how the garbage
code in __cyc2ns_read() doesn't have them - and how it was buggy as a
result.

(Also notice how this all predates our "we should use load_acquire()
instead of smb_rmb()", but whatever).

IOW, all the "volatiles" in the x86 <asm/percpu.h> file are LITERAL
GARBAGE and should not exist, and are due to a historical mistake.

                   Linus
