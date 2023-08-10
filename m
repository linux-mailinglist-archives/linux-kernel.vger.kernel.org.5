Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF257778D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjHJMvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjHJMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:51:36 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE083C5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:51:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 47D2B40E01A0;
        Thu, 10 Aug 2023 12:51:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ea89pFpdl3we; Thu, 10 Aug 2023 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691671892; bh=E7oT9arX/kjdLffGRAnKE53sSXpKCypTPGvWWboVfMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vqcufvc4wgeA2lN5TDP/YKIIDg8piONGBF1kQ+2xcl/wPnrRt6Z7xs9G7iMAK1Zeb
         6BuoEM4Dv8Ks3M/7/UayY3IqCs4jpBMPcLlnra+Tjg+jzW0c5VOwskf5C70VdlDeFd
         MRXMsTSaG2zbcfAXFa/hu308PbrWZ2OL45OIUMBofA7/Tra/ClvXYX08QUd2j7ybHQ
         zdQh+6KSYybH63gRSCz1YalB+Ecq8ZcxN1OpaLjMZ7HwJf6o2IhDvXXLp/WhBWAos2
         FHRT5ELJ0a2jB9bQqyGJaFaeXmrCFdLqwO/p2P3odw9mrKflKtAFfDsFskk/1MU27F
         Y4mukUKJWZkQMBGWMmdUWdr0aGdVtXsHRwCdfosf5rdZK77OcnX4IOrUlDaXiw66jG
         WmPkP2f//lZkhrJL19ASmuLITi3KFm5ELIcaEwL+LOV25HNQLdKOodZFFhwElBY3Ae
         i25qOqcAoLECTNmCF+fFpO6XIWmcRxlT6MwWFO8kotEdJA61UrMsUIEDtOzn+HBacG
         M1VSoc8pZNpyWPjyTj5Hu1P3rQ8ieu64++LKz93k1HKASoJKkv8yuCyxcNEUcxmN+x
         WLhsCGBcthyOkIMKX3WXHEPgcs4sa1FOMe+B37Ta3fDFBySkUijo1WPyJPKK5hbdwO
         nSqXyN0VYHGX23tHSo/iGTPk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD2E840E0185;
        Thu, 10 Aug 2023 12:51:27 +0000 (UTC)
Date:   Thu, 10 Aug 2023 14:51:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: Hang when booting guest kernels compiled with clang after SRSO
 mitigations
Message-ID: <20230810125122.GIZNTdSuFvA3Cjfexq@fat_crate.local>
References: <20230810013334.GA5354@dev-arch.thelio-3990X>
 <20230810081038.GAZNSbftb6DOgg/U7e@fat_crate.local>
 <20230810090835.GBZNSpE6tCw+Ci+9yh@fat_crate.local>
 <20230810101649.GA1795474@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810101649.GA1795474@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 03:16:49AM -0700, Nathan Chancellor wrote:
> Just to clarify, this is the guest kernel at -rc5 and the host kernel
> with the SRSO mitigations applied? If so, that's the problem. The guest
> kernel does not have to have the SRSO mitigations applied to see this
> problem. Sorry I should have made that more clear! If not though, that's
> interesting because I was running -rc5 on the host without issues.

Well, how do you even build CPU_SRSO with clang?

config CPU_SRSO
        bool "Mitigate speculative RAS overflow on AMD"
        depends on CPU_SUP_AMD && X86_64 && RETHUNK
					    ^^^^^^^

config RETHUNK
        bool "Enable return-thunks"
        depends on RETPOLINE && CC_HAS_RETURN_THUNK
				^^^^^^^^^^^^^^^^^^^

config CC_HAS_RETURN_THUNK
        def_bool $(cc-option,-mfunction-return=thunk-extern)

$ clang -mfunction-return=thunk-extern
clang: error: unknown argument: '-mfunction-return=thunk-extern'
clang: error: no input files

$ clang --version
Debian clang version 14.0.6
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
