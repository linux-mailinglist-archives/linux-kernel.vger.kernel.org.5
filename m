Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA37D7076
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjJYPMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJYPL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:11:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F7128
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 08:11:52 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=XtPXgxB57V6n1MPpsofiVrQ0BlkYzkC1fwDew9gaDWqdvnFxRz37J+D+RAaR0UggVbvzi+s9qTTyss3+8HTtPsUAgL6P0m4v/igiyaLv7CsgT0Mk1PQY4H6M9tKuoz1ypXL4nRD7IHoTJn5Mh6MxHYrFmDLzI+VYUHpUoZvGvUz/nLsxA0gK+df6lEdILu1AcrTFublbzngTHfkyYdAHbgZWq1Yte8R6G1CEzANtud5p/8f9eEGCEE0tH2DOxl9NwSgzqtAAwsD37SvgMTyPZnjXKDh4qSgOQJxSOwhUc9fBY9waPeWMPGzsueV12pltx4vQ3zOqoZXSQ/OTvBK7vQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac6tAgThnwUoTXpT6dH0fSf4M5O/Gv2Td33A0mwXxaQ=;
 b=OawiK3JuY57JyxYotoNIjFP6noGtsxx9PIgeRRhruvvdavQ0aWr0/0dgq6mBcJqPI+tMvkeRoixF4K44XGC4eFzOp0U7nQ2xynLJVQQ0KbBfuYD8RbxOWyUbMdzomV39PlK9SHbv5YBDsESVOg5VG7/Ugrt4uMP61aMH+4IRj+/KcjQYTq4UanXPd4/kOc0PQcR5S4FOxytgk3hg8Y7RLrxS/UWojSymFQOhnxQOn/iug4TDVdkqzpbxxl22F6xkRiUVUqzx7w9sA+Z3ik1amS7QRgpH4i9n9f1f7c+QOb9vhZrTVvmUfWDyBIb0nWZ2z3m7RGa+ZGYYy8JgWgFxJg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac6tAgThnwUoTXpT6dH0fSf4M5O/Gv2Td33A0mwXxaQ=;
 b=cGsgmDvyn2JCPF2p7Cnfyr2P58kY1vvp0co4FEO5llkIWPg+DCfGlSZkMrztPSO3Z+MSi9oVFtOomoi3F7WVyjFMEta57BhSYJlzQTagMUv/fulplojlGsJfp+cYkP+GaB5cg3f3r8bzv9J2S8mt2o6amXkYY5fuT2I7S0i+qqw=
