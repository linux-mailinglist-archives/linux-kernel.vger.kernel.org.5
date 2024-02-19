Return-Path: <linux-kernel+bounces-70963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDBC859EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19781F21BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227A2224DC;
	Mon, 19 Feb 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sAXlnjDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beP9XFMG"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A12208D9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332514; cv=none; b=kX2t7z0Y2yKMOCqC7nM0H9J3C3aSt3Gs9Dqp49NIGbaUC6BkDtGJh6jWWsrBdeebTp3ne4NSUIGZ9Cyb4dmeguH+P96s93q9YyW7pmJmD2hcuNyLu/42R/S3Km68B3TO1THnHs6ygi9Emar0YK2jWTiXdq9HnhQy+u7uokSoiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332514; c=relaxed/simple;
	bh=p4I06lA9wVVMv5yTt2paC/EqCeqXEZaW9MNwJqmyyx4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gyK2mfVk6VoCc+LBBKB22YDqNey+ig3gdZHIfmLPSSuUBX3WrZmUCfpHpPzdgo/gkdmnvFH2/QkO8Eau6B73x/i8i6JX56PF12YskRdrCJI6qMiSc4vzIzM2s+xiz76WO0gfXoEd7v1xrdu7oXnkAhPFkyZT4ZQC/07x8XP3vVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sAXlnjDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beP9XFMG; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3F9B911400B1;
	Mon, 19 Feb 2024 03:48:31 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 19 Feb 2024 03:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708332511; x=1708418911; bh=YvDMJfF8Qd
	KU7dqT4c/sdORKmS8pZbitmc0tJv3FxpA=; b=sAXlnjDM7IApbIlebkjSLsvupR
	kI4Wia8yzJpl2qT+SPkgxeDnbfRqMzmwlyKteczek2/9mmb3gvwMaGbhLTD0rgoA
	jFxYdKsGTlPLvFMNlAIZoyS3Ab0O2mCut6H9aIsidMFNkCSFLYMarJMnvQEqAfyl
	o1UFb0ZRF6eqej//SzuDBv5L8epVIN6cWkFlS/wgIDS5t62SfK3u07oQvB65ebew
	QxKIh48/Rsm8JnJsjBWFg+ELEcm7ppbw4h2wbpjwvhD/80+y+YC3S5yru3DsbR36
	QLBv+qfM3IB7LddJx8m0ZC9NHG4vGaAYeYwSmrXrWN0Vc+o5Bi7+2qql1dUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708332511; x=1708418911; bh=YvDMJfF8QdKU7dqT4c/sdORKmS8p
	Zbitmc0tJv3FxpA=; b=beP9XFMGVNabutxw0Mse/IbLRvktRlsQd6GBaF1M8Mhc
	TPePzdcrR9bwKydJ94cDi6gLn7NAvcOlNe3C6rbwhEOxK6wRNe2966woPsOqMIzy
	cPuv7rkrIbgPUeimuGhA/NAhgIXmqjw8XrlT/a1JVhS5Sv36XSuJVXAuEQzvBtsc
	F3eExs+5s+M+5UiGjZX22tC2ysQ8MSE1Zjxuduz4Ra+kMy7e1S+SXuotv4WW2Ick
	65k41aJhKp5lmKLS6AGfNUOuomdxm/6mpIDdAhqxLVYsiuyNVkwhZ0fmvIIUkkci
	RP1+1Pw51KHZpaWbBnFVGUyo49PkTI2Fb4AXwoj4LQ==
X-ME-Sender: <xms:3hXTZbEoOMmgVgDn20se08qvd-5lUOgzPhkM7D3656_FuapcNIdg5Q>
    <xme:3hXTZYV1mmoSQVdvKyKuhfRjTJvaKDHKbTZKdfsroiJgPQiUtOM4n0EOtjGk0Lb1f
    24k5l63034e1dsv3_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3hXTZdLfVc2mLWC1N8dvxo2R4mTlSoVgiWH_DFAKMOIxwZp4XJBtbw>
    <xmx:3hXTZZFkIkuA5MFj6f71ZO67cLwRMyosiD1pFtq3t99Ew_aeBGvdXw>
    <xmx:3hXTZRXc7pNaUa_yBJwM6DjEtvVQujNMNvWrQaE0mAcmZI7nWSGeXw>
    <xmx:3xXTZcOYTYiUxrIt_NAbLkhdVW6ATdYufZYI9307pOYk9YiEsXT_6A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 73BB3B6008D; Mon, 19 Feb 2024 03:48:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c083c1af-31ef-43a8-ba2d-98d63dfe45e0@app.fastmail.com>
In-Reply-To: <20240219084610.11007-1-brgl@bgdev.pl>
References: <20240219084610.11007-1-brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 09:48:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Bjorn Andersson" <quic_bjorande@quicinc.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] arm64: defconfig: build ath12k as a module
Content-Type: text/plain

On Mon, Feb 19, 2024, at 09:46, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part of
> their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
> defconfig.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume that Bjorn will pick this up through the qualcomm
tree.

     Arnd

