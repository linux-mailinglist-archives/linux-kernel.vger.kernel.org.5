Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9476A9BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjHAHG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjHAHGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:06:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AFEE7C;
        Tue,  1 Aug 2023 00:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmo0eUr85ki1ZDF/niGdiNUQ++O+RyqPDO9Ni5LQ8WHYmoyrwkWbvlD8Qxeh50CZAa2gsk88vjthEWyt5E7OdFeOcCDus2KIesihLgdlB8MWLmJfSHSICa57DvZSHyX1zWaOEdd0dvsCsHoXr2gSm3GTysC1epRv0qypG4hMC4YNHVpoNAZYFux0bQFLR9n8fT4A2sBB+e+QO2zI4XZ5TdUSZPuGDOlrn2VXCbKJy3k2SelzrLxaX1XCB/GAr1AveV0Fm8AiJW1JE7eA93TUCDKkgh0Am/KcbqvoQfJeehUuLdFLkqijLNmxVe9AARdxUIXj1F1rICPS6j6pdXHg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ut2ZHm7voKtBYpSabY12c2aF3UX5vl8kBKwbxzFW+E=;
 b=n6xTnP/slmYu5dw7//OPnpT7VqYAUx3kZGBPUfwJ/J4ynlsFgSY/tiJq1MdNmXqFMs0RiLzlO/ChdsfKVuKLrRwjqE3vCSwkePmi8DclgUZWTMIvhoMbJvRcQJ/gR8w3eyB7/+qhMS4Q+zIP5KdbodjIMAslJBgK/Xepx5z57ho7ngrsXtGDK6cS2SfFagcTTi24nQ0tb8VhNIa8FvTLRcO6TcTDi2m1MVLZSo0nscEq+93TAlf2g1ByYV7w2Wtp9eLPfVkJD9l6Nmv36EAAc6Mt7Vs98aRuEiFnZo2PSoIF1q+7oYeagETCZlq8cv/v/7rV5TPpRjeGYhTet6qO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ut2ZHm7voKtBYpSabY12c2aF3UX5vl8kBKwbxzFW+E=;
 b=IqyREAotf7McYAdhjBQIESbvVzQHwh2LPhP5tlGfuELpAzrcyPp1swDpSA2c/rICbN/OY8ilw5LLgAmJ/PWzndpVEX6h7NcR+Ni67TYInuDQZQNU+A3PiIY3f2h0NRZBp7CzpW8kEb+//7cMm+3jfU7zDq514Ccsxnz9Tacz5ZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 07:06:17 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2dd6:4ccd:1695:d51f]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2dd6:4ccd:1695:d51f%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 07:06:17 +0000
