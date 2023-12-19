Return-Path: <linux-kernel+bounces-5733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F116A818ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C7B23BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3A39AFE;
	Tue, 19 Dec 2023 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="itoo7OK8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C0374FB;
	Tue, 19 Dec 2023 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siddh.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siddh.me
ARC-Seal: i=1; a=rsa-sha256; t=1703008191; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=QOyVkYFTtehlwMgXA2ZYoTfaWgXSd7e0EpVAQQhTPu2E2XzKSFhFpo2B8n1L2SYtz8DpDRUOM6mziNNXuD1Zd9rcUcZpHJDu7OQJr8KmCLaBVsA6ujPxwMPW/Ybp2Y2dO4ZGx2ftS0UrtNE2AXh7NvO93tWZt1VtKjLgIWGS9W8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1703008191; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AF+NCNsa1eutOHcZrZ045IS0+FsNjuyaPy8+4b1PvQU=; 
	b=QhBkOfPbqj542fHj0H2AINnX85mdPtraoEot6EalN/QvrFVuwbXR0pMyRaknCycWWhGSPxEew8wUSuEtkEnyu/2gGni6+R1MdAdiAxHb7COWxySp0NMKoTOs4/z5zte2Dox87C+0hluq6WtwUKn68O/n6EZH5GNmt811bkP4GEU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1703008191;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AF+NCNsa1eutOHcZrZ045IS0+FsNjuyaPy8+4b1PvQU=;
	b=itoo7OK8xmy9lIdJMp9qpWvoSb/J3qowZhsccfulphFDGZG9QM/sBNBSCUsozWjz
	XSquQRvK9wKTCVq4gkndIEJ4z05OO4phxoxBeLOmyrWcyc+ISlO5fB2fAfCsGfVTPWb
	NekMrLpM1GeclQKgKGXkcAVOOWzd/CbEiwpADgtI=
Received: from kampyooter.. (122.170.167.40 [122.170.167.40]) by mx.zoho.in
	with SMTPS id 1703008190516661.7229040711136; Tue, 19 Dec 2023 23:19:50 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 0/2] nfc: Fix UAF during datagram sending caused by missing refcounting
Date: Tue, 19 Dec 2023 23:19:42 +0530
Message-ID: <cover.1702925869.git.code@siddh.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Changes in v7:
- Stupidly reverted ordering in recv() too, fix that.
- Remove redundant call to nfc_llcp_sock_free().

Changes in v6:
- Revert label introduction from v4, and thus also v5 entirely.

Changes in v5:
- Move reason = LLCP_DM_REJ under the fail_put_sock label.
- Checkpatch now warns about == NULL check for new_sk, so fix that,
  and also at other similar places in the same function.

Changes in v4:
- Fix put ordering and comments.
- Separate freeing in recv() into end labels.
- Remove obvious comment and add reasoning.
- Picked up r-bs by Suman.

Changes in v3:
- Fix missing freeing statements.

Changes in v2:
- Add net-next in patch subject.
- Removed unnecessary extra lock and hold nfc_dev ref when holding llcp_sock.
- Remove last formatting patch.
- Picked up r-b from Krzysztof for LLCP_BOUND patch.

---

For connectionless transmission, llcp_sock_sendmsg() codepath will
eventually call nfc_alloc_send_skb() which takes in an nfc_dev as
an argument for calculating the total size for skb allocation.

virtual_ncidev_close() codepath eventually releases socket by calling
nfc_llcp_socket_release() (which sets the sk->sk_state to LLCP_CLOSED)
and afterwards the nfc_dev will be eventually freed.

When an ndev gets freed, llcp_sock_sendmsg() will result in an
use-after-free as it

(1) doesn't have any checks in place for avoiding the datagram sending.

(2) calls nfc_llcp_send_ui_frame(), which also has a do-while loop
    which can race with freeing. This loop contains the call to
    nfc_alloc_send_skb() where we dereference the nfc_dev pointer.

nfc_dev is being freed because we do not hold a reference to it when
we hold a reference to llcp_local. Thus, virtual_ncidev_close()
eventually calls nfc_release() due to refcount going to 0.

Since state has to be LLCP_BOUND for datagram sending, we can bail out
early in llcp_sock_sendmsg().

Please review and let me know if any errors are there, and hopefully
this gets accepted.

Thanks,
Siddh

Siddh Raman Pant (2):
  nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to
    llcp_local
  nfc: Do not send datagram if socket state isn't LLCP_BOUND

 net/nfc/llcp_core.c | 39 ++++++++++++++++++++++++++++++++++++---
 net/nfc/llcp_sock.c |  5 +++++
 2 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.43.0


