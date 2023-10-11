Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7D7C55EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjJKNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjJKNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A493
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697032477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xrlMJK0HKaF7VGhnGhdLQ/tjhSDJ2FSBz3+97dLCK6s=;
        b=NzdY454wySF6Ds4PSUSqJCD54NGiZVtRw5iEYiaX/js1rQsi75sT15ECKhtstBwmqrWZig
        oOYplMS0o0MWVgKPx2l2r7SKCkpLhhlKj7p44ahkODlxDSPEQp0SY/ShOFAKX7TD/0mCI0
        25pd9D3UQSeXTegwhSHp6JIwGXg2FnQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665--vkb6D5oPkuQZF0Wa2YkAw-1; Wed, 11 Oct 2023 09:54:36 -0400
X-MC-Unique: -vkb6D5oPkuQZF0Wa2YkAw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5a7ed6903a6so5013827b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697032475; x=1697637275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrlMJK0HKaF7VGhnGhdLQ/tjhSDJ2FSBz3+97dLCK6s=;
        b=DM2CFOWURPyFz221zFRKwewTrhEtFFmPbIU460wYraf8xE+qqjuFYGRHrHdihvh7RS
         EFz/doO7/uwAUqYQd8YiB7P0gU7CeR41BDTRK2wj06BzmVP8GNMKlFbF/KeJOdAFDPUG
         n+Ul49cm4y71ipDPXqXDM0bs4G0oWyNU1rvY7LysWN/eQ99vIvToaC993gsB6UFZFtKA
         hlTmzha2Q535DA9u2+f9qC4/JK6vtuflw2qzAIbUn3dmagWvS1IleYqP1A1poNTXvoEo
         Hk4LUfZ12W9vK6visZ3JiPJV0o+Zfa5PPZVEsSfElP/6s9CmrKxV62gvdQXxW0iFHREL
         AqeQ==
X-Gm-Message-State: AOJu0YzlxaMAaISo1ZSXGG9giDaRRNQ4dQ9y++nBjgL0g9mx0/PZWWkt
        uMXXMknQhRbmwNQ6bf6O6ZTuS2ka0pF/Vx/4Ute7G/U8BnnbAOdtp7CON3Mr/Ly8CFbOwYtzJKk
        WK7ofd5nQ9qAqL+iRHx1siQZk
X-Received: by 2002:a25:8d82:0:b0:d06:4f8a:53d5 with SMTP id o2-20020a258d82000000b00d064f8a53d5mr19381127ybl.1.1697032475255;
        Wed, 11 Oct 2023 06:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO44bCWKWio9yPI2XTbX7B/vxj+w0gjchXofCDSYpbleULrpuMqiXhrHxbDgDlWiqm5rLIKw==
X-Received: by 2002:a25:8d82:0:b0:d06:4f8a:53d5 with SMTP id o2-20020a258d82000000b00d064f8a53d5mr19381105ybl.1.1697032474945;
        Wed, 11 Oct 2023 06:54:34 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id bu15-20020ad455ef000000b0066d04196c39sm735289qvb.81.2023.10.11.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:54:34 -0700 (PDT)
Date:   Wed, 11 Oct 2023 08:54:32 -0500
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
Subject: Re: [PATCH v3 07/15] firmware: qcom: scm: make qcom_scm_assign_mem()
 use the TZ allocator
Message-ID: <nq6m3v2wflhv5qgxtllympnzqtbtcn7d7ihgw5rdpvqjugv2xs@4vpuzoopkeic>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-8-brgl@bgdev.pl>
 <v5ty4xeshodjlpyatqlrjipqejazamuhqhauorujveyqzpikoq@rftlvk6354yx>
 <CAMRc=MdGABGa_bc3_ug+iSKtMg9pcKe40F7zv9Ff2C0ed8i2=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdGABGa_bc3_ug+iSKtMg9pcKe40F7zv9Ff2C0ed8i2=Q@mail.gmail.com>
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

On Wed, Oct 11, 2023 at 09:41:49AM +0200, Bartosz Golaszewski wrote:
> On Wed, Oct 11, 2023 at 12:19 AM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Mon, Oct 09, 2023 at 05:34:19PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Let's use the new TZ memory allocator to obtain a buffer for this call
> > > instead of using dma_alloc_coherent().
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  drivers/firmware/qcom/qcom_scm.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > > index 71e98b666391..754f6056b99f 100644
> > > --- a/drivers/firmware/qcom/qcom_scm.c
> > > +++ b/drivers/firmware/qcom/qcom_scm.c
> > > @@ -4,6 +4,7 @@
> > >   */
> > >
> > >  #include <linux/arm-smccc.h>
> > > +#include <linux/cleanup.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/completion.h>
> > >  #include <linux/cpumask.h>
> > > @@ -998,14 +999,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > >       struct qcom_scm_mem_map_info *mem_to_map;
> > >       phys_addr_t mem_to_map_phys;
> > >       phys_addr_t dest_phys;
> > > -     dma_addr_t ptr_phys;
> > > +     phys_addr_t ptr_phys;
> > >       size_t mem_to_map_sz;
> > >       size_t dest_sz;
> > >       size_t src_sz;
> > >       size_t ptr_sz;
> > >       int next_vm;
> > >       __le32 *src;
> > > -     void *ptr;
> >
> > nit: couldn't you keep this up here?
> >
> 
> This still needs to make its way into the coding style guide but I got
> yelled at by Linus Torvalds personally for not declaring the managed
> variables where they are initialized. So this is the correct approach.

I'm being a stick in the mud, but couldn't you initialize to NULL and
keep them all up top? That seems more in line with the current "declare
all variables at the start of function" guideline the kernel follows.

Not a big deal... yours call! but /me shrugs

> 
> Bart
> 
> > Otherwise,
> >
> > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> >
> > >       int ret, i, b;
> > >       u64 srcvm_bits = *srcvm;
> > >
> > > @@ -1015,10 +1015,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > >       ptr_sz = ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
> > >                       ALIGN(dest_sz, SZ_64);
> > >
> > > -     ptr = dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
> > > +     void *ptr __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
> > > +                                                     ptr_sz, GFP_KERNEL);
> > >       if (!ptr)
> > >               return -ENOMEM;
> > >
> > > +     ptr_phys = qcom_tzmem_to_phys(ptr);
> > > +
> > >       /* Fill source vmid detail */
> > >       src = ptr;
> > >       i = 0;
> > > @@ -1047,7 +1050,6 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > >
> > >       ret = __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, mem_to_map_sz,
> > >                                   ptr_phys, src_sz, dest_phys, dest_sz);
> > > -     dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_phys);
> > >       if (ret) {
> > >               dev_err(__scm->dev,
> > >                       "Assign memory protection call failed %d\n", ret);
> > > --
> > > 2.39.2
> > >
> >
> 

