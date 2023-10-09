Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB067BEE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378868AbjJIWQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378741AbjJIWQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:16:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51E99
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gsqbqv+uwpVez9RFImjhD+VmSrXuPfgdDFQnqeQ0L1Lm0WteC4HMWLiorquQCsM/TeKN+IYw7/EZrFuwsJyEzGzEa1I/N3SqPlTTs6MTVD4yqQV/ZSgqEYslq8MA/lYUrbCiqmjK8hJonKgjYhsuUZNOZdCaz2IFztJt/xuHW+8jy/6Y+uv0DKpwWhoi2sBsoSdFnl0sY80z9j+gTYE3WpfzARq/u/9XkpCl7vpKY58A+vwPXx8ey852MjrCI8gGvPiUQfvK++GzWwXbl5cxnfSa0V0iSpKjZNXzgQTLkuMofDbZNUQMzE0gxJPdx9+3vRZrHd23/OC1+bhgZXnZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+fb95RthJG0urcwOHSvwbioZb5AozS2rN2Seh3T3HA=;
 b=mYM1xp61hIGVnQQEcMwDvh5Ho/zzGXVparWRJN5lKE+uCaNdPIMbWqyYa7duKf5ydB0Ls8F93S5YM7U3bDmcjiv9Gv2tKBLRt4kueU2qXpJxxR9z3X4dEmq1NxwrbgruhYvXKROie0h5xig4mdOBIN9FM8shtbVstxDvMHz1P6sSRzgElgZGfqfnE6lwIdj89aayTqHfwehLjSFPeEXUmfyrBGwU6EK4Glblr/JHfH3SWmvP3ZwlTy9vv0ZHTZ0Yo6uI8yoMY/RpvumSDk/8kAszM6+FvZG6tk2/CAdlwjS4sg/JmWEwMey70if1f2DSV7+rz2omySJZOPMZj8uFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+fb95RthJG0urcwOHSvwbioZb5AozS2rN2Seh3T3HA=;
 b=Qs1sEQsrafrYpOrsjPZQAUSZKPpruqgPdzS3mBjIzNLLmnZGSd9ljBMQK/7SPLdVhxP+uKxf756zQqjwdXIjDGYD3MJzakjJAofSnppo0jnh1mC9NnvzkA+/XCSIEnLmSyXbcSGxFc7zewulnQnZg2JuJY3jnO/SaDGYNsIkgS0oNTpWzZforWj3m4k1WVYFvFy6/ut9wzvZV/+JRf2hnRIL/NbkzsIGwpsOpfzfB/8dc87m1xWCy9yRsM1I0/YZKSgwjOcnlp5GMm4PLf+ZE5s4Q3xwsMg1+UUT311fdBhmFZGYBqi+uQVBO2X6PQPsG8QkKuF7iYLiv2sFwZ+kbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 22:16:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 22:16:29 +0000
