Return-Path: <linux-kernel+bounces-97810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E64A876FD0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2F8281C8A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5203A381CC;
	Sat,  9 Mar 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VUTukaRY"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B572D603;
	Sat,  9 Mar 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709973902; cv=fail; b=DA0wK4YC6CPM4wCtDZLZRRulraP5x/gUR7knJzuv21hE4pprHlqF5fQhwPzvxjWzcla9EUHLZXK3RRpqCBTZKgvyDdTgqSgQ2rxAlw+F2Lhz8KQmRtRI/YRtG2EQ3KYtdbf/2Vo/ztSCDU+jeJmk9WtoDUXdzZ8qPXNoL+tMN3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709973902; c=relaxed/simple;
	bh=JRDWt4EGjmd0YtOuqx0r3pv3DIpAsjYBk09G5FwgP8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FugzRPzl/pE4OM43hlvoF2m3D4C/6tA1yaQlowjRX8O3k0/Hd8VF+HDEsd1TrUbV4SJgx9m55GQzJx1UIIfXRgUVZBW6fhFTscV2n+0zi1oWdcn6FRPLg3QPkZf0bbICCRq/F3j+jC0DSho06OglbJ6UISeuN6xAppMzrBW5l/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VUTukaRY; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuQephkNng46SbnOxUQnZe9zy4prShgUnfLSZc3sKz+uyxS3dlYsLVb+6Alnnh0YeeR5uzknwKkgn96HvQyAOA4cz57qJD1/HAUoC7WGvPwe/LxCvHtI/3A0Fr91Z+OBFpSBAzHEC129YOSkBoXl+0jL1E+oTP1CLJDDXexgs86AMtJDQG613N3UTDbT4ZfGOxWNeJj3NRihPK/oM+8ff+QUZsEdKtv0OOwHMA39OL2LjfSPCiMOKjzSBrJITJiLsQcEFfKKNP6KNT6M/EzhMJACRgNWmwVm2wV1QZkVbfi6AV3JPll7aAtHqyF5LpP1WZ8aUtudoPxcUX9DgQ6eMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0OX826FMlvQ5XNt9IPcEa+pizUCnBKfzRzvDntygPc=;
 b=M1WzcGwgqVcstHYDitZBDueNwobG0wzhH1HcW/hQyXOEvkbaQ10STS7uZY2xoq24XP1yMkRR/4/sR1hVbORDuJnd6N0AokABKUrtuXZAGHvVIpE7dCInQrEAXQ6qFL1SoT1Kp+rXTJCWjoQp//LfL6sm6NuoWd0qO+I+84bzoMvwIi3vXhoqYMs1PtEItvMqKJLw+6gP1y+wIJdjOA7BJZHfEAFUlSOki7cVzIj4rggMJkVVrJy71LrbLJ0Ch2Ge/jvh9k/sbMXzSLFK7KphEXatDa6HWj90jIy1fYR4YHiKZyevSRFFnPz1yDuPAdlyp25ccMMwoIENvzF+et5Qcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0OX826FMlvQ5XNt9IPcEa+pizUCnBKfzRzvDntygPc=;
 b=VUTukaRYeXbIB/fpjSmsF5lwd5fjgecdJJQwptiS1o+CQP+dpk+6OZg2wIXP7H+/cKLnhEPW1t9gyb045qcOP9UrDN5kgKbTA+e/CNM3LjgBRROXk5Kf0LXsincxLCkb84evis2ra07sSaC0vD/Jy8XQZ2Oa4cC8hWsM37CCq2JDuYBmm8nw+d4Uan/7lqv8g3kgfPJegdGGE+o46D7eUipz42mi0dvmqO+qmr6LrOift9ZHT2JV3Y+3Pt4TjH92LAjALyQAYxOvs6A4BoyeSTOHYIttXYMGicjkfsFn4pl4Fnw+jXRIoIkouc8cuswrJLKm1WE72YwXrNVz7AZQkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Sat, 9 Mar
 2024 08:44:56 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.024; Sat, 9 Mar 2024
 08:44:56 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: rrameshbabu@nvidia.com
