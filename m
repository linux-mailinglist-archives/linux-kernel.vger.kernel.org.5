Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EED7EB213
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjKNO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:27:49 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A218FCA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:27:46 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B4DD040E0171;
        Tue, 14 Nov 2023 14:27:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id chJwPbpJbe2x; Tue, 14 Nov 2023 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699972062; bh=Lr49NePHfatVliL7iLtk4mJWIWf7OiS9AhN7JnzFX9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8VJOeF+82XKqw/9H8ixcxMu5EVXBzi0iafDyrzybEhtS+8MkoFlK45rrgf7lK+1U
         D2DxO7dPlji8Jcbk9U798bmulD0X+5k2YpsiL+VWxG/a1iiP1jmCveFwchyKldr+ET
         IwigV+LneUQOR0QNC4asOM8is8WcGgq2cVyN12eU+1+vgcfTwKTBomRpk3t3dHlX8G
         XjOWbPI6UITW4qV69Lh7ubzUTMDTl7FP5nhdznd/lFolATBkXX3ttUWpbSwyADmpaj
         jZ6ulGRPu1mT9S4tYCKHeZ0qOAEGlFM7Hsu7pNBs3CwH6uSH0TXKjkuwnu/EnWLm4+
         JitC1n3Bn7U7uiBEm1OtYL5auK/EiibH/eqwbIj8nSVDdSSPElFACkHM2rouW97CDA
         IepqEplBbBrV++UmG/p5KHQ02j3sXS5/QljdjTA8oTQucARHnNai13k3Z9/nBW38tI
         u8ibt1p7Y9pSR0+B2sVpWb6BEFtKGKi/K9lxtr9SsRp8UTCOLeP/cCFUlCphuT4oNY
         Qfoqw3gUwYjVntUB2kkpf7ExyeVv2NY4+oThtmTDzctstB0UOESgZFWweJ1qHzSDCU
         Gw8erOeEBCd6cU9syPdRs0lV7noiWggIERgX7TDndOmo1XoNslRzWLoSb2BfNd0YRv
         3U/xCDk3F191cSyUpPzISI7w=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9EEA240E0030;
        Tue, 14 Nov 2023 14:27:34 +0000 (UTC)
Date:   Tue, 14 Nov 2023 15:27:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 2/5] x86/alternative: add indirect call patching
Message-ID: <20231114142733.GCZVOD1TvZ2qq536dg@fat_crate.local>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-3-jgross@suse.com>
 <20231114123737.GBZVNqEXKgt+6P1Wiv@fat_crate.local>
 <20231114125028.GX3818@noisy.programming.kicks-ass.net>
 <20231114134715.GBZVN6Y97XrLQ4cbSL@fat_crate.local>
 <20231114141833.GX8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231114141833.GX8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 03:18:33PM +0100, Peter Zijlstra wrote:
> Well, a random absolute address isn't going to be any better or worse
> than 0. But perhaps adding the relocation as a comment helps?
> 
> 
>    ff 15 00 00 00 00       call   *0x0(%rip)  #  R_X86_64_PC32    pv_ops+0x4
> into:
>    e8 00 00 00 00 90	   call   +0          #  R_X86_64_PC32 *(pv_ops+0x04)

A bit better, yeah.

> ALT_FLAG_DEREFERENCE_INDIRECT_CALL ?
> 
> I'm going to already raise my hand and say that's too long ;-)

To your own suggestion? :-P

ALT_FLAG_DIRECT_CALL simply, I guess, along with an explanation.
Meaning, this flag tells the alternatives to produce a direct call.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
