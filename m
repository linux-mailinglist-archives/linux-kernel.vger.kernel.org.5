Return-Path: <linux-kernel+bounces-138430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A2989F11D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1791F24C05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEF315AAC6;
	Wed, 10 Apr 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lxFQ+Jli"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC21591F3;
	Wed, 10 Apr 2024 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749582; cv=none; b=bVsC0zU65VoyvovKRspscP33a7Do6WrqRQo2rWvwCWuamM/8wD2teMTVwWPNzeOuLLLW+YNuSq3xDGon8peNZ+fSEKarwB9AS3qNATX5/U9vDkLk63Xhv11t8zxMmr+HnjL/yq+OPcfd0TrZspTzwxsb6geld6JmEtJ7skD2org=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749582; c=relaxed/simple;
	bh=q4saJN2PRER/qiy0BEUip5pqKVwYn/d8JY/2VLWe7Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVkx++fbvkj7UisXMfMQBAy0XXs3mNJxSeSeb3ZF/DmF1e+EZOtL8ft6WWFaZ21C2ZatygWycHNUI1wWsIeW59lHdjgU+QS/fns3QM5SxGzQThgHzyDNWrRx0OnPHwL8m48h0YwhIutiTrjbeHBaa3l0axTsNopCaRuKDRHUZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lxFQ+Jli; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CU+986Z11w4Ij4sQmxpqlfXUo1dZIJLGs3jAPqkZ2zc=; b=lxFQ+JlibqTHj/kNTPs93Fu9eP
	B09i1SNIvuDfU+GhSQL6AdlcTXAiNblA+/Dpdt1l7XHfrVhouFp+TT5QwEMRHdjuvlTwowAMaZ1nO
	T3rbqq9Y1yXahLmsVMhClmuHQ0zp0zi/EzC24jt9hTdCU2zUfAmQZfS7jEQwKor+x0rwYZcrdKPpN
	3i/bP+Njz9xn2i9S0Ic9nmqniCbwY6DRJfOV3QUhsuGDYRkt5W4OtnBoqKhIzJ0nmT1oroVs22C5T
	RMAQiu+MmMpjTk4KL4L8IcVAOcmybCz3yQ71kTE0vcStgduzIxr7faS4LEkMgxsjNR+DbO9OwB83e
	SxflROWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruWP3-00000004NOi-2SqU;
	Wed, 10 Apr 2024 11:46:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 397663004D5; Wed, 10 Apr 2024 13:46:09 +0200 (CEST)
Date: Wed, 10 Apr 2024 13:46:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Atul Kumar Pant <quic_atulpant@quicinc.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	rafael@kernel.org, daniel.lezcano@linaro.org, kernel@quicinc.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Disable RT-throttling for idle-inject threads
Message-ID: <20240410114609.GA40213@noisy.programming.kicks-ass.net>
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
 <20240410085441.GA21455@noisy.programming.kicks-ass.net>
 <20240410112933.GA3190796@hu-atulpant-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410112933.GA3190796@hu-atulpant-hyd.qualcomm.com>

On Wed, Apr 10, 2024 at 04:59:33PM +0530, Atul Kumar Pant wrote:

> Hi Peter,
> We are trying to add support for true 100% idle-injection ratio from
> idle-injection framework. 

Yeah, I got that. I'm saying that is broken. Both from a requirement POV
and an implementation POV.

If your hardware needs 100% idle injection that means CPU availability
is unreliable and everything that relies on CPU-masks will be broken.

Furthermore, since idle-injection is build on top of FIFO, anything with
a higher priority (DL, stop) will simply preempt it anyway.

And, as already mentioned, hogging the system with FIFO will break
things.

So I would *very* strongly urge you to push back on whoever thought this
is 'needed'. This is *bad* hardware.

> It might happen that we want to run idle cycles for
> slightly more time than permitted by RT-bandwidth control.

The thing is configurable for a reason.

> We understand the
> concern about it hogging the cpu. Will it be better if we make it a choice for
> the user who uses idle-inject framework, whether to have true 100%
> idle-injection support or not?

None of the above mentioned issues will magically go away. Run a 100%
FIFO task for an indeterminate amount of time and you get to keep the
pieces.

Also, we'll be replacing the throttling code with DL servers 'soonish'
at which point all this will stop working anyway, since DL will preempt
anything FIFO, including your idle injection crud.

