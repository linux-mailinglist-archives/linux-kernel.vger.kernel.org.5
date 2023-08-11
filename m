Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88D778A25
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjHKJhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjHKJgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:36:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74430DB;
        Fri, 11 Aug 2023 02:36:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 47E8C21873;
        Fri, 11 Aug 2023 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691746594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKE2B+AUQdCdxtybXQXEsZ0s9QJcXsW1/BXKK44OcjU=;
        b=qSNGNq77DKM7JWtq3rfmyqvV/C0IP/agjhEbkZ+o9nTbF5NKRFrXqwbVQAcY01/vymDxKX
        TymlnC9YUDBFYZ6VW/LPw1/zvzPFKCPYmCMHkYPN76JbIuHIP9Ql3qdm68xYBZF8LRyXiY
        +rIW1zXyFht32b+Hm3Mio2HfIdSj5eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691746594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKE2B+AUQdCdxtybXQXEsZ0s9QJcXsW1/BXKK44OcjU=;
        b=53K+i6LQq5hUzqdEVPz5eoPgZ301Luz3gOcLNW8oI2ccmWVc7MTHGoLf2OpqpWVU17I0DX
        XhUnBdABvCLLQgBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 174AF138E2;
        Fri, 11 Aug 2023 09:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wojTAiIB1mTIHwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 09:36:34 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 08/13] nvme: Use def_file_path variable instead local variable
Date:   Fri, 11 Aug 2023 11:36:09 +0200
Message-ID: <20230811093614.28005-9-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811093614.28005-1-dwagner@suse.de>
References: <20230811093614.28005-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all tests are using the same file path name anyway, use
the def_file_path variable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/004 |  6 +++---
 tests/nvme/005 |  6 +++---
 tests/nvme/006 |  6 +++---
 tests/nvme/007 |  9 +++------
 tests/nvme/008 |  7 +++----
 tests/nvme/009 |  7 +++----
 tests/nvme/010 |  7 +++----
 tests/nvme/011 |  8 +++-----
 tests/nvme/012 |  7 +++----
 tests/nvme/013 |  7 +++----
 tests/nvme/014 |  7 +++----
 tests/nvme/015 |  7 +++----
 tests/nvme/017 | 11 ++++-------
 tests/nvme/018 |  7 +++----
 tests/nvme/019 |  7 +++----
 tests/nvme/020 |  7 +++----
 tests/nvme/021 |  7 +++----
 tests/nvme/022 |  7 +++----
 tests/nvme/023 |  7 +++----
 tests/nvme/024 |  7 +++----
 tests/nvme/025 |  7 +++----
 tests/nvme/026 |  7 +++----
 tests/nvme/027 |  7 +++----
 tests/nvme/028 |  7 +++----
 tests/nvme/029 |  7 +++----
 tests/nvme/031 |  6 +++---
 tests/nvme/040 |  7 +++----
 tests/nvme/041 |  7 +++----
 tests/nvme/042 |  7 +++----
 tests/nvme/043 |  7 +++----
 tests/nvme/044 |  7 +++----
 tests/nvme/045 |  7 +++----
 tests/nvme/047 |  7 +++----
 tests/nvme/048 |  7 +++----
 34 files changed, 103 insertions(+), 138 deletions(-)

