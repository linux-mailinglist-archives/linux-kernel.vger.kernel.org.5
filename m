Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604237C603E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbjJKWS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjJKWSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30B79E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697062664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HOBDG3xKzKr8T8oX4JN9DRdb/jGhMmbUwbMpuegARt0=;
        b=SFT9YY1PzI7T1R4oMIGQBIhAm4wPgSieLuEorlADa0jnT2bnDT73Euxs7RQlpD3H5gQnPw
        rsNVsFtwRei3AAvEbVogku2KMimnJ+b4OqKcLkfvFXpj7GWuIZOdFyuPQZ5/LpR6C92SC5
        Ormi3p7JNSCYIwj3uvDetYMg2JdVa04=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-vlGBz8bBP3yYVRmoAhLDhA-1; Wed, 11 Oct 2023 18:17:42 -0400
X-MC-Unique: vlGBz8bBP3yYVRmoAhLDhA-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-d9a3a98b34dso411116276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697062662; x=1697667462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOBDG3xKzKr8T8oX4JN9DRdb/jGhMmbUwbMpuegARt0=;
        b=beXUxCLEWqyr6E3JVEBH4EdmRrOV4TRit1Ecowrbb0IxqPJVNRRuT0bWBgcjUjnYBf
         93DmsP34aeiLMQRzAsqNiYI6zgtfeHn7rsU9JAsU4mubHgpbHm4PcC9vl46uitgriiXr
         ChLMr/pLcBkpEDaJodIS7E+mvt2G41EJ9CDIDixTlj4ACw00TK7XOEhN8IyiSxfgd26S
         TQ6sBdc6ZyRWNG3wxKS1gtuzN47L0+y3AbFOgWn5ClOglI0N2+M9xgu8+9S4v/oHvbN4
         EToT/6GZgs6ZcQ9TMabFlWCO5MEhafjK1YfGWG7AehzRwnTqwwvmOeiEfXn4Fi59oVef
         N7wA==
X-Gm-Message-State: AOJu0Yw/JHkAou9fMobIflPOxk/OqADQCHcGc14cjvowePAgeM2kW03M
        cLTIEykE2n/+dQBpl6ClUyNWgNfnVqr73mra4JL+bCJhRCieyO5BPguYMnFKBmkbNqewuW9nSWK
        44xyeikPB+yHVsbB0DrnUttCd
X-Received: by 2002:a25:a346:0:b0:d62:d6c5:f5ee with SMTP id d64-20020a25a346000000b00d62d6c5f5eemr21254607ybi.58.1697062661941;
        Wed, 11 Oct 2023 15:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB/WjZnlk4wnVo1njse5BQo14v078PToJ3YVKAolzEvbngE/7Trey8T7IuLzo8Styd6XAAmA==
X-Received: by 2002:a25:a346:0:b0:d62:d6c5:f5ee with SMTP id d64-20020a25a346000000b00d62d6c5f5eemr21254593ybi.58.1697062661608;
        Wed, 11 Oct 2023 15:17:41 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id w9-20020a0cb549000000b0065b14fcfca6sm6060095qvd.118.2023.10.11.15.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:17:40 -0700 (PDT)
Date:   Wed, 11 Oct 2023 17:17:38 -0500
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
Message-ID: <j543teo2apaugbq25to3un7f7iyh45tfxenmhj7vb3vwqd52i3@434do3lfdzq4>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-14-brgl@bgdev.pl>
 <fr4jwbacvcheqtxy6php2u6wr72mqm5hgat6xwmxhijee7j6sk@azlu42eod6b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fr4jwbacvcheqtxy6php2u6wr72mqm5hgat6xwmxhijee7j6sk@azlu42eod6b4>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 04:14:32PM -0500, Andrew Halaney wrote:
