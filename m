Return-Path: <linux-kernel+bounces-128679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8F895E13
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E335C289BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18E915E7EB;
	Tue,  2 Apr 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZyVaUReg"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993215E5A6;
	Tue,  2 Apr 2024 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091180; cv=fail; b=B3jSnKFSeIb+foUz8J9Bjdj2qBs3kW/r+kYpltk0wc8GRPFGIi6w6jRyxDmAXxpHsU+3a6MgPiONMVgyBclMSDI/u+XJaT6QlWh2JPjWuWw5N3SQ3UUuAt1FWEvsxFPRjKI5U1zbId2K05UjAAtwJeX5YMGdHY1xPgdPOXmN+SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091180; c=relaxed/simple;
	bh=j6stmcY22YZ0xweGD3iFWeL6dMCnH8/BRpBH1YzqmaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goZZ7q907F26uEVZk2cmqKZO9uPAxt7Cc9CekrC+yokvo3Y64fnGQakQ67pul3DjUBkak9kUItk5oXlsF4YBxQfP243T35DHUc465KRufiScgF6qeKGT4u2Y7TB0l57ugqgbbFD6DXfwnQn/+VRdWswT58Je1UqnBSOzWJZa34E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZyVaUReg; arc=fail smtp.client-ip=40.107.244.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0tTRhcKfvLFiSLYpodR3t8tfKqaH0Yoh1vc1BGL9rP9kFBBCPXxcnXMuJ097O4jC9QYUqUFseaZRDbPQnK9Zx6hQw63C9l4ZPvoQPJOWqi5aw2vrWwQtS2kV0JCAbPFdBv3NziLw4Stk8w+4F3xeOyt7c3j9OlktJc4P1rr67bJR6k1EJIoWjPjQBSMg9/N/QOLmaSAKvyVaq1b/qqV71bugWzKsmxFPWrst5UqDfplUGtKq8Je6RbBf6rVVXSghMtYG9GFnZxyQmAXazPC6Ggl+2FY3fZU7ZSqLcNoOR1Ijw/F0qaswWMX7xxM2hszrFCuvlGXw+deDIJPS8dLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+53jNI38qiikc0vyHelGLzbgxCEV/EElUoregCyvTGQ=;
 b=QArp/1Q46ICFyjGYlO1rOWvFZhQ+/74DUhYLkUn90ucXDRNI+3fOKj8gJaLF8iH4oP1YlLzP5lzUqcWtRNfAIV6HiVC16+kcBy0KMkqxs9RKYL3DIgAiT4z7s3Yyul30riRA1d4ZY1PaWcnaA4HdQhYKZeDoz+Ot3Ha61GwUog1ZAfZGzBz31CF4Zobg0kLLooj89DSzmv7Kz9UkdXMJPosLGwGjn9MChv9uC8644/Zu//kG/vscGeY7lhQP1bwYc0Odp3oIOsaquNIr4mgizxHjeVIroVwVdAPrQRPGLsDccw2355PFcN1Atybu7AVle4Ssu3TNHQ9JwPi2rF7ZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+53jNI38qiikc0vyHelGLzbgxCEV/EElUoregCyvTGQ=;
 b=ZyVaURegBO19WaCTGhAELxHW1Eqn3a+VtGLYfne5e3RspcBpibKrDJ9X37gU3d2AqyWb7lKBIuYgWb51WQxtylT9dPRs5IicY/+FZgYn/YrFY6zl1asL5cDWqBNqlhjKRIx1dKKSpfI+XzQhvtoojJoQZkYWUlpizVAKsWsJjDKtUe/1QyYb/k59YTgJP6R8TbyXD5Gi540dgdhyIycmsT4xvRQLifjGsx5whxcsm/wQP0KjbuxeVWAK4vaYxoT2jXQsZHOhH1ZX0x7F5kAMswxdWk3HS6gqdkoApxDQ22idoDZQjdSikm8hJv7I6Aw2Y7Q1fBL0lifewd+bmUdWTw==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 20:52:27 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 20:52:27 +0000
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
Subject: [PATCH net-next v1 1/6] ethtool: add interface to read Tx hardware timestamping statistics
Date: Tue,  2 Apr 2024 13:52:01 -0700
Message-ID: <20240402205223.137565-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240402205223.137565-1-rrameshbabu@nvidia.com>
References: <20240402205223.137565-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::20) To BYAPR12MB2743.namprd12.prod.outlook.com
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
	QACBuQBVNwYdsvLChoNoXMQLM8BxxIYDo9/c61viO/4Njr4LinLfzlaczRvtxn16D9NPFt1X4WOlYjlo3Kfot2MhXoirE60q4vS5qjnUtcTNvMsFAraQB3FgWz+SLmCoft7GZDh8pbYwnEmr7TIkvKN76Ow6NVwX/U0xz6VyUQ2U6azPM22gMs03C/S82dUcHVeccchoKpDWzRqCNRVl+3SD2BkCc2HNi3mMQY0C+5p45vjmnEtfmAppTZUb+H5+DzKksTdo9hVufFVxfRseXzFo9qjGFCrRIHFxWa8RVGVMuLaxetJ+UZ2AmQZX+AOuQGSOUCkbeRzKb2XnG2mqyvGwK9IfJl7IpLzeCmoUYVxoj9rDjMDM0+ZhPvEOCcwczZnEvB0Bj+6aGzheC2Gn0AlRMbjOJJDBosVW7T7kWdmG5sz3tn2MKin4yromkbEdjXnDPj8KBvLx1OhpniBveBY+6tIibswqTFspWlcJTuCwVBLcgjWAY97FUQ2oC8QRb7YHOmyoBvUQ391NYiliJ5FeGbuKQkbexvDGEsw+tc6akjQfMn1Hxlm8KFr/o0ePV7mlomzOD2wlIw1NrTGLijqUm0CKG/96kXm2uIAixEUusLnCjOrGRZrhmvVuNVi0G947Vem4rPWa0E2Mq1VAIg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hccMaao0kLALirdvrx3YjTQjy6Vcuq7BwTESz850p3ft4sY3IP9tgCjpoOmF?=
 =?us-ascii?Q?RdvFqU3oBOVd+HS44OMPulT/lR7T/PmtM5xxMehZN35YDIVHKfKNpX58A4A/?=
 =?us-ascii?Q?p1HvBPOfc4Tml2/tYsP+SwPqzn4EgJpmwi0UIZ4CTl3heswTReo/UK8/8GLn?=
 =?us-ascii?Q?YBXgianKtpK0EVZutwSZKeG7EjxBS1uZ1Re8prFT9cFORCh60DTjFrvgZGhA?=
 =?us-ascii?Q?OfAKY3pir0k/GO8E+67zQrYSFCBxiSFE+BSfH/LuwxZgpiElTqsHpnkIKi0y?=
 =?us-ascii?Q?lhPSQ20Ma0/hg5Sl1a1ZH2ah1V6KCVLD3vFxr8z6Xo19SC8zGXMK67f+HUmA?=
 =?us-ascii?Q?UwNmyHNzs9iRhTmPRnb88nCK2ZfKbs+7Bb96XVkKlUaq9jQ7UjHEBGlSR9y2?=
 =?us-ascii?Q?XDzu1DU8G0Zoi7qihh46reqKea4PRlb+24TbSkVwW4H4weEvUQThRC5U34pz?=
 =?us-ascii?Q?TevU1aPPukbjqfM45T1Yp7RvGCyp/5HHRQf0Ztobc5RlXXfiUzDw38sCxJbG?=
 =?us-ascii?Q?sDjeLSgswza0z0eJy4wezDxIcwQucbAAZbtqY+XTseCrGKoe52BTo5Zjo8P4?=
 =?us-ascii?Q?df3/o+2CRYXEtPZpIeQ6c6SQVrU/GIKBWScQ364LPbG77EtRUk9bhg+wPInJ?=
 =?us-ascii?Q?+w6QNccVgrg8xTz1yKYMMLZC2LmW7NziBmWY2wG5v4/1HxFOXIGGoByLcPVh?=
 =?us-ascii?Q?NUIfhAkTn32X7dy1obAPkZ1e7Q9zz7yAXN3/zi/AIIkRsH3eP0SWJur5z+A8?=
 =?us-ascii?Q?y4UNPI2xDXZsgBrxov4c2QvTlMVdRxJg6iFO54xFK9damVdVRnoi8OMEWktH?=
 =?us-ascii?Q?rB1zACTdiw/mdXnokbd35APGumbx5jCcFT7nGlldPsKKIR9sdK7D4dMx6THT?=
 =?us-ascii?Q?UnlkO7YLsnxJlKcJW36tj38tlnAYTuBzEwZrVmNz+AYfgojNaKfsGUkJFFd8?=
 =?us-ascii?Q?5NHDeJcOnEKEPQOR0A52BXAdFtAUiskTj4MCaqR9uu9gmO2ztASgyzrNkxXY?=
 =?us-ascii?Q?UVJizOP6YfQD3sdoR3OHSCbuowfkJXtU6hKDC8i87oKRc5lJhSahu6MJkin5?=
 =?us-ascii?Q?HdHH2PL60kVkDakvhuxfJGtXr6hPceprYr9mmLeiSlYuyiuSkq+gY/HB51kk?=
 =?us-ascii?Q?37zA0Htzv417lvShPfuinaTmKfkU4D2JpiIleGBLFkfmTwcVyiPcrGSxoMj1?=
 =?us-ascii?Q?MIMTKoaBu203uxT1z362Jtp+wIBra2NywXNWZuVO4QA/687HTZvBMrjtyXXs?=
 =?us-ascii?Q?NVMClK3mjOAmd1vU1kK9EYE/yM7zTQtsqdmlDq6/lXOqaoRWUS9A3tck/1Kp?=
 =?us-ascii?Q?KGrIss8D0IAAzFFqCBxY7a/VupBYiNguLk6UGUtPDHO1YF2AMvOQOK9EVvIt?=
 =?us-ascii?Q?VKsAXlh5VgvaqHX1u31Xj9pfyP+90T1z/C7TnMQZif4rAZ0ePY+B0+upEPPW?=
 =?us-ascii?Q?UOX7vMbqnZ9XhbhFsaIHfh4Nm3FSMilVeG3Tnnr0K8gPedFBpqLUX0MKbTst?=
 =?us-ascii?Q?B6Hbi/fUjnecWr65+6yoVRlt293Mdh7+JXXlXfG3CykMYMilogf41UGsDe4v?=
 =?us-ascii?Q?Mxfqb1sXwxk4Ybc/BZy6gczQJAOkw9vHSo3OeRLbW1oEh0KXMKmWSEKaHB1H?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7e4233-5eea-4b10-02bc-08dc5356ce46
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 20:52:27.4126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qe5vH2iG5LKe4rU6NViTpmMsH17lDmVEq1SwOuK+iVHpAgo8ikWBXuKS25V6yCV6gjSitWplD5UlWM5qajNC2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

