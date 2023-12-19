Return-Path: <linux-kernel+bounces-4552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC0817F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58FF1F21B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75BE1FAE;
	Tue, 19 Dec 2023 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="lfnekWpA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706E15B1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1702949137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDBV8cJaB7iV+TTP4pZBNgMOM9Qt20Xbuc5uqu6VF04=;
	b=lfnekWpAB6CzsHQTX6yE3W9MFHdgtKLUx+4hEtPY/9stmu7C/2VGc05jgGkTH1x/jOpqs8
	ng9+j8baGfujv1RHW0M44wwhjI0cz9SjOZq0T1H08gqzHJmLylyuYPJFKAyqpzVasBifih
	OgTGD5tseC6RYuU6emWw1lkSbBiYxApssqU59LuNkvdVt1lIeKk9QiOWx5Xy0ky/jHJ6J0
	NHIaPUv67bZZHYsUbbZX7OkRDceSVRkfGKpeplV5sMLL5uzE0uCUccQzPXaVZ3qwOLD1jV
	ITxlvoapBY1LwCsayvq8vj/UKuHlIIJesyN2jZiyzO6N8Xu77j/2DOdnVT5Bvw==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date: Tue, 19 Dec 2023 02:25:14 +0100
Subject: [PATCH v3 1/2] get_maintainer: correctly parse UTF-8 encoded names
 in files
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231219-get-maintainers-utf8-v3-1-f85a39e2265a@bang-olufsen.dk>
References: <20231219-get-maintainers-utf8-v3-0-f85a39e2265a@bang-olufsen.dk>
In-Reply-To: <20231219-get-maintainers-utf8-v3-0-f85a39e2265a@bang-olufsen.dk>
To: Joe Perches <joe@perches.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT

From: Alvin Šipraga <alsi@bang-olufsen.dk>

While the script correctly extracts UTF-8 encoded names from the
MAINTAINERS file, the regular expressions damage my name when parsing
from .yaml files. Fix this by replacing the Latin-1-compatible regular
expressions with the unicode property matcher \p{L}, which matches on
any letter according to the Unicode General Category of letters.

The proposed solution only works if the script uses proper string
encoding from the outset, so instruct Perl to unconditionally open all
files with UTF-8 encoding. This should be safe, as the entire source
tree is either UTF-8 or ASCII encoded anyway. See [1] for a detailed
analysis.

Furthermore, to prevent the \w expression from matching non-ASCII when
checking for whether a name should be escaped with quotes, add the /a
flag to the regular expression. The escaping logic was duplicated in two
places, so it has been factored out into its own function.

The original issue was also identified on the tools mailing list [2].
This should solve the observed side effects there as well.

Link: https://lore.kernel.org/all/dzn6uco4c45oaa3ia4u37uo5mlt33obecv7gghj2l756fr4hdh@mt3cprft3tmq/ [1]
Link: https://lore.kernel.org/tools/20230726-gush-slouching-a5cd41@meerkat/ [2]
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 scripts/get_maintainer.pl | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 16d8ac6005b6..dac38c6e3b1c 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -20,6 +20,7 @@ use Getopt::Long qw(:config no_auto_abbrev);
 use Cwd;
 use File::Find;
 use File::Spec::Functions;
+use open qw(:std :encoding(UTF-8));
 
 my $cur_path = fastgetcwd() . '/';
 my $lk_path = "./";
@@ -445,7 +446,7 @@ sub maintainers_in_file {
 	my $text = do { local($/) ; <$f> };
 	close($f);
 
-	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
+	my @poss_addr = $text =~ m$[\p{L}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
 	push(@file_emails, clean_file_emails(@poss_addr));
     }
 }
@@ -1152,6 +1153,17 @@ sub top_of_kernel_tree {
     return 0;
 }
 
+sub escape_name {
+    my ($name) = @_;
+
+    if ($name =~ /[^\w \-]/ai) {  	 ##has "must quote" chars
+	$name =~ s/(?<!\\)"/\\"/g;       ##escape quotes
+	$name = "\"$name\"";
+    }
+
+    return $name;
+}
+
 sub parse_email {
     my ($formatted_email) = @_;
 
@@ -1169,13 +1181,9 @@ sub parse_email {
 
     $name =~ s/^\s+|\s+$//g;
     $name =~ s/^\"|\"$//g;
+    $name = escape_name($name);
     $address =~ s/^\s+|\s+$//g;
 
-    if ($name =~ /[^\w \-]/i) {  	 ##has "must quote" chars
-	$name =~ s/(?<!\\)"/\\"/g;       ##escape quotes
-	$name = "\"$name\"";
-    }
-
     return ($name, $address);
 }
 
@@ -1186,13 +1194,9 @@ sub format_email {
 
     $name =~ s/^\s+|\s+$//g;
     $name =~ s/^\"|\"$//g;
+    $name = escape_name($name);
     $address =~ s/^\s+|\s+$//g;
 
-    if ($name =~ /[^\w \-]/i) {          ##has "must quote" chars
-	$name =~ s/(?<!\\)"/\\"/g;       ##escape quotes
-	$name = "\"$name\"";
-    }
-
     if ($usename) {
 	if ("$name" eq "") {
 	    $formatted_email = "$address";
@@ -2462,13 +2466,13 @@ sub clean_file_emails {
 	    $name = "";
 	}
 
-	my @nw = split(/[^A-Za-zÀ-ÿ\'\,\.\+-]/, $name);
+	my @nw = split(/[^\p{L}\'\,\.\+-]/, $name);
 	if (@nw > 2) {
 	    my $first = $nw[@nw - 3];
 	    my $middle = $nw[@nw - 2];
 	    my $last = $nw[@nw - 1];
 
-	    if (((length($first) == 1 && $first =~ m/[A-Za-z]/) ||
+	    if (((length($first) == 1 && $first =~ m/\p{L}/) ||
 		 (length($first) == 2 && substr($first, -1) eq ".")) ||
 		(length($middle) == 1 ||
 		 (length($middle) == 2 && substr($middle, -1) eq "."))) {

-- 
2.43.0


