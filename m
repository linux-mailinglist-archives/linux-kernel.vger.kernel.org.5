Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9687A618B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjISLnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:43:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA65F5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHlkwvVp6ucoc7Jsmgx5Y2vTiY6vPMrd6XsPQsPNaKqlerddNhOVM7EDHI9eJk92m3NoeV3bI271MmhrfIy2BoSphubsUrKUkIoPoFRuHF5/2Cif5UriiXIyyg5jbx7EP4SXeKIiCBomnfR47W2jTPFKm9SieKcByy1xAlF62H6+W7guEkJDnhib4UrgwcjuJUGJw44s+ki2W94C//Ury+goLs4GuTHIE7O/7NgLkMPqGMPAJq7z9IsYjfJUQABHLhnhtInV3xzw+upRWmZYDtVlDIuO63tMhqxDZGDrL/sN91SgxW7MxhTU3un+KDuP/JpCX6Wh1tKBKjO8peTL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au5O3qF/D2W3vL35NSd42JBaWy2FzJt7RhjS4tbLWVo=;
 b=APdqWI/DAOLIn7IoTR7gPAbd6kDnp48v+qiDBWlRbnfQAi1yWRzK1PysL8mNwcOVDjLssw2dNL0wF/lEZitY0LtTuGWovhtQ4JAn8dtMDWsbDlmhc9Z9/gMnxJsnBbxrypri8ZvGofVW15DBdMZmv8hU3niRZfAvncHjiTck+NtqhY582Ysao1x0b3GVugXju/kKj55j3+9D9Fmv9W2xJ2tcUsN12ogw2m70a1I1yoBkzPS0JsX4S3X7ObkQKsYuOGTx08PGBmu4JeBqmd8HtXYPAkq+QUGHbR6NbkfC2gDDROqXg8s9BtbY9Q2JtZAyrFyy1rOXgeAuKBTceBh6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au5O3qF/D2W3vL35NSd42JBaWy2FzJt7RhjS4tbLWVo=;
 b=VPgKpcSr/A6I9CP7099JYJlfgJHtOtrT0Sus6rWuZ0JE837d6texVu3+L46MjRgJQSBL9s1xLicGVY0X+ghJogke49nnNolgrKIJO88VZWuONQ8VZfdXJCu0kaSKGCSLSiVDCo2LziHd5ZH9CaHdyUhuNkVdQGry8OfDHoa2Wzk=
