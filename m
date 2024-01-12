Return-Path: <linux-kernel+bounces-24323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C560382BB08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BF4B20F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D25B5D9;
	Fri, 12 Jan 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HIzrxhlC"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D8CF4F7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P7BoQkKVZMgf6vnmP1aQ9LNyV+OuN5zAeIwFDZGSshE=; b=HIzrxhlC3lQeP8d0vel1OTHYYS
	H9ExqFhsFjfNhDSzJCRwzNhJB9AZaP1Jro1YhYIlFkxBrAafxGA/RRuViLWdQ019rXzxfSWCQ7Mjw
	VCKFwpcJI/fx+pcv4Uce59rr08TsSJcH1QYtXVmHbObokLqnRRTuvU7Yr6b5H7+D46soliAsMUWFm
	AkOUfscdOwyElzbDGkcNi6nIIcJkmwhk7cgpLlgwOYTFDjHLD2mMEMUbgOKo/FIEXJoNlPJTjZNFU
	itggmrSDxrPXQaugbmylsV1mirs3SCETYWB+38PZ0O6R+SzTecCKxjl+MfbGxf5/RIZsZHbwYZNwS
	CSf0MHsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rOAOn-001yLf-2L;
	Fri, 12 Jan 2024 05:48:09 +0000
Date: Thu, 11 Jan 2024 21:48:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Fix a warning in the
 crash_save_vmcoreinfo_init()
Message-ID: <ZaDSmY5oObFqWCfs@infradead.org>
References: <20240111192329.449189-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111192329.449189-1-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 11, 2024 at 08:23:29PM +0100, Uladzislau Rezki (Sony) wrote:
>  #endif
>  	VMCOREINFO_SYMBOL(_stext);
> -	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", (unsigned long) VMALLOC_START);

Well, the right fix is of course to make sure VMALLOC_START has a
consistent type, else we need to plaster this crud all over.
unsigned long seems like the right type for it, so at least m68k should
be fixed to confirm to that by adding a UL postfix to the definition.


