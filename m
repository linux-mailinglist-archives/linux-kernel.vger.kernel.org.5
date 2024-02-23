Return-Path: <linux-kernel+bounces-79025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F6E861C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697CA1F24A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF914938C;
	Fri, 23 Feb 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UY3hKYOc"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646251448FF;
	Fri, 23 Feb 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716451; cv=fail; b=HmOdSlWe0FZgyymJflSzgeQbJn6YSTl6Oce6zaTfVVv4XAssVTSCSL4SmzQVE3WPM9ZAxIcv0UPRhXJIvs7bhANyrHzludOoUqP/rPFm2BE/RUQmLTFIfOzLnqBc9ruo3MNpvREUzvpCtUykrKlLz1AfVHP53Kh1EPKgywJJ9NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716451; c=relaxed/simple;
	bh=8feHoYxZ3rNCGgZZnsZp9789s2w9BBLP2QJSpFPp+3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taV/rKewHloqkjgQ/9mX1WfVD4IAN68xAXSSoJk3qQr5zkVftuKX81vnHcIpCR4RrOosFFnkxEPAU/eReM+d8Jxk8APR/kUaPMNl48blwJBxNmozrpepjDBzl41pTuGW/sJDAx7Fk2AZq9kToK1PWJDyeCWu/IZcvXWI3XhtTto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UY3hKYOc; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsCsAl+MIRYFQDLHUJrqpZGY11WXD5jevSP3R3sBIMg/xDHjVtI+VSMoL5IzCJ3A5MRyY/TewRFvyXvTop0d7KlvI1dr9kUVtUw5T4u3rGglh3/aYNQCoq25PNSClZARnFrZqJOb924oOKAL+mZr02rKH5IRp6IGGMlBdIlxHcPSoRHn6nCjXrQp+1giZ8tYXgQNIDKYpRda5bDqZXUUWwt0O7XaH1sk704g1TX3lcnLfsTBce+ilic9ebw7pZUgWxSUsEtWRFHbA41Q05jnL3kXqlwPrTNEIf6X8rh3HrKHM2z5I4yNdnu9Q3U/1TvH1IGBA04CgAVuNEB5oEr7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY4V+/ZWqhCEoAtnGgwFCeXOMeEt8vzUV5T+ws0Os3A=;
 b=QEY9OizVbAPrv3YecGppTYV0lQi9zz4jaQ1jNwRa80Z8fL7KJEizpTChta2JgvsjHHcKToofZqEOdKLh3Z8Jsv58tSLidVsa5us371RVI1L1EDReg6ZCyDGq3xwVHCCy2KPWGDF2Fb+Nk1GAd+zPFrvt9abddqNP3rt8ICDDNjMtwy0ZRhc2g4HqXYEhE02MQB1WEG/i63lKsAf0FWLTkSv9Ctbj/Ag8PV+mzCn0rA17veYIrpS6s8gyVy7f817tcdTYJDrG/0dnWyluCqECq89VgUSbPSSsnLtwnMq4QRdMB+znAHg9BH6TRQOtLjGmUAhltTHdFlkWb3CPzwJY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY4V+/ZWqhCEoAtnGgwFCeXOMeEt8vzUV5T+ws0Os3A=;
 b=UY3hKYOcXTEp6yTQvg3wubEXkhErXbPC6FrsShgiPYQfQ76PYms4nAcjbzAPPEfpmbpCrLNFl9lRSymXBNYW+KHYEZMkR0EbfTmUwK9fbvQNYzaRIokgO7nHQ2O8HluWqDfuiXa/B+WT1eJ8IIRgHA+JkqLkzPwatu4bfmx4H2zmAmQEY9zljeOEn5K7CqbbOxWAtR+rGmvEhoD2i7f4RGI//TSOucdJFckeHVx/61rQlwPbPx84QNrYfG7SXPziCMix7Ic7aGiuWohleZ7ZUgkokw/5o+S7oybSbO1xFrIrEU0GlNpKh8qD3gvl+GeJia9jWORkQ9EPaQjeFB8CMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Fri, 23 Feb
 2024 19:27:18 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:27:18 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx hardware timestamping statistics
