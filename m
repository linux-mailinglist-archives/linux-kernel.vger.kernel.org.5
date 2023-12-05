Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE173805C20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjLERip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjLERLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:11:55 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DAC1B6;
        Tue,  5 Dec 2023 09:12:01 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ce2ff70619so1828772b3a.2;
        Tue, 05 Dec 2023 09:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796320; x=1702401120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIgtlDTFB4ifEMLDlLmo9Odq54+Ds0nrV8Ow5EkAIJU=;
        b=RrHlwgWYD+BzQORJacpjZ/JZKcWlId6KwX/N/mrbENPKCLcsPLDtxlEVzd2vvc+Ysj
         7CB6r5LW0+Kcg0LMHwIK9e6XoA7GNfnproYdUIax5V2v3kHpEZj3hgQbMpUJCMQ5Zqcu
         fekv6Fx3YrMhhc+Dgvb0ObIKhi4ONMWsd0D0e4BuUxjVV0i1zwSLehI+b/Y8wRb+1JqS
         NquELOsXZDiLw+Sf4LmSyBK71akY0TBYJGybficzl4dGlzU2LjK3jcxsj9ZrFCNopT28
         r0DRfoM0rLOUGD1X60A0qnKGsFA9dKyBakrufMUNp5o4CvCia9VWYT7Azmj8DkVZjPsD
         Q6Pw==
X-Gm-Message-State: AOJu0YyTaUHd40WTqoNLBuAlY0lUF25Gonmh1io+TnMuBE98zGrouuDL
        +LDwj0Cceu/Bm8u0HG12x+Y=
X-Google-Smtp-Source: AGHT+IF7E5x8UjIWIzapLtbdXMzc56ip0B+yOdQGhzLNbJWo3FqUwECSSsaBg30dT08e4RQCQaiGiA==
X-Received: by 2002:a05:6a20:9384:b0:18b:94c5:24c2 with SMTP id x4-20020a056a20938400b0018b94c524c2mr3656735pzh.60.1701796320419;
        Tue, 05 Dec 2023 09:12:00 -0800 (PST)
Received: from [172.20.2.177] (rrcs-173-197-90-226.west.biz.rr.com. [173.197.90.226])
        by smtp.gmail.com with ESMTPSA id bf8-20020a170902b90800b001cfd077fab4sm10409920plb.282.2023.12.05.09.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 09:12:00 -0800 (PST)
Message-ID: <5e7c5c75-cb5f-4afe-9d57-b0cab01a6f26@acm.org>
Date:   Tue, 5 Dec 2023 07:11:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] ufs: core: Add CPU latency QoS support for ufs
 driver
Content-Language: en-US
To:     Naresh Maramaina <quic_mnaresh@quicinc.com>,
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
 <590ade27-b4da-49be-933b-e9959aa0cd4c@acm.org>
 <692cd503-5b14-4be6-831d-d8e9c282a95e@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <692cd503-5b14-4be6-831d-d8e9c282a95e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/4/23 21:58, Naresh Maramaina wrote:
> On 12/5/2023 12:30 AM, Bart Van Assche wrote:
>> On 12/4/23 06:30, Maramaina Naresh wrote:
>>> +    /* This capability allows the host controller driver to use the 
>>> PM QoS
>>> +     * feature.
>>> +     */
>>> +    UFSHCD_CAP_PM_QOS                = 1 << 13,
>>>   };
>>
>> Why does it depend on the host driver whether or not PM QoS is
>> enabled? Why isn't it enabled unconditionally?
> 
> For some platform vendors power KPI might be more important than random 
> io KPI. Hence this flag is disabled by default and can be enabled based 
> on platform requirement.

How about leaving this flag out unless if a host vendor asks explicitly
for this flag?
>>
>>> + * @pm_qos_req: PM QoS request handle
>>> + * @pm_qos_init: flag to check if pm qos init completed
>>>    */
>>
>> Documentation for pm_qos_init is missing.
>>
> Sorry, i didn't get your comment, i have already added documentation for 
> @pm_qos_init, @pm_qos_req variable as above. Do you want me to add this 
> information some where else as well?

Oops, I meant 'qos_vote'.

Thanks,

Bart.

