Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176C8777428
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjHJJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjHJJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9973AA0;
        Thu, 10 Aug 2023 02:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82646654E4;
        Thu, 10 Aug 2023 09:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CFFC433BB;
        Thu, 10 Aug 2023 09:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658962;
        bh=9QHODcZM6KKrgHiwTBHLES0drVEZoPScIy4Zc+1uY7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LV4M+mX17H/l62Y8F0htkILTVvHc8End0nfp4b6Da2Yv59kFUo6ruj+1jgNQDcPcL
         bEMUVjHoLQGmQV7WaF4RCa2IIkcseaWUE0c8b+hkKxgKilfqOVQLeuUZxr1F403lQ5
         PIAWg4wpd/85K7c7aS0EDgIDJkLA7qollbgW/AGapkfJwmNrQDewzQHrMcegNbfOAG
         RIZ7+fRH0weBi8Blk9D1MvRb+rP4LFr8xPygL4RTyy5OtvGxC7k/attTUGRsgFnNf3
         gehTGnIVTbaR0eaPFStVZnt1BCk/A0sJ9zKi1QJ1iCG/t0SumZFzLG3ZtccJBM+Mnw
         dheXEGy0ytwRw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 19/36] tty: make char_buf_ptr()/flag_buf_ptr()'s offset unsigned
Date:   Thu, 10 Aug 2023 11:14:53 +0200
Message-ID: <20230810091510.13006-20-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
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

The offset is meant from the beginning of data, so unsigned. Make it as
such for clarity. All struct tty_buffer's members should be unsigned
too -- see the next patch.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 include/linux/tty_buffer.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index b11cc8c749d2..391a875be20c 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -22,12 +22,12 @@ struct tty_buffer {
 	unsigned long data[];
 };
 
-static inline u8 *char_buf_ptr(struct tty_buffer *b, int ofs)
+static inline u8 *char_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 {
 	return ((u8 *)b->data) + ofs;
 }
 
-static inline u8 *flag_buf_ptr(struct tty_buffer *b, int ofs)
+static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 {
 	return char_buf_ptr(b, ofs) + b->size;
 }
-- 
2.41.0

