Return-Path: <linux-kernel+bounces-63527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E298530C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCB21F24C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52057535CB;
	Tue, 13 Feb 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="zmv8ZY9U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FagTpgjK"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423A52F8D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828139; cv=none; b=aKJesEZz2zFdu0OlbSSYz46iM57LyYEE1apGMfvRf1tDsKReq8nbPklOnyiVoYiMJrHG/a9vCX+YrzrX/6WU7MaVEaYSMQp5O13c2BCKBVjUefxVTjD+vD7QMfUfD+wSoEqzDoWWD1w7LwIjDkoiJZ/b7Wu9n5oiwDrcxsx18JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828139; c=relaxed/simple;
	bh=0OgEvOX7jGbGoo0P3aw4FynnbHT70vSEB7oG7CcUcO8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Dn2TK/3Q1Yl2P45V825g8E3l4sWkK/z1fItniqiLzhsSPelkt2xdtHJv2tPkTJ/scACYI47w57sFwlgTMG3W8TuS7WtE4Y6qSREq6zznkmWnmuN6rEZ7OR/JBa6a7/t6Z0mvsabC6wh7c6Ouw6KnmmbJjUnaLK+38yxyXtK8nZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=zmv8ZY9U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FagTpgjK; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id DE8D518000B4;
	Tue, 13 Feb 2024 07:42:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 07:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707828135; x=1707914535; bh=0OgEvOX7jG
	bGoo0P3aw4FynnbHT70vSEB7oG7CcUcO8=; b=zmv8ZY9Uz2kZdDDT8X6jbt1lFB
	vIPh0XpR+p7ikxpDWuJqBMeF4cTNVsfa6xZLEb0zwKO69SarGoBOYdiJpikHQYQZ
	vh95eHPi7VO0WXJTfvm6/QtGrGw/b5Y750sjDto0ZAeWpqu1X8iVGvW/y0TxgLqh
	r1+tbzGoHKN3D5d1PwxgoJs4rz3JwbJr2G8rmuwufcj59wzWDOiou1EL3A7oyOOo
	RoczehmP9tQg2VBYrsh2Rk6n9R/a8jpycWnIizsr7kcaXVepZBmfwUOA3EgJxRkO
	TMomA3+Pv9VbiLp789zwoxnfryucN+Xl9eMnCPJGkV7T1vnsP9nzugMiR3Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707828135; x=1707914535; bh=0OgEvOX7jGbGoo0P3aw4FynnbHT7
	0vSEB7oG7CcUcO8=; b=FagTpgjKyiJxDQVAmPFXY2Y+4GuGUltOiheHQI5v5/D4
	q6kMVAK9lPTK+HNGhha5hNLvx7M/TASWUvIwlBZITLFt+IIlB41XdWvZ3BKaR3/r
	3/1sqVHIjX2eT7+0fVIOyFWkfpQGWtlAoNnYK8Atyt6c25IttylyJzKaSfisNEXo
	ZKW0wvcJjU1m4PjYBdbJWJ2NJ8ogZcEXWu1SYzVSBM7Y9egrBYmjerVXfuDoSAab
	g2MWZHyZaO5dgAaMF88WfU1Eoc89e6ruzL3qNZS3er6Y5cMAqZQvCdAyGxBvioL1
	19fgB/E8ghQUemdN/kICnCjgY712TOfgV3NOD/m6FA==
X-ME-Sender: <xms:p2PLZRgDo-UNQE-CysT5qnPKweDJdjifdqlWE1lRBc0xqutxKLxWiw>
    <xme:p2PLZWD9RS3E8LScLvfA3okIcxksGRVXV8WB45sNQZvfO-f4IDH0WSx_LRAWV0C1x
    BSoIthe3U_GpDFOQBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeejvddvvdduleduheejiedtheehiedvjefgleelffeigfevhffhueduhfegfeef
    heenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:p2PLZRF6UfQ4hlXvPAKJ5KHepc3_NRxNVxCqpP_ndkGACtwjONoTsQ>
    <xmx:p2PLZWSr68Qtaf8Z24NtkV68-dUv02tgdBGnijiN3WAhMH8pSAf3oA>
    <xmx:p2PLZeyVx4ihkxeaOJnSxWgvawzXbsUaGOwRuiqjYhtuBLS9KYZH7g>
    <xmx:p2PLZS8LqOt7Q1esFaMINHYFJNyS3AsQ0-tFh0Bcaj0D_BftnNq_EzPvIU8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0F2FBB6008F; Tue, 13 Feb 2024 07:42:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c23f0e06-9ec1-444c-b2ae-77f0fc2de539@app.fastmail.com>
In-Reply-To: <20240213111527.25218-1-jirislaby@kernel.org>
References: <20240213111527.25218-1-jirislaby@kernel.org>
Date: Tue, 13 Feb 2024 13:41:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiri Slaby" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Clemens Ladisch" <clemens@ladisch.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hpet: remove hpets::hp_clocksource
Content-Type: text/plain



On Tue, Feb 13, 2024, at 12:15, Jiri Slaby (SUSE) wrote:
> Commit cf8e8658100d (arch: Remove Itanium (IA-64) architecture) removed
> the last user of hpets::hp_clocksource. Drop the member.
>
> Found by https://github.com/jirislaby/clang-struct.

Nice tool!

> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

