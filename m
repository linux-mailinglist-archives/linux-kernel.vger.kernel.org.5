Return-Path: <linux-kernel+bounces-69277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED88B858685
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA6B1C210B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6EC1384AC;
	Fri, 16 Feb 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jkSpXLYq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TrL3BRZn"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C434812FF60;
	Fri, 16 Feb 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114310; cv=none; b=OzZAjgu2gdgBPJckDQXU7U1WEkbSWk6s0acwPn4ZqWNAhMMo+B+ew8GJpvC8sDcMF6OB+yknh/MqrWatN6axHwqt/44NfIzRZCepZD7xMkyxh7SnwxEF7tq/5xwrtpkxU44c8naD3i/ptvzBqPGwL/P316fSiEsuIOQoE+eqBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114310; c=relaxed/simple;
	bh=sKjVKjm0Cju6dR30zSwBvIMmz/AyJkt9fOrMTl3BxbQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QWXHGgMuUzYZ0Nj3n4jxJUL32Z32CyHctqlQSJSSJGeyYqGp/raCwbOJGUoT5I36/sfPIbHBOUtglD/z83Hz9awUROJzATxa2zWLJmICJWG+8xPWwD6SaiWXtQto2wC9ve/AHtcOBQ1tzHPGnJ7h0nsZ4hR+A66Sqj2RfG+PBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jkSpXLYq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TrL3BRZn; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id CB4BF5C0052;
	Fri, 16 Feb 2024 15:11:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 16 Feb 2024 15:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708114306;
	 x=1708200706; bh=28ebHOOZ0gHWDewFw4LLJRaTSJuyD5ugj7D+HBTHzXc=; b=
	jkSpXLYqI0AILE08dSPABHejGUHz+VRLdYvX1/IRf/tWJvsds+S09r2GEOJxo5MR
	oydiPHiuBEkLX9kxGfRbe8BSUMJ5eeU+skRURq6OHMTkH0LhxlbKXL22Z24infiM
	7G0Namf4UK0PEYz1vmeBWtiKw0ntO7qHGB6h8N6nEcYIA1J2Y8wCzxrX6N3miEUL
	fULshplfylTmsJ2tygqkg62GHLLl97qGHgjt0D782v8WCXVlGSECXdDqvc0GOuAb
	KeI34ifnNvik7IGb9Muj3p39qQokKyjcsBxvS1P7cdCBrnmMhQRS0OtjXisFgYqt
	W+iUROXU+7QPNfQlcNiZLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708114306; x=
	1708200706; bh=28ebHOOZ0gHWDewFw4LLJRaTSJuyD5ugj7D+HBTHzXc=; b=T
	rL3BRZnZhqGUYTc6wkWWVvaAsWUuD6LiU1laMwS6cHWPQIruE72nVds9KBDhsdnT
	lnr/MK4GaveT8hNRadrzkese4vCDem0YVEXNI8mEDegIObPlHuz/Dex58Ob1GTok
	VAn/RAB3z+pqry6wTbj0+0G/XRiQxzzv5oX/V0EVnw3UD5IMwhsc38JprwxqWfig
	V3PGZMMtjukqaYojKZSD2GwN1QkJ/1hpwUylCumevJLbIZUbB2JtTrObZbiYmSUs
	6O/pC2RJMudi9o4C93NhOi/K/H96YDKwQmBqq1dadtFVElEUqXpackylMtp7zh6y
	TE41DFLmMPdDLAQlsXw4A==
X-ME-Sender: <xms:gsHPZSE_CRG9p-__m-hFXPj44AOxV_BY_i5s_FAgPsoXvO99RwYidw>
    <xme:gsHPZTWjCag_fKn31XIEglB-m4_sDpBub46ZmFXGflhCZdhUxgsdeibr_4UGD7vSm
    RjLar9noCOlU_GMgPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:gsHPZcJz-JbNtrfu_gTQQ0YYCxHS2Nuytqe1M4ahLbtGhNb54Peoyw>
    <xmx:gsHPZcEBhbfUB5jFJPwgRV5ay8QH3o5t-e6LFZC7SVxL3F3CRIx9WA>
    <xmx:gsHPZYXpZNvZq26-e2o1zB8fDD5VZbTRNBNPvU5-9CXt-0QI7dy3OA>
    <xmx:gsHPZRPnHL8cPwoF7XA-s6AiQW1NtsNNTogO1W5erVDiNY4pUXlwVA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 61DA3B6008D; Fri, 16 Feb 2024 15:11:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <025f63f5-9114-439b-ad49-c37dffd1ea2f@app.fastmail.com>
In-Reply-To: 
 <CAFhGd8qmR+EPVUDt0DVttxm3aBQpdL2i4XbFZ3_ko6Li=mVH3A@mail.gmail.com>
References: <20240216163201.1901744-1-arnd@kernel.org>
 <CAFhGd8qmR+EPVUDt0DVttxm3aBQpdL2i4XbFZ3_ko6Li=mVH3A@mail.gmail.com>
Date: Fri, 16 Feb 2024 21:11:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Justin Stitt" <justinstitt@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
 "laurent.pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Mark Brown" <broonie@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] media: dvb-frontends: avoid stack overflow warnings with clang
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024, at 19:56, Justin Stitt wrote:
> On Fri, Feb 16, 2024 at 8:32=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>> -
>> -       buf[0] =3D MSB(reg);
>> -       buf[1] =3D LSB(reg);
>> -       memcpy(buf + 2, data, len);
>
> I'm curious why a copy was made at all.
>
> Reviewed-by: Justin Stitt <justinstitt@google.com>

I guess the idea was to allow writing arbitrarily long
contents to a single register with a single decriptor.

The current version of the driver only ever writes a single
byte value, but maybe it either used to have other writes,
or it was meant to support them later but never did.

      Arnd

