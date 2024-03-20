Return-Path: <linux-kernel+bounces-108415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8A880A37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 974FDB22B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9FC11C83;
	Wed, 20 Mar 2024 03:54:31 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22F11712
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906870; cv=none; b=dZXPFnUos1dPdSr7eoKIgtb/fkbwdMKa0cwZtIpijc4bqGpuAU8iC/MVmRPmFQJgt61jyLUGYJO1r/wrAPV0uA37Sf7TcId2nxXSFHhyikCM6e58sFstxnN8dla73zTeEa92xRUKsXaoJL5Qnwf5yq06gj8wnegVw2LDq4jpdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906870; c=relaxed/simple;
	bh=XVB6+9HFSTGPkmI81vMP7oAx1uomsLy1PXz5e4m89X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5paH4S65v5RBaJ4LSfjxVLZEpVVKTou11YVbOoERaHNGCBS8ZvIIP1No60iTvYq7bchw5Cz2buQKZCZ2S3BOSUPg5ng5tNzud9NnbKE9HqXuEgGyb0bynIy33OSwz5Y8dZ5kQ/54L1QTZz8K25BHp0n5i9I2IlREzn1QIKJv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42K3sPLu062256;
	Wed, 20 Mar 2024 12:54:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Wed, 20 Mar 2024 12:54:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42K3sPRp062253
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 20 Mar 2024 12:54:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f9a8a442-0ff2-4da9-af4d-3d0e2805c4a7@I-love.SAKURA.ne.jp>
Date: Wed, 20 Mar 2024 12:54:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] x86: call instrumentation hooks from copy_mc.c
Content-Language: en-US
To: Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, tglx@linutronix.de, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
References: <20240319163656.2100766-1-glider@google.com>
 <20240319163656.2100766-3-glider@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240319163656.2100766-3-glider@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/20 1:36, Alexander Potapenko wrote:
> @@ -61,10 +62,20 @@ unsigned long copy_mc_enhanced_fast_string(void *dst, const void *src, unsigned
>   */
>  unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigned len)
>  {
> -	if (copy_mc_fragile_enabled)
> -		return copy_mc_fragile(dst, src, len);
> -	if (static_cpu_has(X86_FEATURE_ERMS))
> -		return copy_mc_enhanced_fast_string(dst, src, len);
> +	unsigned long ret;
> +
> +	if (copy_mc_fragile_enabled) {
> +		instrument_memcpy_before(dst, src, len);

I feel that instrument_memcpy_before() needs to be called *after*
copy_mc_fragile() etc. , for we can't predict how many bytes will
copy_mc_fragile() etc. actually copy.

> +		ret = copy_mc_fragile(dst, src, len);
> +		instrument_memcpy_after(dst, src, len, ret);
> +		return ret;
> +	}


