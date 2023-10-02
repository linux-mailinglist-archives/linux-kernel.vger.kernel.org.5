Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0602E7B5D89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjJBXHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjJBXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:07:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B61AD;
        Mon,  2 Oct 2023 16:07:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820AAC433C7;
        Mon,  2 Oct 2023 23:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696288032;
        bh=pqvohkmy+2m5Tqt1sTRxlBrIprA83sMhWjYw54JI05M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jjdz6eixvqAz08YRMbWSuL4jQlaSOX95kn5uuK4Mkq6zj1pdxcmCPphMyrBYhuByE
         9n+mae1GFj78m6OwJyEKUcC5/wYYIK7LsF9xWbNpWvZaXyMyeVbJQuH9W8vLjh5RLA
         y/0H7xXbdRS98XpnP2zQDhGKT1lhZ+t8OvGHkfJeLkqNAW03dfnsUpSUaMtqN+7e9r
         /57qKywpv3q0rZndFV8DU8v7d85ynQ0UC/4zm/+SQ11mKiY1UzaDWKHgnq0oiQXzh/
         L8aERvYjHrcY5hqyGdNdR9dbP1X+VszD2VL3U90PlTYSA6D87BeBHSWNSfmkGHvzB6
         g52qkjS/mwXwA==
Date:   Mon, 2 Oct 2023 16:07:09 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] gen_compile_commands: use raw string when replacing \#
Message-ID: <20231002230709.GA1029006@dev-arch.thelio-3990X>
References: <20230929190446.113168-1-jeremy@jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929190446.113168-1-jeremy@jcline.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On Fri, Sep 29, 2023 at 03:04:46PM -0400, Jeremy Cline wrote:
> I noticed this since I'm running Python 3.12-rc3, which emits
> "SyntaxWarning: invalid escape sequence '\#'" when running this script.
> According to the Python 3.12 release notes this will eventually become a
> SyntaxError.
> 
> Based on the comment in the code, I believe the intention was to match
> the literal string "\#". Marking it as a raw string will stop Python
> from trying to treat it as an escape sequence and behave as intended.
> 
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

Thanks for the patch, it looks good to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Just a heads up, you are not the first person to see this and send a
patch:

https://lore.kernel.org/20230912060801.95533-5-bgray@linux.ibm.com/

But as far as I can tell, there is no movement on that changeset, so if
Masahiro is able to pick this up, that would still be good. Masahiro,
the original change is available at
https://lore.kernel.org/all/20230929190446.113168-1-jeremy@jcline.org/,
if you are able to apply it that way.

> ---
>  scripts/clang-tools/gen_compile_commands.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
> index a84cc5737c2c..bc005cac1944 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file_path):
>      # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
>      # kernel version). The compile_commands.json file is not interepreted
>      # by Make, so this code replaces the escaped version with '#'.
> -    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
> +    prefix = command_prefix.replace(r'\#', '#').replace('$(pound)', '#')
>  
>      # Use os.path.abspath() to normalize the path resolving '.' and '..' .
>      abs_path = os.path.abspath(os.path.join(root_directory, file_path))
> -- 
> 2.41.0
> 
