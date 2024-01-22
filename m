Return-Path: <linux-kernel+bounces-32513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB00A835C88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721801F27AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEE920DF0;
	Mon, 22 Jan 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6zdzIZ5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E82134A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911933; cv=none; b=BDtaVmvydhdMx6uDVnr0+28nknUWF6ewN8AV3jZ8drpj/9g71G8sV+jKqR8fkQmGbzIpJEZKEfj07Ahs/YkHBPz0LUl/w4JbZcY+6RnLuza1X3yxGjee5GlkU80Y7cz6oG9q9GIbkxzv/MQXEvxM8KSEjYMZlk4nCnt+NtCSZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911933; c=relaxed/simple;
	bh=vUaDauDo3e2ShV5yK9PRL50MWWowqSMsEr4+HE7ImnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOniU3fWWaETgoQn6wTJyi3fDH3gGyPXjPA31QDT17eH2nQQNpqJI05GaVLjBDZXuCUtaiawglu67tMCd6W1HlI4iJoCQjuR2jj9P7uvtaH9eYOksKJeZjuzr9JaR2mPrdrh9Z1cnhFsR5zFLWUOwHDlmmBZ2EdPktz2maQboiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6zdzIZ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705911930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDmft0G/LbU/vGcrH0ViFbqfb55/2jbpdSGlzfSsB1Q=;
	b=f6zdzIZ52M34bnQsnGHOMzeX24AUAKBC85dOG6L68h9vkstdwUKWP64VifsAQK0U9g6bpO
	eQiOLHlNmLyqxspF3C3MocFSxBzd+lMdD6yyCcOh6vTPPgPQtJ46awsyxzexV5xMJgeuUS
	4gMiyNsQDYTKvTZ1Nh6CauZnrL2Al3c=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-NWTYPndYNOq5zEwbd6P6EA-1; Mon, 22 Jan 2024 03:25:26 -0500
X-MC-Unique: NWTYPndYNOq5zEwbd6P6EA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6ddeec294fdso742560a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705911925; x=1706516725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDmft0G/LbU/vGcrH0ViFbqfb55/2jbpdSGlzfSsB1Q=;
        b=C4LB9A40jFnRNX7z8LoJZZ4J79iksvnL60i0PYZGiN8nYiuzbCX/N1Eg2VyZQNIVBo
         TX+Dh3V9y3cbtRMlHLGVayUynBRlbhjYYr/YHoxWnqoy1XLqPyy4vjFff+09Y7U0JvLv
         u6KTEJ+u9qwiL6XWpYg5H2CVx8iSZ8VrSvcQzlsOB5oN++ef2oTojRL4J84l8YLFSY1r
         l0TnD1NqxRMQQvaqcf/uvn7bvLXb/VwtQ42cXTsNeI9KlmLdKIvI3ciPR2E9xgyrNb58
         tt5FLebzt1HIv2G0cVoJnxHl9qxD8udQENctk2ts9nh0eWWXbT2qobwrqL1PMdlSPrZy
         A7Jw==
X-Gm-Message-State: AOJu0Yy4fPVOq81sX977SaJCml0D8i8Lx+sdiLjU8ChyaBBKDbnr5i9m
	OE4Q7qSXy6auvbxDwV2E6DXmDdUewwk9w0qQlZswumZ1i738Nn6z/mlJimsMGEs91RULKaOvmG0
	Rboo1AePk9du+g30/1pjkZcZYS6RUg2t5ahNZklVk0Hz3MQt92PJgG9gBY9xI2g==
X-Received: by 2002:a05:6358:591d:b0:176:5ca9:7213 with SMTP id g29-20020a056358591d00b001765ca97213mr953008rwf.0.1705911925334;
        Mon, 22 Jan 2024 00:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSePoGNoX92PzQmVfT4AXX54k/+l1fGFhIaFtWONOwMEeDpGYerPythOMH74Vw9shCsROV9A==
X-Received: by 2002:a05:6358:591d:b0:176:5ca9:7213 with SMTP id g29-20020a056358591d00b001765ca97213mr952991rwf.0.1705911925009;
        Mon, 22 Jan 2024 00:25:25 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h8-20020a654808000000b005ca0ae17983sm6839110pgs.8.2024.01.22.00.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:25:24 -0800 (PST)
Date: Mon, 22 Jan 2024 16:25:12 +0800
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Yang Shi <shy828301@gmail.com>, linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Mike Rapoport <rppt@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Jones <andrew.jones@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 01/13] mm/Kconfig: CONFIG_PGTABLE_HAS_HUGE_LEAVES
Message-ID: <Za4maErLKnRnM0sB@x1n>
References: <20240103091423.400294-1-peterx@redhat.com>
 <20240103091423.400294-2-peterx@redhat.com>
 <20240115173737.GO734935@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115173737.GO734935@nvidia.com>

On Mon, Jan 15, 2024 at 01:37:37PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 03, 2024 at 05:14:11PM +0800, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Introduce a config option that will be selected as long as huge leaves are
> > involved in pgtable (thp or hugetlbfs).  It would be useful to mark any
> > code with this new config that can process either hugetlb or thp pages in
> > any level that is higher than pte level.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> So you mean anything that supports page table entires > PAGE_SIZE ?

Yes.

> 
> Makes sense to me, though maybe add a comment in the kconfig?

Sure I'll add some.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks for your reviews and also positive comments in previous versions,
Jason.  I appreciate that.

I'm just pretty occupied with other tasks recently so I don't yet have time
to revisit this series, along with other comments yet.  I'll do so and
reply to the comments / discussions together afterwards.

-- 
Peter Xu


