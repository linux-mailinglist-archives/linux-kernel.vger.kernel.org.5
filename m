Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5597AF43B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjIZTkE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 15:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjIZTkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:40:02 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A439D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:39:55 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 34E7A1CA71C;
        Tue, 26 Sep 2023 19:39:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 1AD9617;
        Tue, 26 Sep 2023 19:39:49 +0000 (UTC)
Message-ID: <1a47655c27cd4c5b56005a833f7292a1c7eda224.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn about multi-line comments without an
 empty /* line
From:   Joe Perches <joe@perches.com>
To:     Petr Tesarik <petr@tesarici.cz>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>
Date:   Tue, 26 Sep 2023 12:39:49 -0700
In-Reply-To: <20230926192006.18351-1-petr@tesarici.cz>
References: <20230926192006.18351-1-petr@tesarici.cz>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1AD9617
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: zt66wiwc6dj7tc7qms3868ck67heizt3
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX180yN9BNQIDL3gqiJCQMxLfdA4ikmK8qkU=
X-HE-Tag: 1695757189-507493
X-HE-Meta: U2FsdGVkX1/CgA2gqhTVQCHFTjs25b1wzJcGLV9Y9+CYqMGKx8u0rEOHXDnePy5ei4BQj/dsKFvQnaFcYPBSULpzQOlhysUtIoJVl+PemhiOMjNWnWBp0QzapTLtIV2/cC5VRj/G8ksCTLTOFOWGHuCs//wyUx9Ia2pwkhkruODKtx+yJt3QCxQAaRZAU0x47MC3Npx6n5wc21kE5oy7DfRceyzRKoQGWCwppt+osLj2Jv2IJbP6TorbeKPmkNEA5v4b7keDxquwGPEZ+3/0lx94sbadLy2z4qosY46kKq4HGSVDW4XitCrecQxyw9xH
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 21:20 +0200, Petr Tesarik wrote:
> According to Documentation/process/coding-style.rst, the preferred style
> for multi-line comments outside net/ and drivers/net/ is:
> 
> .. code-block:: c
> 
>         /*
>          * This is the preferred style for multi-line
>          * comments in the Linux kernel source code.
>          * Please use it consistently.
>          *
>          * Description:  A column of asterisks on the left side,
>          * with beginning and ending almost-blank lines.
>          */
> 
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>
> ---
>  scripts/checkpatch.pl | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7d16f863edf1..0fc3427a9ec9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4006,6 +4006,14 @@ sub process {
>  			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>  		}
>  
> +# Non-networking without an initial /*
> +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
> +		    $prevrawline =~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
> +		    $rawline =~ /^\+[ \t]*\*/) {
> +			WARN("MULTILINE_BLOCK_COMMENT_STYLE",
> +			     "multi-line block comments should start with an empty /* line\n" . $hereprev);
> +		}
> +

Nack.

There are _way_ too many uses without an initial /* blank line
that are perfectly acceptable style.

$ git grep '/\*.*' -- '*.[ch]' | \
  grep -v '/\*.*\*/' | \
  grep -v -P "/\*\s*$" | \
  grep -v '/\*\*' | \
  grep -v "SPDX-License" | \
  grep -v -P '^drivers/net|^net/' | \
  wc -l
51834

