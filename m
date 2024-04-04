Return-Path: <linux-kernel+bounces-132227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716488991A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2E428107E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637B4130495;
	Thu,  4 Apr 2024 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="1uSXOarV"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF946FE10
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271406; cv=none; b=NOOV/QB9QEC0ZhqyBUitJJmmb1mcFyj9D6DTbMMlFIy6aUC1wxdY+3Ihd+9HcmlJtJtX3rhpTdQgcS+6YYg4iNaAc3+qB4Kp+RIs8Oyr35RNqZ7wNP0bICvTR4BS0ehlw+aWuhnSSDNCyqSzpCmoBHfxJ1so6Hl+IwWfKoTrDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271406; c=relaxed/simple;
	bh=8QwwNNfJXvvqZb7TDQHcSV1vv31/AZDGCVJ+8xWBRaA=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=q1+wtvEJbkX/QdpIIpFRfaZtJw7lnSU1u0kKkZUozf3tcIYdrhgY1x1yysCyDAiIjqnNF6AzO01LrGycWPFRM4XKDCEEgft8C0i4l9rmRAkXMEPPoDRfTxUvxQuQqN18JWm0IP/6TAnmFxaIczRj7ClTMQjXfaaN4cgl+R/HPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=1uSXOarV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e0ae065d24so13283535ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712271404; x=1712876204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OL/MDiO936TzZBP1Y+DxywgEUHwmxOHrRIVOM1NfUaE=;
        b=1uSXOarVTrl/oEDw80EnzxVJnRKZ+rwW00VDQY4XMw+k5hlRWac+kUl9blnIjLEPOM
         vjHXse6vENxOhLDqoLgZSMRiI/u2EweM3LWgMaymwskwz+Au5xJGQL834D7saJswz50r
         0+7UFlSPImRbAcH/zXYlKJTzYIFEHBdM7JVQm3+HevIScoX32kK73faJyduZXVdcmT1I
         HuXif5kc8h7+zYv2mIJehsKpNeCR1sl3IMTxjnZj9jpIIjV43GwAgIosla3GOSXZU1gl
         lUYau8MRrn8Jw0PzKXhYQObIf8c/t9o18fkS5kpjyfiLXfc44asuqiFfF3pUd7GTpzDg
         PV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712271404; x=1712876204;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OL/MDiO936TzZBP1Y+DxywgEUHwmxOHrRIVOM1NfUaE=;
        b=vO0iDHLhMbLaGq2MJjcOUmhcO5KosncYXmGVI8HXKQlPT1/CRNeltj7M3sKL4kCY4J
         Qc2Gctn0UXx9bMNYDPkp81t8krFv5AMzYkFBcil3d3k8Ri/7jqOhQ6o8jl9gU5w/M4Hz
         aGBVlwi5mt4ue8ZSIDakj5vvrD6OdtfCJ+OuUbwVa5zGwTdvKPTVf4CdeOOZ6xvFqX2f
         JqdPQdAlEBl2s1P8mxQ15hQ2TQihVBx2zhCsofdnR4XIBTdhj+6FPrYdvQEwdRcupUs6
         CybNdPWOA3jSla0Rst/oaXUb8wxasGFDAze0jx8cdDew0CeOSa9efQYi4JNh2m8zRWz2
         L4SA==
X-Forwarded-Encrypted: i=1; AJvYcCWYVo5Tm+ZA/H2huFMp6ZXMnHXeEMfshXz1pZyFETqhGOiNF6KYwMH/Cz2kLyiU7ApJUPCmAcnQfCR4/RvkX9kaot/o1H4Z9VCkvtXV
X-Gm-Message-State: AOJu0YzbeP+h4BXxd3pDRBugBXdwZSWc2Lzg53gGuXKGwEkNQooIMcFU
	rqkLw6ygOOr8MuJ9qVhuNP5OGS72UwHSW5elqP7hcV68mzyLDioe7+rrfMRVnpsYHJEv84BVLJu
	u
X-Google-Smtp-Source: AGHT+IEJYcRBBJJK0MlnfRHHwpjX0sR/a8BtOO1ZYMpWw8zu7xcfMp1MQQQ896kVkk3BXLOD9Mhg+g==
X-Received: by 2002:a17:902:d315:b0:1e2:849e:13a4 with SMTP id b21-20020a170902d31500b001e2849e13a4mr951669plc.35.1712271403813;
        Thu, 04 Apr 2024 15:56:43 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id mm12-20020a1709030a0c00b001e27c31e4f3sm156009plb.238.2024.04.04.15.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 15:56:43 -0700 (PDT)
Date: Thu, 04 Apr 2024 15:56:43 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Apr 2024 15:56:41 PDT (-0700)
Subject:     Re: [PATCH v3 0/3] page_owner: Fix refcount imbalance
In-Reply-To: <e0110a0a-9bde-4e83-8e2a-2631e1bad0cf@ghiti.fr>
CC: osalvador@suse.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
  linux-mm@kvack.org, mhocko@suse.com, vbabka@suse.cz, elver@google.com, andreyknvl@gmail.com,
  glider@google.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex@ghiti.fr
Message-ID: <mhng-4caed5c9-bc46-42fe-90d4-9d845376578f@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 28 Mar 2024 23:39:33 PDT (-0700), alex@ghiti.fr wrote:
> Hi Oscar,
>
> On 26/03/2024 07:30, Oscar Salvador wrote:
>> This series consists of a refactoring/correctness of updating the metadata
>> of tail pages and a couple of fixups for the refcounting part.
>>
>>  From this series on, instead of counting the stacks, we count the outstanding
>> nr_base_pages each stack has, which gives us a much better memory overview.
>> The other fixup is for the migration part.
>>
>> A more detailed explanation can be found in the changelog of the respective
>> patches.
>>
>> Oscar Salvador (3):
>>    mm,page_owner: Update metada for tail pages
>>    mm,page_owner: Fix refcount imbalance
>>    mm,page_owner: Fix accounting of pages when migrating
>>
>>   Documentation/mm/page_owner.rst |  73 +++++++------
>>   mm/page_owner.c                 | 184 +++++++++++++++++++-------------
>>   2 files changed, 146 insertions(+), 111 deletions(-)
>>
>
> This fixes the following report from syzbot:
> https://lore.kernel.org/linux-riscv/00000000000070a2660614b83885@google.com/T/#t
>
> So you can add:
>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case that helps any, but I think this is one for the MM folks  Thanks 
for chasing down the fix!

> Thanks,
>
> Alex

