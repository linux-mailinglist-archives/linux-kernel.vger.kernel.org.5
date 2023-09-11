Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27FD79BF42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjIKUum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbjIKL14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07B64CDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694431625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XU8RLh7grKPuWPmu4OmjyaOM+2R9QefqTD05IQ9xwE=;
        b=Jy2t/uVC26skgIrD673uWv+DeO3dZQYI8y9ow3y2GQtKgQ5wbME5LO2++xoYOM3GHT5vxf
        TsBeUmaEdXKe3sXZ3Eh1Mho+7CVLxNGCjnp8F9vToo/q5YvSI8BH6sMkqAHNGdyCcJjknx
        DmNYAvrm3K7nGZR71wvr8BAH23rIjJM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-kkJZIAxZN3CuNdZAwjSJkg-1; Mon, 11 Sep 2023 07:27:03 -0400
X-MC-Unique: kkJZIAxZN3CuNdZAwjSJkg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ad73eb9668so30494766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694431623; x=1695036423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XU8RLh7grKPuWPmu4OmjyaOM+2R9QefqTD05IQ9xwE=;
        b=DfGeQRwGYn+oJTnkn39QsUr6N0Ohs5Sp6z7028LmwxtN+cA+eA9HPb8I1yDoLeWhKv
         aw7KgsfOgZ4IJDRghZd7qB8Zmy/0xFKFflNieG3nJS74nKDVPBoWeauKKBvC4VKH+gvR
         i2tXgYVXB5ua6sOJjw7C1CLAvzH1WtjK5tIZ9ML0J+XoRq58bJtxOIwWzxgZ8VabPyn/
         Atrq1KjGJ2NDRq+NelJFYPD6Q8BsRvpEiav7iW1TpHjQ1emRMPEmoiEiYhzOEDjMeYgY
         hc2a+R3BmB80HQ8vM4oOJHzg2xIGng3O49JKNYdfepUpM25WuwD0d3RQvTDWi6eKJVsk
         WjZw==
X-Gm-Message-State: AOJu0Yyp765h+XOEd3JT8gaqZs+3z399RUp48l9A+wvoaBmBXLPZAYGB
        Xhr4BzgDQoNGRLsIMm26mS4FMqad56y5jJGCK8TFLSZX64T426kCccW6QjDSZQ8Jp7Xf2VRhb5Z
        kmDaZVXcDjXBV2AU1Dwss7e8l
X-Received: by 2002:a17:907:9724:b0:9a5:962c:cb6c with SMTP id jg36-20020a170907972400b009a5962ccb6cmr17846765ejc.31.1694431622919;
        Mon, 11 Sep 2023 04:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ/AHu7nLmYgByLaPLMmYUvX4ccy5bwEbWpR+GUk2r/aBtLdPjo047ti0Vrwz7SNb+Q3eH2A==
X-Received: by 2002:a17:907:9724:b0:9a5:962c:cb6c with SMTP id jg36-20020a170907972400b009a5962ccb6cmr17846740ejc.31.1694431622681;
        Mon, 11 Sep 2023 04:27:02 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906941800b0098921e1b064sm5185543ejx.181.2023.09.11.04.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:27:02 -0700 (PDT)
Message-ID: <aa427e7e-374d-facb-883f-0b9b69ce00c0@redhat.com>
Date:   Mon, 11 Sep 2023 13:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230905082813.13470-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230905082813.13470-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/5/23 10:28, Luke D. Jones wrote:
> Add quirk for ASUS ROG X16 (GV601V, 2023 versions) Flow 2-in-1
> to enable tablet mode with lid flip (all screen rotations).
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index fdf7da06af30..d85d895fee89 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -478,6 +478,15 @@ static const struct dmi_system_id asus_quirks[] = {
>  		},
>  		.driver_data = &quirk_asus_tablet_mode,
>  	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ROG FLOW X16",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GV601V"),
> +		},
> +		.driver_data = &quirk_asus_tablet_mode,
> +	},
>  	{
>  		.callback = dmi_matched,
>  		.ident = "ASUS VivoBook E410MA",

