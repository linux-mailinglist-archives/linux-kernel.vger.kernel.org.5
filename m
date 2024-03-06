Return-Path: <linux-kernel+bounces-93992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBA18737F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034D5B24350
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B67413173E;
	Wed,  6 Mar 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="pQqyyCql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUeFs0LG"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3A131745
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732466; cv=none; b=vFR+1kuAwsIQxgzwtMkPwDaf49g1UM3IlzrZq/0f6ZxuvCRflnScmc7c1Jk1oeCer/vozQDxzmaQif3IEpf7cnuK9zYw8T9v0w7mbqS2NhhLAZi4yD+bo3S9kZK7r1I9ZSA2J9GksZDG5WjSOsH5mhUIPAlmKQcFs5kRtODFQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732466; c=relaxed/simple;
	bh=DqyuLe982M0gCzXNHkRNqdo/en/tcqMLSPM6bGJs+l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq7/pYcz3aG5IVU8ulU//l6v5Yw3ltP36vbj5iOm5p872Kl9l6FIHXDhnsLMokpVG+hT6JUGyCj7NauMqR/1N5GXPLg/oBoeGj0sXoDZ2Vd0AmZoTINS0mSYA9V6Ht0QPCTYAkkzNo4xjFQRYrVEdpVMbQCmf2qU5WRTGzdqo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=pQqyyCql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUeFs0LG; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 0CC0E1C000B5;
	Wed,  6 Mar 2024 08:41:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 08:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1709732461; x=
	1709818861; bh=8eGGmM1KR7AcuGh7NIqABGQLQZZwfZwqFbPI2nbC2o0=; b=p
	QqyyCqlax0VekC+Sgn3UonHyKUxzjko/W+1I49gCNsNSOSpFGuGt+jX6m5ghUE8n
	eQvLK3o2Z529+WIfSAE4pO9+YabIUhYNRZIBKm/4BVvQkQCFEUMCPvl/S1nyvZ3h
	Ud95cHEkOVbPKBvvHNm3tFgd7jAKjZ2L4ngTRUkERfHwmWnvZHBtimAtKXTvLszT
	xSpLFosx9nW5MqDTVSm6oY6mD0OG6Fv2eiQ313czSC47S/75KnjXa08FhLI0EGZ2
	9n5JiZ38jyvo3Jt0QoRxds4SWlleXfaUN5a72h/SQaKQMOXsWfhjE1F5EvsmJ5ID
	+A/ZuM4zifYaDpbUhGGdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709732461; x=1709818861; bh=8eGGmM1KR7AcuGh7NIqABGQLQZZw
	fZwqFbPI2nbC2o0=; b=WUeFs0LGk+h67KdusPFYnAPyCP/I7PhiyPqAPsH+uhPo
	kXkK/66ApjN8jCvAGWG8ioQlOkQM1z3bei0M6Pb/SgzpKThnZLZzZZdT502pzgmw
	fHMMwb/KKUo8t7dCMFTe+2CfaLUCLN7pevgsboQlZqJu5R+KV/Qlsz8QmuV0coXq
	0cdGUpd8AOsI2EaRQa1UtnwggfAWtDMBvfmPdz0LiS/RYr4efYHaXKtCd34sZ0kh
	v9uDY6SiIFc0Ml0cdxCmWzSddsnSOtfOVZnsQmDyANIt0/vtZwkay+ePV4xpLw75
	e69DvuS9T010AV4lIR5HPmOnGhiq51j5hjQN+cSDaw==
X-ME-Sender: <xms:bXLoZVdyXPRFp6RCD3IpYeGYkEDNjxMGxnaL8c_cqI-afWySLOVjpA>
    <xme:bXLoZTP1QDxaj1SNudq65pPpEcknU5WOSdvneihzIGikGs9Vzjya0b5wfvuqGMA0b
    kV9dh9SyTSKo4JYbgo>
X-ME-Received: <xmr:bXLoZeiQWEDkGssYHYRPHzV82RcF9qv1Lkh4oWKufrYDp6veHKTDAfHinzSf9ARummzJDsb9CVqH_TvJoyaMiKBary6LXfZX7S8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieei
    tedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:bXLoZe-OqQKS3RKwvDSkU0HPNW5z0GbGAdce_AePAnn1xV_vahYBZA>
    <xmx:bXLoZRtaNLvV9E2QKz8xAdXAsX5dSAmUG3tVOU-DWKo3x-SDbEzNYg>
    <xmx:bXLoZdE7Cbqz4ejL_s30yiKUlnFQwaDsxwy15-koxLygLEogs3Ai0w>
    <xmx:bXLoZZLqNBEWe0WpFndDAjlIi2zzGoYf5loRyz4cs3g_IHmIPV5w7bNw4Do>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 08:41:00 -0500 (EST)
Date: Wed, 6 Mar 2024 22:40:56 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Edmund Raile <edmund.raile@proton.me>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firewire: ohci: prevent leak of left-over IRQ on
 unbind
Message-ID: <20240306134056.GA124318@workstation.local>
Mail-Followup-To: Edmund Raile <edmund.raile@proton.me>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240229101236.8074-1-edmund.raile@proton.me>
 <20240229144723.13047-2-edmund.raile@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229144723.13047-2-edmund.raile@proton.me>

Hi,

On Thu, Feb 29, 2024 at 02:47:59PM +0000, Edmund Raile wrote:
> 
> Commit 5a95f1ded28691e6 ("firewire: ohci: use devres for requested IRQ")
> also removed the call to free_irq() in pci_remove(), leading to a
> leftover irq of devm_request_irq() at pci_disable_msi() in pci_remove()
> when unbinding the driver from the device
> 
> remove_proc_entry: removing non-empty directory 'irq/136', leaking at
> least 'firewire_ohci'
> Call Trace:
>  ? remove_proc_entry+0x19c/0x1c0
>  ? __warn+0x81/0x130
>  ? remove_proc_entry+0x19c/0x1c0
>  ? report_bug+0x171/0x1a0
>  ? console_unlock+0x78/0x120
>  ? handle_bug+0x3c/0x80
>  ? exc_invalid_op+0x17/0x70
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? remove_proc_entry+0x19c/0x1c0
>  unregister_irq_proc+0xf4/0x120
>  free_desc+0x3d/0xe0
>  ? kfree+0x29f/0x2f0
>  irq_free_descs+0x47/0x70
>  msi_domain_free_locked.part.0+0x19d/0x1d0
>  msi_domain_free_irqs_all_locked+0x81/0xc0
>  pci_free_msi_irqs+0x12/0x40
>  pci_disable_msi+0x4c/0x60
>  pci_remove+0x9d/0xc0 [firewire_ohci
>      01b483699bebf9cb07a3d69df0aa2bee71db1b26]
>  pci_device_remove+0x37/0xa0
>  device_release_driver_internal+0x19f/0x200
>  unbind_store+0xa1/0xb0
> 
> remove irq with devm_free_irq() before pci_disable_msi()
> also remove it in fail_msi: of pci_probe() as this would lead to
> an identical leak
> 
> Fixes: 5a95f1ded28691e6 ("firewire: ohci: use devres for requested IRQ")
> 
> Signed-off-by: Edmund Raile <edmund.raile@proton.me>

Applied to for-linus branch. I'll send it for v6.8-final.

I think the pairs of 'pci_alloc_irq_vectors()' and 'request_irq()',
'free_irq()' and 'pci_free_irq_vectors()' would be fine here, but the
replacement of legacy API is not welcome in the last week of kernel
development, so I postpone the work to the future.

Thanks


Takashi Sakamoto

