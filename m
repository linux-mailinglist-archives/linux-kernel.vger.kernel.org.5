Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB26778A29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjHKJhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjHKJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:36:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701035A1;
        Fri, 11 Aug 2023 02:36:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98D891F74A;
        Fri, 11 Aug 2023 09:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691746597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/3g66sTTwH7DSyrxQhTnav2sVGdYCVdhQzPdl0m5hk=;
        b=HVi4O4z60oftk9DuBhet3VHfpCSs/54H6wyO7L8j/hsIYEoGYqG7Po35O1dCWiYsgEsZ5e
        Eprypy+VaHlXqj0uTPpy6WNLc/s7Df2evO+m3E4g2rBv8susGJIH+J+X4vwklRmtmAJbTZ
        LTKxgwzq6gOevvv19MA/cXrljHLfLaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691746597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/3g66sTTwH7DSyrxQhTnav2sVGdYCVdhQzPdl0m5hk=;
        b=isAlobYTg9X2szHgc/Kil0p/21FI7CREz8KIbEnzTEDlovxzVWfgWOHtgC7JWactVB8poh
        09CJB1PQt3wIA4Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BA23138E2;
        Fri, 11 Aug 2023 09:36:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a7omGSUB1mTVHwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 11 Aug 2023 09:36:37 +0000
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
Subject: [PATCH blktests v3 12/13] nvme: Add explicitly host to allow_host list
Date:   Fri, 11 Aug 2023 11:36:13 +0200
Message-ID: <20230811093614.28005-13-dwagner@suse.de>
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

Only allow to connect to our setup target with the correct hostnqn.

Thus we have to explicitly add the test hostnqn to the test subsysnqn
allow_host list.

In nvme/030 the genctr is updated as side effect by writing the
attr_allow_any_host variable. Though writting to attr_allow_any_host is
not allowed after switching to the allow_host list. We can achieve the
same effect by adding and removing the host to the allow_host list.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/004 |  2 ++
 tests/nvme/005 |  4 +++-
 tests/nvme/008 |  2 ++
 tests/nvme/009 |  2 ++
 tests/nvme/010 |  2 ++
 tests/nvme/011 |  2 ++
 tests/nvme/012 |  2 ++
 tests/nvme/013 |  2 ++
 tests/nvme/014 |  2 ++
 tests/nvme/015 |  2 ++
 tests/nvme/018 |  2 ++
 tests/nvme/019 |  2 ++
 tests/nvme/020 |  2 ++
 tests/nvme/021 |  2 ++
 tests/nvme/022 |  2 ++
 tests/nvme/023 |  2 ++
 tests/nvme/024 |  2 ++
 tests/nvme/025 |  2 ++
 tests/nvme/026 |  2 ++
 tests/nvme/027 |  2 ++
 tests/nvme/028 |  2 ++
 tests/nvme/029 |  2 ++
 tests/nvme/030 | 11 ++++++-----
 tests/nvme/040 |  3 +++
 tests/nvme/047 |  2 ++
 tests/nvme/rc  |  7 +++++--
 26 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/004 b/tests/nvme/004
