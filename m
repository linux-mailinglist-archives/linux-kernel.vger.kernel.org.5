Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205987D004C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbjJSRMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjJSRMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:12:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6248131
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoXuazvp5m84bHCwri3i+QBk+8aVl28B5jNhDzbRSINB0DqnbLmkWfZ5qsa+KSV+v8XYqgn2Im/W0MTJsclKoSmeY1095JNFgjycH09Kg3JGyMaTnkxEC43be/TjDWb+y77c5+j+mVLPrR+X1wDtxYEhB8LZeEiQaHjhIo8EWgb7gqLzI0i4VDiGDfAydMIbmSKRk8qCgukp8dCiXixE9yS4vGM9bqGtLkthF4C7vPE9m09P7tUEn1QALbPNBiGE7jSl/bgK1KhPDt7xK/j9DN64jJJGyCayiPts6IliChbGw8CjVajiwbx7gAxwBVv0/xYkvBfB7GwQ0MJOiEouIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp+v5+Ce0rNFv6oBC5F66OCOYdcsysOpzu/9BLIQZuI=;
 b=GSegCkySbQ0HG5o905JzY1JUOwcmmpspbZ4wV7Cy3KzCcXeXOaRiq1sevwLuljwxJOf5BxrSISsxoD2+ct853R4QWp0WzQH+80jnrjnB/h1/eiXj2ohrxh3KRi6/+NFWv3Fem0awwVX1mtAsORrzBZUZJX7Bd4vpOL8jS4iFTY6ZqiScuAtEhfVKk2Jdp1OksCPYhzERlsp/BMVV17r7OC5fBJfMl2Lwt/aySAm6/4iFXR67Z6Nq7Q01rIz18twLzsfi/BYQCfdLqLOT42aBoQOs8NIglXo5vZaG8OOwxEL9I+tKdiR5JEzmF5d782xa2LktQe9ynv4nZUe5x1xjgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp+v5+Ce0rNFv6oBC5F66OCOYdcsysOpzu/9BLIQZuI=;
 b=HPia55UFwp7PY41qFXy3k0CQh2OlmvZC3qPOSGlbKxtMz/jcxLzyYmSY9atPFVFybzFClr3n2FEgTrnX8WpkTwhw2qMm7Ix2VNlCmbLpjhtJEyDYXSOOWK+3H7M7ZG4sd4N99pM7O2RM6V/n9J8SCpDe0lFYSpASxOj0C9/H/71HcQQEuSeyC22Mkxvndnm2iuEi/9+kHxrcZhyujBFCWtH60TB2mjxbRMvc6mxijwcQB2sK+H0GgAuUINkqxWcGvvUPBaa8TFAJCTVIO2Bc/Dh3ffyvEZJDNx3ahXWi0WSaXfFkd90JwrXJY00mvEVmmEgWBD8Hyy1Jp1P/8BcrWA==
Received: from MN2PR19CA0033.namprd19.prod.outlook.com (2603:10b6:208:178::46)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 17:12:12 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::25) by MN2PR19CA0033.outlook.office365.com
 (2603:10b6:208:178::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 17:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 17:12:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 10:11:56 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 10:11:55 -0700
Date:   Thu, 19 Oct 2023 20:11:46 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: mlx5 ConnectX diagnostic misc driver
Message-ID: <20231019171146.GM5392@unreal>
References: <20231019082451.785aa123@kernel.org>
 <2023101923-tried-provable-72e7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023101923-tried-provable-72e7@gregkh>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 5035005e-ee41-4617-803e-08dbd0c688bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgsQHRABKVcrBPORqonBGJt9E5L/uUP5mGYvtlTpvZsr+FsLO6gbkHiE+4L3lcIE/lMJE3cTSQxpwhWvA5iHcQdVixflHMWWJOrTkZ7X3OUlUkN5Uht/Jb832B+gOiyXVFLCQ7zmESXtBTclJl0VQCduihiEST8DFE62tiby3HkrWiJJKg71pkaG3JPsF6q/2vSJn+jiN+1SLSOOTmDgYM5yZN7xBpRH26C81LUEqyoVWPZHzkaTj37sxZcX2+P9Ipkl6bk4ZUY819xC2nWZ7OgpTsEYF1ep+QmXQ46a0oyV2ftfOZ51JPGxqjdt7/lWXAvCBjChpq51VM5LYnNP3CTXU5YUt+U80texJggBR2fbnn6vlRnvUJYOqnqSqk3Y/AAmZwvxL481WgFNNuDA8iU/uDuJxLn3t4q5LO2eoRVb/KOUdREEZyBNAia+D3UtxDZ/bFagEOqbZ2QtkyxEVkCT82xIWIa0MQC1FPsBU9N359CqZatfYbBpm8eTqVEmboSxa3XpjZqMHdYziQbsXgJrDlG7gPH606vFAyP/rTH3duehB4X8oeRzWm5p6G3+FcH7nQZCeMP0kH409AXVPZhFZ30mEq8P0O0zhO96t7HxzuiHTwN1ldJiZfA3Vad65NKekWlPlgLd3F9yvQAHgSjpYfdmh2j8vdqjqKhQYAtp8139FtM9qDWSIWZPuHhfHeFTaDNxjj6B02JDhDnhcfrKGX9lY3/rMHsOeFHQLOr45dBwvXrsRJl+J1p6igzk
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7916004)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(47076005)(2906002)(82740400003)(33656002)(336012)(1076003)(86362001)(7636003)(426003)(26005)(356005)(16526019)(6666004)(9686003)(40460700003)(70206006)(316002)(70586007)(6916009)(54906003)(8676002)(8936002)(4326008)(5660300002)(41300700001)(40480700001)(33716001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 17:12:11.5776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5035005e-ee41-4617-803e-08dbd0c688bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:36:04PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 19, 2023 at 08:24:51AM -0700, Jakub Kicinski wrote:
> > > The ConnectX HW family supported by the mlx5 drivers uses an architecture
> > > where a FW component executes "mailbox RPCs" issued by the driver to make
> > > changes to the device. This results in a complex debugging environment
> > > where the FW component has information and complex low level state that
> > > needs to be accessed to userspace for debugging purposes.
> > 
> > You're being very dishonest towards Greg by not telling him that this
> > is a networking device, and the networking maintainers explicitly nacked
> > this backdoor. Nacked it, because you can't answer basic questions like
> > "what are the use cases" with more than "custom config and debug".
> > 
> > Whether Greg wants to take this into the "misc" pile is entirely up 
> > to him, but you gotta give him more context.
> 
> Well, in this case, no way in hell will I be taking this.  If this is a
> networking device, 

It is not networking device. Only by coincidence, the PCI core of mlx5
driver is located in netdev, and it serves other subsystems as well
(VFIO, VDPA, RDMA, e.t.c.).

Just as a reminder, we added auxiliary bus to make sure that this device
is properly decoupled across various subsystems.

> it needs to go through the normal networking driver review process,
> thanks for the heads up.

That process is not relevant here, not everything in the world is netdev.

Thanks

> 
> greg k-h
