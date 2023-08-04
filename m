Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B676FE6D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjHDK06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHDK0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:26:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F52118;
        Fri,  4 Aug 2023 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wnWE9A0pZhmWQ/iig8cD0cvaXnMKj6c4FvYq9RiRE3o=; b=LMW8wPAijZIexhoKO9XW2JQ+3Y
        QXJEgjlyjJlCxpMro/f1wYLCu7vv1PxQDFfDnr9e4ZwEAo9z023esGElNhyEXSwtZKGwUyE3XFMAv
        /I7G7hqQC8cyf1hbMtOy+RZzaRxyojzXpjNtipSw+/NPga3r2kWpAMhiFzJyrNx1nH6ijl5uMH7YZ
        L55Y3slIorUhz+Phlk7M0NAmPj/4zXHpbo9xNEZE0Ho8saJsYj/faD1DMCv77OMKW+C66NV54Rehl
        R4ZLcDtC0nrKH7rsp6A2RgMzE0WC7I0GV2iPx8szL8YyZ5nw3EVC/ClkN9GRNR+LG7GcMls6b6pqT
        vgo/3tQA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRs1E-00C7kp-0t;
        Fri, 04 Aug 2023 10:26:52 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk
Cc:     lizetao1@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] romfs: only select BUFFER_HEAD for the block based path
Date:   Fri,  4 Aug 2023 12:26:48 +0200
Message-Id: <20230804102648.78683-1-hch@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selecting BUFFER_HEAD unconditionally does not work as romfs can also
be built with only the MTD backend and thus without CONFIG_BLOCK.

Fixes: 0f842210d97a ("fs/Kconfig: Fix compile error for romfs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/romfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/romfs/Kconfig b/fs/romfs/Kconfig
index 3f6b550eee6192..f24a96a331af1b 100644
--- a/fs/romfs/Kconfig
+++ b/fs/romfs/Kconfig
@@ -2,7 +2,6 @@
 config ROMFS_FS
 	tristate "ROM file system support"
 	depends on BLOCK || MTD
-	select BUFFER_HEAD
 	help
 	  This is a very small read-only file system mainly intended for
 	  initial ram disks of installation disks, but it could be used for
@@ -58,6 +57,7 @@ endchoice
 config ROMFS_ON_BLOCK
 	bool
 	default y if ROMFS_BACKED_BY_BLOCK || ROMFS_BACKED_BY_BOTH
+	select BUFFER_HEAD
 
 config ROMFS_ON_MTD
 	bool
-- 
2.39.2

