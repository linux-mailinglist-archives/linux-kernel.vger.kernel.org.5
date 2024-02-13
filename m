Return-Path: <linux-kernel+bounces-63750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997158533F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C89286DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036075FEF5;
	Tue, 13 Feb 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BbJjjegB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMFmdCxv"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C546D5FEEB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836360; cv=none; b=U3esuDT1DxG2OQa1SRNSvp/kwdP9mA2LlZG3l4qFHKoT+E39Bl6KJFsM0axShcZfJ7sX+xkuNkdHdrVG7I6Wm68+J+yzzX6XgVYVCLIdXptMt0TS6+A68zUEeUpTPhVnFUQAGL7wrs6xBllYfiBfAZPNmuLiHLkg2p5eDYz7fbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836360; c=relaxed/simple;
	bh=wNwnNSGdVzE3t9gaViaE+/JueHQ8uupULFvu9iD61S0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DaB6Ab11kK/IhbPrD5HhQVyan1vNDV0BlLLbTlvZE8aqRIxAbUA88k4BBCqFsAVlFEteFtuutKR/pDEvwm7Qrnv8Ok050Pq30nGNXpdHR+XTk4nKrxuhUGo5E4i9q8ted8kNIYWV01BVOEXa349UyW31wkQa1JmFIOMVxrMQyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BbJjjegB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pMFmdCxv; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 5E0EB1C0009F;
	Tue, 13 Feb 2024 09:59:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 09:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707836355; x=1707922755; bh=gIhltuSg5f
	07BAmyhLRuaUI07Ue7i03H63GgJHWxFt0=; b=BbJjjegBA+jDVdmuiQT4bMkomq
	WcVqztPOzaaRGkHsuf2WEYqqDrse5N0sr2oFCBRV2L1/bWdmmIVGKT6wSvxo+czG
	GUZFYbijTJUpjSRdZWHQNrNeFA4/x52agtiva0X2AGfdZtr3fTga8KE9htXQKCat
	AYqmx6Xuj6aA4vx3viza4Rp8HEbVhnprBcvJZcJaQR2ooRIY+oG6Y2stFJoBloSX
	MsSOp2ODDJxV6u7bHD8SmymmjUq8FDTmHQthasymrp6yhotuqXjjJOMLhE0KtBkO
	27FRk46TH4IACaPcYHxlmGJof9CtztH/vdc1243IH3GxAFcu4JWbbhXkYuGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707836355; x=1707922755; bh=gIhltuSg5f07BAmyhLRuaUI07Ue7
	i03H63GgJHWxFt0=; b=pMFmdCxvPYBNFM1HifBRMaH2pg4DtihTJGksRgUpCpAL
	ftEFHc6I2iedyWUJpXxkrMn7D6Gz8JI4qXknrn+W4jY9JPEDt0kmbSRAQ1tpMGex
	G89ZR3TcaTL4Dz48Yo1Qh3iO1AjJoroPXj2Ra9US9SPAEZMmnzoBfTTKvAGaMWdV
	n8rixKSIOTJ2J5TZ4Bez03sbdzgaeGablHw2bMemfU52BJJ1s1137Zgp+okw903A
	HVz8ANDeIGqcJuS1fyjslZVyah/4I1BDvI7G+xlf/vuvTg4F5N3Vic+zut83kXEd
	bYhLrR1G/SnEwKYt/75GFwVaDHfOg0NDw9OS+yvkaw==
X-ME-Sender: <xms:w4PLZdJFzHVZ7I82tLPqFxXDINWiqY5OWnLc0MPtzRR9RdP5RcCSxw>
    <xme:w4PLZZKCQnAVHyFMfMsJ5H6L8JxwMBPevBspQJUrBtUYHgGU9UGbBM93a0DOHCNw2
    01x5u1j-LwpdA30jXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:w4PLZVscmX-EmlgJTxepSKNntNeRTJayEtQp9iNDxQEBXOjDWozIYA>
    <xmx:w4PLZeZAcjZfKvQHVuq8P_LMSlmvNf0flqgyRlBxtIX21dtJJ7Tv-A>
    <xmx:w4PLZUYKQFk3UwhZFLSCdgB2TXKKEQjmdFteUfSj3xHm-ahyKcdePQ>
    <xmx:w4PLZeseEKIpmx8UV9Ft2_rLR7mJkO_ArFsFI0SVlPOcfsOcvIFJGGcufq0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3A6B7B6008D; Tue, 13 Feb 2024 09:59:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <17209419-093b-4674-8b43-06c92312ef61@app.fastmail.com>
In-Reply-To: <877cj88lck.fsf@intel.com>
References: <20240213134817.3347574-1-arnd@kernel.org>
 <877cj88lck.fsf@intel.com>
Date: Tue, 13 Feb 2024 15:58:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Oded Gabbay" <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>,
 "Daniel Vetter" <daniel@ffwll.ch>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Matt Roper" <matthew.d.roper@intel.com>,
 "Matthew Brost" <matthew.brost@intel.com>,
 "Riana Tauro" <riana.tauro@intel.com>,
 "Daniele Ceraolo Spurio" <daniele.ceraolospurio@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe: skip building debugfs code for CONFIG_DEBUG_FS=n
Content-Type: text/plain

On Tue, Feb 13, 2024, at 15:55, Jani Nikula wrote:
> On Tue, 13 Feb 2024, Arnd Bergmann <arnd@kernel.org> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Some of the debugfs functions are stubbed out in these configurations,
>> so trying to build the .c file with the definition fails:
>>
>> In file included from include/uapi/linux/posix_types.h:5,
>>                  from drivers/gpu/drm/i915/display/intel_pipe_crc.c:27:
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c: At top level:
>> include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
>>     8 | #define NULL ((void *)0)
>>       |                ^~~~
>> drivers/gpu/drm/i915/display/intel_pipe_crc.c:549:20: note: in expansion of macro 'intel_crtc_get_crc_sources'
>>   549 | const char *const *intel_crtc_get_crc_sources(struct drm_crtc *crtc,
>>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Stop trying to build them by making the Makefile entries conditional,
>> same as for the i915 driver.
>
> Already fixed by commit 439987f6f471 ("drm/xe: don't build debugfs files
> when CONFIG_DEBUG_FS=n") in drm-xe-next.
>
> Maybe that needs to be picked up for -fixes?

I made sure that this still happens in linux-next today, but
it does not seem to contain 439987f6f471.

     Arnd

