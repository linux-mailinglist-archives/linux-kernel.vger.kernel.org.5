Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B740A7E747C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjKIWoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjKIWoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:44:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E873C2F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:43:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19D4C433C8;
        Thu,  9 Nov 2023 22:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699569839;
        bh=J7Z1TIeSL+ecHsL867EqIQu1HuhYiRqQAIyQZP57BDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3ZU15IwNxgEt75cYUU2e9Ny1xKFm4B8BJolByRNzxsrKvuIbIZ4W/NuC3X16+uPS
         DlF88cCYEnoar75dAwN4bUdaiEB+u7gL6igwBjb9m81aiy2sEglvhhoFbi47j0pujJ
         /rOUexJhy0q8TOXx+weSvZEchj6u/om3lfQpDo6yGojAUnOrcOJqcgupDFyz32+3LY
         LBVF1vxCKZlWsDPecTUkdi51ixdB+5U9XLx4YQokXZQovNk+OjL1rNen4y1hgqDeIn
         W/0fktVWg7aTuGbzZI0TCGrVIeVLEUQtxxqNyrjsUrm0yp8MF2jmkrXoZDkY1uEEIX
         5kL7GuuB0jriA==
Date:   Thu, 9 Nov 2023 14:43:56 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 12/12] x86/bugs: Add a separate config for missing
 mitigation
Message-ID: <20231109224356.diks3jws5ezfldzy@treble>
References: <20231019181158.1982205-1-leitao@debian.org>
 <20231019181158.1982205-13-leitao@debian.org>
 <20231025162906.abnyb7xum7cpjwxy@treble>
 <ZTqdPc59HWBdP269@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTqdPc59HWBdP269@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:09:17AM -0700, Breno Leitao wrote:
> Hello Josh,
> 
> On Wed, Oct 25, 2023 at 09:29:06AM -0700, Josh Poimboeuf wrote:
> > On Thu, Oct 19, 2023 at 11:11:58AM -0700, Breno Leitao wrote:
> > > Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
> > > where some mitigations have entries in Kconfig, and they could be
> > > modified, while others mitigations do not have Kconfig entries, and
> > > could not be controlled at build time.
> > > 
> > > Create an entry for each CPU mitigation under
> > > CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
> > > them at compilation time.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > We also probably need a CONFIG_MITIGATION_MELTDOWN.
> 
> Isn't Meltdown covered by the MITIGATION_PAGE_TABLE_ISOLATION Kconfig
> entry? Would you mind clarifying what would be the difference between
> CONFIG_MITIGATION_MELTDOWN and MITIGATION_PAGE_TABLE_ISOLATION, and why
> do we want CONFIG_MITIGATION_MELTDOWN?

Ah yes, not sure how I missed that one.

> > > +	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
> > >  	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
> > >  	    cpu_mitigations_off())
> > >  		return SPECTRE_V2_CMD_NONE;
> > 
> > I'm thinking CONFIG_MITIGATION_SPECTRE_V2 should also affect whether the spectre v2 user
> > mitigation gets enabled.
> 
> Makes sense, would something like this be enough?

Looks good to me.

While you're at it, for consistency can you add a cpu_mitigations_off()
check to spectre_v2_parse_user_cmdline()?

-- 
Josh
