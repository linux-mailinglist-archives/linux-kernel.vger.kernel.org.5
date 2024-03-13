Return-Path: <linux-kernel+bounces-102640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1F087B531
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7CC1F21E09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121759167;
	Wed, 13 Mar 2024 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+SqBf+I"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781E5C8EC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372776; cv=none; b=iFLgcE3SvKJ5Oe9Ot2XBUfxyWKL8Tbse17hQFLdy+vELpU7yIxcSITZgywDQCe1D9MqSi261z58qNOVXAZYt8vH8TZ5bA3tdEQ3hga0VabNbOEY686IRMj0QE5XezdlQbBcoccPwkFrQJJYx3ycOP0zDXxsP3FHe1DeRApc+4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372776; c=relaxed/simple;
	bh=Y1iSM22dg3LiiDqRKeEsKzhciAAjh9C9p1po/lPcrIs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EvTi7j9fKUOV/LdRO8HCCZlu3ml36xFARpDboG42bs+NGRrYrvg6AyrerHoXZflUeFZwN+LWmHTAUhXON2OakBkY8UrEeiX9PANz9jh3R4FicSIC+rkL7kgQNNBU8yLUgtEmy5NMu24dvH6z0SRDFt5pZMX2JTMMcc8VuzgmM4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+SqBf+I; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dddd1a8732so65035ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710372774; x=1710977574; darn=vger.kernel.org;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiJs5IjnxOl55+o3CnjBg3VVlJkoRX43JQshQZFjjM8=;
        b=P+SqBf+IKhznT+BMQJA1uwjzvggDNa3SqicS3MFF6Gxzzs+yfcs457apElhAYIrmks
         VDPrCszNgOSqNr4uCNKlngBQYM/QyvwyG6DHfdYUx+ypAJ6KaB8MjosLzU1+1xbPG/Wr
         S8YC8e9wrdUBdPwOMCQcdytVhvU78u/2SgAiIs5+uh8XGGSV+9DCjYitOd6YpU4RJyHq
         J5LxRmaeotmKkuPGkalGgva+aop/viv9kQowkIfyFgDYc/aFqJq2eOJbxZ13WZRm7DtN
         t1eCpzgYURNGScYcIbZ80+psmDIFmst9nsocf3a9NRUzTdAmkgn8bmTE+RxuIkf6C/Ok
         tRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710372774; x=1710977574;
        h=content-id:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiJs5IjnxOl55+o3CnjBg3VVlJkoRX43JQshQZFjjM8=;
        b=KH3x9jV00Emty4WzlMP2KFiJ4ckrZGGgG6ugyJ5H7JNrkYAnidbJYja1dDEACZ4DWP
         53ZWxF3Wjdxee8wKPJ2k6PJ79D5KW6RntOA4h7Xhy12UqIAeN4FJ7LQfOYi9LPrMlXWk
         t9ZyEOyxetVDp6K8grHoY0RicBHOVZZMHirBCLheZ1h+EHMVTHvsEqeAbwiffH3hfBJP
         vCbwAOhZPzkCfcrpoqkV0Uh9UjXZaUgJlkYZ8j/+wT1fGOWj4ftjYZceGDfaExj3pDGv
         k/o+RYc5FTMRuUTpYL+f3+kXDNwHpe1ikR+1Fh1P4ta/bcbo1kwnnZskLlC4TVTqGMNO
         MPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUMMLtO2fi5eavYFwMeHxhlHSuuorUbjhmn5r05ONRcVnPe39Znl0fTK1FoJ13kk2sm18dkYKa0cQNALQFL6E3rVkHCedoAeW8AqSX
X-Gm-Message-State: AOJu0YydBndOQYp+FZs/AZYpyOmmjpS26+40qs4Kh+5Rzvct8I1BuXfh
	p/Qeu3ud8VNYZUUtJvou1VH8kOBfOjYjbGDAMMoUgNZNP09cGM60+eSrrIc9mw==
X-Google-Smtp-Source: AGHT+IF5zpg3mqgIajnAZYiOJ33Dq2n+HncuYMPiwins4omF0YdE7n75wYOZ2cinolol9fIsOQX0KA==
X-Received: by 2002:a17:902:d4cb:b0:1dc:dfa7:fc60 with SMTP id o11-20020a170902d4cb00b001dcdfa7fc60mr82885plg.2.1710372773902;
        Wed, 13 Mar 2024 16:32:53 -0700 (PDT)
Received: from [2620:0:1008:15:93dd:65bc:bbd0:d2ac] ([2620:0:1008:15:93dd:65bc:bbd0:d2ac])
        by smtp.gmail.com with ESMTPSA id s14-20020a63dc0e000000b005df58c83e89sm185578pgg.84.2024.03.13.16.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 16:32:53 -0700 (PDT)
Date: Wed, 13 Mar 2024 16:32:52 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Will Deacon <will@kernel.org>
cc: Nanyong Sun <sunnanyong@huawei.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Matthew Wilcox <willy@infradead.org>, muchun.song@linux.dev, 
    Andrew Morton <akpm@linux-foundation.org>, anshuman.khandual@arm.com, 
    wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Yu Zhao <yuzhao@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
    Sourav Panda <souravpanda@google.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap
 optimize
In-Reply-To: <20240208131734.GA23428@willie-the-truck>
Message-ID: <f8a643a9-4932-9ba4-94f1-4bc88ee27740@google.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com> <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com> <20240207111252.GA22167@willie-the-truck> <ZcNnrdlb3fe0kGHK@casper.infradead.org> <ZcN1hTrAhy-B1P2_@arm.com>
 <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com> <20240208131734.GA23428@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="2003064516-144154717-1710372487=:1424452"
Content-ID: <35d77e60-41b9-7263-4bd3-47f07a148a86@google.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--2003064516-144154717-1710372487=:1424452
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <9e36df0a-b6e1-52a5-34af-6b5859d9248f@google.com>

On Thu, 8 Feb 2024, Will Deacon wrote:

> > How about take a new lock with irq disabled during BBM, like:
> > 
> > +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
> > +{
> > +    spin_lock_irq(NEW_LOCK);
> > +    pte_clear(&init_mm, addr, ptep);
> > +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +    set_pte_at(&init_mm, addr, ptep, pte);
> > +    spin_unlock_irq(NEW_LOCK);
> > +}
> 
> I really think the only maintainable way to achieve this is to avoid the
> possibility of a fault altogether.
> 
> Will
> 
> 

Nanyong, are you still actively working on making HVO possible on arm64?

This would yield a substantial memory savings on hosts that are largely 
configured with hugetlbfs.  In our case, the size of this hugetlbfs pool 
is actually never changed after boot, but it sounds from the thread that 
there was an idea to make HVO conditional on FEAT_BBM.  Is this being 
pursued?

If so, any testing help needed?
--2003064516-144154717-1710372487=:1424452--

