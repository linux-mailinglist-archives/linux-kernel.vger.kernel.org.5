Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD487C86DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjJMNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjJMNbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57E8BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697203862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rz4xahKNYt4q0o13HIbhqMbybtPyDBNS7zXL2UL8V70=;
        b=WX3lJTr88NHyiRS4CfKMGdd393PfikOM4805u7+J1zJnTc6UMjEnGNwwg9PpfeGdMq/c5A
        6DRvePG2HCdUgkJMKA4wBk6p61GhIt0JuTzrCaklUAqjt7JLGNiiGyWGjgZHx5fbElzVDC
        7hz+gwwGMyfkcIk1tqzSTmYXsGbt2AQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-_j2hXN6oOC6GpPVwFqwIlA-1; Fri, 13 Oct 2023 09:31:00 -0400
X-MC-Unique: _j2hXN6oOC6GpPVwFqwIlA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b2a6655ee2so2785647b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697203860; x=1697808660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rz4xahKNYt4q0o13HIbhqMbybtPyDBNS7zXL2UL8V70=;
        b=HHx6O0ExPMg8fWKOW8KCDnMHIKfBQA7/kfija4y1PcUSFYbdRg4dUrryJoRKydChJb
         4O7z9v2MuHonP9UDYDEyhkKd+jjo5GJT/mVX6L+JDbmaeCiE2bDjLNtIf9oZuc3xEfWh
         0qnXPtBFhTrQ12EzLjy7DU28eh9m7/wXD1CqrFQf7RpwUEvtWJzuDpVbyJCEabzZMAOJ
         rbOYydoKQu3Eks2Gp0c5rT78zX9Lsf/trRKA9P1Q/kdXy+nA5PCFvp1Kbq2R4mlakSjT
         olrbj6RGi+UmsJJtY5A9YX5byrlojE4ZhqGI6X6vpAOgZacefYTEkVH2Q6nvqIuG91Iu
         i34g==
X-Gm-Message-State: AOJu0YyBkOqAzndNbAyLuYc8MI1gaRmIhjNlqJlN03pAlS/nXoCWsTc5
        icHslncm5zB5p1YDSWW3vPs5pRMQk3u2+lvMUVcpZRBCSrjJqHenc9TAoTDlGIlfTHlF5jH6QeS
        6OyZbuQpaEw4DqhibubBSF3Ho
X-Received: by 2002:a05:6808:17a5:b0:3ab:81e4:4da0 with SMTP id bg37-20020a05680817a500b003ab81e44da0mr36843251oib.42.1697203859698;
        Fri, 13 Oct 2023 06:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8SpB8ZGgToYJ9f5SxmQwMQIvpkdqh0PXfOqQaDM+EaOUb2GC5VyjnrHrmhT9VglvFbYbL4A==
X-Received: by 2002:a05:6808:17a5:b0:3ab:81e4:4da0 with SMTP id bg37-20020a05680817a500b003ab81e44da0mr36843220oib.42.1697203859392;
        Fri, 13 Oct 2023 06:30:59 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id x17-20020ae9e911000000b0077703f31496sm633676qkf.92.2023.10.13.06.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 06:30:59 -0700 (PDT)
Date:   Fri, 13 Oct 2023 08:30:56 -0500
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
Message-ID: <km6pp6ctzclrgrvfgpbhoykngcnyoqerjnng65x3mox7dzdwwt@nnvxbwqbygrw>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-14-brgl@bgdev.pl>
 <fr4jwbacvcheqtxy6php2u6wr72mqm5hgat6xwmxhijee7j6sk@azlu42eod6b4>
 <j543teo2apaugbq25to3un7f7iyh45tfxenmhj7vb3vwqd52i3@434do3lfdzq4>
 <CAMRc=Mcyp7GQ9Hb2crASW_Y_Q84tn977BXfrKDrM1N8ihdrvRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcyp7GQ9Hb2crASW_Y_Q84tn977BXfrKDrM1N8ihdrvRQ@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:32:00AM +0200, Bartosz Golaszewski wrote:
> On Thu, Oct 12, 2023 at 12:17 AM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Wed, Oct 11, 2023 at 04:14:32PM -0500, Andrew Halaney wrote:
> > > On Mon, Oct 09, 2023 at 05:34:25PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Add a new Kconfig option for selecting the SHM Bridge mode of operation
> > > > for the TrustZone memory allocator.
> > > >
> > > > If enabled at build-time, it will still be checked for availability at
> > > > run-time. If the architecture doesn't support SHM Bridge, the allocator
> > > > will work just like in the default mode.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> > > >  drivers/firmware/qcom/Kconfig      | 10 +++++
> > > >  drivers/firmware/qcom/qcom_tzmem.c | 67 +++++++++++++++++++++++++++++-
> > > >  2 files changed, 76 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> > > > index 237da40de832..e01407e31ae4 100644
> > > > --- a/drivers/firmware/qcom/Kconfig
> > > > +++ b/drivers/firmware/qcom/Kconfig
> > > > @@ -27,6 +27,16 @@ config QCOM_TZMEM_MODE_DEFAULT
> > > >       Use the default allocator mode. The memory is page-aligned, non-cachable
> > > >       and contiguous.
> > > >
> > > > +config QCOM_TZMEM_MODE_SHMBRIDGE
> > > > +   bool "SHM Bridge"
> > > > +   help
> > > > +     Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
> > > > +     in the 'Default' allocator but is also explicitly marked as an SHM Bridge
> > > > +     buffer.
> > > > +
> > > > +     With this selected, all buffers passed to the TrustZone must be allocated
> > > > +     using the TZMem allocator or else the TrustZone will refuse to use them.
> > > > +
> > > >  endchoice
> > > >
> > > >  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> > > > diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> > > > index eee51fed756e..b3137844fe43 100644
> > > > --- a/drivers/firmware/qcom/qcom_tzmem.c
> > > > +++ b/drivers/firmware/qcom/qcom_tzmem.c
> > > > @@ -55,7 +55,72 @@ static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
> > > >
> > > >  }
> > > >
> > > > -#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
> > > > +#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
> > > > +
> > > > +#include <linux/firmware/qcom/qcom_scm.h>
> > > > +
> > > > +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> > > > +
> > > > +static bool qcom_tzmem_using_shm_bridge;
> > > > +
> > > > +static int qcom_tzmem_init(void)
> > > > +{
> > > > +   int ret;
> > > > +
> > > > +   ret = qcom_scm_shm_bridge_enable();
> > > > +   if (ret == -EOPNOTSUPP) {
> > > > +           dev_info(qcom_tzmem_dev, "SHM Bridge not supported\n");
> > > > +           ret = 0;
> > > > +   }
> > > > +
> > > > +   if (!ret)
> > > > +           qcom_tzmem_using_shm_bridge = true;
> > >
> > > Does the qcom_scm_shm_bridge_enable() returning -EOPNOTSUPP case make
> > > sense? Setting ret to 0 and then claiming we're using shm_bridge seems
> > > wrong to me.
> > >
> 
> You answered yourself in the previous email. The size cannot be less
> than 4096 bytes. There's no need to check it anymore than that IMO.
> 

Ok, I still think that would be nice but your call.

But this comment was about the above ret = 0 assignment. I am thinking
that's incorrect, because you fail to enable SHM bridge with
-EOPNOTSUPP, then you go ahead and tell the code to claim it is
supported with the if (!ret) conditional. This results in SHM bridge
trying to be used when its really not supported right?

Looks to me that you're really trying to return 0, not ret = 0.

> Bart
> 
> > > > +
> > > > +   return ret;
> > > > +}
> > > > +
> > > > +static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
> > > > +{
> > > > +   u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms, *handle;
> > > > +   int ret;
> > > > +
> > > > +   if (!qcom_tzmem_using_shm_bridge)
> > > > +           return 0;
> > > > +
> > > > +   ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> > > > +   pfn_and_ns_perm = (u64)pool->pbase | ns_perms;
> > > > +   ipfn_and_s_perm = (u64)pool->pbase | ns_perms;
> > > > +   size_and_flags = pool->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
> > >
> > > Is there any sanity checking that can be done here? I assume bits 0-11 are all
> > > flag fields (or at least unrelated to size which I assume at a minimum
> > > must be 4k aka bit 12).
> >
> > I guess qcom_tzmem_pool_new's PAGE_ALIGN would make sure this is
> > probably ok for all future users, but I do think some sanity would be
> > nice to indicate the size's allowed for SHM bridge.
> >
> > >
> > > > +
> > > > +   handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> > >
> > > Consider __free(kfree) + return_ptr() usage?
> > >
> > > > +   if (!handle)
> > > > +           return -ENOMEM;
> > > > +
> > > > +   ret = qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
> > > > +                                    ipfn_and_s_perm, size_and_flags,
> > > > +                                    QCOM_SCM_VMID_HLOS, handle);
> > > > +   if (ret) {
> > > > +           kfree(handle);
> > > > +           return ret;
> > > > +   }
> > > > +
> > > > +   pool->priv = handle;
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
> > > > +{
> > > > +   u64 *handle = pool->priv;
> > > > +
> > > > +   if (!qcom_tzmem_using_shm_bridge)
> > > > +           return;
> > > > +
> > > > +   qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
> > > > +   kfree(handle);
> > > > +}
> > > > +
> > > > +#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
> > > >
> > > >  /**
> > > >   * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> > > > --
> > > > 2.39.2
> > > >
> >
> 

