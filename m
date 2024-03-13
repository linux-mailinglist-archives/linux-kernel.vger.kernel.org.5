Return-Path: <linux-kernel+bounces-102569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0EE87B3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB261282F84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C53B56776;
	Wed, 13 Mar 2024 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FK1pQxy1"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D054BCF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366719; cv=none; b=XduGbOt2T84t1o/dQ7QY7Y/7dEYPUOFFjuYmd4NNi/ocUvazQMcAUGk+0RaNyzyIcI2q0YaaklUXxmzCZiAd4ELfPLf+QIXGXNSRiPgi0vee6GAPHbxnL4Ffk0hj9C8qk1wz2Qd+SINNPROb67utg/hy2il1ZIvbgpXT/pPyLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366719; c=relaxed/simple;
	bh=hBdvIs25UMavbKrjHvaxFsQ76fNHP6pFUKDpTkxaYns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHXETIcWsQIhrILTLNn56ES4bsQ42i7l8l/FVHXjGO9HWB7AUSMfqoIPvAe02HaLguDdIAXysk8fvf3DqPK603Hfa151R4G95x7lqhpur27ly/qypQz89ouN0abFhshvbEHocGBMUnLIfP3dj6RiIZBpl+EbnKrhGyaTU6szp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FK1pQxy1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so251627166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710366716; x=1710971516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QeGHZUugSwtILKFvBXuTtAPNxZwHhdb9r9cwhsNH7u8=;
        b=FK1pQxy1FxeNpikCxTJ6sX6jx/F3rXGBlNB5S7Dq/biBbNMb0guHxET1e6b86gXLry
         7DiukqQLtg2sMivqfNRUWt1LSMevWGCJeHAE4d+bY+1oYJwTb3bv0MDgQtpnZXNwGWnV
         sXxL/W52SfIkwvgg4FzrYwMHQH2YCa2gYbQ98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366716; x=1710971516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeGHZUugSwtILKFvBXuTtAPNxZwHhdb9r9cwhsNH7u8=;
        b=S7onsNY6hFVNcrQngpH8iUbPpT66Oskf4M33nrltp6GnRZZInaKwY5zJE5pmj5UOCf
         SohVZQBFjuWI7iOhgwAv2Obcyk69xzTbhoVoP3ZF06ucxXFtdI3bqw9Td2QKRHtYHZhQ
         fMQ59DerFIjRxe4vmalWCAI1C4FGENpSJLwgc9snwu7g055ZXaZtb7PeQ5i6KvXZo1n3
         sEk1R9acwMO0JEIoanDAwkKc4YHzbXZ7KtNaEOfy4mIpkiQG/uCHwBtLOfXf+oX1d98I
         9FHxiUTQp9w0RKATU9FLUtddwfcEQPXY6wcDIqmo4NzObt12boEiUSxBjTMkyw9JQ/KX
         CM2w==
X-Forwarded-Encrypted: i=1; AJvYcCWgqIHJViKphnZ1gI9PiDzxdwhWNpvpwO0K0EnsLWrCt875vb0tpJRCpJ2imt8gLHKpv5bLHCL/1RPK98MxwZ+XNoVaby+bzRYZFtLl
X-Gm-Message-State: AOJu0YzpdrFDbUCOzja+TwvcJZsealMjgQbc6EbsYsms8qTmP0WsCN3z
	N3u1YOfYSvyclpnFja9s7ozKcodnYHQOhaHW5uGGkre9GTkHU49NHO+bOIQih2RgdJX90sFvrxo
	EqumdLA==
X-Google-Smtp-Source: AGHT+IG3qwSJaNAoDj4mckVauf0OSbfqZ1r9PZEpyMMUwYp6bckaVNgqJoJhMJhyPCA6rJ6RsaolzA==
X-Received: by 2002:a17:907:c08b:b0:a45:a2cc:eb93 with SMTP id st11-20020a170907c08b00b00a45a2cceb93mr98500ejc.4.1710366715949;
        Wed, 13 Mar 2024 14:51:55 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id q21-20020a1709066b1500b00a461e206c00sm44612ejr.20.2024.03.13.14.51.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 14:51:55 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a446b5a08f0so64095766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:51:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZIk0H/j0KbjYcpPAljiexyN9E0Kh/QJnmwSzRGqrjQ89/zCdwdj1Mf/JCIvQvDNT88U5fnXl1vMMEbeIH+E0D5tmRrqA5tcwlq8mQ
X-Received: by 2002:a17:906:c0d4:b0:a44:52ec:b9e7 with SMTP id
 bn20-20020a170906c0d400b00a4452ecb9e7mr20310ejb.16.1710366714711; Wed, 13 Mar
 2024 14:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
 <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com> <bqlnihgtaxv4gq2k6nah33hq7f3vk73x2sd6mlbdvxln2nbfu6@ypoukdqdqbtb>
In-Reply-To: <bqlnihgtaxv4gq2k6nah33hq7f3vk73x2sd6mlbdvxln2nbfu6@ypoukdqdqbtb>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Mar 2024 14:51:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbgtooUErM9bOP2iWimndpkPLaPy1YZmbmHACU07h3Mw@mail.gmail.com>
Message-ID: <CAHk-=whbgtooUErM9bOP2iWimndpkPLaPy1YZmbmHACU07h3Mw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.9
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 14:34, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> I liked your MAD suggestion, but the catch was that we need an
> exponentially weighted version,

The code for the weighted version literally doesn't change.

The variance value is different, but the difference between MAD and
standard deviation is basically just a constant factor (which will be
different for different distributions, but so what? Any _particular_
case will have a particular distribution).

So why would a constant factor make _any_ difference for any
exponential weighting?

Anyway, feel free to keep your code in bcachefs.

And maybe xfs even wants to copy that code. I don't care, it seems
stupid, but that's a filesystem choice.

But if we're making it a generic kernel library, it needs to be sane.
Not making people do 64-bit square roots and 128-bit divides just for
a random statistical element.

              Linus

