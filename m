Return-Path: <linux-kernel+bounces-92712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A90E8724D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2661C217CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C21DDA7;
	Tue,  5 Mar 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="goTFMAQt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxJ4UUkV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51EDDB3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657456; cv=none; b=gNkLf1Qs4ei7nsOo8kZk61pTcUDvfXEKGswx6SAAtZPe4M8m1Kc9QzsWD4OE4xOMJSy16bJBRWU3kzAhWERlhs+6To4cRte/FZ/RtcgFJJvQ9v7VXzbwWEGy4SjDXjncGoy+zTEc4HHj99zsY054VtI8yFYytApT79OiVfBZB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657456; c=relaxed/simple;
	bh=/czM1to18GyklSjPalpolZHpMa2KefWb0zNihkLXQPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G2BuajU9WHnBXPCqxorY/bskwl+uudj7HBdNVsUyS0U+SIBF5K5PrZbYainzkeOcQToPN8a8hIQ9+hR6XjbMtuQUcJOCIWqKYGKPnKmRTYC/ATBc/nVeGvGtImeX0I+RSXwgA7/JEuKrmm6pLKlmQd8+qkpekSnX53y8fDRSStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=goTFMAQt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxJ4UUkV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709657452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hlmQlLMlayfFzLpIbgYp3Xuxdad+NM4BJi9zn3V/LbY=;
	b=goTFMAQtUDYG4StVi/S6RvagEcrITPQ3gz2e6fS6/91WMTcQTu20S8raGJDRSLYrCRcqGX
	bvnu56KDPziqo5mkWTVh1r4GUtN4IM4sHNagP16Z3tiHYGcy5gJ1OeMt2Ac7Y3rjh4SQUS
	DhDOpYHAojnfB4C1Wmkejgw8Js/q6bUE4typjLyyYIDUGNdM6v//M+mE02v131U78RNETo
	1Qzt9Ux9GpTMI/1WVzVVwjhmUI1i2hgc+Sn1ijJihRQ/5/aDNaVQeCvzgobHHCwPsklxHc
	QZvCCkcyU/7F2fJyia88SqQyqBlUjiH4RDOqpOzlRx67tbJfzjohq37PJUj16w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709657452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hlmQlLMlayfFzLpIbgYp3Xuxdad+NM4BJi9zn3V/LbY=;
	b=bxJ4UUkVpVI9POFazLErv4cOKxtnZGxAtbPU55ucR5AJSSbW1rShDi0RD9a2k/c99nXIuh
	X8TNEJtYxCwkPwBQ==
To: Dave Hansen <dave.hansen@intel.com>, Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>, LKML <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] x86: disable non-instrumented version of copy_mc
 when KMSAN is enabled
In-Reply-To: <74d900cf-ab90-49ea-ba55-380d7df59526@intel.com>
References: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
 <74d900cf-ab90-49ea-ba55-380d7df59526@intel.com>
Date: Tue, 05 Mar 2024 17:50:51 +0100
Message-ID: <87jzmgvd04.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 05 2024 at 07:21, Dave Hansen wrote:
> On 3/1/24 14:52, Tetsuo Handa wrote:
>> -	if (static_cpu_has(X86_FEATURE_ERMS)) {
>> +	if (!IS_ENABLED(CONFIG_KMSAN) && static_cpu_has(X86_FEATURE_ERMS)) {
>>  		__uaccess_begin();
>>  		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
>>  		__uaccess_end();
>
> Where does the false positive _come_ from?  Can we fix copy_mc_fragile()
> and copy_mc_enhanced_fast_string() instead of just not using them?

All it takes is a variant of __msan_memcpy() which uses a variant of
copy_mc_to_kernel() instead of __memcpy(). It's not rocket science.

Aside of that, this:

@@ -74,14 +74,14 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
 {
	unsigned long ret;

-	if (copy_mc_fragile_enabled) {
+	if (!IS_ENABLED(CONFIG_KMSAN) && copy_mc_fragile_enabled) {
		__uaccess_begin();

is completely bogus. copy_user_generic() is not at all covered by
KMSAN. So why fiddling with it in the first place? Just because it has
the same pattern as copy_mc_to_kernel()?

> The three enable_copy_mc_fragile() are presumably doing so for a
> reason.

Very much so. It's for MCE recovery purposes.

And yes, the changelog and the non-existing comments should explain why
this is "correct" when KMSAN is enabled. Hint: It is NOT.

Thanks,

        tglx

