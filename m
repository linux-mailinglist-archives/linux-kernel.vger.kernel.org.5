Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4AC7D731C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJYSTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjJYSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:19:45 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0166129;
        Wed, 25 Oct 2023 11:19:43 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6be0277c05bso31651b3a.0;
        Wed, 25 Oct 2023 11:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698257983; x=1698862783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIF5SNyxqETQBsZl3EiA63EhgtzdhRNTSD6F6SXnqZg=;
        b=WcGMl/efERmq5xPjDaxVmxtQ3Mofmj52s9mHxbCMpyVTdS12hrpzrpLcyUc2AT9xpL
         n55eDQqaAO2FYsdMe0m/kVLWIK+84Z5Br0E7ex5KBlMiPw7sKyqSLSYFwNlJZ978faOq
         ZdseF+fG3D37MwWutmiZ09l3CWuN2JQ+VHItO0HvMV5/sQbfWSZIrz3lz9jx9ekc+Jeq
         d+vdpxkp97WzR9FZLEQO/pg19p/L443YXzUUAm+tIgyM4wuWf02N71ZzAsbOjxrwvCr8
         oJO/l5ZlmGa+PKZtHsfN2/n41Qyab5xsALxXm5XPBIndk68bj4LhDxlHbqUHw7ae1Lo5
         WlGg==
X-Gm-Message-State: AOJu0YxAeVWZTnH92cp6CKIXta28z/chviJW0HCYcbZbYKNNTXeo0BcH
        q/BCaerEdD280yA69YSNMa8=
X-Google-Smtp-Source: AGHT+IFcUoXt18mLHyK8MFK5ZXgiCi3Mgy4xr3p/Rwf8WYnjPczedMMBcAG56P0hgziq74rf/DYy+w==
X-Received: by 2002:a62:f202:0:b0:6b6:7a04:6f9 with SMTP id m2-20020a62f202000000b006b67a0406f9mr12107461pfh.28.1698257982908;
        Wed, 25 Oct 2023 11:19:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4dcf:e974:e319:6ce8? ([2620:15c:211:201:4dcf:e974:e319:6ce8])
        by smtp.gmail.com with ESMTPSA id e8-20020a056a0000c800b006bd26bdc909sm9768960pfj.72.2023.10.25.11.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:19:42 -0700 (PDT)
Message-ID: <573a7ab2-93ec-4184-9806-31a7ed99c04b@acm.org>
Date:   Wed, 25 Oct 2023 11:19:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] scsi: fnic: Add support for multiqueue (MQ) in fnic
 driver
Content-Language: en-US
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231020190629.338623-1-kartilak@cisco.com>
 <20231020190629.338623-13-kartilak@cisco.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231020190629.338623-13-kartilak@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 12:06, Karan Tilak Kumar wrote:
> @@ -405,22 +388,20 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
>    * Routine to send a scsi cdb
>    * Called with host_lock held and interrupts disabled.
>    */

This patch removes the DEF_SCSI_QCMD() invocation so the above comment 
is now wrong. Please fix it.

> -static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
> +static int fnic_queuecommand_lck(struct scsi_cmnd *sc, uint32_t mqtag, uint16_t hwq)

Because this patch removes the DEF_SCSI_QCMD() invocation, the name of 
the fnic_queuecommand_lck() function is now incorrect. Please remove the 
_lck() suffix.

> -DEF_SCSI_QCMD(fnic_queuecommand)
> +int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
> +{
> +	struct request *const rq = scsi_cmd_to_rq(sc);
> +	int rc;
> +	struct fc_lport *lp = shost_priv(sc->device->host);
> +	struct fnic *fnic = lport_priv(lp);
> +	uint32_t mqtag = 0;
> +	int tag = 0;
> +	uint16_t hwq = 0;
> +
> +	mqtag = blk_mq_unique_tag(rq);
> +	hwq = blk_mq_unique_tag_to_hwq(mqtag);
> +	tag = blk_mq_unique_tag_to_tag(mqtag);
> +
> +	if (tag >= fnic->fnic_max_tag_id) {
> +		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
> +				"fnic<%d>: %s: Out of range tag: 0x%x\n",
> +				fnic->fnic_num, __func__, tag);
> +		sc->result = DID_ERROR << 16;
> +		scsi_done(sc);
> +		return 0;
> +	}
> +
> +	rc = fnic_queuecommand_lck(sc, mqtag, hwq);
> +	return rc;
> +}

The code guarded by "if (tag >= fnic->fnic_max_tag_id)" should be 
removed and instead the driver should ensure that tags never exceed the 
fnic->fnic_max_tag_id limit.

Please also remove the local variable 'rc'.

Thanks,

Bart.

