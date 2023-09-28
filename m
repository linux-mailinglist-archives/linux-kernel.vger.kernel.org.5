Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779C47B11AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjI1EqL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 00:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1EqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:46:09 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879FC122;
        Wed, 27 Sep 2023 21:46:06 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id DD6D7C01D8;
        Thu, 28 Sep 2023 04:46:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 05D4320027;
        Thu, 28 Sep 2023 04:46:01 +0000 (UTC)
Message-ID: <bf9200e2fc9c55187f2b7661a3b5043f56b0deff.camel@perches.com>
Subject: Re: [PATCH v2 1/2] get_maintainer: add patch-only keyword-matching
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Date:   Wed, 27 Sep 2023 21:46:01 -0700
In-Reply-To: <20230928-get_maintainer_add_d-v2-1-8acb3f394571@google.com>
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
         <20230928-get_maintainer_add_d-v2-1-8acb3f394571@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 05D4320027
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: qeinrsmei3ja19axxtycfdr5dscit6dg
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX185vXcL/b9usz0C882foflJofFvwxVo9/w=
X-HE-Tag: 1695876361-983820
X-HE-Meta: U2FsdGVkX18CCCe4hmse5fZo10tEdxpz+jjkXnAdw6Lv8ijYTtK1ZWrjgSejmbS0yCyQG0ApORtEPcUQbrO4o/yYrFxqXxjE5Euckpge7CNz364G8VuZUpST3//rK31y0GjJRDYXPPJnpGkHBAxpzZz5kF7fLJQMvGnjOaq6YY3mu7ZoAPmuNmnI8NSqNuXssiPawWUXDVpmmcZakmHWNtp7VmBhizCjfLXh28yewW9fW5WRDNZwRh1R8KzZ/JaBrytKoZBJHoR3XxYmFktktopYVlZCsgyWOjO29kmsn0QlOYxyQd4gxjcUJTKpjA6v1CLSjmtPeUZPcR7GuN9ThoXYb++5h7TmR2BHutCbZbTNuDe/dc4/cZfPtUwaowknIGAQx/nBAfFrPeW/j+4nydQOEXmBDD++B8/PlAt9T8GdcGuimwODUT4oV5+A+I/UtJ9b6jkUxXY=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> Add the "D:" type which behaves the same as "K:" but will only match
> content present in a patch file.
> 
> To illustrate:
> 
> Imagine this entry in MAINTAINERS:
> 
> NEW REPUBLIC
> M: Han Solo <hansolo@rebelalliance.co>
> W: https://www.jointheresistance.org
> D: \bstrncpy\b
> 
> Our maintainer, Han, will only be added to the recipients if a patch
> file is passed to get_maintainer (like what b4 does):
> $ ./scripts/get_maintainer.pl 0004-some-change.patch
> 
> If the above patch has a `strncpy` present in the subject, commit log or
> diff then Han will be to/cc'd.
> 
> However, in the event of a file from the tree given like:
> $ ./scripts/get_maintainer.pl ./lib/string.c
> 
> Han will not be noisily to/cc'd (like a K: type would in this
> circumstance)
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  MAINTAINERS               |  5 +++++
>  scripts/get_maintainer.pl | 12 ++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b19995690904..94e431daa7c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -59,6 +59,11 @@ Descriptions of section entries and preferred order
>  	      matches patches or files that contain one or more of the words
>  	      printk, pr_info or pr_err
>  	   One regex pattern per line.  Multiple K: lines acceptable.
> +  D: *Diff content regex* (perl extended) pattern match that applies only to
> +     patches and not entire files (e.g. when using the get_maintainers.pl
> +     script).
> +     Usage same as K:.
> +
>  
>  Maintainers List
>  ----------------
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index ab123b498fd9..a3e697926ddd 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -342,6 +342,7 @@ if ($tree && !top_of_kernel_tree($lk_path)) {
>  
>  my @typevalue = ();
>  my %keyword_hash;
> +my %patch_keyword_hash;
>  my @mfiles = ();
>  my @self_test_info = ();
>  
> @@ -369,8 +370,10 @@ sub read_maintainer_file {
>  		    $value =~ s@([^/])$@$1/@;
>  		}
>  	    } elsif ($type eq "K") {
> -		$keyword_hash{@typevalue} = $value;
> -	    }
> +          $keyword_hash{@typevalue} = $value;
> +	    } elsif ($type eq "D") {
> +          $patch_keyword_hash{@typevalue} = $value;
> +      }
>  	    push(@typevalue, "$type:$value");
>  	} elsif (!(/^\s*$/ || /^\s*\#/)) {
>  	    push(@typevalue, $line);
> @@ -607,6 +610,11 @@ foreach my $file (@ARGV) {
>  			push(@keyword_tvi, $line);
>  		    }
>  		}
> +    foreach my $line(keys %patch_keyword_hash) {
> +      if ($patch_line =~ m/${patch_prefix}$patch_keyword_hash{$line}/x) {
> +        push(@keyword_tvi, $line);
> +      }
> +    }
>  	    }
>  	}
>  	close($patch);
> 


