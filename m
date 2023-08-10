Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9D7776A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjHJLNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjHJLN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:13:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8D1268D;
        Thu, 10 Aug 2023 04:13:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 729FE1F74B;
        Thu, 10 Aug 2023 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691666004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuVTgiPNHtm81E56o06X9CeBH8SajSsSbCDIqRyYjxc=;
        b=Rxff0To3p16XqcWSennoKrrfwjprNRnIQ5pZCHPN3/PHMT13bvNuS/pp7KSJiaO2V8EgJZ
        H/SN4ok4XoDl0F+Vn8zTdxNy+73m8XcNEPdTp+v5uCGix6tRXKmTmkkYSzet6u3rKUPOwF
        Yx2QRIqAgcH2k1svt5Z8K6veLHGkpK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691666004;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuVTgiPNHtm81E56o06X9CeBH8SajSsSbCDIqRyYjxc=;
        b=4MrncnodqGEFoDztSPFudopgw3DNUSui1R11VNT6lY1wAnVgmGxJoLj0VtD7XJD/uKE+WI
        yrNBBuUFd9dycCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D1DB138E2;
        Thu, 10 Aug 2023 11:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7TOWFlTG1GQ9LwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 10 Aug 2023 11:13:24 +0000
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
Subject: [PATCH blktests v2 04/12] nvme: Use def_subsysnqn variable instead local variable
Date:   Thu, 10 Aug 2023 13:13:09 +0200
Message-ID: <20230810111317.25273-5-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810111317.25273-1-dwagner@suse.de>
References: <20230810111317.25273-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all tests are using the same subsystem nqn anyway, use
the def_subsysnqn variable and drop the local subsys_name
variable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/003 |  8 ++++----
 tests/nvme/004 | 14 +++++++-------
 tests/nvme/005 | 12 ++++++------
 tests/nvme/006 |  9 ++++-----
 tests/nvme/007 |  9 ++++-----
 tests/nvme/008 | 15 +++++++--------
 tests/nvme/009 | 15 +++++++--------
 tests/nvme/010 | 15 +++++++--------
 tests/nvme/011 | 15 +++++++--------
 tests/nvme/012 | 15 +++++++--------
 tests/nvme/013 | 15 +++++++--------
 tests/nvme/014 | 15 +++++++--------
 tests/nvme/015 | 15 +++++++--------
 tests/nvme/016 | 13 ++++++-------
 tests/nvme/017 | 13 ++++++-------
 tests/nvme/018 | 15 +++++++--------
 tests/nvme/019 | 15 +++++++--------
 tests/nvme/020 | 15 +++++++--------
 tests/nvme/021 | 15 +++++++--------
 tests/nvme/022 | 15 +++++++--------
 tests/nvme/023 | 15 +++++++--------
 tests/nvme/024 | 15 +++++++--------
 tests/nvme/025 | 15 +++++++--------
 tests/nvme/026 | 15 +++++++--------
 tests/nvme/027 | 15 +++++++--------
 tests/nvme/028 | 15 +++++++--------
 tests/nvme/029 | 15 +++++++--------
 tests/nvme/033 |  2 +-
 tests/nvme/034 |  2 +-
 tests/nvme/035 |  2 +-
 tests/nvme/036 |  2 +-
 tests/nvme/038 |  2 +-
 tests/nvme/040 | 13 ++++++-------
 tests/nvme/041 | 21 ++++++++++-----------
 tests/nvme/042 | 23 +++++++++++------------
 tests/nvme/043 | 18 +++++++++---------
 tests/nvme/044 | 31 +++++++++++++++----------------
 tests/nvme/045 | 27 +++++++++++++--------------
 tests/nvme/047 | 19 +++++++++----------
 tests/nvme/048 | 23 +++++++++++------------
 40 files changed, 266 insertions(+), 297 deletions(-)

diff --git a/tests/nvme/003 b/tests/nvme/003
index aa26abf8d8b3..71b82ce758a3 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -29,8 +29,8 @@ test() {
 
 	loop_dev="$(losetup -f)"
 
-	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}"
-	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discovery
 
