Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4AC76EFB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjHCQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHCQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80969E4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F4EA61E43
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C345C433C7;
        Thu,  3 Aug 2023 16:39:41 +0000 (UTC)
Date:   Thu, 3 Aug 2023 17:39:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/fpsimd: Only provide the length to cpufeature
 for xCR registers
Message-ID: <ZMvYSmpCfFQ2+m7q@arm.com>
References: <20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:58:48PM +0100, Mark Brown wrote:
> For both SVE and SME we abuse the generic register field comparison
> support in the cpufeature code as part of our detection of unsupported
> variations in the vector lengths available to PEs, reporting the maximum
> vector lengths via ZCR_EL1.LEN and SMCR_EL1.LEN.  Since these are
> configuration registers rather than identification registers the
> assumptions the cpufeature code makes about how unknown bitfields behave
> are invalid, leading to warnings when SME features like FA64 are enabled
> and we hotplug a CPU:
> 
>   CPU features: SANITY CHECK: Unexpected variation in SYS_SMCR_EL1. Boot CPU: 0x0000000000000f, CPU3: 0x0000008000000f
>   CPU features: Unsupported CPU feature variation detected.
> 
> SVE has no controls other than the vector length so is not yet impacted
> but the same issue will apply there if any are defined.
> 
> Since the only field we are interested in having the cpufeature code
> handle is the length field and we use a custom read function to obtain
> the value we can avoid these warnings by filtering out all other bits
> when we return the register value, if we're doing that we don't need to
> bother reading the register at all and can simply use the RDVL/RDSVL
> value we were filling in instead.

Maybe that's the simplest fix, especially if you want it in stable, but
I wonder why we even bother with with treating ZCR_EL1 and SMCR_EL1 as
feature registers. We already have verify_sme_features() to check for
the mismatch. BTW, is vec_verify_vq_map() sufficient so that we can skip
the maximum vector length check?

-- 
Catalin
