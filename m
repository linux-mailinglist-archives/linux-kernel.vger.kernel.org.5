Return-Path: <linux-kernel+bounces-78520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7C986146F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DC61C20DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC72224E0;
	Fri, 23 Feb 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCPiZqGI"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6622329;
	Fri, 23 Feb 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699525; cv=none; b=lZUiI6A1yqBFqOaxWt7hRj9srJBV7wJiZwLglO9F03B30oaeF3tvFC/2IjPjdjAosaBmDCrnN3tsZTWtG6k+FWF5QSFPHJmZ0CYfnzK+YUzQUjQAMOomk8uNs6wJoA91OT7iz9/d+NtWXBaFP0wKE+1+rd0zET5NZGvy/HYnNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699525; c=relaxed/simple;
	bh=FYS368qujw0WANetUJ0YWVVEYUneG/dCxdwk6stMB3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljzmNRBwhWR9NY8L3h3ZqJvH7hkp4Bg1ArpdOf7CNY4ojcEHaJRMgPXG2PZ8LaoqBkai/WqaPp8A3FZOXDO8Jz6vJBvEPC1fulFsGiIZlM8mi1A3zbHG4VeCtf3NV/vzoRbpmDIDQbwOuX8X6XlKhUXDwpB1ZH9E50hl3ex0xTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCPiZqGI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc0e5b223eso7151005ad.1;
        Fri, 23 Feb 2024 06:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708699524; x=1709304324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYS368qujw0WANetUJ0YWVVEYUneG/dCxdwk6stMB3o=;
        b=aCPiZqGIS+AKK5+7Zad6rGgsXk+4VkEKBkDY/PKQGqIzFAnf5FTIfk7usvQ/6JBLZb
         YDdy3NYTNfaWiwooUxIyBacSdkId7POMChbaLxvKCny/VoVQrqA+W+mrvofzL2K8JrD+
         MG1zj81k/+4pNEgnp/um/l7+2VOz4yPMUbXGh3DF0ncugE6a3Jb9HB4S+90eKV0H3T1m
         f5HogaACDAU0+CWr28Eq4uHl6HEryvbipW0PavQbRI4RBPEezp6yH+tvoXnCb4B8MS9e
         B/zp5BRBAThQfYji3tvGQaeqEC1i5pLH816LXgHbDu8KeV5rn+87EpJDx1Q3hPX9N0J4
         pXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699524; x=1709304324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYS368qujw0WANetUJ0YWVVEYUneG/dCxdwk6stMB3o=;
        b=SpjAmB7gVLi0Y6Ubj9z3lPmumaTaO4rE7txSRUca7mrEWzJrHA69eKuk1YPGMj93Ai
         eb3FV4Q2xlrgKdYTgAXANL9PdGbVBya+6xit6gzzSbMz0wVl/OgTC5PktQX1X0RTDmVl
         8mKovSyGXZ6+zEQTrkAVwNq7LeUKSC08zXRrbk2lNrB7htoxd/lPKF7nAXi0inkjeug2
         Wtj4BYRgo1BP/4NYPHz8jP5Ub094AgcHsv2gStDFmji+736IIMmjEBdibjzyvIpFBxMI
         WEDaiLaoIBp2QYJdrwuVpRPqm+qrKAbtHTmWUw2jGHp7T7UR0qU/MO5qo0pKDdiTx/FF
         sTPA==
X-Forwarded-Encrypted: i=1; AJvYcCVYiA+a8BOgOS3zJuREVRO+Ma0pQLnhP9VhQVs688bvfBPqn+/Ec5eM0NcSAtGIHCKM/cQhv5AMScKhblfY9uKx6KpVwPNJyrCnHRcIOMhDpO0vomr5QutW2qYlNEws2n8mgXT49j1ykrbda4UdNx2VRoRTm7orqS2nHVpqdHB0EjMHLab3nLtX2hJ/bKFXSrvQiSQqVj6J5ou8HbEDt6Y=
X-Gm-Message-State: AOJu0Yz7OZh0s9Cm0X/qDHfcrw8nKAxB7atBS2FD2S0KsMDPuDH5ft0H
	H7pGpX+6q6WExfV2BPlR2n4apklhc5ms0q/VK2aqcV/fUbeWuSg37rNa8wQFzHgpsJCMaZ9+nss
	dOEeAggfDT5TQVN0tmAyd9nmi+gM=
X-Google-Smtp-Source: AGHT+IGQh4Gasx98EwmKbpWjx7oNjPOHi30hzceQIltFlR3Zv8xEu09Tzkr96XjYz57W4Vc5AnxGSufwQh5QIluHSa4=
X-Received: by 2002:a17:902:f811:b0:1d9:7095:7e3c with SMTP id
 ix17-20020a170902f81100b001d970957e3cmr1600961plb.57.1708699522325; Fri, 23
 Feb 2024 06:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-leverage-walmart-5424542cd8bd@spud> <20240223-perjury-preshow-fc2cf73d552e@spud>
In-Reply-To: <20240223-perjury-preshow-fc2cf73d552e@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Feb 2024 15:45:10 +0100
Message-ID: <CANiq72=mCnm0mKOw5K44PmZ+jF=67jxEEkcXP-E0O8CaUrps=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: make mutually exclusive with CFI_CLANG
To: Conor Dooley <conor@kernel.org>, Matthew Maurer <mmaurer@google.com>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Ramon de C Valle <rcvalle@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:38=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> configuring a kernel without symmetrical support for kfi.

Nit: typo.

> This probably needs to go to stable. The correct fixes tag for that I am
> not sure of however, but since CFI_CLANG predates RUST, I blamed the
> commit adding rust support.

Cc'ing Matthew et al. in case this is a problem for them, but I guess
we can relax it later as needed.

Cheers,
Miguel

