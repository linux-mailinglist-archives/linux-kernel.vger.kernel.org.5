Return-Path: <linux-kernel+bounces-63657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8518532DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B01B212B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277A57893;
	Tue, 13 Feb 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SESKF8uF"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45B57868
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833983; cv=none; b=fyAaMUmCUVvIW4m3y+Yr3QbZ/Y0GclaXlqBCFdLu/q1es408adNNJNhTxyYbXHW5oajsSX43ZpzVALMIY7zwJQGBe4fKCKYeZMZdP849cF9u4c2OopyWFxZpbzqFBfDCqksMPWgZWzKzbT851u+VOU+GqmajzpreLVHp2doMugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833983; c=relaxed/simple;
	bh=+zhSIt0qtZV5RTWTlLFo90VHqHo8JuZcxOT8dUoT4Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4kvhdFMEYepRq0LwqWSSDGqYtE4ukaaeuYgpsWXZ42RWzzQxTwzH1JeDoxGnDib7PteAao8HnoGnoPBy9qdjKhuETvBlQyVQ1aHSN+65WQ0YIri9MRFGfsjfBZq2Ks4J+y21xfUJJj7BbvTPXfe3V4SwWYfO4stVw2AvCZuswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SESKF8uF; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ddf26eba3cso636773a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707833980; x=1708438780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zhSIt0qtZV5RTWTlLFo90VHqHo8JuZcxOT8dUoT4Nc=;
        b=SESKF8uFLIiTAqR9eB1wKmj6RbRRX8cZyvaYJZBQsZGHuGKtBxLKEBdZp/sh3+rW+r
         vFsxBkYtu7cezK9qwd7kHMDJzIr2Y6YmjKSfMKmaUOFYCgbXJxxnDUT7T9+hjXlGzVZH
         b/e8x/7gtZr8uJiZcYvQ1T0jMxaRb8LwXqA9RKDkvavXS0PLKxAPeaC6YPIVa1+zQ80t
         gFppsIWILNhU+TiBfCvF4MUp7SAgTacT/kTUdJo6qheeH0G8fpQI5ZIHSHYR+Bm1rmxk
         QGmp7LfbCR4Jd2YPCjhvmvoxKOP4O2JonWG59kzVQ9ye3RRyyHgcb4uPGtIbo4fXCmuo
         lVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833980; x=1708438780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zhSIt0qtZV5RTWTlLFo90VHqHo8JuZcxOT8dUoT4Nc=;
        b=QTbkX9TOd42TYpDRWLQObKFuIGgEVWpbZIEDGeKvH3sJqfrt25eG7gwuPp7PXm2Uot
         SwfsGXnmk89d1z0u7Azbo/p3LkBQ7eUm2gv1e9k9GCeWzDQxwECyPUt4QGmECcsw9Dl4
         bYr28mqy6VKJeqon8mfhUQLNL16qOxCvEDZSpxd+pdCsGDMFmYILULRfLzRgJ7FrCo8e
         b4FlH72l1i5tozEXN2cg8e6VWM2AqCxH9w8EWq8CvYoilEHfULYip0/BhmnAn6WhmAgV
         chfzDukyXyzZ6ojNFQyEsJjSNeX/0mPDGuDMr+tI4u+nrdnZS/E+BpAmyUt3t2hz+TBL
         RA0g==
X-Forwarded-Encrypted: i=1; AJvYcCWQAdIKdM/ZYxb1OjNHGp9uoHacae59toDeq6HLfH2MjKv3J1ZLTI2LAbsW5nEbYRwzY1DGbMRM1TVjkMzySr98UKL4epIrh02Iiv3j
X-Gm-Message-State: AOJu0YwN1jRuAKy6xUSO4UZpGjlFbz1jfrGdSDScO+HcN+xbc8Km14sa
	WIv7RXncX2J1MRCZJcXW7MIHDl2qSo4lfgzT2C28DipNka7fbWL0t4aZBmbRMgXjsh4HT6Wu97A
	U4liCMx2aeyNXlAnWlITjILXtttSZvd3xQpFd
X-Google-Smtp-Source: AGHT+IFGV2cuf05umKWyaF8qgM/iWKpcM28es4dunNmKzKHkKH1tyJ1+fkwaegZnOhlMpH/IXDxiY8tlEYEB5smmJVw=
X-Received: by 2002:a05:6870:8a20:b0:219:3d17:63a5 with SMTP id
 p32-20020a0568708a2000b002193d1763a5mr12034734oaq.13.1707833979998; Tue, 13
 Feb 2024 06:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130023843.11512-1-dakr@redhat.com>
In-Reply-To: <20240130023843.11512-1-dakr@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 13 Feb 2024 15:19:29 +0100
Message-ID: <CAH5fLgj-0Li7E4KGKV0e1-dF9x6TQXS6E_KyagY2ndQV8MSVnQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: str: add {make,to}_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 3:38=E2=80=AFAM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> Add functions to convert a CString to upper- / lowercase, either
> in-place or by creating a copy of the original CString.
>
> Naming followes the one from the Rust stdlib, where functions starting
> with 'to' create a copy and functions starting with 'make' perform an
> in-place conversion.
>
> This is required by the Nova project (GSP only Rust successor of
> Nouveau) to convert stringified enum values (representing different GPU
> chipsets) to strings in order to generate the corresponding firmware
> paths. See also [1].
>
> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/to=
pic/String.20manipulation.20in.20kernel.20Rust
>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Not a deal-breaker, but this comment of mine still applies:

https://lore.kernel.org/rust-for-linux/CAH5fLgiwRDcyaxbcUNY8M1c_w11vkCWyRfq=
VVrN9Sgc7XYT0xw@mail.gmail.com/

Alice