Date: Fri, 23 Feb 2024 11:24:45 -0800
Message-ID: <20240223192658.45893-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223192658.45893-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::16) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9905dc9c-8e0a-4f7c-795b-08dc34a572ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	II2DtvgiUm/1V82zgAyawl48ynWKP6lwQlAMYRaV4gZOB4HiFuYlksRRq/6C9ZnC6JZAnK9nrHLkgt2dDK8pZsQY6dZG/hxRRBbwPI8dj0L4QOJNQnqIxjG4RvfHgQkd8vkvbMLOH9gGJ7DaO6+FPMJEILCnyQ6tRRGfd4eG19t1mtLg15LmQQNZk3712SkJCx2p6YTpDr2kYOmV3v1K0kUq2TOIsMNJ9XmvY9zOKmI3nc2WMQafbamjctxj+dw6Pyl684oxywEaphrWJeGMXfmT8njAQF9BNx9jTcQtC04URIys/JlFulr8BMj/NIZqw32eqD0ZJuUUp4du5/0fvm8HfTvMcObyyGzUnymS7Rm8updlLEN1P1K1+X7UEjib0Pv9RhG8p1ifQa7uoyVBxzDlXHbBTLpittIYUZpVfvP+AbP4t36WlfADqAOJYDNsKyv9AI8ejTKp/b2YAGxwHkrCcrFrmyK4uTuvgrLQmMPdhymzfSKE3c7rrGZRvM3EOeoKZNX6CsLTWaFAEOQo/a5p35a9Fa1EiiwYfO8Lhexapp9C9+b+A5GbDqL9vzYkz+U73feyONFPGkGcW0al0YiD3+i3vmOl8lmAJxkE4GM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?axrlAjToC0YPhqIQVE3xF3RkieH4b6Ug/iPXYtrWZROXw4wHNZYCh8kUyy1d?=
 =?us-ascii?Q?/p0+mKaokQbiiD6UFp5eZBH2OCflnl9BjzSL/uePJXkFGM8gzXpgUPF+CMW3?=
 =?us-ascii?Q?vm+GtfigTuAyegxE5ZmpV92Z3BOjGpYqKvQ79Su6ROhSxxE3fMwmkte5sNro?=
 =?us-ascii?Q?besa80r+/l4irztpG7R+nRMa9LD8r1xynnv2fXEC7uhtAECz9wb73wbWKCZW?=
 =?us-ascii?Q?aZxzr9XGfz/AqgYTiOVeUHVDNt2GIDkwQF5m9HOSNEmBjiSwOj7MojU05b4r?=
 =?us-ascii?Q?AaRNGThg5wrHMvZ4ATPvbtAQmp9Sr74DWGqlB7supUH3erCdaKSMLZAsAtth?=
 =?us-ascii?Q?H1l1cOyHqIvOPXMDlroecibms3afYDGgjgyWjeddSjaXg9POtPlNCSzziUic?=
 =?us-ascii?Q?baGKDXRoXJc1pVn0Q9zwgnwQ9Ewxy0C6BDbZuqN1qBBqKUztGXk1qw9wThID?=
 =?us-ascii?Q?RPID+X6LCln/RGlpxOGuYUTY43PzPqVLzxgTXiXE9e5mJ+2j1znNZFTaqF+o?=
 =?us-ascii?Q?HTrgDyjMhK9IVYSSE3jjF3smfk5VuuGUGxDqp6tKtZ+4+PklfMxgfoHRqnOo?=
 =?us-ascii?Q?dT/rkKQ1MaAsdjjWe4J3/7u8vyiEltFCvH+DSxwMy+/VARQl74z+nTCaKzoJ?=
 =?us-ascii?Q?RB/jyzQbfH9RiuCXfvNooPsJ4oSs6CB21hbwkjPYd57+Bp2Q9ZUN3ZsSK/VZ?=
 =?us-ascii?Q?hIajm+98sDdxER9fy8OgDVdsDnn5pU6IhjUGvjxaoBt4X934VT/0ItTPuHnI?=
 =?us-ascii?Q?sIhqHktVrflAcFFEebUWEw70If8nTAMSg/Ajffrbh6GWUzdbBj4POzlmQWts?=
 =?us-ascii?Q?u/jxvshcLoyL0jJclHy62jWmaB2odLqjc/uUWx9zllfjnVD+o9sXJ4VaCuYw?=
 =?us-ascii?Q?I/4U22q28Fz6ySMWTjYLP8PT4aLGEijJ81NyarBuyf6KvkrwcxtWzZuZ6Bdk?=
 =?us-ascii?Q?1n5TnHqdo7KEjqr+yqbU9eCxPZpqxbru9sfx9S+oo4Z8Rq7q0XRyd2wxgxJt?=
 =?us-ascii?Q?7+IUkEMoHkj/+Fp9PZuvX2573r7mkJB80DCJDdVAkwIhmzlT4Y5eVbqxQLzr?=
 =?us-ascii?Q?Als9v+XOaffmXu04WoqjBo7eFr8gsdLqvN97zIi1XuE99bj+Ux1gCpe1KhQH?=
 =?us-ascii?Q?/qkJdiIpcbe9B1rth1Z9v9dgajn67d8H38IKy36oyEpKghYKnVNRHZdi3CNb?=
 =?us-ascii?Q?zn44hPxtNTL5nBN8qqdk6qrmjVd1hc7npTuJhF2+4WF3ilKKr9gCVutrZfdh?=
 =?us-ascii?Q?G1L7h4KwqkFtEC0TqlSXPhtTspSa9LnaMAELrcEvS7vXud1fIji1dbIyTaRO?=
 =?us-ascii?Q?bUYP6/3odJy/deK2B+NGpLaSaeKeZurRdQ7VoqcGonAi/NRoCz/FzT97o5eC?=
 =?us-ascii?Q?BkK5hzwNLL2LXNxDggLBNDpuolBEWYgoNIxjYymgwCGdbCvzr2mx7t0E1IlV?=
 =?us-ascii?Q?fNl6rBrFJdk6WR84WkU3dm/++fWxkAL+HND/Y/Mgjrdy8ih+CKpRT2axYjuS?=
 =?us-ascii?Q?qgxSPXthTvs6zQ3mb1xXeF/s6SRUNk4xhumxdGHurnLyxo15tc2vd62o6LVp?=
 =?us-ascii?Q?uuBqy66AsRWTp0ihW8EmmaZhqg/4aEJ6HnG+5UWHxNbZUPEkaL2rjt6q/6KD?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9905dc9c-8e0a-4f7c-795b-08dc34a572ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:27:17.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjpl8+e8rmjyKUhCQvkZ5XCgkESO98dqz4q39Q+alx7AosbaF5JMZvGZu2w2h5xLep1QASgoevdZMd44uwqPxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831

