Return-Path: <linux-kernel+bounces-161486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085328B4CA8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AF32816D4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F970CCB;
	Sun, 28 Apr 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0TWNIn1"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C755B1E4;
	Sun, 28 Apr 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714321293; cv=none; b=R0iOVQC0J8O43C0/tEfzO98uZgJAvmR0SOpQ/U3CVYk9NoZojprX2Qd6sZMBG4LfOcaO10gKYIe4q0WfPvlqcXB22Fwy9sHVZ8Wa55YI6sztwnf7VD3yd7Io+Wlb93AkBwIcAZn9W/+azhUkReYVYl58AID0ovcgwsSr8mvl0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714321293; c=relaxed/simple;
	bh=Hcq5fDpR/sRrNIDN75Dx5TGFAVJTKRZVsYxdUtcHmgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4Dd9soOIRgfXEZaMx7+ZIIZKpslC2WaG0Pe/csQ8mNo1bajupClsc6V1b9xzxVyxoQgUIqj9FHcK1XC8YVJieQAGn2VJFQQ064VoZMV0udd7cS67Z6yMi9pna9C9IJ3kSUl7ExQv4oPST8+RlKg0n05kHMSG1Ps9kCtJeMtTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0TWNIn1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34a32ba1962so3099725f8f.2;
        Sun, 28 Apr 2024 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714321290; x=1714926090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDuTZksCbCwlQLX9V0u6jvPFt7dyage8pVEZZal0zuw=;
        b=E0TWNIn1vbAsaTTwjm6ZtwgxvMMcy8u8jEJIuiU8sNOxsD8S8K/gyDkYYK95rWwnlu
         xFSKdbjc3f6lBUI0AWJr+Xi02SL+/+1m2IaWPOsJrT+8LqYP6BnAkruT2XRT5Qz7/I0X
         ffk0z4+bdxFSyouJGS8ggZQ2ov/XzajzBbyDEEKmtcI/R7TUpTh4BMeckuG270dqN4LU
         MAbfixlkdtv4FOtF96qe5cItAUX2P8XEMCrZN7gGd0W1DNhF2VR/ox0ABpDvjhnS504C
         jx3VYAiuc1dFA/5AxgmhTASEPl5IBBq1rGOYpjPcPVvXICcS7XRYiTlzYntJ08fZmblL
         MODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714321290; x=1714926090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDuTZksCbCwlQLX9V0u6jvPFt7dyage8pVEZZal0zuw=;
        b=TXrhtrwC+AyOyeIZyKnMg1jNV/P0E0BPmI1mjtIahKigOec5vVBwE9/cZwCNoFhAzb
         XOHftoRHGFYYEsDZxdIyIOp12hcbj3kMTHhuMWSRWRPFCjrZyXcSmh85TX4GZHv42V+t
         y/0Bs3r7ISLfJsj50HZ5916vln9HDbaMTIOwGqY6uo0J6uRLO4cQLFcZcXsDKhalW3kx
         C4h/7fq7pdc7jdKIy9EZGJTSs0cSqTnI+qHuxg+Gn/lIszmBOh9KzWyyyt4jRMRfa8ze
         1l3/ZSjeHuUPuJ4eOSUplJ7RNzSvK7K5/cc5LBLjRHEdUOjM8S0L74qZnTkmdwOhH5Wn
         7Wig==
X-Forwarded-Encrypted: i=1; AJvYcCVN1waB8P+KjPukRJULeGyVob/dH9QNIKBOjphQJxTEpabEBK14w6KxAixZfFZW/0/1bj+FIiSmrVZPZ4SJPlPe/qp2p+itF/rY0xNxXXhfz7ngIhEEJTdEL8rgdPp6rmJ4eXYIZxxrDQ==
X-Gm-Message-State: AOJu0YwzfeDtRUPeMOYQrEGcCqHAQdxYb7myw74bgYmOdvrpkRT9HWxA
	tanDZbpUVvZEYLVDB3n3qMI+pPGKBC0jq2X2HjcUtAMureIYLnCGU9Vuz7qv
X-Google-Smtp-Source: AGHT+IGjYdwpUTlA0OuBWcAiywyJEAlMt6d4FSbR+ySGWGSkG9AUUGI+nRHZpFfGhpFk4jtkfWjdOg==
X-Received: by 2002:a5d:6c6a:0:b0:34d:b45:9b33 with SMTP id r10-20020a5d6c6a000000b0034d0b459b33mr778495wrz.52.1714321289740;
        Sun, 28 Apr 2024 09:21:29 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b0034c61e211a5sm6351271wrt.63.2024.04.28.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 09:21:29 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: wens@csie.org, samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC dtsi for
 H6
Date: Sun, 28 Apr 2024 18:21:28 +0200
Message-ID: <5773383.DvuYhMxLoT@jernej-laptop>
In-Reply-To:
 <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
References:
 <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 28. april 2024 ob 13:40:36 GMT +2 je Dragan Simic napisal(a):
> Add missing cache information to the Allwinner H6 SoC dtsi, to allow
> the userspace, which includes lscpu(1) that uses the virtual files provided
> by the kernel under the /sys/devices/system/cpu directory, to display the
> proper H6 cache information.
> 
> Adding the cache information to the H6 SoC dtsi also makes the following
> warning message in the kernel log go away:
> 
>   cacheinfo: Unable to detect cache hierarchy for CPU 0
> 
> The cache parameters for the H6 dtsi were obtained and partially derived
> by hand from the cache size and layout specifications found in the following
> datasheets and technical reference manuals:
> 
>   - Allwinner H6 V200 datasheet, version 1.1
>   - ARM Cortex-A53 revision r0p3 TRM, version E
> 
> For future reference, here's a brief summary of the documentation:
> 
>   - All caches employ the 64-byte cache line length
>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative instruction
>     cache and 32 KB of L1 4-way, set-associative data cache
>   - The entire SoC has 512 KB of unified L2 16-way, set-associative cache
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



