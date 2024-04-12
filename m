Return-Path: <linux-kernel+bounces-142549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7D8A2D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7C01C21811
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD069537E6;
	Fri, 12 Apr 2024 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoNQuoLc"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FE52F68
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919887; cv=none; b=BZvPUqp2hAsXT2kGmz477KPDaFBziD0VPO8NJgjcQGG901KuINNNr+K2J58qIMeJnVQ578m53HqfwzqVcAhvTRUS6JtB8DhCi8v+t6lKXpq4eo1xCT3rQ+bItzGB/7O6Rh8Tw6ULssM2/kQP9357hhAsAuv3mq81k8lJLxdSJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919887; c=relaxed/simple;
	bh=sdwH1R9n4tNKxfvqvKIo+bgKKBZKjj5KhJXWUjV31DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3DDxkCmw/cBG45ua+ef2NzXyFTBhIsPI80Ahl9kg0ChF/4rgYkuFz/P03p0jfJTNtvO7cnygeujyCzg6Nvg/QvKANCptjRrQL3TX6KIP/9T02O5m7lpuFncbT6scUVZppVgW7FJf6OxEGfxXI6dcvp/5YglPQnK1gy0EJHNb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WoNQuoLc; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6181237230dso8846787b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712919885; x=1713524685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdwH1R9n4tNKxfvqvKIo+bgKKBZKjj5KhJXWUjV31DU=;
        b=WoNQuoLcw1INOvLBKDTdHnwqevn80l6x2PT2zPyB7cIab/BIEHlKSouSm3trbwcSdR
         onzZVEKyy9kNrgeDklbG4+/zXrNmeUvGEVXrwyN/cV2PZvD82/N4LtCbPjOVgXzh/qbO
         nkNcyUZzye29jlKMXwxz3WFWkwBHgwPbHz6q3H22IjWMhtC9smSrEJ89wPpJf5Mk86AG
         Zaf5ZYnbGOS3yEgGr0zedBmHXAomw8DvC3bZgtSjH+TVMj5gyUXLMSvrziUqvYoT+F64
         NIIPWwwTY156ctEVg651PQofJNc6ID4CGPpx/OHA6DEh9Io9YRX6np5JrVTlOUnrSke7
         eDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712919885; x=1713524685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdwH1R9n4tNKxfvqvKIo+bgKKBZKjj5KhJXWUjV31DU=;
        b=COxfyr8JKLi4eCJjJ5SHt6eEgNvWIfVTJQAyS7cDMoUMeamqZOLtdauXV21IEubFtd
         aQ7ELW69FKelnWK5BFQfeqTfOuWkzDGOxZHiqEhwZxWfLEulpkNLibGJ0FLGWJFxV8Hf
         P55inUP93un02ZGn6HWp3UUhfXauXkgM0idwscNk8VBO+PmfmhWTbTfTrAH6yjgqobgR
         D/KkuisCxi8MolIDlwxkt9FbMfrUgzW05H69pF5yV34fO30Di0qWIznSoiOszJrEEQxb
         s4xU0a81E5CJFJgvTpECGOMDiQZcjeoYPsy1cm9fpidFm4UMs6xENVtnHC3+GaW5P5Z1
         RzTA==
X-Forwarded-Encrypted: i=1; AJvYcCVDF3WvhRWb71XvUvte9U9c8iFUhxZAEOaxsZY0/MVDcP+o8wyZ+4StRvaQHVGFK0BkZFMNgGR4e/FDu5o/aQ01ao00LxCbh6vrKPFc
X-Gm-Message-State: AOJu0Ywx45QEUxyQTsBmlth61ndF8J6EKI/7r/1/y/73gOlBmee6iuyN
	vxE9m6KLlmKkLSzBFtGI+JiznBRenyBrnnTM0eX1EUMZ1o4vUdP/FHAGjTeI80GoMibkCgEOfST
	iLRv2YwWF4Mb0ZSeP+Q+SIBgUL8qjnB5qOy7o
X-Google-Smtp-Source: AGHT+IGNEjb8Y/6bEpVUOvMsUILJyavFotZHgP1bYU3MESMgRaLSsWfRA38Dfr2IgsmXW38UD1R5VJjCAcPO2VrO2Bo=
X-Received: by 2002:a81:ef0d:0:b0:611:22cb:2f40 with SMTP id
 o13-20020a81ef0d000000b0061122cb2f40mr2034797ywm.52.1712919884606; Fri, 12
 Apr 2024 04:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411230801.1504496-1-boqun.feng@gmail.com> <20240411230801.1504496-2-boqun.feng@gmail.com>
In-Reply-To: <20240411230801.1504496-2-boqun.feng@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 12 Apr 2024 13:04:32 +0200
Message-ID: <CAH5fLgg6w5rmQSwpO=jQoveAKOcJxWRwuw5edMu23hKmSYN_fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: time: doc: Add missing C header links
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:08=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> The definitions related to jiffies are at linux/jiffies.h, and the
> definitions related to ktime_t are at linux/ktime.h, since
> `kernel::time` provides the functionality dealing with jiffies and
> ktime_t, it makes sense to add links to them from Rust's time module.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

