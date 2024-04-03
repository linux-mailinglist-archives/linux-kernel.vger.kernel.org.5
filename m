Return-Path: <linux-kernel+bounces-130626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B16897AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B49B23BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF5156979;
	Wed,  3 Apr 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dwl1L0jx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2117.outbound.protection.outlook.com [40.107.244.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB6156860;
	Wed,  3 Apr 2024 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179783; cv=fail; b=Vn8kGxBHqfbxcd4UIA1CnYusNaBWLVDESy58rU8xavhoMpVpnvVK+8QwMDsSk8JuQGCzV5dXj64Uh+nYhZHEdk104eL5u7MbmNQVq28XbpeEVO/WWCYh6XXdtDXVaaa0251k0JnD05NI8J1o4cKKp6FqfFhFAHFpy8wvEtL/jvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179783; c=relaxed/simple;
	bh=YAd7EEvF0Np65JsTlkvO6thAZQDyW2SpU68734RQWPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIBRq33qwDd/JQLXCVb8oTBfS8/3iPfFZ5VxBSp2+cUo4uD1OsWFVzo5343UY79xs609vxVxyB5RISpmwYyT4nmyDlagjhdOlOsvzebSrx/gLarcBX1qsIlhSvUWSGwDn2v5pqCPWk6p3/W82hEzu+kQ6BvGD9fxv54StkzgcKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dwl1L0jx; arc=fail smtp.client-ip=40.107.244.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKJVbwx9cO3y4zGvasWb4xIICNDi05BT90gr/10AxdXHX8hEeX3IA2o5xQ7MIZJ48Tzr0xCratzBJ57/kwgJxuUfqALLbYiKXIvNAuS0/67tBQO74O2fkLpohnTYEt/uCh9RT2bv+3NN/UfcH4XniuJ02OT7J7KVVDoKoFhXE59md4hR/ssDspyVqCcvnOwDBQsXpPP1HuvfZbQha/A+GVG9Np1BQ/5OQQGF/SMTUgt0enQL/PWd2GtNdJhKVQ7OwTf0FReXdaI4ZfJziIvsR+jfRnP2E3OVfyFkLEgiRK5a4nrrZw93e0U0xWQRwv9aAznEX1YXm69coC9+/m3UQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EqEnmgq+Ec/6hhhQGst4Vqk1FvLRL2j2mFc0T8D5vc=;
 b=flm2DHR+o/5ckKzwfyFTd7pOs118rlGbIt8fLzD2TBx+18Fo3bjrnyuVqegQ+lEPCuErkXieUY82R0uXBG33qtYuwNvLE6MeinfT0WiKaz93srJHtlxrYmAO8AWrO/i9lpbYvdd7OSlz7r3FtyXJl0OzJxrN0Sp4NShPZ1+pyaN/ckmGSYOC4T16W0GtNvLhFvN2Kks4Cfp0QfbZBiVP2b+Khtk9rSWi0SAvsJ0FNd14+D6k9GL8jSD2re2ZhrFpVgLq1pRgMgE5wi6mQ9x0H0EBet+GXss+lrnspItfUI27WyQ6Ck12pJqrica22QFGkYDbawVi2lsEkqKzRRX4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EqEnmgq+Ec/6hhhQGst4Vqk1FvLRL2j2mFc0T8D5vc=;
 b=dwl1L0jxSzic98verPhR5PZpkESIa37neoOyshd/9B01Yd4kbNUhdSa1M4CB4Vn5QWIBc+aBRFfRO634F7APqn8fneuivtPO40QGesOgN+NwP4yMhE9UVab1EAXiorp0qgqZo8q9D9/qnw0GLXuH2pVDE7pwjgUP7PWM8Rorf/LNJHYhF8VTmJmNl4tO2OAcP6eJqK615RicGDmfgXoNWqqovNvTjgikoQHnI40scEB8me/JoOUIN+I0Rh5wTzEQzzMnAx1OsKCk22+HuzyMZM2ihbAK+LJwK8EStht5/y/adR+DiJ1SMPo8Jsq1LpkgOQLCpyqrdjWlXGR0jcZfFA==
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:29:37 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:29:37 +0000
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
Subject: [PATCH net-next v2 1/6] ethtool: add interface to read Tx hardware timestamping statistics
Date: Wed,  3 Apr 2024 14:28:39 -0700
Message-ID: <20240403212931.128541-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240403212931.128541-1-rrameshbabu@nvidia.com>
References: <20240403212931.128541-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:332::13) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB8586:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LttNEbVu4DrzDTHi7jDMn74WPday9KWPnkjG8UHkIGwrL0MRAWcJv/dbtEPCMLZ4ZWD2/yLqh316URy8DL8Ugu/MSAeiNXhbf3r81WVrqIzJrLf9TNfypC9J0axxeWRZ/Zfe4vZH4LuNeTUJkHxdNrxSwwBSPVjEQ3kOh/hiVijJpo09Ns9M1iexswRSvj+pc6y5NFDkTjvehhQosM+RG2sx5LU1HnF3do8qCkEjQKrGdcdhvK0CwWQ+TeN+h4QuX6Dy/DkKtOMXZ627YcKUwtjJArSMxtBKBIFSNExzBTLY1hIBPHt16Bf0rsIkiO2QtnDkuvJLHq9C+KsZrWMA3At0+VXyPUNZLRep5wFb/VdnPFFRxm8ZzIxW+4DZ0J2MhnsCo9Rm3uAbPZJYcUJreRbATigKz2tgof5v7zBx/AEwwqwUp6Fpx5wGeE6epagz8UQ5IsRFe9vL8fgAM73LCLfjChmL6boyMYURvmXAZglNMsO4d1EZNY8Nxw/lqLsKjDyZW70Ft8Q3ZP0CdRrlw/Tvi0lIgXTqmtw2aRbhnV08aTVp2GPpATe4DltUVkAXaqKitIFlRdX+uNyDIzvafRzgB66nEuOWECBw1jdDbngPM6XuTZ2rTt7JJfn1NKtcngXiKCpPnoCjRKqHL+CQT5cpCnQbgEITjCsMPmK2NFI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRHZU8z37deMFJ+bbSyZr0EPuNJiePX2O8khoS58kGXhYPWcOmbHZG8w1pcO?=
 =?us-ascii?Q?+EzbKZ254isg+b5P42YIm3C2Zgm+48r32WLkXamnpPi/FvsZffFooHWfBjLA?=
 =?us-ascii?Q?9Bvz43lOFF7KWFkmaIGLYa8/DVYbXYOkjGOiKILQckbblwL6+nZTiYt373A+?=
 =?us-ascii?Q?3wuzLat0CHyrVnhFjDhawMm9FMyhGSceOurcXJumou+3MdFEH9H2vpSlPHBx?=
 =?us-ascii?Q?5OEpCzoUq5KIWDdeq2fZwSB2GXhD1C7v0J3NVHm/l1tKc0NnlTauM+EyeQYE?=
 =?us-ascii?Q?ffFIknw78Hev4ZEIDhemnIDQ3A26uOF30hXua5EiaKsEO2xjk7baHMjhrfGJ?=
 =?us-ascii?Q?I3UTlMrRsgJHyW5HGix8RdAwMBGYEtQuhLREpsDR6937uCCPgfJlDsU+WDl1?=
 =?us-ascii?Q?nSoyfCGwAeICURMICFHBRNRD28C4VjtFfwqOixwUBcbNxuDW9ArlRZ2rnvjJ?=
 =?us-ascii?Q?TdrWbdNsK6AOn9ZUzJicxHH3jA43/pgw0EP+2MvnuVkZNldKZZOM/IBGT/sE?=
 =?us-ascii?Q?Yoi3WoeYXR5xQY5iIxw15bHSmzc1pmYPHEnMDkpMKBgXL3+xYXwD3uZVKoB4?=
 =?us-ascii?Q?kzMQ7x/muehwpbItdc/xGDl3jMGa15bn1Z4jMtNKYRF3WYRY9L4IgNJwJf1D?=
 =?us-ascii?Q?o2IxUo8fHygEyQVxCTlyy8oE1WvxXhvIwLN7wYiCzT7iHurdLB9KDvGKq/dH?=
 =?us-ascii?Q?+K1oyPX+j/lH6MTq5q6Mf/szhw4LWF3YwCNYpoCiycvU6zV0nTGv+j0edKZm?=
 =?us-ascii?Q?udFRuVDic3pv/EYDen2fIyJJ+paHz+28UDzXmNENokOhSB2yON0BfW09LbiS?=
 =?us-ascii?Q?DhjdZfgQqi9xN1SRkwrLYp6GIcmjgQcqCU3veUnKzO5wAfgoh1P8gvgoiazn?=
 =?us-ascii?Q?39viYz9ZMdtTf34HSXfMFGSQW9EipK75BNG7aiWrDaL7qMFSDHBMWBuwifdn?=
 =?us-ascii?Q?ERwwwJLp7hz/ZEztnXu/E45u6zKpEexedKrdTRsXAtCAZrcjDrPXTIAfPOEf?=
 =?us-ascii?Q?gJjsscpltkGc5PPV6uzCnWA3WS0gnSH6ct0boVwCztgB7TagEj949lA0TzuI?=
 =?us-ascii?Q?tSoo0G3Qu7oRo6Vk2dpjEre3sUcJD6uhdV13bn7sNUl8dijYphzPyqQyaAK8?=
 =?us-ascii?Q?9b6AzFi0tlbylmdnmuzi7ZI6OZ3Ly1Z3mBOHF0otY+UofrPs9pBNYSrDzH3w?=
 =?us-ascii?Q?AGYQCTB8r9SQzGPRPJADV4OtCr52rCyVGRILEIglpsY5Ud2SCv4KU0p+lIEL?=
 =?us-ascii?Q?58ditxqmfBTdHwEPo52o/rCJ2o2Kr2c8BJKtU8mesEm3Cmvq2oxICWe3s0lJ?=
 =?us-ascii?Q?fy7VvHk9Kdzz8cHI7PNzTc3rmU6yoqdAik/zoOF4wgyCTZeeOaFOthLWE+Q+?=
 =?us-ascii?Q?Hg5GwMBT0ywgPLpPgf4kWUim5V11iEnzfuFNOVZPUtvMbU6PVf9ofnbjjItI?=
 =?us-ascii?Q?EPrkGLDxWOf6oMaLpg6YcBmZBkDmMEkHvYYiORoBT6TXFEsmK1lz4o4zY3mi?=
 =?us-ascii?Q?oXwSSPFsFHJ7y/2dVvN65ZJchBmLtLkMS7czjszgr4O/BinnPbHyAcEkX6bw?=
 =?us-ascii?Q?UDk7CYyLXrJLnpY76jqm3pbehCyBNY3WiuXdIUyNQwD718tkDLEUVL9ZEu3z?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21959c7f-c194-4c14-14bd-08dc542529fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:29:37.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvSkVwOkbrRjsSZkKARyO1ogkm8BRQd3UWWEjM8215YBeSlQoxlTkLXyLS3yXt70BAx/0yExEHhAYIH+WNPLyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