Cc: ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	alexandre.torgue@foss.st.com,
	andrew@lunn.ch,
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuhangbin@gmail.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	paul.greenwalt@intel.com,
	przemyslaw.kitszel@intel.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	saeed@kernel.org,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev,
	vladimir.oltean@nxp.com,
	wojciech.drewek@intel.com
Subject: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware timestamping statistics
Date: Sat,  9 Mar 2024 00:44:35 -0800
Message-ID: <20240309084440.299358-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240309084440.299358-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 5831aebc-8746-41c6-d899-08dc401531cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9ihDgenn8pBJACRbcsEiBiv9vv9ZEVrbVJK9bwDGc7LVFvnbxxSrk+5lPVBtgmUseHDNLYladbMZiB1QHooelCsiOwSDfmBmUnT50wL7Ev41nqNLyHTkoA3XKtGleMtsIr0ZMJgEodZmICYMe0xLCCp5BirHfMdGaW3u0r40GvbcEjcQz/7/U9Dyldb+gyN7ckap8MnOBY2iGVP9Tu0J249x//Vuop5EPN83LTWcqa0+N/BpLxcZ1Y1KWcv6CfDlJ4rQfcL/e8ymZDeWUdM4+G7qAp3GWpKYBW4TZvJCKAFDZJdT9fyGGewo6AoHVgAO7jsVIi8rqUTeWPf4G22vAMdlKG9JblZAMGYsFq8+iLFZtCKFNf8t0qpCk82Lgj3nfq7NE8RApAqSEmeIe30z2z8/1TjyVLpvFz1CxK3Tj8HgCtFv1GoPUJ784Ki+oJfVrUsl+n86HpnDAImsLzn3SeIYe4A3Pd0FmVyHFrndonnIM4TnLcHboetz//rpEyfR3HJIcHGo6toZRKMiuhdciy3hlAaYXxgxNbTBPpPDJFbFhnvH9uuMDz7g4FNcpx/u4r9/uSMiidMazsSmlhMkx35QrJRQ2hOz0eIBHnvQtTTVAbKC+J4oNL1ksgpfulogxrsjUNhFgjdv70BY85AFsxPziCMrGtNA1aW81Z690n4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jnGsR2U8F1RexY0kktASNoaoJqZxGw/yOWuKFIqD2Z+KsXuJV+YgQxHFEWRv?=
 =?us-ascii?Q?We2XPtHOt4+v6jJrJp9iaycXLReBpXosgnxoamp4IEafUhH9KCBcfZFS/JHa?=
 =?us-ascii?Q?AdIonW5hOj5sjy7fIG7t6kMMOu6xMu4k5K6dNGU3AFLTH48cP9jbsW6xTYjF?=
 =?us-ascii?Q?eGEImqLgYzj8B80e8UizevKRRdStXvNNHKOhXCYVsfvMjtgK074s1sUqLh9K?=
 =?us-ascii?Q?IYCIt7gDkNyR8sr7A5cltxd9IE0gbSEn71C7H6EOm++gJj7WDnxjPJsQrhxc?=
 =?us-ascii?Q?32MvOOz0QaMS8oObeVoSaK/HsFCfSBXJFYo+0Oa2NAQRd3RkeYSVaTx6V2jb?=
 =?us-ascii?Q?7kRt601JrbPB3nAFFPOlKaK/K7f84qpShX7dKEIolphdOi35nDeXL4tL8reT?=
 =?us-ascii?Q?Nc4nJw9PFCcX/sOFRwVQh6frqMl2fUjKe98deyPMpi3W0893RUDF9Pa4TaSa?=
 =?us-ascii?Q?WoSFXICfREqhPdjFXbQRicWe5Len91YfY+PJDkJTkD05w71sO0xZ3vdZdLa4?=
 =?us-ascii?Q?XymAZAaE0uOztMiTnoNXaLidhSrepbuOyInJmuUetW688/BEWP4SejoQcvvF?=
 =?us-ascii?Q?gqYER24F8xIKbBi8SpxmvJrdt3k40qVZhVA8cwC1+Hj54P7ZuWg26brWv2Sq?=
 =?us-ascii?Q?PMI5ul5Q1pwUaMS5R51Y9/k6cYczn8dKLsscm+WOBsZ5F5QhjftPmkfIS7+T?=
 =?us-ascii?Q?X0GtGQ/9dbgsm5YOGXkKoT8MFpxAn2xa2UROSUsLOtCXskgQU+tssy1zl3YF?=
 =?us-ascii?Q?YW3qSv4mfU+qIZW2ym0KOnYAwzAz1bcMYimZxqB+0bDNJFA8dskWDmWRMIz9?=
 =?us-ascii?Q?/MAqqdHySpGHE2R/LbJBWAdI/nFc46HDVYyHezXOOHu+Yp8Po06jMbkjl4ae?=
 =?us-ascii?Q?Leowque/Esk8B/6axeiqTLa8L6ASj6862BxBP3VL8lIbSRs+2yXBPWIp/3dS?=
 =?us-ascii?Q?rtp0FJt2suPNTmf3RRuaZBQZCvFaIWS55lATua8yUksv/KyzLdLGuT5qOicn?=
 =?us-ascii?Q?LMAFWljmH5e/19vSLU1IlmxRoLGGO722qL1ny/yox7t2M9YQwf2t95RjYkzL?=
 =?us-ascii?Q?ac41G0l3BJw06cK0d8X2YNsi2bUuMyU1ZrTDp9HVB0rz2yA77iZCsSpazR6R?=
 =?us-ascii?Q?JAQPSnaTGZihapAx6jbR6O6a7kg/VdDYDK09ORfcJLEUQ1+9QqrCpAN+Wd2a?=
 =?us-ascii?Q?Fk743ZzpAT97lMFNHKTMhrj9xEcWdXGL6droF9rc2V2pt8cpYBlApB0KJU6L?=
 =?us-ascii?Q?m6lBQVSut/9qJXagqiXNOnDLCBdGKwljZgcVAD5xigKiX1evFYzqvJaK3c0y?=
 =?us-ascii?Q?xSu9PM/3D6RwZr1fIqlvtPHJHHxsNdiYkQlRK5zh0glxoulGNJN2T3hGIz0u?=
 =?us-ascii?Q?U2YXpIIT9H88tjt+NnlBwsyaDMQqUvBu3uNdR7juUYBZnvWr2SNrff6D3RA9?=
 =?us-ascii?Q?geGb9T9hO7XqoR8PAwVjRyCesCdYtPmGee2fROFNZC7DwVAxFzr3txt2TanG?=
 =?us-ascii?Q?sQMlakM6APs6tzGGcz/7mZqmOKifMEocjWjNd+z9DmbKLrxijfkCc0zcqrRv?=
 =?us-ascii?Q?/KRoi6xzsQ6GNoQVHxKl5+YrBp4v7t6FjRTAZtAmw+aiP6draxswyOj6ylg8?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5831aebc-8746-41c6-d899-08dc401531cd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 08:44:55.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RxYZYq32jBDPOT1SADG6N6RymE1ETUxqxJhVPHNuqCqfJapfnQ9MiL5H1o46+Wgz5K+eD0OrpXrAYZxJDHY9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

