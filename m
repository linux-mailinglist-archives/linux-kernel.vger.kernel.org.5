Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765A28119D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjLMQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjLMQnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:43:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA8A10C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:43:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8150DC433C9;
        Wed, 13 Dec 2023 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485794;
        bh=+jJ0AZEvag610YYMeIA2DZY9vRhnQ1MUWo6qd+Qzkcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Plg/RkoEgxcb5oLFgT/r2pbwVa+OiOKfDqeFr23Y4XhEqyZ5uVBDN++Xkp9njtYA/
         e/ZmXCZgAUTOyvm1+MRDRVjk/Goo8EXcyPKp/Z5Jq6vkTd7Z0kpFegYh/Cr9+MFWQC
         ExHTW5hlY3r+qo8ZKQSDl3P2AIFZRW2roFNhvsQBR8o6zm7rZPMr8nRhSijOrPYRQB
         jum+fusgZZy+M4y8zPPL3U6Btq5SJH2c8BRlGS5oiDRK4vX1rVhGb5qPcu+A+1FypL
         eGsgpAVmBSsoR8RBqoGoAYvcP7xcmaFTF+SCgp92suHe8vT62kPWYfSnmce8dWivHj
         6fNgbUfjI7k1Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 09/12] usb: mon_stat: Replace snprintf() with the safer scnprintf() variant
Date:   Wed, 13 Dec 2023 16:42:38 +0000
Message-ID: <20231213164246.1021885-10-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213164246.1021885-1-lee@kernel.org>
References: <20231213164246.1021885-1-lee@kernel.org>
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

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).  So let's
do that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/mon/mon_stat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/mon/mon_stat.c b/drivers/usb/mon/mon_stat.c
index 98ab0cc473d67..3c23805ab1a44 100644
--- a/drivers/usb/mon/mon_stat.c
+++ b/drivers/usb/mon/mon_stat.c
@@ -35,9 +35,9 @@ static int mon_stat_open(struct inode *inode, struct file *file)
 
 	mbus = inode->i_private;
 
-	sp->slen = snprintf(sp->str, STAT_BUF_SIZE,
-	    "nreaders %d events %u text_lost %u\n",
-	    mbus->nreaders, mbus->cnt_events, mbus->cnt_text_lost);
+	sp->slen = scnprintf(sp->str, STAT_BUF_SIZE,
+			     "nreaders %d events %u text_lost %u\n",
+			     mbus->nreaders, mbus->cnt_events, mbus->cnt_text_lost);
 
 	file->private_data = sp;
 	return 0;
-- 
2.43.0.472.g3155946c3a-goog

