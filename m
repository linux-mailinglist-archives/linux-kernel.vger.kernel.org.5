Return-Path: <linux-kernel+bounces-37618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EAD83B29E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573DB281FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CE133420;
	Wed, 24 Jan 2024 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="axXfERWH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovgdj+WC"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FBF1640B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126210; cv=none; b=pLlrB6a/HPKqeJqiSR+Z0N2aDR14SNhV3QwQraW4nE1sWSxQY0ru/PTWz1beE8eqsr4WT0c5rpssB22/SGSfejbV3moeqrjKSNQqBMrGPF7sW+dQcs9uiUbL3Pzj8k9YHHZjOiW55yCOGqzEgvvn71LSU2PhYpN/p6HJJLYIWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126210; c=relaxed/simple;
	bh=b+4KtwroWHifUa0zcEfyPb9PwKrw/aT0juXUNpoFFc4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Xu5lMw5K+sFuIyfuCZx+QN/XrwMb7+gB6hel7Bn8hjoHEkn4em8G70m1YRh5ZIqXFmKDr9oz5H1bMTAZv+MrYOB8/JFuzdaEJESGCJig8oUegkfjvrnc1uh0H/tuHmWM1zvzDGc41YyvpnrHTmhaQEjgRnNazc4YudPaL0CK418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=axXfERWH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovgdj+WC; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E431A3200B1D;
	Wed, 24 Jan 2024 14:56:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Jan 2024 14:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706126207; x=1706212607; bh=9jH7pw6p/m
	HP/bf945yek2SfxYUmUszqOHoo1rnSN+s=; b=axXfERWHUxhquE8wAT1ts9RciR
	cmMceIRESHuBc9xymhXLHO6NcYhttDqzlHeFxrYz3doizal0fUOP9QSaXLCbtrb4
	ORRvcSkYkuAOEVvu0l8cXu3YVjsBShpncNKRV4IRLLCgOIGq963UD0vqv8zu4fAH
	f2VQCaJZmlgHUaR8m8i44fPKVm+AvXAcTusrwyN5nJuRrnNQWFyrYtYy5MkWTUDn
	Y/UeA4rHT92N1/uWYrJqo6AXb5uXwWZFtqmRP+RBR7HmIBh3+oSklocuPmmwMFsN
	OH0YxalJsSZF+19DmoZNGoOqbAgrKyeuuRMPFyE3cmLG6rWdvR8zYE+Q3ezg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706126207; x=1706212607; bh=9jH7pw6p/mHP/bf945yek2SfxYUm
	UszqOHoo1rnSN+s=; b=ovgdj+WCQ16ONrcXYiM8hF+lJqZi8H0Z3OIRYyCogo9n
	YjYwYUvN/YLvV8HV4VzOwg8+5KZBoh1A7VsIoBexgkApjAU7CjZfJO/PbRn5x9yy
	B9BRmA5imdAmeEnrYuyrqwHkHnmrwqc5nhCSeY5ETTAOW5I5PTzdYSuVW3gCZBvS
	MAQXL5KZTFofBl4cCFmgd/dmpxB0CoJmAUv/viGbaRTKvpGYU1ojZrs0kxvGwQjL
	tcQiTvY8OZ/xyqkc5ukmwbFOtyaglbGAbj7CckQF9vYn84GgmtCaj8+Uu3mHpzNS
	LrD+PFitDQ/+/38xxiU+q9auwW5+/rPg9ejk2iW9rw==
X-ME-Sender: <xms:fmuxZWtLOj0KpHWuIKekPU-Ci0ws6GpyRNsXmvzzssG57PgO2GbG6g>
    <xme:fmuxZbdaLgqf8NVNhL64ghXZ98zy4fMDsSS7BaW1asxHPzopxnbsGh-IV4TPV5KGw
    JiWQwIe_BC7opj18EM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:f2uxZRxiUUXsLuTNlmDOzcBVEIahXQDY5nL61j455SrRPUZqf2nx1g>
    <xmx:f2uxZRNaf6BTAnH3AGSpVqSTzE56ymcYhGGVYhIxicPMepaQWzze2A>
    <xmx:f2uxZW8w7oDmnoDqGogthGESnkLJt55sT5jakH4E571HVNiBjp5vwg>
    <xmx:f2uxZab2bNKSl1ghACx_P9rfdTSAHyCK3l2s3N_hE-vIyf1-muvhMA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E684EB60093; Wed, 24 Jan 2024 14:56:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3cc8741e-6866-4068-9226-d46b68b7c801@app.fastmail.com>
In-Reply-To: <5f5a2ecd-7878-46ba-9a85-a2a4ba060ad7@ti.com>
References: <20240124162857.111915-1-afd@ti.com>
 <20240124162857.111915-2-afd@ti.com>
 <20240124164116.k5ah56xvuclfkxdr@despise>
 <0ab47165-3ba3-4d34-aea0-9bc12fd5ff31@ti.com>
 <20240124180451.bptuhldi44leulr3@pectin>
 <5f5a2ecd-7878-46ba-9a85-a2a4ba060ad7@ti.com>
Date: Wed, 24 Jan 2024 20:56:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrew Davis" <afd@ti.com>, "Nishanth Menon" <nm@ti.com>
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Santosh Shilimkar" <ssantosh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: configs: keystone: Remove this defconfig
Content-Type: text/plain

On Wed, Jan 24, 2024, at 19:52, Andrew Davis wrote:
> On 1/24/24 12:04 PM, Nishanth Menon wrote:
>> On 11:31-20240124, Andrew Davis wrote:
>>> On 1/24/24 10:41 AM, Nishanth Menon wrote:
>>>>
>>>> There are a bunch of downstream folks who will have recipe fails etc if
>>>> we do that. I am not sure we need to go down that route.
>>>>
>>>
>>> That is the point of this patch, we want to stop any remaining downstream
>>> folks from using this defconfig. It is not maintained nor updated like
>>> the multi_v7_defconfig, any new or needed options will only be added to
>>> multi-v7 defconfig.
>>>
>> 
>> I am going to have to defer to ARM maintainers what they think..
>> enabling LPAE etc in common multi_v7_config.
>> 
>
> We are not enabling LPAE in common multi_v7_config, that can't be
> done as many plats do not support it. Keystone will use the new
> multi_v7_lpae_defconfig which was just added:
>
> e9faf9b0b07a ("ARM: add multi_v7_lpae_defconfig")
>
> That is what prompted me to make this change, we now have a
> commonish config that works for Keystone.

I think adding keystone to multi_v7_defconfig is a good
idea here for the reasons you explained. I don't mind keeping
the other one around as well though, since keystone is
a bit special.

     Arnd

