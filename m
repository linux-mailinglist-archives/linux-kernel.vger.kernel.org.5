Return-Path: <linux-kernel+bounces-109394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE288188C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745B21F2329B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138A88593C;
	Wed, 20 Mar 2024 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5pkGtFI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8785643
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710966275; cv=none; b=lZ3L2UJuxeMYupuxUrBdD6Tij+TOqfpLqtJD+tyZ7PYUeDMQR80+MZraD0Mwcpy7LcJIYbaPN0OGwkfSw1fWzU5tyzaAygoU6OFApOo5kHFHCE4aF4PH4xN5BDemzY/fxTaqw9r/qpQVwn+ghtM1NAyacSYsg6EjHof6jHbm0KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710966275; c=relaxed/simple;
	bh=M4q/YYp0qcs/a4m55jxwo1bG/2xhK+JzK1SSgdwqTnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4dWFfBDL3wfF98Z1i4tTay9pT0qud18ihpJHUMhMLQHRZ8V4Rvqn8ZXB0xGhLs40um21nNsU4c4TejcKG42UzaOV75Lk5tpzbJgyIwqI1q/OECrFX50Lov+kiYdwLkzxe8/QbZsCdqMkf6jSAw3kqMte+AB5VhPDabQVXQqq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5pkGtFI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710966272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCFXpjAzH80ioMiekBjHvVKOxv2INAL7O3pqSOfLGCE=;
	b=T5pkGtFIl621uhQfqIzPxre3Mkp9q0/CeKQ7/jV11aF418URT/ZT8dmcol+X3MX64Ho1A3
	WBFNYEEw2lHilLhyYYDvqAQXrOcxrg8GJv61zNp/kUcmm+x7Jeq/7i2Nq51mBywKvf3tao
	Sp/xRvErEwAe0Ve/XsoO1MgGZumnP1w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-YV3KzI2xPGCA-oX0kM-I9w-1; Wed, 20 Mar 2024 16:24:29 -0400
X-MC-Unique: YV3KzI2xPGCA-oX0kM-I9w-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-430c9bbe925so575261cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710966269; x=1711571069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCFXpjAzH80ioMiekBjHvVKOxv2INAL7O3pqSOfLGCE=;
        b=YZ8OuSt9yN3rwuVtRbiDChZ4qlCcKpOfWOKeD1Hu6hrqdcDNpNqDtMHxM5/848AETu
         Lb1+sVlwsPHO1hmL2C6Ezgu4YVFzO6sWVSOH4zIXqHC5jtmU4DFYzOY1DKWlNPzcsOPQ
         BzOlpg1TF0pIQF79GmYkvjEKmRVQrm1RJIBWxH9rX9IBG3wGwi75TzRr0VDyQnSys3+H
         ux3vWpF511hvXRHUNQRuCd68PF6r3aqoP8pLmwR0GZmqft46J9WBIkJYRj5Xj8IKpvFJ
         BB2n0wm14D2JDc6uZurWGOHePDe9ouy1Va/d6IyptaiJ/CfS6+ITt2+yRtukBV1/NdDl
         kgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUabnzWP3MBbP2TF/2mDeEa5waAEBS9c+Z/Tl+ytO8YHBfmFiqd9F8BUriae+fe+6t2G21hpOWK9KWy4A8ft67OHuqBKiJb6S8lGi2r
X-Gm-Message-State: AOJu0YzhOa8hx2HejdYfTDTZtS7Iqu6A13W8ZpnxKRG8scLEF3hXQuDK
	7ZNrW2QQEWcbmtms6MAowtRLtK/e1RizKQQh9okIh9kHYI77FinLEg467iaTSUr231udwrFkgeJ
	1uQ5JtPA0t9qBn/2iRl1vr7RlD8ukQe5e1hkhZzh2RuomcbaGKAUepNoBi78Cfg==
X-Received: by 2002:a05:6214:4285:b0:68f:e779:70f2 with SMTP id og5-20020a056214428500b0068fe77970f2mr3011031qvb.3.1710966268727;
        Wed, 20 Mar 2024 13:24:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC7ZXjclbG6h5wFeCIdBAt5YTulJwCv/uK86AiBxheygftq1ifha1EzMNeKJfkJ4R9dQ9Xpg==
X-Received: by 2002:a05:6214:4285:b0:68f:e779:70f2 with SMTP id og5-20020a056214428500b0068fe77970f2mr3011015qvb.3.1710966268333;
        Wed, 20 Mar 2024 13:24:28 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id im14-20020a056214246e00b0069049298fccsm8155728qvb.65.2024.03.20.13.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 13:24:27 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:24:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Message-ID: <ZftF-Qn46aV7rjD1@x1n>
References: <20240313214719.253873-10-peterx@redhat.com>
 <7b7d6ce1-4a3f-4392-951d-a9bd146c954c@csgroup.eu>
 <ZfLzZekFBp3J6JUy@x1n>
 <1f6ad500-3ff7-44d4-8223-067bd2ed9ffe@csgroup.eu>
 <20240318161519.GA5825@nvidia.com>
 <e0417c2a-2ef1-4435-b5a7-aadfe90ff8f1@csgroup.eu>
 <20240319232656.GC159172@nvidia.com>
 <7ca8f19e-7517-404a-b7bb-92ac516d87c8@csgroup.eu>
 <ZfsKIResY4YcxkxK@x1n>
 <2e632389-eb4e-42af-adee-36d5ba6c3d0f@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e632389-eb4e-42af-adee-36d5ba6c3d0f@csgroup.eu>

On Wed, Mar 20, 2024 at 05:40:39PM +0000, Christophe Leroy wrote:
> 
> 
> Le 20/03/2024 à 17:09, Peter Xu a écrit :
> > On Wed, Mar 20, 2024 at 06:16:43AM +0000, Christophe Leroy wrote:
> >> At the first place that was to get a close fit between hardware
> >> pagetable topology and linux pagetable topology. But obviously we
> >> already stepped back for 512k pages, so let's go one more step aside and
> >> do similar with 8M pages.
> >>
> >> I'll give it a try and see how it goes.
> > 
> > So you're talking about 8M only for 8xx, am I right?
> 
> Yes I am.
> 
> > 
> > There seem to be other PowerPC systems use hugepd.  Is it possible that we
> > convert all hugepd into cont_pte form?
> 
> Indeed.
> 
> Seems like we have hugepd for book3s/64 and for nohash.
> 
> For book3s I don't know, may Aneesh can answer.
> 
> For nohash I think it should be possible because TLB misses are handled 
> by software. Even the e6500 which has a hardware tablewalk falls back on 
> software walk when it is a hugepage IIUC.

It'll be great if I can get some answer here, and then I know the path for
hugepd in general.  I don't want to add any new code into core mm to
something destined to fade away soon.

One option for me is I can check a macro of hugepd existance, so all new
code will only work when hugepd is not supported on such arch.  However
that'll start to make some PowerPC systems special (which I still tried
hard to avoid, if that wasn't proved in the past..), meanwhile we'll also
need to keep some generic-mm paths (that I can already remove along with
the new code) only for these hugepd systems.  But it's still okay to me,
it'll be just a matter of when to drop those codes, sooner or later.

Thanks,

-- 
Peter Xu


