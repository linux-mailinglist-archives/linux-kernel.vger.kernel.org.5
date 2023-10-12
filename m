Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175F37C66F7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378029AbjJLHlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347221AbjJLHl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:41:26 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA012192;
        Thu, 12 Oct 2023 00:41:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4F53E40E01AE;
        Thu, 12 Oct 2023 07:41:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iEwd9QEY93se; Thu, 12 Oct 2023 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697096464; bh=jJUZbzlswPXGZoXPc17PlkAB4TzsPozIWmI2f9OwXCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+q11BTQwE+t099woHPw3xGFHvdM6FZzpHuueaY02wRAHmWaocNOlz9MLAs4r45M9
         W2FJ9y8iuKWnbTE9wFRU5dGCOUNQhnAB3x+MF0yDzCNgLZC1ZmDM9CORtOTQ4AzuJ8
         lw3BMilA0StdChbHNQqXIZo/Wa2P087TioOdMD7nYxDoZ5duN7WNlFFZBNE1UU1VIi
         RFHA19UlsyhElmCV+pHQUCFicsfId5nBNDpXfZpsi9gInlB9Gzq3bXXrGzIOVnCBG4
         /tfyWx8J8SaW2XhL7PTDCISib7LYu4Ci9aOkdkj4TIdm3C0SBCV2jW30ONGHuSuuzV
         kaJYO9yOHBjE9qYI4YOCj5dm1cKfK/iQziBI+JPYe78ICClZiTu2TkE9YJxooUaEEx
         9WkFjg4wmE1XDBi1hnNMOwKLcjNkENDreWoD3RUqJdSPjwXhPUfJ07iWXlaQB650JA
         SYV4+YWz/gGJJFOEXPHw7dYV8F1yreQVekQklmFjD5y82rxiRjmtRTySVOf2g2dtC5
         6s/HEV4NKDbZ0qZUT9FryiUv9kB4M5sTj5Gb8xDPTLRGbTgiweUVbAXNhbUdoMgNHA
         YAXEZQCzyZdqtMWXT0om3eKklAaZy8ZMHMm8lk4p8sAwQTvZWWeVkq6SM1WJSsdOKr
         MBsFOh6iai13E7qntj7NPmfo=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E177840E01AA;
        Thu, 12 Oct 2023 07:40:57 +0000 (UTC)
Date:   Thu, 12 Oct 2023 09:40:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        rene@exactcode.de, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip: x86/urgent] x86/cpu: Fix AMD erratum #1485 on Zen4-based
 CPUs
Message-ID: <20231012074051.GBZSejA6bTV53638DE@fat_crate.local>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
 <169701622768.3135.17489375930381616520.tip-bot2@tip-bot2>
 <ZScTem8iF8CUZqf6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZScTem8iF8CUZqf6@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:28:26PM +0200, Ingo Molnar wrote:
> While in reality:
> 
>    Zen 2 == Fam 17h
>    Zen 4 == Fam 19h

If only were that easy...

family 0x17 is Zen1 and 2, family 0x19 is spread around Zen 3 and 4.

> 
> So it's confusing to list these separately and out of order.
> 
> So in resolving the conflict in perf/core I updated this section to read:
> 
>   /* Fam 19h (Zen 4) MSRs */

That's wrong.

>   #define MSR_F19H_UMC_PERF_CTL		0xc0010800
>   #define MSR_F19H_UMC_PERF_CTR		0xc0010801
> 
>   #define MSR_ZEN4_BP_CFG		0xc001102e
>   #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
> 
>   /* Fam 17h (Zen 2) MSRs */

Ditto.

> This doesn't change the definitions themselves, only merges the comments 
> and the sections, (to keep the Git conflict resolution non-evil), but 
> arguably once perf/core goes upstream, we should probably unify the naming 
> to follow the existing nomenclature, which is, starting at around F15H, the 
> following:
> 
>    MSR_F15H_
>    MSR_F16H_
>    MSR_F17H_
>    MSR_F19H_
> 
> Or are the MSRs named ZEN2 and ZEN4 in AMD SDMs, which we should follow?

See above. The MSRs are per Zen generation while the family is per
family. Yes, it is confusing. :-\

IOW, you want to have this as the end product:

/* Zen4 */
#define MSR_ZEN4_BP_CFG                 0xc001102e
#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5

/* Fam 19h MSRs */
#define MSR_F19H_UMC_PERF_CTL           0xc0010800
#define MSR_F19H_UMC_PERF_CTR           0xc0010801

/* Zen 2 */
#define MSR_ZEN2_SPECTRAL_CHICKEN       0xc00110e3
#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT   BIT_ULL(1)

/* Fam 17h MSRs */
#define MSR_F17H_IRPERF			0xc00000e9

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
