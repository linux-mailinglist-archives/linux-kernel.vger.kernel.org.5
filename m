Return-Path: <linux-kernel+bounces-138190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D06789EDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF261C20F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C31552F2;
	Wed, 10 Apr 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fB0n+DJw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA21154C15
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738649; cv=none; b=OeOHakt7iQUvfblwB/Ex37fqJYIBTpoeuAS26D+GRquOn7cDPkV7uDpXL7gi5iO+sL3RrvDWazidUWZW6fALZ4zrhBsqq9PcdeCvpBUGULkjar80M6RryN9rc7SZwigDE6b3NMGhPP0l9h0b6rtifKOxd1PwuQQMhdu4xFgt1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738649; c=relaxed/simple;
	bh=pZU/9L9pIBcm+gJ2VeSziov6XOhPFwUwPxGpBchtOaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmv+owItorK+/bCWX6G2aGW2aJtl325NpJOZ7FuCZxGaeTV6lKQRWQ6V9T+Z5IhSqKiAMYZ0Sw47m1bnznHzporBV9bwAEze9diNOw2pxtC4sWWnIYhJT3LloJsZN9+5Ed5MTPm38xJ+vFVI8BjMLWI4xKB7BuvOxBXC3elGnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fB0n+DJw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712738646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/8u8RiACrjH0Ov6QIh5KlQeJMTBnHt53gJzaMO3RSU=;
	b=fB0n+DJwJ8hbRNIKgHxGASCRnAqB7x1S2fkZhhzhFW17NP8I/vysXWc55fzTV1rGP4djDU
	7mgj8xm3PFzeHtq3A02LUnpm6xGp4ED2/uWL/okf7bKozd1yiqAiOId9wxA+z61lXcFwwT
	iZb/wCUwA9nr1CXx1RPxZ3saR8+IgnE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-aH8WnQUyOQu-_p1o0tHZ5w-1; Wed, 10 Apr 2024 04:44:00 -0400
X-MC-Unique: aH8WnQUyOQu-_p1o0tHZ5w-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e50208ebe6so716845ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712738639; x=1713343439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/8u8RiACrjH0Ov6QIh5KlQeJMTBnHt53gJzaMO3RSU=;
        b=ogk2zGyGnPfr8jclQW7223HOMXyXPZQmJ+z3DT926+5FoQCsDlbtxhP/Izl9VekyLz
         pXGUzfzRmVx51cp9ulKqFVGzQ/5HggAGtwV6tqfqJctflO0EGTDs389VlJgKaDTd75CZ
         KKMPXY/h8esxPTqPCEDeA7s1cjFgOKYq0FKoEN1T1o77andpSrT9TYDDvq8rFw0ae6NO
         C4sgwRkVFue/GmG8Z4pt3xugy64mfQqurSPIRsyzuNyKTBVg06OPtV5/0Zm2aG8iAl14
         8jJ8tirwZuOlF15fEWDXSJG/Zo2Iet/N5LutYEbAIPgbrJiiDuT7VssnojY+6iJooEZe
         APTA==
X-Forwarded-Encrypted: i=1; AJvYcCWZXPTJ+hHyHCcqjBwLYavWGYM7wemM/8z3L0VqImGVtu/Ro2InjulzRRgbrP2FPDIrkg2mCXWpEAQnMpvCGBrzsaqxsoOoduQxyTyo
X-Gm-Message-State: AOJu0YwNbssBlemO5nYYQHGNC00taWrAaTsHlqEwJZzuffwqPj1KbaLE
	OC9mZVjLoU2+U+YyZx5ziHR7yeALLV4FU16swziQcIpoq/d9ipCC4DNKAfZFX4OpgvVzs2yjwwB
	NQ1lRlUzBr+bd1ygnC64Z4+JibhaJ82V67KjaBjZXOGVHMVUivhTo8SsmjrhLMg==
X-Received: by 2002:a05:6a20:12c4:b0:1a8:2d22:2025 with SMTP id v4-20020a056a2012c400b001a82d222025mr2338666pzg.0.1712738638915;
        Wed, 10 Apr 2024 01:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwC+8hP4eRdQdzrRF5bUoyS6m0uCyKGnyeK7ZzH2kCnq17IDQmsibqG2jjTB0pS4pE6MLXUA==
X-Received: by 2002:a05:6a20:12c4:b0:1a8:2d22:2025 with SMTP id v4-20020a056a2012c400b001a82d222025mr2338643pzg.0.1712738638521;
        Wed, 10 Apr 2024 01:43:58 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001e41e968a61sm5696540plg.223.2024.04.10.01.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 01:43:58 -0700 (PDT)
Message-ID: <25764b88-d1a5-4b9f-b2a1-2923f1adb979@redhat.com>
Date: Wed, 10 Apr 2024 16:43:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arm64: tlb: Fix TLBI RANGE operand
To: Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 maz@kernel.org, oliver.upton@linux.dev, ryan.roberts@arm.com,
 apopple@nvidia.com, rananta@google.com, mark.rutland@arm.com,
 v-songbaohua@oppo.com, yangyicong@hisilicon.com, yihyu@redhat.com,
 shan.gavin@gmail.com
References: <20240405035852.1532010-1-gshan@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20240405035852.1532010-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/5/24 11:58, Gavin Shan wrote:
> A kernel crash on the destination VM after the live migration was
> reported by Yihuang Yu. The issue is only reproducible on NVidia's
> grace-hopper where TLBI RANGE feature is available. The kernel crash
> is caused by incomplete TLB flush and missed dirty page. For the
> root cause and analysis, please refer to PATCH[v3 1/3]'s commit log.
> 
> Thanks to Marc Zyngier who proposed all the code changes.
> 
> PATCH[1] fixes the kernel crash by extending __TLBI_RANGE_NUM() so that
>           the TLBI RANGE on the area with MAX_TLBI_RANGE_PAGES pages can
>           be supported
> PATCH[2] improves __TLBI_VADDR_RANGE() with masks and FIELD_PREP()
> PATCH[3] allows TLBI RANGE operation on the area with MAX_TLBI_RANGE_PAGES
>           pages in __flush_tlb_range_nosync()
> 
> v2: https://lists.infradead.org/pipermail/linux-arm-kernel/2024-April/917432.html
> v1: https://lists.infradead.org/pipermail/linux-arm-kernel/2024-April/916972.html
> 
> Changelog
> =========
> v3:
>    Improve __TLBI_RANGE_NUM() and its comments. Added patches
>    to improve __TLBI_VADDR_RANGE() and __flush_tlb_range_nosync() (Marc)
> v2:
>    Improve __TLBI_RANGE_NUM()                                     (Marc)
> 
> Gavin Shan (3):
>    arm64: tlb: Fix TLBI RANGE operand
>    arm64: tlb: Improve __TLBI_VADDR_RANGE()
>    arm64: tlb: Allow range operation for MAX_TLBI_RANGE_PAGES
> 
>   arch/arm64/include/asm/tlbflush.h | 53 ++++++++++++++++++-------------
>   1 file changed, 31 insertions(+), 22 deletions(-)
> 

For the series.

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

-- 
Shaoqin


