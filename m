Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8E7ADD42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjIYQd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjIYQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:33:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD12CE;
        Mon, 25 Sep 2023 09:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I73H9Po5CppQoi1yu9oTF6llOG5znTQEsUC0vnbiID59H7OTiwUd8GelUkXuD5FGWD98qjxV01yDipOjp5X5ZCCN1ZXYQ5ITr1i9vkDEm203y9aeD9a0O2zKlg8QyYtJG7IAvEGhDmQk+RtEcaClhNWdFXuiDFUrGRd73LNbTFnbqHlklHPrMbB4WpGiy5lj5tHPjJ7HAPN3a7S4uBeovrGIct8OssXlrotwmKg0l1M3cNyXUrlRrzvaooTAyqxtokZyst612T+KYNXbBNkp8+0IeW8mWsEFMJHDDxn1caDXHhGF/aANaT9bCLl/qse2BLWHeTAqyeVhyVDjZcWrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBqjg3kmxqKoiz7TR5E/nF50aRFfc+Y9hBjLr0TFGWc=;
 b=EKY0pbBItXlTr/V2ySN3Rfiy6vcMxx1+TTwG395iaHQy/2sIZ5WiIcgczff0Sd+RBM4tm5euaKYeeicY7AaT/YTQoEE1XPepjIzyllTnUCl4gFSC6uqMTyklymSIa+NBtovsPHlnE375Ep2XIp2sU2Pa8RpLYZjHwupAlj1bi7Y9BvQCb6HIUPov8GM6T3vy3tQOqN3lKcY0iJeyj7IFemuCwdNk8+C4U03vW2P54NBvE5AOKc0AD1mOJ1zfxCUZ0Qt1u3SrDBm2qdA4Vb1HrEuXnBYYuNxcpDfYxqLp1Fc1X93GczIN4zm4tcOI4FlKKaveXhr7aKv1G0eh8I5pSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBqjg3kmxqKoiz7TR5E/nF50aRFfc+Y9hBjLr0TFGWc=;
 b=cNAzI1a2OF26LH0Dla6FQPu7guW5zX+dFmbRDxJ2pYjwuudNcYLepqbKrcNfu+W3R094A2yYc9n3R7X2XUpcr7Eveu4CVsFk3L1cz30daDDq6E03Gw1V6Bmfts2KWvXe0Hjt6e0sUhg6aCLztB7uqtI1HG5cdNpqou+8qHRPy0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 16:33:44 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 16:33:43 +0000
