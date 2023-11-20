Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43A77F1295
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjKTMBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKTMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ED79F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700481666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQkYTuNlbgh1Az+Wq9fQiOcjDblSpxXYTdu4o0Oymww=;
        b=cc5K54VhY/6Tg1X2hG+yv2MOOTp+KW9r/eZWIgm+NXiXl1FpeBleJohqtf4jP/QHM+KYMM
        63t9BgLfDgpJWNuq/b+fkEIO/PW+pL6DtY3PEg8up8KUDlI00vGh5hxMVt7/YvFPDb0vIm
        rZ1yYYpzHlezE6HFDsOPmhjr0OMk1Fc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-ha-7RzISN5inTa_8UIOcFg-1; Mon, 20 Nov 2023 07:01:03 -0500
X-MC-Unique: ha-7RzISN5inTa_8UIOcFg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-543f45ab457so3230919a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700481662; x=1701086462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQkYTuNlbgh1Az+Wq9fQiOcjDblSpxXYTdu4o0Oymww=;
        b=r03Z8SufoUtf2XQDFWulb8qIyDJhqFhl9K+dO5WZWnWFH1rkfDmVnynVaUmfxnZtIQ
         CZxlH8IdFTylVbhJHdn1W9tMq1602D7vrEOJMRYSfBrkATd82FLczfBJ6H5wFDiBXIrN
         k0udCRUoefktmOENaPXrLZHoBTDGBcUs7jpT494QibINqP378nfUZF3zBEvNr5CHMZRJ
         bbUhAc/5Lfc9ZGSMyF0Vt3P/8EBtEG1ONcsAZW4VVSpD6FDVm+dXB8JFlbdnbopp/n0S
         9WNZzF3TILtSwFf+cwl1omf6DyL+JvsPwqFhmHo1e0JnF7IEVjcSGaDDCeJ7ZNl8wk3u
         sL/Q==
X-Gm-Message-State: AOJu0YwChpCcfXzps9tvP0+srl2boERXoHzlu7M/PkNerPYLRcbaXtzO
        lTtzlrofHDBE3/3QAoCRxZyZdycl3hthVhTOSU85Nbz+HHZu4od6HTwhvOneYAg+aU9wNRBZTyp
        d18fp4LS53f48qodggiO2RIED
X-Received: by 2002:aa7:c490:0:b0:540:2b93:af85 with SMTP id m16-20020aa7c490000000b005402b93af85mr5016132edq.26.1700481661854;
        Mon, 20 Nov 2023 04:01:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFd05tDbDz/SB2rFj94QjLf5QkLRfTQitYsFuz+WL/sKO/iPaAoGepSIC84nRcCaE7toW2AQ==
X-Received: by 2002:aa7:c490:0:b0:540:2b93:af85 with SMTP id m16-20020aa7c490000000b005402b93af85mr5016116edq.26.1700481661503;
        Mon, 20 Nov 2023 04:01:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d16-20020aa7d5d0000000b00548aeeb1a9esm1233627eds.89.2023.11.20.04.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 04:01:00 -0800 (PST)
Message-ID: <4eb8e035-26f1-44e6-ae32-61d843c61f13@redhat.com>
Date:   Mon, 20 Nov 2023 13:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] platform/x86: wmi: Add wmidev_block_set()
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, jithu.joseph@intel.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231103182526.3524-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231103182526.3524-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

On 11/3/23 19:25, Armin Wolf wrote:
> Currently, WMI drivers have to use the deprecated GUID-based
> interface when setting data blocks. This prevents those
> drivers from fully moving away from this interface.
> 
> Provide wmidev_block_set() so drivers using wmi_set_block() can
> fully migrate to the modern bus-based interface.
> 
> Tested with a custom SSDT from the Intel Slim Bootloader project.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

One thing which I noticed during review of patch 3/4 is that
some WMI drivers might benefit from having a wmidev_block_query_typed()
similar to how we have a acpi_evaluate_dsm_typed() which takes an
ACPI type and returns a NULL pointer instead of a wrongly typed
ACPI object when the type does not match. Specifically this
would allow dropping the return obj type checking from
sbl-fw-update.c : get_fwu_request() .

