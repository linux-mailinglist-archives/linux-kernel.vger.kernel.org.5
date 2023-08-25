Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463D1788D93
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbjHYRGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344234AbjHYRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:06:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2134.outbound.protection.outlook.com [40.107.94.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE81D212C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpiYxvfYvYheIQTey4+YriUIIZRgu2Fi5OwYqvCBwKvHviu2014NUwm+QRg71g8snpuC6OWRLwnlD7kuCp1B0uTOnftoW1aUAAHQEJb4VNmMR0FEPZe/vwtQXJb8mTiLsObyy7q1954NK3uG/nvwGgtCeS+yA/a8oIWtNJrw/jHlGgx2pDiV3U5zDYWMVZYrd2pfRrGtx000uQp2b1gdrKV27AISabBDcQmfahyFP/aW3sBYYqXg9wQ72+7xT8djBoXn9pdfq/v9jZHCuimn/K4EoOyTw3BGETB12/SHXY3859fN0md/gh4HpfqgNGRVEj8CPcwIz76MVMZQxGy9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MoEox2nhEFjZhCb7jF86o7rrsOJ1+wzA0GVyhoHjHU=;
 b=H4eF9XFxzMH1bKbOj/FnkIPX0GsqNo6jkMBAcRLZ0oY9a9d34JXXkqnn5fKR1zWxb/mQWgS5QpwEZZpqIfd6BniwLXRIbNkc0dfLZ/jYyNrHhHmc0+TMeELwtnHEnW04BjAt7X0tMrlXuyN05rg3sWadu0ms2ar/fGPh8aQLNyIV6IsC8TJleXsH+1RU4oENZthh3vCEQPnR5IjRN9O7gcjTN6lL5etuQEMQmgIrxSePYpzKJxxZPT9OHxybqNAJZZHm6cyRzkaK7QwcM4UhwpX2Clj+B5Df9JtOtaaM9FvC/N2/H4KKDA1xaIx9bkqehM9DGtSveawOvw+QDBVLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MoEox2nhEFjZhCb7jF86o7rrsOJ1+wzA0GVyhoHjHU=;
 b=Aakep+awg+XzepViw01w0CTf33QVpx7n0qKPLc0GdqA0Pm08DR8x4xOu7ghWKTWlzvxXjVmZTJ+GToXrzOM9x16T21UbusmXze7XyHW2fl8GyNqHJCPnP7PQ9+Fz7zFgAmK2w0zilqWtO8XLhB26GijBbuepmkxBL457uqhhNPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 LV8PR01MB8455.prod.exchangelabs.com (2603:10b6:408:18a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 17:06:23 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::67e1:3510:9ea0:8661]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::67e1:3510:9ea0:8661%7]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 17:06:23 +0000
