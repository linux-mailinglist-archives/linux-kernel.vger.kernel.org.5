Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9A67A4907
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbjIRL7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241883AbjIRL6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:58:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F7E172A;
        Mon, 18 Sep 2023 04:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJmio5g+/675efPyfwqRx7G1Xco5WarcTBrZdrEijqQKPGV6Zq6E52TtT4r/6zaCqShAEFGgTWG0RlOMjFQsMsafrtvcaJP5zVybSTVRf5zAA07ZKJLaUO3KrM/F463qIioFtKU/ALV2OZ8j2sW68MT0XQB/9PL/SCJAonbQjGNnk1v93+Zdlo5ugvEig3OoIAEXvnngUBcIKjxQzmHZUHZf8Fqk4P1gfdoXGXoSvPe2Yz3r6tpmRc5TlEhBdZ3bTsn9NTJKqh2ta9Ov3Bl6qOJb8oX+6FwPToj1QJZozvM2c7pWdva1ZaoRrJmTy+DRUE2mRuwkFJzpPsXEkalMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1FIBDQHRoSpuV6r0BPeSdALbquX/AvwUSU51/p7reo=;
 b=QKgsEEiRJbFq6OXN7/4mh+B9NyvfzuFtYXw5hKGGyQrq/o9pvAzVOA/OeRpA0+nrhYDldA3ZGRaVL+FdP5NUxzl6yPOidKTrgn1o/XEbq7P3iW76mmc3DKT3w0eb+EiMvVpK3Q5i/vffdydGsyy5YpeRxD5EXOI0l+eBKBowq5pkBx33GioGVCd4OjlFRb2n5gpDh3gwRTtfyjoQ1/fU6OF5zUcO4YuaqO7Xq4W7ev+7YGiJPurOQCo2vBZK8eAPbRMxg9lZ4jbRcYLF2zc/tfbemkg7cnHJKXcKMJDWOlWUjihRpHuTc2bojg9jqa2Va6W5IVO2iincjB0psAdgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1FIBDQHRoSpuV6r0BPeSdALbquX/AvwUSU51/p7reo=;
 b=XfJiihrSZ9Q6zqLhp9u+qCLQkX60xvUlA669aw0DF67AL4/MahhiKSdO+elVqBsmTeW/xlnh53jf9ty7eyUs+RLaxlMO3HJVGSRel4qvT31nXDJyc9+y1qY5jxYYeMWgx+IRIfVGV+WA7euS+k09VJWg74Az1keMYrTOZNyThiS0/9xfyJFm+CVRRliW1oEJRsGZPp7RDmWCF60MGm2WEDO1SjqwJ7+G342KqdTthad/R2CjJNeWNUpi9u7umYG3XuKd2FKMcWtpxBVaxZNqoSnhB1sJwONun+Rhz9c8I+tZsSGYZvMSzHIrlQOfE4uMxjwBSm/BH3ybFS1/ecszVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 11:54:48 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:54:48 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v3 2/3] HID: nvidia-shield: Fix some missing function calls() in the probe error handling path
