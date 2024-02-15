Return-Path: <linux-kernel+bounces-67347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FFD856A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DCF1C21DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B0136981;
	Thu, 15 Feb 2024 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZw5XIyk"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A25136642;
	Thu, 15 Feb 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015983; cv=none; b=uIO7LPi82W5VFP+sHQns9NnHOR23khwFLs77cy28/MVSxyD/odSSbXBP82MTo9NrZ5dOvwGUnpwOH4F2cGku/NRrv6NDzBRVzg1aZ5tEwlz9g/z8CFscP3O2waLCrXkMKbcXYrk2bwjUFBBPTXxn8L0P/BDlGK7MgDbC8dzjSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015983; c=relaxed/simple;
	bh=3urhEffbny3eqMehm9nA/WWlSnq5YVWchMtHmZ8KO9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8LKT52SSEdnp4xTLSKUbNH4MExp1UwmewPJiOnOJ0dbxYHl2kKSLFE7FxLyr6QMrGc3tLZga8Bn5yLs8ysuw/IvN6q6cHolShFcNXxi59/NKGzkpYEVg+kAdKPL41lePCr8Xfj4BmjeyCcgwwvMmWPweUeelgPQfkl6UqKNNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZw5XIyk; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607e60d01b2so3235487b3.1;
        Thu, 15 Feb 2024 08:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708015981; x=1708620781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3urhEffbny3eqMehm9nA/WWlSnq5YVWchMtHmZ8KO9c=;
        b=ZZw5XIykAKFEXT2I5UYYmc5dkhtuAPDQK+abq+VHLz3jZKfXffwc5urp9U0xI9AvgM
         C0wlPjpsti9EkQ1n3mfpxPVhr28chhMHazi5aedVxA1Uvp8HdTT4V4wkv8hELKh4qboS
         75O01CdAoI15t89enlt80+vn3MzYEUxWidf3YMimxtyU1YDL7/vAKLpvjTSthDDQ48Q/
         sscGGoTHz1n8exOl52+qKe2OeJsyGlsvXsbpv9R+hJBxQQOVkCSiCBc6pZQ2rlP5tFNe
         5SSwbQol6xjVkOcIDqgE+gdzqvwFG9cTTN8jCff9ErFOc2m5jwEHI/8Adzvy4Lhm196s
         HXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015981; x=1708620781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3urhEffbny3eqMehm9nA/WWlSnq5YVWchMtHmZ8KO9c=;
        b=XDZ6hIWV8I+zuVBEJ7ZHlRZiW5FBxVTwsYs3jiFOmbzVnjYJ49Cki8x4HcfqH3gJne
         QI44P82szsKRXXJZWb9Y04508VxXNFFSKFRPsZTB1UaysGEMaXgMRhHZJ1DIwPZo4Q01
         UAWdPitHr+u9iUwm5HntH+x9aoEQs6g6iKdJp67hWh4uZbGf/LWF7zLaBZb9jsFFvgmm
         ebgzmOIbbj9rE8KWdVzInEXj+E2CFKr3Rl01dXHu5Fp+QaNfkPbQjRSm/UaVnRsAm5dB
         TpYbKIGoi023wVywcwwgtreUcKPfHRmNETH8HhclYwO6UGxgnzVzgKpCf6IPBpfgKEki
         5H2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMqXoSvOPtUuMNBagyNIY25YddB0KXkd/Rg6mv7Htmx3kxpi2Wxt9OcN8wZK/hdSkzSzPvsp8wmxU9gQERFwfdH/qGpMPA9XQBDq8qniNKFbfKmH/4OdPynud3MpusMCSh32bKKjAWgbI3SSU=
X-Gm-Message-State: AOJu0YwVHdDR4H7lrT5n7nSl+DkBRQ5Ux1WzXv0lnpP8nMzLAGouHD/s
	dXCZRAJBsUq/m6yrPKK6MymOJDZtMTtXTY7r053d1802AfunMhyPgrAvQ8oCQ6ZTRIpw1G6QrwE
	HOLf5ugEAdDs1uzI/X7/3FntQuirV35ZLK+A=
X-Google-Smtp-Source: AGHT+IGZoU0I6g032GfE3DGCx5tvFSzZ86o1eomPBrlDFGTbcCVUwTtXGhw/AytwPu1KUKaedi4kw48WtWiOF+MGhCA=
X-Received: by 2002:a81:451e:0:b0:607:e8eb:678b with SMTP id
 s30-20020a81451e000000b00607e8eb678bmr1001204ywa.28.1708015981050; Thu, 15
 Feb 2024 08:53:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com>
In-Reply-To: <20240212-rust-locks-get-mut-v2-1-5ccd34c2b70b@gmail.com>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Thu, 15 Feb 2024 13:52:53 -0300
Message-ID: <CANeycqpk14SVAH4=wU-sbDsEu1BQ7pbBtrt1pCuxm3yKdiwcmw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: locks: Add `get_mut` method to `Lock`
To: mathys35.gasnier@gmail.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 11:13, Mathys-Gasnier via B4 Relay
<devnull+mathys35.gasnier.gmail.com@kernel.org> wrote:
>
> From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
>
> Having a mutable reference guarantees that no other threads have
> access to the lock, so we can take advantage of that to grant callers
> access to the protected data without the the cost of acquiring and
> releasing the locks. Since the lifetime of the data is tied to the
> mutable reference, the borrow checker guarantees that the usage is safe.
>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>

Reviewed-by: Wedson Almeida Filho <walmeida@microsoft.com>

