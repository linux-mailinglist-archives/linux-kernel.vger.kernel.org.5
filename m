Return-Path: <linux-kernel+bounces-123964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99141891068
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D241C21BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF9179B7;
	Fri, 29 Mar 2024 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="T5OLUA3I"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9ECA7A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675964; cv=fail; b=aUwysPxKGez73aPQHcfVJA/fpGPoLQQsqllRJIy6W7fcdSpmLXX2GWRVsaIqcKFTU5pnsYH46VXh4D69U9y77mXjhT6c33sGATUtw2ekY1n5L3gcBAQzq1ORbclJ4ENm/yyrbcINZ1sjK9IWT8l/tH3sg3K4r4XnRmvNL3nlqQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675964; c=relaxed/simple;
	bh=Ig1cz/NaP2WjXX/9bQxSfKqXf6A0OJKM/piDet0CUYg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mw9x6YgV/qzw2eZ7egs981yj2br96O1WNap42S41iRkkl63HjCRpDeWXVn+kl3GJu3yUpobCLOZgqShcH6HJrWs7DMgOmHLcLj8UzVQpnOwfiDbWVn2xp9YfxCQg3+E/xQRQu6JdGe7xi0uBvl+iKLpBvN43D3ElUHgZ+jkrjns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=T5OLUA3I; arc=fail smtp.client-ip=40.107.220.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmUcT8aUS8um1SuGdvCTt5gv6vKeRa2cq9N2gkc4ykfi3qUnlf6XLthwWNlEwzFoHw1pl6Lg60eOezllsvnPnY6iJf8sUOJ0rMN8cyRURDsWFVEIczDM2esxO9jfk18R3XgRMOwJfhc/K0IgAfz8hAD9bRuC56pLSAnJ/NbWvj92VsJE1Kg2a55yc149VDFgDmWwvxTtwoBpn5l5h9pOJC6Q3vkvBOLs5qsdki+PM5I9FyND82rYG8ZyqQ5bpBVLuDeU3AJHbrwR2o+XbPyKtQk0aNCa22rcSlwjvdgHKnp47L6amh0zKCEkZ8JXLy0jWiOzMI05+SGZyzxivcyi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk2e9KFtNVUFkWiS7bpjbt1VopeeLdQqwIhnK+xhUNI=;
 b=cQSECR3yZfLV5hsgJTzpxj14A1yYxFZq7zeUX1sjqv4owlz1gPfejcEjH0PCEmG3b5DGWZhCivnoYDBrgd8xdK6BT0Ml966oPkTwcdvUaoeEyUfZKHmiZ/IjkPT/g9GZzpTbe94nve46tQJonLjULxHYWiKSoA/UQbqVRz+H1lAwYSzWscrYU/qSvXElbBs3qCBSpv2T5EALP6GpFVMIZaqNJB4so6pfrBjvxQC0c7EnNQus+48fgAmOP1bf2VWlZcG3Bdx4lZD9khyLV2sxRimBGSkNgkfBOPq3iEywUdm65RVgUCFiDLVQi2Y1cXJg3apXY8bfNh4flkSbtKsDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk2e9KFtNVUFkWiS7bpjbt1VopeeLdQqwIhnK+xhUNI=;
 b=T5OLUA3It7HXApmqfLVsZ8oVkcPr1v0ZcDa1lVU4Y8gWhcCofdWndbj2MYSyxsvqwAZp8B9zFahuqlJtGa4409DmhuklghqqxPJOxKmcgrTgirAIEKQcmC9wTz9cBgoAPCRaXpCqz30EjIQpFnInpLa41vKB3ZAahW3aiMWzp/s=
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 DS7PR01MB7878.prod.exchangelabs.com (2603:10b6:8:81::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Fri, 29 Mar 2024 01:32:37 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7409.038; Fri, 29 Mar 2024
 01:32:37 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v3 0/2] Mesh PMU: Add tertiary match group support
