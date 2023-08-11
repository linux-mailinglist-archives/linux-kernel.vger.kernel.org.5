Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB634778A28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjHKJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjHKJgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:36:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7633599;
        Fri, 11 Aug 2023 02:36:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2B5E21886;
        Fri, 11 Aug 2023 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691746595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qhpDrnyJ7ZYfbrDMR7+SmW/nd2jhoSM4735T51Dzt4=;
        b=pcB43r5Z/CBlWZVJ0T9kGSF0OnAGzh6SntRQxREobsma6jNwsF+jGmAWsHey9n2IsMGww8
        7Wh0oxlHeHDSFZdmO9orM9k59U+UASus/sorN8v+/+NSPdRv6vEZn4g4wH5LeN36G0+sVQ
        ypPEAEZ/oMDY8oHzHmFhCTbyMp8Vfo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691746595;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qhpDrnyJ7ZYfbrDMR7+SmW/nd2jhoSM4735T51Dzt4=;
        b=uLoPn+bTdPeHemz7XtZ9ewKQmr5Fk2fp2xEBIYFXh9cMmO191ZkR21ZI3yXWiLeAEk+/jo
        o1HR08ciq3ABnnAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A53C1138E2;
        Fri, 11 Aug 2023 09:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tOd3JyMB1mTNHwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 09:36:35 +0000
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
Subject: [PATCH blktests v3 10/13] nvme: Use def_subsys_uuid variable
Date:   Fri, 11 Aug 2023 11:36:11 +0200
Message-ID: <20230811093614.28005-11-dwagner@suse.de>
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

As all tests are using the same subsys uuid name anyway, use
the def_subsys_uuid variable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/004 | 2 +-
 tests/nvme/005 | 2 +-
 tests/nvme/006 | 2 +-
 tests/nvme/007 | 2 +-
 tests/nvme/008 | 2 +-
 tests/nvme/009 | 2 +-
 tests/nvme/010 | 2 +-
 tests/nvme/011 | 2 +-
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 tests/nvme/014 | 2 +-
 tests/nvme/015 | 2 +-
 tests/nvme/017 | 2 +-
 tests/nvme/018 | 2 +-
 tests/nvme/019 | 2 +-
 tests/nvme/020 | 2 +-
 tests/nvme/021 | 2 +-
 tests/nvme/022 | 2 +-
 tests/nvme/023 | 2 +-
 tests/nvme/024 | 2 +-
 tests/nvme/025 | 2 +-
 tests/nvme/026 | 2 +-
 tests/nvme/027 | 2 +-
 tests/nvme/028 | 2 +-
 tests/nvme/029 | 2 +-
 tests/nvme/041 | 2 +-
 tests/nvme/047 | 2 +-
 tests/nvme/048 | 2 +-
 28 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tests/nvme/004 b/tests/nvme/004
index 78b11c7b84c5..54d74b61f689 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -32,7 +32,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
diff --git a/tests/nvme/005 b/tests/nvme/005
index 211b8affc32a..8e3ddfe75e2f 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -32,7 +32,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
diff --git a/tests/nvme/006 b/tests/nvme/006
index f31633825a70..910204aaeb90 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -28,7 +28,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/007 b/tests/nvme/007
index b6a4bc437103..db00bdcc2d08 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -24,7 +24,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index a38926ef0051..752ab30a756b 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -29,7 +29,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index 2c8ea7ead9b8..7debd837cc76 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -25,7 +25,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 81f7d2024ee6..cba711b29af8 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -29,7 +29,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index e6f78867e283..ba2718d81bd9 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 85549c25a1c6..629b5194435e 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -33,7 +33,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 355bc2e03557..ca51544b82d1 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -29,7 +29,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index 44ae91e2210f..6d27300cfb30 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -32,7 +32,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index 16e41ee65d42..1b3aa4aa36c2 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -29,7 +29,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/017 b/tests/nvme/017
index 7cbf274c13b0..aa0a3fefae90 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -26,7 +26,7 @@ test() {
 	local genctr=1
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 
 	for ((i = 2; i <= iterations; i++)); do
 		_create_nvmet_ns "${def_subsysnqn}" "${i}" "${def_file_path}"
diff --git a/tests/nvme/018 b/tests/nvme/018
index d1d2082e62ac..b66056d43041 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -27,7 +27,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 2628dea55ac8..b456b38d038e 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -31,7 +31,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index 4a4f3c12da30..ba88921d75af 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -27,7 +27,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index 11f82d64f378..02ef9727ee59 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index 586f6cdd3448..74c12c3e0ba9 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index b13426cf5615..413b6afa6d14 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -29,7 +29,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index b7c7b3f64321..1baf5487ae64 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 04ceace5840b..9eecd4d4a604 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index a9dc7bc15db5..8a8bc58170e2 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index fda8c61405a5..723e721202be 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 8e42ea37a634..d4e62e8cae1c 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -26,7 +26,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index 7988faf5dd03..b113e387f1fa 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -62,7 +62,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/041 b/tests/nvme/041
index 0a0700533b7b..cb2766619b0e 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -37,7 +37,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"b92842df-a394-44b1-84a4-92ae7d112861"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}"
diff --git a/tests/nvme/047 b/tests/nvme/047
index 66032f679ae2..2b81f7ea9ffd 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -32,7 +32,7 @@ test() {
 	loop_dev="$(losetup -f --show "${def_file_path}")"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
-		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
 
diff --git a/tests/nvme/048 b/tests/nvme/048
index 6a05feae9b82..19234a5b3791 100755
--- a/tests/nvme/048
+++ b/tests/nvme/048
@@ -92,7 +92,7 @@ test() {
 	truncate -s "${nvme_img_size}" "${def_file_path}"
 
 	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
-		"b92842df-a394-44b1-84a4-92ae7d112861"
+		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
-- 
2.41.0

