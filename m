Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3327ECADD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjKOS7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKOS7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:59:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3398DC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:59:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da04776a869so8303369276.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700074775; x=1700679575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua0IE78OI3V4iuwp2QSoKWUWADgF+ZXc9DJoA62znV8=;
        b=HrwQrn8i6dDUjmKum1vuBdPBQaYWlguTAXN3RxpHfzbQUWsd3mwTNYJNMwnx58MYVR
         a2UwHaB/M+uadfbJkmwrDU1nYRT+OaeOG4NyZvRzkDkrFUi8fPIIVX/EMjJl4ZBxjHQT
         U2k0RUEFeQgn8EzG/52Wd0VqEVtz1he9Vd7FIch7+ql8Z/Ep4WjMvnFhiU80RgMQ4DN+
         z1ze2ck7CZNYDqUv0uDWzFg8hv7khfbZ8qUqFGvmqlmHRpG2eJyxhCvYeCcueBuhy1Y5
         UH7YYuB8ZofaJm2bAKgT/l0w6FCrL+biEA8GTPy6ibsJ4TDIVIZrGBh6ot+bvjIqcOL+
         TaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700074775; x=1700679575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua0IE78OI3V4iuwp2QSoKWUWADgF+ZXc9DJoA62znV8=;
        b=mvymVG6W1/+uy18+vUupk9epNi1ZNqr+CaSfCKk+zW/q8TmLorRE/rWre9z7L6UDgw
         j0DQr8ttLA4nORXpptDXOHJIV7FfQQuKMWWyG8z8AxDKgSW2eS9LDbRg84nNz+9ZS6hx
         a+kawIqMpH+FCmRCWEUe+z/EAUDWbPSKjk59E5mxuvjOfCpV+6EjEurW6kODdK6anU2n
         hhc5TmNa0agBk0ALFH7mL3y6TcodnrvJA6fmbjvOCMz75wZMHObt4Q0lp69r7EGB4E/i
         NUan4jUQkih2cyeFMFY5oJCRGLtA08QQF+qP/ZoRQbNoro3+Xdpyh2nQdJblqaZeaj6G
         G6Kg==
X-Gm-Message-State: AOJu0YzhCYFgkItUZYFuSNcD7V6lz/QGhujLcai25tjFgoo+AaE/SBYr
        lWN9Hsl7k6XieuxYdr8EH744q4U9OeZR
X-Google-Smtp-Source: AGHT+IG4WTHgqONtffzlqF6zScXN91i8USvwLBDkxy3oKiW24KlItT0ymbvPzefkJqrXnqbgEVkRxRRI9mn0
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:3441:0:b0:da0:c49a:5feb with SMTP id
 b62-20020a253441000000b00da0c49a5febmr310470yba.4.1700074775178; Wed, 15 Nov
 2023 10:59:35 -0800 (PST)
Date:   Wed, 15 Nov 2023 18:50:09 +0000
In-Reply-To: <20231115185858.2110875-1-mmaurer@google.com>
Mime-Version: 1.0
References: <20231115185858.2110875-1-mmaurer@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115185858.2110875-2-mmaurer@google.com>
Subject: [PATCH 1/3] export_report: Rehabilitate script
From:   Matthew Maurer <mmaurer@google.com>
To:     gary@garyguo.net, masahiroy@kernel.org,
        Matthew Maurer <mmaurer@google.com>
Cc:     linux-kernel@vger.kernel.org
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

* modules.order has .o files when in a build dir, support this
* .mod.c source layout has changed, update regexes to match
* Add a stage 3, to be more robust against additional .mod.c content

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/export_report.pl | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index feb3d5542a62..dcef915405f3 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -55,6 +55,7 @@ sub collectcfiles {
     open my $fh, '< modules.order' or die "cannot open modules.order: $!\n";
     while (<$fh>) {
 	s/\.ko$/.mod.c/;
+	s/\.o$/.mod.c/;
 	push (@file, $_)
     }
     close($fh);
@@ -120,10 +121,14 @@ foreach my $thismod (@allcfiles) {
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__attribute__\(\(section\("__versions"\)\)\)/);
+			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
 			next;
 		}
 		if ($state == 2) {
+			if ( $_ =~ /};/ ) {
+				$state = 3;
+				next;
+			}
 			if ( $_ !~ /0x[0-9a-f]+,/ ) {
 				next;
 			}
@@ -133,7 +138,7 @@ foreach my $thismod (@allcfiles) {
 			push(@{$MODULE{$thismod}} , $sym);
 		}
 	}
-	if ($state != 2) {
+	if ($state != 3) {
 		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
 		$modversion_warnings++;
 	}
-- 
2.43.0.rc0.421.g78406f8d94-goog

