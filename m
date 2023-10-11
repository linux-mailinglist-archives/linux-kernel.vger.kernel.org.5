Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA887C55F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjJKN4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjJKN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D5590
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697032554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CCQEtnJtqrl4ZQlzrkW0UsHRVRuDX1lNSfSKzLC2Fyw=;
        b=hfKkioAPJAFuEUWeIHuCkyhmSEoX81gxy8HV/MDRIcrJIC7Ichn+OlGsDTcmqs4WvNWMjh
        CTm6RN9N4kD/peQCeSCEsZ9lzvMRM31UdpSp+GUHP8Jz8AbPydYE/3HSpaXAS5MZkUdLkt
        xGYRkq67ZYyS9T1x2loV+3Ndp4mCXeI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-mL34rKmhNnC6INHukD-YbQ-1; Wed, 11 Oct 2023 09:55:53 -0400
X-MC-Unique: mL34rKmhNnC6INHukD-YbQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-775751c3437so915808485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032552; x=1697637352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCQEtnJtqrl4ZQlzrkW0UsHRVRuDX1lNSfSKzLC2Fyw=;
        b=Z2/fsbWkvSV1xrgn8+6MzOII/oanlht3/uIDBf8AYjh7n4k9f9uPEctkS56zoVuO+e
         CsX/8pR9Dbm5qI98XwmETyPVm0DVe+7UuSYXeYVnnc6Q12ynFd5m87nfcmv5y4qlgCYT
         meNSjS6X204kYa1vFh4BNbGBM3+2s3hkUAS+2QloEglahcCj05AKiOJj7mgAW64kVGYH
         rpcxD2slHujZcbtu4u5mvq6Os6QPWUIwWWDoDc5WRPYYi2KO0l8khiA22VmJUQJQElqW
         928fRYtzBkoMMN2mo4IpwwlhAVI8K1XEJLNIqDxI49xqvGRYXLNCKG74E+0J933fuRw8
         F6YQ==
X-Gm-Message-State: AOJu0YxjseZAeRdAjb/Uw3dZ5ufU1Zq405JGdfCFbhLgDKfIoUvAGE7/
        94cQhipTmjzNqXnn356rFNKixNMz1rz2/LgtlYP422imoIOqmcvX8AaRRpDSu3t2mgJ+A0b6nZA
        A/J87FBy46dzanDCNoUMRmWtwxJ7RYrXR
X-Received: by 2002:a05:620a:2493:b0:773:dce0:b2b8 with SMTP id i19-20020a05620a249300b00773dce0b2b8mr25704056qkn.17.1697032552590;
        Wed, 11 Oct 2023 06:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi3OK6NLbzJY91SNGXtfrl8Fa+QyLwnsW/XwbEjDqucInTsI9Z/AMMlIz8fq5NCAnl+iFobA==
X-Received: by 2002:a05:620a:2493:b0:773:dce0:b2b8 with SMTP id i19-20020a05620a249300b00773dce0b2b8mr25704032qkn.17.1697032552283;
        Wed, 11 Oct 2023 06:55:52 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j30-20020a05620a001e00b00767d2870e39sm5243919qki.41.2023.10.11.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:55:51 -0700 (PDT)
Date:   Wed, 11 Oct 2023 08:55:49 -0500
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
Message-ID: <ebihxhbl2hyhuke3l2nm56yhvmj4qcja6fbihrc4bhrf2czoix@wjnnyic7wvi7>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-12-brgl@bgdev.pl>
 <y5otsuzhc27xeay6js4nkqss2bo5bsmygwdjuhqpdzce4yffxk@gkkh522s5e3b>
 <CAMRc=MdfZzG-C7=OVhR7x_vEmCexS39GEJ3F-CHM7cfya+A-VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdfZzG-C7=OVhR7x_vEmCexS39GEJ3F-CHM7cfya+A-VA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:44:54AM +0200, Bartosz Golaszewski wrote:
