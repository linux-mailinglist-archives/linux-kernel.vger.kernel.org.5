Return-Path: <linux-kernel+bounces-63114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB998852B16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE621F2336B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF001BDE5;
	Tue, 13 Feb 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gjAfXrtP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XHSTsDEw"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA918021
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812810; cv=none; b=S8u8wiDoVKr+FgbCBjgoaUoTU24NaYqeWzKwltwQDiDCq7IR7uwCWISEpfHJVaKGRgSX3WYaMD/mo+oevuuLni51WQprpmiQUOZ08j40HAOIru2kRkG8Ujsh1Y7PvYgwmVKMrDOMVD5pfYyTlb/EsZMzbVNmK25mCzNZ3Jt5eQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812810; c=relaxed/simple;
	bh=0Zdnug2OdbGP1tbcQWKLArv2EpaIXtZ0vKUzVYNwEcg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Uk+JdaEkMy/DUEiRjrXNj2o6ih36fxF6M4LoUTS1Ta3DJIDOsG2VJhcTdu2dvomzKCBcZnw62Uacclvyyv4VWdPpaAeIPV7o01CookDU2+3LHmHt6MSaBht/4l8veDv969kIMQnJHEirzqVhE3oQc0QwJ9pzXwhDtjxe01XaTp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gjAfXrtP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XHSTsDEw; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id EEB021800089;
	Tue, 13 Feb 2024 03:26:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 03:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707812806; x=1707899206; bh=0Zdnug2Odb
	GP1tbcQWKLArv2EpaIXtZ0vKUzVYNwEcg=; b=gjAfXrtPBps6HEbUN6VSbD/lyp
	IOK+/zQhE1/cUz+/w2YjAfPxxLzdhA1WeBsQK0NRN8Tn17KxnXCzDKYY7R48Ahjh
	Zcaidzp2JfPlF5XUU0vBTTnV+iEegFumR1+uv/vN3D4hGG0RrgGHHM2gADAkK0A0
	zoNCL/Bhh6SMMWvjBBj7vml+TNBuFa1vnxehdZDd5mMk5SjN+btEbZtQbT1HLPs4
	iEirkFtwqwdS6OEyDHgNzxJU1Kr1wuTKdTcia4nIUWjR65y0wuRCSfHz6ycHz26t
	gDK3YfQK9p/+mre9FwS8e2u/s0ZsAhvNxGB5CZdq8M0YQbzDOpHSNfQBEbuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707812806; x=1707899206; bh=0Zdnug2OdbGP1tbcQWKLArv2EpaI
	XtZ0vKUzVYNwEcg=; b=XHSTsDEweTmJB9N/bXla1LU8VkKlmj2wZjMKNPESVch6
	UY+bn+HiRf7g53HyqgnjDN/vR1zZgr/jdrAWZYsp434i7M4DBWP+GE47RYhzTM0b
	+VBYniy5A65dN783blRBxfbxQXaXMSBnbVKk/qaDy7kyViGU5ShGcSceLBkkip8j
	iMIFSqrfBHxlEyt6/fix8g6+Qnh0kMDtxTcxZ+6YWvReGh2ngu4pRuyMsL9WSHQB
	2zVVxYgDIV65xarXJJe5ZaWoGzU8EkOB0PH2jQRp4DucboDxLAWE3ViFK8cJvNQZ
	GFHPndxnqA5p/e7BuYlYHAwWfFWlWMw52ThxsfJfQw==
X-ME-Sender: <xms:xSfLZYdPKNHaJAbEPFTxzh-PqDR8RIOHpRfFv1vad1ImGSPj_d5-4g>
    <xme:xSfLZaNCB_DDOG9zV2ZNDCsH_HtiPjHwfyLbYDBOvx4UYfvYc8z1vSGtIiKJ4zsPd
    LtlBEVpZZVGCzx5rvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeggdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xSfLZZgpmng1wkYIPYImGEILc8rRa1qTQ68CchKswb7k1wOKN61s8Q>
    <xmx:xSfLZd-xBUijdetbvXsEF2sOVCvvQ6y7nGHdyV5fNgcBdu1qVbKf4A>
    <xmx:xSfLZUvaEmBj5hSGFvAp46ZTE9TrwNpliiLEAsHEt255dHe8kYhT0Q>
    <xmx:xifLZZ-7okTwJ7x1OiOgo4T8yyUOq5RyR_8q1rpbLjDTo67-gbQG7iny2nQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9250EB6008D; Tue, 13 Feb 2024 03:26:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <56d3622f-4188-47e9-86ec-6870aa93a9d9@app.fastmail.com>
In-Reply-To: <20240213060028.9744-1-rdunlap@infradead.org>
References: <20240213060028.9744-1-rdunlap@infradead.org>
Date: Tue, 13 Feb 2024 09:26:24 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Randy Dunlap" <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: "MyungJoo Ham" <myungjoo.ham@samsung.com>,
 "Chanwoo Choi" <cw00.choi@samsung.com>, "Marc Zyngier" <maz@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Peter Rosin" <peda@axentia.se>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] extcon: max8997: select IRQ_DOMAIN instead of depending on it
Content-Type: text/plain

On Tue, Feb 13, 2024, at 07:00, Randy Dunlap wrote:
> IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
> it directly thru "make *config", so drivers should select it instead
> of depending on it if they need it.
> Relying on it being set for a dependency is risky.
>
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
>
> Therefore, change EXTCON_MAX8997's use of "depends on" for
> IRQ_DOMAIN to "select".
>
> Fixes: dca1a71e4108 ("extcon: Add support irq domain for MAX8997 muic")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