> On Mon, Oct 09, 2023 at 05:34:25PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Add a new Kconfig option for selecting the SHM Bridge mode of operation
> > for the TrustZone memory allocator.
> > 
> > If enabled at build-time, it will still be checked for availability at
> > run-time. If the architecture doesn't support SHM Bridge, the allocator
> > will work just like in the default mode.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/firmware/qcom/Kconfig      | 10 +++++
> >  drivers/firmware/qcom/qcom_tzmem.c | 67 +++++++++++++++++++++++++++++-
> >  2 files changed, 76 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> > index 237da40de832..e01407e31ae4 100644
> > --- a/drivers/firmware/qcom/Kconfig
> > +++ b/drivers/firmware/qcom/Kconfig
> > @@ -27,6 +27,16 @@ config QCOM_TZMEM_MODE_DEFAULT
> >  	  Use the default allocator mode. The memory is page-aligned, non-cachable
> >  	  and contiguous.
> >  
> > +config QCOM_TZMEM_MODE_SHMBRIDGE
> > +	bool "SHM Bridge"
> > +	help
> > +	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
> > +	  in the 'Default' allocator but is also explicitly marked as an SHM Bridge
> > +	  buffer.
> > +
> > +	  With this selected, all buffers passed to the TrustZone must be allocated
> > +	  using the TZMem allocator or else the TrustZone will refuse to use them.
> > +
> >  endchoice
> >  
> >  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> > diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> > index eee51fed756e..b3137844fe43 100644
> > --- a/drivers/firmware/qcom/qcom_tzmem.c
> > +++ b/drivers/firmware/qcom/qcom_tzmem.c
> > @@ -55,7 +55,72 @@ static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
> >  
> >  }
> >  
> > -#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
> > +#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
> > +
> > +#include <linux/firmware/qcom/qcom_scm.h>
> > +
> > +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> > +
> > +static bool qcom_tzmem_using_shm_bridge;
> > +
> > +static int qcom_tzmem_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = qcom_scm_shm_bridge_enable();
> > +	if (ret == -EOPNOTSUPP) {
> > +		dev_info(qcom_tzmem_dev, "SHM Bridge not supported\n");
> > +		ret = 0;
> > +	}
> > +
> > +	if (!ret)
> > +		qcom_tzmem_using_shm_bridge = true;
> 
> Does the qcom_scm_shm_bridge_enable() returning -EOPNOTSUPP case make
> sense? Setting ret to 0 and then claiming we're using shm_bridge seems
> wrong to me.
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
> > +{
> > +	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms, *handle;
> > +	int ret;
> > +
> > +	if (!qcom_tzmem_using_shm_bridge)
> > +		return 0;
> > +
> > +	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> > +	pfn_and_ns_perm = (u64)pool->pbase | ns_perms;
> > +	ipfn_and_s_perm = (u64)pool->pbase | ns_perms;
> > +	size_and_flags = pool->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
> 
> Is there any sanity checking that can be done here? I assume bits 0-11 are all
> flag fields (or at least unrelated to size which I assume at a minimum
> must be 4k aka bit 12).

I guess qcom_tzmem_pool_new's PAGE_ALIGN would make sure this is
probably ok for all future users, but I do think some sanity would be
nice to indicate the size's allowed for SHM bridge.

> 
> > +
> > +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> 
> Consider __free(kfree) + return_ptr() usage?
> 
> > +	if (!handle)
> > +		return -ENOMEM;
> > +
> > +	ret = qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
> > +					 ipfn_and_s_perm, size_and_flags,
> > +					 QCOM_SCM_VMID_HLOS, handle);
> > +	if (ret) {
> > +		kfree(handle);
> > +		return ret;
> > +	}
> > +
> > +	pool->priv = handle;
> > +
> > +	return 0;
> > +}
> > +
> > +static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
> > +{
> > +	u64 *handle = pool->priv;
> > +
> > +	if (!qcom_tzmem_using_shm_bridge)
> > +		return;
> > +
> > +	qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
> > +	kfree(handle);
> > +}
> > +
> > +#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
> >  
> >  /**
> >   * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> > -- 
> > 2.39.2
> > 

