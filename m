Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A877640CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGZU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGZU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:57:33 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB719B6;
        Wed, 26 Jul 2023 13:57:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6864c144897so61843b3a.1;
        Wed, 26 Jul 2023 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690405052; x=1691009852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=40xe9fvFJ9sOsupKilGdDObjo09oxlOirIRg3aGbZbs=;
        b=aghccPiw+p9jl5oj4/mcOtE1wC1J1UAJ2zUK/5yyjyk1dFvroG7sU6HuGwpy9/hvVj
         5jK+Jb3SxNJ5ZQIFHmq3EExt5e9K5UJ4J13mbKBPTqxwJ5djmgPP30A/L6rafMnaawiv
         DHONLr/aScs0ReBeBekOjIRVTu0W3tPcZ4NTpBDC9cMzvmQSp6Y2UdwdNx+LG0E81zy3
         pSBmUU8BFSyB4tjXLaaGKaFvhZbQ836OmdxBiK4bGLRdPL3sbNomzAKelKvSLeV9VEni
         8LzVfDBqMBOw7bIYBmYiiJVZdxrjXfslOoK1xcJxmbJFTcBfwY1JE4AvVf+o8G9CmVUc
         iNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690405052; x=1691009852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40xe9fvFJ9sOsupKilGdDObjo09oxlOirIRg3aGbZbs=;
        b=bOaD0eenVvU/BMrT0WKhsxuTpj7VvCog3wjugE0JBBxveGLeeFSimlnOJERokBSD/R
         JumJFL9VZhfsEp7jHGq2+prcj+iNhJ1OoioZ/yCeEBIZS2XIYSptCJbbFVsNuGffpwZn
         KDz9yad41P14SP27ABd8xFYIZ8EhKjkXjG5ea4G3rqPBe/gUXLYKcXGX5M8nz7s9s8+4
         IrQPB4oDkxGV896D87Q0EgPIcIySbBgSeuf2ouY5Ndd9AJCTHnhBCH0tXzfv/ZT+0zjZ
         xPvNvkFN2ds8M4ZaJqKmvUBZrE5ojVdJBXolG426yGxpXyIItSNjk7mkuilVGnM1gFo6
         J+qw==
X-Gm-Message-State: ABy/qLYKRD2+HmJrrmFJoxF/yP0I7UffzkDnC1Rk+Pd2FX6ELBBRxYD3
        peWjOtSL0OGLQP8+3AYooqQ=
X-Google-Smtp-Source: APBJJlFwOFlKgUr5EHQGcfI4UKTPdcLNmhmJVe7LY3hHHwZO0dDZEIG8OC7wGY1Ci/7PEnT5pj2+sA==
X-Received: by 2002:a05:6a00:4a0e:b0:677:3439:874a with SMTP id do14-20020a056a004a0e00b006773439874amr3577463pfb.3.1690405051983;
        Wed, 26 Jul 2023 13:57:31 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7904a000000b00682c864f35bsm27660pfo.140.2023.07.26.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 13:57:31 -0700 (PDT)
Date:   Wed, 26 Jul 2023 13:57:28 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <ZMGIuKVP7BEotbrn@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:01:31PM +0200, Johannes Zink wrote:

Earlier versions of the IP core return zero from these...

> +#define	PTP_TS_INGR_LAT	0x68	/* MAC internal Ingress Latency */
> +#define	PTP_TS_EGR_LAT	0x6c	/* MAC internal Egress Latency */

and so...

> +static void correct_latency(struct stmmac_priv *priv)
> +{
> +	void __iomem *ioaddr = priv->ptpaddr;
> +	u32 reg_tsic, reg_tsicsns;
> +	u32 reg_tsec, reg_tsecsns;
> +	u64 scaled_ns;
> +	u32 val;
> +
> +	/* MAC-internal ingress latency */
> +	scaled_ns = readl(ioaddr + PTP_TS_INGR_LAT);
> +
> +	/* See section 11.7.2.5.3.1 "Ingress Correction" on page 4001 of
> +	 * i.MX8MP Applications Processor Reference Manual Rev. 1, 06/2021
> +	 */
> +	val = readl(ioaddr + PTP_TCR);
> +	if (val & PTP_TCR_TSCTRLSSR)
> +		/* nanoseconds field is in decimal format with granularity of 1ns/bit */
> +		scaled_ns = ((u64)NSEC_PER_SEC << 16) - scaled_ns;
> +	else
> +		/* nanoseconds field is in binary format with granularity of ~0.466ns/bit */
> +		scaled_ns = ((1ULL << 31) << 16) -
> +			DIV_U64_ROUND_CLOSEST(scaled_ns * PSEC_PER_NSEC, 466U);
> +
> +	reg_tsic = scaled_ns >> 16;
> +	reg_tsicsns = scaled_ns & 0xff00;
> +
> +	/* set bit 31 for 2's compliment */
> +	reg_tsic |= BIT(31);
> +
> +	writel(reg_tsic, ioaddr + PTP_TS_INGR_CORR_NS);

here reg_tsic = 0x80000000 for a correction of -2.15 seconds!

@Jakub  Can you please revert this patch?

Thanks,
Richard
