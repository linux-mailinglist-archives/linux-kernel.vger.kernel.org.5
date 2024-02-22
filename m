Return-Path: <linux-kernel+bounces-76849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC32585FD92
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D4289196
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A78150983;
	Thu, 22 Feb 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LI1ER78W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W/q0WRYE"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82F14F9F6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617909; cv=none; b=MHU8XCA4v7ToyRLo8uq6aV7gnXNIZB/TxFQ8HgmBhhrYuKmjh2deUMQd27KS7HYNCHcO4EJtTsnpSzxMIue+PgGxROaAE9pi41/yrUXE3jiCmEHtdf6JrLG9ILsvfNtqLimPxZBJNoO0Zn4CmrzsMWWkE20dXTvIzv3novksFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617909; c=relaxed/simple;
	bh=RfsuVSe8GNXs7XyLML0In0jzB6G/EuStSNIt2i71n8k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DRirv6cxScBV6OCaAn7M7THshR2xGFxAr4KAKeUlZodI7FjtSmrbtp+V3evpDDXBOvp1UUGivLxxHHiKGKk1g8f6nuCn/Na2uhYqbpgDDjt6Y+PvB/HjsHchBG8leVM5LmTJkSWAnzqI+6vHaL5hak/5qaiyKmgHKPTiJ5saFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LI1ER78W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W/q0WRYE; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 78F3E1C00097;
	Thu, 22 Feb 2024 11:05:05 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 22 Feb 2024 11:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708617905; x=1708704305; bh=oyltdXXGcd
	hvG+yd7mXvuWv0EVxRlvMya8h/82uW5s4=; b=LI1ER78Wvd+MF7uqYk0caF5CAW
	HrnTX8Cm1F1MZNX04bxsASqKE2GWgF1D12os5fuqsqWCBoNKkmOxm600KKD6Y+iJ
	r7KKM1ozrCTG48qMkuWSE7Efc1xfM/ajKt2RCWLEQP2m/4+VE+0an0KmoDuqsS5C
	qxkO27Tk9xrF7ppOizFXYO+Hk11hIAHLRAs6KQXkOMzaIXdiN1B7va+tNdlqOBOR
	Eew+1x3jgOlBFffDxgaJ7x8RE13NjrktOh2P71yIMQ1bsUh55bWb3oOgj+t5md8e
	iQYXoaMGKjMirW5xz8OgPwWjR9Rte5EaT5dUB+aWW4sgo3SLPV7tGi9FU9KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708617905; x=1708704305; bh=oyltdXXGcdhvG+yd7mXvuWv0EVxR
	lvMya8h/82uW5s4=; b=W/q0WRYEugit6zPUKthF4WQ5Ow0hrWEIB463EH6VtX22
	FjAE1WxmIKJroWz9Ty/SFibLOx7NSLEa8WTTPcNiC7rdl+W5xM6R59qraP/o5wgT
	aSsaFM1yy7Epa38mJq0CeVkDi5M5QA32rK69Zf2/CF4T4j1pvk0//a7gQrmXXQVD
	skm34d1P1wgRYnaxl0q7totZyLqtHfIh+QS7IIJX+vX0mBE4l0dq+OZtngN/V6UZ
	4y0IX3aKnjjs0hAPGhjpzrmvigRrdCppd6ad49CnUXX0Hf+fgs9dfJ7JuwDyhO4h
	zvOhYSIQNv1BqOwmTFTlxWIK576CdpKtTnOqD3EWVg==
X-ME-Sender: <xms:r3DXZUASbnYtssaDujRnEbqSELH_zmRau5VzhNGXapJlkdml7FnjEg>
    <xme:r3DXZWhhOeyuGmAoOsEKqAlzr_rl0zqwaY6U7rXSemzNWeoTXmrXnHiISQ6e7eTfd
    VrVDuPXb_EHOtvmyPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:r3DXZXlBMhWU8w-DwlvYmzGdJloOSM_FW78CwyeDT561wiEa6QsrEA>
    <xmx:r3DXZawCqLtuqQhHptYfAZqgCAl7dIi_wBXWLXK4MSkGHeIUpUXgEA>
    <xmx:r3DXZZRvw7Od1q-HYNJhksQT8vcrX9IfmWLvuqYOOQD5mJReSAv2fA>
    <xmx:sXDXZfBzEuLPcOeoul3NFB7ZNim_jUmaTRNIhzs-ohMhnbqVgF53WxXSe2g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 728F5B6008D; Thu, 22 Feb 2024 11:05:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58297ee9-4f33-4b3b-bd00-b44e86965892@app.fastmail.com>
In-Reply-To: <4e9396ca-460b-49ca-818e-73f0a8997b15@huawei.com>
References: <20240220081527.23408-1-liuyuntao12@huawei.com>
 <1342759e-b967-4ec4-98d5-48146f81f695@app.fastmail.com>
 <38c09a4b-69cc-4dc5-8a68-e5f5597613ac@huawei.com>
 <30b01c65-12f2-4ee0-81d5-c7a2da2c36b4@app.fastmail.com>
 <4e9396ca-460b-49ca-818e-73f0a8997b15@huawei.com>
Date: Thu, 22 Feb 2024 17:04:43 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yuntao Liu" <liuyuntao12@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Russell King" <linux@armlinux.org.uk>, "Andrew Davis" <afd@ti.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Jonathan Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>,
 "Eric DeVolder" <eric.devolder@oracle.com>, "Rob Herring" <robh@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: [PATCH -next] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Type: text/plain

On Thu, Feb 22, 2024, at 12:24, liuyuntao (F) wrote:
>
> The position of the caret has been moved below the right brace
> of { KEEP(*(.vectors.bhb.loop8)) }, indicating that lld is treating
> the entire `KEEP(*(.vectors))` as a file name. This could potentially be 
> a bug in lld. Perhaps we can temporarily
> enable the DCE option only when option LD_IS_LLD is disabled,
> like risc-v:
>
> `select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD`.

I would really like to see this working with lld if at all
possible, as it allows the combination of gc-sections with
lto and CONFIG_TRIM_UNUSED_KSYMS.

I experimented with lld myself now and I did get a booting
kernel even without the the KEEP() on the vectors. I also
see that this is the only use of OVERLAY in the kernel, so
I hope that we can find a way to make it work with existing
lld after all, either without the KEEP or without the OVERLAY.

Did you see any problems without the KEEP() on the vectors?

     Arnd

