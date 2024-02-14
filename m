Return-Path: <linux-kernel+bounces-65031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC08546EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1851C2472E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD353171C8;
	Wed, 14 Feb 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="q7qYGDaS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xNFThNoj"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6F168C4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905774; cv=none; b=VjAgQBNYTvwAExcGgNkm2w5COIpFJDWrsugC0Rd/OrEvtn+kt60SSYfUnFb3cMWUfVKMzpsD/7vD/sz0GCErSreD1aLVLAT+LFXRCFRuAnYVO1U9IZUCRogAgTec3yL5CRtIozcTQcw7rK/mHzrJgCFoIawfZ7Ee/vE4XWLNgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905774; c=relaxed/simple;
	bh=zuwCehDqvPwNY2pDhqnDiDPpipznxqF/iKxY8Zmzma0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ItsjNHL02VuAyHB5dkML6zHxqt1Y9yPvwO60uvPYmwjX2fM0viu7hl07ykhJqxN7cRVoaWZPPY7J6oJW0wxrRU5xpaw7imQT0PlijzCMyHqPAkFlCoZ2xMle8dOTk7TflQSJaeyZgDnTLZ2EwgoCFhbAJKPTxXFmIeyy9+UMizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=q7qYGDaS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xNFThNoj; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 250803200312;
	Wed, 14 Feb 2024 05:16:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 05:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707905770;
	 x=1707992170; bh=i+j6Jypgho7pg7a8tVM8hLo4QkNUJm6rujup4OU8wt8=; b=
	q7qYGDaSQIL13G2UWfKe/bnaIKMvPv7sZvyFCa2+HU8q3mTQm5ywQkD75xustvuk
	vj7mg62gWUK3s3dZSb8Wy/V9T6EzHgIn/CZGFOf98dKl6bkCCF9RxCKyQdrUkFS0
	bYB7CFU9b566Q+7oJrPrudAmDTjoI9lvK9dRROKKjFF5fEOd/RFjbYFKAPF6PzVA
	MuhSbLlW4BSTssVju7Rv1fh8OV4EvrBq5yWLAMS9QEw3HEsDxEobGjTT1YdpCswQ
	ohWp+vp4L4VzdLkX4XPqow1tIkWfCSKOa6JRXaVZHWH5EqKFMC1MKbxAp+1tWfD/
	DPZZ5Qs0mbANFRR9ZK8YOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707905770; x=
	1707992170; bh=i+j6Jypgho7pg7a8tVM8hLo4QkNUJm6rujup4OU8wt8=; b=x
	NFThNojJ94AUpEjn1VHcxswHwW6hV/AiIw/M+dxGlsU7yMY8ZA2SsA4pvLpGeNeE
	OHgYL+UvPCIeBaqD+P++1XYi81I/4XUVIQKyYLur4aZUkevlsnFUlVZHhUPcLqP2
	j3TaDe6o8+hpqLNN+Z07WVTrXDiS+I4dfUMMVpBEhc8087mJYjjF3Ju4xIUZ7po2
	2xcH537IcYk9HhGlmBrvsRsKUTILOSiILaVEwOJB+UneEsm4i6hM4IVxHP82OXfC
	7J3Z+NyERO0VgGpuO3KbBCjLa72pTX9y5xjt2iaUeBLJGdS51O+fz8jsD0CwDw4V
	l6xYZ9DlxnMhuQw3WmQsg==
X-ME-Sender: <xms:6pLMZYWNDVpEMfd0S9wsVkKgH2TDKlOgYqEwFWbJWSrlKZPU1DJRKg>
    <xme:6pLMZcnbfJmUSfXRUU526QU3H1zdwS5QGPVMK1rWiivEh2gpX6p2j0ibwYbtDvo2t
    jzeRc5zwcQ8GT9a_IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6pLMZcaCTGqkNgNoJTFQK_2yTqt-dBHQjCconBo1SL4oLVosX6O3qw>
    <xmx:6pLMZXX-fIcWAouiYFYXGvg7VxaCLLRuNHBBmKnBiX8-jgm2RFpfvw>
    <xmx:6pLMZSk69UKXLbjcfv9U0k5KRm4NauJhiujkWh7AZzUlKONAHI8q3g>
    <xmx:6pLMZekZXsGTOLO-XTW0N4LQCVsL9s7UMhsJoEks9hgusY-2TB1k5Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 49E4FB6008D; Wed, 14 Feb 2024 05:16:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <42be4820-1e19-4782-b412-0b0269f7a696@app.fastmail.com>
In-Reply-To: <f0b2b4dda91ef1342fc38540bf3d453366b943e9.camel@linux.intel.com>
References: <20240213095719.454865-1-arnd@kernel.org>
 <f0b2b4dda91ef1342fc38540bf3d453366b943e9.camel@linux.intel.com>
Date: Wed, 14 Feb 2024 11:15:50 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Oded Gabbay" <ogabbay@kernel.org>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>,
 "Daniel Vetter" <daniel@ffwll.ch>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm/xe: avoid function cast warnings
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024, at 11:10, Thomas Hellstr=C3=B6m wrote:
> On Tue, 2024-02-13 at 10:56 +0100, Arnd Bergmann wrote:
>> =C2=A0
>> +static void xe_range_fence_free(struct xe_range_fence * rfence)
>
> There's a checkpatch.pl style error above: s/* rfence/*rfence/. I can
> fix that up when pushing if it's ok with you.

Right, I saw the report. Please fix it up then so I don't have
to resubmit. Thanks,

    Arnd

