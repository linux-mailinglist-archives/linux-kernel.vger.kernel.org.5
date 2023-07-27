Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899F0765861
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjG0QM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjG0QM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:12:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6442D45;
        Thu, 27 Jul 2023 09:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okq1vllXzt+ous3FMNK6pcNqLft85sxkaORTA4Ec+nkEQXVWJL4Y/kU904oEhoacqw4HSWlWU0hjH7ubb8RGnOpB9q5tb6rxEYruQAVdI5LGs3LtDFhwAlrqPb7R49pm2eQsFOc8SV/+xka+4lLbzT+lWcsREdFrcUj9s9e6u0LBjW6PCiAkXdc9YmZDAk9+/2l5ieF7XAzA4tBy8H866yp2ZJ9YBj3OZWTfxBffbjld0Y5tK15UHPQOgreA6BW0nLjq7OSXhTwiDfbutbZU1reoHEo0kKScz4GXzi8cOS7pLXZ8oPc4DQ9hC8LT1PIshk/9ot2dU87zrij4bpCUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbqRP2MddH/jXvpIzlUv53O47Q2wL1/JpUkFAR26x44=;
 b=MK6KxIIJI1gIX1NCvLQcqcYF6G49xbmt071yq7U8O2lx8EZK06RGsFNNMmuvs3xXMmOVBtGSsJymvb5fVzBHo8OExWwdosg8OcA3bFVtemdit2QUziVc3J7Hawb8lwXkooN55Y7xNocjKFK2zh8dLhowdxT6cp6b4mNwvB3HA/a2Ody83cA3IszogjGfN0fM3tWj9tC8CqQssp5XFyTDOdWiFK3woWLuHm59zKMe+9TE3iEnxfWcjOVB1SeP8PE5Drz/QiX0xktwymb8pOQEPFX7g2UK/umhFj/RBeEYrX6Qh7PcfGf0f3QTVGkfsdSv+sziuJmbGOmt7mqtteI9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=strlen.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbqRP2MddH/jXvpIzlUv53O47Q2wL1/JpUkFAR26x44=;
 b=nFRcm0sp7fj8d5BFA25PoHiJ14vAdRtf1WpPbtyyE+BEFGOejrec7H4Sxci9tjZKq7kTqfXGFgiXYUfHy0l/TyJfNtDxZfPPWAUZu45QxqQoTOQMfpdrL7uYdZNvvak/F1/BFWUDorugGiJyo2JweethuPW1MEIfjsuhs6xhRqXPC5SHy7dzCAQjFBu0oOv4JRR+0BMCC2aYNvhq0hooqLWirY5ddBDZze3FSviIRZJKBlY9lVhrd53HlblukFB2+90n2A7jomq2VUO1MVJc7iNNXsnNKGXVlc9CWnnp9xY09qtB4Iw6zMXoM2s9bXVj57tAh+TmEhjBSna8ASImuw==
Received: from MW4PR03CA0304.namprd03.prod.outlook.com (2603:10b6:303:dd::9)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:12:24 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::48) by MW4PR03CA0304.outlook.office365.com
 (2603:10b6:303:dd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 16:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 16:12:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 09:12:10 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 09:12:01 -0700
References: <20230727062814.2054345-1-rkannoth@marvell.com>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vladimir.oltean@nxp.com>, <claudiu.manoil@nxp.com>,
        <alexandre.belloni@bootlin.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <olteanv@gmail.com>, <michael.chan@broadcom.com>,
        <rajur@chelsio.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <taras.chornyi@plvision.eu>, <saeedm@nvidia.com>,
        <leon@kernel.org>, <idosch@nvidia.com>, <petrm@nvidia.com>,
        <horatiu.vultur@microchip.com>, <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
        <simon.horman@corigine.com>, <aelior@marvell.com>,
        <manishc@marvell.com>, <ecree.xilinx@gmail.com>,
        <habetsm.xilinx@gmail.com>, <peppe.cavallaro@st.com>,
        <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
        <mcoquelin.stm32@gmail.com>, <pablo@netfilter.org>,
        <kadlec@netfilter.org>, <fw@strlen.de>
Subject: Re: [PATCH v1 net-next] dissector: Use 64bits for used_keys
Date:   Thu, 27 Jul 2023 17:54:15 +0200
In-Reply-To: <20230727062814.2054345-1-rkannoth@marvell.com>
Message-ID: <87v8e5fi5s.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 6362b935-9072-401d-b474-08db8ebc43b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /84/mrD/rK+FOfxFo8N9V0BxNHyneEwx2WT1fBN0V+kIpBETMIvJge67Iy0q9CzntN0DeQBfOvRiBFc9Qs5XkHod7bCfcKtBFrZiQIVMCOIitpmGZKLHcxWo6/V4ktMNghE73MP8rek9G9BUB6INQ3Gw/axuP2qz0jmJnyDPaYohnbyc0nIikAEkB5QJYb5W9DmU6+zljeRcc253UYsZnQFBJ0tlLpuMgpEBqqGEeewXjDf848LVlvAhgDIVr7jTMxXwFg/TGIX/TcPySldbIGUiVlSiqBJQXHkiZlDLxMyETzBaVDAHT0z8LIETmQoXA4EiC9q3Xn7lG8DdYYvFt0HPB/oifHXlgx7l0O0wyzl80P15d97I9T1OQBhR9wDENJ3m90DAqLkgwZSF2+BAn01aD8CYOMDQJkqaD4oDWwzANXYhcRO0odJRntTDpgTxtbBVIKbJgnfOPWDb5zJV/k5DirQ6rzVn0BTxMf8Pj0/NeRjqrwyU0ny5Vg9uDc9VeYNGpeq+xE3tO88QxURJCY9TIEFj89XY8/TmkqNqyPbNuElCRMUkRcmNI7R/DhKLcQTBJvmEaba9WVYYV9aUNR6W10j19wf0T19FBYYM7g4GhuOP4XnxAYZkQiCZuGMLMXlKPmWMohI+api2WK/w0Szm7zwbpqhPHaebBxw6mfaWro0ARVujxWVwK9uXUEWADanUiIyA6BTUue2Z7FjXdWr31ibf5xhf+nU1RMvkGd7pvin/Dwv4QomRgHKsVYslcaKRwlbcP6bXpYlW67GAVGCi1BTNNnkb9v5kq2MqNMg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(316002)(4744005)(8936002)(8676002)(7406005)(7416002)(5660300002)(40460700003)(41300700001)(36756003)(40480700001)(86362001)(966005)(26005)(356005)(478600001)(82740400003)(6666004)(47076005)(36860700001)(16526019)(186003)(336012)(426003)(2616005)(4326008)(6916009)(70586007)(70206006)(54906003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:12:24.2825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6362b935-9072-401d-b474-08db8ebc43b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ratheesh Kannoth <rkannoth@marvell.com> writes:

> As 32bit of dissectory->used_keys are exhausted,
> increase the size to 64bits.
>
> This is base changes for ESP/AH flow dissector patch.
>
> Please find patch and discussions at
> https://lore.kernel.org/netdev/ZMDNjD46BvZ5zp5I@corigine.com/T/#t
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Looks good as far as mlxsw:

Reviewed-by: Petr Machata <petrm@nvidia.com> # for mlxsw
Tested-by: Petr Machata <petrm@nvidia.com>
