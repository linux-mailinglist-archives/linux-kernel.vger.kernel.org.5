Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28F87C5E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbjJKUOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjJKUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6A90
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697055238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYit+PDu9PL4z4YO7eZa6nfZUOBQU0KXacY8Uj59d+o=;
        b=V2niZ/P+BxKNV1zqdo0CcSeb+xh93jDXI+ZWjzUUMk3niN0ylxgkZnvkc2SnzQ985IuXru
        TO9DZ50MeL13Tc017Yzzparhw7zl0XbhbrvICEDrr6c3KgHJSj4xoQuFJHelRpvHFvN8+/
        WuzMwlsGbY9NHZDY9zUvYTkuQ7g2q3s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-RLwmt8a6OhS0w5Zzx9EbCA-1; Wed, 11 Oct 2023 16:13:47 -0400
X-MC-Unique: RLwmt8a6OhS0w5Zzx9EbCA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7740c0e88ffso24714585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697055226; x=1697660026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYit+PDu9PL4z4YO7eZa6nfZUOBQU0KXacY8Uj59d+o=;
        b=boWsB+TvLdepncMSvmkCxnUb5uf+VUW1nUKNmyGbYt+Qo80KI6a/YH01fOqJMCwNgF
         /1WJksF/xR+ozLbDhdErS9CWXwrg+9YQVOp0HceF9JID+Avw5PJdeIMIDRWUd6tKgpwW
         DzY+a8nRF+ET3QArPtVq0gsBL4wdf+flFwXSCMJp3dUJYaeGg2IZX2ChhmE/nLSZ/lVP
         CrwU+EvqlmJOaFQU6nlq4zj491oUzsToiQucCTQR6i+lbV5/BTatLH3qap4LjGKndFuz
         pLYJhyD7YTiy5OLIg71zWa26zm19gRGAx6mQPFEv+0CSOuDdkBDx2WHzuWB+NPZOQd0M
         NdUg==
X-Gm-Message-State: AOJu0YzO6YFypMKQZCRggKbXNVYrj2uyk6iss+cwDae2BDEpvgCFbxKW
        ED9SdPjgCuQ0iRmOh2lfSBOx/Fe3Psr4p5z4Tc3lwRO3vN6cdvMS4RhfpEnWT4hoUsura9Od0ka
        Jsgg5hB0//PDvqmrQQ/s+OADzRyfjz1DF
X-Received: by 2002:a05:620a:1da4:b0:774:2e8a:ccc6 with SMTP id pj36-20020a05620a1da400b007742e8accc6mr20969916qkn.32.1697055226653;
        Wed, 11 Oct 2023 13:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3gduk370dapNuDdUw/KKVll6KhLtRpucqRY7dFPOFVLxAyKy6n5IZWNdLd+zVDz6btUrMpQ==
X-Received: by 2002:a05:620a:1da4:b0:774:2e8a:ccc6 with SMTP id pj36-20020a05620a1da400b007742e8accc6mr20969892qkn.32.1697055226350;
        Wed, 11 Oct 2023 13:13:46 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id os22-20020a05620a811600b007757acf488esm5473106qkn.39.2023.10.11.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:13:46 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:13:43 -0500
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
Message-ID: <3tguyivqgoovzil7mqivkyx5n5n27qnwqh36dvz36s46vgqd7s@qi6zqxj5pswk>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-8-brgl@bgdev.pl>
 <v5ty4xeshodjlpyatqlrjipqejazamuhqhauorujveyqzpikoq@rftlvk6354yx>
 <CAMRc=MdGABGa_bc3_ug+iSKtMg9pcKe40F7zv9Ff2C0ed8i2=Q@mail.gmail.com>
 <nq6m3v2wflhv5qgxtllympnzqtbtcn7d7ihgw5rdpvqjugv2xs@4vpuzoopkeic>
 <CAMRc=MdO3ctA-g=VVhXp9QKPdUT1XX0iEKTzEKzHjNzh_=-jPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdO3ctA-g=VVhXp9QKPdUT1XX0iEKTzEKzHjNzh_=-jPQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 04:33:53PM +0200, Bartosz Golaszewski wrote:
