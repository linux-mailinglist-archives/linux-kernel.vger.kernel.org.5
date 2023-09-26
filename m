Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF12B7AF488
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjIZT4t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 15:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjIZT4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:56:46 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF8139
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:56:39 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 153B01401C1;
        Tue, 26 Sep 2023 19:56:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id D0A6D2002B;
        Tue, 26 Sep 2023 19:56:34 +0000 (UTC)
Message-ID: <1adcfeaa4bd01d59a349daa697cc007e81bc81b1.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: warn about multi-line comments without
 an empty /* line
From:   Joe Perches <joe@perches.com>
To:     Petr Tesarik <petr@tesarici.cz>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>
Date:   Tue, 26 Sep 2023 12:56:33 -0700
In-Reply-To: <20230926192400.19366-1-petr@tesarici.cz>
References: <20230926192400.19366-1-petr@tesarici.cz>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: D0A6D2002B
X-Stat-Signature: siki54z4m5k3ukbiesczeso7s1xon815
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18RwV7z2XZ+CEopVkA3HcOUH900IhNfLeI=
X-HE-Tag: 1695758194-275211
X-HE-Meta: U2FsdGVkX19eaIHF7ga9cpIj2HzEocOD1G5G1zoL9dh0T7+33NcAGFYcMNv+7nw6fOEt1cMJw9CiOKTKFYPZnnm+B3B8NEONBJICHFyOunWMm3TDNQO0eGvO4MHtA81SMKE/ILTGnNJeuzjvkMjbLpYur6mNsNhgVY5DyaYGFaDs4vvKjDYBApu2MiygD24dDfOCmGDsBzj0EdZ6ED1o4S+DGKUqUWk4Dyg3UwdOHsSxnp9/Dve8tPKj5HomSh9BE00mb8e5WHqxXePXrXVJfhBNOjYUkQvKK6alfpSgetMr1mLI0rFvAgfMBaIH9z+U
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 21:24 +0200, Petr Tesarik wrote:
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
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4006,6 +4006,14 @@ sub process {
>  			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>  		}
>  
> +# Non-networking without an initial /*
> +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
> +		    $prevrawline =~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
> +		    $rawline =~ /^\+[ \t]*\*/) {
> +			WARN("BLOCK_COMMENT_STYLE",
> +			     "multi-line block comments should start with an empty /* line\n" . $hereprev);
> +		}
> +
>  # Block comments use * on subsequent lines
>  		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
>  		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*

Still nack.  Too many existing instances.

$ git grep '/\*.*' -- '*.[ch]' | \
  grep -v '/\*.*\*/' | \
  grep -v -P "/\*\s*$" | \
  grep -v '/\*\*' | \
  grep -v "SPDX-License" | \
  grep -v -P '^drivers/net|^net/' | \
  wc -l
51834


