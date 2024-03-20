Return-Path: <linux-kernel+bounces-108668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA242880E33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA0128380F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2138DF1;
	Wed, 20 Mar 2024 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IaS7zYhi"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE0411720
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925388; cv=none; b=K6VHLcDMbld5CurHfTelBf2L14a1M+4S8pOXgm3zZ9FqRcE2wrrZxZOK/e1jMbAlCz2OV96VPWPOFTB77jKPQPuLspkSK+IS+LNzN5VtSl+V2jyRF8Ky1PzUq/KPvz/AG6aL9+dJowCKELsDN+wG62pAtFJLFIdCEVNP6BoTfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925388; c=relaxed/simple;
	bh=BZa6c0MGicxhcKWAIIPG4HIyh39wkSHV3YBPceFQLP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NngcNgMW/RiwEq2oJCmliqwUqPzZUp3mcT/DI0BoZmQHHowhxHhxZ5Lj1VSTA8CDtLCQDsHF8pbXUGlfHCjCnk4Q/52scS3GxaELG1S3FGewB4ANf2shvyCxsPMTuEyRx/KeLv1qtvTtpluc46fHopP5hM/fN3Czl9ZGF+9W+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=IaS7zYhi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46ce2bd562so358478366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1710925384; x=1711530184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e853/CIeP1boPVzJEG82oNvtub+iVamjhYN4igRh6aQ=;
        b=IaS7zYhiwdHxCCAlvqU905poz5kD2P4V9ol+h5yoNk8HHKjuJPSTmDYKh3P1x4qFkk
         VP8MQO2jJlk6wa2jPq7KjTN1hFgmT5VOKoeZhHmTxmdd+wtG0hlZEnUbnOrJvmQ5WZV/
         HaXsQTbgh9sdBDXlThO6PCVc+Z2wJ96qKyZls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925384; x=1711530184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e853/CIeP1boPVzJEG82oNvtub+iVamjhYN4igRh6aQ=;
        b=hU5Rh9qIq0SmgvrS/w6bg5TGQGshbZMfJvczKOMtHRJge8LH/SqlQqQw+c/unQQVtx
         UKW6v1vUpMrUIMak12oStwcfhps3uLsmQ2CiBrb/IRu3iv5S9Cq59fqKACQ37WflXro6
         solPlHWt77UFIeDmaJ0IUQ5PWaBCb78zQOpVMXRb9HDwwJEpmgRDuw1M8qrM6/qe70rA
         MugjgWTc+ww1tPSOQsL40H9MIdL6NGwmYADFf3IxBF/A3EWNKgPSxbkUGH2vJYvw8A4+
         e/8Z0gVuOGVKVKNcvKXceMfJY0zfC4Ws7pXSFzGXOE+1nyCkCPOu02PF6cqr2IpXRuiI
         Gqcw==
X-Gm-Message-State: AOJu0YwTdUKYnnVTy+TM8m/aBj0XGOG8mJjXk6VENMNYvKHMs0krmsob
	TD4HS3CNjL9qP/3PUBnRbDEvImi5/SiK0J1VpFAvyIc8hh+7J5TUaoL20cJhOjU=
X-Google-Smtp-Source: AGHT+IEzSIozknXdMtfg/ffmQAHJeKDwUz3ms35ZBf0kMM2VG2sU0KvBfz9FKgUnOf/x+b+e1GISkA==
X-Received: by 2002:a17:906:264e:b0:a46:c11d:dd05 with SMTP id i14-20020a170906264e00b00a46c11ddd05mr3741140ejc.57.1710925384086;
        Wed, 20 Mar 2024 02:03:04 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090670d100b00a46a04d7dc4sm5108801ejk.61.2024.03.20.02.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:03:03 -0700 (PDT)
Message-ID: <5a6f58c5-40f3-4c89-8988-a9fee932e3ca@rasmusvillemoes.dk>
Date: Wed, 20 Mar 2024 10:03:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpumask: Create dedicated kmem cache for cpumask var
Content-Language: en-US, da
To: Dawei Li <dawei.li@shingroup.cn>, yury.norov@gmail.com,
 andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
References: <20240319122400.399516-1-dawei.li@shingroup.cn>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240319122400.399516-1-dawei.li@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 13.24, Dawei Li wrote:
> alloc_cpumask_var_node() and friends allocate cpumask var dynamically
> for CONFIG_CPUMASK_OFFSTACK=y kernel. The allocated size of cpumask var
> is cpumask_size(), which is runtime constant after nr_cpu_ids is
> freezed.
> 
> Create a dedicated kmem cache for dynamic allocation of cpumask var.

Why?

> The window for creation of cache is somewhat narrow:
> - After last update of nr_cpu_ids(via set_nr_cpu_ids())
> - After kmem cache is available.
> - Before any alloc_cpumask_var_node() invocations(sched_init() e.g).

OK, so this sounds somewhat fragile. It's maybe correct, but I fail to
see what is gained by this, and the commit message does not provide any
hints.

Rasmus


