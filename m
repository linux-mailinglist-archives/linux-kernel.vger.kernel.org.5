Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDF7791F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjHKOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjHKOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:35:31 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE4130
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=Xd+TgXFtpWK8JUp/buH0ZdNAaimnoDNIO7zEmS6bZ9c=; b=Qh6Yinvx23/8VlytZgJZE4vMcY
        zpVO0I0SturxAaHA9CzDIvKg33IMiBOTu4odRO0ragaHMU7cWSxAjmWKSuDRlyq4P9uEYmEmkLTUr
        BmHpgrl8lu21Be+jkMKAcQDtl6ehhdaEkIYzQhG3zK6sdjiSDnAnd/+cPnPzsTlOsIZ+7DqJ/vnCZ
        Hf/FtpsUHjJ416aYMFX6O4Mnh7CUeNxDeXuhaQQK1aw+3JNL136K1hPH5WyN8mJi1XtIWdWNWWmCR
        GQ5rc1F3UIpL7TImvHhyu1zeYLE1hcFcTF4aSoEKXWdkoWZ4DkNUMXPfRsyFdm+HmYyoGzG8XPuEc
        rJEiZyiA==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2])
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qUTEV-008IKO-JZ; Fri, 11 Aug 2023 16:35:19 +0200
Received: from aurel32 by ohm.aurel32.net with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qUTER-00HJuM-1m;
        Fri, 11 Aug 2023 16:35:15 +0200
Date:   Fri, 11 Aug 2023 16:35:15 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bo YU <tsu.yubo@gmail.com>
Subject: Re: [PATCH -fixes] riscv: uaccess: Return the number of bytes
 effectively copied
Message-ID: <ZNZHI+5hkhYDhdxF@aurel32.net>
Mail-Followup-To: Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bo YU <tsu.yubo@gmail.com>
References: <20230811110304.1613032-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811110304.1613032-1-alexghiti@rivosinc.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 2023-08-11 13:03, Alexandre Ghiti wrote:
> It was reported that the riscv kernel hangs while executing the test
> in [1].
> 
> Indeed, the test hangs when trying to write a buffer to a file. The
> problem is that the riscv implementation of raw_copy_from_user() does not
> return the number of bytes written when an exception happens and is fixed
> up.
> 
> generic_perform_write() pre-faults the user pages and bails out if nothing
> can be written, otherwise it will access the userspace buffer: here the
> riscv implementation keeps returning it was not able to copy any byte
> though the pre-faulting indicates otherwise. So generic_perform_write()
> keeps retrying to access the user memory and ends up in an infinite
> loop.
> 
> Note that before the commit mentioned in [1] that introduced this
> regression, it worked because generic_perform_write() would bail out if
> only one byte could not be written.
> 
> So fix this by returning the number of bytes effectively written in
> __asm_copy_[to|from]_user() and __clear_user(), as it is expected.
> 
> [1] https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/
> 
> Fixes: ebcbd75e3962 ("riscv: Fix the bug in memory access fixup code")
> Reported-by: Bo YU <tsu.yubo@gmail.com>
> Closes: https://lore.kernel.org/linux-riscv/20230309151841.bomov6hq3ybyp42a@debian/#t
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Closes: https://lore.kernel.org/linux-riscv/ZNOnCakhwIeue3yr@aurel32.net/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/lib/uaccess.S | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Thanks for providing a patch so fast. I confirm that the issue I
reported is fixed, but also that the full strace testsuite now passes
successfully.

The code looks all good to me, so:

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
