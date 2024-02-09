Return-Path: <linux-kernel+bounces-59344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BC84F5A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEFA288AF8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53DE37706;
	Fri,  9 Feb 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdYFzyx1"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551B20311
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484216; cv=none; b=Ztqp31BaNTR3tAkYXQPEWVVsI+z6817XpuoskI0HG1b1G38gXtlCEeB/4VH4UXdxy1ZbipyVfuA1DPEZ0THaAo1q4r5zmLdKKV8tZ4T42bYEpbii2ugS8goxOT/BrmBxc+S/vCFAUirQqU13BHmjTdviKRbhOhBCEm6+2L2nk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484216; c=relaxed/simple;
	bh=RxLgmJtRrWkGZg+HZMG1tfMX6Q9WWD8CMQ/AGzP0BpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+mXuwNVqs2p3iEHi5OiJAeLCZpDO1DbAOTWpWZDYhyYSTGBx5udFDEBhmpWZCQBKbr3pbMjMbR50QXtj/mmHXLzOeyFxcIxUaGzSvUvht7O1jH+UjupGphnD0V6/v+LQ4SYJnc0a1LHjT4aa7RQINP6OKg6WW1byy2S6APZUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdYFzyx1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7810827e54eso54465985a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707484213; x=1708089013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxLgmJtRrWkGZg+HZMG1tfMX6Q9WWD8CMQ/AGzP0BpU=;
        b=TdYFzyx1zEzzE+4Gi/DLu6IWeSD2n1OwiyhzX+aGP57zQPZu2fg1tlRmEK0oVwSKZU
         f8ITh2wGap67kmVbjqm8xTc/G+zhseyNiUH8BXGonV0Vg2HGLt+tuokMa5sodsVlhS/Y
         G/vZDt1NFSNM6eIuS1vgOFlh9s2DseN0Y8f3vrFraiUluFemf8vdb8tGW1nYU7S/VEdK
         vrPr0lSMwgQeaJ9Y9fnRIgUeVrNi7CJ9rXvTJhUuMWxD6Ko2RQgCsWZS/rbXnI7E1n9L
         pagwsHqGxFFf0XKdzSvWH7I284TVwtPSxhrPAiPdy2xRLCswAZEzJL4IuWPh/z8eV9He
         ysew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484213; x=1708089013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxLgmJtRrWkGZg+HZMG1tfMX6Q9WWD8CMQ/AGzP0BpU=;
        b=rQYW4A8t//MAYaMvJ2+QteW1omeFoSw9C4Qk1HDCBYNmaHl1TwM+Afl+Zy9rTjqZrH
         +yMDV+2/FcXdB0GZny5BlpQWhz7Ktnb8Ab8C0wVKcwncpAI0baJY2htnMgYXb8DkqppA
         +hNHssU76/aZS3cxt9GfD0oP8+0ZEbLKD3mpeUQNBw0c8ubs/zq5HltKP8L4+akI2cdF
         7EiG5zhqD3zqs8Jhyv3owtfylx8pKzMInn4dPdNrnQeVsyi4cWDVz1tTBCqNbH+ipcs3
         kfEFr9orzR+jwfzSjlFjv1nCGpfbCHpWvpLuL3X+Sb6IYIFzYtzSeZc6DgU5RmI9Ce07
         gwew==
X-Forwarded-Encrypted: i=1; AJvYcCUAxaCLzY6731g+kIFof6d4z/BjTNKuUvu29fauSiMSc1dmlvK8JXpN59xifBlWXn6lfEMBa5AZtQn3PWNQh1j0wVOJ5SImmo9rYO2o
X-Gm-Message-State: AOJu0Yz6OcbhSqXhgA79vEfDR7mT7AispUSDhY0MjJVp7Pxu48caiQU9
	bdzme9Ps9gZWXEMFJN9VCfaAi4J/B1qcNovSmS4XK3I0bf3BLRP4A1Xc8R3GEb4RvMxMIUNNab8
	rjXOoz+E41DPV2TzWJ1GaHUuJQygi5JwWyDpW
X-Google-Smtp-Source: AGHT+IEyvqfyudXBQ2ZuDE+QHXEKaJ6wdDJ2v1ESP26Wuu+FSPcNAhIzZeCvrbqS9qCYxLosg8I33Ibesz6f1BnMJI8=
X-Received: by 2002:a0c:e247:0:b0:68c:cc45:7980 with SMTP id
 x7-20020a0ce247000000b0068ccc457980mr1485127qvl.26.1707484213563; Fri, 09 Feb
 2024 05:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com> <20240205-b4-rbtree-v1-1-995e3eee38c0@google.com>
In-Reply-To: <20240205-b4-rbtree-v1-1-995e3eee38c0@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Feb 2024 14:10:02 +0100
Message-ID: <CAH5fLgj1cat5m-_MACOjBi=eGqWcXCydThNtvOTFM38v9XmhVQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] rust: add `container_of!` macro
To: mattgilbride@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 4:50=E2=80=AFPM <mattgilbride@google.com> wrote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> This macro is used to obtain a pointer to an entire struct
> when given a pointer to a field in that struct.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>

