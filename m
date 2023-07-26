Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC67763087
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGZIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjGZIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A261BFB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690361163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ub5GeO5Ezrxd1eWr4bFQ+Xv5ustr9L2gJSjy4MO2o7A=;
        b=G4Yk/mivsGVI6r1/QHwnekGw2R+tNBUNwMXhLiI+PFexzRDOLi1chksntlbIRYcMt9yRNT
        vKDfMm+Fi+iRC/nAsA+9HdbfGFlFkcRmrb5nP9l8oQiASVrNi+uo1JVtdwgn341HSvCaWx
        ojZqVlePROH6id7RvmJLSSOtnJBJUvk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-puNmrldoNU-aUHXtghpKaA-1; Wed, 26 Jul 2023 04:46:02 -0400
X-MC-Unique: puNmrldoNU-aUHXtghpKaA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993c24f3246so81398666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690361161; x=1690965961;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub5GeO5Ezrxd1eWr4bFQ+Xv5ustr9L2gJSjy4MO2o7A=;
        b=P5jB80Vuq+j/oanx9AE2WoAUpUmDJ+aM6cvoqQv5mLEhvXVSZfP/XDm/FByUJVw1kp
         L5qB56HxClo/xlZUJIIobud5+eTKr+kTNJLHp0Vrv8fmSalcc3HWj4YZ+iANWtQ+3z1e
         spvrgpxU+E9tXoF1pl+A12t3q3he3FCDywyGUEq427nTVx2ODkLSWlrYBAKcg40c6Jo4
         nfqDGmSFXlAcljUX6U1tSO4hGXPujtRHJHwup4FUlP/ebBLbd1wOzuzNc5fCMqu9qUVo
         +hXBnCg44PRIIFmA6gu1I1ACvIXAM2TAgp2nRR7TCc0Wim0BjU2kBNNbGUxTKRUACR//
         CojA==
X-Gm-Message-State: ABy/qLZQ+Ux5zMlg95UCxj8MynQOdN9O89hjhZc9y/l74maoZkPek2k1
        bg0ZeAydembcxG6IQL0Fa1cRB+IgCOCfJJIrqX5P5KvSB4j1T3wt0QOVM3Jof/RZUOBYacAyDnY
        jpwhxizuvzLfpLYEY4p+2Dg4W
X-Received: by 2002:a17:906:64c6:b0:99b:c2ce:501c with SMTP id p6-20020a17090664c600b0099bc2ce501cmr1280308ejn.19.1690361161021;
        Wed, 26 Jul 2023 01:46:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVSwR5f8G724gmsihQpPs+qWoRbi1NErvN5vf88zyw8UwdqGfs8C9PKzk4sfXNIPO5vBYBUA==
X-Received: by 2002:a17:906:64c6:b0:99b:c2ce:501c with SMTP id p6-20020a17090664c600b0099bc2ce501cmr1280289ejn.19.1690361160621;
        Wed, 26 Jul 2023 01:46:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k27-20020a1709063e1b00b00982842ea98bsm9192626eji.195.2023.07.26.01.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:45:59 -0700 (PDT)
Message-ID: <efe4b91f-2602-2115-738e-bb99b42ec5b6@redhat.com>
Date:   Wed, 26 Jul 2023 10:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with
 invalid GUID
Content-Language: en-US, nl
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230715211604.1272227-1-pobrn@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barnabás,

On 7/15/23 23:24, Barnabás Pőcze wrote:
> Since a WMI driver's ID table contains strings it is relatively
> easy to make mistakes. At the moment, there is no feedback
> if any of the specified GUIDs are invalid (since
> 028e6e204ace1f080cfeacd72c50397eb8ae8883).
> 
> So check if the GUIDs in the driver's ID table are valid,
> print all invalid ones, and refuse to register the driver
> if any of the GUIDs are invalid.
> 
> Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>

Thank you for working on this!

About the do this here, vs do this in file2alias.c discussion,
we have many old style WMI drivers which are not covered by
the check you are adding for the new style WMI bus driver.

So I think having a check in file2alias.c would be a very good
thing to have. AFAICT that would also cause compile time
failures rather then the run-time errors your current approach
results in.

I think that having an additional check like the one which you
propose has some value too, even if it is just to cover drivers
which for some reason don't use `MODULE_DEVICE_TABLE()`, but IMHO
the most important check to have is a check in file2alias.c .

Regards,

Hans




> ---
>  drivers/platform/x86/wmi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index a78ddd83cda0..bf0be40b418a 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1513,6 +1513,19 @@ static int acpi_wmi_probe(struct platform_device *device)
>  int __must_check __wmi_driver_register(struct wmi_driver *driver,
>  				       struct module *owner)
>  {
> +	bool any_id_invalid = false;
> +
> +	for (const struct wmi_device_id *id = driver->id_table; *id->guid_string; id++) {
> +		if (!uuid_is_valid(id->guid_string)) {
> +			pr_err("driver '%s' has invalid GUID: %s",
> +			       driver->driver.name, id->guid_string);
> +			any_id_invalid = true;
> +		}
> +	}
> +
> +	if (any_id_invalid)
> +		return -EINVAL;
> +
>  	driver->driver.owner = owner;
>  	driver->driver.bus = &wmi_bus_type;
>  

