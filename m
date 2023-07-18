Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C68D757C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjGRM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjGRM7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:59:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A63A1B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1689685159;
        bh=acJNVov+LEY5vzZF2D/HTZd1dJc8QADqtfbwJQh2Skg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=r6tVW/RcSC1U72NGhCYDHUMHKZKIGJOXGCJF/+RE0O2c7z8GdbGwX+kdyMO7zpQ2f
         /Po1Ds78wdOzXCGnpUIWeq4QT3eK7sHRnw55x/yplEJmP+GKIRuZs+1GGDPJeXrBSG
         g80rRSEIA7UuDQGJQpYVWVpVXrOwfZ4sj5yzQ3LUbyQv7lJJEsAsfB4efJECmnsW53
         wYXt+0iaGhrzbSqp9i50Ro0ka6Cr0lq1BxJMSaOwmh5I94RRhd8SmVdI7FsAcHsNG/
         HBzsk2S/hwigjyGp/tJbp+s+vqjqJJ4a8Dt/TA2tsdr6t1iRqXTBzqPlA90UEtwqZB
         pEo9BOidgT9PA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R4zYM5xYRz4wZt;
        Tue, 18 Jul 2023 22:59:19 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     John Ogness <john.ogness@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/build: vdso linker warning for orphan sections
In-Reply-To: <871qh6wcgb.fsf@jogness.linutronix.de>
References: <20230609051002.3342-1-npiggin@gmail.com>
 <871qh6wcgb.fsf@jogness.linutronix.de>
Date:   Tue, 18 Jul 2023 22:59:13 +1000
Message-ID: <871qh5jrz2.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Ogness <john.ogness@linutronix.de> writes:
> Hi Nicholas,
>
> On 2023-06-09, Nicholas Piggin <npiggin@gmail.com> wrote:
>> Add --orphan-handlin for vdsos, and adjust vdso linker scripts to deal
>> with orphan sections.
>
> I'm reporting that I am getting a linker warning with 6.5-rc2. The
> warning message is:
>
> ld: warning: discarding dynamic section .rela.opd
>
> and bisects to:
>
> 8ad57add77d3 ("powerpc/build: vdso linker warning for orphan sections")
>
> Despite the warning, my ppc64 system seems to run fine. Let me know if
> you need any other information from me.

We already discard .opd and .rela*, so I guess we should also be
discarding .rela.opd.

Can you test with a newer compiler/binutils?

cheers
