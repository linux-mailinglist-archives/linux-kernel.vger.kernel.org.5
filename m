Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A3A7622C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGYT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGYT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:56:32 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649EB19A1;
        Tue, 25 Jul 2023 12:56:31 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-666ecb21f86so5525406b3a.3;
        Tue, 25 Jul 2023 12:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690314991; x=1690919791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbNljxec5F5wit49MbLDhDRO2j7rsVA1tKXeLuxoXXQ=;
        b=Cq6NHmGrUENssKvjlWXu8ptOpBRX1sn6tVeV/MQGlpoKCxA6J1bWfKvfbzHEg6BQ6w
         hkbEmC0sWZFDEpQDirsu2Q8rIEY40DWZvhI41FhSr2dRv/9wA512wfwXXaZE/VQxTRoJ
         ls6hn12rZBGV68Lav3PRSltFFjLyBSC9pf02/Vo06K4Cx1HReR/WDl+L1bv/VR48EZ11
         aqjVUMSzP2+SuQulgObCDvTImUv5HMuGxrlgv2D+bGuIajE7qIifix0OM6MnpEK9CDON
         OORnx9uhKRH3JGGQDAxD3WpgwJpA6eHLiWYelzlx/+qXYYeVOJ3EGSsNGfFQ0ZeE8JnR
         J3WA==
X-Gm-Message-State: ABy/qLbw+JGfOSsfEHKzXBMBiBWNfwsNMmPpfDk8DDCONpJfX000XsGq
        ma3hqcxiYJ24Z0dWI1+Vevk=
X-Google-Smtp-Source: APBJJlHdtLpAwm1PS1imCDJhzvKIuz4NzhOkzB+nWr8orFagSQD7Y+dNBDIluUHoDDDSba4wAb/GBg==
X-Received: by 2002:a05:6a21:66c9:b0:126:a5e3:3938 with SMTP id ze9-20020a056a2166c900b00126a5e33938mr46079pzb.19.1690314990528;
        Tue, 25 Jul 2023 12:56:30 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7ecb:b0e6:dc38:b05f? ([2620:15c:211:201:7ecb:b0e6:dc38:b05f])
        by smtp.gmail.com with ESMTPSA id bu9-20020a632949000000b004ff6b744248sm10947134pgb.48.2023.07.25.12.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 12:56:30 -0700 (PDT)
Message-ID: <08fcf48b-75bb-f9f3-ca2d-f20d5317a991@acm.org>
Date:   Tue, 25 Jul 2023 12:56:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 2/2] scsi: ufs: ufs-qcom: check host controller state
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, powen.kao@mediatek.com,
        alim.akhtar@samsung.com, adrian.hunter@intel.com,
        jejb@linux.ibm.com, stanley.chu@mediatek.com,
        asutoshd@codeaurora.org, quic_cang@quicinc.com, mani@kernel.org,
        martin.petersen@oracle.com, beanhuo@micron.com,
        ebiggers@google.com, agross@kernel.org, Arthur.Simchaev@wdc.com,
        konrad.dybcio@linaro.org
Cc:     quic_ziqichen@quicinc.com, quic_nguyenb@quicinc.com,
        quic_narepall@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manish Pandey <quic_mapa@quicinc.com>
References: <20230725192710.26698-1-quic_nitirawa@quicinc.com>
 <20230725192710.26698-3-quic_nitirawa@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230725192710.26698-3-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 12:27, Nitin Rawat wrote:
> Check host controller state before sending hibern8 command.

A patch description should mention what has been changed and also why. 
The above explains what has been changed but not why. Please explain in 
the commit message why this change is necessary.

Thanks,

Bart.
