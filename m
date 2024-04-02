Return-Path: <linux-kernel+bounces-128470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE78895B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4ECB24716
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6715AAC7;
	Tue,  2 Apr 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhTNg/XP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641D15AABA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080704; cv=none; b=mV4WJF2dA1hK317evuqfqO0TB23qTq982zIY5ayK4ClucOOCq8LArXKTgm7tsr42FsBifXWWIdu6mx4kEzIex7xuKppWiUSvbImplvhi2soQSmB6tbz/1dAZBJFvt+xHoeqrDLFVrlXBw3uRmdtQqy0v+2BnN3NqmZiK421G0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080704; c=relaxed/simple;
	bh=FBUk2UKTm5C5jiObsig5cVysbNmOkY70P/QraBD/Y7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyHJSrsy1+7gwtXxSV/K8jbqSGESITTYuXoJ4z2LHLw3eKY7trFCNtcsRo1ewibOHOJVsMiRHo+E2a5I1TM+OQeLSG4Eva/U6H2lR8UXpWNCM1w2q0T4Tkp2tUiwY0oNkSJ/2gMM+b/BDi9RFFzkIJFun3DzS5g6DrVvAIGpsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhTNg/XP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712080702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QbOtfO/Dg9m2AlUnDgJHatWmb8CbT3I2rXBSbFfhdJY=;
	b=UhTNg/XPtc7hgQsz8u4FV1NdMiuxMAnM/F9vzyvMFTahGOWlBYPy2RK1YiDt3E5/r5wvnx
	uU4FBhVU+oM39GSFc9thnjr/lEqz+8k4yBd1NE3QsNCPsH8/vBJJZG0dctaC/Vo6VdOKE9
	8Okvzgp112eqIkOqRtmGjrOA+QgL/eA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-6VvuqlXcPYWRqDozlribJg-1; Tue, 02 Apr 2024 13:58:18 -0400
X-MC-Unique: 6VvuqlXcPYWRqDozlribJg-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4d455b9df33so333458e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080698; x=1712685498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbOtfO/Dg9m2AlUnDgJHatWmb8CbT3I2rXBSbFfhdJY=;
        b=dG1T2tqCt8ud0OuuN2hq2CuLJT3WvXe0lWhH3S060LFwUOCcMmzepQJ+tkne/1w/d5
         KwNDo1kiFtemttM8lO+Pov5bt5jS3QuXTd8+dpx4xV7Rvw1XcofGk3aEkX79OaOG3e8U
         q8J4s99HTckgSWqL7H8ipT5Copo856sQqjeocDLuOiGzDBwP9SLTrE98zp5P9vhSeO1T
         hiOuJlapb1q+yWbLCAUHNuTSJEBExqAico4FOaKOradzS+Lju1WiuZ0czv1E7qytSTyJ
         ak6kRB7wofQGVnn/zZrMVyPjopiUO8+w7UTndpI4OSQH/lkL/3KKc/pNQvR4cvysgWmh
         H67A==
X-Forwarded-Encrypted: i=1; AJvYcCXeK1fK8x+pYoGUMdAiv9JBzrRj5W3xaVmaAteFwpAX2crm8bQekZt87qkEdii325tKLZOBxW2vtG38bJMM/WAcQQk7JlTjY9rFgjvd
X-Gm-Message-State: AOJu0Yxvd5qJpmalmXOaCeSXPxUal+3dZiNfpkC8aa0kEQ0xtZib5Km2
	DH1wLW/3Sra+08zMYMVCZk+93c03L7ZOajgAis9S5gxY9cGO1PbFz4dnSQO/+ucfcfvvTHTPzDR
	YlNLnde07E/H3EduOoGeY76YevjqjJfliK1vg9xOHXH6IN/pimnQNTlKnn2bmeQ==
X-Received: by 2002:a05:6102:93:b0:476:e72e:94ef with SMTP id t19-20020a056102009300b00476e72e94efmr9650791vsp.3.1712080697546;
        Tue, 02 Apr 2024 10:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8b3uQ69B5cqo+ud6RtEbqNi2TEDMHUU32VESs2Pw1E24CP/zf32LkrpOQk6Mcp1ToEoA3Uw==
X-Received: by 2002:a05:6102:93:b0:476:e72e:94ef with SMTP id t19-20020a056102009300b00476e72e94efmr9650757vsp.3.1712080696946;
        Tue, 02 Apr 2024 10:58:16 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id kk15-20020a056214508f00b00696a78b9cc6sm5720428qvb.53.2024.04.02.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:58:16 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:58:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v4 13/13] mm/gup: Handle hugetlb in the generic
 follow_page_mask code
Message-ID: <ZgxHNKbDnIIs7n2r@x1n>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-14-peterx@redhat.com>
 <adfdd89b-ee56-4758-836e-c66a0be7de25@arm.com>
 <5d9dd9a7-e544-4741-944c-469b79c2c649@redhat.com>
 <ZgwwOq3XXKlS_7LQ@x1n>
 <f4aff3e9-1d78-4bb8-a6f3-2887b9928b54@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4aff3e9-1d78-4bb8-a6f3-2887b9928b54@arm.com>

On Tue, Apr 02, 2024 at 05:46:57PM +0100, Ryan Roberts wrote:
> I'll leave you to do the testing on this, if that's ok.

Definitely.  I'll test and send formal patches.

> 
> Just to make my config explicit, I have this kernel command line, which reserves
> hugetlbs of all sizes for the tests:
> 
> "transparent_hugepage=madvise earlycon root=/dev/vda2 secretmem.enable
> hugepagesz=1G hugepages=0:2,1:2 hugepagesz=32M hugepages=0:2,1:2
> default_hugepagesz=2M hugepages=0:64,1:64 hugepagesz=64K hugepages=0:2,1:2"

This helps, thanks.

-- 
Peter Xu


