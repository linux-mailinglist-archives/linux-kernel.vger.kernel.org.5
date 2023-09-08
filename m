Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC736798A18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbjIHPiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238178AbjIHPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:38:19 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A161BFF;
        Fri,  8 Sep 2023 08:38:15 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so2432898a91.0;
        Fri, 08 Sep 2023 08:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694187494; x=1694792294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOERKHutiZlXz7bvmf0W6NeUuFZ/gnqQS2q918Qpw+o=;
        b=L27d15moJ2fOaO9eeyvvLQgTfRZR7gYV6l4b1aPrUAMSvfqLXK5vPceh6WxWA3Dzgw
         ZEtNOfsIoFYaLw8F8RJaX6DGwxI/KatQ4AgkfO5NMwWIL5yqMTWiXIY7IxHsp7wD4HkV
         1WlDFdbinj+sp2qhVnu4y9ylXiviEr6TMxORFOnOjAW9UVuKFpZjTriC2JcMvNlJV/qY
         A4eFRU0xlWmC/SHt8OwhIuOlVfIl1/z1J+j4YzD22D/fjkxzuqftK+XnkUvQEZkUZMFH
         fbjjxMzcvPHeUAtkYFBfX0SgFkRNcLvTxOC5/t/8IEnBeggEynckx8oYpi/bCmhdWcyX
         2wDQ==
X-Gm-Message-State: AOJu0Yzpzw81GOfp1iS5uaq9vrhMK+XForH6lSDy+RTCFJalrKgQVE+D
        uyra7kxFYlLUxn3l95xokjI=
X-Google-Smtp-Source: AGHT+IFMO9+uxTS912paVNHVIS3J3nEA8gF0LqIwO0anJXYopM9bDy69Y4RdtISx/Q1ok84HeGmWMw==
X-Received: by 2002:a17:90a:9ae:b0:261:2824:6b8c with SMTP id 43-20020a17090a09ae00b0026128246b8cmr7914329pjo.13.1694187494371;
        Fri, 08 Sep 2023 08:38:14 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090a120200b0026307fa0442sm3414804pja.49.2023.09.08.08.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:38:13 -0700 (PDT)
Message-ID: <e03f1e62-1f22-422d-9bf8-fab480ccefb7@acm.org>
Date:   Fri, 8 Sep 2023 08:38:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] scsi: ufs: core: Add ufshcd_wb_buf_resize function
 to enable WB buffer resize
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        zhanghui <zhanghui31@xiaomi.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230908102113.547-1-luhongfei@vivo.com>
 <20230908102113.547-3-luhongfei@vivo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230908102113.547-3-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/23 03:20, Lu Hongfei wrote:
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index f42d99ce5bf1..85caefa421f7 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -98,6 +98,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
>   			     enum query_opcode desc_op);
>   
>   int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
> +int ufshcd_wb_buf_resize(struct ufs_hba *hba, u32 resize_op);
>   
>   /* Wrapper functions for safely calling variant operations */
>   static inline const char *ufshcd_get_var_name(struct ufs_hba *hba)
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 93417518c04d..7e4461360cbd 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -6045,6 +6045,27 @@ static bool ufshcd_wb_need_flush(struct ufs_hba *hba)
>   	return ufshcd_wb_presrv_usrspc_keep_vcc_on(hba, avail_buf);
>   }
>   
> +int ufshcd_wb_buf_resize(struct ufs_hba *hba, u32 resize_op)
> +{
> +	int ret;
> +	u8 index;
> +
> +	ufshcd_scsi_block_requests(hba);
> +	if (ufshcd_wait_for_doorbell_clr(hba, 1 * USEC_PER_SEC))
> +		goto out;
> +
> +	index = ufshcd_wb_get_query_index(hba);
> +	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
> +		QUERY_ATTR_IDN_WB_BUF_RESIZE_EN, index, 0, &resize_op);
> +	if (ret)
> +		dev_err(hba->dev,
> +			"%s: Enable WB buf resize operation failed %d\n",
> +			__func__, ret);
> +out:
> +	ufshcd_scsi_unblock_requests(hba);
> +	return ret;
> +}
> +
>   static void ufshcd_rpm_dev_flush_recheck_work(struct work_struct *work)
>   {
>   	struct ufs_hba *hba = container_of(to_delayed_work(work),
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 7d07b256e906..7dd560dc22c6 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1381,6 +1381,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
>   				     struct ufs_ehs *ehs_rsp, int sg_cnt,
>   				     struct scatterlist *sg_list, enum dma_data_direction dir);
>   int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
> +int ufshcd_wb_buf_resize(struct ufs_hba *hba, u32 resize_op);
>   int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
>   int ufshcd_suspend_prepare(struct device *dev);
>   int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);

My feedback about this patch is as follows:
- If a new function (ufshcd_wb_buf_resize()) is introduced, a caller for 
that function should be introduced in the same patch.
- Function declarations should be added either in the private header 
file or in the public header file (include/ufs/ufshcd.h) but not in both.
- The name of the ufshcd_wb_buf_resize() function seems misleading to 
me. To me that name suggests that this functions resizes the 
WriteBooster buffer. That's not what that function does - what it does 
it to configure whether or not the UFS device is allowed to resize the 
WB buffer.
- Please remove the ufshcd_scsi_block_requests(), 
ufshcd_wait_for_doorbell_clr() and ufshcd_scsi_unblock_requests() calls. 
I'm not aware of any requirement to pause SCSI command submission while 
changing whether or not WB buffer resizing is enabled or disabled.

Thanks,

Bart.
