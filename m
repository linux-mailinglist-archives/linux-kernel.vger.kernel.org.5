Return-Path: <linux-kernel+bounces-280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C3813EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FEC1C2206D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9EE7E4;
	Fri, 15 Dec 2023 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MScOnLKC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F721806
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1f055438492so94038fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 16:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702599337; x=1703204137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3vxsSYcJl7kxjEI0DE/6eMOwd60Yeadj9yTz3Q7bO4A=;
        b=MScOnLKCRwKUM8ocPotQhTx4tecNw1nbnNTnORHhe7DaorVTsZ3sMOtM1KT93SpPqp
         EdYDTLL+uWzNea07LWbnAkh3pOc0rc8oFSnF9rWfb39jiNOrAvTJYnMMi1oHL9PmXWFB
         Y7ghkZ3ZYdWu1ewlhcrG5VrtstzuFRJHFO6gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702599337; x=1703204137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vxsSYcJl7kxjEI0DE/6eMOwd60Yeadj9yTz3Q7bO4A=;
        b=dbIIUeiIcMKx+sL8NULQ1XPLPZZoAwUTK3WGgh+92A5KdnUasdIV9eyRe2A8vJFDej
         9p6ShPzWC795sbRV8UkLsb2QTww/OyOrm/zPDA/k/unHF+imFL0zvMbK38yrNt1BaQKQ
         NSIbPPqTdVB10usF8zA/wKJKzGoVYTo5/97csrkfVjX0xK6M05OHHFuiY0S8YXyesuVu
         enoLrlh0fD3yIviTRD9QoAQqShu7aaQDnAaJClIf8YfLS8AZMlQIqVW/tIOesZ6wzafG
         6lZllL3ajFmb8spc6m99nq4G6EnOIYFo9NsDuVqHadZBS/lW0Q+eECebcvdEgzReMIus
         n2VQ==
X-Gm-Message-State: AOJu0Yx9dPx94mxCxKSSGZuFwnMaLtU2Ar66W7EEM/KSCDVJZ8bgdRpk
	/t3YFJzNexS+WIOtnHwy58zbzw==
X-Google-Smtp-Source: AGHT+IHFRmua4bfn43gLFDa9bkrDQeU7FxUvYPviaakD/OpweZOXYdoagupozxPjgB1z0T0xAhmzxA==
X-Received: by 2002:a05:6871:5214:b0:1fb:75b:1306 with SMTP id ht20-20020a056871521400b001fb075b1306mr13210128oac.88.1702599337638;
        Thu, 14 Dec 2023 16:15:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm12295937pgg.50.2023.12.14.16.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:15:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] scripts: kernel-doc: Disambiguate origin of warnings
Date: Thu, 14 Dec 2023 16:15:35 -0800
Message-Id: <20231215001535.work.434-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982; i=keescook@chromium.org;
 h=from:subject:message-id; bh=FcgzlnnYVUiulfG4TMJAtGChKc9AwWvF2yVBcOfI0aI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBle5qn/WNMSKjhxrdtusfP6tHCylX5qfzPX7ZUn
 +6z7C4JvVeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXuapwAKCRCJcvTf3G3A
 Jk7TD/9rPD8v7z1WFt7sk+BstGNvtlczv6+GNHoCati8N43Vq/g5880r4J5usQyvVeBe/NoKkWg
 JDAexchPcffhIBQQUYErMVwwoQkxsZIGdJJ+daU1N1ni+9nud2e18HnghYck01L2rOyWlU0g12w
 p6w94ili61MOU2+BRAT5x+hAd7Lx9sz/WbSsIBCf04myb2ogXT5wIb4u/UwUtdu0ee1TEOtptqv
 BhC+w+QMQ0xOOKJgxaLtNzIGUpYNgCxQ0SRUsIItbG6b/wibXgEENCxEc5ftBAEVi1CTXb5mdYH
 CWBVG7fPLuXvXmCXm1+H4hgMpykH0hILIMCoOwHnF8CtPSI50qKMNLzxoRj+Aj7AcmXzGGhUiL4
 MtjlaFPb25DfiK9LWC+p3g3JHIOPGP9JGps8Q1aMn2CyDstZq1dOcsGUgGOBZP54syTB4sn1o+3
 n/ZWEQVnxPPeJooDaT5eW1e6ox1fDqETHxmfXikVb6mdGytc6DGq4UF8BpSqTPHtMw7sctoXn8G
 hUFLdqvhF85y25Hp8/QpgA/tZ6+emZrm+6b6FUnYiLxD9uMTeEYH8mY1lUC79FB/06tS5LzWZ/9
 MpCtLvhiMacbUH2L6d1kuqs5Mnw9a3DcKWViZt8rDiGf9roG0wEN64jndzXM2L+uz4BeECEvtWf
 2bTz9Nv xb5twAtg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

