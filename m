Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B47C8795
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjJMONs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjJMONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551AAB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697206383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKNl2Sg2UX0CqarnGytCYre/GJvG3BPZJr1PClqG+q8=;
        b=L8wpUZaNaae8rqVGFIkitpQRpYNW+Gqov9tuj2W6eR9AD55GYFkXstAgHhvgwv8P+BQOLz
        Uhzbt2wpbidE5v/Vs1uUGVOC+1PWdQsczx4Mi5vNv0xE9ifKrzm3+SNYlWBcz7YiOQ2GUT
        o9621dXYhsDLyrj/JGFYCUa4Tez/oXo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-wU8oQ22OPTCfa3YeWRBnQg-1; Fri, 13 Oct 2023 10:13:02 -0400
X-MC-Unique: wU8oQ22OPTCfa3YeWRBnQg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-774105e8c7fso249877985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697206381; x=1697811181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKNl2Sg2UX0CqarnGytCYre/GJvG3BPZJr1PClqG+q8=;
        b=PmmRxiqqrO4hDdqSfcXPCWHnpVA55CUGAtF+ga0KaUkVWBH2wS2HHhOnX5K4k89YHr
         vGrbc4IcqAo6cklyqEPo4QNyHzQDzFMM62T9ezWAw80/2XaMdULXp+24rAD47Kn8tuMk
         MlUGkJigJZh/zANyNZ/j85ZrXVKKVen4pYeem9Dgio72UIqYuyMelbwWJlYCy/oycpIa
         VTKA31idTeMZmBLJpuLt3t/trdqAifnhyeDfu576fFxdtwd3bAzzfa4dtivTU3tdikHQ
         2bRu7RijHVy743lCXuY8EjCjrxXf9vje7+tzSQl9xTErzK3pvJ6pkOidfd//1/+wc6Wt
         fh5A==
X-Gm-Message-State: AOJu0YyIJKaNGG4fXP/MX1NZEw8P96fF2E6Z8FJ22rZPdC22Vc0TCCVV
        AJbsDX3tdcHCA9cjl261e6vUrrdbGG9qKi6ECvMHqMLKOIDt8hGb8bbpVDW3F5hD5hTA/0MDmLT
        1HPABikDbXFgAkOtaPlbnVFg5
X-Received: by 2002:a05:620a:678:b0:775:446b:860c with SMTP id a24-20020a05620a067800b00775446b860cmr24362157qkh.70.1697206381094;
        Fri, 13 Oct 2023 07:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqkGP62nYlBuY9GJD/TlSdNVRzWia8Fmh8r5TKl8mwE54TuKEbSE0dwsTqU6pAhQhwqm3L+w==
X-Received: by 2002:a05:620a:678:b0:775:446b:860c with SMTP id a24-20020a05620a067800b00775446b860cmr24362136qkh.70.1697206380802;
        Fri, 13 Oct 2023 07:13:00 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id y10-20020a37e30a000000b0076dae4753efsm662404qki.14.2023.10.13.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:13:00 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:12:58 -0500
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
Subject: Re: [PATCH v4 13/15] firmware: qcom: tzmem: enable SHM Bridge support
Message-ID: <ny6snvytcdycxsqhtodbped3xgwfasjp6cubbpmgfa6uxrqmp4@lbmc3i2pgmvl>
References: <20231013114843.63205-1-brgl@bgdev.pl>
 <20231013114843.63205-14-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013114843.63205-14-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:48:41PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a new Kconfig option for selecting the SHM Bridge mode of operation
> for the TrustZone memory allocator.
> 
> If enabled at build-time, it will still be checked for availability at
> run-time. If the architecture doesn't support SHM Bridge, the allocator
> will work just like in the default mode.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/qcom/Kconfig      | 10 +++++
>  drivers/firmware/qcom/qcom_tzmem.c | 65 +++++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 237da40de832..e01407e31ae4 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -27,6 +27,16 @@ config QCOM_TZMEM_MODE_DEFAULT
>  	  Use the default allocator mode. The memory is page-aligned, non-cachable
>  	  and contiguous.
>  
> +config QCOM_TZMEM_MODE_SHMBRIDGE
> +	bool "SHM Bridge"
> +	help
> +	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
> +	  in the 'Default' allocator but is also explicitly marked as an SHM Bridge
> +	  buffer.
> +
> +	  With this selected, all buffers passed to the TrustZone must be allocated
> +	  using the TZMem allocator or else the TrustZone will refuse to use them.
> +
>  endchoice
>  
>  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> index 68ca59c5598e..6c4f29a00f26 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -55,7 +55,70 @@ static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
>  
>  }
>  
> -#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
> +#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
> +
> +#include <linux/firmware/qcom/qcom_scm.h>
> +
> +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> +
> +static bool qcom_tzmem_using_shm_bridge;
> +
> +static int qcom_tzmem_init(void)
> +{
> +	int ret;
> +
> +	ret = qcom_scm_shm_bridge_enable();
> +	if (ret == -EOPNOTSUPP) {
> +		dev_info(qcom_tzmem_dev, "SHM Bridge not supported\n");
> +		ret = 0;
> +	}
> +
> +	if (!ret)
> +		qcom_tzmem_using_shm_bridge = true;
> +
> +	return ret;
> +}

Restating the comment we just concluded on in v3 (just to make it
obvious for other reviewers), the -EOPNOTSUPP
case here should probably return 0, not ret = 0, otherwise we'll try to
use SHM bridge on memory later even though it is not supported:

https://lore.kernel.org/linux-arm-msm/20231009153427.20951-1-brgl@bgdev.pl/T/#m175bd35782cb5824820977bb3f799b32e32fb2d7

> +
> +static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
> +{
> +	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms;
> +	int ret;
> +
> +	if (!qcom_tzmem_using_shm_bridge)
> +		return 0;
> +
> +	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> +	pfn_and_ns_perm = (u64)pool->pbase | ns_perms;
> +	ipfn_and_s_perm = (u64)pool->pbase | ns_perms;
> +	size_and_flags = pool->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
> +
> +	u64 *handle __free(kfree) = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return -ENOMEM;
> +
> +	ret = qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
> +					 ipfn_and_s_perm, size_and_flags,
> +					 QCOM_SCM_VMID_HLOS, handle);
> +	if (ret)
> +		return ret;
> +
> +	pool->priv = no_free_ptr(handle);
> +
> +	return 0;
> +}
> +
> +static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
> +{
> +	u64 *handle = pool->priv;
> +
> +	if (!qcom_tzmem_using_shm_bridge)
> +		return;
> +
> +	qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
> +	kfree(handle);
> +}
> +
> +#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
>  
>  /**
>   * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> -- 
> 2.39.2
> 

