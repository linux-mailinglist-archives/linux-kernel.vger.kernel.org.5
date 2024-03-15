Return-Path: <linux-kernel+bounces-104636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5CC87D154
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9D7281D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0245954;
	Fri, 15 Mar 2024 16:44:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9E3BB28
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521051; cv=none; b=blLpXxWzIUwiI7tlbJxNnFh8CY9vyewPPktqcHNGsDGTpUGli+kLt9EaEBAFmQrM0bJYMqK6fV7Ru1a6M9lPuD5RdpYK0GW+5fzzouYYeDE++wGlPYZDlcYw38jwZsnYiEzh8Cuhn1tUnJCaOHVmdhazlB/UbdqebjYoQPWI0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521051; c=relaxed/simple;
	bh=754d/MCAy85ow4tVxawUX/SPqIUnGxfiIpLT0IQOX+s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ONdg/2czm8s/yrJwAMsouhn65n726rbmueR+Jl0utFGeujUHLn/lJ8kNHosd2P0P2Il8cMX8nBHBBQ0mmkzjoxyq2kgKchB7DmiVeq1EUFTp1/9o4e5DJuz5wwXh63RpUP3mbXRrtIGKsBH6w6LR1Pw3XK3/9TLJMpRWVOHxVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4527BC43390;
	Fri, 15 Mar 2024 16:44:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rlAhN-000000033Ga-10Ou;
	Fri, 15 Mar 2024 12:46:25 -0400
Message-ID: <20240315164625.101518642@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Mar 2024 12:46:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 1/2] ktest.pl: Process variables within variables
References: <20240315164601.705819502@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Allow a variable to contain another variable. This will allow the
${shell <command>} to have its command include variables.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 829f5bdfd2e4..4383729e0fc2 100755
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
-- 
2.43.0



