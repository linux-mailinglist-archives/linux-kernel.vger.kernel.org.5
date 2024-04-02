Return-Path: <linux-kernel+bounces-127652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B56894EEF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DE21C217C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449A958AAB;
	Tue,  2 Apr 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEKCsU+3"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8257315
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050998; cv=none; b=g0UOEAAQC0Vmyolew6KpVEM1laKeSKpRk1Gsc+v3m+DgLGeVmVzV1UZkoZI3yHSjXBiZ9QVkXnsXNCpcyBRdn9So/FegPReGGdA0fQpGfKbxUrEMLaPgx57AJ7RRNdycl2hVF95FFe5xiRdCvtIYdnocowJ0iaWSztvuEZh5+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050998; c=relaxed/simple;
	bh=RVAWVqofcGVIJFPGO5hoiwSwVpKqWH4TNxIF1wPwKlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3KGJXVbwg6Pu29ZPnxZ4PyvTeQFkzqfd/8Fue/+Bie07qO8N1W3Z8IouOXxZ1EO1pcvx6jGheGcB2TP5mYUfpvwSgKm9x0JH68PmNQ0AUsjO9Y342SkWVJZ+JIz9W2iRwF3ROOJSUwasJOx5iVGC8V0zh6Po2TKscRwJzCDeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEKCsU+3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d717603aa5so49812121fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712050995; x=1712655795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDVn1pulaEc3iCiE7KADuw7X+Dvp13LQcCqo7Te8g48=;
        b=EEKCsU+3rN3GzVB0DmHq3j+nhaLGpaft3W/zMz607Z4S/ULgvgXWnq5gDDFBj0kvBL
         FeX2d0eg+gwAFCWmH7dHjh8IL6C0wVkNVKxqhmvWqzVW9OvJ2V7lRGt9bPAhkC7faf5K
         qIty2iJRaDRvGyi1nphi4wyE9Kw6y9S3h0eKep1X3JdRVUKECmVhfr93SOa09RlfwI9s
         fO450B9vHB1xbDxyYosQZK/R0kNXKVmB+1LTvb3PDUR3kQuW3ar4yDGswq1EUrEfv3GK
         XwwB3QM51Za6qpvLIlNym//6PXWUJcbJOYEutVv0QBUPzYHpNrenTSTGykhiTPBP028m
         W+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712050995; x=1712655795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDVn1pulaEc3iCiE7KADuw7X+Dvp13LQcCqo7Te8g48=;
        b=Nz4tQhLUMU7PlDjQ+M3bXkl/Xg6GxDR5HqFlHTLGb9RsHLQNOmZzJV9i35SBYWogSu
         2pfV6KLnnZh2pzMxn7khoWBcyq1kNH1K0K+jfiz2BQ2iPKFzq+Wb2IXY8sdGhoV54edJ
         ICsvilomUkjJDkwNHaUPq9DQK8hKYBXCUlcIRJQaSWAeP0Fg9tmQkZx1GGAEIg7ioYSS
         Y36Dfx4hsgMS/RWl3b2+vcUdPoIQIR+Ap4P7xls0h8xJB5fXxXBu3iGae2ekXIJXfDEL
         Q7HAkdUm5rM8Y0WrY8PQenMGtBzVI5z0IluMOreKT/ZWI1+IhRniTRls1zkt0mmLy4Ht
         g6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXCNJ0pURZhB/GfsNiAttTpfUOpyDW/t9/H7yKe/bWw+xCh06h48ktjvCX78wGrIPzXxfMlI7qJIK0dOUZrmrMTgC0vWjpqmzwVakOM
X-Gm-Message-State: AOJu0YxL+3+r5bKURVDLnqQF1n+JV1ad6q0gRz+iw6pRnzc/YJi06cPt
	kY0/nS/amrC/Yl014XWGwgmn1EkhYcSFL1h1e0WEVGhr03qQrI6HQ0i5vhSDJ2ZGsUYkduVgSyP
	7fAZn4RU19phFTAz8K3ZbeElEjQQ=
