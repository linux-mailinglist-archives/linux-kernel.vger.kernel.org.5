Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D927477DFAD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbjHPK4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbjHPKzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B55C13E;
        Wed, 16 Aug 2023 03:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DBED64FFF;
        Wed, 16 Aug 2023 10:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF26FC433C8;
        Wed, 16 Aug 2023 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183335;
        bh=f0NgofJBUmSnyOLLGLK1G2U+0vgQxZe+PafjYAMnUsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFFno7RU8fFroRTlwyEv3dE4wmWHidBnWnAJI52ytxIlo9XxakgTjA+X9oEe1YDmU
         VU5OpHYDSbL15lY55l4UPHmzjMwx3/GGRmORxWqU+H+yGT8rYNqUt+1VDhl31dXIOz
         seXik9e5dJVoSpekD9EhKHJlYZoK20CLZBsPM28Mdjq9hrWSqYVoIHBpwOXgEmYoPE
         hr8zW01IHvSZTI65sICvPQz50zq4WRf6VtN08eI3sSexLCm8GPgHMQZFqTatTUg4ug
         qsum1XLGYaIKdvthtOG02RcY8TNOPKbw48ynoHcDHcXz4DPiFQLch6ZxrGopT7YGps
         P/AiSAFjvejfg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/10] tty: tty_buffer: switch data type to u8
Date:   Wed, 16 Aug 2023 12:55:21 +0200
Message-ID: <20230816105530.3335-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105530.3335-1-jirislaby@kernel.org>
References: <20230816105530.3335-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to have tty_buffer::data typed as unsigned long.
Switch to u8, but preserve the ulong alignment using __aligned.

This allows for the cast removal from char_buf_ptr(). And for use of
struct_size() in the allocation in tty_buffer_alloc() -- in the next
patch.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/tty_buffer.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index e45cba81d0e9..31125e3be3c5 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -19,12 +19,12 @@ struct tty_buffer {
 	unsigned int read;
 	bool flags;
 	/* Data points here */
-	unsigned long data[];
+	u8 data[] __aligned(sizeof(unsigned long));
 };
 
 static inline u8 *char_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 {
-	return ((u8 *)b->data) + ofs;
+	return b->data + ofs;
 }
 
 static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
-- 
2.41.0

