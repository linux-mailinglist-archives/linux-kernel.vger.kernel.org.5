Return-Path: <linux-kernel+bounces-132225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFA08991A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDB91F294AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC8113BC17;
	Thu,  4 Apr 2024 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CXz4GI4B"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28813119B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271252; cv=none; b=uF/WTL8gEgwIyy8pW4v3zr/dfXXiRPdDJ+8fk2zr0aPLkrKof+byEIBr2lpjbZyUft6lq6Z0aCmdSKSzApGRNmV3Rr9iBKewqPfvQWo66V2idq53faFdufF22bTEOoATKhWVLLSWfwCP9F4539jM4DRss6TOuPkEVQxs26m9XIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271252; c=relaxed/simple;
	bh=CBk1FC94GdXzH1IZDUzAhUZ2sWkEO7wRaPRzjYJybNY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JYkVBdYrsmSb/COwhEVBArwTh9p0f/GoTIEsYi6Ne61d8rdqVQmqBINGJgxueXtbZF+ObNW8mseKNoJj5Cm0GJq2W8zQsXVDdBKiS3E0H2InZNQhZBb/GVrklKGEvaCtNMO5WLo15dgdMx4jWArD0kBoT2oQZ5lQ8YgRaFaDEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CXz4GI4B; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaa6so21190921fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712271248; x=1712876048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mdvSc1zZ0NZb6JrdVcRl9RlAFW0xeLaKiO8AUNqQ0Es=;
        b=CXz4GI4BQ721DZv7JzRU7oNGRmq1GBJzeqyX0YHmQtdoYyT4qZaJu/yjHqjUDMDeul
         qoaayTxBGe/F1QBVUgkVe+vC3OMwwdw/kjD0a1zGqalh2vSuF/qoeuIe50wWg65u6VGr
         V+bPjhd/g9gkZSVd/rgCKnTVAapsT9yTX3obY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712271248; x=1712876048;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdvSc1zZ0NZb6JrdVcRl9RlAFW0xeLaKiO8AUNqQ0Es=;
        b=eKWKXw1bvfW2S+3aURnv5QOXuxADtro7WC+sT289xjfsAYzPOSB6TwhnvWLRVvSVJ3
         krYIgouOx/AHvq6Gg+XEx7JzrNvyRv2aV89T3/fX4dqpzAxZ8anhLWWA33l/IEi+/LFI
         uDRlxRdZ5TNBl7v/xZ+VMb4ULwOGrHQEpu7X+OrKfKiD7vAdesGleTJA4UE3tNmWvWgm
         /mPybMYHZdcyx8q+PmQqvYrZT3xQz4Qxl9KyGDVSos957wHVrnmuUu02y4SijUJPNWrd
         WaJlOh1bmOaB50aWYnp5Go9TA9IWZvs6EO8IyCJkTFz7qFSPUUZT/eh8M0LQSdJsoPfY
         zRPw==
X-Forwarded-Encrypted: i=1; AJvYcCXHy3URBmozpiXmuS3EwByO1MjpxlsvdSZfKxiGinYsfE5YKnpN+xTG/53Z+nG73etN9EStbqQJ/nhZd9TLgwwlBOPi/5JgkI/nzGYT
X-Gm-Message-State: AOJu0YyI2dNtIOuE0fIkAmhigswZCTeqRikuhEZK0/Uyk/Hsbsgtxl0c
	PN+86kJzN4AefOKmMZ/cf6YsUMULzWoGLJBR+970SbcLieJdSgI6OQbP9hBzKO+zywUB+75c5vi
	kJxE=
X-Google-Smtp-Source: AGHT+IFm3oJ97/ntXdNYJ5u6oUCWvKPljQ4wDyoouu//24LdkHAGG1HCEhYqiJjvHLiDajWVjsZ3Zw==
X-Received: by 2002:a2e:95c7:0:b0:2d6:c5d7:8477 with SMTP id y7-20020a2e95c7000000b002d6c5d78477mr2683355ljh.36.1712271248195;
        Thu, 04 Apr 2024 15:54:08 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c509000000b0056bf6287f32sm115839edq.26.2024.04.04.15.54.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 15:54:06 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46a7208eedso219879066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:54:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUjkgV/5/6X+SPNGiYKFksAKKRGpzPdQmyPq0iT1Uet/MVfYyWDbB5O0cMKvGdiHdDpfWZYA8RVg87+yHRRIDHmvvCC0eWLaUsn9ez
X-Received: by 2002:a17:906:4c56:b0:a4e:1b02:81d6 with SMTP id
 d22-20020a1709064c5600b00a4e1b0281d6mr2391731ejw.10.1712271246458; Thu, 04
 Apr 2024 15:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Apr 2024 15:53:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
Message-ID: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
Subject: More annoying code generation by clang
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000067b57c06154d378e"

--00000000000067b57c06154d378e
Content-Type: text/plain; charset="UTF-8"

So this doesn't really matter in any real life situation, but it
really grated on me.

Clang has this nasty habit of taking our nice asm constraints, and
turning them into worst-case garbage. It's been reported a couple of
times where we use "g" to tell the compiler that pretty much any
source to the asm works, and then clang takes that to mean "I will
take that to use 'memory'" even when that makes no sense what-so-ever.

See for example

    https://lore.kernel.org/all/CAHk-=wgobnShg4c2yyMbk2p=U-wmnOmX_0=b3ZY_479Jjey2xw@mail.gmail.com/

where I was ranting about clang just doing pointlessly stupid things.

However, I found a case where yes, clang does pointlessly stupid
things, but it's at least _partly_ our fault, and gcc can't generate
optimal code either.

