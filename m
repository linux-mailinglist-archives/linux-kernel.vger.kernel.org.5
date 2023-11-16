Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935AA7EE8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345548AbjKPVet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjKPVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:34:47 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C7181;
        Thu, 16 Nov 2023 13:34:44 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso11659445ad.3;
        Thu, 16 Nov 2023 13:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700170484; x=1700775284;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Lg5JQN/IO4naSkyvjuyEMADD75Wozkh18eEuNQzW8w=;
        b=AZo58xP73OunjtUXX561/zSPIHoyIxpf7ZzdXzUCEw1MQaTdHyh5jLGSSlJc2WuarX
         LULzf4FGIrppj/BWzB8X6FYZOy9V8LVF9nCBDlFHt6ZJX3t4rnpa6hyTVVgpetXmCqjx
         9Jwe41RpQ7WeRZnvd2UvXBnHHoUiWDGtqg0Vx96EyHbhtzy+Wt/0BLz1wp6N2cPB5dlC
         Ya8xdasehfZOLQEREjLuKweRoiGw35q+u6tsxqE0aMyt0lj2e2RENXp+8GbKZ6aJ9bJH
         QeYLr5qvWGLFf2MB7+AziB0g6YbdnOfdcLy3GACcCKRgHnladB2HKrKK4e81i0rTGzFv
         1F6g==
X-Gm-Message-State: AOJu0Yw/GVOVeV5feDx7zJUDvgV3YcGbHfQcVhl+dvWM4OuZRFKj05NV
        7WqSj3Gz5mBfgrAF8nR+jJ4yrVCkAKM=
X-Google-Smtp-Source: AGHT+IExskLIEbduOJa+RiIqBMOy0Jopc7fpY4dCGuXFO6bGuQvOXAlU7g5NDn+IBF1YhoTrEHuUiA==
X-Received: by 2002:a17:902:ab0f:b0:1ca:86db:1d39 with SMTP id ik15-20020a170902ab0f00b001ca86db1d39mr12305110plb.30.1700170483938;
        Thu, 16 Nov 2023 13:34:43 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:9b50:bd2b:ae57:7a6d? ([2620:0:1000:8411:9b50:bd2b:ae57:7a6d])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709028ecb00b001cc51680695sm111521plo.259.2023.11.16.13.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 13:34:43 -0800 (PST)
Message-ID: <3a6e3034-3e7c-4983-9d15-8112ae737281@acm.org>
Date:   Thu, 16 Nov 2023 13:34:40 -0800
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

I think that the above approach is racy: the state of lrbp->cmd can
change after it has been checked and before ufshcd_clear_cmd() is called.

Thanks,

Bart.
