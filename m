Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ECF7FA31B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjK0OkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjK0OkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:40:15 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2227.outbound.protection.outlook.com [52.100.157.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A5E6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:40:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Riov8VrlyUrthcFu80ECf/Zmr0R+caku9Bjrbk7QgjmTEOg3CMTTBjmRaJgsXcXgLy5blWYMrcEFj7d7vl5p8nHHuSQ7xaW8D3uzrlKIf1fpGgshOv5F5+pX271BVWHWyypNQSfe615SbF7Q9CZ1cs1ETaD+6UE8xwDqfb26Eexa9dR3mC2J7TxOE8pD5MoE2qj1tJL7svn9khk3AKCfgKJOcvRghupBHlQWI3wJrXRj2EgqZx0yF8Na+/8KYi+CfoyIlfVfBNXL3KF+P3SJcK159LVRMwmehoqxD33bRkO8S5MnISQQtLu4J3zVs9jzf94AB57nnoORJECm3AOsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5yo0Sgy8oXl+zF9J2b9tGZwlptUpBCb3GszpoHT/7o=;
 b=M+oHEHsr01U68Dk0QY/c0mX68fx1TI6TaeMCPlSiR0sKk0BXAPn66/ta9THHt7lt5nXg0RdQxJnxqwYk8oIyfSm3buPBL6Ab5A/lx+2p0KlKxnAfxAvLVLzRTb1v0EmFfHIsSlRImdQU4kOgnkptqq2So+LAjAtYvRGtU//SFNZvYRtiSYrTfXlUQaJKe+O9JcAHYayQMnByDqo5NXjrN7aoygfrmOzlBgtxwCw+0OgalU768WyE+BGOXBgC/3mOTHgoorFmxTcxp9OOYithR7Yn6NsRWiJ78r2qvqxLurdkTXjPPVlqdI/6EFUR/KSpBish2TjBjdaexcclSSZ1kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5yo0Sgy8oXl+zF9J2b9tGZwlptUpBCb3GszpoHT/7o=;
 b=gLTvR/Gh+pdaeCuWe86Oc+1M1K0hMQCWkcn/Pi5p2MLi90lyH0g/FZe/OjPO1eggbWGNbz/g/Bzj4lQ1O/+LhOm8NvIZqKmWY6qgS+I7UytIlMYA2rQdu0lypYs/DCwHlWwYKxPaLz/HeGLGASeqHOHXs6zoP2NfW9p1J0cAGLjZ/SWWAqinc7KTVigyuPmp7ONcs49i7WRS8JkjiCVe01hwUVNZtPT0ATyX9a+yhov937SMZYScyNrcBn1re7GsDYcP2GBHBnW5uHf7Omtjd4SsofqgmWO8VI3ZSScXzZS3flo+3cRl5LlRRtUwrvMAaCLAzVzrwLHx51Sicsuwvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 14:40:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 14:40:18 +0000
Date:   Mon, 27 Nov 2023 10:40:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231127144017.GK436702@nvidia.com>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112702-postal-rumbling-003f@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112702-postal-rumbling-003f@gregkh>
X-ClientProxiedBy: BLAPR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:208:329::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 52488999-7df8-4a0c-86c6-08dbef56c691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TX2KVy0vZ44x7dtqwvBzpKzCqDY5F6jsHZKs5rwM8gRJIVEjd9u/ZYpy/Fna?=
 =?us-ascii?Q?xN5rB4GBdN4Vik7Ina3PmBYnA/Fmp/DjXnzGBN6wJbmLDZBehxQ7BtyNKiGk?=
 =?us-ascii?Q?XP+s5w9gURJnLiENeEogz7ks79pUecISSxfNDsouhEKHW0pB6XveYU31stoB?=
 =?us-ascii?Q?een0BOm3qGJMnmCJSlvBm4mKDQcqzUTVswSx3NTtqjwTumbpsc6CJJRaMbOa?=
 =?us-ascii?Q?CdIKaUE8gBr97fjC+h4aYT/6XqqUpE+V6iVQGsLdLjcAN7wsvQrThTJTRl2B?=
 =?us-ascii?Q?QnpZ3UK3mx6vHl90vdEtVasNJf168V/ReOomIvTf7pJocTd//oJxD+B6MIsO?=
 =?us-ascii?Q?PbQy8AQBF1vIJETPh04zJr4NzTxgdWBH2LvPZk0qOXipbVT+q/rWlJfCTe8T?=
 =?us-ascii?Q?JtXxozS4U+J2+SvAxUc8ZGTX6w9f7vOE6Wgs8NDPKSvGS7MRhmsacU1cYgZ7?=
 =?us-ascii?Q?yQiVGgb+SD/DuiJ7Pb0+eW3xdbfrSMvGn66EfyR46b2k3dXMvakPU4loG2S5?=
 =?us-ascii?Q?yxQxtOA73DkRCQ9gvoHDzZJuuq4KQp/dEPi3Hytbx7RI0ZvL68De5yiIG+Gx?=
 =?us-ascii?Q?pOEdZ2EALwMgQYeWGoP4zxbgomrIW3VRm6d/LGHBpZ6vHdX6y88qNj4NiFnn?=
 =?us-ascii?Q?OJWTGt+e339uuaOR16+3W4zfyP2kvkuQdAO+SugDhZl/sr70KYhPTRcmkFhQ?=
 =?us-ascii?Q?M4sQHSRZHlkjAHMtRHk6ESllnJJ+Lz12KZSLrAZnmaIqoUZ0Yv1zpOrCn2yI?=
 =?us-ascii?Q?JwuNKOPTp9B/7zxpowuJjXm/fX81pQg+qiGayDph7csYCFDHv97Nv+ClxBzl?=
 =?us-ascii?Q?jkNXc/OfIEmUoF+LLX6bPTb4B9aCMUDTTwLUY+hicECGG+iI8wbGfY21/skR?=
 =?us-ascii?Q?z8+qqB5vPgXmWzmDnJG4219miMEpyPeCKo9wTMyRMMe7paN3npxD1vnZVZnM?=
 =?us-ascii?Q?GMEVNImLG5kDNTdhdR9rS1aqwQs5p4Kxwsq+ZNf0qPma8R27eCv2ZvMX/N8k?=
 =?us-ascii?Q?XHlOIlr0pO5s2FNOA+3V+LK0bg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(8936002)(8676002)(4326008)(6512007)(6506007)(66556008)(66476007)(54906003)(66946007)(6916009)(316002)(6486002)(478600001)(33656002)(36756003)(38100700002)(41300700001)(1076003)(86362001)(107886003)(26005)(2906002)(2616005)(5660300002)(27376004)(42413004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vIZz68VOHIF3F1hggSO5jTprYcXnR7P4zW3Kyu2JuvGRtOsfouHhEZwNXGTQ?=
 =?us-ascii?Q?acaM8QwpJ3IuhedLDm0SjhGEpFf1LePx4MPcY7/mxCQW0lj+4bhbEdkWzYEY?=
 =?us-ascii?Q?CFN0qS83zE3GJrBtFlAS5gJ8Sf27foMFF1cOjLC5aOvtWHaqyKFHiYGAcj3d?=
 =?us-ascii?Q?3VR8hO8c68PqdHiasTLR9hTwWlB821uC3HjRbhTrxkefyAf4GI/1xWm+yg5Q?=
 =?us-ascii?Q?cwyN8YPentsrt+GTYI05+ZSBBuOKrPHp6a5n/OGl0aXfs5Mp/o5JA3Fr5fOa?=
 =?us-ascii?Q?GODUVPpuvtPP1tee/+oqUqzUNJ6OGHAF+HPbyQQQuhWvRn5xftV+CLZS04BJ?=
 =?us-ascii?Q?YK31A00hb9AWek4SagVkUfxoSEr0bMhxiI0ki2zH6/Cn6tYUJ9IJ+MVt20Bh?=
 =?us-ascii?Q?BY6JlJ/OyVL+DUGplYXZ9rPrEuVEkDTfI6018oMVecrY2ezoM6Vk87J/I8Vc?=
 =?us-ascii?Q?7mSINhoah0n7nxj3SStwV1I/4kbSRvwGxJ6ixGAMhH9D9ukK9fJpKXzoDm8x?=
 =?us-ascii?Q?uPue7YtvaBpn+YxoWjcgytzZ0mafHwCKlvBzFsPfRgIIapZOVpP5eytfix5/?=
 =?us-ascii?Q?bNB7R2K3ZKA867PxDsiMKeIeEqMASu+ypQqsRT0O9uJM0DCZm5WIHecUZ1Qq?=
 =?us-ascii?Q?tXNA9eIlG2YtnYrEueJMqBH/mf1gKqXhrPGZclNF9VNgjBWxqYVmB5786n8E?=
 =?us-ascii?Q?rZ8MdaUm+D7VzTiA+77jkUfaYB3zDQcLE3gwBulPYEwCci0jtdWqk0XOMpNR?=
 =?us-ascii?Q?kIdDi9uo3FP6tNaz4DATP1+nUm+aavg+scRrpq9K/JUx2/huVGnH2VcuIsXf?=
 =?us-ascii?Q?yXpkaWQh0YiZW8a7kVlCZ2gqLJG4apVNWbyzTwqxCkd382GUx5V/ToD4L9+S?=
 =?us-ascii?Q?a6X15YCmbUto45khRsaH2p4f/+7TsEPJ4+lE+dhpkKVQyUH8u6oWEDdAV7eq?=
 =?us-ascii?Q?KGZb1uXEy6GW3Mz7GPRiyIhowe57RDKm4171Lxm+vvl+BVEDubw99dlVcy+x?=
 =?us-ascii?Q?KU/0aa6V/mCsNOrAk31U6RlhZc+8CI+EHb3LtDnJrzFH45Uu+0xh2nPLcNe1?=
 =?us-ascii?Q?treNyK/HL0DKKBN5FfoiSxx5NP/TkEPE5NVOVGnN2ib/JIUWJJ9JT6LZXD6o?=
 =?us-ascii?Q?BQfyp7uafxCQOeWeoxa1Muj6UAwFHb5P9gHxXGp8dGHmwFEPQNfmZBMNqjXe?=
 =?us-ascii?Q?eoQz8RQHpO9v4uu1wv3ktR0gOzfiYj38QD7CU0KZgZu3XWEKL7Hs00SJ8kfR?=
 =?us-ascii?Q?Nx3is0Bmw1tipjAZlT5GufqjIVeyj4woXRnFhiRUAqcL4Eu6poSLCLd9ztm0?=
 =?us-ascii?Q?rlDwCSlFWyWwJ0MLsh7kBBexoticKsCYvbx9KS0ypVwotIwRQOnfcb3dDIxT?=
 =?us-ascii?Q?x3jOdHDh4VEWeXfmFnnrevrMD1h7fuhnDjwvN8Ef6ubKHNNJW9sMI/WiRcAG?=
 =?us-ascii?Q?Bm1KUbIqPhhIdFHM/u7bcSitkExE0CtDBUIfT3Nz+JGUgAOVcm8jhJU/ffjz?=
 =?us-ascii?Q?qzMthfIg2O7IgPFPTig+PjkSSp49w+l7KqxY0bqQLVhaP7kOzk+Ce3wozxyG?=
 =?us-ascii?Q?NqlWWo35hILeHv57FCKzEHFu6/v3lgT8zsQYdSOG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52488999-7df8-4a0c-86c6-08dbef56c691
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 14:40:18.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kZN31sj59smGGxQZJ2h6YILsHkh5PNwLomqtEwWsu0D1/vwe4d7VnuKA/1xb1eQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 01:36:54PM +0000, Greg Kroah-Hartman wrote:

> Why is this dual licensed?  Again, you are using a GPL-only api for this
> driver, how would that even be possible to make this code be BSD?

The code to FreeBSD with mlx5 related dual licensed code integrated is
freely available to inspect. I've never looked myself but I'm told
FreeBSD changes the reference Linux code to remove the use of GPL
code, and that FreeBSD has created BSD licensed versions of some
kernel APIs to support that.

> I thought we already discussed this, AND I talked to someone who
> discussed this with a nvidia lawyer already and I thought this was going
> to get changed.  What happened to that?

It is in the cover letter. You asked for an approval and statement
from our legal and we obtained it. Our lawyers did a review, discussed
with a LF contact, and continue to instruct to use the dual
license. We've done what you required us to do.

The summary I have of the call you refer to does not include a
discussion or agreement about change in nvidia policy regarding mlx5
code.

Like Dave said, our lawyers are not your lawyers. Now that we have
involved legal, and they have given an instruction, we must follow it.

Regards,
Jason
