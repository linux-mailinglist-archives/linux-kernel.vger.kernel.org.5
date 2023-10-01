Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB97B46F1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjJAKgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjJAKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:36:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E04FD9;
        Sun,  1 Oct 2023 03:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+9apRzwB7Dhay5tiGBBlcvvPSAI4VAmDoONztyGvUyoMq7bVMxonsOk8jpakdyq8qvuZoIyK6t5o97jIE/aCWontuccRoa+hJw9t60nYpKxREsjOq0cjthpp278xWwLIFrUSZWRVN/DFOiuufXHKVqErJT3duMqQNcvyf0rB9h6fysSF7Jhcnkp3OeKjS9S34ixMhgeScu0jEo2pcyNO/DKgyYsPR376uya3MA1gXwZKfht2dbnughM0Zf7uqP8px1YEQSYxtFKhhwKsCrMbVHAXRAKCmbD0yjwxRQ6usdhO6bbhL3b+6bzoyA18duZqA+DgOJpRseUR0rd5uq28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiWFQXD98sB/XqBci/ZBEfxWRQKjWR7Bg+CDu7V3uMo=;
 b=ifIEiNtEejT9B9mbDJpJsoWAnkBD3fPOj9KwlcOilVwNP8TihAqW+P30TE8gbHX8xsQGhtNQnT/xHm9I/eH8QeV4iU8fQTudEDnJKSzl1NXBhZY9SbeLJCN0lGcylo6TOsMBE0EGuoPRfHBiobQzk7mJeJSYKPTmIeFKqheVBKoA9Lul+j0jw5jqePZZOH1alw3QHKuShTbHKe+lITvs/kHjTYldeX9wxZhcce5klY7byqiNWQ/XHf4p17KKDiNgFzUuJ1eJyWe+45rRpo3QfQz09VHZAlv/UpSnfoYFIfRSLIS20jThiRkpf/KJ1cSkdFcd6gR0PAUe6Y1Ps/PdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiWFQXD98sB/XqBci/ZBEfxWRQKjWR7Bg+CDu7V3uMo=;
 b=F3SCKXvtYiHV2T5OS4GO5aF03hdqSO0EMbByLCQcxL+21OXMCeaSgfmuDitJzuLeQFCdT0Kx/4j4McDhnMjqe6RTdr0WEwOGNPWha4+dbjBsZw5K46lJp/sjQiKFjKPzzY0Qshte3MXLIXhuW28nTP3NfcIsAILY0aDKhxKpflEuj404kTgchgH63bHxEgVyr7WDgEonK7ea6hWxnuXTGSlXsWL14/seek6W2vSxssF5gErokqlSEAZ0yZ3EAlT26y40LVJKmFs69hHzwUN4IIGGnhMEkjZ73lmsRTqrYfji1TUlXuXShfXvG/Jpm2JZcssha37HrsbvGXJHQKGU/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 10:36:02 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fbb3:a23d:62b0:932%4]) with mapi id 15.20.6838.029; Sun, 1 Oct 2023
 10:36:02 +0000
Date:   Sun, 1 Oct 2023 13:35:56 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 5/5] mlxsw: spectrum_span: Annotate struct mlxsw_sp_span
 with __counted_by
