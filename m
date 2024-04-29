Return-Path: <linux-kernel+bounces-162811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21A98B60D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215301C21324
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D762F12839E;
	Mon, 29 Apr 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4r0V0Cj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855883CBA;
	Mon, 29 Apr 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413693; cv=none; b=IPKxnvrKSmfUUydyeuvv+3gHk+mEEkaMKfjukZkWp92dSM7aKXKWxsU9A78biZAbQ0vZWtHEB8LzzwGNyUmIWf28IxJy9XmTSqWRTXmyWS4uK6sI8KL5kHnJyFq+YUJ8XcBVcvkqVi6Sc7n1BYTE0TRqIpOfQF+PQSft4Sut2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413693; c=relaxed/simple;
	bh=HnQX04g3H4aGl0kOgsahnA7O/urfcjX5rQYi9xXRvfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S9cmJV5kgG6H3ZebeA1uk4NxMll5VD4InFNDjnr2djfbLOFZQm+4banu/B+ftsRhmrZmCDbRA1kVF80DyiJg80uLhX3Vgb2RO7AarE5vzg2MZnS9Tm9Dw8am+B9EeNL68SD/x/sQo1/Ls8+tG/UNcyQ9oPpg3CY1F7jZwLajlnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4r0V0Cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD37C113CD;
	Mon, 29 Apr 2024 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714413692;
	bh=HnQX04g3H4aGl0kOgsahnA7O/urfcjX5rQYi9xXRvfA=;
	h=From:Date:Subject:To:Cc:From;
	b=l4r0V0Cj/ClfZtI2+M6SVJ009QE5l00rm0yGksF08mH8aqqq5eVFdU8auSlCHli5s
	 KMaUrrs+eeXS+4DoYLqQuLDfQpSNcCQS7IrVlZvvwfj9w06E6REFcrHGWXFhu6TKW/
	 54uecAJnjZYEJgDWhgYOHujTre977PDeYGFfTcqFtWVGZ6OPX4BS3GPygxr5Lol5SK
	 cSAVULvtwjhttNae5v5OSkwJ8jJ1yJAOn/QFOgu2Gu6GualOlTzvTFhOXie83EGx38
	 4h9zIu5z+qFIs98WyeJjh2iqUpDWV2ZXACVsn7kxXpknVAqGudVdo0P/c8RmH4a5fc
	 gRYJr1vvSYaWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 29 Apr 2024 20:00:31 +0200
Subject: [PATCH net] mptcp: ensure snd_nxt is properly initialized on
 connect
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-upstream-net-20240429-mptcp-snd_nxt-init-connect-v1-1-59ceac0a7dcb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAD7gL2YC/z2NMQrDMAwAvxI0V+AaDU6/UkoJttJqiGIstQRC/
 h7ToePdcLeDcRM2uA07NP6KyaodrpcB8nvSF6OUzhBDpEBxxE81bzwtqOz4t0v1XNG0PHVzFBX
 HvKpydixjIiophZkS9GxtPMv2W96hR+BxHCe/WyL+hwAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Christoph Paasch <cpaasch@apple.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3765; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4DC3uSMFTJhiH+tjuyCzuGWfOrPmEvBhyUaXOn+ngXI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmL+B4xsRUyWBPNFj4ImKhOSMfiA0bEkPlKfCuo
 gS2+pFda4uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZi/geAAKCRD2t4JPQmmg
 cw6ZEACKIZuD6B9nxlXS0mrv/rrVLtxTD70oRzZUAEY5D5RIIwQLC+cely9HUTKBrg/+OW1Uul/
 hCidmg+XZGD0gghxawOeOhbLUo+n/xzrHtgU+AgYsS1+jHUG5zHaj9T2NhBpGWQLEPxYzB3LbIF
 iDDDkqwPB8CfD/Va08UQsu13wsGxCepM7Rc2devVjvCIBpKvUqlwKNXNa5nAmMGl2jk0d4mP7S9
 h+7RrYVDRZd65Dh3eAKsyR/fwS7DTsiaZRu8yJ6hsFlMk3xTpxLqjHvvT7ptfCuLVaJllxNHlhZ
 WxxUF21HPSKrp3y5tEoUNIEswwsTyi76rwqk6HKBs96W1JVN1AtRg4Sk9NJgxa3eQ0DqU6TTvax
 ipbKBD4dGlccDNMlIAhotDmsnLT1tcijoSLZbP8uuQgUq1FwOK73uowh7oHo9foajmHfqSsCURr
 xaX2FSfdPcZ6SBRsyfkOracvUjTDAak+VwYEikjcy96KCEMhE/ry+r5oHzI48XjJSc0G1mRIQEI
 obG6HxfFElc7PIvHVkCzJ529aGzfkwrBzDTBRa4CWxKa32vhlBGGT2LqVwYkZDpDpxuP+5+qI1h
 l9DycXQaw2mgul0KadqjUw/xZa/3NGQecIWZkl5P7jn2ncyhtkx9zmsTsmjMj1ECxGbVj8KIEvc
 tSHTWSH50i7S89w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Christoph reported a splat hinting at a corrupted snd_una:

  WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 __mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
  Modules linked in:
  CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 #59
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
  Workqueue: events mptcp_worker
  RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
  Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
  	8e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
  	<0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
  RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
  RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
  RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
  RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
  R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
  R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
  FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
  Call Trace:
   <TASK>
   __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
   mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
   __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
   mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
   process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
   process_scheduled_works kernel/workqueue.c:3335 [inline]
   worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
   kthread+0x121/0x170 kernel/kthread.c:388
   ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   </TASK>

When fallback to TCP happens early on a client socket, snd_nxt
is not yet initialized and any incoming ack will copy such value
into snd_una. If the mptcp worker (dumbly) tries mptcp-level
re-injection after such ack, that would unconditionally trigger a send
buffer cleanup using 'bad' snd_una values.

We could easily disable re-injection for fallback sockets, but such
dumb behavior already helped catching a few subtle issues and a very
low to zero impact in practice.

Instead address the issue always initializing snd_nxt (and write_seq,
for consistency) at connect time.

Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Tested-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7e74b812e366..965eb69dc5de 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3723,6 +3723,9 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
+
+	WRITE_ONCE(msk->write_seq, subflow->idsn);
+	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 

---
base-commit: ba1cb99b559e3b12db8b65ca9ff03358ea318064
change-id: 20240429-upstream-net-20240429-mptcp-snd_nxt-init-connect-d9844d880f48

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


