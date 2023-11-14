Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D37EB12D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjKNNrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjKNNrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:47:36 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147AB1B5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:47:33 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1B2E940E018F;
        Tue, 14 Nov 2023 13:47:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sSZDH4Z35msb; Tue, 14 Nov 2023 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699969649; bh=Bz2wr5hUsFGQnH+osaeuDzSJTLNKM+ey40ld1RnYKHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PICg1ympgy7+K5qTkxUp7rLGJUPY/jNDAbN8GixhviDP+OT9ahBTLWBg8XBJcczdK
         vxnwMFNS37ZT7OefmdSIiZcG9ftRIYBSnBwYdWsMWAt4mNqY/v50Hi93YZqzte7VgW
         6ty9uhP2XJU+X2CPrVhzLWth6CXidQU38dW6anzvIbH2h6e6gBumFGeQ9Y8rwr1j/P
         3WOOQDfsIuoGg/yzJJOtqCB4ryPTgHQB81XQDpjl0XUAIoWEz31Oe79iB9zkRYxPZM
         WFXsulxfwvJP/Y7Q6/735b8fdw35orA3Zn9aGqqfcS4JIfbiiWhjB111eS4yRNZDBa
         9QOvuxoAaqW00EzNY9lIDDuG/5hfzdXPHI1TQ0Y+mgRRSWYdCGbyAxwce6EMmZQwp3
         XO+hS1Tx66RKdDVpGd71flc3DbelkMoidQdGQYA8CbNuWsd+ODCCO+fXcsAUpr6L4q
         OYpFhZEv9825eaIWc338gdi/c0a1KOvpcqSQQeejLMkg0NPL1cK/semlpBZWM4qPIU
         LqgIeNDC8SnhLpFjdtVh8X+QGyQ3+XX56DW+41enU8d/VQZUOHaXOkp1va0haJHLaj
         Ry5NOrzWiijug6pGqA9KVx1DxDJdnOF+4ZKZX/6A4jexzyxj8k9yn3Pd/cjZXaDUtu
         2gxd+orbG01tFp5Ju05fLwEU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9A8240E0171;
        Tue, 14 Nov 2023 13:47:20 +0000 (UTC)
Date:   Tue, 14 Nov 2023 14:47:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 2/5] x86/alternative: add indirect call patching
Message-ID: <20231114134715.GBZVN6Y97XrLQ4cbSL@fat_crate.local>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-3-jgross@suse.com>
 <20231114123737.GBZVNqEXKgt+6P1Wiv@fat_crate.local>
 <20231114125028.GX3818@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231114125028.GX3818@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 01:50:28PM +0100, Peter Zijlstra wrote:
> This loads the function target from the pv_ops table. We can't otherwise
> do this.

On Tue, Nov 14, 2023 at 01:56:37PM +0100, Juergen Gross wrote:
> It is replacing an _indirect_ call with a _direct_ one, taking the
> call target from the pointer used by the indirect call.

Then this is not just a ALT_FLAG_CALL. This is something special. The
flag definition needs a better name along with an explanation what it
does, perhaps best with an example from the final vmlinux - not from the
object file:

call   *0x0(%rip)

==>

call   *0x0

where the offsets haven't been linked in yet.

If this is going into the generic infrastructure, then it better be
explained properly so that other stuff can potentially use it too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
