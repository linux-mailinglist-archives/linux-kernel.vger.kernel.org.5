Return-Path: <linux-kernel+bounces-65824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AA855279
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BAA1C274BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A513D12F37B;
	Wed, 14 Feb 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GPYuxI1z"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C8604AB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936252; cv=none; b=Z69/OagRfbGYuYa68uDIRFS9klAIt4lvYojpnumHl7JlG4YpiSTBhIQz4YBHgXr9DyR89JVg0kMGCwZczDqG6f+DTA7Hxn3MGbDy4yKBcL+qaxVXL+ZTz3ZjeFnRqeRIEvWbPPreaEB9O296cru77tOml/rt6GKNRqlJX2j5uhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936252; c=relaxed/simple;
	bh=icjqOUBqDhvNqaJSlrDNjJyaZHw4wcNN655EoUeZaWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfpMbYYHJqnzEE1zAd2MR2ssjAMfKilNFIxEUIL3l+/dZOetIpu/6SxKtQQ+suAazPeH/2jUlU3lqEO13NLVnxVChUV1oT/oiXKKGe+ojNkeGg6g6r6jblc7Dk+5MOSZ202E3Vw3ghIC6nhb2xwqCLW8vM/7K3E7bNRKiv+mL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GPYuxI1z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so111626a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707936249; x=1708541049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqaxyVnmqOcpqixyynWKkEU90hzNVr8SECJt4qWMgW4=;
        b=GPYuxI1zMIQ9rrbFushFvsDTJQz7T1C8Ju0bpBZi3JHTN/5A0t57GoFBWH1nRCpgTN
         LUiU8mXvTJVSxl1fLDLO1KDJYge24RxJJvGkA/QQWUBNxRmVn68pG8ayCJO/B4g2ItVm
         x2Ep9gvgBvp43aRsynYMrOpDJ5DaJ9R+Y+hag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936249; x=1708541049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqaxyVnmqOcpqixyynWKkEU90hzNVr8SECJt4qWMgW4=;
        b=hl+5x7LYA2qoq/hFrznyWiBwEGFWF9o0+YKcvrXFz8QJTfIAuOlwnp9d9alxaZhz0g
         q028+a52f/eSWsMix1dE7FJZO3MIJxDL86S7NdiNKvppSm0X+BRS0Cf+J06hd0sWjPKr
         SfOndHAMmudQQMQaBDXZO+OYNIpNYj16LE7ltFvP8u3aUrHdAzTKleQ+yCQ9gk8Wagv2
         bIvg9Z0woLt6v27ungB0ZUYkwbnm8JD+4lNL3uYn4+1MxWKlmR7xYP8kip+lzu6jn7SU
         RxVOGh8MGbEtgOjY5ty1ojrbvtgqDt3AVvV5M1f9ZUQcVuuZzzA0V+YTYwUKNW6ZQb2s
         dmWg==
X-Forwarded-Encrypted: i=1; AJvYcCUmQ607V/e0rmFUBdRBQWpNvBnlWgEywCCYF/q0bmT6OphthEfgbXmPvp1Z2UzfPojiIB1ScHHGE4t5qafhAg9kGRInBLDd3tzuZMSc
X-Gm-Message-State: AOJu0YwA/nZrnWfbtBYlsutno3G8a8aDQFyq+/wi29DupA6tCQzp0/9i
	yRAObxdXv4HGBtvP12KVh/+Eo48thQngEmlRmBaVo4NTioeY9fpz8GWmYVFF+/xHNg0PV7x/I6Z
	CH8I=