My opinion: Nack.

I think something like this would be better
as it avoids duplication of K and D content.
---
 scripts/get_maintainer.pl | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..07e7d744cadb 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -57,6 +57,7 @@ my $subsystem = 0;
 my $status = 0;
 my $letters = "";
 my $keywords = 1;
+my $keywords_in_file = 0;
 my $sections = 0;
 my $email_file_emails = 0;
 my $from_filename = 0;
@@ -272,6 +273,7 @@ if (!GetOptions(
 		'letters=s' => \$letters,
 		'pattern-depth=i' => \$pattern_depth,
 		'k|keywords!' => \$keywords,
+		'kf|keywords-in-file!' => \$keywords_in_file,
 		'sections!' => \$sections,
 		'fe|file-emails!' => \$email_file_emails,
 		'f|file' => \$from_filename,
@@ -318,6 +320,7 @@ if ($sections || $letters ne "") {
     $subsystem = 0;
     $web = 0;
     $keywords = 0;
+    $keywords_in_file = 0;
     $interactive = 0;
 } else {
     my $selections = $email + $scm + $status + $subsystem + $web;
@@ -548,16 +551,14 @@ foreach my $file (@ARGV) {
 	$file =~ s/^\Q${cur_path}\E//;	#strip any absolute path
 	$file =~ s/^\Q${lk_path}\E//;	#or the path to the lk tree
 	push(@files, $file);
-	if ($file ne "MAINTAINERS" && -f $file && $keywords) {
+	if ($file ne "MAINTAINERS" && -f $file && $keywords && $keywords_in_file) {
 	    open(my $f, '<', $file)
 		or die "$P: Can't open $file: $!\n";
 	    my $text = do { local($/) ; <$f> };
 	    close($f);
-	    if ($keywords) {
-		foreach my $line (keys %keyword_hash) {
-		    if ($text =~ m/$keyword_hash{$line}/x) {
-			push(@keyword_tvi, $line);
-		    }
+	    foreach my $line (keys %keyword_hash) {
+		if ($text =~ m/$keyword_hash{$line}/x) {
+		    push(@keyword_tvi, $line);
 		}
 	    }
 	}
@@ -1076,6 +1077,7 @@ Output type options:
 Other options:
   --pattern-depth => Number of pattern directory traversals (default: 0 (all))
   --keywords => scan patch for keywords (default: $keywords)
+  --keywords-in-file => scan file for keywords (default: $keywords_in_file)
   --sections => print all of the subsystem sections with pattern matches
   --letters => print all matching 'letter' types from all matching sections
   --mailmap => use .mailmap file (default: $email_use_mailmap)
@@ -1086,7 +1088,7 @@ Other options:
 
 Default options:
   [--email --tree --nogit --git-fallback --m --r --n --l --multiline
-   --pattern-depth=0 --remove-duplicates --rolestats]
+   --pattern-depth=0 --remove-duplicates --rolestats --keywords]
 
 Notes:
   Using "-f directory" may give unexpected results:

