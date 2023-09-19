Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4017A5CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjISIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjISIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7222FE6;
        Tue, 19 Sep 2023 01:52:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCF4C433C8;
        Tue, 19 Sep 2023 08:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113521;
        bh=Z65rlSSe5rxg0BM+imKZAtq/SW24Xm/16B5wVK3QGRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZvTGqZVgla0MW6UhsfsySiRrFuiu4Mbwnf3wxBPTfnp+q3FXf9JlMKIHZXQTnWpt
         VMPosdBg1rs3JK0E5oxJ8TuMHEneVuRKLDtje+eMrJvHHtQYjVm4IL3us53HXcJi1R
         9HafvmhlytUSZemqIupHGaXuBOD6kcUacpKwvmSZPdh4g8dTz1MMxBGNYUwuWT3NP2
         eDlma0PXYbFz2ublkuFs9zBo6oNiL1tmgeDCLXub89n6YZQgC/HtrwEakJ/TCl82d3
         kkwMQGqXch0gkSPFkay9bzwjLphzzCCVvnAFayBvFC6lc0wfby3mjHbr40Bt2aghQe
         TjJejPSf7Qj5w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/15] tty: n_tty: use 'retval' instead of 'c'
Date:   Tue, 19 Sep 2023 10:51:42 +0200
Message-ID: <20230919085156.1578-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919085156.1578-1-jirislaby@kernel.org>
References: <20230919085156.1578-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In n_tty_read(), there is a separate int variable 'c' and is used only
to hold an int value returned from job_control(). There is also a
'retval' variable typed ssize_t. So drop this single occurrence of 'c'
and reuse 'retval' which is used on all other places to hold the value
returned from n_tty_read().

Note that 'retval' needs not be initialized now. Drop that.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 6c9a408d67cd..71aa898b077a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2154,9 +2154,8 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 	struct n_tty_data *ldata = tty->disc_data;
 	u8 *kb = kbuf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	int c;
 	int minimum, time;
-	ssize_t retval = 0;
+	ssize_t retval;
 	long timeout;
 	bool packet;
 	size_t old_tail;
@@ -2192,9 +2191,9 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 		return kb - kbuf;
 	}
 
-	c = job_control(tty, file);
-	if (c < 0)
-		return c;
+	retval = job_control(tty, file);
+	if (retval < 0)
+		return retval;
 
 	/*
 	 *	Internal serialization of reads.
-- 
2.42.0

