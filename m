Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68077696A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjHIUCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHIUCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ED2121
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691611312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHsnx+XgYvq7zVbyX3fE1g8eFuqDc6DMbNib2NAq4Jc=;
        b=QI78G5BoGDKhqZ+eka7c2+ecSnYi/iltQrZWGnb375DeIcbYwgmx1VaRoTXa0mnM8o9lHz
        asyU+FIulGhyC6aXRO0nqYow9m30qi1iln6Az0eMPVw1W3SNb5+9pb26qwCCqiB8jJhC2r
        00vFXy4XP0OCKVIF/8OJzyBaNqGlI84=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-y1fPMhTrNG644C8kjFCoTg-1; Wed, 09 Aug 2023 16:01:50 -0400
X-MC-Unique: y1fPMhTrNG644C8kjFCoTg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993d7ca4607so14134866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611308; x=1692216108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHsnx+XgYvq7zVbyX3fE1g8eFuqDc6DMbNib2NAq4Jc=;
        b=kgm/D2piABFxrHDu7ahsN0SviZTdsjBC1SEQ0hWSj5elwASQ1jwc6T/B/1xMWGWWcc
         GegvzMKjBWyR9WxJm2PAliI0pUheLA9MDjCVdh5mISjjcl5ZJVHtZJzLz9ROmCiUmEtd
         jFrpk1pbdRcBW60brRwztInrxtKqdw8cpEEOk3RdqsJmrDu5sgAe5PJKOBpkXNb/lry9
         PcJNq4921bJYnIMxC+TnXV2z6hj84niazR92itOSMaaRl6yqY6bv3AWmJ9ssZz+4Ovup
         O2HyevFfHAe2qYOJYJEUYNFzV6NklbvD2aQFxw6ZkAm9RykqYuBL7xrtUlubeKHSfJ6h
         1Qow==
X-Gm-Message-State: AOJu0YxhLW4H7hJ6Y//tVEjNAjvU//3DLj/y1S4DLnFKWVwWQ0Kjw1+H
        UHAxnEC6HPYhEjGviU5jbh6aG37EZxan+s9rdnDln+FsLIH8MRKyVcVM23YAmEB7v7fzd9QWUXY
        w7MxZ1O1x+odRsqiaVEheDVs8zuutQ0df
X-Received: by 2002:a17:906:1da1:b0:99c:3da8:63a9 with SMTP id u1-20020a1709061da100b0099c3da863a9mr102083ejh.29.1691611307900;
        Wed, 09 Aug 2023 13:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvrBtzGaCDsgAfmEDv2vzTugocmqCO+v7o4HM7Pynq5OPxeQOxgdhhgeQcbsQ9IoeWaK9jjg==
X-Received: by 2002:a17:906:1da1:b0:99c:3da8:63a9 with SMTP id u1-20020a1709061da100b0099c3da863a9mr102063ejh.29.1691611307593;
        Wed, 09 Aug 2023 13:01:47 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lt1-20020a170906fa8100b009934707378fsm8337278ejb.87.2023.08.09.13.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 13:01:44 -0700 (PDT)
Message-ID: <aa35b6e9-e58e-de92-9a86-c5a9be13fd26@redhat.com>
Date:   Wed, 9 Aug 2023 22:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: ISST: Reduce noise for missing numa
 information in logs
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230808174359.50602-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230808174359.50602-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 8/8/23 19:43, Srinivas Pandruvada wrote:
> On platforms with no numa support and with several CPUs, logs have lots
> of noise for message "Fail to get numa node for CPU:.."
> 
> Change pr_info() to pr_info_once() as one print is enough to show the
> issue.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index 1f59ac55c5f7..a95004e3d80b 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -335,8 +335,8 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
>  
>  		node = dev_to_node(&_pci_dev->dev);
>  		if (node == NUMA_NO_NODE) {
> -			pr_info("Fail to get numa node for CPU:%d bus:%d dev:%d fn:%d\n",
> -				cpu, bus_no, dev, fn);
> +			pr_info_once("Fail to get numa node for CPU:%d bus:%d dev:%d fn:%d\n",
> +				     cpu, bus_no, dev, fn);
>  			continue;
>  		}
>  

