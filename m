Return-Path: <linux-kernel+bounces-98858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5A87805B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399D61C21379
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B243D3A7;
	Mon, 11 Mar 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="McIIT54j"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB83CF7E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162975; cv=none; b=bR4asFmliuqS9n4vbeECtlmMLnetuiwL5oShU0zn/MEuNUCKQVEa72CVBGr9ViOfSgfVCMZpAJY6KBzWYXmOf0ePdfJEgdYSE27qhKQR2RbUvvGQbova4fLfYcSFIx0ab/wb7Gist9M8olBg5XOeg2rW+69A/un1/7seRgGAZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162975; c=relaxed/simple;
	bh=R83UERplwF/KQ5zSe+MgQMSo687FJg2FimupNdkCCUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBdwUHaYoSWn7T0yQEb0dGCeQ/a2YHl7gbq3WFRQ82VPOufRA+502fBzTe+KNBUrnKKsep22C7g5p5dXl/LKB4Nvdc1I5FsIpZTmmJbrwwHtyu5pLD6td1cmw9K0w1GS3liIP9Iz+hKAt6zQOGX6xZA1EjN9WxxTwJnfTpfX6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=McIIT54j; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so59300621fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710162971; x=1710767771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sw4tENrKm2Q6sGgH1kKiwJ8p2ROgVDUkRiPZUykVBHw=;
        b=McIIT54jWllkjZnN85iFKUWpsBR41/y+Ie+2JWIi5STrJLAy+K2dAOFlUuxnLef0ex
         mEp+t7fKc9A3j9pDVSQk+fAbRGUdo0oVcVXM+/v/5F1NOc1GTxnXEPrjbpWAgJFvEYrj
         DQMkrg8S5BUycySGwTVJbGsKxmVW2UUblmQ0VE8sWma7ND2Jsi8LsiViAHN9dhhnveTh
         voJcbJvQcb++mWqtcBVc98JcheanP6unMjE7QqCk08nA9nUqTIjHLMjKS778hCWImkLy
         voptMbyPWKpH3+Vla03h0bGmwjRe3Q3cjGEpPt7mMRjg/7e5KInkk1TVHeO4a0ZEpCi5
         EQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710162971; x=1710767771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw4tENrKm2Q6sGgH1kKiwJ8p2ROgVDUkRiPZUykVBHw=;
        b=m8fQbc2Vm6aSUx5AyilVMgDMlsKD7DoAfPrd/d1wMTQcbdpmkxv9lTHyDcJ3kPv+Wg
         UkP3clzJdNPxyNAyqO9yRQzH75i7gEnx857uxvFkz8b+Rh6QURlXvKWjXPal81zcacfc
         64oXIj4p5VtJGgWGqj/H8WW+73LQGPYglJOcpI54FhaX3fBofkxYSckwku1uiE4XN5qw
         HLv6++jy8MVdr7zcIZjQV6UwQoufsK8Bk8mrwuTvnBqc85uGu3EeieJOmI9hhS46nx6G
         V4DQrddIv2vKUgtfFh18xc/IE4gxyVzel99h3Xvg5A4+s/arqaBjKaw2FHMc1DezJXJq
         mwSA==
X-Forwarded-Encrypted: i=1; AJvYcCVTgqlYroud/s8xEcaE8rtdeSwaAeSVd+IrT8wycX/HXoTnjyd23nKb31pTEDFhTXGQ8fIMDCt0/EZM6aEYJP7lHXSOzxmJlgKUpbGJ
X-Gm-Message-State: AOJu0YwuEGHfxw7PLrbKbKLF9rE7fVMzkd9f23SbFxSzYtM5pB/GRuyR
	Lxfinos85Weqrc9yPGJjn91xBxJVNTKjKdWhe5yhAoCHndmsnFiCrPpQdenO72fSEaYGh4gAPC6
	h
X-Google-Smtp-Source: AGHT+IEIykn5pR2lAPGY3OjFEnaMje7wcvAv6WYUVhhakvp/PSb+swLecLc6+LkuX8uqyRwQmHOP3g==
X-Received: by 2002:a2e:aa26:0:b0:2d0:aa06:f496 with SMTP id bf38-20020a2eaa26000000b002d0aa06f496mr3695777ljb.40.1710162971012;
        Mon, 11 Mar 2024 06:16:11 -0700 (PDT)
Received: from ?IPV6:2003:e5:873a:400:704b:6dbb:e7c0:786e? (p200300e5873a0400704b6dbbe7c0786e.dip0.t-ipconnect.de. [2003:e5:873a:400:704b:6dbb:e7c0:786e])
        by smtp.gmail.com with ESMTPSA id f5-20020a2ea0c5000000b002d417020a9fsm1133150ljm.83.2024.03.11.06.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 06:16:10 -0700 (PDT)
Message-ID: <3891dbee-173b-4fb3-a7f5-512dbe8264af@suse.com>
Date: Mon, 11 Mar 2024 14:16:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 02/34] x86/xen: Remove early "debug" physical address
 lookups
Content-Language: en-US
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com, pbonzini@redhat.com, tglx@linutronix.de,
 x86@kernel.org, bp@alien8.de
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183929.E17C1B9C@davehans-spike.ostc.intel.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240222183929.E17C1B9C@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.02.24 19:39, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The __pa() facility is subject to debugging checks if CONFIG_DEBUG_VIRTUAL=y.
> One of those debugging checks is whether the physical address is valid
> on the platform.  That information is normally available via CPUID.  But
> the __pa() code currently looks it up in 'boot_cpu_data' which is not
> fully set up in early Xen PV boot.
> 
> The Xen PV code currently tries to get this info with
> get_cpu_address_sizes() which also depends on 'boot_cpu_data' to be at
> least somewhat set up.  The result is that the c->x86_phys_bits gets a
> sane value, but not one that has anything to do with the hardware.  In
> other words, the CONFIG_DEBUG_VIRTUAL checks are performed with what
> amounts to garbage inputs.
> 
> Garbage checks are worse than no check at all.  Move over to the
> "nodebug" variant to axe the checks.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


