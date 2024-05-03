Return-Path: <linux-kernel+bounces-167590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548598BABA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B302845C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DAA1534E7;
	Fri,  3 May 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4cdNHva"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB6152DFB
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736114; cv=none; b=Lp6oqdXb7IA53JfwVzaZlZ7axaZdftX6dIkCPvcT+gIOth0WRIdVxOAWERRujTh/+oxoGolQBTvKAV8MotR6MUx8gLPBFP140ObWD1AmwpxW4lYT8UbalH+tn9yhY98xyc4lC42u7BwgCW9nMN2Rbk0/X5PgykYUnkYm+1Y8u2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736114; c=relaxed/simple;
	bh=Vy6tlTc++EeXxdDB7kgFB3QOL4xnaDzS0cwQuZ2VSG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFlfBnfBBD/9K73IDlAh1yAcFFOiTfQd5aY38+32MWxcEriJQjuRbgj+h43kjPcpOY9RkfDUOr/k4CI15IIiL065BkOvnyWW5XdiX9VcyDFma0BhrpwMP4qWQJ2YYAAIAas9tICwuHDzlmAnek404sMdcmhHYZClIXIhYI4lmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4cdNHva; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4affeacaff9so1929042e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714736112; x=1715340912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy6tlTc++EeXxdDB7kgFB3QOL4xnaDzS0cwQuZ2VSG8=;
        b=R4cdNHva5GHHamKwsequFquIU8TtCROMmZs0dMu/PdPI/npquslFC8nuYhIXkPFY5o
         rrBQVkYZkQxb5YquHWbhjtZ5fFVOsQcMu+N24KyvArzx8uhbwJC9PNOQNNGrUI7h2X2j
         FT5yPvJcq2kn7GmgR/11BUhH7oByBds/doceLincTJqzRab7aI0gNg6tkp2qpTBdmhcy
         589ru/HImritDdengeAad4mqFb9SsiyEOInnYqBqxQsA+35Lnkt45ISLEX86sm9WApJj
         6/wGJWczpQhzlfSYVGZFvB5S0NEfbxy7TT+r7Z6DG6MlreI7h5Xw0auJOay4chPvC1Bc
         naOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714736112; x=1715340912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vy6tlTc++EeXxdDB7kgFB3QOL4xnaDzS0cwQuZ2VSG8=;
        b=O2UYAcPA2SUbCxTFHJnAzjJvo5RBrlcf0yFgejywte1/xu+TfjTHihD504lhKIdKfV
         hO0bO7PUwyD1XrcZXBSWZsHHrq1kp4hXqDfwXHKIVVQNy/XN1Znm5ZIGOIiHUz2UXBkV
         BFYSrais7QxbU/xXnI/a02txssiBK9TKaZPtsxZP0VOMDlTj+XwTTnynS53idmRGhGoH
         IjHhGuvBQ0pfBo/4oKjmpw6K1dcCPfaZsTRYdzYvy8ZzeI1zEqe+ItYB8Z0WGJSZSvfk
         hBLoMuNMCS8cyosqKixlcK/Pvr2cdMfpxu8hVBmCTgz34plnX3RMO379nidPUCCH3JOb
         OKNg==
X-Forwarded-Encrypted: i=1; AJvYcCUxoEjTa2jREWl7ZgslKLOeYy4daqQFY5jW7Q+2cdP7mDY8aJN1KLZ1x+nxTzhcCpwBGrmPQWqtTVsVIN5Jyo3lrUCXo3Xbk3BpF5xj
X-Gm-Message-State: AOJu0Yy7fFeDi4FWQbeYIzm4lJt6wFDz0lLIJPMTdVPn0TW7CoaiETTJ
	vCV0TWjgpHNCoea19wjpeO2S64lloRkBclNZQRzx/8mtZDxQyXwnbymCUBlUvC29abS96dKmHm2
	by7cO4hj9RVVoBeag1RqHdF4QYwFXVjz8fO5N
X-Google-Smtp-Source: AGHT+IHJ5LLav1WoS1LCMCU5SIOeeC4JL8vo1qtUmeAbGsYQ5VrRHqnDzkVTZMJTzAdRJU0fbrCaR7G4XGw3/A7ZOLI=
X-Received: by 2002:a05:6122:2094:b0:4d8:75ca:8cbe with SMTP id
 i20-20020a056122209400b004d875ca8cbemr2446452vkd.16.1714736112253; Fri, 03
 May 2024 04:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425213419.3904105-1-benno.lossin@proton.me> <20240425213419.3904105-2-benno.lossin@proton.me>
In-Reply-To: <20240425213419.3904105-2-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 3 May 2024 13:34:59 +0200
Message-ID: <CAH5fLggj_MT=njdieD9BX_gV+4A02m0+zMyzPTJ9DR6hSkQhEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: init: add re-initialization functions
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 11:34=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> Sometimes it is necessary to split allocation and initialization into
> two steps. One such situation is when reusing existing allocations
> obtained via `Box::drop_contents`. See [1] for an example.
> In order to support this use case add `re_[pin_]init` functions to the
> pin-init API. These functions operate on already allocated smart
> pointers that contain `MaybeUninit<T>`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57ad=
3f5bc592@proton.me/ [1]

I'm not a big fan of the name. Perhaps we can use a name similar to
`Box::write`?

Alice

