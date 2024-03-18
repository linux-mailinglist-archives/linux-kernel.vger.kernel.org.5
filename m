Return-Path: <linux-kernel+bounces-106352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2FE87ECE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CAA281034
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AA852F87;
	Mon, 18 Mar 2024 16:00:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F86374CB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777645; cv=none; b=Y/oJ5PIxi3HTznrTWmAs8uePCT2d3LzJMQxqNP/p9aiCeToO0fgOC2jHGCUKuwDeRZym+6YcpPh09jjEJNNdvMHyq/bBrEBPt0wnvlBIgwXrfddvTj24ZyXF4iLXWaYht6z8dRwH6OXzzMGx17/T7XLiQIlUQgoFbXs/J6bK0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777645; c=relaxed/simple;
	bh=rgVJ9QL1+rhP+vexbQFE0b5PuvlMLSk2rqnz/XEb6Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=E9hNsc42TdEDmyVGWPXVvirjyfU8DGc9pf7YxWg0aaHk+n1uy6TsaRt2eRCbs5iksmeoevQVXiApYGrt6ITxe+0QtVaztHN+uFyd2e3WqDcvr++Uxq37IzSKM1SSFz9vKN9bw1pGiJsyGhFnCdln1Er2Qil7ocRzCRp8Xv/gkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8BFC433C7;
	Mon, 18 Mar 2024 16:00:44 +0000 (UTC)
Date: Mon, 18 Mar 2024 12:03:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, John 'Warthog9' Hawley
 <warthog9@kernel.org>, "Ricardo B. Marliere" <ricardo@marliere.net>
Subject: [GIT PULL] ktest: Updates for 6.9
Message-ID: <20240318120304.3c471ffa@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

ktest updates for v6.9:

- Allow variables to contain variables. This makes the shell commands
  have a bit more flexibility to reuse existing variables.

- Have make_warnings_file in build-only mode require limited variables

  The make_warnings_file test will create a file with all existing
  warnings (which can be used to compare against in builds with
  new commits). Add it to the build-only list that doesn't require
  other variables (like how to reset a machine), as the make_warnings_file
  makes the most sense on build only tests.


Please pull the latest ktest-v6.9 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v6.9

Tag SHA1: aeafd5e2cbb670b6175ea7dc079b10920037f98d
Head SHA1: 07283c1873a4d0eaa0e822536881bfdaea853910


Ricardo B. Marliere (1):
      ktest: force $buildonly = 1 for 'make_warnings_file' test type

Steven Rostedt (1):
      ktest.pl: Process variables within variables

----
 tools/testing/ktest/ktest.pl | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)
---------------------------
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 829f5bdfd2e4..eb31cd9c977b 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -792,13 +792,13 @@ sub process_variables {
     my $retval = "";
 
     # We want to check for '\', and it is just easier
-    # to check the previous characet of '$' and not need
+    # to check the previous character of '$' and not need
     # to worry if '$' is the first character. By adding
     # a space to $value, we can just check [^\\]\$ and
     # it will still work.
     $value = " $value";
 
-    while ($value =~ /(.*?[^\\])\$\{(.*?)\}(.*)/) {
+    while ($value =~ /(.*?[^\\])\$\{([^\{]*?)\}(.*)/) {
 	my $begin = $1;
 	my $var = $2;
 	my $end = $3;
@@ -818,16 +818,20 @@ sub process_variables {
 	    # we simple convert to 0
 	    $retval = "${retval}0";
 	} else {
-	    # put back the origin piece.
-	    $retval = "$retval\$\{$var\}";
+	    # put back the origin piece, but with $#### to not reprocess it
+	    $retval = "$retval\$####\{$var\}";
 	    # This could be an option that is used later, save
 	    # it so we don't warn if this option is not one of
 	    # ktests options.
 	    $used_options{$var} = 1;
 	}
-	$value = $end;
+	$value = "$retval$end";
+	$retval = "";
     }
-    $retval = "$retval$value";
+    $retval = $value;
+
+    # Convert the saved variables with $####{var} back to ${var}
+    $retval =~ s/\$####/\$/g;
 
     # remove the space added in the beginning
     $retval =~ s/ //;
@@ -843,6 +847,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we

