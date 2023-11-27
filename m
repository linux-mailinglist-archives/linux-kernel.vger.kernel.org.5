Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096CA7F9FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjK0Mh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjK0MhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:37:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4D18F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:37:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3171CC433C9;
        Mon, 27 Nov 2023 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701088643;
        bh=uyHZEuXLj22GNLDewaozjXuiaYjIbKInpUePCEbPMjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDwsYs3aHeHIduMUjTAwD49prGX/Mai38E0SL3liafrzH4IXWc3psrcB65CWF7/5V
         HQG5ak0m0QpIwiq0aisO/RPsz+YWq7OtBN1AU1nhvARAYj9ROzidrqNQeBdUBrPrUc
         PG2PRld6fF22fYqYCI1tDDppzujvfA9ZvpMXCNMvX/k3zfmj8EixWlK3Z0JbH6HmPC
         TDkxsWEbIMZWYiIBPEaG8YNk0JuSJpcUVA+GOPa+oIVTyNalrajh53xwGHVv8Z5dON
         tL5YNV+1l/nrhLPk/frsYRnhZOlmq2DYCb3jq2MshDUkcDTW49+5Xfzrn5adUtYxEP
         1tUkCYfECThPA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 4/5] tty: srmcons: switch need_cr to bool
Date:   Mon, 27 Nov 2023 13:37:12 +0100
Message-ID: <20231127123713.14504-4-jirislaby@kernel.org>
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

'need_cr' is a flag, so type it properly to be a 'bool'. Move the
declaration into the loop too. That ensures the variable is initialized
properly even if the code was moved somehow.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 32bc098de7da..c6b821afbfd3 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -94,17 +94,16 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 	static char str_cr[1] = "\r";
 	size_t c;
 	srmcons_result result;
-	int need_cr;
 
 	while (count > 0) {
-		need_cr = 0;
+		bool need_cr = false;
 		/* 
 		 * Break it up into reasonable size chunks to allow a chance
 		 * for input to get in
 		 */
 		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
 			if (buf[c] == '\n')
-				need_cr = 1;
+				need_cr = true;
 		
 		while (c > 0) {
 			result.as_long = callback_puts(0, buf, c);
@@ -122,7 +121,7 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 		while (need_cr) {
 			result.as_long = callback_puts(0, str_cr, 1);
 			if (result.bits.c > 0)
-				need_cr = 0;
+				need_cr = false;
 		}
 	}
 }
-- 
2.42.1

