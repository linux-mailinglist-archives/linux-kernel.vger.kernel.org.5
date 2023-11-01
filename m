Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431C7DE4C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344136AbjKAQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:41:12 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD643101;
        Wed,  1 Nov 2023 09:41:09 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1cc3216b2a1so30314825ad.2;
        Wed, 01 Nov 2023 09:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856869; x=1699461669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+opAGuk+SjszooQP+bzRmo6Dg400E28RdHt2ncsoH0=;
        b=qDuJ6+eV3llRfDwxdlZhqlXUyT98bcBjELOu9E96L7JyS5B5psM4wkkB1KmUFD5gpv
         9zq9/53BAnu/9101GcOmnheTsujO4QOW1+VCNFYMwO8d5g9LmFQ3XSMZC93wRH8Mvl4E
         QCbHZ+AVExPpjHLqN+aigcczJOmz4VL42iuF4QcQwMhRUOmYnwkl2Ygw/oiPQtp/L7/o
         BEmQA+fqjfN8WYA04X1K9+cqaZzsdIqxNn+EqT2fxLa0ZLpbxS/fAh+T09WbY7e1jCLu
         VyBeujHZ+EZ+qZK8oi4BHRhL2nNM0AjOWfHFDCt4Jk/cgPt6neNc1lEBcLxfMpmYKCu5
         jbwQ==
X-Gm-Message-State: AOJu0YzEXWiC/NRxiuGb7pioVywd8tu18JHdwPceiBviNp+ISikxwvC5
        S08KxV08W0cdGUgRpz7IP4I=
X-Google-Smtp-Source: AGHT+IGg5AzXY63twkWghPNw6C7tntLttMWoxGkD3DnikuNd8PsmAbkzHqnqH/lLjvQSnRHbLLBmHQ==
X-Received: by 2002:a17:902:6803:b0:1bf:c59:c944 with SMTP id h3-20020a170902680300b001bf0c59c944mr12504402plk.22.1698856869220;
        Wed, 01 Nov 2023 09:41:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2312:f48f:8e12:6623? ([2620:15c:211:201:2312:f48f:8e12:6623])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b001c3267ae317sm1541678plg.165.2023.11.01.09.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 09:41:08 -0700 (PDT)
Message-ID: <cfcd744a-8986-452c-9c27-71a2e6b245f4@acm.org>
Date:   Wed, 1 Nov 2023 09:41:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
Content-Language: en-US
To:     naomi.chu@mediatek.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        casper.li@mediatek.com, powen.kao@mediatek.com,
        alice.chao@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
References: <20231101082402.20856-1-naomi.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231101082402.20856-1-naomi.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 01:24, naomi.chu@mediatek.com wrote:
> From: Naomi Chu <naomi.chu@mediatek.com>
> 
> Allow UFSHCI 4.0 controllers to fully utilize MCQ queue slots.
> 
> Signed-off-by: Naomi Chu <naomi.chu@mediatek.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 2ba8ec254dce..5c75ab9d6bb5 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -436,7 +436,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
>   
>   	for (i = 0; i < hba->nr_hw_queues; i++) {
>   		hwq = &hba->uhq[i];
> -		hwq->max_entries = hba->nutrs;
> +		hwq->max_entries = hba->nutrs + 1;
>   		spin_lock_init(&hwq->sq_lock);
>   		spin_lock_init(&hwq->cq_lock);
>   		mutex_init(&hwq->sq_mutex);

Please add a Fixes: tag and expand the patch description. What should be
mentioned in the patch description is that the UFSHCI specification
requires that there is always at least one empty slot in each completion
queue. I think that is why the above change is necessary.

Thanks,

Bart.
