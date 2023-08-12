Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10B779CCA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 04:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjHLCzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 22:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHLCzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E65630E8;
        Fri, 11 Aug 2023 19:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8F7A6131D;
        Sat, 12 Aug 2023 02:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8815C433C7;
        Sat, 12 Aug 2023 02:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691808922;
        bh=8xhMi8cCxfgXnMrPb750nSrQBcgTHJS5NlxPxURCcW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDtF4baCkmTYqMhnD6jEUxmemiA2ZKrOgocYikKT2OcRX4Rkymkte02ADgwxauQIb
         b687ULIO7ZD8Uxqeb/UM1lR3ahx2gCrv/V0ANfZJrDwanBUfu9hNbZUOvopmBoUrSz
         VASQEYNoZb7LbAjB1MO5NvarJzr+BxM3TWWAmx60GxD9lNuAp5rFBgWT6pWti/d1RX
         KkTAJoh8aXOvA8d30tYlpkOWgBgn8Gp1RpQJ9ufhEsNNMLYtuY7xEMJm19/r4j1u/k
         vuGTm3ihEgbffmvmvKxUoGjFeDedH3F1+HcavQRT+KG179e/pCatY7gm8ETRGxEosS
         b6Os7KV70F0vQ==
Date:   Fri, 11 Aug 2023 19:55:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kamlesh Gurudasani <kamlesh@ti.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 2/6] crypto: crc64 - add crc64-iso framework
Message-ID: <20230812025520.GE971@sol.localdomain>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
 <20230719-mcrc-upstream-v2-2-4152b987e4c2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719-mcrc-upstream-v2-2-4152b987e4c2@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:58:49AM +0530, Kamlesh Gurudasani wrote:
> diff --git a/include/linux/crc64.h b/include/linux/crc64.h
> index 70202da51c2c..10b792080374 100644
> --- a/include/linux/crc64.h
> +++ b/include/linux/crc64.h
> @@ -8,11 +8,15 @@
>  #include <linux/types.h>
>  
>  #define CRC64_ROCKSOFT_STRING "crc64-rocksoft"
> +#define CRC64_ISO_STRING "crc64-iso"
>  
>  u64 __pure crc64_be(u64 crc, const void *p, size_t len);
>  u64 __pure crc64_iso_generic(u64 crc, const void *p, size_t len);
>  u64 __pure crc64_rocksoft_generic(u64 crc, const void *p, size_t len);
>  
> +u64 crc64_iso(const unsigned char *buffer, size_t len);
> +u64 crc64_iso_update(u64 crc, const unsigned char *buffer, size_t len);
> +
>  u64 crc64_rocksoft(const unsigned char *buffer, size_t len);
>  u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len);

Is "crc64-iso" clear enough, or should it be "crc64-iso3309"?  There are
thousands of ISO standards.  Different CRC variants are specified by different
ISO standards.  Is this particular variant indeed commonly referred to as simply
the "ISO" CRC-64?  Even if it's currently the case that all other CRCs in ISO
standards are different widths than 64 bits (which may be unlikely?), I'm not
sure we should count on no CRC-64 variant ever being standardized by ISO.

- Eric
