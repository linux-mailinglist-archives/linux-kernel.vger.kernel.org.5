Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9268068B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376770AbjLFHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376830AbjLFHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:37:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171B61722
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5433C433C7;
        Wed,  6 Dec 2023 07:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848257;
        bh=dQFCDmEpt5P6ThPydBMGELVuIhzHjl7/FVwjhyy0yRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUvsjQdzGwCfUKDjkBnh/6sqrgysLBucHf9QNxpTCbCY4llLHwlLyUSb2wcYenaUb
         jG87KYRBZojYzewsCBheiyxTR4VpE8G0gBw/uY6yifqJq5i3AkCl3tbe4Noj0V0QIM
         vqoXgTa/35sZnCChMUIhYLIRHWIrwbdl5uUR+MPnem7KSgL26UxJXAKIwOsFuchwnI
         lboLuLBNTSCNJ/UPslvXHh2gX+97CnffjXIQ2IBaaNUwTDlWtbO16MH97vG1trDxcu
         RPXaPiTEwD5YOckTLLLuCcqmG9uCgVJIOOatRfjCJJ5kncQnjMvAXkhr+5z3fX0ZPA
         1oOsp61cFOkRg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 08/27] tty: con3215: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:36:53 +0100
Message-ID: <20231206073712.17776-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3215.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 34bc343dcfcc..0b0324fe4aff 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -79,8 +79,8 @@ struct raw3215_info {
 	struct ccw_device *cdev;      /* device for tty driver */
 	spinlock_t *lock;	      /* pointer to irq lock */
 	int flags;		      /* state flags */
-	char *buffer;		      /* pointer to output buffer */
-	char *inbuf;		      /* pointer to input buffer */
+	u8 *buffer;		      /* pointer to output buffer */
+	u8 *inbuf;		      /* pointer to input buffer */
 	int head;		      /* first free byte in output buffer */
 	int count;		      /* number of bytes in output buffer */
 	int written;		      /* number of bytes in write requests */
@@ -522,12 +522,14 @@ static unsigned int raw3215_make_room(struct raw3215_info *raw,
  *	string	without blocking.
  *	Return value is the number of bytes copied.
  */
-static unsigned int raw3215_addtext(const char *str, unsigned int length,
+static unsigned int raw3215_addtext(const u8 *str, size_t length,
 				    struct raw3215_info *raw, int opmode,
 				    unsigned int todrop)
 {
-	unsigned int c, ch, i, blanks, expanded_size = 0;
+	unsigned int i, blanks, expanded_size = 0;
 	unsigned int column = raw->line_pos;
+	size_t c;
+	u8 ch;
 
 	if (opmode == RAW3215_COUNT)
 		todrop = 0;
@@ -558,7 +560,7 @@ static unsigned int raw3215_addtext(const char *str, unsigned int length,
 		if (todrop && expanded_size < todrop)	/* Drop head data */
 			continue;
 		for (i = 0; i < blanks; i++) {
-			raw->buffer[raw->head] = (char)_ascebc[(int)ch];
+			raw->buffer[raw->head] = _ascebc[ch];
 			raw->head = (raw->head + 1) & (RAW3215_BUFFER_SIZE - 1);
 			raw->count++;
 		}
@@ -570,8 +572,8 @@ static unsigned int raw3215_addtext(const char *str, unsigned int length,
 /*
  * String write routine for 3215 devices
  */
-static void raw3215_write(struct raw3215_info *raw, const char *str,
-			  unsigned int length)
+static void raw3215_write(struct raw3215_info *raw, const u8 *str,
+			  size_t length)
 {
 	unsigned int count, avail;
 	unsigned long flags;
@@ -596,7 +598,7 @@ static void raw3215_write(struct raw3215_info *raw, const char *str,
 /*
  * Put character routine for 3215 devices
  */
-static void raw3215_putchar(struct raw3215_info *raw, unsigned char ch)
+static void raw3215_putchar(struct raw3215_info *raw, u8 ch)
 {
 	raw3215_write(raw, &ch, 1);
 }
@@ -823,12 +825,10 @@ static struct ccw_driver raw3215_ccw_driver = {
 	.int_class	= IRQIO_C15,
 };
 
-static void handle_write(struct raw3215_info *raw, const char *str, int count)
+static void handle_write(struct raw3215_info *raw, const u8 *str, size_t count)
 {
-	int i;
-
 	while (count > 0) {
-		i = min_t(int, count, RAW3215_BUFFER_SIZE - 1);
+		size_t i = min_t(size_t, count, RAW3215_BUFFER_SIZE - 1);
 		raw3215_write(raw, str, i);
 		count -= i;
 		str += i;
-- 
2.43.0

