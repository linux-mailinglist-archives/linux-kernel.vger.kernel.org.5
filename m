Return-Path: <linux-kernel+bounces-4553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7732817F40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9B7285BED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DBF1FB6;
	Tue, 19 Dec 2023 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="WbvSdKXo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B615AC
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
	bh=DCcA5+GzeT7LmnAC4ZC7lotYpQkFKLlKWVTf7X6olec=;
	b=WbvSdKXocvo/vee2x/4gWhabR5oUOFwYlDUL49pFBugA3rlgQAtfZEYOnPGoFZbNEAKeQD
	L7qjo3jJwn5bQ1HLg8a78fkvseHQ2D8YawQ5IhtNdZ9+7Oy+rqfgixtH/t/w1wlYrVqScT
	Vtm59qGpbVGYDL/y4IFf51r8+d9hiADQP0fSxjMxBeTsznXA8P/e1kFzjhqClg5bNV6n5c
	iocVQ3UpcrBEilkx0w2lXyfj4Id8OXjfn9XbY3pj8quvD4X8oDeNSwGJztj/EraYGQ1EsA
	pZG+H2avnXHdNha9ldle27k5xIaN2pUFnI40PEogjJ/7jP+ITArhmrSDihh/sw==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date: Tue, 19 Dec 2023 02:25:15 +0100
Subject: [PATCH v3 2/2] get_maintainer: remove stray punctuation when
 cleaning file emails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231219-get-maintainers-utf8-v3-2-f85a39e2265a@bang-olufsen.dk>
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

When parsing emails from .yaml files in particular, stray punctuation
such as a leading '-' can end up in the name. For example, consider a
common YAML section such as:

  maintainers:
    - devicetree@vger.kernel.org

This would previously be processed by get_maintainer.pl as:

  - <devicetree@vger.kernel.org>

Make the logic in clean_file_emails more robust by deleting any
sub-names which consist of common single punctuation marks before
proceeding to the best-effort name extraction logic. The output is then
correct:

  devicetree@vger.kernel.org

Some additional comments are added to the function to make things
clearer to future readers.

Link: https://lore.kernel.org/all/0173e76a36b3a9b4e7f324dd3a36fd4a9757f302.camel@perches.com/
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 scripts/get_maintainer.pl | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index dac38c6e3b1c..ee1aed7e090c 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -2462,11 +2462,17 @@ sub clean_file_emails {
     foreach my $email (@file_emails) {
 	$email =~ s/[\(\<\{]{0,1}([A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+)[\)\>\}]{0,1}/\<$1\>/g;
 	my ($name, $address) = parse_email($email);
-	if ($name eq '"[,\.]"') {
-	    $name = "";
-	}
 
+	# Strip quotes for easier processing, format_email will add them back
+	$name =~ s/^"(.*)"$/$1/;
+
+	# Split into name-like parts and remove stray punctuation particles
 	my @nw = split(/[^\p{L}\'\,\.\+-]/, $name);
+	@nw = grep(!/^[\'\,\.\+-]$/, @nw);
+
+	# Make a best effort to extract the name, and only the name, by taking
+	# only the last two names, or in the case of obvious initials, the last
+	# three names.
 	if (@nw > 2) {
 	    my $first = $nw[@nw - 3];
 	    my $middle = $nw[@nw - 2];
@@ -2480,18 +2486,16 @@ sub clean_file_emails {
 	    } else {
 		$name = "$middle $last";
 	    }
+	} else {
+	    $name = "@nw";
 	}
 
 	if (substr($name, -1) =~ /[,\.]/) {
 	    $name = substr($name, 0, length($name) - 1);
-	} elsif (substr($name, -2) =~ /[,\.]"/) {
-	    $name = substr($name, 0, length($name) - 2) . '"';
 	}
 
 	if (substr($name, 0, 1) =~ /[,\.]/) {
 	    $name = substr($name, 1, length($name) - 1);
-	} elsif (substr($name, 0, 2) =~ /"[,\.]/) {
-	    $name = '"' . substr($name, 2, length($name) - 2);
 	}
 
 	my $fmt_email = format_email($name, $address, $email_usename);

-- 
2.43.0


