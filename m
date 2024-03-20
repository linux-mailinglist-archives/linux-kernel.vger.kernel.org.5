Return-Path: <linux-kernel+bounces-108858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E228810F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9C61F243C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A553DBB7;
	Wed, 20 Mar 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MET3jxyq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KD+F/3vI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7A3BBC8;
	Wed, 20 Mar 2024 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934256; cv=none; b=dZtF/N88IPJDVE/cwljpyuWXFhn9maDRfKXwdLcZbFXMugA8RNkrv3GjLGLoIxHVfCIjAD4VCf1EerZ0dI2pN2Y3UDSfqKvluooT+x+hMu0xrcrG8dfhVYEglXzAqBG5GvJu+jaUM45GzXoFvM37Uozs2wdrUgl1hTQ2YIZ+PKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934256; c=relaxed/simple;
	bh=a8TOprEuyws5CRENEXE+KPayvt7+FUvQnptRl61id2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VjzTdcXQDUf/yZItJ/KhFghpbxqzXP2DVzahW+5TDyS+cRg62pJJ3DtZxH+Tf8srnVKGqPb7M29i7PK2fLcuTqju5I1Sq0FQPJQAqTBLK1cYatoTn9ThlR2m6FKVfLMAD7pPKnL7yT3ChavhYBTgYR6tm3wX75UH8BkgGnErVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MET3jxyq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KD+F/3vI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710934253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwE/GBJYLkV/7/yUUomeUZHide/jRSkFJUzETBE/thU=;
	b=MET3jxyqm1sXOQn5gphkidNCjfG+Tr/p2/ki9n+/AqGfDi6uzTb2aT/MyL+ioOWks6ndHO
	MI95oCOA1zQP2cwvzPcoi7DRiq7z2zXhoQrgJCUxMxEHjz9x4uvFfD/XYPX3zBQTUr65XL
	lNTFECeMgVwWMspuPc3Omri78q9n2MBo8amNB3KLmOlgidIbjna0YRPG5+YXucDf8l0X6t
	Xe5iJoS5QZsKia9g+j3+SDVmp31i41KL3GoBs5cawaUNf+yvjjaPvcxueJEeMTUBz6dcYS
	q1ELLfg0R+vKzoni0nnLM5iim2DRcVOb6v7gUhRjGS7rNFMU1AXrXD/j6iMeew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710934253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwE/GBJYLkV/7/yUUomeUZHide/jRSkFJUzETBE/thU=;
	b=KD+F/3vIh9T1cQ/PXywhSvE5rgPwIOfCSkG52QZ7ALq7BZCiJ1z2qhgQYCog3Dp3vC7iyf
	WkvevLWZUyLc3cCw==
To: lakshmi.sowjanya.d@intel.com, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, peter.hilber@opensynergy.com,
 pandith.n@intel.com, mallikarjunappa.sangannavar@intel.com,
 subramanian.mohan@intel.com, basavaraj.goudar@intel.com,
 thejesh.reddy.t.r@intel.com, lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v5 01/11] x86/tsc: Add base clock properties in
 clocksource structure
In-Reply-To: <875xxhi1ty.ffs@tglx>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
 <20240319130547.4195-2-lakshmi.sowjanya.d@intel.com> <875xxhi1ty.ffs@tglx>
Date: Wed, 20 Mar 2024 12:30:52 +0100
Message-ID: <87zfutgmxf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 20 2024 at 12:23, Thomas Gleixner wrote:

> On Tue, Mar 19 2024 at 18:35, lakshmi.sowjanya.d@intel.com wrote:
>> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>>
>> Add base clock hardware abstraction in clocksource structure.
>>
>> Add clocksource ID for x86 ART(Always Running Timer).
>
> This change log tells the WHAT but not the WHY. You have to add context
> and explanation WHY this change is required and why it makes sense.
>
> Also I think this should be ordered differently:
>
>   1) Add the clocksource_base struct and provide the infrastructure in
>      get_device_system_crosststamp()
>
>   2) Make TSC/ART use it

    2a) Remove the art to tsc conversion in drivers
    2b) Remove art to tsc

>   3) Add the realtime muck
>
> Thanks,
>
>         tglx

