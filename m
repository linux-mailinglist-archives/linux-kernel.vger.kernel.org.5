Return-Path: <linux-kernel+bounces-146495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6813B8A660F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5155B244F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C087153821;
	Tue, 16 Apr 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkrD72Sp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A175A3B78D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255945; cv=none; b=ZKNZW3dnQ43RgVdTRnNuS4K6MsjSPaRqFZEW+hPCdGNUeIoHACwYU8xfQjE1dP16ZuXLo1ra1Ymup57qsid/DpChcYk9eAMUzFdaOQ2K81PoNaD6ga1SsZi9GwTbXuBXMgdVzc1e2XxM06jG1z1eAmYNVuhcpBD1Kf/wHov3S04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255945; c=relaxed/simple;
	bh=h9QGKmmAl3E+10Y8FZ97vaLKSeogYohkbJTw71ZWmXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzPJkXewqqvLt+tiyXXtJbT+sHIx10XFqXyodpTTwE04BjhKw9xNo0uL6Yz48MZnpdNNGm+eRzkVzTzlv/wsgvEyVVJfzN7CdyNL3d+WuphmyX/xLQ9lEPUES5xgNFSP18j1DJCbCRsPo04zrG/9PPcAtdzw8Ss6UXNbv4Rpuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkrD72Sp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713255942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlRGwveZNaKTf/vaEO9gfk6UvaP7DHItsQdZ9LD5yHU=;
	b=LkrD72SpOG7fLZaC6CDyeDwEvw0KgcJJgQi9h3ABxX45hpQkP/nhjMdPCYQ4JiS++L0llL
	HbAcuKRxfagMxH7XXuKa7MdPcFUVl5LFaAAtNfM+upbTifOutgtzoU3xYkvPgWX5MvZd/X
	4py3tBYqLJNKRO/kWlN3Aadi792J6ps=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-pfTzIxqRNfylM1b9IYORBg-1; Tue, 16 Apr 2024 04:25:38 -0400
X-MC-Unique: pfTzIxqRNfylM1b9IYORBg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343d7cd8f46so2946996f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255937; x=1713860737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlRGwveZNaKTf/vaEO9gfk6UvaP7DHItsQdZ9LD5yHU=;
        b=b/qrYfBGFr7vzeSXmFWMDXYtiUtTwiyEaDr6gNiwJ+scxK0TzlhN5CmaQHx8V1U4iX
         DUjFuZY2zEOHvPQD79wR4+8hNYYuSRIvM3PMwKzkUIm8QVaVXlVDduRusot5fKnDAKTc
         HWMmXCEUgNSFejxq0hxRMdfuOrBe36vRVnk+XUSp1WLYEnG0NgTCvywaSQB+NigJ+REQ
         gEkeJG8dy0RTpcojdl3WtXRY1tyOC6ASKiX5XLPGc9p3xQl0MCEzfXDiNDRetZkGHfM6
         5ZJWUqUDys6qIMuWsqsNQlNtdoiMnq6LsfWbXNqY9Lu5GtvrHLXAT1IaOMXxqjhZS0a1
         guTA==
X-Forwarded-Encrypted: i=1; AJvYcCWjO4fMLConwX1Q1/3yMVGPeZ4SOxOYAxhEcWaE66WcWuN/OVdtoztU094Z8AC8j7MMRgdhH8ymDKMFtL2wzRGl74D26BJKnfCrSavr
X-Gm-Message-State: AOJu0YyN3j9x9QY5Ov017oTYtSFWw4zosFl3T+YGaLV3FY4QeG+6jLTX
	IrMDIvxmYmoyLcvYXKEaPFZtmZ7HrrL+th5j3D7Sb4JXO4HuU8N5nVu51dQymaD3MT6nCgbqVFG
	yX9ra7uMzseVNt9vz2crsk4sBPH4PohM7vEIh8YWy897vSCXRsLWrHTfY89NVtw==
X-Received: by 2002:adf:e350:0:b0:341:c9d1:eae5 with SMTP id n16-20020adfe350000000b00341c9d1eae5mr7129803wrj.27.1713255937579;
        Tue, 16 Apr 2024 01:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKytJX+FjhQR2w1i1oJtNMSD1iHaqi6KTBm9EVmUYy4DH79bYUapQe5OqUrK74IzMetGwlpA==
X-Received: by 2002:adf:e350:0:b0:341:c9d1:eae5 with SMTP id n16-20020adfe350000000b00341c9d1eae5mr7129796wrj.27.1713255937264;
        Tue, 16 Apr 2024 01:25:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d4d8d000000b003432d61d6b7sm14045151wru.51.2024.04.16.01.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:25:36 -0700 (PDT)
Message-ID: <70ec563b-b6a8-48d6-9f9b-287b13df8f36@redhat.com>
Date: Tue, 16 Apr 2024 10:25:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the drm-misc tree
Content-Language: en-US, fr
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240416173112.04579e40@canb.auug.org.au>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240416173112.04579e40@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/04/2024 09:31, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drm-misc tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> drivers/gpu/drm/drm_fb_dma_helper.c:166: warning: Excess function parameter 'drm_scanout_buffer' description in 'drm_fb_dma_get_scanout_buffer'
> drivers/gpu/drm/drm_fb_dma_helper.c:166: warning: Function parameter or struct member 'sb' not described in 'drm_fb_dma_get_scanout_buffer'
> drivers/gpu/drm/drm_fb_dma_helper.c:166: warning: Excess function parameter 'drm_scanout_buffer' description in 'drm_fb_dma_get_scanout_buffer'
> 

Hi,

Thanks for pointing that out. The parameter name is 'sb' and not 
'drm_scanout_buffer', I will send a fix.

Best regards,

-- 

Jocelyn

> Introduced by commit
> 
>    879b3b6511fe ("drm/fb_dma: Add generic get_scanout_buffer() for drm_panic")
> 


