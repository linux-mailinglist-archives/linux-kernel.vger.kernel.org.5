Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4506B78B42B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjH1POz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjH1POf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:14:35 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CEDEA;
        Mon, 28 Aug 2023 08:14:33 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-68a56401b9aso2358817b3a.1;
        Mon, 28 Aug 2023 08:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235673; x=1693840473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4/eVPaw3IBTjAjPz+bqGvgtrzgk0IYeEEuriGEdCkg=;
        b=a/lUK2+slgqFtyaDOEnKU5shpfOxLAW2ydCYVFRSZIDFSfO7qVVqB/YjggDzrk7G6i
         xFiP3Uc/fc3iukRgBhDt4WfTdqyoZBscWvLdP3lULd6jLwlnSobwT2JtUvIR76MlpHwL
         QyQu835gupRneFndzv+rZjrIFtn633mDUoxiTzfQwBDB/SJABSZtnLzsrbc2eHj6P4RN
         XN+C3GjmaB7wdzQiTYjw+jYhgtJW47SZ6YNOx330vZ7bG0IueAxyBlOUfWqjWhCjoLyV
         Tqi5a6/fsMbB0aTHJ3MQxLReXH6R/RTttQvInV4NpyPehTzMbQ5aBoFx2eN8nmRxtrgQ
         ltHg==
X-Gm-Message-State: AOJu0Yycu9U7+B5HXxF8FS4wZEXF0lC+UNcfuQrJctmb3VJ8XWvxVAJR
        Vvy7fMqAV6lTNvP88tYAtF4GWG1od/Y=
X-Google-Smtp-Source: AGHT+IH+PPAxCeqwS0rQxAFK2k4hiRnRDctlRk35+6aaJ1RvNhCGrMLpEhUj+rAntmblcZ/VFz85jg==
X-Received: by 2002:a05:6a21:6da6:b0:126:9081:2156 with SMTP id wl38-20020a056a216da600b0012690812156mr25192585pzb.4.1693235672771;
        Mon, 28 Aug 2023 08:14:32 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79250000000b0068bff979c33sm6708230pfp.188.2023.08.28.08.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:14:32 -0700 (PDT)
Message-ID: <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
Date:   Mon, 28 Aug 2023 08:14:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 21:13, Shinichiro Kawasaki wrote:
> For me, your original suggestion to add "ignored_agument" looks better
> than "$@". (or in short, "noarg" or something)

It is not clear to me what the intention is of the _nvmet_target_setup
calls without arguments. Is the intention to pass all arguments that have
been passed to the caller or is the intention not to pass any arguments?
In the latter case I think it would be wrong to suppress SC2119 because
there really is a problem in this case. How about passing -- as argument
if the intention is not to pass any arguments? It is a well established
convention for shell commands and shell functions to ignore the double
hyphen if it is encountered in the argument list.

Thanks,

Bart.
