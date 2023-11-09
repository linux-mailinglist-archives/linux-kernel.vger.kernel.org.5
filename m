Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6CA7E6D77
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjKIPef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjKIPec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:34:32 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A635AC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:34:30 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699544067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fh5FxdhqxyPMFvq7DwpOb62I2S3xPmOM/5undUGaLs8=;
        b=I+7dxyohR20zDvsdodZRebLKR6MvQj2wWNnaWNN2hCEoIGx9P+RBWSSqNJhXagEizarlYt
        SABIRD5ZWbmiZL5h5Dg6c65s7yNoaa//gElgYzkpQmu36bT73cAsC2bjZ7ZF2eEnB6cfU4
        Io5I2qjGy4YR/De6h5wz7vEU8y8CgV8=
Date:   Thu, 09 Nov 2023 15:34:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   jeff.xie@linux.dev
Message-ID: <58b99c29425dd61130f04b41be14e3609daf5a91@linux.dev>
TLS-Required: No
Subject: Re: [RFC][PATCH 2/4] mm, slub: implement slub allocate post callback
 for page_owner
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chensong_2000@189.cn, xiehuan09@gmail.com
In-Reply-To: <ZUznNn42H5vRUF0r@casper.infradead.org>
References: <ZUznNn42H5vRUF0r@casper.infradead.org>
 <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-3-jeff.xie@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

November 9, 2023 at 10:05 PM, "Matthew Wilcox" <willy@infradead.org> wrot=
e:


>=20
>=20On Thu, Nov 09, 2023 at 11:25:19AM +0800, Jeff Xie wrote:
>=20
>=20>=20
>=20> +#ifdef CONFIG_PAGE_OWNER
> >  +static int slab_alloc_post_page_owner(struct folio *folio, struct t=
ask_struct *tsk,
> >  + void *data, char *kbuf, size_t count)
> >  +{
> >  + int ret;
> >  + struct kmem_cache *kmem_cache =3D data;
> >  +
> >  + ret =3D scnprintf(kbuf, count, "SLAB_PAGE slab_name:%s\n", kmem_ca=
che->name);
> >  +
> >  + return ret;
> >  +}
> >  +#endif
> >=20
>=20
> Or we could do this typesafely ...
>=20
>=20 struct slab *slab =3D folio_slab(folio);
>  struct kmem_cache *kmem_cache =3D slab->slab_cache;
>=20
>=20... and then there's no need to pass in a 'data' to the function.
>

I accidentally replied using my other email (xiehuan09@gmail.com) just no=
w.=20
Thank=20you for your advice. Indeed, the "data" didn't serve any purpose =
here.

--
Jeff Xie
