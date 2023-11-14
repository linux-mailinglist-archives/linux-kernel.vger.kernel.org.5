Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283F97EB300
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjKNPGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:06:47 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A479D123
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:06:44 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B6B1D40E0032;
        Tue, 14 Nov 2023 15:06:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4Uz4AMc0hRK7; Tue, 14 Nov 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699974400; bh=2EHEy163hk2/hZKzFmzok7WEIqyaK7LDByonjtgnNFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgmeLhkDZ2UOEoVMlexxw54a0qvKuZMVCGycqtjLOfLrrve3TSMLCxJh/6m5mNrgA
         uuJ5JAXV0zuDPIWXnmwApYzXDG31oLh6zrT2h1CqNx3S0snX+oRMoMa+EZz54O4uYt
         pVXworQtiz3ZG73NTeojMe+FOX/WzPITeW3QxWA+mzwZDjbcv+y0igtxHMcPGYAa3b
         4HYRgQJ90em+MZTIE4vd4t6RrPWL0EYvOB9rDFaEUspLu1FJV68up5ucE903ukJoak
         R0tO1PcigPonlS6fXEU67ypmdl/pNSSvGe/Su7I3PCZRok2E/Owc+niflTVPOSOV0/
         7N4To9JCVu+mWefjP21eBhGFM4jYWCiAsllB0885jmv4I+1cZIYHzJeFsdKWKwY09e
         La7bnThPKIoZ/5BYEFvJxiUns0ehATZ/o/mFLC3Ybtc5SF5yyt8SFjUORbHxgrB1Ji
         3MEp9+pXcB28V2s8kdMg3du1oVETgv+kLrkUnqTr1NdoPCyc0k92AcvC8lpOmQlk9+
         pbt9trq7X2bqBmJGFn2Gn/XQcPIziFcsb61QvdynFdB7L8NfuXLe8uttEKfLvHZjnm
         a6r1gTwZbRQ78Gkn3yweNLi+82fJ/kpM04JoBIfc4XO8aHo3rcHyj8ugQ2ruY/GBU8
         tGd7Zx2Be1TF29y6v3undhu4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A5DD40E0030;
        Tue, 14 Nov 2023 15:06:32 +0000 (UTC)
Date:   Tue, 14 Nov 2023 16:06:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 2/5] x86/alternative: add indirect call patching
Message-ID: <20231114150627.GDZVOM82VPHDlnD3lF@fat_crate.local>
References: <20231030142508.1407-1-jgross@suse.com>
 <20231030142508.1407-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030142508.1407-3-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:25:05PM +0100, Juergen Gross wrote:
> +#ifdef CONFIG_X86_64
> +	/* ff 15 00 00 00 00   call   *0x0(%rip) */
> +	target = *(void **)(instr + a->instrlen + *(s32 *)(instr + 2));
> +#else
> +	/* ff 15 00 00 00 00   call   *0x0 */
> +	target = *(void **)(*(s32 *)(instr + 2));

Yeah, let's document those a bit better. Either with comments above or
as Peter suggests:

	/* Add 2 to skip opcode and ModRM byte: */
	disp32 = *(s32 *)(instr + 2);

	rip_rela_ptr = (void **)(instr + a->instrlen + disp32);
	target = *rip_rela_ptr;

so that it is crystal clear what we're doing here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
