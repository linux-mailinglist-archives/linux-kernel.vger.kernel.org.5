Return-Path: <linux-kernel+bounces-116528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDFA88A06B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A282C2932
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72FC76046;
	Mon, 25 Mar 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eu7jsqMk"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE01C584B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342606; cv=fail; b=Cy/aBcqQ0QTJ7NDWLL6oQTfBzgJvTIDrm6fRFjA2+iHcxTZq20douizSUoNM9OnzzxN6BFDthoh8ulctuutqnCKy9Sje1NEbHgitgN3My70qI/U3OO4AftIwjZXcfrQiFjLKvUWCqiy2n3471DQzd1uH1R+FqrBDUBbgj7H6OGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342606; c=relaxed/simple;
	bh=0mpJdUFwvyzeIjs/R32kZR0Rc/x0NKHI1MxVxlSbv/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JTYcKnZyP1qoZ9tpxj1bf/fy95dhgN7rugxT1An318KngOTRQeQRkW6yM3ZEpJeG4bD6JCBSp9O0OkqGp11Z1Nwf+32KAVa4gWySxlxt3fDIyMdyD/cJXSa9h6OL5YgnNrfYHY6mC+iFKo2ptXwUPSrsy6rCb58r64rd+xYmcyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eu7jsqMk; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS7/+W+2S8gsvhw3TLndSCrd7hNWDuS3xDrlbBcpUXoH1BqGg36Ek3dpPAXGgnCAZq4cxNQ+xUFo5PN+KBaScLpwUHr52ytBqRLRbe5zevjhVCstKzGUvHDeNKJ/B0J5VtenofjhmxpK+awQRZ33WAk/bcAEUI2Hlc0ZSV8AwVlrO3HrtkAN3qm/1EVrZPRaGr316e5+U5ZKwjYIR+F+X1Co1TY3RZr0Exb/kthSgM5aDO9Y7BZS3vW1DoburUMikpkRuhZ8vqzJkFtTgKsDXDOeqshscWzlbo4yHPLu5t4fn6eh6+1cwKP4XhF4Pj30YdyJBcCeS6HIK+iB0bTOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyBLUPD/mCdiBYehrBqpjV0AQR8JIeoBZz38Rg0Wi+k=;
 b=W19P5BjfaWvzKg09Qah8oLYmICk9snlXdzCI4yyYyueopxlfadOuq94B4GtxfkiaBX8nGV3XMlywMhmAg30KXg5TjS9Abc9ChAM8O+th+W0jP2HxkUMI0Nu3xXbd6JyfNKu1hk7ReZ6Da1klcygbcQHCudMI+p+zjfdtdbYH/6xEHOerJKuoFsL3/tyAfK5RLFW0VukJPBQZrz5foSv+J8TMYl/pyKDk5aSr9Sle6hEAbU7hgPfXiCWOJMi761gOVQu/xbIp2btUplmWPUgehcAlRX9yuh4Pxi1TZk1vu27QqjWBzJMKDDL/mQ210xLZRMVGXpCKNKAkShzDE1D96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyBLUPD/mCdiBYehrBqpjV0AQR8JIeoBZz38Rg0Wi+k=;
 b=eu7jsqMkrpxfeI4Nr0GoAbFqk+sPH6mEDTFIInLWwzn8/008b5KqjEsT5Di7+PQfaQeIeuayf0HjSziUNizlqTLp8GUCA+pJ4N8sIw9J1dtjF06pqVlghk0XNDPIoSFHzDVRHFi54Ttki/X6GkoH2qF79K1h+bWPBNR85I6Waey/65vMBrYCnylk6ZSgXfVYVv3RNqweDZrpt9WWGFB6sjt1lP6V6/iVEH6IxMSOux/97khGmxqDKONSh0+wN3WFMVJz9ox2qnjuItTdmWIVg0LiCTouKXBdrH0uyz2rDtm6dyTtj0s8chKNMMmnjFWxusM0jHCsv2lncJ93mTdxkg==
