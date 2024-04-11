Return-Path: <linux-kernel+bounces-140021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153D8A0A78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621411F244B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDE813E40C;
	Thu, 11 Apr 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbK4fynY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD613CA86
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821729; cv=none; b=exm3ZKTTx9fAlSAql5oYi5WngSKZsXYyHmrl+WJEbrLVQiYXJfRDUpOEJmH2CK3ETF7JXnB7Rq/413SUGU0MZYRguOSmY50R30WuIN2rGvI41uu1pThhNITKZEuNWwFtX6ZXxQR8At644Y5bOXfoayhlLk0g8hZAwo8gJl5jbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821729; c=relaxed/simple;
	bh=r4SQLt+FKISkSF+imKemCoJcOW2/rVGXnSrxd75vBdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYfkhsrXLV/tpyqRcKZQ5U3qbEjrq+GBxppz1pAgt28chUfP00Gcru6lZ2gjzOMZ0KPrQ/1rx2zzvTKscMIivGygvlw1/oANvPF+qQV1e4kMDUM56FKYDAa3Xm+FYwB3QIzy8OFkyt6d/PnZ65RI09FA8qpb9Nc0RFSWUZdmzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbK4fynY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51aac16b6eso332518266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712821725; x=1713426525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tdl+z5zxThgZ9ReZV+OZIcBPgM7J7kLhFlcV1qmAXSs=;
        b=TbK4fynYYubFarus3K2/jjK2Ci0MeIknKaKvfnuaeesBttTx5c5OrdbMCIw1AZotEX
         HU55IIGg9YG+KiiEuf0GqUvjEWDFW7mIIiguslHLFExz5rHOPM6o70RUMPAujkpBfdUh
         ZGYlOpWKgl2UwOzf+bN0q/NRfIfqOzzPb/j3RAea/lYt1ir3gam2lLzXjekTKjfhokwb
         UAMAv59Wu2grJ+0IJlqh6u3XazKiIWTYF5Kj77BBRkZ8sB1o2906Mi6H4DLpfrxPq8fk
         ufEyQK1DeXvTFYDtBSjSPvx/TSikGTbPxdTy75ySSeWMbS92HXNKxAr0MsfcuNEr8Tq4
         1+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821725; x=1713426525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tdl+z5zxThgZ9ReZV+OZIcBPgM7J7kLhFlcV1qmAXSs=;
        b=GJ2Tgo0UBb3hC8C73oreb/5N5kDHhfidN2AzWMmQshbfpEZ5sASFiR3K4LZUFpOxSj
         ZriFbetIAnGlc1L52bvZAr2WwRgxSnzQ0Qt1sov5vjwa8O47d/oa6XyWH5VpJu8XaJbi
         06IMQyhMdHk/0vn8y/fIiE5MwKKXtwOAMsnA0UnKM49EucBDkrzDS5n6Px18xgiys5Vs
         jyOd5XLJ0aHDfURvyjbb3saSRLcw5GOoaqSwrJi45HgJ45w01jawxjq+UQOswAQNhRBT
         CMjdkyftzP/fjBnaEaEt9hLt71BUq5gkvjH+r9mupSwftAPyy8XuyIBiO58FmbHlE0eB
         QIcA==
X-Forwarded-Encrypted: i=1; AJvYcCWETEizlwKltWfdxEG3NqCu2soJ/yehVUFjJlGAsyIwTOkfcdIxu05YUjYTZsY/nGoUFRCDG+qnPxcMXDcRVgA/HljpOJR6X9weNZD2
X-Gm-Message-State: AOJu0YxTpY/Ns8jMF9k1e/aiFiWZCGWTRyQ6mjk+qW1tVRdxqRdFYOu0
	bW5yUZ3BSNAv1ph5hx6TkpGfXgSQOhUI6Jd5pqgiPanRd4Vv3pYA
X-Google-Smtp-Source: AGHT+IG8CuSwQPW9wvXUMdV4KqgZVxjI74+8LUH15hl7Umn5XJqQXpMdqHEREMveaevNSMdH5FlFKQ==
X-Received: by 2002:a50:8ade:0:b0:56e:2cb6:480e with SMTP id k30-20020a508ade000000b0056e2cb6480emr4468455edk.38.1712821725223;
        Thu, 11 Apr 2024 00:48:45 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906354f00b00a5195ee5d62sm484426eja.164.2024.04.11.00.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 00:48:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 11 Apr 2024 09:48:42 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 7/7] x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with
 CONFIG_MITIGATION_SPECTRE_BHI
Message-ID: <ZheV2ly/LZjpaVTE@gmail.com>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org>


* Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> For consistency with the other CONFIG_MITIGATION_* options, replace the
> CONFIG_SPECTRE_BHI_{ON,OFF} options with a single
> CONFIG_MITIGATION_SPECTRE_BHI option.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/Kconfig           | 17 +++--------------
>  arch/x86/kernel/cpu/bugs.c |  2 +-
>  2 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b63b6767a63d..4474bf32d0a4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2633,27 +2633,16 @@ config MITIGATION_RFDS
>  	  stored in floating point, vector and integer registers.
>  	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
>  
> -choice
> -	prompt "Clear branch history"
> +config MITIGATION_SPECTRE_BHI
> +	bool "Mitigate Spectre-BHB (Branch History Injection)"
>  	depends on CPU_SUP_INTEL
> -	default SPECTRE_BHI_ON
> +	default y
>  	help
>  	  Enable BHI mitigations. BHI attacks are a form of Spectre V2 attacks
>  	  where the branch history buffer is poisoned to speculatively steer
>  	  indirect branches.
>  	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
>  
> -config SPECTRE_BHI_ON
> -	bool "on"
> -	help
> -	  Equivalent to setting spectre_bhi=on command line parameter.
> -config SPECTRE_BHI_OFF
> -	bool "off"
> -	help
> -	  Equivalent to setting spectre_bhi=off command line parameter.
> -
> -endchoice
> -
>  endif
>  
>  config ARCH_HAS_ADD_PAGES
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 74ade6d7caa3..4c46fa2d08c2 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1628,7 +1628,7 @@ enum bhi_mitigations {
>  };
>  
>  static enum bhi_mitigations bhi_mitigation __ro_after_init =
> -	IS_ENABLED(CONFIG_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
> +	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;

Uhm, after this patch there's no CONFIG_MITIGATION_SPECTRE_BHI_ON anymore, 
which is kindof nasty, as IS_ENABLED() doesn't generate a build failure for 
non-existent Kconfig variables IIRC ...

So AFAICT this patch turns on BHI unconditionally.

I've fixed as per the patch below, but please double check the end result 
in tip:x86/urgent once I've pushed it out..

Thanks,

	Ingo

=====================>
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 80d9018da3d2..25111ad388d9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1628,7 +1628,7 @@ enum bhi_mitigations {
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {

