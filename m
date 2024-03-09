Return-Path: <linux-kernel+bounces-97812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2674876FD8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E501C20E66
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4A3B2A2;
	Sat,  9 Mar 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z1gnZcpT"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386438391;
	Sat,  9 Mar 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709973906; cv=fail; b=sUwTDFN45kspXy8MrVm/FQk8naMKEB6a/T+Oy3Q8KuVg9XtgYP5xFln3RnsSs1nWyA89fRefk9v4uAoZ9Pbb29bREYvA8v2V3nMr+UMxaTxCUzcqzpAsgn1J3zHCpqLUy2UBuRVX859xqB/u1mKUL/e8JHrgpEbrl8TafUFfU3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709973906; c=relaxed/simple;
	bh=Gw1ihCHNwDGXu3omJz5gb4JIxKhd0pxJF2Us4AuhbZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYFg5/z16vuZj4vgyZ58EuqMIaBsFWC3wD6q2S2Gdpg9UKpavI25QdwnUwjGcaJdflnYerygPvuhClP6rO6ov8XhxO96mFlIkgU0iB/Lv6SamkB/4iVvsSSsPss0lt1OJeBVAwmX0JmsVMy5Ij/31nydFnu7zB6htpDAVFYd7bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z1gnZcpT; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQPIsykBhYDBFvSp/leiXNZXhOIZyGH+NeqP077PYVFdu3ivF1TsMzEYsbhKZn1ZrGuPZOvDhonoWzpai224O2QiRcLKaFSiF0dmlXhsxLIoN9GqTyxF9QC/GImISbHBrd62tERL2QHQyvVV/vioU4BDimGm38MbldZ/eSVwE9lXMkXNgxAoef4PSDIoO70/WP+k55GM6JN2Fz3mNZDqtUWK8ycVgO/bKIw374l2lOFW21bHym9pNg4OIFoYil9XRlehoI2uUYFFt1zv6+bPi4qaMsEaSQJwYD0kN78+Yl6FmO02mBAses9/xGuWoCHpzk3AK7XH16rP5w5b38JkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfe8Ixs1TmZvYSGMbWnkoX0+FwKXN51Akjy4k7CR/RA=;
 b=LGxpBtItAH86LKOFubv4hT6PXKp5LIqOhQgpk1gZU5SjGDrnFBpr1wndcbHuxVizKu72JOid9S21u6HdP/HwgBX/e+nvuJlIPjiC1LSY5ECu/1fWYvm6xwDBz6FUsSHBpCt+Ih/1Y1OjzDlVZ5PrSLlWhtew26xbR/XeTX3+2N+XghQTvU3sirORT3+d+cXXj4JHL19CGFHIoVLwVXbeWEPpLzT3CjyGLumFRVyAO46uiVfRbzJv5u61Vm5hfNbNE3Wn/WpCcCWLiN+pze8/MdC9UUKFC+fma5fjKguR2+7J9LG7Vukm5z6lt2GvvK/cNSnPqn0CwbO6ztF2vY+MaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfe8Ixs1TmZvYSGMbWnkoX0+FwKXN51Akjy4k7CR/RA=;
 b=Z1gnZcpTgodeXaeNCNpgCFVqaHP0YV+EloaJ5p/1Pwn/bf5Ird5TiMirt2N0sHAM6fvOtuXYXVdsHOiLWYnF9P5QaXZ0gWxxoQI+pUWO2AfaSisXTgFipdEmOp2X9/qScI9TkBR9H5Aix2WqIuQ5lrEH7goDUh0PtnGA6soRVPV37clxYCZ+mBj3/OdNtLGEP/k/LDhKdWuJmS+cqreFaIG70zKq1F3fSuY09czn9v7duozJhvm17HvEhbV1yoCFtDxZLj9j59Tx27RLaB1yR9PY8W0k3sQopc0mTMJonflqF/EL77qzHmEmuAbmQQlp8w2CatsBy+ZCwnQoRVDNfw==
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
	wojciech.drewek@intel.com,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH RFC v2 2/6] net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port timestamping CQ
