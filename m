Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8167F9FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjK0MhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjK0MhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:37:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F33135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:37:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F097FC433C7;
        Mon, 27 Nov 2023 12:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701088640;
        bh=Os/aL6pwYCaykDQuL9blVdurCOtOksBV5A81B3Uv14U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmPBIhDNqfe952AulwvGdFAO4H/dT83Ku1Mmt1cdCOYV45wnHaGDc+d3pBhUq8pUO
         e+18m5V/HtE8EeOmpk5o4wYYdarBexzxBZ4Bs90RKobiw6pQyKnZ58MwA5lsa8LHDj
         ueglzzLkrDb8FRQ/HWjrG5/K3pegBNHg3sSsD8WyKX/I58k/EIjxhlHJf0mb2tYysl
         uGDIBDu1HdAhOHxfTr0A7cbfah114t01pzD+9FVpBawlAJQtStpqw9WSNyY4cIe1Zh
         ZviGo/eYCOXPZjQtx816LO5B+Zp74bf5mYlB487BUSNDqyepwS3lxSHNFxol1Guoaj
         VFYS+EpXbI6kQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 3/5] tty: srmcons: use 'count' directly in srmcons_do_write()
Date:   Mon, 27 Nov 2023 13:37:11 +0100
Message-ID: <20231127123713.14504-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231127123713.14504-1-jirislaby@kernel.org>
References: <20231127123713.14504-1-jirislaby@kernel.org>
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

Similarly to 'buf' in the previous patch, there is no need to have a
separate counter ('remaining') in srmcons_do_write(). 'count' can be
used directly which simplifies the code a bit.

Note that the type of the current count ('c') is changed from 'long' to
'size_t' so that:
1) it is prepared for the upcoming change of 'count's type, and
2) is unsigned.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---

Notes:
    [v2] reordered so that it makes sense

 arch/alpha/kernel/srmcons.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index de896fa9829e..32bc098de7da 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -92,24 +92,24 @@ static void
 srmcons_do_write(struct tty_port *port, const char *buf, int count)
 {
 	static char str_cr[1] = "\r";
-	long c, remaining = count;
+	size_t c;
 	srmcons_result result;
 	int need_cr;
 
-	while (remaining > 0) {
+	while (count > 0) {
 		need_cr = 0;
 		/* 
 		 * Break it up into reasonable size chunks to allow a chance
 		 * for input to get in
 		 */
-		for (c = 0; c < min_t(long, 128L, remaining) && !need_cr; c++)
+		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
 			if (buf[c] == '\n')
 				need_cr = 1;
 		
 		while (c > 0) {
 			result.as_long = callback_puts(0, buf, c);
 			c -= result.bits.c;
-			remaining -= result.bits.c;
+			count -= result.bits.c;
 			buf += result.bits.c;
 
 			/*
-- 
2.42.1

