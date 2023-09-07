Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBE3797B7E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjIGSTM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIGSTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:19:09 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA0EBC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:18:48 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 3802480FB2;
        Thu,  7 Sep 2023 18:18:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 2254860010;
        Thu,  7 Sep 2023 18:18:44 +0000 (UTC)
Message-ID: <95b681074a36807e25351f9de8cb2b23aa5c7ef8.camel@perches.com>
Subject: Re: [PATCH 1/2] checkpatch: special case extern struct in .c
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, apw@canonical.com,
        Kees Cook <keescook@chromium.org>
Date:   Thu, 07 Sep 2023 11:18:42 -0700
In-Reply-To: <20230907174415.593856-1-jim.cromie@gmail.com>
References: <20230907174415.593856-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2254860010
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: eyhqc3tmgiqoiptoted3hcow99duxpyj
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18qlr7V176JSZ7MnFLtre1FXZJNRbmLG7U=
X-HE-Tag: 1694110724-923512
X-HE-Meta: U2FsdGVkX1+1dHcpe98Y++gz87DJQvVUR4veWG15SiXJoWS8bdKJvqGygdxprhlC80sNCuKyKYEvaPcO02w58DD1/Sm4U0696iLyzKhYvpvWK5JA5nyUXwFrZaUN+TUNKhsD4aOjA+HJD4xxZcyWJ6uQaNS1xVq6Pw35mi9uPpUSAfOyHHDKcJW3plq+GzoZ6hee6eX8KycOqysG/VpNfvo8H1Gwjqvyv1qNG+Kx2GEf0hFFDzcbm3HlTrA3FXvcGpNr/zewjvbPPqTPrpfuRmnm6+moh9Kk8j1TBU4I01ggfXGzflnfz0HMykiLKdSqeBjZ55k7TjrkY33ft7dc4DQsJ736lDvr8vhep9TBKuAjwZDHKcgJ5rxkFL24bc0JvqnW4UH3Tpv2zFVaZTfhMcZskSIQO74py4R5nE40wq6cXfY/l69/l/Viy1McvejQmI2WggWANb1dfxm+v05M7AFIZBk/r8Ni1D6GMl2qBz9/gwyNi3SD3hzOAMDAyuyc/pc1+fk6Ooo=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-07 at 11:44 -0600, Jim Cromie wrote:
> The warning "externs should be avoided in .c files" wants an exception
> for linker symbols (named in vmlinux.lds.h etc), like those that mark
> the __start, __stop/__end symbols delimiting many kernel sections.
> 
> Since checkpatch already checks REALNAME to avoid looking at patch
> chunks changing vmlinux.lds.h, add a new else-if block to look at them
> instead.  As a simple heuristic, treat all words (in the + patch-lines)
> as candidate symbols, to screen later warnings about the same symbols
> being found in following chunks that change *.c files.
> 
> Where the "# check for new externs in .c files." is done, precede it
> with a new else-if block to isolate one common extern-in-c use case:
> "extern struct foo bar[]".  For this case, we can issue a more
> informative warning:
> 
>   WARN("AVOID_EXTERNS",
>      "found a file-scoped extern type:$st_type name:$st_name in .c file\n"
>      . "is this a linker symbol ?\n" . $herecurr);
> 
> NOTE: The "screening" is a regex match, not an exact match.  This
> accepts __start_foo and __stop_foo symbols found in a *.c file, if
> "foo" was found previously in a vmlinux.lds.h chunk.
> 
> It does require that the patch adding "externs in .c's" also have the
> additions to vmlinux.lds.h.  And it requires vmlinux.lds.h chunks
> before .c chunks.
> 
> Cc: apw@canonical.com
> Cc: joe@perches.com
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  scripts/checkpatch.pl | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 880fde13d9b8..6aabcc1f66c1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -74,6 +74,8 @@ my $git_command ='export LANGUAGE=en_US.UTF-8; git';
>  my $tabsize = 8;
>  my ${CONFIG_} = "CONFIG_";
>  
> +my %maybe_linker_symbol; # for externs in c exceptions, when seen in *vmlinux.lds.h
> +
>  sub help {
>  	my ($exitcode) = @_;
>  
> @@ -6051,6 +6053,9 @@ sub process {
>  
>  # check for line continuations outside of #defines, preprocessor #, and asm
>  
> +		} elsif ($realfile =~ m@/vmlinux.lds.h$@) {
> +		    $line =~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
> +		    #print "REAL: $realfile\nln: $line\nkeys:", sort keys %maybe_linker_symbol;
>  		} else {
>  			if ($prevline !~ /^..*\\$/ &&
>  			    $line !~ /^\+\s*\#.*\\$/ &&		# preprocessor
> @@ -7119,6 +7124,21 @@ sub process {
>  				     "arguments for function declarations should follow identifier\n" . $herecurr);
>  			}
>  
> +		} elsif ($realfile =~ /\.c$/ && defined $stat &&
> +		    $stat =~ /^\+extern struct\s+(\w+)\s+(\w+)\[\];/)

Use the proper \s+ instead of ' '
And why use $stat instead of $sline?
Are you expecting these externs to be on multiple lines?

		} elsif ($realfile =~ /\.c$/ &&
			 $sline =~ /^\+\s*extern\s+struct\s+(\w+)\s+(\w+)\s*\[\s*\]\s*;/


> +		{
> +			my ($st_type, $st_name) = ($1, $2);
> +
> +			for my $s (keys %maybe_linker_symbol) {
> +			    #print "Linker symbol? $st_name : $s\n";
> +			    goto LIKELY_LINKER_SYMBOL

yuck.  no gotos please

Just use last

> +				if $st_name =~ /$s/;
> +			}
> +			WARN("AVOID_EXTERNS",
> +			     "found a file-scoped extern type:$st_type name:$st_name in .c file\n"
> +			     . "is this a linker symbol ?\n" . $herecurr);

Single line output required then $herecurr
Using "in .c file" is also unnecessary.

> +		  LIKELY_LINKER_SYMBOL:
> +
>  		} elsif ($realfile =~ /\.c$/ && defined $stat &&
>  		    $stat =~ /^.\s*extern\s+/)
>  		{

