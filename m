Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF17784B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjHKBAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjHKBAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:00:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50F730CD;
        Thu, 10 Aug 2023 17:59:47 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3491a8e6fd1so5602685ab.3;
        Thu, 10 Aug 2023 17:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691715578; x=1692320378;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8py9CmVJF/PEqBHKH/2zqqHxI76wfEMg3DxuwRshNzk=;
        b=GSoPKrCYy4rTubcQ+2Ud7Fp7gdWy4vMxRY7Tu101hKMNBqZLCV5vN9p6bcJOwsmarT
         onr4Rtzfplcceu2zX/fCxsmXqQNgrKOH9SDUTJ10bc6y54krY6qYZQ3pFepJyd3CRMZV
         tgDOeCUWzp1fY15b8aFuU419fCLp8GA6khkWx4SSoMTIkIRjOvNzShSqRyEc69wQodFZ
         1DBngy6zpLYkEPHtkDPgQkNz4/Km1Z1nrdWXwBQHnKEOv/FOvTyxO3tyCNqF/ExiI2io
         KlILerYX/lixC4xjAxHfeQMcGli2x/nmb+PzpUJk0dbGwTCtLOLF6QpJV5ftSrrZbMeY
         LyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715578; x=1692320378;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8py9CmVJF/PEqBHKH/2zqqHxI76wfEMg3DxuwRshNzk=;
        b=B77lbOpEhzCLqV60E0Egt8ZC8c8sW0BOXaLGDdJ9vyK+EKZYzjqka2OKevjiDdZ3kC
         WJLxcQijd57pPK7tCku8ON6vFVeWKPo9EYSYvbiTkdxwZ5gHClcCD6Bw5Lya8x9oGVmH
         1+JtDh+S8H5BA6FuFb4oLPTN7CFqPwmJgCWc+P2gtmENITajwBE3ZLKqhi4Ao7ggg4ZK
         36zVbOPBgMRwvZPw8S+mWFLNegoJ4A5TFUoaMuC4M93wOd81O+3eSyNXWzKFAkcGYxbf
         Hon48QJMDcPPcbE1Azh+Oz1dmyRXuGx2cm/0eSuByVCgsl67EZbj1eFggdSIT/drOI0R
         l77A==
X-Gm-Message-State: AOJu0YzQabaJR598c74ul6nT9JsXoYjSVV/820Hc68uZ0ureriFcK091
        bFJ8RfQYBZujZY6GxSIf6XyOW9O/HWqKEPLj
X-Google-Smtp-Source: AGHT+IENSWelZ0cph7zWT/ZpnJ+dVKvFoRPIsGorfg4uYI5ozFgA98z9N2RiOiMQwkoW/YJkbJkQjg==
X-Received: by 2002:a05:6e02:1ca1:b0:349:479d:43fb with SMTP id x1-20020a056e021ca100b00349479d43fbmr534144ill.5.1691715577746;
        Thu, 10 Aug 2023 17:59:37 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.43])
        by smtp.gmail.com with ESMTPSA id y14-20020a92d0ce000000b003460b697bc0sm777338ila.59.2023.08.10.17.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2023 17:59:37 -0700 (PDT)
From:   Sishuai Gong <sishuai.system@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: [PATCH] tracefs: avoid setting i_mode to a temp value
Message-Id: <10CFECF7-B9FC-4562-A445-4811F4C27655@gmail.com>
Date:   Thu, 10 Aug 2023 20:59:26 -0400
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
To:     rostedt@goodmis.org, mhiramat@kernel.org
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
 fs/tracefs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 57ac8aa4a724..dca84ebb62fa 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -297,8 +297,7 @@ static int tracefs_apply_options(struct super_block =
*sb, bool remount)
 	 */
=20
 	if (!remount || opts->opts & BIT(Opt_mode)) {
-		inode->i_mode &=3D ~S_IALLUGO;
-		inode->i_mode |=3D opts->mode;
+		inode->i_mode =3D (inode->i_mode & ~S_IALLUGO) | =
opts->mode;
 	}
=20
 	if (!remount || opts->opts & BIT(Opt_uid))
--=20
2.39.2 (Apple Git-143)

