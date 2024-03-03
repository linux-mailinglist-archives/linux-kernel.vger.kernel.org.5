Return-Path: <linux-kernel+bounces-89762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92B86F532
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A3AB21034
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4459B5C;
	Sun,  3 Mar 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D9LfZCp9"
Received: from xmbg9.mail.qq.com (xmbg9.mail.qq.com [81.69.217.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CBDDBD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.69.217.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709473812; cv=none; b=S/XgSTB3bf1vnxql6z4udBOlr3dqtUDsxESa0g+hHQg0vulXXWEJVqzKJukC3MhhWD2sV8gla2qh+2lwydhhMJYIFDyl48OR90N83vJIwkfwMl5NX5ScH0seMuYb0e+38Llbs+zzrV+4KdkbA81alNvu/PuPkX15G9He6GtCV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709473812; c=relaxed/simple;
	bh=q7aVnpQfojbNvVjLMpOGPbY3ZgvtHFpeN7zbX1Nsa3M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CD0aAG0po3J7Artzk52LhANcYLG8Kpkby24ey8drctzvcJWExujO5hrix0S8qkXpiLZ1sLDTlmotLQPJ/Idd6Hud1gAOS2+uqFkWnpmFypwX6iu5qvmyvYcnqXZgun46ikZeVQuHgTBja96OLf79+qTr1pa9pOEKo5frO9eDORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D9LfZCp9; arc=none smtp.client-ip=81.69.217.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709473804; bh=sBqmRt7qqG9ivI2p3xgtXTCdIlBqGzWhtXzBZBhAO0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9LfZCp9LNSJPNLDcF6jdBryN03Ic3FEj3WhR/3u7Ra3TCt8ag3kiMnjJnz9IyF9t
	 vjuzdTI6byd7eQUFC5LiLChpvjGdl000psqg2PHep9rwRmoVPLTnO+8nYy9a9aQ0oi
	 48un2rvj3sezw0F/OJh+ZV4J2841NaGT46ybvec4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id A4C07C52; Sun, 03 Mar 2024 20:41:12 +0800
X-QQ-mid: xmsmtpt1709469672to7x0bnhv
Message-ID: <tencent_146CC89774EBA6EC92CFA4783E6CA42D850A@qq.com>
X-QQ-XMAILINFO: MbOQvCiz/DlEBSLO3bCgeAInCPH/hw+KFIIHVly85jF/Nqup/gpW5WJBrHrIw1
	 jBh09JNzyD+1Z2c1ZI6CS6+R56QFF9/lJOBxe43hX+Bv2VH5qSAAz+g1OxwVwJvrtYeitdAfwqH7
	 2SrtVVY23J8DbpBKr1sWD1oHRsmG2MjjFbOIc00ZNjV5pIZsLDRd6f2vlpw8Ja+ol2Vc9vOogKZV
	 lOlAnZVHHuA9xcWVej27OqKuQQmvNOhfVH/oao3SC6jbj+5iObxp/FFTWHi7twN3vvoKf56fVbwj
	 ke2TTPJ9n0ISwR39LhqNWo4u6I9g8uC+U8aV/hyiDlvfjUC8LXyZfAqhgEddngrEPcwTk3uqkVCG
	 eytPTUjtYLOLxRAmegyVTrQKUxiJL8Za8yqGAfCjAQealbpDjyMzBlyjzF02R0NpNm0v5kONON7c
	 gEropmuMgVSoJQ/NBXyOGn9+xIkhv3KqsfVTwBqj81/QYYc0cdTUOeVOTk4TksAdYUgrcxYRZKzY
	 P3SXIzkla76juuL52RrFVJmcb3Zlaxoz1EuBblxNVgU2koIz5EtzrJA20QSj5hL6B70pqZlCUrQI
	 rXE93K5BunnF9cXywXW/zBbOYFk0y9yO38x76H+1L7sAB3KlrM+Nro7IV5tOCGSDV0o51izIqBPW
	 JRUYhmj8wZLXB3qgvxmm8Bp5ixlkM9J++bTc5Budxm1vlL+dQQixLiHvOGo7QZAfXvpmuYGS2L2v
	 SZKSDCuV3ijSwbjAjj+H+86e+1acL3fslneaIHF1RAAZiYtE29FB6oILWC1QiM/4iFLBnXWU1JP3
	 NtkJKyb3SaKJoeH7D5O55jblKZNZVKj4kIHu0WQ+A+feIV+OW4fwh+pZSEcb44Nh/Qlwvi/iPAcp
	 1JfX+x5Fl556rEDs0fhujdNU+Mu1Lrbe6s6a81s5siE7ui+3q/xdSAH6R+laPs0jTKgoWoBxGvae
	 Hci4PaMoWVKJgI4St6yF/oOX3nd2BxxKqzeK/m95SUUQxubaE3n5UZdxdG86CE5WMLpOSWstE7Ox
	 vfSepxpFd7Pt1R288RTJyQFlgQg/s=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hams?] KMSAN: uninit-value in nr_route_frame
Date: Sun,  3 Mar 2024 20:41:12 +0800
X-OQ-MSGID: <20240303124111.596358-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b69bf20612bf586e@google.com>
References: <000000000000b69bf20612bf586e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in nr_route_frame

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index edbbef563d4d..5ca5a608daec 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -656,6 +656,7 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
 	 * to allow max possible filling before reallocation.
 	 */
 	prefetchw(data + SKB_WITH_OVERHEAD(size));
+	memset(data, 0, size);
 
 	/*
 	 * Only clear those fields we need to clear, not those that we will


