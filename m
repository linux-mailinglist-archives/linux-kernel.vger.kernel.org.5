Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2B77E4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbjHPPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344018AbjHPPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:08:49 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB8D10EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:08:48 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3241540E0196;
        Wed, 16 Aug 2023 15:08:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wIM32hN5vIrK; Wed, 16 Aug 2023 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692198523; bh=mIQey0dRfzLmzh/CrePhYY4OIsL/+mIY5MFCO0xvqPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+zaV1cszXLwFmNRjlBivVL193aB4stgw87vJNJykqq8mktcxu8ArySbtEt5kOAwg
         KMwGP7ewSKnetMlMf69SAzC79dVQJmAQNPAeELjcD952Iowo9+KfSYtoR1KIY9C5An
         RPClfz53asmfKSoiQ1zvEqXFli+CNqlXMcK/C/TO99p8xUTi0WvFbMQzej5dGhWQXE
         +YwvKmr6nLKNoMzekLlf2Bcfbz+fyBS9SL5VRf9tYtAGkM0bj+ocQDa10E5uCXB/Rz
         c022AXjI539C+RPZU4CgdeFRj5QFfFPe9IKVvpETPllnLasLTtEhMp8T4j0zqAHPxN
         ISj6aRKc9FhPixzYa4sWGswzsJ2ZYw76t69yBdpumKfHTitUitwZ5680hvyn58BZ0u
         BjvOFwm0wMACoVsmi4p8GKuGARjZMUaAhBE4GrRiyd2H3ook4SvoxPVRwLlNRJOxFF
         oJJ6/aWC3p8i11FtBcm9U8OWhfY9QoHwiFq4hdHjVV6HkWLns+OTbQF0B8vtoI2OzA
         0Ilmhvg3gOIIsbRvrvsdIBUixIBVDetG0MrFSSb+WgtyQtNiKrGnicHhVZZaX6ru4A
         //+gJvtqfAF/jaFUaRC/LOQ9MeaBs0NYOH0yXtFfGXXc5HtQPyePwzjuqgmUiiuV23
         NloGlzpDynn1iMUnIX3wbaSE=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B806340E0140;
        Wed, 16 Aug 2023 15:08:34 +0000 (UTC)
Date:   Wed, 16 Aug 2023 17:08:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 05/11] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230816150829.GJZNzmbVhrdli94XGz@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121148.842775684@infradead.org>
 <20230815212931.GA3863294@dev-arch.thelio-3990X>
 <20230815224348.GE971582@hirez.programming.kicks-ass.net>
 <20230816073828.GAZNx89HT8mYCOxvV1@fat_crate.local>
 <20230816145232.GA1535486@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816145232.GA1535486@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 07:52:32AM -0700, Nathan Chancellor wrote:
> All my configurations build and run cleanly in QEMU at commit
> d80c3c9de067 ("x86/srso: Explain the untraining sequences a bit more")
> so I think we should be good here.

Phew!

Thanks a lot for testing!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
