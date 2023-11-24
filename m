Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4C37F748A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbjKXNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjKXNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:05:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0279D71;
        Fri, 24 Nov 2023 05:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1700831128;
        bh=6Y8qQKiNapfxIiyPU0awITssjjLEv8Lqe9dkOsuewfU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Muf2VTywqEgHzegB/nAYDtxju24jHb7b6xljhCIq+59yo1LqKOiMI8hHN6TIOQj/t
         JOZD4Ol4zOUuz//nId6dzwBldfv9dLBQoc4UI5Dp3ykNfbtRGTdZzdEzf9Y6v0Wg1O
         0VXZwf9FDnMLX+W/BaGAdfkK1N0pQBZKgeAA33boLATaOM+7T7QOo3aNyvWElDUhN2
         jmnA8eUVZfkfo9aeoHFOMrzbRMCT4mu+SyCm18IPUmCOPybpxWQ4rJsG6sKGgTwQBt
         ewBl8pQYuqBGWOSUCH2d7wN8BzI3M2I5i/g2OjApQ8plVpz84DtFeRrbzd0DwlcHVz
         pa11Xh/2NXhTQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ScFZm6CGZz4xNt;
        Sat, 25 Nov 2023 00:05:20 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Christoph Muellner <christoph.muellner@vrull.eu>,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH 0/5] RISC-V: Add dynamic TSO support
In-Reply-To: <20231124115430.GS3818@noisy.programming.kicks-ass.net>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124101519.GP3818@noisy.programming.kicks-ass.net>
 <59da3e41-abb3-405a-8f98-c74bdf26935b@huaweicloud.com>
 <20231124115430.GS3818@noisy.programming.kicks-ass.net>
Date:   Sat, 25 Nov 2023 00:05:16 +1100
Message-ID: <87plzzqp2r.fsf@mail.lhotse>
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

Peter Zijlstra <peterz@infradead.org> writes:
> On Fri, Nov 24, 2023 at 12:04:09PM +0100, Jonas Oberhauser wrote:
>
>> > I think ARM64 approached this problem by adding the
>> > load-acquire/store-release instructions and for TSO based code,
>> > translate into those (eg. x86 -> arm64 transpilers).
>> 
>> 
>> Although those instructions have a bit more ordering constraints.
>> 
>> I have heard rumors that the apple chips also have a register that can be
>> set at runtime.
>
> Oh, I thought they made do with the load-acquire/store-release thingies.
> But to be fair, I haven't been paying *that* much attention to the apple
> stuff.
>
> I did read about how they fudged some of the x86 flags thing.
>
>> And there are some IBM machines that have a setting, but not sure how it is
>> controlled.
>
> Cute, I'm assuming this is the Power series (s390 already being TSO)? I
> wasn't aware they had this.

Are you referring to Strong Access Ordering? That is a per-page
attribute, not a CPU mode, and was removed in ISA v3.1 anyway.

cheers
