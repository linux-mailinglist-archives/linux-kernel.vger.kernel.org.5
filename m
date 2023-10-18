Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22EE7CDD11
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjJRNTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjJRNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:19:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CE583;
        Wed, 18 Oct 2023 06:19:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-504a7f9204eso9056959e87.3;
        Wed, 18 Oct 2023 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697635148; x=1698239948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjzTimwqxjnhGfFjgtYHgr9Iodgd4DYN9W7dLb4ZLYg=;
        b=e/DVhHzlWH1dHvjekG4vT7N17/8vS4167OUBc6iMPeEWOi731HbX1aGVe0TMTrG66r
         1cbcWSD/5Urs2DQP+LPn+AHljMzu26nnlZqEWKMu8H6LSrZqUFpm5g+vp9ZsyayXCuKb
         aWnebHseE4KPEzPBnrkJenzlW9n8xbeFsIdd/5JNUd4KKDKOKkId3VwQQ0CpZfw1lLN6
         9ycII5NhZD/eHs3G2pjXuyrnO0U1ZByQuP/qn6KRZtbDM86iTFA/sLlvhdcbPsDrf+c1
         R2S1MUPBNXymZkSI+ElWR5sSWbNqXICWdUqjGwY8DOwOYXFQL31LDfUr9T90hssgb8g2
         9toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697635148; x=1698239948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjzTimwqxjnhGfFjgtYHgr9Iodgd4DYN9W7dLb4ZLYg=;
        b=QJ2Iq8vfJt39E8Oe+kbu6+vmDLAzIL6D58bHJP5WH6vpRqhGYFwSTMcMxRh/BpfsAE
         C/epC56XTSh7CPQo/h5mKnTShtizX8CnTweusDSS4ehlF7oOscquTC6t+SHwvEQro4cs
         946Z2kSVFOLeKpMLkNIY3fplCZa7IBwr3qY7GGTHP7e3gSsdjEenPrSStyKVVLaF8tjl
         XrG81Y23g0WFMOz7D6lJnkgZ1UCLqWHw8CwYuLQ8lzUtDmXWrpCk1XgWKxznUicifYe3
         uP+kNJ13YSQYM7/QjtJP29IqTdMHmqInEc9e8zL7ZOuCpqvVt6YIDOOaHRaK4bg1LDC0
         k5Lg==
X-Gm-Message-State: AOJu0Yyf4WxrEaAohwEFyg3fP3lExvnVyc0i48r5AK5KDqToL0GT9cu3
        aDulWI6LO4Bn8inYgSddtag/ZWQkRRxLDA==
X-Google-Smtp-Source: AGHT+IGoGVcybbNqA2cB5/NvcZjqpJi5gZyEcgh84aGE7VlwA69fC6EB/NdV5zPVM7/r7jwq8xPZxQ==
X-Received: by 2002:a05:6512:3b21:b0:503:7fc:8afe with SMTP id f33-20020a0565123b2100b0050307fc8afemr5160105lfv.1.1697635147911;
        Wed, 18 Oct 2023 06:19:07 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.26])
        by smtp.gmail.com with ESMTPSA id e23-20020a196917000000b00500b561285bsm708479lfc.292.2023.10.18.06.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:19:07 -0700 (PDT)
Message-ID: <9b82b0df-c4a9-40bc-8980-ac2494073fcd@gmail.com>
Date:   Wed, 18 Oct 2023 16:19:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Send netlink ACK before setting connection in
 auditd_set
Content-Language: en-US, ru-RU
To:     Chris Riches <chris.riches@nutanix.com>, audit@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
References: <CAHC9VhQBV1mcFUmXQs1-VKpAVdaAQ3EiGk-G3ybxfcBkoKGwcw@mail.gmail.com>
 <20231018092351.195715-1-chris.riches@nutanix.com>
 <102df7b7-a07a-475a-adb6-ae60453feb63@gmail.com>
 <cdcd0b8a-1098-470f-86ba-dcc858ac4cd3@nutanix.com>
From:   Rinat Gadelshin <rgadelsh@gmail.com>
In-Reply-To: <cdcd0b8a-1098-470f-86ba-dcc858ac4cd3@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2023 15:49, Chris Riches wrote:
>
> On 18/10/2023 13:11, Rinat Gadelshin wrote:
>>> -static void audit_receive(struct sk_buff *skb)
>>> +static void audit_receive(struct sk_buff *skb)
>>>   {
>>>       struct nlmsghdr *nlh;
>>> +    bool ack;
>> Maybe we should initialize 'ack' as 'true' here?
> That doesn't feel particularly useful to me. In fact, I think it's 
> actually clearer
> uninitialised as a never-used initialisation could look like an 
> actually-used default.
> We're guaranteed to initialise before use.
>
> - Chris

Sorry, you are right.
I've missed the following line:

ack = nlh->nlmsg_flags & NLM_F_ACK;

- Rinat

