Return-Path: <linux-kernel+bounces-131465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F8898837
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA34282229
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1ED76041;
	Thu,  4 Apr 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nt2YeS8s"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF58535AC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234905; cv=none; b=N79SqClmEmG2CyXz/fR7HKmpLPaOAjojpAx103ejfcLD3uHEEJskaYmuOUuKb5fXBWDK/+F7Y3RWKgpC8jyGZMRbKnGTTB1qlBttOlA4UWOoBZkagIuX6W1Et/TbHyvfEEVCAewgk3yY3o25PEG++29kln1kYvaOO13c3QK+tIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234905; c=relaxed/simple;
	bh=zItQ9R1wNOgcne/I6ELOtf+zMzkgqghvssWfXc2Iz+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klGDIWjo7/S9Bo1/B7qDNsN2/YQWnRTwP1JXxVtir+xIl3gWNibYnbVUZrxPf+IE9PoGf6F8JGl7G04uvBdBAsYP06JM6GNRaSrluiBstN9fEbaw0qaP4ghVpzqfOlzsZiDfHvb1ZMqGXe8yggkr7Osqwxm1OhdWWsJH2B/owpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nt2YeS8s; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4affeacaff9so264747e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712234903; x=1712839703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zItQ9R1wNOgcne/I6ELOtf+zMzkgqghvssWfXc2Iz+U=;
        b=Nt2YeS8svF9pa3pij4M+cKgdBieIE0TkSB9iUNJN6f3N6kFOrtlfQuef+7/Lh+3aVk
         EG68LVA034OlGtTeFfS9ZP4NhF5lgw0i9kk/SzrHD7MNMRADksvbQBDJAkzhLt3qhh38
         3U7wN3KI/f5bschSFjwfMtfZ0UeX3tNU5aMn2IdFTDeMafpYG8S8hXB9e+hWTpxiMtud
         SpQ5aUTSBP9Adq2/eZZEEN7WO2zJkTf+Kp2JsRDnOvre29vlShxJ37gUUrv+BjnCF4j/
         9bC4v5BbeKkLiFcFnHyT7gHs1hCsKn8oEPFIMiJXi7PGS5r4tiNeIaszmBxn8m2QV95V
         FD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712234903; x=1712839703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zItQ9R1wNOgcne/I6ELOtf+zMzkgqghvssWfXc2Iz+U=;
        b=dl9OXmOx2plZDYrJYvOowgkwvB+vAD3tx5m+sWgfAEm8LuRBr09q1s472xsno1mwYa
         n+BQXCkj95k6EPrxS27Jne7rLewydxNdjVlwOLbmLrKu7zPbw6A6usk5VusGAwKgJCld
         5iAUpGfVsn82xHnP7eDslezWOB4OxLNJaoBaK2KUdnAby4VE4jPmfS0lYW00LWSmr0d4
         SyzhC6voceBmvuPFlsj/HXR3G2mNJjhaVGkBSXn3KherhlwJWUyZIHxmxJ1D3R/glqv2
         rV4b7te8Pl3C+kxlFo0aZXerd9Y4ts2W9KUq0EHSmCGHCgeSAM8Zztw5plXvDx3JTxOp
         GGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBTiEIyQdlR9/dC/0qn1fqUF43Rh0nHWagC1f01hxqnteclIrzazk7qvldx6stzo+bXfQzNepKsSBvGVVRlFrIgJ9mMQxCN0tB09DW
X-Gm-Message-State: AOJu0YxTMKuS/XgdiCTZ45tzkWymiY0fLtOxOTN0gvWkyryFozU2VmgU
	/gNSioo3uiWXeoP2/IeTW1jcZ8Us5BG11ajj4HONIluSy2lntBZ9eESmKfQMjRAslv1w3ESehVR
	PnSalx/nlqqj1NBO6UG9MJP7t+fXAP6FpDpwT
X-Google-Smtp-Source: AGHT+IG9ft1FtPMeFD96GHl8oofYlvkbNt1h330iUt53+y8NfQzSzV0qlbPA3CMXk86Qp94i19OxnBnQNmd1HGLMlK0=
X-Received: by 2002:a1f:f4c1:0:b0:4d4:e92:1a71 with SMTP id
 s184-20020a1ff4c1000000b004d40e921a71mr1942216vkh.11.1712234903114; Thu, 04
 Apr 2024 05:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328195457.225001-1-wedsonaf@gmail.com> <20240328195457.225001-5-wedsonaf@gmail.com>
In-Reply-To: <20240328195457.225001-5-wedsonaf@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 14:48:12 +0200
Message-ID: <CAH5fLggFu4f03-FcG37xzfVjUnibg56jOuDnNsdk6Bzs0UW0cQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] rust: introduce `InPlaceModule`
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>, 
	Valentin Obst <kernel@valentinobst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:55=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This allows modules to be initialised in-place in pinned memory, which
> enables the usage of pinned types (e.g., mutexes, spinlocks, driver
> registrations, etc.) in modules without any extra allocations.
>
> Drivers that don't need this may continue to implement `Module` without
> any changes.
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Tested-by: Valentin Obst <kernel@valentinobst.de>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

