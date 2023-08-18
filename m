Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C7F780DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377704AbjHROQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377687AbjHROPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:15:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D34A3C3F;
        Fri, 18 Aug 2023 07:15:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3DC421F8AC;
        Fri, 18 Aug 2023 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692368145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBFsEI0/jrPBLLtbeuavruB1PrzH5cauI3y9s1NHi6I=;
        b=NL5BgYi75+jWolN2aiQ57XHRy2xhqKOUS8csGmT3Jt2IzHiSzRUo3rZNpmXtGLBqSjsi1R
        zuN9JXS0pShhU283vlnIQT1Ele5ADz56+aKK38woLo0NgRFTdPXmHcwwbCT+eombTSPUWh
        mdpEI6L85HmVW9pKFB4T8fDWRtnDba8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692368145;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBFsEI0/jrPBLLtbeuavruB1PrzH5cauI3y9s1NHi6I=;
        b=NCxsre0lJQTNOQW4oUEDcAS+2mcYnucIYl0ePmCLZcMS2ysIyuaFXXxOqqcR6bIGASLBic
        UwH0N3Dm/ZMA8iBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30F7E13441;
        Fri, 18 Aug 2023 14:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /fn0CxF932SdOwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 18 Aug 2023 14:15:45 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 2/3] nvme/{033,034,035,036,37}: drop port handle between passthru target setup and cleanup
Date:   Fri, 18 Aug 2023 16:15:36 +0200
Message-ID: <20230818141537.22332-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818141537.22332-1-dwagner@suse.de>
References: <20230818141537.22332-1-dwagner@suse.de>
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

The passthru nvmet setup and cleanup helpers are using the port as
handle to track resources.

Instead returning the port from the setup call, we figure out in the
cleanup code which resources have been allocated. This avoids passing
around awkward handles.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/033 |  5 ++---
 tests/nvme/034 |  5 ++---
 tests/nvme/035 |  5 ++---
 tests/nvme/036 |  5 ++---
 tests/nvme/037 |  5 ++---
 tests/nvme/rc  | 30 ++++++++++++++++++++++++------
 6 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/tests/nvme/033 b/tests/nvme/033
index d924883460c2..6cc4f57e6d60 100755
--- a/tests/nvme/033
+++ b/tests/nvme/033
@@ -50,16 +50,15 @@ test_device() {
 	_setup_nvmet
 
 	local nsdev
-	local port
 
-	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	_nvmet_passthru_target_setup "${def_subsysnqn}"
 
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	compare_dev_info "${nsdev}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
-	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/034 b/tests/nvme/034
index e79eef5e756d..3bd1c3ad2f61 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -21,15 +21,14 @@ test_device() {
 
 	local ctrldev
 	local nsdev
-	local port
 
-	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	_nvmet_passthru_target_setup "${def_subsysnqn}"
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
-	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/035 b/tests/nvme/035
index f0dfc92ceeea..712fe1dbcfb8 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -27,15 +27,14 @@ test_device() {
 
 	local ctrldev
 	local nsdev
-	local port
 
-	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	_nvmet_passthru_target_setup "${def_subsysnqn}"
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	_xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
-	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/036 b/tests/nvme/036
index 61b9e2309da7..89ccd256a67c 100755
--- a/tests/nvme/036
+++ b/tests/nvme/036
@@ -19,9 +19,8 @@ test_device() {
 	_setup_nvmet
 
 	local ctrldev
-	local port
 
-	port=$(_nvmet_passthru_target_setup "${def_subsysnqn}")
+	_nvmet_passthru_target_setup "${def_subsysnqn}"
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
 	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
@@ -31,7 +30,7 @@ test_device() {
 	fi
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
-	_nvmet_passthru_target_cleanup "${port}" "${def_subsysnqn}"
+	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/037 b/tests/nvme/037
index 5a78444b7e78..a2815b3ff2d7 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -20,15 +20,14 @@ test_device() {
 	local subsys="blktests-subsystem-"
 	local iterations=10
 	local ctrldev
-	local port
 
 	for ((i = 0; i < iterations; i++)); do
-		port=$(_nvmet_passthru_target_setup "${subsys}${i}")
+		_nvmet_passthru_target_setup "${subsys}${i}"
 		nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" \
 				"${subsys}${i}")
 
 		_nvme_disconnect_subsys "${subsys}${i}" >>"${FULL}" 2>&1
-		_nvmet_passthru_target_cleanup "${port}" "${subsys}${i}"
+		_nvmet_passthru_target_cleanup "${subsys}${i}"
 	done
 
 	echo "Test complete"
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 0b964e99efd8..b6f06be75ca1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -712,6 +712,19 @@ _remove_nvmet_subsystem_from_port() {
 	rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
 }
 
+_get_nvmet_ports() {
+	local nvmet_subsystem="$1"
+	local -n nvmet_ports="$2"
+	local cfs_path="${NVMET_CFS}/ports"
+	local sarg
+
+	sarg="s;^${cfs_path}/\([0-9]\+\)/subsystems/${nvmet_subsystem}$;\1;p"
+
+	for path in "${cfs_path}/"*"/subsystems/${nvmet_subsystem}"; do
+		nvmet_ports+=("$(echo "${path}" | sed -n -s "${sarg}")")
+	done
+}
+
 _set_nvmet_hostkey() {
 	local nvmet_hostnqn="$1"
 	local nvmet_hostkey="$2"
@@ -781,13 +794,12 @@ _find_nvme_passthru_loop_dev() {
 
 _nvmet_passthru_target_setup() {
 	local subsys_name=$1
+	local port
 
 	_create_nvmet_passthru "${subsys_name}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
 	_create_nvmet_host "${subsys_name}" "${def_hostnqn}"
-
-	echo "$port"
 }
 
 _nvmet_passthru_target_connect() {
@@ -806,11 +818,17 @@ _nvmet_passthru_target_connect() {
 }
 
 _nvmet_passthru_target_cleanup() {
-	local port=$1
-	local subsys_name=$2
+	local subsys_name=$1
+	local ports
+	local port
+
+	_get_nvmet_ports "${subsys_name}" ports
+
+	for port in "${ports[@]}"; do
+		_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+		_remove_nvmet_port "${port}"
+	done
 
-	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
-	_remove_nvmet_port "${port}"
 	_remove_nvmet_passhtru "${subsys_name}"
 	_remove_nvmet_host "${def_hostnqn}"
 }
-- 
2.41.0