Multiple network devices that support hardware timestamping appear to have
common behavior with regards to timestamp handling. Implement common Tx
hardware timestamping statistics in a tx_stats struct_group. Common Rx
hardware timestamping statistics can subsequently be implemented in a
rx_stats struct_group for ethtool_ts_stats.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 include/linux/ethtool.h              | 28 +++++++++++++++
 include/uapi/linux/ethtool.h         | 20 +++++++++++
 include/uapi/linux/ethtool_netlink.h | 17 +++++++++
 net/ethtool/netlink.h                |  3 +-
 net/ethtool/stats.c                  | 53 +++++++++++++++++++++++++---
 net/ethtool/strset.c                 |  5 +++
 6 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index b90c33607594..1cc1010afaca 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -483,6 +483,31 @@ struct ethtool_rmon_stats {
 	);
 };
 
+/**
+ * struct ethtool_ts_stats - HW timestamping statistics
+ * @layer: input field denoting whether stats should be queried from the DMA or
+ *        PHY timestamping layer. Defaults to the active layer for packet
+ *        timestamping.
+ * @tx_stats: struct group for TX HW timestamping
+ *	@pkts: Number of packets successfully timestamped by the queried
+ *	      layer.
+ *	@lost: Number of packet timestamps that failed to get applied on a
+ *	      packet by the queried layer.
+ *	@late: Number of packet timestamps that were delivered by the
+ *	      hardware but were lost due to arriving too late.
+ *	@err: Number of timestamping errors that occurred on the queried
+ *	     layer.
+ */
+struct ethtool_ts_stats {
+	enum ethtool_ts_stats_layer layer;
+	struct_group(tx_stats,
+		u64 pkts;
+		u64 lost;
+		u64 late;
+		u64 err;
+	);
+};
+
 #define ETH_MODULE_EEPROM_PAGE_LEN	128
 #define ETH_MODULE_MAX_I2C_ADDRESS	0x7f
 