Date: Thu, 28 Mar 2024 18:32:13 -0700
Message-ID: <20240329013215.169345-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:610:b1::13) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|DS7PR01MB7878:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uxiXQt+RsCb5JApZOid1shaDyTg/rz0UN4AjFCJjQxCMuENcc1cH3+HZW28jQDOE9WG3dyHoHLvoU+igBE0oViEnva6LRX/WWldQi8ZvpT1iGIm4FNFCFL1EWzg7yQsbiWDMwZxGF4Nz+jx6FgpV0n6z6hCKuKFZndJnQScvfeM7XY2uiwEmr9ImB303mejs6miWVvptDa9RCsB7aJg9gC4C0JhzdBg1uejcJO8xCbqe1l5R7tkJvc2tIwwgMQ5sZpJfBASaqWDwC0IfVReeRrXbBQmJn1MUJL9VuZ6CBapvc2M8FOYh3j1Pg9vzaKDtEWE2IdCREMWCs6I9CV3wuEVA1G/2QA2USOgfoboc5LsHDNCuoWp11/jMGsg1uyD9ZCk4og2rhvexMSWtythA+hMEfZRq31ezjdrcoTQk9SpKhQYR8F7XuBTQFJ1aJ9Of3+JFlZ8rnDAaCkd11TV5wOeEU6y0cwznx3qXbT3ieIYbY8XF9c8c3pqg+nWZJujnqyAWP8WGaqvYB1W6JJmQcBFZIfhZ6HW0Ba9sssampynqxNB4W6CEmvfBLvxhPsOefc1JISEFSPbpttX0alKQ4LQKtuBIj6/UVHgE7tTfPzncjClpd2KALyPVVtTChiUNtp6p1rID/ShUF2gLl238sHBdOzEk5HvEmDwlI00Vq0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VFYBIRrgPfwehK3Jtbh1yo5VfJPXVZqmAdwBA6QP/ftPQ4z08JZ/JiFQovb/?=
 =?us-ascii?Q?7uZjHZf4tYg0eI6e/TmAPLZza7VfP49IGx+ryptOlW1fGxJseHn5Kxh53NGy?=
 =?us-ascii?Q?HdVlPonpTEF4s/MkLjJjx8NoaR7jv9nKlhTKEydEYcCpAlsOAomT88zfzzEX?=
 =?us-ascii?Q?KgI7IF5xJ3rG7ZCCNgWszYwkj0GVRAZaTq7dqJ6LPzOy9nydqTy9KlcE09FE?=
 =?us-ascii?Q?DPTxGT11gHmyk+V0Ltm49zd5o4lsOOHo6NTswk0zI5kp7t+KhQD2PAXtnJMk?=
 =?us-ascii?Q?a8y6Tjz3F5DWvB8YB81nvTL287PcmjC7ar1Q4Pq+StqwnhTPXbSx7JE2Ar5x?=
 =?us-ascii?Q?SJhCUHqTOdi+CpyMJ3IhM1adVb3uUxygm2Ho7kPWvWTfPslyVlo62btNsDTI?=
 =?us-ascii?Q?njhmpfrkBmjtiAdCAUGEGxHzqXWXPqjGw5Osg8oDwzp31qkdOvfSMovTpjIP?=
 =?us-ascii?Q?9bnOMrp0peSEm11ObR669cSOuMvN1nigmEmE3kvrA3xa9TfogvEWMNxOrufD?=
 =?us-ascii?Q?N40cHSzqz/102MBmVNAEQHM3dm5WTDqPKQbeU53DuWQAf0YDIv9QQvmKAzbd?=
 =?us-ascii?Q?sIcULI+Js22qjk24s+pxPNryJ8148KVAjd1IX37YZ7gNocIXjLsC3uFT9fRU?=
 =?us-ascii?Q?c09CLHJhYOGm+pMwM0KvRHeiuEUQk+QsKZvmHaRd1BZUjKhN12ix6UfAgNf3?=
 =?us-ascii?Q?cUIeCHXCg+/DoDzVbxDn99N8d8SAu7MSi6HgIa7wAAUNSV/4Qev1EYbgZk77?=
 =?us-ascii?Q?cqKOFtsqroVfwq13viEJuyZP5AJ7w3rpLAUpHnOAmvjGauTBCE/F6iWzpXy4?=
 =?us-ascii?Q?xMrv275XbwgJ/0ORdN8sP2maIzOm83wOd5cm0uGzaEnsifFdt1XoxFpgw/Uk?=
 =?us-ascii?Q?7Os5G3WU7N5SXuN45ZOZGoAXgqjpBf3D3uYGI+Avts7ejiwPAsJK+zLNcnZM?=
 =?us-ascii?Q?cfKhBYB0TCwtHxFCeEWkn3NbiwfwW7tsgrdd19z4qHw3obSg8os4HcDZG08k?=
 =?us-ascii?Q?KaWlRzNGxSPPvKZaJ+otkbppqKbQJwE9+tyXvHZtLOLM9TK4a180zQJWpqmp?=
 =?us-ascii?Q?nJzE7y6Dg/H1rJWTOAV3sEM0a2gerUoOxDxNbMLrHOwvGj9RqOErrW7hXOoB?=
 =?us-ascii?Q?A27daO+zrwWcn24ck1SIG6LBV+XqSTKR7C8ngrEXQP3lXOUTl4ttoMZF6Roe?=
 =?us-ascii?Q?++ODVPuNk+7Ch8DKZ/jBJFaicpuhY+wYMENLn7u791zbvnguVOvPlwzE8MXR?=
 =?us-ascii?Q?6A5Lw68rQFyKoorGyNhGhLLHEjEb/lvZ5M8NQV+UgJubeRQ+1fpo6Spv45hu?=
 =?us-ascii?Q?hjbfrfqnnZU6iJKxowm3Z9Qs5oueCHFZsVId2jsxQyxBqxbzn2U/YV9UgwKN?=
 =?us-ascii?Q?0GuPIiF9l3CWKXcM/iNN2hQN/kgr2uZdXxCvZzx+s4i1MET/wcGf4A4+HDy8?=
 =?us-ascii?Q?qnT/u2FTf2Vn60m9kcUf/Bk4BLamV8HrY3pZzinmjX29UX5+ts4JH8JyhHPL?=
 =?us-ascii?Q?8Avt/ePJt2Z7J3lkobR9ubaMOyhhhnAyt51lG5SzrS64bv12yQ+C1f1PHbkU?=
 =?us-ascii?Q?S5OaqPfZfhje4GUZZj1QoAIGw9kocLzoNAFeKi6aWq25Kf2Jq+xYjRMpgdog?=
 =?us-ascii?Q?hqgIeaB+SxAlbpbMPvVsoBw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8422be67-160c-44f1-6dad-08dc4f901dda
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:32:37.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDi+LeZ2oPpQWF67AD15uujjSi0NtLMZM1r5A4QHQfFKP5SJsi3TBfmUeCurCXmiqEJISQNycLvaZjMDwBy4FCuDY96Ki0/zupf5oATSe15WFmEXgZtCXJD1/3dU9wgQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7878

