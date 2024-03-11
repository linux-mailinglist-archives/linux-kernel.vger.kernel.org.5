Return-Path: <linux-kernel+bounces-99127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A780E8783BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61378284205
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDC747F60;
	Mon, 11 Mar 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B7WJ2CQK"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52F47768
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170704; cv=none; b=cLjbRE9AaGllthY7yvSPpfC/Mfb5hFB7Q2ENX2U3yLq+1H5TGAQBeSxRfMo7tTcv0rBc3EmV+Euxc1S6F1x7ov4cgB2GJh05NuUUeiMtM8wy/NweJHwTCmf6bsEYAJMKydKYlEdTUn+v8YC0ByWxbsTPD6C7P83QhvmKZK69sY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170704; c=relaxed/simple;
	bh=8m5tTULbRwygGhNOxOOxCgJVXvWrvtn3dJnD+l/vKU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=KKK6POALkaHpKCDWye5RTQMkbuqlTdfqyoXxmQBR/h5NjnjUPe74Kc78nwYEFyZPLDB+EBqTiE48ZTVZVtFHuc4ISR/l90ziMFgkIPseoXG4NL4LX2jG9S3hvz45yIVr+obSw6r877RQXEp6K43+ncpuFajOin36JEGf65jZEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B7WJ2CQK; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C198E2000A;
	Mon, 11 Mar 2024 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710170700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8OZ8zCko77xC4qzd41Shrz3MxT07LVdca6HBrBBo7k=;
	b=B7WJ2CQKIvaWYTlfpseGUN0MkUZPO5kNbOkUQyKyEJ/E/M6djvVpMmeB8p/XOAo5wAwzhv
	XZmwSHQLIGc97bGXpX4a6W32Eh12ZCM1idi4qffiv6iiS8OCMbWEMEfIkKpcPkBlXbYllL
	iFQIJy5rtQBIp8grJY17dYpsIleKpmpkW5GI7o6aIEmWGbmEOjJNjFBONvNB6J8eDW/2PG
	ZOwbfIemkY54rvY98u/LqKoHTe8h/Yo89pIWuDUoiCxVcOv0Ahi96xVv7mm4EZ0Jv0kAO2
	JL6o/ZD0UagqlC+ak+pv9sl2FJQJ7BnkiCEzgDNrP71FWIGiCO3OuTLLSsJs1A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 11 Mar 2024 16:24:54 +0100
Subject: [PATCH 1/3] scripts/decode_stacktrace.sh: remove find_module
 recursion and improve error reporting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-decode_stacktrace-find_module-improvements-v1-1-8bea42b421aa@bootlin.com>
References: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
In-Reply-To: <20240311-decode_stacktrace-find_module-improvements-v1-0-8bea42b421aa@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

The find_module() function can fail for two reasons:

 * the module was not found
 * the module was found but without debugging info

In both cases the user is reported the same error:

   WARNING! Modules path isn't set, but is needed to parse this symbol

This is misleading in case the modules path is set correctly.

find_module() is currently implemented as a recursive function based on
global variables in order to check up to 4 different paths. This is not
straightforward to read and even less to modify.

Besides, the debuginfod code at the beginning of find_module() is executed
identlcally every time the function is entered, i.e. up to 4 times per each
module search due to recursion.

To be able to improve error reporting, first rewrite the find_module()
function to remove recursion. The new version of the function iterates over
all the same (up to 4) paths as before and for each of them does the same
checks as before. At the end of the iteration it is now able to print an
appropriate error message, so that has been moved from the caller into
find_module().

Finally, when the module is found but without debugging info, mention the
two Kconfig variables one needs to set in order to have the needed
debugging symbols.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 scripts/decode_stacktrace.sh | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index fa5be6f57b00..7f3fb5e82707 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -88,31 +88,32 @@ find_module() {
 		fi
 	fi
 
-	if [[ "$modpath" != "" ]] ; then
-		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
-			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
-				echo $fn
-				return
-			fi
-		done
-		return 1
-	fi
-
-	modpath=$(dirname "$vmlinux")
-	find_module && return
-
-	if [[ $release == "" ]] ; then
+	if [ -z $release ] ; then
 		release=$(gdb -ex 'print init_uts_ns.name.release' -ex 'quit' -quiet -batch "$vmlinux" 2>/dev/null | sed -n 's/\$1 = "\(.*\)".*/\1/p')
 	fi
+	if [ -n "${release}" ] ; then
+		release_dirs="/usr/lib/debug/lib/modules/$release /lib/modules/$release"
+	fi
 
-	for dn in {/usr/lib/debug,}/lib/modules/$release ; do
-		if [ -e "$dn" ] ; then
-			modpath="$dn"
-			find_module && return
+	found_without_debug_info=false
+	for dir in "$modpath" "$(dirname "$vmlinux")" ${release_dirs}; do
+		if [ -n "${dir}" ] && [ -e "${dir}" ]; then
+			for fn in $(find "$dir" -name "${module//_/[-_]}.ko*") ; do
+				if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
+					echo $fn
+					return
+				fi
+				found_without_debug_info=true
+			done
 		fi
 	done
 
-	modpath=""
+	if [[ ${found_without_debug_info} == true ]]; then
+		echo "WARNING! No debugging info in module ${module}, rebuild with DEBUG_KERNEL and DEBUG_INFO" >&2
+	else
+		echo "WARNING! Cannot find .ko for module ${module}, please pass a valid module path" >&2
+	fi
+
 	return 1
 }
 
@@ -130,7 +131,6 @@ parse_symbol() {
 	else
 		local objfile=$(find_module)
 		if [[ $objfile == "" ]] ; then
-			echo "WARNING! Modules path isn't set, but is needed to parse this symbol" >&2
 			return
 		fi
 		if [[ $aarray_support == true ]]; then

-- 
2.34.1


