Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EDB7C5EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjJKVPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjJKVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882339E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697058876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q1KVk9ogiduHSj1YLdU62EA0hMWIK2Rnbi2BDgC0/6c=;
        b=NcjGGnDvC7BUQS5AXSCqdJaMcPwCko4SwYfu8xCp+o2eB2NwhhZD3tigcXvTRpQ+UmNOOW
        uVpx81pgczms5OKFxSbHBVeBxmsh6mFlFC1Vj/+ChyL1I9hm/df5OFaNkcJtbn6Y2VbtJe
        U29IZiBNiQ49J47/biljS7+2MHSgMBg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-S0RojSQ0N7Klly0Vdfdvmg-1; Wed, 11 Oct 2023 17:14:35 -0400
X-MC-Unique: S0RojSQ0N7Klly0Vdfdvmg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-66cf38c6d97so2616226d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697058875; x=1697663675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1KVk9ogiduHSj1YLdU62EA0hMWIK2Rnbi2BDgC0/6c=;
        b=vQW59dnaDTl6XhhWLqC2jdzkFr1vkZT/I1osa1JlrYrU1qUZjELSOc4k5SG7Oh1Ps7
         ItYVgmL6a30oBBDso1gOFp6IaYnLkaWfQnJ2JwXtpDFJcCDpUKBpZ75scn6Y81qoDNPZ
         KGwjhF4fQI1v1PEZCLB3RJIdXle+vefCdCaoIvRmPTfvrrybG7ItEKgsjSswoaEPQNyU
         xo+fz/3ILUBF/RIIUPQZGnRTS2gd76Y+x51uxBChrDitbu/j62KOl0PkyKC0sf4LpFAg
         zact57sMHtbhQnx68ozORJFJ/L9/BAUIdQEPZ7ZUvHPGpB1cFh/f1xJtSkr8PTSzkOFm
         1zbg==
X-Gm-Message-State: AOJu0YxNiJI0RY8TEWpiHZwvH+h6v8tMbNxk/Bs4YQ1yUL1iKU2RIef2
        lx5qn7CLypvdA0ZfN1dQvQ1GYB9dextFsVMgqx67C1969hVM/J/dSR+kgiYs5H2rxfVWKILEVV0
        iRrEblA0iZfBQ2FLaGI3IMh+R
X-Received: by 2002:a05:6214:29e5:b0:66d:132b:1c96 with SMTP id jv5-20020a05621429e500b0066d132b1c96mr259832qvb.28.1697058874929;
        Wed, 11 Oct 2023 14:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsnLbiaKP7Wfp/etk2peqwvyRGGC13O75tTXWZ2+u8ZqBEXIg/SzoYmUfjGWR7gq5YrQUrWQ==
X-Received: by 2002:a05:6214:29e5:b0:66d:132b:1c96 with SMTP id jv5-20020a05621429e500b0066d132b1c96mr259818qvb.28.1697058874644;
        Wed, 11 Oct 2023 14:14:34 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id z14-20020a0cf24e000000b0064f4e0b2089sm5958669qvl.33.2023.10.11.14.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:14:34 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:14:32 -0500
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
Subject: Re: [PATCH v3 13/15] firmware: qcom: tzmem: enable SHM Bridge support
Message-ID: <fr4jwbacvcheqtxy6php2u6wr72mqm5hgat6xwmxhijee7j6sk@azlu42eod6b4>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-14-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-14-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:34:25PM +0200, Bartosz Golaszewski wrote:
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
>  drivers/firmware/qcom/qcom_tzmem.c | 67 +++++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 1 deletion(-)
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
> index eee51fed756e..b3137844fe43 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -55,7 +55,72 @@ static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
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

Does the qcom_scm_shm_bridge_enable() returning -EOPNOTSUPP case make
sense? Setting ret to 0 and then claiming we're using shm_bridge seems
wrong to me.

> +
> +	return ret;
> +}
> +
> +static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
> +{
> +	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms, *handle;
> +	int ret;
> +
> +	if (!qcom_tzmem_using_shm_bridge)
> +		return 0;
> +
> +	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> +	pfn_and_ns_perm = (u64)pool->pbase | ns_perms;
> +	ipfn_and_s_perm = (u64)pool->pbase | ns_perms;
> +	size_and_flags = pool->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);

Is there any sanity checking that can be done here? I assume bits 0-11 are all
flag fields (or at least unrelated to size which I assume at a minimum
must be 4k aka bit 12).

> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);

Consider __free(kfree) + return_ptr() usage?

> +	if (!handle)
> +		return -ENOMEM;
> +
> +	ret = qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
> +					 ipfn_and_s_perm, size_and_flags,
> +					 QCOM_SCM_VMID_HLOS, handle);
> +	if (ret) {
> +		kfree(handle);
> +		return ret;
> +	}
> +
> +	pool->priv = handle;
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

