Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945437E4669
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjKGQzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGQzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:55:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B0693;
        Tue,  7 Nov 2023 08:55:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 434CC1F37C;
        Tue,  7 Nov 2023 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699376133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8YR5IGNzGB11lqau+yV+L6ykZhJX5tp/evzkhWrEHQk=;
        b=UyvKFRK2tBb95knrq8Oe+GkLZujLkjmbW2yLtFKf3/4cx65dyc3yWLdWDOIIo76wEZ2VuX
        3DS42Kma4cdafZJxNH/NM7sjKQYgZ3mWCp2GppuYmKLmfTnnVVvlGOTzs8lZllvorIcCxT
        U78DUmg41RgGMTT7KTAKly4UirgYjx8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1658132FD;
        Tue,  7 Nov 2023 16:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y2KmNARsSmUURwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Tue, 07 Nov 2023 16:55:32 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     bp@alien8.de
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/mce: Remove redundant check from  mce_device_create()
Date:   Tue,  7 Nov 2023 18:55:29 +0200
Message-Id: <20231107165529.407349-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mce_device_create() is called only from mce_cpu_online() which in turn
will be called iff mce is available. That is, at the time of
mce_device_create() call it's guaranteed that mce is available. No need
to duplicate this check so let's remove it.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kernel/cpu/mce/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7b397370b4d6..71999f97a3c8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2568,9 +2568,6 @@ static int mce_device_create(unsigned int cpu)
 	int err;
 	int i, j;
 
-	if (!mce_available(&boot_cpu_data))
-		return -EIO;
-
 	dev = per_cpu(mce_device, cpu);
 	if (dev)
 		return 0;
-- 
2.34.1

