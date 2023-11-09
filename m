Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979977E61C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 02:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjKIBSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 20:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjKIBSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 20:18:45 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D25EE25B6;
        Wed,  8 Nov 2023 17:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=H2MrE
        P4Pk8UhpGfWF10RAj7laH3eHNP3CvzSzKNDEi0=; b=oj83yIuq5lhsZBWfs+qUp
        PgHt2VywnaxiTf0I3okmG+h/FY0NtHAkJyIv5uNuR/W8W/EoxZsVgQaQLoCHXJ6z
        X6vdrFDUbKZPVEo1xfQRbrME4K91vxFIWGmYJf7LOCFjko4NE+DxhH5dRVBu7tVv
        LW780qvjtmW0cyVZ8wJAQI=
Received: from thinkpadx13gen2i.. (unknown [111.48.58.12])
        by zwqz-smtp-mta-g5-2 (Coremail) with SMTP id _____wAHp9EwM0xlnBOeCg--.3255S2;
        Thu, 09 Nov 2023 09:17:37 +0800 (CST)
From:   Zongmin Zhou <min_halo@163.com>
To:     linkinjeon@kernel.org
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, sfrench@samba.org, tom@talpey.com,
        Zongmin Zhou <min_halo@163.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH v2] ksmbd: prevent memory leak on error return
Date:   Thu,  9 Nov 2023 09:17:25 +0800
Message-Id: <20231109011725.1798784-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd8qZTiSBR3aSUk4YRSo+LG-Z20FRJfGgV1Awf+Lep4kpg@mail.gmail.com>
References: <CAKYAXd8qZTiSBR3aSUk4YRSo+LG-Z20FRJfGgV1Awf+Lep4kpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHp9EwM0xlnBOeCg--.3255S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw15Gr4UtFWfuryUAFyDAwb_yoWDtrb_C3
        45Xw48WrZ0yayDJw15Zr1Yk3sagw48ZFy0gF1ftF4xGa1UJr15Gws8X3s5uFna9rWkZrZx
        Gw17ursxKw13XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKPfHUUUUUU==
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbiUBQjq1WBz+-QugAAsS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocated memory for 'new' failed,just return
will cause memory leak of 'ar'.

v2: rollback iov_alloc_cnt when allocate memory failed.

Fixes: 1819a9042999 ("ksmbd: reorganize ksmbd_iov_pin_rsp()")

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202311031837.H3yo7JVl-lkp@intel.com/
Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
---
 fs/smb/server/ksmbd_work.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index a2ed441e837a..44bce4c56daf 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -123,8 +123,11 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 		new = krealloc(work->iov,
 			       sizeof(struct kvec) * work->iov_alloc_cnt,
 			       GFP_KERNEL | __GFP_ZERO);
-		if (!new)
+		if (!new) {
+			kfree(ar);
+			work->iov_alloc_cnt -= 4;
 			return -ENOMEM;
+		}
 		work->iov = new;
 	}
 
-- 
2.34.1