Multiple network devices that support hardware timestamping appear to have
common behavior with regards to timestamp handling. Implement common Tx
hardware timestamping statistics in a tx_stats struct_group. Common Rx
hardware timestamping statistics can subsequently be implemented in a
rx_stats struct_group for ethtool_ts_stats.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 Documentation/netlink/specs/ethtool.yaml | 20 +++++++++
 include/linux/ethtool.h                  | 21 ++++++++++
 include/uapi/linux/ethtool_netlink.h     | 15 +++++++
 net/ethtool/tsinfo.c                     | 52 +++++++++++++++++++++++-
 4 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..f99b003c78c0 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -559,6 +559,21 @@ attribute-sets:
       -
         name: tx-lpi-timer
         type: u32
+  -
+    name: ts-stat
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: tx-pkts
+        type: u64
+      -
+        name: tx-lost
+        type: u64
+      -
+        name: tx-err
+        type: u64
   -
     name: tsinfo
     attributes:
@@ -581,6 +596,10 @@ attribute-sets:
       -
         name: phc-index
         type: u32
+      -
+        name: stats
+        type: nest
+        nested-attributes: ts-stat
   -
     name: cable-result
     attributes:
@@ -1388,6 +1407,7 @@ operations:
             - tx-types
             - rx-filters
             - phc-index
