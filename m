Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC37FC1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjK1QYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjK1QYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:24:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2243.outbound.protection.outlook.com [52.100.167.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD223AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTKgAQHzmc/wJ5zI6wWoEBTF/kngF74aAztOhNGc1QiLozC4WF2UOa4Qr7YfGyYTD9v6H8klMkhtMm18J1UgbSxoakBG5VHkFHkU/gjhPHNmrK45OydF7QJxeld5Yigk0pBSKCOkEbkHULnDdKG7bOgvkKYXMhPPAhQJtlJZoEu1IBDmwpIQF8D71v5cxIQRwlwGd0KAK7l6aAnaIjtDNKUH6tGvOS6uabAtz4iJ29JaW+f78ZFEMnlk5RCa1VXAGFvUMz9jsVnKxBBKBrdskg+t0pyiEyFki7mHEEIp2ScGD5PlB1JuGEghB8fTIXunBH3s6RPy7GwrKLGzDKPHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvYZFrKZ7wo9PpBh3uipQUarHpQDe6izt2EDTpRapYI=;
 b=BVYFdbdahdHAEX4X7872Im7LPAM4knDJ0xM/JoZZ9QbCbvehjyrmWjZHbjFS/GtU64jCpHvNhfSa3Jdmhp34pYuXR7M96Ay3CceO+B5Lx4YFaIKVESVQdjp4SUj5CGq+/6Qks+/d0A6TBojJivqgQEbdzgdNsZwTFm9md3hXQt1eaYOf62R1ZqbdI2ofCnb5dpCw4ziIHehCS8Oa5M5V522uS5fBysPn0rUMOgCFj3lj0vRZ2TXOzeDKTo+2kxponZKFOxAwfUpQOHoZcXROj96NtHSEiAuD/j3DeUIS6nZd7yj55NwlnzUkwjEI3PjDWc0dRbJdnOuD0P+RoDnOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvYZFrKZ7wo9PpBh3uipQUarHpQDe6izt2EDTpRapYI=;
 b=sF06XL06CsgrSXkDhBDGKWg5+QVEFarSQJE9SZFkDabSavqG9/KmK1mHSpsr9xertccOmTM00pVb1r16TTNdBu+K++Q8JiBes5fvlB4Q8OM8TDebtzNE/q9qMxa8ydfllNnWQNshuTa1q/a0Wsp1PRI5q5/lrhMNnIuHT3gNaCYpzGwXhcsgw3jwP0NQUzB4vA/Hmk21zuBZIfB+Lm1IfJQjDGl75Fss/J6HlRTVjJeMMCUGjz8AzL96VquvyLiD/q+ADCLCzQcidSyPwVx5uDj4RT2MszzBA/mKR/dshtcyL8ipWN8JNo2Q2vxeff0djb88BytQLge6IJTA/J0S5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 16:24:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 16:24:15 +0000
Date:   Tue, 28 Nov 2023 12:24:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231128162413.GP436702@nvidia.com>
References: <20231121070619.9836-3-saeed@kernel.org>
 <2023112702-postal-rumbling-003f@gregkh>
 <20231127144017.GK436702@nvidia.com>
 <2023112752-pastel-unholy-c63d@gregkh>
 <20231127161732.GL436702@nvidia.com>
 <2023112707-feline-unselect-692f@gregkh>
 <ZWTtTjgBrNxpd9IO@x130>
 <20231127160719.4a8b2ad1@kernel.org>
 <20231128044628.GA8901@u2004-local>
 <20231128065321.53d4d5bb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128065321.53d4d5bb@kernel.org>
X-ClientProxiedBy: DM6PR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:5:177::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 6575d196-417a-4efd-c669-08dbf02e7675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9OIpdomYH11436pditcQgePg+Q/Ky/DQvKcky9nVcy4nkWfMRuAtYQx+ZaSn?=
 =?us-ascii?Q?ZywKarE73Ef6PG40Lx1XhozVXdkwoeNyTUnlqlgFWOKnWSHepMX8vLul5XoK?=
 =?us-ascii?Q?vS/xI1q2vBEYm3EiTXNs1jFmlzfWtUrdGGBRbEkr/jRS0ywgOqEgD3L/pgTB?=
 =?us-ascii?Q?W934e2QG70MUoi4lsB9Y0U2LJ69wfjo/1kv04vnCRtqIpIcD/4HGDlkzMTOZ?=
 =?us-ascii?Q?vnDSILeLsAaaJASWLFJuJUUGlZNHAjlWeu6tNRQWC+1WN2QNYk6fdEvxNS+k?=
 =?us-ascii?Q?Mag9/M6uK3okgRJrpH4U84CtqvbjGDXqxeZaoyhMuzwym6iIg/mU8WaHCMyK?=
 =?us-ascii?Q?sc+abSwQBBUXgQ7g4VbxfV3A6Q6Ef6FSRLjaT6abPdPsbbxEV/XAF3vXcsCb?=
 =?us-ascii?Q?tSmRyGihzk5faygjT6/WiyT/B5Myt2WpUEMt7qu5C/dCnr18ZoOFJWi4LOHs?=
 =?us-ascii?Q?sw0uzIHbjoEb2pFUCG+aJ9vq+PGh9A1v1g2q/eRQH8gCJ1DuXoWQDgbKXa1K?=
 =?us-ascii?Q?NgMYSFOHwvNHF3Xb/paLEZXMgDOzD3oyEWoIn48EkyUPxaS6PghjxKXjmyNK?=
 =?us-ascii?Q?qX25B445D1eRD1CmRcDzZeDYh3QsAXk1Kw3jlDVHECwntwWbLYvj/kBUBF4U?=
 =?us-ascii?Q?XdjMX3nScbZZsZos1iDEBKIY7XCvl2fl3jeQ8m5J4NITtPSflx5yKYxvMmch?=
 =?us-ascii?Q?JKzKUYHUMfR8R7cR1oxnNpcsb5Go4xmeLI2GEw4LM9/0EjLVMjr2gNyXr0D5?=
 =?us-ascii?Q?ypbPIFyu1assKMLXKIB4AxT9XKXwgYE3gQslSka5AwatvDDyyjYKSsNzaJoU?=
 =?us-ascii?Q?1DtfobyFXwqPx+1T3FTl0NFXtRYKyO6BMeZ0FddbrjPSBzMASlsagSy7jQiG?=
 =?us-ascii?Q?QQ4QK0CO9NOdO8up1sfUm58JOhS6PNZguV970aDc1zQDD42BQ18Nw3TgbHUw?=
 =?us-ascii?Q?7Ffx3Wv8dpANaFJ+tUkQ2lwbtWIWUppVvHMmoRKsTypG385aFL+Sd1OTeT7t?=
 =?us-ascii?Q?+89frRKPbwqd2pVi6S6THuDMPZHwMOvM66/G8qpx/An00oIGI7uBkIKWtAaK?=
 =?us-ascii?Q?sRLQV8Xm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(66556008)(6916009)(316002)(54906003)(66476007)(66946007)(6512007)(8936002)(8676002)(4326008)(41300700001)(6486002)(478600001)(6506007)(5660300002)(966005)(2616005)(26005)(1076003)(83380400001)(107886003)(66899024)(38100700002)(86362001)(33656002)(36756003)(27376004)(42413004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1hDI6kiqAEZhy7bIU9iQMwP6K8pvq6NJicsl1XZEZBnQmLqpBdRDg6n8Aky?=
 =?us-ascii?Q?SArER0Hq+6L1wLTxuziZY4i/i5+QMhP6ZtXWnMAHFxPk1wzFYx4ty4tLM89s?=
 =?us-ascii?Q?LJiYst8EcE74BglCHmWVPCUHbKzMIkfTb7knv/hswGhbIFwguVmu53Yo0ryn?=
 =?us-ascii?Q?76GAaO9OWwZx2b3xVVG2hbfQrVKfp55kavsxvSwIfGzCfw5+hyFvYZTlqbfz?=
 =?us-ascii?Q?yO6z4JJa9CAOBaha/me23U4HXmx26ezvIobHqORh+x+a5Np4Il8cSgNojyAO?=
 =?us-ascii?Q?b1nVcOQITqQ/taG9xjvP/nbNHClt6iT3GviHg/sZ6iVIA2ImsWqORvG3UB+w?=
 =?us-ascii?Q?nIGdXYAcdqOaJV2AZhL7IcXLKW3P/hFuGvTn2irpU65NTuNvvg2hF65SksAg?=
 =?us-ascii?Q?4Qwf+rgw/EJz1aNcP9f6Ibmh8b7fV0uc2zRbuLrx8u1SXABSGXBVHjTOK6Al?=
 =?us-ascii?Q?3HdsrVyVznkNuZFGhi2weCqi16tbTpxfyQnkMH53yJl7HlOzBKFobd7om1hd?=
 =?us-ascii?Q?Dkj2a4Ql/8irpYmMCXkrHY0J9jKE1GSXuENNUSDMpRJQS28VxSJuftjVZ/Rr?=
 =?us-ascii?Q?DpS1xIx9/wdASFxs4AMlvX2hvFo5VTY0gn1GZPTsRhq7IMXTMTut4fTntN2O?=
 =?us-ascii?Q?o7WFTg0EQ0VGWYvthu2iV94/H8riK32yDI5crKwvBnyUFOu5uyiUX3wyepsg?=
 =?us-ascii?Q?AGGrjJnbYG1JQ94/XCX5pZ6XAu+b352Jy64YDLpuHixY0ru6CzD3CYf0CFAx?=
 =?us-ascii?Q?IzJb9AGr0RtKM+5I2Um3GlYmExO75RO1UyeVAwm2yWp8xQT4vh6miE7ZTmaH?=
 =?us-ascii?Q?U0UnUMAPcJbuEcEPnM2zCt/UPnQw5hKWS8T+5h4TdS8U1C/X62d8GkbVjGWh?=
 =?us-ascii?Q?ekwDLM0HuHD4xKtRKt6lxV6lDz24F+DsXONPhSUH8EM9Zdh0lJCvhTwxfG9W?=
 =?us-ascii?Q?DBMK/1AtXdO0a76/JEyh+JLQ8tc2B3HIUu6UjOUqNTVaMzNrQ7l5+gkFKnWH?=
 =?us-ascii?Q?jvSNGCfTrJHnwvrU4NTTH6s6tuAbi3Rvsk/LBH46gxkaLYxL7A0mcJkts4HJ?=
 =?us-ascii?Q?bgNmeDQiZ65dCzJKkgXE4UPQaxNLV3nACEs80dfuKZuxroyeyz1l1H0iRyKK?=
 =?us-ascii?Q?pQjCaGk3suCXYOHyqxmTJYEin62WqbSIHSTg2qhypsA5DhazvUoDt2W85/6H?=
 =?us-ascii?Q?koRXe0JLQZiaiRy/o0ywi8xVLS2NMgiMpZ9Hhjoj/PlzdHK5p7K3jOp8uO8P?=
 =?us-ascii?Q?pIjHYXMM1T6dq7wwrkUQYykwyaDa7Pc16wDEnEADM5oqVPlkz7JnC7QRSWJo?=
 =?us-ascii?Q?d+CY/0nPDCnmz4E99CiHaIKu69QqhHT/i7DKPblDRXznXQbGFVO94jK4q/uZ?=
 =?us-ascii?Q?5ZO62E/FM5HRnNHpth5MJ4dVtbW9sSTYVWAyZb3Eo1eL76OwyyzvR1bCPzHl?=
 =?us-ascii?Q?62ABWv82llAYLX6wYdEAq2xeB+icbDPQs+l1xRKdjLJwtjOIMNC2oNvTksJZ?=
 =?us-ascii?Q?6bLrsuCpz+9Qt0lRK8KKgId2M331cTG1hG1tz/D2Dq6hV4mLGvvydQnY+0t/?=
 =?us-ascii?Q?jjCGy7M6xlkdBeX/Or3p4nbrE1LEtFU7qzDudH++?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6575d196-417a-4efd-c669-08dbf02e7675
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:24:15.0980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPUwWI4fqUG6YCrAJyo6AMRtxCVzLoSv1IneKybljp6Mhv62JQw5jTqsLPfNZhlJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 06:53:21AM -0800, Jakub Kicinski wrote:
> > You said no to the devlink parameters as a way to tune an ASIC.
> 
> What? When?

You said you already rejected it at the very start of this discussion
and linked to the video recording of the rejection discussion:

https://lore.kernel.org/all/20231019165055.GT3952@nvidia.com/

This session was specifically on the 600 FW configuration parameters
that mlx5 has. This is something that is done today on non-secure boot
systems with direct PCI access on sysfs and would be absorbed into
this driver on secure-boot systems. Ie nothing really changes from the
broader ecosystem perspective.

The discussion starts at time index 22:11.

Dave (IIRC? sorry) is talking about unique things and suggesting
devlink. Many people in the audiance seem to support this idea

27:00 -> 28:00 you repeated this thread's argument about said NO
"occasionally you are allowed to use [devlink parameters] them"

At 29 you said just keep it all out of tree.

Oh, I chimed in around 30:00 saying it is not the kernel maintainers
job to force standardization. This is a user problem.

31:25 you said again "nothing"

31:30 S390 teams would like this and pushed back against "keep it all
out of tree" describing the situation as a "deadlock".

33:00 you said need two implementors for device specific parameters,
which misses the point of the discussion, IMHO.

And this was at the Dublin LPC, so over a year ago.

I second Dave's question - if you do not like mlx5ctl, then what is
your vision to solve all these user problems?

Jason
