Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17BA7B0993
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjI0QFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjI0QFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:05:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED06E95;
        Wed, 27 Sep 2023 09:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1AX07Q+U+kmHbbmp/URr/z2dO4AoPf40S4F1B98TI/UBqjWVZS2V17djZy1vC6t/hlbf+L5xjbt9yxNTy8EiwyJBZR2l9lE96QZvJUqEqRcU3HzCrvvti3ADyCyt3hW6z+es2iX1R6hhFpMm4eJMUF3eTUBfsuwDu8CblLvm6zXsnDdGRzWIcUFM3e/CqpG74cvkLG8v2lJuloRU7sxBlsP69oX9NJwZk2YKZmsZ+FkjxGw1DeYDrMcHL1j7mpnEb5TzcnoAy6LXgR0747ENJHDS8oVhha7MfmZgkF8/CF1rrWga669ldQ1nZ4mzet8/Yfophpy3PbX+Eslku4V1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b71DXxL98B37KWCFFjJyRP0JNULrfy8Hz8jpKD9FiGQ=;
 b=YldTkQ/o8XmVAZFA0iZ9Xal5nlS6/bzuyBXj7OAAj3Gyyu9l1QsBM73g4YdKgN14gRQah/ZJd7vWBPyBb8ysxWXa2bSXcjOrkUrurQl8ld0ZYjb8e/Sc784Fj7dzSxpma3FT8yO66784il6xey0q/YxaBFbzv6folt6SLtWF+jR/D4kXswNAgKUDFuFg0JI4ZYW+JmUV1IG+GFuTPU4XlMJ+8YIhTvXbf2qqtlF5DN/LWjbnM8sb6OglXj0XAqRQIHEQdO6+H3zn8wera+V/3cq0kJpJAbKqfB79EDykEDRwcSK/09oMbJKcrfzhHWphMxT6qE/aHBgzIKtu12bEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b71DXxL98B37KWCFFjJyRP0JNULrfy8Hz8jpKD9FiGQ=;
 b=YUqZgvU07iSR6we7Ozx2YuQrksVtg4lpp6NzfEbqrymrPd5ki9HnduN1K5d84RqmrNqVnnOGyZHVzi3Nh9mz4HXEVH+h19bs1htjFkwxuGQISTyx9D/RWfhpWSvqpP29SJCCJDs+7Api90vlFoqaeyipZ9r/xs2oEOoGuS46Hts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Wed, 27 Sep
 2023 16:04:56 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8%4]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 16:04:55 +0000
