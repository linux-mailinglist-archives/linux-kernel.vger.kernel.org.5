Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40987826C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjHUKEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHUKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57A0DE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692612244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xg9daV7uWAmIhLcF/R04spGodJ9GWcUQaJbU5Trx9fQ=;
        b=ABqglO1Rqq80e9pdr3HM4YvXBLA0Jeds2ZGi6bzEizTXxUuo2Z6cvTxEA90Caq2r4oRp7r
        LWnqdovARuwlGmeDb8l3crGgnHq9o/b30pG4emxS3lFnp17CCiseHqCZfivNO1LGM+6EY+
        j+PcgpIvHQmeqRhUwsy5JEC0XVn36fA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-oIRDONRkM2aK8DcUC1ikUw-1; Mon, 21 Aug 2023 06:04:02 -0400
X-MC-Unique: oIRDONRkM2aK8DcUC1ikUw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99df23d6926so210985166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692612241; x=1693217041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xg9daV7uWAmIhLcF/R04spGodJ9GWcUQaJbU5Trx9fQ=;
        b=DW2CSwZrO4hDLpxq12QTGSi4Mne2Butw9zog1O7vkzouW3dg6wbtgR3yH0v1ldOdx3
         oHInZTfX966nbSWSddVXirdrvUrJCIcZzGsafR30fXIWafdEUerFmDhp2O6R3Q9RTavt
         c+2JSVh30ZTaf0+Pt7w8Ab+dSYDxBuyS27hyMdnFNEo8Keai0fKDwNZBFjCvxm82e4oJ
         dY8KF360JQaYhfiolSFbATa5Te0wX6F5bEwPYEorkfmdm8+bo7nHo8n7S2NClDyyqPru
         MKWXZtdVcLgHWApqsugent5AYQ2kGkPIL7PAYsgMLXdtEL2wny/a99hQrylfx5gPi+Ac
         1pvQ==
X-Gm-Message-State: AOJu0YwgL7uy9nMW/QVtYlS/h3sedT+pQHuhSwhWJIF2iHLzclOHpcZE
        bUxdyMz9BiW6ItaTp97rx/HB0gjYopq3NK6oTM4UVmUtGSrinTBRcuhHy/LGSPrMKmSYeQWMyUn
        fJqFVIEvdP/uQbPAuPHpnVtehkXdTo66h
X-Received: by 2002:a17:906:113:b0:99d:dc0b:a898 with SMTP id 19-20020a170906011300b0099ddc0ba898mr3819182eje.69.1692612241359;
        Mon, 21 Aug 2023 03:04:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+kOx3h4pL6VVinVKGtauFYxSqWn9IHcE9L+rnnke+HTGQpb9UPTXLilgemLfOfaH9txtzmw==
X-Received: by 2002:a17:906:113:b0:99d:dc0b:a898 with SMTP id 19-20020a170906011300b0099ddc0ba898mr3819173eje.69.1692612241047;
        Mon, 21 Aug 2023 03:04:01 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906140900b0099bca8b9a31sm6238818ejc.100.2023.08.21.03.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 03:04:00 -0700 (PDT)
Message-ID: <6f57cd3a-f10d-d94e-d74d-685e2722d11f@redhat.com>
Date:   Mon, 21 Aug 2023 12:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] [v1] platform/mellanox: Fix mlxbf-tmfifo not handling
 all virtio CONSOLE notifictions
Content-Language: en-US
To:     Shiih-Yi Chen <shihyic@nvidia.com>, linux-kernel@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org
Cc:     davthompson@nvidia.com, limings@nvidia.com
References: <20230814175313.7101-1-shihyic@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230814175313.7101-1-shihyic@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/14/23 19:53, Shiih-Yi Chen wrote:
> From: shihyic <shihyic@nvidia.com>
> 
> rshim console does not show all entries of dmesg.
> 
> Fixed by setting MLXBF_TM_TX_LWM_IRQ for every CONSOLE notification. 
>  
> 
> Signed-off-by: shihyic <shihyic@nvidia.com>
> Review-by: limings@nvidia.com
> 
> ---
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index a79318e90a13..4561b7d42412 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -887,6 +887,8 @@ static bool mlxbf_tmfifo_virtio_notify(struct virtqueue *vq)
>  			tm_vdev = fifo->vdev[VIRTIO_ID_CONSOLE];
>  			mlxbf_tmfifo_console_output(tm_vdev, vring);
>  			spin_unlock_irqrestore(&fifo->spin_lock[0], flags);
> +			test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
> +					 &fifo->pend_events);

You are not doing anything with the test result of test_and_set_bit() here,
so I think you can just use a (cheaper) set_bit() call here ?

Regards,

Hans



>  		} else if (test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
>  					    &fifo->pend_events)) {
>  			return true;