> On Wed, Oct 11, 2023 at 3:54 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Wed, Oct 11, 2023 at 09:41:49AM +0200, Bartosz Golaszewski wrote:
> > > On Wed, Oct 11, 2023 at 12:19 AM Andrew Halaney <ahalaney@redhat.com> wrote:
> > > >
> > > > On Mon, Oct 09, 2023 at 05:34:19PM +0200, Bartosz Golaszewski wrote:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > Let's use the new TZ memory allocator to obtain a buffer for this call
> > > > > instead of using dma_alloc_coherent().
> > > > >
> > > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > ---
> > > > >  drivers/firmware/qcom/qcom_scm.c | 10 ++++++----
> > > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > > > > index 71e98b666391..754f6056b99f 100644
> > > > > --- a/drivers/firmware/qcom/qcom_scm.c
> > > > > +++ b/drivers/firmware/qcom/qcom_scm.c
> > > > > @@ -4,6 +4,7 @@
> > > > >   */
> > > > >
> > > > >  #include <linux/arm-smccc.h>
> > > > > +#include <linux/cleanup.h>
> > > > >  #include <linux/clk.h>
> > > > >  #include <linux/completion.h>
> > > > >  #include <linux/cpumask.h>
> > > > > @@ -998,14 +999,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > > > >       struct qcom_scm_mem_map_info *mem_to_map;
> > > > >       phys_addr_t mem_to_map_phys;
> > > > >       phys_addr_t dest_phys;
> > > > > -     dma_addr_t ptr_phys;
> > > > > +     phys_addr_t ptr_phys;
> > > > >       size_t mem_to_map_sz;
> > > > >       size_t dest_sz;
> > > > >       size_t src_sz;
> > > > >       size_t ptr_sz;
> > > > >       int next_vm;
> > > > >       __le32 *src;
> > > > > -     void *ptr;
> > > >
> > > > nit: couldn't you keep this up here?
> > > >
> > >
> > > This still needs to make its way into the coding style guide but I got
> > > yelled at by Linus Torvalds personally for not declaring the managed
> > > variables where they are initialized. So this is the correct approach.
> >
> > I'm being a stick in the mud, but couldn't you initialize to NULL and
> > keep them all up top? That seems more in line with the current "declare
> > all variables at the start of function" guideline the kernel follows.
> >
> > Not a big deal... yours call! but /me shrugs
> >
> 
> I agree with you but it's not my call to make. Please see[1].
> 

Yeah, I see you're following the guidance there (declare + initialize
together unless there's a conditional, etc, preventing that) in this
series. Thanks for the pointer.

> Bartosz
> 
> [1] https://lore.kernel.org/lkml/20230919193516.GA20937@noisy.programming.kicks-ass.net/T/#m7f97e10dbfde777f58493398a77933e6a2f3c15d
> 
> > >
> > > Bart
> > >
> > > > Otherwise,
> > > >
> > > > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > > >
> > > > >       int ret, i, b;
> > > > >       u64 srcvm_bits = *srcvm;
> > > > >
> > > > > @@ -1015,10 +1015,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > > > >       ptr_sz = ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
> > > > >                       ALIGN(dest_sz, SZ_64);
> > > > >
> > > > > -     ptr = dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
> > > > > +     void *ptr __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
> > > > > +                                                     ptr_sz, GFP_KERNEL);
> > > > >       if (!ptr)
> > > > >               return -ENOMEM;
> > > > >
> > > > > +     ptr_phys = qcom_tzmem_to_phys(ptr);
> > > > > +
> > > > >       /* Fill source vmid detail */
> > > > >       src = ptr;
> > > > >       i = 0;
> > > > > @@ -1047,7 +1050,6 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > > > >
> > > > >       ret = __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, mem_to_map_sz,
> > > > >                                   ptr_phys, src_sz, dest_phys, dest_sz);
> > > > > -     dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_phys);
> > > > >       if (ret) {
> > > > >               dev_err(__scm->dev,
> > > > >                       "Assign memory protection call failed %d\n", ret);
> > > > > --
> > > > > 2.39.2
> > > > >
> > > >
> > >
> >
> 

