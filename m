Return-Path: <linux-kernel+bounces-121425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95E088E7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7C5B26EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3F146D46;
	Wed, 27 Mar 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Qj/uUrN0"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEEA146A8F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549423; cv=none; b=KsPxsCPZapM9x1P6m30r6g+qQufywvEBeGvySxmLyGLPO4WWaDU0fK4OQdat/mOCgav6tN3MhVQuG37DvUy49W+E46X2o5nk4qzEy/zJC+TsHC5B89yvotgdoe/bPVjTdAx3kplkJOJbGOhKIY9Rz/97FzgW+MoSNBaR1jTT4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549423; c=relaxed/simple;
	bh=J7UhRdgWg8g0gvaZs0hX56TeUc4gLGidHY4DvHhM/W8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=n2HNmgdIuWm80pTeYCuBH949+dy6arYaUXj41YH64OJJZBbdjfiIprqy39f+nb7dKWWeacAPUAWpqKyuNMOuuQ9Vlqn5Hdw3l3HaSy+7dXgJsnLKg4bI5AvOxIRY9llzsclG6ma+RpglocvRFR8q1+t2VpM589gPBEE0e3lavY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Qj/uUrN0; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711549111; bh=l1g3KVEUbPfrnpMbSqUvtMmtEzMFFaEtMNlAt4sADcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qj/uUrN0gwAnlLYXJhtVshFGNk3wXZ0p7jKn8hmRcoWga419uXk8ELJHu5CosTAUx
	 nbKa4qZSOW7ux6WCcKY9aumvMfEU9gvyAzUvmecijmfnRaLSA96ENeMrSWKhyBCyFE
	 romae2OwWTj1AHs3MnTy0uGE0VzgJVrvcMdcASvE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 49DBEC1D; Wed, 27 Mar 2024 22:18:29 +0800
X-QQ-mid: xmsmtpt1711549109teqxmcxs0
Message-ID: <tencent_87499A2ED6AEFA4CB927C7C6F992F5067F06@qq.com>
X-QQ-XMAILINFO: OCYbvBDBNb9rZde+3q3Z/T+3QxFn6xkpS8ZSBpzfFLhHrXpKmxsWaYXdGCG+RE
	 +sPbI2+bJIsRY80jNApE+RUJA9mv8yrcvidYcBQcorXQqvE5om2xpUpjQctk/Tdmm+zhhKMK0KiK
	 DTjIb+38YsafmFdlbe06/U7gfS2p2IvZLVfCw4D7DmlG5poNekOorsJbYLZVbQ9x5HZB7UZ+PUeS
	 /ipxKDc2tvjukq0aXgNpxnaVSno+VaLOUvvjSpTsFAdtEt0NMoB7ILBFAzg7tK9ENPA3H2y7Yqg5
	 hMzIVKsb7Hm9kl+gFCA5m0UX/J9/W17yDaMQBvCO4rdtCHhgPdh3i6mfgYpFVA6xoVwvLusbNFvV
	 zBsxpAIJS9SlziIJAapysFA8w8/xcIX2gITVTE2Izz25kj70CM1KddWoV+zvei0dgKzpxKsNrVqM
	 yy9Yuoj3cZyOXTZNDqSVN3JNRvzrtjncTINgX113m1OWtfm8FlHPZ9ocMx1nFILVnxrXVjAOTCjk
	 7ZoBEkFo8AlTOvh6hQJ22nawG9McV9uYGaZ6YIqO8ctNUmdvqjaOF9YNjXTieOQctMPF9Mv83pW+
	 ui5CKpkT2Go0ayJUDwgbvRCkzH5xCZzi7Akaycl3zS8eGuVUznUoCjT6BFtUNvTG4YsEvgH6WsEv
	 o4mzlz3kVAvs9OF5dJb8JUIOnQ2Uifb4H29QgBd0jio0BVPg/iLAOjqQGyxXju88EMsv3/7ydkCl
	 maGbyrbY4xTdN3nTuSSMXaNoihlC/Sf3PXQ5B5ERNPbdXaISZNGQlBATUWcpzKuhipZfhr7a9adW
	 SCrf6MOZbH4stoCQYv2dVpgwxs/S4d98OcLt2KsPFIh1cJ9pfSvBme1fqMQ8sOIf0hIGvN68qiZo
	 g3ChNOvB2BJPWwGYKunxFZlYwcn1IhKWIlPNVILP3QMzZLa/fpXD4=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
Date: Wed, 27 Mar 2024 22:18:30 +0800
X-OQ-MSGID: <20240327141829.3279427-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000069ee1a06149ff00c@google.com>
References: <00000000000069ee1a06149ff00c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr deref in dev_map_enqueue

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/core/filter.c b/net/core/filter.c
index 8adf95765cdd..721b85aebf58 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4381,6 +4381,11 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
 			err = dev_map_enqueue_multi(xdpf, dev, map,
 						    ri->flags & BPF_F_EXCLUDE_INGRESS);
 		} else {
+			fwd = dev_get_by_index_rcu(dev_net(dev), ri->tgt_index);
+			if (unlikely(!fwd)) {
+				err = -EINVAL;
+				break;
+			}
 			err = dev_map_enqueue(fwd, xdpf, dev);
 		}
 		break;


