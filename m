Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7981B7D4331
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjJWX2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJWX2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:28:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085EDE;
        Mon, 23 Oct 2023 16:28:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F8AC433C7;
        Mon, 23 Oct 2023 23:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698103697;
        bh=6P4ReWHS+myUk2YY4Rx+y5auSUtYo8uMw77/ieje5bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQsh875nTbQaGdexfP8f74K5+5NSqOXtFMfRypG7GfzyOYu3bn8+DJr7lRfVKjhYn
         VecaNSFENoWHQVEuXz7TMRBPUZBHtkY6HHI+8JHen60tfuU7/XMDMNihzrANDlk1pV
         hUztLgpSLwWoMI4RP2cZv1iD/sfemiEgIUl35K8dDj05tR5wtmVRjoChkkTnWs41LF
         2ZOfiSNZg6Z3sMNJw0mOp+STEWvKmm34fRoOLu5M73UYhy8YbPjjifiLSY0NpLc7Yz
         R9rZaX7mYZNAX69lwdWTZ+3RGCPbjdePSJJ1QPyJ6lciAXkaHcY2JI8tU3kk6DWfVu
         ETU/bK9Ded25g==
Date:   Mon, 23 Oct 2023 16:28:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 04/10] modpost: remove more symbol patterns from the
 section check whitelist
Message-ID: <20231023232814.GA3514685@dev-arch.thelio-3990X>
References: <20231022170613.2072838-1-masahiroy@kernel.org>
 <20231022170613.2072838-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022170613.2072838-4-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:06:07AM +0900, Masahiro Yamada wrote:
> These symbol patterns were whitelisted to allow them to reference to
> functions with the old __devinit and __devexit annotations.
> 
> We stopped doing this a long time ago, for example, commit 6f039790510f
> ("Drivers: scsi: remove __dev* attributes.") remove those annotations
> from the scsi drivers.
> 
> Keep *_ops and *_console, otherwise they will really cause section
> mismatch warnings.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/mod/modpost.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 792ba9da0f27..19b138664f75 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -997,13 +997,7 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
>  	/* symbols in data sections that may refer to any init/exit sections */
>  	if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
>  	    match(tosec, PATTERNS(ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS)) &&
> -	    match(fromsym, PATTERNS("*_template", // scsi uses *_template a lot
> -				    "*_timer", // arm uses ops structures named _timer a lot
> -				    "*_sht", // scsi also used *_sht to some extent
> -				    "*_ops",
> -				    "*_probe",

It seems like this one might still be needed. I see this when building
certain arm64 configurations with clang.

  WARNING: modpost: vmlinux: section mismatch in reference: qcom_irq_combiner_probe+0x0 (section: .data) -> combiner_probe (section: .init.text)

> -				    "*_probe_one",
> -				    "*_console")))
> +	    match(fromsym, PATTERNS("*_ops", "*_console")))
>  		return 0;
>  
>  	/*
> -- 
> 2.40.1
> 
