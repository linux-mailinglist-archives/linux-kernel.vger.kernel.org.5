Return-Path: <linux-kernel+bounces-37610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAFF83B284
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101421F256F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD3133406;
	Wed, 24 Jan 2024 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SNWO6MUI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bDmgc05Y"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4301133402
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125817; cv=none; b=M3gQH2WK8SfpY1Sznh0nGXiQ/mhRN+3sb8VQuRlLKfddwGZq3SeJ37RI3YZregYGNIuBVs1TOD1+t19kZ7rD4b4ie45gkxzWZWNmgEubppRBkVGrDnKswFBz54Cra0zYpn5sW6VHKhhCKqH9pbt3FB3JEaTBjPMoDaA+El6lNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125817; c=relaxed/simple;
	bh=CbtLl/Wg+eaH8tLoD2vQmgrib77A8xHj01iKkwH6gac=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dpxbsdhB0ezyIiPYTxeb/FFsSX7FZ2yHPLe8BT7AV5kkRb+z5G/Xngt/C3YJ2aQNumGumioTCEYmRK+cDlFFH2OJr2yppcUO65GOLIrKzXE9IV60OCxEhk/Rnrb1e81CXf2xZYDQJA4l2W4e3AcED2zUSxZ/t0ch3nbWMKY0DRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SNWO6MUI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bDmgc05Y; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3AF7F3200B19;
	Wed, 24 Jan 2024 14:50:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 14:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706125813; x=1706212213; bh=t8KZ2K9xpy
	MdqQzXZl3cy8YA1hW8Qqq39th4gk28VV4=; b=SNWO6MUIhch111VGvlDZIkl0zj
	lPLNm6cm4te26M4IzgCLii6fYgW1aH1/15RASbewdhti7mOaviezW04gkvJ7oKE1
	jmmOCzCULYf/IJkTUTuEzIPmWCSS7+WQG6y/fe5a/J1T7N47llwvmlloJJRMd10f
	rgVFQtqjPz+crGhjUBBDi1Otqn01FcsW0lN6RIliiknWEvYKJs6NjScr29D7yCyl
	GTVKSwaEE7SXZqIqLrV2n8Xip/lPsdqUj5tMIlTwmmzTz6kH/jpPRZ4+EmJ1+vO/
	cnBqVLoedEGXE6FvOfp9RWeW+SleIy/qUx23/w1IKX+jdV1GYYhfRSCMQRkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706125813; x=1706212213; bh=t8KZ2K9xpyMdqQzXZl3cy8YA1hW8
	Qqq39th4gk28VV4=; b=bDmgc05Yy/8VyShT11736bEQ+Pk3eQqA2Aw0mAkNzKhk
	2oROdZ/REnJvF3tP7M0/3ub5PJ/8x6mc/Ny3+JsZHbpPa23z91H1kb5UDT0jrSSY
	oWVgy1yhLih3JY+qSTtJokTyabHKqIrdt1Tq5rUnlGV2C4fDI7n8bqgtF5gkeLOY
	5b7sR4fUY07AS52nEII+kMnoEEBWINR9Vw7K2NI34HY9TGBrS8AlVpVPo+kODvfq
	l7img+kQumncM5oteN84EDpmYM6zpivEcNBivvqa79iNs1NdsRpC2lkawskkKa+K
	hPDlHS4jqtP8sESMqP6ujhxA930Ei1c+rGgPYXpbOQ==
X-ME-Sender: <xms:9WmxZRp1I6tZbBIpM8T38wRO6-WfU1jOPlFmQNpSOnzEwVDK_0nmvA>
    <xme:9WmxZTpUPIE1NvyTOlVbmrefUjuc3uKLPeje7cgdbHrhr_9Hh7p2yzNyGF-nzReqr
    rCBqe8gepDBGconsFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9WmxZeNQNCPsAiKLsizABUn96Na_3ms-jlMHmB466yJ4yAooX-r_XA>
    <xmx:9WmxZc7OGa7RgLjd3wSzUonJEW0upCklyDlrmy611r1_tlqFgV8wcg>
    <xmx:9WmxZQ7m9daKwNn5VzDCkxDHlP5ZvZ1hJTiURpKxazcABb9H6R9HpA>
    <xmx:9WmxZSs4dVfHLJCK80UL-27sjqv35oIRLrXDyTPQG_00bbUoS5JFEQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3CD28B6008F; Wed, 24 Jan 2024 14:50:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d13250c-e48b-4e31-b449-5b54837a0d40@app.fastmail.com>
In-Reply-To: <20240124182256.776c164b@xps-13>
References: <20240122153442.7250-1-arnd@kernel.org>
 <20240124182256.776c164b@xps-13>
Date: Wed, 24 Jan 2024 20:49:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
 regressions@lists.linux.dev,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 "Chen-Yu Tsai" <wenst@chromium.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, asahi@lists.linux.dev,
 "Sven Peter" <sven@svenpeter.dev>, "Michael Walle" <michael@walle.cc>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Content-Type: text/plain

On Wed, Jan 24, 2024, at 18:22, Miquel Raynal wrote:
> arnd@kernel.org wrote on Mon, 22 Jan 2024 16:34:10 +0100:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> 
>> As far as I can tell, this is a problem for any device with multiple cells on
>> different bits of the same address. Avoid the issue by changing the file name
>> to include the first bit number.
>
> There is only one bit number right? We are talking about byte offsets
> so this value can only range from 0 to 7? If we understand each other
> correctly then why not, I'm fine with the extra ",0" thing.

On the Apple M1, the nvmem registers are 32 bit wide, so the
bit numbers can go up to 31. I can imagine some system using
64-bit registers, but it's unlikely to be higher than that.

      Arnd