There's no prefix to warnings and errors reported by scripts/kernel-doc
which makes it frustrating to isolate errors reported from CI systems.
Add a "$0: " prefix to all the STDERR output.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/kernel-doc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 41f838042364..2a7b975b03e7 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -450,7 +450,7 @@ sub print_lineno {
 sub emit_warning {
     my $location = shift;
     my $msg = shift;
-    print STDERR "$location: warning: $msg";
+    print STDERR "$0: $location: warning: $msg";
     ++$warnings;
 }
 ##
@@ -1292,7 +1292,7 @@ sub dump_struct($$) {
 			   });
     }
     else {
-	print STDERR "${file}:$.: error: Cannot parse struct or union!\n";
+	print STDERR "$0: ${file}:$.: error: Cannot parse struct or union!\n";
 	++$errors;
     }
 }
@@ -1398,7 +1398,7 @@ sub dump_enum($$) {
 			    'purpose' => $declaration_purpose
 			   });
     } else {
-	print STDERR "${file}:$.: error: Cannot parse enum!\n";
+	print STDERR "$0: ${file}:$.: error: Cannot parse enum!\n";
 	++$errors;
     }
 }
@@ -1469,7 +1469,7 @@ sub dump_typedef($$) {
 			   });
     }
     else {
-	print STDERR "${file}:$.: error: Cannot parse typedef!\n";
+	print STDERR "$0: ${file}:$.: error: Cannot parse typedef!\n";
 	++$errors;
     }
 }
@@ -1993,7 +1993,7 @@ sub process_export_file($) {
     my $file = map_filename($orig_file);
 
     if (!open(IN,"<$file")) {
-	print STDERR "Error: Cannot open file $file\n";
+	print STDERR "$0: Error: Cannot open file $file\n";
 	++$errors;
 	return;
     }
@@ -2102,7 +2102,7 @@ sub process_name($$) {
 	}
 
 	if ($verbose) {
-	    print STDERR "${file}:$.: info: Scanning doc for $decl_type $identifier\n";
+	    print STDERR "$0: ${file}:$.: info: Scanning doc for $decl_type $identifier\n";
 	}
     } else {
 	emit_warning("${file}:$.", "Cannot understand $_ on line $. - I thought it was a doc line\n");
@@ -2320,7 +2320,7 @@ sub process_file($) {
     $file = map_filename($orig_file);
 
     if (!open(IN_FILE,"<$file")) {
-	print STDERR "Error: Cannot open file $file\n";
+	print STDERR "$0: Error: Cannot open file $file\n";
 	++$errors;
 	return;
     }
@@ -2410,14 +2410,14 @@ foreach (@ARGV) {
     process_file($_);
 }
 if ($verbose && $errors) {
-  print STDERR "$errors errors\n";
+  print STDERR "$0: $errors errors\n";
 }
 if ($verbose && $warnings) {
-  print STDERR "$warnings warnings\n";
+  print STDERR "$0: $warnings warnings\n";
 }
 
 if ($Werror && $warnings) {
-    print STDERR "$warnings warnings as Errors\n";
+    print STDERR "$0: $warnings warnings as Errors\n";
     exit($warnings);
 } else {
     exit($output_mode eq "none" ? 0 : $errors)
-- 
2.34.1


