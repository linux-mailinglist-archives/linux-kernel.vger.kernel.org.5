Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67E67F115D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjKTLJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjKTLI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:08:58 -0500
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F110C8;
        Mon, 20 Nov 2023 03:08:07 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1094:0:640:693f:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 5347160AF3;
        Mon, 20 Nov 2023 14:08:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 48KPEc2OmeA0-RYr1IvyC;
        Mon, 20 Nov 2023 14:08:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1700478484; bh=Vm1HwT5DR4IJofIUMyPRScfRp936nGn+krIYXRU3nt8=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=YRsk6JklS+6fFl1O4jC2rNNAsNaddU148WlG7k1YvTnhzMO9NuCla9IOcN81ZMNyA
         N9bJ+oKQGmHhGkjoKf8f7oWfAqOKrB/Fx92Io7iLp/XoMyZbB9onrYykDdbml/uJRt
         ZngDwnuYpRHnjRFv+Hab3jRJXEgbKxKG50Avst1I=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Will Deacon <will@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] uapi: propagate __struct_group() attributes to the container union
Date:   Mon, 20 Nov 2023 14:05:08 +0300
Message-ID: <20231120110607.98956-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the kernel test robot has reported an ARM-specific BUILD_BUG_ON()
in an old and unmaintained wil6210 wireless driver. The problem comes from
the structure packing rules of old ARM ABI ('-mabi=apcs-gnu'). For example,
the following structure is packed to 18 bytes instead of 16:

struct poorly_packed {
        unsigned int a;
        unsigned int b;
        unsigned short c;
        union {
                struct {
                        unsigned short d;
                        unsigned int e;
                } __attribute__((packed));
                struct {
                        unsigned short d;
                        unsigned int e;
                } __attribute__((packed)) inner;
        };
} __attribute__((packed));

To fit it into 16 bytes, it's required to add packed attribute to the
container union as well:

struct poorly_packed {
        unsigned int a;
        unsigned int b;
        unsigned short c;
        union {
                struct {
                        unsigned short d;
                        unsigned int e;
                } __attribute__((packed));
                struct {
                        unsigned short d;
                        unsigned int e;
                } __attribute__((packed)) inner;
        } __attribute__((packed));
} __attribute__((packed));

Thanks to Andrew Pinski of GCC team for sorting the things out at
https://gcc.gnu.org/pipermail/gcc/2023-November/242888.html.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311150821.cI4yciFE-lkp@intel.com
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/uapi/linux/stddef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 5c6c4269f7ef..2ec6f35cda32 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -27,7 +27,7 @@
 	union { \
 		struct { MEMBERS } ATTRS; \
 		struct TAG { MEMBERS } ATTRS NAME; \
-	}
+	} ATTRS
 
 #ifdef __cplusplus
 /* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
-- 
2.42.0

