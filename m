Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD47636A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjGZMrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjGZMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:47:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6854F131;
        Wed, 26 Jul 2023 05:46:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26BDF21D5B;
        Wed, 26 Jul 2023 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690375615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3D/8xiwb5LZRiCK/cX5fizoimL7p6nP04ZVnr1xHQyE=;
        b=18DXzcrSblZX5FsV5wjJRC94/WECqBc3VlWFYuCMqlv5aumnncPvRWYJLMSroLCKIexqx3
        736hMZk880M1GRbese7VIuIiD3pkMxpnPUFHUwEt8Jicajdzaz0x9FD6XCevn8LJU1cPqF
        VsOCR2bBS+aNyMOknQPM8Ipp06Ldjrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690375615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3D/8xiwb5LZRiCK/cX5fizoimL7p6nP04ZVnr1xHQyE=;
        b=qhypcxSIVXImxInRPEw73k4H+4TKsideCSpezjEHa6HelsMWJVAJUGV+oMPFa4QtNBPuQl
        vCECqv+epZBeq4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16A2C139BD;
        Wed, 26 Jul 2023 12:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JhAiBb8VwWQrUAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 26 Jul 2023 12:46:55 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 05/11] nvme/{041,042,043,044,045,048}: Remove local variable hostnqn and hostid
