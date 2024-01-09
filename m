Return-Path: <linux-kernel+bounces-20331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB205827D69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD9B1C2321C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521304698;
	Tue,  9 Jan 2024 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="fRksbHJv";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="fRksbHJv"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8A4418
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id AD89FC01C; Tue,  9 Jan 2024 04:39:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704771571; bh=EFsqeQpoVPi+aLXOF4MlH5LIHnl+EleljLHKqEwD79Q=;
	h=From:Date:Subject:To:Cc:From;
	b=fRksbHJvrUIsLT1B1lrcqnKV5j5kDaPZKepCkUWhW0MrY7S0h+AObVryIK5C2UxS+
	 w+IR2MSydMJu+KRGLTq/JBC3NsHBywuTLQHmOMkOkIeRi4aI4Gh/BUwFqfFFZx1QGt
	 u6e88Swvu2vCh6yP5Xifv3OWxUdK5C+Um0VzNJQQiN4ZvSYcksm1BLseUehFHpwO7q
	 v+BjWfqEPV46OloDm27nynlL47r67jS+BS/X9BfAzEUhwI7OO+OqAv2/GXYL20iBi2
	 Ye0zANyZaNFvTUjf/HUZrwlmdKKfXZrUHHtRFE8p1oSJmFz4ZdQ8/EM1u8/gJkF1oy
	 QmBS2WytYD3aQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id E38EDC009;
	Tue,  9 Jan 2024 04:39:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704771571; bh=EFsqeQpoVPi+aLXOF4MlH5LIHnl+EleljLHKqEwD79Q=;
	h=From:Date:Subject:To:Cc:From;
	b=fRksbHJvrUIsLT1B1lrcqnKV5j5kDaPZKepCkUWhW0MrY7S0h+AObVryIK5C2UxS+
	 w+IR2MSydMJu+KRGLTq/JBC3NsHBywuTLQHmOMkOkIeRi4aI4Gh/BUwFqfFFZx1QGt
	 u6e88Swvu2vCh6yP5Xifv3OWxUdK5C+Um0VzNJQQiN4ZvSYcksm1BLseUehFHpwO7q
	 v+BjWfqEPV46OloDm27nynlL47r67jS+BS/X9BfAzEUhwI7OO+OqAv2/GXYL20iBi2
	 Ye0zANyZaNFvTUjf/HUZrwlmdKKfXZrUHHtRFE8p1oSJmFz4ZdQ8/EM1u8/gJkF1oy
	 QmBS2WytYD3aQ==
Received: from [127.0.0.2] (localhost.lan [::1])
	by gaia (OpenSMTPD) with ESMTP id 444fb58d;
	Tue, 9 Jan 2024 03:39:25 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Tue, 09 Jan 2024 12:39:03 +0900
Subject: [PATCH] 9p: Fix read/write debug statements to report server reply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-9p-rw-trace-v1-1-327178114257@codewreck.org>
X-B4-Tracking: v=1; b=H4sIANe/nGUC/x2NywrCMBAAf6Xs2YUkrY/4K8XDJq52D8ayG6pQ+
 u+mHodhmBWMVdjg2q2gvIjJuzTwhw7yROXJKPfGEFwYnHcR44z6waqUGfPJH2N/ccO599CKRMa
 YlEqe9uZFVll3MSs/5PvfjLdt+wH3x0NkdgAAAA==
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2350;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=KH8+UxTTncKHAbh6u8Ig6CCfYanqBKjiLNUI96FwBaY=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBlnL/tDqMymOF9w2pbjX/AeHsc+Ybi+GBNnx0Av
 lRGjwbiw8yJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZZy/7QAKCRCrTpvsapjm
 cAFvEAC43BlpyofxewTGb+IY8PzerfCuFZNfuYNsYsdWtsyzVaIEM+PuQzaIckYPPCQzh1HdNRn
 PbkfEg0bGVb4A9539pYrHx4vo666UGlQQO1yf/P/Hli2bZxxe7IrwN+N5/k5q6fKBEJ0Vd6W4OK
 rB9eVL5WDe7tSecvbBEqqccwXNWE+P0RziuWLCCmAj5mevbQWFhPA2lZXYCwRYSiDQ3BVXiUOXe
 rOKfw8g9RE8mKkdaiHkSmhoCvkhvqEjniHxK6hYfBnoCPHIUxBku0jvKx+AiK2l+zS3ARb6qpcS
 +/fzUM25Z7XnBgEHREKAs21KmBlIPFJMrajNFxLDFK1ndhjUSRyhU+6XdaLUq6GYoB2jzxwnSbt
 CW5YLgMUco90tsOPsuRhd9ltuF2oLro2RBu77NESnulLKZaoruWEQp/GLWFkilPztJ19cdCcmdK
 wi2Zr5cSn5rTKtf3G+x7B75vksP16PbWC9CRyJgovwcJQXolmmojwDHd5ACMW4WNIPgRnBh+mXf
 FFkMqLyo6H7dxA/JO7QVOoaYofoj7VdgJk8n60ZohpS5MTR69WaoXkwwXYo5XA0QWz0hY1qcwiS
 lLKnyjo6E90RUQ8KTnzhp7LB3JgcZT7rPZbV7DBMQQTxeKmNEffVu8FNwNcPdi2OCe/QbMIjWsd
 Iamx1EMp5mwY02Q==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

Previous conversion to iov missed these debug statements which would now
always print the requested size instead of the actual server reply.

Write also added a loop in a much older commit but we didn't report
these, while reads do report each iteration -- it's more coherent to
keep reporting all requests to server so move that at the same time.

Fixes: 7f02464739da ("9p: convert to advancing variant of iov_iter_get_pages_alloc()")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/client.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index e265a0ca6bdd..f7e90b4769bb 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1583,7 +1583,7 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		received = rsize;
 	}
 
-	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", count);
+	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", received);
 
 	if (non_zc) {
 		int n = copy_to_iter(dataptr, received, to);
@@ -1609,9 +1609,6 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 	int total = 0;
 	*err = 0;
 
-	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %zd\n",
-		 fid->fid, offset, iov_iter_count(from));
-
 	while (iov_iter_count(from)) {
 		int count = iov_iter_count(from);
 		int rsize = fid->iounit;
@@ -1623,6 +1620,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 		if (count < rsize)
 			rsize = count;
 
+		p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu count %d (/%d)\n",
+			 fid->fid, offset, rsize, count);
+
 		/* Don't bother zerocopy for small IO (< 1024) */
 		if (clnt->trans_mod->zc_request && rsize > 1024) {
 			req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, from, 0,
@@ -1650,7 +1650,7 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 			written = rsize;
 		}
 
-		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", count);
+		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", written);
 
 		p9_req_put(clnt, req);
 		iov_iter_revert(from, count - written - iov_iter_count(from));

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240109-9p-rw-trace-c61593804731

Best regards,
-- 
Dominique Martinet | Asmadeus