X-Google-Smtp-Source: AGHT+IFIbAn27atsILmGI1LmhLV8xCoEIATS+TskLdFW2kOH5mGqXgNTiN7Dd//KeHxv19YC3JB1WA==
X-Received: by 2002:a17:906:260a:b0:a3c:c451:2115 with SMTP id h10-20020a170906260a00b00a3cc4512115mr2519783ejc.77.1707936248845;
        Wed, 14 Feb 2024 10:44:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxu/j3d5jIBQDbvpRTBmpB/hhgxTYtOl5Mm4GJLVCebCgcNdSCG9fr2fqnVeZrKMraDtjmM/8kYgejowHQQssZJJZcvyd16x+ZkvKh
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709060d8800b00a3d47ee62c7sm821317eji.124.2024.02.14.10.44.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 10:44:07 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so82680a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:44:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBGJBCSNl4IWhWvwQ5mB9yeTXqpEHOTcP5l267UZbn+jIoWlk0GQJT658g9pqwEkTM6cgUcqo3PZ9WIKxV2ZV9QAYQoxCzli29ywF/
X-Received: by 2002:a05:6402:35c1:b0:563:2069:9555 with SMTP id
 z1-20020a05640235c100b0056320699555mr2778693edc.35.1707936247440; Wed, 14 Feb
 2024 10:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208220604.140859-1-seanjc@google.com> <CAKwvOdk_obRUkD6WQHhS9uoFVe3HrgqH5h+FpqsNNgmj4cmvCQ@mail.gmail.com>
 <DM6PR02MB40587AD6ABBF1814E9CCFA7CB84B2@DM6PR02MB4058.namprd02.prod.outlook.com>
 <CAHk-=wi3p5C1n03UYoQhgVDJbh_0ogCpwbgVGnOdGn6RJ6hnKA@mail.gmail.com>
 <ZcZyWrawr1NUCiQZ@google.com> <CAKwvOdmKaYYxf7vjvPf2vbn-Ly+4=JZ_zf+OcjYOkWCkgyU_kA@mail.gmail.com>
 <CAHk-=wgEABCwu7HkJufpWC=K7u_say8k6Tp9eHvAXFa4DNXgzQ@mail.gmail.com>
 <CAHk-=wgBt9SsYjyHWn1ZH5V0Q7P6thqv_urVCTYqyWNUWSJ6_g@mail.gmail.com> <CAFULd4ZUa56KDLXSoYjoQkX0BcJwaipy3ZrEW+0tbi_Lz3FYAw@mail.gmail.com>
In-Reply-To: <CAFULd4ZUa56KDLXSoYjoQkX0BcJwaipy3ZrEW+0tbi_Lz3FYAw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2024 10:43:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRQKkgUSRsLHNkgi3M4M-mwPq+9-RST=neGibMR=ubUw@mail.gmail.com>
Message-ID: <CAHk-=wiRQKkgUSRsLHNkgi3M4M-mwPq+9-RST=neGibMR=ubUw@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: Explicitly disable asm goto w/ outputs on gcc-11
 (and earlier)
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Jakub Jelinek <jakub@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "Andrew Pinski (QUIC)" <quic_apinski@quicinc.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000540e2206115be5e4"

--000000000000540e2206115be5e4
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Feb 2024 at 03:12, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> So, I'd suggest at least limit the workaround to known-bad compilers.

Based on the current state of

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921

I would suggest this attached kernel patch, which makes the manual
"volatile" the default case (since it should make no difference except
for the known gcc issue), and limits the extra empty asm serialization
to gcc versions older than 12.1.0.

But Jakub is clearly currently trying to figure out exactly what was
going wrong, so things may change. Maybe the commit he bisected to
happened to just accidentally hide the real issue.

                Linus

--000000000000540e2206115be5e4
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lsm537ms0>
X-Attachment-Id: f_lsm537ms0