Date: Sat,  9 Mar 2024 00:44:36 -0800
Message-ID: <20240309084440.299358-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240309084440.299358-1-rrameshbabu@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240309084440.299358-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 8922ad58-ca86-40a0-ad3a-08dc40153253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s1Sc2mDHh1c/Ef3m56LeuF/hE7Xh5MUlfQlYCXKtWF42liwK8rcb5ecM5WiXa179OZVGR+Rm0Q2PtJM0Gj+5bSDmYlBCv+8F1CrXh5pBmHLaqOfnG/BgKxfmBX8b4FFBGG3BUSG13yDmsO9d+pRKgi78EvrIaWvmKdsAA9XsnzCPGKiR+J14hcx2TawPD33ClTj6Kp/+RlAVXql4dS5AJ44SeFjudgmqhQZJPOVvvkzhHSl2b6/kUP2BJsxXxnbMS5iapzOgnmKnOJ5FXDQ291JqHxTwwdAYYUoK2hn4AFkYdVLLmgj67YDwFuPnbe6BNQX2Wfh747vcFKcvw6Fb1OgzSwuxSRzuHbKOm+ddldl01hskd9+o+maxPnLXSfN4+Uf/iB6ahyD5O1wPO2h7hl0xSRNsUSleH/uMEIFHPvfocX5y9Bmywf1kIIZtdfeZDgkDyO0NntSVIAIElQSOy/abQ2HrszEo6UC11HwVn4dP4fyWywS7IqHOIkHl+bZJHsh+XNnvJulSF+/ZXIeXDVj2R3O7Dn07ixaqqCz19Bnd3vo0Wm64HV2HpOuED7c8Nh/engB0pkZXKElzSb3dWrUQOWnRy+H1XIIVaTeA81sZhZKqWmXnKoKKkHxulGlXvRLXQ10wnNzuQ/a+qTrt4v4cro845O1BbQdvupxGhic=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lOi2hH6tsq/A3KOPh3uuRSnI6cPLNph+ju3VJLhTxpJmbT63CEIWgCqYFig?=
 =?us-ascii?Q?xJemNowF4mFSk1OeZGMeegLVvCqRZyxP5TWV6flgki9HUMzDT/GXVoJLhIyW?=
 =?us-ascii?Q?jWoEa5jcDljz/o8ckKVw+lIK2qDSnwSaifMBWZiv+NsXe0MDM6KUUBqYNPux?=
 =?us-ascii?Q?U68EMnDyitd0kdx8Cyg81qZF4E234kMOKi+P1TRifvW7voAQKPLtQO9XUY/O?=
 =?us-ascii?Q?VCdTn9YcJHBD8ri2uq+7iGixGA4YbpuqA/VOE9zX+eldB3P8ynTbG0VFwJmD?=
 =?us-ascii?Q?qOKdQJRetndVqIWprlbNaGOzxYNB8TKYed1k++ggW8jtAajGvtWycUtRcPUx?=
 =?us-ascii?Q?G98MjXqxEhmdn59Epep9WEFXq+Tml4FQcJel/W/L0yQgj5Fa79pe1PzEXTC2?=
 =?us-ascii?Q?c8fZDcCsMhxGIoDQ2vRUAbhpaRr9iVK8f3V7FOak86Y/nTNOvPUOI6+jrIbM?=
 =?us-ascii?Q?Z3D4sK1GT2UF/M4FPVPFsF8CfRx6C9UuzGW7JwBnuR0zQoXfe5FMUuQRbxg/?=
 =?us-ascii?Q?DKCrRcWCjUtMT+1uWW8OgjejpSdnzH8v7+MIE0YgCRnaAmzdpKGMIBw3XP7a?=
 =?us-ascii?Q?hbfQ+PapY5RAq3LJLUn3JI/v+ML0mhyhDp1GypEmcSLDrZXgaNEaN/waI2FO?=
 =?us-ascii?Q?tCfIB88aJf9RxvglPz5YhmPlOg4DePpds1ADH1VQWSzz6/rJLuqB7MRiTnWE?=
 =?us-ascii?Q?sEHmtAF74B81uXWlYn5jg7sUxuBNqQQG2vV4aasAVczL8tKhr4tU4DgxG/jb?=
 =?us-ascii?Q?TyhhAT8tceXSthH1nXVlh9JuHtBq9t2aWc6z7UqsU7UarP2vleTAJRKg/6Oe?=
 =?us-ascii?Q?yHTzhUjOaKrESQ/UxlCEpNSoDqtk4uz6djalRCaWm5v8JyLRpvDuHVTU4xkb?=
 =?us-ascii?Q?Kprl9meZZZMpN2uStGuJCsudJdUUmFVR+OlbOQDup1QUMOZy7ri0ZA9FGMSw?=
 =?us-ascii?Q?PUrjwEZ/wXOP1zg8L2h1/UEcd1RSvCUtwuPve6Df09OnpAs3jywvwGvOzBgz?=
 =?us-ascii?Q?Fq5s9PU50xddR/7kBF0+G+mW9K866O5+RQkFfUZo/nqD9DTxKQ8O7MDJfzSP?=
 =?us-ascii?Q?X4CrknBkbGUPBxNZUgwSGtpfdoKqRD9k4kDHgnqqb6cEVz2mTo/oaDTAwOqb?=
 =?us-ascii?Q?lzjdUU00DnlfnCr5WWG2Af4yexx6rFj0rfM9A5yOjmAbbbiC4YVGOtVgmVtc?=
 =?us-ascii?Q?aQY1pccMuo1iIR3vAsvHTF5d12sQxYpYMrACiBFiFajERyM61myYhXE7H9Nx?=
 =?us-ascii?Q?+aIrsyzemP9AYaA0eeJxvkjHC3nfU6lFJPYuYm5/opOO77uDC52s+4Ipy3Od?=
 =?us-ascii?Q?yJX2NvkeIx9pdkI1ZnSBvTgLG8BH9b0XJKAeZlxEuys3to4bWXQfoooCHGkL?=
 =?us-ascii?Q?69LxZP38DHaAGr5yVoKzA1nP9pMgmwxNVkUbf9Vfs0Rn5mqn7+l+pd3/ynMz?=
 =?us-ascii?Q?l2grg4Lp8FcOa44odsVcqVZYSQj1r28rGFifO0KzDYTqgyIK92uTInhyN1V8?=
 =?us-ascii?Q?LFcjAr+vgTovAZ9dU1Dcz/qmDbshvNgc+/sYUfmNfBKr7ffbfPn0UJniEC57?=
 =?us-ascii?Q?C4QBn+E6kCfykdEd+0z+ENeZqjXk+oQDPEjc2WOvv751RUtbjKwpNibfCZY0?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8922ad58-ca86-40a0-ad3a-08dc40153253
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 08:44:56.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyH4pHdWEcddYapr7xj5lcZCdbNktwGvjBoU0m0YIXhBO4zGw0Kt9TJtPMNEyxA1aFr3+D5Ebwyovd5qZplWyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394

