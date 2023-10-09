Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1947BEA2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378243AbjJISzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377493AbjJISze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:55:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C7FA4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:55:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F04BC433C7;
        Mon,  9 Oct 2023 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696877733;
        bh=GFc4Q5qaXcf/ZjZp9N+g0hF8nyG1r4y/dZRvyq8Du9A=;
        h=Date:From:To:Cc:Subject:From;
        b=E5t4oZoZGUwok3/PFxqTFm3bx+BQDZJJ+vyjeQKx5qfH3NW3T8avl6qgl+bnyUYJC
         zO1yvhHO+sP4fFX8+Jb4cqmWJslQJwmigAelDrmyPqCA58TgriU+tkTzbfJb5SuovZ
         jmqfndJSghzEQXm51nn5/kzyOz9T/Y1tXPAfnCjNoUTr4bTsLW0LPDmZeCVakppUDH
         jEcJR2BKfR9ECTm+7FG2ekhXkNGfJJsXybno9Pv1LFe6AsPro4qWuKH7WRyXxsIk1O
         o7ESnWSiQu2Nh1It7cAwnSiFhLfLU8drWQ2MQTfz+NjJJgjGI/aYtvnD6rJ7+HzeyS
         ydCrTBcQ7J1Mg==
Date:   Mon, 9 Oct 2023 12:55:30 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] xen/xenbus: Add __counted_by for struct read_buffer
 and use struct_size()
Message-ID: <ZSRMosLuJJS5Y/io@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

While there, use struct_size() helper, instead of the open-coded
version, to calculate the size for the allocation of the whole
flexible structure, including of course, the flexible-array member.

This code was found with the help of Coccinelle, and audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/xen/xenbus/xenbus_dev_frontend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 0792fda49a15..6f56640092a9 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -82,7 +82,7 @@ struct read_buffer {
 	struct list_head list;
 	unsigned int cons;
 	unsigned int len;
-	char msg[];
+	char msg[] __counted_by(len);
 };
 
 struct xenbus_file_priv {
@@ -195,7 +195,7 @@ static int queue_reply(struct list_head *queue, const void *data, size_t len)
 	if (len > XENSTORE_PAYLOAD_MAX)
 		return -EINVAL;
 
-	rb = kmalloc(sizeof(*rb) + len, GFP_KERNEL);
+	rb = kmalloc(struct_size(rb, msg, len), GFP_KERNEL);
 	if (rb == NULL)
 		return -ENOMEM;
 
-- 
2.34.1

