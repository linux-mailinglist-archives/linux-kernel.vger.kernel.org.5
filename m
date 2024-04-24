Return-Path: <linux-kernel+bounces-156679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457088B06BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA505283E47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B35A158DD7;
	Wed, 24 Apr 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WEadfsC7"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DA282EE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952801; cv=none; b=LTFuYX/gbBe5naQKgPfPrRCq5ei/HOcLTlzMfzqg5OmYubrwrkwiyBsFwPahOOjTvjRcwSoo7ytW8kKs9SNawfWiHBaKVC0m/+nwcSGWVExOKV2Kg8mTYSpxvxUlFQN6kNvol2V6D2URRq5ivu5ns215p1dPLHFMvwcl3aS8UdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952801; c=relaxed/simple;
	bh=Ux7ls70uZC1fOJGQnu98hEvKQEH6QOpdA96fV34/2nY=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAeWruIbrwiHSJHetW/eYPCjthP3U6d8+HrDprccmnzfV1m+pOLKnQW1+gtqvZlKKoJztAhmhAywIC4NMuzRhFAVobYoYbVzOcqBhTBO53FJ8nni/JtTKy1WOqGywdJJEqijzJ4U6dpvyDzFoK7ftCTaWGVIw0o3lcsk+wKpSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WEadfsC7; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 341743FB77
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713952796;
	bh=S2dZSeR9LCzi8J1OpoztZzAdz+9TX12tp6NKUBGWijE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=WEadfsC76zjEwReLrXF4EdNY6e2KqKdUpvYwl497JQ+VkN/NdEmR6Fu+PI61JStRB
	 znZuObYg7RuRexz2sRUM/dK/P/fcR3pe5s/f4QibPzQaLPEXTYYMsvOjIWE66wVZGH
	 L/8qClmTE09I2t84OVf85/Osmk1B+7+cosjTrvrpX0IzeJ1sikt/UfC+XAQZsYxcl1
	 PpsdEsY7GcFudoimv+YNCpp96UbdWeP0V9z11hu1Xsa2EuZxMCMZGi+w2ILiF2DHR9
	 /pOSnHnKsbvHod9nNWoxKeFrGU9A8RN5RCFzCZcpGLQ3XOl4sqlVtvDOfBUf+qjHIG
	 rhKECOjnZsCiA==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43a2aab079cso2403111cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713952795; x=1714557595;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2dZSeR9LCzi8J1OpoztZzAdz+9TX12tp6NKUBGWijE=;
        b=abiU9pqyjnuMgwL65KdsrZxJhoElZ/ZFvMEE6fTiRwDmB81SiAxrPcG8jbt01NLxi0
         x1/JjCtqAh9vneuGlLWOufkO/yJ+V8LtfTUJwxWbcBh0CSC1n94I7KRncaCVFBhmQxiA
         WvLONsMRfIS1wirRodMrH4SlG96UsKEMsJEtCs1UsuAnhnVKEYd3FQdbJyqAgC67BIuU
         pkMYkqFzwZpceuxgxckL5GxX1xvlknqhkyMlNeXqsejumUgcieH4iuV3MBa0DbpMqsQb
         YegkG7VuoIwz8t6eTjihCFMnEqCq5i9tXS2PnGlnAenTGOD1dLv8sD1MUBCa/cMhJ09/
         4WTA==
X-Forwarded-Encrypted: i=1; AJvYcCVk1QsHXMyPNDOWyYyWk7/FVj3/OVJO6WKgJYTM2fImx4Sy6r4L5HBMRwxdq0LKbzNmNpS2ipcIqmNAu5qkxERE/uAbL7LSNfbt8KXy
X-Gm-Message-State: AOJu0Yz78flUXyVFuuj1PVHNmhMwkSn+0sGGlXe9XFhZbPWK2jVt7wiV
	CPLpQZNqrJLNA/lOAMJvKOE9ihhPDv4nB4UPcJXe4ntrO8Y+kPtviW86at/gxmQqwD6taQ2o+dG
	xqRaOREayPuVQi6485fHTYEZadHVle5o66VflnjigwSGQPgRPJT1v7Z2JcwktjEo2KqrJnfHxZr
	VU5phFwUSAHAPRBWCrMrSLRlTVg1VSIz1pFcJKcCGW6132freY+HAu
X-Received: by 2002:ac8:5fcd:0:b0:439:2dd2:8c29 with SMTP id k13-20020ac85fcd000000b004392dd28c29mr2632662qta.53.1713952795217;
        Wed, 24 Apr 2024 02:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6L8U6dPY+IwDuihju7OczEcUyPW0NUseAoFBQBuD16x08m9IflcpytSNV7vfl8H2u2zH90ZPc/+Vym43bEtQ=
X-Received: by 2002:ac8:5fcd:0:b0:439:2dd2:8c29 with SMTP id
 k13-20020ac85fcd000000b004392dd28c29mr2632629qta.53.1713952794863; Wed, 24
 Apr 2024 02:59:54 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Apr 2024 02:59:54 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 24 Apr 2024 02:59:54 -0700
Message-ID: <CAJM55Z9hObw7T=Z92w_5pYVcuR3UDW-Mas5YpCoGv4Y5s5M9xg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add StarFive's JH8100 StarLink Cache Controller
To: Joshua Yeong <joshua.yeong@starfivetech.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, conor@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, leyfoon.tan@starfivetech.com, 
	jeeheng.sia@starfivetech.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Joshua Yeong wrote:
> StarFive's JH8100 StarLink Cache Controller flush/invalidates cache using non-
> conventional RISC-V Zicbom extension instructions. This driver provides the
> cache handling on StarFive RISC-V SoC.

Hi Joshua,

As far as I know you didn't tape out the JH8100 yet, and you seem to have
replaced the SiFive cache controller with your own implementation. Can you
exlain a bit more about why you didn't implement the perfectly good Zicbom
standard instead of adding yet another non-standard work-around like this?

/Emil

>
> Changes in v3:
> - Fix code syntax
> - Link to v2: https://lore.kernel.org/all/20240423072639.143450-1-joshua.yeong@starfivetech.com/
>
> Changes in v2:
> - Change patch title from 'Add StarFive's StarLink-500 Cache Controller'
> - Remove StarFive alternative from errata framework
> - Fixes warning from https://lore.kernel.org/oe-kbuild-all/202403151625.boKDjHGr-lkp@intel.com/
> - Flush completion through atomic timeout function
> - Link to v1: https://lore.kernel.org/lkml/20240314061205.26143-1-joshua.yeong@starfivetech.com/
>
> Joshua Yeong (2):
>   cache: Add StarFive StarLink cache management for StarFive JH8100
>   dt-bindings: cache: Add docs for StarFive Starlink cache controller
>
>  .../cache/starfive,jh8100-starlink-cache.yaml |  66 +++++++++
>  drivers/cache/Kconfig                         |   9 ++
>  drivers/cache/Makefile                        |   5 +-
>  drivers/cache/starfive_starlink_cache.c       | 135 ++++++++++++++++++
>  4 files changed, 213 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
>  create mode 100644 drivers/cache/starfive_starlink_cache.c
>
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

