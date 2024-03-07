Return-Path: <linux-kernel+bounces-96366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86950875B2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6BF282B06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819846424;
	Thu,  7 Mar 2024 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Wz5A8mL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C31D698
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854663; cv=none; b=ACNRcnAL/Qqj3AQ45Rv5Bs1VVRcRIFqJjIkTTVpE7R1867KRKaWXAp61LcfMZ1ZUwQ8m9UEEt143ViiN0UZPsoGgr9ySfUb43dpF589oc44y4bgR/7flkLgqeHw3L9sDz+ctbnNULuV24onRHJzy+fboHMRMGmVtCi1rh5f2xDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854663; c=relaxed/simple;
	bh=HamO7J7FJu0KHq+q2EF/Zf7RE2xVJwEPm6ll2+UF7OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udkT5zqAGV2WcSC6BWmhZ8zlpWWRWxvGwwLr4KXSfpKjHLTvjE+D7U+j18fLfw/YziToDavEXxaxtp8yU02jLKIIOH2Mu+vdW807O09R0JRPMeq3YjA05W8cx+R+SfFRv7ScG9EIEuozxnXgXGbfUKs0sfi774IgvW72/anoHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Wz5A8mL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a45aa7cb2b3so32579866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709854660; x=1710459460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HamO7J7FJu0KHq+q2EF/Zf7RE2xVJwEPm6ll2+UF7OE=;
        b=1Wz5A8mLWTJX65wnjqaUCaLCjEEoqruCfYFxVHwYiCWWMbiFgtNXNh8ihluCIqgS1+
         aBHlzDMg6Rz9O/Fgndg+mdsvwmLaj5C0+lzf8Gqqcb3kGvlTevdN3s6piCY2LoZEn6XC
         gZVp30RAbZbGwbQvEk5+ee65R29WohzLXO8uEupArZweBA0VuejcUU/gyj+2sNhF8Zfq
         YDCnANzXMXZZyytPerLHZ8fO6FvVu/6I15VWXn3XKMaZFEKulxYGSJF+h54IFdtE8TXr
         7fiiXNc9BzI0lHVwZqJsCyeOQAIrsUY2kvx9PGBGqrYDuUqUQFWSuOx0mWMraYN1ESJw
         2bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709854660; x=1710459460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HamO7J7FJu0KHq+q2EF/Zf7RE2xVJwEPm6ll2+UF7OE=;
        b=dtS+rYXmbIo+1vQUd4rYx+eqO0jAWa5Z9C5nw/TTYRLkLBRu9b5kHnYEfy1QmmmXNf
         o+HzIt+T7BahH6cnw3R4X0a/UREdYM6AZ50PPxCsSJUkkDyJZBjl1k5j7/aKyMgNJJbO
         tSv64BV57EkufmJtjZK/ArumGC8QKEA3AqrpF6EHcz3zzoqdunvTHb4pJmeEoO2ZG+l9
         4+k3nAuqdv/u63994x6e2wINwgV/ArktbmrKLbHFTzWTS1qs7juju3V+n5pgJC8lL6Eo
         wkte0TSU4lk6w+qZQkMzGT53hJ4pPk0+mUBFkM0RZf7HiK+ULer/Med6Qz/IOsFM5cUN
         myhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5iL3wQ5/qtdSy20KETWEcKbGY2RqCnmOTaFoiq4zkY4Fb/Mk7YOjMDAZaj/Owe6VvhdEthefEzVNGJ9CLqkpQlOsw4Up/itONsc82
X-Gm-Message-State: AOJu0YyRLbFuxJ81mij+OdZ7YFqca3FDrNk2JuXmLVzDQ2aX+hkkRLGr
	1by8OF6I0mvKEjcDDkes4p65hu99MMzKmpVYwocykVvb95Ymd5SQSIOhmDEsyaGcdL5Uvs7+G+T
	OL9zcRhEbnqbWXYZSKA+/yqFMhkS1CyApvKob
X-Google-Smtp-Source: AGHT+IG8FErNayZGDlvwgBW0eCyCZijR9v+QazpAlUwAC5NkfJpH9OM+3gl51zCAqE24cE8BlsbREJdNqX3YfITxkNk=
X-Received: by 2002:a17:906:2448:b0:a45:3308:560d with SMTP id
 a8-20020a170906244800b00a453308560dmr9214915ejb.71.1709854660265; Thu, 07 Mar
 2024 15:37:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-2-yosryahmed@google.com> <ba8a51fe-7b22-46b1-be5f-1e4c837d085c@intel.com>
 <ZeomquHvZs9-BKKK@google.com> <CAJD7tkZMiRDF4jXK6yQh+cZdC7uJsTMfAXrPaC0TkTFQCoe7Tg@mail.gmail.com>
 <56ea29c2-8545-4689-a418-eb7784613650@intel.com>
In-Reply-To: <56ea29c2-8545-4689-a418-eb7784613650@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 7 Mar 2024 15:37:04 -0800
Message-ID: <CAJD7tkaRV4APEYECL_rThr5ArWaLpUG+eBiwgxqe49N6sMRBbg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during
 context switch
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Or we can avoid returning a value from the helper and avoid passing an
> > mm. The callers would be more verbose, they'll have to call
> > mm_lam_cr3_mask() and mm_untag_mask() and pass the results into the
> > helper (set_tlbstate_lam_mode() or update_cpu_tlbstate_lam()). Another
> > advantage of this is that we can move the READ_ONCE to
> > switch_mm_irqs_off() and keep the comment here.
>
>
> One thing I don't like about set_tlbstate_lam_mode() is that it's not
> obvious that it's writing to "cpu_tlbstate" and its right smack in the
> middle of a bunch of other writers to the same thing.
>
> But I'm also not sure that open-coding it at its three call sites makes
> things better overall.
>
> I honestly don't have any brilliant suggestions.

Let me ponder this a little bit and try to come up with something, I
think a max of renaming and open-coding could make an improvement.

Thanks!

