Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31A0778A16
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjHKJgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjHKJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:36:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06F30D6;
        Fri, 11 Aug 2023 02:36:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C40CF1F74A;
        Fri, 11 Aug 2023 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691746586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySX0bPj+OlMTvPO100mpK3C4LxGQ/kzWWhKoP04YVHk=;
        b=VbMpFrod3ldH1MS01GB0y8S5/KfzgGqw0knj4Yf0a7mNb9GuUcGmJ0i2f6j4u+kRXlzqyx
        B08yvUOmf4paw4zh6VSGibx7xAbgkrggtmE6TK/1ziwyINk82gQKLffRHQbm9cV3FF27Zs
        BCAhl5ihDAljWjB4dlb8gre/Cni25NA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691746586;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySX0bPj+OlMTvPO100mpK3C4LxGQ/kzWWhKoP04YVHk=;
        b=fQWp79yuL39li4hY47smhIhNxqZK1RadgJCWBiMnPmdwqBmoBZem9PtSWlEuZYohlPl8u7
        Lh+JLkyPUQ1r5HAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A805F138E2;
        Fri, 11 Aug 2023 09:36:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hxgGKBoB1mSlHwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 09:36:26 +0000
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
Subject: [PATCH blktests v3 02/13] nvme: Reorganize test preamble code section
Date:   Fri, 11 Aug 2023 11:36:03 +0200
Message-ID: <20230811093614.28005-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811093614.28005-1-dwagner@suse.de>
References: <20230811093614.28005-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This unifies all the tests preamble code section.

Reorganize all tests to start with printing the test name, then
the setting nvmet and finally followed by the variable declarations.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/006 | 4 ++--
 tests/nvme/007 | 4 ++--
 tests/nvme/016 | 4 ++--
 tests/nvme/017 | 4 ++--
 tests/nvme/030 | 8 ++++----
 tests/nvme/031 | 8 ++++----
 tests/nvme/033 | 7 ++++---
 tests/nvme/034 | 7 ++++---
 tests/nvme/035 | 7 ++++---
 tests/nvme/036 | 7 ++++---
 tests/nvme/037 | 8 ++++----
 tests/nvme/038 | 6 +++---
 tests/nvme/039 | 4 ++--
 tests/nvme/040 | 7 ++++---
 tests/nvme/041 | 8 ++++----
 tests/nvme/042 | 8 ++++----
 tests/nvme/043 | 8 ++++----
 tests/nvme/044 | 8 ++++----
 tests/nvme/045 | 8 ++++----
 tests/nvme/048 | 8 ++++----
 20 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/tests/nvme/006 b/tests/nvme/006
index ea0db93791a7..b44c56b6a25d 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -18,12 +18,12 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
+	_setup_nvmet
+
 	local port
 	local loop_dev
 	local subsys_name="blktests-subsystem-1"
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "$TMPDIR/img"
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
diff --git a/tests/nvme/007 b/tests/nvme/007
index 243a79f5a254..112432df7a9d 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -17,12 +17,12 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
+	_setup_nvmet
+
 	local port
 	local file_path
 	local subsys_name="blktests-subsystem-1"
 
-	_setup_nvmet
-
 	file_path="${TMPDIR}/img"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
diff --git a/tests/nvme/016 b/tests/nvme/016
index f617cf103900..cac0c0509aca 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -16,13 +16,13 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
+	_setup_nvmet
+
 	local port
 	local iterations="${nvme_num_iter}"
 	local loop_dev
 	local subsys_nqn="blktests-subsystem-1"
 
-	_setup_nvmet
-
 	loop_dev="$(losetup -f)"
 	local genctr=1
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 3dbb7c174b56..429a25e8e011 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -16,13 +16,13 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
+	_setup_nvmet
+
 	local port
 	local file_path
 	local iterations="${nvme_num_iter}"
 	local subsys_name="blktests-subsystem-1"
 
-	_setup_nvmet
-
 	file_path="${TMPDIR}/img"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
