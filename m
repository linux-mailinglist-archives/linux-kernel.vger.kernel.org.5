Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE079287A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243515AbjIEQWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343575AbjIECgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:36:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A41CC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1693881397;
        bh=5+JoxtLs6MVTssB1pdaRBmIYrJlBYbAptn7l8A1Vk+A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Br/G74WdcIjQZxwDT+3mLhNHjcoPzFSvAB/Y+N6jsZfYbOgF3AbHwCA2vW91rZlkR
         kVr/zcNm3e4X36YDgFg64oFezqScC1nSyMEJKS5hbIidm9gAd+K/o57X/f/wTVM1rx
         l7omlV3WPJ63z7H3WOl4x/rqphjCnCs0X90rs7biRA0S0qE3vqHtsK9EWOBeAPkdHi
         /KPsJpkfn6UjL4BevawmfW2+xPoBB5V/gN4KOst/Y+lDp3S0qDWtKRxUo9XjWb3lI6
         1pdzYcSZ7Vm5hxGCkj8YaPZzUtEmBTSUzYTBbmw8HmkdQupT9tIZtSjsTk5W/ZjvXd
         GnY495hVf7QUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfqQF028Gz4wxy;
        Tue,  5 Sep 2023 12:36:36 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64e: Fix wrong test in
 __ptep_test_and_clear_young()
In-Reply-To: <2daed51109cbd7e7fbd26fab4e77fc6a27dee63e.1693643773.git.christophe.leroy@csgroup.eu>
References: <2daed51109cbd7e7fbd26fab4e77fc6a27dee63e.1693643773.git.christophe.leroy@csgroup.eu>
Date:   Tue, 05 Sep 2023 12:36:36 +1000
Message-ID: <87a5u1ibwr.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Commit 45201c879469 ("powerpc/nohash: Remove hash related code from
> nohash headers.") replaced:
>
>   if ((pte_val(*ptep) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
> 	return 0;
>
> By:
>
>   if (pte_young(*ptep))
> 	return 0;
>
> But it should be:
>
>   if (!pte_young(*ptep))
> 	return 0;


That seems bad :)

But I don't know off the top of my head where
__ptep_test_and_clear_young() is used, and so what the symptoms could
be. Presumably nothing too bad or someone would have noticed?

cheers
