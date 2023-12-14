Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96BA813400
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573640AbjLNPHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573629AbjLNPHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:07:06 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF611B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:07:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
        t=1702566427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zr4tfF93uxRBpIQm7Itom01eR+K81zCOIkvaVvYrtXk=;
        b=UGdfi8uYqVky/1c2eFLH/hEl/cC3Bz7hK8JrlIAob3vCyWoLsEvryHvgy07v1XRwssOG4e
        C+zm0VCGsNFbLjcbMzKC+nIwNpOl2jUzCV3sLvLd674iYFjuUMELiVCC7lzpPAJp8h+C5s
        eqGSgIqFaL7E9liVCBYkpxKCIlx1uqT0PvR3e+XQARyMnR8+zecjWc1B2+LCcpbr87XIwd
        mQ75u7Gb3Cksdqi8FgBuse2EsTV4QegXl8z3sF3M6F3N++XdD+RzaxtMquCxpnFEuC+U/1
        fzC3EXBIY5o+ojtiP0BHqKTKZjFDRbuJcxjxOvA6miKuc64FPljItvMrJcxi4Q==
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date:   Thu, 14 Dec 2023 16:06:53 +0100
Subject: [PATCH v2] get_maintainer: correctly parse UTF-8 encoded names in
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231214-get-maintainers-utf8-v2-1-b188dc7042a4@bang-olufsen.dk>
X-B4-Tracking: v=1; b=H4sIAAwae2UC/4WOTQ6CMBCFr0Jm7RjaIiIr72FYlDKFiVpMWxoN4
 e5WLuDiLb6XvJ8VAnmmAG2xgqfEgWeXQR4KMJN2IyEPmUGWUolSVDhSxKdmF7PIB1yibVBJU59
 MNdS20ZCjL0+W33vtrcs8cYiz/+wrSfzcP4VJoEClbWPOmnqpLtc+n8H5sdhA7jjcodu27Qukz
 Ts+vgAAAA==
To:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

While the script correctly extracts UTF-8 encoded names from the
MAINTAINERS file, the regular expressions damage my name when parsing
from .yaml files. Fix this by replacing the Latin-1-compatible regular
expressions with the unicode property matcher \p{L}, which matches on
any letter according to the Unicode General Category of letters. It's
also necessary to instruct Perl to open all files with UTF-8 encoding.

The issue was also identified on the tools mailing list [1]. This should
solve the observed side effects there as well.

Link: https://lore.kernel.org/tools/20230726-gush-slouching-a5cd41@meerkat/ [1]
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
Changes in v2:
- use '\p{L}' rather than '\p{Latin}', so that matching is even more
  inclusive (i.e. match also Greek letters, CJK, etc.)
- fix commit message to refer to tools mailing list, not b4 mailing list
- Link to v1: https://lore.kernel.org/r/20231014-get-maintainers-utf8-v1-1-3af8c7aeb239@bang-olufsen.dk
---
 scripts/get_maintainer.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..344d0cda9854 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -20,6 +20,7 @@ use Getopt::Long qw(:config no_auto_abbrev);
 use Cwd;
 use File::Find;
 use File::Spec::Functions;
+use open qw(:std :encoding(UTF-8));
 
 my $cur_path = fastgetcwd() . '/';
 my $lk_path = "./";
@@ -442,7 +443,7 @@ sub maintainers_in_file {
 	my $text = do { local($/) ; <$f> };
 	close($f);
 
-	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
+	my @poss_addr = $text =~ m$[\p{L}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
 	push(@file_emails, clean_file_emails(@poss_addr));
     }
 }
@@ -2460,13 +2461,13 @@ sub clean_file_emails {
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

---
base-commit: 70f8c6f8f8800d970b10676cceae42bba51a4899
change-id: 20231014-get-maintainers-utf8-32c65c4d6f8a

