Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23547E6DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjKIPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjKIPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:45:43 -0500
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [IPv6:2001:41d0:203:375::bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739F24EC4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:43:13 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699544591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVC5kvj11UWNazgoKPaQxDH585CeKpol97QYH/btY2Y=;
        b=cRIn5/hnElVTePcq0N4hui9EdkEbSeRs5uPwln7WSsqdaZwiIPrA0UWXOF6c6yI9xlANmj
        Im4dVwsy/MJsZNJvarMIcYHsP2/3Oru2iHs9rL7w0RSQffu+uwy9iX29s+tu3H6NC+YKkx
        5yiHgRK9ryEly4q9oloh0LPiSNFPxGo=
Date:   Thu, 09 Nov 2023 15:43:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   jeff.xie@linux.dev
Message-ID: <27f7b8c52e2da5e8003de2226bff181fdc7a7f69@linux.dev>
TLS-Required: No
Subject: Re: [RFC][PATCH 3/4] filemap: implement filemap allocate post
 callback for page_owner
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chensong_2000@189.cn, xiehuan09@gmail.com
In-Reply-To: <ZUzoAhpkrCNz9l1k@casper.infradead.org>
References: <ZUzoAhpkrCNz9l1k@casper.infradead.org>
 <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-4-jeff.xie@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

November 9, 2023 at 10:09 PM, "Matthew Wilcox" <willy@infradead.org> wrot=
e:


>=20
>=20On Thu, Nov 09, 2023 at 11:25:20AM +0800, Jeff Xie wrote:
>=20
>=20>=20
>=20> +static int filemap_alloc_post_page_owner(struct folio *folio, stru=
ct task_struct *tsk,
> >  + void *data, char *kbuf, size_t count)
> >  +{
> >  + int ret;
> >  + int mapcount;
> >  + dev_t s_dev;
> >  + struct inode *inode;
> >  + struct vm_area_struct *vma;
> >  + struct mm_struct *mm;
> >  + unsigned long virtual_start =3D 0x0;
> >  + unsigned long virtual_end =3D 0x0;
> >  + struct address_space *mapping =3D data;
> >=20
>=20
> This is just folio->mapping.

Thanks, I need to know more about struct folio ;-)

>=20
>=20>=20
>=20> + mapcount =3D folio_mapcount(folio);
> >  + if (mapcount && tsk && tsk->mm) {
> >  + mm =3D tsk->mm;
> >  + VMA_ITERATOR(vmi, mm, 0);
> >  + mmap_read_lock(mm);
> >  + for_each_vma(vmi, vma) {
> >  + if (page_mapped_in_vma(&folio->page, vma)) {
> >  + virtual_start =3D vma_address(&folio->page, vma);
> >  + virtual_end =3D virtual_start + folio_nr_pages(folio) * PAGE_SIZE;
> >  + break;
> >  + }
> >  + }
> >  + mmap_read_unlock(mm);
> >  + }
> >=20
>=20
> Why not just walk the rmap directly to find out where it's mapped in
> any process instead of the one which allocated it?

Since the page_owner's result only shows which PID allocated this page, w=
e only need to obtain the address space of the corresponding process for =
that PID.

--
Jeff Xie
