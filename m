Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1C7ECA75
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjKOSWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKOSWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:22:18 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63C9C1;
        Wed, 15 Nov 2023 10:22:15 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1cc3542e328so54182905ad.1;
        Wed, 15 Nov 2023 10:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700072535; x=1700677335;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asa7PA3ApN9uKyqznyP4okj+yLhWrazAhQHPOuL+PeQ=;
        b=NyRVSUnMk4p6uWw3PszDvJNH0+pEBf3eRRDQVgNYCGiDm4EzsetnuyYk3L4iisWhvu
         UxXQHm4MQ2aOOzuScG7gY9ooGjbx1ft5wdn8i/ug/4wawhQKynE4RR8qcWURZ0XrcJVR
         tFZ+is6iJFgZi6keveOIkHsvCPO7wYoeB/e2BHSoWqqR+u8uYi9g/h0ygA2wexchrV2l
         3Fpt+JOxomHb1tA6qY1QPCJaxRVosQfXQHG/l1bWskZkMXK/Ns2K55W589SbhsKN3RBn
         kt9mCGd5fqkRSSUqzStCQWa51c4gJOjQTXpQ9TLNp7b00sWnA4ToQyA6m64LATIpgyVO
         wZCQ==
X-Gm-Message-State: AOJu0YypSPWuNSKnWAkv7YyAKDbtBxumlsX11AwTqTaBr6y9GC0f8Of5
        K7fa/C9Xxe3S1Ifyo6j6+ML+SFKY1V0=
X-Google-Smtp-Source: AGHT+IHRWHNyhIkrOem91wb5cbPbYteKdllocRyCHrmLcTH8T/L/Io2tEWq7DC7GMCPrGbGHtHssgw==
X-Received: by 2002:a17:902:e892:b0:1c6:21b4:30bb with SMTP id w18-20020a170902e89200b001c621b430bbmr7417690plg.15.1700072535188;
        Wed, 15 Nov 2023 10:22:15 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:56f1:2160:3a2a:2645? ([2620:0:1000:8411:56f1:2160:3a2a:2645])
        by smtp.gmail.com with ESMTPSA id a22-20020a170902b59600b001c9ab91d3d7sm7613787pls.37.2023.11.15.10.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 10:22:14 -0800 (PST)
Message-ID: <e9745815-afc0-46c6-828b-c969a2d352eb@acm.org>
Date:   Wed, 15 Nov 2023 10:22:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Content-Language: en-US
To:     hoyoung seo <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com, grant.jung@samsung.com,
        junwoo80.lee@samsung.com
References: <CGME20231114043431epcas2p4a8d452e18fff192c03fb6066e81514ea@epcas2p4.samsung.com>
 <20231114043704.52525-1-hy50.seo@samsung.com>
 <dca06fd3-d4ad-4e41-a0a3-61d52c85ef9c@acm.org>
 <000001da1784$5c2520f0$146f62d0$@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <000001da1784$5c2520f0$146f62d0$@samsung.com>
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

On 11/14/23 21:27, hoyoung seo wrote:
> The test_bit() function just check SCMD_STATE_COMPLETE bit state.
> Do not set SCMD_STATE_COMPLETE field.
> This function is also used in ufshcd_mcq_compl_pending_transfer()
> to check the status of cmd.

Right, I misread your patch. Can you please take a look at the following
patch and verify whether it perhaps addresses the same issue that you want
to address: https://lore.kernel.org/linux-scsi/20231115131024.15829-1-peter.wang@mediatek.com/

Thanks,

Bart.

