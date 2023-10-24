Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB2F7D5B04
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjJXTAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjJXTAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:00:44 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C241310C3;
        Tue, 24 Oct 2023 12:00:42 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c434c33ec0so31843495ad.3;
        Tue, 24 Oct 2023 12:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698174042; x=1698778842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtjJN2v2IlRgjr2CSbemGBy1a2c5zb3n0c0gdEv0B28=;
        b=QSzhUxY8zQ1MnZAzUH8CvPIUeOsMymUTX3BfkEMyqBTMjLPnfaNk0+nGITiDjceA/6
         sPyjdMPDJpKZR1kVyqpo27rT7/jyZ2Vt9gKGsHcRJJeViBgtXYBQTFrkD38NLv0MJQs7
         8sbdOuEBodANZlsd3J+16m2ORnIbR7debvZGmboGbwr3477fWJyWXVDGeELqeUPFtxMU
         v8LhzAma2g9XE2zXjjqPXhfW4Q4+8zyA6BZ0dqnVMIWeu6K9eOv6EpbVrgaAQtQ8omiS
         D8HIqU4CMtI6StkC5G32zLtcfXRp+SLFSO1qK1rUXUucGmfJHsydO7bL9F8fZYnugMOB
         ssow==
X-Gm-Message-State: AOJu0Yx5wIwnbgzhIWF1BbUrArtMXYVWOxWjcLc3tX1nfcUBoasvAQEl
        SpsGPGKQXRLLWQlGZoSOIjQ=
X-Google-Smtp-Source: AGHT+IHsv5pOf8N3VUIytVRyVB9Ag28Vf17S2OMnOiTsoiNnHHFSV+7JY3DQK15yqjmDVmK91Ns3tg==
X-Received: by 2002:a17:90a:1a10:b0:269:c7d:aac5 with SMTP id 16-20020a17090a1a1000b002690c7daac5mr9609930pjk.3.1698174042065;
        Tue, 24 Oct 2023 12:00:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:30e1:c9d3:6b41:493d? ([2620:15c:211:201:30e1:c9d3:6b41:493d])
        by smtp.gmail.com with ESMTPSA id az7-20020a17090b028700b0027d157e686asm7177565pjb.49.2023.10.24.12.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 12:00:41 -0700 (PDT)
Message-ID: <6a89fb45-b940-4db8-9025-944ccd2d4628@acm.org>
Date:   Tue, 24 Oct 2023 12:00:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] core: ufs: fix racing issue between force complete
 and isr
Content-Language: en-US
To:     alice.chao@mediatek.com, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com,
        naomi.chu@mediatek.com, cc.chou@mediatek.com,
        tun-yu.yu@mediatek.com, chun-hung.wu@mediatek.com,
        casper.li@mediatek.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231024084324.12197-1-alice.chao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231024084324.12197-1-alice.chao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 01:43, alice.chao@mediatek.com wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 8382e8cfa414..ef6bd146a767 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5518,13 +5518,13 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
>   			 * For those cmds of which the cqes are not present
>   			 * in the cq, complete them explicitly.
>   			 */
> +			spin_lock_irqsave(&hwq->cq_lock, flags);
>   			if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
> -				spin_lock_irqsave(&hwq->cq_lock, flags);
>   				set_host_byte(cmd, DID_REQUEUE);
>   				ufshcd_release_scsi_cmd(hba, lrbp);
>   				scsi_done(cmd);
> -				spin_unlock_irqrestore(&hwq->cq_lock, flags);
>   			}
> +			spin_unlock_irqrestore(&hwq->cq_lock, flags);
>   		} else {
>   			ufshcd_mcq_poll_cqe_lock(hba, hwq);
>   		}

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

