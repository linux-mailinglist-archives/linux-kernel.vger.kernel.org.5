Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188497DC23F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjJ3WCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjJ3WCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:02:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B8FFD;
        Mon, 30 Oct 2023 15:02:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E14C433C8;
        Mon, 30 Oct 2023 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698703364;
        bh=hmXfhyRbFB4SPz5+yRItfsjgmm00F2inmvHFJjdkKno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RvR5ETAihQ5U2c7DCUaBHf5rLRTY7qPryACqOg949WLoqskyUaWZ/hZZNnkexHt8k
         wtVkIuGSkB7Mn2QEayJQI5OxlQ3ussziOB8akYMqCBDaPvlhnbalpcfijwsS7U+XDL
         A3tU0Bg7BibPrakvWPeWT9dTIywdyWQEZVnpWmYCIn4LBSdt2OOgjjN7VMf8ECXmoy
         kZlrV7+5JL/bQW7qKACaLK8+u/w72NtV1WGscGxbB8ZrpnPVkX0opSyPM0tuvgJpfl
         EO/XybBPox8uud+4Hox+NMgGZuIaQlsJLGc0+kYpC4vHSF3Fup/RT0gkTCsDWcamsY
         7NcXIyqwx2s5g==
Date:   Mon, 30 Oct 2023 15:02:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20231030150243.0e66ba73@kernel.org>
In-Reply-To: <ZT896a2j3hUI1NF+@gondor.apana.org.au>
References: <20231030155809.6b47288c@canb.auug.org.au>
        <20231030160953.28f2df61@canb.auug.org.au>
        <ZT896a2j3hUI1NF+@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 13:23:53 +0800 Herbert Xu wrote:
> If we simply apply this patch to the netdev tree then everything
> should work at the next merge window.  But perhaps you could change
> the patch description to say something like remove the obsolete
> crypto_hash_alignmask.  It's not important though.

I'm happy to massage the commit message and apply the fix to net.
But is it actually 100% correct to do that? IOW is calling
crypto_ahash_alignmask() already not necessary in net-next or does
it only become unnecessary after some prep work in crypto-next?

We can tell Linus to squash this fix into the merge of either
crypto-next or net-next, I'm pretty sure he'd be okay with that..
