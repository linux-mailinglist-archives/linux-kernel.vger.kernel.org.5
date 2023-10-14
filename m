Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A27E7C95B5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 19:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjJNRXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJNRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 13:23:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9930D8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 10:23:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b2cee55056so542468066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1697304199; x=1697908999; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BHon3+6fMcyIPAc0hS9MZwVEhIjaxCRNkaJRhXQQno=;
        b=lmXSr5RYiCc2175nmqhwy94b20UxlhmArTeMoNKvtGPz95+wLxSjwhs048hXz1wNFX
         Z4t4AL1mM562JPe9YZQXQnAUKtVvsTNgqnfzv7tu0AmR3xuZRuMQhAPPer43OwP1514y
         gpMqj2JJ9h9ty9XGcrxf05l9AC0XdYAUcnLlxs4QDNGSZI1+5feypoF7XUWqFY4r/EuZ
         F/PN0KK1RrUE9uIO7mWWNa3KEdwAU899bWdJA3d8XWRLdX06cnhPxQdFh2hcD3KZL3y5
         4Bn2mZdsrY/1chUmiX74AjFllFAEOu9HrarYJ0VX6j1fazpzMfXVIV+NS9vLFbRRSINt
         2yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697304199; x=1697908999;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BHon3+6fMcyIPAc0hS9MZwVEhIjaxCRNkaJRhXQQno=;
        b=MAxMkK0jDGxVkBMe/tKV0ieY0lQppHdg2gT4Hd9eCw8VJ6dXVavA1XR9NhvjGYBoo5
         WjmsLBbA9UQAtQ5WDlAtk7J1ONZTnPTlkSYACMpJoUs9I3qnyDEUs3jhqk+4NEljfmHq
         7X7k05eKkLuGYfW9vt924QRBlCq/4n/JODKHY6xZeb1GEo3AXGKAx2lSO6AFDN9nkxH8
         iSYXJFt7YAypQxXRbGaRfe0ahlpNSXVDHbSAaB1HQY+8kamd3Ry58/SJ39BuLn2dPfEX
         lGU6I4ZhY6y8qujmgomrUCzHzDmp7+DTuAUx2CoykzLzqu45+gELoOeJj1Bc15RuqESw
         zs2A==
X-Gm-Message-State: AOJu0YwP932CGm5Cn1qqCbCGt3634Tjfv3pV90jywUXA7KsoudcRMV5l
        RQo2haQSd8j+8eudcMil/ejAWQ==
X-Google-Smtp-Source: AGHT+IHE8QH0v2eQPI1wz/WDxC8yPBlGcb46CqZ8/cn946zuzG2oCsctzwK+RuxaqqX6irsakSKBsg==
X-Received: by 2002:a17:907:9486:b0:9be:f71d:9471 with SMTP id dm6-20020a170907948600b009bef71d9471mr1481941ejc.68.1697304199144;
        Sat, 14 Oct 2023 10:23:19 -0700 (PDT)
Received: from capella.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id bt8-20020a0564020a4800b0053e4783afbasm2215091edb.63.2023.10.14.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 10:23:18 -0700 (PDT)
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date:   Sat, 14 Oct 2023 19:22:44 +0200
Subject: [PATCH] get_maintainer: correctly parse UTF-8 encoded names in
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231014-get-maintainers-utf8-v1-1-3af8c7aeb239@bang-olufsen.dk>
X-B4-Tracking: v=1; b=H4sIAGPOKmUC/x2MMQqAMAwAvyKZDdhWRfyKOJSaagarpFUE6d8tD
 jfccPdCJGGKMFYvCN0c+QhFVF2B22xYCXkpDrrRRjWqxZUS7pZDKpBEvJIf0GjXd65dej9YKOk
 p5Pn5t9Oc8weerN/1ZgAAAA==
To:     Joe Perches <joe@perches.com>
Cc:     =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

While the script correctly extracts UTF-8 encoded names from the
MAINTAINERS file, the regular expressions damage my name when parsing
from .yaml files. Fix this by replacing the Latin-1-compatible regular
expressions with the unicode property matcher \p{Latin}. It's also
necessary to instruct Perl to open all files with UTF-8 encoding.

The issue was also identified on the b4 mailing list [1]. This should
solve the observed side effects there as well.

Link: https://lore.kernel.org/all/20230726-gush-slouching-a5cd41@meerkat/ [1]
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 scripts/get_maintainer.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..cb78e11623a6 100755
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
+	my @poss_addr = $text =~ m$[\p{Latin}\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
 	push(@file_emails, clean_file_emails(@poss_addr));
     }
 }
@@ -2460,13 +2461,13 @@ sub clean_file_emails {
 	    $name = "";
 	}
 
-	my @nw = split(/[^A-Za-zÀ-ÿ\'\,\.\+-]/, $name);
+	my @nw = split(/[^\p{Latin}\'\,\.\+-]/, $name);
 	if (@nw > 2) {
 	    my $first = $nw[@nw - 3];
 	    my $middle = $nw[@nw - 2];
 	    my $last = $nw[@nw - 1];
 
-	    if (((length($first) == 1 && $first =~ m/[A-Za-z]/) ||
+	    if (((length($first) == 1 && $first =~ m/\p{Latin}/) ||
 		 (length($first) == 2 && substr($first, -1) eq ".")) ||
 		(length($middle) == 1 ||
 		 (length($middle) == 2 && substr($middle, -1) eq "."))) {

---
base-commit: 70f8c6f8f8800d970b10676cceae42bba51a4899
change-id: 20231014-get-maintainers-utf8-32c65c4d6f8a

