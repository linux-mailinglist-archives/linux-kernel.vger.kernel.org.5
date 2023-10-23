Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18D7D4347
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjJWXhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjJWXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:37:32 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B0FD6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:37:30 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id BE6B4C01A; Tue, 24 Oct 2023 01:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698104247; bh=DieO6nLmhMIqZKysrRjkquiB3ylJYMRIAY1/0apJM7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=As7hYBKJcsMK7eqVfmb98m7g9QVUHPyzbw+8kljawWmtI6EmNy3K5S5193py0+cK1
         Hj+r13Y6QRPMS0jpra9jmQjUNdcW227JSYtim2JI+KUUnoMojrPp0vcRW/pNjNTTa0
         /Dk1vKx5Ccyk5p8CuQ8yI9AZlr6ywQf1fP9sLoJM2p2P0phQYCblgmYaIKSVH6fM4z
         QyVAK+OqpcvVK53Z9hJGT5jyG40vBawKpsjXSxTWe6vzSZUzANZL/8Di56axkUJ/fz
         0UVixLOfhf81D9Dv5yo1LIk8N5KxmsVjGwDnqiMpv3FV81iZ6JaU9UkRhtDdUVsgAk
         UnfNJCE3lPEAA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 40535C01A;
        Tue, 24 Oct 2023 01:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698104246; bh=DieO6nLmhMIqZKysrRjkquiB3ylJYMRIAY1/0apJM7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldMR/5s1aEDMSt/4JHtx3ytpCH02TK1IjzclsiD3vV/jGgHI5o4CAEEhdbe2VFiuL
         ykV2SYqK0o+3+L/OuICoC3lDjOBVAqiiePcA7vPx7a4MZCKE7qTI4S1miw2pH4/6ed
         8xfaPCcrejJKMtvSqj1aXXBAStHbpf2jmHahWlRZkaMz0X+uu70vqBIcZMGOncxpst
         1fMe7I/m5YLEZC+ARzv/al35YRI36tAoQ2I8O48RVsL5kuf9qOUUlHElKPX46GWkBr
         iPm3ZB1VHBNxcceiTYj9V15Svz0cq8saNQOZNa1zmc/vbE0f7fxIKy2bmERd5V+ZXM
         gxtY4orBogjCA==
Received: from gaia.codewreck.org (localhost.lan [::1])
        by gaia (OpenSMTPD) with ESMTP id c8ad982d;
        Mon, 23 Oct 2023 23:37:16 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs@lists.linux.dev, ericvh@kernel.org, linux_oss@crudebyte.com
Cc:     lucho@ionkov.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Su Hui <suhui@nfschina.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 2/3] 9p: v9fs_listxattr: fix %s null argument warning
Date:   Tue, 24 Oct 2023 08:37:03 +0900
Message-ID: <20231023233704.1185154-3-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023233704.1185154-1-asmadeus@codewreck.org>
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W=1 warns about null argument to kprintf:
In file included from fs/9p/xattr.c:12:
In function ‘v9fs_xattr_get’,
    inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
[-Werror=format-overflow=]
   55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use an empty string instead of :
 - this is ok 9p-wise because p9pdu_vwritef serializes a null string
and an empty string the same way (one '0' word for length)
 - since this degrades the print statements, add new single quotes for
xattr's name delimter (Old: "file = (null)", new: "file = ''")

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/r/20231008060138.517057-1-suhui@nfschina.com
Suggested-by: Su Hui <suhui@nfschina.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
---
I've checked this works as expected (getfattr listing all user.* xattrs
after setting some), so let's fix this warning.

As pointed out by Dan this makes the message les clear, so I added
single quotes to make it clear we're dealing with an empty string; I
think it's good enough.
Su, I made you only Suggested-by because of the extra legwork and
format changes, but happy to give you authorship if it's something you
care about; I'd just like to get it out during the next merge window
in a couple of weeks so please say the word.

This makes fs/9p build warning-free with W=1 on gcc 12

 fs/9p/xattr.c   | 4 ++--
 net/9p/client.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index e00cf8109b3f..d29907c378fd 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -68,7 +68,7 @@ ssize_t v9fs_xattr_get(struct dentry *dentry, const char *name,
 	struct p9_fid *fid;
 	int ret;
 
-	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu\n",
+	p9_debug(P9_DEBUG_VFS, "name = '%s' value_len = %zu\n",
 		 name, buffer_size);
 	fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
@@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 
 ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
-	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
+	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
 }
 
 static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
diff --git a/net/9p/client.c b/net/9p/client.c
index 86bbc7147fc1..9c2bc15e3cfa 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1979,7 +1979,7 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *file_fid,
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P,
-		 ">>> TXATTRWALK file_fid %d, attr_fid %d name %s\n",
+		 ">>> TXATTRWALK file_fid %d, attr_fid %d name '%s'\n",
 		 file_fid->fid, attr_fid->fid, attr_name);
 
 	req = p9_client_rpc(clnt, P9_TXATTRWALK, "dds",
-- 
2.41.0

