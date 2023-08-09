Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C076F776243
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjHIOUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjHIOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BFE1FEE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77CE563868
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156A7C433C8;
        Wed,  9 Aug 2023 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691590834;
        bh=RP3S8qQe8GkEijJORvJffgE78gAf5hx7H6yU+j0EzxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDUwVt+KyasZIWo4T0S1n7ImwmAA1NZ9OMfFsklXXiHGcmUoPvT9Nz9pAU7sC05jB
         AheSauweONLtQDh6uLflexb4ezgJivzkF2Yq35cYEZWcmmOPDeEgUtvrP1uV2m3wnc
         VfCfS5YFIPV6/WZy5rzERhCLv1ooWtS2XW1AJuLxIIlAJpoxv0pgapMU59lRS+s77X
         /NfNrsu1//hyxpgbiW8CtARVjifTwZMv9hO9bC5dkz+uhg48itDOClhLbzkqPMeV9I
         ILkaevivS1PFc2QsiXLCEGPX+nHiotsZxTrxasdLlrp4XM0SR7ji1sqMupUDIYvV4h
         PPgG/MKK8x6NA==
Date:   Wed, 9 Aug 2023 10:20:31 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 12/17] x86/cpu: Rename original retbleed return thunk
Message-ID: <20230809142031.jkj4pa2mhccrdmmd@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072201.259675763@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072201.259675763@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:30AM +0200, Peter Zijlstra wrote:
> +++ b/tools/objtool/check.c
> @@ -455,7 +455,12 @@ static int decode_instructions(struct ob
>  				return -1;
>  			}
>  
> -			if (func->return_thunk || !strcmp(func->name, "srso_safe_ret") || func->alias != func)
> +			/*
> +			 * Both zen_return_thunk() and srso_safe_ret() are embedded inside
> +			 * another instruction and objtool doesn't grok that. Skip validating them.
> +			 */
> +			if (!strcmp(func->name, "zen_return_thunk") ||
> +			    !strcmp(func->name, "srso_safe_ret") || func->alias != func)

Hm, speaking of renaming they should probably be called
retbleed_return_thunk() and srso_return_thunk().

-- 
Josh
