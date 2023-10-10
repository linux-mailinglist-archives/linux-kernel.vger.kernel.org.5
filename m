Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107B7C4411
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjJJW3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjJJW3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65847130
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696976913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0lY8Usb/WxC44Vf0gXOx0P0lksQ7vtbcR6F+u6qCVDk=;
        b=A0rFe8xtB8CG44B4A31lp5sYhnGb7C+ROz6penp12BxyJsvb7wywxOcJt5dhQe7wEhB0sI
        rTmOqSnh5qPnu3bGkrfYhCIYY/9tAZi7eXzxo59f/0aR7TH2L3fhP7LhPAxHyKmbqY6p9s
        kwV+ZRrjXWat0qZlQY4o+VeMnOguhfY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-yg4JAO_8N6q6HV_O8lQ16A-1; Tue, 10 Oct 2023 18:28:17 -0400
X-MC-Unique: yg4JAO_8N6q6HV_O8lQ16A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-65b0d19bfd0so73669526d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976896; x=1697581696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lY8Usb/WxC44Vf0gXOx0P0lksQ7vtbcR6F+u6qCVDk=;
        b=f3Qd4kmluNxyWn8Q0cHld30iuwujksNZLu7wb8JwSDIEfqvWtSyQqTHrIu0y88wprF
         Rfiw0lGegocFtao/rsUXe0P4WiXyvoyPACf9jmr/ZSP9MjWXOjko4f1QuUx1+2p8gjN8
         JAB6xFr5ZBP1LZUeXjko839GzBcvP85qWpWqaHQpKbFzrqWWo7aEvhFvSl4gKpKuXTHt
         lqXb7J5DDcY9gap8Lf9HG2THosgsH54mDqWscQTw0VOgSHWtnmDvVbUyBX/xmL8KzrCI
         5yP/NzqSoxpsD6K9LwCh/cOLN1vgq7bOgQoS2xDoKNYZd6xVe5nhb5AM4pam1BD7K8F2
         a3jw==
X-Gm-Message-State: AOJu0YzWY6+7Oe67NDfBNjceCO/g2t6az0xsXg2i8sHHxJUFnmIjAeGC
        NCOMAgFLt4G6w0YR/I+WxiAq52nBzVqo84x0QZe4Nu5P6uKbsaUJQvAkOQEgdesP9FViTzyTc+q
        wf9ZWvtqv5ICdBHY1f+Gp5zgl
X-Received: by 2002:a0c:e78b:0:b0:64f:6199:a8e with SMTP id x11-20020a0ce78b000000b0064f61990a8emr21136776qvn.23.1696976896687;
        Tue, 10 Oct 2023 15:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEboajQ4nZ/cXl5Vu15HueXN7j73Nk31by1J1VEP3/o43Up0wBONY+hFPXHf9IFVwfeRzmEYw==
X-Received: by 2002:a0c:e78b:0:b0:64f:6199:a8e with SMTP id x11-20020a0ce78b000000b0064f61990a8emr21136757qvn.23.1696976896459;
        Tue, 10 Oct 2023 15:28:16 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id jy11-20020a0562142b4b00b00641899958efsm328378qvb.130.2023.10.10.15.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:28:16 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:28:13 -0500
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
Subject: Re: [PATCH v3 10/15] firmware: qcom: scm: make
 qcom_scm_qseecom_app_get_id() use the TZ allocator
Message-ID: <z3gxzr5cttdhie2svrz7binuxvjqjn5jojkifvvys5hvbyklb3@4tjzaaocr7ft>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-11-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:34:22PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Let's use the new TZ memory allocator to obtain a buffer for this call
> instead of manually kmalloc()ing it and then mapping to physical space.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/firmware/qcom/qcom_scm.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 11638daa2fe5..3a6cefb4eb2e 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1525,37 +1525,27 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
>  	unsigned long app_name_len = strlen(app_name);
>  	struct qcom_scm_desc desc = {};
>  	struct qcom_scm_qseecom_resp res = {};
> -	dma_addr_t name_buf_phys;
> -	char *name_buf;
>  	int status;
>  
>  	if (app_name_len >= name_buf_size)
>  		return -EINVAL;
>  
> -	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
> +	char *name_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
> +							     name_buf_size,
> +							     GFP_KERNEL);
>  	if (!name_buf)
>  		return -ENOMEM;
>  
>  	memcpy(name_buf, app_name, app_name_len);
>  
> -	name_buf_phys = dma_map_single(__scm->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
> -	status = dma_mapping_error(__scm->dev, name_buf_phys);
> -	if (status) {
> -		kfree(name_buf);
> -		dev_err(__scm->dev, "qseecom: failed to map dma address\n");
> -		return status;
> -	}
> -
>  	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
>  	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
>  	desc.cmd = QSEECOM_TZ_CMD_APP_LOOKUP;
>  	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
> -	desc.args[0] = name_buf_phys;
> +	desc.args[0] = qcom_tzmem_to_phys(name_buf);
>  	desc.args[1] = app_name_len;
>  
>  	status = qcom_scm_qseecom_call(&desc, &res);
> -	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
> -	kfree(name_buf);
>  
>  	if (status)
>  		return status;
> -- 
> 2.39.2
> 

