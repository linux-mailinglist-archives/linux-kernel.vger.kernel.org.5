Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6107B7F28D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjKUJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjKUJXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8FD1718
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AA5C433B6;
        Tue, 21 Nov 2023 09:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558611;
        bh=PA6BiikxG3uzO12jc1Xme6+JXf2R8R2PKRHIkH33CJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lkgd3ALh6dk93dgNjaqw6JHJlFb0jSZb+q4FfSbAPgUgud1HxYBjbcmgKV/CDcpmt
         cjQzjlXKtWivtcuTnsTYYGZhAZnAXKN7KnexLfCnAIj5KOBH3l6jrSPilvG5OPG7xB
         g1AaPKRNUhn+kTxDy46JntHNCk/Uy90l+aiDPOKLD66fnPqVmKjxpKr3sJ9wpNru/8
         P23MaZYg0z+UKBvB9ZRn/CAfdgYvjyhvjJgh/kr1rfyxUicCV92g6ulSC2MeT3cnnu
         /DEUeBCvb8rdnqdLMoTlnSXDJXWjiL8AqvxhsVaEA2zX512fmMyURtmqCt9KgKT1bS
         AJaC7XUVnWTKQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 15/17] tty: srmcons: make srmcons_do_write() return void
Date:   Tue, 21 Nov 2023 10:22:56 +0100
Message-ID: <20231121092258.9334-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
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

The return value of srmcons_do_write() is ignored as all characters are
pushed. So make srmcons_do_write() to return void.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 8025e2a882ed..32bc098de7da 100644
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

