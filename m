Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91196779CE7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 05:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjHLDBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 23:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjHLDBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 23:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D7530E8;
        Fri, 11 Aug 2023 20:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0372F63C60;
        Sat, 12 Aug 2023 03:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AB6C433C8;
        Sat, 12 Aug 2023 03:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691809278;
        bh=l/yGOkqsa8kjqG7Q1FQDe6y3BvLBuVJGICeXb/Wg5U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCxyEaxofwKOYu++aRE8JA4T/q7hFz1Tm2cqdaSq9C7IwL4TLoD0hSX5PzqUZAmwg
         AQ0Orhh4RIGvEvJ6/RFNlRgS7xqfH8+sGkTzSsaKvnFkoXkwhdIXZ0b8PYtK/wPGqx
         EsIB3TgiTWUiUH5BxyBCLAxc3x5BX23OdMPz/M/0w4M7PwEbvYQ1JzmcMWxjAQ3aGG
         rlT/VwdIFSJ2VL1x5XgG6V5SuIk/Dm0DK4s4NXDqgdJvsXZdGhcAHR/SDMhVphAJn2
         eBy1ORPaoHqfZ+1QGnWQaNa6MHgcMjZpSJMMBRqi/XvMCd2So6840O0lwUh0t58MBk
         7FjJZ/kVIKA/w==
Date:   Fri, 11 Aug 2023 20:01:16 -0700
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
Subject: Re: [PATCH v2 0/6] Add support for Texas Instruments MCRC64 engine
Message-ID: <20230812030116.GF971@sol.localdomain>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:58:47AM +0530, Kamlesh Gurudasani wrote:
> Add support for MCRC64 engine to calculate 64-bit CRC in Full-CPU mode
> 
> MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
> according to the ISO 3309 standard.
> 
> The ISO 3309 64-bit CRC model parameters are as follows:
>     Generator Polynomial: x^64 + x^4 + x^3 + x + 1
>     Polynomial Value: 0x000000000000001B
>     Initial value: 0x0000000000000000
>     Reflected Input: False
>     Reflected Output: False
>     Xor Final: 0x0000000000000000
> 
> Tested with
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> 
> and tcrypt,
> sudo modprobe tcrypt mode=329 sec=1
> 
> User space application implemented using algif_hash,
> https://gist.github.com/ti-kamlesh/73abfcc1a33318bb3b199d36b6209e59
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>

I do not see any in-kernel user of this CRC variant being introduced, which
leaves algif_hash as the only use case.

Can you elaborate on the benefit this brings to your application?  Yes, it
allows you to use your hardware CRC engine.  But, that comes with all the
overhead from the syscalls, algif_hash, and the driver.  How does performance
compare to a properly optimized software CRC implementation on your platform,
i.e. an implementation using carryless multiplication instructions (e.g. ARMv8
CE) if available on your platform, otherwise an implementation using the
slice-by-8 or slice-by-16 method?

- Eric
