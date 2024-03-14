Return-Path: <linux-kernel+bounces-103256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD88087BD10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A741284417
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CAC59149;
	Thu, 14 Mar 2024 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJEzbgW3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF718E20
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420846; cv=none; b=tFOXJgVmccjESMnybmEDtshv8XmdkkEk+Yey96d11Zedp/xUvhtaxGYXLCnW8uW+nZgXtw8qcdCPnK2WjOSTOr5vyF1XXOoQfOevJ6kvsgsKSJB1PTpI6nUK9MBjLPVdLfDrwWaDo/4hscHfIpfFGTVE65pp6qJzgSfnHCk0PPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420846; c=relaxed/simple;
	bh=VP8+Z7Ov4O9DzuKaTY4W+WBGCtvu2iJHFLZOUXvTs0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDSpgET4ukpou0+qiRg2Orm0WhlNFbVMHvDCnlV4MZkNiEtko/eMlZpG/qQRmcNthTNXQS5s4Kb7TcVXw/4A6jeYHkpwZ0oEFcZzEIg6ol//wMvSWWAFTpqDQfTHY46FElgfeq3YAk4asq1tdTDx5VN3gVMwWFeo4gWAME6GXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJEzbgW3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710420843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZxWk5KkUQhQXZEGGdHKASVJGou5PrPdHxO3BmOv5tM=;
	b=GJEzbgW3NvzdmOuKkHmVPPUVsRiQubmNeTj2O/0ogg6WFtLTnxBslrMsm31Rj0ZEXebe27
	qNnmIj3BS0Ix3e20hgLqlk6KYJi/tG1ebFmMp+enVRKY3K21EfZktqbY454EMfuZxG4hva
	8Zsyq8iBpU0qMHJASa6nOiJ07ssAjq8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-Hshys6gbO3Kn1Q1Cd_XY6Q-1; Thu, 14 Mar 2024 08:54:02 -0400
X-MC-Unique: Hshys6gbO3Kn1Q1Cd_XY6Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-690d3f5af86so3182926d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710420841; x=1711025641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZxWk5KkUQhQXZEGGdHKASVJGou5PrPdHxO3BmOv5tM=;
        b=WLY2Krna7xUjWSB9K8yZ5K2VqHiJPeNb63oUyqo3SLAuOBY7v4luDEy9p9TGgcf6g0
         r0xooo7l0kO+3HsF/iQyU1IOzww7UrqmwUckl9VoVwNxx1YbJuvsLrnsHaThO88xMKRh
         GgXsAe5Olxhvz4AEu8OiGm0dioj7L4ZvRU9bflDRSqglhgaYJTEL8HV9nMFx+SgxjHUJ
         dZ+fXUGvNtWRQf0z582FmCYPtThOl5D72xGWegO9uoM2eqToCYbmTsZw0PKPgJybXcTi
         fvlmEb8KbN80emoRk4chnJtgexqs2TyW6w4WvY135IFFYqwrefYqQ0fcVxpHvQazcvzW
         6ukw==
X-Gm-Message-State: AOJu0YwYxn9DeeomSAFVb/rBsNI7D8rgZSC0AMXh+qFNwU2MIx2PYJ6T
	YMCMqv3xdY+SnKagPw1MwEWZFShqYN168TIK7lJoF1FqUu+OMAegkD5mid4Bb9v+9FJFsgSaS7W
	a/eSS2Bnx+ZKFMRYZyRXp/Ec1ImoaMNKasoT0kNWJfrvvRtXhqndmYIIqoS1yIg==
X-Received: by 2002:a05:6214:568b:b0:690:de72:316f with SMTP id qm11-20020a056214568b00b00690de72316fmr1649089qvb.1.1710420841568;
        Thu, 14 Mar 2024 05:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDKFAcy0D0RZIBzW/ijnDnKbSAtNbNy7aeKjfEkMPENW2gRJ/JKFObLbnjKUsRDl/qV6I7cQ==
X-Received: by 2002:a05:6214:568b:b0:690:de72:316f with SMTP id qm11-20020a056214568b00b00690de72316fmr1649061qvb.1.1710420841118;
        Thu, 14 Mar 2024 05:54:01 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id kd13-20020a056214400d00b0068ff79d8d97sm409217qvb.41.2024.03.14.05.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:54:00 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:53:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Message-ID: <ZfLzZekFBp3J6JUy@x1n>
References: <20240313214719.253873-1-peterx@redhat.com>
 <20240313214719.253873-10-peterx@redhat.com>
 <7b7d6ce1-4a3f-4392-951d-a9bd146c954c@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b7d6ce1-4a3f-4392-951d-a9bd146c954c@csgroup.eu>

On Thu, Mar 14, 2024 at 08:45:34AM +0000, Christophe Leroy wrote:
> 
> 
> Le 13/03/2024 à 22:47, peterx@redhat.com a écrit :
> > From: Peter Xu <peterx@redhat.com>
> > 
> > PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
> > constantly returns 0 for hash MMUs.  As Michael Ellerman pointed out [1],
> > it is safe to check _PAGE_PTE on hash MMUs, as the bit will never be set so
> > it will keep returning false.
> > 
> > As a reference, __p[mu]d_mkhuge() will trigger a BUG_ON trying to create
> > such huge mappings for 4K hash MMUs.  Meanwhile, the major powerpc hugetlb
> > pgtable walker __find_linux_pte() already used pXd_leaf() to check hugetlb
> > mappings.
> > 
> > The goal should be that we will have one API pXd_leaf() to detect all kinds
> > of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
> > pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.
> 
> All kinds of huge mappings ?
> 
> pXd_leaf() will detect only leaf mappings (like pXd_huge() ). There are 
> also huge mappings through hugepd. On powerpc 8xx we have 8M huge pages 
> and 512k huge pages. A PGD entry covers 4M so pgd_leaf() won't report 
> those huge pages.

Ah yes, I should always mention this is in the context of leaf huge pages
only.  Are the examples you provided all fall into hugepd category?  If so
I can reword the commit message, as:

        As a reference, __p[mu]d_mkhuge() will trigger a BUG_ON trying to
        create such huge mappings for 4K hash MMUs.  Meanwhile, the major
        powerpc hugetlb pgtable walker __find_linux_pte() already used
        pXd_leaf() to check leaf hugetlb mappings.

        The goal should be that we will have one API pXd_leaf() to detect
        all kinds of huge mappings except hugepd.  AFAICT we need to use
        the pXd_leaf() impl (rather than pXd_huge() ones) to make sure
        ie. THPs on hash MMU will also return true.

Does this look good to you?

Thanks,

-- 
Peter Xu


