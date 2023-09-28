Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21007B24CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjI1SII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjI1SIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:08:05 -0400
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A471AD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1695924469; bh=oObhWCm0aLg4S+GS1V9cLf/a75Slux1PBQAsLF5Xpos=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=aZBjYWK8O+r3GWmOXTHMtUrkjxMO+/JCA8mNVlu7TgNgO6LmdC3AGLP0uGiHtMb0S
         KiMttSmBr7ArfkieuKhF5NHDmlblmtpxS/8XJ0IkRQNqncCeleuqfmOlWsoSeAvrEp
         wgX8oN5MjA+TWCVMwRqsizlNSy5sQSgVT40HF++I=
Received: by b221-4.in.mailobj.net [192.168.90.24] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 28 Sep 2023 20:07:49 +0200 (CEST)
X-EA-Auth: UsKampcKnXwLSvLdP7O8yhzEp/Ut96KaB06/sLcfF/h3F5XRvLbqg4ykuLZZ66CGW17C8kGlVgTOtG97uwG4MyxA39usmocW
Date:   Thu, 28 Sep 2023 23:37:42 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <error27@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] gfs2: fix 'passing zero to ERR_PTR()' warning
Message-ID: <ZRXA7n0wD83zhPxC@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve the following Smatch static checker warning:
	fs/gfs2/acl.c:54 __gfs2_get_acl() warn: passing zero to 'ERR_PTR'

by returning NULL when an extended attribute length is zero, instead of
passing on zero to the ERR_PTR().

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: Patch is build tested only.


 fs/gfs2/acl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 443640e6fb9c..818d67f10dcf 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -50,8 +50,11 @@ static struct posix_acl *__gfs2_get_acl(struct inode *inode, int type)

 	name = gfs2_acl_name(type);
 	len = gfs2_xattr_acl_get(ip, name, &data);
-	if (len <= 0)
+	if (len == 0)
+		return NULL;
+	if (len < 0)
 		return ERR_PTR(len);
+
 	acl = posix_acl_from_xattr(&init_user_ns, data, len);
 	kfree(data);
 	return acl;
--
2.39.2



