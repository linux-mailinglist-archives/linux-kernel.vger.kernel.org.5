Return-Path: <linux-kernel+bounces-11495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF581E73F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D061F22866
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448E64E61C;
	Tue, 26 Dec 2023 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjknHMxm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB624E1C7;
	Tue, 26 Dec 2023 12:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B44C433C8;
	Tue, 26 Dec 2023 12:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703592651;
	bh=4rZCbmJDnadJWKBeFv3M2opTN6rbniARuPF/dzEQZb8=;
	h=From:Subject:Date:To:Cc:From;
	b=qjknHMxm+y4wPlw4YC3tV4AZJ2tY1jSKCr3KvuZde6AlF45AR1dKJoq0XfMPIz/U2
	 zkBncPWleqGTKB8/OqAYL01883CeBUcIJsPr1G7mGlxaTGhNZYtSSWMSMZ445Qx1tU
	 kHsYO1QJVq7Z6bkFzgrJFWE6XCXkWP609v4egOBIAId95+rf4ckRN1Yx0mFvAJMTqP
	 3izshPJldhvdiFdc97ybQkW0z9Qz84DkEqMQucycSsEV15F3BLYN/0NfTuBc2fXk8r
	 BB12zNzmDINkA4krCXtyIBBxTHHm1KGHXpgqATlrmQ/Kb/8TyiyHr8o8jbxTV3AXrR
	 5az9VzYZ8q2Iw==
From: Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: new reviewer and prevent a warning
Date: Tue, 26 Dec 2023 13:10:16 +0100
Message-Id: <20231226-upstream-net-20231226-mptcp-prevent-warn-v1-0-1404dcc431ea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKjCimUC/z2NwQqDQAxEf0VyNqBxKdhfEQ/rGtscTJfd1RbEf
 zd46PHNMG8OyJyEMzyrAxLvkuWjBm1dQXh7fTHKbAzUUNcSPXCLuST2KyoX/KdrLCFiNANrwa9
 PiuSW3vVumsg3YDorF/ndVwPYGMbzvADVLjfyfwAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Matthieu Baerts <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4rZCbmJDnadJWKBeFv3M2opTN6rbniARuPF/dzEQZb8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlisLJVoG4MVl6gB+v1+z38DaP3EoDtY/6dhmKI
 vWxmU0+QKCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYrCyQAKCRD2t4JPQmmg
 cxo3EACVqPTV1aW/iMx3wqNdMA0ZNOsd6fELIihvMGMFv+XjjwGpYzBGtWbGDj9MPjlUgihdzCM
 72Z8rYKZwA6lQYOaSikyqyXMfRb5Iz8MCFPFNUoCNzIWbrTvVFzr94k8vfds0p3AZ1yrmhrXfsc
 SX3e3jvJjPN59qqZwSx2SGXb7V8IxnoLtJUzjLyok1Xz/TgiizNm8vLOe9jK/i7DieEaeT1ewfR
 MRv3VYaBzpR35HT4DPgFzbh+v9Y9BUfaLsYIWhSNhBDQCjdnsWhQeJjLZk+2dDX542IxDG5CO2R
 ucFGLdmR4hXJE70WfwFsJppTcKzRk0n06IFZ4w9FruOXBiYapVKj2vZKtLOJcCj8oEguXhW0gfO
 hbrFPCSYpuKIfkBMu7lyFFTCJxFn43h65jmqgphlRF7ww3bazpy6WXyXIyKV8BEpOKsVL58gbqd
 sCCkVJ6LST7UzLQph2rpu76Y0uKcCXwnAby1WQwA9vcaUVan64kHLEeWLT4ky32ub0cXU23KVY5
 9aFUKU1L18eZPwkGrmqtGyY2nKQ6XSTrEmSAvVDe1iVr/p5UyoPEn8465zsiTvKfNq6eCDbAuAT
 GGyD9JIbX2kB3nQX1rpvZxw+ubkTgfDV8juEnr2OfqZQDXinGtom+ShcELS2JJl6PxDg2y5lsUn
 twYSgeoZ7FF71ag==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patch 1 adds MPTCP long time contributor -- Geliang Tang -- as a new
reviewer for the project. Thanks!

Patch 2 prevents a warning when TCP Diag is used to close internal MPTCP
listener subflows. This is a correction for a patch introduced in v6.4
which was fixing an issue from v5.17.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Matthieu Baerts (1):
      MAINTAINERS: add Geliang as reviewer for MPTCP

Paolo Abeni (1):
      mptcp: prevent tcp diag from closing listener subflows

 MAINTAINERS         |  1 +
 net/mptcp/subflow.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)
---
base-commit: dff90e4a092b771354287fbe55e557467c9da620
change-id: 20231226-upstream-net-20231226-mptcp-prevent-warn-24f9494bb2a0

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>


