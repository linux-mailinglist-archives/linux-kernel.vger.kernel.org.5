Return-Path: <linux-kernel+bounces-90717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08288703DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7957E283795
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238B3FB1C;
	Mon,  4 Mar 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q4XVbJKI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/E9Ixk3T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF83EA89
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561885; cv=none; b=G116K+7fAv8Qcl+3cS0I9JKEQgGgX3B17Ku9UVhHp7Svo8M6RCqxMmG9M7iB/oVd7nJ6+aUa6TR+IdvHz1JcPOPH1xMALn+iv7+tuNjsSBD1tjI/clHwEJcL9EeB/6GDHmMtfSsefPD/7rgRI6NEuY+G1dI9CDcICaI/fuycZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561885; c=relaxed/simple;
	bh=wysMqA0NcoiYhrn6zwI2/1l5OR37mkkdjVbQDIWLhJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IWjaQbbFUlpoD3v2h6ynupJw1tP5i1DOpHrpcoVTaclzuBC0gXNJS7cYUhk5NYGOsxJHs8USJa95ZnSERO5ySGf9B3HF7EwS5rrLbvajBJTnVJ+qJWVbicuxK4Y1YQsMZQF+qAc6NJ3xqjo3sphw6jrvSByfgKXcZeP73Cj3IA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q4XVbJKI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/E9Ixk3T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709561882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wysMqA0NcoiYhrn6zwI2/1l5OR37mkkdjVbQDIWLhJM=;
	b=Q4XVbJKI0UeZ2ox3dwMrnDmR9kvuSdrVODv8vRY5YxPD4lNIPCjh375lBdUCzRU16Juzmo
	ZQHBL4rL2UIXecTtKvcqG6D9bSjxHvRCHrmbKRW+IFSDBrMrXmbOwlanOwbrNfmTA7W7pi
	egzTkKxTvNPZD5iBdRwbOBaOHBbvZ8w+BNuzbS9KMx3XLO775GRSjwFZAwi7FqgCsEDtaa
	H3+ZzLAxasgDjXOAKM3MRdwACbGVRaZp37iav93FT33FFyXODLMv7kQP/gMdhu95SXfSwQ
	SU72WyXcYsSaUMb9j3GTYQnFZjM/lHmELdZIcGvose1c+0b1G5ikrR36pEqZsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709561882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wysMqA0NcoiYhrn6zwI2/1l5OR37mkkdjVbQDIWLhJM=;
	b=/E9Ixk3TcwCiCBU07OgV3zyAp4HZIgJkO3N2kijNmrs9snwZY7MZaOFkzg7GcOh+iMsA2S
	8jOUaCWik+jq8/Cg==
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Yang Shi <shy828301@gmail.com>, "Kirill A
 . Shutemov" <kirill@shutemov.name>, Jason Gunthorpe <jgg@nvidia.com>,
 peterx@redhat.com, Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 4/7] mm/x86: Drop two unnecessary pud_leaf() definitions
In-Reply-To: <20240229084258.599774-5-peterx@redhat.com>
References: <20240229084258.599774-1-peterx@redhat.com>
 <20240229084258.599774-5-peterx@redhat.com>
Date: Mon, 04 Mar 2024 15:18:01 +0100
Message-ID: <8734t6w06e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 29 2024 at 16:42, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
>
> pud_leaf() has a fallback macro defined in include/linux/pgtable.h already.
> Drop the extra two for x86.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