Date:   Wed, 26 Jul 2023 14:46:38 +0200
Message-ID: <20230726124644.12619-6-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726124644.12619-1-dwagner@suse.de>
References: <20230726124644.12619-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit acc408477e85 ("nvme/{041,042,043,044,045,048}: Use default
hostnqn and hostid") switched the test over to use the default
hostnqn. It missed the change to remove the local variable and
use the def_hostnqn/def_hostid directly.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/041 | 16 ++++++----------
 tests/nvme/042 | 21 ++++++++-------------
 tests/nvme/043 | 22 +++++++++-------------
 tests/nvme/044 | 27 +++++++++++----------------
 tests/nvme/045 | 23 +++++++++--------------
 tests/nvme/048 | 12 ++++--------
 6 files changed, 47 insertions(+), 74 deletions(-)

diff --git a/tests/nvme/041 b/tests/nvme/041
index fbceaa1cb2d5..4c553251f379 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -25,14 +25,10 @@ test() {
 	_setup_nvmet
 
 	local port
-	local hostid
-	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hostkey
 	local ctrldev
 
-	hostid="${def_hostid}"
-	hostnqn="${def_hostnqn}"
 	hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "nvme gen-dhchap-key failed"
@@ -45,21 +41,21 @@ test() {
 		"b92842df-a394-44b1-84a4-92ae7d112861"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}" "${hostkey}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}"
 
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-			     --hostnqn "${hostnqn}" \
-			     --hostid "${hostid}"
+			     --hostnqn "${def_hostnqn}" \
+			     --hostid "${def_hostid}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Test authenticated connection
 	echo "Test authenticated connection"
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-			     --hostnqn "${hostnqn}" \
-			     --hostid "${hostid}" \
+			     --hostnqn "${def_hostnqn}" \
+			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
 
 	udevadm settle
@@ -71,7 +67,7 @@ test() {
 
 	_remove_nvmet_port "${port}"
 
-	_remove_nvmet_host "${hostnqn}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${file_path}"
 
diff --git a/tests/nvme/042 b/tests/nvme/042
index 28d712e835df..866249ed598c 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -25,23 +25,18 @@ test() {
 	_setup_nvmet
 
 	local port
-	local hostid
-	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hmac
 	local key_len
 	local hostkey
 	local ctrldev
 
-	hostid="${def_hostid}"
-	hostnqn="${def_hostnqn}"
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	for hmac in 0 1 2 3; do
 		echo "Testing hmac ${hmac}"
@@ -50,11 +45,11 @@ test() {
 			echo "couldn't generate host key for hmac ${hmac}"
 			return 1
 		fi
-		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
+		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-				     --hostnqn "${hostnqn}" \
-				     --hostid "${hostid}" \
+				     --hostnqn "${def_hostnqn}" \
+				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 		udevadm settle
 
@@ -68,11 +63,11 @@ test() {
 			echo "couldn't generate host key for length ${key_len}"
 			return 1
 		fi
-		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
+		_set_nvmet_hostkey "${def_hostnqn}" "${hostkey}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-				     --hostnqn "${hostnqn}" \
-				     --hostid "${hostid}" \
+				     --hostnqn "${def_hostnqn}" \
+				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 
 		udevadm settle
@@ -85,7 +80,7 @@ test() {
 
 	_remove_nvmet_port "${port}"
 
-	_remove_nvmet_host "${hostnqn}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${file_path}"
 
diff --git a/tests/nvme/043 b/tests/nvme/043
index 6392bd8b2492..5569a7a58ad5 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -26,17 +26,13 @@ test() {
 	_setup_nvmet
 
 	local port
-	local hostid
-	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hash
 	local dhgroup
 	local hostkey
 	local ctrldev
 
-	hostid="${def_hostid}"
-	hostnqn="${def_hostnqn}"
-	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	hostkey="$(nvme gen-dhchap-key -n ${def_hostnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "nvme gen-dhchap-key failed"
 		return 1
@@ -47,17 +43,17 @@ test() {
 	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}" "${hostkey}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}"
 
 	for hash in "hmac(sha256)" "hmac(sha384)" "hmac(sha512)" ; do
 
 		echo "Testing hash ${hash}"
 
-		_set_nvmet_hash "${hostnqn}" "${hash}"
+		_set_nvmet_hash "${def_hostnqn}" "${hash}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-				     --hostnqn "${hostnqn}" \
-				     --hostid "${hostid}" \
+				     --hostnqn "${def_hostnqn}" \
+				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 
 		udevadm settle
@@ -69,11 +65,11 @@ test() {
 
 		echo "Testing DH group ${dhgroup}"
 
-		_set_nvmet_dhgroup "${hostnqn}" "${dhgroup}"
+		_set_nvmet_dhgroup "${def_hostnqn}" "${dhgroup}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-				      --hostnqn "${hostnqn}" \
-				      --hostid "${hostid}" \
+				      --hostnqn "${def_hostnqn}" \
+				      --hostid "${def_hostid}" \
 				      --dhchap-secret "${hostkey}"
 
 		udevadm settle
@@ -86,7 +82,7 @@ test() {
 
 	_remove_nvmet_port "${port}"
 
-	_remove_nvmet_host "${hostnqn}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${file_path}"
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index 608a086a0864..6c2cb602313c 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -26,16 +26,11 @@ test() {
 	_setup_nvmet
 
 	local port
-	local hostid
-	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hostkey
 	local ctrlkey
 	local ctrldev
 
-	hostid="${def_hostid}"
-	hostnqn="${def_hostnqn}"
-
 	hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "failed to generate host key"
@@ -53,16 +48,16 @@ test() {
 	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}" \
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
 			   "${hostkey}" "${ctrlkey}"
 
-	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
+	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
 
 	# Step 1: Connect with host authentication only
 	echo "Test host authentication"
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-			     --hostnqn "${hostnqn}" \
-			     --hostid "${hostid}" \
+			     --hostnqn "${def_hostnqn}" \
+			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
 
 	udevadm settle
@@ -73,8 +68,8 @@ test() {
 	# and invalid ctrl authentication
 	echo "Test invalid ctrl authentication (should fail)"
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-			     --hostnqn "${hostnqn}" \
-			     --hostid "${hostid}" \
+			     --hostnqn "${def_hostnqn}" \
+			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${hostkey}"
 
@@ -86,8 +81,8 @@ test() {
 	# and valid ctrl authentication
 	echo "Test valid ctrl authentication"
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-			     --hostnqn "${hostnqn}" \
-			     --hostid "${hostid}" \
+			     --hostnqn "${def_hostnqn}" \
+			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
@@ -100,8 +95,8 @@ test() {
 	echo "Test invalid ctrl key (should fail)"
 	invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-			     --hostnqn "${hostnqn}" \
-			     --hostid "${hostid}" \
+			     --hostnqn "${def_hostnqn}" \
+			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${invkey}"
 
@@ -114,7 +109,7 @@ test() {
 
 	_remove_nvmet_port "${port}"
 
-	_remove_nvmet_host "${hostnqn}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${file_path}"
 
diff --git a/tests/nvme/045 b/tests/nvme/045
index b8d886aaf9e8..a936e7fb661f 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -27,8 +27,6 @@ test() {
 	_setup_nvmet
 
 	local port
-	local hostid
-	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hostkey
 	local new_hostkey
@@ -37,9 +35,6 @@ test() {
 	local ctrldev
 	local rand_io_size
 
-	hostid="${def_hostid}"
-	hostnqn="${def_hostnqn}"
-
 	hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "failed to generate host key"
@@ -57,13 +52,13 @@ test() {
 	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${hostnqn}" "${hostkey}" "${ctrlkey}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}" "${ctrlkey}"
 
-	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
+	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-			     --hostnqn "${hostnqn}" \
-			     --hostid "${hostid}" \
+			     --hostnqn "${def_hostnqn}" \
+			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
@@ -82,7 +77,7 @@ test() {
 
 	new_hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 
-	_set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
+	_set_nvmet_hostkey "${def_hostnqn}" "${new_hostkey}"
 
 	echo "Re-authenticate with new host key"
 
@@ -92,7 +87,7 @@ test() {
 
 	new_ctrlkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
 
-	_set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
+	_set_nvmet_ctrlkey "${def_hostnqn}" "${new_ctrlkey}"
 
 	echo "Re-authenticate with new ctrl key"
 
@@ -101,7 +96,7 @@ test() {
 
 	echo "Change DH group to ffdhe8192"
 
-	_set_nvmet_dhgroup "${hostnqn}" "ffdhe8192"
+	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe8192"
 
 	echo "Re-authenticate with changed DH group"
 
@@ -109,7 +104,7 @@ test() {
 
 	echo "Change hash to hmac(sha512)"
 
-	_set_nvmet_hash "${hostnqn}" "hmac(sha512)"
+	_set_nvmet_hash "${def_hostnqn}" "hmac(sha512)"
 
 	echo "Re-authenticate with changed hash"
 
@@ -127,7 +122,7 @@ test() {
 
 	_remove_nvmet_port "${port}"
 
-	_remove_nvmet_host "${hostnqn}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${file_path}"
 
diff --git a/tests/nvme/048 b/tests/nvme/048
index 20d234e72621..f9a19b1e655e 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -88,25 +88,21 @@ test() {
 	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
 	local file_path="${TMPDIR}/img"
 	local skipped=false
-	local hostnqn
-	local hostid
 	local port
 
-	hostid="${def_hostid}"
-	hostnqn="${def_hostnqn}"
-
 	truncate -s "${nvme_img_size}" "${file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${file_path}" \
 		"b92842df-a394-44b1-84a4-92ae7d112861"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
+
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
 		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
-					--hostnqn "${hostnqn}" \
-					--hostid "${hostid}" \
+					--hostnqn "${def_hostnqn}" \
+					--hostid "${def_hostid}" \
 					--keep-alive-tmo 1 \
 					--reconnect-delay 2
 
@@ -126,7 +122,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${hostnqn}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${file_path}"
 
-- 
2.41.0

