Return-Path: <linux-kernel+bounces-128682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE0895E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2AC28B935
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A0715EFA3;
	Tue,  2 Apr 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PafcERh+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337515E7EC;
	Tue,  2 Apr 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091184; cv=fail; b=Wi9Sraj/Qs5Qwgf2TUbvr9eNHSD2IxIMG375UHVZYbsOt7Er/ll1wav1M9shItE8maBTD8+fIsHNiKTr8J4Aj22LpTojJwLweK/SmcDCJIJ+fpvsqXw0DPHcaPBlrFyNh+uywC96E5NGvkdzyLB6NTdvj3oNs/Je2A3Fl2+2uL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091184; c=relaxed/simple;
	bh=i37RrI0Yfd+qpbhqvBQb0KwqxFEgy6CsR2rSzcv5NG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=puDuMS1Yx81XdtJ1quDzLhtMmmBI6mjZPtKFAl4OIih5n5ybYTdZn1BL27MqljeGTvXc7eZ0QjFz0T3ihby+DxkJJ2ZemvMzA9E0UMZeEpnQUaiWHHlfJaI2UG5BAzObT9LlharctBWjZcMYz8TNLUieKzOWT+CrzojY4/0nsw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PafcERh+; arc=fail smtp.client-ip=40.107.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdM4ZJQyUDFoJzce8HlBANO3k/OHXob0VZcIzC87s5K05IUrfrD/oa/UVWua7rCl8l+qNRmJVRkZ63eA8DsbUT/SlBQI+I/f1rng7LJG/VmoZGCuYCvfxNNFYfqHpXhiDf2B8mWI1P16cp9tQ8AcfCgR0l3gSQC+UPB2IMHScqY8lvujhBCKqwwVzD6LFSWr3IPubn3NZzcNM+nk62qcNgQCdXoKqDopxJUdc1Qrev5/nEnnZon4zZgBDkM5lsTxj98gVj1VrsgFpCcD0VsaD3iGUZ55rTvtYUywx8wApbqFB0Q9rKoNlplpY/kUmD+Gy/hScFtfvno5/WrdZ6oVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bZiNK+KNKQ4yMz90KgKJ+Sq/gR08XGQsI5wDFJnBIQ=;
 b=cmLeTvTYv4n81NejGhQ1fRiH+HkGOtOg+gOxT1sHdJOT44wKAXkPvCqT5LhFZk1kgpyUrlbi+KxFDC4hc/0ZNYFFinmgzuLK0z5WpnjbA9fI0xsDmbLEWyH6+uPLWVVJL2KqB8Y5m6ErCRFf/h9YQyNSSYCRVY+jk3DZteY1CuehMH0bntegLc/MeafPwLCxTwmC/Q4CXEB9qhlbqg8weRZRKF+UK7aLOn/reokeEfrb6xSlzHRKAJEXeryVirWDLbcxE+LxrHCsJoHe8iThqFiPmenyMj8wgrMfUxfGoKKkETFbYWcwTclc391WvMpyYa4VLE9atS6+MHQus0w1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bZiNK+KNKQ4yMz90KgKJ+Sq/gR08XGQsI5wDFJnBIQ=;
 b=PafcERh+kRxBvTQsQg1Vr+8CZvT0rQcQSCU0xX9fkj+2NPb2gii4qVRD4UGPuzyllrfcAr5DlWVgzmkeowWhYSigbgMnVgtDE/RLySzQzPUSyZzG7H2LubRqD5ilORx+U5Psq/JW2MF3jqjwOe+g9WOyMQfET3ldVQOrNYAkPlpxXwMIZCynoHCuPLI0ywG87FCruOZmoAK/Gbr8dYjiwnJHPZR2vl4rmoJcW1vh7/phjmOJ8HnV5zKalVFZCGAsS6cUUZ7cKlSxTWoSoccJ29f9WHTsv7lmvVuSheU/lH+TAHxnj11WBsQXYTgA6S+6olLf9szljZghHzFL7+MO1A==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 20:52:30 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 20:52:30 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	alexandre.torgue@foss.st.com,
	andrew@lunn.ch,
	cjubran@nvidia.com,
	corbet@lwn.net,
	davem@davemloft.net,
	dtatulea@nvidia.com,
	edumazet@google.com,
	gal@nvidia.com,
	hkallweit1@gmail.com,
	jacob.e.keller@intel.com,
	jiri@resnulli.us,
	joabreu@synopsys.com,
	justinstitt@google.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	leon@kernel.org,
	liuhangbin@gmail.com,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com,
	paul.greenwalt@intel.com,
	przemyslaw.kitszel@intel.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	saeed@kernel.org,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev,
	vladimir.oltean@nxp.com,
	wojciech.drewek@intel.com,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net-next v1 5/6] netlink: specs: ethtool: add header-flags enumeration
