Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AFC771C53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjHGIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHGIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:34:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E64710EF;
        Mon,  7 Aug 2023 01:34:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44AAB218A9;
        Mon,  7 Aug 2023 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691397251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CkiLjiLMxObzy3Sb9w3oxtxHFV8IOAxBlCK+K5bcwaE=;
        b=r+DUjLGFEllhgYp/YiieuZF0DOCjFDWeLyJoWFD0+nxlhS2s+B4eZvPMd4W3P12+txsJ5K
        G431i69aOhsJSqtUZcspvZ0xB1KGBCaF8Sc0PPEF5QWSdWdODP1kf6Odvb05n1/K6EP4OM
        2N5m5JFtHu58v9ZyWEHYpAtkTXoamI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691397251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CkiLjiLMxObzy3Sb9w3oxtxHFV8IOAxBlCK+K5bcwaE=;
        b=PmOcswpF0o6Csfk6kbt4+f54rrFElHQs3ovyF4w1bqSUJ5n6roG5qyOxTHY7f0PI1TMtU0
        9q+79oecr2eV8RBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F71013487;
        Mon,  7 Aug 2023 08:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9RkuA4Os0GTCBwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Aug 2023 08:34:11 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, gregkh@linuxfoundation.org, hch@lst.de,
        joern@lazybastard.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, loic.poulain@linaro.org,
        miquel.raynal@bootlin.com, regressions@lists.linux.dev,
        richard@nod.at, snitzer@kernel.org, vigneshr@ti.com,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH for 6.5 regression] PM: hibernate: fix resume_store() return value when hibernation not available
Date:   Mon,  7 Aug 2023 10:33:57 +0200
Message-ID: <20230807083356.19222-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a laptop with hibernation set up but not actively used, and with
secure boot and lockdown enabled kernel, 6.5-rc1 gets stuck on boot with
the following repeated messages:

  A start job is running for Resume from hibernation using device /dev/system/swap (24s / no limit)
  lockdown_is_locked_down: 25311154 callbacks suppressed
  Lockdown: systemd-hiberna: hibernation is restricted; see man kernel_lockdown.7
  ...

Checking the resume code leads to commit cc89c63e2fe3 ("PM: hibernate:
move finding the resume device out of software_resume") which
inadvertently changed the return value from resume_store() to 0 when
!hibernation_available(). This apparently translates to userspace
write() returning 0 as in number of bytes written, and userspace looping
indefinitely in the attempt to write the intended value.

Fix this by returning the full number of bytes that were to be written,
as that's what was done before the commit.

Fixes: cc89c63e2fe3 ("PM: hibernate: move finding the resume device out of software_resume")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Resend with review/ack tags added and not buried in the thread.
Link: https://lore.kernel.org/all/2cfa5f55-1d68-8a4f-d049-13f42e0d1484@suse.cz/

 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e1b4bfa938dd..2b4a946a6ff5 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1166,7 +1166,7 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	int error;
 
 	if (!hibernation_available())
-		return 0;
+		return n;
 
 	if (len && buf[len-1] == '\n')
 		len--;
-- 
2.41.0

