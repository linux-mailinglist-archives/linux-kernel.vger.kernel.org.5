Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26B77CC703
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbjJQPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjJQPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC994C04
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697554335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkcETT//EFaL9Pze2jt5mEPkfaMAWnv0Qv1/ld7Gzfk=;
        b=LRpzNVw20A/Jor15CAeJ01hwIficb7X5OyhGddNM5E28X5gDL3YbhwQCO5Cgt2ENX8Elkk
        be3HajT3aOmKAQFQPiat4kyNuxle9nCGx37m1wwiVKLShpZAY9oNgC/8smKB2ejpA2Vp7Q
        N50bQLbMTgy5qMY4SDp0+16/lYoJpRo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-xJOvuZDpMlyTLzI9SfdSkQ-1; Tue, 17 Oct 2023 10:52:04 -0400
X-MC-Unique: xJOvuZDpMlyTLzI9SfdSkQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-407da05ee50so4613275e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697554323; x=1698159123;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkcETT//EFaL9Pze2jt5mEPkfaMAWnv0Qv1/ld7Gzfk=;
        b=rb0yqel0kP/kmhUadotuv1qRztS3SOicPBSKl8OxlrW8q8mPj3JKelabtswrZFp785
         J3SZuerEEKcjbo/IsRpHt6qmCVq1PRa+mpDqlwEIfGVXhQf9PKfi4Fjt9AJ4tgbM3m+b
         mLwK6GdKtEvQ3sdqfJsSBTM3llqIM9ROJhRJpewuF7mGF+7cDuV79dy6ZREvMoRR2ed+
         J+C5wL2SU6odRLiHYyhHI8Ht/mGQKltHbTpVGPpNAsO+HeqNUw+qRvHcWBRShGyLcoTm
         hWAXiaEgG4u9124HH14JrQSM1y36uNfcP70JwXSvi2VtNoTWTEzTpqoMdj2JtPzc3c7h
         Zr6w==
X-Gm-Message-State: AOJu0Yx+GE4qvPs3SI+V9sSKheE9Iux4aKQYTS0Aui1nulqWmI0XVV4z
        lKAqf/mhPAbDSmKrMIYBiWp7e/1wpIHPv3jAthCLitGR3HjOketYcxEqh3wkzfUSIjFGfn9qo6R
        H8NMp1sT5p2JoZKmAkPbDfxOW
X-Received: by 2002:a5d:4987:0:b0:32d:8f50:8553 with SMTP id r7-20020a5d4987000000b0032d8f508553mr2129611wrq.55.1697554322934;
        Tue, 17 Oct 2023 07:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbtcpK9ZcLxNynF1iY2rO4bpSfkOlVHEomMguJ7XEMTPw/YCqxreMiWzQaPdLtQ4ekkjJrfQ==
X-Received: by 2002:a5d:4987:0:b0:32d:8f50:8553 with SMTP id r7-20020a5d4987000000b0032d8f508553mr2129602wrq.55.1697554322647;
        Tue, 17 Oct 2023 07:52:02 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id h4-20020adfe984000000b003143c9beeaesm1860384wrm.44.2023.10.17.07.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:52:02 -0700 (PDT)
Message-ID: <97d106d28e4c3468912a478dba79ab2221109cbd.camel@redhat.com>
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun
 and destination fields
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     joro@8bytes.org, seanjc@google.com, vasant.hegde@amd.com,
        jon.grimm@amd.com, santosh.shukla@amd.com,
        joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
        boris.ostrovsky@oracle.com
Date:   Tue, 17 Oct 2023 17:51:59 +0300
In-Reply-To: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У вт, 2023-10-17 у 09:42 -0500, Suravee Suthikulpanit пише:
> According to the recent update in the AMD IOMMU spec [1], the IsRun and
> Destination fields of the Interrupt Remapping Table Entry (IRTE) are not
> cached by the IOMMU hardware.

Is that true for all AMD hardware that supports AVIC? E.g Zen1/Zen2 hardware?

Is there a chance that this will cause a similar errata to the is_running
errata that Zen2 cpus have?



> 
> Therefore, do not issue the INVALIDATE_INTERRUPT_TABLE command when
> updating IRTE[IsRun] and IRTE[Destination] when IRTE[GuestMode]=1, which
> should help improve IOMMU AVIC/x2AVIC performance.
> 
> References:
> [1] AMD IOMMU Spec Revision (Rev 3.08-PUB)
> (Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)

Looks like the link is broken.


Best regards,
	Maxim Levitsky

> 
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 089886485895..d63590563d3e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2970,8 +2970,8 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
>  	return index;
>  }
>  
> -static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> -			  struct irte_ga *irte)
> +static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> +			    struct irte_ga *irte)
>  {
>  	struct irq_remap_table *table;
>  	struct irte_ga *entry;
> @@ -2998,6 +2998,18 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>  
>  	raw_spin_unlock_irqrestore(&table->lock, flags);
>  
> +	return 0;
> +}
> +
> +static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> +			  struct irte_ga *irte)
> +{
> +	bool ret;
> +
> +	ret = __modify_irte_ga(iommu, devid, index, irte);
> +	if (ret)
> +		return ret;
> +
>  	iommu_flush_irt_and_complete(iommu, devid);
>  
>  	return 0;
> @@ -3681,8 +3693,8 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
>  	}
>  	entry->lo.fields_vapic.is_run = is_run;
>  
> -	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry);
> +	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> +				ir_data->irq_2_irte.index, entry);
>  }
>  EXPORT_SYMBOL(amd_iommu_update_ga);
>  #endif


