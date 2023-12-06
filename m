Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A246980707B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378374AbjLFNDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFNDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:03:11 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84031A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:03:16 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=XyLDM4dMxNBaTYpKC43Fl/qYpNWG9Z2YA3PgPTxnUgV0972nDi+1TvgguFO5Spv0BH+9pJFp4ohVCfPG9HswSbCSqwyk7mVC72DfT/BKuOV6Flo+81MwiBUYOpkmRFO9srlhXm1ENyRaV/QDLxpe9rU04p9+auuSBnlqoEY3H27diNV2IP739kndLACON9BwvQL6c8+XCNTNWyfnreDzIAol/NXVDQFHSxAT7eCsaPrw9l7GW9zHdht+1WqVPcyIrxA1bhecID2XhAYFvuUztafG5ygOe+M0eU41rH4aX1FFnwsORmZ8TlcZUYJtd+xOrP3FtUt5O7uzfopoiMLb5g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvfIfHmgmpB9ky5wnbF0MbG67mfX80e5ayKXxcghpqA=;
 b=Nghc4TGc8ROAovzIgUbcrj/beo5PYM8MBwwLbCpMgz1stlxu3Anm8LlgKMmmMpRwbWqmrTvYIO8J3iu9CEMlzFvDXcvSoFiG0PVekQuRS8KfC9nG1vEzJMSoFsk4gsS9DxnNaGhvMpXgMotWFcEeJMoTK5eJh9rmCgSYvKTOevBVl5vy/cIBrBW7jVgJI/9m4HKNr1Sl2gjgsSlF/isDFVmDXBkObfqA+LWWktsLmBzeQVPji/OYXzBkgexVzxkdkbcxx1/8BunHCUQIsfJXwwCJ/0P7bkvdSGl7qHZIRg92BxFyUYhozY7gc2v/6lCodJiDd08dZKC6RYKFle/mOA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvfIfHmgmpB9ky5wnbF0MbG67mfX80e5ayKXxcghpqA=;
 b=z5H4ktSaDvMEeFEABLFGsbayBW8h98yaOvIWrUd4EvZ9xYV4+Mhlml0o/Da738FAmpoIjlgankWAPQRBNMSySO2aE//xZfVvjXqEDSskdyMoRwXLYM8wi+8huruyWsNasROVmUuCleClo6vFI+usRrlN48jiaPcAhUkRpSgxqv0=
