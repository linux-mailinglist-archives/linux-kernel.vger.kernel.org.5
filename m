Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E2C80449C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343937AbjLECYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjLECYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:24:14 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72725CE;
        Mon,  4 Dec 2023 18:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=v4vafIp0lx9db/09meQhTdWX3KXD/90cqv4KIh7IvXU=; b=KaDecUGVJTBarWzcIdGONopl76
        81cGwcUbG9/pwyWFQgh8/vDOz2vsgw3usdmXo4MrunVxpOr4O20rFb8lmhRvPSg7HY5eVNADhYO/5
        tqt5FRY7HROjCgKesVoWICVmsWQjGxUlPDibUMP2QccKA5ZF1BFEU7RSvCs7EJMA3VS+Yzi5AgKdt
        9MgN/MtQITSeHHwxlDKeDHlxlF4rBztbzx9PoHnFKE9ZvG88kuSTZl3J+mKR/c8NyrOqrC7owExaG
        HClrfzbar1oV1rtQwVhUmrY/wVUy3UTZSZONtSGACzeawHxQGEvUyI9Od/tfjtHbym6fCECGYOw+R
        IswYVnHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAL6g-00791y-1Q;
        Tue, 05 Dec 2023 02:24:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 01/18] make net/checksum.h self-contained
Date:   Tue,  5 Dec 2023 02:23:52 +0000
Message-Id: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022100.GB1674809@ZenIV>
References: <20231205022100.GB1674809@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It uses ror32(), so have it pull linux/bitops.h
(and linux/bitops.h pulls asm/types.h)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/net/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/checksum.h b/include/net/checksum.h
index 1338cb92c8e7..5bf7dcebb5c2 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -16,7 +16,7 @@
 #define _CHECKSUM_H
 
 #include <linux/errno.h>
-#include <asm/types.h>
+#include <linux/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/checksum.h>
 #if !defined(_HAVE_ARCH_COPY_AND_CSUM_FROM_USER) || !defined(HAVE_CSUM_COPY_USER)
-- 
2.39.2

