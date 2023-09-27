Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A37AFD24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjI0H43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjI0H4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:56:22 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133F7B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:56:21 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 22AAD40E00B3;
        Wed, 27 Sep 2023 07:56:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iQcQX1myYkB8; Wed, 27 Sep 2023 07:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695801375; bh=cMU1mq0MH89l94SpBt4s2P2s0VkUKVXINmOw1/WT98Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WN/R8bvcAbGrT+wIjBkyupOpC1ArHqIlrHBCySy+ckJMAOgOBoZ+tZeTuk3M3JUht
         iGQhcWrjNOC6JaIK2HLVRDORKNF+XDBPOe/fAN3aCYnjWEOWx/WKlrOra4mzvNsaMi
         eqgpXsFlaeP1Zknvg88FYFRq2XHtMym1E55jB100Ajwx22/viM/A6djaDC/6RDB/Ed
         Hj/k7XAQxzgFBL7TeR42tU+MNOvskJ00Zm2WNDRNF4QtALoCaA0tKs8EvxVVd5mhzF
         tf5dC76W8wnO2PfR9PG7rCBkyknTlf9KlIQUySjgHuLU6/d9oM4xMZb0c6VADjsEq4
         qVHZrEldR21zSYf37AkC617EVLyzZA8NCNGqXGF73u+0of1LTT6f7kv5p6l/H2LJRL
         0JIcwW3J7zEUtNBxJcR5fH0nvJ5OY7BhtWQXGw77i/f5EZjZGmbu8/X8iMnpHB7QCJ
         RuGZPQXaU7XUrQEfvEe/IbN47kaMs96owYnU1cJsJSqC2eKoNb6/ysCE62Vdkh6vFs
         9DQRt3k1PuViOlJMcjy6RJOQWnaaVVnC9FP/TJVyLHZQHJSMhmAjUv5rrkPGNQ4Zs7
         dQacRBDTnQEitf66YycepjH4iCDaCYbx5hOvZYvINXCIkofTjnFNYb0vTWnVPyyDLF
         YTaq6IWB3fDlQCcFI6eRKNl8=
Received: from nazgul.tnic (cust-west-par-46-193-35-178.cust.wifirst.net [46.193.35.178])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 940D340E014B;
        Wed, 27 Sep 2023 07:56:09 +0000 (UTC)
Date:   Wed, 27 Sep 2023 09:56:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 20/30] x86/microcode: Sanitize __wait_for_cpus()
Message-ID: <20230927075628.GAZRPgLGhVDFPDJ-4R@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065502.022650614@linutronix.de>
 <20230922162429.GKZQ2/vfYY21ty5bqR@fat_crate.local>
 <87wmwdfhbe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmwdfhbe.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:51:33AM +0200, Thomas Gleixner wrote:
> MSEC_PER_SEC? Thats really wrong because timeout counts in microseconds,
> no? So USEC_PER_MSEC.

Doh, yes.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
