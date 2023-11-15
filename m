Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AE07ECAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjKOTAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjKOTAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:00:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE00D43
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:00:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7aa161b2fso99285647b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700074803; x=1700679603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6470cZa62MbyzT9ybBeTXZeWGQJ3Ep0Ies1ZAhH/GQQ=;
        b=4F9f/PlCKtRx7V1hZe909E6AwhIsYPhqxk9dh1iti+PCbOAVyeMH4urKb2sqYe/Ly1
         mwbHASr108CSm+17WGX+Oqhu5XAj+BKdm3aFbEs7RP8jxMs5f2r/d8VFYLaNyLDLVPCF
         X/c3seVu/YsX+mW2PJ7NO3kvqgUhERFu4vRwd9YYVQ2f/S1YfOK+CClbiKgwQEr5hCHE
         WduQeUQuMCaIODu64K/FgexOLWOQoIMHKupLCAmAcVmn97ZPbTKjaJNVFhrtjNatv61p
         kj9AdrTdrXcoWwK1/cc5wv6/r/OD1VPGdMIWvM04mTxepRE5nxCI8OOmTwNSwPu6sJj6
         eXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700074803; x=1700679603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6470cZa62MbyzT9ybBeTXZeWGQJ3Ep0Ies1ZAhH/GQQ=;
        b=tJ9zG6HvekAEKC90br+zGC/nidOsfp/LmT3vpkFCySatkB1lL/T4eTSzc+u6eSeONF
         WoV11uMXercruokFdxbKMf2FQwd3fOECR21A73KDbBTj9AI+cTlhsmVdlBGU6ad0zsDe
         EEbDlZl8orTjjSHM5OhAef3+bJR7DG4G5hV8jD9ZzRTNINeejEWj+9Hz7KLXsLmpy9J6
         1/v/tPiZ4eSZ1cTeH8GvYAYylwLW7gCYQ5OUGeYGcgV4t+KNIq5Q5XkNvfZP3+hyrFjd
         zshneN0FWTJHOwbiuV/W6baDlVSCcbz8ecab5gaB01jeJlrIF8ll/GeV3NXrJ4aF9NPh
         HPng==
X-Gm-Message-State: AOJu0YzMe9bD3OcoOHvdsf4ndFawUC4fZ9ZhuHCJIUnSufVqf7DRX7Mm
        LLvgPpZEs58G+ZholNXFtS3SW5+RYYHR
X-Google-Smtp-Source: AGHT+IGj4F/MXm7B2Wfl0eZemMfQuMvtUIwlG9Eh1CjSAp9v4p9E13xAtW+esLZaxt/mw4nmhALmNh6bxkNc
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a81:49ca:0:b0:59b:e97e:f7df with SMTP id
 w193-20020a8149ca000000b0059be97ef7dfmr357547ywa.2.1700074803419; Wed, 15 Nov
 2023 11:00:03 -0800 (PST)
Date:   Wed, 15 Nov 2023 18:50:11 +0000
In-Reply-To: <20231115185858.2110875-1-mmaurer@google.com>
Mime-Version: 1.0
References: <20231115185858.2110875-1-mmaurer@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115185858.2110875-4-mmaurer@google.com>
Subject: [PATCH 3/3] export_report: Use new version info format
From:   Matthew Maurer <mmaurer@google.com>
To:     gary@garyguo.net, masahiroy@kernel.org,
        Matthew Maurer <mmaurer@google.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