Track the number of times a CQE was expected to not be delivered on PTP Tx
port timestamping CQ. A CQE is expected to not be delivered if a certain
amount of time passes since the corresponding CQE containing the DMA
timestamp information has arrived. Increment the late_cqe counter when such
a CQE does manage to be delivered to the CQ.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst      | 6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c            | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c          | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h          | 1 +
 4 files changed, 9 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index f69ee1ebee01..5464cd9e2694 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -702,6 +702,12 @@ the software port.
        the device typically ensures not posting the CQE.
      - Error
 
+   * - `ptp_cq[i]_lost_cqe`
+     - Number of times a CQE is expected to not be delivered on the PTP
+       timestamping CQE by the device due to a time delta elapsing. If such a
+       CQE is somehow delivered, `ptp_cq[i]_late_cqe` is incremented.
+     - Error
+
 .. [#ring_global] The corresponding ring and global counters do not share the
                   same name (i.e. do not follow the common naming scheme).
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index fd4ef6431142..1dd4bf7f7dbe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -169,6 +169,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 		WARN_ON_ONCE(!pos->inuse);
 		pos->inuse = false;
 		list_del(&pos->entry);
+		ptpsq->cq_stats->lost_cqe++;
 	}
 	spin_unlock(&cqe_list->tracker_list_lock);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 4b96ad657145..7e63d7c88894 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -2158,6 +2158,7 @@ static const struct counter_desc ptp_cq_stats_desc[] = {
 	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, abort) },
 	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, abort_abs_diff_ns) },
 	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, late_cqe) },
+	{ MLX5E_DECLARE_PTP_CQ_STAT(struct mlx5e_ptp_cq_stats, lost_cqe) },
 };
 
 static const struct counter_desc ptp_rq_stats_desc[] = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 12b3607afecd..03f6265d3ed5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -461,6 +461,7 @@ struct mlx5e_ptp_cq_stats {
 	u64 abort;
 	u64 abort_abs_diff_ns;
 	u64 late_cqe;
+	u64 lost_cqe;
 };
 
 struct mlx5e_rep_stats {
-- 
2.42.0


