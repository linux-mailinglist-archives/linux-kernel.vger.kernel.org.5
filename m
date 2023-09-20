Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D97A7203
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjITF01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjITF0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:26:01 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7958126B6;
        Tue, 19 Sep 2023 22:23:32 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qipg1-00GD6L-51; Wed, 20 Sep 2023 13:23:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Sep 2023 13:23:08 +0800
Date:   Wed, 20 Sep 2023 13:23:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Roxana Nicolescu <roxana.nicolescu@canonical.com>
Cc:     davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: x86 - load optimized sha1/sha256 modules based
 on CPU features
Message-ID: <ZQqBvPmsrBXzimfe@gondor.apana.org.au>
References: <20230915102325.35189-1-roxana.nicolescu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915102325.35189-1-roxana.nicolescu@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 12:23:25PM +0200, Roxana Nicolescu wrote:
> x86 optimized crypto modules are built as modules rather than build-in and
> they are not loaded when the crypto API is initialized, resulting in the
> generic builtin module (sha1-generic) being used instead.
> 
> It was discovered when creating a sha1/sha256 checksum of a 2Gb file by
> using kcapi-tools because it would take significantly longer than creating
> a sha512 checksum of the same file. trace-cmd showed that for sha1/256 the
> generic module was used, whereas for sha512 the optimized module was used
> instead.
> 
> Add module aliases() for these x86 optimized crypto modules based on CPU
> feature bits so udev gets a chance to load them later in the boot
> process. This resulted in ~3x decrease in the real-time execution of
> kcapi-dsg.
> 
> Fix is inspired from commit
> aa031b8f702e ("crypto: x86/sha512 - load based on CPU features")
> where a similar fix was done for sha512.
> 
> Cc: stable@vger.kernel.org # 5.15+
> Suggested-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> Suggested-by: Julian Andres Klode <julian.klode@canonical.com>
> Signed-off-by: Roxana Nicolescu <roxana.nicolescu@canonical.com>
> ---
>  arch/x86/crypto/sha1_ssse3_glue.c   | 12 ++++++++++++
>  arch/x86/crypto/sha256_ssse3_glue.c | 12 ++++++++++++
>  2 files changed, 24 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
