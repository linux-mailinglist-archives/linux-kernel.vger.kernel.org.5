Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321EC7FB6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343981AbjK1KHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjK1KG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:06:58 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63087DC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:07:04 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5490b325edcso1131730a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166023; x=1701770823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDrEySI/1pWlb/EVtcfzf3j47hSXHdd6oiAatlhFT1c=;
        b=R57xHF8ScnlVixdl2SZFJtSkIZMPrUendc0V7PG2t2gY1KGg5RG9/xPNBsyKk+VAIs
         V1LtbThRx9Okto/6mLQBz78WyZGHmf7iDuAoQJQhRXyuGIFvueYJlquouscC1WGcr7Tr
         c9b+B6Gq78uJHyThTB0YPn/Hhyshnchhb2YI+7w6B9g8r2Wcb9NlZvAVMrnNYiuBQld6
         kc76mu7v9K74oQ3+jDUSxE8UEU61FdmMZCb3xaGIWqQdtZU2lNiM2BHGlYK5Nyu31SMq
         D/FULwo2N4UF/CIa0tdRDV3CTNL6L4Q8V33MP2a4SMzu8C59wOMzUd6u3WPKmw186oLD
         3rBA==
X-Gm-Message-State: AOJu0Yx3ZwGlpTGk/Tgo4GWff3RM182P5DAr4nWKUyzu1qwBNa/RnX2K
        MnBW+HPItM201sDMVEE6WuU=
X-Google-Smtp-Source: AGHT+IGhSyFpXGgBeC+cRpX2q+J7NdJHxOrw9GPgE9CCUiMz/ubPGmld7qE6QoPJVugrVsSU7ULNOA==
X-Received: by 2002:a05:6402:1d4b:b0:546:efd8:7f05 with SMTP id dz11-20020a0564021d4b00b00546efd87f05mr11056136edb.1.1701166022633;
        Tue, 28 Nov 2023 02:07:02 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7de8e000000b0053e3d8f1d9fsm6035528edv.67.2023.11.28.02.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:07:01 -0800 (PST)
Message-ID: <e8ae84bf-2cd8-4eea-8523-62de6e493dfc@grimberg.me>
Date:   Tue, 28 Nov 2023 12:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
 <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
 <20231127163333.GA2273@lst.de>
 <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
 <n57gxockmm4iqt53olerr52rgxg3mvgdp4wfshyci2r7dohxfg@22mqtj3ya3g3>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <n57gxockmm4iqt53olerr52rgxg3mvgdp4wfshyci2r7dohxfg@22mqtj3ya3g3>
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


>>>>>> Should this even be an nvme specific attribute? I thought we should have
>>>>>> blk-integrity.c report its 'tuple_size' attribute instead. That should
>>>>>> work as long as we're not dealing with extended metadata at least, but
>>>>>> that's kind of a special format that doesn't have block layer support.
>>>>>
>>>>> Reporting the tuple size is a good idea.  But is that enough for
>>>>> the existing nvme-cli use case?
> 
> 'nvme list' is just listening the block size and the meta size in the
> 'Format' field. So nothing really crazy going on:
> 
>    Usage                      Format
>    -------------------------- ----------------
>    343.33  GB / 512.11  GB    512   B +  0 B
> 
> nvme-cli commands like 'nmve ns-id' etc will always issue a command so
> that is not a concern. It's just the libnvme nvme_scan_topology() call
> which should stop issuing any commands.
> 
> I'll add the missing tuple_size to the integrity sysfs dir in this case.
> 
>>>> nvme-cli currently queries with admin passthrough identify command, so
>>>> adding a new attribute won't break that. I assume Daniel would have it
>>>> fallback to that same command for backward compatibilty if a desired
>>>> sysfs attribute doesn't exist.
> 
> Yes, a fallback will exist. There is no need to break existing users.
> 
> In summary, the only missing entries are
> 
>   - csi
>   - tuple_size
>   - nuse

I agree with the comments made, especially the one made by Christoph
that these values should be added to the nshead.
