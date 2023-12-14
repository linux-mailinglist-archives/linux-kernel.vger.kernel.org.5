Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A08813579
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573934AbjLNP55 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 10:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjLNP5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:57:54 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C9E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:58:01 -0800 (PST)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 9121B140CA6;
        Thu, 14 Dec 2023 15:57:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id C937D20027;
        Thu, 14 Dec 2023 15:57:55 +0000 (UTC)
Message-ID: <f7510474a007223811da8b04efabf13376e53728.camel@perches.com>
Subject: Re: [PATCH v2] get_maintainer: correctly parse UTF-8 encoded names
 in files
From:   Joe Perches <joe@perches.com>
To:     Alvin =?UTF-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Duje =?UTF-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alvin =?UTF-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Shawn Guo <shawnguo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 14 Dec 2023 07:57:54 -0800
In-Reply-To: <20231214-get-maintainers-utf8-v2-1-b188dc7042a4@bang-olufsen.dk>
References: <20231214-get-maintainers-utf8-v2-1-b188dc7042a4@bang-olufsen.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: C937D20027
X-Stat-Signature: gzprjdghpxfeg6cy6iyagoo9msawof6c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/5xJ1vvWzGg4zdXvtfmVJr7Ek3eWE5S00=
X-HE-Tag: 1702569475-258753
X-HE-Meta: U2FsdGVkX1/Ae4pwXkWwvrD5QTS79zApbgYmE4Y8tn25pYgx4Admx+Esrk75UyH/mdXXiGGh6xbWnv0mQ3eMUOrdN7hApdC5B+2boH9/OPNrgfiRLPgSkKu7eS6A7PCcAnFL2yZbfcQ4FLaEj+YhoSAW9zvfcC8uSczTTl/aYcGq9MuVJoaKeLDmPHMyrZtBXSq0+7FIpOBFUiZN4HM8Cl2cjG4XERD2HF3nNMyZVeGCVDb+jmOCxiACr1IHB9Pud/oVNMXi65nRM5+/fvGHx7/XNtUyPxyp7GwvFP1KPEYBlVM7nlcw9fCseop3YBZJZKvDWQqOHTsdt3vm+i8m6TIo77+1FnIhbKFXEfxieaRot1v6gu98NTYYmAozjbPi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-12-14 at 16:06 +0100, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> While the script correctly extracts UTF-8 encoded names from the
> MAINTAINERS file, the regular expressions damage my name when parsing
> from .yaml files. Fix this by replacing the Latin-1-compatible regular
> expressions with the unicode property matcher \p{L}, which matches on
> any letter according to the Unicode General Category of letters.

OK

> It's also necessary to instruct Perl to open all files with UTF-8 encoding.

I doubt this.

> ---
> Changes in v2:
> - use '\p{L}' rather than '\p{Latin}', so that matching is even more
>   inclusive (i.e. match also Greek letters, CJK, etc.)
> - fix commit message to refer to tools mailing list, not b4 mailing list
> - Link to v1: https://lore.kernel.org/r/20231014-get-maintainers-utf8-v1-1-3af8c7aeb239@bang-olufsen.dk

OK

> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> @@ -20,6 +20,7 @@ use Getopt::Long qw(:config no_auto_abbrev);
>  use Cwd;
>  use File::Find;
>  use File::Spec::Functions;
> +use open qw(:std :encoding(UTF-8));

I think this global use is unnecessary.


> @@ -442,7 +443,7 @@ sub maintainers_in_file {
>  	my $text = do { local($/) ; <$f> };
>  	close($f);
>  
> -	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
> +	my @poss_addr = $text =~ m$[\p{L}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
>  	push(@file_emails, clean_file_emails(@poss_addr));
>      }
>  }

Rather than open _all_ files in utf-8, perhaps the block
that opens a specific file to find maintainers

sub maintainers_in_file {
    my ($file) = @_;

    return if ($file =~ m@\bMAINTAINERS$@);

    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
	open(my $f, '<', $file)
	    or die "$P: Can't open $file: $!\n";
	my $text = do { local($/) ; <$f> };
	close($f);
	...

should change the

	open(my $f...
to
	use open qw(:std :encoding(UTF-8));
	open(my $f...


And unrelated and secondarily, perhaps the
	$file =~ /\.yaml$/
test should be
	$file =~ /\.(?:yaml|dtsi?)$/

to also find any maintainer address in the dts* files

https://lore.kernel.org/lkml/20231028174656.GA3310672@bill-the-cat/T/

