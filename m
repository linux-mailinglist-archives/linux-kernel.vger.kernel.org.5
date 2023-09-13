Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FED79F2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjIMUiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjIMUiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:38:05 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63261BC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:38:01 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 7DDED1A0DB3;
        Wed, 13 Sep 2023 20:38:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 668C42000E;
        Wed, 13 Sep 2023 20:37:58 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Silva <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] checkpatch: Simplify creating search strings
Date:   Wed, 13 Sep 2023 13:37:51 -0700
Message-ID: <ef2ab1a00367e201879d9bff44a2e7e936b87a7e.1694636817.git.joe@perches.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694636817.git.joe@perches.com>
References: <cover.1694636817.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 668C42000E
X-Spam-Status: No, score=4.89
X-Rspamd-Server: rspamout06
X-Stat-Signature: aig5jh5ba1bsssmfixgizfssewqsei5t
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19uOctU2Ce8H1bSgmQLe4M/7y7V0x72Py4=
X-HE-Tag: 1694637478-717840
X-HE-Meta: U2FsdGVkX1+8zdzFunbnL6OYE3TD/jnVW9qkuNeJy91kNora1rdp3TEvaPjQlUttQeEqUdrxLr2S5VEbtnwHGv7ozUcuQNZhBm2bXCOm+8vBY3V0ue70BrLDe5p0M5+av18oI319qtPXeVYgsC8nlHDms8wxEFDn5d0kfiYX56S/etsyCk1zRysKMp666vY9K36+SeHfNUbMKTLqI2Kqz943GVsHaXfSn/mn4X9fb7Wxhchf1eKD7oDoxsQ1Mih29BMkN8YGZGbQ/b1dNq6P0IGnrE5FEujbOdDLNgH4fq2dCpEW4fpPz9x3I67/zJkNJQfta3rcCqs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use join and map instead of loops.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1c..617f9e53bacdf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -625,18 +625,8 @@ our $signature_tags = qr{(?xi:
 our @link_tags = qw(Link Closes);
 
 #Create a search and print patterns for all these strings to be used directly below
-our $link_tags_search = "";
-our $link_tags_print = "";
-foreach my $entry (@link_tags) {
-	if ($link_tags_search ne "") {
-		$link_tags_search .= '|';
-		$link_tags_print .= ' or ';
-	}
-	$entry .= ':';
-	$link_tags_search .= $entry;
-	$link_tags_print .= "'$entry'";
-}
-$link_tags_search = "(?:${link_tags_search})";
+our $link_tags_search = '(?:' . join('|', @link_tags) . ')';
+our $link_tags_print = "'" . join("' or '", @link_tags) . "'";
 
 our $tracing_logging_tags = qr{(?xi:
 	[=-]*> |
@@ -819,15 +809,10 @@ our @mode_permission_funcs = (
 	["__ATTR", 2],
 );
 
-my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
-
 #Create a search pattern for all these functions to speed up a loop below
-our $mode_perms_search = "";
-foreach my $entry (@mode_permission_funcs) {
-	$mode_perms_search .= '|' if ($mode_perms_search ne "");
-	$mode_perms_search .= $entry->[0];
-}
-$mode_perms_search = "(?:${mode_perms_search})";
+our $mode_perms_search = '(?:' . join('|', map{$_->[0]} @mode_permission_funcs) . ')';
+
+my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
 
 our %deprecated_apis = (
 	"synchronize_rcu_bh"			=> "synchronize_rcu",
@@ -847,12 +832,7 @@ our %deprecated_apis = (
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-our $deprecated_apis_search = "";
-foreach my $entry (keys %deprecated_apis) {
-	$deprecated_apis_search .= '|' if ($deprecated_apis_search ne "");
-	$deprecated_apis_search .= $entry;
-}
-$deprecated_apis_search = "(?:${deprecated_apis_search})";
+our $deprecated_apis_search = '(?:' . join('|', keys %deprecated_apis) . ')';
 
 our $mode_perms_world_writable = qr{
 	S_IWUGO		|
@@ -887,7 +867,7 @@ foreach my $entry (keys %mode_permission_string_types) {
 	$mode_perms_string_search .= '|' if ($mode_perms_string_search ne "");
 	$mode_perms_string_search .= $entry;
 }
-our $single_mode_perms_string_search = "(?:${mode_perms_string_search})";
+our $single_mode_perms_string_search = '(?:' . join('|', keys %mode_permission_string_types) . ')';
 our $multi_mode_perms_string_search = qr{
 	${single_mode_perms_string_search}
 	(?:\s*\|\s*${single_mode_perms_string_search})*
-- 
2.41.0