+            - stats
       dump: *tsinfo-get-op
     -
       name: cable-test-act
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index b90c33607594..a1704938a6fb 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -483,6 +483,24 @@ struct ethtool_rmon_stats {
 	);
 };
 
+/**
+ * struct ethtool_ts_stats - HW timestamping statistics
+ * @tx_stats: struct group for TX HW timestamping
+ *	@pkts: Number of packets successfully timestamped by the queried
+ *	      layer.
+ *	@lost: Number of packet timestamps that failed to get applied on a
+ *	      packet by the queried layer.
+ *	@err: Number of timestamping errors that occurred on the queried
+ *	     layer.
+ */
+struct ethtool_ts_stats {
+	struct_group(tx_stats,
+		u64 pkts;
+		u64 lost;
+		u64 err;
+	);
+};
+
 #define ETH_MODULE_EEPROM_PAGE_LEN	128
 #define ETH_MODULE_MAX_I2C_ADDRESS	0x7f
 
@@ -759,6 +777,7 @@ struct ethtool_rxfh_param {
  *	It may be called with RCU, or rtnl or reference on the device.
  *	Drivers supporting transmit time stamps in software should set this to
  *	ethtool_op_get_ts_info().
+ * @get_ts_stats: Query the device hardware timestamping statistics.
  * @get_module_info: Get the size and type of the eeprom contained within
  *	a plug-in module.
  * @get_module_eeprom: Get the eeprom information from the plug-in module
@@ -901,6 +920,8 @@ struct ethtool_ops {
 				 struct ethtool_dump *, void *);
 	int	(*set_dump)(struct net_device *, struct ethtool_dump *);
 	int	(*get_ts_info)(struct net_device *, struct ethtool_ts_info *);
+	void	(*get_ts_stats)(struct net_device *dev,
+				struct ethtool_ts_stats *ts_stats);
 	int     (*get_module_info)(struct net_device *,
 				   struct ethtool_modinfo *);
 	int     (*get_module_eeprom)(struct net_device *,
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 3f89074aa06c..046a78d9421d 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -478,12 +478,27 @@ enum {
 	ETHTOOL_A_TSINFO_TX_TYPES,			/* bitset */
 	ETHTOOL_A_TSINFO_RX_FILTERS,			/* bitset */
 	ETHTOOL_A_TSINFO_PHC_INDEX,			/* u32 */
+	ETHTOOL_A_TSINFO_STATS,				/* nest - _A_TSINFO_STAT */
 
 	/* add new constants above here */
 	__ETHTOOL_A_TSINFO_CNT,
 	ETHTOOL_A_TSINFO_MAX = (__ETHTOOL_A_TSINFO_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_TS_STAT_UNSPEC,
+	ETHTOOL_A_TS_STAT_PAD,
+
+	ETHTOOL_A_TS_STAT_TX_PKT,			/* array, u64 */
+	ETHTOOL_A_TS_STAT_TX_LOST,			/* array, u64 */
+	ETHTOOL_A_TS_STAT_TX_ERR,			/* array, u64 */
+
+	/* add new constants above here */
+	__ETHTOOL_A_TS_STAT_CNT,
+	ETHTOOL_A_TS_STAT_MAX = (__ETHTOOL_A_TS_STAT_CNT - 1)
+
+};
+
 /* PHC VCLOCKS */
 
 enum {
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index 9daed0aab162..0d1370ded122 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -13,14 +13,18 @@ struct tsinfo_req_info {
 struct tsinfo_reply_data {
 	struct ethnl_reply_data		base;
 	struct ethtool_ts_info		ts_info;
+	struct ethtool_ts_stats		stats;
 };
 
 #define TSINFO_REPDATA(__reply_base) \
 	container_of(__reply_base, struct tsinfo_reply_data, base)
 
+#define ETHTOOL_TS_STAT_CNT \
+	(__ETHTOOL_A_TS_STAT_CNT - (ETHTOOL_A_TS_STAT_PAD + 1))
+
 const struct nla_policy ethnl_tsinfo_get_policy[] = {
 	[ETHTOOL_A_TSINFO_HEADER]		=
-		NLA_POLICY_NESTED(ethnl_header_policy),
+		NLA_POLICY_NESTED(ethnl_header_policy_stats),
 };
 
 static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
@@ -34,6 +38,12 @@ static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
+	if (req_base->flags & ETHTOOL_FLAG_STATS &&
+	    dev->ethtool_ops->get_ts_stats) {
+		ethtool_stats_init((u64 *)&data->stats,
+				   sizeof(data->stats) / sizeof(u64));
+		dev->ethtool_ops->get_ts_stats(dev, &data->stats);
+	}
 	ret = __ethtool_get_ts_info(dev, &data->ts_info);
 	ethnl_ops_complete(dev);
 
@@ -79,10 +89,47 @@ static int tsinfo_reply_size(const struct ethnl_req_info *req_base,
 	}
 	if (ts_info->phc_index >= 0)
 		len += nla_total_size(sizeof(u32));	/* _TSINFO_PHC_INDEX */
+	if (req_base->flags & ETHTOOL_FLAG_STATS)
+		len += nla_total_size(0) + /* _TSINFO_STATS */
+		       nla_total_size_64bit(sizeof(u64)) * ETHTOOL_TS_STAT_CNT;
 
 	return len;
 }
 
+static int tsinfo_put_stat(struct sk_buff *skb, u64 val, u16 attrtype)
+{
+	if (val == ETHTOOL_STAT_NOT_SET)
+		return 0;
+	if (nla_put_u64_64bit(skb, attrtype, val, ETHTOOL_A_TS_STAT_PAD))
+		return -EMSGSIZE;
+	return 0;
+}
+
+static int tsinfo_put_stats(struct sk_buff *skb,
+			    const struct ethtool_ts_stats *stats)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, ETHTOOL_A_TSINFO_STATS);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (tsinfo_put_stat(skb, stats->tx_stats.pkts,
+			    ETHTOOL_A_TS_STAT_TX_PKT) ||
+	    tsinfo_put_stat(skb, stats->tx_stats.lost,
+			    ETHTOOL_A_TS_STAT_TX_LOST) ||
+	    tsinfo_put_stat(skb, stats->tx_stats.err,
+			    ETHTOOL_A_TS_STAT_TX_ERR))
+		goto err_cancel;
+
+	nla_nest_end(skb, nest);
+	return 0;
+
+err_cancel:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
 static int tsinfo_fill_reply(struct sk_buff *skb,
 			     const struct ethnl_req_info *req_base,
 			     const struct ethnl_reply_data *reply_base)
@@ -119,6 +166,9 @@ static int tsinfo_fill_reply(struct sk_buff *skb,
 	if (ts_info->phc_index >= 0 &&
 	    nla_put_u32(skb, ETHTOOL_A_TSINFO_PHC_INDEX, ts_info->phc_index))
 		return -EMSGSIZE;
+	if (req_base->flags & ETHTOOL_FLAG_STATS &&
+	    tsinfo_put_stats(skb, &data->stats))
+		return -EMSGSIZE;
 
 	return 0;
 }
-- 
2.42.0


