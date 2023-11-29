Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05B07FE0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjK2U0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjK2UZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:25:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09780D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:26:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33903C433C8;
        Wed, 29 Nov 2023 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701289565;
        bh=PN5ubgLpDPuW9rHykLBRI+s3FZh6xjxWlF9+Ry84t80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SXjh5gO079La4jU98h/gu37YvIoFwnrjoraInTxvddDeytta4VebZNQV2H+kSoxiN
         3P939JvVZhSvqOjLYzrv5cJDl+zd5o13jLXxReDmxH0jo3ydVQlnR1skJnl+4OqPuE
         Hh38EVOHi9+DI11WDHEtPhu2f95exDmdlCyoXg2I1Nwr3meJ5BQ40qPOAJzd1HRfO6
         HP9okeS8J9iVDUeb1o18O3kLuYJYkJL3m76mOJBPUGxxuCRH0hgOvWysuLnJrLfAfK
         Exa6Y9enh+emk9SzsSK2bSobP/7mJNXRsChuKM78adeE2l5ZXwdgsCn0ZbdpKPfXNC
         II+VZoyJLkvUg==
Date:   Wed, 29 Nov 2023 12:26:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Jerry Shih <jerry.shih@sifive.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 04/13] RISC-V: crypto: add Zvkned accelerated AES
 implementation
Message-ID: <20231129202603.GB1174@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-5-jerry.shih@sifive.com>
 <20231128-await-tipper-2094715466f2@spud>
 <20231128201228.GE1148@sol.localdomain>
 <E78B3BF9-8E49-417B-A89E-05F72690A92F@sifive.com>
 <20231129-subtitle-unlinked-c0871a28ac88@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-subtitle-unlinked-c0871a28ac88@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 11:12:16AM +0000, Conor Dooley wrote:
> On Wed, Nov 29, 2023 at 10:39:56AM +0800, Jerry Shih wrote:
> > On Nov 29, 2023, at 04:12, Eric Biggers <ebiggers@kernel.org> wrote:
> > > On Tue, Nov 28, 2023 at 05:54:49PM +0000, Conor Dooley wrote:
> > >>> +static inline bool check_aes_ext(void)
> > >>> +{
> > >>> +	return riscv_isa_extension_available(NULL, ZVKNED) &&
> > >>> +	       riscv_vector_vlen() >= 128;
> > >>> +}
> > >> 
> > >> I'm not keen on this construct, where you are checking vlen greater than
> > >> 128 and the presence of Zvkned without checking for the presence of V
> > >> itself. Can you use "has_vector()" in any places where you depend on the
> > >> presence of vector please?
> > > 
> > > Shouldn't both of those things imply vector support already?
> > 
> > The vector crypto extensions imply `V` extension. Should we still need to check
> > the `V` explicitly?
> > https://github.com/riscv/riscv-crypto/blob/main/doc/vector/riscv-crypto-spec-vector.adoc#1-extensions-overview
> 
> The check for Zkvned is only for whether or not Zvkned has been provided
> in the DT or ACPI tables, it doesn't mean that the kernel supports the V
> extension. I could see something like a hypervisor that does not support
> vector parsing the "v" out of the DT or ACPI tables but not eliminating
> every single extension that may depend on vector support.
> 
> The latter check is, IMO, an implementation detail and also should not
> be used to imply that vector is supported.

First, the RISC-V crypto files are only compiled when CONFIG_RISCV_ISA_V=y.
So in those files, we know that the kernel supports V if the hardware does.

If the hardware can indeed declare extensions like Zvkned without declaring V,
that sounds problematic.  Would /proc/cpuinfo end up with the same misleading
information in that case, in which case userspace would have the same problem
too?  I think that such misconfigurations are best handled centrally by having
the low-level architecture code in the kernel clear all extensions that depend
on missing extensions.  IIRC there have been issues like this on x86, and that
was the fix that was implemented.  See arch/x86/kernel/cpu/cpuid-deps.c

- Eric
