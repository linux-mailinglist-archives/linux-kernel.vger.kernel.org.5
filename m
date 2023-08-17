Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B052677F23F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348907AbjHQIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349031AbjHQIdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:33:45 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3C1BD4;
        Thu, 17 Aug 2023 01:33:40 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99bcf3c8524so168631266b.0;
        Thu, 17 Aug 2023 01:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692261219; x=1692866019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DV+51nG4XiGuXDD21Bk0S4x/fufuHRaJ2bgQpqeNG1w=;
        b=BUxUq3EYA8SuK4f983K8Vr3VsP3XrtrIYixNPCXBYeB76L7sBy8hsb9uqkaP5Qsdua
         YIktzh5o/yGrynrCz6i5RaupM/ecVKCw1y7p5cNSd5hhGhyShK0PLLM4MX8EisQwS6QZ
         o/UMIs/PEolq7kcbpsiL6OhrcA47dBwOu1rr2/PlZuA/+rvGFEnlE6nRnZZ6T3iXquLL
         RfjFTd4ZgPfDq7l4VnPzOsOjfhJynnpnVGOiFTz/gdqRItkMNoSjUm52TEBdy145tXTT
         BSv3ksLzygRt3Y4v4sMuickZetOusKLhCU85uZNZN3IgUcqmC4HVurIEaHad7oGVnOfE
         UxMA==
X-Gm-Message-State: AOJu0YzygfUxrgrsp5EXAhUbnWuL5UciRPE7OjkA0yDpzarS+vk+85lt
        Mw5r0SbmYcykJ03NFlfoGrA=
X-Google-Smtp-Source: AGHT+IFF7yfv2VJErpteiD85j75Wa6YPduJX5bVBide3GMy3Na5+GURGy3p9cHb8LNFiL8w6UuK/yw==
X-Received: by 2002:a17:906:2204:b0:998:bac1:3bdd with SMTP id s4-20020a170906220400b00998bac13bddmr3203809ejs.2.1692261219032;
        Thu, 17 Aug 2023 01:33:39 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090608cc00b00993004239a4sm9733096eje.215.2023.08.17.01.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 01:33:38 -0700 (PDT)
Message-ID: <cb468a17-c653-b257-8f5d-bf5981c22de5@grimberg.me>
Date:   Thu, 17 Aug 2023 11:33:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v3 13/13] nvme: Introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20230811093614.28005-1-dwagner@suse.de>
 <20230811093614.28005-14-dwagner@suse.de>
 <58d299c4-84e1-603d-6c99-15d0484f9609@grimberg.me>
 <lfr3tkzz3sqnsw4y7sqyxc42ptvzkyfqfpeko6gzs42jdgjl2d@u5fbzjksbztd>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <lfr3tkzz3sqnsw4y7sqyxc42ptvzkyfqfpeko6gzs42jdgjl2d@u5fbzjksbztd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> It is very very strange that _setup returns a port
>> which is passed to _cleanup...
> 
> This is the only information the _cleanup helper needs and that is why
> it survived the refactoring so far.

Doesn't change the fact that it is awkward.

>> I think that _cleanup should simply remove all
>> ports, and that setup should not return a port
>> to begin with.
> 
> This assumes that blktests is the single user and can blindly remove
> everything. I would like to play nice here and only cleanup resources
> blktests actually allocates.

I suggest that the test records resources that it is using
and destroy them in the cleanup (IIRC Shinichiro did something
similar with the modules in some other place).

>> If someone needs the actual port number, then it
>> should either not use this _setup helper or
>> query it somehow.
> 
> I try to figure out how to implement such a query helper then.

That would probably be needed when a test wants to cherry-pick
which stuff it is destroying. But on the other hand, in this
case it also doesn't make sense that this test will be using
the default basic setup function. So I don't think it is
very much needed.
