Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35A27BEE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378741AbjJIWT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjJIWT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:19:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED66DAF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NArmRUti+Jv/O/fnxey4n3dL5MfV/bJlYyD8kXc7RnoXmWb2bd2iZ/eKJaKdDO6tnNGRqzE7QLlDRphNUQmJIaHlrqmOFtpcTk68i3y6c+9qMJ8png8teIpxIdhHg4WXpq9JjKIk5YhGvX+XyA6EmS2ggEqLxP27c9cFrqs4kpspPnk9kDexa/XED4WppNrx8vs61jJ0d3IkE0yfoWjdNsZQJw663pH22K9F10muQvJ2XD7R37F8XS2k5kcvtU5i/tLsB+x1LFkW9myXyfvziqid94TGe1PO8ttfsasSfNlJkP3ObpG8qVnNfoXW6cxFD3i5ew8KlNwZhyCRlgaleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oee/L9NO56WFyPqdSGDL0rghx/f7Z3HNHj8Ot00tnHA=;
 b=Ew535213vOVV9wBMuvJShOyA5nRcjfugfsBsP9Mz65vliQ43Chj6PV4YOg9vc0jCt9M3uJ3YICOk7QMmzdzFoTL5rKL/UZbssUvypedLE/g0UIqLtWP2i7vu0o0AajAATcwWnZyu51LVOfaYJ7RfpvA9NXox56YuNVMv6u/4O+UfrC6E0GLY3jMBPGRqXfYHN04rjc3LiTTeLN3X211kGZ9N0OUZ/qA+s1IT+HVR/E0XQcc2mKojOApX7ce5liNnS5/CgodWRgOxRMeOR5Xh4qFUmhHlQ6njlEhaUUXnnEjGQDweYGE74O0ShpaNM5dG4lZT1usu4ntdjSn3W1vZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oee/L9NO56WFyPqdSGDL0rghx/f7Z3HNHj8Ot00tnHA=;
 b=SjRpm97hGhuqhL/rie4Kih/sYmXBeBHRizJ1I0ofjaT4pUSBV4oCdIhxDFWy0bT+5sa1Q4zwrnI4UGPQIShWr5/EAreW60uUsfmzIxVvBVojkuL64mttttnZ9AyKJzx6JlrIFMewi7NE3McRcj8rh8ShTTIBDhQBGDz/lCkX86diVqtGZ5FjBO6U2MAXAdpr7m+jpqC+TTP4IvrSeuf6tVS94zryE2YSSB/Mnjp1B18DChwWpbWhgo5k8X9K1jGXKlTWf4CvvoOAQ0EQuwBPbRjsBvDR7VlOgPdmmqoYP0S4R2kMc6uXelalgbeG+trGV4367hpcbVnmSWoq2hw3uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 22:19:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 22:19:23 +0000
Date:   Mon, 9 Oct 2023 19:19:22 -0300
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
Subject: Re: [PATCH 2/4] mm/gup: explicitly define and check internal GUP
 flags, disallow FOLL_TOUCH
