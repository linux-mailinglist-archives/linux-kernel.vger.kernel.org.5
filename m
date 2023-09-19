Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181687A6803
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjISPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjISPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:25:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD27510F5;
        Tue, 19 Sep 2023 08:25:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93117C433C7;
        Tue, 19 Sep 2023 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695137102;
        bh=UMaEZIFSrDtCcr7xQGKlCv23NQcUwkNGSeXgHyAqyxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xlcms9WkXoNfIxR1Jj75ZuDJbSHOYZ3qO81WtPq3Lmwg01dh7zjhSa0IGmkZFthBJ
         N5+AlM9bc2iP6K6bM74JuwMgD/zhv5eI3r7BmQe+GXFcuBLGwMmvABhnaEO0mfIWOV
         0d0xqiLjhx+5vuyHHzGNw9c8qfF9sfeJs3qJ7PloVzZzrxwsjdpy627YE4u3vttAS1
         p94VPYbt9/ZL4h2qXNjwewvRi0zFA+PZ36+Oro4Y0c8Sd5g1knfZUyd8VoPDAtWBdC
         uuixBJvLClIzCA2cfSXvEcursxLIuYDyUM8H5zaJueLjyU2RGV2B/ntm3m7Ts0ezUh
         2Nnljwf06Jl5Q==
Date:   Tue, 19 Sep 2023 08:29:11 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] firmware: qcom_scm: use the SCM_CONVENTION based on
 ARM / ARM64
Message-ID: <ww5rr5okemzevgdvueok5k5uaqakmqdtdtjtw4jur2cdgfsep7@hz2y7qfat5jv>
References: <20230607045345.25049-1-quic_kathirav@quicinc.com>
 <rzxxoofebcyuoktsl72diwv575md62bxqse4uizfns247gyklp@tdoixme3qrjq>
 <CAA8EJprVQZXXVnNCULDYeUha0-mSyLZr1r6axbmw1MUiP_O9zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprVQZXXVnNCULDYeUha0-mSyLZr1r6axbmw1MUiP_O9zg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:10:32PM +0300, Dmitry Baryshkov wrote:
> On Fri, 15 Sept 2023 at 18:17, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Wed, Jun 07, 2023 at 10:23:45AM +0530, Kathiravan T wrote:
> > > During SCM probe, to identify the SCM convention, scm call is made with
> > > SMC_CONVENTION_ARM_64 followed by SMC_CONVENTION_ARM_32. Based on the
> > > result what convention to be used is decided.
> > >
> > > IPQ chipsets starting from IPQ807x, supports both 32bit and 64bit kernel
> > > variants, however TZ firmware runs in 64bit mode. When running on 32bit
> > > kernel, scm call is made with SMC_CONVENTION_ARM_64 is causing the
> > > system crash, due to the difference in the register sets between ARM and
> > > AARCH64, which is accessed by the TZ.
> > >
> > > To avoid this, use SMC_CONVENTION_ARM_64 only on ARM64 builds.
> > >
> >
> > My memory of this is cloudy, but I feel the logic is complicated because
> > early 64-bit boards all used 32-bit TZ. So, I really would like Elliot's
> > input before picking this change.
> 
> But this codepath is not changed by this patch. Only the 32-bit
> codepath is altered.
> 

Ohh, you're right, sorry about that. Would still be nice to see some
feedback from the team here...


The commit message is talking about the convention check crashing the
system, the only part of the convention checker that seems to matter to
me is the "calling convention" bit in the smc call.

Per the "SMC calling convention specification", the 64-bit calling
convention bit can only be used when the client is 64-bit. So perhaps
this is the actual problem?

Beyond that, another practical problem I can see is if we pass more than
4 arguments to a call the layout of the extra arguments will not match
between the two worlds (as Linux will pass an array of unsigned long).


With this in mind, I'd like the commit message to be more specific.

Afaict, this is not an issue with the convention detection, but rather
the invalid to call __scm_smc_call() with 64-bit convention on a 32-bit
system. Working around this by having an undocumented #if ARM64 in
another part of the driver isn't clear enough, IMHO.

Moving the check to __scm_smc_call(), or at least documenting the
behavior there (and next to the #if) seems reasonable.

Regards,
Bjorn


> >
> > Regards,
> > Bjorn
> >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
> > > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > > ---
> > > Changes in V2:
> > >       - Added the Fixes tag and cc'd stable mailing list
> > >
> > >  drivers/firmware/qcom_scm.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > > index fde33acd46b7..db6754db48a0 100644
> > > --- a/drivers/firmware/qcom_scm.c
> > > +++ b/drivers/firmware/qcom_scm.c
> > > @@ -171,6 +171,7 @@ static enum qcom_scm_convention __get_convention(void)
> > >       if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
> > >               return qcom_scm_convention;
> > >
> > > +#if IS_ENABLED(CONFIG_ARM64)
> > >       /*
> > >        * Device isn't required as there is only one argument - no device
> > >        * needed to dma_map_single to secure world
> > > @@ -191,6 +192,7 @@ static enum qcom_scm_convention __get_convention(void)
> > >               forced = true;
> > >               goto found;
> > >       }
> > > +#endif
> > >
> > >       probed_convention = SMC_CONVENTION_ARM_32;
> > >       ret = __scm_smc_call(NULL, &desc, probed_convention, &res, true);
> > > --
> > > 2.17.1
> > >
> 
> 
> 
> -- 
> With best wishes
> Dmitry
