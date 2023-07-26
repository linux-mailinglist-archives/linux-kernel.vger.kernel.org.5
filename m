Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B597636B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjGZMrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjGZMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:47:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1B81BD6;
        Wed, 26 Jul 2023 05:47:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12D0521D67;
        Wed, 26 Jul 2023 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690375619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbDYNVvlsfmPp7vHYHFE4FO2z3fiEokDrLA+6DaLKtM=;
        b=IVpoEmzB618sHE+gXRxUAfpUC+adllHxmEgT/42LjijRnplRIRMd4A4XKcm90hrzoauAd/
        nv6TaYDg4TOXegey4m/rzH5Oi66WUukIq2YepAVdzudxpX/8dBz8Ze5pgT80AQvhIP/tMz
        Gf9pXGIiHB4lJaymmjhZhx+ZNNZC3z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690375619;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbDYNVvlsfmPp7vHYHFE4FO2z3fiEokDrLA+6DaLKtM=;
        b=zRg8nVC28ELOyWnGUF/wx3Q6cPY3R3jxTLgqsgJjHY2FisvuZ4A9zMYJ5+ORm4tKGUhKCq
        wdl+9umcw/NZsKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04982139BD;
        Wed, 26 Jul 2023 12:46:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n+8bAcMVwWRFUAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 26 Jul 2023 12:46:59 +0000
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
Subject: [PATCH blktests v1 10/11] nvme/rc: Add helper for adding/removing to allow list
Date:   Wed, 26 Jul 2023 14:46:43 +0200
Message-ID: <20230726124644.12619-11-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726124644.12619-1-dwagner@suse.de>
References: <20230726124644.12619-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two helpers to add or remove the host from the allow list of the
subsystem.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 7f5829a2e58d..706f95d74a4b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -612,6 +612,23 @@ _create_nvmet_subsystem() {
 	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
 }
 
+_add_nvmet_allow_hosts() {
+	local nvmet_subsystem="$1"
+	local nvmet_hostnqn="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
+
+	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+}
+
+_remove_nvmet_allow_hosts() {
+	local nvmet_subsystem="$1"
+	local nvmet_hostnqn="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	rm "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+}
+
 _create_nvmet_host() {
 	local nvmet_subsystem="$1"
 	local nvmet_hostnqn="$2"
@@ -621,8 +638,7 @@ _create_nvmet_host() {
 	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
 	mkdir "${host_path}"
-	echo 0 > "${cfs_path}/attr_allow_any_host"
-	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
+	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
 	if [[ "${nvmet_hostkey}" ]] ; then
 		echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
 	fi
-- 
2.41.0

