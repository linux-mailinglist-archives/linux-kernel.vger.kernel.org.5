Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8347F1D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjKTTTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjKTTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:19:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC27210E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:18:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA452C433C8;
        Mon, 20 Nov 2023 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700507938;
        bh=8GrqBpx0HG1TFaZKdiHie469Wi/VanH3SYoEwrBLjtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsgSdljj2y1K4QXuI0J47MilWCgnCZU0WD/Xv3w+9CbSg+ZcuApxMhkpOdOZt1BI0
         DIjT6Y8bjiNEqkZt1fHfgRZJk+hFhaGhQ6GX0DHgUrEQuVzjCe1ulUo+ORF/SRnv08
         Y8i4NUJIxX8INL+TH9feVjcji1HRJ1xb7eMzp64HI/Bel7W4tyPqFAXe0aOu4pvtrc
         LcmwVK9q+9Gk1bkJkBnmmgNjIHkFyqX0hAlCIRY7KY/6iDAVv27vMul3n1eJwWkI33
         fHAIEUPYV2vrgM2nBMzJue2p9Dow8h8rdZu2kJgg2NvmPQQTgYji09NJ/AVoNAO2FG
         CYORXBPpNN96g==
Date:   Mon, 20 Nov 2023 11:18:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 12/12] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
Message-ID: <20231120191856.GA964@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-13-jerry.shih@sifive.com>
 <20231102054327.GH1498@sol.localdomain>
 <90E2B1B4-ACC1-4316-81CD-E919D3BD03BA@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90E2B1B4-ACC1-4316-81CD-E919D3BD03BA@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry!

On Mon, Nov 20, 2023 at 10:55:15AM +0800, Jerry Shih wrote:
> >> +# - RV64I
> >> +# - RISC-V Vector ('V') with VLEN >= 128
> >> +# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
> >> +# - RISC-V Zicclsm(Main memory supports misaligned loads/stores)
> > 
> > How is the presence of the Zicclsm extension guaranteed?
> > 
> > - Eric
> 
> I have the addition extension parser for `Zicclsm` in the v2 patch set.

First, I can see your updated patchset at branch
"dev/jerrys/vector-crypto-upstream-v2" of https://github.com/JerryShih/linux,
but I haven't seen it on the mailing list yet.  Are you planning to send it out?

Second, with your updated patchset, I'm not seeing any of the RISC-V optimized
algorithms be registered when I boot the kernel in QEMU.  This is caused by the
new check 'riscv_isa_extension_available(NULL, ZICCLSM)' not passing.  Is
checking for "Zicclsm" the correct way to determine whether unaligned memory
accesses are supported?

I'm using 'qemu-system-riscv64 -cpu max -machine virt', with the very latest
QEMU commit (af9264da80073435), so it should have all the CPU features.

- Eric
