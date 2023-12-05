Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC64805100
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjLEKqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjLEKqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:46:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C3CE;
        Tue,  5 Dec 2023 02:46:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPa4rh7tDMi4GvB4TI2Qp7e0yz74u5aFMav0OI/l/Pjp/YAyNAEHWwHk9zfQsXM/F9nHtf6UQr5PXXxPYqV/mKTYW1IjqEJTYUa8UuPrX4RGxsvCkebyv36Gbd8mU4u/j8neAwSIm8Sv2YxC8wfLEe4UoRS0sMmftUXhLZkHY3RB9K8DMVNVuw1gyn7s/OyToO/DGFWzuJWhVScam0d4ReZ6MCJJHhqz4gzB/iWYMY6vB09EvXN2W1GZ+eFg4+SM9Y693esABzDh5JE7hyYj3K2iHxsgBBox9b6B6krr7JHEW2OUkeYJDvg3v6GpHDnieI4U6Ti/mbwZcLnWFTNUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP/LvjnSZ752aHpWJ8nKH7P9dJccsbTvl1cJE+SL04c=;
 b=jIw0pOheqwo84YTgvImzmdYHU1UFD5E8Nd2hnQRcYzXBrWbPbkPN1iNY841oiZGjWRggSw110vwCTqLSQm8WBonOsFEycTj158JwgNigxWBDY9OZNfAqrljrUKk32/H6909UzOgLcCjWHSLkcAfVMuf4NagHk07me7uGe+974XfsOdEhOBYzCWnu6XkBAg++v9yuSHlCf0PFHe+eQeqwJ9KMx9tN18Ae1KpeaV/38/IIpyj2wGLJTUirua7lSDdnC1lo6fQlW3v9T8c3OoHGmBMbIiWFzKUAufwo8d5r6I0MkhetA1HKXyfJO4+ufiuRoEqWDsL6j7xCKLSReO1YMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP/LvjnSZ752aHpWJ8nKH7P9dJccsbTvl1cJE+SL04c=;
 b=rUQuPML2JWYUKsPkoIlwc3+ByCJ69thf64PluqUyQ8bamlpn8tHwj6/dpMg1uUACe9iv/Kjkgo/GK1rOLnf36AZgJKdTKFjGUH4h0v7quC7BcJzlZzSsN4vrEC8nYV6gE1ZN2+MIUM+LsGHiGod41cUT6GXKzj6jlQfvyASPeG+FomK+LQD+bktBEHeXDAxZUBJE8IwSJycN4LcZ6EWiSdyQXBW6indkhmC+LObZJBiugyPFDG6e13Ur8gldhqaGI/S/6ejoRVhgO4tkyAkzvhr4uEK27q6RKY4+gSeamb1Edxl4wUZBnVI6tTERqzb0rBp3z5woLWlvMLHQ210FwQ==
