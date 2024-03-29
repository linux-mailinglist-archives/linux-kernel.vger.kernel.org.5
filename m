Return-Path: <linux-kernel+bounces-124423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3543589175A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95AA1F24113
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64D66A34F;
	Fri, 29 Mar 2024 10:59:38 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A9E6A013;
	Fri, 29 Mar 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709978; cv=none; b=eT7k3WtkxwOHXy5LL2zd5od1U9Jq+h6EMsfy6LgJrhB7pC4AaqcU5kBm+ByixiGTcYMrcpJwMBwGsgZ4TjiYvhs8T4XRWHWqs2uZnh81nW2x+6lYDioNSVpXhQmP59PfKjHkXnX4QlKL+9E6ko8vmS5zFtZhxxn1DblVgKqiRzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709978; c=relaxed/simple;
	bh=k+v0qzwa/G31seXck9YqysYUEETaqx3WTiw/bXysXXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrgMwWQKVfAPgUGfXuEmVvmgFRw7RTgs63GohRIvCF7fkT9kNFgg3TRHbjSZoznl9V1EC5qUOnErbT/r4izY3ulg3jilSiZxP1/mQDKQLohY2Bm5jyU9y57/uVUTG+Ck2koz7BV8tK5q975WIQTQ5A0euN/Q6ZB++BOYIwTlvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp90t1711709833trhodnwy
X-QQ-Originating-IP: ip4zIv0IgokV1PIQx8JCNN0m4s34KKdMABqAoCfUXCE=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Mar 2024 18:57:12 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3iFSdA6FuP1qfcOUFMFiuSHQF3s31WACj0xlrvJ1/LDtxfHmhYkH
	RU8ot5MGMvKKsDxe4nphnUcPBEbBybaeU9+BT4+n1TOk6Wy9wI83oh+cATtEaNUMIMh/D0p
	47m8l1f8URDsOjl4dwtkM3iBOjwZgvZbp3dEIRNGtESCkkDK85s+OBzodj4Y99avaGtokn2
	11TLQWPvgRzTVgWByAGuAvzEz2G1LwehWJf7f3uVrSSe+ki00Bj6KEVdrgXUaRj3AylLdIP
	wqJmfDq2518PcBgkEcO86oWen8Uk/asmx38QIlTvNyxc5Qe0N96/aRePTEXMtfolAoDa3Ye
	sD7YrCN7sHLHF3lJFXEfhVvlFV5ZQb02dO05nMdb0YVahYorDUM3RXX7cuKcA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1969986897555587113
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ioana.ciornei@nxp.com,
	wintera@linux.ibm.com,
	twinkler@linux.ibm.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next 0/2] Avoid explicit cpumask var allocation on stack
Date: Fri, 29 Mar 2024 18:56:08 +0800
Message-Id: <20240329105610.922675-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,

This's a tiny series which replace explicit cpumask var allocation on
stack with *cpumask_var API to achieve neutrality on config and avoid
possible stack overfow. 

Dawei Li (2):
  net/iucv: Avoid explicit cpumask var allocation on stack
  net/dpaa2: Avoid explicit cpumask var allocation on stack

 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 14 ++++---
 net/iucv/iucv.c                               | 37 +++++++++++++------
 2 files changed, 35 insertions(+), 16 deletions(-)

Thanks,

    Dawei

-- 
2.27.0