diff --git a/tests/nvme/030 b/tests/nvme/030
index cfcdcbe6be23..a0b999cace94 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -16,14 +16,14 @@ requires() {
 }
 
 test() {
-	local port
-	local genctr
-	local subsys="blktests-subsystem-"
-
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
 
+	local port
+	local genctr
+	local subsys="blktests-subsystem-"
+
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
diff --git a/tests/nvme/031 b/tests/nvme/031
index e70898819a86..27b08e96dd0b 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -24,15 +24,15 @@ requires() {
 }
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-"
 	local iterations=10
 	local loop_dev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "$TMPDIR/img"
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
diff --git a/tests/nvme/033 b/tests/nvme/033
index 90aee817de5d..5a4fac03bea0 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -45,13 +45,14 @@ compare_dev_info() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local nsdev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
diff --git a/tests/nvme/034 b/tests/nvme/034
index e0ede717c373..334b2525d1b6 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -15,14 +15,15 @@ requires() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local ctrldev
 	local nsdev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index 0896f7bb578d..68a9b608920e 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -21,14 +21,15 @@ device_requires() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local ctrldev
 	local nsdev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
diff --git a/tests/nvme/036 b/tests/nvme/036
index 8218c6538dfd..c3fc5d4a948d 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -14,13 +14,14 @@ requires() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local ctrldev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
diff --git a/tests/nvme/037 b/tests/nvme/037
index fc6c21343652..5a78444b7e78 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -13,15 +13,15 @@ requires() {
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-"
 	local iterations=10
 	local ctrldev
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
 	for ((i = 0; i < iterations; i++)); do
 		port=$(_nvmet_passthru_target_setup "${subsys}${i}")
 		nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" \
diff --git a/tests/nvme/038 b/tests/nvme/038
index 24f02d4ad4d1..5af28da03c36 100755
--- a/tests/nvme/038
+++ b/tests/nvme/038
@@ -19,13 +19,13 @@ requires() {
 }
 
 test() {
-	local subsys_path="${NVMET_CFS}/subsystems/blktests-subsystem-1"
-	local port
-
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
 
+	local subsys_path="${NVMET_CFS}/subsystems/blktests-subsystem-1"
+	local port
+
 	mkdir -p "${subsys_path}"
 	rmdir "${subsys_path}"
 
diff --git a/tests/nvme/039 b/tests/nvme/039
index f327b54a8d00..73b53d0b949c 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -131,12 +131,12 @@ inject_invalid_admin_cmd()
 }
 
 test_device() {
+	echo "Running ${TEST_NAME}"
+
 	local nvme_verbose_errors
 	local ns_dev
 	local ctrl_dev
 
-	echo "Running ${TEST_NAME}"
-
 	if _check_kernel_option NVME_VERBOSE_ERRORS; then
 		nvme_verbose_errors=true
 	else
diff --git a/tests/nvme/040 b/tests/nvme/040
index 688a0939a376..3b76753132f3 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -17,6 +17,10 @@ requires() {
 }
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys="blktests-subsystem-1"
 	local file_path="${TMPDIR}/img"
 	local port
@@ -24,9 +28,6 @@ test() {
 	local nvmedev
 	local fio_pid
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
 	truncate -s "${nvme_img_size}" "${file_path}"
 	loop_dev="$(losetup -f --show "${file_path}")"
 
diff --git a/tests/nvme/041 b/tests/nvme/041
index 5b04b99b128e..d8937915d622 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -20,6 +20,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -28,8 +32,6 @@ test() {
 	local hostkey
 	local ctrldev
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
@@ -38,8 +40,6 @@ test() {
 		return 1
 	fi
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
diff --git a/tests/nvme/042 b/tests/nvme/042
index 8df5ed37aacc..af291cb33a04 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -20,6 +20,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -30,13 +34,9 @@ test() {
 	local hostkey
 	local ctrldev
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
diff --git a/tests/nvme/043 b/tests/nvme/043
index 8f4b783a02ff..4a37f91e50c3 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -21,6 +21,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -31,8 +35,6 @@ test() {
 	local hostkey
 	local ctrldev
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
@@ -41,8 +43,6 @@ test() {
 		return 1
 	fi
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
diff --git a/tests/nvme/044 b/tests/nvme/044
index fca0897af27b..27cb343f5ea7 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -21,6 +21,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -30,8 +34,6 @@ test() {
 	local ctrlkey
 	local ctrldev
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
@@ -47,8 +49,6 @@ test() {
 		return 1
 	fi
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
diff --git a/tests/nvme/045 b/tests/nvme/045
index eca629a18691..005d62d4f886 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -22,6 +22,10 @@ requires() {
 
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
@@ -34,8 +38,6 @@ test() {
 	local ctrldev
 	local rand_io_size
 
-	echo "Running ${TEST_NAME}"
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
@@ -51,8 +53,6 @@ test() {
 		return 1
 	fi
 
-	_setup_nvmet
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
diff --git a/tests/nvme/048 b/tests/nvme/048
index a6ebb8927865..6efcd7d6ab03 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -81,6 +81,10 @@ set_qid_max() {
 }
 
 test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
 	local subsys_name="blktests-subsystem-1"
 	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
 	local file_path="${TMPDIR}/img"
@@ -89,10 +93,6 @@ test() {
 	local hostid
 	local port
 
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
-- 
2.41.0

