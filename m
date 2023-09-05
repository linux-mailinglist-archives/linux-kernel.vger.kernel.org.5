Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09F79254D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjIEQCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354777AbjIEOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:16:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E477A197;
        Tue,  5 Sep 2023 07:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A8F9603F3;
        Tue,  5 Sep 2023 14:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F80C433C7;
        Tue,  5 Sep 2023 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693923396;
        bh=b1HjVkh0xrreHoeaZyylU8NoDy/+pEJYUbGeu9YyivQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNgxVyJFRw10wginbFjErx24ryk8fp7TsmpWsX6woUBaEKADXyhU/94yz4NdLojvu
         tRJdysMnyBAGnkxy7VJKdggCeeXALwg7/wGl0NpvBT7wtisArgwUBcbq4EK3lQk84h
         dtaz6uvL+1JhRR2yH1ooWGITwqaXaKoCAq+VyH/XT1JICPRuqlpytrA9u4TM/cWLVF
         JOpT0wfVb421dJq9VzYLUDaBgXojNzJpWiffXCOkXQn2DmP2/EPk+DD0/InUDXHJk3
         BZT0DBbjUfd+95pNid95Cd6vfLojSwo8XdT+u7Yo4rylCYqmf43gbNQOnVZBQYE1sV
         ldDwHY7iomENg==
Date:   Tue, 5 Sep 2023 15:16:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Mostafa Saleh <smostafa@google.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] arm64/sysreg: refactor deprecated strncpy
Message-ID: <20230905141631.GA3236@willie-the-truck>
References: <20230831-strncpy-arch-arm64-v3-1-cdbb1e7ea5e1@google.com>
 <ZPHUb4svC//EhyqJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPHUb4svC//EhyqJ@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 12:09:19PM +0000, Mostafa Saleh wrote:
> On Thu, Aug 31, 2023 at 10:55:59PM +0000, Justin Stitt wrote:
> > diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> > index 2fe2491b692c..3addc09f8746 100644
> > --- a/arch/arm64/kernel/idreg-override.c
> > +++ b/arch/arm64/kernel/idreg-override.c
> > @@ -263,8 +263,8 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
> >  			return;
> >  
> >  		len = min(len, ARRAY_SIZE(buf) - 1);
> > -		strncpy(buf, cmdline, len);
> > -		buf[len] = 0;
> > +		memcpy(buf, cmdline, len);
> > +		buf[len] = '\0';
> >  
> >  		if (strcmp(buf, "--") == 0)
> >  			return;
> > 
> > ---
> > base-commit: 706a741595047797872e669b3101429ab8d378ef
> > change-id: 20230810-strncpy-arch-arm64-1f3d328bd9b8
> 
> Your patch will not apply on mainline but on the revert, otherwise
> 
> Tested-by: Mostafa Saleh <smostafa@google.com>

If somebody can post a v4 based against mainline, then I'm happy to pick
it up as a fix.

Thanks.

Will
