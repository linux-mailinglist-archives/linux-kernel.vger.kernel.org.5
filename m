Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E777C0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjHNTbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjHNTbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:31:39 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED74C3;
        Mon, 14 Aug 2023 12:31:34 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bbff6b2679so29828715ad.1;
        Mon, 14 Aug 2023 12:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692041494; x=1692646294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJBCZPU7wndBMkkSrEOkrwqV7pJUYyiEi+KRQwCxM/c=;
        b=NJDc54e/tjfqzoQ9i4EmVw8BgzQC3wjgHvVRIIRik8rBhUFP0ASuXldFV5VV70liki
         jos8nxEwquRQnl+m5mDH/6Q5LADe9O8v2P2bGTzYkZ1Gke8rPrvIRNELWTbk75eg0s3d
         XkQZcnxwwUOK7FCuOdICmz+T8/foHx9GrT29t7Dr9OqB3l3cMc0TgssFJksOKzAt47q6
         Ool3DpdjN/4cGt6/XsEgC4/8e/gMQlapOlJIdDRLEfcA49ZigQstvaPnIt7m1/RORGot
         c876MCEDO9lxeVBiIg1a2Zmerg5LKLX8H8EWjyw7sMv9ehjG63oIFu+Cla0bBDe15H/Z
         wF2w==
X-Gm-Message-State: AOJu0Yzf1BrlPICdc9Mpa4OUuGd6LleBJeHh3B1SyAi3nBfBl/OVAbpa
        atYrik2z7AF+t59RXytdaHE=
X-Google-Smtp-Source: AGHT+IHoTREhRW2DAyMdFvoW6r5gYLHWsA6I3O33/SI1QmYEvcRepE2xqpf7X+5KNkimT5WG+C43xA==
X-Received: by 2002:a17:902:ce89:b0:1b8:94e9:e7b0 with SMTP id f9-20020a170902ce8900b001b894e9e7b0mr10722355plg.9.1692041493803;
        Mon, 14 Aug 2023 12:31:33 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e105:59a6:229c:65de? ([2620:15c:211:201:e105:59a6:229c:65de])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902d4d200b001ac591b0500sm9836780plg.134.2023.08.14.12.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:31:33 -0700 (PDT)
Message-ID: <f01040be-dfa5-fe60-fba5-410fccc1d50e@acm.org>
Date:   Mon, 14 Aug 2023 12:31:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 1/2] scsi: ufs: core: convert to dev_err_probe() in
 hba_init
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com, quic_nguyenb@quicinc.com
References: <20230814184352.200531-1-bmasney@redhat.com>
 <20230814184352.200531-2-bmasney@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230814184352.200531-2-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 11:43, Brian Masney wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 129446775796..409d176542e1 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -9235,8 +9235,9 @@ static int ufshcd_variant_hba_init(struct ufs_hba *hba)
>   
>   	err = ufshcd_vops_init(hba);
>   	if (err)
> -		dev_err(hba->dev, "%s: variant %s init failed err %d\n",
> -			__func__, ufshcd_get_var_name(hba), err);
> +		dev_err_probe(hba->dev, err,
> +			      "%s: variant %s init failed err %d\n",
> +			      __func__, ufshcd_get_var_name(hba), err);
>   out:
>   	return err;
>   }

This opportunity could have been used to improve the grammar of the reported
error message. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
