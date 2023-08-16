Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5931D77DC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbjHPI1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbjHPI1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899C61BDA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28CA165CA6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721E8C433CA;
        Wed, 16 Aug 2023 08:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692174425;
        bh=/NwmrTbylnu4L2dUN7IAYjB8B65NFoALZ+lzOZthkSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyTC1D3lQqUOQZ4XiWP7Iu8HKl3vz95meL5fMuPHOTSoNY/YPfNDIeMGy31vEaqel
         4KEdtD3lMCYhAanBb1VVr1qQQiMDFFyCAOVLBZ5/nITRCBoTqGTcagWWm8Y0xamzGT
         aUhS65LUy1G2ipnvqukPMv3KAK0G8kxOsgSzsKBRE5Q8fUEKbTbZCvnn+yIq9bQFm9
         jfWV1dB/6A3PVUxYSrhuBNH+En9YR79z/t/JDqdPCUnWSeO1XtvuSDTXv0GcjNGrsZ
         PYR/uZEf+Z+D4AriwPoaa2v/TTcnOEXJUP8kt+XJDa/DqMH7dQIakPSbkwHbbQ3G/r
         D/70SEbglZxlw==
Date:   Wed, 16 Aug 2023 10:27:01 +0200
From:   Simon Horman <horms@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] net: nixge: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <ZNyIVQABsgj96DiK@vergenet.net>
References: <20230815-void-drivers-net-ethernet-ni-nixge-v1-1-f096a6e43038@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815-void-drivers-net-ethernet-ni-nixge-v1-1-f096a6e43038@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:50:13PM +0000, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |       drivers/net/ethernet/ni/nixge.c:1273:12: warning: cast to smaller integer
> |               type 'enum nixge_version' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |        1273 |         version = (enum nixge_version)of_id->data;
> 
> This is due to the fact that `of_id->data` is a void* while `enum nixge_version`
> has the size of an int. This leads to truncation and possible data loss.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: There is likely no data loss occurring here since `enum nixge_version`
> has only a few fields which aren't nearly large enough to cause data
> loss. However, this patch still works towards the goal of enabling this
> warning for more builds by reducing noise.

This information might be better placed in the patch description,
above the scissors (---) and tags ("Link:", ...)

And, although I did make an error in this area myself as recently as
yesterday, this patch should probably be tagged as being for net-next.
It's probably not necessary to repost for this.

	Subject: [PATCH net-next] ...

The above notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
