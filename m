Return-Path: <linux-kernel+bounces-148866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDE8A8851
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BB01F21B61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8DF1487C6;
	Wed, 17 Apr 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+svFLKX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CB1411CF;
	Wed, 17 Apr 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369528; cv=fail; b=DAIM9e2yq6+TrgqZEEPKWTXFffJpWGDzkxQ4s8FK6wHnTurDVMZRkjIv6nSkxuxj9AryEbLpnt3yozaM91Ct0n6hcNKjFd559zDz+Dspz6PQq9yIjUkyWaatDvYOQu8+Xc7gPsqGmPWs9S3Um7Nx90+TsVE0tZBetA+rxecPYBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369528; c=relaxed/simple;
	bh=YiVCssRfvb/dKENGvjbvQss5vTpEd0WGXxuwh3KKq0Q=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Op0Z5hDJ9/ozRE2Cpg/gj5JRF4FW7kJhpN1UuZAm5LEk1uHWeIOEsVLIK1Ox67/y3dKjE1ONmH6qgwem5snxZbvg0aBkPjNJ7NJdyMk+sLaGdYtrOYvXgU2fDteY1Aj4FTMy5/etU041A/EXkh4DPYLZ/dlqCkZc/qRvdRY/34Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D+svFLKX; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFWAJ8/Jq21gl+Tg1hT+KZ13t5hZZ2TjQywWcvsvvuZ+kHMo+R61fgQUZSXlcfVxYivGBeK4UmGZqAh2zpUNFQRwv/C2fiYiRCyDG/tHACTZ9wGGO3t4NqKmixCq0/aNflOyUoMVY8s7W9xuTIVK7UN+vjutS2kZmNSw1w9IJAaU9gqYP9Re0kXN7v+wLt6hE4BZXMEIQhesiuNudhEIF66PWyrEApUczCoE2Vg1kXjeVxsFCZJs24Bn6iKako1YUo1t23Y8eQdhHvCOl56srshzGtyavB93XeCVmu6YTG/qdH4T/Gz7Geezm0UO/Ycs9AkpSp1cfv6auDZTOgmPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiVCssRfvb/dKENGvjbvQss5vTpEd0WGXxuwh3KKq0Q=;
 b=JUJYDVCFezzXzJ+Ccg1WKJVLgoldpxpffWSG+MV4+5gFoi3z/lrkUwqTPeN3jiy8NZ+U6giXJxVmz83JO7GCrjzJhznKLowTDNU/kziBMxoPFws2fsbTob8iwJfN3BOjkuTp+LNBgLNvfbePd9+/kxCI/qpYiQ08M2LKpBoHAInt0RpumQCvxYamIUm9LdBQW/d7jvYMxgMCDeYg0mW2hZzoVnnLhf+nZsQxc2YuBXl5Enwb/OvcjanbCm8LhR+X2jZgISkx99G4iwkZoSvwNkerhmwbPZ6TgOwJs6tJbUJ6C/hOkX/7HnQR7oAOACX7RnRNwO8FS8M87U1toTH1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiVCssRfvb/dKENGvjbvQss5vTpEd0WGXxuwh3KKq0Q=;
 b=D+svFLKXWXbf9qQm68/1V6d/Fh661/3dNzaXZ8zxyUE8GUnNuDYkTgPYXtQedfRG6uVPVveL3jvM1ktm3JycjgB8H8LlsoNfTYu/Im/TIcwcD/EmuJZvtIpErAN45lbG/BqExNuRDeZGlSP+u+LQGBvQIni9MWUVAzQNRFkHJhVYQYMNL4cVTgXs2iSsLDnUkbGhmGJ6k9mjCIoZSXUvtiC2L0JxklGDkjONqaPFF4oJ4NutEbOXEW344KEYqxisYo/hGFj8gtwkrNWFyjcd73R3/8cf19r+c72Wp+S+HtXEsnuQJubva6V6R+i2NHeheKpksri0CRgZCol4EKB/Hw==
Received: from MW4PR03CA0117.namprd03.prod.outlook.com (2603:10b6:303:b7::32)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.38; Wed, 17 Apr
 2024 15:58:43 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:b7:cafe::d5) by MW4PR03CA0117.outlook.office365.com
 (2603:10b6:303:b7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Wed, 17 Apr 2024 15:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Wed, 17 Apr 2024 15:58:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Apr
 2024 08:58:33 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Apr
 2024 08:58:29 -0700
References: <20240417135131.99921-1-ast@fiberby.net>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?= <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next] mlxsw: spectrum_flower: validate control flags
Date: Wed, 17 Apr 2024 17:57:48 +0200
In-Reply-To: <20240417135131.99921-1-ast@fiberby.net>
Message-ID: <87o7a8c76m.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cdcd03-8f5a-4953-6e00-08dc5ef741c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rNf2/mSPbQRk9eq9ybODdcDeDEbOD66mXlh0CwsQJmNqzAsXqfpaoeaMqO5mb0fbgJ3jMUm1vE6CNiSO7OYmaJKf3Rxy3msldet9Vz3ZF7d3FRYJjbNm4WZaSov1B9NurVZQM19VMo6ufTtWxq2sQGfzLCs8+UJtCokcAWLUuKsb7xkQ1aaa4/AXpwsYELJM/AN4d401bg6NzbnJlGyx8EDU/A0LdlAXOteWT4ozfNoOmFJ6mVholxFjJxvg/gwDDU5MfsuO7wNPMPn2AXIviqdh470QjuHKBjdHj2+qdmeG/RYCxXe3KgoQrwxHa/4GVtNEH+2sRq4lcRBUPLcNbK4bV1sSznMDZjUYPqVPYVUPAV047pBkoK9zDJxvoPlYehlBdejabvHOzokJlCWwSk5uYC2S10PabMVQK0zQGWc2MyVtpJk/G1UV6L2Phu5r9CoOf96XGxZ8jdbGGVbQ7/SaptXeumbgZAnvvw6wWkqIntVKAWbr+aWVQcXGiMLAJUTgN4ze9MLHdNt8Q5pAbZdCp5woalauswOjO5W5GM5hBLl3xEvtHGT28x7gQynaoQjS0s6HMHY3MqLZfMN01lmeMx8Jj9A2ZGTPJo8p2lHN44/OFM342FDffbzrpdg1c5OUJpoFFvXT1bCDgu9tcORbDXGVA/LBq4bA7PKLGpuAPECEwJUeipxnVmLCpKO39IxN65Bc7R2qc6DPzqC0JGByj8caWhQGdk/TXceK57KPu3xlX0NdoXBTShvpPT5k
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 15:58:43.1933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cdcd03-8f5a-4953-6e00-08dc5ef741c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308


Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> This driver currently doesn't support any control flags.
>
> Use flow_rule_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
>
> In case any control flags are masked, flow_rule_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
>
> Only compile-tested.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Thanks, I'll take this through our regression.

