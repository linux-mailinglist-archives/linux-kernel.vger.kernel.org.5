Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7C7EE46F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbjKPPcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjKPPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:32:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966B71BC7;
        Thu, 16 Nov 2023 07:31:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGqDQU/OgXbktdkWHb/aJXFzGQJVqS3lwnScsf4EQDVGzT7AmyB3jbEH1IDKlpZ5+CulL1UqFiiVe4iybBuleD1xQfChSzUnE+kL/FmJtZVrWGmX9cFQkFNbucgV3BhJLcH1swZ43crVyIn+XpjqN21VAAgBKxQSGjUOOag2UutOmQPVE79vSEqqY6Ailt3wxLqGfJoOSiOwh+EHd4uDIBHb88oPWDg2XRtApZAj28ahpkm0rToFcA5n40oBNE9t4XOtRSjQwgGoYd3OhTT130EMpC9dOpHEjNiLU1bOc0EwvkC5oqIux6xNCp5Lcemg3w2EcX7bJUvmTPPYvQW3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAYBSKfP4pU3rqewRvgC57MxHVjYdDHw92TAgwIzleQ=;
 b=T7T0TuKKuVKy5XvClNUI03wzucOT266msTR3MRekRemQoD5Sd9Q7z7BIeyRGVG8uQbTf9+1/VorFdyF8vi0QmZ+NNB1lo1idq021vU1C+zHKIcpZtU2CvpL29nxYl3PtwlBtIFUV6ig9afDee5YIk2FoSyDXD/MwYSyKa8ZhxAFTzltxM7buj5OvMaR2aECo0c1Dv20WpMJ4w0xjjkE1KBvhJqrOjBsVPORQNyerrsN178nEzlizpffiRor5tByKDBEx42NddAi/hkMCI6YTHs1Tfu/pn4+Fy1U9pvKIwdnRgHs6cF3/3JM0qIhyc+WaT53bz1aFHvJn1R+b0KbleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAYBSKfP4pU3rqewRvgC57MxHVjYdDHw92TAgwIzleQ=;
 b=Ql7kZbE9rrvarDroMOeScGdVpLS/pquJfUwRLi6qSzFEPvCgXHixPK2wPMc+AGveeSbeJtxoVOZOJxsJwtj14Urbh1bMJaXTo86y31n8AOH0PgThQdsN2TtL85jrjDJWT5jiT9ehVj5b+LEOjHE57ayFGqyzz2Nm3BYpVuMqlzGSk3WMaSAvwlVvIqZ39lnL1ezG5A+2qONwb5pevEc5hOxC+JLCtdhzLZbBTj+aa73/FErakaREOe4YFZLL6T5iVwUgn4hEiuODaRWvzN7ADyf2mBQV7Uf3w5MM093CDr6F2vj4oPg32TC4ZU4w7IlD/mD1+uWBm6SfbUucVcQwKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 15:31:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 15:31:48 +0000
Date:   Thu, 16 Nov 2023 11:31:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Message-ID: <ZVY14zBmi1wgZBiw@nvidia.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <ZVNzS2EA4zQRwIQ7@nvidia.com>
 <ed875644-95e8-629a-4c28-bf42329efa56@huawei.com>
 <ZVTJ0/lm1oUDzzHe@nvidia.com>
 <0a1cdd5a-c4c5-3d77-20a2-2beb8e3a6411@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1cdd5a-c4c5-3d77-20a2-2beb8e3a6411@huawei.com>