Message-ID: <d4e0daa4-152a-4a60-a49c-93645a97f534@amd.com>
Date:   Mon, 25 Sep 2023 11:33:40 -0500
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
 <ff56ae0f-48b5-492b-bbb3-713d457e8514@amd.com> <ZPoRrLJEKwSGv+jR@p14s>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZPoRrLJEKwSGv+jR@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:40::40) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7c8fd1-ce43-4aa3-7779-08dbbde52ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qr8joCBZPaOCKAmiUVKrgtd2ky+HTO6Qjntxrjz1u9DtoJJTrjnDzXJWjbb7vsauvbHyBD1FNQ31n11fc61aOz2R8upMf3dUjb/PRPK9cEtna9GZDk6C5G+AbCZMnt3eCtuNIwwnBtTVP7Oup+1Bnbs2BFF42QvX6qpzZDt6KqnpttD49rJINnmbjoFZGHke3vQ+pDOGKex2qcCdRreNfj7ZJU2nTllClcywWKfKSjMEhkLJ3K3DQ3PgoSlqYC5xNLUu+gD7ZB2W0zT4DnWX9uYUF+lC/XRWZQo7r2PL6qZsX08bfh2ZzJuTTeQVBMLAzF5hre9PaU8QhvG+VZ0sRBgjqwGUlCMpnJHwEg2dlaeZ16W1F+8blCt95f52kFgjvS7zYjjI9E+203yXsMpiD9afMYjS0F8+w5E6/VmeBTnT4wpVM6b02S/5h/9jbKowATGLOUrkkGAetBd+oLEVaPhhcRHJQzpJPrgFe2ogPxFdijV1OGFahAhVDa+GPs1nmCsto62KCIrUghA1zTq5RCai2Lvq6UlOXFDdCWkrSZSRQces09cQOI3IBtsoz8SjjiBdQXJ+9kV4gnUENBbZzSmLEtT7LQkNF/CbukEYSB97v3xfJ5xGqi6GBIYneBoZ1wGRqUd8yle5DBsnOE6dng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(86362001)(2906002)(30864003)(26005)(6512007)(53546011)(66899024)(6506007)(36756003)(6486002)(478600001)(83380400001)(2616005)(31696002)(38100700002)(41300700001)(5660300002)(44832011)(4326008)(316002)(31686004)(66476007)(66556008)(54906003)(8676002)(66946007)(8936002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tSU3kwMlpjSXdlelRoMHUvdTJZMDBIekY2bDhDUStNbml0Nno3VmhyQUNw?=
 =?utf-8?B?OHBWV2lYVkc2aFlEOTVkUGowa1lkVmxqak1XRHhWdkw5c0p2d2k5MTQrdjBH?=
 =?utf-8?B?VWJmYk1vSW5RT05GQmFkaEx2ZkluWk9wNXlia0dDMWlOQnRNK0M4K2ErdFBP?=
 =?utf-8?B?dUIxOUFvUjFyeTB5MlZ5RGh3dmpKbFFDSnhUcHUrZC9mREdkMVdZWGdMR0ZE?=
 =?utf-8?B?RkNtaVUydnJ6YkxMS3E2ZEVJWGlRS29WY3BFcmJzazk2MHVSOTN0RzNLRFAz?=
 =?utf-8?B?YnVaUWFYelF3NGUrOG1xUUs0L1NzNk9LdGtTQlBjQkVZUHZweTR4SkNxb0M4?=
 =?utf-8?B?cHVNcElNM0thQWxONlJuV3U0SFQzTXFMZEV1N0EzMTREUzc4L0hrayswU2po?=
 =?utf-8?B?TlpyMFJELzJWZ2RhenQ1Sk05bUhKcHplMFQ4Z01uWi9oU3o0blM1QW9GcFAv?=
 =?utf-8?B?ZTlnNlA4c2ovc2RLSndXSDJRQmV4UGViNklISFJzYnRYYWMzcHFjeW8xYzQ3?=
 =?utf-8?B?VE1SZTVuOVFSQ2J1QkJoRlk2alhHS3AvMFJibFc5QjQ1OWpLd1RBTVhQWXhn?=
 =?utf-8?B?OGNwUm5hWTJBd1JjeWs0eFFiYlR0aFZLRGVvUDVERGdFalNQS1V3UzgveENo?=
 =?utf-8?B?TENGd2pYZkptM2NBdGJyeWdFaktXNm9OalY5WFFOZkRRMC82V3JJYjFnRWZy?=
 =?utf-8?B?VGVEc1J4a2ZEWkZZY3hHZjlvYmhFUWRGQ3dMR01FM2JYMC9aWktNSm91R2RP?=
 =?utf-8?B?bExINTJ2RS83V0wyZzZVRTRvMlF2enBFZW9GM0pPRmF2TSs5WnZGNXpzV25F?=
 =?utf-8?B?QWU5VEsyV2hNYUlHZ3QzV1VYZnh5ZGdHUElHQXlwNnFLRUFIcXd1OWdDNGl3?=
 =?utf-8?B?b1o5THpoenVUREVLelFtZWcxRm1LNVN1TUZISUZLenhLNkVYczhvNkhTQkN6?=
 =?utf-8?B?a092WTZlR1ZDYit1bHF0enU1Y2dmaGx0NnUwOUsyaC9VTEhsTGtrR2luL055?=
 =?utf-8?B?dUhsbDJxSFlDZWNkd1M0QUh1a2IwWWRzaVJDMVB1bmlRZWRIbGx3c3NRbzNk?=
 =?utf-8?B?cVdnaVdleWdpaWRFcHVScWo4dEJvSVlOUnRhMmI1ckM2VGZidXRqdjc5Tkxx?=
 =?utf-8?B?c2taSXdScnRid1NTOS9JU2tuSGxSQUY2VzlrczBxeDhsK1hKS29XbWtNTmdn?=
 =?utf-8?B?WUd3YXB6M05lTW1RWFl2U3RGZGswQm11VFkxbUNYU0hmZjVDcTB6L2wrMGFx?=
 =?utf-8?B?UW9OSXFEQVZoRjFBdDl6MWozTm04YTBpcmMvK0t0aXVtNnAzOEdZTnNIYU9P?=
 =?utf-8?B?MFIzL1VKT1paYU1NcitXTGRyU0MyMGlYUzFiSUlnOWJ6YjN0RHlxRHBOaE5M?=
 =?utf-8?B?bUdMdkozdFlrZVJZVGFBZ05uS3huandGYzlVWmdKenNnQm1qUE5zaDYrSEdK?=
 =?utf-8?B?am13T21sTyt1TUlibmM1RFdZMkdKYThvTXdqWjBsQkkrcEdIWU1EZHdsdlpG?=
 =?utf-8?B?UTU5clNDVlh2ekhiS0dnVXA3dUcyZVRWb2RORnFncTVZN3B1YU9TamVtU1Z2?=
 =?utf-8?B?R0x0bnUrd3F1YXJTTmgrdmdVNFpTWXlCdVllcjBXcXd1Y2NHODBRY1liQ2lh?=
 =?utf-8?B?OHZBYTJKYXl3NEtSQ2dieHIzSFA2RkpDSnpKMVJLelV1RHBIV2h0VnIzQlpv?=
 =?utf-8?B?b253cXhLK1RyUUNlZk83VGZ2N1g2bnJLbjlEQWtQZ1VnZ1gxR3gvRVVxOGVq?=
 =?utf-8?B?TVdpVzVxcHp5TFBPUDRBU0duUXFsd0szZDJNMkVmMVhQTzMzRnorN01hK3d3?=
 =?utf-8?B?MWVwQ2NRR2xBMGM4RXdQeGVsdWZpamV2RE1ZZ1BPcEppT1Fhd0thZUdyNmd1?=
 =?utf-8?B?a0pUaVBHc29MQkZ0aDJseWM0MkFXVkNwczZnSmRDZnhRZDFXQkVFK3dvU0lX?=
 =?utf-8?B?Q1hPU3hwUlYxZndacDR2WC9nYlFYMmszOE1iL1NuZmd1ZGZXZEZyaVM2ajYx?=
 =?utf-8?B?SGxpemhLeThlSnJoL2NlRFFmQkI1RDg0RjVORGg5YUg4bW85NXovNHIwOGhD?=
 =?utf-8?B?dEFsNG5qWUg4dm1RaTRPZVpVRkhHNXVOZ0Y4VUdWaVI5U3E3RTZGYnNTZzh3?=
 =?utf-8?Q?A7AujnpeyPupsXKxoMVlElTOw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7c8fd1-ce43-4aa3-7779-08dbbde52ecb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 16:33:43.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oj9YBn+BrPxkx/T4waFxt7EVPMQSDQeAjcniYwUAtLGjAet+UPnCvuUquKHslbP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/23 1:08 PM, Mathieu Poirier wrote:
> On Wed, Sep 06, 2023 at 05:02:40PM -0500, Tanmay Shah wrote:
> > HI Mathieu,
> > 
> > Thanks for reviews. Please find my comments below.
> >
>
> I took another look after reading your comment and found more problems...
>
> > 
> > On 9/6/23 2:47 PM, Mathieu Poirier wrote:
> > > Hi Tanmay,
> > >
> > > On Tue, Aug 29, 2023 at 11:19:00AM -0700, Tanmay Shah wrote:
> > > > Use new dt bindings to get TCM address and size
> > > > information. Also make sure that driver stays
> > > > compatible with previous device-tree bindings.
> > > > So, if TCM information isn't available in device-tree
> > > > for zynqmp platform, hard-coded address of TCM will
> > > > be used.
> > > > 
> > > > New platforms that are compatible with this
> > > > driver must add TCM support in device-tree as per new
> > > > bindings.
> > > > 
> > > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > > ---
> > > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 279 +++++++++++++++++++-----
> > > >  1 file changed, 221 insertions(+), 58 deletions(-)
> > > > 
> > > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > index feca6de68da2..4eb62eb545c2 100644
> > > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > @@ -39,15 +39,19 @@ enum zynqmp_r5_cluster_mode {
> > > >   * struct mem_bank_data - Memory Bank description
> > > >   *
> > > >   * @addr: Start address of memory bank
> > > > + * @da: device address for this tcm bank
> > > >   * @size: Size of Memory bank
> > > >   * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
> > > > + * @pm_domain_id2: second core's corresponding TCM's pm_domain_id
> > > >   * @bank_name: name of the bank for remoteproc framework
> > > >   */
> > > >  struct mem_bank_data {
> > > > -	phys_addr_t addr;
> > > > -	size_t size;
> > > > +	u32 addr;
> > > > +	u32 da;
> > > > +	u32 size;
> > >
> > > Why are the types of @addr and @size changed?
> > 
> > So, R5 can access 32-bit address range only. Before I had missed this.
> > 
> > In Devce-tree bindings I am keeping address-cells and size-cells as 2.
> > 
> > So, out of 64-bits only 32-bits will be used to get address of TCM. Same for size.
> > 
> > This motivated me to change the type of @addr and @size fields. It doesn't have any side effects.
>
> It doesn't have an effect but it also doesn't need to be in this patch,
> especially since it is not documented. 
>
>
> This patch needs to be broken in 3 parts:
>
> 1) One patch that deals with the addition of the static mem_bank_data for
> lockstep mode.
>
> 2) One patch that deals with the addition of ->pm_domain_id2 and the potential
> bug I may have highlighted below.

Hi Mathieu,

Just heads up. There is change in this plan. I found out that pm domain framework can be used to power-on/off devices

with pm domains in device-tree. So, I am developing patches accordingly.

I will still split patches but it won't be same as what was posted here. There will be patch that is using

pm domain (genpd) framework to power-on/off TCM.

Tanmay

> 3) One patch that deals with extracting the TCM information from the DT.
> Everything else needs to be in another patch.
>
> > 
> > 
> > >
> > > >  	u32 pm_domain_id;
> > > > -	char *bank_name;
> > > > +	u32 pm_domain_id2;
> > > > +	char bank_name[32];
> > >
> > > Same
> > 
> > Now we have "reg-names" property in dts so, when that is available, I try to use it.
> > 
> > So, instead of keeping simple pointer, I copy name from "struct resources". So, I changed bank_name
> > 
> > from pointer to array.
> >
>
> I'll look at that part again when the rest of may comments are addressed.
>
> > 
> > >
> > > >  };
> > > >  
> > > >  /**
> > > > @@ -75,11 +79,17 @@ struct mbox_info {
> > > >   * Hardcoded TCM bank values. This will be removed once TCM bindings are
> > > >   * accepted for system-dt specifications and upstreamed in linux kernel
> > > >   */
> > > > -static const struct mem_bank_data zynqmp_tcm_banks[] = {
> > > > -	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > > > -	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> > > > -	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> > > > -	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> > > > +static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> > > > +	{0xffe00000, 0x0, 0x10000, PD_R5_0_ATCM, 0, "atcm0"}, /* TCM 64KB each */
> > > > +	{0xffe20000, 0x20000, 0x10000, PD_R5_0_BTCM, 0, "btcm0"},
> > >
> > > Here the device address for btcm0 is 0x20000 while in the cover letter it is
> > > 0x2000.
> > 
> > Thanks for catching this. This is actually typo in cover-letter. It should be 0x20000 in cover-letter.
> > 
> > >
> > > > +	{0xffe90000, 0x0, 0x10000, PD_R5_1_ATCM, 0, "atcm1"},
> > > > +	{0xffeb0000, 0x20000, 0x10000, PD_R5_1_BTCM, 0, "btcm1"},
> > >
> > > Same
> > 
> > Same here: It should be 0x20000 in cover-letter.
> > 
> > >
> > > > +};
> > > > +
> > > > +/* TCM 128KB each */
> > > > +static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > > > +	{0xffe00000, 0x0, 0x20000, PD_R5_0_ATCM, PD_R5_1_ATCM, "atcm0"},
> > > > +	{0xffe20000, 0x20000, 0x20000, PD_R5_0_BTCM, PD_R5_1_BTCM, "btcm0"},
> > > >  };
> > > >  
> > > >  /**
> > > > @@ -422,6 +432,7 @@ static int zynqmp_r5_mem_region_unmap(struct rproc *rproc,
> > > >  				      struct rproc_mem_entry *mem)
> > > >  {
> > > >  	iounmap((void __iomem *)mem->va);
> > > > +
> > >
> > > Spurious change
> > Sure,  I will remove it.
> > >
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -526,30 +537,6 @@ static int tcm_mem_map(struct rproc *rproc,
> > > >  	/* clear TCMs */
> > > >  	memset_io(va, 0, mem->len);
> > > >  
> > > > -	/*
> > > > -	 * The R5s expect their TCM banks to be at address 0x0 and 0x2000,
> > > > -	 * while on the Linux side they are at 0xffexxxxx.
> > > > -	 *
> > > > -	 * Zero out the high 12 bits of the address. This will give
> > > > -	 * expected values for TCM Banks 0A and 0B (0x0 and 0x20000).
> > > > -	 */
> > > > -	mem->da &= 0x000fffff;
> > > > -
> > > > -	/*
> > > > -	 * TCM Banks 1A and 1B still have to be translated.
> > > > -	 *
> > > > -	 * Below handle these two banks' absolute addresses (0xffe90000 and
> > > > -	 * 0xffeb0000) and convert to the expected relative addresses
> > > > -	 * (0x0 and 0x20000).
> > > > -	 */
> > > > -	if (mem->da == 0x90000 || mem->da == 0xB0000)
> > > > -		mem->da -= 0x90000;
> > > > -
> > > > -	/* if translated TCM bank address is not valid report error */
> > > > -	if (mem->da != 0x0 && mem->da != 0x20000) {
> > > > -		dev_err(&rproc->dev, "invalid TCM address: %x\n", mem->da);
> > > > -		return -EINVAL;
> > > > -	}
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -571,6 +558,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > > >  	u32 pm_domain_id;
> > > >  	size_t bank_size;
> > > >  	char *bank_name;
> > > > +	u32 da;
> > > >  
> > > >  	r5_core = rproc->priv;
> > > >  	dev = r5_core->dev;
> > > > @@ -586,6 +574,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > > >  		bank_name = r5_core->tcm_banks[i]->bank_name;
> > > >  		bank_size = r5_core->tcm_banks[i]->size;
> > > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > > +		da = r5_core->tcm_banks[i]->da;
> > > >  
> > > >  		ret = zynqmp_pm_request_node(pm_domain_id,
> > > >  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > > @@ -599,7 +588,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > > >  			bank_name, bank_addr, bank_size);
> > > >  
> > > >  		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > > > -						 bank_size, bank_addr,
> > > > +						 bank_size, da,
> > > >  						 tcm_mem_map, tcm_mem_unmap,
> > > >  						 bank_name);
> > > >  		if (!rproc_mem) {
> > > > @@ -632,14 +621,14 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
> > > >   */
> > > >  static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > >  {
> > > > +	u32 pm_domain_id, da, pm_domain_id2;
> > > >  	struct rproc_mem_entry *rproc_mem;
> > > >  	struct zynqmp_r5_core *r5_core;
> > > >  	int i, num_banks, ret;
> > > > -	phys_addr_t bank_addr;
> > > > -	size_t bank_size = 0;
> > > > +	u32 bank_size = 0;
>
> Why is this changed to a u32 when rproc_mem_entry_init() takes a size_t for
> @len?  This is especially concerning since add_tcm_carveout_split_mode() still
> uses a size_t.
>
> > > >  	struct device *dev;
> > > > -	u32 pm_domain_id;
> > > >  	char *bank_name;
> > > > +	u32 bank_addr;
> > > >  
> > > >  	r5_core = rproc->priv;
> > > >  	dev = r5_core->dev;
> > > > @@ -653,12 +642,16 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > >  	 * So, Enable each TCM block individually, but add their size
> > > >  	 * to create contiguous memory region.
> > > >  	 */
> > > > -	bank_addr = r5_core->tcm_banks[0]->addr;
> > > > -	bank_name = r5_core->tcm_banks[0]->bank_name;
> > > > -
> > > >  	for (i = 0; i < num_banks; i++) {
> > > > -		bank_size += r5_core->tcm_banks[i]->size;
> > > > +		bank_addr = r5_core->tcm_banks[i]->addr;
> > > > +		bank_name = r5_core->tcm_banks[i]->bank_name;
> > > > +		bank_size = r5_core->tcm_banks[i]->size;
> > > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > > +		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > > > +		da = r5_core->tcm_banks[i]->da;
> > > > +
> > > > +		dev_dbg(dev, "TCM %s addr=0x%x, size=0x%x",
> > > > +			bank_name, bank_addr, bank_size);
> > > >  
> > > >  		/* Turn on each TCM bank individually */
> > > >  		ret = zynqmp_pm_request_node(pm_domain_id,
> > > > @@ -668,23 +661,28 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > >  			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > > >  			goto release_tcm_lockstep;
> > > >  		}
> > > > -	}
> > > >  
> > > > -	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
> > > > -		bank_name, bank_addr, bank_size);
> > > > -
> > > > -	/* Register TCM address range, TCM map and unmap functions */
> > > > -	rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > > > -					 bank_size, bank_addr,
> > > > -					 tcm_mem_map, tcm_mem_unmap,
> > > > -					 bank_name);
> > > > -	if (!rproc_mem) {
> > > > -		ret = -ENOMEM;
> > > > -		goto release_tcm_lockstep;
> > > > -	}
> > > > +		/* Turn on each TCM bank individually */
> > > > +		ret = zynqmp_pm_request_node(pm_domain_id2,
> > > > +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > > +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > > +		if (ret < 0) {
> > > > +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id2);
> > > > +			goto release_tcm_lockstep;
> > > > +		}
> > > >  
> > > > -	/* If registration is success, add carveouts */
> > > > -	rproc_add_carveout(rproc, rproc_mem);
> > > > +		/* Register TCM address range, TCM map and unmap functions */
> > > > +		rproc_mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> > > > +						 bank_size, da,
> > > > +						 tcm_mem_map, tcm_mem_unmap,
> > > > +						 bank_name);
>
> The original code adds a single carveout while this code is adding one for each
> memory bank?  Is this done on purpose or is it a bug?  No comment is provided.
>
> > > > +		if (!rproc_mem) {
> > > > +			ret = -ENOMEM;
> > > > +			goto release_tcm_lockstep;
> > > > +		}
> > > > +
> > > > +		rproc_add_carveout(rproc, rproc_mem);
> > > > +	}
> > > >  
> > > >  	return 0;
> > > >  
> > > > @@ -693,7 +691,12 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > >  	for (i--; i >= 0; i--) {
> > > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > >  		zynqmp_pm_release_node(pm_domain_id);
> > > > +		if (pm_domain_id2) {
> > > > +			pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > > > +			zynqmp_pm_release_node(pm_domain_id2);
> > > > +		}
> > > >  	}
> > > > +
> > > >  	return ret;
> > > >  }
> > > >  
> > > > @@ -800,17 +803,23 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> > > >   */
> > > >  static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > > >  {
> > > > +	u32 pm_domain_id, pm_domain_id2;
> > > >  	struct zynqmp_r5_core *r5_core;
> > > > -	u32 pm_domain_id;
> > > >  	int i;
> > > >  
> > > >  	r5_core = rproc->priv;
> > > >  
> > > >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> > > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > > +		pm_domain_id2 = r5_core->tcm_banks[i]->pm_domain_id2;
> > > >  		if (zynqmp_pm_release_node(pm_domain_id))
> > > >  			dev_warn(r5_core->dev,
> > > >  				 "can't turn off TCM bank 0x%x", pm_domain_id);
> > > > +		if (pm_domain_id2 && zynqmp_pm_release_node(pm_domain_id2))
> > > > +			dev_warn(r5_core->dev,
> > > > +				 "can't turn off TCM bank 0x%x", pm_domain_id2);
> > > > +		dev_dbg(r5_core->dev, "pm_domain_id=%d, pm_domain_id2=%d\n",
> > > > +			pm_domain_id, pm_domain_id2);
> > > >  	}
> > > >  
> > > >  	return 0;
> > > > @@ -883,6 +892,137 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > > >  	return ERR_PTR(ret);
> > > >  }
> > > >  
> > > > +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
> > > > +{
> > > > +	int i, j, tcm_bank_count, ret = -EINVAL;
> > > > +	struct zynqmp_r5_core *r5_core;
> > > > +	struct of_phandle_args out_arg;
> > > > +	struct platform_device *cpdev;
> > > > +	struct resource *res = NULL;
> > > > +	u64 abs_addr = 0, size = 0;
> > > > +	struct mem_bank_data *tcm;
> > > > +	struct device_node *np, *np1 = NULL;
> > > > +	struct device *dev;
>
> As far as I can tell @ret, @res and @np1 don't need initilisation.  It may also
> be the case for @abs_addr and @size.  
>
> > > > +
> > > > +	for (i = 0; i < cluster->core_count; i++) {
> > > > +		r5_core = cluster->r5_cores[i];
> > > > +		dev = r5_core->dev;
> > > > +		np = dev_of_node(dev);
> > > > +
> > > > +		/* we have address cell 2 and size cell as 2 */
> > > > +		ret = of_property_count_elems_of_size(np, "reg",
> > > > +						      4 * sizeof(u32));
> > > > +		if (ret <= 0) {
> > > > +			ret = -EINVAL;
> > > > +			goto fail_tcm;
> > > > +		}
> > > > +
> > > > +		tcm_bank_count = ret;
> > > > +
> > > > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > > > +						  sizeof(struct mem_bank_data *),
> > > > +						  GFP_KERNEL);
> > > > +		if (!r5_core->tcm_banks) {
> > > > +			ret = -ENOMEM;
> > > > +			goto fail_tcm;
> > > > +		}
> > > > +
> > > > +		r5_core->tcm_bank_count = tcm_bank_count;
> > > > +		for (j = 0; j < tcm_bank_count; j++) {
> > > > +			tcm = kzalloc(sizeof(struct mem_bank_data *), GFP_KERNEL);
> > > > +			if (!tcm) {
> > > > +				ret = -ENOMEM;
> > > > +				goto fail_tcm;
> > > > +			}
> > > > +
> > > > +			r5_core->tcm_banks[j] = tcm;
> > > > +			/* get tcm address without translation */
> > > > +			ret = of_property_read_reg(np, j, &abs_addr, &size);
> > > > +			if (ret) {
> > > > +				dev_err(dev, "failed to get reg property\n");
> > > > +				goto fail_tcm;
> > > > +			}
> > > > +
> > > > +			/*
> > > > +			 * remote processor can address only 32 bits
> > > > +			 * so convert 64-bits into 32-bits. This will discard
> > > > +			 * any unwanted upper 32-bits.
> > > > +			 */
> > > > +			tcm->da = (u32)abs_addr;
> > > > +			tcm->size = (u32)size;
> > > > +
> > > > +			cpdev = to_platform_device(dev);
> > > > +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
> > > > +			if (!res) {
> > > > +				dev_err(dev, "failed to get tcm resource\n");
> > > > +				ret = -EINVAL;
> > > > +				goto fail_tcm;
> > > > +			}
> > > > +
> > > > +			tcm->addr = (u32)res->start;
> > > > +			res = devm_request_mem_region(dev, tcm->addr, tcm->size, res->name);
> > > > +			if (!res) {
> > > > +				dev_err(dev, "failed to request tcm resource\n");
> > > > +				ret = -EINVAL;
> > > > +				goto fail_tcm;
> > > > +			}
> > > > +
> > > > +			memcpy(tcm->bank_name, res->name, ARRAY_SIZE(tcm->bank_name));
> > > > +			np = of_node_get(dev_of_node(dev));
> > > > +			/*
> > > > +			 * In dt power-domains are described in this order:
> > > > +			 * <RPU core>, <atcm>,  <btcm>
> > > > +			 * parse power domains for tcm accordingly
> > > > +			 */
> > > > +			of_parse_phandle_with_args(np, "power-domains",
> > > > +						   "#power-domain-cells",
> > > > +						   j + 1, &out_arg);
> > > > +			tcm->pm_domain_id = out_arg.args[0];
> > > > +			of_node_put(out_arg.np);
> > > > +
> > > > +			dev_dbg(dev, "TCM: %s, dma=0x%x, da=0x%x, size=0x%x\n",
> > > > +				tcm->bank_name, tcm->addr, tcm->da, tcm->size);
> > > > +			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id);
> > > > +
> > > > +			if (cluster->mode == SPLIT_MODE)
> > > > +				continue;
> > > > +
> > > > +			/* Turn on core-1's TCM as well */
> > > > +			np1 = of_get_next_child(dev_of_node(cluster->dev),
> > > > +						r5_core->np);
> > > > +			if (!np1) {
> > > > +				of_node_put(np1);
> > > > +				np1 = NULL;
> > > > +				goto fail_tcm;
> > > > +			}
> > > > +
> > > > +			of_parse_phandle_with_args(np1, "power-domains",
> > > > +						   "#power-domain-cells",
> > > > +						   j + 1, &out_arg);
> > > > +			tcm->pm_domain_id2 = out_arg.args[0];
> > > > +			of_node_put(out_arg.np);
> > > > +			dev_dbg(dev, "tcm pm domain id %d\n", tcm->pm_domain_id2);
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +
> > > > +fail_tcm:
> > > > +	while (i >= 0) {
> > > > +		r5_core = cluster->r5_cores[i];
> > > > +		for (j = 0; j < r5_core->tcm_bank_count; j++) {
> > > > +			if (!r5_core->tcm_banks)
> > > > +				continue;
> > > > +			tcm = r5_core->tcm_banks[j];
> > > > +			kfree(tcm);
> > > > +		}
> > > > +		kfree(r5_core->tcm_banks);
> > > > +		i--;
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  /**
> > > >   * zynqmp_r5_get_tcm_node()
> > > >   * Ideally this function should parse tcm node and store information
> > > > @@ -895,12 +1035,20 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > > >   */
> > > >  static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> > > >  {
> > > > +	const struct mem_bank_data *zynqmp_tcm_banks;
> > > >  	struct device *dev = cluster->dev;
> > > >  	struct zynqmp_r5_core *r5_core;
> > > >  	int tcm_bank_count, tcm_node;
> > > >  	int i, j;
> > > >  
> > > > -	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
> > > > +	if (cluster->mode == SPLIT_MODE) {
> > > > +		zynqmp_tcm_banks = zynqmp_tcm_banks_split;
> > > > +		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_split);
> > > > +	} else {
> > > > +		zynqmp_tcm_banks = zynqmp_tcm_banks_lockstep;
> > > > +		tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks_lockstep);
> > > > +	}
> > >
> > > Why are the changes to get TCM bank information from the DT and enhancement to
> > > support lockstep mode in the same patch?
> > 
> > Actually TCM in lockstep mode was supported before as well. It's just I was using same table in lockstep mode before.
> > 
> > However, now I am having two tables for split mode and lockstep mode.
> > 
> > I had to do this as I have introduced "da" field in "struct mem_bank_data" object.  This makes it easy to process
> > 
> > "device address" derived from device-tree.
> > 
> > And as I have introduced "u32 da", I had to modify table as well and remove hardcoding of "da" calculation in "tcm_mem_map" function.
> > 
> > As all of this is connected, I have them in same patch. No new functionality is added, but just code refactoring.
> > 
> > > > +
> > > >  
> > > >  	/* count per core tcm banks */
> > > >  	tcm_bank_count = tcm_bank_count / cluster->core_count;
> > > > @@ -951,10 +1099,25 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> > > >  			       enum rpu_tcm_comb tcm_mode)
> > > >  {
> > > >  	struct device *dev = cluster->dev;
> > > > +	struct device_node *np;
> > > >  	struct zynqmp_r5_core *r5_core;
> > > >  	int ret, i;
> > > >  
> > > > -	ret = zynqmp_r5_get_tcm_node(cluster);
> > > > +	/*
> > > > +	 * try to get tcm nodes from dt but if fail, use hardcode addresses only
> > > > +	 * for zynqmp platform. New platforms must use dt bindings for TCM.
> > > > +	 */
> > > > +	ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
> > > > +	if (ret) {
> > > > +		np = of_get_compatible_child(dev_of_node(dev), "xlnx,zynqmp-r5f");
> > > > +		if (np) {
> > >
> > > Why was this check added?
> > 
> > We want to maintain backward compatibility with previous bindings only for zynqmp platform.
> > 
>
> That check has nothing to do with backward compatibility.
>
> > So, hardcode table is used only for "zynqmp" platform if getting "reg" information from device-tree fails.
> > 
> > If node is not compatible with "xlnx,zynqmp-r5f" then it is new platform and we must not use hardcode
> > 
> > table instead we should fail.
> > 
>
> So this is the real reason for the check, but zynqmp-r5f is still the only
> platform supported by this driver.  Please remove and re-introduce if/when a new
> platform is added.
>
> > 
> > > So far there are too many unanswered questions with this patchset and as such I
> > > will stop here.
> > 
> > No problem. Please let me know if you have any further questions.
> > 
> > 
> > > Mathieu
> > >
> > > > +			ret = zynqmp_r5_get_tcm_node(cluster);
> > > > +		} else {
> > > > +			dev_err(dev, "tcm not found\n");
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	}
> > > > +
> > > >  	if (ret < 0) {
> > > >  		dev_err(dev, "can't get tcm node, err %d\n", ret);
> > > >  		return ret;
> > > > -- 
> > > > 2.25.1
> > > > 
