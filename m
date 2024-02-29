Return-Path: <linux-kernel+bounces-86254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D786C2E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DD91F231C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF37F482E5;
	Thu, 29 Feb 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcNZpG3O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A0481D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193387; cv=none; b=mjo+gUQTRIu07puMC70Id3LVGFRiUjevpHKp8vlubHzdK5BTO5rbN4U6HlBz2dgbSiGBcVFP3ZezuZzWsMBhWkNj08BWuI+EP5YJU+305W0pZw6zvWTosgPWk9O2Bii6gHkO2gQnwoRHZQ5ctvu9XpA2JzfBAAkq6W0iSD9uTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193387; c=relaxed/simple;
	bh=q5m5axH+BLCl2agZv8n9DXtP46+hpfFVeTafKX3WiDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKJQb0PVQH6gQv4oEyD7VyACHalop5ixKtJs9Uj7wCpDYenqyzRea1lwDt48lboLhf79Fc5t7W6SXzFa/XXhECXBRF3ZainaPfhpzxKxlRTgWiqhfLfjw60zugFm+8QpmOm8PDvXCxJF6FiDYD9SBkPxFYuD5aTAXUD4tAya/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcNZpG3O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709193384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZYUQ2/MyEIs+wTU4JfVi5JkU9l2GM3/3Nd9NcCBnAo=;
	b=OcNZpG3OqsPzefSEb+z7yVLiWaxHDw4HUkeb04QiETegz7Tlhyw0xJ736Ay30oBZuQ2gpy
	uwLfIUnvV+l1pziHTd3UTUK0HFOV7Hst26lC31qASqJBYt43dn+W8KMrf08DXNm9Xi8VU2
	Xbzt66PwreGN6UgicytwGfp2GSmwhNo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Muph3YawPpac88wV6CBblQ-1; Thu, 29 Feb 2024 02:56:23 -0500
X-MC-Unique: Muph3YawPpac88wV6CBblQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651eecf80dso1091725ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709193382; x=1709798182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZYUQ2/MyEIs+wTU4JfVi5JkU9l2GM3/3Nd9NcCBnAo=;
        b=f2AYfaE49Om3Tp9orBFJdTXganQmzpkU4QvaGWVTE0FD5T13FL+iMiuqpiSMKX2yHC
         IMeWDv6UwqNBfegF5DlIzLCIPX2cQJUNJ5ZD5N0TtRpF+42y7Pqn7pJb4OFAu3fALvM3
         Gula8wgiZUkpRXbLYhCgyqjvtz5XAIMww6e01qON5kYlRkEtRETihAYQDWDKnOiYTbHB
         22XnaK9o6kHkCz4fRaotvOtJqElqHrxqLz/N1IZ+dTV6F4W1sgQHKqZvapv4DNPfF2XU
         leexeJQCXN8Yi/TWtzKytyX5UO75khEQTsBtIuLOxMOyzD5AnDaQ5PLliX1pzNcMKenx
         CrQA==
X-Gm-Message-State: AOJu0Yz0Bx9JOxBc74QHDx/p15xcYUn3aOvGNjAxrxN/sa8iIz0LQycF
	ockn+hnc4pK22XwnyaqyI6oLEs9dMTASJVODFATMrrNTB8d+VcA2X8bDA1AwDe+EVAuZytmJ+hE
	kpNeqx/dkwnDTfr94IU/qW51CEQ3YkWNJDFu04Ue/9t3w+gzS2qUwecno51phIQ==
X-Received: by 2002:a05:6e02:20ee:b0:365:aeb8:26d1 with SMTP id q14-20020a056e0220ee00b00365aeb826d1mr1725571ilv.0.1709193382281;
        Wed, 28 Feb 2024 23:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK2Caj/CnSM8btPacrXhbRxxuWkGYLUk6S0weGtsslNFGdZ2LEbvNGX15pEdr1SssPwwCMDw==
X-Received: by 2002:a05:6e02:20ee:b0:365:aeb8:26d1 with SMTP id q14-20020a056e0220ee00b00365aeb826d1mr1725558ilv.0.1709193381990;
        Wed, 28 Feb 2024 23:56:21 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ff11-20020a056a002f4b00b006e57b37a932sm664588pfb.9.2024.02.28.23.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 23:56:21 -0800 (PST)
Date: Thu, 29 Feb 2024 15:56:11 +0800
From: Peter Xu <peterx@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Yang Shi <shy828301@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] mm/treewide: Drop pXd_large()
Message-ID: <ZeA4m7DK03oHE1Kz@x1n>
References: <20240228085350.520953-6-peterx@redhat.com>
 <202402291233.CVhChP2c-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202402291233.CVhChP2c-lkp@intel.com>

On Thu, Feb 29, 2024 at 01:17:36PM +0800, kernel test robot wrote:
> >> arch/x86/include/asm/pgtable.h:1099:19: error: redefinition of 'pud_leaf'
>     1099 | static inline int pud_leaf(pud_t pud)
>          |                   ^
>    include/asm-generic/pgtable-nopmd.h:34:19: note: previous definition is here
>       34 | static inline int pud_leaf(pud_t pud)           { return 0; }
>          |                   ^

This is CONFIG_PGTABLE_LEVELS=2.  IIUC patch 5 didn't do anything wrong,
but when renaming pud_large() it caused this confliction, while in the past
it was a silent confliction between the old pud_leaf() macro and pud_leaf()
defintion, the macro could have silently overwrote the function.

IIUC such pud_leaf() is not needed as we have a global fallback.  I'll add
a pre-requisite patch to remove such pXd_leaf() definitions.

-- 
Peter Xu


