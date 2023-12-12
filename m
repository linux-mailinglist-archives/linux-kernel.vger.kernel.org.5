Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1D80F604
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376710AbjLLTHY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 14:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:07:23 -0500
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8764D93
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:07:29 -0800 (PST)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 83586A0AA6;
        Tue, 12 Dec 2023 19:07:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id AC6D460009;
        Tue, 12 Dec 2023 19:07:23 +0000 (UTC)
Message-ID: <74126e6e301d2f4a0e5a546caa54961dbc2d492c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use utf-8 match for spell checking
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        =?ISO-8859-1?Q?Cl=E9ment?= Le Goffic 
        <clement.legoffic@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Date:   Tue, 12 Dec 2023 11:07:22 -0800
In-Reply-To: <20231212094310.3633-1-antonio.borneo@foss.st.com>
References: <20231212094310.3633-1-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: AC6D460009
X-Stat-Signature: w5n7g444nosr9atuewo16cpfkdo4myh4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19HSExzuAnmITnpGMOOhmfORfXhjn61ikg=
X-HE-Tag: 1702408043-976277
X-HE-Meta: U2FsdGVkX1+qu2fsds+XWX0ynq9IUdQllRFbwE5CL+N19JiQH2TZmrxd8yiWLMztmVJnsfG6mCuWKsrRztDBPx9H9Q68VfHgwSKwHMgdoWmW6aApliF1xHTKVtl7TS3tN2qV+tVrWr5z3vqSMiul5Xxwx40GLUZ2ty3hkYPTYsddFNJlkkPPYXGJYEeArG5xo97Pyw1uSirZJifx5nUp0yP6CypEBIMsq5eBq5/b4aKibqMK3SKQ2rLhmHRpNMos1urMaPKn450vlPJmR1uVkG1TMACEF2mXt1hxHARHpJWZahcZYhgkdX9T4UeHilNYQxxV3wp9SVfvEJowHkJ7r3jz7ZX3ooqkq9q3ztFhk/QnPg6TM2jDzUxIMwPWU3LFdKC4EyoZDTtPUzTbcgGEzyTtXqpHTubMT/GLvqJSjZf9MvTkLOdeUTfZXAokxWsJ
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-12 at 10:43 +0100, Antonio Borneo wrote:
> The current code that checks for misspelling verifies, in a more
> complex regex, if $rawline matches [^\w]($misspellings)[^\w]
> 
> Being $rawline a byte-string, a utf-8 character in $rawline can
> match the non-word-char [^\w].
> E.g.:
> 	./script/checkpatch.pl --git 81c2f059ab9
> 	WARNING: 'ment' may be misspelled - perhaps 'meant'?
> 	#36: FILE: MAINTAINERS:14360:
> 	+M:     Clément Léger <clement.leger@bootlin.com>
> 	            ^^^^
> 
> Use a utf-8 version of $rawline for spell checking.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Reported-by: Clément Le Goffic <clement.legoffic@foss.st.com>

Seems sensible, thanks, but:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3477,7 +3477,8 @@ sub process {
>  # Check for various typo / spelling mistakes
>  		if (defined($misspellings) &&
>  		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> -			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
> +			my $rawline_utf8 = decode("utf8", $rawline);
> +			while ($rawline_utf8 =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
>  				my $typo = $1;
>  				my $blank = copy_spacing($rawline);

Maybe this needs to use $rawline_utf8 ?

>  				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);

And may now the $fix bit will not always work properly