Date:   Wed, 27 Sep 2023 18:04:48 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v11 00/20] cxl/pci: Add support for RCH RAS error handling
Message-ID: <ZRRSoAs04kYWttnj@rric.localdomain>
References: <20230927154339.1600738-1-rrichter@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927154339.1600738-1-rrichter@amd.com>
X-ClientProxiedBy: VI1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:802:1::48) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d071a96-a552-4b2f-fc1d-08dbbf737dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7E/KALjU/5eUpgCzOMiO8p6LOjnC7eA7wjK1otsMTjvWA/BFY2sDL0x4TrJnNkGd2qb7FbeBt9eVsnH6arULJXz8Yx0NyDq4ra1eysL9Xj5AW/1IRSsjjlFIvRr0uiT9QlbrNMlpVeVy70qGeZrkq85VffbzQI4+nzfHQgh3QXkJ2sTAjCR1QIgkmh2oPWXfLs3bXJdw9Jkmvi+HtRNY+QRm4rp2eepPl1QZWXRIjjbxvMCuBhJlET9XYplMKBoDBqqp1IyABSJb2Ym00jcCgfySzO/rrtd/yC3YrAWE+Bcy0+p4LZQAPNPOJc+Irxiwq6I0jukS7NqM9lRF4FanIM5hUX9T1MGGxSvaHY1RmEpjp86+8Sc0/HtJ7Iv9gPsJd6fs+MAVaM1ItzA2n7qVNiFbxsJ5m2++8tTaiS4NQLN6T26BGkByIIv9Tm7CWhRbl4pQHUTSnb0tL7lU25GY+QyP3GZMkRdbl5SCZeIIiPt0T5LJ1+CDNe4YQD+xmDwCSVq+/NYobp/Rttf35MtuqnKt+ahf247ep74obqVWpU58c3ZLxCFLdugEuiF7pL7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6506007)(53546011)(6512007)(9686003)(26005)(4326008)(8676002)(8936002)(5660300002)(2906002)(316002)(41300700001)(6916009)(66946007)(54906003)(66476007)(66556008)(38100700002)(6666004)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mlwf5QyH0CoMDEjsP+qoprv0USJumUvlBwsnWmBAOfGgYOlcBbavn2Gih1nw?=
 =?us-ascii?Q?61XFMHfhWB5ooZsIu9GQBiChWS8i53y/CTXpyqIKSBW67dTdozhH5bBwdi9T?=
 =?us-ascii?Q?y6H7vvH/kWyK40QkoSBW6tXOtNxtApqw6NG5RxItPPvv99/RYplGcyZ0PJ/B?=
 =?us-ascii?Q?WpmZuhZUdZVqdGX5FjeOuVC1RUVqyKldDUkhKT7GxKCgO5puQDJ3h7as4OC9?=
 =?us-ascii?Q?ej25knLTdNlrd+M0XS5wPAsUCaO76tIhGeXXt7KgX9iOIsUR0oiEdGGTqmyu?=
 =?us-ascii?Q?s8t9uJaP3rXMAflA6usYAwe48Ad6eRV9PcHTUIygXS3xOAgDHu6MTm4w/mN2?=
 =?us-ascii?Q?mq18UTGYgA1Tov50HL9AGkGJb/MPGgOMgWofBofV3fZJ55F07pCk+hzfjstl?=
 =?us-ascii?Q?TwZJUzzj3zAYzdOGySfOTTpS42gndlpInBgqExw+p2dSDrufF8pSjxvGfies?=
 =?us-ascii?Q?OJ7wSoQmibr4uutevNgpDjpI6COSzOYI40XgjiHSoPxtWuwCvQSRzd2BybbZ?=
 =?us-ascii?Q?RumNTp6vt5AHzCfYzufM7XtrERw1sMTki1W1P5122PzRawvU56dUaKRgkPnC?=
 =?us-ascii?Q?BoAgGM+xOUTcADFWGn1Bo0hOw4wLsRHENTpsro84AqjytvPrsFBVAwU0O5X8?=
 =?us-ascii?Q?03URQEQ5YYUy88PnE5SljCx6Ro5MZzKtjbxiTqts7ZFf6BnkscHYqqj0yQHS?=
 =?us-ascii?Q?hYpUrbGW9h6UAQglFY4RpgY3jC37OEsUinX1422j6+rqT56XnuKwOeDR0jcg?=
 =?us-ascii?Q?PvXUJd4jqqEi4uq8PakGeWHut5TDDMH83iYe1SIsgegCF8cSCJhciw5bqv4q?=
 =?us-ascii?Q?bpODSwd4qkhI4NQd8MA6b7o9P7onWkxuj/SIe0P4itnsH1IlhH55FUCScZte?=
 =?us-ascii?Q?eZpH5Hr93rNBkjGQB1suGJq5iQbS+vVmbTH4av6S7SkIX60URmAQ5aK5F321?=
 =?us-ascii?Q?yc+Ie+pE5lGGSE2wF067I9nxSEPEaI9iqUIaMH/Ty2H9aW9y4wlQw6T/EVP9?=
 =?us-ascii?Q?mXrsXJZMCVw/Ciz2RTul46/MqNyd9C5YIR/HvE98WvC4wKf+3geZfvBCO9iU?=
 =?us-ascii?Q?wbjomPnuAtSz7ija9Ol4PQxKw6IrYhHarUduBazy5qT5tHE/v+/OiI+fQKM8?=
 =?us-ascii?Q?Ed+noNZBh9jtRSvkYk0esWzDTyL+WM0UUMy4ZiL8xcSHG/US+GLiP6cuQNYr?=
 =?us-ascii?Q?709utaJGfM/Nl4X5bJjxGUavyQFE1zytB+tFIV3h/Dykk3o/7LmK54FnVvtw?=
 =?us-ascii?Q?NNLXWAL90u0HrI0dbhM0JNdjU40AnciJcfyNB/Bom2SHuUd8r6AMJ0ozE/rG?=
 =?us-ascii?Q?4zqsN8HMEpEoneEjure5TiBB3d7EZzFsKww3HXvli9V5Fro5exHnNxPEJN+4?=
 =?us-ascii?Q?S2cH3pY8/QWRnnfC7MJ1zb0AGZrARDYremzLiHXkb597NmwiWB0whUOMZkZq?=
 =?us-ascii?Q?4YkbflZybLlEJPQed1FRopfGKdPsNWzH3YBa/nJGb5AaRfYrIbvQLWwDdXBk?=
 =?us-ascii?Q?nrJVY/c1tdZEqD29JvUH5nILzLBUMT/GJpMdf0BaRjX2hd1sF10HlWd8Bhqw?=
 =?us-ascii?Q?qxywwpKnR3eJsQ0M9BqCNzrfu6kpjzXA6cHZkc/d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d071a96-a552-4b2f-fc1d-08dbbf737dda
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:04:55.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ow+24dMleWyeABZwFCOt44wr/yoUcsx4bcfwLgGc2JzDvxtZbQtd+YN4onF37vbQnqH7Mf2BM5Wy4Q7e/5voeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 27.09.23 17:43:19, Robert Richter wrote:

