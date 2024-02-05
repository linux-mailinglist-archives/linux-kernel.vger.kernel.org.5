Return-Path: <linux-kernel+bounces-52476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB918498B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0FF1C2248A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DC18B04;
	Mon,  5 Feb 2024 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="oOH5Lrlj"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174118638;
	Mon,  5 Feb 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132077; cv=none; b=smID9IFiEHRIvgKFhE60QCYgs2KuSr2I21FZytULPs0ALaz6nbJK4C2Hordeidfaly30Y6lA4iEg728iGfr2vQeXQ4BgGwaYzcBDl0owXxvpbyw7jVr1gdF/yHBWoJ4V+c9OZuy4L/8pshncQ3okCYVsgJc94Q0DgOzDY6HmQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132077; c=relaxed/simple;
	bh=Rz2/NQDtnx9QX45qClLg84vegkmZf2yJfQ2ueKkFnJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H6A76IeshiBHBBnmFYls1TQeY+2SU9R5iPPTh4Bd0l1E832nbd56vqcTSNWJVhYwdsWnEDqg0q2g74fh7i831BMRZb1qz4M0SqyVIREo263iTzyLe9JWambzETj1s0VA681Xdp/SO5DWuBzMjN1fUmdGrduAjPR4i7bQZKZYS74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=oOH5Lrlj; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id A8EE940F1DFE;
	Mon,  5 Feb 2024 11:21:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A8EE940F1DFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707132064;
	bh=8eo/Q0edrb5NcHDsJfOyyWcOMOAMiCdqztmPDVSV+jk=;
	h=From:To:Cc:Subject:Date:From;
	b=oOH5LrljU5KLyfEHokjGu71VmrskUfa4W4Mo8kK4PDSfP0DkgmVDEHSdksDwKTSOE
	 b/wC9ajaHAoHZ0eCGdZgr759DnPsk6koUDbtK/KcQK7zKWchnlg6visFjuz+hHCKeq
	 jjo1LnLOufWl+K5e0WVh/YgZ2Rub8LwDq2NVVYdo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails
Date: Mon,  5 Feb 2024 14:19:16 +0300
Message-Id: <20240205111917.181490-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksmbd_iov_pin_rsp_read() doesn't free the provided aux buffer if it
fails. Seems to be the caller's responsibility to clear the buffer in
error case.

Found by Linux Verification Center (linuxtesting.org).

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/smb/server/smb2pdu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ba7a72a6a4f4..0c97d3c86072 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6173,8 +6173,10 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
 					     offsetof(struct smb2_read_rsp, Buffer),
 					     aux_payload_buf, nbytes);
-		if (err)
+		if (err) {
+			kvfree(aux_payload_buf);
 			goto out;
+		}
 		kvfree(rpc_resp);
 	} else {
 		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
@@ -6384,8 +6386,10 @@ int smb2_read(struct ksmbd_work *work)
 	err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
 				     offsetof(struct smb2_read_rsp, Buffer),
 				     aux_payload_buf, nbytes);
-	if (err)
+	if (err) {
+		kvfree(aux_payload_buf);
 		goto out;
+	}
 	ksmbd_fd_put(work, fp);
 	return 0;
 
-- 
2.39.2