Date:   Mon, 9 Oct 2023 19:16:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] mm: make __access_remote_vm() static
Message-ID: <20231009221628.GB3952@nvidia.com>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <70436dcf596565770e604a4fc4e8f27a14c85166.1696174961.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70436dcf596565770e604a4fc4e8f27a14c85166.1696174961.git.lstoakes@gmail.com>
X-ClientProxiedBy: BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 88792e18-32d2-4f5f-c4ba-08dbc9156303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8tlXyGPFuRG6coA/mdsXUQDHLL2ZghWRUkUISRNGT4JbFYcCNCVGhWkclAkwDFovb7tfTx3Kqe0D2Tl2DzHbJbONtiB7B+3yNx/RtznoYTV0GOokmhJ9fxAlLZc9NqY7SBmASDnywuPIVfWUg3X4J2v4pgJJCObf49oMPcpv+pDceWGefVhLXhR8xXWMKEXbloHZ6oJzAjJl5hOW5hgJhvPzeuRwrvBZ8l0Hoaygx8N8FKfodQ2chbj2lOk11AhK7CWg6fwKEnj6A9/p9W28c4FzTXPoWX76vaw8SvZY6I2KnnUWupt6gl/Boutst/gavuQXeTWWEEfRsdoHKmke2nxULsgQIu3AbmEFa6b6LVNikl+eOeeqZpa43aZIq1C5DwQ7XiAPf+Ixos+mTZkyGR02PyhwslU6opZqwviREQAzKKCxs929z07RG/gbM5ANptGl6NVLWx0E8gBDcHEq31n11uVAqF4a0dlYpYan1atqmhlj+wUKRPgJHQ1HbjmJBjDUI/F3rs8XOq+mOCRj9Yce2FLSTQkHI4HZjJTzvgI2oGd9cRVzoXhhaWSlX/4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(1076003)(26005)(4744005)(66476007)(54906003)(66556008)(6916009)(7416002)(2906002)(66946007)(83380400001)(86362001)(36756003)(33656002)(5660300002)(6506007)(478600001)(6486002)(6512007)(8676002)(4326008)(8936002)(316002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5lWqJbNjXSGImesy5kbTpuFiPOWO9p4g4z7sQfGAQL0mJrwzxPa9llcEM/Y?=
 =?us-ascii?Q?CbQFTiBfq/CD7VwnoyTcUe4nPNJQJyrQj0t5YUgcsT40i4KaPNcqjLpPcZDX?=
 =?us-ascii?Q?uALj0qiFT7WrPCZJgsiBS8+mp8wINJbeOK4c6fLfvPypHeDA3FeRUjn3tngg?=
 =?us-ascii?Q?Pva5okLbxHl8y52fxNWMYssRfiWNFilrUCfCEWfImr0kLKH3KCNnte2X+8CM?=
 =?us-ascii?Q?/eDQ6/rlSD1109YopO6CFhdp68ug/UuOOUSwUlMx33i6JyFcffcnGLgNHR+S?=
 =?us-ascii?Q?Kuu/26UKAC79a3xZmLDSDsI8KZnUwSgLBcegcBuXViVgo2EzOEYvGDIFq5gF?=
 =?us-ascii?Q?lyIDM5zGhmVVGDqQBXAhMC2z6zjUHuFyz5k1AQ0W/wsrXWyrXOZuNJuOe15u?=
 =?us-ascii?Q?fL/Oqc3cfhHj8KFlUINiZYOsy5Lpx9ZK95aJS77M738TXr0R/Pt3j7tPBwFd?=
 =?us-ascii?Q?W9nc8iWboDaik+ZfYUqx+QNVa7rxqCRFmAq1pWRQFl81w5Mc0RR6vscE1+kE?=
 =?us-ascii?Q?Bn+gVgc5IErRsYosS2Vdgrr2X/Cpui45mWhJBkKqcRqJC7OAhZY7vC/Ro/3e?=
 =?us-ascii?Q?OO0OB9+CELcfo6jD9HQXJ9U+zPq6Uu3XwhCBi816CSMLn/BVrUJFHdHwx8IE?=
 =?us-ascii?Q?bkjz8QgjchBueSVBbryA1fuv0EQzlXDDfb1ehNuks2K/ppIxKjiIZsca+Zcv?=
 =?us-ascii?Q?Njib7WzV9byxFgPfdKbIcqvr+rgnnbX/P6p73+Xi4vGzpafyf7uYjHysoDf/?=
 =?us-ascii?Q?+XcOw0Fum3iCl236+Z947hH/skxkzEbXJxuY6wvMgSKZBAO+aBDn0ETkgzQx?=
 =?us-ascii?Q?NYx9xE2bz5yhdeJdwiwlAS3HtcVsFgzTRprfCwQViwLdvgMjx5AUXaZRPk7G?=
 =?us-ascii?Q?EL99ZnARTnJkr1pBa0LnL7QnIW/ExFGj1TbQMQbOQfCHqJCEwG944EE4pSCt?=
 =?us-ascii?Q?omWqz33RP1jYJI3SnuA4Ire9TZpLIS2Mt7o2HSIBa2aUcDP3MgY8aW+mapYn?=
 =?us-ascii?Q?6SqfSEPYKct5lQUC2AA0+ooa4jpzbH8ZDtoi1SVw3tEGA+yPURV2ndXQIrHQ?=
 =?us-ascii?Q?BZKpNCGKpfqMezviz7gDCAH2tPARsfNyP4cYKvAWHRw+J0SlL69RhB9KjI0c?=
 =?us-ascii?Q?J1+Lk/n4uebZiPpKEYbdmGFs+ZBxWNY39iWav64/sZbhLIGdoc+6+qZMFSQp?=
 =?us-ascii?Q?PZwjy4rbFPbVjwiitOXQ1wWX/GRMunXh0Qj59bUltlOZs9vffbDE7w4X3iHN?=
 =?us-ascii?Q?V6YLK/vjW5M/g26/eCxERnYAZuJbDGylcfpiW4fj6OzwzzGsnfIpf6H8N9Or?=
 =?us-ascii?Q?tU11KoF0ZoESmnYUFTGZ4GD3dY5v4XcrraKqeanwysRqANBpsAwmZ1R/dXEP?=
 =?us-ascii?Q?hmX+RwRff7w18SdA5CmbVWnxoDdwkwJQr1Dr7OCwgeaIO7Q2R5vhK7nwzBHZ?=
 =?us-ascii?Q?P49lD6Tn0oo7qBcmSBMNyQwd+ryE1aOzxnorGltmxCQHAkoD3zRZKThYGPR6?=
 =?us-ascii?Q?mU6EnQtaM9BV2fT5sUy4ww/y5EjPkPSNnQDg6e9kFJUKZk9wEbGNBSXzlOtL?=
 =?us-ascii?Q?gP4fPf2bSSBckz4KX94=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88792e18-32d2-4f5f-c4ba-08dbc9156303
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:16:29.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vrjoiN3uqATtwiXxFSvhza9ZjO5ggyl7xX2lykrzAacYY2ST1M2jzdhAKGYyGmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 05:00:02PM +0100, Lorenzo Stoakes wrote:
> access_remote_vm() passes through parameters to __access_remote_vm()
> directly, so remove the __access_remote_vm() function from mm.h aand use
> access_remote_vm() in the one caller that needs it (ptrace_access_vm()).
> 
> This allows future adjustments to the GUP-internal __access_remote_vm()
> function while keeping the access_remote_vm() function stable.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  include/linux/mm.h | 2 --
>  kernel/ptrace.c    | 2 +-
>  mm/memory.c        | 4 ++--
>  mm/nommu.c         | 4 ++--
>  4 files changed, 5 insertions(+), 7 deletions(-)

Why do we even have two versions?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
