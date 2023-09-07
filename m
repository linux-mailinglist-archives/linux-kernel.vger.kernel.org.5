Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A85A7979E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbjIGRY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjIGRYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:24:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654031FEE;
        Thu,  7 Sep 2023 10:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn1lX2aBSkZpPduk3aTFZzQ2Q/yRLSPvHhcqOi3X3ajAhQGqwnBrS9fkmJAEo3EdzdrqI2ut0d0NgYHNr6Nnn9GcrPB78oGOiUuqFXsP9ywcIkHh9/obAX1fbRnKPJK2IQwsBA5HGDk2H+DD0fFUTk86m15jNVy3pIgH6CALYNj98a2AJbLDU7jr2KpXJGELe6KURrLkAI7zKEzQCCmygL9ychOFye/Bq441UhWy32zud0cNqCYdirzSniH+B9QlAfgFnK2yxoWiUbystIYsYyKx8Uog75VP1+ah32sQItTWAuShtSJOIHsZD4SRWoO8pdp1XuIjfqaIaF+dY8kWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7fM/z4RMsK8eb1gWkmOiNHv0dr7V+SbpHXE4IDRn08=;
 b=Ar24JwucnzMpJxx24vG0f8DbIgxKBx9GVGHFED55apA7tHr4VHooaAzfkeicgQKkcTmkzy9T1d51RE9D0rjq6zaRYYqSbLHZ5lF5oDSwL/UZYxDbJPWjZiHkj/tULBdKqq6NGh2iT+tTL7eJzVNQDFMQQAlDpfRf9K7XAYvViBdf2kesfhMDjC77+Xcc4FpJAHKTsGQfP6t7mJLXI5/9YPWdlWtFSwTuGcaiN1aiUrIOQFk/rftSbu+wBEqvOZgdqkmBEeLaExXNhW/W3kGzmpgDbBmBuZ+avkBi7pPL+WFnfvyfiOpdPACHyMAr+AxoeZ7E6cmYysjKKLn6xjpb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7fM/z4RMsK8eb1gWkmOiNHv0dr7V+SbpHXE4IDRn08=;
 b=S3eSvrGjw6dTB624igUe6j/Fw4AghbTBoYQdthpX6KCcadp7Ey7J3FbTy4Z8wTqYtJ8LTcUX6CkvXHxdVIZY7jtQsaLbvHB5s0hrSZ8Th8Zl+F/TxC5HqfK19HpHy/ipSronDdRwfH6qZHV7SVChGRq7nHPRt53jMWMxDrRqTmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 17:23:26 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 17:23:26 +0000
Message-ID: <ad75ec32-cd49-4a64-ae72-e52a6a34dc30@amd.com>
Date:   Thu, 7 Sep 2023 12:23:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] remoteproc: zynqmp: get TCM from device-tree
Content-Language: en-US
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
 <20230829181900.2561194-4-tanmay.shah@amd.com> <ZPjXTTGHb4ZG0GqN@p14s>
 <ff56ae0f-48b5-492b-bbb3-713d457e8514@amd.com>
In-Reply-To: <ff56ae0f-48b5-492b-bbb3-713d457e8514@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c17d3b-dacf-483a-2be7-08dbafc72574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaa3R67NVfKiLlRqlME3s2vzIjrGY6WLvj8wwfsB4IBtAr7wo1SXk285BkMc4ppTbJcFcx8Fo+JJLHerb60Ev6Cw0KRovrVWUfU94+ve4B0z7hBJ3YV0tc95O2EWiSjA9B7EPPnUP98u1mT5T+ZH+CquQ0SHPNG2l2xgqUep76A0VkGvR/3KtdtVNQhPE18yLt4vZXbbXveknK8mMhbnzPUjmjBTDI6MbNz4v5fShIAjeHtyLKLLXUWWX2zjfxdLI+xXXA2dwBetGwSNL9hog4fdZwj2OzsizKfGp8A/4rTcy346ysel76bfeC9X53alXwWdZ7toWnM3SISYBJirXMIvhflfuBTnTomkntT4I07PQ77gg0nMYotHfcifNrV6n8qAFZkVu3CCSkL8GpVREOjVS3jiGL9Ogn66ePhldwjSN1pAqmXFXICcgp+TVjQfzE9UGiXHtJ0rDHTiupcRYy5/4odtRs8vtOAst87en45jBarD3vXOd3bJ5vRWoY+pfmbD/TJhj8P2rsLLstjGbHg0v/GbRmJWNURA3i1XM1tVGDfHjF2qEIXt0q/Dh6ooosgcrE10PVOPWyQvM0xzMgshrLNgbGpZLGGlqXQEoROE8EPVSUtNe6aXarE3Fulw5nG61MBajfoal1LQr1orOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199024)(1800799009)(186009)(6506007)(478600001)(6486002)(86362001)(53546011)(26005)(31696002)(5660300002)(6512007)(83380400001)(31686004)(6666004)(2906002)(38100700002)(30864003)(66556008)(36756003)(66899024)(2616005)(6916009)(316002)(54906003)(66476007)(44832011)(66946007)(8676002)(4326008)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkhGdDdKWE9ZQTA4NExCUmlYTHJMOEtMUmZpRWZOWTBkdW9CMlZhS2FFSDVs?=
 =?utf-8?B?K01VeU80UWhEYmxpVmwrWXJyYnRMVnQ2S0NoNWQ3RkFaQmNkQWdwTkhQKzRh?=
 =?utf-8?B?YTJiVElNNHF1VGZld0tneGNNK1cyTTVpbURVUU5RdEJ4c1doOHlPVHN6T1hI?=
 =?utf-8?B?VS9PMFFOVy9CTm5lc0hlT3RoL25keHZBalJieGRLZFlYN3lFYTFTaEJERnhm?=
 =?utf-8?B?UHBCRFc0dzVVOEhqdENqRXJxZzkwSVRYVmd4RlpDTXNPa2tiZ3FBaVdPYTZ1?=
 =?utf-8?B?NG1vVFVkdWJiMDhyYnBKbXozOURIZjU1UnFZSVB3ZUkzakJDZVJoREp3dUor?=
 =?utf-8?B?a3NVOE9mc3Q2SmM0MWRLL0FMQWdyU3JKamJJS05Idjg0LzUyWktjVzBYNkRB?=
 =?utf-8?B?RXcvVVlXNFFvMDdCTDduanZQRHBvR0VOL2NITTlGRGkvWEdELzJ6ZVh2cXRr?=
 =?utf-8?B?cWMzT002U0hXMDJJMXB5aGxDaDJWN1NFditib1d4NXFSUmpKSzhHTXRTZndk?=
 =?utf-8?B?VjNMTzBEU1IvUlNXZjBjS2lqZTdzWVFQRFAxZjdKSTQzNzlBaVVWVTkyZURz?=
 =?utf-8?B?QzVLQk13SE5RbWhGTHFWNWVHR2ptQ09BYk9JYkgwTEpvcGpleWQxcG54ZDRz?=
 =?utf-8?B?am5ma0RBN0pIQTh2K3M4RmtqM3J6WGNBTGE1U3FMZ0daN2xpMkk2aHpwVTVE?=
 =?utf-8?B?ejY2dlh4Ni8rNkNvMGdLaFFjZ3BoUGpLdXozTFhCZVZYSmRLb3VHV1dkNnRj?=
 =?utf-8?B?d0ZTSGFya2JhOFp2WmxNOEVhNFRkN0NzYmpPM1ZnMVd0NWI2eFNkN0dieWVp?=
 =?utf-8?B?cExPK3dydkhuRnVSS2NUNlhHMTR3L1BXclI5MTRJYmdNcTFkSk9UQ3FENUhZ?=
 =?utf-8?B?R2pkd0FqWUNIa1R6NzNXWWl2K3BFRFJHTHRZa3Q4Q2JsaTJ2NE9NQm9JaHAz?=
 =?utf-8?B?eE8xOUk0MVd5QytOS2I5SXlMNjZWUDRXNTdZQmwra1V2cjgyZ1V1QmtCQlZF?=
 =?utf-8?B?cVRkNTJGN3J6VUNDM0JhVEdnbnAxQlJIcEpaWUFlMU5BeUU3NDJOS0pJQ0tM?=
 =?utf-8?B?K283UjVPbHVqZWo3ZWJHajBBY1RyYWRPWmk0ZTVUM0YxSEROLzBaOFo2c1pI?=
 =?utf-8?B?dmVEOENjcnpCVi9QTko3cXQyWmorTDVkMmFBOHRPNUxZbXV3RGR6am9UblJp?=
 =?utf-8?B?bTlFd2NvM0hoa29ZVmwvU2NQN1JQVEE2YkNOVEpacGtsV0ZmQTU4TW1VZ1VZ?=
 =?utf-8?B?dXdDb29qOFJDNm4xaWxUN0NndGNqUDNUYjhmNzk2Qy9sNUFjckF0L081bnlS?=
 =?utf-8?B?QktuNlFJSFFiR3V6NzU2OW4vVDdqTDd5eCthdUZHYms5ZzdLMEZZSWxjL0RC?=
 =?utf-8?B?WHZXZjBWTXlubjNZR2lzaFpDNTkrdFZtSGRKeXFuK0dDQ05YNkFsVE93dTEx?=
 =?utf-8?B?YjZvRmh4bVVBV2IyZVFuUitVR3lsWlI4NXc1dGVrRmdtSTMwUXlsb2JVVDRs?=
 =?utf-8?B?N0pPUnkxc29DMVl4eVIyRXdLQmhoNGU1WEc2OXZ3QjVwUmJFQzdmclZ0ZWF3?=
 =?utf-8?B?VFh4eVkxbDFGQTFkY3hQeGZWS3N4SC80NG1nd0RRdy9Odmo4VnNBL2tHWmlx?=
 =?utf-8?B?NzlwdHRXdnVWeTI3VTIzclNjUnViRUg4WWdyN29SbDlmT0Ywam9CQ2ZQMHdo?=
 =?utf-8?B?R3NkZnlnNm1qenNEUkdSUXA0NTR2VFkvZkFnSXU0Vm9zczFYaStlTXFQYWJY?=
 =?utf-8?B?MXpObkZuM3NRUTR5R203V2ZXS2NGTmZ2aEhGUEJzLzFLeElMVFVSc0xVbE1j?=
 =?utf-8?B?aVdYb1hQb25hQmx3U1d1QmtWS1BoQndMdFZxK3F6d25ReUdpK3F4azI2bzRa?=
 =?utf-8?B?MzNObituZEl2OGNBNnpCbFpudkMzK1lsTE10TUIreC9xQThBMmwvUVZocko2?=
 =?utf-8?B?NmpkTkZRKzFQU2V5Y2JFbTNnNXlKNENXemcrMTQvODFUczh6V256bXJPZGJt?=
 =?utf-8?B?bUlSQ0tVRUp0MG5KRWJWeUtKUlVWNU5OTmdhRmxPUlJVd2tXWngzZ2I4T2tO?=
 =?utf-8?B?OHZzSVN1aVNBcW16cjNRLzNLVzVVYlpSc1FTeUZsa1A0N0dlRzcxd01qT0lu?=
 =?utf-8?Q?TdRC44Qh+k02snDY0+42FEjOU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c17d3b-dacf-483a-2be7-08dbafc72574
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 17:23:26.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6hMTtv2SSEC3DHIy0ivGF6RyPHoRSey9Nd0+fcnuCWd51FYONKRllN6ZmBpyWsZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/23 5:02 PM, Tanmay Shah wrote:
> HI Mathieu,
>
> Thanks for reviews. Please find my comments below.
>
>
> On 9/6/23 2:47 PM, Mathieu Poirier wrote:
> > Hi Tanmay,
> >
> > On Tue, Aug 29, 2023 at 11:19:00AM -0700, Tanmay Shah wrote:
> > > Use new dt bindings to get TCM address and size
> > > information. Also make sure that driver stays
> > > compatible with previous device-tree bindings.
> > > So, if TCM information isn't available in device-tree
> > > for zynqmp platform, hard-coded address of TCM will
> > > be used.
> > > 
> > > New platforms that are compatible with this
> > > driver must add TCM support in device-tree as per new
> > > bindings.
> > > 
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 279 +++++++++++++++++++-----
> > >  1 file changed, 221 insertions(+), 58 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > index feca6de68da2..4eb62eb545c2 100644
> > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > @@ -39,15 +39,19 @@ enum zynqmp_r5_cluster_mode {
> > >   * struct mem_bank_data - Memory Bank description
> > >   *
> > >   * @addr: Start address of memory bank
> > > + * @da: device address for this tcm bank
> > >   * @size: Size of Memory bank
> > >   * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
> > > + * @pm_domain_id2: second core's corresponding TCM's pm_domain_id
> > >   * @bank_name: name of the bank for remoteproc framework
> > >   */
> > >  struct mem_bank_data {
> > > -	phys_addr_t addr;
> > > -	size_t size;
> > > +	u32 addr;
> > > +	u32 da;
> > > +	u32 size;
> >
> > Why are the types of @addr and @size changed?
>
> So, R5 can access 32-bit address range only. Before I had missed this.
>
> In Devce-tree bindings I am keeping address-cells and size-cells as 2.
>
> So, out of 64-bits only 32-bits will be used to get address of TCM. Same for size.
>
> This motivated me to change the type of @addr and @size fields. It doesn't have any side effects.
>
>
> >
> > >  	u32 pm_domain_id;
> > > -	char *bank_name;
> > > +	u32 pm_domain_id2;
> > > +	char bank_name[32];
> >
> > Same
>
> Now we have "reg-names" property in dts so, when that is available, I try to use it.
>
> So, instead of keeping simple pointer, I copy name from "struct resources". So, I changed bank_name
>
> from pointer to array.
>
>
> >
> > >  };
> > >  
> > >  /**
> > > @@ -75,11 +79,17 @@ struct mbox_info {
> > >   * Hardcoded TCM bank values. This will be removed once TCM bindings are
> > >   * accepted for system-dt specifications and upstreamed in linux kernel
> > >   */
> > > -static const struct mem_bank_data zynqmp_tcm_banks[] = {
> > > -	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > > -	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> > > -	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> > > -	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> > > +static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> > > +	{0xffe00000, 0x0, 0x10000, PD_R5_0_ATCM, 0, "atcm0"}, /* TCM 64KB each */
> > > +	{0xffe20000, 0x20000, 0x10000, PD_R5_0_BTCM, 0, "btcm0"},
> >
> > Here the device address for btcm0 is 0x20000 while in the cover letter it is
> > 0x2000.
>
> Thanks for catching this. This is actually typo in cover-letter. It should be 0x20000 in cover-letter.
>
> >
> > > +	{0xffe90000, 0x0, 0x10000, PD_R5_1_ATCM, 0, "atcm1"},
> > > +	{0xffeb0000, 0x20000, 0x10000, PD_R5_1_BTCM, 0, "btcm1"},
> >
> > Same
>
> Same here: It should be 0x20000 in cover-letter.
>
> >
> > > +};
> > > +
> > > +/* TCM 128KB each */
> > > +static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > > +	{0xffe00000, 0x0, 0x20000, PD_R5_0_ATCM, PD_R5_1_ATCM, "atcm0"},
> > > +	{0xffe20000, 0x20000, 0x20000, PD_R5_0_BTCM, PD_R5_1_BTCM, "btcm0"},
> > >  };
> > >  
> > >  /**
> > > @@ -422,6 +432,7 @@ static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
> > >  				      struct rproc_mem_entry *mem)
> > >  {
> > >  	iounmap((void __iomem *)mem->va);
> > > +
> >
> > Spurious change
> Sure,  I will remove it.
> >
> > >  	return 0;
> > >  }
> > >  
> > > @@ -526,30 +537,6 @@ static int tcm_mem_map(struct rproc *rproc,
> > >  	/* clear TCMs */
> > >  	memset_io(va, 0, mem->len);
> > >  
> > > -	/*
> > > -	 * The R5s expect their TCM banks to be at address 0x0 and 0x2000,
> > > -	 * while on the Linux side they are at 0xffexxxxx.
> > > -	 *
> > > -	 * Zero out the high 12 bits of the address. This will give
> > > -	 * expected values for TCM Banks 0A and 0B (0x0 and 0x20000).
> > > -	 */
> > > -	mem->da &= 0x000fffff;
> > > -
> > > -	/*
> > > -	 * TCM Banks 1A and 1B still have to be translated.
> > > -	 *
> > > -	 * Below handle these two banks' absolute addresses (0xffe90000 and
> > > -	 * 0xffeb0000) and convert to the expected relative addresses
> > > -	 * (0x0 and 0x20000).
> > > -	 */
> > > -	if (mem->da == 0x90000 || mem->da == 0xB0000)
> > > -		mem->da -= 0x90000;
> > > -
> > > -	/* if translated TCM bank address is not valid report error */
> > > -	if (mem->da != 0x0 && mem->da != 0x20000) {
> > > -		dev_err(&rproc->dev, "invalid TCM address: %x\n", mem->da);
> > > -		return -EINVAL;
> > > -	}
> > >  	return 0;
> > >  }
> > >  
> > > @@ -571,6 +558,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > >  	u32 pm_domain_id;
> > >  	size_t bank_size;
> > >  	char *bank_name;
> > > +	u32 da;
> > >  
> > >  	r5_core = rproc->priv;
> > >  	dev = r5_core->dev;
> > > @@ -586,6 +574,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > >  		bank_name = r5_core->tcm_banks[i]->bank_name;
> > >  		bank_size = r5_core->tcm_banks[i]->size;
> > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > +		da = r5_core->tcm_banks[i]->da;
> > >  
> > >  		ret = zynqmp_pm_request_node(pm_domain_id,
> > >  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > @@ -599,7 +588,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > >  			bank_name, bank_addr, bank_size);
> > >  
> > >  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > > -						 bank_size, bank_addr,
> > > +						 bank_size, da,
> > >  						 tcm_mem_map, tcm_mem_unmap,
> > >  						 bank_name);
> > >  		if (!rproc_mem) {
> > > @@ -632,14 +621,14 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > >   */
> > >  static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  {
> > > +	u32 pm_domain_id, da, pm_domain_id2;
> > >  	struct rproc_mem_entry *rproc_mem;
> > >  	struct zynqmp_r5_core *r5_core;
> > >  	int i, num_banks, ret;
> > > -	phys_addr_t bank_addr;
> > > -	size_t bank_size = 0;
> > > +	u32 bank_size = 0;
> > >  	struct device *dev;
> > > -	u32 pm_domain_id;
> > >  	char *bank_name;
> > > +	u32 bank_addr;
> > >  
> > >  	r5_core = rproc->priv;
> > >  	dev = r5_core->dev;
> > > @@ -653,12 +642,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  	 * So, Enable each TCM block individually, but add their size
> > >  	 * to create contiguous memory region.
> > >  	 */
> > > -	bank_addr = r5_core->tcm_banks[0]->addr;
> > > -	bank_name = r5_core->tcm_banks[0]->bank_name;
> > > -
> > >  	for (i = 0; i < num_banks; i++) {
> > > -		bank_size += r5_core->tcm_banks[i]->size;
> > > +		bank_addr = r5_core->tcm_banks[i]->addr;
> > > +		bank_name = r5_core->tcm_banks[i]->bank_name;
> > > +		bank_size = r5_core->tcm_banks[i]->size;
> > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > +		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > > +		da = r5_core->tcm_banks[i]->da;
> > > +
> > > +		dev_dbg(dev, "TCM %s addr=0x%x, size=0x%x",
> > > +			bank_name, bank_addr, bank_size);
> > >  
> > >  		/* Turn on each TCM bank individually */
> > >  		ret = zynqmp_pm_request_node(pm_domain_id,
> > > @@ -668,23 +661,28 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > >  			goto release_tcm_lockstep;
> > >  		}
> > > -	}
> > >  
> > > -	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
> > > -		bank_name, bank_addr, bank_size);
> > > -
> > > -	/* Register TCM address range, TCM map and unmap functions */
> > > -	rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > > -					 bank_size, bank_addr,
> > > -					 tcm_mem_map, tcm_mem_unmap,
> > > -					 bank_name);
> > > -	if (!rproc_mem) {
> > > -		ret = -ENOMEM;
> > > -		goto release_tcm_lockstep;
> > > -	}
> > > +		/* Turn on each TCM bank individually */
> > > +		ret = zynqmp_pm_request_node(pm_domain_id2,
> > > +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id2);
> > > +			goto release_tcm_lockstep;
> > > +		}
> > >  
> > > -	/* If registration is success, add carveouts */
> > > -	rproc_add_carveout(rproc, rproc_mem);
> > > +		/* Register TCM address range, TCM map and unmap functions */
> > > +		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > > +						 bank_size, da,
> > > +						 tcm_mem_map, tcm_mem_unmap,
> > > +						 bank_name);
> > > +		if (!rproc_mem) {
> > > +			ret = -ENOMEM;
> > > +			goto release_tcm_lockstep;
> > > +		}
> > > +
> > > +		rproc_add_carveout(rproc, rproc_mem);
> > > +	}
> > >  
> > >  	return 0;
> > >  
> > > @@ -693,7 +691,12 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > >  	for (i--; i >= 0; i--) {
> > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > >  		zynqmp_pm_release_node(pm_domain_id);
> > > +		if (pm_domain_id2) {
> > > +			pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > > +			zynqmp_pm_release_node(pm_domain_id2);
> > > +		}
> > >  	}
> > > +
> > >  	return ret;
> > >  }
> > >  
> > > @@ -800,17 +803,23 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> > >   */
> > >  static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > >  {
> > > +	u32 pm_domain_id, pm_domain_id2;
> > >  	struct zynqmp_r5_core *r5_core;
> > > -	u32 pm_domain_id;
> > >  	int i;
> > >  
> > >  	r5_core = rproc->priv;
> > >  
> > >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > +		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > >  		if (zynqmp_pm_release_node(pm_domain_id))
> > >  			dev_warn(r5_core->dev,
> > >  				 "can't turn off TCM bank 0x%x", pm_domain_id);
> > > +		if (pm_domain_id2 && zynqmp_pm_release_node(pm_domain_id2))
> > > +			dev_warn(r5_core->dev,
> > > +				 "can't turn off TCM bank 0x%x", pm_domain_id2);
> > > +		dev_dbg(r5_core->dev, "pm_domain_id=%d, pm_domain_id2=%d\n",
> > > +			pm_domain_id, pm_domain_id2);
> > >  	}
> > >  
> > >  	return 0;
> > > @@ -883,6 +892,137 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > >  	return ERR_PTR(ret);
> > >  }
> > >  
> > > +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	int i, j, tcm_bank_count, ret = -EINVAL;
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	struct of_phandle_args out_arg;
> > > +	struct platform_device *cpdev;
> > > +	struct resource *res = NULL;
> > > +	u64 abs_addr = 0, size = 0;
> > > +	struct mem_bank_data *tcm;
> > > +	struct device_node *np, *np1 = NULL;
> > > +	struct device *dev;
> > > +
> > > +	for (i = 0; i < cluster->core_count; i++) {
> > > +		r5_core = cluster->r5_cores[i];
> > > +		dev = r5_core->dev;
> > > +		np = dev_of_node(dev);
> > > +
> > > +		/* we have address cell 2 and size cell as 2 */
> > > +		ret = of_property_count_elems_of_size(np, "reg",
> > > +						      4 * sizeof(u32));
> > > +		if (ret <= 0) {
> > > +			ret = -EINVAL;
> > > +			goto fail_tcm;
> > > +		}
> > > +
> > > +		tcm_bank_count = ret;
> > > +
> > > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > > +						  sizeof(struct mem_bank_data *),
> > > +						  GFP_KERNEL);
> > > +		if (!r5_core->tcm_banks) {
> > > +			ret = -ENOMEM;
> > > +			goto fail_tcm;
> > > +		}
> > > +
> > > +		r5_core->tcm_bank_count = tcm_bank_count;
> > > +		for (j = 0; j < tcm_bank_count; j++) {
> > > +			tcm = kzalloc(sizeof(struct mem_bank_data *), GFP_KERNEL);
> > > +			if (!tcm) {
> > > +				ret = -ENOMEM;
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			r5_core->tcm_banks[j] = tcm;
> > > +			/* get tcm address without translation */
> > > +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> > > +			if (ret) {
> > > +				dev_err(dev, "failed to get reg property\n");
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			/*
> > > +			 * remote processor can address only 32 bits
> > > +			 * so convert 64-bits into 32-bits. This will discard
> > > +			 * any unwanted upper 32-bits.
> > > +			 */
> > > +			tcm->da = (u32)abs_addr;
> > > +			tcm->size = (u32)size;
> > > +
> > > +			cpdev = to_platform_device(dev);
> > > +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> > > +			if (!res) {
> > > +				dev_err(dev, "failed to get tcm resource\n");
> > > +				ret = -EINVAL;
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			tcm->addr = (u32)res->start;
> > > +			res = devm_request_mem_region(dev, tcm->addr, tcm->size, res->name);
> > > +			if (!res) {
> > > +				dev_err(dev, "failed to request tcm resource\n");
> > > +				ret = -EINVAL;
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			memcpy(tcm->bank_name, res->name, ARRAY_SIZE(tcm->bank_name));
> > > +			np = of_node_get(dev_of_node(dev));
> > > +			/*
> > > +			 * In dt power-domains are described in this order:
> > > +			 * <RPU core>, <atcm>,  <btcm>
> > > +			 * parse power domains for tcm accordingly
> > > +			 */
> > > +			of_parse_phandle_with_args(np, "power-domains",
> > > +						   "#power-domain-cells",
> > > +						   j + 1, &out_arg);
> > > +			tcm->pm_domain_id = out_arg.args[0];
> > > +			of_node_put(out_arg.np);
> > > +
> > > +			dev_dbg(dev, "TCM: %s, dma=0x%x, da=0x%x, size=0x%x\n",
> > > +				tcm->bank_name, tcm->addr, tcm->da, tcm->size);
> > > +			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id);
> > > +
> > > +			if (cluster->mode == SPLIT_MODE)
> > > +				continue;
> > > +
> > > +			/* Turn on core-1's TCM as well */
> > > +			np1 = of_get_next_child(dev_of_node(cluster->dev),
> > > +						r5_core->np);
> > > +			if (!np1) {
> > > +				of_node_put(np1);
> > > +				np1 = NULL;
> > > +				goto fail_tcm;
> > > +			}
> > > +
> > > +			of_parse_phandle_with_args(np1, "power-domains",
> > > +						   "#power-domain-cells",
> > > +						   j + 1, &out_arg);
> > > +			tcm->pm_domain_id2 = out_arg.args[0];
> > > +			of_node_put(out_arg.np);
> > > +			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id2);
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +fail_tcm:
> > > +	while (i >= 0) {
> > > +		r5_core = cluster->r5_cores[i];
> > > +		for (j = 0; j < r5_core->tcm_bank_count; j++) {
> > > +			if (!r5_core->tcm_banks)
> > > +				continue;
> > > +			tcm = r5_core->tcm_banks[j];
> > > +			kfree(tcm);
> > > +		}
> > > +		kfree(r5_core->tcm_banks);
> > > +		i--;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >  /**
> > >   * zynqmp_r5_get_tcm_node()
> > >   * Ideally this function should parse tcm node and store information
> > > @@ -895,12 +1035,20 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > >   */
> > >  static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> > >  {
> > > +	const struct mem_bank_data *zynqmp_tcm_banks;
> > >  	struct device *dev = cluster->dev;
> > >  	struct zynqmp_r5_core *r5_core;
> > >  	int tcm_bank_count, tcm_node;
> > >  	int i, j;
> > >  
> > > -	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
> > > +	if (cluster->mode == SPLIT_MODE) {
> > > +		zynqmp_tcm_banks = zynqmp_tcm_banks_split;
> > > +		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_split);
> > > +	} else {
> > > +		zynqmp_tcm_banks = zynqmp_tcm_banks_lockstep;
> > > +		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_lockstep);
> > > +	}
> >
> > Why are the changes to get TCM bank information from the DT and enhancement to
> > support lockstep mode in the same patch?
>
> Actually TCM in lockstep mode was supported before as well. It's just I was using same table in lockstep mode before.
>
> However, now I am having two tables for split mode and lockstep mode.
>
> I had to do this as I have introduced "da" field in "struct mem_bank_data" object.  This makes it easy to process
>
> "device address" derived from device-tree.
>
> And as I have introduced "u32 da", I had to modify table as well and remove hardcoding of "da" calculation in "tcm_mem_map" function.
>
> As all of this is connected, I have them in same patch. No new functionality is added, but just code refactoring.
>
> > > +
> > >  
> > >  	/* count per core tcm banks */
> > >  	tcm_bank_count = tcm_bank_count / cluster->core_count;
> > > @@ -951,10 +1099,25 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> > >  			       enum rpu_tcm_comb tcm_mode)
> > >  {
> > >  	struct device *dev = cluster->dev;
> > > +	struct device_node *np;
> > >  	struct zynqmp_r5_core *r5_core;
> > >  	int ret, i;
> > >  
> > > -	ret = zynqmp_r5_get_tcm_node(cluster);
> > > +	/*
> > > +	 * try to get tcm nodes from dt but if fail, use hardcode addresses only
> > > +	 * for zynqmp platform. New platforms must use dt bindings for TCM.
> > > +	 */
> > > +	ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> > > +	if (ret) {
> > > +		np = of_get_compatible_child(dev_of_node(dev), "xlnx,zynqmp-r5f");
> > > +		if (np) {
> >
> > Why was this check added?
>
> We want to maintain backward compatibility with previous bindings only for zynqmp platform.
>
> So, hardcode table is used only for "zynqmp" platform if getting "reg" information from device-tree fails.
>
> If node is not compatible with "xlnx,zynqmp-r5f" then it is new platform and we must not use hardcode
>
> table instead we should fail.
>
>
> > So far there are too many unanswered questions with this patchset and as such I
> > will stop here.
>
> No problem. Please let me know if you have any further questions.

Hi Mathieu,

Did you want me to document all the comments I mentioned in driver and send new patchset or can we continue reviews ?

I am fine either way. Let me know.

Thanks,

Tanmay

>
>
> > Mathieu
> >
> > > +			ret = zynqmp_r5_get_tcm_node(cluster);
> > > +		} else {
> > > +			dev_err(dev, "tcm not found\n");
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
> > >  	if (ret < 0) {
> > >  		dev_err(dev, "can't get tcm node, err %d\n", ret);
> > >  		return ret;
> > > -- 
> > > 2.25.1
> > > 
