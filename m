Return-Path: <linux-kernel+bounces-167565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC02C8BAB5B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2976E1C21F96
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF1152178;
	Fri,  3 May 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="elb+q/N0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LUJl5Rb0"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA2139587;
	Fri,  3 May 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734430; cv=none; b=iBrFaBtMYUamH49JVsanAwXDD99/fnS7VpNw5YFxtadpyk4DgvJE3U6L3xBKU/8APP6uQQWTDNlIGvrYH64RGC+OkaHb61p7l6dJ5eTMPpBh/sdbfdXdITmq0r++JCdK6hiELaPBHOJu80bbTl+g8NEc6VYYVshC5e66fdRxoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734430; c=relaxed/simple;
	bh=GvR9uzfRiZCjQFolJpRQOkcSbc2rF79IzZKOQLzwZaM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Czt0UGl5vmRHZc8wrhCDkYoVvITFA61OtKHtzT1erqR6xM0/a+Me9sl855xJ0UaEbJliybEsW4gAwkC7ukUfSGOWsnWAHEw7u6bYh4txRFoQx6sXDCAmKuSZrnvhjycMxX5YM0APcR3/Pe7ekT0JNJYDIijK0MzbtpzMdtjqbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=elb+q/N0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LUJl5Rb0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 39E311140148;
	Fri,  3 May 2024 07:07:08 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Fri, 03 May 2024 07:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714734428; x=
	1714820828; bh=VI2w/AE2L3MjKz4U4N+Q/2y3K/jjX1RHLKw3XFlsV5I=; b=e
	lb+q/N0iihnBJ33hctMernYc+ZR18AcJXy4gLZf5+CjPyPjR62m08Bebp2KMzi29
	3DtL2U7u+7g3tmUqU3swRxHgimCgkuGWfloK7jNlCHvGLJ49cdJzeZxFPySI19f3
	TSLQ0d8+bFA/4Bvv2ayyQTDqdn8bK3QzruZ1Sy8DZ3JQxJ31Nl4wAPJVOxlZAsr/
	YV8kOFgD3CqgzPtWlnWKezI2WfCy6PTrehFwbR7HCnfjMaBO8afMsK6BDT+cvvSW
	WwoafdOQLdf21f/eixquqxiwu8kUmKpCd6vnbAcGZ9p/iYbDxGCagb14wCobeaCt
	yMcbJjLtkszMxRIlDVl8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714734428; x=1714820828; bh=VI2w/AE2L3MjKz4U4N+Q/2y3K/jj
	X1RHLKw3XFlsV5I=; b=LUJl5Rb0mAsszQnonIblVOmLZ93ja8UCz/7DpnA1hKMe
	wNUTVTsH9i+9dunfgz5I4dDkRBFL5mpiZ5ROsRGoGTx9Pql6lPPFD6gYkBJ1FdyX
	2vH47UgES98NVHay381abZbRnjOJUd/EPIKlkreGiC3F7hPbqyzjDzLQkGh6d/C7
	lLaXc9M5JhHkMbmYnZLe7134UyWjC4rFdcSWuirWRHl44R3z5YDF/JEvY2JrAQ5n
	C9u+Sn2q1va8JYpNko36GNEnYFmnDflz/tNKmWu3JjyYhgDBSeb7QMHnoHg3HYwa
	E5RyXZIxTUmLBgLrrKZKBm2bUqKcggBxd6rmmuVlrA==
X-ME-Sender: <xms:W8U0ZrcF9DfUcu3i9ew-JCI-q43oy2LMp5b8kNEmChZ53UX2MIIbrg>
    <xme:W8U0ZhP1sk7j1RkUh6QWgvHFwV-2PCDkMKWdOKSEO-VyRy-obtn8lsm_djtrpd94e
    qC_3Kwz8Xo6ABR_FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
    rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
    ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
    ueevieduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:W8U0ZkjDRal_SfaHcAn2hl_8rlg1UMMo2NwRY8jbWAe38a3Jyft37Q>
    <xmx:W8U0Zs9BanujQeodhLfMiKeUACvOTXDOLF9KZyARDCc77FWK_qy0Gw>
    <xmx:W8U0ZnvDdWzKnr0B8F7jxtr8pvxzXQhRWqx5DQoei_cah8XsSJ9UCw>
    <xmx:W8U0ZrFZD1wERCvoPPdw3UcxtfEZM2-3jvCg7mIVYNH9VDhMxfYz8A>
    <xmx:XMU0ZtANjDrpg-Rb5cYXBWbQPhDaAHJUWdDfh4N8Qe5_2LN0eKLc39l2>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 98257A60079; Fri,  3 May 2024 07:07:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-417-gddc99d37d-fm-hotfix-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <178dbfc7-31cf-4cfa-a466-08ba5e7302b1@app.fastmail.com>
In-Reply-To: <fde9c98a-e14d-4c03-91ab-0cdc209a1763@app.fastmail.com>
References: <20240502180736.7330-1-a.fertl@t-online.de>
 <fde9c98a-e14d-4c03-91ab-0cdc209a1763@app.fastmail.com>
Date: Fri, 03 May 2024 23:06:45 +1200
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Alois Fertl" <a.fertl@t-online.de>, a.zummo@towertech.it
Cc: alexandre.belloni@bootlin.com, "Chen-Yu Tsai" <wens@csie.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Samuel Holland" <samuel@sholland.org>, linux-rtc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drivers/rtc: rtc-sun6i: AutoCal Internal OSC Clock
Content-Type: text/plain


>> 
>>  static void __init sun50i_h616_rtc_clk_init(struct device_node *node)

Sorry, this struct. The H6 struct is present. 

>
> Ryan

