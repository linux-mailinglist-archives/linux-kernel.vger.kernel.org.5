Return-Path: <linux-kernel+bounces-31107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FC783290E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFCD7B2329A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCEC4EB49;
	Fri, 19 Jan 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpDiNrMr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4024B47
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664535; cv=none; b=DxK2voi6ulCpaSK5zauEUEm8r4HWfRINvGoS/0WZoAAfzhDQ24EWi807TUL07XA9mOx00U4ZyDkskhb/c/GXkoSZ1z55qM/Sw5ehO1xwe4GCFudJycQ56zlzsgZDIrB4vqdzFFvcGL8i3C2oaxsM5AIKQYhbTxBs9khrGy93Ggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664535; c=relaxed/simple;
	bh=xMOqSLBIyM2IZsbfPaN7LMfLSmGeIVV9PAZhUsjiD/E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r6dUVjvuKLA+6hIJqdpjD2vXM8dswGVE1F/yL5pI7yf13amLMwDX2eKDbkiBPeQgc5LhTc2qpkut15WoMMfPYSG+t2/7U3dHhaL0Eh+lRbproOuQuHFKnm2nR+eU8PWYmUQlSh10yDjVUzFqm+47j19whBUJI6LPXmuVupOtXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpDiNrMr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705664533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xMOqSLBIyM2IZsbfPaN7LMfLSmGeIVV9PAZhUsjiD/E=;
	b=GpDiNrMrWZg1ckcksCafGLlK50N7s1QXPOsFUrAc1ZjG87TZdr/tLC/A1VsA3hca6BaZST
	O/3W/PYwu+xLRSMhULoXLE3bIhJL2jZEbrX1Aaf2trhk2e+bQ/u/zWd1HbdI7hB0FqOBhU
	sVS/e4B+fpHTZ7jIvFwrs8fsorrnBTo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-_vzKjl53P--Wj6cgTWjqYw-1; Fri, 19 Jan 2024 06:42:11 -0500
X-MC-Unique: _vzKjl53P--Wj6cgTWjqYw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2cd13187886so1945381fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705664529; x=1706269329;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMOqSLBIyM2IZsbfPaN7LMfLSmGeIVV9PAZhUsjiD/E=;
        b=SVPN/Go1KdxZCQLT8z9uZ3GvDEKnnJje+GwYs1tjEdilsl1689E5PXbEqccdS5FXuh
         3IuJM5snlOItP1mi76yjQ6+6j2H8htLsRngz6/23v2w+AFKHAsdd4B/zrM46/l1aE+vF
         AOfx1n0wkj5CummGbOWmVC6kWN+PTwvhWv5eCz9mGKhyTkPwgGkUs0eNqLgZuCsX61Hf
         oFvxe5tY34zHirHjV12dVjG+c+Rb3Kx0wnFdpmskDYn5zgzWGFVumkTkYr0A34BFy/zV
         XRBAzbpGdC6CkzyprN0kiqALtjv+AfKqi5nBKYX2TrTXM+pwL3EIEWVydmzY5U2vzixE
         EK/Q==
X-Gm-Message-State: AOJu0YyzN1E5UoBM1Z1mO2Td3izUiVaIdE88iE3ljeIQ4P12V6hmw5GO
	IDiOW3egveSLyQgGimH9SAgSCgmaOBNwphCyLqaPS57M7kOya+fhm3K7m2V1EB+k4pfGk2Q59yl
	9XV9gb8HzNn+msGLJ7viYVHUD3ocGO0xRsLaFMw+oT7ubzpaCW/+jZiRw7ehnew==
X-Received: by 2002:a2e:988f:0:b0:2cd:3731:9c5a with SMTP id b15-20020a2e988f000000b002cd37319c5amr1164531ljj.2.1705664529851;
        Fri, 19 Jan 2024 03:42:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvTGzEe5sslav7QIgyeBW3wqnWrYYzEtDSGVkjfflQdI2fiPPTNvOgQS3+BFd5R/O0T3/NJw==
X-Received: by 2002:a2e:988f:0:b0:2cd:3731:9c5a with SMTP id b15-20020a2e988f000000b002cd37319c5amr1164520ljj.2.1705664529496;
        Fri, 19 Jan 2024 03:42:09 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-180.dyn.eolo.it. [146.241.241.180])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d510f000000b00336aa190139sm6313332wrt.5.2024.01.19.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:42:09 -0800 (PST)
Message-ID: <e667aa499be7a1ebc1267d30f502275d36bf1f04.camel@redhat.com>
Subject: Re: [PATCH v2] net: stmmac: Wait a bit for the reset to take effect
From: Paolo Abeni <pabeni@redhat.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>
Date: Fri, 19 Jan 2024 12:42:07 +0100
In-Reply-To: <AS8P193MB1285C2DE6BCCDC8DD40E5A64E4702@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
References: 
	<AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
	 <f5ddf800df95cdce32637d41bc1539aed0a7b6f3.camel@redhat.com>
	 <AS8P193MB1285C2DE6BCCDC8DD40E5A64E4702@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-19 at 11:27 +0100, Bernd Edlinger wrote:
> On 1/16/24 13:22, Paolo Abeni wrote:
>=20
> > You need to include the relevant target tree into the subj prefix (in
> > this case 'net').
>=20
> Will do, but please clarify how exactly I need to change the subject line=
.

The prefix part should be alike: "[PATCH net v3]"

Cheers,

Paolo


