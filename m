Return-Path: <linux-kernel+bounces-109144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5364C88153E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72F1B2300F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA954BD4;
	Wed, 20 Mar 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wy7hnMrI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3853E0D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950953; cv=none; b=EWQZE0PxBmu1sb+FEmPySPo1r3/e6VNWba81SRg3YHBBWZhI9H23oro7cFA5rOIwy1nTfr7L3SBuFri0n20kSQ/kD2N/GG/SWu66r43uxRUu/i65xMolUVag+wBbLHr1tHhEG3ewweH4lcJ//cMI9NTi6rJY8+ZOaPtp47I+qQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950953; c=relaxed/simple;
	bh=NYi7TEFzmJfpPsXbUQ+NXX+o1xIpezcbZbtkLnObb7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNYIkiOmlTcPQ1h5D51hFdocPbpYBKyB5wVHtnvw3uz2YtUl1Jy87UCWeTYRHal8uX2YdPhB4RAfmPii86Cwmn+/yE0KylEPDkRBGCWOyfPKWVLv9DOP3S01A/n4KT9FSkdEyuIcjOmLxaa5hzyZotW9Pz8PI1ZoHz5iXr14s78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wy7hnMrI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710950951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/kVb2OPEa9Hz3NlGswxjF/cBh1c8MnT1EuBR8prPYIM=;
	b=Wy7hnMrIDJx1AU55ta/Z4OrB1ijfjr8r9jZyBKWKFuUV6aFjgY7hI3A58HpW+VkHXXozkc
	CpmZpnwuZPivIQn26pPlnxgoHWoXkMwWxWfMWZ9E6Y/P62RKDLeQ243nBM3TuZjL4A8LYn
	8j34zSnAKKKcJMDo4H60zqR84UBhEog=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-foHk0Gb9PY2wuefm3pjiMQ-1; Wed, 20 Mar 2024 12:09:09 -0400
X-MC-Unique: foHk0Gb9PY2wuefm3pjiMQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6e67a83e7efso1439149a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950948; x=1711555748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kVb2OPEa9Hz3NlGswxjF/cBh1c8MnT1EuBR8prPYIM=;
        b=THTbwt2e2W+DK7WztNppype536fis/kTVjpdXpI0F6yg5QANs6uesZDXpgQVcYZxcI
         QA6TrMi/7OMnNoNvrZAfZg5d7Be2vRNGqEPq5b3BpgCTHjoLWRLq/62cwYQ97prCBD9Z
         5bcy6f1KGywAfvBGc0bSg0HITlFKkI94oj17Q48AO9rc2up8dM3lEkbwxMMnztSIED3D
         1gTyWisuUshDQFDdBDN7mhw2tZEMp0cBrdAAHhBnnLDnTIpUu7qxuZjSrLgtI/ctPDB2
         ShRmP4v4wAYcJ1eLMcKPnhpVJbvdz8mpOyK/AAAuB74Uksj+ChH5K5P+6PbSXeO/AxgH
         +MDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5AQbU4+8fUGuR89rObi0YZMlLLf/zdhyM3FnkMxl9wxwEIoDHkAoXCwuI50dBHrh0QAXdLVg3TzB67lHBsA28tgvSlC7jg56wDYu3
X-Gm-Message-State: AOJu0YxiOxCXSnNuY8xhFuNYUg7KLd6d283Y7Hk89zgaeD7Ap1HGiZh6
	Kp30ZFC6LE4zXFBHYspTCe6a6m2r8qCulLi5ZshkJkruEEQZkrQpEVQw/z+6YDn8eqvANph/BFu
	eDVmIyPpChBCqY7PZk8N1qbZLlRo7KR6ce/oPSVNUh/MycLjJV1f4OlIjLPozxg==
X-Received: by 2002:a9d:7ad9:0:b0:6e6:a1a4:d6ec with SMTP id m25-20020a9d7ad9000000b006e6a1a4d6ecmr5509635otn.3.1710950948527;
        Wed, 20 Mar 2024 09:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUPcSOgWRtuZK7x7eAKmfFnaS1NKw8N142/BtimLIrxti/cRS6mu+CLtqkpSIoYmn0o6zxkQ==
X-Received: by 2002:a9d:7ad9:0:b0:6e6:a1a4:d6ec with SMTP id m25-20020a9d7ad9000000b006e6a1a4d6ecmr5509595otn.3.1710950948100;
        Wed, 20 Mar 2024 09:09:08 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id fn12-20020ad45d6c000000b00690fed3da61sm7963317qvb.109.2024.03.20.09.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 09:09:07 -0700 (PDT)
Date: Wed, 20 Mar 2024 12:09:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
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
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Message-ID: <ZfsKIResY4YcxkxK@x1n>
References: <20240313214719.253873-1-peterx@redhat.com>
 <20240313214719.253873-10-peterx@redhat.com>
 <7b7d6ce1-4a3f-4392-951d-a9bd146c954c@csgroup.eu>
 <ZfLzZekFBp3J6JUy@x1n>
 <1f6ad500-3ff7-44d4-8223-067bd2ed9ffe@csgroup.eu>
 <20240318161519.GA5825@nvidia.com>
 <e0417c2a-2ef1-4435-b5a7-aadfe90ff8f1@csgroup.eu>
 <20240319232656.GC159172@nvidia.com>
 <7ca8f19e-7517-404a-b7bb-92ac516d87c8@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ca8f19e-7517-404a-b7bb-92ac516d87c8@csgroup.eu>

On Wed, Mar 20, 2024 at 06:16:43AM +0000, Christophe Leroy wrote:
> At the first place that was to get a close fit between hardware 
> pagetable topology and linux pagetable topology. But obviously we 
> already stepped back for 512k pages, so let's go one more step aside and 
> do similar with 8M pages.
> 
> I'll give it a try and see how it goes.

So you're talking about 8M only for 8xx, am I right?

There seem to be other PowerPC systems use hugepd.  Is it possible that we
convert all hugepd into cont_pte form?

Thanks,

-- 
Peter Xu


