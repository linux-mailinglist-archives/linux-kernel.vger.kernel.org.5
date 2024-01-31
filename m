Return-Path: <linux-kernel+bounces-47191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74954844A53
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126A81F28494
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121639FC6;
	Wed, 31 Jan 2024 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="iYPqex+0"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32A39AD5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737544; cv=none; b=BHSHO1tzFGyqM36UBw7GadkKlZ73fHZmtLgyR3MU1gRF868jGOtjgCbcewwd5O0h+XQxogElErV9TOIHXlsdAon1+s93c1ApQojhoedzLVXa3ODJGgOdeuQIKduhd+1qq10a+RPegLRy5fjJs8unZYP7Qa94zCbzUafXzweDk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737544; c=relaxed/simple;
	bh=MqYdbGGmYJ/TG7dOij6KwrLaPnSRe6KEms8E935jiYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJqDriJi9Y5ewTYp+iymE2tsVG5LOTq1zeIf5jnxUls1Jn1Wnx5xAVJSPZOHYUerE4tK5wEU0GuRZh0c3C28a33IYKkCLhEUnpwovQVzJ8tukiXbn0BTl4RpB+agoF28jds6TWCbYi6YsiLaWFqaEdLh5d3D0nuuGHBQXvW/xcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=iYPqex+0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60412866c36so2688027b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706737540; x=1707342340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqYdbGGmYJ/TG7dOij6KwrLaPnSRe6KEms8E935jiYo=;
        b=iYPqex+0UmZL3uWxVTtKyRzFL3qe/uVJkNiyBCzPa4N+U5kt3J1WYOUXQAMxw7LuKy
         2xBc7yhO5XNmlUYglCYL3EsPSrichqEqCfJVofVt73eR0lTggZRSvKj1MI6qrXaWlQAw
         /oOtTSiHxiuXkK1KkOSwIDKHEWePCEZZ3eIxeDx5XRlnSwMqEJ83/ubDCs1iHSmRh6ic
         w5X5aQu0u/WTV55j6LyqjNxN7qSIg5h0DqzVVke90ZEAe8yhicijv4ylOJMszOAOWXBk
         79RJSzmZlQsjvI8AYk5LO6aule9WkB+fJ2kMm3zlaJyL1PPMHSxDceqmpvOZolruijqI
         lpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706737540; x=1707342340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqYdbGGmYJ/TG7dOij6KwrLaPnSRe6KEms8E935jiYo=;
        b=SS10krStNqMBPe2UFTH01FtkfXLkSpQUyCB5g9G+4H8orWlLSuEgdgHC4mT+/5EkU3
         bQ9LbteY9IXcZdc+y7d3s4YaRmogzlSx1Q43ZrpOMoEDzTcMxDw4O/zwSVCekyB2G7Fi
         nDfoGJM7DEH0mjeUrfYgUwPIdvaE7tnWcfKOse1nGkqwdFD01ZHNWKQOfEyXErzpIlqo
         v+aLstxxUEVyUqilVVjQzHzI6bXqPqh8TW7NgDcmUMYcYOqwVkqQXOoVlv20OAfwlzxE
         6nwfeUc2KOPiwFz9A/c4jBLllrWs6ue9MOf4b8Op+MKUcDnYE0inFE2+eaulQ3KV8vJ2
         bHKA==
X-Gm-Message-State: AOJu0Yz+Q5pSr9j8YuKgCDBsOI3FwJ6YV2M5tXf/BF7pSJ6aBEHUjZZq
	rFZ6Kinz2BJspNJSPhfCZ2t9bKp9RlkH9wXyA8rUp+d0NTzZ5761UkSyM7OHDwGelqwqZJu6YaF
	9kwTWgfQrGM/Ez92X7VGRT9m+tVpTaE0Z0F6/aw==
X-Google-Smtp-Source: AGHT+IEeSoqGaEV2K7YR4U1cMnEbUZUOwrtGLVPajPIxKhYWweVq83gKpZgUuwZuna/wBZDMlGALXxu1jlOIUlw6pFw=
X-Received: by 2002:a05:690c:711:b0:5ff:9319:840e with SMTP id
 bs17-20020a05690c071100b005ff9319840emr2868836ywb.31.1706737540509; Wed, 31
 Jan 2024 13:45:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129145837.1419880-1-aliceryhl@google.com>
In-Reply-To: <20240129145837.1419880-1-aliceryhl@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 31 Jan 2024 16:45:29 -0500
Message-ID: <CALNs47vihohNCzDuB8d0G1Y3EF1HUipMrL186DtrMRu41Rrr0A@mail.gmail.com>
Subject: Re: [PATCH v1] rust: add reexports for macros
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 9:58=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Currently, all macros are reexported with #[macro_export] only, which
> means that to access `new_work!` from the workqueue, you need to import
> it from the path `kernel::new_work` instead of importing it from the
> workqueue module like all other items in the workqueue. By adding
> reexports of the macros, it becomes possible to import the macros from
> the correct modules.
>
> It's still possible to import the macros from the root, but I don't
> think we can do anything about that.
>
> There is no functional change. This is merely a code cleanliness
> improvement.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Trevor Gross <tmgross@umich.edu>

