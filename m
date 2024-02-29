Return-Path: <linux-kernel+bounces-87178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA0286D0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226F028C7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D85970AD5;
	Thu, 29 Feb 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UkPwfEB4"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353770AFD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227973; cv=none; b=c5kHeq44NfCP9wKzjsyCs8iBDjQ9dNH/fbPfo4BPXWYDGOKE09RNZFXp2Wq1QDZEh3e37bwzlOTgq0u1JBc8rqTzezbL1ixA0qElBtglZuzVFyUb3Ow8qfEkRd45pexU0VGM86Q9WUOUGgOdxiyn0NbSitnIxVR/MAWjO+99gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227973; c=relaxed/simple;
	bh=jzGj5I4LRuYklOQyJfNOnG7oivOkxoCVa97TajgQgCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BitHi7aGA8+Y+lvSXv7S+ctoMSv5axEHKSrsoVUIIqyxXnGjr4OgQd3mt0Q/dM9DzuTmSCreKXSWYs5+3i5HGZ5KgHzFGKiBDIWaHmpyRmfdQnKLfIdns5EA6CsVmdxFzQIYgqQVJyJwwGooDe9asRV6zbjNRHvPQNLyw1WeA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UkPwfEB4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a446478b04bso70524466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709227969; x=1709832769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQrqXSOy2jKpIC5hjgybMDfk5pI8gvMKo0UOhxnaCp0=;
        b=UkPwfEB4O6Y6ht2USoBSG/iMVrIqf1j5RMbMgxabuAJkeVL8qQLd3VEOJrEp93s8pu
         Lh8Ssf+TE3jpPEtTfzCN9mC/qbm04xvvUsmhPghUtWBelhS5yDBWEEpy4BZJZnOgG7Eu
         NbSQved5jtliTlseHJSmjtSjjSOOLVFXZOZ+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227969; x=1709832769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQrqXSOy2jKpIC5hjgybMDfk5pI8gvMKo0UOhxnaCp0=;
        b=NRaghaahAg+lHpsa11N5IEIJ3ky4Qq2Rx315utkKfFAa9WS8lXK23WRK5iXRqrfPg0
         RVXA9hLqeDFiEX07AKRt6varlflYotBu8OQizqPH0zqlSTHAUSirQqixtN0WWyJCJA7h
         4bYkkLJtL7d9Y/V87zCE8lLB622lIcEy6AjRTSJE1Dcmd2iJltSdK37L9uGa7RutXHS7
         89ug+sDnABj4u6P1pj6BdAomvINnTtQqJeJhGIID0AsKHmXH4cdzFaamDRNzTGQ1wg+J
         0ko5D/wbcjCJycEWsjlZWNIb0sNTMh+62LYIthfXumU/sUq91RHDh1O5Pi4SeBHOLvf1
         kCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBSsvXVoDsXdZUhwSSgUq/9oxj0g2ApjAvAnkSsKZBD0oiDr4wBU/T++EfIgvJBmBQ3Y8uYiKmhy6zRDUEKU+sgFXByCSHx37YyVYG
X-Gm-Message-State: AOJu0Yyh62QQ21d6vCz2/ITRemuZn4aqxx5eqixpC3dA69/GN9Gaqx1F
	DzPmpRjIPBvwaaLMDdIZjdcKOmFoan+eXoYtfcw/a368xAZlvQ2UkZdQwkG639MZ9ijUwtOxkdz
	CGWT4tw==
X-Google-Smtp-Source: AGHT+IFYwIuaUSpSHd+TzurO1KQrUGh8CS1dTYmf5496JxMk1QtsyK32S0l5Tw5CF2OsOzYT2RSADg==
X-Received: by 2002:a17:906:bc52:b0:a3e:5856:9b03 with SMTP id s18-20020a170906bc5200b00a3e58569b03mr2240799ejv.18.1709227969315;
        Thu, 29 Feb 2024 09:32:49 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id cm29-20020a170906f59d00b00a3ce60b003asm897443ejd.176.2024.02.29.09.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:32:48 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so1688160a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:32:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOT141zy9zGA+Zm7M3JCH8tM5CcebmOOLVShfTjYXT9g+cLsU9f7gE/5UaVqzcKeOn0twZGC5qMlVHZZZ5M8nH4InNYPOHBQDfor4j