> On Wed, Oct 11, 2023 at 12:49 AM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Mon, Oct 09, 2023 at 05:34:23PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
> > > convert all users of it in the qseecom module to using the TZ allocator
> > > for creating SCM call buffers. Together with using the cleanup macros,
> > > it has the added benefit of a significant code shrink. As this is
> > > largely a module separate from the SCM driver, let's use a separate
> > > memory pool.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > <snip>
> >
> > > @@ -567,20 +529,14 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
> > >               return EFI_INVALID_PARAMETER;
> > >
> > >       status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
> > > -     if (status) {
> > > -             efi_status = EFI_DEVICE_ERROR;
> > > -             goto out_free;
> > > -     }
> > > +     if (status)
> > > +             return EFI_DEVICE_ERROR;
> > >
> > > -     if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE) {
> > > -             efi_status = EFI_DEVICE_ERROR;
> > > -             goto out_free;
> > > -     }
> > > +     if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE)
> > > +             return EFI_DEVICE_ERROR;
> > >
> > > -     if (rsp_data->length < sizeof(*rsp_data)) {
> > > -             efi_status = EFI_DEVICE_ERROR;
> > > -             goto out_free;
> > > -     }
> > > +     if (rsp_data->length < sizeof(*rsp_data))
> > > +             return EFI_DEVICE_ERROR;
> > >
> > >       if (rsp_data->status) {
> > >               dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
> > > @@ -595,77 +551,59 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
> > >               if (efi_status == EFI_BUFFER_TOO_SMALL)
> > >                       *name_size = rsp_data->name_size;
> > >
> > > -             goto out_free;
> > > +             return efi_status;
> > >       }
> > >
> > > -     if (rsp_data->length > rsp_size) {
> > > -             efi_status = EFI_DEVICE_ERROR;
> > > -             goto out_free;
> > > -     }
> > > +     if (rsp_data->length > rsp_size)
> > > +             return EFI_DEVICE_ERROR;
> > >
> > > -     if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length) {
> > > -             efi_status = EFI_DEVICE_ERROR;
> > > -             goto out_free;
> > > -     }
> > > +     if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length)
> > > +             return EFI_DEVICE_ERROR;
> > >
> > > -     if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length) {
> > > -             efi_status = EFI_DEVICE_ERROR;
> > > -             goto out_free;
> > > -     }
> > > +     if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length)
> > > +             return EFI_DEVICE_ERROR;
> > >
> > >       if (rsp_data->name_size > *name_size) {
> > >               *name_size = rsp_data->name_size;
> > > -             efi_status = EFI_BUFFER_TOO_SMALL;
> > > -             goto out_free;
> > > +             return EFI_BUFFER_TOO_SMALL;
> > >       }
> > >
> > > -     if (rsp_data->guid_size != sizeof(*guid)) {
> > > -             efi_status = EFI_DEVICE_ERROR;
> > > -             goto out_free;
> > > -     }
> > > +     if (rsp_data->guid_size != sizeof(*guid))
> > > +             return EFI_DEVICE_ERROR;
> > >
> > >       memcpy(guid, ((void *)rsp_data) + rsp_data->guid_offset, rsp_data->guid_size);
> > >       status = ucs2_strscpy(name, ((void *)rsp_data) + rsp_data->name_offset,
> > >                             rsp_data->name_size / sizeof(*name));
> > >       *name_size = rsp_data->name_size;
> > >
> > > -     if (status < 0) {
> > > +     if (status < 0)
> > >               /*
> > >                * Return EFI_DEVICE_ERROR here because the buffer size should
> > >                * have already been validated above, causing this function to
> > >                * bail with EFI_BUFFER_TOO_SMALL.
> > >                */
> > >               return EFI_DEVICE_ERROR;
> > > -     }
> >
> > Personally (no idea what the actual style guide says) leaving braces
> > around the multiline if statement would be nice.... that being said,
> > that's my opinion :)
> >
> > <snip>
> > > @@ -704,12 +635,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
> > >       if (max_variable_size)
> > >               *max_variable_size = rsp_data->max_variable_size;
> > >
> > > -out_free:
> > > -     kfree(rsp_data);
> > > -out_free_req:
> > > -     kfree(req_data);
> > > -out:
> > > -     return efi_status;
> > > +     return EFI_SUCCESS;
> > >  }
> > >
> > >  /* -- Global efivar interface. ---------------------------------------------- */
> > > @@ -838,6 +764,10 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
> > >       if (status)
> > >               qcuefi_set_reference(NULL);
> > >
> > > +     qcuefi->mempool = devm_qcom_tzmem_pool_new(&aux_dev->dev, SZ_256K);
> >
> > Any particular reason for this size? Just curious, it was (one) of the
> > reasons I had not marked patch 4 yet (it looks good, but I wanted to get
> > through the series to digest the Kconfig as well).
> >
> 
> I cannot test this. Do you know what the minimum correct size would be?

I've got no insight into these firmware interfaces unfortunately. Was
mostly curious if Qualcomm had provided a suggestion behind the scenes
or if this was picked as a "sufficiently large" pool size.

> 
> Bart
> 
> > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> >
> 

