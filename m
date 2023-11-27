Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A07F9FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjK0MhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjK0MhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:37:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529D137
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:37:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA21C433CA;
        Mon, 27 Nov 2023 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701088638;
        bh=7xwl2go0dypemlRQx0VO0egjtxiAuAu5+0HRC11KHFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NS+1TflWMGnme8u2dnnmKXzu3p5uLGRFpki3eE/ZTF+zo6R980UPkMsFL6QQq9/KF
         TLK9TlUGuZRV8BlcoITBHrf6fOtkxgl2sSoM2XmI9U4WJ8i2bsMXV5bNa3DF56cUaS
         h/j/ux80f6jrAq5/VjiMw08iTXFyNsnbWvAWtiwFBdL6uOpgfrnJLfjQIHv8DAe20g
         RThm7zSjfd0BnD0xnYDBQsXjm9xKlfM9Y1sItz7p+KqXQvY68v/4E+rs12Mm328q/u
         9xFCVvd1PLXAp8xuqtpPxOow2ZGee81kN1I0BFY2oNf77/BRuEz5Hv4xlnhdgXbbTz
         0Tunq2OROve3Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 2/5] tty: srmcons: make srmcons_do_write() return void
Date:   Mon, 27 Nov 2023 13:37:10 +0100
Message-ID: <20231127123713.14504-2-jirislaby@kernel.org>
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

The return value of srmcons_do_write() is ignored as all characters are
pushed. So make srmcons_do_write() to return void.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---

Notes:
    [v2] reordered so that it makes sense

 arch/alpha/kernel/srmcons.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index b68c5af083cd..de896fa9829e 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -88,7 +88,7 @@ srmcons_receive_chars(struct timer_list *t)
 }
 
 /* called with callback_lock held */
-static int
+static void
 srmcons_do_write(struct tty_port *port, const char *buf, int count)
 {
 	static char str_cr[1] = "\r";
@@ -125,7 +125,6 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 				need_cr = 0;
 		}
 	}
-	return count;
 }
 
 static ssize_t
-- 
2.42.1

