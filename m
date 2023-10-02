Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAA67B53E1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbjJBNZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjJBNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BACB3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696253056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KviN0X/RCx/xPsHBoxNjf84tjjuoc20Hd49jrGxldSk=;
        b=gyvTOujIbu2/H76jJ0l3Q/AXzX04wzFG/bqahMNusfYb8nWr45KYaD47VVKTnGgaW8OOBN
        6nMyUIAilA2UlLqtDIshruJtHl+mPqLjITsf45l5V+KDSWxnwI4fWq6WjdGAHr4/EoJDPH
        ACWiRN6x5ga4BpE+nB/pP52MD/xPZaM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-X2omKhzRPfig3rQzC3OJuQ-1; Mon, 02 Oct 2023 09:24:13 -0400
X-MC-Unique: X2omKhzRPfig3rQzC3OJuQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3af64a4c931so7511058b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 06:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696253052; x=1696857852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KviN0X/RCx/xPsHBoxNjf84tjjuoc20Hd49jrGxldSk=;
        b=nSkyrs7VjggJnZONfD3zwbgD0ZLxzvH3r2zM13dM2Qbab4Xg8xnMiFkkTMIqNnIujU
         C9nWHnrtetWdAK3nQ8bferuOTk1wRThJ/Ng9mM9mw9e4dM3mrpc/FLhFjBtkcT52pi3g
         cKdJGGJdRxtsIj2Pryo0G/9GXZZaoIhR2MIpVyoxY8dBNenow4HSFHVitZin3TlOWNeb
         UnD+WD963tcAhTBJ0zHhKCylVfKJfNu/w6S4gkHvl/af/buJHbkw8Q0MhVk47nvEdYfN
         hHqUlV1uoaWT0grttFYOHQr2ivgrsJj65EpRfNQsGKqqtmOnBxGxhr4/qeqN8d/t2/Vp
         iJBA==
X-Gm-Message-State: AOJu0YzhMLDlBTgB6yjmVTv7gVdFiV3tmYrlF71y4dlLgqDDVC811plo
        HVme3sgDRaymWWW20amQvnD+mWRBfJfeAEw4pE9pCIVmN2QiT2cq+f0b4VfU5eiHWSq90z5whg4
        mtfyAQbfibER0Suj8qoaW9ewA
X-Received: by 2002:a05:6808:309c:b0:3ab:84f0:b491 with SMTP id bl28-20020a056808309c00b003ab84f0b491mr14899218oib.19.1696253052512;
        Mon, 02 Oct 2023 06:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNYuViafwDqus6MokKeZpafc4TpjWvt/q4KRQ8mzGcIJB5yeDpFD4cy3LJZRgwtWeWRw2zNA==
X-Received: by 2002:a05:6808:309c:b0:3ab:84f0:b491 with SMTP id bl28-20020a056808309c00b003ab84f0b491mr14899186oib.19.1696253051886;
        Mon, 02 Oct 2023 06:24:11 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id c15-20020a0cf2cf000000b0065d05c8bb5dsm3775747qvm.64.2023.10.02.06.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:24:11 -0700 (PDT)
Date:   Mon, 2 Oct 2023 08:24:09 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 06/11] firmware: qcom: scm: make
 qcom_scm_pas_init_image() use the SCM allocator
Message-ID: <5puhrnpw2rww6kawt77krges6aj4re6nfblqkomuw5njtwydya@cuarfakzv62i>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <20230928092040.9420-7-brgl@bgdev.pl>
 <gwflmag5pq7osprj25l7i4tgyln2nauuqcwdhth2eomareooag@4dw4lwk4vr36>
 <CAMRc=Mfxt1DLinxMcKivQqqnHvFv5P8WXNnfAwnfrHgoz+q-5w@mail.gmail.com>
 <20230929204404.enzsjanohdqqpmk4@halaney-x13s>
 <2539186e-e0ec-4eba-9d6a-d966e00f0eb9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2539186e-e0ec-4eba-9d6a-d966e00f0eb9@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 03:48:37PM -0700, Elliot Berman wrote:
