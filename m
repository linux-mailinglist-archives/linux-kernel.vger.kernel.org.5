Return-Path: <linux-kernel+bounces-22345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4F7829C69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E441C20C22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF464A9AD;
	Wed, 10 Jan 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gdKF9xbq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fe32LR2E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBE4A997
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704896451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUHtN7Ow773G2ZKEdASk6unjuADbbEAnPh+gfAOkG6o=;
	b=gdKF9xbqP4PrqQKf6LY1QIvsMZz6SEhF/Xjlu+CQ7lzISpfM7H/iFL9AmaUatndfjb83Qf
	qzq49lVoZ5PMCcDv0VbtJ6FLN3sMUUXpcqfYcV2jMbpbHMvNW7dFKYAsLvTrAzZvBl5UOE
	SL2+u1nK5Uk85v8zuD34KgP4b7uWMj05SxZxL/vVMsqbfqKAdSuUjh8lKXhxfFYwzVKj5D
	/uthCBjmNQ9rCiC7Rzdix3wjeJzhzB7CK7arqT0qOE5XoXrrPgwTfoSp+8l5XLNZiKD35h
	ZsJMlyNpRT4O+jMRJnxiiNJV/N2KFVeQBELPUjv2JdAfue+442jC5+TeHIBCjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704896451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUHtN7Ow773G2ZKEdASk6unjuADbbEAnPh+gfAOkG6o=;
	b=Fe32LR2EVhHUOEHoRMUzyb+p+hBsGTqgkRtfY2N1rSw/5SQT+Pdd7e9Qwd9F8nLzzoAK58
	LA2Wpul8FUZFQrDQ==
To: Andi Kleen <ak@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mtrr: Check if fixed MTRRs exist before saving them
In-Reply-To: <ZZ4b6aq6s_GbpbcN@tassilo>
References: <20240105163711.9278-1-ak@linux.intel.com> <87plyajphp.ffs@tglx>
 <ZZ4b6aq6s_GbpbcN@tassilo>
Date: Wed, 10 Jan 2024 15:20:50 +0100
Message-ID: <87cyu9jmm5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 09 2024 at 20:24, Andi Kleen wrote:
> On Tue, Jan 09, 2024 at 08:06:26PM +0100, Thomas Gleixner wrote:
>> On Fri, Jan 05 2024 at 08:37, Andi Kleen wrote:
>> > This one place forgot to check the fixed capability.
>> 
>> What's the consequence of that missing chec
>
> You get a WARN_ON for a WRMSR failing if you don't have the MSR.
>
>> and shouldn't this have a Fixes tag?
>
> It's more an ancient bug back dating back to my tenure in 2007, but here it is:
>
> Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before")

Care to send a V2 with a less meager changelog?

