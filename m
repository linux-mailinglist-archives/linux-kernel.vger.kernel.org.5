Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ABF8113E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379159AbjLMN6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjLMNkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:40:43 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE35113
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:40:48 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1f8313c781so149376866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474847; x=1703079647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJKnfzyzyEQaXBcdN+jnFLQABa9yl2KfuisahfbwSlU=;
        b=qzGFLyEjknFumFJWAyK3EcmaK7IsnkcmIMOIeHmVyBUuWdhZpKJ4BNNNmjkFZSnJIn
         JI+beVVKr3iJrDSjq39a93FswHZCHpAo0YPGLLM5ehGGi6/XE/saN+frrqGpE+KQrqLl
         hFLlMYTbrzLFXwg8SGidE8r8YLznIU5Cz6eCq4BifdkqZ+Mko1Omg+Gx+mt0CV3IuFQ1
         WiwVUASIq62DGeWB9zp4WGbfqj52fwVk71cfrp/TAzHhCWDJpxrRysebKXwN/zyoFsmt
         crox0DBTik+cQcRM300137Stxio78YvMBTLkkGO6vthjCKkMiZ4mdnaZmQAex2o4C+hW
         L8cw==
X-Gm-Message-State: AOJu0Yx8jmqf5Epg9gqViyxxfnuqc99fQgW2FutAlbMlgPbrYZdIsVyN
        +NP942ojVyknj18MydzUync=
X-Google-Smtp-Source: AGHT+IHSIG2JrGvEU8taQncs/5kxJkoD0Nrw5y01/fbw6hnXBdaviPPdh3h5/riPgMszYtWJGWWMGQ==
X-Received: by 2002:a17:907:c317:b0:a1d:5c72:3be2 with SMTP id tl23-20020a170907c31700b00a1d5c723be2mr8370959ejc.7.1702474846772;
        Wed, 13 Dec 2023 05:40:46 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id vw12-20020a170907a70c00b00a1c904675cfsm7740917ejc.29.2023.12.13.05.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:40:46 -0800 (PST)
Message-ID: <b6169317-4714-4240-87ab-3e80b2aac2c4@grimberg.me>
Date:   Wed, 13 Dec 2023 15:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] nvmet: configfs: use ctrl->instance to track passthru
 subsystems
Content-Language: en-US
To:     Evan Burgess <evan.burgess@seagate.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SN7PR20MB6609903F74075383EC400BFC808FA@SN7PR20MB6609.namprd20.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SN7PR20MB6609903F74075383EC400BFC808FA@SN7PR20MB6609.namprd20.prod.outlook.com>
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


> To prevent enabling more than one passthrough subsystem per NVMe
> controller, passthru.c maintains an xarray indexed by cntlid values.
> An nvmet subsystem cannot enable passthrough via configfs if its
> passthru_ctrl->cntlid value is already accounted for by the xarray.
> 
> However, according to the NVMe base spec (rev 2.0c, p.145), "The
> Controller ID (CNTLID) value returned in the Identify Controller data
> structure may be used to uniquely identify a controller within an NVM
> subsystem," meaning that cntlid values are not guaranteed to be
> globally unique across multiple subsystems. Instead, the cntlid only
> uniquely identifies multiple controllers _within_ a subsystem.
> 
> As a result, multiple unique & valid NVMe targets can be blocked from
> enabling passthrough at the same time if their controllers share cntlid
> values, a behavior (seemingly) allowed by the spec. This could be
> remedied by indexing the xarray with passthru_ctrl->instance values,
> which are allocated per controller by IDA and thus should act as truly
> unique controller identifiers.
> 
> I have seen this issue in practice, but have found a suspicious lack of
> corroboration across this ML and elsewhere (so far). So, I am not
> discounting a possible misunderstanding of the spec and/or code here.

You are correct AFAICT.
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
