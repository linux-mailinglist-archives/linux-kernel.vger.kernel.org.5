Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7143D80FA71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377810AbjLLWVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377795AbjLLWVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:21:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C917ECF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702419712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8IvIEyGhLX3zR8XVMbk2xgzCAlPgW6m04dxsYOaRvxs=;
        b=BLam4sxK+GA0X8zJpalJeC+MFgG0fJtXCkP8NZl5jHLkAOMdB1hhjCn9W7FdY91WV0PYlp
        ONHrSdWyWgj4zwLP99zqPQpoOBsdZBoj/vqG8LhdB8B9KI3R9yN4L2PqTBO+GPjMt9Bnh9
        7swptQA5JXmTzSrEj8TIfaptqKchEEc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-KL9pq91fPiid1_y1sPN5TA-1; Tue, 12 Dec 2023 17:21:50 -0500
X-MC-Unique: KL9pq91fPiid1_y1sPN5TA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4257de8a5f4so79992071cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419710; x=1703024510;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IvIEyGhLX3zR8XVMbk2xgzCAlPgW6m04dxsYOaRvxs=;
        b=Nsk8Ff60jCtH0LXJYg8KmMRq2db7DkgGNUo7H/uQeP0WUeqL1dJDLj34oqZMLHGQV1
         eD1v73tNYw2cVPchR/By+jaBKKWcgyOf02JYVC/LxnkgPPpYAayJoe46j8HqdoV2sKMF
         uCueF9Ylw6AuG5bnI8+IojGcJHo6tujrFf1vJiBLqr3/9vSlgk2w40ovp3ia9sf3SPgQ
         Z3VSfU/e83h5swV0swuG0vWTGObgQa1qOOaKr/1yKu6O94ZOMhADXpv6eQVbncJLvEPx
         5/jkeC+N90DXGMJUJQjAu3bup/9Djy7pRXweS4pldO49qe4ibhv0NR5QDvVVCFACEQlf
         IZtQ==
X-Gm-Message-State: AOJu0YydBvgIdphwgsjxAIwP9kKc/2sn64HTgq6BQaPGZIXDJry5TygH
        qIUQiy+d7vVhf67gXkfcduFiD1Oll8wJ1DYcb4iguk2zSqLGvYrdYsGQdqgvPkc33pp0fZRc9W3
        DShhGTM+Z9QkWEJmiq+6Jtugg
X-Received: by 2002:a05:622a:1895:b0:425:a982:b5f5 with SMTP id v21-20020a05622a189500b00425a982b5f5mr10706476qtc.94.1702419710143;
        Tue, 12 Dec 2023 14:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECTJZMp8xy1O7K0wkag8Kqd2mbp3y/3RMkuyq4/BznjN3N6oXuue/c4cN/d7/GbsmXnoppzQ==
X-Received: by 2002:a05:622a:1895:b0:425:a982:b5f5 with SMTP id v21-20020a05622a189500b00425a982b5f5mr10706468qtc.94.1702419709818;
        Tue, 12 Dec 2023 14:21:49 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id t11-20020ac86a0b000000b00423b8a53641sm4400791qtr.29.2023.12.12.14.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:21:49 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:21:47 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] soc: qcom: pmic_pdcharger_ulog: Search current
 directory for headers
Message-ID: <qwp3lspu2k4awtn36jebslxqqstmtkoey2a2wnh5pstxbqhko5@i3ktuplsnkir>
References: <20231205-pmicpdcharger-ulog-fixups-v1-0-71c95162cb84@redhat.com>
 <20231205-pmicpdcharger-ulog-fixups-v1-1-71c95162cb84@redhat.com>
 <320864f5-fdd2-4345-a0dd-b97bcf17f473@linaro.org>
 <k77ayy4xwlnghjefvw3yl4aenwyq272pezjaazx65bvdle37et@5fnbae4fxnjz>
 <zwzpbhcb4ggs3kdf72jvjlpe5cpa26vbjs6qw4nyedhcgwcrza@67in3h243yyx>
 <139f9af0-ca6a-4a58-ae18-79ef6fac47e3@linaro.org>
 <cea465e6-ff24-4552-b4f6-a0594ea9ea6c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cea465e6-ff24-4552-b4f6-a0594ea9ea6c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 08:21:41PM +0100, Neil Armstrong wrote:
> On 12/12/2023 17:52, Neil Armstrong wrote:
> > On 12/12/2023 17:15, Andrew Halaney wrote:
> > > On Tue, Dec 12, 2023 at 09:54:48AM -0600, Andrew Halaney wrote:
> > > > On Tue, Dec 12, 2023 at 04:23:20PM +0100, Neil Armstrong wrote:
> > > > > Hi Andrew,
> > > > > 
> > > > > On 06/12/2023 00:05, Andrew Halaney wrote:
> > > > > > As specified in samples/trace_events/Makefile:
> > > > > > 
> > > > > >       If you include a trace header outside of include/trace/events
> > > > > >       then the file that does the #define CREATE_TRACE_POINTS must
> > > > > >       have that tracer file in its main search path. This is because
> > > > > >       define_trace.h will include it, and must be able to find it from
> > > > > >       the include/trace directory.
> > > > > > 
> > > > > > Without this the following compilation error is seen:
> > > > > > 
> > > > > >         CC      drivers/soc/qcom/pmic_pdcharger_ulog.o
> > > > > >       In file included from drivers/soc/qcom/pmic_pdcharger_ulog.h:36,
> > > > > >                        from drivers/soc/qcom/pmic_pdcharger_ulog.c:15:
> > > > > >       ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.h: No such file or directory
> > > > > >          95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > > > > >             |                                          ^
> > > > > >       compilation terminated.
> > > > > 
> > > > > I never experienced such error, and no CI even reported it, can you explain how you got this ?
> > > > 
> > > > To be honest, I am unsure why I'm experiencing this (and until I saw
> > > > another thread about it today I thought maybe I had screwed something
> > > > up!).
> > > > 
> > > > I just took it as an opportunity to try and read up on the tracing
> > > > infrastructure and sent this series. Definitely no expertise with the
> > > > in's and out's of tracing :)
> > > > 
> > > > I'm able to reproduce this on next-20231211:
> > > > 
> > > >      ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make mrproper
> > > >      <snip>
> > > >      ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig
> > > >      <snip>
> > > >      *** Default configuration is based on 'defconfig'
> > > >      #
> > > >      # configuration written to .config
> > > >      #
> > > 
> > > Realized I missed a step, actually enabling tracing and the driver at
> > > play here... but the result is the same.
> > > 
> > > Attached is a config where I hit this.
> > > 
> > > >      130 ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make drivers/soc/qcom/pmic_pdcharger_ulog.o
> > > >        HOSTCC  scripts/dtc/dtc.o
> > > >      <snip>
> > > >        CC      drivers/soc/qcom/pmic_pdcharger_ulog.o
> > > >      In file included from drivers/soc/qcom/pmic_pdcharger_ulog.h:36,
> > > >              from drivers/soc/qcom/pmic_pdcharger_ulog.c:15:
> > > >      ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.h: No such file or directory
> > > >         95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > > >      <snip>
> > > >      2 ahalaney@fedora ~/git/linux-next (git)-[b4/b4-stmmac-handle-mdio-enodev] %
> > > > 
> > > > I even tried it in a fedora container with the above build commands and
> > > > the following podman invocation (plus some package installs) and saw the error:
> > > > 
> > > >      podman run -it -v ~/git/linux-next:/linux-next:z quay.io/fedora/fedora:latest /bin/bash
> > > > 
> > > > So I'm unsure if it's a fedora package version thing (which I'm running on my host)
> > > > or something else... Once I saw it was sort of spelled out in the
> > > > examples I referenced here I just decided it was something needed
> > > > fixing, regardless of why I'm hitting it while others seem ok.
> > 
> > Interesting, I don't get the problem with the same tag, same .config but with gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu
> > 
> > I'll try with gcc 13.
> 
> Ok tried with ARM's arm-gnu-toolchain-13.2.rel1-x86_64-aarch64-none-linux-gnu (https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads),
> and no error, and I even tried with https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/ and same no error...

Hmm. I'm unsure what's up. I tried with a debian container and a fresh
clone and still saw it :/

If you want, something like (swap docker for podman if that's your
thing): podman run -it debian:latest /bin/bash
should let you reproduce after cloning etc.

> 
> Neil
> 
> > 
> > Neil
> > 
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Neil
> > > > > 
> > > > > > 
> > > > > > Fixes: 086fdb48bc65 ("soc: qcom: add ADSP PDCharger ULOG driver")
> > > > > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > > > > ---
> > > > > >    drivers/soc/qcom/Makefile | 1 +
> > > > > >    1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> > > > > > index 110108e23669..05b3d54e8dc9 100644
> > > > > > --- a/drivers/soc/qcom/Makefile
> > > > > > +++ b/drivers/soc/qcom/Makefile
> > > > > > @@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_PDR_HELPERS)    += pdr_interface.o
> > > > > >    obj-$(CONFIG_QCOM_PMIC_GLINK)    += pmic_glink.o
> > > > > >    obj-$(CONFIG_QCOM_PMIC_GLINK)    += pmic_glink_altmode.o
> > > > > >    obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)    += pmic_pdcharger_ulog.o
> > > > > > +CFLAGS_pmic_pdcharger_ulog.o    :=  -I$(src)
> > > > > >    obj-$(CONFIG_QCOM_QMI_HELPERS)    += qmi_helpers.o
> > > > > >    qmi_helpers-y    += qmi_encdec.o qmi_interface.o
> > > > > >    obj-$(CONFIG_QCOM_RAMP_CTRL)    += ramp_controller.o
> > > > > > 
> > > > > 
> > 
> 