Received: from CH0PR03CA0335.namprd03.prod.outlook.com (2603:10b6:610:11a::31)
 by MN2PR12MB4174.namprd12.prod.outlook.com (2603:10b6:208:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 04:56:40 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::a) by CH0PR03CA0335.outlook.office365.com
 (2603:10b6:610:11a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 04:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 04:56:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 24 Mar
 2024 21:56:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 24 Mar 2024 21:56:32 -0700
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 24 Mar 2024 21:56:32 -0700
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, John Hubbard
	<jhubbard@nvidia.com>, David Hildenbrand <david@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Vishal Moola <vishal.moola@gmail.com>, Peter Collingbourne
	<pcc@google.com>
Subject: [RFC] mm: page-flags.h: remove the bias against tail pages
Date: Sun, 24 Mar 2024 21:55:19 -0700
Message-ID: <20240325045519.222458-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN2PR12MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: a6191545-2444-4299-793f-08dc4c87f5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MeAjrvrEnbazyAMDOPEBU3bX8PbhNCZkgDoxWTpAqWkC83/EewDiIxscqwd47B30FxmQIhxP2QyHMnqhTj8Yej0AL0hFMD8Re/vxn9yLOEOeJUNwmapnyEr4krETJYXtUUe9fgHRp/40jTA8pq5bst8Y6NJVJi0AbbcyeX9AK2LLIyk0FOcRNW6omP+7tEFkoi/NVcpFXzCRgFRcbO38lg33ajByjRUnQWsBeg7lBb3hoCL6APssmPRdCCgsyQTbosTkD2WkLSf+kxlpifKxVVTWigL0Su7dOcSih1+QZgjw3YnweC3BqKljIQpJWkobwdbsigubSucpNw1Uy8RXv0G8soeKSmIYYFwJnbDb9C4ECdk8cJ8FxuX3TCa3Sf2Lynb9M1M4v4Kk5IbUOfGqcn8sul1IFYUg9sQrxKkd/svMEQzD/zd3SB6XBYj/SXQdN6J8A8O/55hz1tiF/lNQxpC4hplfbwBOJxxfneTjFvMCjoCA+opJ7XeO5w7q3WKXZo2WHjBIljjBHDHETMyAhJuT3uHAgPAPAsiuVAw1NYlGGOld8JfK7N4NGD/9qrwqSZLT8JaXgQAiVPkRAMN1uqoMOP3TMMcVhNgiwWJg+b+DvebBHM+R9UtmhfcoGDwxujQDW2X4ekIs20Ln1CbEa2eLauMn2HT6kRimAA/grbERlcKnnNTDBFMBCtW3txmarA4QrVmsSSY7wzRwQCHRB7qj+yMPctgku9XrTYRMg+Wo++Ho+S7IXOGrUxBwY8Tz
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 04:56:40.4771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6191545-2444-4299-793f-08dc4c87f5b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4174

commit 1d798ca3f1643 ("mm: make compound_head() robust") added
page->compound_head and the associated "unlikely" check for a tail page
in compound_head():

	if (unlikely(head & 1))
		return (struct page *) (head - 1);
	return page;

That worked nicely in 2015. However, in the 8.5 years since then, things
have changed: folios and huge pages are heavily used, with more uses
coming. See for example the various THP enhancements being proposed. And
hugetlbfs remains alive and well. And large folios are being plumbed
into everything.

With that in mind, remove the "unlikely" attribute when checking for a
tail page in compound_head(), and let normal CPU branch prediction do
what it may.

Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Peter Collingbourne <pcc@google.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

Is this reasonable? I haven't gone out and gathered test data, because
the original patch to create this just assumed that compound pages were
uncommon, and so now it's time to stop making that assumption. I think
that's sufficient reasoning here to leave out the compiler hint, right?

thanks,
John Hubbard
NVIDIA

 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 652d77805e99..ae9509c6736c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -246,7 +246,7 @@ static inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
-	if (unlikely(head & 1))
+	if (head & 1)
 		return head - 1;
 	return (unsigned long)page_fixed_fake_head(page);
 }
-- 
2.44.0


