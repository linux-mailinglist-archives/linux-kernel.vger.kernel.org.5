Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B367C6896
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjJLIUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjJLIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:20:18 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2132.outbound.protection.outlook.com [40.107.96.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C58A9;
        Thu, 12 Oct 2023 01:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntgHUcVhdRY7VPd6V+IPJyLgDp4/Mo7gs1tp1n89iLXoDVRPe7Dk+7yl+y63nC2+IrStUfwKAn/rNDKapwVipaPUvdBJZUaTT18fV3fvNv0fE+EcomOxpCjZedMwEhslst9YLLxCM+rwhQ1jnfeBfUcO4FsR22r7YDrcYKPBgSd0httqaEZ1HsHnHzRKrkMOpoiDupYSsYQnq2aC4x2MlhYq3ibAFkwap1WjJ5RzNpYGytZu/7kTQvhfyzwrEhGgayqilSSXI6RjFnbuk4yToqUaoQlCG20+gph8fsku5xyFbP55bVkEi7FNqRkrmfvLCp1JPVMks3QKMyjFcDQHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4QNzJBn9YsnomYCrAZYehKHh95XDodptEUOu57WJkw=;
 b=Fkbc3dwJxK/LH0dHQl8Ng2nO3Fx+xSrS8dYByjvxpTT4dChyBX4hsFu0gMW9OzmbHCeGTgOowq+1707wFC7TxyE6+EQhwgaxTW+V+wBB41IFDk+d5oq/RzL3LLcLzleThxEVInLKZAi6c994yYMCe6Obh9uCDtmEiG3xiactJCv2lZCqkpXRnvHPQgIAEsdR/3OoL4KlWQtKhxc306yJVdB7EovcPhgrX7aRn/N7rFaIrANnqKGHZa6J+jEsQdj0h84idh57eGzfN/WLyqVQYhDKwIPvVbQTM6i4DrhIqYH9Z4B5ueKufA6TsSmz+37hRFo3lAlcZWgpqCfi2EZWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4QNzJBn9YsnomYCrAZYehKHh95XDodptEUOu57WJkw=;
 b=RHi6xDOmlgVa9r+ic2i1ojIPN+dbPMCIUFd8hJ7ypXSrR7yca1hRo3dHYkFzHsiuuI1iwUE8GlkocFOAWYRWbbdnVwqyxum/yD1TJ3NlJNK1zi+6NrBhpvyR3apWfzxfvjcHfC0xSeyDICTW7AgfRL/sgpkFGhZmjLQrInbV0s4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BN0PR01MB6893.prod.exchangelabs.com (2603:10b6:408:166::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Thu, 12 Oct 2023 08:20:12 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6863.040; Thu, 12 Oct 2023
 08:20:12 +0000
Date:   Thu, 12 Oct 2023 01:19:41 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-perf tree
In-Reply-To: <20231011172250.5a6498e5@canb.auug.org.au>
Message-ID: <e8ca559b-421e-c326-f33-6edc8bfade@os.amperecomputing.com>
References: <20231011172250.5a6498e5@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:610:b1::34) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BN0PR01MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a1455d-59fd-4699-0f6d-08dbcafc0e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIx6r040e06e5xi2Fb3ChQUehT3No6DUPwjfmxE4IozW2dGRMsxE7ne/HlSakuCUPX9evcl+BbgTR5WbpMVKreBaEJ3NaDtrXuFsrX+4seOg6zLzB0TuBRr0MUD2aohNHBdcCbGssSRRYwOTWKz++4NykQHebAykE8aRiIgMIYMgpOUJIiRBCPFBtnyQE+n0qr6nIZ0lrw5xvz6bI5qouzrrhSHqUs9BndwyTu+9AlpJluTFUsuOuAx1/5WodljmWiPYuYswkmxVXyW+gom/NbJn+BG31X1syUiLhFIxSQyWrTY8hcDzMd9K1Tu99y2xg76KzSH5ho21y/O7d4Zig0D5o7p5IfeA3d+4eu6SYEKIuExvkk5xQsQfZyU8QMFPvV6IpuAPBZUcdyPYQEzo0Haz6JPkMBSTrDfefiWPqiByCEPzHogwSAcynSw+nVEfy4UTgHp0fBtjV2G/c2YjZNXZMtNLbT7her900r8qMcWteX+6MCvhqvMCGEHq6zUsb7SRVKp8LXLc36muJ9KnIDMrHaE/dm6nUn3ktzET8kwiHMdGTRn2qIIEfLn+SQXhG+ICDD+Uzf0BKuPCyGbtXZSSvK/z7+PZGsMqVtQs2Aw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2616005)(6666004)(6512007)(52116002)(38350700002)(38100700002)(86362001)(26005)(83380400001)(6506007)(66476007)(110136005)(54906003)(316002)(66556008)(66946007)(2906002)(4744005)(8676002)(8936002)(4326008)(5660300002)(41300700001)(966005)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34rnN9v39QHp/pED5lv1fDTnWcxQaMbKWBWJjMNbBO2+8JLhr3AicjXQs6Qd?=
 =?us-ascii?Q?9MiHQZGgXoMpSHJpD3GX2PAHgBJjQZnw58sFNg48WWU/C1/PwyYaKNHynTZw?=
 =?us-ascii?Q?57mi9gcOXmVYw5/6eA8sbJuynTPZ7S+1LsKV3tjmAw8cslwdW9+dvsBq0YYo?=
 =?us-ascii?Q?ofl3HeGb8aFApz15uKxhWlUjJlDLv97mrYwuCq+IcyH+9mgWwHOX/2wHq6vv?=
 =?us-ascii?Q?DxSmFyHHXJ6QUNP3bwjkACOS6Dipe00WjNp+hpdAsAiH3RK8YZDLTX+gpnvD?=
 =?us-ascii?Q?L2icbNRgg9fDj7mFbqw77raZlIVLtqqzpx7EXzIwNCi3Uw1EhvZvROvJDl1N?=
 =?us-ascii?Q?qC/grAoUpoTgebFfm8pVugzpyGea1zo1bYseuVxiIFszZC+VQ24vMYdp190c?=
 =?us-ascii?Q?3hWJJvDTSdDnJt3Ju7c2s/fyCHoq6ajZH1faglrES7N4o2UtDeE6WQFe2hup?=
 =?us-ascii?Q?axcpasKw5jPxZ27rn+hMIw6RcmvHfH9LM8hsXXWf82238bvjsbfMHL7sC0hu?=
 =?us-ascii?Q?ClOaoFhRGEs/WBPyyZk5GsX8k8ah54Ebo+UqDFnrwfCBgRQJwNvBeQEkLRL3?=
 =?us-ascii?Q?4hcNV4GgctIJByhl4ahw8yVDWfzMuYFvkAxg/yEAU1yy5CNRUPKjcBN5DS9k?=
 =?us-ascii?Q?8St30z1oxPhuLW6bY8WXCNOMgKmKLMLmsubm7pfdtgzKa9CEpayME9Xho8zn?=
 =?us-ascii?Q?HUvN/6sYMu34+mK9jMfbsz2yu91gbbbBZHKJfq33UAJ7ow7FoNUSUBgzSLkd?=
 =?us-ascii?Q?Xu+u6Lnx5lhKi279FK7HbsFZT0Y0sCU5k4l6Nt8xWvdY8stm7eBE6iJwjIce?=
 =?us-ascii?Q?CrfaymDaODr4+RrjqpTojd2OfwTiAULkqtSE+BLLVWCdYz+7YGfizDk3gOO3?=
 =?us-ascii?Q?uLvzNKocYR88dlow6L+FqO8A+mGZv7ZE1GrrOofByKSmrBWpEo3iVGmPfoCv?=
 =?us-ascii?Q?dglkl+oTQsOM6c/5/Tr67kjw5IvrIRYwIPohZBNmo/OJv+GlxIxENo0ba0Lh?=
 =?us-ascii?Q?tbUZl+q4y9LatQ9zGr+w6t35ndlIyFL+VdYhLB7YNoKpAsGQiVv9cmCCX54H?=
 =?us-ascii?Q?kojvkj/iI8YNPHTtbfeToFf17ldydaDZUsk+5ey77dwyjlu/u6G6ZghS3VmV?=
 =?us-ascii?Q?Fy2JulzPyHskMgM/DdbWDxw7hpN6KKLlLtfH017Fi7xclzEA06XJu1m1nM6n?=
 =?us-ascii?Q?locrH9/dJyfJp+8XpmdeaXGpwP+iwlGUEj+Ja9YjxtI+bj8Kh1bSlwARdQhN?=
 =?us-ascii?Q?p2tLYXbePf9SGh2Q+31q2i0A/MoxlM/+eIJpjX5aXYwZncA3Emfuhj7WOglb?=
 =?us-ascii?Q?/uh7DCDnWECNUvDUUMIDjx0eOhKhgmsDxXB24HC6Rfk/c5uE9RcltGEZ7EhN?=
 =?us-ascii?Q?N0YBNVT8ChecmfPViLmNuHjlN+LVb1n9zaPipUqS3dJGLFY7V/PN4G5dVOyz?=
 =?us-ascii?Q?gRamys0aGJQjrIQRFr/sWewFiZJx/r0+Thns4J+q5kRH2frQZyyOKs6pn06j?=
 =?us-ascii?Q?F6Ty32B8kNfM9PSMr9y4AoBdl5lLgCqSCOe+l76i+GB6G5TiupY1DbwS8Gfj?=
 =?us-ascii?Q?r/ZOznL9P3+ELwmWX98HXLCB/BmN8nzqJgWCf1eiSnpzF/5JTuHQ1s/8uQkM?=
 =?us-ascii?Q?VW8M3vWmRclxwXCJEA0uPoo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a1455d-59fd-4699-0f6d-08dbcafc0e06
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:20:12.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5O2vyrXud5B6ywTfFPAeOX5m/KVzRG4UtZ8VLmvgt9l+u2hKSjEx4WAvEfHdDdldks0ymd04QKO+gBww4y8tgoR/QAWIhGVK1jQXEXmiaS6osCkFwDGbywq0U+nEPOf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6893
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Oct 2023, Stephen Rothwell wrote:
> Hi all,
>
> After merging the arm-perf tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/admin-guide/perf/ampere_cspmu.rst: WARNING: document isn't included in any toctree
>
> Introduced by commit
>
>  53a810ad3c5c ("perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU")

Thanks Stephen for catching another bug!



Will, it seems that I had made another stupid bug in the same patch. This 
time I hadn't added the ampere cspmu document to perf toctree. I submitted 
a fix for it:

 	https://lore.kernel.org/all/20231012074103.3772114-1-ilkka@os.amperecomputing.com/


Could you apply the patch or merge it with the ampere cspmu patch, 
whichever you prefer?

Cheers, Ilkka