Hopefully, I got it this time and the patchset starts to look better now...


v3:
	* Replaced wp_cfg in arm_cmn_hw_event with wp_idx that keeps
	  track, whether the event uses 0 or 1 index for the given direction
	* Cleaned and simplified allocation/claiming of wp config
	* arm_cmn_val_add_event() can't and won't fail anymore
	* Separated wp_combine from wp[] in event validation phase
	* use memset()/sizeof() when clearing an event
	* Still kept wp config allocator in separate functions - at least
	  for now

v2:
        * Wp config registers are allocated on node basis, instead
	  of using the same one globally
	* Use bitmap in the event structure to keep track on the
	  wp config registers assigned to the specific event.
	* The bitmap tracks only either UP (wp conf 0&1) or DOWN
	  (wp conf 2&3) registers.
	* Dropped the second patch
	  ("The patch set v2 is now in the internal mailing list")
	  as perf/sysfs doesn't really support items with the same
	  name even if visibility would handle them.
        * Addressed a bunch of other comments by the author
	* https://lore.kernel.org/all/20240307230929.6233-2-ilkka@os.amperecomputing.com/	 

v1:
	* https://lore.kernel.org/all/20240126221215.1537377-1-ilkka@os.amperecomputing.com/


Ilkka Koskinen (2):
  perf/arm-cmn: Decouple wp_config registers from filter group number
  perf/arm-cmn: Enable support for tertiary match group

 drivers/perf/arm-cmn.c | 116 +++++++++++++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 23 deletions(-)

-- 
2.43.0