X-ClientProxiedBy: MN2PR01CA0012.prod.exchangelabs.com (2603:10b6:208:10c::25)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2036a7-a806-4355-1717-08dbe6b925e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zip2sGGvK1VzJ1t+mXTxfbOzsDPuVdgahrzxtHyDTVWf6tqtZWbIup8dRlI9lrMv8srU6mF8NjMV59wy6KQy8ZgJcEty3Np/1LaQM1Wj4frAxG95hjqkLv6O7D42TyRqfTyWMBg/GVM5rY88SN5P3grH9oWP7mL005l2n53O8yoePw8YazYSWkWzjtgkC6UULFdnGEYs7X1mo/LgP3JU7HDEERr77ulSvsAVBY0Cc6CfPcyrSs0swx+yH+D9WsI6ryF+DVx1X8IhoOlmjuqApW579lKlnXdovw5ReW1xMYLUgRDfKhBHl/24NE6HCR6havCVY1HutIIDUAfnRArmzVb565u8Wdy8JsU/pZYeXrXekr3scxt+L6gy8gJY8ulK8Ip+bnbWHnhxQiEoTYrkzZPUtdIvrH42pyuJMl6wRIvn/W+3d4s2Tl7NYkxz+1nEPDIkCqMKbO5PlzMz7NFvX34YGVqWBxptI/DZOMIKsDmfJZZCej/YZieyQ6U1Dmgrt1vSIJ4WMnxdYbO7wfKzfHHfPcYjdrRQXlxfUlLuJBQQG6PLVWB2rNNTqpTDwrT6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(83380400001)(6512007)(6506007)(478600001)(6486002)(4326008)(8936002)(66556008)(8676002)(2616005)(54906003)(55236004)(53546011)(26005)(6916009)(316002)(66476007)(66946007)(7416002)(2906002)(86362001)(38100700002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SalxX0l0mbvb4JaLOjGZmgfHyt55sZ/6z54FDTQOfLjyquJFGzr4yk1YhCOU?=
 =?us-ascii?Q?9TI4sAYlEPnnUgqvRQriH0bQiHkCsYuv9TQAZk01Wwmx5m95l9d0VBxOjhTI?=
 =?us-ascii?Q?AVVxL1Ljfi4dOcAA1Yj/agW+eKhpkvK5fkvMqry9Zz/9+BRmegot2yoMrYRE?=
 =?us-ascii?Q?azqrgnoKC1WJzSfiUMYz2kiIF2JCRS78aZpmpT6zeOlHknsYGxsPpBVerZSp?=
 =?us-ascii?Q?XI4trQ7p0k0Uvggd3Qzkhj5EuEm/e7Yc07pop+8TAMgh0ywPG06UI/TQyjze?=
 =?us-ascii?Q?wItDajRNzEAqQ8AIadpSrjEGrTSX0QexUBoNx0nZZ0ZBRNB54idSAUlp5Kas?=
 =?us-ascii?Q?e+AAmRz5lOPTsI3glSrjdNVvgavjUY9Lx/ZvtSO8WR9EQHZcfGi5QqLHRXQs?=
 =?us-ascii?Q?CO3Cgcf41TWJiVNUoFUvSMWr6PNn/rkHWpiZ34fiRjhzVThCvJN6H6Q29qPs?=
 =?us-ascii?Q?Enxvt1g0CK44bSvuMYFQ4VliGKy6vrgvnO12pxlCAkticEBFN9PEm6LYBl+/?=
 =?us-ascii?Q?qmRMi0qicE4tg0pEGICj9ZSA2sv8w/a6FyUcWBAQ/flu1arVImK5jKmLo3Xi?=
 =?us-ascii?Q?9U6k0KkaW1BktKhSRi9P9FG9rgatINFtZOs8hWh+GLVywmNUtvNdBt6JAFsC?=
 =?us-ascii?Q?gXvO8r2PgQwHc8XqMjDlI+PUzVcAtcFvNrjCHc0l1Ijk6Ff+5jZF5Adu1xy8?=
 =?us-ascii?Q?xW9xAj2fQW459Zrn24EDHbeQAZJ3a/T/H7A/x5n0qoS6EsralEOwEPE7kB06?=
 =?us-ascii?Q?PUC+dPpuQbBjC4+9YekFWH85t0gLfnPa0hW/BZ9bwcYQWz3MBcmlaswCKPAA?=
 =?us-ascii?Q?RRH5OqgSV3mF3D3EGV/jarCJldkizsclQqVeBT0rHCm/251Lz+GKNz2Ulzoo?=
 =?us-ascii?Q?SSbuzl/gA9GAe7d+fTn7bzJXryk8DKOyhUzc6p/CiB5BI7NqOMl63HfRes0V?=
 =?us-ascii?Q?2goqpM7oUet+m+qXUfrK9amnRbCiCCSe38kx57OwVA//Nsb2ISgKTDrV2qtp?=
 =?us-ascii?Q?uADOxJb/OHMAw+ijdt2P7I02ElL+gKvL1uOpNg0XXCHQEVYAWbNJExUng7gQ?=
 =?us-ascii?Q?8tYxufjbK3hkqDISA6Dtd8diFDXRhe+Z73/U7MxjKwAckEwQAwwSHKHnTwma?=
 =?us-ascii?Q?CCJ2I4E7I1L0gC7FlEnQJirfvHlvVt0JIXznHUnficAWO5QXNpun7v1YVna8?=
 =?us-ascii?Q?45/2OCDSIa+oeNnfupUOsTOP5uMrek97zab+zvBeRniGLns9+iBGoBtQz63f?=
 =?us-ascii?Q?SAU+7IBTRk54ikDQTAhKFgDY3qxG0BrUWmN/y8VVT+eR7MUErq4V0qLXx8YY?=
 =?us-ascii?Q?Mlgk4P9ZCAGiGMP4wxFbSGjn4t7gtWLYzEYvjuAlsDzUzOLuk1d/7jRW8YIr?=
 =?us-ascii?Q?2oCOFQckET3ETj6VuGC0rIcyzTRuEqGGR5DQsYWjZ1hOPW+eotvXTv6p1k7z?=
 =?us-ascii?Q?sUuOdsJrnyuYmEd7+lI7x5OCPW3eWi0umM5gVViQFYoSbW67tYqcZNxAJSCH?=
 =?us-ascii?Q?rAOdNBjJScbIIxk/244Tha1WGg+au5xgQ2mUpI3QZVdieK+Z8z9JG8e3tcT/?=
 =?us-ascii?Q?f8MUx22oRs5v3YfFfvhIn2Lu5HatGotnLD5dkkt9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2036a7-a806-4355-1717-08dbe6b925e4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 15:31:48.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFrTSH138ZaUuBrwLePA3Kpo2JQj3fzVaA6pD4EBLFvWj1d7eu5hG3jWd1UtJ6pH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 07:10:01PM +0800, Yunsheng Lin wrote:
> On 2023/11/15 21:38, Jason Gunthorpe wrote:
> > On Wed, Nov 15, 2023 at 05:21:02PM +0800, Yunsheng Lin wrote:
> > 
> >>>>> I would expect net stack, page pool, driver still see the 'struct page',
> >>>>> only memory provider see the specific struct for itself, for the above,
> >>>>> devmem memory provider sees the 'struct page_pool_iov'.
> >>>>>
> >>>>> The reason I still expect driver to see the 'struct page' is that driver
> >>>>> will still need to support normal memory besides devmem.
> >>>
> >>> I wouldn't say this approach is unreasonable, but it does have to be
> >>> done carefully to isolate the mm. Keeping the struct page in the API
> >>> is going to make this very hard.
> >>
> >> I would expect that most of the isolation is done in page pool, as far as
> >> I can see:
> > 
> > It is the sort of thing that is important enough it should have
> > compiler help via types to prove that it is being done
> > properly. Otherwise it will be full of mistakes over time.
> 
> Yes, agreed.
> 
> I have done something similar as willy has done for some of
> folio conversion as below:

That is not at all what I mean, I mean you should not use
struct page * types at all in code that flows from the _iov version
except via limited accessors that can be audited and have appropriate
assertions.

Just releasing struct page * that is not a struct page * everywhere
without type safety will never be correct long term.

Jason
