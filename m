Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379987671C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjG1QU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjG1QUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D067449C;
        Fri, 28 Jul 2023 09:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1623B6213D;
        Fri, 28 Jul 2023 16:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177EBC433C8;
        Fri, 28 Jul 2023 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690561219;
        bh=54MBqcw7ll+B/9DNGmX7N8jbDcKh/YfDc7wKAAwwCSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXUW4yU3b9+EbfFAnlCu5wXpY78EhCMIaXLkksSu9SjyKIUgi9VByK834Y5kXsYYe
         owTZYS0/58fjy0KvMP0s12fWFQ4EISUtvzgfGCUSRBM2xFG9IYFwe4jq+rJpU1LJ2k
         ReAvnUXdVONC4Fq3IHPTRNgBRfM4SE2CzJDcAXIq38bQ7aLz+MgmtIujXVQDklYBRs
         Ipw/lr1SFDR0Qbq7/XnYDzW8BcaU66EKBgGk03SXF5jrpf3SkVQca6hd3OOIrGBbJm
         j0oESWznR+asqrsdzpz4mdUCrjUh/LTtoJt7gsrpMYb5iJh1OThWX1wp3SkOO4gwyM
         TonJVT03FnJCQ==
Date:   Fri, 28 Jul 2023 17:20:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V13 - RESEND 02/10] arm64/perf: Add BRBE registers and
 fields
Message-ID: <20230728162011.GA22050@willie-the-truck>
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711082455.215983-3-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:54:47PM +0530, Anshuman Khandual wrote:
> This adds BRBE related register definitions and various other related field
> macros there in. These will be used subsequently in a BRBE driver which is
> being added later on.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 103 +++++++++++++++++++++
>  arch/arm64/tools/sysreg         | 158 ++++++++++++++++++++++++++++++++
>  2 files changed, 261 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index b481935e9314..f95e30c13c8b 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -163,6 +163,109 @@
>  #define SYS_DBGDTRTX_EL0		sys_reg(2, 3, 0, 5, 0)
>  #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
>  
> +#define __SYS_BRBINFO(n)		sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 0))
> +#define __SYS_BRBSRC(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 1))
> +#define __SYS_BRBTGT(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10)) >> 2 + 2))

It's that time on a Friday but... aren't these macros busted? I think you
need brackets before adding the offset, otherwise wouldn't, for example,
target registers 0-15 all access info register 0 and __SYS_BRBTGT(16) would
then start accessing source register 0?

I'm surprised that the compiler doesn't warn about this, but even more
surprised that you managed to test this.

Please tell me I'm wrong!

Will
