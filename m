Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE30B7EFD56
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346437AbjKRC61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjKRC6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:58:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFAE171A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:58:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da07b5e6f75so3291476276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700276295; x=1700881095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6470cZa62MbyzT9ybBeTXZeWGQJ3Ep0Ies1ZAhH/GQQ=;
        b=A+K7W2goGY3rCRjchC7VMQq7Xg5AZwcYYzysdc+2u8ff3LvNEE0oRpHfJT18UQp+Tj
         Vxw/Lz5R2tV0BLDhuOImU1MSL3Eg9uhp71m6ky1ddK6jEsjTzkD5gCBFRfOYPPXMi8tD
         Vd66AYhHa+2IAEhxWB6Gp5C7k+eWK6MqJYDmh840RN97lJz+JqpDREwsU3HbnR2k/nez
         EikZnDIXaXE3L4gBVpvI3eGFXzYY/imHZ0LocduIXhhiYQLeOl6cz68zvws80d2rreEo
         P2lkWaIIOGoQCq8prnhBAGj67Bn4bNAxq4u8hvkakG8K4fXsd5SbazKYGcAstfApcoJe
         6JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700276295; x=1700881095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6470cZa62MbyzT9ybBeTXZeWGQJ3Ep0Ies1ZAhH/GQQ=;
        b=Iv2fdifOKW1t6OgePmyWFMtV/ImdL+rGzmcPD3Wk4pP7ESMqGCmJen7IG2oQSWQQR1
         /mMyjM2YApjkMP7d99NwD5vt6njyxOUS+PYNZzi5leZL6JerAngmrjycVc5IV/qk5wiF
         dlR12ETGq4UG6u5CLN1EIWw1vesVD2tjLPzvubZn21eoB+e0iN4Dfkflg/J1KTuY4fwi
         GFEaHIbPcCCjNgMEy3XSRVA8t9whre7b+dm6UuuiQ42fDCt3qeM5OPUnKUdERHdQqy5L
         9FZbdInua99sJm5FSt4Cj1fdG3bVQeZ5iqKSzQkvti2LgOZfjwtUcSHV61R3IuqE9Xkx
         dw2g==
X-Gm-Message-State: AOJu0YzycjMbEBz4f4eEL0I/xyR1u5wMwI5rb49bPV3WJq5uW6ilMD3x
        uS3F031sgquLfa/Azb9NgiEQ2XUomsvq
X-Google-Smtp-Source: AGHT+IE0p+YtnUfNXyViuu9ji/lc0sYzrwa5eOwzdtBv1fKlqv6arjeB7wtV3bdeWily94YGEBFtqUBG97qg
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a5b:cc9:0:b0:da0:37e1:558e with SMTP id
 e9-20020a5b0cc9000000b00da037e1558emr26098ybr.6.1700276295405; Fri, 17 Nov
 2023 18:58:15 -0800 (PST)
Date:   Sat, 18 Nov 2023 02:54:46 +0000
In-Reply-To: <20231118025748.2778044-1-mmaurer@google.com>
Mime-Version: 1.0
References: <20231118025748.2778044-1-mmaurer@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231118025748.2778044-6-mmaurer@google.com>
Subject: [PATCH v2 5/5] export_report: Use new version info format
From:   Matthew Maurer <mmaurer@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Laura Abbott <laura@labbott.name>,
        Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new version info format has a superset of symbols in the old format.
Since this is a tool for in-tree modules, we don't need to parse the old
one with this tool any longer.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/export_report.pl | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index dcef915405f3..6a37df6f947f 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -114,31 +114,29 @@ foreach my $thismod (@allcfiles) {
 	}
 
 	my $state=0;
+	# State map:
+	# 0 - Looking for names
+	# 1 - Scanning names
+	# 2 - Done
 	while ( <$module> ) {
 		chomp;
 		if ($state == 0) {
-			$state = 1 if ($_ =~ /static const struct modversion_info/);
+			$state = 1 if ($_ =~ /__used __section\("__version_ext_names"\)/);
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
-			next;
-		}
-		if ($state == 2) {
-			if ( $_ =~ /};/ ) {
-				$state = 3;
-				next;
-			}
-			if ( $_ !~ /0x[0-9a-f]+,/ ) {
+			if ( $_ =~ /;/ ) {
+				$state = 2;
 				next;
 			}
-			my $sym = (split /([,"])/,)[4];
+			$_ =~ /"(.*)\\0"/;
+			my $sym = $1;
 			my ($module, $value, $symbol, $gpl) = @{$SYMBOL{$sym}};
 			$SYMBOL{ $sym } =  [ $module, $value+1, $symbol, $gpl];
 			push(@{$MODULE{$thismod}} , $sym);
 		}
 	}
-	if ($state != 3) {
+	if ($state != 2) {
 		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
 		$modversion_warnings++;
 	}
-- 
2.43.0.rc0.421.g78406f8d94-goog

