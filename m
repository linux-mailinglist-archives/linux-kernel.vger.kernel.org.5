Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4D5803DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjLDTAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjLDTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:00:33 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9F3D5;
        Mon,  4 Dec 2023 11:00:40 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d001e4cf7cso19426805ad.2;
        Mon, 04 Dec 2023 11:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716439; x=1702321239;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1TuqS/7C7MDnJYXgnCCq7sNkI/3dfj9oPHuyt6Lz0g=;
        b=L50mEP/RjTLfGLZHinpsWm1fN2yS+mVPWeISYoi84N6RoRi97wZake/V2F0hDo9wsG
         ht38us+Z8QtgBY+S5US7wowkICCqkQ6tA9xTC/4iATiV55O6vLa1Z71EUponCII4dQ85
         QWZ7QzxRE0ei7nrL+dprw4l4o+GrUahU3/dTChReab3/pjrznUGojVQ8cZYGUgGEA+Iz
         lG+dp1MhW/PtPNXgz5mTHsKEE5rETk1VoQE4nGnmP7rP+ncl9F9WGyHh5czGaTro3lO7
         /Vm2E81mFfApXfXskdtf7QSZfF5flUGd9OfgwoCncBe4kg1srB8WKZ1kUcPwOFWYJnON
         Yslw==
X-Gm-Message-State: AOJu0Yw4xl3SElhIUTjYAjdSuRfnXP9XT3kQ3aUhEib0UbmQQLHCkH69
        azS0+8KWL2Md/3TfTFAnhj8=
X-Google-Smtp-Source: AGHT+IHHQ2rAL0Tvz4EmLO23SEvKXkdcMniEXebNQQPfxw8obQEF0UOva9F7zaPNEHq1byNEaiZN3A==
X-Received: by 2002:a17:902:e5c8:b0:1d0:7d9a:3bc3 with SMTP id u8-20020a170902e5c800b001d07d9a3bc3mr2090541plf.79.1701716439379;
        Mon, 04 Dec 2023 11:00:39 -0800 (PST)
Received: from [10.46.23.145] ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id i31-20020a63221f000000b005bd2b3a03eesm7940081pgi.6.2023.12.04.11.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 11:00:39 -0800 (PST)
Message-ID: <590ade27-b4da-49be-933b-e9959aa0cd4c@acm.org>
Date:   Mon, 4 Dec 2023 11:00:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] ufs: core: Add CPU latency QoS support for ufs
 driver
Content-Language: en-US
To:     Maramaina Naresh <quic_mnaresh@quicinc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chu.stanley@gmail.com
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
 <20231204143101.64163-2-quic_mnaresh@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231204143101.64163-2-quic_mnaresh@quicinc.com>
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

On 12/4/23 06:30, Maramaina Naresh wrote:
> +	u32	(*config_qos_vote)(struct ufs_hba *hba);

Please remove the above callback since this patch series does not
introduce any instances of this callback.

> +
> +	/* This capability allows the host controller driver to use the PM QoS
> +	 * feature.
> +	 */
> +	UFSHCD_CAP_PM_QOS				= 1 << 13,
>   };

Why does it depend on the host driver whether or not PM QoS is
enabled? Why isn't it enabled unconditionally?

> + * @pm_qos_req: PM QoS request handle
> + * @pm_qos_init: flag to check if pm qos init completed
>    */

Documentation for pm_qos_init is missing.

>   struct ufs_hba {
>   	void __iomem *mmio_base;
> @@ -1076,6 +1089,9 @@ struct ufs_hba {
>   	struct ufs_hw_queue *uhq;
>   	struct ufs_hw_queue *dev_cmd_queue;
>   	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
> +	struct pm_qos_request pm_qos_req;
> +	bool pm_qos_init;
> +	u32 qos_vote;

Please rename "pm_qos_init" into "pm_qos_initialized".

Thanks,

Bart.

