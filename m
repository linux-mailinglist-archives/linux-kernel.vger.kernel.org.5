Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620047BBD7A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjJFRJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJFRJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91697BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696612126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q4CHYDckQ+QF26tAup+TjibaSYNiGvtrGF0BfcPGvSM=;
        b=EHxdoDqUpRgBus/PAQl2w+jVAbhJB5yQzUGws3oMcHl6XTu/xItgyX0+Mmq5ACCE1saxdA
        P3ogYw2uZ2B7UT6Q/Uwir+DZBE2DfSrQezHQI/1CAKbNNpVUZJulWQvAh3jDyLdViUwe2b
        O6QELAmYz3Y0vt3UPVuoe6Q1JlNl2P4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-SMhrMzOMPly-zdIZ7G2U2Q-1; Fri, 06 Oct 2023 13:08:39 -0400
X-MC-Unique: SMhrMzOMPly-zdIZ7G2U2Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae42088b4bso189816666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 10:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612117; x=1697216917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4CHYDckQ+QF26tAup+TjibaSYNiGvtrGF0BfcPGvSM=;
        b=GcyJcIaEyyQxm44+vMdIFOy2waW12gw2BB/knCRanfTZycVLbcO9kyDAFG0dYQ8H+5
         ZlJdD7y7Y55fnyIJ9QkIkPAOtji5lkSxklrIr1DKvvsdIKd+zljarkjTmRLG6WuujjF2
         dsm5qdHzef3pDcLu7SvejIUT39ZqGUsNiN6sdLHJN8nagUhrf16+EgFE2la1l/fXqovn
         rT1peX8/ZtAg5d70O5pbuphOsigIYNre1D3aIpPyFamsv+Zsc6cPYJ3vZCkFS6B/6Zv2
         J+6/H3DJtK6HOJ8iLf45cArcfh9JOXjVlvqIqYG4T21GgLwzwVBWEDmfSpn1D2CeLtRv
         FIPA==
X-Gm-Message-State: AOJu0Yypw2Ys36McVeDrHWb6n74vfjoemniUP5WFrZs/p836gO4Ui8i+
        hLRf/Tg0tmW9pUqhrGPQ/Y1LNCP17XGeP7Mhtf8VWDOL0C/Bapk8RIcT1cOHWAT+xBAVX6aBSR6
        LREAae3db3mYGPRuZwQW2+55KsirqaYCG
X-Received: by 2002:a17:907:2724:b0:9ae:6196:a410 with SMTP id d4-20020a170907272400b009ae6196a410mr7690109ejl.43.1696612117521;
        Fri, 06 Oct 2023 10:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkiZMdRLdCPktK/xK30RiaUONLVHJjkhW+qH9PuP1MXcElS2vYVFDHZq00GowGDAhpd68xKw==
X-Received: by 2002:a17:907:2724:b0:9ae:6196:a410 with SMTP id d4-20020a170907272400b009ae6196a410mr7690090ejl.43.1696612117260;
        Fri, 06 Oct 2023 10:08:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b009a168ab6ee2sm3125674eji.164.2023.10.06.10.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 10:08:36 -0700 (PDT)
Message-ID: <371fc87d-ade3-51b8-6f56-4d99dad88873@redhat.com>
Date:   Fri, 6 Oct 2023 19:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/1] platform/x86: asus-wireless: Replace open coded
 acpi_match_device()
Content-Language: en-US, nl
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
References: <20231006155351.3503665-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231006155351.3503665-1-andriy.shevchenko@linux.intel.com>
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

On 10/6/23 17:53, Andy Shevchenko wrote:
> Replace open coded acpi_match_device() in asus_wireless_add().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: rewrote error path logic (Hans)
> v2: fixed compilation error
>  drivers/platform/x86/asus-wireless.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Thanks, patch looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
> index abf01e00b799..1a571efa02eb 100644
> --- a/drivers/platform/x86/asus-wireless.c
> +++ b/drivers/platform/x86/asus-wireless.c
> @@ -148,16 +148,12 @@ static int asus_wireless_add(struct acpi_device *adev)
>  	if (err)
>  		return err;
>  
> -	for (id = device_ids; id->id[0]; id++) {
> -		if (!strcmp((char *) id->id, acpi_device_hid(adev))) {
> -			data->hswc_params =
> -				(const struct hswc_params *)id->driver_data;
> -			break;
> -		}
> -	}
> -	if (!data->hswc_params)
> +	id = acpi_match_device(device_ids, adev);
> +	if (!id)
>  		return 0;
>  
> +	data->hswc_params = (const struct hswc_params *)id->driver_data;
> +
>  	data->wq = create_singlethread_workqueue("asus_wireless_workqueue");
>  	if (!data->wq)
>  		return -ENOMEM;

