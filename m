Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B44801472
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379441AbjLAU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLAU1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:27:45 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6BDD;
        Fri,  1 Dec 2023 12:27:51 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso8607295ad.0;
        Fri, 01 Dec 2023 12:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462471; x=1702067271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TFPInV3Tc8ZFH5rwZRwPYcB8wwI/zl+CFu8s3Ie1xU=;
        b=hhfbuBFnoT9UuZff9clCk5x+1Fv105MjcMJNnWTtQdbeHLXsXAjPQ10tPkSECoHreM
         oUZulqeyXaEp0xdX7H4ooeRzlGCdUptAi8c6r898R7D8ZbcubB4BtN407TmEtV6uHVTb
         3VO7azcQYt2tOUeocIXEEXuYLP8rP55sRd2vuLe3akR8KvsIPk8d28NYZHPcI3uJYpKz
         94t8fuH8WXEPswkDbqz49KgKHH7pk7mqgRFrMweNguk24dTIT7D+Rj5TUIYOZo96Tnny
         IFrXyWFwMVMH0rKSA9rrs67ZsBifMgO4yOHz9+Bw3lpMFv0LO+55dC3BUdJOWFTjtu8R
         25Ig==
X-Gm-Message-State: AOJu0YwlIyDqt835xeX/mFUEZHy/7IonP33YFcCrbrogiuV8Br+SBWie
        pqCyqD0m5CiuThvgu0bPv14=
X-Google-Smtp-Source: AGHT+IEPDjVtIn3LAftvRhiMx0r4y+ay+rjlITtJ30wwSBgS3pfnXWGK/B1TcLukDKXmQ8nLyPPJrQ==
X-Received: by 2002:a17:903:22c1:b0:1d0:1c45:fca6 with SMTP id y1-20020a17090322c100b001d01c45fca6mr105449plg.55.1701462470485;
        Fri, 01 Dec 2023 12:27:50 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001c9d011581dsm797614plg.164.2023.12.01.12.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 12:27:50 -0800 (PST)
Message-ID: <ac563d4a-29dc-4985-bdbf-f6e77ba74a82@acm.org>
Date:   Fri, 1 Dec 2023 12:27:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] scsi: ufs: qcom: Export ufshcd_{enable/disable}_irq
 helpers and make use of them
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-7-manivannan.sadhasivam@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231201151417.65500-7-manivannan.sadhasivam@linaro.org>
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

On 12/1/23 07:14, Manivannan Sadhasivam wrote:
> Instead of duplicating the enable/disable IRQ part, let's export the
> helpers available in ufshcd driver and make use of them. This also fixes
> the possible redundant IRQ disable before asserting reset (when IRQ was
> already disabled).

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