@@ -46,8 +46,8 @@ test() {
 	fi
 
 	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
-	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
-	_remove_nvmet_subsystem "blktests-subsystem-1"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	echo "Test complete"
diff --git a/tests/nvme/004 b/tests/nvme/004
index 1e5c2b8b3e87..0314ed3c949e 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -31,20 +31,20 @@ test() {
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
-	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
 	local nvmedev
-	nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_nvme_disconnect_subsys blktests-subsystem-1
-	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
-	_remove_nvmet_subsystem "blktests-subsystem-1"
+	_nvme_disconnect_subsys ${def_subsysnqn}
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 	losetup -d "$loop_dev"
 	rm "$TMPDIR/img"
diff --git a/tests/nvme/005 b/tests/nvme/005
index 836854086822..935b8634cb96 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -31,23 +31,23 @@ test() {
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
-	_create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
-	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	udevadm settle
 
 	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
 
 	_nvme_disconnect_ctrl "${nvmedev}"
-	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	_remove_nvmet_subsystem "blktests-subsystem-1"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	losetup -d "$loop_dev"
 	rm "$TMPDIR/img"
 
diff --git a/tests/nvme/006 b/tests/nvme/006
index b44c56b6a25d..066acabb1175 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -22,19 +22,18 @@ test() {
 
 	local port
 	local loop_dev
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "$TMPDIR/img"
 
 	loop_dev="$(losetup -f --show "$TMPDIR/img")"
 
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "$loop_dev"
diff --git a/tests/nvme/007 b/tests/nvme/007
index 112432df7a9d..c6ba36cc4b4f 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -21,19 +21,18 @@ test() {
 
 	local port
 	local file_path
-	local subsys_name="blktests-subsystem-1"
 
 	file_path="${TMPDIR}/img"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
diff --git a/tests/nvme/008 b/tests/nvme/008
index 5abc4240ca46..c3fbcbc59686 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -24,29 +24,28 @@ test() {
 	local nvmedev
 	local loop_dev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	udevadm settle
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "${loop_dev}"
diff --git a/tests/nvme/009 b/tests/nvme/009
index 491d3c809ab0..88c27889fbe1 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -22,27 +22,26 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	udevadm settle
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
diff --git a/tests/nvme/010 b/tests/nvme/010
index d2eb95311510..38c062ec73f4 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -24,30 +24,29 @@ test() {
 	local nvmedev
 	local loop_dev
 	local file_path="${TMPDIR}/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
 		--filename="/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "${loop_dev}"
diff --git a/tests/nvme/011 b/tests/nvme/011
index da8cbac11124..0dab74e7e5b5 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -24,28 +24,27 @@ test() {
 	local nvmedev
 	local file_path
 	local file_path="${TMPDIR}/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	_run_fio_verify_io --size="${nvme_img_size}" \
 		--filename="/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index efe227538c57..8ed57d3a5ab0 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -28,29 +28,28 @@ test() {
 	local nvmedev
 	local loop_dev
 	local file_path="${TMPDIR}/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "${loop_dev}"
diff --git a/tests/nvme/013 b/tests/nvme/013
index 2be8681616d1..e3eb4e914750 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -26,27 +26,26 @@ test() {
 	local port
 	local nvmedev
 	local file_path="${TMPDIR}/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
diff --git a/tests/nvme/014 b/tests/nvme/014
index 55d920f2660b..cbafd802af16 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -27,20 +27,19 @@ test() {
 	local bs
 	local count
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -53,10 +52,10 @@ test() {
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "${loop_dev}"
diff --git a/tests/nvme/015 b/tests/nvme/015
index 071141380e43..b32d16a91de8 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -26,18 +26,17 @@ test() {
 	local bs
 	local count
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -50,10 +49,10 @@ test() {
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
diff --git a/tests/nvme/016 b/tests/nvme/016
index cac0c0509aca..908abbdaaa75 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -21,30 +21,29 @@ test() {
 	local port
 	local iterations="${nvme_num_iter}"
 	local loop_dev
-	local subsys_nqn="blktests-subsystem-1"
 
 	loop_dev="$(losetup -f)"
 	local genctr=1
 
-	_create_nvmet_subsystem "${subsys_nqn}" "${loop_dev}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns "${subsys_nqn}" "${i}" "${loop_dev}"
+		_create_nvmet_ns "${def_subsysnqn}" "${i}" "${loop_dev}"
 	done
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
+	_add_nvmet_subsys_to_port "$port" "${def_subsysnqn}"
 
 	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	for ((i = iterations; i > 1; i--)); do
-		_remove_nvmet_ns "${subsys_nqn}" "$i"
+		_remove_nvmet_ns "${def_subsysnqn}" "$i"
 	done
 
-	_remove_nvmet_subsystem "${subsys_nqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/017 b/tests/nvme/017
index 429a25e8e011..6f7ef5882d3e 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -21,7 +21,6 @@ test() {
 	local port
 	local file_path
 	local iterations="${nvme_num_iter}"
-	local subsys_name="blktests-subsystem-1"
 
 	file_path="${TMPDIR}/img"
 
@@ -29,26 +28,26 @@ test() {
 
 	local genctr=1
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 
 	for ((i = 2; i <= iterations; i++)); do
-		_create_nvmet_ns "${subsys_name}" "${i}" "${file_path}"
+		_create_nvmet_ns "${def_subsysnqn}" "${i}" "${file_path}"
 	done
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	for ((i = iterations; i > 1; i--)); do
-		_remove_nvmet_ns "${subsys_name}" "$i"
+		_remove_nvmet_ns "${def_subsysnqn}" "$i"
 	done
 
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	rm "${file_path}"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index 78e9b2bb94d8..155f094ea6b3 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -24,18 +24,17 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -47,10 +46,10 @@ test() {
 	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
 		&& echo "ERROR: nvme read for out of range LBA was not rejected"
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
diff --git a/tests/nvme/019 b/tests/nvme/019
index 9fff8ccaac9c..4ac351cbb782 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -24,7 +24,6 @@ test() {
 	local nvmedev
 	local loop_dev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
@@ -32,23 +31,23 @@ test() {
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "${loop_dev}"
diff --git a/tests/nvme/020 b/tests/nvme/020
index 1966d5925213..744d4b7d6805 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -22,29 +22,28 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm -f "${file_path}"
diff --git a/tests/nvme/021 b/tests/nvme/021
index 1fefc0fbca00..1fd9bcbb3d23 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -23,18 +23,17 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -42,10 +41,10 @@ test() {
 		echo "ERROR: device not listed"
 	fi
 
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm -f "${file_path}"
diff --git a/tests/nvme/022 b/tests/nvme/022
index 1ff915786f86..053991625250 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -23,18 +23,17 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -42,10 +41,10 @@ test() {
 		echo "ERROR: reset failed"
 	fi
 
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm -f "${file_path}"
diff --git a/tests/nvme/023 b/tests/nvme/023
index 90316230a3d7..c10e5a0138a8 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -24,20 +24,19 @@ test() {
 	local nvmedev
 	local loop_dev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -45,10 +44,10 @@ test() {
 		echo "ERROR: smart-log bdev-ns failed"
 	fi
 
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "${loop_dev}"
diff --git a/tests/nvme/024 b/tests/nvme/024
index 384a8266e741..d1d7f0bfb994 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -23,28 +23,27 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	if ! nvme smart-log "/dev/${nvmedev}" -n 1 >> "$FULL" 2>&1; then
 		echo "ERROR: smart-log file-ns failed"
 	fi
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm -f "${file_path}"
diff --git a/tests/nvme/025 b/tests/nvme/025
index 815223d1c28d..ea944830612b 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -23,18 +23,17 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -42,10 +41,10 @@ test() {
 		echo "ERROR: effects-log failed"
 	fi
 
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm -f "${file_path}"
diff --git a/tests/nvme/026 b/tests/nvme/026
index d2203f19f026..f1193c20477c 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -23,18 +23,17 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -42,10 +41,10 @@ test() {
 		echo "ERROR: ns-desc failed"
 	fi
 
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm -f "${file_path}"
diff --git a/tests/nvme/027 b/tests/nvme/027
index 97fe70e78344..c097c51ea4f3 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -23,28 +23,27 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-rescan failed"
 	fi
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm -f "${file_path}"
diff --git a/tests/nvme/028 b/tests/nvme/028
index c539620bee28..6e37be4893b1 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -23,28 +23,27 @@ test() {
 	local port
 	local nvmedev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
 	fi
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	rm -f "${file_path}"
diff --git a/tests/nvme/029 b/tests/nvme/029
index c6d38b42af70..4d0ca997404b 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -57,20 +57,19 @@ test() {
 	local nvmedev
 	local loop_dev
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
@@ -82,10 +81,10 @@ test() {
 	test_user_io "$dev" 511 1023 > "$FULL" 2>&1 || echo FAIL
 	test_user_io "$dev" 511 1025 > "$FULL" 2>&1 || echo FAIL
 
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "${loop_dev}"
diff --git a/tests/nvme/033 b/tests/nvme/033
index 5a4fac03bea0..46a520ae01fa 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -49,7 +49,7 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="blktests-subsystem-1"
+	local subsys="${def_subsysnqn}"
 	local nsdev
 	local port
 
diff --git a/tests/nvme/034 b/tests/nvme/034
index 334b2525d1b6..3c65d92cbaea 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -19,7 +19,7 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="blktests-subsystem-1"
+	local subsys="${def_subsysnqn}"
 	local ctrldev
 	local nsdev
 	local port
diff --git a/tests/nvme/035 b/tests/nvme/035
index 68a9b608920e..c705d9cf25a4 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -25,7 +25,7 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="blktests-subsystem-1"
+	local subsys="${def_subsysnqn}"
 	local ctrldev
 	local nsdev
 	local port
diff --git a/tests/nvme/036 b/tests/nvme/036
index c3fc5d4a948d..2e933cc41928 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -18,7 +18,7 @@ test_device() {
 
 	_setup_nvmet
 
-	local subsys="blktests-subsystem-1"
+	local subsys="${def_subsysnqn}"
 	local ctrldev
 	local port
 
diff --git a/tests/nvme/038 b/tests/nvme/038
index 5af28da03c36..007b5f425312 100755
--- a/tests/nvme/038
+++ b/tests/nvme/038
@@ -23,7 +23,7 @@ test() {
 
 	_setup_nvmet
 
-	local subsys_path="${NVMET_CFS}/subsystems/blktests-subsystem-1"
+	local subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
 	local port
 
 	mkdir -p "${subsys_path}"
diff --git a/tests/nvme/040 b/tests/nvme/040
index 3b76753132f3..8d7f68f9a2d7 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -21,7 +21,6 @@ test() {
 
 	_setup_nvmet
 
-	local subsys="blktests-subsystem-1"
 	local file_path="${TMPDIR}/img"
 	local port
 	local loop_dev
@@ -32,11 +31,11 @@ test() {
 	loop_dev="$(losetup -f --show "${file_path}")"
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_create_nvmet_subsystem "${subsys}" "${loop_dev}"
-	_add_nvmet_subsys_to_port "${port}" "${subsys}"
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 	udevadm settle
-	nvmedev=$(_find_nvme_dev "${subsys}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	# start fio job
 	echo "starting background fio"
@@ -55,8 +54,8 @@ test() {
 
 	{ kill "${fio_pid}"; wait; } &> /dev/null
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys}"
-	_remove_nvmet_subsystem "${subsys}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "${loop_dev}"
diff --git a/tests/nvme/041 b/tests/nvme/041
index d8937915d622..fbceaa1cb2d5 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -25,7 +25,6 @@ test() {
 	_setup_nvmet
 
 	local port
-	local subsys_name="blktests-subsystem-1"
 	local hostid
 	local hostnqn
 	local file_path="${TMPDIR}/img"
@@ -34,7 +33,7 @@ test() {
 
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
-	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "nvme gen-dhchap-key failed"
 		return 1
@@ -42,33 +41,33 @@ test() {
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"b92842df-a394-44b1-84a4-92ae7d112861"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
-	_create_nvmet_host "${subsys_name}" "${hostnqn}" "${hostkey}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}" "${hostkey}"
 
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 			     --hostnqn "${hostnqn}" \
 			     --hostid "${hostid}"
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Test authenticated connection
 	echo "Test authenticated connection"
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 			     --hostnqn "${hostnqn}" \
 			     --hostid "${hostid}" \
 			     --dhchap-secret "${hostkey}"
 
 	udevadm settle
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/042 b/tests/nvme/042
index af291cb33a04..28d712e835df 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -25,7 +25,6 @@ test() {
 	_setup_nvmet
 
 	local port
-	local subsys_name="blktests-subsystem-1"
 	local hostid
 	local hostnqn
 	local file_path="${TMPDIR}/img"
@@ -39,50 +38,50 @@ test() {
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
-	_create_nvmet_host "${subsys_name}" "${hostnqn}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}"
 
 	for hmac in 0 1 2 3; do
 		echo "Testing hmac ${hmac}"
-		hostkey="$(nvme gen-dhchap-key --hmac=${hmac} -n ${subsys_name} 2> /dev/null)"
+		hostkey="$(nvme gen-dhchap-key --hmac=${hmac} -n ${def_subsysnqn} 2> /dev/null)"
 		if [ -z "$hostkey" ] ; then
 			echo "couldn't generate host key for hmac ${hmac}"
 			return 1
 		fi
 		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 				     --hostnqn "${hostnqn}" \
 				     --hostid "${hostid}" \
 				     --dhchap-secret "${hostkey}"
 		udevadm settle
 
-		_nvme_disconnect_subsys "${subsys_name}"
+		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
 	for key_len in 32 48 64; do
 		echo "Testing key length ${key_len}"
-		hostkey="$(nvme gen-dhchap-key --key-length=${key_len} -n ${subsys_name} 2> /dev/null)"
+		hostkey="$(nvme gen-dhchap-key --key-length=${key_len} -n ${def_subsysnqn} 2> /dev/null)"
 		if [ -z "$hostkey" ] ; then
 			echo "couldn't generate host key for length ${key_len}"
 			return 1
 		fi
 		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
 
-		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 				     --hostnqn "${hostnqn}" \
 				     --hostid "${hostid}" \
 				     --dhchap-secret "${hostkey}"
 
 		udevadm settle
 
-		_nvme_disconnect_subsys "${subsys_name}"
+		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/043 b/tests/nvme/043
index 4a37f91e50c3..3dc543fd55d3 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -45,10 +45,10 @@ test() {
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
-	_create_nvmet_host "${subsys_name}" "${hostnqn}" "${hostkey}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}" "${hostkey}"
 
 	for hash in "hmac(sha256)" "hmac(sha384)" "hmac(sha512)" ; do
 
@@ -56,14 +56,14 @@ test() {
 
 		_set_nvmet_hash "${hostnqn}" "${hash}"
 
-		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 				     --hostnqn "${hostnqn}" \
 				     --hostid "${hostid}" \
 				     --dhchap-secret "${hostkey}"
 
 		udevadm settle
 
-		_nvme_disconnect_subsys "${subsys_name}"
+		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
 	for dhgroup in "ffdhe2048" "ffdhe3072" "ffdhe4096" "ffdhe6144" "ffdhe8192" ; do
@@ -72,18 +72,18 @@ test() {
 
 		_set_nvmet_dhgroup "${hostnqn}" "${dhgroup}"
 
-		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 				      --hostnqn "${hostnqn}" \
 				      --hostid "${hostid}" \
 				      --dhchap-secret "${hostkey}"
 
 		udevadm settle
 
-		_nvme_disconnect_subsys "${subsys_name}"
+		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index 27cb343f5ea7..608a086a0864 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -26,7 +26,6 @@ test() {
 	_setup_nvmet
 
 	local port
-	local subsys_name="blktests-subsystem-1"
 	local hostid
 	local hostnqn
 	local file_path="${TMPDIR}/img"
@@ -37,13 +36,13 @@ test() {
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
-	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "failed to generate host key"
 		return 1
 	fi
 
-	ctrlkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	ctrlkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$ctrlkey" ] ; then
 		echo "failed to generate ctrl key"
 		return 1
@@ -51,29 +50,29 @@ test() {
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
-	_create_nvmet_host "${subsys_name}" "${hostnqn}" \
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}" \
 			   "${hostkey}" "${ctrlkey}"
 
 	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
 
 	# Step 1: Connect with host authentication only
 	echo "Test host authentication"
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 			     --hostnqn "${hostnqn}" \
 			     --hostid "${hostid}" \
 			     --dhchap-secret "${hostkey}"
 
 	udevadm settle
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Step 2: Connect with host authentication
 	# and invalid ctrl authentication
 	echo "Test invalid ctrl authentication (should fail)"
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 			     --hostnqn "${hostnqn}" \
 			     --hostid "${hostid}" \
 			     --dhchap-secret "${hostkey}" \
@@ -81,12 +80,12 @@ test() {
 
 	udevadm settle
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Step 3: Connect with host authentication
 	# and valid ctrl authentication
 	echo "Test valid ctrl authentication"
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 			     --hostnqn "${hostnqn}" \
 			     --hostid "${hostid}" \
 			     --dhchap-secret "${hostkey}" \
@@ -94,13 +93,13 @@ test() {
 
 	udevadm settle
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Step 4: Connect with host authentication
 	# and invalid ctrl key
 	echo "Test invalid ctrl key (should fail)"
 	invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 			     --hostnqn "${hostnqn}" \
 			     --hostid "${hostid}" \
 			     --dhchap-secret "${hostkey}" \
@@ -108,10 +107,10 @@ test() {
 
 	udevadm settle
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/045 b/tests/nvme/045
index 005d62d4f886..b8d886aaf9e8 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -27,7 +27,6 @@ test() {
 	_setup_nvmet
 
 	local port
-	local subsys_name="blktests-subsystem-1"
 	local hostid
 	local hostnqn
 	local file_path="${TMPDIR}/img"
@@ -41,13 +40,13 @@ test() {
 	hostid="${def_hostid}"
 	hostnqn="${def_hostnqn}"
 
-	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "failed to generate host key"
 		return 1
 	fi
 
-	ctrlkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	ctrlkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$ctrlkey" ] ; then
 		echo "failed to generate ctrl key"
 		return 1
@@ -55,14 +54,14 @@ test() {
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
-	_create_nvmet_host "${subsys_name}" "${hostnqn}" "${hostkey}" "${ctrlkey}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}" "${hostkey}" "${ctrlkey}"
 
 	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 			     --hostnqn "${hostnqn}" \
 			     --hostid "${hostid}" \
 			     --dhchap-secret "${hostkey}" \
@@ -72,7 +71,7 @@ test() {
 
 	echo "Re-authenticate with original host key"
 
-	ctrldev=$(_find_nvme_dev "${subsys_name}")
+	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
 	if [ -z "$ctrldev" ] ; then
 		echo "nvme controller not found"
 	fi
@@ -81,7 +80,7 @@ test() {
 
 	echo "Renew host key on the controller"
 
-	new_hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	new_hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 
 	_set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
 
@@ -91,7 +90,7 @@ test() {
 
 	echo "Renew ctrl key on the controller"
 
-	new_ctrlkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	new_ctrlkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 
 	_set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
 
@@ -116,15 +115,15 @@ test() {
 
 	echo "${new_hostkey}" > "${hostkey_file}"
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	rand_io_size="$(_nvme_calc_rand_io_size 4m)"
 	_run_fio_rand_io --size="${rand_io_size}" --filename="/dev/${nvmedev}n1"
 
-	_nvme_disconnect_subsys "${subsys_name}"
+	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	_remove_nvmet_port "${port}"
 
diff --git a/tests/nvme/047 b/tests/nvme/047
index 6a7599bc2e91..b435dd3cecba 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -27,37 +27,36 @@ test() {
 	local loop_dev
 	local rand_io_size
 	local file_path="$TMPDIR/img"
-	local subsys_name="blktests-subsystem-1"
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	loop_dev="$(losetup -f --show "${file_path}")"
 
-	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 		--nr-write-queues 1 || echo FAIL
 
-	nvmedev=$(_find_nvme_dev "${subsys_name}")
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	rand_io_size="$(_nvme_calc_rand_io_size 4M)"
 	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 		--nr-write-queues 1 \
 		--nr-poll-queues 1 || echo FAIL
 
 	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size="${rand_io_size}"
 
-	_nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
 	losetup -d "${loop_dev}"
diff --git a/tests/nvme/048 b/tests/nvme/048
index 6efcd7d6ab03..20d234e72621 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -85,8 +85,7 @@ test() {
 
 	_setup_nvmet
 
-	local subsys_name="blktests-subsystem-1"
-	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
+	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
 	local file_path="${TMPDIR}/img"
 	local skipped=false
 	local hostnqn
@@ -98,34 +97,34 @@ test() {
 
 	truncate -s "${nvme_img_size}" "${file_path}"
 
-	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"b92842df-a394-44b1-84a4-92ae7d112861"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
-	_create_nvmet_host "${subsys_name}" "${hostnqn}"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
-		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 					--hostnqn "${hostnqn}" \
 					--hostid "${hostid}" \
 					--keep-alive-tmo 1 \
 					--reconnect-delay 2
 
-		if ! nvmf_wait_for_state "${subsys_name}" "live" ; then
+		if ! nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
 			echo FAIL
 		else
-			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
-			set_qid_max "${port}" "${subsys_name}" 2 || echo FAIL
+			set_qid_max "${port}" "${def_subsysnqn}" 1 || echo FAIL
+			set_qid_max "${port}" "${def_subsysnqn}" 2 || echo FAIL
 		fi
 
-		_nvme_disconnect_subsys "${subsys_name}"
+		_nvme_disconnect_subsys "${def_subsysnqn}"
 	else
 		SKIP_REASONS+=("missing attr_qid_max feature")
 		skipped=true
 	fi
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 	_remove_nvmet_host "${hostnqn}"
 
-- 
2.41.0

