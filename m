Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE3676A0BE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjGaTAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGaTAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:00:04 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F601BD3;
        Mon, 31 Jul 2023 12:00:01 -0700 (PDT)
Received: from quatroqueijos.lan (201-43-195-14.dsl.telesp.net.br [201.43.195.14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5C0C141E37;
        Mon, 31 Jul 2023 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690829999;
        bh=SpTi4eXcMBULgHrAPUO/kPqUwuzXKmursJQy7z+Cg9Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=AqDCcghbdEu3jCMWuxXQIJ4aHH2y33CotZ3U1v2pOSPOCuz9e3DtVyiVV8C2cVfgB
         o0xufSifsRPc9R8+bCLc/yNiy0zdvvApWJUtCgCN8Bn/1luT1cjCmYCKhImZU9WpgH
         jsfiHM3lVLKYwHxjOZnA9qq2/I+wABqg2fbIG2QdIMc6tYFKAYbo7cU8VPDzYHcg/V
         7TEqKsbQy7bn3lgG5S/4iwKXEhvniFJNIqNVcyCUWmErxykEy61AhqpP8fPdvWVSxP
         wAPBgQG1yZm8p3dfLDgEi2gaWgPTrpCQYIvqGyPcY7OFMqbpupsFxUIKEk2ZNscgD2
         UFcBGiZ1z25ww==
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc
Date:   Mon, 31 Jul 2023 15:59:42 -0300
Message-Id: <20230731185942.279611-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any unprivileged user can attach N_GSM0710 ldisc, but it requires
CAP_NET_ADMIN to create a GSM network anyway.

Require initial namespace CAP_NET_ADMIN to do that.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 drivers/tty/n_gsm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1cdefac4dd1b..c7a787f10a9c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3576,6 +3576,9 @@ static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
 
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
 	if (tty->ops->write == NULL)
 		return -EINVAL;
 
-- 
2.34.1

