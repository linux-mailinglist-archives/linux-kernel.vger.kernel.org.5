Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AE977BE65
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHNQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjHNQwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:52:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F433E63;
        Mon, 14 Aug 2023 09:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A222463996;
        Mon, 14 Aug 2023 16:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E53C433C7;
        Mon, 14 Aug 2023 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692031970;
        bh=S8/38gOX8CEBqpB9alrToiwydnTBozTScdBE+KGfjnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txcWCsP8BvaHjh2RYmoe7+RTCg0O53+D1jmlGgIBOBq9VC2ckkSWUXdoUM/aLXN6J
         i2gV1zWw0rlBkNU0i43AzAopUr5Uw8voedWq/fF1K4giCWiNUtokKBUbRZNcqD6dTS
         TA1rejJzKREjB927mRsWauqHeM5oz+IXbPk9m4aUtoGsh8Lyl+/n2PkmLeB/zDZFI3
         TU+oLFWBOPZP2kpl12Byg5Hi5rv8zJAnmTpUObZNYlyWxtjGzNCaMMCpzRhOYRb6st
         3psq2Q4f43NQMM2v4nMPj3kanRCCUi/ywS/2oY1P3thPtfbizvDB/6xhnkApd1fSzC
         r1fZjGAVeUaFQ==
Date:   Mon, 14 Aug 2023 09:52:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        clang-built-linux <llvm@lists.linux.dev>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Daniel Kolesa <daniel@octaforge.org>, x86@kernel.org
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Message-ID: <20230814165246.GA911700@dev-arch.thelio-3990X>
References: <20230809103636.615294317@linuxfoundation.org>
 <CA+G9fYvQdQqTqCgbS4sit_Y2AtKtDiWMOkGZjoeSEFhc=M_jKw@mail.gmail.com>
 <078d6e3d-9572-a624-2c5a-e2d58473e6d0@roeck-us.net>
 <20230811041339.GA193223@dev-arch.thelio-3990X>
 <20230813110254.GDZNi4XhHjY4xlNdBJ@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813110254.GDZNi4XhHjY4xlNdBJ@fat_crate.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 01:02:54PM +0200, Borislav Petkov wrote:
> On Thu, Aug 10, 2023 at 09:13:39PM -0700, Nathan Chancellor wrote:
> > 1911 is still being investigated (some additional eyes on it would not
> > hurt).
> 
> I'm hoping that we can take this one:
> 
> https://lore.kernel.org/r/20230809072200.543939260@infradead.org
> 
> which should resolve this issue, right?

Yes, it does, as least for mainline and 6.4. The backport to 6.1 seems
hairy (due to a lack of call depth tracking me thinks). It may be worth
taking Nick's change there for simplicity's sake but I'll let y'all make
that decision.

Cheers,
Nathan
