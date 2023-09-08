Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E45F798A05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbjIHPbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244681AbjIHPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:31:50 -0400
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54B1FDF;
        Fri,  8 Sep 2023 08:31:45 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-565403bda57so1600704a12.3;
        Fri, 08 Sep 2023 08:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694187104; x=1694791904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRShrLzitNqj8/xAQrhQg+U5yxxqgdL+nBg9BoZixwc=;
        b=otGPbCKMb2A6JZZvXs+qDh+VyJ/xxzL71L9qeSROnFwVWGatQbgyA9xKBPG3rUDNqU
         DiUqsm1aE4CpQNpCxOd1BPoOypYC7mRFonJGTd1L6rHSteg8nGHi/2wmNM5oS1SPx2G0
         FzzkRzT1fLyAlBdou7O8nn6Vx/gfyLQIY2COVKyE+GpIMUhWNZpOdwjZ3wqEOu7FbAFc
         6TD53oWga/xE9JGa6f/x+9qPZf9T7q8pUho7J38X0v3WX2yL9aaiOc7Wycr/G111YNzT
         kkXEPJE5YmVQN8jP4po74XhbEs4gjowBcC+QmXvmkUbX9atH7Xj59Ez/Wb468ttFEHza
         r0Tw==
X-Gm-Message-State: AOJu0YyRUiKJJ6MRtDgoDbTGICULfwR7q+ymsqGIl/ZC7OEmKKBwlD5k
        mfeWeA0EUvw5tuw5h9Uo0JY=
X-Google-Smtp-Source: AGHT+IEcBraudG9VxXOdBpAHPRzQ7KM+OGNSywEvYs5bNKBS/U1td5xCZjS0z/CSSNgtcNY5yhzRHQ==
X-Received: by 2002:a05:6a21:798a:b0:152:5f8b:359a with SMTP id bh10-20020a056a21798a00b001525f8b359amr2538304pzc.28.1694187104269;
        Fri, 08 Sep 2023 08:31:44 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78256000000b0068c61848785sm1434660pfn.208.2023.09.08.08.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:31:43 -0700 (PDT)
Message-ID: <13551c7e-af15-467b-a473-1941542d001d@acm.org>
Date:   Fri, 8 Sep 2023 08:31:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] scsi: ufs: core: add wb buffer resize related
 attr_idn
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        zhanghui <zhanghui31@xiaomi.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230908102113.547-1-luhongfei@vivo.com>
 <20230908102113.547-2-luhongfei@vivo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230908102113.547-2-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/23 03:20, Lu Hongfei wrote:
> UFS4.1 will support the WB buffer resize function, and UFS driver needs
> to add definitions for attr_idn related to this function to support
> this feature

needs to -> can

Please also mention that the ballot for resizing the WriteBooster buffer 
has been approved.

> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> index 0cced88f4531..8016bf30c8c4 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -179,7 +179,10 @@ enum attr_idn {
>   	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
>   	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
>   	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
> -	QUERY_ATTR_IDN_TIMESTAMP		= 0x30
> +	QUERY_ATTR_IDN_TIMESTAMP		= 0x30,
> +	QUERY_ATTR_IDN_WB_BUF_RESIZE_HINT	= 0x3C,
> +	QUERY_ATTR_IDN_WB_BUF_RESIZE_EN		= 0x3D,
> +	QUERY_ATTR_IDN_WB_BUF_RESIZE_STATUS	= 0x3E

Please add a trailing comma after "0x3E".

Thanks,

Bart.

