Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A09779AE0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbjIKVIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244172AbjIKT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:29:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0281212A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:29:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52e297c7c39so6062552a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694460560; x=1695065360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZzh/DBuy01jQlncJ8BxreG4T0oh4ErWrLQjt3L1jcs=;
        b=DmZeS5E5wfP7m58TcrDx8OU2oLh/XsOWnGiYURI6kJVLSz+dBx8sJS3rm5ElZNTZou
         7dZmvf7PCmBqJcfoZhzaHk43i6bQUb0Cs4KcqzrG1A2UbDnQeT43cUMqwxLLqvrIf7EL
         sBAv5YdFqQ3DnBgvjwqAe80ZwniUbmvhxfxLu8u6ceqNPIEgxEUkHJ/T9LssBwy1IGRe
         s8vWfDYxJGV9dZEKPhj7Ca9IB6+AEsT5a7Z6Se4sYCb47spO3Q7TmMJFhIlvtZnYDEeV
         Qymb6YeOGTQ8FXaz7TssAGiCSpDcjYwYY5m8tbWaXeJtqcTlm8kvCYq7wVvvf+n2DeTU
         QbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460560; x=1695065360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZzh/DBuy01jQlncJ8BxreG4T0oh4ErWrLQjt3L1jcs=;
        b=u/gfSkc37cKAhrYmwyIxU6YIedRKrctrTdZAE2l+XM3GLuo0CyxvEGsDBrFNxCuMVM
         6HGBYSV7nSed3vyVPW5MFo8X4PWIWb42lp8ERhARSK/UOu3eOpWKtQINFEGTChBcA1PC
         4doI8RaTKVBarSh3s0OAh/xupj6RjYAxgmBGapCh0OZ7u7g9bULELGVcRTcmfwQMiNRW
         AoWtVON8Yp852Fq0Y6OFQaRqY36x2UZi3c6OVZc1Qdr30bBgEK5qbv8Ap8m/xax2ViXR
         OkaYTqROZEgUPsINpf7zKkFG60/v6RrQqq5umIGusHzvNCCXwg+HneY9USrJToc0Aztf
         ULmw==
X-Gm-Message-State: AOJu0YwklH2xAd/EvDg510lee8U7nk5YCWWXLbW6oLSXXB+8ZqI73vjQ
        O40lxpAAvpaNG247MpeSIPg=
X-Google-Smtp-Source: AGHT+IH3JKjxir6dCvy6TAASsokGwwD1qL65KbvEhXU9Z1phY7jA9USqKstRMNkQ2Jhj8vTcYYdzXg==
X-Received: by 2002:aa7:d1cb:0:b0:52c:9f89:4447 with SMTP id g11-20020aa7d1cb000000b0052c9f894447mr8580218edp.4.1694460559977;
        Mon, 11 Sep 2023 12:29:19 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id w9-20020aa7cb49000000b0051bed21a635sm5027658edt.74.2023.09.11.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:29:19 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     joro@8bytes.org, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/sun50i: Allow page sizes between 4K and 1M
Date:   Mon, 11 Sep 2023 21:29:18 +0200
Message-ID: <5707055.DvuYhMxLoT@archlinux>
In-Reply-To: <40649946-739b-fec6-d743-f7828613fec5@arm.com>
References: <20230911190218.1758812-1-jernej.skrabec@gmail.com>
 <40649946-739b-fec6-d743-f7828613fec5@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 11, 2023 9:06:12 PM CEST Robin Murphy wrote:
> On 2023-09-11 20:02, Jernej Skrabec wrote:
> > While peripheral supports only 4K page sizes, we can easily emulate
> > support for bigger page sizes, up to 1M. This is done by making multiple
> > entries in map function or clearing multiple entries in unmap.
> 
> No, it's done by converting over to the {map,unmap}_pages ops. There's
> no need to resurrect this horrible bodge.

Missed those, thanks! In any case, logic to implement those isn't that 
different than here.

Best regards,
Jernej

> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > 
> >   drivers/iommu/sun50i-iommu.c | 49 +++++++++++++++++++++++-------------
> >   1 file changed, 31 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> > index 74c5cb93e900..93077575d60f 100644
> > --- a/drivers/iommu/sun50i-iommu.c
> > +++ b/drivers/iommu/sun50i-iommu.c
> > @@ -95,6 +95,10 @@
> > 
> >   #define SPAGE_SIZE			4096
> > 
> > +#define SUN50I_IOMMU_PGSIZES		(SZ_4K | SZ_8K | SZ_16K | SZ_32K | 
\
> > +					 SZ_64K | SZ_128K | 
SZ_256K | \
> > +					 SZ_512K | SZ_1M)
> > +
> > 
> >   struct sun50i_iommu {
> >   
> >   	struct iommu_device iommu;
> > 
> > @@ -593,10 +597,12 @@ static int sun50i_iommu_map(struct iommu_domain
> > *domain, unsigned long iova,> 
> >   {
> >   
> >   	struct sun50i_iommu_domain *sun50i_domain = 
to_sun50i_domain(domain);
> >   	struct sun50i_iommu *iommu = sun50i_domain->iommu;
> > 
> > -	u32 pte_index;
> > +	u32 pte_index, pages, i;
> > 
> >   	u32 *page_table, *pte_addr;
> >   	int ret = 0;
> > 
> > +	pages = size / SPAGE_SIZE;
> > +
> > 
> >   	page_table = sun50i_dte_get_page_table(sun50i_domain, iova, gfp);
> >   	if (IS_ERR(page_table)) {
> >   	
> >   		ret = PTR_ERR(page_table);
> > 
> > @@ -604,18 +610,22 @@ static int sun50i_iommu_map(struct iommu_domain
> > *domain, unsigned long iova,> 
> >   	}
> >   	
> >   	pte_index = sun50i_iova_get_pte_index(iova);
> > 
> > -	pte_addr = &page_table[pte_index];
> > -	if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
> > -		phys_addr_t page_phys = 
sun50i_pte_get_page_address(*pte_addr);
> > -		dev_err(iommu->dev,
> > -			"iova %pad already mapped to %pa cannot 
remap to %pa prot: %#x\n",
> > -			&iova, &page_phys, &paddr, prot);
> > -		ret = -EBUSY;
> > -		goto out;
> > +	for (i = 0; i < pages; i++) {
> > +		pte_addr = &page_table[pte_index + i];
> > +		if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
> > +			phys_addr_t page_phys = 
sun50i_pte_get_page_address(*pte_addr);
> > +
> > +			dev_err(iommu->dev,
> > +				"iova %pad already mapped to %pa 
cannot remap to %pa prot: %#x\n",
> > +				&iova, &page_phys, &paddr, prot);
> > +			ret = -EBUSY;
> > +			goto out;
> > +		}
> > +		*pte_addr = sun50i_mk_pte(paddr, prot);
> > +		paddr += SPAGE_SIZE;
> > 
> >   	}
> > 
> > -	*pte_addr = sun50i_mk_pte(paddr, prot);
> > -	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> > +	sun50i_table_flush(sun50i_domain, &page_table[pte_index], pages);
> > 
> >   out:
> >   	return ret;
> > 
> > @@ -626,8 +636,10 @@ static size_t sun50i_iommu_unmap(struct iommu_domain
> > *domain, unsigned long iova> 
> >   {
> >   
> >   	struct sun50i_iommu_domain *sun50i_domain = 
to_sun50i_domain(domain);
> >   	phys_addr_t pt_phys;
> > 
> > +	u32 dte, pages, i;
> > 
> >   	u32 *pte_addr;
> > 
> > -	u32 dte;
> > +
> > +	pages = size / SPAGE_SIZE;
> > 
> >   	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
> >   	if (!sun50i_dte_is_pt_valid(dte))
> > 
> > @@ -636,13 +648,14 @@ static size_t sun50i_iommu_unmap(struct iommu_domain
> > *domain, unsigned long iova> 
> >   	pt_phys = sun50i_dte_get_pt_address(dte);
> >   	pte_addr = (u32 *)phys_to_virt(pt_phys) +
> >   	sun50i_iova_get_pte_index(iova);
> > 
> > -	if (!sun50i_pte_is_page_valid(*pte_addr))
> > -		return 0;
> > +	for (i = 0; i < pages; i++)
> > +		if (!sun50i_pte_is_page_valid(pte_addr[i]))
> > +			return 0;
> > 
> > -	memset(pte_addr, 0, sizeof(*pte_addr));
> > -	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> > +	memset(pte_addr, 0, sizeof(*pte_addr) * pages);
> > +	sun50i_table_flush(sun50i_domain, pte_addr, pages);
> > 
> > -	return SZ_4K;
> > +	return size;
> > 
> >   }
> >   
> >   static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain
> >   *domain,
> > 
> > @@ -827,7 +840,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
> > 
> >   }
> >   
> >   static const struct iommu_ops sun50i_iommu_ops = {
> > 
> > -	.pgsize_bitmap	= SZ_4K,
> > +	.pgsize_bitmap	= SUN50I_IOMMU_PGSIZES,
> > 
> >   	.device_group	= sun50i_iommu_device_group,
> >   	.domain_alloc	= sun50i_iommu_domain_alloc,
> >   	.of_xlate	= sun50i_iommu_of_xlate,




