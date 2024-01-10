Return-Path: <linux-kernel+bounces-22643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B341982A0D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6109C28C39F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467734D5AD;
	Wed, 10 Jan 2024 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XpOTEBKk"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E73FB33;
	Wed, 10 Jan 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=AhrsHTa+ABmANvCwYnlTgj7bU1iI/SJ2QKWl7MaF2eI=; b=XpOTEBKk50dvdKPplMoujqdzBj
	Gy2Xi3ahaSODc+/m9ivpaIFd+h2cLDGb69vJ4P3/XfLUbTvG+aeDK2vPfN1eYRmOxbyhi1og7nZ6I
	SmnrrmVoIl1iM9RDLzh8opWCklNvlOfId5uMR4ic79lysP82Nn2s6cSgtnjA+PM8z7kSaxfPwj3oc
	wCXkj/bhCCn4hK2OzAEOgMNOl/IqbPC/kbum0iQFjeoEtRP+Ypp9NoVVfVtMrDPU5SGvJcd0VHMh+
	vrrsQNaQeOWQvm4BRf34PmUZBWxPnw3nJI+ByeBhImcfW4NZQKmCHSLkKbn11dpUtqt2FjMPv7peM
	RFzLl2PA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNdwE-00Dbl8-10;
	Wed, 10 Jan 2024 19:08:30 +0000
Message-ID: <a759c808-a14c-4370-b47a-7db908fa3127@infradead.org>
Date: Wed, 10 Jan 2024 11:08:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] membarrier: Create
 Documentation/scheduler/membarrier.rst
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, corbet@lwn.net,
 mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
 charlie@rivosinc.com, rehn@rivosinc.com, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-3-parri.andrea@gmail.com>
 <63046420-264a-4e7c-b45c-17f0486ba4d9@infradead.org>
 <ZZ7qiIDFDEMEfNiS@andrea>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZZ7qiIDFDEMEfNiS@andrea>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/24 11:05, Andrea Parri wrote:
> Hi Randy,
> 
>>> +MEMBARRIER_CMD_{PRIVATE,GLOBAL}_EXPEDITED - Architecture requirements
>>> +=====================================================================
>>> +
>>> +Memory barriers before updating rq->curr
>>> +----------------------------------------
>>> +
>>> +The command requires each architecture to have a full memory barrier after
>>> +coming from user-space, before updating rq->curr.  This barrier is implied
>>> +by the sequence rq_lock(); smp_mb__after_spinlock() in __schedule().  The
>>> +barrier matches a full barrier in the proximity of the membarrier system
>>> +call exit, cf. membarrier_{private,global}_expedited().
>>> +
>>
>> What does "The command" refer to above and below, please?
> 
> The term was meant to refer to any of MEMBARRIER_CMD_PRIVATE_EXPEDITED and
> MEMBARRIER_CMD_GLOBAL_EXPEDITED (from the section title); FWIW, this seems
> to align with the terminology adopted in MEMBARRIER(2) for example.

I see.

> Mmh, unless I get a better idea, I'll expand those occurrences to:
> 
>   "The commands MEMBARRIER_CMD_PRIVATE_EXPEDITED and MEMBARRIER_CMD_GLOBAL_EXPEDIDED
>    require [...]"
                                                                            _EXPEDITED

OK, that's better IMO. Thanks.

-- 
#Randy