Date: Tue,  2 Apr 2024 13:52:05 -0700
Message-ID: <20240402205223.137565-6-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240402205223.137565-1-rrameshbabu@nvidia.com>
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MW3PR12MB4393:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DypMzFw3u4zNWdgBXOadM06KP8IS6H6GA0LDgIk/+NMBuuRSLPNmVO+naTDUKSJf2TBIYcRSYRRHXlKGO1S78WOVwKskNqsnglAAn41FHbNxQp5WjokQrVYr4XWp4pQ8fY/53K3N1eSyz116FOmaV6Oz5fwK/x50zorsYkaYcScT9rv0JayEFFCQF0LT+LAZw2AafHTeYJHRojRxxgT1lZvGl5jzx4w0JIxqXHGg5cYMbpe5WQF84vue7f+SIID1zBkEZkRB/68LO/2EkJUjkcGeQOQJnfv+rJGRwExk0Ajg5ae38FVzbhZFOoLf4Hg2iDao8Fr9krNOf3QpmMfRT9AL6u8xLwqqyPCPKfmrsGSehuF5HE0GSqOMwyxVKg4sLuKk/mGxqlXH3HfsnLTLnjyN9LSpMnFEelMyHHliRse26UDVZCaPjN/OX//fCXpZuUwsHYF+2hYxT/mWXHRxecAVTY7cEwJYDtS5e3bk7Kg2bNmLg1YTEhFPc/N0l/M0ndMr4EpfZy5dWKqDXupljQH4uW4rsZavSYx/Kg31lvY9CHmpVK8yZiMRI6wR/XN/7qCEzCwxDmHZAMLaNRTf9P9zp/VVV/Eq1ALEyWwbxWsQc74exJ3DZQ4qzfSxYZSvP/yL92gQpYfGAztv6YeTfKcLvfWq9xSZYSBQAjLxovA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdX/32sAduWM8bQbg8WqWz88oAr5zMmneJSw3/+jKTDRqgeZaL3+yLaAAbJa?=
 =?us-ascii?Q?sRbxMfFw+gNnRdd7phAx9OH7vBMDcWQkJEW6c+DzQsGKjT8wP96hHi7AcrX2?=
 =?us-ascii?Q?Inc9JPtCjbaG0NjSAJlf1HktIxJgLrA/pamzkP7E0naiaLoXmXixQWItu98o?=
 =?us-ascii?Q?texHekfO29ISRxP9AqGtjfgf6SCnG5b3qBNorxkU0iKquUUsGp5ZfAtwJlg+?=
 =?us-ascii?Q?XGa1IyzxyJAHlbxPDbZ1+N1JOpTQduIZYsDAbQqj3cXK8xCV4pv5uMnL9gMx?=
 =?us-ascii?Q?SLzqlWRCvXNJXR+vs2pJPYq4fTW/R0e0RaA05t99qPoSYtaZky12yo/QjNal?=
 =?us-ascii?Q?fw/PMa9CPeEMN/Tnf+LVXtCOrObvbg5W0EU0OX21vlN92I67m7XjwqYKYBtb?=
 =?us-ascii?Q?uum69sOshMQiM2JFhVbeXkIwATQTk39q6CedHRsjOp/ebA0xifA5hRUMDK+u?=
 =?us-ascii?Q?4VoiCeMZ7OIKizXR2zBwGgwMNNedimslrS+vLPOEPOXAFGTQxvBofphWX/tv?=
 =?us-ascii?Q?DE6Eo87li8Mf8dKxZ7w/gtldBp8cU/ZW/ZKN+NWHjBXjhCCrd5Nrbz3rlgbN?=
 =?us-ascii?Q?P9o28F1BYdhr/9SKC056hzR9KjikQlIiN05oYDZxWKL5tApo/Q4UDUcR9KFp?=
 =?us-ascii?Q?auzkIYcTxlbB8EOtPCieCq4BCv/cd7ki3iVvOYOorAtFXs7Zcywe1HHcnJdw?=
 =?us-ascii?Q?wx6J00usejh/bmn9vpALAJXkctp/OJT5015N17JnslIG59d8hYKm8D9CIzTv?=
 =?us-ascii?Q?98XrUeyKGZMEYq/vVOuvZaDO4gJcC6CmKtL/N5nF46g+NBqKaKqSo7O1moik?=
 =?us-ascii?Q?mzrG5SjbUAFvphHKppHFAj0im1g2aFZSH8r2DxkOPvtWglK6lznSXqDpO2jG?=
 =?us-ascii?Q?a+2v2MxRf4nKD5aAlhHnCtWKiJy1AsVv+Vzv+pjSKmAdfNHNfcgj4JwB6nJb?=
 =?us-ascii?Q?0tOYjLapRC9kZ75dckIAudzdjGHIh8SwilF1/cckWHHs9vL7dizqYnkqZpGH?=
 =?us-ascii?Q?UqoYvlXADYXEgWo38EBEtHbpXmV3+5WvtcSCa7705XWduIy+kRqLhkpILMSw?=
 =?us-ascii?Q?A5b8KGvpYNdI7zY2BhfW7aghxrJ7r59DNtHEpcee19x85uBZm6MIblDWV3/X?=
 =?us-ascii?Q?UcmmhzJLFVp0st/jQa1295ZCO2bWKznJ5gLxszJh4csnLGVqQjkVWyTwnhsF?=
 =?us-ascii?Q?AsiYj/tOvlIPJLspd5vrC+47obfDT4BDA1VHFqtZlY2zGlREkPkcb0fDHQIQ?=
 =?us-ascii?Q?oR+cl1L4NtPRFZfgG7tZq5hrBDfR+Zdsc9oHUHrOaAHT+1Kgbx+5LSKyyS31?=
 =?us-ascii?Q?8SQXXiCtY5gchMyytd885+XzpbWZGzA0Yv44vWJQ4SKwP4ysX0O6razIfZHf?=
 =?us-ascii?Q?5afBpfsIQ+AhYR+U7ZWhygFS0TK3ajBX1+evVnCmuAMgGchmOvC+F2D5DFo0?=
 =?us-ascii?Q?z01mJUNpJFJIcSbR2ArFcQ65gAtLimFhchkGSxj5tiQxqoMh7cyz70FQFvn+?=
 =?us-ascii?Q?xM+j3dnX0tmqcUeLUqBQYpx0Q0yMplkKwjqoJbGBlYjT8XIjh00hqRW+oSKY?=
 =?us-ascii?Q?88aA6rujX7V1IgIa2kO6BY5afQ1foW+d6GmDISqOr30PaIE9AfUY6AVPl51K?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0880f769-3a49-4ec3-742f-08dc5356d033
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 20:52:30.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMIc3mv/QpnD9t/z30B3QTSPT4FiI/6JkjFvqqFMg4Es0ERpehgr9NwINtTrXLAXwJ/GjnChP9jVczRtcSAzHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

