Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B07BADA7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjJEVf1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJEVfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:35:24 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA0B95
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:35:23 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id D3538C044C;
        Thu,  5 Oct 2023 21:35:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id E1CCC60018;
        Thu,  5 Oct 2023 21:35:18 +0000 (UTC)
Message-ID: <01fe46f0c58aa8baf92156ae2bdccfb2bf0cb48e.camel@perches.com>
Subject: [PATCH] get_maintainer: add --keywords-in-file option
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 05 Oct 2023 14:35:17 -0700
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: E1CCC60018
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: znaudhuzqxb7bcm3zyebt8hx47tdeup6
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+fFSt0IL88q4Ibii+0k4u3v7SsGFFw49k=
X-HE-Tag: 1696541718-941851
X-HE-Meta: U2FsdGVkX1+4d9ajuY2KehV0iygo73eUFfl/0sGlPh3p27Q/AXFVh65dIIuRefmqGoJHbkVr+K4jg/FRhR2x7A2YMQor9GIGiVYmHgdIEeD0TmtuYib6Dlj2g73hY/Qcq8M7Ii/LbbeG4RFyE7Hk6LOor2+DIX+yCZIxBBNyouNbUR3185I8VYe4bdvFIlwP2sH74aZtA2yi3xQYEdfUkVjtvegkkvAfcPEViE/BgMpBHkTr7azUyiWNa+gU1MrnvZzq2mOzt1wMMWb0H6xlT8HE4wfNX5GaWbdSqcAmQWeDs/Y5iTjsfD/FomnliXf0PJ3XTxCHT8DWGNijgbT8pZ4IM/RYkDTdQ5nNRILMXcyjVKl4AtJI9k7M5eON6jjab38zYukUIUjxuE4yvPJFNZvoGb1XmuTa5+3YUEIMsA3KaBEdpN/UI4n3X2t4uBDPVZSNJ5IzKO63ke/K9GXPUAGlExhRgiR+J11jtGd4G6P2J99ce3d1rvX/FSCpk2vlsmMUhIxZJgoEbySvIYj8+VWslZEtKJPSEqrTcTPriZNmZDUqbmb+/klfRHPTmDSbwZwwgpBIWgGoPtqxV6pwcg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were some recent attempts [1] [2] to make the K: field less noisy
and its behavior more obvious. Ultimately, a shift in the default
behavior and an associated command line flag is the best choice.

Currently, K: will match keywords found in both patches and files.

Matching content from entire files is (while documented) not obvious
behavior and is usually not wanted by maintainers.

Now only patch content will be matched against unless --keywords-in-file
is also provided as an argument to get_maintainer.

Add the actual keyword matched to the role or rolestats as well.

For instance given the diff below that removes clang:

   diff --git a/drivers/hid/bpf/entrypoints/README b/drivers/hid/bpf/entrypoints/README
   index 147e0d41509f..f88eb19e8ef2 100644
   --- a/drivers/hid/bpf/entrypoints/README
   +++ b/drivers/hid/bpf/entrypoints/README
   @@ -1,4 +1,4 @@
    WARNING:
    If you change "entrypoints.bpf.c" do "make -j" in this directory to rebuild "entrypoints.skel.h".
   -Make sure to have clang 10 installed.
   +Make sure to have 10 installed.
    See Documentation/bpf/bpf_devel_QA.rst

The new role/rolestats output includes ":Keyword:\b(?i:clang|llvm)\b"

$ git diff drivers/hid/bpf/entrypoints/README | .scripts/get_maintainer.pl
Jiri Kosina <jikos@kernel.org> (maintainer:HID CORE LAYER,commit_signer:1/1=100%)
Benjamin Tissoires <benjamin.tissoires@redhat.com> (maintainer:HID CORE LAYER,commit_signer:1/1=100%,authored:1/1=100%,added_lines:4/4=100%)
Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Tom Rix <trix@redhat.com> (reviewer:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:1/1=100%)
linux-input@vger.kernel.org (open list:HID CORE LAYER)
linux-kernel@vger.kernel.org (open list)
llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)

Link: https://lore.kernel.org/r/20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com
Link: https://lore.kernel.org/all/20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com
Link: https://lore.kernel.org/all/3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com
Original-patch-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..16d8ac6005b6 100755
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
+	    add_categories($line, ":Keyword:$keyword_hash{$line}");
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

