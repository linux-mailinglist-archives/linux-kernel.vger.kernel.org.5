Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302880A48A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjLHNkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHNkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:40:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B021706;
        Fri,  8 Dec 2023 05:40:06 -0800 (PST)
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B32A66073AA;
        Fri,  8 Dec 2023 13:40:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702042805;
        bh=XyWarEWJXpA/T9XhTV+onEShyeWe+9A2yodWAKUFUJI=;
        h=From:To:Cc:Subject:Date:From;
        b=hwp9A3WrBnaVFqsUWe+3crnvYWmhKfcMaI94XY4ocrQvK2T0rc8PLVSHNO2jl6QRk
         OBiYSCn1CFviR5Nie9vd4o1l1dL8pYZJuPm+qGCAiTVEZT4eRGme+t17/y5YOHq+9l
         GLgYDgqP8UgabULhins15CaD/wIgQTRPG5gIN3tP3MMjGjsG22Znbo5IaiNfn0jwQK
         eDj0q8BpRMNsaYhpaEBjQdF/NlR9c4zEXzqfrr5vpd+XlHRrjVPDZbJhtYRoMG19SO
         YPvJlFcz3bBSD8LhFtMiCZ0+k5JAXaNsmC4D3ghKEWpmbkkRaFoHEzV/6gq+R19xYM
         Si0G8GPrtgBkg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftest: dt: Stop relying on dirname to improve performance
Date:   Fri,  8 Dec 2023 10:39:27 -0300
Message-ID: <20231208133955.483851-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When walking directory trees, instead of looking for specific files and
running dirname to get the parent folder, traverse all folders and
ignore the ones not containing the desired files. This avoids the need
to call dirname inside the loop, which gives a big performance boost,
approximately halving run time: Running locally on a
mt8192-asurada-spherion, which reports 160 test cases, has gone from
5.5s to 2.9s, while running remotely with an nfsroot has gone from
13.5s to 5.5s.

This change has a side-effect, which is that the root DT node now
also shows in the output, even though it isn't expected to bind to a
driver. However there shouldn't be a matching driver for the board
compatible, so the end result will be just an extra skipped test:

ok 1 / # SKIP

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/310391e8-fdf2-4c2f-a680-7744eb685177@sirena.org.uk
Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 tools/testing/selftests/dt/test_unprobed_devices.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/dt/test_unprobed_devices.sh b/tools/testing/selftests/dt/test_unprobed_devices.sh
index b07af2a4c4de..7fae90293a9d 100755
--- a/tools/testing/selftests/dt/test_unprobed_devices.sh
+++ b/tools/testing/selftests/dt/test_unprobed_devices.sh
@@ -33,8 +33,8 @@ if [[ ! -d "${PDT}" ]]; then
 fi
 
 nodes_compatible=$(
-	for node_compat in $(find ${PDT} -name compatible); do
-		node=$(dirname "${node_compat}")
+	for node in $(find ${PDT} -type d); do
+		[ ! -f "${node}"/compatible ] && continue
 		# Check if node is available
 		if [[ -e "${node}"/status ]]; then
 			status=$(tr -d '\000' < "${node}"/status)
@@ -46,10 +46,11 @@ nodes_compatible=$(
 
 nodes_dev_bound=$(
 	IFS=$'\n'
-	for uevent in $(find /sys/devices -name uevent); do
-		if [[ -d "$(dirname "${uevent}")"/driver ]]; then
-			grep '^OF_FULLNAME=' "${uevent}" | sed -e 's|OF_FULLNAME=||'
-		fi
+	for dev_dir in $(find /sys/devices -type d); do
+		[ ! -f "${dev_dir}"/uevent ] && continue
+		[ ! -d "${dev_dir}"/driver ] && continue
+
+		grep '^OF_FULLNAME=' "${dev_dir}"/uevent | sed -e 's|OF_FULLNAME=||'
 	done
 	)
 
-- 
2.43.0

