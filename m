Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66F5783BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjHVIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjHVIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:38:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF6A1AE;
        Tue, 22 Aug 2023 01:38:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BB5F1F85D;
        Tue, 22 Aug 2023 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692693482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqL2sMcaHhRS4XGXqpth3e/SV2SBKNsHssmjl8r+6/0=;
        b=qX4ULHi4W6VxkBDnV6JdeAvtF2BmF5Dpq1eSJ6XOC/BX6u++ABjxzyibjHeJVM3S0tZEzq
        JClVQ/BiwZMkVShf787V5cxNyvRmkLtRbBNENrZT5fSDEl9kU0D6se+naGjazauWH9ewvk
        dxem0ixg0O8DgjzXPl/9QqbSr3oI+FM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692693482;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqL2sMcaHhRS4XGXqpth3e/SV2SBKNsHssmjl8r+6/0=;
        b=7F/p0Xs8kc7yj34zamuRf91kisMhe2JagN3GW/hRJEF83WgT1C3001xFgUtvKXkTSJfC5V
        4sBeKUF/t/NgkUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 182C9132B9;
        Tue, 22 Aug 2023 08:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pO3MBepz5GQ1cAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 22 Aug 2023 08:38:02 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 3/3] nvme: introduce nvmet_target_{setup/cleanup} common code
Date:   Tue, 22 Aug 2023 10:38:12 +0200
Message-ID: <20230822083812.24612-4-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822083812.24612-1-dwagner@suse.de>
References: <20230822083812.24612-1-dwagner@suse.de>
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

Almost all fabric tests have the identically code for
setting up and cleaning up the target side. Introduce
two new helpers.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/003 | 14 +++-------
 tests/nvme/004 | 21 +++------------
 tests/nvme/005 | 20 ++-------------
 tests/nvme/006 | 19 ++------------
 tests/nvme/007 | 14 ++--------
 tests/nvme/008 | 21 ++-------------
 tests/nvme/009 | 16 ++----------
 tests/nvme/010 | 21 ++-------------
 tests/nvme/011 | 16 ++----------
 tests/nvme/012 | 21 ++-------------
 tests/nvme/013 | 16 ++----------
 tests/nvme/014 | 21 ++-------------
 tests/nvme/015 | 16 ++----------
 tests/nvme/018 | 16 ++----------
 tests/nvme/019 | 21 ++-------------
 tests/nvme/020 | 16 ++----------
 tests/nvme/021 | 16 ++----------
 tests/nvme/022 | 16 ++----------
 tests/nvme/023 | 21 ++-------------
 tests/nvme/024 | 16 ++----------
 tests/nvme/025 | 16 ++----------
 tests/nvme/026 | 16 ++----------
 tests/nvme/027 | 17 +++----------
 tests/nvme/028 | 17 +++----------
 tests/nvme/029 | 21 ++-------------
 tests/nvme/040 | 19 ++------------
 tests/nvme/041 | 18 ++-----------
 tests/nvme/042 | 17 ++-----------
 tests/nvme/043 | 17 ++-----------
 tests/nvme/044 | 19 +++-----------
 tests/nvme/045 | 18 +++----------
 tests/nvme/047 | 21 ++-------------
 tests/nvme/048 | 17 ++-----------
 tests/nvme/rc  | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
 34 files changed, 141 insertions(+), 519 deletions(-)

