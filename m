Return-Path: <linux-kernel+bounces-162210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F528B579B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CC92887C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286C80BF0;
	Mon, 29 Apr 2024 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KHlGtT1g"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DA548ED
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392603; cv=none; b=tMFulZc/YHZpTYqAzVA9rReFNLher2tc1f1URT06CjB+uPYnk5nHv9TYVOyDtD12WLs7cEszDPJ3n3Fo1t7UC4oIrrJkT7dzv2fTH+g8SEVpWAgyRI2UjNhsqWj+SLF1Ai4ttL6Ytupislbgsxwu3WwJiHBDMP2OBX5FApL77AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392603; c=relaxed/simple;
	bh=k3LPaxpQ0t6t3el8UgR64nKFhllhxo4z3vuO4mc314Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNpFZb5wVwx0X6fuswikhrFm4hwmSRNncyH4QTjSFp4YZ2NjoKOJsiiwqlK8uUu1AJTW2DcD+XizpgL4xtyO1eq2Bg74Flcf0ALuQi54qcY5qo7y9k/THTa3mLbyqKEqsuWUzYbtaVUcmVVuWqbexLOkzjloGCIb/xtxtp3B0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KHlGtT1g; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa241232faso3367393eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714392601; x=1714997401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXRgEPH1uU79zQD6+IHe0m9b6rETQiei9x6o058HUWY=;
        b=KHlGtT1g4NGIZs59emiTgrgXv/bcZHcgwHWTXpf7TzHQL2qHiw2oyj0e9oRxwKAvZn
         lFQ8bAS6lhDVZqNlCMP5aRye/UT/4tYyeUYiSYvjWwqwLnEP9EawaH+VYhR+kCI0amza
         L58L9OoasdzI3hIztLR0adX3Atp1xD779v9jSjl9K/U2e8Hs4IvMF3QogpAseYdZaeqE
         +9yAhE927znwsNV6wqLq7pFKxCYfNwnuqYU05Ad/RpH9IkaBWyXHmP/olFKXAMVJsvvB
         xMiRUxLiukUKsWiDuMjLR6XFVB7qc6CJ8k0mY0eUyIXcD/w/dXQZPV+10HTv/Fp+S9nA
         9Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714392601; x=1714997401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXRgEPH1uU79zQD6+IHe0m9b6rETQiei9x6o058HUWY=;
        b=evLqgJ4oXLbrL/pz7KSpMhV1ZpTm3BCydsKdhPxBjXcTODsmtqaIuNg81l08aALTKB
         UJv6/JMEkLaYMc3+uDHobv6xuZCHwi1iCzkO54pDnD54EsFsulgdyOunhD9Wh+c+Fpm6
         x3RGrxMTwt6V1oxsqjPavWAMt407M+QK0yBT35Kbd6yDn18lrJhHGrmOLxxcNRU4lPn1
         RqMOE0sJMljRwQpHCYnguF03CIAt4Lv7Z3t+qJglhVhdH8j/7Nr6aBF/54iHkbJgdQ7e
         rx9LXnemX865gUTFwQg2GC8gfiiGCNhqQuBW3xmfGtIpOpzpHxP2zHL862kepzG1igD8
         uBqg==
X-Forwarded-Encrypted: i=1; AJvYcCU/QrlMIEL++yBBZwFHC6xCZBMBtr5g5s9Dzo3r0klzcQrvjyX3tjvThSBnOy6eVs3p+htnvW4iW9qZ+X9vHgMqUUhUUTYEWI8rm4g1
X-Gm-Message-State: AOJu0Yw9uRruX+lbtQ++roPvZjSotmR2LiSFi5FnOv8p0NIY5h0trt0V
	DkDVUnUJZS/9UgMOWTJSD6P+ww9PKfwcCvf2UcDKFyXzOBYocI33moLFUbjWnlk=
X-Google-Smtp-Source: AGHT+IEY0PvXjgaQ9NXclObpxAxFwPAYyqZoUOatV7BjbYwCTbVrRKEXAnTs41fAvifo/8xzoAQp6w==
X-Received: by 2002:a05:6358:797:b0:186:9d05:5f0 with SMTP id n23-20020a056358079700b001869d0505f0mr12388658rwj.22.1714392600738;
        Mon, 29 Apr 2024 05:10:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id h2-20020ac85682000000b004365ab2894asm10399689qta.51.2024.04.29.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 05:10:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1PpX-000oW0-FJ;
	Mon, 29 Apr 2024 09:09:59 -0300
Date: Mon, 29 Apr 2024 09:09:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] iommu/amd: Fix compilation error
Message-ID: <20240429120959.GM231144@ziepe.ca>
References: <20240429111707.2795194-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429111707.2795194-1-andriy.shevchenko@linux.intel.com>

On Mon, Apr 29, 2024 at 02:17:07PM +0300, Andy Shevchenko wrote:
> With WERROR=y, which is default, clang is not happy:
> 
> .../amd/pasid.c:168:3: error: call to undeclared function 'mmu_notifier_unregister'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> .../amd/pasid.c:191:8: error: call to undeclared function 'mmu_notifier_register'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2 errors generated.
> 
> Select missed dependency.
> 
> Fixes: a5a91e54846d ("iommu/amd: Add SVA domain support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iommu/amd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

