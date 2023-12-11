Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CB380D4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbjLKR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbjLKR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:59:23 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C9C3;
        Mon, 11 Dec 2023 09:59:29 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d2e6e14865so21498905ad.0;
        Mon, 11 Dec 2023 09:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317569; x=1702922369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TG12YyuQcIlIUIhJpok1Z9XhgvnLDNR3xx7iZohyHA=;
        b=F67ZyNzD63Qx4pluM/am8tEL13aLrpl+Qph7Hf8agm7nqr79KZE8QOUY0CM3gRro2V
         Q+yHzKs+wyaj4Fsl4wDFi49FvhF77MSVOZ/u8mQMhDwBaLj65fjDweSfxV4NOpl4AX7B
         SQK7W1aBTfcPYaU5/ORr4Q+3+sdJrqZeRKwhW0eC49PDKnNCTAmnqLlS26JxpwQLcXkl
         71/ksIzPyspdYcqtIN78Pj0wPrjb2YXKxarCC2OFSqLBKTy7iHXpU7ewCHAEQpYpjnuI
         5ZenvxsCKEZ5WWCPODa9F4yL+Vj6XDyHKCNcXXaooytPxwOQxh/uPRVz5uLLq5YROz0U
         7oiQ==
X-Gm-Message-State: AOJu0Yz2X+2fbjtc3oeycDDG35AIH2n+eEtxGsuYsMaPY49sHr/FxJJU
        /hcv1gdx4Fe4ue3poh43R18=
X-Google-Smtp-Source: AGHT+IE5lNotrSQSHXP57Xi5usYbH8Ac+LXzWL6rFd610YIZtYdxRXvrh/HMoTpbtPoScBauDbOVKA==
X-Received: by 2002:a17:902:e810:b0:1d0:6ffd:6e60 with SMTP id u16-20020a170902e81000b001d06ffd6e60mr2382910plg.88.1702317568985;
        Mon, 11 Dec 2023 09:59:28 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3431:681a:6403:d100? ([2620:0:1000:8411:3431:681a:6403:d100])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b001d0855ce7c8sm6979575plg.252.2023.12.11.09.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 09:59:28 -0800 (PST)
Message-ID: <0d59681d-2d7d-4459-b79c-c5f41f20b7a5@acm.org>
Date:   Mon, 11 Dec 2023 09:59:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: qcom: Perform read back after writing reset
 bit
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Dov Levenglick <dovl@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231208-ufs-reset-ensure-effect-before-delay-v1-1-8a0f82d7a09e@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231208-ufs-reset-ensure-effect-before-delay-v1-1-8a0f82d7a09e@redhat.com>
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


On 12/8/23 12:19, Andrew Halaney wrote:
> The recommendation for ensuring this bit has taken effect on the
> device is to perform a read back to force it to make it all the way
> to the device. This is documented in device-io.rst  [... ]
There are more mb()'s that need to be replaced, namely the mb() calls in
ufshcd_system_restore() and ufshcd_init().

Thanks,

Bart.
