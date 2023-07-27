Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07057765929
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjG0Qt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjG0Qt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41F01724;
        Thu, 27 Jul 2023 09:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40A9161EE2;
        Thu, 27 Jul 2023 16:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB7EC433C8;
        Thu, 27 Jul 2023 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690476595;
        bh=gcwSoL2bkDWbowCSuuulpc/4xH1rTxXZ2w4KlNaV8sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ga5J9/+3lu2HE+A49nb6Q8RsDrf1xcwmIjw20AVQZ1wu+uPt1Qczw2tW5SfIj937U
         FjQxAIrzJNrwEWwOcjrsbgYsXWxYrCoTFsJfEqickqDZtR6p5W03DnYFnXS1SJZRs7
         QTT18Irx2tocg/Lr4BFTVYwyJYSfQwch3AEO2fqf5pZxBriszkPHMbV70I0LJUV67Y
         DQ/++5Bu58zNLWsZ6nOQi/hTQ73JNz90k5Ma4G4ORiViRqL6SyS3gCfAsqoiNeM8rc
         uJcyM5wJszKFtdrPXPAhIyfJWMJCgfrRY6sGjOGSsyg9ZTYVHl2sQMLhx1UXqThGA9
         yhjEiL6ccCMNQ==
Date:   Thu, 27 Jul 2023 09:49:27 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2 2/2] scripts/faddr2line: Constrain readelf output to
 symbols from System.map
Message-ID: <20230727164927.3bjth6ac75jh6rdr@treble>
References: <20230725211157.17031-1-will@kernel.org>
 <20230725211157.17031-3-will@kernel.org>
 <20230725213805.g6osfswz5o6cxusy@treble>
 <20230727121851.GA19653@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727121851.GA19653@willie-the-truck>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:18:52PM +0100, Will Deacon wrote:
> On Tue, Jul 25, 2023 at 02:38:05PM -0700, Josh Poimboeuf wrote:
> > On Tue, Jul 25, 2023 at 10:11:57PM +0100, Will Deacon wrote:
> > > @@ -185,7 +186,7 @@ __faddr2line() {
> > >  				found=2
> > >  				break
> > >  			fi
> > > -		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
> > > +		done < <(${READELF} --symbols --wide $objfile | sed -f ${IGNORED_SYMS} -e 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
> > >  
> > >  		if [[ $found = 0 ]]; then
> > >  			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
> > 
> > Looks good, though the outer loop has another readelf incantation:
> > 
> > 	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
> > 
> > It should probably have the same sed options?
> 
> Hmm, I don't think it's needed there, is it? The awk expression has a
> strict match on $sym_name, which is going to be something extracted from
> a kernel log and therefore exists in kallsyms.

Yes, I think you're right.

> > Also it looks like it's wrongly checking for FUNC.
> 
> Yes, I agree that should be dropped for the reasons you gave before.
> 
> So I can spin a v3, with an extra patch to avoid checking against FUNC.

Sounds good, thanks!

-- 
Josh
