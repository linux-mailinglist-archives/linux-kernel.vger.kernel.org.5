Return-Path: <linux-kernel+bounces-107623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCF587FF47
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C00283125
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3624181734;
	Tue, 19 Mar 2024 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNAeT70P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160C8004F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857078; cv=none; b=shWy3ShMI4szHMMOhht0JuNt1PWzzY6im7pu3keDNAWLH5qGvfP64JOdc8loe3j73+lyMFAVJ7MHZ55lngzMBTeQexRKco8yqCc4pFDkZiAhgjs1FbHM7/gY7NoI8HsJwPosXi+kk8lvIDY9THkgycMBTnVPojt07w4js3uouHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857078; c=relaxed/simple;
	bh=yNVTuH8Tx4LSKyNlUvmV1JciL2tHoqgg0gSm10mQhSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqH3k881lJm0GRkXX9BSS91pmsj4FUG60/487Epiq+42aZHXWNITMs3pBgLMy785iOXsd6NgfoHdO+HMyYH5qAFf6VxRdEgab/MZxRf4UVPlT7vrogTpbBeNOYNAVkwRFvy+B8zAp/eCaWFFedbBL23LmxENWLA4gmLOcUUYXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNAeT70P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710857075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8w0eeleNwYf+7p/hWMlw61q+s/j0K+e36TEHXQ6sQvU=;
	b=UNAeT70P6dWCHTAtRa1DRYA3iIbyZjtwpT/Jq7RnlaAoqDAzpK9HtBUkjVMuucrG+RrlEc
	JZklrnpLniS8X8mnnArWzFZYIuCFLjilxfIxpXvwPOv6+d1I1n4m5nuVqTRepvH93M/YsL
	7i/We1qwLx0rF/ss+KEG2Lc2vPaGB6g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-gcBMmA-hNum6XgzviqNJkA-1; Tue, 19 Mar 2024 10:04:33 -0400
X-MC-Unique: gcBMmA-hNum6XgzviqNJkA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7830635331bso155305085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710857073; x=1711461873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w0eeleNwYf+7p/hWMlw61q+s/j0K+e36TEHXQ6sQvU=;
        b=on5tNswfNyeRs27W/o1utEvzfIYpaIShz5vFMckoNGlniJ/Ibn9vuialzcS9mqoFY5
         qijyuXYQzCB9qjsJUrT7/1CyB3vpHjTjuGXMpYAIxm99tW1q7t2vGQomFxZa1owBpfvc
         0ft2WaT22zy07z9a2YvlWhx/LutZEGBQPLyl/yqi9IiOuqxsYuvjmT3KO+Z/fnxQLw2r
         aOk1ErQKzv1a9XUt3URv3yObHHDA1RHMQS9oejeklDZIKXDrLNb2eA47ACiUh/H0rYRw
         1oO8QnOzEOJzxvF1uURcJ4IpH3vr+TDJho3T3cqPrrhqs+J5znA9leYE0pdCR6q8eptf
         TbYQ==
X-Gm-Message-State: AOJu0YyfwtShhtARmFGfmtmvb31pHYCtBrLDENSgHnfggzs1nwXlyLhN
	E89iUXA0JoR1I1wu+pmripBBvXRe84Wr85nRbu2QPhkFRDndCGuXpzPV7yjkOdqY2dF3lRobCRl
	mH5I0I1INnbxr0aguE9MUcjM9ztbTrdZ+xqzYutAWRd+sdV9e6Ji96oB2WH7xaQ==
X-Received: by 2002:a05:620a:1911:b0:789:ea58:d3b1 with SMTP id bj17-20020a05620a191100b00789ea58d3b1mr2518349qkb.4.1710857073237;
        Tue, 19 Mar 2024 07:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2woW7UEchY2IkBVWYzgRK0KWJ4spUtcTxNI2cDq95Ac2i5H9cK+iTpsS+AG/gM2n1vRK6zQ==
X-Received: by 2002:a05:620a:1911:b0:789:ea58:d3b1 with SMTP id bj17-20020a05620a191100b00789ea58d3b1mr2518292qkb.4.1710857072670;
        Tue, 19 Mar 2024 07:04:32 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ye1-20020a05620a3b8100b00789e1874eccsm4708269qkn.41.2024.03.19.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:04:32 -0700 (PDT)
Date: Tue, 19 Mar 2024 10:04:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v2 05/14] mm/sparc: Change pXd_huge() behavior to exclude
 swap entries
Message-ID: <Zfmbb82ErXU8WXt3@x1n>
References: <20240318200404.448346-1-peterx@redhat.com>
 <20240318200404.448346-6-peterx@redhat.com>
 <744C19CB-4AE0-472B-ABD8-2064EB04FDA0@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <744C19CB-4AE0-472B-ABD8-2064EB04FDA0@linux.dev>

On Tue, Mar 19, 2024 at 12:25:39PM +0800, Muchun Song wrote:
> > @@ -409,14 +409,12 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
> > 
> > int pmd_huge(pmd_t pmd)
> > {
> > - 	return !pmd_none(pmd) &&
> > - 	(pmd_val(pmd) & (_PAGE_VALID|_PAGE_PMD_HUGE)) != _PAGE_VALID;
> > + 	return pmd_leaf(pmd);;
> 
> There is a redundant semicolon in the end.

Will touch it up, thanks.  PS: This will be dropped as a whole in patch 12.

-- 
Peter Xu


