Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006D878B429
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjH1POZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjH1POQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:14:16 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A0E8;
        Mon, 28 Aug 2023 08:14:13 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6bca5d6dcedso2606220a34.1;
        Mon, 28 Aug 2023 08:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235652; x=1693840452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+8NbH3OkSUgunICilRSyAwwlEnHmG2jLuoYIeResH8=;
        b=fwH4lNAbodm77k3irT18eGvBOEwaRyUswtfokFti37S9kHSJ7yULFr0m49LSvC9OTU
         a8rOvTPHNDbdurxf8vFLdZNZLztnoOsglCUHdeLdtyr4XzMXWZuAgYW9TBCXmAVYLlTE
         xSMJFmna0W1AdYHIjHBXHC6O/Zx8yOIctPlaR2rraPNXHF0yEtmeRW+yZ/CPQtWvb8Md
         8QAVfNhHPaWVKX16u1WIeKXc6waVFIU+v2yzGdYNqjwfWTNJUqDQoskrp5u6bU0eW73g
         GgbVSB0GhxSIC07Qg/uyX7HSrdjpqhBHstQFG0zoP2GOy7wT/onvm4omLAWSNaLC0YcR
         uC/Q==
X-Gm-Message-State: AOJu0Yxu+lr4UyilXQS0E3vmK7ukUOU1Oysvcme2YTPz3Yf0L2xAek5J
        cgsD1/xQRePjtybUsYaXFWs=
X-Google-Smtp-Source: AGHT+IHehlIs0QtxM1G3arB1CsJ+l1ULiJfDx1nonQ34Og0tJzw+InmyhN+hI3mSyQkLfTcVgUYTRg==
X-Received: by 2002:a05:6870:418d:b0:1ad:4c06:15c with SMTP id y13-20020a056870418d00b001ad4c06015cmr12264398oac.18.1693235652069;
        Mon, 28 Aug 2023 08:14:12 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79250000000b0068bff979c33sm6708230pfp.188.2023.08.28.08.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:14:11 -0700 (PDT)
Message-ID: <8e407992-d6da-46e2-a006-ad3b3cdfb101@acm.org>
Date:   Mon, 28 Aug 2023 08:14:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230822083812.24612-4-dwagner@suse.de>
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

On 8/22/23 01:38, Daniel Wagner wrote:
> +	while [[ $# -gt 0 ]]; do
> +		case $1 in
> +			--blkdev)
> +				blkdev_type="$2"
> +				shift 2
> +				;;
> +			--ctrlkey)
> +				ctrlkey="$2"
> +				shift 2
> +				;;
> +			--hostkey)
> +				hostkey="$2"
> +				shift 2
> +				;;
> +			*)
> +				shift
> +				;;
> +		esac
> +	done

So all arguments that are not recognized are ignored? That will
make debugging typo's harder than necessary. Shouldn't this function
complain if an unrecognized argument is encountered?

Thanks,

Bart.