Date:   Tue, 1 Aug 2023 12:35:58 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Message-ID: <ZMiu1t8blYAdm2Br@BLR-5CG11610CF.amd.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728120930.839913695@linutronix.de>
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c0f596-ed16-46ca-14de-08db925dcd13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wjtRnKHk5R5Uwjr/3phAZJZ0soM3w5zxYlJ4kZ//9xDycbvXNgSowKbz88r+GmIVsuKRBF/u8YKXAWzow5GedyTYvooruFQuGVFpIWryBIrRjaQGTI2hlfiy9A5F/TMN90N6L6/FB609m7SAt6QSDJlxEy74z65OQqSWRgLHaFW3kPxLC8J/mxcZhzVJvjPKeVDVdko994tMUQ1xjx+N4ZmLEgaFXUIWv2Rru9OacrWzRyudb9pA2X8qFn6hT7PO65KGepvnTNCc/1JaO0CicjPFT5bTumSjKDNCBPdlU3pnrlkQwzeUb6XE2Z/YLv3FFryORi0I4NuLrxsdMg64pIZOPTFTGotNe1nOMs1GKi194n4DlEvofOJA0T6rxjkAnG0WdyozqgpBRWJOL34QhoQORFPPrj4ge82ALaCdwmUHQuCtqaVbyMSQyrZa4djiTQAAzCzwInl6ltclmUoOXUJprA5UNoLF3vTWxZnRAfxDMgNbriVsih9UV27xMb1qynL+wEjJGIwiN/bMU9yWglLbVKkrNP41sCUmxfUt9f1xZzuZLv6J4CEpoFd2aUo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(6666004)(6486002)(6512007)(2906002)(26005)(186003)(6506007)(38100700002)(54906003)(478600001)(83380400001)(316002)(66946007)(66556008)(66476007)(4326008)(6916009)(41300700001)(8676002)(8936002)(7416002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?95In0x8DZI7tu5t0S0WOfxt+vSkkV2ugDf4kTn09dvwz9EaKFD25GUfK9kx6?=
 =?us-ascii?Q?qujQlsaVnYaLiNmaEXZ9Oipl0ijwT3KmbhLaQfwH3pdj6TTUXcSFJ7ataGzd?=
 =?us-ascii?Q?TpfRUR4KmaIqX1stUZnADeApC6M/ZCdgMrLIrnogi+41apwkT39yMtUTuIw2?=
 =?us-ascii?Q?jC0zvboSSGAxaIUbuu6oHZOdGieV+OsxNk3peH3hkImb1s7BAIPumWoNgNxo?=
 =?us-ascii?Q?PY3cNKuAWtWDsnREX653mOBcquTyO3VPE5E5kJmfaR95bvvF/YrO2Mmrlc+G?=
 =?us-ascii?Q?9zXN5J+bO6siBujGkCF1WTJVEGvAwYa42TLYcpPvUbOMpSCbBCk/l+/u+uIw?=
 =?us-ascii?Q?8Zo1/QkB+wC+viB6UrMgF1nZ/r5Wba3MEEuLCup4o8U2OZ4wTzdC2XQ7+NVl?=
 =?us-ascii?Q?nGqkElRghIINdSTYpR2iItEi9FLXr+eS/FfNEtxR3ApVuNzDLFMqFvOXoccw?=
 =?us-ascii?Q?iIqqday51W+x6UGYlWrXgsoFJP/T/ueK6zBET7pvDmUcsPvOylAEl2kBoits?=
 =?us-ascii?Q?grXananNAkFW9+hbYB9hdiQPAf9nUi0uMbyy1pnzpCLydjqelz/5WIX/5dKM?=
 =?us-ascii?Q?KNEbvtzjm4tKXEOn6zqngF3Fb+W83lTNdYAIcJi+JV7pYyYo9dTwh8WiZghZ?=
 =?us-ascii?Q?xT5qH9yA5wC+3hWX+dqKhx5qt+LklEk9alxCDEtddNMNrNG8S90SxmImpum+?=
 =?us-ascii?Q?RLMEqj0f/WrZlYLD7OjIhRnksq3g3iwNydbGl38j/UDQ41JwKX8EEzusKedJ?=
 =?us-ascii?Q?DvN1D8LdjmZo5ocU18+bNu/+h9qShvpruv4d9BYedOzIJUB366oLDQGegzM8?=
 =?us-ascii?Q?bRELfhjNlUziVDMNFSRUVAdUHv7cH6Y7ewY8/QWV/1D5qxjFpU7ouRz39IUy?=
 =?us-ascii?Q?KWtJgQmDDIiZEoJ20E2wrPit19cEA9oNtmNuhOZeTp45RNrcj8XIFcun9a0b?=
 =?us-ascii?Q?wRekLswhEHxfRMSLoAIl0fLmGLH8eW1T71teWgmDWvQp1bVzkhbJ/Ojwui8v?=
 =?us-ascii?Q?/6UarYi1Ke7AtFoIE9IaqPF3kacL+PfM8V4wlzWlOv3gsR0s2tXEg4RVYo0R?=
 =?us-ascii?Q?I5VN7VAqfdP+UmJ3TcSOE4mCh6V/LrKZKArOFV1g15HVH6nwbWavOv4XB6rr?=
 =?us-ascii?Q?+aYqnV+NfuIqdKNbxg7TBHyQdEVmU09czkacZaD8XyUEBGxkc05ag3Jbcmz8?=
 =?us-ascii?Q?cq3UTJZMLsv87gHMmZ/HkmcfuKYwob5IZCQPWbJtVuhN2WWSbCQO3u+7zNBf?=
 =?us-ascii?Q?ZxiV6IYZ/zgdIDOxJwpznhH1gKadrTJs1Q+2jtlhEQGldSshyDChJ8QDkdz4?=
 =?us-ascii?Q?aoFz99yJiVGHZFasoqB1ghuTXFb3gX/sdSu+qvalNQ4qOEbBScBPSq4qDrxh?=
 =?us-ascii?Q?rxQwbXV++l+AzD1RaZAgipdOz6INotzLBgkNzEu6Xr3GlP8Jwwb5zGsNmfUB?=
 =?us-ascii?Q?Wv/iHulAkTQoRyGVMjstuEVZnkTMQOmhs3VXxXAfjJnKXU22xwY3c4YafHf9?=
 =?us-ascii?Q?T4I6gmjHVGv1ikLhC4Xq086PVGovpFBEHk6LccAWmAp7b19fX8G0b90T49gn?=
 =?us-ascii?Q?nCRFnX9/DTdFpAyzhjUSTtIbimxWkeLpifgzCLDf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c0f596-ed16-46ca-14de-08db925dcd13
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 07:06:17.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuPryMXNDnBetBmlfKm8NYSjjsvbzJtD17SsgEKIz3rnfygFaODw+DMGR5Rt5wEcTwLSEjQHCvSdi8ao4FHSiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On Fri, Jul 28, 2023 at 02:13:08PM +0200, Thomas Gleixner wrote:
> Topology evaluation is a complete disaster and impenetrable mess. It's
> scattered all over the place with some vendor implementatins doing early
> evaluation and some not. The most horrific part is the permanent
> overwriting of smt_max_siblings and __max_die_per_package, instead of
> establishing them once on the boot CPU and validating the result on the
> APs.
> 
> The goals are:
> 
>   - One topology evaluation entry point
> 
>   - Proper sharing of pointlessly duplicated code
> 
>   - Proper structuring of the evaluation logic and preferences.
> 
>   - Evaluating important system wide information only once on the boot CPU
> 
>   - Making the 0xb/0x1f leaf parsing less convoluted and actually fixing
>     the short comings of leaf 0x1f evaluation.
> 
> Start to consolidate the topology evaluation code by providing the entry
> points for the early boot CPU evaluation and for the final parsing on the
> boot CPU and the APs.
> 
> Move the trivial pieces into that new code:
> 
>    - The initialization of cpuinfo_x86::topo
> 
>    - The evaluation of CPUID leaf 1, which presets topo::initial_apicid
> 
>    - topo_apicid is set to topo::initial_apicid when invoked from early
>      boot. When invoked for the final evaluation on the boot CPU it reads
>      the actual APIC ID, which makes apic_get_initial_apicid() obsolete
>      once everything is converted over.
> 
> Provide a temporary helper function topo_converted() which shields off the
> not yet converted CPU vendors from invoking code which would break them.
> This shielding covers all vendor CPUs which support SMP, but not the
> historical pure UP ones as they only need the topology info init and
> eventually the initial APIC initialization.
> 
> Provide two new members in cpuinfo_x86::topo to store the maximum number of
> SMT siblings and the number of dies per package and add them to the debugfs
> readout. These two members will be used to populate this information on the
> boot CPU and to validate the APs against it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/topology.h       |   19 +++
>  arch/x86/kernel/cpu/Makefile          |    3 
>  arch/x86/kernel/cpu/common.c          |   23 +---
>  arch/x86/kernel/cpu/cpu.h             |    6 +
>  arch/x86/kernel/cpu/debugfs.c         |   37 ++++++
>  arch/x86/kernel/cpu/topology.h        |   32 +++++
>  arch/x86/kernel/cpu/topology_common.c |  187 ++++++++++++++++++++++++++++++++++
>  7 files changed, 290 insertions(+), 17 deletions(-)
> 
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -102,6 +102,25 @@ static inline void setup_node_to_cpumask
>  
>  #include <asm-generic/topology.h>
>  
> +/* Topology information */
> +enum x86_topology_domains {
> +	TOPO_SMT_DOMAIN,
> +	TOPO_CORE_DOMAIN,
> +	TOPO_MODULE_DOMAIN,
> +	TOPO_TILE_DOMAIN,
> +	TOPO_DIE_DOMAIN,
> +	TOPO_PKG_DOMAIN,
> +	TOPO_ROOT_DOMAIN,
> +	TOPO_MAX_DOMAIN,
> +};
> +

[..snip..]

> +static void topo_set_ids(struct topo_scan *tscan)
> +{
> +	struct cpuinfo_x86 *c = tscan->c;
> +	u32 apicid = c->topo.apicid;
> +
> +	c->topo.pkg_id = topo_shift_apicid(apicid, TOPO_ROOT_DOMAIN);

Shouldn't this use TOPO_PKG_DOMAIN instead of TOPO_ROOT_DOMAIN ?


> +	c->topo.die_id = topo_shift_apicid(apicid, TOPO_DIE_DOMAIN);
> +
> +	/* Relative core ID */
> +	c->topo.core_id = topo_relative_domain_id(apicid, TOPO_CORE_DOMAIN);
> +}
> +

--
Thanks and Regards
gautham.