Multiple network devices that support hardware timestamping appear to have
common behavior with regards to timestamp handling. Implement common Tx
hardware timestamping statistics in a tx_stats struct_group. Common Rx
hardware timestamping statistics can subsequently be implemented in a
rx_stats struct_group for ethtool_ts_stats.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        - Fixed scripts/kernel-doc warning in include/linux/ethtool.h

 Documentation/netlink/specs/ethtool.yaml     | 17 +++++++
 Documentation/networking/ethtool-netlink.rst |  9 ++++
 include/linux/ethtool.h                      | 27 +++++++++-
 include/uapi/linux/ethtool_netlink.h         | 14 ++++++
 net/ethtool/tsinfo.c                         | 52 +++++++++++++++++++-
 5 files changed, 117 insertions(+), 2 deletions(-)

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
index 9901e563f706..6fd9107d3cc0 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -480,6 +480,26 @@ struct ethtool_rmon_stats {
 	);
 };
 
+/**
+ * struct ethtool_ts_stats - HW timestamping statistics
+ * @pkts: Number of packets successfully timestamped by the hardware.
+ * @lost: Number of hardware timestamping requests where the timestamping
+ *	information from the hardware never arrived for submission with
+ *	the skb.
+ * @err: Number of arbitrary timestamp generation error events that the
+ *	hardware encountered, exclusive of @lost statistics. Cases such
+ *	as resource exhaustion, unavailability, firmware errors, and
+ *	detected illogical timestamp values not submitted with the skb
+ *	are inclusive to this counter.
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
 
@@ -755,7 +775,10 @@ struct ethtool_rxfh_param {
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
@@ -898,6 +921,8 @@ struct ethtool_ops {
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


