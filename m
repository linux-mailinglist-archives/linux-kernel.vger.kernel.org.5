Return-Path: <linux-kernel+bounces-5455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D4818ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E18F281CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A61C68E;
	Tue, 19 Dec 2023 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VrOFsnWz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AA1C697;
	Tue, 19 Dec 2023 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702998566; x=1734534566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gqCZICqTsn1ZAWtUxDZg9+U6l8m0uHS+deZJRdybB1c=;
  b=VrOFsnWzzd2qIQDqo+bjVTp38kVXrVFsChV/WwykHK+s5g9Z138wM3H3
   mAIGFne+vX5LYvHaTM2eFekbLia6a1WdhFRxrOBKbvIRrReQ5hnBrl94D
   28meiocyDvUoCBv3VO7ssJc8B50uFdZIWoVMO7Q9m4HrVvxa5XXfS5n9Z
   k=;
X-IronPort-AV: E=Sophos;i="6.04,288,1695686400"; 
   d="scan'208";a="260445655"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:09:23 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id F327882E2E;
	Tue, 19 Dec 2023 15:09:22 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:38779]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.164:2525] with esmtp (Farcaster)
 id a73f32d0-54d2-499f-b599-5a7df5d71c0c; Tue, 19 Dec 2023 15:09:22 +0000 (UTC)
X-Farcaster-Flow-ID: a73f32d0-54d2-499f-b599-5a7df5d71c0c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 15:09:21 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 15:09:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mengkanglai2@huawei.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<fengtao40@huawei.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <yanan@huawei.com>,
	<kuniyu@amazon.com>
Subject: Re: [Consult]kernel tcp socket lack of refcnt for net may cause uaf problem?
Date: Wed, 20 Dec 2023 00:09:07 +0900
Message-ID: <20231219150907.9338-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <26f7811f5ee247c389ddd38034d8747d@huawei.com>
References: <26f7811f5ee247c389ddd38034d8747d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: mengkanglai <mengkanglai2@huawei.com>
Date: Tue, 19 Dec 2023 13:44:36 +0000
> Hello, Eric:
> 
> I found upstream have fixed a UAF issue (smc: Fix use-after-free in
> tcp_write_timer_handler()):
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9744d2bf19762703704ecba885b7ac282c02eacf
> 
> When create a kernel socket use sock_create_kern , it won't call get_net()
> to increase refcnt for net where the socket is located.
> I found some other subsystem(like rds and sunrpc) also use sock_create_kern
> to create kernel tcp socket, I want to know if they have same UAF problem?

You need to check if the subsystem itself holds net refcnt (not per socket)
and if it waits for TCP timer to be fired before destroying a socket.

It seems that runrpc holds net refcnt (xprt_net) and rds holds per-socket
net refcnt.

