Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EFF7BBBCE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjJFPfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjJFPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA9AD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696606463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nm81sd5g6L/uk9Dy8jwBzSBl6p2VXrLcmdyYwUU4Xvg=;
        b=RBOoqYOFTkaNI6Qz0+xJ0UafPi1ha7Edi/QTrZAOWjBPoRyKKEyI/etTni9X3EDCJ8aiPq
        +joRxtlfRdMhC6Zm/JMO718g7hOFt7TX4bKKRZF0FY5yeW4SIE5p/d/Gr65HETr0rGjQzO
        2T2x6aE0S9piSSrpV4KbxkGJOwnc/90=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-Hr55XoDvNqyiS4Ke_C-x3g-1; Fri, 06 Oct 2023 11:34:22 -0400
X-MC-Unique: Hr55XoDvNqyiS4Ke_C-x3g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b822f5c156so194807466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 08:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606461; x=1697211261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm81sd5g6L/uk9Dy8jwBzSBl6p2VXrLcmdyYwUU4Xvg=;
        b=L0z9LL/N45cNaAT2ORb27YP0FX/2sszXQW8q6homWePCaOd4YCXI7G5NsP5BfqkF6A
         lMcwNTvnuAiNe3khYvl8e+r+kUoksZc4yzMB3bLfOX338cNbJN72oDFMMi75UbvDJoFR
         ODQoH+HWtJyiicYgGGJWNKZU4X9TBBvKJaNp5MU9Lbetb2zqd9HarPe3T/lBiwQ6HjhH
         sQ2hkchgl7xo4X7gZUxTZ5mLH4nGPDGqwGvg99rzEhdzfxV0hCH/OqO7FcQqs9oaND+m
         wKPgMYsIEvmGzhHCreB8/6EwGMBT/NHc2qKDXgTT1ANRR0C8tbLlu+jbqmEDnrC1+ClY
         OsLQ==
X-Gm-Message-State: AOJu0Yyra/mieal3gMVEg51kRhtndLtAhmurLehcJ/En4G8Dl4b8fkli
        956Of/TMhBUS16V9dKe0KK6s8rXut++6Vv2HHlxomexCbo7h7Vhw3EEOLOjYgfcTaiyg8ixRxxJ
        8OGC3yBXZvQnAHKPcVhr1AT00
X-Received: by 2002:a17:906:3ca9:b0:9ba:7f5:3602 with SMTP id b9-20020a1709063ca900b009ba07f53602mr178348ejh.60.1696606460861;
        Fri, 06 Oct 2023 08:34:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5PrjgAgFw2Z3uHNQKWjFWRAUyXTx8CpOFP9L46cTJXrh2ZidKRQAEUI3N+uf75TWPurYsIg==
X-Received: by 2002:a17:906:3ca9:b0:9ba:7f5:3602 with SMTP id b9-20020a1709063ca900b009ba07f53602mr178335ejh.60.1696606460553;
        Fri, 06 Oct 2023 08:34:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p26-20020a1709060dda00b0098921e1b064sm3029251eji.181.2023.10.06.08.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 08:34:20 -0700 (PDT)
Message-ID: <ff4e541d-590b-7eef-aeee-dc15ca869691@redhat.com>
Date:   Fri, 6 Oct 2023 17:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] platform/x86: xo15-ebook: Replace open coded
 acpi_match_device()
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
References: <20231006153152.3502912-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231006153152.3502912-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/6/23 17:31, Andy Shevchenko wrote:
> Replace open coded acpi_match_device() in ebook_switch_add().
> 
> Note, while it is a bit longer it is more robust in case
> more IDs will be added.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


p.s.

This driver too really should be converted to not be an acpi_driver
instead it should bind to the instantiated platform_device
for the adev, but that would require someone with actual
hw access to test the conversion ...






> ---
> v2: fixed compilation error
>  drivers/platform/x86/xo15-ebook.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
> index 391f7ea4431e..2ae8a58adcd0 100644
> --- a/drivers/platform/x86/xo15-ebook.c
> +++ b/drivers/platform/x86/xo15-ebook.c
> @@ -81,9 +81,9 @@ static SIMPLE_DEV_PM_OPS(ebook_switch_pm, NULL, ebook_switch_resume);
>  
>  static int ebook_switch_add(struct acpi_device *device)
>  {
> +	const struct acpi_device_id *id;
>  	struct ebook_switch *button;
>  	struct input_dev *input;
> -	const char *hid = acpi_device_hid(device);
>  	char *name, *class;
>  	int error;
>  
> @@ -102,8 +102,9 @@ static int ebook_switch_add(struct acpi_device *device)
>  	name = acpi_device_name(device);
>  	class = acpi_device_class(device);
>  
> -	if (strcmp(hid, XO15_EBOOK_HID)) {
> -		pr_err("Unsupported hid [%s]\n", hid);
> +	id = acpi_match_device(ebook_device_ids, device);
> +	if (!id) {
> +		dev_err(&device->dev, "Unsupported hid\n");
>  		error = -ENODEV;
>  		goto err_free_input;
>  	}
> @@ -111,7 +112,7 @@ static int ebook_switch_add(struct acpi_device *device)
>  	strcpy(name, XO15_EBOOK_DEVICE_NAME);
>  	sprintf(class, "%s/%s", XO15_EBOOK_CLASS, XO15_EBOOK_SUBCLASS);
>  
> -	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
> +	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", id->id);
>  
>  	input->name = name;
>  	input->phys = button->phys;

