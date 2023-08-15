Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A073277D2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbjHOTCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbjHOTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D88213A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:01:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54254211C2;
        Tue, 15 Aug 2023 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jL1kZwcY6dMGheLY8VT1W4i0RrpIBAIOY7mmAx3IYPo=;
        b=U0X1AgYfraeXpvSANmhqdI7y2OkQ2UGIwcVOzfcm/4PdYBALruX+lRci8AHZZJT5xfnCiw
        Rq/leeZlmplImx0Gfb4IuCNEf1HduS/gLJSTJV3ws+ITLCn5hyV0hdxvDEnSgXDCertqKd
        RDAGtXlAcYho/A2L3BMbJrOlxtTgXeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jL1kZwcY6dMGheLY8VT1W4i0RrpIBAIOY7mmAx3IYPo=;
        b=+TU5ZXj5De1Bwf8O1Mw0fmUPyyUx62ZWZTkuT1FEmBwy51vPvohgM1zBdg9+Njv67ADUf6
        3Jg43Eu1NUlI1FAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32F511390C;
        Tue, 15 Aug 2023 19:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0PykC5vL22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:47 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 01/25] iov_iter: Export import_ubuf()
Date:   Tue, 15 Aug 2023 21:01:12 +0200
Message-Id: <20230815190136.8987-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815190136.8987-1-tiwai@suse.de>
References: <20230815190136.8987-1-tiwai@suse.de>
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

Export import_ubuf() to be used in sound subsystem for generic memory
handling as Linus suggested.  It's used for constructing an iov_iter
of a single segment user-space copy for PCM data.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 lib/iov_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e4dc809d1075..3743bbcbbb89 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1544,6 +1544,7 @@ int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
 	iov_iter_ubuf(i, rw, buf, len);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(import_ubuf);
 
 /**
  * iov_iter_restore() - Restore a &struct iov_iter to the same state as when
-- 
2.35.3

