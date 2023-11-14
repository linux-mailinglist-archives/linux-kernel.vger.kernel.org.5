Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43737EB5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjKNRzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNRzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:55:03 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B952D103;
        Tue, 14 Nov 2023 09:55:00 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6b44befac59so26726b3a.0;
        Tue, 14 Nov 2023 09:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699984500; x=1700589300;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHtHFpyOlSff+x/gFsJmwpSkAzwrVZgPUm4CH8QQRsQ=;
        b=lKPHlwj0Vr6i4+dQxnotGIzN4zB/A6A1vV6i3dSHkHWz9c4ROK564H4aJRCvfGOciD
         aBm/8vDsEgeiWyKIESmcDalb5htWiVcPhCHzYIfzo02fp4aXat0oKaTLxWrdwI9tjHHM
         6rnccAr91XPyH6CKoU53I0rZkKl1InaeJcQSxuhnG9uWvUb7cyRjX7U5s68AkcLbspfR
         rUkv8SW9MW8p2YhPkKjTgesTYjc7Nmp8NgkTw6RHTVciy298tXgCkDcXk7KIjlpmpTgc
         Uw6ncp9hxhMlfRNKoTFXjcy8gZtk7RyF0YM7mezBPw2/PK5SnCmdBVqmVwqchWwcSC8P
         /lug==
X-Gm-Message-State: AOJu0YzorVpqRxqtYzNo3scKDRjZ/NOvtyFPO0nxZxEznjlKOztN6i6Y
        jfbvKklorTDc58On+lnZbRE=
X-Google-Smtp-Source: AGHT+IFWIPTn5fXrUIohnW/KGmKbKA32E+TBbo8K0h5owubh18xMM2TmsvnP3pHHVg11J+B7tWcvIQ==
X-Received: by 2002:a05:6a00:8f0b:b0:6c3:415a:5c05 with SMTP id ji11-20020a056a008f0b00b006c3415a5c05mr4873174pfb.14.1699984499954;
        Tue, 14 Nov 2023 09:54:59 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:2278:ad72:cefb:4d49? ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id fn18-20020a056a002fd200b006926e3dc2besm1448536pfb.108.2023.11.14.09.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 09:54:58 -0800 (PST)
Message-ID: <dca06fd3-d4ad-4e41-a0a3-61d52c85ef9c@acm.org>
Date:   Tue, 14 Nov 2023 09:54:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Content-Language: en-US
To:     SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com, grant.jung@samsung.com,
        junwoo80.lee@samsung.com
References: <CGME20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea@epcas2p4.samsung.com>
 <20231114043704.52525-1-hy50.seo@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231114043704.52525-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/23 20:37, SEO HOYOUNG wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 9a730a794b66..55f4c0eeda7b 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7574,6 +7574,10 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
>   		goto out;
>   	}
>   
> +	if (!ufshcd_cmd_inflight(lrbp->cmd) ||
> +	    test_bit(SCMD_STATE_COMPLETE, &lrbp->cmd->state))
> +		goto out;
> +
>   	err = ufshcd_clear_cmd(hba, tag);
>   	if (err)
>   		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",

The UFS driver must not set SCMD_STATE_COMPLETE itself. Only the SCSI core is
allowed to set that bit.

Thanks,

Bart.
