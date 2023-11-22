Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D8D7F3B14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjKVBO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVBO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:14:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098EE199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:14:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AF8C433C8;
        Wed, 22 Nov 2023 01:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700615664;
        bh=rphzolO4qNFSWg1tDMw1cULkepLmztnO/fdyF7aCD/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrVWFy+llDoq6D7PZjaiAXmmUgR9/2t/fPiONPKKVbSp1ki43ndsX1+mM//dArRI3
         Ercyb0mb3CzQ0WKOE43JoMhsoS9OpGRcDGytKRRFCP+CMxPV01k2rshgGA+x/Ujagq
         mTvwLEBrZ6NTCoc/QEM/nqWhsm5dgsQfD6olfUePK/Ser1rEPQl80RBASM8XG5PVQO
         f4i6CRxJX+jNaY+OSmCbB/eCvsDC03m4Bz8QgmKAH4OWa2y/iOQ6awZG89h2k5UbJh
         0zhl1vnz0yYOI6+nWUfrjudkfiS66CNcLlqJWvgSyClI5XK9kx+1yKHmiPXRiWIOv1
         SPG+qtA42ri5g==
Date:   Tue, 21 Nov 2023 17:14:22 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated
 AES-CBC/CTR/ECB/XTS implementations
Message-ID: <20231122011422.GF2172@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231102051639.GF1498@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102051639.GF1498@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:16:39PM -0700, Eric Biggers wrote:
> > +	  Architecture: riscv64 using:
> > +	  - Zvbb vector extension (XTS)
> > +	  - Zvkb vector crypto extension (CTR/XTS)
> > +	  - Zvkg vector crypto extension (XTS)
> > +	  - Zvkned vector crypto extension
> 
> Maybe list Zvkned first since it's the most important one in this context.

BTW, I'd like to extend this request to the implementation names
(.cra_driver_name) and the names of the files as well.  I.e., instead of:

    aes-riscv64-zvkned
    aes-riscv64-zvkb-zvkned
    aes-riscv64-zvbb-zvkg-zvkned
    sha256-riscv64-zvkb-zvknha_or_zvknhb
    sha512-riscv64-zvkb-zvknhb

... we'd have:

    aes-riscv64-zvkned
    aes-riscv64-zvkned-zvkb
    aes-riscv64-zvkned-zvbb-zvkg
    sha256-riscv64-zvknha_or_zvknhb-zvkb
    sha512-riscv64-zvknhb-zvkb

and similarly for the cra_driver_name fields.

I think that's much more logical.  Do you agree?

- Eric