Now adding a wmidev_block_query_typed() wrapper around
wmidev_block_query () just for this is not really a win,
but it might be useful in the future ? Anyways just an idea.

Regards,

Hans




> ---
> Changes in v2:
> - applies on pdx86/for-next
> ---
>  drivers/platform/x86/wmi.c | 64 ++++++++++++++++++++------------------
>  include/linux/wmi.h        |  2 ++
>  2 files changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 5c27b4aa9690..9d9a050e7086 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -536,41 +536,50 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
>   *
>   * Return: acpi_status signaling success or error.
>   */
> -acpi_status wmi_set_block(const char *guid_string, u8 instance,
> -			  const struct acpi_buffer *in)
> +acpi_status wmi_set_block(const char *guid_string, u8 instance, const struct acpi_buffer *in)
>  {
> -	struct wmi_block *wblock;
> -	struct guid_block *block;
>  	struct wmi_device *wdev;
> -	acpi_handle handle;
> -	struct acpi_object_list input;
> -	union acpi_object params[2];
> -	char method[WMI_ACPI_METHOD_NAME_SIZE];
>  	acpi_status status;
> 
> -	if (!in)
> -		return AE_BAD_DATA;
> -
>  	wdev = wmi_find_device_by_guid(guid_string);
>  	if (IS_ERR(wdev))
>  		return AE_ERROR;
> 
> -	wblock = container_of(wdev, struct wmi_block, dev);
> -	block = &wblock->gblock;
> -	handle = wblock->acpi_device->handle;
> +	status =  wmidev_block_set(wdev, instance, in);
> +	wmi_device_put(wdev);
> 
> -	if (block->instance_count <= instance) {
> -		status = AE_BAD_PARAMETER;
> +	return status;
> +}
> +EXPORT_SYMBOL_GPL(wmi_set_block);
> 
> -		goto err_wdev_put;
> -	}
> +/**
> + * wmidev_block_set - Write to a WMI block
> + * @wdev: A wmi bus device from a driver
> + * @instance: Instance index
> + * @in: Buffer containing new values for the data block
> + *
> + * Write contents of the input buffer to an ACPI-WMI data block.
> + *
> + * Return: acpi_status signaling success or error.
> + */
> +acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const struct acpi_buffer *in)
> +{
> +	struct wmi_block *wblock = container_of(wdev, struct wmi_block, dev);
> +	acpi_handle handle = wblock->acpi_device->handle;
> +	struct guid_block *block = &wblock->gblock;
> +	char method[WMI_ACPI_METHOD_NAME_SIZE];
> +	struct acpi_object_list input;
> +	union acpi_object params[2];
> 
> -	/* Check GUID is a data block */
> -	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD)) {
> -		status = AE_ERROR;
> +	if (!in)
> +		return AE_BAD_DATA;
> 
> -		goto err_wdev_put;
> -	}
> +	if (block->instance_count <= instance)
> +		return AE_BAD_PARAMETER;
> +
> +	/* Check GUID is a data block */
> +	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD))
> +		return AE_ERROR;
> 
>  	input.count = 2;
>  	input.pointer = params;
> @@ -582,14 +591,9 @@ acpi_status wmi_set_block(const char *guid_string, u8 instance,
> 
>  	get_acpi_method_name(wblock, 'S', method);
> 
> -	status = acpi_evaluate_object(handle, method, &input, NULL);
> -
> -err_wdev_put:
> -	wmi_device_put(wdev);
> -
> -	return status;
> +	return acpi_evaluate_object(handle, method, &input, NULL);
>  }
> -EXPORT_SYMBOL_GPL(wmi_set_block);
> +EXPORT_SYMBOL_GPL(wmidev_block_set);
> 
>  static void wmi_dump_wdg(const struct guid_block *g)
>  {
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index 763bd382cf2d..207544968268 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -35,6 +35,8 @@ extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
>  extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
>  					     u8 instance);
> 
> +acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const struct acpi_buffer *in);
> +
>  u8 wmidev_instance_count(struct wmi_device *wdev);
> 
>  extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
> --
> 2.39.2
> 

