Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18AD7824BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjHUHna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjHUHn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:43:27 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEFBC5;
        Mon, 21 Aug 2023 00:43:19 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fe1f70a139so5988315e9.0;
        Mon, 21 Aug 2023 00:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603798; x=1693208598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6hlRFuEO18ewfLVhWL/VLpc0gMEa3vQtcpOVMBFDnE=;
        b=SRkOalP30b3QYyaTKxtIXw5HvkiHJd+jRPby4VDt4ucCJOUq6zKapl/L7wjfUWC/HB
         0igNL6VU5SDf+nFc87hVvMOOJmbpAv4+z2RXOgZgQLVwY9cIwbMmOmzPx0Qc83uNH0iO
         Dr/hZatzA8ZftaayqSnY5nSSTlFV9rKv208oMhFRTIuxR+a0IGhl6RBrjfG0iz0JHz/6
         iMSFhbvne01Srfs4JVfURZ7fBHWWRsbimP7a5IAMAvMk8SU1Ysj0Yql5AWirqyJnXFjC
         8WPgrPNcVuQIdBkTziQE09AriA8Nymhi8aeQtI40z6r/K6/DaBkT5TjuslbgXoVFjZv5
         wuAA==
X-Gm-Message-State: AOJu0Yy+QXvKblGVEnWtRJUewtQliTmh6B4TjcNZD6QKO/hkb3I2S/+v
        LIz4gKqTB1V3djxsrDfiClk=
X-Google-Smtp-Source: AGHT+IHDt7naLH0gcQQARK8rQAsDXjJZrHcQgGMzMpPBtCojQBs1ERrRjAWBRx5UUBj9r+yPoyICZw==
X-Received: by 2002:adf:f4ce:0:b0:317:f1d6:997c with SMTP id h14-20020adff4ce000000b00317f1d6997cmr4443599wrp.0.1692603798154;
        Mon, 21 Aug 2023 00:43:18 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b0031416362e23sm11696178wrw.3.2023.08.21.00.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:43:17 -0700 (PDT)
Message-ID: <fc4d55db-dbd3-d2e5-ab2a-3eed07b30676@grimberg.me>
Date:   Mon, 21 Aug 2023 10:43:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v2 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230818141537.22332-1-dwagner@suse.de>
 <20230818141537.22332-4-dwagner@suse.de>
 <3713297b-a5fb-b027-c34b-d56526155c4c@grimberg.me>
 <u2esnihohobu5jaxgz3xdfpjfvfrnmkklzajjrckdnr6g3i54b@qofopy4bhhlp>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <u2esnihohobu5jaxgz3xdfpjfvfrnmkklzajjrckdnr6g3i54b@qofopy4bhhlp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> diff --git a/tests/nvme/003 b/tests/nvme/003
>>> index 71b82ce758a3..eed1f549866a 100755
>>> --- a/tests/nvme/003
>>> +++ b/tests/nvme/003
>>> @@ -22,15 +22,8 @@ test() {
>>>    	_setup_nvmet
>>> -	local loop_dev
>>> -	local port
>>> -	port="$(_create_nvmet_port "${nvme_trtype}")"
>>> -
>>> -	loop_dev="$(losetup -f)"
>>> -
>>> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
>>> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
>>> +	_nvmet_target_setup --blkdev=device
>>
>> --blkdev=device by default no?
> 
> Yes. I thought it is better to be explicit in the tests. I don't mind
> dropping --blkdev=device if you think we should use the defaults.

Just wondering why it is different than all the rest of the defaults?
It probably can be omitted from the callers.
