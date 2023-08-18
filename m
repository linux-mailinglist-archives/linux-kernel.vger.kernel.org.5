Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0DF78025C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356447AbjHRABr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356496AbjHRABN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:01:13 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC13C2F;
        Thu, 17 Aug 2023 17:01:00 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34bae82b2ffso1301285ab.1;
        Thu, 17 Aug 2023 17:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692316842; x=1692921642;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ob2V2ZAUPHW3e5EnDvRG4L5HNwkLuIUU++tOEmo/pnY=;
        b=qfNLK2cORHJbGfKhKLYJvJ5BuBMEKl0rtq1sM9J7FUn3jbZIscnpbKCuPJnR6FCK8N
         4dhJfD+ZbIrYveMFrLmf+/RFGRa08H9ahn2O8TIz6Qdi0CaoBJVZp+BCsuEruuQMu0xw
         QmGsTSTGAXcPkv8PpnfUAkLzmHEThovxWaXr5wA/Xm4XcNcwp6XhHT4VOfZOu9Qvx1ZX
         tkc/FsyYMqsuhCACSFZW9gIjKmjdDS7C6nMYABZUA+wbxrqMMUDeEWZGgT2e6grOnwOB
         /dlw2qELd1oP8J8tqroJRfSYrAau9qUjcIi6CJs5cdfMOXJWk2JM7Rx6sQzBHbMScDM1
         XpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316842; x=1692921642;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob2V2ZAUPHW3e5EnDvRG4L5HNwkLuIUU++tOEmo/pnY=;
        b=GrAA8pvTsBP84LQ3nPfdE7eX/9nUBzM19s4eLtUaF32TGbBwwWJtMfzBHaiau7hqjf
         RS95CQ7V8R4UG9XrP75AHPtOxBu5+IdV3Wk7FvuZCVPS7xT580YVfCgCCuVBAEA//T8T
         8j9OXsjo8bk8Q4DaykqMiIW7YYvJkuKhB8WwObkz/dVBSo9rvkS5flReaUJt+FRNXdcU
         WKSdVKuNV3See9m9UU6EfNCYErRaLOWAMx8dnJdcyWSxIL3M3zT/phzQZy+lVzSUzJcO
         woxdvtB+fPS6cwvFZ+Lv8gaGKlSsyNSNGpXCXVTN8kvlhxtjYx6L8i4QJxIOZxGghtYH
         Uc9g==
X-Gm-Message-State: AOJu0YyQGHuIFy2ccorsNWueged7VJ4XL6VyNynOb+jR3wIPOjVWunwC
        l7nvFR/BMtdDUNh33ek2IPTGl/bpW4Xi6g==
X-Google-Smtp-Source: AGHT+IH1vCQkmqUZlt3Ig/EPWUsNrxZqGcu80BHC0b+Ab/TOyBl/Mxi4L7sKzKqks2Z4xpX18PJ0wg==
X-Received: by 2002:a92:da04:0:b0:345:bfc7:d527 with SMTP id z4-20020a92da04000000b00345bfc7d527mr1156798ilm.7.1692316841815;
        Thu, 17 Aug 2023 17:00:41 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.161])
        by smtp.gmail.com with ESMTPSA id h6-20020a02cd26000000b0042af069eeefsm164232jaq.50.2023.08.17.17.00.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2023 17:00:41 -0700 (PDT)
From:   Sishuai Gong <sishuai.system@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: [PATCH v2] tracefs: avoid changing i_mode to a temp value
Message-Id: <AB5B0A1C-75D9-4E82-A7F0-CF7D0715587B@gmail.com>
Date:   Thu, 17 Aug 2023 20:00:31 -0400
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
To:     rostedt@goodmis.org, mhiramat@kernel.org
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now inode->i_mode is updated twice to reach the desired value
in tracefs_apply_options(). Because there is no lock protecting the two
writes, other threads might read the intermediate value of =
inode->i_mode.

Thread-1			Thread-2
// tracefs_apply_options()	//e.g., acl_permission_check
inode->i_mode &=3D ~S_IALLUGO;
				unsigned int mode =3D inode->i_mode;
inode->i_mode |=3D opts->mode;

I think there is no need to introduce a lock but it is better to
only update inode->i_mode ONCE, so the readers will either see the old
or latest value, rather than an intermediate/temporary value.

Signed-off-by: Sishuai Gong <sishuai.system@gmail.com>
---
 fs/tracefs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 57ac8aa4a724..0d49922f1127 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -290,6 +290,7 @@ static int tracefs_apply_options(struct super_block =
*sb, bool remount)
 	struct tracefs_fs_info *fsi =3D sb->s_fs_info;
 	struct inode *inode =3D d_inode(sb->s_root);
 	struct tracefs_mount_opts *opts =3D &fsi->mount_opts;
+	umode_t tmp_mode;
=20
 	/*
 	 * On remount, only reset mode/uid/gid if they were provided as =
mount
@@ -297,8 +298,9 @@ static int tracefs_apply_options(struct super_block =
*sb, bool remount)
 	 */
=20
 	if (!remount || opts->opts & BIT(Opt_mode)) {
-		inode->i_mode &=3D ~S_IALLUGO;
-		inode->i_mode |=3D opts->mode;
+		tmp_mode =3D READ_ONCE(inode->i_mode) & ~S_IALLUGO;
+		tmp_mode |=3D opts->mode;
+		WRITE_ONCE(inode->i_mode, tmp_mode);
 	}
=20
 	if (!remount || opts->opts & BIT(Opt_uid))
--=20
2.39.2 (Apple Git-143)

