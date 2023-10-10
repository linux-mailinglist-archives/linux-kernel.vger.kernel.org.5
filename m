Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A77C4535
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJJXDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344454AbjJJWut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2876DEA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696978195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cb0ffsa2ZMdKBtsL7Ay09Q93KCT+/I1vCSqafr4Bsa8=;
        b=i//K4VgfmKv73DrIy7QweT9wyIbYOikuZYzwh1qoyzYxpIYsRnjxdxk6xkboXCg0Rotlqk
        ssxgLMeXJcyJx46OUGB+tWfy7ZtbXNp5GTJcvmU5+0fc8ocB6+4MATXEtigBinVG3JP426
        XiATuE++8QhXvO+SiXE7LqtFAQWoUjY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-krei1O9FM1eUuqLhPxVw2w-1; Tue, 10 Oct 2023 18:49:53 -0400
X-MC-Unique: krei1O9FM1eUuqLhPxVw2w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-65b0d19bfd0so73812326d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978193; x=1697582993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb0ffsa2ZMdKBtsL7Ay09Q93KCT+/I1vCSqafr4Bsa8=;
        b=ENDcOabHAj8rX7MN2eeNdjXOGKSwNQe58SKMhrh8Wjgt6N+wLi/sXGpEVs/QpGqv0/
         gDpcUjSrTB84lko5SgTesnY4KAHBtDUfcvdUZVm+1l+W85erWmSRVZ0yKJ0nBr4FSjzn
         49eHvDBeONwaKg8hb9dhlWjsuDQmhY2WWKJF7fhlb+Xjck3Ikt2+YdQFRsFdzu96cVzt
         4oCVei652lO0EflRR7gZBeDK02Mld1FSEXsRCGRx5n5gXip9qhCid42hdQ4u+n9srPx+
         PGIjiw+oxIH/vETesFeoIb0XBu0e5GN//h8q/G0iwrFw7iD7RuFkJj7Ns8xOSL0biOZv
         6v2A==
X-Gm-Message-State: AOJu0YwL5Qw02ymic84gW/vWHVlZ5r8w+uWHJIrftpcbNtR3hv8TD9lq
        teK6TPz4e6PeG+cm4qC7jMKeulX1mI3vKwJlNaEvtQJoADTMdJ3nngxy2fTq4Q8Fyc1gM2nAbGB
        UrNbbrZb5COFtyCE9ILOWpW5V
X-Received: by 2002:a0c:c543:0:b0:66c:fc47:46b7 with SMTP id y3-20020a0cc543000000b0066cfc4746b7mr2407018qvi.16.1696978193303;
        Tue, 10 Oct 2023 15:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAX4sHPUZ1sj/c/iglb3GQvKcOnNHGycBBbOTg8o/hIRciCX9+6emo2NlFUDRtk0Tifxswrw==
X-Received: by 2002:a0c:c543:0:b0:66c:fc47:46b7 with SMTP id y3-20020a0cc543000000b0066cfc4746b7mr2406996qvi.16.1696978193022;
        Tue, 10 Oct 2023 15:49:53 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id z19-20020a0cda93000000b0065b31dfdf70sm5147823qvj.11.2023.10.10.15.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:49:52 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:49:50 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 11/15] firmware: qcom: qseecom: convert to using the
 TZ allocator
Message-ID: <y5otsuzhc27xeay6js4nkqss2bo5bsmygwdjuhqpdzce4yffxk@gkkh522s5e3b>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-12-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-12-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:34:23PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
> convert all users of it in the qseecom module to using the TZ allocator
> for creating SCM call buffers. Together with using the cleanup macros,
> it has the added benefit of a significant code shrink. As this is
> largely a module separate from the SCM driver, let's use a separate
> memory pool.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

<snip>

> @@ -567,20 +529,14 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>  		return EFI_INVALID_PARAMETER;
>  
>  	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
> -	if (status) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (status)
> +		return EFI_DEVICE_ERROR;
>  
> -	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE)
> +		return EFI_DEVICE_ERROR;
>  
> -	if (rsp_data->length < sizeof(*rsp_data)) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->length < sizeof(*rsp_data))
> +		return EFI_DEVICE_ERROR;
>  
>  	if (rsp_data->status) {
>  		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
> @@ -595,77 +551,59 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
>  		if (efi_status == EFI_BUFFER_TOO_SMALL)
>  			*name_size = rsp_data->name_size;
>  
> -		goto out_free;
> +		return efi_status;
>  	}
>  
> -	if (rsp_data->length > rsp_size) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->length > rsp_size)
> +		return EFI_DEVICE_ERROR;
>  
> -	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length)
> +		return EFI_DEVICE_ERROR;
>  
> -	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length)
> +		return EFI_DEVICE_ERROR;
>  
>  	if (rsp_data->name_size > *name_size) {
>  		*name_size = rsp_data->name_size;
> -		efi_status = EFI_BUFFER_TOO_SMALL;
> -		goto out_free;
> +		return EFI_BUFFER_TOO_SMALL;
>  	}
>  
> -	if (rsp_data->guid_size != sizeof(*guid)) {
> -		efi_status = EFI_DEVICE_ERROR;
> -		goto out_free;
> -	}
> +	if (rsp_data->guid_size != sizeof(*guid))
> +		return EFI_DEVICE_ERROR;
>  
>  	memcpy(guid, ((void *)rsp_data) + rsp_data->guid_offset, rsp_data->guid_size);
>  	status = ucs2_strscpy(name, ((void *)rsp_data) + rsp_data->name_offset,
>  			      rsp_data->name_size / sizeof(*name));
>  	*name_size = rsp_data->name_size;
>  
> -	if (status < 0) {
> +	if (status < 0)
>  		/*
>  		 * Return EFI_DEVICE_ERROR here because the buffer size should
>  		 * have already been validated above, causing this function to
>  		 * bail with EFI_BUFFER_TOO_SMALL.
>  		 */
>  		return EFI_DEVICE_ERROR;
> -	}

Personally (no idea what the actual style guide says) leaving braces
around the multiline if statement would be nice.... that being said,
that's my opinion :)

<snip>
> @@ -704,12 +635,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
>  	if (max_variable_size)
>  		*max_variable_size = rsp_data->max_variable_size;
>  
> -out_free:
> -	kfree(rsp_data);
> -out_free_req:
> -	kfree(req_data);
> -out:
> -	return efi_status;
> +	return EFI_SUCCESS;
>  }
>  
>  /* -- Global efivar interface. ---------------------------------------------- */
> @@ -838,6 +764,10 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>  	if (status)
>  		qcuefi_set_reference(NULL);
>  
> +	qcuefi->mempool = devm_qcom_tzmem_pool_new(&aux_dev->dev, SZ_256K);

Any particular reason for this size? Just curious, it was (one) of the
reasons I had not marked patch 4 yet (it looks good, but I wanted to get
through the series to digest the Kconfig as well).

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