Message-ID: <ZRlLjD1hEYRWZunt@shredder>
References: <20230929180611.work.870-kees@kernel.org>
 <20230929180746.3005922-5-keescook@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929180746.3005922-5-keescook@chromium.org>
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: d195d662-3988-4e08-3445-08dbc26a35b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHuwFO9Z0dkxtuWPrfJ8utPlu9h89dXX4I4khci0HLIPYxPAx4Ixdkn+Bj+v4tasQv8j59c53WRjcJxy71O4OWrpBs1JbLNTMVLK0s7lp6tibQZGgFQWvBKSn1FuFUjw67RWhRME/r93t7NtqAIG57yyZLFCmJMxqo2Sm5SaF+lo6ji2hlBPTi5sQUHmHBkM3QHGGlpyr9/Kbz2Wb7HEg9axVFuoIUB1y3tGDXK/rJG1uDgxKC5wdBtTcV3lBYrYRcX1lCM+6+lye7HSAEJsGfL7GM0bj9yUeO9/5Uvs/mwWqnvX0J34tNqfWUz21f/knC8aPYqOY+xWAzX5EXvRCgdxWJMehAYpSObywgbLBaE0EjTpXNI3HZAmSmAXKiWi6/p0oby/8o7lJOOm7w+hDQAOHzKlFySdaYzCO1cfkmpaEdt2Xn1vAZbWvBYCCx255vgeYgn+WhN2Dmw6y+6v09mg/iiYwGHngyzBcr3YayAsc/T4jBKoCmNuFzbIcu50Q4CU6YW91TAfBORFjM0XclMQ9EItd7JtLx6BP5jeIAY1aqVIsE8Q3IIKOsDQrX14tyRBNVK6kwzLRex3wBiVKWScnsMFkbCnxwPm7idZqhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(38100700002)(4326008)(8676002)(8936002)(2906002)(9686003)(4744005)(6506007)(7416002)(6666004)(6512007)(86362001)(966005)(6486002)(5660300002)(33716001)(478600001)(54906003)(66476007)(66946007)(66556008)(316002)(6916009)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JXjhssXrRXgMjM7PnHFyy2SOPxIw+NP1uJI1aiSnrxojy3AOCXuIaObtaVIx?=
 =?us-ascii?Q?mN/dO8Mn072LaqX56/CiN/JiJaDuyykSwQWyyvszBO6WzVLvWGXcz6F3jO3c?=
 =?us-ascii?Q?zRAI/4jzX4Wp52lyuVBUwWp7Shz+MjdwTuOEMWjhQL3/86Gq6g3pHFDRWTp6?=
 =?us-ascii?Q?vaDeYufOkK5QrcmUM+oeiOQsTLx6hSzli3rQodWKxC64tzpDV46Gp15vjcr0?=
 =?us-ascii?Q?Rg66PhaA9e3APsgeCebVM5Pbm51CKLLuYY7+TT5c2b9NjTpQpjxlCxd6Duho?=
 =?us-ascii?Q?1FrMq2za2hiXtY87j2NQK4iaqOvZQRqh0pnWvQ7MV1dCWnWjRHup/Ful/y7d?=
 =?us-ascii?Q?UlRbItu4hSYUimxdlgDyB5UBpPwsnC6LkEyfYURNWIT2P+Meo5XsNx44soo7?=
 =?us-ascii?Q?Y81WzJo3nTN9BFZfQ8oucfMbqmC7gnBtvelchmBcmy+DcUHJTBekFAw7QwSt?=
 =?us-ascii?Q?X624ut2KC6G5wqZzASPRxplfmpTsQmgUH/gD84Mc/O45CjyIdcahezsM8MVv?=
 =?us-ascii?Q?IraON5aeq/lmgDAdtzZsl/ykhQt7aia3ZGkWfX2f9EYhpPuJRt/SGIJ8N6T/?=
 =?us-ascii?Q?uYsqgX61MneZpKxMOwdY/0Dkex3tSPTxAM2T/lKrXNlQ7LvXFRJiXWlCk7b8?=
 =?us-ascii?Q?FzXgIvMjxADo7hn1tZWg2XdKPiZJ4Vd33W+Mh7prCFul7GTSr+6c6oQAZsu1?=
 =?us-ascii?Q?4OW92KxeOQM7Kjo+zqoG9/JsBo2cN13LIKysD0VxXpXFOz0XjLwafGuYKrTn?=
 =?us-ascii?Q?e+usVTJdw2of0Er2g78Hht0nWt0sUbAq8VgJr6i3CLEdb2OK9yRpxorVj4my?=
 =?us-ascii?Q?AVtSeRrH+NBM7RuS/53PGI/ka6CwmB6MDezOj8uJJy7c3WB+KO0f0v9N8tmS?=
 =?us-ascii?Q?F3bZgXAHhukZvZS4mkD9B4gHbqeUrL+70FWuOoyWXKMgQUzw9CTSfZVggUv0?=
 =?us-ascii?Q?lJ+SP6rAgqqy/0wDLqfuRPG3+K6GCraEjDrT+mIDJNgjWBYnPVKqctjLzIny?=
 =?us-ascii?Q?uZC8R5Z4/2fgpADdwNc8uqQdqJUQL9yUAzK67UAU5vy2SF5LF6nEi5zswuB6?=
 =?us-ascii?Q?DTpTeSF39q0hMRYM1NrSpCdx7pZhGgzVepvlcYuerP5/UVbZXb35MORstnfh?=
 =?us-ascii?Q?9mH0zZx74EMxizWrrjv50lEOuDE0dXxdIPTxJ/h2qxSxhIZBavr7AMRqwEhd?=
 =?us-ascii?Q?pVWzw3jfB4KMaHEewXmRFLfo6NNiAxv52/asGOMa56LhEIj8AgD1Ayviqpb9?=
 =?us-ascii?Q?O29oe9BiOOVlumyZrlYWpqKeI6ZRTn7cPPVfdl1OZ5XlJAq8a1DXtn2/Q+ys?=
 =?us-ascii?Q?O7HKoBCPer36wni1Kkdiu6wlagIumzbnFWUQzwbT36Jyuc8LLPk6EljM5jLr?=
 =?us-ascii?Q?uiZDHRzM+j20JxV2VZNIg0tSIZeL2Omvofs+SeU/N7SeataOTUdnd0kxIGGN?=
 =?us-ascii?Q?nbNTsbYNe152Fhk2cVhUUbccWk+Rh1W/9/8h+brNAK9iLH+52MMdtX6uUYLW?=
 =?us-ascii?Q?ZIe5avjOprhu07j+cSBgbRCQ9q6TrRoRNwd/ZVn3JrgCKT19bFN4kyLqaABg?=
 =?us-ascii?Q?Gh4nZsuB8VxYgBeTw8FLBeHN4jR50Kl02DpKsJZt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d195d662-3988-4e08-3445-08dbc26a35b9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 10:36:02.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SxmjCsV5idDYZ82eNUK3P9Gi0E5ZxlVFS98YQfegrJR/Q/vmP/kdsyGgtYA0k+gN9ApiYb3fesLGf68s2ZHXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:07:44AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_span.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks for taking care of that
