Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E852777FCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353955AbjHQRY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353970AbjHQRYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:24:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EFFBF;
        Thu, 17 Aug 2023 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=98fxoirN/Zj64QlVogFrB6MtraBkkeO+8jNX/wKR4lk=; b=UxZbWIN6QcKSi5/fZfyfAq/rss
        iICZBGvgGctNr3gWm225M02ZqixctF3bQ06Of0YuvvHt3W4JgONL/aqYsOEVZxZLaL7D9BK4N3Hxb
        jpKQDpquTsu4Qcbtij1IOq6nWFjpI/CfBHZv94tH2SGOFDM7klb1Lh3rwvpKNIVo5kaiStDFkTL9l
        t+t09+gBSaKLXy2O+skNYHIxX5fpD80+IwILLfLvl8C0mxfwfY7P3Cswgsc+Bc5nAIB5FCRn1PGNl
        0hJbmDkwVQVYxvEBaI4BKb4mzV3lDgK8l+pDVXvK9oB0KotiZc44o02FRit9PGf9zn9PTf1vbjxW1
        XLxAtZrA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWgjB-006saa-1M;
        Thu, 17 Aug 2023 17:24:09 +0000
Message-ID: <f33e4fad-6ee0-4892-6eae-0d1308f1166e@infradead.org>
Date:   Thu, 17 Aug 2023 10:24:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] scsi: sli4: Remove code duplication
Content-Language: en-US
To:     coolrrsh@gmail.com, james.smart@broadcom.com,
        ram.vegesna@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org
References: <20230817114301.17601-1-coolrrsh@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230817114301.17601-1-coolrrsh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 04:43, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> In the function sli_xmit_bls_rsp64_wqe, the 'if' and 'else' conditions
> evaluates the same expression and gives same output. Also, params->s_id
> shall not be equal to U32_MAX. Therefore removing the unused code.
> 
> This fixes coccinelle warning such as:

Thanks for that. ^^^^^

> drivers/scsi/elx/libefc_sli/sli4.c:2320:2-4: WARNING: possible
> condition with no effect (if == else)
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

Based on feedback from Broadcom people,
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v1->v2
> Modified patch and the corrected the warnings using checkpatch.
> v2->v3
> Modified patch details keeping HW descriptor variable.
> 
> ---
>  drivers/scsi/elx/libefc_sli/sli4.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
> index 8f96049f62dd..5e7fb110bc3f 100644
> --- a/drivers/scsi/elx/libefc_sli/sli4.c
> +++ b/drivers/scsi/elx/libefc_sli/sli4.c
> @@ -2317,12 +2317,8 @@ sli_xmit_bls_rsp64_wqe(struct sli4 *sli, void *buf,
>  		SLI4_GENERIC_CONTEXT_VPI << SLI4_BLS_RSP_WQE_CT_SHFT;
>  		bls->context_tag = cpu_to_le16(params->vpi);
>  
> -		if (params->s_id != U32_MAX)
> -			bls->local_n_port_id_dword |=
> -				cpu_to_le32(params->s_id & 0x00ffffff);
> -		else
> -			bls->local_n_port_id_dword |=
> -				cpu_to_le32(params->s_id & 0x00ffffff);
> +		bls->local_n_port_id_dword |=
> +			cpu_to_le32(params->s_id & 0x00ffffff);
>  
>  		dw_ridflags = (dw_ridflags & ~SLI4_BLS_RSP_RID) |
>  			       (params->d_id & SLI4_BLS_RSP_RID);

-- 
~Randy
