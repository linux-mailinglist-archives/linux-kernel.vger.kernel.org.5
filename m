Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775DD7D4D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjJXKDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjJXKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:03:10 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3729DEA;
        Tue, 24 Oct 2023 03:03:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 9B86F18685AA;
        Tue, 24 Oct 2023 13:03:06 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U9j6gZZ_QIsU; Tue, 24 Oct 2023 13:03:06 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 120331867D87;
        Tue, 24 Oct 2023 13:03:06 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id timcU0KQJ8eb; Tue, 24 Oct 2023 13:03:05 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
        by mail.astralinux.ru (Postfix) with ESMTPSA id B322E186785A;
        Tue, 24 Oct 2023 13:03:04 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, Tom Talpey <tom@talpey.com>,
        Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.10 1/1] smbdirect: missing rc checks while waiting for rdma events
Date:   Tue, 24 Oct 2023 13:02:26 +0300
Message-Id: <20231024100226.25860-2-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024100226.25860-1-abelova@astralinux.ru>
References: <20231024100226.25860-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

commit 0555b221528e9cb11f5766dcdee19c809187e42e upstream.

There were two places where we weren't checking for error
(e.g. ERESTARTSYS) while waiting for rdma resolution.

Addresses-Coverity: 1462165 ("Unchecked return value")
Reviewed-by: Tom Talpey <tom@talpey.com>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 fs/cifs/smbdirect.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index bcc611069308..7d18b9268817 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -571,8 +571,13 @@ static struct rdma_cm_id *smbd_create_id(
 		log_rdma_event(ERR, "rdma_resolve_addr() failed %i\n", rc);
 		goto out;
 	}
-	wait_for_completion_interruptible_timeout(
+	rc =3D wait_for_completion_interruptible_timeout(
 		&info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
+	/* e.g. if interrupted returns -ERESTARTSYS */
+	if (rc < 0) {
+		log_rdma_event(ERR, "rdma_resolve_addr timeout rc: %i\n", rc);
+		goto out;
+	}
 	rc =3D info->ri_rc;
 	if (rc) {
 		log_rdma_event(ERR, "rdma_resolve_addr() completed %i\n", rc);
@@ -585,8 +590,13 @@ static struct rdma_cm_id *smbd_create_id(
 		log_rdma_event(ERR, "rdma_resolve_route() failed %i\n", rc);
 		goto out;
 	}
-	wait_for_completion_interruptible_timeout(
+	rc =3D wait_for_completion_interruptible_timeout(
 		&info->ri_done, msecs_to_jiffies(RDMA_RESOLVE_TIMEOUT));
+	/* e.g. if interrupted returns -ERESTARTSYS */
+	if (rc < 0)  {
+		log_rdma_event(ERR, "rdma_resolve_addr timeout rc: %i\n", rc);
+		goto out;
+	}
 	rc =3D info->ri_rc;
 	if (rc) {
 		log_rdma_event(ERR, "rdma_resolve_route() completed %i\n", rc);
--=20
2.30.2