Enable specifying header flags using enumerated entries in the spec file
rather than raw flag values.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 Documentation/netlink/specs/ethtool.yaml |  5 +++++
 include/uapi/linux/ethtool_netlink.h     | 11 +++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index f5aa1e7f3383..bae3bb013787 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -16,6 +16,10 @@ definitions:
     name: stringset
     type: enum
     entries: []
+  -
+    name: header-flags
+    type: flags
+    entries: [ compact-bitset, omit-reply, stats ]
 
 attribute-sets:
   -
@@ -30,6 +34,7 @@ attribute-sets:
       -
         name: flags
         type: u32
+        enum: header-flags
 
   -
     name: bitset-bit
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 8dfd714c2308..34a4a64262b2 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -117,12 +117,11 @@ enum {
 
 /* request header */
 
-/* use compact bitsets in reply */
-#define ETHTOOL_FLAG_COMPACT_BITSETS	(1 << 0)
-/* provide optional reply for SET or ACT requests */
-#define ETHTOOL_FLAG_OMIT_REPLY	(1 << 1)
-/* request statistics, if supported by the driver */
-#define ETHTOOL_FLAG_STATS		(1 << 2)
+enum ethtool_header_flags {
+	ETHTOOL_FLAG_COMPACT_BITSETS	= 1 << 0,	/* use compact bitsets in reply */
+	ETHTOOL_FLAG_OMIT_REPLY		= 1 << 1,	/* provide optional reply for SET or ACT requests */
+	ETHTOOL_FLAG_STATS		= 1 << 2,	/* request statistics, if supported by the driver */
+};
 
 #define ETHTOOL_FLAG_ALL (ETHTOOL_FLAG_COMPACT_BITSETS | \
 			  ETHTOOL_FLAG_OMIT_REPLY | \
-- 
2.42.0