> Changes in v11:
>   - Rebased onto cxl/fixes (c66650d29764)
>   - Added: cxl/port: Fix release of RCD endpoints
>   - Added: cxl/core/regs: Rename @dev to @host in struct cxl_register_map
>   - Added: cxl/port: Fix @host confusion in cxl_dport_setup_regs()
>   - Added: cxl/port: Rename @comp_map to @reg_map in struct cxl_register_map
>   - Removed: cxl/regs: Prepare for multiple users of register mappings
>   - Modified: cxl/hdm: Use stored Component Register mappings to map
>     HDM decoder capability
>     - Dan: rework to drop cxl_port_get_comp_map()
>   - Added: cxl/pci: Introduce config option PCIEAER_CXL
>   - Modified: cxl/pci: Add RCH downstream port AER register discovery
>     - Moved AER discovery to devm_cxl_setup_parent_dport() called when
>       memdev is probed
>     - Fixed devm_cxl_iomap_block() release by fixing devm host
>   - Modified: cxl/pci: Map RCH downstream AER registers for logging
>     protocol errors
>     - Reworded description
>     - Moved register mappings to devm_cxl_setup_parent_dport() called
>      when memdev is probed
>   - Modified: cxl/pci: Disable root port interrupts in RCH mode
>     - Call cxl_disable_rch_root_ints() in devm_cxl_setup_parent_dport()
>       called when memdev is probed
>     - Fixed resource release by fixing devm host
>   - Reworded description of PCIEAER_CXL config option
>   - Added: cxl/core/regs: Rework cxl_map_pmu_regs() to use map->dev for
>     devm

for a v11 this is a major rework. Most of the dport setup is now in
devm_cxl_setup_parent_dport() which is called very late from
cxl_mem_probe(). Also, additional patches with fixes and more
reworks. I saw one failure in the ndctl cxl test suite with qemu, but
decided to send the patches out anyway as a new baseline for review,
testing and debugging. Bear with it as due to its changes the code
need to mature a little.

Thanks,

-Robert
