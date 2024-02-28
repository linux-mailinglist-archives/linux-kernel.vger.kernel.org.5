Return-Path: <linux-kernel+bounces-84828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C5D86AC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D349E1F2491C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51555798;
	Wed, 28 Feb 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwxtWt0j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3455F54FAE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115855; cv=none; b=erFP8hBtDD3nDjoC8lQu7/VoJ8efXkVC640FWgvOA4CwfAoGOXLoX+ORkQaUw92jlRpFsNphr/LhZRv5oMJC27jr7nKoD8W6zuyfG/UR6T8+u+m6kPyQpgGqFCXbb11AI1Ey+nsJRRGku9j7mDNrABdjJeCiVDy+ok5Andc1i4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115855; c=relaxed/simple;
	bh=s2OXAAbhfYk3/UflXlhhkCgoKotoYbzQpfVl2XbZtxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpsaxo/psmwoC0e0bA13BA0CY8DdgkhnJWohosxHMQVEj6jIfNdEJH+k2FdwJv93IjIk1rC/Hzk8d8crNw9JwT3MoXTcmqCkZPjn0JoG+InS9TKo5Esi9SF3ojkqTfF/kDHmbJjBO3G3CkQKvxS57DvdebnqXulS+JBAwsmEgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwxtWt0j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709115853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuM8DzjfIvXog8Ktsli0EuxIlZtcxvx2KqthlbNhP2w=;
	b=RwxtWt0jIgChKa/KAsKEPikoI1HOnNo5ApDH03yyx7WINPjol00+9xWVOEWU69HcA7lYKW
	IS3mTixeN0Zsx2AFebcBFHa9y4pdRwaCCiHNsHj8rmePxQvZLJ/A/8qOKCxKs4NxfXN4jk
	e55k1Xn0iSfHPJnUYhr/XPqWc9TueT8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-qi4tEVCkPdGA1J1mtsHrKQ-1; Wed, 28 Feb 2024 05:24:11 -0500
X-MC-Unique: qi4tEVCkPdGA1J1mtsHrKQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29a16254a66so1807942a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709115851; x=1709720651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuM8DzjfIvXog8Ktsli0EuxIlZtcxvx2KqthlbNhP2w=;
        b=Gdqfzh65/iXzyn4wJy913Uozazh0f9ZYIVmRwaQowqJXsIOIWuxM7ScwbdyqbU6r7w
         pte9jRJjylkfeN1vRqy7hOtILgE5OBhCHsyaUzJy9KMepi0fUgkFXA+vqGqXLIVEDedW
         rly21jP333J3EX5KQQRrnCJqvEYDSLmrYZU7CQbL7qrvGmKryVHMYzdGUo01RojE84oh
         ERI9wN3HDRS+Z51v4vEFNknF5aEzqlxcf21DY1pxswvXrDw4efBUKOCxXKbUD5i5T9NC
         H7gJOrHVLM4BfGSJvKYZnXm64RTfPRGgIzpZmePfT8UqTPgrNnR0q5zGbFFAei3fI9MB
         AHqA==
X-Gm-Message-State: AOJu0YwCoUKo4GpS0T/0u4tVAvtlMZ2CjeUisaVwff+2M065DDtoHwFJ
	AxdQRXIUA1TbXUeYNvBvmjgiByio7G6gSjdxun0cnrwnyoaQVUszK4RJbMMTvSexm+dgmMD2jEb
	5lTSFMm3xGMenYE/OjA+AGIwOZf3xv4J9LLOG7WUE/8IKG9JLvPDotusvUOc1wg==
X-Received: by 2002:a17:903:41cb:b0:1db:a770:81a4 with SMTP id u11-20020a17090341cb00b001dba77081a4mr13185102ple.1.1709115850724;
        Wed, 28 Feb 2024 02:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQqydckRfZJZIaG/rRqPcgYNfTlA7NhghdSgVkZCgv1MurPpBWUZSA3ZuFWklgTD7WqfdhSQ==
X-Received: by 2002:a17:903:41cb:b0:1db:a770:81a4 with SMTP id u11-20020a17090341cb00b001dba77081a4mr13185086ple.1.1709115850287;
        Wed, 28 Feb 2024 02:24:10 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902854200b001dcc160a4ddsm2087740plo.169.2024.02.28.02.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:24:10 -0800 (PST)
Date: Wed, 28 Feb 2024 18:23:59 +0800
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Yang Shi <shy828301@gmail.com>, Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>, "x86@kernel.org" <x86@kernel.org>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/5] mm/treewide: Replace pXd_large() with pXd_leaf()
Message-ID: <Zd8Jv8hQdXejTnbU@x1n>
References: <20240228085350.520953-1-peterx@redhat.com>
 <93954095-4515-46ff-bdad-ad08439b4471@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93954095-4515-46ff-bdad-ad08439b4471@csgroup.eu>

On Wed, Feb 28, 2024 at 09:50:52AM +0000, Christophe Leroy wrote:
> Le 28/02/2024 à 09:53, peterx@redhat.com a écrit :
> > From: Peter Xu <peterx@redhat.com>
> > 
> > [based on latest akpm/mm-unstable, commit 1274e7646240]
> > 
> > These two APIs are mostly always the same.  It's confusing to have both of
> > them.  Merge them into one.  Here I used pXd_leaf() only because pXd_leaf()
> > is a global API which is always defined, while pXd_large() is not.
> > 
> > We have yet one more API that is similar which is pXd_huge(), but that's
> > even trickier, so let's do it step by step.
> > 
> > Some cautions are needed on either x86 or ppc: x86 is currently the only
> > user of p4d_large(), while ppc used to define pXd_large() only with THP,
> > while it is not the case for pXd_leaf().  For the rest archs, afaict
> > they're 100% identical.
> 
> Maybe would also be a good opportunity to replace pmd_is_leaf() by 
> pmd_leaf() and the same for pud_is_leaf()

Sure, while I'll wait for some more comments, I can add one on top when
repost.  Thanks,

-- 
Peter Xu