We have this fairly critical code in __fget_files_rcu() to look up a
'struct file *' from an fd, and it does this:

                /* Mask is a 0 for invalid fd's, ~0 for valid ones */
                nospec_mask = array_index_mask_nospec(fd, fdt->max_fds);

and clang makes a *horrid* mess of it, generating this code:

        movl    %edi, %r14d
        movq    32(%rbx), %rdx
        movl    (%rdx), %eax
        movq    %rax, 8(%rsp)
        cmpq    8(%rsp), %r14
        sbbq    %rcx, %rcx

which is just crazy. Notice how it does that "move rax to stack, then
do the compare against the stack", instead of just using %rax.

In fact, that function shouldn't have a stack frame at all, and the
only reason it is generated is because of this whole oddity.

All clang's fault, right?

Yeah, mostly. But it turns out that what really messes with clangs
little head is that the x86 array_index_mask_nospec() function is
being a bit annoying.

This is what we do:

  static __always_inline unsigned long
array_index_mask_nospec(unsigned long index,
                unsigned long size)
  {
        unsigned long mask;

        asm volatile ("cmp %1,%2; sbb %0,%0;"
                        :"=r" (mask)
                        :"g"(size),"r" (index)
                        :"cc");
        return mask;
  }

and look at the use again:

        nospec_mask = array_index_mask_nospec(fd, fdt->max_fds);

here all the values are actually 'unsigned int'. So what happens is
that clang can't just use the fdt->max_fds value *directly* from
memory, because it needs to be expanded from 32-bit to 64-bit because
we've made our array_index_mask_nospec() function only work on 64-bit
'unsigned long' values.

So it turns out that by massaging this a bit, and making it just be a
macro - so that the asm can decide that "I can do this in 32-bit" - I
can get clang to generate much better code.

Clang still absolutely hates the "g" constraint, so to get clang to
really get this right I have to use "ir" instead of "g". Which is
wrong. Because gcc does this right, and could use the memory op
directly. But even gcc cannot do that with our *current* function,
because of that "the memory value is 32-bit, we require a 64-bit
value"

Anyway, I can get gcc to generate the right code:

        movq    32(%r13), %rdx
        cmp (%rdx),%ebx
        sbb %esi,%esi

which is basically the right code for the six crazy instructions clang
generates. And if I make the "g" be "ir", I can get clang to generate

        movq    32(%rdi), %rcx
        movl    (%rcx), %eax
        cmpl    %eax, %esi
        sbbl    %esi, %esi

which is the same thing, but with that (pointless) load to a register.

And now clang doesn't generate that stack frame at all.

Anyway, this was a long email to explain the odd attached patch.

Comments? Note that this patch is *entirely* untested, I have done
this purely by looking at the code generation in fs/file.c.

                Linus

--00000000000067b57c06154d378e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lulu0arv0>
X-Attachment-Id: f_lulu0arv0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL2JhcnJpZXIuaCB8IDIzICsrKysrKysrKy0tLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9iYXJyaWVyLmggYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9iYXJyaWVyLmgKaW5kZXggNjZlNTdjMDEwMzkyLi42MTU5ZDJjYmJmZGUgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2JhcnJpZXIuaAorKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9iYXJyaWVyLmgKQEAgLTMzLDIwICszMywxNSBAQAogICogUmV0dXJuczoKICAqICAg
ICAwIC0gKGluZGV4IDwgc2l6ZSkKICAqLwotc3RhdGljIF9fYWx3YXlzX2lubGluZSB1bnNpZ25l
ZCBsb25nIGFycmF5X2luZGV4X21hc2tfbm9zcGVjKHVuc2lnbmVkIGxvbmcgaW5kZXgsCi0JCXVu
c2lnbmVkIGxvbmcgc2l6ZSkKLXsKLQl1bnNpZ25lZCBsb25nIG1hc2s7Ci0KLQlhc20gdm9sYXRp
bGUgKCJjbXAgJTEsJTI7IHNiYiAlMCwlMDsiCi0JCQk6Ij1yIiAobWFzaykKLQkJCToiZyIoc2l6
ZSksInIiIChpbmRleCkKLQkJCToiY2MiKTsKLQlyZXR1cm4gbWFzazsKLX0KLQotLyogT3ZlcnJp
ZGUgdGhlIGRlZmF1bHQgaW1wbGVtZW50YXRpb24gZnJvbSBsaW51eC9ub3NwZWMuaC4gKi8KLSNk
ZWZpbmUgYXJyYXlfaW5kZXhfbWFza19ub3NwZWMgYXJyYXlfaW5kZXhfbWFza19ub3NwZWMKKyNk
ZWZpbmUgYXJyYXlfaW5kZXhfbWFza19ub3NwZWMoaWR4LHN6KSAoewlcCisJdHlwZW9mKChpZHgp
KyhzeikpIF9faWR4ID0gKGlkeCk7CVwKKwl0eXBlb2YoX19pZHgpIF9fc3ogPSAoc3opOwkJXAor
CXR5cGVvZihfX2lkeCkgX19tYXNrOwkJCVwKKwlhc20gdm9sYXRpbGUgKCJjbXAgJTEsJTI7IHNi
YiAlMCwlMCIJXAorCQkJOiI9ciIgKF9fbWFzaykJCVwKKwkJCToiaXIiKF9fc3opLCJyIiAoX19p
ZHgpCVwKKwkJCToiY2MiKTsJCQlcCisJX19tYXNrOyB9KQogCiAvKiBQcmV2ZW50IHNwZWN1bGF0
aXZlIGV4ZWN1dGlvbiBwYXN0IHRoaXMgYmFycmllci4gKi8KICNkZWZpbmUgYmFycmllcl9ub3Nw
ZWMoKSBhc20gdm9sYXRpbGUoImxmZW5jZSI6OjoibWVtb3J5IikK
--00000000000067b57c06154d378e--