Received: from AM5PR0101CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::24) by DB8PR08MB5402.eurprd08.prod.outlook.com
 (2603:10a6:10:11b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 13:03:14 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:206:16:cafe::ac) by AM5PR0101CA0011.outlook.office365.com
 (2603:10a6:206:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 13:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 13:03:14 +0000
Received: ("Tessian outbound 7c4ecdadb9e7:v228"); Wed, 06 Dec 2023 13:03:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8cf71a8632bdbe35
X-CR-MTA-TID: 64aa7808
Received: from d9939670322c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8AD9C85E-0FD2-4A00-8080-C1C2B90453BD.1;
        Wed, 06 Dec 2023 13:03:07 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d9939670322c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 06 Dec 2023 13:03:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGRpzL3oyv40HWWDPG0rQGPHRh8djt6ej0Y13VwLXoSjVx+o26hGROoGA0U4CQXYHGeKQJOBgboLjies/Qa8ho7S/wRwF9Yb1ZpnpAdytR+l92L3Id3eYAp3wGeI5qWslCuqxkEM9mXC7mMhV+xQVmzwqFv2SaGwLCJF5Y/vNbMS95hg9o50fo0KTqxe1mYNRW2OZW/J+I34tiOchyfkiHcvuYbb/QqBSCyjry2fzdSgrDmc+UPIuCDd5eivBOHy160G6RoGRK752TEspr17ZzagHcPQdExgu2OuFPiWqGUc8W2/TpK67AI6nilqxCK/Y3B6UmNMptu/HqrTEGk46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvfIfHmgmpB9ky5wnbF0MbG67mfX80e5ayKXxcghpqA=;
 b=cPwhbmFREaUvXzMT5H1oDymoeuyitGl7IO1pwV6zgWfKP3PvdBork4Ce6segyMQhKw0woXNzzlMPa/5ijHpBIyirKeO3cxWYAVth+RQmujXGPPLwp1ybRGLl1kx12MYH7qZ+yH+0Oaxbf505eD8MhD5VGZqRMNqA3LUpLKuz7SKOFSw02UUutYv0ew+lsSDl9G0ykmLuOoG0FX40+qrB3nN+lJzH1gyPXJrUO6arPXrP2vzkrZOGBDwUSmNy2b8D6v8a9oMww9IZwyfzJTW02gx7N1hYs1deOIkDh0GxqAnLkDNKkW98RutvZQG3eyTB5fJA85hJKdLr8GtmBve4Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvfIfHmgmpB9ky5wnbF0MbG67mfX80e5ayKXxcghpqA=;
 b=z5H4ktSaDvMEeFEABLFGsbayBW8h98yaOvIWrUd4EvZ9xYV4+Mhlml0o/Da738FAmpoIjlgankWAPQRBNMSySO2aE//xZfVvjXqEDSskdyMoRwXLYM8wi+8huruyWsNasROVmUuCleClo6vFI+usRrlN48jiaPcAhUkRpSgxqv0=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PAVPR08MB9460.eurprd08.prod.outlook.com (2603:10a6:102:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 13:03:04 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::4624:7666:7948:2d64]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::4624:7666:7948:2d64%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 13:03:04 +0000
From:   Justin He <Justin.He@arm.com>
To:     kernel test robot <lkp@intel.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, nd <nd@arm.com>
Subject: RE: ERROR: modpost: vmlinux: local symbol 'dma_addressing_limited'
 was exported
Thread-Topic: ERROR: modpost: vmlinux: local symbol 'dma_addressing_limited'
 was exported
Thread-Index: AQHaKANWpWdF4JQR30WUOtN4ZSggm7CcN7mA
Date:   Wed, 6 Dec 2023 13:03:03 +0000
Message-ID: <DBBPR08MB45389EB25B0C89853366E5D2F784A@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <202312061307.TwC5Kt2r-lkp@intel.com>
In-Reply-To: <202312061307.TwC5Kt2r-lkp@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|PAVPR08MB9460:EE_|AMS0EPF000001A8:EE_|DB8PR08MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8733c9-d9eb-4e0c-d17a-08dbf65bb4eb
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: kK+ZkX16Lmu3yGpsvsnQVqkTDMSmYaTHYEvw0C6mefWMUjQmZSPSGh8cKixzc5p6F0O5LXxF4+qfyplhHp6JPqDoHoY0y5lUzhh411tGwcnXAi8FjFf2Xy2iuJk3CmYhIYGckYSQccibZVmd4RM+bN4xpX32IBwRZVx1BHUGmccwZQGI1Z0IEGdG85knhUK/ZVw7pqbjjNsbOEPe5cWJyEk6QzUXpkioNKYvq7joJFOAQwMh7ejZnV7/xlusc6lf8WI/dWmAlnMtiB191UmqZH5HT29bQypCUiZv235k0kwwQhmEnR3vTcgKwUD7KYe3PTz5sdEVdNfixm5WbFTsoQ36tN2dXjsOdv9hDNWqJCsmOFPXmA58o/12mBvdL/HGTlxZXSy5bIdqvuZwCC2+3Hg8nyNESkHwK48rW8U0T83mJui2+HLTI9esTPb8/5ZutXzh3YNykGuAnwEj6usoSo0+/LBeicPWFMtMMAdkEWrvl0yGqQcjBg1TXghCXq8uRTrnAmyAeoTfli5FJJYLV5iiSxI5yZunosVN9Vxm+Pwv3lwgWkYWHtGa4/iG4MEI7Xljme4IJwUHcP8GLZ0QncNBIgPCYocLf9W+C+AoZEz3FwjLy3XB1RjkjQyv09MKG/fTUuApSCJ38mMM7P5+tO+x5A5jJYzNjol6Q91Ws1w=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38070700009)(55016003)(316002)(478600001)(7696005)(52536014)(8676002)(53546011)(122000001)(6506007)(71200400001)(26005)(64756008)(4326008)(9686003)(76116006)(54906003)(66446008)(66476007)(66556008)(66946007)(6916009)(83380400001)(8936002)(38100700002)(5660300002)(33656002)(2906002)(86362001)(41300700001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9460
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bd34a217-0e08-417b-ef09-08dbf65baeeb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZ/Oai+PA2BTHu9LWoNKbberRkV7kCn1pUPIoH3f2GF+ek83Sc1TLmj1Bxy5NPQmag0o+nGJq2ixpsoYzSh2iaO7AU/Co0B/GIuDN8jUs/Ws6KC07Z2mmbZZYKA/KQjYctr5AESPTlV7EgF6dAgr7FFps9Lvba4yNCtWEM0CwspaQYessiPuJjnXszh6OBjo6d5zl5zS55W5ExmTCs6n5SyPtUuH+vmiATeb7rcRKDMB+WvTm65sneBhemDevZprrc9JUvVTMNGbRKWvd28FI3rbZTdtbdDzVCrRBkfoaYnswv2rwdRhDysO5I3YE//Zu8SEN2RgIXRG+lCH6TvyuMxipwiW3XYY7xL2cS4U0GL2qIY7dz0kJKLfmCkncHXz5GJe20M5Ko6wjjk0bD//GTYTjrJ6gSgSdkXi/BX28AIuPqDTVSQtHaEpIxI5Bnugqou5YvX/xAK8IJVeyNuQttGlCNwUmCgFva+u2G4G6o6Yvfr573iufUo8eTrqwzK519LCNXTUzIYlQ+JbFCiY99Cbwfeg2ACSHM9CVZS+7InTI6excB5qjm4mUbpsZtL5vQc4HKSbu+2hAk/4w7QJSIS4liVjPBoKtHZq1awlKmxw0NHtIC6A5ggZR2yntev9oYKsvLFF+gyMNkBzwW4oG/9LquSwVDSUqear5lVb30+zzxXZ7srqNR60YKUmOu0BujyD+TLkCEPjYU8bFQs8txyf7CXihL8FGNqimevfAO1zhYT1+B97QBA5BU8KWpBucTpm1HRM8HDBMFw85s83eFFxKjYqC5P1BirLI7D7rqI=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(356005)(81166007)(7696005)(6506007)(9686003)(53546011)(26005)(336012)(55016003)(40480700001)(54906003)(70206006)(70586007)(316002)(52536014)(82740400003)(83380400001)(478600001)(6862004)(4326008)(8936002)(8676002)(86362001)(40460700003)(5660300002)(2906002)(41300700001)(33656002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 13:03:14.0242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8733c9-d9eb-4e0c-d17a-08dbf65bb4eb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5402
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, December 6, 2023 1:15 PM
> To: Justin He <Justin.He@arm.com>
> Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Christop=
h
> Hellwig <hch@lst.de>
> Subject: ERROR: modpost: vmlinux: local symbol 'dma_addressing_limited'
> was exported
[...]
> ERROR: modpost: vmlinux: local symbol 'dma_sync_single_for_device' was
> exported
> ERROR: modpost: vmlinux: local symbol 'dma_sync_sg_for_cpu' was exported
> ERROR: modpost: vmlinux: local symbol 'dma_sync_sg_for_device' was
> exported
> ERROR: modpost: vmlinux: local symbol 'dma_get_sgtable_attrs' was exporte=
d
> ERROR: modpost: vmlinux: local symbol 'dma_can_mmap' was exported
> ERROR: modpost: vmlinux: local symbol 'dma_mmap_attrs' was exported
> ERROR: modpost: vmlinux: local symbol 'dma_get_required_mask' was
> exported
> ERROR: modpost: vmlinux: local symbol 'dma_alloc_attrs' was exported
> ERROR: modpost: vmlinux: local symbol 'dma_free_attrs' was exported
> ERROR: modpost: vmlinux: local symbol 'dma_alloc_pages' was exported
> ERROR: modpost: vmlinux: local symbol 'dma_free_pages' was exported
> ERROR: modpost: vmlinux: local symbol 'dma_mmap_pages' was exported
> ERROR: modpost: vmlinux: local symbol 'dma_alloc_noncontiguous' was
> exported
> ERROR: modpost: vmlinux: local symbol 'dma_free_noncontiguous' was
> exported
> ERROR: modpost: vmlinux: local symbol 'dma_vmap_noncontiguous' was
> exported
> ERROR: modpost: vmlinux: local symbol 'dma_vunmap_noncontiguous' was
> exported
> ERROR: modpost: vmlinux: local symbol 'dma_mmap_noncontiguous' was
> exported
> ERROR: modpost: vmlinux: local symbol 'dma_pci_p2pdma_supported' was
> exported
> ERROR: modpost: vmlinux: local symbol 'dma_set_mask' was exported
> ERROR: modpost: vmlinux: local symbol 'dma_set_coherent_mask' was
> exported
> >> ERROR: modpost: vmlinux: local symbol 'dma_addressing_limited' was
> >> exported
Since the dma_set_mask/ dma_set_coherent_mask was also in the error list, c=
an I
consider it as a false positive warning?

Besides, I followed the reproducing instructions and got:
# nm build_dir/vmlinux |grep dma_addressing_limited
ffffffff81b2a974 r __crc_dma_addressing_limited
ffffffff8008ac36 T dma_addressing_limited
ffffffff81b330b5 r __kstrtab_dma_addressing_limited
ffffffff81b4e5f2 r __kstrtabns_dma_addressing_limited
ffffffff81b0aec0 r __ksymtab_dma_addressing_limited
Seems dma_addressing_limited is not a local symbol, is it?

--
Cheers,
Justin (Jia He)