index 54d74b61f689..697c758d3059 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -34,6 +34,7 @@ test() {
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"${def_subsys_uuid}"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -46,6 +47,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 	losetup -d "$loop_dev"
 	rm "${def_file_path}"
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index 8e3ddfe75e2f..6646b826ecfa 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -34,6 +34,7 @@ test() {
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
 		"${def_subsys_uuid}"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -46,8 +47,9 @@ test() {
 	_nvme_disconnect_ctrl "${nvmedev}"
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
-
 	_remove_nvmet_subsystem "${def_subsysnqn}"
+	_remove_nvmet_host "${def_hostnqn}"
+
 	losetup -d "$loop_dev"
 	rm "${def_file_path}"
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index 752ab30a756b..3921fc6992b2 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -32,6 +32,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -46,6 +47,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	losetup -d "${loop_dev}"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index 7debd837cc76..aac3c1e0f642 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -28,6 +28,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -42,6 +43,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${def_file_path}"
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index cba711b29af8..19bb7f3fc7a7 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -32,6 +32,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -47,6 +48,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	losetup -d "${loop_dev}"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index ba2718d81bd9..0e54c2588bc8 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -29,6 +29,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -44,6 +45,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${def_file_path}"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 629b5194435e..c6b82c821bf2 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -36,6 +36,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -50,6 +51,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	losetup -d "${loop_dev}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index ca51544b82d1..441db7477d75 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -32,6 +32,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -46,6 +47,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${def_file_path}"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index 6d27300cfb30..3656f9399687 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -35,6 +35,7 @@ test() {
 		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -56,6 +57,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	losetup -d "${loop_dev}"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index 1b3aa4aa36c2..bc04e39c628c 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -32,6 +32,7 @@ test() {
 		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -53,6 +54,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${def_file_path}"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index b66056d43041..68729c3cb070 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -30,6 +30,7 @@ test() {
 		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -50,6 +51,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm "${def_file_path}"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index b456b38d038e..33a25d52e9fd 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -34,6 +34,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -48,6 +49,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	losetup -d "${loop_dev}"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index ba88921d75af..f436cdc8b262 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -30,6 +30,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -44,6 +45,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm -f "${def_file_path}"
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index 02ef9727ee59..5043fe4916be 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -29,6 +29,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -45,6 +46,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm -f "${def_file_path}"
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index 74c12c3e0ba9..8b6f610c4894 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -29,6 +29,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -45,6 +46,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm -f "${def_file_path}"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index 413b6afa6d14..90af0338e81f 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -32,6 +32,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -48,6 +49,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	losetup -d "${loop_dev}"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 1baf5487ae64..7a89ddd79fd9 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -29,6 +29,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -44,6 +45,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm -f "${def_file_path}"
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 9eecd4d4a604..90f214eff6c8 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -29,6 +29,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -45,6 +46,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm -f "${def_file_path}"
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 8a8bc58170e2..ec352acaa489 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -29,6 +29,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -45,6 +46,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm -f "${def_file_path}"
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index 723e721202be..339f7605a9f5 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -29,6 +29,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -44,6 +45,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm -f "${def_file_path}"
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index d4e62e8cae1c..7f387eb337f6 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -29,6 +29,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -44,6 +45,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	rm -f "${def_file_path}"
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index b113e387f1fa..461e6c6c4454 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -65,6 +65,7 @@ test() {
 		 "${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 
@@ -85,6 +86,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	losetup -d "${loop_dev}"
 
diff --git a/tests/nvme/030 b/tests/nvme/030
index a0b999cace94..9251e1744f61 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -28,6 +28,7 @@ test() {
 
 	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
 	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
+	_create_nvmet_host "${subsys}1" "${def_hostnqn}"
 
 	genctr=$(_discovery_genctr)
 
@@ -36,13 +37,13 @@ test() {
 
 	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
 
-	echo 0 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
+	_add_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
 
-	genctr=$(_check_genctr "${genctr}" "clearing attr_allow_any_host")
+	genctr=$(_check_genctr "${genctr}" "adding host to allow_hosts")
 
-	echo 1 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
+	_remove_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
 
-	genctr=$(_check_genctr "${genctr}" "setting attr_allow_any_host")
+	genctr=$(_check_genctr "${genctr}" "removing host from allow_hosts")
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys}2"
 	_remove_nvmet_subsystem "${subsys}2"
@@ -51,8 +52,8 @@ test() {
 
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
 	_remove_nvmet_subsystem "${subsys}1"
-
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/040 b/tests/nvme/040
index 452ecd690edf..1a9be5c9342c 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -32,6 +32,8 @@ test() {
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
+
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
 	udevadm settle
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
@@ -56,6 +58,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	losetup -d "${loop_dev}"
 
diff --git a/tests/nvme/047 b/tests/nvme/047
index 2b81f7ea9ffd..1da24b5638a6 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -35,6 +35,7 @@ test() {
 		"${def_subsys_uuid}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
+	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
 		--nr-write-queues 1 || echo FAIL
@@ -57,6 +58,7 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
+	_remove_nvmet_host "${def_hostnqn}"
 
 	losetup -d "${loop_dev}"
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 61cc2e6d2c2c..e6ec32285f7a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -608,7 +608,7 @@ _create_nvmet_subsystem() {
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
-	echo 1 > "${cfs_path}/attr_allow_any_host"
+	echo 0 > "${cfs_path}/attr_allow_any_host"
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
 }
 
@@ -678,7 +678,7 @@ _create_nvmet_passthru() {
 	local passthru_path="${subsys_path}/passthru"
 
 	mkdir -p "${subsys_path}"
-	echo 1 > "${subsys_path}/attr_allow_any_host"
+	echo 0 > "${subsys_path}/attr_allow_any_host"
 
 	_test_dev_nvme_ctrl > "${passthru_path}/device_path"
 	echo 1 > "${passthru_path}/enable"
@@ -693,6 +693,7 @@ _remove_nvmet_passhtru() {
 	local passthru_path="${subsys_path}/passthru"
 
 	echo 0 > "${passthru_path}/enable"
+	rm -f "${subsys_path}"/allowed_hosts/*
 	rmdir "${subsys_path}"
 }
 
@@ -784,6 +785,7 @@ _nvmet_passthru_target_setup() {
 	_create_nvmet_passthru "${subsys_name}"
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_create_nvmet_host "${subsys_name}" "${def_hostnqn}"
 
 	echo "$port"
 }
@@ -810,6 +812,7 @@ _nvmet_passthru_target_cleanup() {
 	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
 	_remove_nvmet_port "${port}"
 	_remove_nvmet_passhtru "${subsys_name}"
+	_remove_nvmet_host "${def_hostnqn}"
 }
 
 _discovery_genctr() {
-- 
2.41.0

