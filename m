Return-Path: <linux-kernel+bounces-85394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67786B558
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5981C233BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8953FB82;
	Wed, 28 Feb 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TbiyDmEO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704E1E516;
	Wed, 28 Feb 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139370; cv=none; b=X7iDer5e+/dpWukD3+IKg9S+43L3QQRD+Kk6NEmxNaAa9+fz9qRK6B+OQ5HT9GyV1f24UNPQ5Sxp5gkbwdWEpoIj3c3WNfXpZKl7cOEs/dHQonoU9ARmAKK2bvDc3revro1SFcwaQ/52AXsqDAKWk369EysN48dmDGqpfClGKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139370; c=relaxed/simple;
	bh=m5f7UsTub+FQSG/nsPjXIqkJlRLxrtwLhLhVNn6H5ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fm778GqPVkarJEB88t13DPIPC4FrQ/RHcQlaTg4WQbAQYN1TL4m6zVuVETouaYH1sfIRMCTmYHHTp9mL0idetbAfGUzSBghLPC9iuUjui5U+KS1Km0Nbfg0Y9Y+eQioPHCbyCphdaW0LIHoF+AnRlIUGt/f40OugmPM0xPInHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TbiyDmEO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709139365;
	bh=m5f7UsTub+FQSG/nsPjXIqkJlRLxrtwLhLhVNn6H5ok=;
	h=From:To:Cc:Subject:Date:From;
	b=TbiyDmEOjcPlR/19QYVfiEgA4rt4uBmH6wejZAaGopYNCIcFxxRWl75kkXdxUQ7h+
	 F3NnbSTNyUl29eg4CoZI+6htJC/S/uLyTaEElnKdu64ZXByLXIMQsVPcBaGjwK1g5i
	 G3zuEuk9dhYUQMWvcxjG+uQ8Md7V6U2WarUskHoXuxtpy8xQfdvJVCHrxVJSeon+/R
	 ai8CzRnDpPayE7ylbLZg/FnjOsJ2cNiUe5WuDNOhpOhShByBmoTyl2C577SiK0RC/w
	 QySa9dsx/DLiRwmy/ZNaVTUgwvJFQH69ny0nyu2asPlQjSlgo5ARmbRwkLz0hZkntc
	 /MymFNgFtUsuA==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 954CF37820D9;
	Wed, 28 Feb 2024 16:56:04 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH] test-media: Add basic tests for visl
Date: Wed, 28 Feb 2024 11:56:08 -0500
Message-ID: <20240228165608.1000988-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will run the v4l2-compliance tests on the visl device, check
(un)binding and module reloading.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 contrib/test/test-media | 80 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/contrib/test/test-media b/contrib/test/test-media
index afe20760..18a4f886 100755
--- a/contrib/test/test-media
+++ b/contrib/test/test-media
@@ -9,6 +9,7 @@ vivid=0
 vim2m=0
 vimc=0
 vicodec=0
+visl=0
 cec=0
 cecpwr=--skip-test-standby-resume
 kmemleak=0
@@ -56,10 +57,11 @@ if [ -z "$1" ]; then
 	echo "vimc: test the vimc driver"
 	echo "vicodec: test the vicodec driver"
 	echo "vidtv: test the vidtv driver"
+	echo "visl: test the visl driver"
 	echo "cec: adds the vivid CEC compliance tests, except for the CEC standby/wakeup tests."
 	echo "cec-pwr: adds the vivid CEC compliance tests, including the CEC standby/wakeup tests."
-	echo "all: equals 'vivid vim2m vimc vicodec vidtv cec cec-pwr'"
-	echo "mc: equals 'vivid vim2m vimc vicodec vidtv'"
+	echo "all: equals 'vivid vim2m vimc vicodec vidtv visl cec cec-pwr'"
+	echo "mc: equals 'vivid vim2m vimc vicodec vidtv visl'"
 	exit 0
 fi
 
@@ -118,6 +120,7 @@ while [ ! -z "$1" ]; do
 		vim2m=1
 		vimc=1
 		vicodec=1
+		visl=1
 		cec=1
 		cecpwr=
 		;;
@@ -127,6 +130,7 @@ while [ ! -z "$1" ]; do
 		vimc=1
 		vicodec=1
 		vidtv=1
+		visl=1
 		;;
 	vidtv)
 		vidtv=1
@@ -143,6 +147,9 @@ while [ ! -z "$1" ]; do
 	vicodec)
 		vicodec=1
 		;;
+	visl)
+		visl=1
+		;;
 	cec)
 		cec=1
 		cecpwr=--skip-test-standby-resume
@@ -239,6 +246,75 @@ if [ $vivid -eq 1 -a $setup -eq 0 ]; then
 	echo
 fi
 
+if [ $visl -eq 1 -a $setup -eq 0 ]; then
+	dmesg -n notice
+	echo
+	echo loading visl module | tee /dev/kmsg
+	modprobe visl
+	sleep $modprobe_time
+	echo
+	echo visl compliance tests | tee /dev/kmsg
+	echo
+	date
+	stdbuf -oL $v4l2_compliance -m platform:visl -P -s10 -a 2>&1 | tee -a $tmp
+	echo
+	echo unbind visl | tee /dev/kmsg
+	echo
+	echo -n visl.0 >/sys/bus/platform/drivers/visl/unbind
+	sleep $unbind_time
+	echo
+	echo rebind visl | tee /dev/kmsg
+	echo
+	echo -n visl.0 >/sys/bus/platform/drivers/visl/bind
+	sleep 1
+	echo
+	echo second unbind visl | tee /dev/kmsg
+	echo
+	for i in `$v4l2_ctl -z platform:visl --list-devices`; do
+		let "t = 1 + $RANDOM / 4096"
+		echo $i: sleep ${t}s
+		sleep $t <$i &
+	done
+	sleep 1
+	echo
+	echo -n visl.0 >/sys/bus/platform/drivers/visl/unbind
+	sleep $reunbind_time
+	echo
+	echo rmmod visl | tee /dev/kmsg
+	echo
+	rmmod visl
+	sleep $rmmod_time
+
+	if [ $kmemleak -eq 1 ]; then
+		echo
+		echo kmemleak results for visl:
+		echo
+		echo scan >/sys/kernel/debug/kmemleak
+		cat /sys/kernel/debug/kmemleak
+		echo
+		echo end of kmemleak results
+		echo
+	fi
+
+	modprobe visl
+	sleep $modprobe_time
+
+	$v4l2_ctl -z platform:visl --all
+
+	if [ $kmemleak -eq 1 ]; then
+		echo clear >/sys/kernel/debug/kmemleak
+	fi
+	echo
+	echo
+	echo
+	echo
+	echo
+	echo
+	echo
+	echo
+fi
+
+
 if [ $cec -eq 1 ]; then
 	dmesg -n notice
 	cec-ctl --version
-- 
2.43.0


