Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C77C4108
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJJUUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJJUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:20:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA938E;
        Tue, 10 Oct 2023 13:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwri4SsFbAp+lDv+Uv+lvSiXyO9mgzzDQQCExHIweCb8jXcAC7Ri4IaTX8ebuaa8fd7ZEENMx/iwV9rEhWlTtkvqX/DXnAos5wST+pUM6gfe7nN8aQ2FGZfySmQFfLFEMnWeoPvEHXvRfsEO606/FlFwTevgxbP0JxIsrBoY6hp5Qpmmk9flUf07DBWYshaI4PPcG4cZpLdKtgrIvzgq2dl86LJrZGykq21gd9o+U/mXmZi3bFEDzRmJynM87Jkq7IMPw7TxZM5s9rxjejPmOBZCfB5ioJ0sBk/F1KtrSj68Ajrcs1bvcyt3cxjX67JEJnGU5DXfhhwegySc/8a61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPiMFO9cYzUQ4KcmaU19H14uwZgEVaQ7kPON/qaRiVg=;
 b=hZDoHsroEzzZo5u4FUX/+ppQhTY+7w21DyjXDA7ZKtJEAk7UU22l5KsQI8orAYFHKAzHRqgP/lqANF71Gd7/OjBAPonENydIe0R4zmRMe/P31Kqjf3QmH108ujh5sHVXr5o2/mLuSSrnToPeOIRXcohGODhh9Js5Z9KDc7j6z5vt9DHsUfyBolNOsUIL6lUH8AlYgv45jwwNs8uF35g0jTOTtd4pMlGsVloflBZJmR2l2sLbQc/Wj88L9ybEfMIXdB4oknOKx48i8rdPdANhcfV5WfVUKkzPqJfRufjjLeAPyQRxChDPrjLOkd+bkPvU2PrVwmmfrKf6s1KxOgs3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPiMFO9cYzUQ4KcmaU19H14uwZgEVaQ7kPON/qaRiVg=;
 b=gBESsIycKtv0XZ01qi+DF76nXTtjKvnmyqQyALKlFKNoYTjN278o2KKSfLjqdDwBlYrcFZU6iBZ3d9Nvs9KN63a1TwO+e3XbgPHhqampTCvJ5alRnQQ+EOn5va8ckkircJ7PmT1BRZcCxu0c5TbwvsQgGBSAYkbw3G2bUySBKjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA0PR01MB6108.prod.exchangelabs.com (2603:10b6:806:e3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 20:20:27 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::f7a2:1a96:ba3f:d70f%4]) with mapi id 15.20.6863.040; Tue, 10 Oct 2023
 20:20:27 +0000