Received: from AS4P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::7)
 by AM0PR08MB5346.eurprd08.prod.outlook.com (2603:10a6:208:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 15:11:49 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::43) by AS4P251CA0019.outlook.office365.com
 (2603:10a6:20b:5d3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Wed, 25 Oct 2023 15:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 15:11:49 +0000
Received: ("Tessian outbound d9a8e74be042:v215"); Wed, 25 Oct 2023 15:11:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ed5a77ce380fdfd5
X-CR-MTA-TID: 64aa7808
Received: from f4bec29366ee.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5A7ECDFA-9A7B-4B20-81B2-16CF7B4BA618.1;
        Wed, 25 Oct 2023 15:11:42 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f4bec29366ee.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 25 Oct 2023 15:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEVohUbqxup3npwr0e52ggubQrT/KqmjQ5o29m/SyVu2VCm1W/Zk6e/uSlBb6KP0YqyVz4FHV9diI+VrBFQcBqYDANs4Ebk4DMlFA2EBpLwUotL6r3va+jSu2a9vLirjUuHXl23mzLpaxDtNyd82oo0gLHYWrZmZklpYGwAgOXjJwklgQbJG7V0LrX0m089C+y+rFkVd0YgVMXbzz3W/f2tM47KZ+z+UqWmrx5ycfv1sO709ElbjSu+gN8lh3S9e3p36LtCKmErlVrDogzHlr5oXIiac/IOEiJXRiEfM0iOn4TeAldYK6fgVzNamFxb6MyGs04kegr1Tuchsf1n56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac6tAgThnwUoTXpT6dH0fSf4M5O/Gv2Td33A0mwXxaQ=;
 b=j/hUy7KdUyuRzw1f8tZP0YZ65ucDl/GMmOEn8iotwMhNGUpHwg4IEVOyjhqMpJjoQCtyutkd6cJWiTrE0owLnxQOBQXrYmCPj5Qs/hgHwjUcPTbP7tvetvqAs+triCJ5XGWsoi+YHXDVoYI1D/u1hzqzQ5WvjSiC132z6DdlmPRcfIaDfok66yXK2N3AxKtlVaY4/sarQcmSVqGA31SKFzScnqQ2r3o2srF/M+lfYzfVcEInla7djFfJt+/rtSBlWOhnlKDCPlbT8wk1OHLB1nANXphFC3DRMlxYVDoePrYfbK47wwOOUyRlDgLA2wX1PiFoKZJVSVeWtET3DTOWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac6tAgThnwUoTXpT6dH0fSf4M5O/Gv2Td33A0mwXxaQ=;
 b=cGsgmDvyn2JCPF2p7Cnfyr2P58kY1vvp0co4FEO5llkIWPg+DCfGlSZkMrztPSO3Z+MSi9oVFtOomoi3F7WVyjFMEta57BhSYJlzQTagMUv/fulplojlGsJfp+cYkP+GaB5cg3f3r8bzv9J2S8mt2o6amXkYY5fuT2I7S0i+qqw=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by DBBPR08MB5884.eurprd08.prod.outlook.com (2603:10a6:10:1f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 15:11:40 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::eff9:51cd:788c:cdf]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::eff9:51cd:788c:cdf%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 15:11:39 +0000
From:   Justin He <Justin.He@arm.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: RE: [PATCH v3 1/2] dma-mapping: export dma_addressing_limited()
Thread-Topic: [PATCH v3 1/2] dma-mapping: export dma_addressing_limited()
Thread-Index: AQHaAC/A5SmqvDnr60Cv0UxHfdKNELBW7ouAgAO7NoA=
Date:   Wed, 25 Oct 2023 15:11:38 +0000
Message-ID: <DBBPR08MB45389A8B34B3412F904126BBF7DEA@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20231016125254.1875-1-justin.he@arm.com>
 <20231016125254.1875-2-justin.he@arm.com> <20231023060919.GB11907@lst.de>
In-Reply-To: <20231023060919.GB11907@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|DBBPR08MB5884:EE_|AM4PEPF00027A5E:EE_|AM0PR08MB5346:EE_
X-MS-Office365-Filtering-Correlation-Id: 028ab9de-fc7b-42ed-9c42-08dbd56cb615
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: eLTk46SQqMf2p9xq7drjgxHnw0FlJvB7YRxgirGSSHDNd2+SxYCBsYwgZXhWiXEfKGNNSLN4DDQKOA7BCkAHOkORZDxYj96ICmnbwlA6R4GE+6W0fk1ZkbVGJyv1xNP9nAp8wYzqUO5ez8NhfY/zDajdH7F+v3BpoAP5ImxfeXf5cFoZr+iGrm7HcNAKnTVQdPE4ay1ZsDuj6e0qmTz5n07PnBicFPSedycTXU2u3CfosY5pQS0fck0pgGIfcNRzYWe4DdzQnDxKz9cFM114BAh3J+THqp1kGXVXIiUuPgLeCYUVq2ztf4nbxf36J0+6KgZVJl4rbbvs/FQqDvPqLQfYg3P4qgz+vLvQZZuQGBnp720qsquhBpqn2h4b07gUodF8avxcN5qIs01pgyKbVUGVoOtYlhoi0OyX4L32JqKgCa6UwL4vocLF97g5ZX/Rk+RVzAd2j5HHPyzSKDPxAFESn7EIOENv/9w4yQ1x6bdfwrBsJdKJ6cTrjDF9n28ueP394wFVgCq32duL5mtmeTlmU/kjpiW4t58cTt9B/yacxb7Tw7x6s7DjwonEjBpRWW8mQe/MSmY5CwfIQ0MZgmSnP4RFl0m8aEqK7CiX2DPK83KCII8eZqrLbRxYVWCG
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38070700009)(26005)(55016003)(38100700002)(122000001)(2906002)(4744005)(5660300002)(86362001)(4326008)(76116006)(8936002)(8676002)(33656002)(6916009)(54906003)(71200400001)(64756008)(6506007)(478600001)(7696005)(52536014)(66556008)(66446008)(41300700001)(66476007)(66946007)(316002)(83380400001)(53546011)(9686003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5884
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7cf51d93-d166-4016-f8f5-08dbd56caff5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dszKjkbOaEEH/1MoXOXm9fgml4MVStnKl+Z3706DKOUNirtofmcnez9A5jIvCIx6zeOKwNKh2IM5MPqlUBUKCc8FNFSYG2L+zpFfWhYeuUdqtGQ26lgfxFP2xZU216ImURHljynnn132HU7mumhbI+rAA3j+KMLUEnGmInAlPSoiIpSq8Mc5dmbrhRu3GnotFc4yWQ5UyuDY9uJB0z/6G8Nm6sUcqhwJGnh+8/EzYitC/qOaQpefPzCmV3KL5ECxk6pFMwQ0Bdd9is4oIErE1TrtEMefJdc4Ikz7GtHVHpNzlahI65iPyjz3kaUYDC79WR7ub7D4ZDXNA3M3VbSa4itK8wW7Q7ut3ojGKKzzbw9sXYCLgOLf7OSNGJeJB8XHF+YbBv3KOcDQsd1L6xlxqWHU7w1PEr2EL5A7a9kq7qJDnK75MrAekQ0U8asVoI7T+/CF7cJjqGR79jnD0q2D3D6a2gEEZ8IGcYQ+57Kbaa5CxRE+DO4g1e+jZa77QBd3XDlrdLk/qsePqe5fpf7QwUTcOX+uEH9xI+ZT+Y0zdBVS3Xxc0h1+1RlRmi/fkuZpvKasDnYnRpR1IP9PTcnqpmHAs3xBMOJkAWc8Wh3rQoWyVqKQgoVvgk+VODoRm0SFK6QyPL6BYasnalyvoKcKkLxHZ0NF19wS/ktlAaif9ErZ08KxSQBAuYCfagQRkHsuyRfPXwODYWMTUaF0Wa9x0rJY3NQMeAFgsMQXcWz5A40CUnkCvs3bBAfJS6NGkBBY
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(4744005)(40460700003)(36860700001)(2906002)(86362001)(55016003)(41300700001)(82740400003)(356005)(70586007)(316002)(54906003)(70206006)(6506007)(7696005)(478600001)(81166007)(336012)(47076005)(40480700001)(53546011)(9686003)(83380400001)(6862004)(52536014)(5660300002)(33656002)(8676002)(4326008)(8936002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:11:49.0642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 028ab9de-fc7b-42ed-9c42-08dbd56cb615
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5346
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, October 23, 2023 2:09 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Robin Murphy <Robin.Murphy@arm.com>;
> iommu@lists.linux.dev; linux-kernel@vger.kernel.org; nd <nd@arm.com>
> Subject: Re: [PATCH v3 1/2] dma-mapping: export dma_addressing_limited()
>=20
> On Mon, Oct 16, 2023 at 12:52:53PM +0000, Jia He wrote:
> > This is a preparatory patch to move dma_addressing_limited so that it
> > is exported instead of a new low-level helper.
>=20
> So while this exports dma_addressing_limited that's really a side effect.
> The primary thing is that it moves the function out of line.
Ok, I will update the commit msg.
Thanks for the comments!=20


--
Cheers,
Justin (Jia He)


