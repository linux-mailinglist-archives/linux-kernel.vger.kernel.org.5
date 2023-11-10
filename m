Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6772F7E8545
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjKJVuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKJVuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:50:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49088131
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 13:50:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcIV5eOto7CP/XD4hNOLXNUmOCUA/8dBVdQK5QpYGEciek/L2j+2AKD/ouLNOjmwKABMGAIlpP8Xwfu1IRxNpIrU23THZd5BBt/UNmN9fhlKGqTRSLClZRtePvxt8geqbZQnVv/MPxjtbeN1irk2V8vaNXen6m2ViJdxICyl2o+zCJoII0czCJHXNQwHrIshxfb5ijZ4yVibEQWbwHu4ggXVbvRfSFemWK9+GLeILnS7FImk2TFjkz0b1VudTzaef3Yl6YnLsxmHxL+zerc96x0XPbf/IxRXntTVZ93PlsU6UmrWJ2pH++Tbp+vV6xKy56Pji4Z01cv6EKpDFtrbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHulGFI3/RrwcNDLEvmaYyTiRgnj0xRZUknurGQI4jU=;
 b=CrRcZ2xII5EMV7mMs6jQygXNz5suN0n91cwXOEhnSRq6BQo6OB6ffhK4cfCJ5/TVWnXHO89Q+QZiG6QxwDV3aJbiaevTF/r3mPoF8a0Hi/OJIoI8Vgra88wyAnglxZfDz2KE0btfEJaWzAfw+M26sxORbBxDaPKk5Y8tMYNbcobyQYrXgsmvzjtUudzcjUSaDkojd+WyPlJn8n1HCexNv524oN+gmXhIBClnJVDl15Rt/+Mp6fxM46OJ2f48uDCC+o0AMiRJ/V7Rx9NIYTcRPfQb6/JX3wBn0BYTJIGTXVkuGCLbZL3808bimXzGujSwRXm5h2/v9GS2i+xQF1j50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHulGFI3/RrwcNDLEvmaYyTiRgnj0xRZUknurGQI4jU=;
 b=kaTddcNcMkjATFrM04lrohokBM0//hyz0xB1iVY1//bPu4y5Tfnw7K7PfuEQk3o4QkN3WtFF9/jzSh2pPfrMeztxy2r1LnnCqs6yB3Fbfor2nCg2iFAhdxOYg4TVZ2Eihik429iS/dRk296IM0zNiwwGyV7ZZKH9TcjZ6qjboRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB4680.namprd17.prod.outlook.com (2603:10b6:a03:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10; Fri, 10 Nov
 2023 21:50:27 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7002.010; Fri, 10 Nov 2023
 21:50:27 +0000
Date:   Fri, 10 Nov 2023 16:50:18 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 2/7] fs/proc/page: use a folio in stable_page_flags()
Message-ID: <ZU6lmvMpSfKjjYB3@memverge.com>
References: <20231110033324.2455523-1-wangkefeng.wang@huawei.com>
 <20231110033324.2455523-3-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110033324.2455523-3-wangkefeng.wang@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB4680:EE_
