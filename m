Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3E78C607
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjH2NfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbjH2Ndw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D10CD1;
        Tue, 29 Aug 2023 06:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0393965791;
        Tue, 29 Aug 2023 13:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5E2C433C7;
        Tue, 29 Aug 2023 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316028;
        bh=AFPFhT2rfecfLuN5jOaRCr6T13Rqbhs0k6X7aqxbbAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqXCb02DBja2GYjKBE0SI3wbGgtjETYoQFgOmwp3lmphfzJOh20oqYZ3hgTaQ5VCX
         EuTb1TG1eVuRnW55VX9t4njCnnjdChsTcyJt78q/+v/LtjNWi20WuGFWHrjhvzCg2v
         qQqAw30u0S0Qe7JwTjbH7XbEBB+g+5N19ZJqHOiRGpOxo+nYNXyoH+kysaUwtW1NM8
         ZPGnybs0bBWGcvJXHl31Uxh5B9bOSHEKeeMT0ttq3JDIrphOVHa2I1/zWhuiwnIBQY
         nb3SktQdtDSqUsz/Rz9IR21tglD/KpOYnEtIDjimjSKk7bfP+yDR7mfeuXXSM1Iv2y
         B6dL7/z0MVp9w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shyam Prasad N <sprasad@microsoft.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, pc@cjr.nz,
        gregkh@linuxfoundation.org, lsahlber@redhat.com, pc@manguebit.com,
        vl@samba.org, ematsumiya@suse.de
Subject: [PATCH AUTOSEL 5.10 5/7] cifs: add a warning when the in-flight count goes negative
Date:   Tue, 29 Aug 2023 09:33:34 -0400
Message-Id: <20230829133336.520573-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133336.520573-1-sashal@kernel.org>
References: <20230829133336.520573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.192
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit e4645cc2f1e2d6f268bb8dcfac40997c52432aed ]

We've seen the in-flight count go into negative with some
internal stress testing in Microsoft.

Adding a WARN when this happens, in hope of understanding
why this happens when it happens.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 015b7b37edee5..7ed6c2d4c549a 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -82,6 +82,7 @@ smb2_add_credits(struct TCP_Server_Info *server,
 		*val = 65000; /* Don't get near 64K credits, avoid srv bugs */
 		pr_warn_once("server overflowed SMB3 credits\n");
 	}
+	WARN_ON_ONCE(server->in_flight == 0);
 	server->in_flight--;
 	if (server->in_flight == 0 && (optype & CIFS_OP_MASK) != CIFS_NEG_OP)
 		rc = change_conf(server);
-- 
2.40.1

