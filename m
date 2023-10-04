Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51AF7B837E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbjJDPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbjJDPYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:24:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93DEE4;
        Wed,  4 Oct 2023 08:24:44 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394F9boO015563;
        Wed, 4 Oct 2023 15:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GFyP5o3xvbVlfmnDgUr1efCm0HaxPLwAX8TPbMyMOZg=;
 b=iFO9ot2MxMFdy8D0wOpJg+czG5xCKEf/vfa9i0QNNQyb2K+4EWo4VC0p1JT4NxBuDDy+
 Yorzm1FhTd2TUoQOwU2I0sO9fOMSN5aR4PQDkzC+nR4xT+0rDZXCnMPksEFn/qYhTRkW
 NFx+YFI1iW6HaqJvFOW39QaHxIlGVD4kKtaxPYFCTJL1nWkDyGi1buGKBMkump1l90nG
 7dAiuLMs6L9E6kqBF4hfFVj8i/Cf+gLaGqxEM3CU2PgeFFJwuOJSjFMHJUP6Zsl7TWTU
 yYR5h81pkFFK8tI2T/4Nq0cY00WpHuHFpQPuqmDpIPNsWYkg7bbZFdSBGl75wdhw2eSB cA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th9ax2uas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 15:24:35 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 394F7P9W010892;
        Wed, 4 Oct 2023 15:24:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q1xg5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 15:24:34 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 394FOX2e7340790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 15:24:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E16E65806E;
        Wed,  4 Oct 2023 15:24:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05A2158063;
        Wed,  4 Oct 2023 15:24:32 +0000 (GMT)
Received: from [9.61.106.119] (unknown [9.61.106.119])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 15:24:31 +0000 (GMT)
Message-ID: <33d32a0a-26bb-6bdf-e07c-79b6ac84a032@linux.ibm.com>
Date:   Wed, 4 Oct 2023 11:24:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] s390/pci: Fix reset of IOMMU software counters
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
References: <20231004-dma_iommu_fix-v1-1-129777cd8232@linux.ibm.com>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20231004-dma_iommu_fix-v1-1-129777cd8232@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1Vp-N0tXhCwsMgyRJpbRd_5qC2CasJzP
X-Proofpoint-ORIG-GUID: 1Vp-N0tXhCwsMgyRJpbRd_5qC2CasJzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0
 mlxlogscore=933 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040108
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 4:56 AM, Niklas Schnelle wrote:
> Together with enabling the Function Measurement Block
> zpci_fmb_enable_device() also resets the software counters. This allows
> to use "echo 0 > /sys/kernel/debug/pci/<dev>/statistics" followed by
> echo "1 > /../statistics" to reset all counters. In commit c76c067e488c
> ("s390/pci: Use dma-iommu layer") this use of the now obsolete counters
> in struct zpci_device was missed as was their removal. Fix this by
> resetting the new counters and removing the old ones.
> 
> Fixes: c76c067e488c ("s390/pci: Use dma-iommu layer")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Verified that I could reproduce the initial issue + tested the fix using NVMe and mlx devices

> ---
> Note: This is based on and references commit IDs from Joerg Roedel's
> iommu/next branch and should go in via the iommu tree.
> ---
>  arch/s390/include/asm/pci.h |  4 ----
>  arch/s390/pci/pci.c         | 13 ++++++++++---
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 3f74f1cf37df..e91cd6bbc330 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -173,10 +173,6 @@ struct zpci_dev {
>  	struct zpci_fmb *fmb;
>  	u16		fmb_update;	/* update interval */
>  	u16		fmb_length;
> -	/* software counters */
> -	atomic64_t allocated_pages;
> -	atomic64_t mapped_pages;
> -	atomic64_t unmapped_pages;
>  
>  	u8		version;
>  	enum pci_bus_speed max_bus_speed;
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 563cb72d9ed0..63fd9e1d9f22 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -157,6 +157,7 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
>  int zpci_fmb_enable_device(struct zpci_dev *zdev)
>  {
>  	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_iommu_ctrs *ctrs;
>  	struct zpci_fib fib = {0};
>  	u8 cc, status;
>  
> @@ -169,9 +170,15 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
>  	WARN_ON((u64) zdev->fmb & 0xf);
>  
>  	/* reset software counters */
> -	atomic64_set(&zdev->allocated_pages, 0);
> -	atomic64_set(&zdev->mapped_pages, 0);
> -	atomic64_set(&zdev->unmapped_pages, 0);
> +	ctrs = zpci_get_iommu_ctrs(zdev);
> +	if (ctrs) {
> +		atomic64_set(&ctrs->mapped_pages, 0);
> +		atomic64_set(&ctrs->unmapped_pages, 0);
> +		atomic64_set(&ctrs->global_rpcits, 0);
> +		atomic64_set(&ctrs->sync_map_rpcits, 0);
> +		atomic64_set(&ctrs->sync_rpcits, 0);
> +	}
> +
>  
>  	fib.fmb_addr = virt_to_phys(zdev->fmb);
>  	fib.gd = zdev->gisa;
> 
> ---
> base-commit: 8e5ab3f54a1061c2be3e1fbcda01fbe604c3450e
> change-id: 20231002-dma_iommu_fix-0a5397992f15
> 
> Best regards,