diff --git a/tests/nvme/003 b/tests/nvme/003
index 71b82ce758a3..b5ea2720100e 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -22,15 +22,8 @@ test() {
 
 	_setup_nvmet
 
-	local loop_dev
-	local port
 
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-
-	loop_dev="$(losetup -f)"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discovery
 
@@ -46,9 +39,8 @@ test() {
 	fi
 
 	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
+
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/004 b/tests/nvme/004
index 697c758d3059..31af8737857b 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -22,19 +22,8 @@ test() {
 
 	_setup_nvmet
 
-	local port
-	local loop_dev
 
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"${def_subsys_uuid}"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -44,12 +33,8 @@ test() {
 	cat "/sys/block/${nvmedev}n1/wwid"
 
 	_nvme_disconnect_subsys ${def_subsysnqn}
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-	losetup -d "$loop_dev"
-	rm "${def_file_path}"
+
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/005 b/tests/nvme/005
index 4ca87ff48016..f9956e960a56 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -21,20 +21,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
-	local loop_dev
 	local nvmedev
 
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"${def_subsys_uuid}"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -43,13 +32,8 @@ test() {
 	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
 
 	_nvme_disconnect_ctrl "${nvmedev}"
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_host "${def_hostnqn}"
 
-	losetup -d "$loop_dev"
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/006 b/tests/nvme/006
index 910204aaeb90..d85f64b702eb 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -20,25 +20,10 @@ test() {
 
 	_setup_nvmet
 
-	local port
-	local loop_dev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
+	_nvmet_target_setup
 
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-
-	losetup -d "$loop_dev"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/007 b/tests/nvme/007
index db00bdcc2d08..feac5060a950 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -19,20 +19,10 @@ test() {
 
 	_setup_nvmet
 
-	local port
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
+	_nvmet_target_setup --blkdev=file
 
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/008 b/tests/nvme/008
index bd5e10fbfb99..f4b45b2f1c11 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -20,19 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
-	local loop_dev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -42,14 +32,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	losetup -d "${loop_dev}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/009 b/tests/nvme/009
index c9a4b57ac288..63614c91a96d 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -19,16 +19,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -38,12 +31,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/010 b/tests/nvme/010
index 19bb7f3fc7a7..e782a9bb06f3 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -20,19 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
-	local loop_dev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -45,14 +35,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	losetup -d "${loop_dev}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/011 b/tests/nvme/011
index 0e54c2588bc8..7329e0505f59 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -20,16 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -42,12 +35,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/012 b/tests/nvme/012
index c6b82c821bf2..6072eed3532a 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -24,19 +24,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
-	local loop_dev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -48,14 +38,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	losetup -d "${loop_dev}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/013 b/tests/nvme/013
index 441db7477d75..c9be60675cc4 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -23,16 +23,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -44,12 +37,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/014 b/tests/nvme/014
index 3656f9399687..d49e8f3cce4d 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -20,22 +20,12 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
-	local loop_dev
 	local size
 	local bs
 	local count
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		 "${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -54,14 +44,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	losetup -d "${loop_dev}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/015 b/tests/nvme/015
index bc04e39c628c..b418d785ab27 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -20,19 +20,12 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 	local size
 	local bs
 	local count
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		 "${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -51,12 +44,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/018 b/tests/nvme/018
index 68729c3cb070..19e439f3f3e0 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -21,16 +21,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		 "${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -48,12 +41,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/019 b/tests/nvme/019
index 33a25d52e9fd..15e98c40134f 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -20,21 +20,11 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
-	local loop_dev
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -46,14 +36,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	losetup -d "${loop_dev}"
-
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/020 b/tests/nvme/020
index f436cdc8b262..aae40e7131e0 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -19,18 +19,11 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 	local nblk_range="10,10,10,10,10,10,10,10,10,10"
 	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -42,12 +35,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/021 b/tests/nvme/021
index 5043fe4916be..f9bed1546307 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -20,16 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -43,12 +36,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/022 b/tests/nvme/022
index 8b6f610c4894..e3e67b0996df 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -20,16 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -43,12 +36,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/023 b/tests/nvme/023
index 90af0338e81f..c8d1e4619822 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -20,19 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
-	local loop_dev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -46,14 +36,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	losetup -d "${loop_dev}"
-
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/024 b/tests/nvme/024
index 7a89ddd79fd9..2308b42968e1 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -20,16 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -42,12 +35,7 @@ test() {
 	fi
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/025 b/tests/nvme/025
index 90f214eff6c8..b3851d8ceb14 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -20,16 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -43,12 +36,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/026 b/tests/nvme/026
index ec352acaa489..38acfcc373b4 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -20,16 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -43,12 +36,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/027 b/tests/nvme/027
index 339f7605a9f5..2d65b3e1a820 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -20,16 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -40,14 +33,10 @@ test() {
 	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
 		echo "ERROR: ns-rescan failed"
 	fi
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/028 b/tests/nvme/028
index 7f387eb337f6..eec1807884a9 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -20,16 +20,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -40,14 +33,10 @@ test() {
 	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
 	fi
-	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
+	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/029 b/tests/nvme/029
index 461e6c6c4454..bbc481437fc8 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -53,19 +53,9 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
-	local loop_dev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		 "${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -83,14 +73,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	losetup -d "${loop_dev}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/040 b/tests/nvme/040
index ed6df3bbed52..7759bac9b43c 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -21,18 +21,10 @@ test() {
 
 	_setup_nvmet
 
-	local port
-	local loop_dev
 	local nvmedev
 	local fio_pid
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
@@ -54,14 +46,7 @@ test() {
 
 	{ kill "${fio_pid}"; wait; } &> /dev/null
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	losetup -d "${loop_dev}"
-
-	rm -f "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/041 b/tests/nvme/041
index bc84412ccb46..99c24ad4e6a2 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -24,7 +24,6 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local hostkey
 	local ctrldev
 
@@ -34,13 +33,7 @@ test() {
 		return 1
 	fi
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}"
+	_nvmet_target_setup --blkdev=file --hostkey "${hostkey}"
 
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
@@ -59,14 +52,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-
-	_remove_nvmet_port "${port}"
-
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/042 b/tests/nvme/042
index 47e1b95ffdc6..f0e196a13ba0 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -24,18 +24,12 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local hmac
 	local key_len
 	local hostkey
 	local ctrldev
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	for hmac in 0 1 2 3; do
 		echo "Testing hmac ${hmac}"
@@ -71,14 +65,7 @@ test() {
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-
-	_remove_nvmet_port "${port}"
-
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/043 b/tests/nvme/043
index 15676f88d556..c95f38e6c71b 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -25,7 +25,6 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local hash
 	local dhgroup
 	local hostkey
@@ -37,12 +36,7 @@ test() {
 		return 1
 	fi
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}"
+	_nvmet_target_setup --blkdev=file --hostkey "${hostkey}"
 
 	for hash in "hmac(sha256)" "hmac(sha384)" "hmac(sha512)" ; do
 
@@ -72,14 +66,7 @@ test() {
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-
-	_remove_nvmet_port "${port}"
-
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/044 b/tests/nvme/044
index 9407ac6338c8..f48458a82323 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -25,7 +25,6 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local hostkey
 	local ctrlkey
 	local ctrldev
@@ -42,13 +41,8 @@ test() {
 		return 1
 	fi
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
-			   "${hostkey}" "${ctrlkey}"
+	_nvmet_target_setup --blkdev=file --ctrlkey "${ctrlkey}" \
+			    --hostkey "${hostkey}"
 
 	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
 
@@ -95,14 +89,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-
-	_remove_nvmet_port "${port}"
-
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/045 b/tests/nvme/045
index 396bcdefbcba..902eb26bef8e 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -26,7 +26,6 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local hostkey
 	local new_hostkey
 	local ctrlkey
@@ -46,12 +45,8 @@ test() {
 		return 1
 	fi
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}" "${ctrlkey}"
+	_nvmet_target_setup --blkdev=file --ctrlkey "${ctrlkey}" \
+			    --hostkey "${hostkey}"
 
 	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
 
@@ -114,14 +109,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-
-	_remove_nvmet_port "${port}"
-
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/047 b/tests/nvme/047
index 1da24b5638a6..94d7d50f9f98 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -22,20 +22,10 @@ test() {
 
 	_setup_nvmet
 
-	local port
 	local nvmedev
-	local loop_dev
 	local rand_io_size
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	loop_dev="$(losetup -f --show "${def_file_path}")"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 		--nr-write-queues 1 || echo FAIL
@@ -55,14 +45,7 @@ test() {
 
 	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	losetup -d "${loop_dev}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/048 b/tests/nvme/048
index 19234a5b3791..06e1fa6b4f65 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -87,16 +87,8 @@ test() {
 
 	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
 	local skipped=false
-	local port
 
-	truncate -s "${nvme_img_size}" "${def_file_path}"
-
-	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"${def_subsys_uuid}"
-	port="$(_create_nvmet_port "${nvme_trtype}")"
-
-	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+	_nvmet_target_setup --blkdev=file
 
 	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
 		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
@@ -118,12 +110,7 @@ test() {
 		skipped=true
 	fi
 
-	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
-	_remove_nvmet_subsystem "${def_subsysnqn}"
-	_remove_nvmet_port "${port}"
-	_remove_nvmet_host "${def_hostnqn}"
-
-	rm "${def_file_path}"
+	_nvmet_target_cleanup
 
 	if [[ "${skipped}" = true ]] ; then
 		return 1
diff --git a/tests/nvme/rc b/tests/nvme/rc
index fdffc07da34a..261892ed2070 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -359,6 +359,12 @@ _cleanup_nvmet() {
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
+
+	blkdev="$(losetup -l | awk '$6 == "'"${def_file_path}"'" { print $1 }')"
+	for dev in ${blkdev}; do
+		losetup -d "${dev}"
+	done
+	rm -f "${def_file_path}"
 }
 
 _setup_nvmet() {
@@ -818,6 +824,69 @@ _find_nvme_passthru_loop_dev() {
 	echo "/dev/${dev}n${nsid}"
 }
 
+_nvmet_target_setup() {
+	local blkdev_type="device"
+	local blkdev
+	local ctrlkey=""
+	local hostkey=""
+	local port
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--blkdev)
+				blkdev_type="$2"
+				shift 2
+				;;
+			--ctrlkey)
+				ctrlkey="$2"
+				shift 2
+				;;
+			--hostkey)
+				hostkey="$2"
+				shift 2
+				;;
+			*)
+				shift
+				;;
+		esac
+	done
+
+	truncate -s "${nvme_img_size}" "${def_file_path}"
+	if [[ "${blkdev_type}" == "device" ]]; then
+		blkdev="$(losetup -f --show "${def_file_path}")"
+	else
+		blkdev="${def_file_path}"
+	fi
+
+	_create_nvmet_subsystem "${def_subsysnqn}" "${blkdev}" \
+				"${def_subsys_uuid}"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
+			"${hostkey}" "${ctrlkey}"
+}
+
+_nvmet_target_cleanup() {
+	local ports
+	local port
+	local blkdev
+
+	_get_nvmet_ports "${def_subsysnqn}" ports
+
+	for port in "${ports[@]}"; do
+		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
+		_remove_nvmet_port "${port}"
+	done
+	_remove_nvmet_subsystem "${def_subsysnqn}"
+	_remove_nvmet_host "${def_hostnqn}"
+
+	blkdev="$(losetup -l | awk '$6 == "'"${def_file_path}"'" { print $1 }')"
+	if [[ -n "${blkdev}" ]] ; then
+		losetup -d "${blkdev}"
+	fi
+	rm "${def_file_path}"
+}
+
 _nvmet_passthru_target_setup() {
 	local subsys_name=$1
 	local port
-- 
2.41.0

