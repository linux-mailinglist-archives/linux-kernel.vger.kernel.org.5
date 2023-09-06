Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288FC7945E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbjIFWDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242369AbjIFWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:03:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DAA1BCA;
        Wed,  6 Sep 2023 15:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGibZ2flVFguUf5YxDlcoef2rAk9JMfGJbxl2u2jcnj9nOVJG9aHqayMg/rBJ3R0AnsZ2EhLYwyENsU+UIpW5gheRoAvBT62GNALJThpuidq9f6ki8eNleiHjWdF58w926SXwIWjYwJFGFk6blp8nXLmgAa9CfoE21p62PPFJP49dOfQ1y8yQcADXu7QFcTYmYBiWaIJajYxI6Frdiq0cRhoSG+plY+PojCqNfe8PhmrgPJHhTx5hU/fk+AhoPBAPQNRILp3WzNjhgpleXHSzX4YnLTyTAKvZhij84dnKkzdT316rhWtHHsTBOnxGECTyhh/AGR5DlvgClqbjreyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuNBQXjr4eDX5smrTdqq42PKXBjn+a+oMaCUukUjRlc=;
 b=LLAlMQpoGu56oak01rLK1lBThDpfnNmQSB4j4X14uBZ0fCnoORMQIwVyiu6X1/a/yjgQzWF+M+lEp4j5aETln8/nwB7VvqsczRwhyllDxgMZACcjN0iK32QCyuSeC8/jPsRtqjDA0+hpKnfKUHEHReFEtVx2etndNhYQFiXAvpNflxx+VtX831vy7y5xyFHDockjB99jY/HYqZ0t+DWpW0DfMjcjZ/k9kgA6jXAEh26RvnWseJK+YJ4vqHLy0f0WDRQnXY8017U4IJMuYgoga55UVbgc28PlHd2LcqOHIKsvgSWkqtEmv4oyHR7+cnW95JIFww+VIs0TfzcFoVwp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuNBQXjr4eDX5smrTdqq42PKXBjn+a+oMaCUukUjRlc=;
 b=O/otsH54/maT8KWON/akExYA5gm/JGOeFVJJz2J1Xm4zkzHURHXvw92yTiEjIAIYTboa0zOtuzM7ScXwgm7GPAbR/ZbJFTWrnoYBZpY4EvLtjG7aSvUaiCaaxnn7yR/XM4hCqb/JpBWKXoxO61KjFw1O9cPKyX/CXI0BSOYlSS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3688.namprd12.prod.outlook.com (2603:10b6:610:28::33)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 22:02:44 +0000