Message-ID: <20231009221922.GC3952@nvidia.com>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <5b20f3cda7cd841555c2626f98d23aa25a039828.1696174961.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b20f3cda7cd841555c2626f98d23aa25a039828.1696174961.git.lstoakes@gmail.com>
X-ClientProxiedBy: MN2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e09d08-6d7a-47b8-7c21-08dbc915ca4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9YEgK5uZgOyGCCYsUVXoFq/cylAckxHqeQBaUJLNXELTwvwRVvdjBtWpkTkz6oebBM8F1JxiNcYehT7jpXtuEB4j9F11ad1Owrt+BI8CbyeaJdvbQFI+LW0ZuaSis64PhcJ1bC+V/f0xgIjNkQynEIjq8b8mr4s4FRAhdz7OvANZ8G/8lp67kIxltQ+WB26ydmoYF4SLmtfLTHigRTlQw1DrXYY/nZ5ZyP3//Ux3mIIMgjLzlsMnxL+UxrSPqbtlbcm6IMyrNt0hkw3ROZR5cjJw07BA/E3pqqmV1uJW+AuHx/XmVQbblXiki5BI7FDDkwVIRvNJqT/5IlITnwUZ8qk5N4zuaPgKbu0Wk/inhWFGyCGbtiPpsVHHpBxcuxQkrVTbCBZYX/QNnXH/e69eLL9NMJectAjk6Daxf5LULxPfiPIu2bLMSoQ+/fDQ41ivPz31j+HQrbBvZBsZXu5aOy9uyl8+WApqLj6u1FMN6Tg5dxcowxztEk0GfGRJWfUP/wvuBqApuXt5sOEr56ii+894cRpSmEWItLuJqGtBj1rS0SyuVB7ZMC2bu+e+Lsh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2616005)(1076003)(26005)(4744005)(66476007)(54906003)(66556008)(6916009)(7416002)(2906002)(66946007)(83380400001)(86362001)(36756003)(33656002)(5660300002)(6506007)(478600001)(6486002)(6512007)(8676002)(4326008)(8936002)(316002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Wk9/ThpQuTMKlTiOyQdYGNdxOL2TfxZMTndV1E1H8/ArcnlNs4Z/KVb6AFx?=
 =?us-ascii?Q?MGyiru6PwilwzzotibN+LeWbeuB3H/qli+kF2p0GVKawoup1Vwd4rIs5E7Zq?=
 =?us-ascii?Q?kG6Gav73ks7OPOG2pLFvEKjvarYjGAZqfOLdFaLJvXfXOicdptOShmlkRDlU?=
 =?us-ascii?Q?y96FeIZMAp8l8OjLH8XZr6KNw9ocPbTRtzLuryrAM2gZVOG/D7NFvzaYSZss?=
 =?us-ascii?Q?XoV85m79hbhFKHJft9dKiKAqgGe3LTNx0x5KX7iQamtA7btGR6/PK0wDtWC/?=
 =?us-ascii?Q?qre1enNpF6DULBt3JDHCboNhFvTozTYWdB93/6d0sGsxVtzUnhHNqMcvC+OF?=
 =?us-ascii?Q?zru1KkNLcVwHL/W8vOanbU1TM6iyMev8HmLNB1Jr9ZhBAbJiR4HiRG3QaShL?=
 =?us-ascii?Q?LytF6AUXstWGbi7TmgaJCV1OjAsQPfLSmo9C+sYDWQf3JdJfhFKgly2ImqbY?=
 =?us-ascii?Q?phaffS6H2VxIS7kAqqMFdUheWkmrsVk0gE5seSOlr1XBvGWEvOc+My7L9ZDQ?=
 =?us-ascii?Q?HRuaRaXmaaXrQ6Fbu0Ifsr/WP/k/8FDAMTgRdTe9T8g4kKd1hm1ut2/E2+Ew?=
 =?us-ascii?Q?ATWmW05BCeM65KGDgQDeJogV4vjplv9Eda2HApSPJeDuEExmU4BJf35q9/iq?=
 =?us-ascii?Q?F7GTyF90NSvo2anZmVX64vH/vjREEIZJR/39bFeERtis4jscNd3J8PdupqeT?=
 =?us-ascii?Q?tr3sOVMbMprhoNZF1nLZePcSL5MtVhx1X1bfe7Hyec+n+UIeDY/eukIsW5YO?=
 =?us-ascii?Q?JD7TecsMilvtPtIGALSMA17Voru+hryMqR8S3fjv7AGpNVOE3SnHpyc9BLnK?=
 =?us-ascii?Q?ggeTUpMQD9Vc4ePNiG5AgfQoBWR26vHl1FbSyu/0VgPsi3vQr3ont/Bk6nHO?=
 =?us-ascii?Q?JvJRG7lRm2cuVWmr4EuJfUZi9p2ZvL8fqXDFzYCXYCe5Adek/rwtgMcJWDyz?=
 =?us-ascii?Q?/Ys7iVLMGxwbW76fp2tA7oY1RKnzSw9vh41YKalPMYZNbvjfrDVMoWjgRfjO?=
 =?us-ascii?Q?WpbBABP2QnDhLq4Q/wZHeIOdITZTgKt9S5bMcLqvuOa1hz8yU1nlJxUkOV0W?=
 =?us-ascii?Q?5/envBthPLPNV4dDDdzFeuTM5KzYu0iGt43R/zbxWeN1SN2F20OuvZuUlipe?=
 =?us-ascii?Q?GnzEn4pscpsxP4sfbIfgPsKO9zBrMd1100KRHZGy8xrF9uoBfwd868MCYQ+E?=
 =?us-ascii?Q?oOWN+GVG6npLjKnFJmrNj97ogOTZACTt6IdzIiLpDbC5jKHT3cw6DXDdkDJM?=
 =?us-ascii?Q?QJSjgG7CfbJI1LqqSgjEmRscTpLLDHzgk24xWSEj8tKydTwpaeVsHJPhpmDy?=
 =?us-ascii?Q?NV6P+4O33awTmqGMYB+ObEfOHU8Q/87C+I3Ztuc8erDeOvmBVPXVm6b6w6Fs?=
 =?us-ascii?Q?Kn9zh2DUBdyOxtRuBpd5Nk9h93VeaOV5aeiy1oc2W6SRg+Yq89YO8pJlwrA4?=
 =?us-ascii?Q?0qWFKEYsc/QCwGcPHKNxx8JDrFLWMR+hDCt1yP8P/DNJbKvJMAQARruKUOxe?=
 =?us-ascii?Q?BzlJ45fLSaVv3+JUkQLq7zYtgpEusr1fnFy4yOTQvzS8aOkzB5DfbfBo/w3r?=
 =?us-ascii?Q?UmqR7h9124vevSqbH/o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e09d08-6d7a-47b8-7c21-08dbc915ca4e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:19:23.0024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxxZ7UA7zhfxTp4dJP1UdPv2CzWSZfhXFYpTpzF1lwA1hSd/rhvBNkhe//AIebpj
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

On Sun, Oct 01, 2023 at 05:00:03PM +0100, Lorenzo Stoakes wrote:
> Rather than open-coding a list of internal GUP flags in
> is_valid_gup_args(), define which ones are internal.
> 
> In addition, we were not explicitly checking to see if the user passed in
> FOLL_TOUCH somehow, this patch fixes that.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/gup.c      | 5 ++---
>  mm/internal.h | 3 +++
>  2 files changed, 5 insertions(+), 3 deletions(-)

Does gup_test still work? It uses FOLL_TOUCH?

Hmm. I guess it was broken for a while anyhow:

/* Just the flags we need, copied from mm.h: */
#define FOLL_WRITE	0x01	/* check pte is writable */
#define FOLL_TOUCH	0x02	/* mark page accessed */

Aside from that this seems OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
