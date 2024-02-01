Return-Path: <linux-kernel+bounces-48052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FBD8456AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439F91C23AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D489315D5B2;
	Thu,  1 Feb 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ9eaTew"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5DD12CDB4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788670; cv=none; b=hEM04NRPkpnByzJKdtbog+AFcsSL1mqZ7OhN5dEyZIX/5sR1NIZ2m1w/aWh/DYe2dsVsz6Djt0HyMIUmGcmIiuSqSaDR9IrdkEv5zx3DmOl2sZLe4DzhFpQU7NRjLzxbjFOHq1NSnkASlHE/uOLNlTXrY6bcH6MC2bZmvLnar/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788670; c=relaxed/simple;
	bh=mUw9QBw6pQM2qZYSxHpKbKIjaHzlrcyFKT2XZgI3KL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XFnfxiNG0e/W5ba4Svv9Gc/LlOkCi595zCjTBqkwSwaBIEm9S3CimggyspFlD097q+9dBv1Ccbu6cVEEYim2KZcEo5+Lzu7O72UxELXmmnJVvlR3qSBRhTON4v5IK13HBPRdce3U7Fihi0OQ8A5DbP48hZNq6ZKDMUoX2Pm3mW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ9eaTew; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da9c834646so572515b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706788668; x=1707393468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpF8lNtVtYc8qMZP5Nps3Nw9hB/q8N4bWH9miAWBlJE=;
        b=gJ9eaTewFc8vZaqz7GFZdVkqZbcjpTQ2E5WaBtwaeu6BdJWfTidb+8h0XpYkJjOEug
         xqdRwQCRLdGaqQLy7HZ0Pny+Lzkdq7WpZUukChIQuFbDpJds+EUp01gdsipSZOBWPnu1
         LXAj0ajeDeEl1PX0kE44DR/rxhgkI7iPU5gGQRpsIF7Ag8T1mjQG6vpFFgv8Hao6t7sl
         JCUUng2Vu2vEGU9mWEtEWrZW2yWbvQyMzU6Yz6ZB5lOFza6Rovrz5WceXp7HDxlUObUr
         zzhe9vgTkkwFpZ9muqfz54oLfYZJjSANvvImP+UUwVy17TQQSAJPdV5tJe4sSRnIn3RX
         nt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706788668; x=1707393468;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpF8lNtVtYc8qMZP5Nps3Nw9hB/q8N4bWH9miAWBlJE=;
        b=kZX2TtAY+Gk2yejwnRKE53pRd5Z8kmFhnpDzfQPzxwv2zS8QLWxXZLjFCRmTUmOUW0
         ZNR6K82YAUQqeGhGF89gsHzSxaomVsPEGnZ29Rs2uMVLzjSqVDp7qsi+SRb0oEzHPU4b
         X9cWrO2ZBYAXL52GcFh2OYd0xI6FdEw6lvUPb+VHuEcNBDv8iAKKwgED0YjMHCHBQKSY
         CwrKHLVtyQZHTO4tCyL806gkbG2emrX2ba+0giJPVPJ8m2yfsesh24WafaKToFRhrAez
         5aNNWrdL7lzgLrkYRFhOcJGn9rCAc/up15ykvAEXtxityzlSDVFvz/vANGm2GY0czQHF
         +/lg==
X-Gm-Message-State: AOJu0Yya8vvNK6shGpoeHeiOtfLd3kPue9kZShjuufV3d3pezRxEDaGB
	go+oePH+UzzuODofE1JdgugdWP17S46l6Ar6LCkd6Btvtt6vYpyWJSmuGrYfGfU=
X-Google-Smtp-Source: AGHT+IG7Ix9Y4fYjGM4zih3YmcVkTMwTMXIx9s+VAcbetlN2AQRBPxEvp3HKcRo3OIgXIWd5fw4iyA==
X-Received: by 2002:a05:6a00:17a1:b0:6db:a1f9:a7b0 with SMTP id s33-20020a056a0017a100b006dba1f9a7b0mr5387376pfg.21.1706788667962;
        Thu, 01 Feb 2024 03:57:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUV2DhyypLh0mUqNS/BpKB/VFUMgm66APOuStkHvO7csqTRyPKe86oE7w2BprZkvwouxvyytR3wY1B2fwN6/GXVvlfhRLQkYV1CEc8phY60/vZqiSya7woSrM0J2i55/ZaB+79MeMzTfM4eIgknTvyz/urvzX7WFQ==
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id ks19-20020a056a004b9300b006d9a7a48bbesm11754439pfb.116.2024.02.01.03.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 03:57:47 -0800 (PST)
Message-ID: <d9a902ac-4a0a-4ee6-a84c-aff4c0e42a87@gmail.com>
Date: Thu, 1 Feb 2024 19:57:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] objtool: remove unused parameter
Content-Language: en-US
To: alexs@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20240119040241.2925185-1-alexs@kernel.org>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240119040241.2925185-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ping

On 1/19/24 12:02 PM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> Remove unused file parameter from init_insn_state(), insn from
> has_modified_stack_frame().
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: linux-kernel@vger.kernel.org
> To: Peter Zijlstra <peterz@infradead.org>
> To: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/check.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 548ec3cd7c00..ecc56a5ad174 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -274,8 +274,7 @@ static void init_cfi_state(struct cfi_state *cfi)
>  	cfi->drap_offset = -1;
>  }
>  
> -static void init_insn_state(struct objtool_file *file, struct insn_state *state,
> -			    struct section *sec)
> +static void init_insn_state(struct insn_state *state, struct section *sec)
>  {
>  	memset(state, 0, sizeof(*state));
>  	init_cfi_state(&state->cfi);
> @@ -2681,7 +2680,7 @@ static bool is_special_call(struct instruction *insn)
>  	return false;
>  }
>  
> -static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
> +static bool has_modified_stack_frame(struct insn_state *state)
>  {
>  	struct cfi_state *cfi = &state->cfi;
>  	int i;
> @@ -3474,7 +3473,7 @@ static int validate_sibling_call(struct objtool_file *file,
>  				 struct instruction *insn,
>  				 struct insn_state *state)
>  {
> -	if (insn_func(insn) && has_modified_stack_frame(insn, state)) {
> +	if (insn_func(insn) && has_modified_stack_frame(state)) {
>  		WARN_INSN(insn, "sibling call from callable instruction with modified stack frame");
>  		return 1;
>  	}
> @@ -3504,7 +3503,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
>  		return 1;
>  	}
>  
> -	if (func && has_modified_stack_frame(insn, state)) {
> +	if (func && has_modified_stack_frame(state)) {
>  		WARN_INSN(insn, "return with modified stack frame");
>  		return 1;
>  	}
> @@ -3814,7 +3813,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
>  	if (!file->hints)
>  		return 0;
>  
> -	init_insn_state(file, &state, sec);
> +	init_insn_state(&state, sec);
>  
>  	if (sec) {
>  		sec_for_each_insn(file, sec, insn)
> @@ -4221,7 +4220,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
>  		if (func->type != STT_FUNC)
>  			continue;
>  
> -		init_insn_state(file, &state, sec);
> +		init_insn_state(&state, sec);
>  		set_func_state(&state.cfi);
>  
>  		warnings += validate_symbol(file, sec, func, &state);