Received: from CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::6268:19d9:8c1b:f448]) by CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::6268:19d9:8c1b:f448%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 22:02:44 +0000
Message-ID: <ff56ae0f-48b5-492b-bbb3-713d457e8514@amd.com>
Date:   Wed, 6 Sep 2023 17:02:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] remoteproc: zynqmp: get TCM from device-tree
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
 <20230829181900.2561194-4-tanmay.shah@amd.com> <ZPjXTTGHb4ZG0GqN@p14s>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZPjXTTGHb4ZG0GqN@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To CH2PR12MB3688.namprd12.prod.outlook.com
 (2603:10b6:610:28::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3688:EE_|CH3PR12MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: 228f1a79-bffc-4132-043b-08dbaf24ff6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpJ2s+S8y0YGRsSYr7GE27ckDl6uReUhfGpmE04nrfbCldavs0IlpnbQI+ov9dKGTlhIW9hTx1Yhu2PBEs5kzL/GgK5ykyCYsIlbLBkaR/jnRvdcAwOSaKh/do66G/4JylffOJcPSzq4lAVMb+uKTCtKhEhmuBsahKsLwIAI72PBQ4FNJ23eIK0LqSImj8POQLuEV4cP8F0oURfwuAnRhJ6+MqT1XR2apvWq+Qpl/J3WGmlHwWhfNC5IshedbDZGAFF+AwgCECyiMQGmzEsUBZDKa43Qi7CFk5kXHUknMRs8ICYLLzacO67RsORkVZmlzlB/YupKJ0YIM5ALBW5gkp+ZL05emMGKPTPETEPk6io9eWMONZ2v4mnXzcX8cugtSQQDFohumEB1FT9bDcMUy5JltdJvJF1VP8pKyO7OP3pgsxxhg/KiNcIZInSD7mWU8KwYNzPyNvR3LpRYZn0xdEkUSgH2LUeziy0dfulyAA/FO04X4EYDQRgxDnCTjdBNCdunUa5rT2KlATJ/GInAmv65G90oM4oHi5tOxUThTxIhLhHjX2BLsyhLHbZf9mS/pLKn8A6Zzu91ST9aY3gDYaytvdsBn8Mbxwg70+dldJlFSdEWv44LkF1OBh/wTq4kG+MxJiMS1zxtjgg96AYo4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3688.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199024)(186009)(1800799009)(53546011)(6486002)(6506007)(6666004)(6512007)(478600001)(83380400001)(2616005)(26005)(30864003)(2906002)(316002)(6916009)(66946007)(44832011)(54906003)(66556008)(66476007)(41300700001)(5660300002)(8936002)(4326008)(8676002)(38100700002)(31696002)(36756003)(86362001)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjUvaTZKdzFGSWd4aDZ4OVlzV045bnVKWFltM0dMb2ZZalhqYlhoY3pSU09Z?=
 =?utf-8?B?K0dCRzlsOU5OS0cvZHNYVWZDR1pKYXdIcTZpaUFzcHlGOGlxK0NsbEgxeXlr?=
 =?utf-8?B?N1o0TGRBTGdWMnd0ZjgwK25iYkF0cGQ0bEdMcEloQW9ML2lSWmZDajhTa3lZ?=
 =?utf-8?B?NDljbUdjeEJxUTkwSWNjK0diYWhDYmxocVZGTWxPdlozSk85bFJzMHFUNDVJ?=
 =?utf-8?B?RUVaZDdJQjBJUDlyVkI3eXpvQjd0ZlBLSTVmV1A5S0wwM2lPS1Z5R3dKQ1V0?=
 =?utf-8?B?S2hRU0MxUFZmSUd0ZU1NTG5IaHMzbytVaWNoc0JsVzg4Q01VZWVKaTZ1MVR6?=
 =?utf-8?B?SEFKY29NbmptenF1NFovbklEZGNqNXhTa3oyV0tYQzZpRFJaYlFZcEV2VTdH?=
 =?utf-8?B?SmxlQ0wzRzNXMkRWZUZxTnVTVitLQWUvdXY4MWM5R3ZTRFFLL1NzY01Pd2FE?=
 =?utf-8?B?Y3ZicjFOSWlDZGk2OWsxbFowSWd4Q1NhZkZqU25DVFAraUhDS0V6aXhmdWpM?=
 =?utf-8?B?cG55MkhlZmZVOW9pTGg3VVFKY2dndXNXOFp6U3dDQnJvdkJvQlJMV21RZTAy?=
 =?utf-8?B?RHhsVzhVOEtFSnlNMHRLVVR5WFVmSFB5MzRPeG1JL05rTmMwU1lHL2k3a1c3?=
 =?utf-8?B?ZjkzdEFMY3BLWUlPczJYbFZFWVo4WFp2dWVjUW5DYVlwdlBtMzBTbHVpdVNv?=
 =?utf-8?B?bmNKVFZBVFNnckJTODdUL1ZwTEVMK1Q1VUdpUjQ1d2tGQTdPRTJZQjc1bXNF?=
 =?utf-8?B?MWJ4ZHQxQzZZU3ZHZzl5cjROdXZMQlFZT2NnbjIyWDROUU1XcE9xUTdjZWdD?=
 =?utf-8?B?WGlJUGNHMWNoR01IWFcrQmlhc0hBR2pLV0duTjJyRTlRY2NiWEk1dFpEeEUw?=
 =?utf-8?B?WmVUTEFZdUpUS1lwK3NBUkJxZTMyVWt2U3ZVZm9mQWErbkNXa2VNT28yWnli?=
 =?utf-8?B?QWYvMlBNRlUzSmtHbDRKNjNKWk9pVjJlYkRNblNPSCtld05ud2l0c0hxZXIr?=
 =?utf-8?B?dlFVczVlR3cxN0Y1ZEV3MXhIOXhkL3VlWkprZ093L2NldmFrQXdLSDB2cjd0?=
 =?utf-8?B?VWtKd0YxT0E4Szg5cDg3QXRDMFF2Q2YwYTdIMjhKUEthT2ZmL1JEc0Q3YSto?=
 =?utf-8?B?R3ZIUktVVlozQzJQMW00R3lncEZhQVh0MGpjd3c1SmxQelBUcVd3Sk9vMVJN?=
 =?utf-8?B?VzV5c3BJWjJnVmc5c1VUZ3BPTWZ2M0dHaW9XMWxXWVYzajRLSjF1d0hHa1JL?=
 =?utf-8?B?M0laZTZVcEFWakJ3YW0xQzB3UzlaMDVVUmFwT1ZtTUp6UGlmYW9sVGEzWTdW?=
 =?utf-8?B?bUd3YkFSQklpVjl6Rnd4WVVCTmpXby80SHdhZUJXRG82STRWbDBHakgrMDk2?=
 =?utf-8?B?ZTRFSFNkTHBKWjVwOVFRZ2RpUVQ1R0ZFZDA2enZycFB0enRUcFkzWFVKQWgx?=
 =?utf-8?B?WmVCYWxtbXovNmNCUndGY0JBVEgycnFwK0wwWm43VzlYU3BiTXYxbnVVbkU1?=
 =?utf-8?B?ckhsMWI2L21qSEdTLyswNWZLR0pkUTlOMnJOdU5pUnJveW44b0IzNlhpbkVY?=
 =?utf-8?B?alorbjdOU3NDdC9tTk04YTRyaUQ0SzBGN1hTcE9KZnBYd25MRk9JL1JVUm5B?=
 =?utf-8?B?T0lETGN3ZnUwdm11NWVtY2lUcmpjd05QNnRzM1JJbTVaQVVKNUk4b2V6ZjJj?=
 =?utf-8?B?MEttOVhvdC9oaVB5QjZ2ZEhHOWpiaGdYQ29jb0IwMk50K1lmbFZYcFE2N2pL?=
 =?utf-8?B?T0I1OG9VWnpDZWJ6UC9DeVVBTVBER2xlMi9peFBWdDA4ZjV2N2ZyNmNNbU5R?=
 =?utf-8?B?N2hCbDMrd01FS1krY29vNnJ0Mkg1Y0h1eXFjeFc3QnlTSlBBcVN2L2ExNkhl?=
 =?utf-8?B?UEN6UnZpQ1o1MmJNcFhZOUxocDJMMC9DMHlBemMxbUhyY1BqVzdhWFpSTWRS?=
 =?utf-8?B?WFBkWnBVa1BBYVFMWnFNSEdUL1FhNkNNZDExNmkyQkFtSURrTVRQb3Zmc002?=
 =?utf-8?B?eGswQXJGTVBLeWJhejZXb2NLN3VZUjczZFhGTXdobEY2Y0xjOS93ZGplRU1Q?=
 =?utf-8?B?RHpVMVhxc1V6NEk5dm1sdlJ6dGlEOWp2Q0g4d2RXOEVjNW0xTjVCcHpvemI5?=
 =?utf-8?Q?H0S6spl7XdLN5F6av4Qe/ZLRx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228f1a79-bffc-4132-043b-08dbaf24ff6d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 22:02:44.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGtClf9K01eNXT8rSiG7xS8sAIbUaQBl5Lm64za57P7hMABvSLI+5fRnLgnRgQg8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Mathieu,

Thanks for reviews. Please find my comments below.


On 9/6/23 2:47 PM, Mathieu Poirier wrote:
> Hi Tanmay,
>
> On Tue, Aug 29, 2023 at 11:19:00AM -0700, Tanmay Shah wrote:
> > Use new dt bindings to get TCM address and size
> > information. Also make sure that driver stays
> > compatible with previous device-tree bindings.
> > So, if TCM information isn't available in device-tree
> > for zynqmp platform, hard-coded address of TCM will
> > be used.
> > 
> > New platforms that are compatible with this
> > driver must add TCM support in device-tree as per new
> > bindings.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> >  drivers/remoteproc/xlnx_r5_remoteproc.c | 279 +++++++++++++++++++-----
> >  1 file changed, 221 insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > index feca6de68da2..4eb62eb545c2 100644
> > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > @@ -39,15 +39,19 @@ enum zynqmp_r5_cluster_mode {
> >   * struct mem_bank_data - Memory Bank description
> >   *
> >   * @addr: Start address of memory bank
> > + * @da: device address for this tcm bank
> >   * @size: Size of Memory bank
> >   * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
> > + * @pm_domain_id2: second core's corresponding TCM's pm_domain_id
> >   * @bank_name: name of the bank for remoteproc framework
> >   */
> >  struct mem_bank_data {
> > -	phys_addr_t addr;
> > -	size_t size;
> > +	u32 addr;
> > +	u32 da;
> > +	u32 size;
>
> Why are the types of @addr and @size changed?

So, R5 can access 32-bit address range only. Before I had missed this.

In Devce-tree bindings I am keeping address-cells and size-cells as 2.

So, out of 64-bits only 32-bits will be used to get address of TCM. Same for size.

This motivated me to change the type of @addr and @size fields. It doesn't have any side effects.


>
> >  	u32 pm_domain_id;
> > -	char *bank_name;
> > +	u32 pm_domain_id2;
> > +	char bank_name[32];
>
> Same

Now we have "reg-names" property in dts so, when that is available, I try to use it.

So, instead of keeping simple pointer, I copy name from "struct resources". So, I changed bank_name

from pointer to array.


>
> >  };
> >  
> >  /**
> > @@ -75,11 +79,17 @@ struct mbox_info {
> >   * Hardcoded TCM bank values. This will be removed once TCM bindings are
> >   * accepted for system-dt specifications and upstreamed in linux kernel
> >   */
> > -static const struct mem_bank_data zynqmp_tcm_banks[] = {
> > -	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > -	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> > -	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> > -	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> > +static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> > +	{0xffe00000, 0x0, 0x10000, PD_R5_0_ATCM, 0, "atcm0"}, /* TCM 64KB each */
> > +	{0xffe20000, 0x20000, 0x10000, PD_R5_0_BTCM, 0, "btcm0"},
>
> Here the device address for btcm0 is 0x20000 while in the cover letter it is
> 0x2000.

Thanks for catching this. This is actually typo in cover-letter. It should be 0x20000 in cover-letter.

>
> > +	{0xffe90000, 0x0, 0x10000, PD_R5_1_ATCM, 0, "atcm1"},
> > +	{0xffeb0000, 0x20000, 0x10000, PD_R5_1_BTCM, 0, "btcm1"},
>
> Same

Same here: It should be 0x20000 in cover-letter.

>
> > +};
> > +
> > +/* TCM 128KB each */
> > +static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > +	{0xffe00000, 0x0, 0x20000, PD_R5_0_ATCM, PD_R5_1_ATCM, "atcm0"},
> > +	{0xffe20000, 0x20000, 0x20000, PD_R5_0_BTCM, PD_R5_1_BTCM, "btcm0"},
> >  };
> >  
> >  /**
> > @@ -422,6 +432,7 @@ static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
> >  				      struct rproc_mem_entry *mem)
> >  {
> >  	iounmap((void __iomem *)mem->va);
> > +
>
> Spurious change
Sure,  I will remove it.
>
> >  	return 0;
> >  }
> >  
> > @@ -526,30 +537,6 @@ static int tcm_mem_map(struct rproc *rproc,
> >  	/* clear TCMs */
> >  	memset_io(va, 0, mem->len);
> >  
> > -	/*
> > -	 * The R5s expect their TCM banks to be at address 0x0 and 0x2000,
> > -	 * while on the Linux side they are at 0xffexxxxx.
> > -	 *
> > -	 * Zero out the high 12 bits of the address. This will give
> > -	 * expected values for TCM Banks 0A and 0B (0x0 and 0x20000).
> > -	 */
> > -	mem->da &= 0x000fffff;
> > -
> > -	/*
> > -	 * TCM Banks 1A and 1B still have to be translated.
> > -	 *
> > -	 * Below handle these two banks' absolute addresses (0xffe90000 and
> > -	 * 0xffeb0000) and convert to the expected relative addresses
> > -	 * (0x0 and 0x20000).
> > -	 */
> > -	if (mem->da == 0x90000 || mem->da == 0xB0000)
> > -		mem->da -= 0x90000;
> > -
> > -	/* if translated TCM bank address is not valid report error */
> > -	if (mem->da != 0x0 && mem->da != 0x20000) {
> > -		dev_err(&rproc->dev, "invalid TCM address: %x\n", mem->da);
> > -		return -EINVAL;
> > -	}
> >  	return 0;
> >  }
> >  
> > @@ -571,6 +558,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> >  	u32 pm_domain_id;
> >  	size_t bank_size;
> >  	char *bank_name;
> > +	u32 da;
> >  
> >  	r5_core = rproc->priv;
> >  	dev = r5_core->dev;
> > @@ -586,6 +574,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> >  		bank_name = r5_core->tcm_banks[i]->bank_name;
> >  		bank_size = r5_core->tcm_banks[i]->size;
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > +		da = r5_core->tcm_banks[i]->da;
> >  
> >  		ret = zynqmp_pm_request_node(pm_domain_id,
> >  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > @@ -599,7 +588,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> >  			bank_name, bank_addr, bank_size);
> >  
> >  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > -						 bank_size, bank_addr,
> > +						 bank_size, da,
> >  						 tcm_mem_map, tcm_mem_unmap,
> >  						 bank_name);
> >  		if (!rproc_mem) {
> > @@ -632,14 +621,14 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> >   */
> >  static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> >  {
> > +	u32 pm_domain_id, da, pm_domain_id2;
> >  	struct rproc_mem_entry *rproc_mem;
> >  	struct zynqmp_r5_core *r5_core;
> >  	int i, num_banks, ret;
> > -	phys_addr_t bank_addr;
> > -	size_t bank_size = 0;
> > +	u32 bank_size = 0;
> >  	struct device *dev;
> > -	u32 pm_domain_id;
> >  	char *bank_name;
> > +	u32 bank_addr;
> >  
> >  	r5_core = rproc->priv;
> >  	dev = r5_core->dev;
> > @@ -653,12 +642,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> >  	 * So, Enable each TCM block individually, but add their size
> >  	 * to create contiguous memory region.
> >  	 */
> > -	bank_addr = r5_core->tcm_banks[0]->addr;
> > -	bank_name = r5_core->tcm_banks[0]->bank_name;
> > -
> >  	for (i = 0; i < num_banks; i++) {
> > -		bank_size += r5_core->tcm_banks[i]->size;
> > +		bank_addr = r5_core->tcm_banks[i]->addr;
> > +		bank_name = r5_core->tcm_banks[i]->bank_name;
> > +		bank_size = r5_core->tcm_banks[i]->size;
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > +		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > +		da = r5_core->tcm_banks[i]->da;
> > +
> > +		dev_dbg(dev, "TCM %s addr=0x%x, size=0x%x",
> > +			bank_name, bank_addr, bank_size);
> >  
> >  		/* Turn on each TCM bank individually */
> >  		ret = zynqmp_pm_request_node(pm_domain_id,
> > @@ -668,23 +661,28 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> >  			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> >  			goto release_tcm_lockstep;
> >  		}
> > -	}
> >  
> > -	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
> > -		bank_name, bank_addr, bank_size);
> > -
> > -	/* Register TCM address range, TCM map and unmap functions */
> > -	rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > -					 bank_size, bank_addr,
> > -					 tcm_mem_map, tcm_mem_unmap,
> > -					 bank_name);
> > -	if (!rproc_mem) {
> > -		ret = -ENOMEM;
> > -		goto release_tcm_lockstep;
> > -	}
> > +		/* Turn on each TCM bank individually */
> > +		ret = zynqmp_pm_request_node(pm_domain_id2,
> > +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id2);
> > +			goto release_tcm_lockstep;
> > +		}
> >  
> > -	/* If registration is success, add carveouts */
> > -	rproc_add_carveout(rproc, rproc_mem);
> > +		/* Register TCM address range, TCM map and unmap functions */
> > +		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > +						 bank_size, da,
> > +						 tcm_mem_map, tcm_mem_unmap,
> > +						 bank_name);
> > +		if (!rproc_mem) {
> > +			ret = -ENOMEM;
> > +			goto release_tcm_lockstep;
> > +		}
> > +
> > +		rproc_add_carveout(rproc, rproc_mem);
> > +	}
> >  
> >  	return 0;
> >  
> > @@ -693,7 +691,12 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> >  	for (i--; i >= 0; i--) {
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> >  		zynqmp_pm_release_node(pm_domain_id);
> > +		if (pm_domain_id2) {
> > +			pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > +			zynqmp_pm_release_node(pm_domain_id2);
> > +		}
> >  	}
> > +
> >  	return ret;
> >  }
> >  
> > @@ -800,17 +803,23 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> >   */
> >  static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> >  {
> > +	u32 pm_domain_id, pm_domain_id2;
> >  	struct zynqmp_r5_core *r5_core;
> > -	u32 pm_domain_id;
> >  	int i;
> >  
> >  	r5_core = rproc->priv;
> >  
> >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > +		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> >  		if (zynqmp_pm_release_node(pm_domain_id))
> >  			dev_warn(r5_core->dev,
> >  				 "can't turn off TCM bank 0x%x", pm_domain_id);
> > +		if (pm_domain_id2 && zynqmp_pm_release_node(pm_domain_id2))
> > +			dev_warn(r5_core->dev,
> > +				 "can't turn off TCM bank 0x%x", pm_domain_id2);
> > +		dev_dbg(r5_core->dev, "pm_domain_id=%d, pm_domain_id2=%d\n",
> > +			pm_domain_id, pm_domain_id2);
> >  	}
> >  
> >  	return 0;
> > @@ -883,6 +892,137 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> >  	return ERR_PTR(ret);
> >  }
> >  
> > +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> > +{
> > +	int i, j, tcm_bank_count, ret = -EINVAL;
> > +	struct zynqmp_r5_core *r5_core;
> > +	struct of_phandle_args out_arg;
> > +	struct platform_device *cpdev;
> > +	struct resource *res = NULL;
> > +	u64 abs_addr = 0, size = 0;
> > +	struct mem_bank_data *tcm;
> > +	struct device_node *np, *np1 = NULL;
> > +	struct device *dev;
> > +
> > +	for (i = 0; i < cluster->core_count; i++) {
> > +		r5_core = cluster->r5_cores[i];
> > +		dev = r5_core->dev;
> > +		np = dev_of_node(dev);
> > +
> > +		/* we have address cell 2 and size cell as 2 */
> > +		ret = of_property_count_elems_of_size(np, "reg",
> > +						      4 * sizeof(u32));
> > +		if (ret <= 0) {
> > +			ret = -EINVAL;
> > +			goto fail_tcm;
> > +		}
> > +
> > +		tcm_bank_count = ret;
> > +
> > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > +						  sizeof(struct mem_bank_data *),
> > +						  GFP_KERNEL);
> > +		if (!r5_core->tcm_banks) {
> > +			ret = -ENOMEM;
> > +			goto fail_tcm;
> > +		}
> > +
> > +		r5_core->tcm_bank_count = tcm_bank_count;
> > +		for (j = 0; j < tcm_bank_count; j++) {
> > +			tcm = kzalloc(sizeof(struct mem_bank_data *), GFP_KERNEL);
> > +			if (!tcm) {
> > +				ret = -ENOMEM;
> > +				goto fail_tcm;
> > +			}
> > +
> > +			r5_core->tcm_banks[j] = tcm;
> > +			/* get tcm address without translation */
> > +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> > +			if (ret) {
> > +				dev_err(dev, "failed to get reg property\n");
> > +				goto fail_tcm;
> > +			}
> > +
> > +			/*
> > +			 * remote processor can address only 32 bits
> > +			 * so convert 64-bits into 32-bits. This will discard
> > +			 * any unwanted upper 32-bits.
> > +			 */
> > +			tcm->da = (u32)abs_addr;
> > +			tcm->size = (u32)size;
> > +
> > +			cpdev = to_platform_device(dev);
> > +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> > +			if (!res) {
> > +				dev_err(dev, "failed to get tcm resource\n");
> > +				ret = -EINVAL;
> > +				goto fail_tcm;
> > +			}
> > +
> > +			tcm->addr = (u32)res->start;
> > +			res = devm_request_mem_region(dev, tcm->addr, tcm->size, res->name);
> > +			if (!res) {
> > +				dev_err(dev, "failed to request tcm resource\n");
> > +				ret = -EINVAL;
> > +				goto fail_tcm;
> > +			}
> > +
> > +			memcpy(tcm->bank_name, res->name, ARRAY_SIZE(tcm->bank_name));
> > +			np = of_node_get(dev_of_node(dev));
> > +			/*
> > +			 * In dt power-domains are described in this order:
> > +			 * <RPU core>, <atcm>,  <btcm>
> > +			 * parse power domains for tcm accordingly
> > +			 */
> > +			of_parse_phandle_with_args(np, "power-domains",
> > +						   "#power-domain-cells",
> > +						   j + 1, &out_arg);
> > +			tcm->pm_domain_id = out_arg.args[0];
> > +			of_node_put(out_arg.np);
> > +
> > +			dev_dbg(dev, "TCM: %s, dma=0x%x, da=0x%x, size=0x%x\n",
> > +				tcm->bank_name, tcm->addr, tcm->da, tcm->size);
> > +			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id);
> > +
> > +			if (cluster->mode == SPLIT_MODE)
> > +				continue;
> > +
> > +			/* Turn on core-1's TCM as well */
> > +			np1 = of_get_next_child(dev_of_node(cluster->dev),
> > +						r5_core->np);
> > +			if (!np1) {
> > +				of_node_put(np1);
> > +				np1 = NULL;
> > +				goto fail_tcm;
> > +			}
> > +
> > +			of_parse_phandle_with_args(np1, "power-domains",
> > +						   "#power-domain-cells",
> > +						   j + 1, &out_arg);
> > +			tcm->pm_domain_id2 = out_arg.args[0];
> > +			of_node_put(out_arg.np);
> > +			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id2);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +fail_tcm:
> > +	while (i >= 0) {
> > +		r5_core = cluster->r5_cores[i];
> > +		for (j = 0; j < r5_core->tcm_bank_count; j++) {
> > +			if (!r5_core->tcm_banks)
> > +				continue;
> > +			tcm = r5_core->tcm_banks[j];
> > +			kfree(tcm);
> > +		}
> > +		kfree(r5_core->tcm_banks);
> > +		i--;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * zynqmp_r5_get_tcm_node()
> >   * Ideally this function should parse tcm node and store information
> > @@ -895,12 +1035,20 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> >   */
> >  static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> >  {
> > +	const struct mem_bank_data *zynqmp_tcm_banks;
> >  	struct device *dev = cluster->dev;
> >  	struct zynqmp_r5_core *r5_core;
> >  	int tcm_bank_count, tcm_node;
> >  	int i, j;
> >  
> > -	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
> > +	if (cluster->mode == SPLIT_MODE) {
> > +		zynqmp_tcm_banks = zynqmp_tcm_banks_split;
> > +		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_split);
> > +	} else {
> > +		zynqmp_tcm_banks = zynqmp_tcm_banks_lockstep;
> > +		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_lockstep);
> > +	}
>
> Why are the changes to get TCM bank information from the DT and enhancement to
> support lockstep mode in the same patch?

