Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FC377BF40
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjHNRs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjHNRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:48:29 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A63D7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 10:48:27 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2CDC040E0197;
        Mon, 14 Aug 2023 17:48:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vtX5sQun8k4G; Mon, 14 Aug 2023 17:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692035303; bh=we7bPFKNk2gezODvYUAFMeGis11Czzq8JCnJIXpbTBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRUnN4B8NUmdZtT6tdKY1Mn+b9o0lR7RN9bll4FpcEV3f93vXph1xCYRFjwrv56Bq
         UHywqDo5p2XekkJ40WFAzidq2BnZHQV3hrvJZTvfZYEAJwe7JnUx9xmfYcTvuoC/mm
         HLjFxFJb4TJQT/4ZiisfrLc4hI//93uQWmpo5Yg+Rjxz9s1TeOL8IwMMDGiJxtcNaJ
         eE4jPSfWtY/wHx8Ut4S8LmvBIjFmwuyXLOmAGB3t+B1z2C7fRuAMdSS8F5XMwqc3+s
         wLZawJA9e+Zkbms9VXGU56dT34RkOupzhxNEZMn9eBUf7t4oYkDMdouz3ynLQC/UM9
         DGW5akgM2NnlIt7dUrEsI9ZFSU7w+/GwVtjc4nJGydRiZ4S1KF81oXsoHMlAwbCl5T
         Sw2dX8up97zMAXEhqeLOsLYv/R3ytWNy5oM73p5fHClihmi0yZ8sbY4GwcGupP91pX
         OSAjksau1tozTx5cb7rFH9C1+G98YCPlKtKZ7QzujwR9ON25PjRSSVXIyJZxQ82gGE
         UKptP08+ji3UaAymbQTypYgDS+JATebGqXNA8pVhpT8VQ/WeISbOmVyiM/WEWXYuaa
         8Anj6k62/eUF7gbmafw/9GsVZxLoK5SDGWo+0NQBPaw9A+r22ewg/9IypZ9VgXG4k7
         eoZMniKkBkmf1+YYCzBA4e78=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3EC540E0185;
        Mon, 14 Aug 2023 17:48:15 +0000 (UTC)
Date:   Mon, 14 Aug 2023 19:48:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 05/11] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230814174810.GGZNpo2sjkpFiJLjif@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121148.842775684@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814121148.842775684@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:44:31PM +0200, Peter Zijlstra wrote:
> Where Zen1/2 flush the BTB entry using the instruction decoder trick
> (test,movabs) Zen3/4 use instruction aliasing. SRSO adds RSB (RAP in

I'll change that "instruction aliasing" to "BTB aliasing".

> AMD speak) stuffing to force speculation into a trap an cause a
> mis-predict.

I'll change that to the much more precise:

"SRSO adds a return sequence (srso_safe_ret()) which forces the function
return instruction to speculate into a trap (UD2).  This RET will then
mispredict and execution will continue at the return site read from the
top of the stack."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
