Return-Path: <linux-kernel+bounces-149089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC528A8BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B234286B68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39141DA58;
	Wed, 17 Apr 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMwTOF8q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752018F4A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380148; cv=none; b=GZei4PwppFn9CB2hGEP7A/DRu4xNyR63K1V8KsF91O4datQGDnkHfdoWuA2YRUkklUb++Tv2ADj6WLq7PGxCi8ud42CZZrr6wgOAe1/1VPlYVv8Kfoi/9Cxgaer33yuG+oIETkD8HHUr83n7UMWu2g7khMy9uNFZF6ysihJLmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380148; c=relaxed/simple;
	bh=CFp8dAgu4+wIOX4KaLhGVXgN2difv8X0VLpbaavssLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBAlknq1oK6QSL90ZF07lxyL6+YGWl1UspUPossY25VXoQirpRTfcD4VMGUZUo/fbMR9iOf90f2V4y9AuWP5x/l5ZF0tmPZEnMAFEznsoyBMSr9qsYSS5+1nZYgursbIhO3XgJwlhiPYRYMzVgn+o44gbIbxQSiziFoDHJCTI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMwTOF8q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713380144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5FP4ZMXWvD56jod+P4Mz3epLSftJiyYtHPql+dMS5U=;
	b=PMwTOF8q9vc2bHG/YltKdI90fGQ8w2XJBEj3yusffin04cL2znfNxo+Ja0Vic6LVjXnxnU
	r0PKSlq+4p7V6OhO1hI1Je3ySM8wbvKXpPyJQMTk5CjFkM2plm7KscVif9QLWD6TSx6k2g
	bwAE83pMtce712Ivx9gZ9OdIuK/JxWA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-Ppt8eqgbN1eBOWe2o9bO0Q-1; Wed, 17 Apr 2024 14:55:42 -0400
X-MC-Unique: Ppt8eqgbN1eBOWe2o9bO0Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69f8db36e8aso299986d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713380142; x=1713984942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5FP4ZMXWvD56jod+P4Mz3epLSftJiyYtHPql+dMS5U=;
        b=SvUCexhq8OGoSCkzXhJ9OK1TQxR4ASlY22lVsFLoBp4YXTTO7k3jUbrIuJUJknnafd
         fMcsLb0vzWUR2YmwQvkUV0OAth+F+PEVIpwsqSa5i6YRsoE8vaBwapxMVxfKfil6E0mW
         ZnUMq0cH3Nvj2EFbUjwy5t/k5uK88O9P3V0OQf7xBmDcPo1IQmA1arhJ5B2GphNGU1I4
         1s5oFCaSsgxpizAUNXrGfT0lqhz2otPqRrQPdmL+g/JqDS0vbMGQBLYJxT+Y5KUCQ3oV
         ue0mcbRa+ddXIZdA1G8n8YgxyCXTxfaPPaEp9AX30gQHvJvNg2Z9sD5XTQhRiGwYmqGq
         Xxlg==
X-Gm-Message-State: AOJu0YwBlo9fp3swmO/aU/Dxr9oYwlDH2E1MVkymKY7EjSF/Ina5L3gr
	VZJrbVkZIdn1/Y5p40VRg0unOm7t76tRMkpJ0MK3WvOhiaNbuja/rOCoNARLFzSmtkNPGwBTVgN
	6baM/MyoxJK6YkD0gS2wIgE1PXB9zE//myqFFrOfOsG3jSNkh1b917HKuXrHUNw==
X-Received: by 2002:a05:6214:23ce:b0:69b:1c5c:28fb with SMTP id hr14-20020a05621423ce00b0069b1c5c28fbmr322382qvb.0.1713380142326;
        Wed, 17 Apr 2024 11:55:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEslpFqTi2iY9urJ7zoJJWAHsKS7CknlIlU3ST+wwwb0jPwoRa2iWZHfO/IbOU5UzodzG7AsQ==
X-Received: by 2002:a05:6214:23ce:b0:69b:1c5c:28fb with SMTP id hr14-20020a05621423ce00b0069b1c5c28fbmr322363qvb.0.1713380141796;
        Wed, 17 Apr 2024 11:55:41 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ej6-20020ad45a46000000b00696b1050be8sm8585776qvb.133.2024.04.17.11.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:55:41 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:55:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] mm/page_table_check: Support userfault wr-protect entries
Message-ID: <ZiAbK63JshbyW48z@x1n>
References: <20240415205259.2535077-1-peterx@redhat.com>
 <CA+CK2bCSs8om+7tO_Sq2fAUD+gzD_4unUXMtO9oRUB+=4biv-Q@mail.gmail.com>
 <Zh_-j56_0RWxd33E@x1n>
 <CA+CK2bACyxNgFACfSu=3ro-nn-+PXCMf6Mug5G0G1oWpWabq4Q@mail.gmail.com>
 <CA+CK2bCr0eb+tc-Hp8Gqjsor4C9vpcGB2y1zhPORTAX=phhzig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCr0eb+tc-Hp8Gqjsor4C9vpcGB2y1zhPORTAX=phhzig@mail.gmail.com>

On Wed, Apr 17, 2024 at 02:51:48PM -0400, Pasha Tatashin wrote:
> This breaks linux-next build:
> 
> mm/page_table_check.c: In function ‘swap_cached_writable’:
> mm/page_table_check.c:192:24: error: ‘SWP_DEVICE_EXCLUSIVE_WRITE’
> undeclared (first use in this function)
>   192 |         return type == SWP_DEVICE_EXCLUSIVE_WRITE ||
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/page_table_check.c:192:24: note: each undeclared identifier is
> reported only once for each function it appears in
> mm/page_table_check.c:194:1: error: control reaches end of non-void
> function [-Werror=return-type]
>   194 | }
> 
> Looks like there is a dependence on CONFIG_DEVICE_PRIVATE.

Right, same to SWP_MIGRATION_WRITE.

I've already sent a v2 with everything fixed, please have a look.  I also
added one more device private entry type that I overlooked.

Thanks,

-- 
Peter Xu


