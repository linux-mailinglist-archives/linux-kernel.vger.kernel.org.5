Return-Path: <linux-kernel+bounces-20966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B68287DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877E51C24317
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C47C39864;
	Tue,  9 Jan 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Vb4lgO2c"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9BE39AD7;
	Tue,  9 Jan 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id E530440737DF;
	Tue,  9 Jan 2024 14:14:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E530440737DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1704809699;
	bh=XMIzVQnRbcJ5ogx4U8zN3UNWCXEPu8snS7SZ8/UXCXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vb4lgO2cPqV1X86JmrbOBvMFfqjl2B4Y0cchENo4XdBEKl2zN5l2PQ3OXcwaZ7M15
	 qhYLbXHfYILKsFYoRd1ZImObiR+/4Z1q4dLfYOYsX+3Tup0/CgV2t+k4z+x9N1ru1q
	 V+WEqHVHqtUhcGNUX04Z5wMUNvXM+pU0Bu/qwQGo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] ksmbd: free ppace array on error in parse_dacl
Date: Tue,  9 Jan 2024 17:14:44 +0300
Message-ID: <20240109141445.6808-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAKYAXd-ULRwKdDLs2XPwf6n9_HTHUJv1+aLmbWN5SqjUxw_xNQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ppace array is not freed if one of the init_acl_state() calls inside
parse_dacl() fails. At the moment the function may fail only due to the
memory allocation errors so it's highly unlikely in this case but
nevertheless a fix is needed.

Move ppace allocation after the init_acl_state() calls with proper error
handling.

Found by Linux Verification Center (linuxtesting.org).

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v2: refine the patch with moving ppace allocation into another place per
    Namjae's suggestion; update the commit description accordingly.

 fs/smb/server/smbacl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 1164365533f0..1c9775f1efa5 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -401,10 +401,6 @@ static void parse_dacl(struct mnt_idmap *idmap,
 	if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
 		return;
 
-	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
-	if (!ppace)
-		return;
-
 	ret = init_acl_state(&acl_state, num_aces);
 	if (ret)
 		return;
@@ -414,6 +410,13 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		return;
 	}
 
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
+	if (!ppace) {
+		free_acl_state(&default_acl_state);
+		free_acl_state(&acl_state);
+		return;
+	}
+
 	/*
 	 * reset rwx permissions for user/group/other.
 	 * Also, if num_aces is 0 i.e. DACL has no ACEs,
-- 
2.43.0


