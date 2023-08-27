Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46CD789BDA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjH0HmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjH0Hl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:41:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D08F4;
        Sun, 27 Aug 2023 00:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F0A360FC9;
        Sun, 27 Aug 2023 07:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D5EC433C7;
        Sun, 27 Aug 2023 07:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122113;
        bh=MoYTBgAtu6sKOwit870xQdmYeIIP7vv4ghjuCBrRV3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxF/HD4OciJyPOKi3dee4RMh85xHKssnGs7l3ennr5Pmk5s6hZ+oQHnKr/5nEa/2N
         +q5dM1bLicKcO6XXVmTlUsf5t9f/c4+Wddxxj6AB4xxyteamKCkMueU8ZKjYndLj6o
         cyWIl+I3Ltdpvo/EbrmsvoFOq3922BIeTS+DX513wdjcH6BgO6N0IKQQvNGedXoPLo
         IX92tzoYAXNEHxTtMD2ad+V0Z4yI5xtkklBsa17gVVJ+3zhgfqTnvEnkhpmnI6Hidl
         uEC8H3HXQro5nUj7D4OXnxKQh8/Wqv/U0n7HAsjswak0uoOtF1/ygNIIloG2cOAEEN
         d3hPuKYTq2ZiQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 02/14] tty: n_tty: use output character directly
Date:   Sun, 27 Aug 2023 09:41:35 +0200
Message-ID: <20230827074147.2287-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827074147.2287-1-jirislaby@kernel.org>
References: <20230827074147.2287-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to use a local variable to store the character when we
can pass it directly. This assignment comes from era when we used to do
get_user(c, b). We no longer need this, so fix this.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 8b2bacb3e40d..f6fa4dbdf78f 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2373,8 +2373,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 				nr -= num;
 				if (nr == 0)
 					break;
-				c = *b;
-				if (process_output(c, tty) < 0)
+				if (process_output(*b, tty) < 0)
 					break;
 				b++; nr--;
 			}
-- 
2.42.0

