Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF7D80A825
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjLHQF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjLHQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:05:53 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C928172A;
        Fri,  8 Dec 2023 08:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8y+chYTX0drw0dcfgOkJc76qs8JLZ8UbkNI69ySmEFbwYR7bOhYNRFvb5M9nBLwmxcVIujJJalK5+HPi5FWe+5qHicSY0eKlHf3QgY0kEVVhNcPw87qdn7IaYehM/5a5bH7fEWwfef1NPYn/suhA2mIp7NmFWKZOQEccZRUrrusWVRO9upi/9+VGcu0rm/nLvIcpSLS7euPIeojA92Vz1JQW6X+59g7NMqgjBvxXywuCamoLaa78yhSm3feZYqsg6QjHePo987MVlBogJepj8QfSjLbnx45qdKh7AonAa8HLr4SZ3eyCBHUYaInxE2o//ENjLeircn3nAPnam77bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CNFOIbWMnLa5Q3eLGZ8e2nxptN/EP+IlWwWaFQXx3M=;
 b=RgGdjaMdvIv++R/YmIifHmU6XpF9G2GUFBmbWJe5GC54fpqZlAsdlVO2BD3wjiGQmGTcBbLg8xoiG6xpMuJMinX42I1GnPkwdhmDFKfE6PNf98jEtmLpXUrb0BeuHLMozN9ROkYwndBlTWkDdnQOws/Cw+Ib6ZpAl+lNJocZzwowvZZpNrbNloOLOlKdbQ4Fs55+bdEmeTUDWo/o6+xI7N5ceZ9R886FuA4EwPRpv3yh71j1XzdFpo7xOCUqIsNp5OtNm/H5gFbyuYTt1RPNCOtkRN5WTvtRfZ+WVmGYIcPC0xWhgXJCODCuNuypVjUVHDO77Lj4SUQILr2+/ZR1eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CNFOIbWMnLa5Q3eLGZ8e2nxptN/EP+IlWwWaFQXx3M=;
 b=iNGU+BIbgj9KX+UZRA8KtH4kKyI3EFJz9knwNug7HbQeRIl9NFZLTkD6zMrvNRZTHu2q3JXFNrGCq9k23Awd7N7Ux3lCECmEv4cBct0jEANgF0AxRvdsgHQe20DOmDxRmlUCUlJu1rs3IEBZaHtd+SNNdFG8JX4CzOES1nQ/8ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 16:05:55 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 16:05:55 +0000