Date:   Fri, 25 Aug 2023 10:06:19 -0700 (PDT)
From:   "Lameter, Christopher" <cl@os.amperecomputing.com>
To:     Michal Hocko <mhocko@suse.com>
cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
In-Reply-To: <ZORtHmDeDCMcCb7Q@dhcp22.suse.cz>
Message-ID: <94b0e0c6-a626-46a1-e746-a336d20cdc08@os.amperecomputing.com>
References: <20230811090819.60845-1-ying.huang@intel.com> <ZNYA6YWLqtDOdQne@dhcp22.suse.cz> <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZNxxaFnM9W8+imHD@dhcp22.suse.cz> <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZOMYb27IulTpDFpe@dhcp22.suse.cz>
 <87v8d8dch1.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZOMuCiZ07N+L/ljG@dhcp22.suse.cz> <87msykc9ip.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZORtHmDeDCMcCb7Q@dhcp22.suse.cz>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:610:4f::17) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|LV8PR01MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a039e7-e175-495a-a455-08dba58d9bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apLGPJSQt0rkg9R/FQylhFNzjrvHooyzFUUhxpL5jLHWPXP79vzQ8zIV5mlK5kmirJ7vaQI9WA5KXYwyKpEXTDlYykds2CzfFhYGlWSKyBxpHjLqUrM68kgROxfoH86qOiZ9glvUsF5xw1fyMGMEGHXYbWjUoQbLnqUc3lAgf6j/gwZHKbnunpSDiOXjqmc48zC+jo8Xa96FUPA+nv43SA0kNPsi3Q3bSuPI3g9fc7UoHF85gZmxl3MpeNgh5IINCRsWZzhuXNg8Kv3pDTKolr1IwS1z8S1ipwWvz//USWQq0zCdj6IWb6j5NlM9+75ZlnaFrOxoFytkb73KFsDzEnOxRdtCuR2c64lw0xHoAFEUAWMM7dxQlJGNYPQTgL6f7lDnDYIOU34OQ7tat0r4vofwgCiJx4RoF/KcSkm9YIMrKQ48yR8YLcehGhsFSvhJf0WjYhXpfvGTJZPvQfX1gMatFJWCaHDKPUXGc0g49NrHBtxqY9Y+6c6M6M+ij/eFHluXo951e3sjXbjWrDmEoG7CaF3pwRifHtJxHS6kOoBtDWuI0tHRLRyBOgSGdp3m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39850400004)(136003)(346002)(396003)(186009)(1800799009)(451199024)(2616005)(5660300002)(4326008)(8676002)(8936002)(4744005)(83380400001)(26005)(38100700002)(6666004)(6916009)(66946007)(66476007)(6506007)(54906003)(66556008)(316002)(478600001)(31686004)(41300700001)(2906002)(6512007)(86362001)(6486002)(31696002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IrwDjgQUZEoB04E7IN0LqUtiQKVRayqNyaJcPIqZlBxM2ed/BnPVnLh0Y/Y/?=
 =?us-ascii?Q?qj6GH7+0bLA1oeZmPt9lCGSwlLMSqJwZ+CqrD9QfF1OGVjQ86GbgvCuZ8STY?=
 =?us-ascii?Q?qBdwjjUVBRqt6ODx0gX/NxgXGLPQobEgLOOtwoIRspPgjO2NCgkZOpTOwgRt?=
 =?us-ascii?Q?jgaHMImyi3qsPF+UCDJdp17l72MJTFKNFKh6G7GDjZiyBYYYBF3J1ZMoyQHE?=
 =?us-ascii?Q?PzVi1oh1/yoOJ1q9fkjFncOX0xksPp4LohUAxHPJ4A22rbgat/LjlYix4Hgp?=
 =?us-ascii?Q?Vo43vOwgRkkbaJAuCYccOvMeRvgsu7u6vSe1QUwtW1DlAMRSLhHbVoBSqsB1?=
 =?us-ascii?Q?aAbMeyEAkgbNkXguTlb7ZLuVXPUQYX4O1wpf5pgI7rVXFPkG5eO5rqaz7WGp?=
 =?us-ascii?Q?nk4yWhCN06be1jPi/GBOW2CpXy3l25BATmeQyoI4kp2qg4QnWzE3IE7G4ZdW?=
 =?us-ascii?Q?xrFCLxpSL1OQsSK2zduppty9+8NNIM/vtTLwTUZ8pzhaH3xbQW0egosjrI8G?=
 =?us-ascii?Q?Avrbvi3kH9JU1rTfLoQXNuaRNrUMFuhTqcjYUUR2gTxLEjEPRAxkiDW6hlPP?=
 =?us-ascii?Q?2XsUsL1ElVF6tLmx4hdBdYjoXPduyPV95bgcXHfG/bEo9u18dULPb77YR/pO?=
 =?us-ascii?Q?xwL1+iivmyKev/dN+lVLN8jqc7ApuBv8Gm5wpMFvbetdOgOkE/gvFJRXneHO?=
 =?us-ascii?Q?HKzBQJUsRd/wWAFdJC3JYJr7z+LV88NdDmbeadcnhVTAjhR3UQ3N8mfMdqIs?=
 =?us-ascii?Q?9ukskaI7BMGvcv9FIUe6F4U7It14aOvSH/U+5KH4pdt4Ds5TcpVGDinrX0Rn?=
 =?us-ascii?Q?4ytQUwkoGP/hIgDwAOXF5p6T6MiBN+brzVmtVU2c11j2eDolZ/EyAcMwLZuZ?=
 =?us-ascii?Q?IN/ZwVGQ/GmMk9e2OkFccXTQu7Ywo9w33GyjD7OaTSpnBpoyOoGHPCDgAoMS?=
 =?us-ascii?Q?pC/QRmDPL0KDqAl3ew1ksmQoJ8CsD+7URCwwysmItqfULDrcpjjX6wYRAPo2?=
 =?us-ascii?Q?L+Epmm0+uGyNP/rddCyxO75AtOQcqzcZMtkdtcEXdfbWp2ck2ShGRfr1qic1?=
 =?us-ascii?Q?q15nJqgKebZeBd7BQw1yKbOv1bBfsrfgXiNjNH2UUp06Sn0OQmy5ov22YKzj?=
 =?us-ascii?Q?h6R8nw668yCZB0NRX0udJT/wFlOwzwhG3U4jN71lmwQ6qXAJBrD345KKv6rb?=
 =?us-ascii?Q?vwZd1sIfcHW1LHn/Mnq+IcMBAoSZaQAXdKizVLJDewQPnQ6BCC4z4tEYOyKD?=
 =?us-ascii?Q?EYR9vYJcJgxa7SwX+sINyF8Fj3o2RZpuyfS15D7FJmifw6ugZnS7/wrUtMtf?=
 =?us-ascii?Q?CzSOTsAJghrLCdw9xkw1Sl0N3z898HuBp3YjlG6Cxdn9ZHSVdkS8IVj3TPCV?=
 =?us-ascii?Q?qeLygxRB7bbTwMfRZrBY9nmjuzxo7/vxCIDB2Mxymg/7zTT27PLGiPwkx/0a?=
 =?us-ascii?Q?q/If+U4xEEeijtqG3Ak1C75jzO0HOsUEhQgxXbOO2vT8UhUqzo8GEFgLbeDQ?=
 =?us-ascii?Q?Z1lsXRWTJCA8Ysg0E+feKTdhm7giEVAsVo6iBfZ7BzR+r2e9NCr1Oq7vk2Hw?=
 =?us-ascii?Q?wJPPV7CZ6246OzGLwnYqpSW131AYBUK+VVO0QseYSsP5CBghBx/jqUkW52TG?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a039e7-e175-495a-a455-08dba58d9bfb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 17:06:23.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kumqAeIlPSlXurxOPCB8C3Be9OKyjc6jJ1Ca75/OZxlgBAcHs0WIiasegp/mXUc1jNmu9PlTGbNTlIBtxiO/9qaE3g3cj8ygwERIHSu8Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8455
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023, Michal Hocko wrote:

> Yes, this doesn't really show any actual correctness problem so I do not
> think this is sufficient to change the code. You would need to show that
> the existing behavior is actively harmful.

Having some pages from a remote NUMA node stuck in a pcp somewhere is 
making that memory unusable. It is usually rate that these remote pages 
are needed again and so they may remain there for a long time if the 
situation is right.

And he is right that the intended behavior of freeing the remote pages 
has been disabled by the patch.

So I think there is sufficient rationale to apply these fixes.