X-Google-Smtp-Source: AGHT+IHo27ExKVdQsgIexgw/a88p7VSPk0bG9b+NNaS3v14guHa4d1q4+UJky59+lywV9h6SWgUSeWKQwU8+p7LScr4=
X-Received: by 2002:a2e:92c1:0:b0:2d7:577:f203 with SMTP id
 k1-20020a2e92c1000000b002d70577f203mr6472923ljh.12.1712050994403; Tue, 02 Apr
 2024 02:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
 <CAFULd4a75kS=3cJzYKsOcJ3ULjW8k5M1cvPYZQ25zZqTo3QX9Q@mail.gmail.com> <CAFGhKbx3dzrMC0euRMNe5=sAhM87v=6gLwOT+c9HwWKZrWc5Gg@mail.gmail.com>
In-Reply-To: <CAFGhKbx3dzrMC0euRMNe5=sAhM87v=6gLwOT+c9HwWKZrWc5Gg@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 2 Apr 2024 11:43:02 +0200
Message-ID: <CAFULd4ZNi7eONVu8syiWyA5ek2TgHTf6jTM+Pf7SaSG6WyHoNw@mail.gmail.com>
Subject: Re: warning: cast removes address space '__percpu' of expression
To: Charlemagne Lasse <charlemagnelasse@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000005bf77c061519effc"

