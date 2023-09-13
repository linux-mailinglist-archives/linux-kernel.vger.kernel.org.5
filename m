Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920BE79DF23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 06:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjIMEYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 00:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIMEYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 00:24:12 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6955A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 21:24:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1932240E0140;
        Wed, 13 Sep 2023 04:24:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WYqVwsQkDh14; Wed, 13 Sep 2023 04:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694579043; bh=nOoSSINxBJwoFouCcrCQkMhLMlmpLoXzkz6xu0GQCjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QREsKrZp9D3scsxvEjurDzDiRsG4PpT0uhuRsLkAnLq6JUCTTFXPLEX7xhekO8erd
         N0bt1uC/kweEL8ZdRY4CUC5lP+JaA2mvjPAMWXFFNHBvdctQ0ZZT3Cg66EzB127pOn
         ApzCJisG5070aOI2ciuUXiGGpeGmBZTcmyyHyuU2QQU07ucxChqHGgJTotQ1HfwR4T
         SFGX7FfAZkwLLqspOlRmWzJ3ydLW0uyaLWiIphziug1hLlOOlmdV/+tinSpY8u4zbN
         csepzcvXk6VOKnJ0jDpV+EdyTw+m9xgpgklKyAoytMnoGY/ZWJIvPyZaAW5tLddLDw
         ioIpbraZw+n6DPLJ9LnbvIrQ2LsBM4f8WuXGhZu9+pC+LDtaRjV6AffN5THauGQM2D
         oDAL71UgPp9SHrwzEblqLI6fEnyBgOtNigZfUTEytwBm0YlhXprogNIBX48SHMP2vQ
         3b45LDUOe3JutWf0hq6Cofnv3tbAKk2CRsW37MtbpwrgznFtTSx864bPdHQVyzMLPx
         bD3NX8Xw0ui4YYbbaklzrovbVSKjJ1YaDSVC1J2Ykhp9CMBgVU9VMdWs+pFH6QZdYC
         5tgm9oHpTEHNso+i0mTonbe0saPn20V6meAZe50s0xqdlPXOr3W7iATBS1hsvDpgSO
         iI0XbnJZdto6TIvgkE5+rf5Q=
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59F5940E00F4;
        Wed, 13 Sep 2023 04:23:55 +0000 (UTC)
Date:   Wed, 13 Sep 2023 06:24:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230913042410.GBZQE5aiEdTeNi4lip@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
 <20230912092709.GE35261@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912092709.GE35261@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:27:09AM +0200, Peter Zijlstra wrote:
> Aah, because we run optimize_nops() for all alternatives, irrespective
> of it being selected.

Yeah, and I remember us talking about it the last time you did it and
how it would be a good idea to do that but be careful about it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