Multiple network devices that support hardware timestamping appear to have
common behavior with regards to timestamp handling. Implement common Tx
hardware timestamping statistics in a tx_stats struct_group. Common Rx
hardware timestamping statistics can subsequently be implemented in a
rx_stats struct_group for ethtool_ts_stats.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 Documentation/netlink/specs/ethtool.yaml     | 17 +++++++
 Documentation/networking/ethtool-netlink.rst |  9 ++++
 include/linux/ethtool.h                      | 28 ++++++++++-
 include/uapi/linux/ethtool_netlink.h         | 14 ++++++
 net/ethtool/tsinfo.c                         | 52 +++++++++++++++++++-
 5 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 197208f419dc..f5aa1e7f3383 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -559,6 +559,18 @@ attribute-sets:
       -
         name: tx-lpi-timer
         type: u32
+  -
+    name: ts-stat
+    attributes:
+      -
+        name: tx-pkts
+        type: uint
+      -
+        name: tx-lost
+        type: uint
+      -
+        name: tx-err
+        type: uint
   -
     name: tsinfo
     attributes:
@@ -581,6 +593,10 @@ attribute-sets:
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
@@ -1388,6 +1404,7 @@ operations:
             - tx-types
             - rx-filters
             - phc-index
+            - stats
       dump: *tsinfo-get-op
     -
       name: cable-test-act
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d583d9abf2f8..08d330b0f50f 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1237,12 +1237,21 @@ Kernel response contents:
   ``ETHTOOL_A_TSINFO_TX_TYPES``          bitset  supported Tx types
   ``ETHTOOL_A_TSINFO_RX_FILTERS``        bitset  supported Rx filters
   ``ETHTOOL_A_TSINFO_PHC_INDEX``         u32     PTP hw clock index
