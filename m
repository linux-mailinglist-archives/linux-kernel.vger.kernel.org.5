Return-Path: <linux-kernel+bounces-124203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AFB8913DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DED1F21EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BBE3307B;
	Fri, 29 Mar 2024 06:39:46 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232BA290E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694385; cv=none; b=LDuaOd94E54o5LPesb2Pi+cnSGYDNBXp7B/HRJ1fugvFbZMRn40xfdYTCf0PEt2ftrQDwuzeJI+CH8qJAy+oJgcuRHRU+H5+IBkv4nQ+BFmwBu+9zUBbCCKV8vyJLiGgH4yg+AuFbt4EPxY+WZ/FcbELF0UCOQ1Dniy9QnI2u4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694385; c=relaxed/simple;
	bh=hGXBuUG6FVxfLHCFNPddtl1ucDEWOR0gTwTKyAjqjKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O03HtxbPqZm/GK2tnRF3V5xq29T6OouWXxksSO2X59vg8pPDPmxs9S/QzoFbFfTmijX7m57p7VcZOfGJUp/RyrD88WQsFeb/K5zp/f2MLkR2G2Cu/5gOo96py0fKkdlh2Kd4fGYlHXzOqS/fKAt8RarNF1yFPD8bn/DPfFlaJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08DEAFF803;
	Fri, 29 Mar 2024 06:39:33 +0000 (UTC)
Message-ID: <e0110a0a-9bde-4e83-8e2a-2631e1bad0cf@ghiti.fr>
Date: Fri, 29 Mar 2024 07:39:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] page_owner: Fix refcount imbalance
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
 Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240326063036.6242-1-osalvador@suse.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240326063036.6242-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Oscar,

On 26/03/2024 07:30, Oscar Salvador wrote:
> This series consists of a refactoring/correctness of updating the metadata
> of tail pages and a couple of fixups for the refcounting part.
>
>  From this series on, instead of counting the stacks, we count the outstanding
> nr_base_pages each stack has, which gives us a much better memory overview.
> The other fixup is for the migration part.
>
> A more detailed explanation can be found in the changelog of the respective
> patches.
>
> Oscar Salvador (3):
>    mm,page_owner: Update metada for tail pages
>    mm,page_owner: Fix refcount imbalance
>    mm,page_owner: Fix accounting of pages when migrating
>
>   Documentation/mm/page_owner.rst |  73 +++++++------
>   mm/page_owner.c                 | 184 +++++++++++++++++++-------------
>   2 files changed, 146 insertions(+), 111 deletions(-)
>

This fixes the following report from syzbot: 
https://lore.kernel.org/linux-riscv/00000000000070a2660614b83885@google.com/T/#t

So you can add:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


