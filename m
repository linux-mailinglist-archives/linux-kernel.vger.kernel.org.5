Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE47DEBBE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348442AbjKBEUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbjKBEUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:20:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A15121;
        Wed,  1 Nov 2023 21:20:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0672C433C8;
        Thu,  2 Nov 2023 04:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698898845;
        bh=txrJlBB0Uz613TnTKBLK7e9nihyZmtdDBI+sCpPNnt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTwbS13fGaAJLxnc4pi0VX3VLVMDZ6et4pCX3CHqbAEMybAfp4b4JDBjGpZjP+i3n
         MTUkffkYFeq8gurYFgsV0/qfMuHG5TtKjO+fm5tRUJyQSMeLFzskbBj3N4AZB4Z2Uc
         kpiO2oZylgD5+j+hs4zmzG/7hID905PbDMgqnV+Sph+gWvOPtsU03jgCKR4Ns43sPI
         86UXEdfJLdStgL8VhdFxWpLjCuEVNlff1PBNEe7JPQ1dee93BNFrqzuA4iptWi+FiA
         QI/uYpZZT75IOm1xJIeAZK83IwFNEfg3RIf7uU6/iopudX10OAlsfbAn1sEdtd8EQV
         nqfc/bAFy2YIg==
Date:   Wed, 1 Nov 2023 21:20:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 0/7] crypto: Proper Initialization of `struct
 skcipher_walk` in x86 Glue Files
Message-ID: <20231102042043.GD1498@sol.localdomain>
References: <DB3PR10MB683562E7BD2DC73A48BEA3C8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR10MB683562E7BD2DC73A48BEA3C8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuran,

On Thu, Nov 02, 2023 at 09:34:08AM +0530, Yuran Pereira wrote:
> In multiple `*_encrypt`, `*_crypt`, `*_decrypt` functions within the x86/crypto
> glue files, the `skcipher_walk` structs being used are not properly initialized
> prior their usage which can lead to undefined behaviour if the `flags` field of
> this structure were to contain junk values at the time of its usage.
> 
> This patch series ensures that instances of `struct skcipher_walk` are correctly
> initialized across different x86/crypto glue files.
> 
> Yuran Pereira (7):
>   crypto: Fixes uninitialized skcipher_walk use in sm4_aesni_avx_glue
>   crypto: Fixes uninitialized skcipher_walk use in des3_ede_glue
>   crypto: Fixes uninitialized skcipher_walk use in chacha_glue
>   crypto: Fixes uninitialized skcipher_walk use in aesni-intel_glue
>   crypto: Fixes uninitialized skcipher_walk use in aria_aesni_avx2_glue
>   crypto: Fixes uninitialized skcipher_walk use in aria_aesni_avx_glue
>   crypto: Fixes uninitialized skcipher_walk use in aria_gfni_avx512_glue

Updating all callers of skcipher_walk_virt() seems like the wrong approach.
Shouldn't skcipher_walk_virt() be fixed to initialize the flags to 0 instead?

Also, does this fix affect any behavior, or is it just to fix a KMSAN warning?
It needs to be fixed either way, but it's helpful to understand the effect of
the fix so that people can decide whether it needs to be backported or not.

- Eric