> Hi Andrew,
> 
> On 9/29/2023 1:44 PM, Andrew Halaney wrote:
> > On Fri, Sep 29, 2023 at 12:22:16PM -0700, Bartosz Golaszewski wrote:
> >> On Fri, 29 Sep 2023 21:16:51 +0200, Andrew Halaney <ahalaney@redhat.com> said:
> >>> On Thu, Sep 28, 2023 at 11:20:35AM +0200, Bartosz Golaszewski wrote:
> >>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>
> >>>> Let's use the new SCM memory allocator to obtain a buffer for this call
> >>>> instead of using dma_alloc_coherent().
> >>>>
> >>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>> ---
> >>>>  drivers/firmware/qcom/qcom_scm.c | 16 +++++-----------
> >>>>  1 file changed, 5 insertions(+), 11 deletions(-)
> >>>>
> >>>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> >>>> index 02a773ba1383..c0eb81069847 100644
> >>>> --- a/drivers/firmware/qcom/qcom_scm.c
> >>>> +++ b/drivers/firmware/qcom/qcom_scm.c
> >>>> @@ -532,7 +532,7 @@ static void qcom_scm_set_download_mode(bool enable)
> >>>>  int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
> >>>>  			    struct qcom_scm_pas_metadata *ctx)
> >>>>  {
> >>>> -	dma_addr_t mdata_phys;
> >>>> +	phys_addr_t mdata_phys;
> >>>
> >>>>  	void *mdata_buf;
> >>>>  	int ret;
> >>>>  	struct qcom_scm_desc desc = {
> >>>> @@ -544,13 +544,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
> >>>>  	};
> >>>>  	struct qcom_scm_res res;
> >>>>
> >>>> -	/*
> >>>> -	 * During the scm call memory protection will be enabled for the meta
> >>>> -	 * data blob, so make sure it's physically contiguous, 4K aligned and
> >>>> -	 * non-cachable to avoid XPU violations.
> >>>> -	 */
> >>>> -	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
> >>>> -				       GFP_KERNEL);
> >>>> +	mdata_buf = qcom_scm_mem_alloc(size, GFP_KERNEL);
> >>>
> >>> mdata_phys is never initialized now, and its what's being shoved into
> >>> desc.args[1] later, which I believe is what triggered the -EINVAL
> >>> with qcom_scm_call() that I reported in my cover letter reply this
> >>> morning.
> >>>
> >>> Prior with the DMA API that would have been the device view of the buffer.
> >>>
> >>
> >> Gah! Thanks for finding this.
> >>
> >> Can you try the following diff?
> >>
> >> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> >> index 794388c3212f..b0d4ea237034 100644
> >> --- a/drivers/firmware/qcom/qcom_scm.c
> >> +++ b/drivers/firmware/qcom/qcom_scm.c
> >> @@ -556,6 +556,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const
> >> void *metadata, size_t size,
> >>  		dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
> >>  		return -ENOMEM;
> >>  	}
> >> +	mdata_phys = qcom_scm_mem_to_phys(mdata_buf);
> >>  	memcpy(mdata_buf, metadata, size);
> >>
> >>  	ret = qcom_scm_clk_enable();
> >> @@ -578,7 +579,7 @@ int qcom_scm_pas_init_image(u32 peripheral, const
> >> void *metadata, size_t size,
> >>  		qcom_scm_mem_free(mdata_buf);
> >>  	} else if (ctx) {
> >>  		ctx->ptr = mdata_buf;
> >> -		ctx->phys = qcom_scm_mem_to_phys(mdata_buf);
> >> +		ctx->phys = mdata_phys;
> >>  		ctx->size = size;
> >>  	}
> >>
> >> Bart
> >>
> > 
> > For some reason that I can't explain that is still not working. It seems
> > the SMC call is returning !0 and then we return -EINVAL from there
> > with qcom_scm_remap_error().
> > 
> > Here's a really crummy diff of what I hacked in during lunch to debug (don't
> > judge my primitive debug skills):
> > 
> 
> I don't know what you're talking about :-)
> 
> > diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> > index 0d5554df1321..56eab0ae5f3a 100644
> > --- a/drivers/firmware/qcom/qcom_scm-smc.c
> > +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> > @@ -162,6 +162,8 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
> >         struct arm_smccc_res smc_res;
> >         struct arm_smccc_args smc = {0};
> >  
> > +       dev_err(dev, "%s: %d: We are in this function\n", __func__, __LINE__);
> > +
> >         smc.args[0] = ARM_SMCCC_CALL_VAL(
> >                 smccc_call_type,
> >                 qcom_smccc_convention,
> > @@ -174,6 +176,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
> >         if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
> >                 alloc_len = SCM_SMC_N_EXT_ARGS * sizeof(u64);
> >                 args_virt = qcom_scm_mem_alloc(PAGE_ALIGN(alloc_len), flag);
> > +               dev_err(dev, "%s: %d: Hit the unlikely case!\n", __func__, __LINE__);
> >  
> >                 if (!args_virt)
> >                         return -ENOMEM;
> > @@ -197,6 +200,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
> >  
> >         /* ret error check follows after args_virt cleanup*/
> >         ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
> > +       dev_err(dev, "%s: %d: ret: %d\n", __func__, __LINE__, ret);
> >  
> >         if (ret)
> >                 return ret;
> > @@ -205,8 +209,10 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
> >                 res->result[0] = smc_res.a1;
> >                 res->result[1] = smc_res.a2;
> >                 res->result[2] = smc_res.a3;
> > +               dev_err(dev, "%s: %d: 0: %llu, 1: %llu: 2: %llu\n", __func__, __LINE__, res->result[0], res->result[1], res->result[2]);
> >         }
> >  
> > +       dev_err(dev, "%s: %d: smc_res.a0: %lu\n", __func__, __LINE__, smc_res.a0);
> >         return (long)smc_res.a0 ? qcom_scm_remap_error(smc_res.a0) : 0;
> > 
> > 
> > And that all spams dmesg successfully for most cases, but the
> > pas_init_image calls log this out:
> > 
> > [   16.362965] remoteproc remoteproc1: powering up 1b300000.remoteproc
> > [   16.364897] remoteproc remoteproc1: Booting fw image qcom/sc8280xp/LENOVO/21BX/qccdsp8280.mbn, size 3575808
> > [   16.365009] qcom_scm firmware:scm: __scm_smc_call: 165: We are in this function
> > [   16.365251] qcom_scm firmware:scm: __scm_smc_call: 203: ret: 0
> > [   16.365256] qcom_scm firmware:scm: __scm_smc_call: 212: 0: 0, 1: 0: 2: 0
> > [   16.365261] qcom_scm firmware:scm: __scm_smc_call: 215: smc_res.a0: 4291821558
> > 
> > At the moment I am unsure why...
> > 
> Does the issue appear right after taking patch 6 or does it only appear after taking
> the whole series? If it's just to this patch, then maybe something wrong with
> the refactor: shm bridge isn't enabled at this point in the series.
> 

I've only been testing the series as a whole on top of a 6.6 based
branch, I'm going to try and test some more today to see if just the
allocator bits (but not the SHM bridge enablement) works alright for
me.

Thanks,
Andrew

