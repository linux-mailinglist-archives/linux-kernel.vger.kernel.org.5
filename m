Return-Path: <linux-kernel+bounces-90964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FC68707B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAC82814FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9327702;
	Mon,  4 Mar 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJHNJCZy"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B75BAFA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571197; cv=none; b=jOMi7AnWT0Zs1T2OvE1WwSMTHmkIVO3Cdt8/IIIv8X/fA1xsSd2KH8oN+pHmWIxsLd9SZBaw6amYhja+D1qOVvEEcZF+LXBihWNkEVe5a4NA0YiE6UGKE3d8Wt+Nc17c0Wa7QTZSN+WiUeqzdzE3YwtC26D/8jsQ5EozPBUYlQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571197; c=relaxed/simple;
	bh=uirtXHt2GRmTN/MJHpx0AE7MnBAQPCAKYbtW//3AYqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiGC0WfS/zb/rtuXtSUuwG65LexIopUgldEE+uksHfjd6+H/ZwpkTFhNC9enYwqeYL9yQgBgYeu0KIXh9ZrBtmRvROBwFZjZLEa+NCVwdOH3ubOzZkXTm4XGLJTEryx/1B41s+iO9rPfo7ZsVEBJ1YmoMqDbaaqWVPqEVzHqaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJHNJCZy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412e6bb2181so6001355e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709571194; x=1710175994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmfK1qwaZeZanYojHD0RUbXhDuCbIKpAYEoB7wzNyKE=;
        b=oJHNJCZydzgvwwg0pPpvODiubSxP83AXeOYfrOvYNRX1745RjAPD07MslMP/m9h9bf
         e3eDlVl9yBqdMb56ueaTtMcFXIm6+iauxnmcIbZSo70xHzjrHHcJZoBrHJNMJ/kForqH
         7TwD0b1oxFKSEclLU8+bJEcic3qG/iwr3vCfCVSwpde71J5EFyF/LwtqfR4/P8hqGyCo
         XGxokaKsOuEQ4FpVgFLgDw5Yj9THP2+COyHlHzt1l3i08sMq1+CSWRRxcUtsexcvjJtg
         LIcdGmRXl+GqZXv0Gmz6P1mDaryOOIdIRdRI7zWrREMx6cm6huCsUc7hQObUGD63hDXi
         t7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571194; x=1710175994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmfK1qwaZeZanYojHD0RUbXhDuCbIKpAYEoB7wzNyKE=;
        b=PAgMz7bP2ogDVGmsTLokqwXtyd6Z2GDJVJX+9c9LojxKvzMvDZJxa7njMDSctRTXjo
         hjgm80jQJgCkL2+omPznvatLgKP7hRCDcYedJ/8aQzj4tvI/Hw/S2siKnPAOkqk5FQFO
         +SkuCN8Ut0CdhfyhWZAVP/OJPU+3h3jQUP6N/TZXPXGDdoEByX4H1ynowXHS28vEEP1S
         vb20Low6uc+Y3Apj5lhHDLBipe//Bo4vZZldxKgE8kusORee3mMZ3rWvrABUms2EsiHX
         r2Zv8/OeQvfh0o4GBkxU8JoRPyiu3YJBzB4BN/iDJBVtWbidceKEKZlz4HSio2KkMAWt
         NWFg==
X-Forwarded-Encrypted: i=1; AJvYcCUd83Jz96e4REh4LIoAXhgYoVMDYvrjHvye+dXx2nm9OgdPFoWHzDOWXLTgP5oWExZZCrYSUNO0wCPLhuaSVPnbj/F3nzLwQ7kiuQrK
X-Gm-Message-State: AOJu0YxXwYuuhVe5Wrr0gbUuqmCZQjajeWIRyfD13tKjmbtZT2jN0TQ8
	jgGWV2O1s+3tObovZpnIScpLEeqfbPjW89+21HH3OjlSsx1bd3bJvtRQeTw1Aij8Ocd6eD1+pYf
	guFdg85l6GoEwGXN4+xDgslxkdMaNzrf4QYBK
X-Google-Smtp-Source: AGHT+IHO0Vyyj9NTmtrzCpdzXYPsNb82jFuB6Tek6U/mE6kJNdZ0Szp7dN5s8m6Is2RH0XDeJ4uHDoLAJmI7qfo9wFU=
X-Received: by 2002:adf:a441:0:b0:33e:4524:e473 with SMTP id
 e1-20020adfa441000000b0033e4524e473mr993953wra.50.1709571194160; Mon, 04 Mar
 2024 08:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301044428.work.411-kees@kernel.org>
In-Reply-To: <20240301044428.work.411-kees@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 4 Mar 2024 08:52:58 -0800
Message-ID: <CAKwvOdkzQCSM1+Z1mRphgu3Vs8SdiDpgxywWiO_OHn+S_Z6UwA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Explain how __is_constexpr() works
To: Kees Cook <keescook@chromium.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 8:44=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> The __is_constexpr() macro is dark magic. Shed some light on it with
> a comment to explain how and why it works.
>
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Is Documentation/kernel-hacking/hacking.rst perhaps a more appropriate
place for this block of text?  Perhaps as another :c:macro: in that
file?

You know I'm not a big fan of increasing header size, even if it is
just a comment.
--=20
Thanks,
~Nick Desaulniers