X-Received: by 2002:a17:906:b78e:b0:a44:176e:410c with SMTP id
 dt14-20020a170906b78e00b00a44176e410cmr2046490ejb.5.1709227968058; Thu, 29
 Feb 2024 09:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com> <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
In-Reply-To: <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Feb 2024 09:32:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
Message-ID: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>, Al Viro <viro@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: multipart/mixed; boundary="000000000000e07d49061288a5ca"

--000000000000e07d49061288a5ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 at 00:13, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> See the logic before this patch, always success (((void)(K),0)) is
> returned for three types: ITER_BVEC, ITER_KVEC and ITER_XARRAY.

No, look closer.

Yes, the iterate_and_advance() macro does that "((void)(K),0)" to make
the compiler generate better code for those cases (because then the
compiler can see that the return value is a compile-time zero), but
notice how _copy_mc_to_iter() didn't use that macro back then. It used
the unvarnished __iterate_and_advance() exactly so that the MC copy
case would *not* get that "always return zero" behavior.

That goes back to (in a different form) at least commit 1b4fb5ffd79b
("iov_iter: teach iterate_{bvec,xarray}() about possible short
copies").

But hardly anybody ever tests this machine-check special case code, so
who knows when it broke again.

I'm just looking at the source code, and with all the macro games it's
*really* hard to follow, so I may well be missing something.

> Maybe we're all gonna fix it back? as follows=EF=BC=9A

No. We could do it for the kvec and xarray case, just to get better
code generation again (not that I looked at it, so who knows), but the
one case that actually uses memcpy_from_iter_mc() needs to react to a
short write.

One option might be to make a failed memcpy_from_iter_mc() set another
flag in the iter, and then make fault_in_iov_iter_readable() test that
flag and return 'len' if that flag is set.

Something like that (wild handwaving) should get the right error handling.

The simpler alternative is maybe something like the attached.
COMPLETELY UNTESTED. Maybe I've confused myself with all the different
indiraction mazes in the iov_iter code.

                     Linus

--000000000000e07d49061288a5ca
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lt7i5gtw0>
X-Attachment-Id: f_lt7i5gtw0

IGxpYi9pb3ZfaXRlci5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2xpYi9pb3ZfaXRlci5jIGIvbGliL2lvdl9p
dGVyLmMKaW5kZXggZTBhYTZiNDQwY2E1Li41MjM2YzE2NzM0ZTAgMTAwNjQ0Ci0tLSBhL2xpYi9p
b3ZfaXRlci5jCisrKyBiL2xpYi9pb3ZfaXRlci5jCkBAIC0yNDgsNyArMjQ4LDEwIEBAIHN0YXRp
YyBfX2Fsd2F5c19pbmxpbmUKIHNpemVfdCBtZW1jcHlfZnJvbV9pdGVyX21jKHZvaWQgKml0ZXJf
ZnJvbSwgc2l6ZV90IHByb2dyZXNzLAogCQkJICAgc2l6ZV90IGxlbiwgdm9pZCAqdG8sIHZvaWQg
KnByaXYyKQogewotCXJldHVybiBjb3B5X21jX3RvX2tlcm5lbCh0byArIHByb2dyZXNzLCBpdGVy
X2Zyb20sIGxlbik7CisJc2l6ZV90IG4gPSBjb3B5X21jX3RvX2tlcm5lbCh0byArIHByb2dyZXNz
LCBpdGVyX2Zyb20sIGxlbik7CisJaWYgKG4pCisJCW1lbXNldCh0byArIHByb2dyZXNzIC0gbiwg
MCwgbik7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBzaXplX3QgX19jb3B5X2Zyb21faXRlcl9t
Yyh2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0cnVjdCBpb3ZfaXRlciAqaSkK
--000000000000e07d49061288a5ca--