X-MS-Office365-Filtering-Correlation-Id: e89d7538-a76c-4e4c-54e5-08dbe2370c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVkdLC1EaTnDhObJ4xJpeu6VTJp9kFoasKwavufE5Jh1dH+TNMWc5D6c3asWxgwqA8yRVtB2rSNtoVKTynlXcANljLB+QujIbTvGV+dnMYDg7JJMEsNwSPjpoj1Y9R+3c1VLWDbXRKP22TiFW1ynmedyaRaHmFfw4nxxOyFrpxtdmC6dgUoyqUmNBsnJEMDMPcp6wEiRcK7ucjyQjz1RlXMRQEqEIkNlS48WiyJr6YHXY4dURdc0finxTiU1tZuFWqdl/zIvc9eJ4DSgMzl6rdLWbBs07jpuWxYN8eF/dR//rWzictF5ASAdRP7vz6aKVCwxl4MWYC3hZSo6LXllC8cP2dxDkU+muDry8xDFrytRxUBCLWUJs0Q6a6uzPmWqiQqaYzZAhhib9OWgsYowXNF0LVCuLEskJ661BZfO2pqGK2MMBmHJQtqC5+/fSxQI8owO+J1wtEK0xNpryT7Mfqcarc13YzxGu24DnCbj288xrBYhDx/oTZRpX4o+sDg2rhhqphouVgroVz1Hxyxcw9/t6l36J1+rVPjB8RgJ4TsgdnFvBVeh1HflmiJG7WEp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(346002)(366004)(376002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(86362001)(83380400001)(8936002)(8676002)(4326008)(6916009)(66476007)(54906003)(66556008)(316002)(4744005)(2906002)(44832011)(66946007)(478600001)(5660300002)(6512007)(6486002)(6666004)(6506007)(26005)(2616005)(38100700002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hlor/9gS/2GDSfhXKDM0z/i6vLfZF0SUyaObSpUwSt1mKliMMxeDy0txh7hs?=
 =?us-ascii?Q?h2Lto4zDjlMtt2fs5xMxdItQfKz5N/yAXGuQszPvuCDO/YuJSp7SiASVPtvM?=
 =?us-ascii?Q?drcKFpPVS4A03Fck29BpG4L/acJ9SwJD4QdU35a8XgLUavsniYPS99Iv9CkN?=
 =?us-ascii?Q?L6bjb6hJoC0InNWSjpETGjLDH9KRUkutC0imAhGFurpBYRE2vQWbnpdfIvhi?=
 =?us-ascii?Q?6IoHRECo+WLLNS8AXI/pTzzxC749nWLVTJ2iNCzZ18Da/QnnoWTxVNp0/7g2?=
 =?us-ascii?Q?F3UHg8683KhWpOqVGmpOWAi9DtuViK3dESxCK3Gzi5T4I3OO/3cWRbXYsYI3?=
 =?us-ascii?Q?66ODAVsoumeMPuxGtgNYIQ1VtSANVCv9i9vU05VqGMkeUZBxt252Y4AsvAaz?=
 =?us-ascii?Q?VEHxBwk2yiM9dJbUkM6Y6lsU4jE88RU29JL4EB3HVKSRT1OvIjHbZ3V6rFWd?=
 =?us-ascii?Q?S5u1f3fltGc/ws059Rvp/0MgJ71WJQKVjuicU1bjS0GqANOYf3aiu4GX4YUB?=
 =?us-ascii?Q?pa1NQWI4ZneqcvWt5xhEM6HtWlPSgZKTBO4qdt9hSv1mvsgxC40qfah/HUe2?=
 =?us-ascii?Q?/0UO+UvX8R/LaIDOkXFZrwJGeVp06UFl69rTXYt3eBu70IHBNqpOFr43OjCx?=
 =?us-ascii?Q?u25TvhYvf5oVvn3bd76oFkVU0fuStHTj70rCdpZhxMMHQtUsMPr7KetyimDv?=
 =?us-ascii?Q?c+zXFU6MxgxqXsd0/p6kztUWL8RmMgbepsLZEvpPUfK1TiPyfoXOhFXiKz1n?=
 =?us-ascii?Q?3jcXLvn+4M2gC1LHtUmfh27YRsWaAJlIzcadGVud12OGn+H/dATBNGmTZyHG?=
 =?us-ascii?Q?/YegIgm3aMVV83+NCURraubjCPmF43MYdcAoujU5l7Hf6HRs01Ol9ml7mWYV?=
 =?us-ascii?Q?JYSJ8mB+B/J3eL1BdvPXqGukn7W6vMet53GxHXAjhMJxMu+KcHtotghtWXVO?=
 =?us-ascii?Q?TJQmGkCCjA3mV+KwUzuuTVJzF3hK3aQNoi2bt+Ctu5F7fVLju9naDDfMKvhe?=
 =?us-ascii?Q?ZDP+fzQ/58VhgKJ3nGOZi4zdHYAlseGEDyJQI/fWXgx4bLt9yyceldIwjjJu?=
 =?us-ascii?Q?0exQ9WH/H6qagYBpIh4w1nz3Ra6wVrAVTGVV7jjtRB+1y/AQ+/Bq0z2hvzxO?=
 =?us-ascii?Q?K7/HD03hEhZjf2y+tQ0x1PfVhO2i/LsHOULEqQtm6TMyfVQHKvEz8juDoI45?=
 =?us-ascii?Q?HWXyjKLmmNxicfli7bcLzUoWQ1wyKoshuJNOgZAvDKJMeZu52RVURwF10hWO?=
 =?us-ascii?Q?/RLnYD+uJ+zQlS+YjwJwFctRl78DzuWB4+wb6+E0evK/PyjLoloqMs8jc5DP?=
 =?us-ascii?Q?nWrKdQ+txzzizyGBl9WwjQ1JONstIYps0hWXnW26acOePMfmpi/hZiFCwfex?=
 =?us-ascii?Q?uzbdV2WudX1xDbI3haEYQ8Y+YAxjqFS0ajmkYD0nZ7XnrdD3+yr5+ERrBxIL?=
 =?us-ascii?Q?g/ZcwjCJ1toJo8yYIAteYQlQTgfJ5/0zmm/73kvfmsR1QuEacUGyMqDNN4MW?=
 =?us-ascii?Q?sktK/NNZZTlZkls2TjEKeY0JUgxUQRHiiSUOA6jO7jbMeeJGMbzEY90/dAwV?=
 =?us-ascii?Q?dX46zO1ML7lzz5DBaE/FSOqykWqdm3LsmJplUmaM2viJKszmlfnA5QKJoCUn?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89d7538-a76c-4e4c-54e5-08dbe2370c99
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 21:50:26.7089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fo1xkT23uNAHN4rcYvvvkiTbRhtuBXICjJjTrxd78ALLLu5ae+9HzlSyL4Q1AtRL/JD1+tTbVBJMEveSlD1+3xyj47fbyp2QaLOn2ySb1vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB4680
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:33:19AM +0800, Kefeng Wang wrote:
> Replace nine compound_head() calls with one page_folio().
>

Sorry to echo Matthew, but this commit message is extremely
insufficient and just outright wrong.

Single pass through, here's the real change list:

1) changes PageFLAG() calls to folio_test_FLAG calls
2) changes compound_head() flag checks to folio_test_FLAG checks
3) change page count to folio ref count
   -- without even looking... is this even correct? Need more
      explanation here. Is page count === folio ref count?

So there are really 3 changes in this patch set that should be broken
out separately, even if they all depend on folio flags, because they
need separate explanation and validation for correctness.

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  fs/proc/page.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