Received: from DS0PR17CA0007.namprd17.prod.outlook.com (2603:10b6:8:191::14)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Tue, 5 Dec 2023 10:46:33 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::19) by DS0PR17CA0007.outlook.office365.com
 (2603:10b6:8:191::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 10:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 10:46:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 02:46:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 02:46:19 -0800
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Tue, 5 Dec 2023 02:46:16 -0800
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Gal Pressman <gal@nvidia.com>
CC:     Dragos Tatulea <dtatulea@nvidia.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Parav Pandit <parav@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH vhost v2 0/8] vdpa/mlx5: Add support for resumable vqs
Date:   Tue, 5 Dec 2023 12:46:01 +0200
Message-ID: <20231205104609.876194-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: 14da9271-6146-4a00-9284-08dbf57f724e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKJCrBV9zwcpCW+h/pZLcZWmsNJDUQ2vwCDyx2HzGKpibQ1mVzY7bB7yCDLhuF9ROKsEJVqrxbGFN7MIwEIeTctGG0lsCJZzfZv36fJamOGljzbtfHmNzZjmOzGNch4zUx2t7bX7N/MSie9MNHyaMt8I99veAHQxHQp7ToF45OMmU9ySuP2tOKTalJmdhCNMEfUSGLk5+XQyMFfG0P+fbpVz6cu5IXZZEkzARrsdBk3G5WS8Z+yg2VdYejYkXdM8LG6Xu/34pkQXqBSinVmuDJ5ClHe3TLP9qm5JwKxjT0KXSXyhcbjc9np5Sn8ymkaxihrCwuuiHkLieRSiZnuullXTAmiShVa1gEyPePBEj4bMYiDgMVGevpFiF3+TpICCM0qxbwDsTGL7mXMvHSSRQBJfj3x9nm4MxFkYzke+ZGd0foo/7mRb7SPOxsLDXxwZXVw+3RsRPw4mHs3syxjAzuFe5eXip4fCbBiFgOfSmLCNT3C2t8d2mnSKzZplMsr32AWq8wSHssSqqKQhgnELmdVYgrSYT/R4YPcfQ6tADakgL+4+pI74fqKlCLTCHVOzdsCd252LGjMuDTQP5cF4isrIWAYQHH+ORkT1mC6gsVhHTNS2Bfmruv07DhUXmX6A4QGiSVQmUMRA2G4Bqdgw8eKWxkhx3R0QUaflQWavxdH3S/JLvVivb6suoAMG/n/d0ETGglRGYIhtxImuScZ8UwulHss7HqoXryZD5m0VSoRXQzbT49+6V/4vNYY5O4B5BxZ3xu27p/FVK82tlIH5OHXRbO0IYGJZA+5NpXu9JUM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(82740400003)(83380400001)(336012)(426003)(36756003)(41300700001)(47076005)(7636003)(356005)(36860700001)(2906002)(26005)(2616005)(1076003)(6666004)(478600001)(966005)(40460700003)(5660300002)(70586007)(70206006)(86362001)(110136005)(54906003)(6636002)(316002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 10:46:32.9054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14da9271-6146-4a00-9284-08dbf57f724e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for resumable vqs in the driver. This is a firmware feature
that can be used for the following benefits:
- Full device .suspend/.resume.
- .set_map doesn't need to destroy and create new vqs anymore just to
  update the map. When resumable vqs are supported it is enough to
  suspend the vqs, set the new maps, and then resume the vqs.

The first patch exposes the relevant bits in mlx5_ifc.h. That means it
needs to be applied to the mlx5-vhost tree [0] first. Once applied
there, the change has to be pulled from mlx5-vhost into the vhost tree
and only then the remaining patches can be applied. Same flow as the vq
descriptor mappings patchset [1].

To be able to use resumable vqs properly, support for selectively modifying
vq parameters was needed. This is what the second part of the series
consists of.

The middle part adds support for resumable vqs.

The last part of the series introduces reference counting for mrs which
is necessary to avoid freeing mkeys too early or leaking them.

* Changes in v2:
- Added mr refcounting patches.
- Deleted unnecessary patch: "vdpa/mlx5: Split function into locked and
  unlocked variants"
- Small print improvement in "Introduce per vq and device resume"
  patch.
- Patch 1/7 has been applied to mlx5-vhost branch.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
[1] https://lore.kernel.org/virtualization/20231018171456.1624030-2-dtatulea@nvidia.com/


Dragos Tatulea (8):
  vdpa/mlx5: Expose resumable vq capability
  vdpa/mlx5: Allow modifying multiple vq fields in one modify command
  vdpa/mlx5: Introduce per vq and device resume
  vdpa/mlx5: Mark vq addrs for modification in hw vq
  vdpa/mlx5: Mark vq state for modification in hw vq
  vdpa/mlx5: Use vq suspend/resume during .set_map
  vdpa/mlx5: Introduce reference counting to mrs
  vdpa/mlx5: Add mkey leak detection

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  10 +-
 drivers/vdpa/mlx5/core/mr.c        |  69 ++++++++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 209 ++++++++++++++++++++++++++---
 include/linux/mlx5/mlx5_ifc.h      |   3 +-
 include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
 5 files changed, 257 insertions(+), 38 deletions(-)

-- 
2.42.0

