Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA327DCD59
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbjJaMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344376AbjJaMzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:55:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74FEB7;
        Tue, 31 Oct 2023 05:55:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA51EC433C8;
        Tue, 31 Oct 2023 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698756906;
        bh=RYewFD9TWjSqCwbN9nCh3XE/ZeLF89Q9BiBTGcTP5bY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXcs+V3Pikwn7hI7NEzQFtLth6QsK0Dx016S7N1oBy6EB2HnqV3UO4bM8AMlf5VR8
         c20wgb5Th1Yifknay+NRXSp6fUlhnlfcMvGZyI1C3tvVocKjyxn5dG8MuOAfzfQ2Py
         xVUHMdwkAv67S/O4imB2m1D8zzf6T6VRU7sG/s08=
Date:   Tue, 31 Oct 2023 13:54:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: Apply a1e2c031ec39 and e32683c6f7d2 to 5.15 and earlier
Message-ID: <2023103135-yesterday-exhaust-a621@gregkh>
References: <20231027160144.GA232578@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027160144.GA232578@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 09:01:44AM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please consider applying the following mbox files to their respective
> stable trees, which contains commit a1e2c031ec39 ("x86/mm: Simplify
> RESERVE_BRK()") and commit e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for
> older binutils"). This resolves a link failure noticed in the Android
> trees due to a new diagnostic in ld.lld:
> 
> https://github.com/llvm/llvm-project/commit/1981b1b6b92f7579a30c9ed32dbdf3bc749c1b40
> 
>   ld.lld: error: relocation refers to a symbol in a discarded section: __brk_reservation_fn_dmi_alloc__
>   >>> defined in vmlinux.o
>   >>> referenced by ld-temp.o
>   >>>               vmlinux.o:(exit_amd_microcode.cfi_jt)
> 
>   ld.lld: error: relocation refers to a symbol in a discarded section: __brk_reservation_fn_early_pgt_alloc__
>   >>> defined in vmlinux.o
>   >>> referenced by ld-temp.o
>   >>>               vmlinux.o:(exit_amd_microcode.cfi_jt)
> 
> While I think this may be related to Android's downstream use of LTO and
> CFI, I see no reason that this could not happen without LTO due to
> RESERVE_BRK() prior to those upstream commits residing in the
> .discard.text section.
> 
> I confirmed they resolve the Android build problem and I did an
> ARCH=x86_64 defconfig build and boot test in QEMU and an allmodconfig
> build with GCC, which had no regressions.

All now queued up, thanks!  If only all stable submissions were sent to
us in such easy-to-consume-form :)

thanks,

greg k-h
