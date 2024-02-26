Return-Path: <linux-kernel+bounces-82128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95A867FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56DD4B21EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743B12F365;
	Mon, 26 Feb 2024 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGgoFCLf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R9JB9LDB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767412E1D5;
	Mon, 26 Feb 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971575; cv=none; b=K8WQjCyhLYCYQCzHw7/RDaDB7OFG5VNcNrN1XEtIEVFCLTJZ9Vt2PJiQPU/k2eOertTiNVRMh61Z0A3BQsq9JIvTByDfdvsjOdYherWsZz7K8cjb7mRZ7pSQlfmQSP1k/6SE5koq1M5MMVIT+YGNXcPmT3h+UlkidknwadWHDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971575; c=relaxed/simple;
	bh=Z/5vyQkhSyY8T3YX1ooj4Fr7eQCk9ePPjokpVbkSqFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NhbEmNVF2Ocl8ZtHgrmmGQ2ujxlVSpJrATLsJQQgaf1I1kt10+jK01z1k/wJqzwF6crmVjQgjKMI4cpCRwNGkXiO74vigHLh/sDxqulYTW72IvqlMcspRzBttmi8aNIIArFfJfpevYf8Gq8qjJ1Hc0PIVn0KjnkIH6bh39PxsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cGgoFCLf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R9JB9LDB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708971569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp20KoVGhhuk462r1NDh+rcZQEgIkTFGl1UxvwRBJaw=;
	b=cGgoFCLfQcqJ1fg68sh454LSjikqBCUVAWYFAU4O/KZKlJhgwii0CGSisqn7oBGT5YVDmF
	cC/y/wMth3aVBotgTt6wxehD+e60oU0d+cTPH14wM0a9yi07KF7+0J2REehdrN2UTrrZlQ
	+VRSLQ1YqBUacySwFXC7NZhbROGiwGn2CpLfbhOwAF4+kTZtSg4UAnG49OPC5uXBkv1Ueo
	aRAg8J1bkHgTwaHTvVLfsbxy/RTuzgrAvBcP5EcErr9w/ctH+Wjz+wWU5QPVD8Whm8COHq
	4cF3hSHKCsXlqJWTO5dcS3bWYz9Z5/ZG12E08VDOnSjY9JSt2+zz006q7kgl5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708971569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp20KoVGhhuk462r1NDh+rcZQEgIkTFGl1UxvwRBJaw=;
	b=R9JB9LDBVcIFfUTLLMSYBP7+YDFdXrdV1gD034EG9WW0b5726XFh9fOnvaik1VCNtq+v/d
	JPS/bDs0hfJP7RCw==
To: tip-bot2 for Ingo Molnar <tip-bot2@linutronix.de>,
 linux-tip-commits@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org
Subject: Re: [tip: x86/apic] smp: Provide 'setup_max_cpus' definition on UP too
In-Reply-To: <170894808668.398.2149303099223176501.tip-bot2@tip-bot2>
References: <170894808668.398.2149303099223176501.tip-bot2@tip-bot2>
Date: Mon, 26 Feb 2024 19:19:29 +0100
Message-ID: <87o7c39jgu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 26 2024 at 11:48, tip-bot2 for Ingo Molnar wrote:
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -218,6 +218,8 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
>  static inline void kick_all_cpus_sync(void) {  }
>  static inline void wake_up_all_idle_cpus(void) {  }
>  
> +static const unsigned int setup_max_cpus = 0;

Oops. I missed that when looking at the patch. This is in a header file
and will be instantiated a gazillion times where ever the header is
included. It want's to be a define, no?

Thanks,

        tglx
---
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -218,7 +218,7 @@ smp_call_function_any(const struct cpuma
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
 
-static const unsigned int setup_max_cpus = 0;
+#define setup_max_cpus	(0)
 
 #ifdef CONFIG_UP_LATE_INIT
 extern void __init up_late_init(void);