Received: from CH2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:610:60::38)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 11:43:03 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::d2) by CH2PR14CA0028.outlook.office365.com
 (2603:10b6:610:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 11:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Tue, 19 Sep 2023 11:43:03 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 06:42:57 -0500
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        David Airlie <airlied@redhat.com>,
        "Gurchetan Singh" <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        "Robert Beckett" <bob.beckett@collabora.com>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Parav Pandit <parav@nvidia.com>,
        <virtio-comment@lists.oasis-open.org>,
        <virtio-dev@lists.oasis-open.org>
CC:     <qemu-devel@nongnu.org>, <linux-kernel@vger.kernel.org>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        "Christian Koenig" <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [VIRTIO PCI PATCH v5 0/1] Add freeze_mode to virtio_pci_common_cfg
Date:   Tue, 19 Sep 2023 19:42:41 +0800
Message-ID: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c7d1c0-dc32-47dd-6393-08dbb905958a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w18isxmLh4uds0TuMTFySlMPHefR9OMiV6OifUQgY2uWoPoDeuL0dEch2X7w4im0NV/5bYIDDfZ507aHogvyIzn4+Dl5QmkF7lg/4oyf32rSy+sep4E7CoOxV+C9EUBQ3JLeIEaDNl+Re0acTwS6lNonxHEb6kPw9Mjq7vbh4ub5i6UmbqGV33qOt7dAf+gHPOeUD0hi8eKDowg9n+RW1Pui6a+bEWrOB25HoXsupldrfsDQelPfq3Xvo6cgKgfze27/4QZqfpGiYJ8uk6b5RmNmF413AloOATw8FGLuGOsspVF7Ohma2kuL+GUY+3Ci83llIVm55s8zzEo21FbRZxQJjz/RWvajMssXaY8VI5lY5cDJXW0dzv8WZz8pulIrN8uzzPyLxylx6g9KMiPdB84JCh6TJ9PT+N+iyR70lo/+xE60lreciTbIrloqWX5FJ+HJAPVPqlMrB2YQMuztrOUl3Xznt2CCz4VH8bV6QsAcBbDupS5LVIrV9KAZnbagSxBWebfCGZdaHRzK1XUoG6KBURosY1cvBhyUxNo7A/DLK9/lLEiAkZ57axmi7/CdNV7IfXQMtdiDVB+NfIrGLhCbNeqCE1EV8wxYLYw7o35QKNyn5xYIxfFzRBvUVrvIyrDT8+X1BqNUkik1sOxYuDwzPwLJapFSbLAd8sfIYJP0hQ+uKGu/d0NC3qfAc8fSWhBFcDrUtiPKkcNwbckHtJ6GCf+lZOn7GRn165NskCZjFzZb/5DTOm05M4fNlZyRpSPtikf+FMZziw/1fAeXOQSZbqNg7W1KnhWkKpGrC9JQPA/RtcJ0NmRwehk/bmRa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(5660300002)(26005)(16526019)(1076003)(8936002)(4326008)(8676002)(40460700003)(2616005)(47076005)(2906002)(7416002)(86362001)(356005)(921005)(81166007)(36860700001)(82740400003)(83380400001)(336012)(36756003)(426003)(40480700001)(7696005)(966005)(70586007)(70206006)(54906003)(110136005)(6666004)(478600001)(41300700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 11:43:03.6188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c7d1c0-dc32-47dd-6393-08dbb905958a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This is the v5 patches and makes below changes:
* Since this series patches add a new mechanism that let virtgpu and Qemu can negotiate
  their reset behavior, and other guys hope me can improve this mechanism to virtio pci
  level, so that other virtio devices can also benefit from it. So instead of adding
  new feature flag VIRTIO_GPU_F_FREEZE_S3 only serves for virtgpu, v5 add a new parameter
  named freeze_mode to struct virtio_pci_common_cfg, when guest begin suspending, set
  freeze_mode to VIRTIO_PCI_FREEZE_MODE_FREEZE_S3, and then all virtio devices can get
  this status, and notice that guest is suspending, then they can change their reset
  behavior.

V5 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230919110225.2282914-1-Jiqian.Chen@amd.com/T/#t
V5 of kernel patch:
https://lore.kernel.org/lkml/20230919104607.2282248-1-Jiqian.Chen@amd.com/T/#t

The link to trace this issue:
https://gitlab.com/qemu-project/qemu/-/issues/1860

Best regards,
Jiqian Chen

v4:
no v4 patches.
V4 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230719074726.1613088-1-Jiqian.Chen@amd.com/T/#t
No v4 of kernel patch


v3:
makes below changes:
* Use enum for freeze mode, so this can be extended with more
  modes in the future.
* Rename functions and paratemers with "_S3" postfix.
* Explain in more detail
Link:
https://lists.oasis-open.org/archives/virtio-comment/202307/msg00209.html
V3 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230720120816.8751-1-Jiqian.Chen@amd.com
V3 of Kernel patch: https://lore.kernel.org/lkml/20230720115805.8206-1-Jiqian.Chen@amd.com/T/#t


v2:
makes below changes:
* Elaborate on the types of resources.
* Add some descriptions for S3 and S4.
Link:
https://lists.oasis-open.org/archives/virtio-comment/202307/msg00160.html
V2 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230630070016.841459-1-Jiqian.Chen@amd.com/T/#t
V2 of Kernel patch:
https://lore.kernel.org/lkml/20230630073448.842767-1-Jiqian.Chen@amd.com/T/#t


v1:
Hi all,
I am working to implement virtgpu S3 function on Xen.

Currently on Xen, if we start a guest through Qemu with enabling virtgpu, and then suspend and
s3resume guest. We can find that the guest kernel comes back, but the display doesn't. It just
shown a black screen.

That is because when guest was during suspending, it called into Qemu and Qemu destroyed all
resources and reset renderer. This made the display gone after guest resumed.

So, I add a mechanism that when guest is suspending, it will notify Qemu, and then Qemu will
not destroy resources. That can help guest's display come back.

As discussed and suggested by Robert Beckett and Gerd Hoffmann on v1 qemu's mailing list.
Due to that mechanism needs cooperation between guest and host. What's more, as virtio drivers
by design paravirt drivers, it is reasonable for guest to accept some cooperation with host to
manage suspend/resume. So I request to add a new feature flag, so that guest and host can
negotiate whenever freezing is supported or not.
Link:
https://lists.oasis-open.org/archives/virtio-comment/202306/msg00595.html
V1 of Qemu patch:
https://lore.kernel.org/qemu-devel/20230608025655.1674357-2-Jiqian.Chen@amd.com/
V1 of Kernel patch:
https://lore.kernel.org/lkml/20230608063857.1677973-1-Jiqian.Chen@amd.com/


Jiqian Chen (1):
  transport-pci: Add freeze_mode to virtio_pci_common_cfg

 transport-pci.tex | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.34.1

