Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FBA76699B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjG1KAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjG1KAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:00:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA81035B6;
        Fri, 28 Jul 2023 03:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxsV2UpOMINQ2BMmzyIAgQjINKzjEGmfcGdx8IbO88DS1z5GRAvxSMNKxWEiCSS6eMiS+X/PZWFwx6eoB2W5iI8BkA4Ea08E00MeEvdGAtS3+Rw0xrIZTu6uRDzwItUQv92SA5VbVrSDpnoYxY3Q6EPSiYeFtjgP1aWeOJLtK5W1qnkN+CFbBsP611earqL5DEbvn3fb6QBb3GRRETqxyF6bx4BNJ2Ky2PvmKrGAZkCU6xLpAHOLmVBwz6bTGkrTgA4L6Q5CuMPwv8DdvA1973+2lNg1QQzB0Ikn1JgVnclomYZAdshRHfG8sRrGD7YTj0udrDgiojBjuVBV8rBEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYN2CntSlb53OrhuxxsqUPnGpZk1P9sMSX9EKaR75g0=;
 b=LLp2V6lTEnY7rmfRursvv8Jmz0RhcbQvEbgv+YsKxJDZlBD8LOmoMwHXpgesHvtJtTAv5Kp5vUz9nESU2qFwh+TiNnfsUPllok1K5JTh8zu8AXNQjY+j3IeB4J83xcSQYrDsyltVwt4ffdker466oOjZ9cA4Iu+XPxfrLFFHERdfe451e0QZUzfI00vQCkJZYhcrh66/wjiquUhOh3Ynrq+GXySkrXw/aTW9lQ+ni2i+natIN/SQfQfrBP/IyQnBMun/G0qvcHWr4VbF7zHj6KDkr6QBl8FwH3ZPBo1hoXDWm6fUt+To1TRwASTJ/FX5l9OBZ5C4aT0yTXiPmhPBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYN2CntSlb53OrhuxxsqUPnGpZk1P9sMSX9EKaR75g0=;
 b=irUKawbN93FkBpanDP+o4oRIrVUFvS2R8nZjp3MQQUdZdjHoLTyHtrM529N/cuWDaXqWrgC8RV4iit882+tIV25ANMvhfAlh3l8h/V29voCoAmQKXJi+hBMcrVRIiEBLd1VfqH8tASrWPss3J+Uw1dBQiB9wejrhN7753ifBu4b0jH0t3AcODvnpxT8eZJ13BwjNhps27GaFa5MbcExU90vbeG9qZ8SRSIT/g3TMtm/RoymiXNtbMXhyiQYvS7fAbP7hqjX19ONuOhSK6sGhcSy7Uyz6ElcPOgyoN+f1/QFfuGKp0rU41GJpueWiby3Hyp0CDKxG7dLyJwphOyZmKQ==
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.35; Fri, 28 Jul 2023 10:00:09 +0000
Received: from DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::88) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 10:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT071.mail.protection.outlook.com (10.13.173.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 10:00:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Jul 2023
 02:59:55 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Jul
 2023 02:59:52 -0700
References: <20230728022142.2066980-1-rkannoth@marvell.com>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next] dissector: Use 64bits for used_keys
Date:   Fri, 28 Jul 2023 11:30:24 +0200
In-Reply-To: <20230728022142.2066980-1-rkannoth@marvell.com>
Message-ID: <87mszgfjai.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT071:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa8eb04-38d0-4a83-0267-08db8f516d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ea1A+VmaptUsEg8wA+r4DfZ0Z9rSnYknaRtlC0Q6GOMP9/Gl3EfvQKJgpwo8dL0qi4IjvDc2m0g994ixRUF09svIgedaBKvxxr3ymvK0sbjjnQpIu9FxFMkVKnXuO0CFrOcoLvUxEpp/7n3IretHoJt/3Ryf0rB+TQPAwMkuPckbDPXdbsR0EAvw2IOEHO7QU5e14V/dlTgE6lgxbLTQlAM0EdnirFLuB2Y/AiPIPF3KqzoOom9SUlC7ru8btnwFpYJA+RlPmZEiAO7ZKPDyIXzFlZz4UZHRpVpbE/7By/4MuAECQ4+kR9/eWzWYtQSy6xj9U5+51Px4B1W+SZKn/QdqlNdu8E4KWk3z+MolLEQs+rrCLtWGM0o/7ehKT7F9IkcscHa97kbDU/WLXFp1HEgeTuRxIX5L48PQqe82HtV65EyFy1rFECw7HZaOwDkZR438cvpy8Ja6u4Px47eez7sUavIAyzK8Knbn5Xk6g76g3L8KMDz97x9lB94Ya2W+didk4ucUcOffVL+LWzq/3odzQfJ0DeJUiz5bgwrHA2MUbg+gR5ZXOE7WBXlzEWEYadUy3IS+tU8wXhWcYxBbh6ARwl7RPozn6mGSHismi30oV3NmdpK1+kkyqzI7zqKcRFJ2tJPC8Kq4BlyqNY4cb3jBrjU2mXMw7KKuSC4UXb2AfpTwMFNw9y1O/SnVWWbQLNoClqbCy/UHB33SBTlIEZu1wiPgnmc147ub/AVepy7vLREU7kBd/efZHTShxfn4ThQIiB9vTAfd911Q7NMzuRUCL244zd9cKezdHqjaTDY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(83380400001)(47076005)(40460700003)(36756003)(426003)(2906002)(36860700001)(86362001)(4744005)(2616005)(40480700001)(356005)(7636003)(82740400003)(41300700001)(316002)(4326008)(6916009)(966005)(26005)(8676002)(8936002)(54906003)(478600001)(70206006)(70586007)(6666004)(336012)(186003)(16526019)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 10:00:09.1913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa8eb04-38d0-4a83-0267-08db8f516d62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ratheesh Kannoth <rkannoth@marvell.com> writes:

> As 32bit of dissector->used_keys are exhausted,
> increase the size to 64bits.
>
> This is base changes for ESP/AH flow dissector patch.
> Please find patch and discussions at
> https://lore.kernel.org/netdev/ZMDNjD46BvZ5zp5I@corigine.com/T/#t
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>

This makes it look like I reviewed the whole thing. I think I wrote
this:

	Reviewed-by: Petr Machata <petrm@nvidia.com> # for mlxsw

Also, you either missed or ignored my proposal for subject line update.
I do think that "net: flow_dissector:" would be a better prefix, because
that's how the component is called, and it's in the net namespace. It's
OK not to agree, but in that case please argue to that end.
