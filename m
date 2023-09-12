Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C079D806
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbjILRv5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbjILRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:51:30 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7297E172A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:51:26 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 1356BC0C80;
        Tue, 12 Sep 2023 17:51:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id F3C3820;
        Tue, 12 Sep 2023 17:51:22 +0000 (UTC)
Message-ID: <5d72679f634080c8df3c2269495267171cf72f66.camel@perches.com>
Subject: Re: [PATCH][next] checkpatch: add a couple new alloc functions to
 alloc with multiplies check
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Tue, 12 Sep 2023 10:51:22 -0700
In-Reply-To: <ZQCaO+tYycDxVLy7@work>
References: <ZQCaO+tYycDxVLy7@work>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: F3C3820
X-Stat-Signature: 86ozqfui8k7wrzihz1m85s33xhgpwb4w
X-Spam-Status: No, score=-3.60
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/j0GjjU0r9vPLT6NVNCwg85GfWKfClFE8=
X-HE-Tag: 1694541082-375569
X-HE-Meta: U2FsdGVkX1+MdnxPkBdOQ1O7sKJvTpMNOWdK9dspbgFgUFqDB9yz8nq2cBP2f/ngzL1bgDEJRR5eqEk4nddE6HB6yF/ZWSO7EdWqkxx261iyaOa/ox21SSPNCi9jWsfmmDmpKpogDxa++IwOQQ4JirLCa/FEyZgxWX5httIDYBntzC6CrhCdGy8QRJjbU/ecYmOyDDovaVWnwRpfwZGKbBGtGC45JRn0pmqwA0HCopWFjWeOOPgAfQxZ9zc2h8WWU2nEqTxuZ0fNpTgvVId53GaE7rGDp2lZQWo4r1MPvJ2MSI7jWAzyR3aeq5c7gtrJCGbzidtTm3B4a3mgcsKh21wA+pb/XcW2HHykQpRnzWRENTcCexVZBQG5LGbDM8BFWSU18kGe1dFwWDYSqvtKyA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-12 at 11:04 -0600, Gustavo A. R. Silva wrote:
> vmalloc() and vzalloc() functions have now 2-factor multiplication
> argument forms vmalloc_array() and vcalloc(), correspondingly.

> Add alloc-with-multiplies checks for these new functions.
> 
> Link: https://github.com/KSPP/linux/issues/342
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  scripts/checkpatch.pl | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7d16f863edf1..45265d0eee1b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7207,17 +7207,19 @@ sub process {
>  			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
>  		}
>  
> -# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
> +# check for (kv|k|v)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/vmalloc_array/kvcalloc/kcalloc/vcalloc
>  		if ($perl_version_ok &&
>  		    defined $stat &&
> -		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
> +		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,?/) {
>  			my $oldfunc = $3;
>  			my $a1 = $4;
>  			my $a2 = $10;
>  			my $newfunc = "kmalloc_array";
>  			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
> +			$newfunc = "vmalloc_array" if ($oldfunc eq "vmalloc");
>  			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
>  			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
> +			$newfunc = "vcalloc" if ($oldfunc eq "vzalloc");
>  			my $r1 = $a1;
>  			my $r2 = $a2;
>  			if ($a1 =~ /^sizeof\s*\S/) {
> @@ -7233,7 +7235,7 @@ sub process {
>  					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
>  				    $cnt == 1 &&
>  				    $fix) {
> -					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> +					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k|v)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
>  				}
>  			}
>  		}

Seems ok.  Dunno how many more of these there might be like
devm_ variants, but maybe it'd be better style to use a hash
with replacement instead of the repeated if block

Something like:
---
 scripts/checkpatch.pl | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1c..bacb63518be14 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -854,6 +854,23 @@ foreach my $entry (keys %deprecated_apis) {
 }
 $deprecated_apis_search = "(?:${deprecated_apis_search})";
 
+our %alloc_with_multiply_apis = (
+	"kmalloc"		=> "kmalloc_array",
+	"kvmalloc"		=> "kvmalloc_array",
+	"vmalloc"		=> "vmalloc_array",
+	"kvzalloc"		=> "kvcalloc",
+	"kzalloc"		=> "kcalloc",
+	"vzalloc"		=> "vcalloc",
+);
+
+#Create a search pattern for all these strings to speed up a loop below
+our $alloc_with_multiply_search = "";
+foreach my $entry (keys %alloc_with_multiply_apis) {
+	$alloc_with_multiply_search .= '|' if ($alloc_with_multiply_search ne "");
+	$alloc_with_multiply_search .= $entry;
+}
+$alloc_with_multiply_search = "(?:${alloc_with_multiply_search})";
+
 our $mode_perms_world_writable = qr{
 	S_IWUGO		|
 	S_IWOTH		|
@@ -7210,14 +7227,11 @@ sub process {
 # check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*($alloc_with_multiply_search)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
 			my $oldfunc = $3;
+			my $newfunc = $alloc_with_multiply_apis{$oldfunc};
 			my $a1 = $4;
 			my $a2 = $10;
-			my $newfunc = "kmalloc_array";
-			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
-			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
-			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
 			if ($a1 =~ /^sizeof\s*\S/) {
@@ -7233,7 +7247,7 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*($alloc_with_multiply_search)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
 				}
 			}
 		}