diff --git a/tests/nvme/004 b/tests/nvme/004
index 0314ed3c949e..78b11c7b84c5 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -27,9 +27,9 @@ test() {
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	truncate -s "${nvme_img_size}" "$TMPDIR/img"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -47,7 +47,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 	losetup -d "$loop_dev"
-	rm "$TMPDIR/img"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/005 b/tests/nvme/005
index 935b8634cb96..211b8affc32a 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -27,9 +27,9 @@ test() {
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
-	truncate -s "${nvme_img_size}" "$TMPDIR/img"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -49,7 +49,7 @@ test() {
 
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	losetup -d "$loop_dev"
-	rm "$TMPDIR/img"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/006 b/tests/nvme/006
index 066acabb1175..f31633825a70 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -23,9 +23,9 @@ test() {
 	local port
 	local loop_dev
 
-	truncate -s "${nvme_img_size}" "$TMPDIR/img"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -38,7 +38,7 @@ test() {
 
 	losetup -d "$loop_dev"
 
-	rm "$TMPDIR/img"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/007 b/tests/nvme/007
index c6ba36cc4b4f..b6a4bc437103 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -20,13 +20,10 @@ test() {
 	_setup_nvmet
 
 	local port
-	local file_path
 
-	file_path="${TMPDIR}/img"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -35,7 +32,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/008 b/tests/nvme/008
index c3fbcbc59686..a38926ef0051 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -23,11 +23,10 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "${file_path}")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -50,7 +49,7 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/009 b/tests/nvme/009
index 88c27889fbe1..2c8ea7ead9b8 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -21,11 +21,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -44,7 +43,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/010 b/tests/nvme/010
index 38c062ec73f4..81f7d2024ee6 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -23,11 +23,10 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
-	local file_path="${TMPDIR}/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "${file_path}")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -51,7 +50,7 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/011 b/tests/nvme/011
index 0dab74e7e5b5..e6f78867e283 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -22,12 +22,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path
-	local file_path="${TMPDIR}/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -47,7 +45,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/012 b/tests/nvme/012
index 8ed57d3a5ab0..85549c25a1c6 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -27,11 +27,10 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
-	local file_path="${TMPDIR}/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "${file_path}")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -54,7 +53,7 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/013 b/tests/nvme/013
index e3eb4e914750..355bc2e03557 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -25,11 +25,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="${TMPDIR}/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -48,7 +47,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/014 b/tests/nvme/014
index cbafd802af16..44ae91e2210f 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -26,11 +26,10 @@ test() {
 	local size
 	local bs
 	local count
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "${file_path}")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -60,7 +59,7 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/015 b/tests/nvme/015
index b32d16a91de8..16e41ee65d42 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -25,11 +25,10 @@ test() {
 	local size
 	local bs
 	local count
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -55,7 +54,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/017 b/tests/nvme/017
index 6f7ef5882d3e..7cbf274c13b0 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -19,20 +19,17 @@ test() {
 	_setup_nvmet
 
 	local port
-	local file_path
 	local iterations="${nvme_num_iter}"
 
-	file_path="${TMPDIR}/img"
-
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	local genctr=1
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns "${def_subsysnqn}" "${i}" "${file_path}"
+		_create_nvmet_ns "${def_subsysnqn}" "${i}" "${def_file_path}"
 	done
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
@@ -49,7 +46,7 @@ test() {
 
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/018 b/tests/nvme/018
index 155f094ea6b3..d1d2082e62ac 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -23,11 +23,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -52,7 +51,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/019 b/tests/nvme/019
index 4ac351cbb782..2628dea55ac8 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -23,13 +23,12 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
-	local file_path="$TMPDIR/img"
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "${file_path}")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -52,7 +51,7 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/020 b/tests/nvme/020
index 744d4b7d6805..4a4f3c12da30 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -21,13 +21,12 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -46,7 +45,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/021 b/tests/nvme/021
index 1fd9bcbb3d23..11f82d64f378 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -22,11 +22,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -47,7 +46,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/022 b/tests/nvme/022
index 053991625250..586f6cdd3448 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -22,11 +22,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -47,7 +46,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/023 b/tests/nvme/023
index c10e5a0138a8..b13426cf5615 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -23,11 +23,10 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "${file_path}")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -52,7 +51,7 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/024 b/tests/nvme/024
index d1d7f0bfb994..b7c7b3f64321 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -22,11 +22,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -46,7 +45,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/025 b/tests/nvme/025
index ea944830612b..04ceace5840b 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -22,11 +22,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -47,7 +46,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/026 b/tests/nvme/026
index f1193c20477c..a9dc7bc15db5 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -22,11 +22,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -47,7 +46,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/027 b/tests/nvme/027
index c097c51ea4f3..fda8c61405a5 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -22,11 +22,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -46,7 +45,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/028 b/tests/nvme/028
index 6e37be4893b1..8e42ea37a634 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -22,11 +22,10 @@ test() {
 
 	local port
 	local nvmedev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -46,7 +45,7 @@ test() {
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/029 b/tests/nvme/029
index 4d0ca997404b..7988faf5dd03 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -56,11 +56,10 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "${file_path}")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -89,7 +88,7 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/031 b/tests/nvme/031
index 27b08e96dd0b..d5c2561b941b 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -33,9 +33,9 @@ test() {
 	local loop_dev
 	local port
 
-	truncate -s "${nvme_img_size}" "$TMPDIR/img"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
@@ -50,7 +50,7 @@ test() {
 
 	_remove_nvmet_port "${port}"
 	losetup -d "$loop_dev"
-	rm "$TMPDIR/img"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/040 b/tests/nvme/040
index 8d7f68f9a2d7..452ecd690edf 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -21,14 +21,13 @@ test() {
 
 	_setup_nvmet
 
-	local file_path="${TMPDIR}/img"
 	local port
 	local loop_dev
 	local nvmedev
 	local fio_pid
 
-	truncate -s "${nvme_img_size}" "${file_path}"
-	loop_dev="$(losetup -f --show "${file_path}")"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
@@ -60,7 +59,7 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm -f "${file_path}"
+	rm -f "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/041 b/tests/nvme/041
index 4c553251f379..0a0700533b7b 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -25,7 +25,6 @@ test() {
 	_setup_nvmet
 
 	local port
-	local file_path="${TMPDIR}/img"
 	local hostkey
 	local ctrldev
 
@@ -35,9 +34,9 @@ test() {
 		return 1
 	fi
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"b92842df-a394-44b1-84a4-92ae7d112861"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
@@ -69,7 +68,7 @@ test() {
 
 	_remove_nvmet_host "${def_hostnqn}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/042 b/tests/nvme/042
index 866249ed598c..9180fce17b4e 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -25,15 +25,14 @@ test() {
 	_setup_nvmet
 
 	local port
-	local file_path="${TMPDIR}/img"
 	local hmac
 	local key_len
 	local hostkey
 	local ctrldev
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
@@ -82,7 +81,7 @@ test() {
 
 	_remove_nvmet_host "${def_hostnqn}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/043 b/tests/nvme/043
index 5569a7a58ad5..f08422949efb 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -26,7 +26,6 @@ test() {
 	_setup_nvmet
 
 	local port
-	local file_path="${TMPDIR}/img"
 	local hash
 	local dhgroup
 	local hostkey
@@ -38,9 +37,9 @@ test() {
 		return 1
 	fi
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}"
@@ -84,7 +83,7 @@ test() {
 
 	_remove_nvmet_host "${def_hostnqn}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/044 b/tests/nvme/044
index 6c2cb602313c..5eb163db2c99 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -26,7 +26,6 @@ test() {
 	_setup_nvmet
 
 	local port
-	local file_path="${TMPDIR}/img"
 	local hostkey
 	local ctrlkey
 	local ctrldev
@@ -43,9 +42,9 @@ test() {
 		return 1
 	fi
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
@@ -111,7 +110,7 @@ test() {
 
 	_remove_nvmet_host "${def_hostnqn}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/045 b/tests/nvme/045
index a936e7fb661f..8364d5ec3a2b 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -27,7 +27,6 @@ test() {
 	_setup_nvmet
 
 	local port
-	local file_path="${TMPDIR}/img"
 	local hostkey
 	local new_hostkey
 	local ctrlkey
@@ -47,9 +46,9 @@ test() {
 		return 1
 	fi
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}" "${ctrlkey}"
@@ -124,7 +123,7 @@ test() {
 
 	_remove_nvmet_host "${def_hostnqn}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/047 b/tests/nvme/047
index b435dd3cecba..66032f679ae2 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -26,11 +26,10 @@ test() {
 	local nvmedev
 	local loop_dev
 	local rand_io_size
-	local file_path="$TMPDIR/img"
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	loop_dev="$(losetup -f --show "${file_path}")"
+	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
@@ -61,7 +60,7 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/048 b/tests/nvme/048
index f9a19b1e655e..6a05feae9b82 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -86,13 +86,12 @@ test() {
 	_setup_nvmet
 
 	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
-	local file_path="${TMPDIR}/img"
 	local skipped=false
 	local port
 
-	truncate -s "${nvme_img_size}" "${file_path}"
+	truncate -s "${nvme_img_size}" "${def_file_path}"
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
 		"b92842df-a394-44b1-84a4-92ae7d112861"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
@@ -124,7 +123,7 @@ test() {
 	_remove_nvmet_port "${port}"
 	_remove_nvmet_host "${def_hostnqn}"
 
-	rm "${file_path}"
+	rm "${def_file_path}"
 
 	if [[ "${skipped}" = true ]] ; then
 		return 1
-- 
2.41.0

