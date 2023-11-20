Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400187F1D49
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjKTT2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjKTT2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:28:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE45BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:28:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FC7C433C8;
        Mon, 20 Nov 2023 19:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700508484;
        bh=D9xGetJBsZnX1EJOaSpAcRc2P8I2rT0kE7jgOjR+FqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9jDPi+dvngrxY4pnMjeT33brWQCVXkZfXA7MT1UUq8PmeWrCSwP1hJWed8+A2DDM
         86oYWF6ArCAm1awiKjyewwtmI1MtTJRCs8mi1tY19UpN4LAx8/gkf0qvKQD6bhs1P4
         IlO8/GJQCSS56lObJxhM3+IdURCjRn6QDNfoMwCxLYkSYl75TKLaSc8bgo01hn6p0C
         HK9okuAbttEQEa+uMxH5ge0TrGqN6gWuezVceBwwtYTnRFcnnwuVhFzwZRydcCeI2w
         xmP5RzEn8lZTWZ5eqx9ismJjW21Jn6s3rsRfIQAhhDnJ0ffyFz5p/gFtqtLE7dDNk3
         omZ0xyb3++HpA==
Date:   Mon, 20 Nov 2023 11:28:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, andy.chiu@sifive.com, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated
 AES-CBC/CTR/ECB/XTS implementations
Message-ID: <20231120192802.GB964@sol.localdomain>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231102051639.GF1498@sol.localdomain>
 <267FDF51-7720-40AC-9416-B5361C45393B@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267FDF51-7720-40AC-9416-B5361C45393B@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:47:29AM +0800, Jerry Shih wrote:
> > There's no fallback for !crypto_simd_usable() here.  I really like it this way.
> > However, for it to work (for skciphers and aeads), RISC-V needs to allow the
> > vector registers to be used in softirq context.  Is that already the case?
> 
> I turn to use simd skcipher interface. More details will be in the v2 patch set.

Thanks.  Later, I suspect that we'll want to make the vector unit usable in
softirq context directly.  But for now I suppose the SIMD helper is tolerable.

- Eric
