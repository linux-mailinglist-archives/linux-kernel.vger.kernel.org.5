Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344C07C9D92
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjJPDAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPDAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:00:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74757A2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 19:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z5FUqPAul9xuRJ785Oz1m/J72UEr0eduwIwUquJp0Q=;
 b=V/EGfnIs/vWB5tZ8mkIQOYCYzCPaOt2yj1/nHTk6Uiu73oXMUzQz60SJv5EIg70k+fJQ+cXbO5FmqkppH/KUnYzA5t+Z838xL8N2VZnt9xwFTN87wFeahMWmOQpIqgn+Tjvfkyfqg9S+7E3XyOUZijNnP0ehvK2jWfgYIlGMHLw=
Received: from DUZPR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::16) by GV1PR08MB7729.eurprd08.prod.outlook.com
 (2603:10a6:150:50::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 02:59:46 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::17) by DUZPR01CA0009.outlook.office365.com
 (2603:10a6:10:3c3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Mon, 16 Oct 2023 02:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 02:59:46 +0000
Received: ("Tessian outbound 6d14f3380669:v211"); Mon, 16 Oct 2023 02:59:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ef68b58fdbfd5d05
X-CR-MTA-TID: 64aa7808
Received: from 9148f8481325.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DF37B6B1-E3B3-4C8D-8434-C0B04A6ACC49.1;
        Mon, 16 Oct 2023 02:59:40 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9148f8481325.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 16 Oct 2023 02:59:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxSpPDJuGkEvH5/CI5JScqR7Zcu5Ry5LmhAWH0vfBJ2Au9YBp/jROoN8MQG1j1qbvFwcq4g6qUsRSZ2d0vTWD76l9wLjGi8iMw/SelqedCFsnp6ddsPvJxTmHiV2eXlLDcGa4CJPDEtklEKUmTa84/Wu5N0Fd9aMJFr4f0PxO2VCCy/dYkttRiTd+10clM3wUtqqckIFhmI1nTNtiKUbhXYWbKl2QX82oLZy/Hp6sSLOimmd2lYdwAmPvx8nCyWQtiRJvfKfPCLY19Gy0wypl2PrdoiyzNH+GSDYdMWf8hapc37rbbi9f4PVL7rE1XQAXVF6pgOwgFe62GhIU5weBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z5FUqPAul9xuRJ785Oz1m/J72UEr0eduwIwUquJp0Q=;
 b=S76eLr4EJePrmnX/OqNdyf9uz2ZiRZk5Zl40W+Use7/si5JdnJuxD+TQLQckpEstlYpfgwOU+r3swOZ70kQaUIou3SMur6fjhJDlPREyPYbpX4QiH7z/03O1l4IESGbqcwT2b/Lr5poHo+ggUIduqnMQj8R8twZiKCFuHy9hbv1F/xAt7LSx+9ZF4g3UgfKMozBk+9VdIajWhfAseAGGKA59XHzIncU9GSaqfmLonWN6obO4REcwIys3I1HhufpkYtaDNaXdyAKWwBit0bYnnigQciWXZw4qWIeNxVu7SLqabXP/EAOQxJPMe3PA+Oa3436ZGjWhE3PXFlfV2UiTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z5FUqPAul9xuRJ785Oz1m/J72UEr0eduwIwUquJp0Q=;
 b=V/EGfnIs/vWB5tZ8mkIQOYCYzCPaOt2yj1/nHTk6Uiu73oXMUzQz60SJv5EIg70k+fJQ+cXbO5FmqkppH/KUnYzA5t+Z838xL8N2VZnt9xwFTN87wFeahMWmOQpIqgn+Tjvfkyfqg9S+7E3XyOUZijNnP0ehvK2jWfgYIlGMHLw=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by GV1PR08MB8449.eurprd08.prod.outlook.com (2603:10a6:150:81::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 02:59:36 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::4dfd:1da:8b2d:1afb]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::4dfd:1da:8b2d:1afb%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 02:59:36 +0000
From:   Justin He <Justin.He@arm.com>
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <Robin.Murphy@arm.com>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dma-mapping: fix dma_addressing_limited if
 dma_range_map can't cover all system RAM
Thread-Topic: [PATCH v2] dma-mapping: fix dma_addressing_limited if
 dma_range_map can't cover all system RAM
Thread-Index: AQHZ+x6+h/4wKq8NfEOap6kHBNK73LBCpgQAgAAfbACAAUb4AIAHtrJQ
Date:   Mon, 16 Oct 2023 02:59:31 +0000
Message-ID: <DBBPR08MB45385F76B0564DE1D8FFB6BFF7D7A@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20231010020835.3678-1-justin.he@arm.com>
 <20231010074816.GA9082@lst.de> <39d5aabd-4c09-4135-a3d7-00f6da7a1684@arm.com>
 <20231011051100.GB32642@lst.de>
In-Reply-To: <20231011051100.GB32642@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DBBPR08MB4538:EE_|GV1PR08MB8449:EE_|DU6PEPF0000B620:EE_|GV1PR08MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: e036c8e3-5829-4f72-3264-08dbcdf3f43c
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0in1Fw8UUCro0koGbtuN4oXo7Pe6+DmRLEN8QzuAo1/IUizkjLuE4Wwv7WUgKHjdpvzsyfOuMQygcjybGnJQf1ct+8f/RmfVeappiSb+73AhTu2Jz6wR3TMmhzhOaomCbG/cn/vKVCBHvH18R80R5J9BTKpDazx3nonn98qfwGs3zVjOqbVesdJnTFKlxUfe1RfwwGX9p2nC2MWCOrLQdY+yB4qCgusysf8fgxETKa6kWNv3dQa8jBUQvshKgmFfQsWRCZmioV5VmafRdU5ALMZREqXW6xCDd2hdU+lg9wq/Q5dOcJ5sbshK43Vw349xI9HFQG8eq5Y9eeaG4Px2NJ/aV98FNlL+1hdcpHuB5ic8V18lXlK91EUx4Kig9lHOou9AeS5tgU0O7m4gwtdvYtJCMmPdJHHKwHi8QE7OEaJGQzJMNAiXC0ECynVt67q3f6ZBAjwz1uOFqt2o94jI/NnnJpl24OZx7nsWF16igaJnMPjIXcZShIE/V/63KWIivn5xNA+4tvjlnFVld4MeNiGBxr+5k85/p4ncZzO9uh8V5/clUs7+mih1lrIyIZTBn4Ls0JNO4Iaq24SJc0swzw2ugXMGejxpVjsl0ju1D0qQxLxV9JUaNjeYZu4hmq2M
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(71200400001)(6666004)(76116006)(110136005)(66946007)(6636002)(54906003)(64756008)(66446008)(66476007)(66556008)(26005)(53546011)(6506007)(7696005)(9686003)(316002)(4326008)(8676002)(8936002)(52536014)(2906002)(5660300002)(41300700001)(33656002)(38070700005)(122000001)(86362001)(83380400001)(38100700002)(55016003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8449
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 631569c3-8e11-4abd-da8c-08dbcdf3ebc4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKN806dtyBiMqzvW9pjb+On3yY1z6a//eehA+xAzxJzNN359kIaLGW5Mi/nCk+yCXXOVhDWuOx1jP2qh7yTnUw6fCRbjqoKSRqprMPwSKtDfGxDTK6dp/r65ECwUSPkIjYrT0Nklv9CObzTpWUNe30rAeePENWBWVb8u+aGm/hJVzCOkFZWVXp7Py5cn6PS1yGUdZ497owefIJIQ+IHVe5G5ovnA+rOtYwB0XNV7H2Og1g+X8rNBmIYdJsArqiZyjL7MSjalV1rtbYWisIDibp7BStI9A5Moskrrm/zAY1y6+G5NmhErFB/5ECn9+VtMhMOXLNt2I9AZmve2EG53ADlO8hOxgyctvO9ymodQT9YeigZSScv+VnT0b8KsDc1Y+bwCeHLoNNkE9FYlTYHmloDZPxiwDfaHO7Q4YXoDsQT1417gLPQ+JF4I/5aDoNDmKEz49EHHbTO6hQVGJW/ijJHlw7y3b4wcuKyf9DNLhTFRlmogSPJouwbMxo39AWTOqCPqpj+W0I1LAH/n7ggdfKY1Np6iYDx+nr79i+BdaQ1Z5jlk6VOxy1i07y1gkq+PZZsa1PyuQYEVppSA0+b9r1I1kq+mC1YGveB6YJLl6vAMOBBdj+v+3Nzn6J8EWHzdgE/JY7zjdGmsW8s+3BsaRcDveRHeWJBLDfnAYNKZFvjksrLVzX3+8vVALhA/moKOlGaGk2FRoOVGh4GJQgjGrQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(46966006)(36840700001)(478600001)(6636002)(54906003)(70206006)(70586007)(316002)(110136005)(336012)(26005)(7696005)(6506007)(53546011)(6666004)(9686003)(4326008)(8676002)(8936002)(5660300002)(52536014)(2906002)(41300700001)(33656002)(86362001)(81166007)(356005)(82740400003)(47076005)(83380400001)(36860700001)(40480700001)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 02:59:46.1389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e036c8e3-5829-4f72-3264-08dbcdf3f43c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7729
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Wednesday, October 11, 2023 1:11 PM
> To: Robin Murphy <Robin.Murphy@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>; Justin He <Justin.He@arm.com>; Marek
> Szyprowski <m.szyprowski@samsung.com>; iommu@lists.linux.dev;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] dma-mapping: fix dma_addressing_limited if
> dma_range_map can't cover all system RAM
>
>
[snip]
> Ah, indeed, I somehw misremembered calling it in the mapping code.
>
> Justing, can you still respin this a bit, add a prep patch to move
> dma_addressing_limited so that it is exported instead of the new low-leve=
l
> helper, and fix up coding style issues like the overly long lines of poss=
ible?  If
> it's not perfect I'll fix up the rest later.
Sure, thanks for the suggestion.


--
Cheers,
Justin (Jia He)
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