--0000000000005bf77c061519effc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 9:56=E2=80=AFAM Charlemagne Lasse
<charlemagnelasse@gmail.com> wrote:
>
> Am Mo., 1. Apr. 2024 um 21:16 Uhr schrieb Uros Bizjak <ubizjak@gmail.com>=
:
> > > I would even go as far as saying that 1ca3683cc6d2 ("x86/percpu:
> > > Enable named address spaces with known compiler version") together
> > > with 3a1d3829e193 ("x86/percpu: Avoid sparse warning with cast to
> > > named address space") triggered this problem
>
> I think 1ca3683cc6d2 was wrong and is the last working one.
>
>
> Just switch to 1ca3683cc6d2c2ce4204df519c4e4730d037905a and you won't
> see the messages.
>
> ```
> git reset --hard 1ca3683cc6d2c2ce4204df519c4e4730d037905a
> git clean -dfx
> make allnoconfig -j$(nproc)
> make kvm_guest.config
> make prepare -j$(nproc)
> touch include/linux/netdevice.h
> make C=3D1 net/core/dev.o CHECK=3D"sparse -Wcast-from-as"
> ```
>
> Go to 9a462b9eafa6dda16ea8429b151edb1fb535d744 and cherry-pick
> 3a1d3829e193c091475ceab481c5f8deab385023 and you would see the error.
> On amd64  with 12.2.0, this would look like this:
>
> ```
> git reset --hard 9a462b9eafa6dda16ea8429b151edb1fb535d744
> git cherry-pick 3a1d3829e193c091475ceab481c5f8deab385023
> git clean -dfx
> make allnoconfig -j$(nproc)
> make kvm_guest.config
> make prepare -j$(nproc)
> touch include/linux/netdevice.h
> make C=3D1 net/core/dev.o CHECK=3D"sparse -Wcast-from-as"
> ```
>
> I would recommend to use `-Wsparse-all` for testing but for this
> demonstration, it is easier to use `-Wcast-from-as` to reduce the
> amount of noise in the demonstrator.

Oh, I see the problem now. We *do* cast away from __percpu space, this
is how we switch between GCC's named address spaces [1]:

--q--
6.17.5 x86 Named Address Spaces

..

The respective segment base must be set via some method specific to
the operating system. Rather than require an expensive system call to
retrieve the segment base, these address spaces are not considered to
be subspaces of the generic (flat) address space. This means that
explicit casts are required to convert pointers between these address
spaces and the generic address space. In practice the application
should cast to uintptr_t and apply the segment base offset that it
installed previously.
--/q--

Please try the attached patch that informs sparse about this action.

BTW: Please also note recent discussion about different checks for
__percpu name space that can be implemented using GCC's named address
spaces feature [2].

[1] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html
[2[ https://lore.kernel.org/lkml/87bk7ux4e9.ffs@tglx/#t

Thanks,
Uros.

--0000000000005bf77c061519effc
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lui6xxmg0>
X-Attachment-Id: f_lui6xxmg0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGVyY3B1LmgKaW5kZXggNDQ5NThlYmFmNjI2Li44ZmM4ZDIzNmMyNTUgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BlcmNwdS5oCkBAIC03MCw3ICs3MCw3IEBACiAJdW5zaWduZWQgbG9uZyB0Y3BfcHRy
X187CQkJCVwKIAl0Y3BfcHRyX18gPSBfX3Jhd19jcHVfcmVhZCgsIHRoaXNfY3B1X29mZik7CQlc
CiAJCQkJCQkJCVwKLQl0Y3BfcHRyX18gKz0gKHVuc2lnbmVkIGxvbmcpKHB0cik7CQkJXAorCXRj
cF9wdHJfXyArPSAoX19mb3JjZSB1bnNpZ25lZCBsb25nKShwdHIpOwkJXAogCSh0eXBlb2YoKihw
dHIpKSBfX2tlcm5lbCBfX2ZvcmNlICopdGNwX3B0cl9fOwkJXAogfSkKICNlbHNlIC8qIENPTkZJ
R19VU0VfWDg2X1NFR19TVVBQT1JUICovCkBAIC04NSw3ICs4NSw3IEBACiAJICAgICA6ICI9ciIg
KHRjcF9wdHJfXykJCQkJCVwKIAkgICAgIDogIm0iIChfX215X2NwdV92YXIodGhpc19jcHVfb2Zm
KSkpOwkJXAogCQkJCQkJCQlcCi0JdGNwX3B0cl9fICs9ICh1bnNpZ25lZCBsb25nKShwdHIpOwkJ
CVwKKwl0Y3BfcHRyX18gKz0gKF9fZm9yY2UgdW5zaWduZWQgbG9uZykocHRyKTsJCVwKIAkodHlw
ZW9mKCoocHRyKSkgX19rZXJuZWwgX19mb3JjZSAqKXRjcF9wdHJfXzsJCVwKIH0pCiAjZW5kaWYg
LyogQ09ORklHX1VTRV9YODZfU0VHX1NVUFBPUlQgKi8KQEAgLTEwMiw4ICsxMDIsOCBAQAogI2Vu
ZGlmIC8qIENPTkZJR19TTVAgKi8KIAogI2RlZmluZSBfX215X2NwdV90eXBlKHZhcikJdHlwZW9m
KHZhcikgX19wZXJjcHVfc2VnX292ZXJyaWRlCi0jZGVmaW5lIF9fbXlfY3B1X3B0cihwdHIpCShf
X215X2NwdV90eXBlKCpwdHIpICopKHVpbnRwdHJfdCkocHRyKQotI2RlZmluZSBfX215X2NwdV92
YXIodmFyKQkoKl9fbXlfY3B1X3B0cigmdmFyKSkKKyNkZWZpbmUgX19teV9jcHVfcHRyKHB0cikJ
KF9fbXlfY3B1X3R5cGUoKnB0cikgKikoX19mb3JjZSB1aW50cHRyX3QpKHB0cikKKyNkZWZpbmUg
X19teV9jcHVfdmFyKHZhcikJKCpfX215X2NwdV9wdHIoJih2YXIpKSkKICNkZWZpbmUgX19wZXJj
cHVfYXJnKHgpCQlfX3BlcmNwdV9wcmVmaXggIiUiICN4CiAjZGVmaW5lIF9fZm9yY2VfcGVyY3B1
X2FyZyh4KQlfX2ZvcmNlX3BlcmNwdV9wcmVmaXggIiUiICN4CiAK
--0000000000005bf77c061519effc--

