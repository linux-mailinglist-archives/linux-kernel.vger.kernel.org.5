Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED347EA0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjKMQIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKMQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2541702
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 08:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699891669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAkyWuAlP3WRAhkP+++lmx+mwvKY3DtmoscUolCQlDI=;
        b=S8wS8HR28knBtVFcSPiGXyREKrrMviYRASH4lIe+6B4CnaG4WGtk1JWuXFy+59BxIhYyBQ
        U+8E9U5S9Cn0hjNGwNHYMjQ7mTcsw+x/DQ/TJ2eiKHnk775CTPhTlbEAlCgp18gNyJEggg
        C/5ITgjV89reE3utK23i0WoqgreZ4Tw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-o-gFjrg4NRaGMyoZdvn2jA-1; Mon, 13 Nov 2023 11:07:47 -0500
X-MC-Unique: o-gFjrg4NRaGMyoZdvn2jA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a681c3470fso320214666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 08:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699891666; x=1700496466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAkyWuAlP3WRAhkP+++lmx+mwvKY3DtmoscUolCQlDI=;
        b=rhquWYQjASxv1BcLwHiZ4HlccA7mlBxqCokC/hh+OGgK7JQZq5aPiyeestMbOKKbdN
         HPVp0P7Rdb9TE6ifPUnSbrYyNMJK1ElRL33SPrUQ4GEQUCh1kCCy2OPE9RsADqjxm97z
         h+kUenRFWX55AARvkfJxoctDfzceS4jecEm8tZOvzm0+5N8n9Klw6Dj5cOBCYK2mwC2x
         C9JmIpiZRwTDlX+nr2I4gfi6BkSbtsk6zSvtPwte4hQL1SiLliW7YpiEnKPignqOrMZy
         5grAykuVH6+5hIoaAkaWnLyQjPeR97kkmcT4MDtiGZtJomab+jVp7X7ImD1SFkdgQjq5
         8e8g==
X-Gm-Message-State: AOJu0YyFCzLGvt2O3eKy+kVsAIQfcD6XLDxVxTtIHeOpJZEQGFVxetwC
        Q6Paje/LbicNgaq6cPAZJ4HB/eruihpGjFgQ6A8KMAklhPET8dqD/JmXXoyV2O+WHNaMmGTRztM
        KDL7SdkIIHovsD0/F+uj6smvp
X-Received: by 2002:a17:906:b1b:b0:9ae:5370:81d5 with SMTP id u27-20020a1709060b1b00b009ae537081d5mr4359527ejg.41.1699891666715;
        Mon, 13 Nov 2023 08:07:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGTihF/62EKU+Wtiz2v06QtymYDdd3hPfvECCV8zFTiBRYk2GSvIbvrQVO+5wZ5S1Ntj5ooA==
X-Received: by 2002:a17:906:b1b:b0:9ae:5370:81d5 with SMTP id u27-20020a1709060b1b00b009ae537081d5mr4359512ejg.41.1699891666435;
        Mon, 13 Nov 2023 08:07:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id um27-20020a170906cf9b00b009de467a25d5sm4272281ejb.13.2023.11.13.08.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 08:07:45 -0800 (PST)
Message-ID: <ae5131e3-b282-437d-9a80-ae8b697eea3c@redhat.com>
Date:   Mon, 13 Nov 2023 17:07:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] dt-bindings: connector: usb: provide bindings for
 altmodes
Content-Language: en-US, nl
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20231113145328.42575-1-dmitry.baryshkov@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231113145328.42575-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 11/13/23 15:33, Dmitry Baryshkov wrote:
> In some cases we need a way to specify USB-C AltModes that can be
> supportd on the particular USB-C connector. For example, x86 INT33FE
> driver does this by populating fwnode properties internally. For the
> Qualcomm Robotics RB5 platform (and several similar devices which use
> Qualcomm PMIC TCPM) we have to put this information to the DT.
> 
> Provide the DT bindings for this kind of information and while we are at
> it, change svid property to be 16-bit unsigned integer instead of a
> simple u32.

Thank you for your patches. I'm fine with this, one remark though:

Since at least the existing arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
is already using this I'm not sure of changing the svid property to
an u16 is really a good idea from devicetree compatibility pov ?

Also the whole 16 bit property notation in the dts files seems
less readable to me. So to me this seems more of something
which one would use when having a significantly sized array
of u16-s since then it will result in space-saving in the dtb.

In this case I personally think it is fine to leave this
as an u32.

With all that said, I'm fine either way.

Here is my ack for routing the drivers/platform/x86/intel/chtwc_int33fe.c
bits through whatever tree is best to get this upstream:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> Dmitry Baryshkov (3):
>   dt-bindings: connector: usb: add altmodes description
>   usb: typec: change altmode SVID to u16 entry
>   arm64: dts: qcom: qrb5165-rb5: use u16 for DP altmode svid
> 
>  .../bindings/connector/usb-connector.yaml     | 35 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  2 +-
>  drivers/platform/x86/intel/chtwc_int33fe.c    |  2 +-
>  drivers/usb/typec/class.c                     |  5 +--
>  4 files changed, 40 insertions(+), 4 deletions(-)
> 

