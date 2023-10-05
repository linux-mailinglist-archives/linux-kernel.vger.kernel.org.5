Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA53A7B99FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 04:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjJEClE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 22:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjJEClC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 22:41:02 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB35C0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 19:40:59 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 585CA120217;
        Thu,  5 Oct 2023 02:40:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 76D2118;
        Thu,  5 Oct 2023 02:40:56 +0000 (UTC)
Message-ID: <3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com>
Subject: Re: [PATCH] get_maintainer/MAINTAINERS: confine K content matching
 to patches
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 04 Oct 2023 19:40:55 -0700
In-Reply-To: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com>
References: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 76D2118
X-Stat-Signature: 8cwfdmcgu6s7feiy9et55jk549jogxjp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+TyMkleSp6sZTOl272wIe+N1zs1yQjNIs=
X-HE-Tag: 1696473656-395626
X-HE-Meta: U2FsdGVkX1+YpHgP8jh2IDxzYlBdQWuu6fWm9Gh68kiSMecvGHO0zc7jgkO5unWiA0V4XgpDLsuDPywI74IEg7BHGg3IVC7decd+ojOAW04JxukfBRVj8Wkp6qe+PMPy8LBxe0r3NhjPVaerPhXEYZq9VMs0GwIPObO6qBaLixhCEVByZf9B/LNig1P2CIR17boqoVkfVq1/J3jO+sGCLdbp8zqP5XplOi/JB16EOdGtfoIfQ1t5hfsoBecbbhlbR1X2fYHymuUkdFoIl7JHgieYRfdaHDbJL+a12aDaWqSCovbUM3FY6igsRzTa7dhDg6LmwxblwGAw1X1azhXWnJucRm0auKxAnjKMnB0k5vru8yZiy7KP7w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-04 at 21:21 +0000, Justin Stitt wrote:
> The current behavior of K: is a tad bit noisy. It matches against the
> entire contents of files instead of just against the contents of a
> patch.
> 
> This means that a patch with a single character change (fixing a typo or
> whitespace or something) would still to/cc maintainers and lists if the
> affected file matched against the regex pattern given in K:. For
> example, if a file has the word "clang" in it then every single patch
> touching that file will to/cc Nick, Nathan and some lists.
> 
> Let's change this behavior to only content match against patches
> (subjects, message, diff) as this is what most people expect the
> behavior already is. Most users of "K:" would prefer patch-only content
> matching. If this is not the case let's add a new matching type as
> proposed in [1].

I'm glad to know  you are coming around to my suggestion.

I believe the file-based keyword matching should _not_ be
removed and the option should be added for it like I suggested.

I also think it might be better to mark the "maintained" output
differently as something like "keyword matched" instead.


Something like:
---
 scripts/get_maintainer.pl | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..befae75e61ab 100755
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
@@ -919,7 +920,7 @@ sub get_maintainers {
 	}
 
 	foreach my $line (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
-	    add_categories($line);
+	    add_categories($line, "");
 	    if ($sections) {
 		my $i;
 		my $start = find_starting_index($line);
@@ -947,7 +948,7 @@ sub get_maintainers {
     if ($keywords) {
 	@keyword_tvi = sort_and_uniq(@keyword_tvi);
 	foreach my $line (@keyword_tvi) {
-	    add_categories($line);
+	    add_categories($line, ":Keyword");
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
@@ -1312,7 +1314,7 @@ sub get_list_role {
 }
 
 sub add_categories {
-    my ($index) = @_;
+    my ($index, $suffix) = @_;
 
     my $i;
     my $start = find_starting_index($index);
@@ -1342,7 +1344,7 @@ sub add_categories {
 			if (!$hash_list_to{lc($list_address)}) {
 			    $hash_list_to{lc($list_address)} = 1;
 			    push(@list_to, [$list_address,
-					    "subscriber list${list_role}"]);
+					    "subscriber list${list_role}" . $suffix]);
 			}
 		    }
 		} else {
@@ -1352,12 +1354,12 @@ sub add_categories {
 				if ($email_moderated_list) {
 				    $hash_list_to{lc($list_address)} = 1;
 				    push(@list_to, [$list_address,
-						    "moderated list${list_role}"]);
+						    "moderated list${list_role}" . $suffix]);
 				}
 			    } else {
 				$hash_list_to{lc($list_address)} = 1;
 				push(@list_to, [$list_address,
-						"open list${list_role}"]);
+						"open list${list_role}" . $suffix]);
 			    }
 			}
 		    }
@@ -1365,19 +1367,19 @@ sub add_categories {
 	    } elsif ($ptype eq "M") {
 		if ($email_maintainer) {
 		    my $role = get_maintainer_role($i);
-		    push_email_addresses($pvalue, $role);
+		    push_email_addresses($pvalue, $role . $suffix);
 		}
 	    } elsif ($ptype eq "R") {
 		if ($email_reviewer) {
 		    my $subsystem = get_subsystem_name($i);
-		    push_email_addresses($pvalue, "reviewer:$subsystem");
+		    push_email_addresses($pvalue, "reviewer:$subsystem" . $suffix);
 		}
 	    } elsif ($ptype eq "T") {
-		push(@scm, $pvalue);
+		push(@scm, $pvalue . $suffix);
 	    } elsif ($ptype eq "W") {
-		push(@web, $pvalue);
+		push(@web, $pvalue . $suffix);
 	    } elsif ($ptype eq "S") {
-		push(@status, $pvalue);
+		push(@status, $pvalue . $suffix);
 	    }
 	}
     }