Date:   Tue, 10 Oct 2023 13:20:11 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm-perf tree
In-Reply-To: <20231010181434.GA10072@willie-the-truck>
Message-ID: <751b969c-b37f-f8e0-5983-98352d7c88c3@os.amperecomputing.com>
References: <20231010095601.1443903c@canb.auug.org.au> <98ffbcf6-a646-ac2-5785-f78644f7cbe@os.amperecomputing.com> <20231010175013.GA10036@willie-the-truck> <20231010181434.GA10072@willie-the-truck>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CY5PR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:930:13::11) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA0PR01MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c58e21-2f4a-4cc0-075c-08dbc9ce572b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3Ag2v394EU83rrZ0AqtMDyY+DJeMu97MVLFqsrtfwXGvbu9socAJTydFJmCE3JiM0AQEWas63Bc+AqOOTcKX+ahOH+EIBM0HZKn2QyzYBAbgqtCv7PFELA1aOC4nuIv9RgQlJwwAoRZvMmZ49b48v3VxtZONqOiippFXKqwVxECVsCI1oupZJmBwUcSEI1vlwojPN3+Uc8odoKKA58uIYJcCifIpEymKNvblJpFVBRcFsDB/ij4vP2kqkRp0qRGYzJPCMNEfDKbkM9GMzTQr4xtWj5+kCdbkcQa6fXt7XSceuLlrBi/9LNRA47CkIo+HAZXnDGKw7xilu8tcKAftZzic0LTth5pfK7bROhsOhiVbTEiG18MIMMXcoub9BRIVKVlI1clyxQ/y7l2BXF59Owj3XmwaEKLo5J5HnnF/ysihp2KPQb7uJd1HTpoEoFpuVzduN1bve7gDowsoQE6D6dxffFMD7BMVvKrQyuMf5A3cu0fMY1l7Tf3/cVnja7fIYNlG8VFU9tukG1jxMJ3hsUglS2kXDMa/YPGveU/n+wcUUMgw8sIb5FPTs+CrBoVFY73IqX3Nkjwj1HGH+qq7xrKejlSbHMLC1TmC6eD04lFo3aegRRfQzQs8eD+UWoC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39850400004)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(86362001)(31696002)(38350700002)(38100700002)(52116002)(66556008)(66476007)(6512007)(6916009)(66946007)(54906003)(316002)(6506007)(26005)(2616005)(478600001)(6486002)(31686004)(6666004)(41300700001)(83380400001)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3U4/anN6t15OWCPw99X/KkyLNfiA35Ohd3P6Ywx1Ww/X7NBp/k8l7qe0qoFy?=
 =?us-ascii?Q?nVELNsAkFpS9IehslzcqIE5rWmwIM4a1X/YquovUEE5au+FJAZsRPtDKasu+?=
 =?us-ascii?Q?IPS54BVlxduH+Qmg/eNlvdN8VBZBGc14XrUNgsak/sO4YTp3rlgtkJ7Bxwkm?=
 =?us-ascii?Q?It3WFzfJA4t7Zmiol9uZPm+1R0cWk9JYtubloFQUoGedbGGyHDgaxwATgZnz?=
 =?us-ascii?Q?uHRrP5fQtNgbTFBG1J2IKU3An8tawWqZX1U8J0VTFa4PaDKW/0JVzPlt2vYD?=
 =?us-ascii?Q?qelkBfI37rmPMpdSoO3SkLzziyDnbhA4GaZjwhfYwDqjDOedeLehYJ2EJQcy?=
 =?us-ascii?Q?fiGUv9o/e5bzWjwOUrN4oo0zLoWu5+hOH524UfTB+BwSZilT+YN6e2y0CenG?=
 =?us-ascii?Q?tgmdYUksuQDW3hvDzhVtNcbVBiiNYPDu+yZFHAEDJpqJskRILFM36vOWIyTS?=
 =?us-ascii?Q?9U17BhDI++yty23F9+DbmpvSSWvePXDUyLBWuI/5/3atWpbUGeOLNrN9X+zD?=
 =?us-ascii?Q?7yzzjBD6jQzzRrfKzVKU+19h3gQbq3fyr0yZVpmUT57BEy2LH7gzcijqylbF?=
 =?us-ascii?Q?iclHXHA0m9mX63VUGE+TUbvD2Mxotx9QZ7ejiasbI2bivNwqZq38yoqL9oIK?=
 =?us-ascii?Q?TAs74MPustbQedGEAn1QUbRTlylmNaFk/uzsRXteXdkXwz2negh4mCk7vX+F?=
 =?us-ascii?Q?7+h6vdGScetcdGn4xEd/geMl/sUWuBwVjtOvYdMJSEDBrFgRFDn1Un4eyjnB?=
 =?us-ascii?Q?wp/LX51kkamPXUfUM7DQB+TFFzRzp29UiY6vCAVGXMw/QDUXc16Th+nHHyb9?=
 =?us-ascii?Q?6YkJxlitq3QmduphuX0ds1tUsB/ruvMcMRpFc40V1YEbiZ0vcC5UZqZ16vgD?=
 =?us-ascii?Q?sa6g/cuk8gdG9yTavNDV0qfT/+GElaCU2lyML070UtgDA3zixkqE2C/IhoaQ?=
 =?us-ascii?Q?n2I7WS4Xi1SNpJ+zNbCi0TDdK80FaYbdultVC4Zynm2/a1i7ZyPkDIQLG0/8?=
 =?us-ascii?Q?aLY1vlGDxtz0jDYOwglxP8ujP763RwNQXdxF8BEameldThpF06F1wXDISQbe?=
 =?us-ascii?Q?jZIf9Lv9CeqXCnJbaS2rhfHQkvc8TdmwkoKyNpFA3vQ0u4OZo28Ye8IA21pU?=
 =?us-ascii?Q?VK57reagNXq8+xGEsTB5YMiHKyElWSIM/tNo2PX5YML4mxcY4dgK4T8eZ3r0?=
 =?us-ascii?Q?eIYT86pjRt7+/deVQ9/ZzlG2z1go1LFxL6fznl+mMUmtaDYxym4waD4rYUXq?=
 =?us-ascii?Q?N+s4CKcDMOJiwabhNJHBxbobWs00c/JqX2FuPah85dqLMCMsUn5oB8VMB3Q5?=
 =?us-ascii?Q?S3MwlLDR2IPNzfbyiGK1hhc2iD9Xd8NY0/CV4ExOAphoSzoPNV2IUk6wf5EE?=
 =?us-ascii?Q?/bGMesppATb3JRF1y9dqEi84gUtRy+kEjSDOpWOzUOPvvF51kf034FXFAZGp?=
 =?us-ascii?Q?pmVFfiSuPIKT4O6kOaxzxKP7zm9mpPucqqZD2igw7aT989IpdiwFy/YoxX3i?=
 =?us-ascii?Q?6up7TI5HujEYiQng1gCr9RL/XUGI6tFJ4nKdFSvc5vYazbYBSlIHYXN9FwFW?=
 =?us-ascii?Q?eyVSLzr11ExzjYz5NUlFzsNObpEb3BoKZ80ublBaatoxgXefFzIBuLfdHaRj?=
 =?us-ascii?Q?1dH03wyyl7bOcFl38b+3yvo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c58e21-2f4a-4cc0-075c-08dbc9ce572b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:20:26.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RamSunKU3syEYAQzElfMzQOxErilGmUFrjfUTd9YIu1uRnUNll37JMdTeITZlx2PbgOdmaXGe/XSt8wrJW2OoZsg3yBAYvL4gzeKKZVRHG+2cR0WUOWIF/0cJ/CL6N4x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Oct 2023, Will Deacon wrote:
> On Tue, Oct 10, 2023 at 06:50:13PM +0100, Will Deacon wrote:
>> On Mon, Oct 09, 2023 at 10:45:18PM -0700, Ilkka Koskinen wrote:
>>> On Mon, 9 Oct 2023, Stephen Rothwell wrote:
>>>> After merging the arm-perf tree, today's linux-next build (x86_64
>>>> allmodconfig) failed like this:
>>>>
>>>> drivers/perf/arm_cspmu/ampere_cspmu.c: In function 'ampere_cspmu_set_ev_filter':
>>>> drivers/perf/arm_cspmu/ampere_cspmu.c:164:9: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
>>>>  164 |         writel(threshold, cspmu->base0 + PMAUXR0);
>>>>      |         ^~~~~~
>>>> cc1: all warnings being treated as errors
>>>>
>>>> Caused by commit
>>>>
>>>>  290a9c0e55f8 ("perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU")
>>>>
>>>> I have used the arm-perf tree from next-20231009 for today.
>>>
>>> Thanks for catching the bug! It doesn't seem to happen on arm64 build but I
>>> can reproduce it on x86_64 build indeed.
>>>
>>>
>>> Will, it seems that "#include <linux/io.h>" is missing from ampere_cspmu.c.
>>> After that also x86_64 build goes through. How would you like to get the bug
>>> fixed? Shall I submit a new version of the patch, and you would replace the
>>> old patch with the new one or is it better to
>>> create a completely new patch that only adds the missing include line?
>>
>> If it's just a missing include, I can chuck a patch on top to fix it myself.
>> I'll double-check it resolves the problem and then update the branch.
>
> In the end I just fixed up your commit, as it was still on the HEAD of the
> branch. Update now pushed out!
>
> Cheers,
>
> Will

Sounds perfect! Thank you Will, much appreciated!

Cheers, Ilkka