Date:   Mon, 18 Sep 2023 04:54:31 -0700
Message-Id: <20230918115432.30076-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918115432.30076-1-rrameshbabu@nvidia.com>
References: <20230918115432.30076-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f7b288-a7fb-4a71-5902-08dbb83e0f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFOp9re/m2sPvJlxuAomrgU/9lIKv2mDwo3exW5MzFXelKtwrRTlKblvVi+EP8mfrQIXuuwSx4wcoE6Rkrx7kux0sR2fnlKuJ4zPqVrceCJbNLXzm+D+PdVEA925Z1A5XqSHjPDo7oezqcGfspy/4tUkTZcScWsnugDRETy66jWkKLn6405XUMpge/7ztkYltrfs4bXcaYDyH5/JR/LcJRCxaacy9+jOZYw59SF7QDFwYnj4XcqZyVew1MYAS7tOEc/kH/YlCe3BSUHQI0mNgXHKKzGiKAJ0dFZho6EX6QAzluxSF5aFEOhv6TScbkca+/PPTJmofuBxl4EOq2ELlvr+WzQGqyu5g4rx6aqWTm927r4SBBm55aiUdFeUzWxa4JcOR5bP0xjynbPeLDAHm8tvRKpiphA+/VuBP5qpnLgRpx+JeJpkCRDaak7w6B0JM6QLaFVdnngTIj7jvWQBwv1T023r0UnsAm6/mjINkweb2JKk+R2pRGa1F9QNJH/ZywK8aoTO7/Q17OwvHiQcLb/b1h5yF5F3vPmGx3TnDx1rw96sPRNnQIMFlF1HOGFi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(8676002)(1076003)(4326008)(107886003)(83380400001)(2906002)(36756003)(5660300002)(86362001)(6506007)(6486002)(478600001)(6666004)(316002)(54906003)(6512007)(110136005)(66946007)(66476007)(41300700001)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eDs26dqn7doqk0toQLfXaZ2E9t6weLsN9Ar4CD11PZ4esAt249Uk/8lnm8CJ?=
 =?us-ascii?Q?03JOYAMTAtAXiiGzA4gZfbePWaRuFhx4z7ST+zQqhg9yAagE6D+Tz1/zCtct?=
 =?us-ascii?Q?m/b4/gm4y1vMiACIoKN7Unedcb/2sm+o2MUGRE5/JSNMnqcT50kZPQi4I2c+?=
 =?us-ascii?Q?4jUkoFecl7aali/s1Y4GyCIarChXeZfAKiMFKjsP0gLtaSXxWP4ISoq8ZHGY?=
 =?us-ascii?Q?RIQa9flx09KpAa6wXcdpEazzVsmJDimGOr/8IcTCIPSJWtZ44MIUBeD4u6xo?=
 =?us-ascii?Q?zNoKjVGfHV0GuFdG9dDQUzyf0sLng8IRMXmDyEPdbahHDL6cXwRd0djZc8cg?=
 =?us-ascii?Q?gZak651G88fBPQ3K1wwMdBibt4R1VZdAI6FDl07Fa5BK4Qij2q3MtyuQMghg?=
 =?us-ascii?Q?uwSD/QTucp54wVnqIOQ5Agp4DFP9uG5Sy9+WGm+jmbEop3ZIhUiDkDTd+3tG?=
 =?us-ascii?Q?UnGNR4CNp7HFSqxbiRblJ6TJbCFDZTBuKD9PA1dbLHDZzefqVLIRxyxzXBBY?=
 =?us-ascii?Q?pVNyN1MN3GpvjDhqYjL5EKRYmuNjOTYYkft1lvwiLUuPsvzCuusaa8xjpDGE?=
 =?us-ascii?Q?rJGu4iXOvblScKTfrtwaZN3Cbd6l5wdinuyT8RLgGftpWyXCtIa7Of2M8RCK?=
 =?us-ascii?Q?Z1PbPL1JkkaV8aih5oTwIQi6Ws3lT7dr728RrHLOzrGBaLb7spYbMGhuIfq+?=
 =?us-ascii?Q?I83kkqdg8VyitXxd57jdRVbG38LRX+9VqkXrJ9muA6sG0eE8Eu33eY8pZq2v?=
 =?us-ascii?Q?EjGwo+4/bD40sIRYC0fIuks0dp6dWM1yVCtq/VPYxn5suhwaJ5K0MmMBfdBg?=
 =?us-ascii?Q?Nl2N17TEIUrnYX/T0XK4X9fyMvcw6wBLyS2DtmKktTm3SJ6CxiS2IC9vRc6u?=
 =?us-ascii?Q?PAoHmGoO7KBuNLB327zjtM5xNh3YOeXp3MQOAYlsMlscQO3gizj1zw73FQss?=
 =?us-ascii?Q?bMXjvlPFCJf346Bj2IpGv8kwyR/GdgkmwJnAnYB3RuJX29gCSHOAVFDteEmI?=
 =?us-ascii?Q?PGE88jNFyE+Cf4GGUSNQvC/22ZFLfsNtcmO4KZ7ZMel4EuhOpse4UzrkYooC?=
 =?us-ascii?Q?ZFGNagI1XRFipXuC8QZ4Wb0UqkMsBMAm6OARIFWWgUAvoPaU16MNaerdg4pL?=
 =?us-ascii?Q?+PV7sGh4iA7FQVYZtgvl1g+346D9fn4b6Ff4KJtxV3Ny0s8nlQhTNbtCyuhb?=
 =?us-ascii?Q?IrD07Rlpwoi1xX9OuT4AZKSN2dUK2bcsnRih510/FsKEfU1QVPFTigGMd8wR?=
 =?us-ascii?Q?0QmW+7eZAOvhJuHNFAEaY+fBqbuPbrdjeB6h5KhN+r1mSHsOE4hHYF/Kwmf2?=
 =?us-ascii?Q?Sa99SDIvpaasDZcyyOXdkYj7jrAjL8Ep7AsmmX6p8oE5mozQwIyJcEelQIQx?=
 =?us-ascii?Q?6cjdBGxpdSmsODIU6vtCmAMVCarTgg+oDtaIAZ1oq8BpYpiYTEisAiCeVhYs?=
 =?us-ascii?Q?JvVdFA4DETTQgWXp6T3V5zUxQg6eLAtB9s+574ffrKO1kAWEKBSlkcs8+tlm?=
 =?us-ascii?Q?9loAo8HhYNEHuXSKjk2+2A2Nyd8xF4fCKG4FGNKrBijh/HRsyNG10fi6z5Z4?=
 =?us-ascii?Q?sbf4eFEZijVdicKA7CRaUlwrbobtFQc6q8Cd6FgjgHUpkQ2CoQH6gCXwAsJC?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f7b288-a7fb-4a71-5902-08dbb83e0f4a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:54:48.8007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Q0xgGsITfuATYXjlSMmJcziB5WFxKCu0y3+isQ8yW9p9fjwo9jZlpHVhr52o2ap8jc6YTAFL0nsx9yQpif6Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

The commit in Fixes updated the error handling path of
thunderstrike_create() and the remove function but not the error handling
path of shield_probe(), should an error occur after a successful
thunderstrike_create() call.

Add the missing calls.

Fixes: 3ab196f88237 ("HID: nvidia-shield: Add battery support for Thunderstrike")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        - Rename err_haptics label to err_ts_create to make the label name more
          accurate.
      v2->v3:
        - No changes.

 drivers/hid/hid-nvidia-shield.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index c144641452d3..a566f9cdc97d 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -1058,7 +1058,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDINPUT);
 	if (ret) {
 		hid_err(hdev, "Failed to start HID device\n");
-		goto err_haptics;
+		goto err_ts_create;
 	}
 
 	ret = hid_hw_open(hdev);
@@ -1073,10 +1073,12 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 err_stop:
 	hid_hw_stop(hdev);
-err_haptics:
+err_ts_create:
+	power_supply_unregister(ts->base.battery_dev.psy);
 	if (ts->haptics_dev)
 		input_unregister_device(ts->haptics_dev);
 	led_classdev_unregister(&ts->led_dev);
+	ida_free(&thunderstrike_ida, ts->id);
 	return ret;
 }
 
-- 
2.40.1

