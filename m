Return-Path: <linux-kernel+bounces-5274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6FC8188D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465C21F254E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8027F19BCA;
	Tue, 19 Dec 2023 13:44:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093CB19BCB;
	Tue, 19 Dec 2023 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4SvdF828JHz1Q6Rk;
	Tue, 19 Dec 2023 21:43:24 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 74FAE140415;
	Tue, 19 Dec 2023 21:44:37 +0800 (CST)
Received: from dggpeml500007.china.huawei.com (7.185.36.75) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 21:44:37 +0800
Received: from dggpeml500007.china.huawei.com ([7.185.36.75]) by
 dggpeml500007.china.huawei.com ([7.185.36.75]) with mapi id 15.01.2507.035;
 Tue, 19 Dec 2023 21:44:36 +0800
From: mengkanglai <mengkanglai2@huawei.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>, "Yanan (Euler)"
	<yanan@huawei.com>
Subject: [Consult]kernel tcp socket lack of refcnt for net may cause uaf
 problem?
Thread-Topic: [Consult]kernel tcp socket lack of refcnt for net may cause uaf
 problem?
Thread-Index: AdoygXTr5FKzOdnSR4i43aSi6m/SRw==
Date: Tue, 19 Dec 2023 13:44:36 +0000
Message-ID: <26f7811f5ee247c389ddd38034d8747d@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello, Eric:

I found upstream have fixed a UAF issue (smc: Fix use-after-free in tcp_wri=
te_timer_handler()):=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D9744d2bf19762703704ecba885b7ac282c02eacf

When create a kernel socket use sock_create_kern , it won't call get_net() =
to increase refcnt for net where the socket is located.
I found some other subsystem(like rds and sunrpc) also use sock_create_kern=
 to create kernel tcp socket, I want to know if they have same UAF problem?

Best wishes!


