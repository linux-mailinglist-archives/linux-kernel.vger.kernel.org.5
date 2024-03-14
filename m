Return-Path: <linux-kernel+bounces-103726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A857887C3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D89D1F222B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2D8762EB;
	Thu, 14 Mar 2024 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="zJaYdoR6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DE8762D3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710444187; cv=none; b=av8iAQ4HjRkmhx0bkS3OVO9yNWYVUoSf7iTKiENRbpU87afZBzpEMmJ/lpF29aWPDHNZwmBCjt5MyHGljxSt3yK1no9u/P98nuYSVo6EbURNQWdnFnvEzKj0HzTvYl2+WfPjx1S9RYYoOVHTnDyq/CCCes4eSm0JcrxgWrMZfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710444187; c=relaxed/simple;
	bh=UZknqzvQ4FXnNpri558VcyxPoGTUJkGKM/XaMZJUDBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mRG98Y7Ln37d4w6PJA5HTu9lHsfY/6rMAnvIARsbQ9LkpPTiNze1oXpDedeU6POaTOIJedZ7Bd84qmHeeCulTg8G67mZ2jV28QVIiP3UBrl7GXco7zhnez5HMj6KpzrlCdKWGxNqdO5HXd9u1X5f+0Ht3qpgx0fwi0byuQF2/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=zJaYdoR6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5684073ab38so2470356a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710444183; x=1711048983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZknqzvQ4FXnNpri558VcyxPoGTUJkGKM/XaMZJUDBU=;
        b=zJaYdoR62LpQZ4gmNRiW90HBcvll6kmkTT0I8yiYizL+rgm1f1h4XvDJDWfVbvVfs9
         esDRZVRZzuOaGHudRXs1mK796AoaHv9qfKxFDCMe/0m9vKPx9FCx4y+XffTxMMk1VYcy
         QvsFIIWRfGERdJhPGSujmoYhnU2g9Hpl1KRlD06yUzjYOUGkvvPrd23xHZCi9DT3fKie
         f1EaIgQ/HuXV4PgDSc9d7T2RHRYeIL5LAacRvrjgZT8XDlL6061WKUFehGSGtmB1tuUE
         bBuzON26u2FJx+fgX6U2aQDufjqwUaZDwxsYK64lyATFA0GgcMgIeRc8SrYRi1z8m5PA
         LfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710444183; x=1711048983;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UZknqzvQ4FXnNpri558VcyxPoGTUJkGKM/XaMZJUDBU=;
        b=unDdtaTqKt56BgRQltm+oxDhaSe9gucqArY8u76kOy+4zBYQAJY87jhCFiew7TSjs2
         tAn/C6O5Nrmkm6n4pwEdbUpA04o2nRuXcpRpgaycJc5+DCmFZ7kQ/Y6s4ABD1/bUF62h
         xmMRVRQ4Lk3YnNV0mxGL0gY22k/rWUDoL2CYYd2I95stvEwWNqCe3oGrSl7itsaqdAki
         VKZ6zaJxwXlrLA51Bf1arntITnc5vD9wSQ/pNF6GKLuSEt3v2acvA+MWdLKfWTN9g9Cj
         mNpGVQN16+8QMqYiOOHT+6cEbtH89nsYOyliEKUrEBWf7CfRMMfw2fMqkWz8mzA2wveq
         zisg==
X-Forwarded-Encrypted: i=1; AJvYcCWY2bvUSUp9CMxAh+5qchNarDGb/hjA3cdaQMiQRXEAQh4cnd9x7FKthzkO7ANOQwxJ9HXJmAwZBGeCIpsjzCGh/Iyxp0GgAP9nwmc1
X-Gm-Message-State: AOJu0YwNDmTjN5TnIxs9ba4w5bMHLhfnd7obGj7AkVhSvoKypll1wOEw
	93xFvFFVwmG9Es9gJCzuWifDiJk4vtvF5X5sKgmVO81HNWn3ipTMFATnHJ9GtSg=
X-Google-Smtp-Source: AGHT+IEQiBoHqZGzF80uJgL2VLJfYI3sQXzz6qKOOI7PtZ2ZTkI1WY3DSt46ADJnk/nmochY/RgTWQ==
X-Received: by 2002:a05:6402:4493:b0:567:80c7:33bf with SMTP id er19-20020a056402449300b0056780c733bfmr3038848edb.7.1710444183353;
        Thu, 14 Mar 2024 12:23:03 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b00568a15b063csm799503edb.2.2024.03.14.12.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 12:23:02 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,  Jens Axboe <axboe@kernel.dk>,
  Christoph Hellwig <hch@lst.de>,  Keith Busch <kbusch@kernel.org>,  Damien
 Le Moal <Damien.LeMoal@wdc.com>,  Bart Van Assche <bvanassche@acm.org>,
  Hannes Reinecke <hare@suse.de>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Niklas Cassel
 <Niklas.Cassel@wdc.com>,  Greg KH <gregkh@linuxfoundation.org>,  Matthew
 Wilcox <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Alice Ryhl <aliceryhl@google.com>,  Chaitanya Kulkarni
 <chaitanyak@nvidia.com>,  Luis Chamberlain <mcgrof@kernel.org>,  Yexuan
 Yang <1182282462@bupt.edu.cn>,  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado
 <sergio.collado@gmail.com>,  Joel Granados <j.granados@samsung.com>,
  "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,  Daniel Gomez
 <da.gomez@samsung.com>,  open list <linux-kernel@vger.kernel.org>,
  "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
  "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
  "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
 (Miguel
	Ojeda's message of "Thu, 14 Mar 2024 19:55:49 +0100")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-2-nmi@metaspace.dk> <ZfI8-14RUqGqoRd-@boqun-archlinux>
	<87il1ptck0.fsf@metaspace.dk>
	<CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Thu, 14 Mar 2024 20:22:54 +0100
Message-ID: <87plvwsjn5.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Thu, Mar 14, 2024 at 9:58=E2=80=AFAM Andreas Hindborg <nmi@metaspace.d=
k> wrote:
>>
>> Yes, good point. Another option suggested by Miguel is that
>> `__blk_mq_free_request` need not be exported at all. We can make it
>> non-static and then call it from
>> `rust_helper_blk_mq_free_request_internal()`. Then only the latter will
>> be in the kernel image symbol table, which might be better in terms of
>> not exposing `__blk_mq_free_request()` directly.
>
> The helper is not needed, i.e. what I meant was to make it non-static
> and add it to `include/linux/blk-mq.h`.

The way the current code compiles, <kernel::block::mq::Request as
kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
module. A relocation for `rust_helper_blk_mq_free_request_internal`
appears in `rnull_mod.ko`. I didn't test it yet, but if
`__blk_mq_free_request` (or the helper) is not exported, I don't think
this would be possible?

BR Andreas

