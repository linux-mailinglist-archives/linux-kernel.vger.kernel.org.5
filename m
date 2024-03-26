Return-Path: <linux-kernel+bounces-119142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB7588C4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A868E1C2493B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A536612C537;
	Tue, 26 Mar 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b3SaobVR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77712BF16
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462118; cv=none; b=rP6lQY/JX4ipfG1ILPjYkkhRS5tGAt74ST/Q/f8GCSuJTRexDraVZR9u1A1r7rS6rY1SM6G9LxY/IZmXvc23aAVVPg1/sRRrbcs7EeBOxeFxizS8gQEQZzA3ekUys5EydwM5vrmF4jlMuIvvQICU5he/SAonwhTju2iYqJkdnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462118; c=relaxed/simple;
	bh=H9izA/lQiWHlnDwGXQxIvtyKYDgd9sg98U7wX2vy0O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsAy7dNSsH8RNqIuFlw9+k0TTCaLxFsmAO1iN2GNsScwvW20RnLMyhKlhhk+FO3PlWkCDXUS3ZSmGcCNXLrgOTWvXI6MdDQ5NMXg2m8nbX1VmyzCq/8hFjqvP2w5NqXtKbPl8fccYomVbXah5LIW1K0pTqR0ZUSK7oRsq1nUdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b3SaobVR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341cf77b86bso1367343f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711462114; x=1712066914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFJbNRl2jhD1FZpGYS71X7jv5bIbfTuIVkI+Wa5VuaI=;
        b=b3SaobVRgRWqVZLcJYP0UAA6c/7h7ZJl6A/vi5euhaKPZLQ8B4/kgEk66s8+Aa10Ab
         JVqu1+TLFgU+9ON3peVpLzh/zAwuws/xzKQPekgHGVv41/fl7fFn0mawOvhpTxBi16Jr
         JR/2lghftcVbWFFXGKDbvSX0eWtLtjAj+zF1kyZfexO4vn9MrCpc4Lpk0V2jjrQa28a8
         r01vPlpteZFt/vnK1zDc60yR7vbD3f+SZY4/30n8RUl1kz//LBHuqRVGelfKCRnyjZ6f
         72JodPV1l5m8nnnNwIvXm/IQUwqBVooO2BLQVg/IWLRDp/z1uonZdqIS3B1AOyevu9aB
         pt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462114; x=1712066914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFJbNRl2jhD1FZpGYS71X7jv5bIbfTuIVkI+Wa5VuaI=;
        b=lmOXdoCByn5C9E5pY9fh6yi1iRRJ3DDguPYurnpsiPJrUGiUbgSQHF40oEUKHIpRHO
         zrO9+feuu6MCjpWvhHG/w36vV4xPqWcHKL+LDxZq1QTzxcTvOQeMj6amG1/wNh+aOqyp
         42QwALG/s67CUqX6+Go05/QGVfvUvBLLVGtMgxrXn7bLrrFFMsWTIkbcqVpkjGk5oko9
         qSVI3994ul9lsVwGvBH9IqKpkcdkhd98HtXmbNXZSxrIw7+mQDoSkW7AmqAvqySwoVAA
         jodQrrUDv/TfXdg0+w+kbfS24EBoNQ6gh4tYYIQ1aAlx/jzkom4jHsQ5Bfamxhg3jsxl
         +BIg==
X-Gm-Message-State: AOJu0Ywa9HC+DFXcmQ3lOLHUlkCTO9qMdCXxvIPKVg3dgvp1Duk1IaRE
	G/L29IyBLDYtXmyM6jJ7/GGxHh2lEDyAQ3JS2OLqKRCwNzxvzi+cKEpnrZwNB14=
X-Google-Smtp-Source: AGHT+IHKUElEqaaxp98nMy5WgUMOMYWKGDZV8R4KWfQ+pKoXJ+gH4dr/mkDaMan6kmWdlO77Ps2aWw==
X-Received: by 2002:adf:fd07:0:b0:33e:7c3f:ee0f with SMTP id e7-20020adffd07000000b0033e7c3fee0fmr6663741wrr.28.1711462114116;
        Tue, 26 Mar 2024 07:08:34 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:73fa:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:73fa:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id by19-20020a056000099300b0033e7eba040dsm12362850wrb.97.2024.03.26.07.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:08:33 -0700 (PDT)
Message-ID: <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com>
Date: Tue, 26 Mar 2024 16:08:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unpatched return thunk in use. This should not happen!
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Marco Elver <elver@google.com>,
 kasan-dev@googlegroups.com
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26.03.24 г. 14:40 ч., Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, Linux 6.9-rc1+ 
> built with
> 
>       CONFIG_KCSAN=y
> 

So the problem happens when KCSAN=y CONFIG_CONSTRUCTORS is also enabled 
and this results in an indirect call in do_mod_ctors():

    mod->ctors[i]();


When KCSAN is disabled, do_mod_ctors is empty, hence the warning is not 
printed.

