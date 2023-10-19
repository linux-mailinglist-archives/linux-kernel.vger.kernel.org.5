Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDD47CEECD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjJSEsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:48:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EAD9F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697690929;
        bh=HSBVb0/6PKzVd/BXIi0nFqaJ/m0nLqwjF6CLo8nWfJQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nrG9hfkGjdJ8PvVVCnQKQ+Qfmxsr4+knCkz3c05OZTbzy9MYDUfvYgATbRUl2cNg6
         ZvWMBYpsXDzLQ62vsYjy0z3Bb1kAEbaSB9w/46q/y+qXE88YVE8604Py5oaZhu1/Ot
         puJ8sTEUN6oRljLbxy7AYwf9IPYCG9IAGspWIeCVxFZBgQ9yCJZ0ysodf8wQm2j7QZ
         Sna8LOFq0HXyH4Nx+toSPZ7Nw03a115OBsAqBBGIO4itk+6pmSlDfRvrivuVkBrfrR
         klJK3MBlRM1jH6p2BHaO0A/Te2JDtz44iKdaklLMKGlY9Ds+Ixa0lg+udnzeqRchix
         L3zcp2f1Uj9bg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9wGS5XSkz4x80;
        Thu, 19 Oct 2023 15:48:48 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] powerpc/smp: Disable MC domain for shared processor
In-Reply-To: <20231018163751.2423181-5-srikar@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-5-srikar@linux.vnet.ibm.com>
Date:   Thu, 19 Oct 2023 15:48:48 +1100
Message-ID: <87pm1b5ia7.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> Like L2-cache info, coregroup information which is used to determine MC
> sched domains is only present on dedicated LPARs. i.e PowerVM doesn't
> export coregroup information for shared processor LPARs. Hence disable
> creating MC domains on shared LPAR Systems.
>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/smp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 498c2d51fc20..29da9262cb17 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1046,6 +1046,10 @@ static struct cpumask *cpu_coregroup_mask(int cpu)
>  
>  static bool has_coregroup_support(void)
>  {
> +	/* Coregroup identification not available on shared systems */
> +	if (is_shared_processor())
> +		return 0;

That will catch guests running under KVM too right? Do we want that?

>  	return coregroup_enabled;

What does coregroup_enabled mean now?

I'd rather this was actually checking the presence of something, rather
than just hard coding that shared processor means no coregroup support.

cheers
