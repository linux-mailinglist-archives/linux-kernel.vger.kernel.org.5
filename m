Return-Path: <linux-kernel+bounces-25542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752682D212
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 21:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC3C2812E3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0834E12E7B;
	Sun, 14 Jan 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0jSetyZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83259EAF7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e72e3d435so7798993e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 12:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705265718; x=1705870518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OjdwhhShuxIM1mqbVlzcS4sQ3O1tzPChgxO0uqhf+Bw=;
        b=M0jSetyZmlRkZCvi0HPR66NF6cLxTXIup7lDcxo5XiSLSTOY4of1mYcnd564kmWJUy
         HjGzO9ZKyD+Ww1sbHZ6qWuF/23kOkaTXShItwKgc1fv48iQUO/StK9EG4n3GoR4+Xe/a
         d0AxrBFEmoyMvKRIDHMoMVLXbii34fNyE7KeYx5TKxAS+RS0GQ3kcCMJaiP//O2nh38G
         KQ4frUOHry1GwD6u+vOlO5q0/RPmbqHi8BK7wFXrN82uE8t79tWid3jJaZwxGEcmTF92
         8HHbLzgn6ZZGxJcKCRVpRIgjQADSzUPz/QrECpdTsMqlI9yIwrxions/0LpQoHkcVKou
         nQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705265718; x=1705870518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjdwhhShuxIM1mqbVlzcS4sQ3O1tzPChgxO0uqhf+Bw=;
        b=eRTRCmwFVlhFEoxu04WukGkvppzuDrxjnjzF27Ldia9LHfHe0Wsax3H23bAY3v5vX0
         sJw0Es4xtICvree5WpjvkDnf3fpoGVmfKHh0PEgKO5AWfiVHtCNG13Bir4qqRGrt19r+
         oRd0CZxhZjA7hYnjzXxXaXYGTurJRyojugWexh5TdIxiRDUxX5clA+vzI7rG3Fp5yEWh
         qPQZ7TPa2LgfpePPfpB6YpINAxl7c8ei2Ht181ETACB3QDL3XyBNB53kwp0OFjSN5+oM
         ou4zujTRd2CpUQ26IrZqkpHSGKPuoDLyvCHxWIO5A+gmg7V7O3h+UZbnsudEFpkrM9Uv
         691A==
X-Gm-Message-State: AOJu0YxJW6ZUL6jPu/YZ6kayWS1D1gx5ph1lL9UI5B0XBYeYc0PU9Q88
	W/htEKcYlUTxJ3moau5tPcA=
X-Google-Smtp-Source: AGHT+IFSg7sPPT5du0kGDtu5w62WANdm97nr297wUbBkWA5r0LG3EslmUwuam5znWD2kqpR+oYiCFw==
X-Received: by 2002:a05:6512:39d5:b0:50e:902d:b44 with SMTP id k21-20020a05651239d500b0050e902d0b44mr1718048lfu.8.1705265718182;
        Sun, 14 Jan 2024 12:55:18 -0800 (PST)
Received: from krava ([83.240.63.77])
        by smtp.gmail.com with ESMTPSA id vh1-20020a170907d38100b00a2daf80d017sm823904ejc.6.2024.01.14.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 12:55:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 14 Jan 2024 21:55:15 +0100
To: David Hildenbrand <david@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yang Shi <shy828301@gmail.com>,
	"Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Itaru Kitayama <itaru.kitayama@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v9 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Message-ID: <ZaRKMwKJIBmh8-lD@krava>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-3-ryan.roberts@arm.com>
 <ZaMR2EWN-HvlCfUl@krava>
 <41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com>

On Sun, Jan 14, 2024 at 06:33:56PM +0100, David Hildenbrand wrote:
> On 13.01.24 23:42, Jiri Olsa wrote:
> > On Thu, Dec 07, 2023 at 04:12:03PM +0000, Ryan Roberts wrote:
> > > In preparation for supporting anonymous multi-size THP, improve
> > > folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> > > passed to it. In this case, all contained pages are accounted using the
> > > order-0 folio (or base page) scheme.
> > > 
> > > Reviewed-by: Yu Zhao <yuzhao@google.com>
> > > Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> > > Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > Tested-by: John Hubbard <jhubbard@nvidia.com>
> > > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > > ---
> > >   mm/rmap.c | 28 ++++++++++++++++++++--------
> > >   1 file changed, 20 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 2a1e45e6419f..846fc79f3ca9 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
> > >    * This means the inc-and-test can be bypassed.
> > >    * The folio does not have to be locked.
> > >    *
> > > - * If the folio is large, it is accounted as a THP.  As the folio
> > > + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
> > >    * is new, it's assumed to be mapped exclusively by a single process.
> > >    */
> > >   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> > >   		unsigned long address)
> > >   {
> > > -	int nr;
> > > +	int nr = folio_nr_pages(folio);
> > > -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> > > +	VM_BUG_ON_VMA(address < vma->vm_start ||
> > > +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> > 
> > hi,
> > I'm hitting this bug (console output below) with adding uprobe
> > on simple program like:
> > 
> >    $ cat up.c
> >    int main(void)
> >    {
> >       return 0;
> >    }
> > 
> >    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
> > 
> >    $ ./up
> > 
> > it's on top of current linus tree master:
> >    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
> > 
> > before this patch it seems to work, I can send my .config if needed
> 
> bpf only inserts a small folio, so no magic there.
> 
> It was:
> 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> And now it is
> 	VM_BUG_ON_VMA(address < vma->vm_start || address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> 
> I think this change is sane. As long as the address is aligned to full pages
> (which it better should be)
> 
> Staring at uprobe_write_opcode, likely vaddr isn't aligned ...
> 
> Likely (hopefully) that is not an issue for __folio_set_anon(), because linear_page_index()
> will mask these bits off.
> 
> 
> Would the following change fix it for you?

great, that fixes it for me, you can add my

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> From c640a8363e47bc96965a35115a040b5f876c4320 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Sun, 14 Jan 2024 18:32:57 +0100
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  kernel/events/uprobes.c | 2 +-
>  mm/rmap.c               | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 485bb0389b488..929e98c629652 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -537,7 +537,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  		}
>  	}
> -	ret = __replace_page(vma, vaddr, old_page, new_page);
> +	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
>  	if (new_page)
>  		put_page(new_page);
>  put_old:
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f5d43edad529a..a903db4df6b97 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1408,6 +1408,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  {
>  	int nr = folio_nr_pages(folio);
> +	VM_WARN_ON_FOLIO(!IS_ALIGNED(address, PAGE_SIZE), folio);
>  	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>  	VM_BUG_ON_VMA(address < vma->vm_start ||
>  			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> -- 
> 2.43.0
> 
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