Actually TCM in lockstep mode was supported before as well. It's just I was using same table in lockstep mode before.

However, now I am having two tables for split mode and lockstep mode.

I had to do this as I have introduced "da" field in "struct mem_bank_data" object.  This makes it easy to process

"device address" derived from device-tree.

And as I have introduced "u32 da", I had to modify table as well and remove hardcoding of "da" calculation in "tcm_mem_map" function.

As all of this is connected, I have them in same patch. No new functionality is added, but just code refactoring.

> > +
> >  
> >  	/* count per core tcm banks */
> >  	tcm_bank_count = tcm_bank_count / cluster->core_count;
> > @@ -951,10 +1099,25 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> >  			       enum rpu_tcm_comb tcm_mode)
> >  {
> >  	struct device *dev = cluster->dev;
> > +	struct device_node *np;
> >  	struct zynqmp_r5_core *r5_core;
> >  	int ret, i;
> >  
> > -	ret = zynqmp_r5_get_tcm_node(cluster);
> > +	/*
> > +	 * try to get tcm nodes from dt but if fail, use hardcode addresses only
> > +	 * for zynqmp platform. New platforms must use dt bindings for TCM.
> > +	 */
> > +	ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> > +	if (ret) {
> > +		np = of_get_compatible_child(dev_of_node(dev), "xlnx,zynqmp-r5f");
> > +		if (np) {
>
> Why was this check added?

We want to maintain backward compatibility with previous bindings only for zynqmp platform.

So, hardcode table is used only for "zynqmp" platform if getting "reg" information from device-tree fails.

If node is not compatible with "xlnx,zynqmp-r5f" then it is new platform and we must not use hardcode

table instead we should fail.


> So far there are too many unanswered questions with this patchset and as such I
> will stop here.

No problem. Please let me know if you have any further questions.


> Mathieu
>
> > +			ret = zynqmp_r5_get_tcm_node(cluster);
> > +		} else {
> > +			dev_err(dev, "tcm not found\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> >  	if (ret < 0) {
> >  		dev_err(dev, "can't get tcm node, err %d\n", ret);
> >  		return ret;
> > -- 
> > 2.25.1
> > 
