Return-Path: <linux-kernel+bounces-132234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2838991D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6FB1C218DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A297D13C3CA;
	Thu,  4 Apr 2024 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vJic398R"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF11548FE;
	Thu,  4 Apr 2024 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272113; cv=none; b=av3Urg3LHCT2GAkjuT00bg777HK/1ycM7MuoAzBWCuIP313Cv6FIDxevfSfPhgiYaD28dkhrAYqL8HGVDtKfGcwTC5oVFxhYcCrh8OaEHNQnMh08MBYKQi33TeKOJk6mZlln1PtO/lV6jABrfBS6Pdos+eUnZL/um085PcSDYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272113; c=relaxed/simple;
	bh=YB3k73MSlgXhaZgBxLqPQ2GTe+rYPuSn+ymAiJvnNjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSMWYBz9PnME3Y04I32ksfkJk/mPcJEzItMcdUt2mzLOKOD9OkgGPYpakEuhaYLsmJj7XdMrbFX8qqyNH0M2bXjHE1lK4M1Sni1QNkQjNBdWulSL3u55vwLD3a7rmOyzrGIRcioqKtD8LKR8lTtd/C9eP+diWp8SZGc7gt9vNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vJic398R; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712272111; x=1743808111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LYlULA1X6feFv3WTxvLyYvnsT80qwNGSBW46vZBwbD0=;
  b=vJic398RT9sY4NnQUWRqDojpyHHcQyHWAwJ2KxTmc6imEHclmbAvS8lM
   Su4mhcQlbMKKxeHjZXnvLYBBY3hkV+2NuutKQLlWwv8GMLOD/D8MPzCxD
   jTzsDAGMrFYyWyVDKy4Xb7ii03GrhiXbx+nrOFybnZvKUE/HgGtnZmgNu
   E=;
X-IronPort-AV: E=Sophos;i="6.07,180,1708387200"; 
   d="scan'208";a="624551142"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 23:08:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:26930]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.87:2525] with esmtp (Farcaster)
 id 7f2003e6-55ab-4344-b717-c85b3a1bcc78; Thu, 4 Apr 2024 23:08:28 +0000 (UTC)
X-Farcaster-Flow-ID: 7f2003e6-55ab-4344-b717-c85b3a1bcc78
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 23:08:28 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Thu, 4 Apr 2024 23:08:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sfr@canb.auug.org.au>
CC: <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-next@vger.kernel.org>, <trond.myklebust@hammerspace.com>,
	<trondmy@gmail.com>
Subject: Re: linux-next: build failure after merge of the nfs tree
Date: Thu, 4 Apr 2024 16:08:17 -0700
Message-ID: <20240404230817.62526-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240405095341.3a9f0d95@canb.auug.org.au>
References: <20240405095341.3a9f0d95@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 5 Apr 2024 09:53:41 +1100
> Hi all,
> 
> After merging the nfs tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> fs/nfs/inode.c: In function 'nfs_net_init':
> fs/nfs/inode.c:2434:13: error: assignment to 'int' from 'struct proc_dir_entry *' makes integer from pointer without a cast [-Werror=int-conversion]
>  2434 |         err = rpc_proc_register(net, &nn->rpcstats);
>       |             ^
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   f290a586e31f ("nfs: Handle error of rpc_proc_register() in nfs_net_init().")
> 
> I have used the nfs tree from next-20240404 for today.

Sorry, I posted v2 of the patch.
https://lore.kernel.org/linux-nfs/20240404221200.52876-1-kuniyu@amazon.com/

