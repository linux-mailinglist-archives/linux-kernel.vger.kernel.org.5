Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3094A77D2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbjHOTDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbjHOTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:03:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BAA2683
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 380D51FD6E;
        Tue, 15 Aug 2023 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6ETb9fq7HCS4tFLoqPg7xnmdjK64qt8f71hdCKXa8k=;
        b=Srfm4UIYpzYCy+pYQArW4SxQonZ5+jWY7nv/E7sBGpPswXQHq7983vZb9/d1dGCW7SO2Xf
        nniw5P4lwgYZZ2DXM9TI0nkgulDgihioKeeIV8dhrXmm9tVXrpnsHVsUH8nMbD4Y6YlSGr
        4L4rjJw2xd8/m86Y4d35oC3CFciiTbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6ETb9fq7HCS4tFLoqPg7xnmdjK64qt8f71hdCKXa8k=;
        b=i0q7ZsVZIbbzD8jgYdc2BErt+pTjvH+NSFNlrHYEq9UewDlu0/IcP4xjSNq5UPOj4I6RDo
        qiogmyqMORJFJoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1544D1353E;
        Tue, 15 Aug 2023 19:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WMhdBJ7L22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:50 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 19/25] ASoC: mediatek: Convert to generic PCM copy ops
Date:   Tue, 15 Aug 2023 21:01:30 +0200
Message-Id: <20230815190136.8987-20-tiwai@suse.de>
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

This patch converts the mediatek BT SCO driver code to use the new
unified PCM copy callback.  It's a straightforward conversion from
*_user() to *_iter() variants.  As copy_form/to_iter() updates the
internal offset at each read/write, we can drop the cur_*_idx counter
in the loop, too.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is adjusted accordingly.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 27 ++++++++++----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index 1ba0633e542f..c12d170fa1de 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -696,11 +696,10 @@ static int wait_for_bt_irq(struct mtk_btcvsd_snd *bt,
 }
 
 static ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
-				   char __user *buf,
+				   struct iov_iter *buf,
 				   size_t count)
 {
 	ssize_t read_size = 0, read_count = 0, cur_read_idx, cont;
-	unsigned int cur_buf_ofs = 0;
 	unsigned long avail;
 	unsigned long flags;
 	unsigned int packet_size = bt->rx->packet_size;
@@ -743,10 +742,9 @@ static ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
 		if (read_size > cont)
 			read_size = cont;
 
-		if (copy_to_user(buf + cur_buf_ofs,
-				 bt->rx_packet_buf + cur_read_idx,
-				 read_size)) {
-			dev_warn(bt->dev, "%s(), copy_to_user fail\n",
+		if (copy_to_iter(bt->rx_packet_buf + cur_read_idx,
+				 read_size, buf) != read_size) {
+			dev_warn(bt->dev, "%s(), copy_to_iter fail\n",
 				 __func__);
 			return -EFAULT;
 		}
@@ -756,7 +754,6 @@ static ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
 		spin_unlock_irqrestore(&bt->rx_lock, flags);
 
 		read_count += read_size;
-		cur_buf_ofs += read_size;
 		count -= read_size;
 	}
 
@@ -777,11 +774,10 @@ static ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
 }
 
 static ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
-				    char __user *buf,
+				    struct iov_iter *buf,
 				    size_t count)
 {
 	int written_size = count, avail, cur_write_idx, write_size, cont;
-	unsigned int cur_buf_ofs = 0;
 	unsigned long flags;
 	unsigned int packet_size = bt->tx->packet_size;
 
@@ -835,11 +831,9 @@ static ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
 		if (write_size > cont)
 			write_size = cont;
 
-		if (copy_from_user(bt->tx_packet_buf +
-				   cur_write_idx,
-				   buf + cur_buf_ofs,
-				   write_size)) {
-			dev_warn(bt->dev, "%s(), copy_from_user fail\n",
+		if (copy_from_iter(bt->tx_packet_buf + cur_write_idx,
+				   write_size, buf) != write_size) {
+			dev_warn(bt->dev, "%s(), copy_from_iter fail\n",
 				 __func__);
 			return -EFAULT;
 		}
@@ -847,7 +841,6 @@ static ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
 		spin_lock_irqsave(&bt->tx_lock, flags);
 		bt->tx->packet_w += write_size / packet_size;
 		spin_unlock_irqrestore(&bt->tx_lock, flags);
-		cur_buf_ofs += write_size;
 		count -= write_size;
 	}
 
@@ -1033,7 +1026,7 @@ static snd_pcm_uframes_t mtk_pcm_btcvsd_pointer(
 static int mtk_pcm_btcvsd_copy(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream,
 			       int channel, unsigned long pos,
-			       void __user *buf, unsigned long count)
+			       struct iov_iter *buf, unsigned long count)
 {
 	struct mtk_btcvsd_snd *bt = snd_soc_component_get_drvdata(component);
 
@@ -1274,7 +1267,7 @@ static const struct snd_soc_component_driver mtk_btcvsd_snd_platform = {
 	.prepare	= mtk_pcm_btcvsd_prepare,
 	.trigger	= mtk_pcm_btcvsd_trigger,
 	.pointer	= mtk_pcm_btcvsd_pointer,
-	.copy_user	= mtk_pcm_btcvsd_copy,
+	.copy		= mtk_pcm_btcvsd_copy,
 };
 
 static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
-- 
2.35.3

