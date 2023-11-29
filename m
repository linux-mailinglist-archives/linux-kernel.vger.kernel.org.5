Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E57FD24E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjK2JU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2JU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:20:56 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CA910DF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:21:02 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40b2e763b83so8329355e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249661; x=1701854461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mrCYKV4ffJHs1ihIdp5IL82nHS6YW4P1u7F/B7XE/kqfN1posCyvhAgR7vPQ0g7bUL
         q8BK9IpLVt5pcyDTSkiYDEZCiUOxLFil1/xHjhSoLLnIDS87Y3i5KigjoAfheA178Tm1
         lfxZVjm0YEFiGxcLWQSuppAFM3RV0Z3sAcOkuPKhkek+hXgZmQuEDtA8fT/vYp8TsSp5
         v7NMtfkvZaQzPBoBL9W5s74Z7qjC4+0nyqbAm00Qzl1ZGhKo99J4Xmavv9XL7ohWYY6C
         54z+LkFkIm9chzwPnUtExIldMP6F9rR7G5xdDebC8yG1u9vm26/Et0Eycaffqxp/PsOe
         Ui8Q==
X-Gm-Message-State: AOJu0Yz1RV1/sFHrAV/plfBZuXxf9uaqDztkPdy84/CtVeEhZ+AKppxT
        ePTePz2bRG+JPycCkTyd5Yx5U/aGBHs=
X-Google-Smtp-Source: AGHT+IFQ6RlFtLFB6xfkrA0P8xsDLVIq36T5EecdHlfY4tG1fIAl8LBdKRPnOYx0zVCy/sjWTl/xqg==
X-Received: by 2002:a05:600c:8512:b0:405:358c:ba75 with SMTP id gw18-20020a05600c851200b00405358cba75mr12331021wmb.0.1701249660759;
        Wed, 29 Nov 2023 01:21:00 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b0040b360cc65csm1524542wmq.0.2023.11.29.01.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 01:21:00 -0800 (PST)
Message-ID: <43910a20-b527-46fb-942d-86293026734a@grimberg.me>
Date:   Wed, 29 Nov 2023 11:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: prevent potential spectre v1 gadget
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     error27@gmail.com, gost.dev@samsung.com, nitheshshetty@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231128122958.2235-1-nj.shetty@samsung.com>
 <CGME20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6@epcas5p2.samsung.com>
 <20231128122958.2235-2-nj.shetty@samsung.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231128122958.2235-2-nj.shetty@samsung.com>
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