+  ``ETHTOOL_A_TSINFO_STATS``             nested  HW timestamping statistics
   =====================================  ======  ==========================
 
 ``ETHTOOL_A_TSINFO_PHC_INDEX`` is absent if there is no associated PHC (there
 is no special value for this case). The bitset attributes are omitted if they
 would be empty (no bit set).
 
+Additional hardware timestamping statistics response contents:
+
+  =====================================  ======  ===================================
+  ``ETHTOOL_A_TS_STAT_TX_PKTS``          u64     Packets with Tx HW timestamps
+  ``ETHTOOL_A_TS_STAT_TX_LOST``          u64     Tx HW timestamp not arrived count
+  ``ETHTOOL_A_TS_STAT_TX_ERR``           u64     HW error request Tx timestamp count
+  =====================================  ======  ===================================
+
 CABLE_TEST
 ==========
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 9901e563f706..4b5ca7628700 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -480,6 +480,27 @@ struct ethtool_rmon_stats {
 	);
 };
 
+/**
+ * struct ethtool_ts_stats - HW timestamping statistics
+ * @tx_stats: struct group for TX HW timestamping
+ *	@pkts: Number of packets successfully timestamped by the hardware.
+ *	@lost: Number of hardware timestamping requests where the timestamping
+ *		information from the hardware never arrived for submission with
+ *		the skb.
+ *	@err: Number of arbitrary timestamp generation error events that the
+ *		hardware encountered, exclusive of @lost statistics. Cases such
+ *		as resource exhaustion, unavailability, firmware errors, and
+ *		detected illogical timestamp values not submitted with the skb
+ *		are inclusive to this counter.
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
 
@@ -755,7 +776,10 @@ struct ethtool_rxfh_param {
  * @get_ts_info: Get the time stamping and PTP hardware clock capabilities.
  *	It may be called with RCU, or rtnl or reference on the device.
  *	Drivers supporting transmit time stamps in software should set this to
- *	ethtool_op_get_ts_info().
+ *	ethtool_op_get_ts_info(). Drivers must not zero statistics which they
+ *	don't report. The stats	structure is initialized to ETHTOOL_STAT_NOT_SET
+ *	indicating driver does not report statistics.
+ * @get_ts_stats: Query the device hardware timestamping statistics.
  * @get_module_info: Get the size and type of the eeprom contained within
  *	a plug-in module.
  * @get_module_eeprom: Get the eeprom information from the plug-in module
@@ -898,6 +922,8 @@ struct ethtool_ops {
 				 struct ethtool_dump *, void *);
 	int	(*set_dump)(struct net_device *, struct ethtool_dump *);
 	int	(*get_ts_info)(struct net_device *, struct ethtool_ts_info *);
+	void	(*get_ts_stats)(struct net_device *dev,
+				struct ethtool_ts_stats *ts_stats);
 	int     (*get_module_info)(struct net_device *,
 				   struct ethtool_modinfo *);
 	int     (*get_module_eeprom)(struct net_device *,
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 3f89074aa06c..8dfd714c2308 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -478,12 +478,26 @@ enum {
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
+
+	ETHTOOL_A_TS_STAT_TX_PKTS,			/* u64 */
+	ETHTOOL_A_TS_STAT_TX_LOST,			/* u64 */
+	ETHTOOL_A_TS_STAT_TX_ERR,			/* u64 */
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
index 9daed0aab162..be2755c8d8fd 100644
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
+	(__ETHTOOL_A_TS_STAT_CNT - (ETHTOOL_A_TS_STAT_UNSPEC + 1))
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
+	if (nla_put_uint(skb, attrtype, val))
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
+			    ETHTOOL_A_TS_STAT_TX_PKTS) ||
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


