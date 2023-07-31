Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42AD769C94
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjGaQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjGaQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6880DF;
        Mon, 31 Jul 2023 09:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D3B61212;
        Mon, 31 Jul 2023 16:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5FAC433C7;
        Mon, 31 Jul 2023 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690821171;
        bh=9APW6kjAiEHu5U4FuEto4YMwT8x/YGo6oRwvtvD7SiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8Bz0h4obauNPZ7sMNXGHjPqUq/cyyXApUk90A/MSRkLEAmzjHzJYuvH/Ww2o4u4s
         jPkB5FD7qQ9kUYIJv19SDXnWvN8XXvlxZzXFgBuf4A2pjUVF8gQNhD2lY3D/2Sp1xE
         CpRoc7SFLc1GZiG4+kF7PMoLtqI5ncSd1EfLUHIKvtOy2eQIVFDj5hNmSuMTHhIv5a
         CdTOSVFsWVQOh3Wnq60SwYSRFOifTdQmQvnAYlyepH3xmgJws7MFdOAgDNXuBa/y0B
         YQI3tW87kRUnddAPm1kLe+TfxHbJc4J1UJZQEhRlXRyKe/tVXnv+GeS/EngU4hqVRO
         hODkDanX4jmTw==
Date:   Mon, 31 Jul 2023 09:35:57 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] nvmem: sec-qfprom: Add Qualcomm secure QFPROM
 support
Message-ID: <wst227b45le3ql6ctkdiyiynae7ipy3gqiz6ibhbxau4bogb5o@w25vnllnwnw7>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-3-quic_kbajaj@quicinc.com>
 <9f417fea-38cf-942b-514e-99b47f27c544@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f417fea-38cf-942b-514e-99b47f27c544@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 12:09:07PM +0530, Mukesh Ojha wrote:
> On 7/24/2023 2:08 PM, Komal Bajaj wrote:
[..]
> > diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> > index f82431ec8aef..e248d3daadf3 100644
> > --- a/drivers/nvmem/Makefile
> > +++ b/drivers/nvmem/Makefile
> > @@ -44,6 +44,8 @@ obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
> >   nvmem-nintendo-otp-y			:= nintendo-otp.o
> >   obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
> >   nvmem_qfprom-y				:= qfprom.o
> > +obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)	+= nvmem_sec_qfprom.o
> > +nvmem_sec_qfprom-y			:= sec-qfprom.o
> 
> Are we just doing this for just renaming the object ?
> 

Correct.

> >   obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
> >   nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
> >   obj-$(CONFIG_NVMEM_RMEM) 		+= nvmem-rmem.o
> > diff --git a/drivers/nvmem/sec-qfprom.c b/drivers/nvmem/sec-qfprom.c
[..]
> > +static int sec_qfprom_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
> > +{
> > +	struct sec_qfprom *priv = context;
> > +	unsigned int i;
> > +	u8 *val = _val;
> > +	u32 read_val;
> > +	u8 *tmp;
> > +
> > +	for (i = 0; i < bytes; i++, reg++) {
> > +		if (i == 0 || reg % 4 == 0) {
> > +			if (qcom_scm_io_readl(priv->base + (reg & ~3), &read_val)) {
> > +				dev_err(priv->dev, "Couldn't access fuse register\n");
> > +				return -EINVAL;
> > +			}
> > +			tmp = (u8 *)&read_val;
> > +		}
> > +
> > +		val[i] = tmp[reg & 3];
> > +	}
> 
> Getting secure read from fuse region is fine here, since we have to read
> 4 byte from trustzone, but this restriction of reading is also there
> for sm8{4|5}50 soc's where byte by byte reading is protected and granularity
> set to 4 byte (qfprom_reg_read() in drivers/nvmem/qfprom.c)
> is will result in abort, in  that case this function need to export this
> logic.
> 

If qfprom needs similar treatment, then let's land this first and then
consider generalizing (i.e. move to some library code) this - or if
infeasible, just fix qfprom_reg_read().

Regards,
Bjorn