Message-ID: <e59205ec-3ad5-4c58-a8aa-6e2957c3decf@amd.com>
Date:   Fri, 8 Dec 2023 10:05:51 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 3/4] remoteproc: zynqmp: add pm domains support
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
 <20231117174238.1876655-4-tanmay.shah@amd.com> <ZV02P3bHEhPLQHBo@p14s>
 <93487d3c-c324-4b9b-8b25-0b4ea52237b4@amd.com> <ZV+V6V2sEWgsqngk@p14s>
 <a75b22c1-66e3-4fce-ae64-de79e73f3cfa@amd.com> <ZWdwl/8LC2Nn+vCq@p14s>
 <ea2edc6e-6655-47f8-8b6d-242f5a0ef804@amd.com>
 <CANLsYkzJgZRSz5=nzW+ATmBKemoSd3ybhKuz1CJy33hftAGiqw@mail.gmail.com>
 <2e24d9be-be10-4f80-b3af-c3e0ed003e7b@amd.com> <ZXM7hZlTAbBb8Iox@p14s>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZXM7hZlTAbBb8Iox@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: a9dc855e-9922-464a-38df-08dbf8078ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 673t2pHmvOB1u6aqJ/jMCNlpYYrWawo+xfEMjUow+GnmmJtVte9lpedRuvObsNoKWnHl7NHAaPf0M1mXM8W97VzzDlxnAjFwi0JawqAaEwjPhJ25QxOWeHH+YyvUapTvrDUNNEpRydrmbLO7WMFSMlid90Qf+FvaYmjJ3SJ8JTgr+PC/9HMR3YJo1eU/coMEapn3UocvuDS3uFIppxqnXv/l05QRaUlilroI9T9mtHBLXBfH3DWJ4EDtZwJIaVnDsirgQgl0CD54DMg2eLZVymhw4lq53rJ94Nf63vovO1wS3d5oFwLSgjdRTagY0WtjyYFKgDucWwRvHYFX9Tv+GcMNbQS8H5oAu8Jv+ONYJf19iXLtMuR1lar1rPLPgHCP6khXt8hanj/LjTC+YF9rpDR9veuCQw9f380vwoSaNAYIZjA8sD+H155xKHmK/r23xvs8oMShBljA9teY2/If/PKNatS6/hNXZM6S7VFPVD0HY37rXCUgOyzKOmWQYSlhfDbJtxle+iH3qO5QwrUw4yYRBX6LpGlUtu5Wkitd4jsAVfDWrIDaf7DU8JP2uA/RHS2jT25etdLufsrSEKAO3j0YvBNFiLPwQthU8NCYk0ihGVZlzrokpCh437Nqx1ultLRm+11mP+zu65kz0sK07A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(26005)(2616005)(53546011)(6486002)(478600001)(6506007)(6666004)(83380400001)(2906002)(30864003)(44832011)(5660300002)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(316002)(6916009)(38100700002)(31696002)(86362001)(36756003)(66899024)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU9iZDRiY0pXV2tGZW9UVW8wSG9ra2tLbmhCNk5XVkx4RHRXbVhjeGJ0c0dS?=
 =?utf-8?B?ako3NW1pRlpRNTRwUllqZDlhM3hvdmxiSmhkVUxUMDJISVY2clpscTZBUk5n?=
 =?utf-8?B?OUh1dkVHWG5PdU5WeGRDNFh6WTUxcno2alFjSXlwUXRyRzcrVllPUnl1TWk1?=
 =?utf-8?B?YVpmbzVQYkU2OTRnZWVpV1huQXpQZmUzYXBoTS9IcnFtZkFyWVIrTmJ5LzRw?=
 =?utf-8?B?VlIreVJ4WTIvOHNsbTRjQm55WjdmTlV6bzhBNWVjY0RjcVliS2Q0NjVYRjdo?=
 =?utf-8?B?Um53MWZQZVg5eUtpbjRyOTN1eVR0Q1BBVFc5SGgzait3NFhBVzgzOUxvaEV4?=
 =?utf-8?B?cmNpN3dtcmwzK2FXVjFmNkFaNHpYMGlIam5mQ2hsdTVVMFNMRkRFOHJFTWRN?=
 =?utf-8?B?N0xqSXBnK2w4dCtzTnZ3WTlMUnhmQ1Z0K25PQlc5YzI3RzlpWFY1d1FrT2Vq?=
 =?utf-8?B?RVF5UE8rTWpXZS9US2tIbjJJYjVIZitYVmkxWjNYTWhQNHAzcVRNUHBhZnc0?=
 =?utf-8?B?OVZRV1lWRDdXblF2ckhJZkdYVWw4YVErZ05uK216R25TOExPS0cwOVFoengx?=
 =?utf-8?B?ejRFQzUxaGJVOTZxMTg0TG1aL0p3ZHlzWnE4ZzNXTURDYTN6bE9Pa1NjcEhl?=
 =?utf-8?B?Q2gwbDZoY3dkb3Z3d2hDaklQbUlmazJlejJZeXlhRW5UaGorK05SWG1Lbnp2?=
 =?utf-8?B?aUU5WHA5M2FER2k2U0NHbjJlMktZUlpCdStyWjFPaDBQMkFPdjY4djdxalph?=
 =?utf-8?B?K3lML0cyaWsxVldRUE03a2toSjdUeVVKREkrRHJML2lKRmFSbDB6Zk91cEw2?=
 =?utf-8?B?NDJFcDBXRUlBZmhJT3ZiN0UrbnZLR3V2eGk3Zmo4Yk1pbEVlRGpZNzZLMXR6?=
 =?utf-8?B?RGJRMmVmS1Rjb0R3YURSSXVUQThjSk5IV1puK1VYajAwWTl5Uy9PUGRTYjRU?=
 =?utf-8?B?T2JyZWNwVXpWTUIvckxiSStuZExYNlI4cWV6aFMxV3dtV2FNZVV5ck1HQUJZ?=
 =?utf-8?B?TkZFblcrdnNRRUZjWk9nd0RPbU13TjFzZ3gzRUpPYy9hY2FXc3N0NHNxUGYr?=
 =?utf-8?B?Rks3V05NZitwRzdkQUtDQldpUU5NN2pyWHhBbjg0MG53SFNzQUZDN21wL0lM?=
 =?utf-8?B?dmVXSTVSTmV4MnNzTzVVaWhmNVhqajJ6NU1MRkFOU2FKOW8xSWYwbUkwTmNS?=
 =?utf-8?B?dUIrbGxOR2ZtMkxKd0RZWHQ3T2dWQm81QVJITHY5UzNYYStJUldzanU1RHJB?=
 =?utf-8?B?VXZjUEZ4cFVySWs5cEJhZDNmdlZwM3RpeUVFRlFmbDdXb1A1aTUzOVRyRmFt?=
 =?utf-8?B?blFNWTdxNU1YaG9kaHRzQWJsS0R6Y1IvQ29US01aR1FLdFFROE5ISlRJdVVX?=
 =?utf-8?B?MzZ1UU9Ud0o5WXI5Q2hBd2VEaFd5d1I1bTZzOWIzZGJLcWtlVmlwdmlvRENR?=
 =?utf-8?B?dGJNSXdoLzhSc0o4VEJ0N08rTklGQm9XV1BsMi9ROFg3UTB1blJpc0QxYXNB?=
 =?utf-8?B?UWNHNER0SlpxWTNzZDl6ZFh3Y1RuRDFnOUttNUlKNXJVdHZlK0YvdVg3MWFq?=
 =?utf-8?B?ck9MTGNaQ2RZY3A0Rm5hNGdtTCtrZEJHZGlaOG1sNk00QzBJck9qWWFBb1Rh?=
 =?utf-8?B?RWpNQVg1TmI0c1NkRUpCL244OElteWZESzRIRG43NWp2M3lNNFd4OUhyenNl?=
 =?utf-8?B?anpFaGYySDY3VWNwRWNsaW5Naks4c1RPaW9nT2RxenN0bjg3S2VhcSsxa0wr?=
 =?utf-8?B?enNaUFRKclBmOTBSVHhkZjZaK003cWxGYlUxazVWVU5ZWU9yZTA3a29VRlVC?=
 =?utf-8?B?QUt3c2JsRWh2T2NvcTk2UTR5SE1Cajh6elpYWDdaMDRHM1BoMERUMVR0OFh2?=
 =?utf-8?B?eGEyb3RPbnE4OXVqaTVnakNOV3loL3I4Y3I0clJiTktiSnhZdzZXTm8vZyt4?=
 =?utf-8?B?d2NRVXFRT0JsQ0kzV2t3Q1NaczFXclVwS0FjaW9PM1c2Skh5Q2M3ekZmYWlT?=
 =?utf-8?B?ZGkxeU1zWTlDODgxTTZObnBNRzFWUVpPWENnbkhHV0kzUTVPd2Q1Qi9tT3VY?=
 =?utf-8?B?bFRHSWdiV25uSWVrY2t4TjZhZzhXZ25kei9jRWVXTmxUUXB5RmtyTGx2YUN0?=
 =?utf-8?Q?V3UYjfF/nAPhVDqjBIi+xNJSl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9dc855e-9922-464a-38df-08dbf8078ee0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 16:05:55.0178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zFopFNSf0k0zm7meYrdCUc4/AtFeXGu7T9PhxW8EahDoaqOs/3SRdiwnAiBPp/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/8/23 9:51 AM, Mathieu Poirier wrote:
> On Wed, Dec 06, 2023 at 12:06:45PM -0600, Tanmay Shah wrote:
> > 
> > On 12/6/23 9:43 AM, Mathieu Poirier wrote:
> > > On Fri, 1 Dec 2023 at 11:10, Tanmay Shah <tanmay.shah@amd.com> wrote:
> > > >
> > > >
> > > > On 11/29/23 11:10 AM, Mathieu Poirier wrote:
> > > > > On Mon, Nov 27, 2023 at 10:33:05AM -0600, Tanmay Shah wrote:
> > > > > >
> > > > > > On 11/23/23 12:11 PM, Mathieu Poirier wrote:
> > > > > > > On Wed, Nov 22, 2023 at 03:00:36PM -0600, Tanmay Shah wrote:
> > > > > > > > Hi Mathieu,
> > > > > > > >
> > > > > > > > Please find my comments below.
> > > > > > > >
> > > > > > > > On 11/21/23 4:59 PM, Mathieu Poirier wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On Fri, Nov 17, 2023 at 09:42:37AM -0800, Tanmay Shah wrote:
> > > > > > > > > > Use TCM pm domains extracted from device-tree
> > > > > > > > > > to power on/off TCM using general pm domain framework.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Changes in v7:
> > > > > > > > > >   - %s/pm_dev1/pm_dev_core0/r
> > > > > > > > > >   - %s/pm_dev_link1/pm_dev_core0_link/r
> > > > > > > > > >   - %s/pm_dev2/pm_dev_core1/r
> > > > > > > > > >   - %s/pm_dev_link2/pm_dev_core1_link/r
> > > > > > > > > >   - remove pm_domain_id check to move next patch
> > > > > > > > > >   - add comment about how 1st entry in pm domain list is used
> > > > > > > > > >   - fix loop when jump to fail_add_pm_domains loop
> > > > > > > > > >
> > > > > > > > > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 215 +++++++++++++++++++++++-
> > > > > > > > > >  1 file changed, 212 insertions(+), 3 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > > > > > index 4395edea9a64..22bccc5075a0 100644
> > > > > > > > > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > > > > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > > > > > @@ -16,6 +16,7 @@
> > > > > > > > > >  #include <linux/of_reserved_mem.h>
> > > > > > > > > >  #include <linux/platform_device.h>
> > > > > > > > > >  #include <linux/remoteproc.h>
> > > > > > > > > > +#include <linux/pm_domain.h>
> > > > > > > > > >
> > > > > > > > > >  #include "remoteproc_internal.h"
> > > > > > > > > >
> > > > > > > > > > @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > > > > > > > > >   * @rproc: rproc handle
> > > > > > > > > >   * @pm_domain_id: RPU CPU power domain id
> > > > > > > > > >   * @ipi: pointer to mailbox information
> > > > > > > > > > + * @num_pm_dev: number of tcm pm domain devices for this core
> > > > > > > > > > + * @pm_dev_core0: pm domain virtual devices for power domain framework
> > > > > > > > > > + * @pm_dev_core0_link: pm domain device links after registration
> > > > > > > > > > + * @pm_dev_core1: used only in lockstep mode. second core's pm domain virtual devices
> > > > > > > > > > + * @pm_dev_core1_link: used only in lockstep mode. second core's pm device links after
> > > > > > > > > > + * registration
> > > > > > > > > >   */
> > > > > > > > > >  struct zynqmp_r5_core {
> > > > > > > > > >     struct device *dev;
> > > > > > > > > > @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
> > > > > > > > > >     struct rproc *rproc;
> > > > > > > > > >     u32 pm_domain_id;
> > > > > > > > > >     struct mbox_info *ipi;
> > > > > > > > > > +   int num_pm_dev;
> > > > > > > > > > +   struct device **pm_dev_core0;
> > > > > > > > > > +   struct device_link **pm_dev_core0_link;
> > > > > > > > > > +   struct device **pm_dev_core1;
> > > > > > > > > > +   struct device_link **pm_dev_core1_link;
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > >  /**
> > > > > > > > > > @@ -651,7 +663,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > > > > > > > >                                          ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > > > > > > > >                                          ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > > > > > > > >             if (ret < 0) {
> > > > > > > > > > -                   dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > > > > > > > > > +                   dev_err(dev, "failed to turn on TCM 0x%x",
> > > > > > > > > > +                           pm_domain_id);
> > > > > > > > >
> > > > > > > > > Spurious change, you should have caught that.
> > > > > > > >
> > > > > > > > Ack, need to observe changes more closely before sending them.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >                     goto release_tcm_lockstep;
> > > > > > > > > >             }
> > > > > > > > > >
> > > > > > > > > > @@ -758,6 +771,189 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> > > > > > > > > >     return ret;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> > > > > > > > > > +{
> > > > > > > > > > +   struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > > > > > > +   struct device *dev = r5_core->dev;
> > > > > > > > > > +   struct zynqmp_r5_cluster *cluster;
> > > > > > > > > > +   int i;
> > > > > > > > > > +
> > > > > > > > > > +   cluster = platform_get_drvdata(to_platform_device(dev->parent));
> > > > > > > > > > +
> > > > > > > > > > +   for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > > > > > +           device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > > > > > > +           dev_pm_domain_detach(r5_core->pm_dev_core0[i], false);
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +   kfree(r5_core->pm_dev_core0);
> > > > > > > > > > +   r5_core->pm_dev_core0 = NULL;
> > > > > > > > > > +   kfree(r5_core->pm_dev_core0_link);
> > > > > > > > > > +   r5_core->pm_dev_core0_link = NULL;
> > > > > > > > > > +
> > > > > > > > > > +   if (cluster->mode == SPLIT_MODE) {
> > > > > > > > > > +           r5_core->num_pm_dev = 0;
> > > > > > > > > > +           return;
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +   for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > > > > > +           device_link_del(r5_core->pm_dev_core1_link[i]);
> > > > > > > > > > +           dev_pm_domain_detach(r5_core->pm_dev_core1[i], false);
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +   kfree(r5_core->pm_dev_core1);
> > > > > > > > > > +   r5_core->pm_dev_core1 = NULL;
> > > > > > > > > > +   kfree(r5_core->pm_dev_core1_link);
> > > > > > > > > > +   r5_core->pm_dev_core1_link = NULL;
> > > > > > > > > > +   r5_core->num_pm_dev = 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> > > > > > > > > > +{
> > > > > > > > > > +   struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > > > > > > +   struct device *dev = r5_core->dev, *dev2;
> > > > > > > > > > +   struct zynqmp_r5_cluster *cluster;
> > > > > > > > > > +   struct platform_device *pdev;
> > > > > > > > > > +   struct device_node *np;
> > > > > > > > > > +   int i, j, num_pm_dev, ret;
> > > > > > > > > > +
> > > > > > > > > > +   cluster = dev_get_drvdata(dev->parent);
> > > > > > > > > > +
> > > > > > > > > > +   /* get number of power-domains */
> > > > > > > > > > +   num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> > > > > > > > > > +                                           "#power-domain-cells");
> > > > > > > > > > +
> > > > > > > > > > +   if (num_pm_dev <= 0)
> > > > > > > > > > +           return -EINVAL;
> > > > > > > > > > +
> > > > > > > > > > +   r5_core->pm_dev_core0 = kcalloc(num_pm_dev,
> > > > > > > > > > +                                   sizeof(struct device *),
> > > > > > > > > > +                                   GFP_KERNEL);
> > > > > > > > > > +   if (!r5_core->pm_dev_core0)
> > > > > > > > > > +           ret = -ENOMEM;
> > > > > > > > > > +
> > > > > > > > > > +   r5_core->pm_dev_core0_link = kcalloc(num_pm_dev,
> > > > > > > > > > +                                        sizeof(struct device_link *),
> > > > > > > > > > +                                        GFP_KERNEL);
> > > > > > > > > > +   if (!r5_core->pm_dev_core0_link) {
> > > > > > > > > > +           kfree(r5_core->pm_dev_core0);
> > > > > > > > > > +           r5_core->pm_dev_core0 = NULL;
> > > > > > > > > > +           return -ENOMEM;
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +   r5_core->num_pm_dev = num_pm_dev;
> > > > > > > > > > +
> > > > > > > > > > +   /*
> > > > > > > > > > +    * start from 2nd entry in power-domains property list as
> > > > > > > > > > +    * for zynqmp we only add TCM power domains and not core's power domain.
> > > > > > > > > > +    * 1st entry is used to configure r5 operation mode.
> > > > > > > > >
> > > > > > > > > You are still not saying _where_ ->pm_dev_core0[0] gets added.
> > > > > > > >
> > > > > > > > So, pm_dev_core0[0] isn't really need to be added for zynqmp platform, as firmware starts it with call,
> > > > > > > >
> > > > > > > > zynqmp_pm_request_wake during rproc_start callback. I will document this in next
> > > > > > > >
> > > > > > >
> > > > > > > That is exactly what I am looking for.  That way people don't have to go through
> > > > > > > the entire driver trying to figure out what is happening with pm_dev_core[0].
> > > > > > >
> > > > > > > I'm also not sure about the power-up order.  Logically the TCMs should be
> > > > > > > powered up before the R5 in order to put code in them.  The R5s are powered in
> > > > > > > zynqmp_r5_rproc_start() but I am unclear as to where in the boot sequence the
> > > > > > > TCMs are powered - can you expand on that?
> > > > > >
> > > > > >
> > > > > > Sure. Following is call sequece
> > > > > >
> > > > > > zynqmp_r5_rproc_prepare
> > > > > >
> > > > > > zynqmp_r5_add_pm_domains -> Here TCM is powered on when device_link_add is called via zynqmp-pm-domains.c driver.
> > > > > >
> > > > > > . . .
> > > > > >
> > > > > > zynqmp_r5_rproc_start -> load firmware and Starts RPU
> > > > > >
> > > > > > So what you mentioned is correct, TCM is being powerd-on before we load firmware and start RPU.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > revision. For new platforms pm_dev_core0[0] will be added in future.
> > > > > > >
> > > > > > > Now I'm really confused - what do you mean by "pm_dev_core0[0] will be added in
> > > > > > > future"?
> > > > > >
> > > > > >
> > > > > > ZynqMP platform has platform management firmware running on microblaze.
> > > > > >
> > > > > > This firmware design does not expect R5 pm domains to be requested explicitly.
> > > > > >
> > > > > > This means, during zynqmp_r5_rproc_start when "zynqmp_pm_request_wake" is called,
> > > > > >
> > > > > > firmware powers on R5. So, pm_dev_core[0] is not really used for ZynqMP.
> > > > > >
> > > > > > However, this design was changed for new platforms i.e. "versal" and onwards.
> > > > > >
> > > > > > Firmware of new platform expects pm domains to be requested explicitly for R5 cores before
> > > > > >
> > > > > > waking them up.
> > > > > >
> > > > > > That means, pm_dev_core[0] for R5 cores on new platform (Versal) needs to be used same as TCM.
> > > > > >
> > > > > > Then, we should wake it up on r5_core.
> > > > > >
> > > > > > To summarize:
> > > > > >
> > > > > > For zynqmp only following call needed to start R5:
> > > > > >
> > > > > > zynqmp_pm_request_wake
> > > > > >
> > > > > > For "versal" and onwards we need two calls to start R5:
> > > > > >
> > > > > > "device_link_add" and zynqmp_pm_request_wake
> > > > > >
> > > > > > So, in future pm_core_dev[0] will be used.
> > > > > >
> > > > >
> > > > > Thanks for the clarification on both front.  The problem here is that we are
> > > > > keeping R5 power domain information in two different places, i.e
> > > > > zynqmp_r5_core::pm_domain_id and zynqmp_r5_core::pm_dev_core0[0].
> > > > >
> > > > > Please see if you can retreive the power domain ID from
> > > > > zynqmp_r5_core::pm_dev_core0[0].  That way you can get the power domain ID when
> > > > > calling zynqmp_pm_request_wake() and zynqmp_pm_force_pwrdwn() and get rid of
> > > > > zynqmp_r5_core::pm_domain_id.
> > > >
> > > > Hi Mathieu,
> > > >
> > > > I looked into this. Probably I can't retrieve pm_domain_id from pm_dev_core0[0],
> > > >
> > > > However, I can retrieve it from device-tree when calling zynqmp_pm_request_wake
> > > >
> > > > and zynqmp_pm_force_pwrdwn.
> > > >
> > > > zynqmp_r5_core::pm_domain_id is caching that value during probe, and use it during
> > > > rest of the driver lifecycle.
> > > >
> > > > I am okay either way, (keeping it as it is, or get it from device-tree). Let me know your
> > > >
> > > > preference.
> > > >
> > >
> > > Humm...  Then I suggest to simply get rid of the device linking to
> > > deal with the TCMs' power management.  From where I stand it provides
> > > more confusion than benefits, and that is without considering the
> > > extra complexity.
> > 
> > 
> > Do you mean to get rid of pm_dev_core0[1], and pm_dev_core0[2] as well ?
> >
>
> Yes
>
> > If yes, its preferred to use pm_domain framework to power-on/off TCM.
> > 
>
> That is when the pm runtime subsystem is used extensively but it isn't
> the case here.  In this scenario using device linking is adding a lot of
> complexity for something that could be done in a single line of code.   

Ok fair point, please give me sometime to explore more.

I don't mind getting rid of pm domain framework usage. For some reason, if we must use it,

we can always introduce it later.

I just want to make sure if we don't use pm domains framework, then remoteproc works for

future platforms as well. I will get back to you as need to do more testing after removing pm domains framework.

Thanks,

Tanmay


> > If we want to get rid of zynqmp_r5_core::pm_domain_id, I will do what's done in
> > 
> > __genpd_dev_pm_attach API where, pm_domain_id is retrieved using of_node of pm_dev_core0[*] device.
> > 
> >     ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> >                             "#power-domain-cells", index, &pd_args);
>
> That is what I asked for in my previous email, i.e use ->pm_dev_core0[0] to
> retrieve the domain ID.
>
> > 
> > However, Its preferred to use pm_domain framework when power-domains are available in device-tree.
> > 
> > Let  me know.
> > 
> > Thanks,
> > 
> > Tanmay
> > 
> > 
> > > > Thanks,
> > > >
> > > > Tanmay
> > > >
> > > > > >
> > > > > > > >
> > > > > > > > I hope this meets expectations.
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > +    */
> > > > > > > > > > +   for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > > > > > +           r5_core->pm_dev_core0[i] = dev_pm_domain_attach_by_id(dev, i);
> > > > > > > > > > +           if (IS_ERR_OR_NULL(r5_core->pm_dev_core0[i])) {
> > > > > > > > >
> > > > > > > > > Here IS_ERR_OR_NULL() is used while two if conditions for NULL and an error
> > > > > > > > > code are used in the loop for the lockstep mode.  Please pick one heuristic and
> > > > > > > > > stick with it.  I have no preference on which one.
> > > > > > > >
> > > > > > > > Ok, I think IS_ERR_OR_NULL is more cleaner, I will address it in next revision.
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > +                   dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> > > > > > > > > > +                           PTR_ERR(r5_core->pm_dev_core0[i]));
> > > > > > > > > > +                   ret = -EINVAL;
> > > > > > > > > > +                   goto fail_add_pm_domains;
> > > > > > > > > > +           }
> > > > > > > > > > +           r5_core->pm_dev_core0_link[i] = device_link_add(dev,
> > > > > > > > > > +                                                           r5_core->pm_dev_core0[i],
> > > > > > > > > > +                                                           DL_FLAG_STATELESS |
> > > > > > > > > > +                                                           DL_FLAG_RPM_ACTIVE |
> > > > > > > > > > +                                                           DL_FLAG_PM_RUNTIME);
> > > > > > > > > > +           if (!r5_core->pm_dev_core0_link[i]) {
> > > > > > > > > > +                   dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > > > > > > +                   r5_core->pm_dev_core0[i] = NULL;
> > > > > > > > > > +                   ret = -EINVAL;
> > > > > > > > > > +                   goto fail_add_pm_domains;
> > > > > > > > > > +           }
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +   if (cluster->mode == SPLIT_MODE)
> > > > > > > > > > +           return 0;
> > > > > > > > > > +
> > > > > > > > > > +   r5_core->pm_dev_core1 = kcalloc(num_pm_dev,
> > > > > > > > > > +                                   sizeof(struct device *),
> > > > > > > > > > +                                   GFP_KERNEL);
> > > > > > > > > > +   if (!r5_core->pm_dev_core1) {
> > > > > > > > > > +           ret = -ENOMEM;
> > > > > > > > > > +           goto fail_add_pm_domains;
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +   r5_core->pm_dev_core1_link = kcalloc(num_pm_dev,
> > > > > > > > > > +                                        sizeof(struct device_link *),
> > > > > > > > > > +                                        GFP_KERNEL);
> > > > > > > > > > +   if (!r5_core->pm_dev_core1_link) {
> > > > > > > > > > +           kfree(r5_core->pm_dev_core1);
> > > > > > > > > > +           r5_core->pm_dev_core1 = NULL;
> > > > > > > > > > +           ret = -ENOMEM;
> > > > > > > > > > +           goto fail_add_pm_domains;
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +   /* get second core's device to detach its power-domains */
> > > > > > > > > > +   np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> > > > > > > > > > +
> > > > > > > > > > +   pdev = of_find_device_by_node(np);
> > > > > > > > > > +   if (!pdev) {
> > > > > > > > > > +           dev_err(cluster->dev, "core1 platform device not available\n");
> > > > > > > > > > +           kfree(r5_core->pm_dev_core1);
> > > > > > > > > > +           kfree(r5_core->pm_dev_core1_link);
> > > > > > > > > > +           r5_core->pm_dev_core1 = NULL;
> > > > > > > > > > +           r5_core->pm_dev_core1_link = NULL;
> > > > > > > > > > +           ret = -EINVAL;
> > > > > > > > > > +           goto fail_add_pm_domains;
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +   dev2 = &pdev->dev;
> > > > > > > > > > +
> > > > > > > > > > +   /* for zynqmp we only add TCM power domains and not core's power domain */
> > > > > > > > > > +   for (j = 1; j < r5_core->num_pm_dev; j++) {
> > > > > > > > > > +           r5_core->pm_dev_core1[j] = dev_pm_domain_attach_by_id(dev2, j);
> > > > > > > > > > +           if (!r5_core->pm_dev_core1[j]) {
> > > > > > > > > > +                   dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > > > > > > +                   ret = -EINVAL;
> > > > > > > > > > +                   goto fail_add_pm_domains_lockstep;
> > > > > > > > > > +           } else if (IS_ERR(r5_core->pm_dev_core1[j])) {
> > > > > > > > > > +                   dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > > > > > > +                   ret = PTR_ERR(r5_core->pm_dev_core1[j]);
> > > > > > > > > > +                   goto fail_add_pm_domains_lockstep;
> > > > > > > > > > +           }
> > > > > > > > > > +
> > > > > > > > > > +           r5_core->pm_dev_core1_link[j] = device_link_add(dev,
> > > > > > > > > > +                                                           r5_core->pm_dev_core1[j],
> > > > > > > > > > +                                                           DL_FLAG_STATELESS |
> > > > > > > > > > +                                                           DL_FLAG_RPM_ACTIVE |
> > > > > > > > > > +                                                           DL_FLAG_PM_RUNTIME);
> > > > > > > > > > +           if (!r5_core->pm_dev_core1_link[j]) {
> > > > > > > > > > +                   dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > > > > > > +                   r5_core->pm_dev_core1[j] = NULL;
> > > > > > > > > > +                   ret = -ENODEV;
> > > > > > > > > > +                   goto fail_add_pm_domains_lockstep;
> > > > > > > > > > +           }
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > > +fail_add_pm_domains_lockstep:
> > > > > > > > > > +   while (--j >= 0) {
> > > > > > > > > > +           device_link_del(r5_core->pm_dev_core1_link[j]);
> > > > > > > > > > +           dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > > > > > > +   }
> > > > > > > > > > +   kfree(r5_core->pm_dev_core1);
> > > > > > > > > > +   r5_core->pm_dev_core1 = NULL;
> > > > > > > > > > +   kfree(r5_core->pm_dev_core1_link);
> > > > > > > > > > +   r5_core->pm_dev_core1_link = NULL;
> > > > > > > > > > +
> > > > > > > > > > +fail_add_pm_domains:
> > > > > > > > > > +   while (--i >= 0) {
> > > > > > > > > > +           device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > > > > > > +           dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > > > > > > +   }
> > > > > > > > > > +   kfree(r5_core->pm_dev_core0);
> > > > > > > > > > +   r5_core->pm_dev_core0 = NULL;
> > > > > > > > > > +   kfree(r5_core->pm_dev_core0_link);
> > > > > > > > > > +   r5_core->pm_dev_core0_link = NULL;
> > > > > > > > > > +
> > > > > > > > >
> > > > > > > > > The error path is much cleaner and readable now.
> > > > > > > > >
> > > > > > > > > I will continue tomorrow.
> > > > > > > > >
> > > > > > > > > Mathieu
> > > > > > > > >
> > > > > > > > > > +   return ret;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  /**
> > > > > > > > > >   * zynqmp_r5_rproc_prepare()
> > > > > > > > > >   * adds carveouts for TCM bank and reserved memory regions
> > > > > > > > > > @@ -770,19 +966,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> > > > > > > > > >  {
> > > > > > > > > >     int ret;
> > > > > > > > > >
> > > > > > > > > > +   ret = zynqmp_r5_add_pm_domains(rproc);
> > > > > > > > > > +   if (ret) {
> > > > > > > > > > +           dev_err(&rproc->dev, "failed to add pm domains\n");
> > > > > > > > > > +           return ret;
> > > > > > > > > > +   }
> > > > > > > > > > +
> > > > > > > > > >     ret = add_tcm_banks(rproc);
> > > > > > > > > >     if (ret) {
> > > > > > > > > >             dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> > > > > > > > > > -           return ret;
> > > > > > > > > > +           goto fail_prepare;
> > > > > > > > > >     }
> > > > > > > > > >
> > > > > > > > > >     ret = add_mem_regions_carveout(rproc);
> > > > > > > > > >     if (ret) {
> > > > > > > > > >             dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> > > > > > > > > > -           return ret;
> > > > > > > > > > +           goto fail_prepare;
> > > > > > > > > >     }
> > > > > > > > > >
> > > > > > > > > >     return 0;
> > > > > > > > > > +
> > > > > > > > > > +fail_prepare:
> > > > > > > > > > +   zynqmp_r5_remove_pm_domains(rproc);
> > > > > > > > > > +
> > > > > > > > > > +   return ret;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  /**
> > > > > > > > > > @@ -801,6 +1008,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > > > > > > > > >
> > > > > > > > > >     r5_core = rproc->priv;
> > > > > > > > > >
> > > > > > > > > > +   zynqmp_r5_remove_pm_domains(rproc);
> > > > > > > > > > +
> > > > > > > > > >     for (i = 0; i < r5_core->tcm_bank_count; i++) {
> > > > > > > > > >             pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > > > > > > > >             if (zynqmp_pm_release_node(pm_domain_id))
> > > > > > > > > > --
> > > > > > > > > > 2.25.1
> > > > > > > > > >