IGluY2x1ZGUvbGludXgvY29tcGlsZXItZ2NjLmggICB8IDEyICsrKy0tLS0tLS0tLQogaW5jbHVk
ZS9saW51eC9jb21waWxlcl90eXBlcy5oIHwgMTEgKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9jb21waWxlci1nY2MuaCBiL2luY2x1ZGUvbGludXgvY29tcGlsZXItZ2NjLmgKaW5k
ZXggYzFhOTYzYmU3ZDI4Li5kMTgxZDI3MDNiYmEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgv
Y29tcGlsZXItZ2NjLmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxlci1nY2MuaApAQCAtNjcs
MjEgKzY3LDE1IEBACiAvKgogICogR0NDICdhc20gZ290bycgd2l0aCBvdXRwdXRzIG1pc2NvbXBp
bGVzIGNlcnRhaW4gY29kZSBzZXF1ZW5jZXM6CiAgKgotICogICBodHRwczovL2djYy5nbnUub3Jn
L2J1Z3ppbGxhL3Nob3dfYnVnLmNnaT9pZD0xMTA0MjAKLSAqICAgaHR0cHM6Ly9nY2MuZ251Lm9y
Zy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9MTEwNDIyCisgKiAgIGh0dHBzOi8vZ2NjLmdudS5v
cmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTExMzkyMQogICoKICAqIFdvcmsgaXQgYXJvdW5k
IHZpYSB0aGUgc2FtZSBjb21waWxlciBiYXJyaWVyIHF1aXJrIHRoYXQgd2UgdXNlZAogICogdG8g
dXNlIGZvciB0aGUgb2xkICdhc20gZ290bycgd29ya2Fyb3VuZC4KLSAqCi0gKiBBbHNvLCBhbHdh
eXMgbWFyayBzdWNoICdhc20gZ290bycgc3RhdGVtZW50cyBhcyB2b2xhdGlsZTogYWxsCi0gKiBh
c20gZ290byBzdGF0ZW1lbnRzIGFyZSBzdXBwb3NlZCB0byBiZSB2b2xhdGlsZSBhcyBwZXIgdGhl
Ci0gKiBkb2N1bWVudGF0aW9uLCBidXQgc29tZSB2ZXJzaW9ucyBvZiBnY2MgZGlkbid0IGFjdHVh
bGx5IGRvCi0gKiB0aGF0IGZvciBhc21zIHdpdGggb3V0cHV0czoKLSAqCi0gKiAgICBodHRwczov
L2djYy5nbnUub3JnL2J1Z3ppbGxhL3Nob3dfYnVnLmNnaT9pZD05ODYxOQogICovCisjaWYgR0ND
X1ZFUlNJT04gPCAxMjAxMDAKICNkZWZpbmUgYXNtX2dvdG9fb3V0cHV0KHguLi4pIFwKIAlkbyB7
IGFzbSB2b2xhdGlsZSBnb3RvKHgpOyBhc20gKCIiKTsgfSB3aGlsZSAoMCkKKyNlbmRpZgogCiAj
aWYgZGVmaW5lZChDT05GSUdfQVJDSF9VU0VfQlVJTFRJTl9CU1dBUCkKICNkZWZpbmUgX19IQVZF
X0JVSUxUSU5fQlNXQVAzMl9fCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5
cGVzLmggYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmgKaW5kZXggNjYzZDg3OTFjODcx
Li4zYmI1YTlkMTZlYWEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMu
aAorKysgYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmgKQEAgLTM2Miw4ICszNjIsMTcg
QEAgc3RydWN0IGZ0cmFjZV9saWtlbHlfZGF0YSB7CiAjZGVmaW5lIF9fbWVtYmVyX3NpemUocCkJ
X19idWlsdGluX29iamVjdF9zaXplKHAsIDEpCiAjZW5kaWYKIAorLyoKKyAqICJhc20gZ290byIg
aXMgZG9jdW1lbnRlZCB0byBhbHdheXMgYmUgdm9sYXRpbGUsIGJ1dCBzb21lIHZlcnNpb25zCisg
KiBvZiBnY2MgZG9uJ3QgYWN0dWFsbHkgZG8gdGhhdDoKKyAqCisgKiAgIGh0dHBzOi8vZ2NjLmdu
dS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTEwMzk3OQorICoKKyAqIFNvIHdlJ2xsIGp1
c3QgZG8gaXQgbWFudWFsbHkgdW5sZXNzIHdlIGhhdmUgb3RoZXIgbW9yZSBleHRlbnNpdmUKKyAq
IHdvcmthcm91bmRzLgorICovCiAjaWZuZGVmIGFzbV9nb3RvX291dHB1dAotI2RlZmluZSBhc21f
Z290b19vdXRwdXQoeC4uLikgYXNtIGdvdG8oeCkKKyNkZWZpbmUgYXNtX2dvdG9fb3V0cHV0KHgu
Li4pIGFzbSB2b2xhdGlsZSBnb3RvKHgpCiAjZW5kaWYKIAogI2lmZGVmIENPTkZJR19DQ19IQVNf
QVNNX0lOTElORQo=
--000000000000540e2206115be5e4--

