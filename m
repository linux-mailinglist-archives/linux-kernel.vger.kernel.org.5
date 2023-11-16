Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038F07EE709
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjKPSzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKPSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:55:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7FC1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:55:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBB8C433C8;
        Thu, 16 Nov 2023 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700160902;
        bh=JwQgKXdyVFHDeYy2JqIrcrbfOB3OycZsBTQgBU7qjPM=;
        h=Date:From:To:Cc:Subject:From;
        b=Q2KeOstZqpSdN4JhKTSNmJecY3BmKrmxV0TKxlDYtF5gv7UBoA9ki8l+3oU7WT0Hx
         SGmSc3VfEncIDsy7g1gUdu/dUurdmxWoNKqVqXpNG0JIQn/9CRKtLj4EZby3gR0ebM
         W29DzH+9f5rXc4ky/j82PuHjBZxanaXp2OXpLgfdOeYwEyc8H6InT7BIuTjYwI2twZ
         K2Q59QirBuKsjjD1uHuCUq6Vt0CT0Ut1+Mc3R70pFEkwWmeLddoRJdAqfYUx+Un6j7
         onTVWGPMm6W16RlorLGNo7T/80qIpz+vuwThsSHkscF6lBwIA6x+UPnUOlCQ+Gw8al
         9yTiFS6TTIGSg==
Date:   Thu, 16 Nov 2023 12:54:59 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] xen: privcmd: Replace zero-length array with
 flex-array member and use __counted_by
Message-ID: <ZVZlg3tPMPCRdteh@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fake flexible arrays (zero-length and one-element arrays) are deprecated,
and should be replaced by flexible-array members. So, replace
zero-length array with a flexible-array member in `struct
privcmd_kernel_ioreq`.

Also annotate array `ports` with `__counted_by()` to prepare for the
coming implementation by GCC and Clang of the `__counted_by` attribute.
Flexible array members annotated with `__counted_by` can have their
accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for array
indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family functions).

This fixes multiple -Warray-bounds warnings:
drivers/xen/privcmd.c:1239:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
drivers/xen/privcmd.c:1240:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
drivers/xen/privcmd.c:1241:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
drivers/xen/privcmd.c:1245:33: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
drivers/xen/privcmd.c:1258:67: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]

This results in no differences in binary output.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 1ce7f3c7a950..0eb337a8ec0f 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1115,7 +1115,7 @@ struct privcmd_kernel_ioreq {
 	spinlock_t lock; /* Protects ioeventfds list */
 	struct list_head ioeventfds;
 	struct list_head list;
-	struct ioreq_port ports[0];
+	struct ioreq_port ports[] __counted_by(vcpus);
 };
 
 static irqreturn_t ioeventfd_interrupt(int irq, void *dev_id)
-- 
2.34.1

