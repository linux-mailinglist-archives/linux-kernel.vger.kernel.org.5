Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3758F79BB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354210AbjIKVwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbjIKKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:05:22 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75047E69
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpABdvO8agxJrIaRtc43eXhzLg6kWWy92yJJP65m4x4NEhaAglBXlZR6a0kpwesvNaws3V/lzTmsRpJelSBcZhCXqdp4DG3YJDCMXBlrrF2MvBh+b4jvG2fvAM87Np0VBbVLTGxGVYLuZLyiZ8UxtzH8FB1/5OZLfKRmCdtW1W2xWNhc7nelyf07vDMsvBZ6Gg/nUc7h/Cce5Jz56p4jooDAhUFL2zyRkAcF2ZetQ7a+YtxY49wa7SRhncPDPOnK1fuPqZHWJC2SBCyxK9lHZchd3YHrxxwdPMwgO8LWd2A7dah6oFMY1EzQceR19pQv9ApJmimBSJU4F4dZIqE72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdHpyzHH33H4Mlc6VS95k1EcgfV/b4jb7137aHaRxDE=;
 b=ZG7PsWC6FjyefHT2wserml0BJqyYmTWMnF/oCIoQqZ8R7Ibnj31F++s0sJbgRSIZ6/EKmcY6iUt+Li5uybR10hMpkrHx6jPuWrIRtFMQ4csYgaET8HvqDxNZ/M1SFBiTFt+1lsznyiRqmPHx4S4LyzvDCEhymr/7YRL2znQIPXV2vaaPtui++7kTIACDtRAlca4xDLCO/dc0Osy9AI/VRiLjzsjEAzOr8nEMLYbDv57oNJ9q+FkTawDROdjShedZRSiScRIM5ZVWmGIV5zlGpP20ySBrRWqSl1cCiciZdt85oYNsc+vFX1yDWE+LSnpMnkbAQ1TZvnu9GA8YyN0ajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdHpyzHH33H4Mlc6VS95k1EcgfV/b4jb7137aHaRxDE=;
 b=GY10W0Op4oRIxIo0PN6NDCCbwjt2znAZAo1EytGpgDly/v6jbYemJvY4kX8b0+Wim8FB13ywFhnuOJ0Tr4UyrJmXbpUlzAKqPY5MgqIQYGcHzFSgHLw7ji0wjCvOpU4SHLxFA0eXuBWO7+04klXjtKd4kiQuh+qgz2UISJTOvWY=
Received: from DM6PR21CA0012.namprd21.prod.outlook.com (2603:10b6:5:174::22)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 10:05:13 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::c9) by DM6PR21CA0012.outlook.office365.com
 (2603:10b6:5:174::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.3 via Frontend
 Transport; Mon, 11 Sep 2023 10:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 10:05:13 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 05:05:08 -0500
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
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
Subject: [RESEND VIRTIO GPU PATCH v3 0/1] Add new feature flag VIRTIO_GPU_F_FREEZE_S3
Date:   Mon, 11 Sep 2023 18:04:29 +0800
Message-ID: <20230911100430.1408168-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 505cd8ad-5fd8-4917-e41e-08dbb2ae9711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmcXSaFgUdMCvTQh57wrabvN18jb1lZrEAT6L5UFdftnhCP9wcEacYyROSGaC/ZhalgRTggT+ibip2Vh+AExziqT3LG5yxy07HmX0kQgcIayFbtNzg1UmO1cPJqOqIcw07PQT+TXz9oW7eeudJYD539umf98Z68yb66sKQCli6NdbAxMMM7lXFzsf8bavD63Y0KpvVbEojjacXKw6Q40neAhqg6jXNACaRYWH48S/ysOWdkmClCTP4qQyfD/rq9zHMiG8xH/It6Ku4gt4vIK6ILSMCxTkwgURn1YX6rapxJKoC+/hch+qKRz6GzrRnQbvR5h6vVnwSIpeqvg91xq3+VS/JTrp/YIM++dzYMadbFhszEYy1ruG7+poDcGD6DbhHZEt3XMSvf//s39rtwcwMlSicMlj0HTo5BiTWFicpkf6uFVlwwIexWUnjfH/VJw4V2b+YdvWJpkifo9AnHFSZwiQoSNv50+Ta/xn+lQSdqaH4Ho/lTEF0gwHcZyXesDt7QyY9hAIU/66MA/RSuCcg3q8oRr6svYUcjdtjUSMAYpAxUqa0pA7xl1ody6qq6pnaMLduXhkEZ3Lc5QDXzyO17uo2wBXdktArHzAeadYNYXjXmzYwo2/Ad9wC2ycyPaFe9eC2Ck5qQCbRwZ1PwT/ih0okKSqPqpVSug3jjVrsps35h4Y95cQlGzJG4jEaEi4OlVKBiVoL2tRO6CPcxe2ivcNzAdKF8vl7D8IBrmHhvvgKvHOsznRKSXWM6hxUkO2k/nqy/rE/EV3j1JMn994xH+d8PXhMY40ZDhG4IPpII=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(8676002)(2906002)(40460700003)(7416002)(36756003)(86362001)(82740400003)(5660300002)(356005)(81166007)(40480700001)(36860700001)(47076005)(8936002)(4326008)(83380400001)(426003)(336012)(26005)(16526019)(41300700001)(1076003)(2616005)(7696005)(110136005)(6666004)(478600001)(316002)(966005)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:05:13.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505cd8ad-5fd8-4917-e41e-08dbb2ae9711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857
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
I hope you’ll forgive me if this disturb you. Since it has been almost two
months since the latest patch was sent out, I didn't receive any reply, so I
rebase the latest master branch and sent it again. I am looking forward to
getting your response.

Best regards,
Jiqian Chen

v3:
Hi all,
Thanks for Gerd Hoffmann's advice. V3 makes below changes:
* Use enum for freeze mode, so this can be extended with more
  modes in the future.
* Rename functions and paratemers with "_S3" postfix.
* Explain in more detail

And latest version on QEMU and Linux kernel side:
	QEMU: https://lore.kernel.org/qemu-devel/20230720120816.8751-1-Jiqian.Chen@amd.com
	Kernel: https://lore.kernel.org/lkml/20230720115805.8206-1-Jiqian.Chen@amd.com/T/#t


v2:
Hi all,
Thanks to Gerd Hoffmann for his suggestions. V2 makes below changes:
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

Currently on Xen, if we start a guest through Qemu with enabling virtgpu, and then suspend
and s3resume guest. We can find that the guest kernel comes back, but the display doesn't.
It just shown a black screen.

That is because when guest was during suspending, it called into Qemu and Qemu destroyed
all resources and reset renderer. This made the display gone after guest resumed.

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
  virtio-gpu: Add new feature flag VIRTIO_GPU_F_FREEZE_S3

 device-types/gpu/description.tex | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

-- 
2.34.1