@@ -807,6 +832,7 @@ struct ethtool_rxfh_param {
  * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.
  * @get_rmon_stats: Query some of the RMON (RFC 2819) statistics.
  *	Set %ranges to a pointer to zero-terminated array of byte ranges.
+ * @get_eth_ts_stats: Query the device hardware timestamping statistics.
  * @get_module_power_mode: Get the power mode policy for the plug-in module
  *	used by the network device and its operational power mode, if
  *	plugged-in.
@@ -943,6 +969,8 @@ struct ethtool_ops {
 	void	(*get_rmon_stats)(struct net_device *dev,
 				  struct ethtool_rmon_stats *rmon_stats,
 				  const struct ethtool_rmon_hist_range **ranges);
+	void	(*get_ts_stats)(struct net_device *dev,
+				    struct ethtool_ts_stats *ts_stats);
 	int	(*get_module_power_mode)(struct net_device *dev,
 					 struct ethtool_module_power_mode_params *params,
 					 struct netlink_ext_ack *extack);
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 06ef6b78b7de..39edae554fc5 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -681,6 +681,7 @@ enum ethtool_link_ext_substate_module {
  * @ETH_SS_STATS_ETH_MAC: names of IEEE 802.3 MAC statistics
  * @ETH_SS_STATS_ETH_CTRL: names of IEEE 802.3 MAC Control statistics
  * @ETH_SS_STATS_RMON: names of RMON statistics
+ * @ETH_SS_STATS_TS: names of hardware timestamping statistics
  *
  * @ETH_SS_COUNT: number of defined string sets
  */
@@ -706,6 +707,7 @@ enum ethtool_stringset {
 	ETH_SS_STATS_ETH_MAC,
 	ETH_SS_STATS_ETH_CTRL,
 	ETH_SS_STATS_RMON,
+	ETH_SS_STATS_TS,
 
 	/* add new constants above here */
 	ETH_SS_COUNT
@@ -1462,6 +1464,24 @@ struct ethtool_ts_info {
 	__u32	rx_reserved[3];
 };
 
+/**
+ * enum ethtool_ts_stats_layer - layer to query hardware timestamping statistics
+ * @ETHTOOL_TS_STATS_LAYER_ACTIVE:
+ *	retrieve the statistics from the layer that is currently feeding
+ *	hardware timestamps for packets.
+ * @ETHTOOL_TS_STATS_LAYER_DMA:
+ *	retrieve the statistics from the DMA hardware timestamping layer of the
+ *	device.
+ * @ETHTOOL_TS_STATS_PHY:
+ *	retrieve the statistics from the PHY hardware timestamping layer of the
+ *	device.
+ */
+enum ethtool_ts_stats_layer {
+	ETHTOOL_TS_STATS_LAYER_ACTIVE,
+	ETHTOOL_TS_STATS_LAYER_DMA,
+	ETHTOOL_TS_STATS_LAYER_PHY,
+};
+
 /*
  * %ETHTOOL_SFEATURES changes features present in features[].valid to the
  * values of corresponding bits in features[].requested. Bits in .requested
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 3f89074aa06c..55f2a3c8caa0 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -749,6 +749,7 @@ enum {
 	ETHTOOL_A_STATS_GRP,			/* nest - _A_STATS_GRP_* */
 
 	ETHTOOL_A_STATS_SRC,			/* u32 */
+	ETHTOOL_A_STATS_LAYER,			/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_STATS_CNT,
@@ -760,6 +761,7 @@ enum {
 	ETHTOOL_STATS_ETH_MAC,
 	ETHTOOL_STATS_ETH_CTRL,
 	ETHTOOL_STATS_RMON,
+	ETHTOOL_STATS_TS,
 
 	/* add new constants above here */
 	__ETHTOOL_STATS_CNT
@@ -875,6 +877,21 @@ enum {
 	ETHTOOL_A_STATS_RMON_MAX = (__ETHTOOL_A_STATS_RMON_CNT - 1)
 };
 
+enum {
+	/* hwTimestampingTxPkts */
+	ETHTOOL_A_STATS_TS_TX_PKT,
+	/* hwTimestampingTxLost */
+	ETHTOOL_A_STATS_TS_TX_LOST,
+	/* hwTimestampingTxLate */
+	ETHTOOL_A_STATS_TS_TX_LATE,
+	/* hwTimestampingTxErrors */
+	ETHTOOL_A_STATS_TS_TX_ERRORS,
+
+	/* add new constants above here */
+	__ETHTOOL_A_STATS_TS_CNT,
+	ETHTOOL_A_STATS_TS_MAX = (__ETHTOOL_A_STATS_TS_CNT - 1)
+};
+
 /* MODULE */
 
 enum {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 9a333a8d04c1..962ecd62aeea 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -429,7 +429,7 @@ extern const struct nla_policy ethnl_tunnel_info_get_policy[ETHTOOL_A_TUNNEL_INF
 extern const struct nla_policy ethnl_fec_get_policy[ETHTOOL_A_FEC_HEADER + 1];
 extern const struct nla_policy ethnl_fec_set_policy[ETHTOOL_A_FEC_AUTO + 1];
 extern const struct nla_policy ethnl_module_eeprom_get_policy[ETHTOOL_A_MODULE_EEPROM_I2C_ADDRESS + 1];
-extern const struct nla_policy ethnl_stats_get_policy[ETHTOOL_A_STATS_SRC + 1];
+extern const struct nla_policy ethnl_stats_get_policy[__ETHTOOL_A_STATS_CNT];
 extern const struct nla_policy ethnl_phc_vclocks_get_policy[ETHTOOL_A_PHC_VCLOCKS_HEADER + 1];
 extern const struct nla_policy ethnl_module_get_policy[ETHTOOL_A_MODULE_HEADER + 1];
 extern const struct nla_policy ethnl_module_set_policy[ETHTOOL_A_MODULE_POWER_MODE_POLICY + 1];
@@ -454,5 +454,6 @@ extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING
 extern const char stats_eth_mac_names[__ETHTOOL_A_STATS_ETH_MAC_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_ctrl_names[__ETHTOOL_A_STATS_ETH_CTRL_CNT][ETH_GSTRING_LEN];
 extern const char stats_rmon_names[__ETHTOOL_A_STATS_RMON_CNT][ETH_GSTRING_LEN];
+extern const char stats_ts_names[__ETHTOOL_A_STATS_TS_CNT][ETH_GSTRING_LEN];
 
 #endif /* _NET_ETHTOOL_NETLINK_H */
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 912f0c4fff2f..e4333d77fb31 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -8,6 +8,7 @@ struct stats_req_info {
 	struct ethnl_req_info		base;
 	DECLARE_BITMAP(stat_mask, __ETHTOOL_STATS_CNT);
 	enum ethtool_mac_stats_src	src;
+	enum ethtool_ts_stats_layer	layer;
 };
 
 #define STATS_REQINFO(__req_base) \
@@ -20,6 +21,7 @@ struct stats_reply_data {
 		struct ethtool_eth_mac_stats	mac_stats;
 		struct ethtool_eth_ctrl_stats	ctrl_stats;
 		struct ethtool_rmon_stats	rmon_stats;
+		struct ethtool_ts_stats		ts_stats;
 	);
 	const struct ethtool_rmon_hist_range	*rmon_ranges;
 };
@@ -32,6 +34,7 @@ const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_STATS_ETH_MAC]			= "eth-mac",
 	[ETHTOOL_STATS_ETH_CTRL]		= "eth-ctrl",
 	[ETHTOOL_STATS_RMON]			= "rmon",
+	[ETHTOOL_STATS_TS]			= "ts",
 };
 
 const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN] = {
@@ -76,18 +79,27 @@ const char stats_rmon_names[__ETHTOOL_A_STATS_RMON_CNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_A_STATS_RMON_JABBER]		= "etherStatsJabbers",
 };
 
-const struct nla_policy ethnl_stats_get_policy[ETHTOOL_A_STATS_SRC + 1] = {
-	[ETHTOOL_A_STATS_HEADER]	=
-		NLA_POLICY_NESTED(ethnl_header_policy),
-	[ETHTOOL_A_STATS_GROUPS]	= { .type = NLA_NESTED },
-	[ETHTOOL_A_STATS_SRC]		=
+const char stats_ts_names[__ETHTOOL_A_STATS_TS_CNT][ETH_GSTRING_LEN] = {
+	[ETHTOOL_A_STATS_TS_TX_PKT]		= "hwTimestampingTxPkts",
+	[ETHTOOL_A_STATS_TS_TX_LOST]		= "hwTimestampingTxLost",
+	[ETHTOOL_A_STATS_TS_TX_LATE]		= "hwTimestampingTxLate",
+	[ETHTOOL_A_STATS_TS_TX_ERRORS]		= "hwTimestampingTxErrors",
+};
+
+const struct nla_policy ethnl_stats_get_policy[__ETHTOOL_A_STATS_CNT] = {
+	[ETHTOOL_A_STATS_HEADER] = NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_STATS_GROUPS] = { .type = NLA_NESTED },
+	[ETHTOOL_A_STATS_SRC] =
 		NLA_POLICY_MAX(NLA_U32, ETHTOOL_MAC_STATS_SRC_PMAC),
+	[ETHTOOL_A_STATS_LAYER] =
+		NLA_POLICY_MAX(NLA_U32, ETHTOOL_TS_STATS_LAYER_PHY),
 };
 
 static int stats_parse_request(struct ethnl_req_info *req_base,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
+	enum ethtool_ts_stats_layer layer = ETHTOOL_TS_STATS_LAYER_ACTIVE;
 	enum ethtool_mac_stats_src src = ETHTOOL_MAC_STATS_SRC_AGGREGATE;
 	struct stats_req_info *req_info = STATS_REQINFO(req_base);
 	bool mod = false;
@@ -104,9 +116,12 @@ static int stats_parse_request(struct ethnl_req_info *req_base,
 		return -EINVAL;
 	}
 
+	if (tb[ETHTOOL_A_STATS_LAYER])
+		layer = nla_get_u32(tb[ETHTOOL_A_STATS_LAYER]);
 	if (tb[ETHTOOL_A_STATS_SRC])
 		src = nla_get_u32(tb[ETHTOOL_A_STATS_SRC]);
 
+	req_info->layer = layer;
 	req_info->src = src;
 
 	return 0;
@@ -118,6 +133,7 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 {
 	const struct stats_req_info *req_info = STATS_REQINFO(req_base);
 	struct stats_reply_data *data = STATS_REPDATA(reply_base);
+	enum ethtool_ts_stats_layer layer = req_info->layer;
 	enum ethtool_mac_stats_src src = req_info->src;
 	struct net_device *dev = reply_base->dev;
 	int ret;
@@ -144,6 +160,7 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	data->mac_stats.src = src;
 	data->ctrl_stats.src = src;
 	data->rmon_stats.src = src;
+	data->ts_stats.layer = layer;
 
 	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
 	    dev->ethtool_ops->get_eth_phy_stats)
@@ -158,6 +175,9 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	    dev->ethtool_ops->get_rmon_stats)
 		dev->ethtool_ops->get_rmon_stats(dev, &data->rmon_stats,
 						 &data->rmon_ranges);
+	if (test_bit(ETHTOOL_STATS_TS, req_info->stat_mask) &&
+	    dev->ethtool_ops->get_ts_stats)
+		dev->ethtool_ops->get_ts_stats(dev, &data->ts_stats);
 
 	ethnl_ops_complete(dev);
 	return 0;
@@ -194,6 +214,10 @@ static int stats_reply_size(const struct ethnl_req_info *req_base,
 			nla_total_size(4)) *	/* _A_STATS_GRP_HIST_BKT_HI */
 			ETHTOOL_RMON_HIST_MAX * 2;
 	}
+	if (test_bit(ETHTOOL_STATS_TS, req_info->stat_mask)) {
+		n_stats += sizeof(struct ethtool_ts_stats) / sizeof(u64);
+		n_grps++;
+	}
 
 	len += n_grps * (nla_total_size(0) + /* _A_STATS_GRP */
 			 nla_total_size(4) + /* _A_STATS_GRP_ID */
@@ -370,6 +394,22 @@ static int stats_put_rmon_stats(struct sk_buff *skb,
 	return 0;
 }
 
+static int stats_put_ts_stats(struct sk_buff *skb,
+			      const struct stats_reply_data *data)
+{
+	if (stat_put(skb, ETHTOOL_A_STATS_TS_TX_PKT,
+		     data->ts_stats.pkts) ||
+	    stat_put(skb, ETHTOOL_A_STATS_TS_TX_LOST,
+		     data->ts_stats.lost) ||
+	    stat_put(skb, ETHTOOL_A_STATS_TS_TX_LATE,
+		     data->ts_stats.late) ||
+	    stat_put(skb, ETHTOOL_A_STATS_TS_TX_ERRORS,
+		     data->ts_stats.err))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int stats_put_stats(struct sk_buff *skb,
 			   const struct stats_reply_data *data,
 			   u32 id, u32 ss_id,
@@ -423,6 +463,9 @@ static int stats_fill_reply(struct sk_buff *skb,
 	if (!ret && test_bit(ETHTOOL_STATS_RMON, req_info->stat_mask))
 		ret = stats_put_stats(skb, data, ETHTOOL_STATS_RMON,
 				      ETH_SS_STATS_RMON, stats_put_rmon_stats);
+	if (!ret && test_bit(ETHTOOL_STATS_TS, req_info->stat_mask))
+		ret = stats_put_stats(skb, data, ETHTOOL_STATS_TS,
+				      ETH_SS_STATS_TS, stats_put_ts_stats);
 
 	return ret;
 }
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index c678b484a079..ce1e193076c3 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -105,6 +105,11 @@ static const struct strset_info info_template[] = {
 		.count		= __ETHTOOL_A_STATS_RMON_CNT,
 		.strings	= stats_rmon_names,
 	},
+	[ETH_SS_STATS_TS] = {
+		.per_dev	= false,
+		.count		= __ETHTOOL_A_STATS_TS_CNT,
+		.strings	= stats_ts_names,
+	},
 };
 
 struct strset_req_info {
-- 
2.42.0


