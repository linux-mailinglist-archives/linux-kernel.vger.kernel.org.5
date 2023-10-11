Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5CD7C5009
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjJKKZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJKKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:25:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F8EB0;
        Wed, 11 Oct 2023 03:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD2wsXk4ZP6QS0Ku1RG8uxMcebFl6XThy5GcC/vdtsWs1uj2KONJOIAe7Rcl2KQRj8fTxrFE62mj4yiFedCV8bG+Wefhhe9VEdSreBQczbAQstNwhqQUV+j/gct8iNEETvtF2fogCMK5PF9Dxgzw0AeHbS7KpS7ELrcfhiF7R4HoKcrGqbxPByEG7umtxpTt2k+NJ31SxsOX3wQUes+X9vqBURcwNo4LABAW2BfotG30NJsYnPCMOVg12I9xVZqJScq9OtgHDGNK+tP7c3bPZ5dsopGoBF47WzBqVWMFKfmMNBHhWzRvJTVUK1u5v9cEIxJQEXhc02sAaJnun0BbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voEMFhJnHcGQ07j4XBjVpP30ULPoCWKqrt6snntFwQ0=;
 b=J/ie7jPiwBe0KEe4/oWEw66pYg4KoCl0P1bP7upELpc/3QfcRfK4qWtGeWl/icMFsd5zdmr+7aeURotF2GJVlQy+m4LfmUJzxHX0PwN9B5xqT4wkvu82ejuH30IfjZGSkyGMJ+285jKpHeTzUXfIWqYeVw9qXWy//DzoZ0YJVAROMJJofOmRbyLpbYc61DMrn1Euh1UYxgrt4mpCFdln/Q3yw7TxJ1qbbvTGCk3OIY+56jaIiG20/umWBnkni8d46qDGvSoJE2e+5yDaD9dDqdWatIBRzCP2rqA+r3HOLSmzUe75W10gS4QIZfeRKsMf7WEFUuLMC+KNCbMgiGEK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voEMFhJnHcGQ07j4XBjVpP30ULPoCWKqrt6snntFwQ0=;
 b=qKfSB51cqavwVi1LX/aHHO1AQ3/Jz3Y3UAhS0ctyu+7CA5NAh4Ctb+NjCWJsAyRt4I7aDVzfEB2Wsj2PySqCOVwKeNo2jR9KFebJwxpxzUy9p8vZrZz9WJt+OV+Nddyo9GdNwc78zHAQr/rCtEDsrldqe5tCabDHBv6jhS3C4a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 10:25:42 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%7]) with mapi id 15.20.6863.041; Wed, 11 Oct 2023
 10:25:41 +0000
Date:   Wed, 11 Oct 2023 13:25:36 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org,
        Roger Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net-next v4] net: ti: icssg_prueth: add TAPRIO offload
 support
Message-ID: <20231011102536.r65xyzmh5kap2cf2@skbuf>
References: <20231006102028.3831341-1-danishanwar@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231006102028.3831341-1-danishanwar@ti.com>
X-ClientProxiedBy: VE1PR08CA0033.eurprd08.prod.outlook.com
 (2603:10a6:803:104::46) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e5b2cf-3583-4fe5-521e-08dbca446bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0YEPJjYEjaMHiagPzLxOms33ngF4EKv8y1NZfKcSIfIjrRNLisWHa/ysrWb+K5a4SWR7bIOPg3TL6zvXXpS4Pf9X48gD/9NDxCYAfDVxikXRjFuvHGdCb2AHgABTFkRPgcSxYSz2y6YkG98o1DdFylfR0kKw1MtBvwERLP9dor+WaaN+DLDYyIvHTdhjuZNUv7TabwRdiz8Uur+4ez9dP/eLbMvMFOpuk6DPe/QyhI6ZQQPMyDnipKMKH2Yx34k/xYYvSry4fJFkssCn564QA1YSiqHuKelGd1i5o2qH/DiIkAsMlSdC2UHT8A51utq9Huu9ShXrzLzr7OVSHzcwmnM8hXMEqSAmktkkHixJsY5P4JwYXvYUPPqDZGKHGhijaOZvL2hpSu7AwM8fm8LiecAF5Ff3dh7JIP9UusuLv8g07OQdzGbo4SFmXculxGjqqD4GbU7QU3CRf+igq/pvXmsOvuV+Lxlcdf/RuLphUeFhpdl9ub4rtGazUdh0AvH18E/dMOJB1tWPonfgVUEDPhBVKBfoE9mcutrfRbE1G8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(1076003)(6512007)(9686003)(38100700002)(86362001)(44832011)(83380400001)(7416002)(2906002)(30864003)(6486002)(966005)(6666004)(478600001)(4326008)(6506007)(8676002)(26005)(8936002)(6916009)(66476007)(316002)(41300700001)(33716001)(66556008)(54906003)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmpJZFNpSWpSTEpzemd0RjdWdlF2S0xpN2RZeHV3VFJSNmptUTZHUTh3bCtH?=
 =?utf-8?B?N2xKdjFRSFVQQldMMjNlcnZtYnlzZktDd0hUM0l5S0ZlTUVhRWtrd2JIYWdt?=
 =?utf-8?B?TnA3c09oTlZFT3JtZWl1WldxY29uZE5lS3lCR0NabVlLaWxWdXNPejRiQ0M0?=
 =?utf-8?B?azFqUDh6SEFkekpVVGpMdGlVYW01WVF5UjcwSWhFR0kyTUNydTc2V2VwWDQv?=
 =?utf-8?B?Z3JkVzJZNjFiWE1BeTIvOEVUTXRqanFqVGJXQTFBVVBhTzBGMDk1VTg2RlR2?=
 =?utf-8?B?TEQzTzN2ZWJ2dnRESnVlT25FNnVyZmF1Mk9uN016em00dFZQdjdSZ1dSemY1?=
 =?utf-8?B?VWRoV1Z0VVF4VUhhUEx4ZUVuZFNWb0w4b2J6b3U2dDVEVzZOaTRDcUVZVkhj?=
 =?utf-8?B?TnJrTHdkQ29lMm9qcVU5WllxUjdLM2twYjJwcWVxRTZuL3puUmpxQ1dJQzBa?=
 =?utf-8?B?UFFxdzRVWlFHMkNiaEx3KzJKcEhzbnJkZlBhSjh5QXIxY2w1N0RaOE82TUJR?=
 =?utf-8?B?SVBuT05KZGxpVjlnRFVzU0NhdDVnazVvbkFRS0R6c0pJZ1Q4VVZoQ0VrZitN?=
 =?utf-8?B?OFlDMitoQWQwOTlZK3Z3MlArSDlKaDZEeDZaekc5dGRuWTBrdEZrcGFXSE0w?=
 =?utf-8?B?SzVrMXFGMFdGa0VNcmRDT29JVFNlamRqUURuUDNoOUcwZ3lybDc0djIrY2NP?=
 =?utf-8?B?UElpcHhaK3dXZk9LZStPb1BaUE5OTHc4WGEyQUppVmtXQjNHMlFvU0Y3N2ZP?=
 =?utf-8?B?WU9qZlR0cEFIc3lmL1UxVk41S2lDTnBqZ3VxYVVVQUF4aGREMTFDWnBZdXF5?=
 =?utf-8?B?MHA0blZWWTJ4YU5TOTR3NEtReW1QSXNKU1hieWx1U0pxcmZRWU5kOEVoZHZT?=
 =?utf-8?B?MDdPUWozdS9WREJFbkhRYVhFUHU5VzRYK3BnSjcyZUx6S1ovNW8xdE0zMUJ3?=
 =?utf-8?B?ZEFQNFVJdEhjV3ozSmZucEVxNEU2L1g0ZTdVWFFET1lYdk5rRkYwaGdmck5h?=
 =?utf-8?B?czhuVGV4b0I1b2tJTEFOV3NONUg0b1RzWXgzK0g3M1VqaklXcGZLVjdNNDky?=
 =?utf-8?B?cGVuc05nOEtXWGNaZGtqcUhHWHd0S2duUjZJMlNMUFJIdmdZSFlXNHpwN0lR?=
 =?utf-8?B?YTQxWUNvT1hIaDFRT0RTSnlqOHU1UlA3cVZZZGhMcGJvNWN6RkFmbTNlMmly?=
 =?utf-8?B?UEJ2OVFyWE9mVGRQRy90cGx2Q3dxK29kRytmRXlrTlp1bE12cHMyREpvTHhy?=
 =?utf-8?B?R3ZsbGlLakpqcjFsdHFvcENSdGJyUnRQOVZvVENGM1NSRkU3alFTTkZQYnNZ?=
 =?utf-8?B?U251NHQxYTIyVjhGNDZPcE8wMlRENHdDbWFVV01rVXh3RG5NU1Nrd1Y0SkF6?=
 =?utf-8?B?ZTFPWHlmTVRBSHRhdHJueTFvak5lcHNJWEJFSFFXcFZoaGRpc3ZHejdpbnln?=
 =?utf-8?B?RHluQ3NZZkhpUXNtMHFmc2RRYkNQbnU1OUtBdVdFblV0MG94ZW1QaGMrNXJT?=
 =?utf-8?B?Q05nOFBuY1lWWWVjVnozLzBWQTFocXQ4RkwwTnFtVklKbjBrSkFKSjZKaEln?=
 =?utf-8?B?YTFSU1VoeCt1WVoydDhGbGVVVW04d25NL0xUMGJqUnpTdURrZ2ttY0dDaEVL?=
 =?utf-8?B?VjlCazZmM0NuT0YyaFRCR0U3dW9CMExnaWcwY0I0dDJaK3hTUmFWVm5zbUp6?=
 =?utf-8?B?elBjOS9vc0FEVUZWdTNaZy9jalZNNnN6ekN4MzZtb3p6RzhacHJENyszOWZn?=
 =?utf-8?B?d3JOSG13bUgrUCtTQ3FicEswdTNQZ0taTjRTRzdrYnBJMytMSis0ZlJIRjZu?=
 =?utf-8?B?dFNqTG5adThrOGV3VHJkRXJacjF3Z3FYRGRzSkRsUG1GKzRlL1dCOW1XcmRB?=
 =?utf-8?B?REJLNFQ2aDBweXYzWHJVbHlPMXVQM1VsbThqczJvc0dqVjBBOFloTTJoVnM3?=
 =?utf-8?B?YkwrTmVKN2p6VHdlZTFSN2V1RVd2M3BXTVpWcFJ1TTRoZzVxc0d3ZVo3NVpC?=
 =?utf-8?B?ellLbW5KMmhzQy9XZEt6bFZVeitDODEwbm8rWURIb2ZvUGxDcHpkdk1keUJO?=
 =?utf-8?B?NTU2eXh1QmtZc2lHeUhkSllrd0tCMFUva1N5aGxESVkxWVY5bGk1WlFMZzIx?=
 =?utf-8?B?alFQaHJORGIyRGhuU1M0SkpDcVMxd25ReHoyUkJBRWxySlJTcHFpR2g5UDBq?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e5b2cf-3583-4fe5-521e-08dbca446bba
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 10:25:41.9069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkpD0KSt/k/U29xVfZTGxTAjp30nDQmA0pLzkdEijZAfCuoC4/HMflCp3T7oJ/k3kkut6Mi54g3AC0v+VBxvbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 03:50:28PM +0530, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
> configuration. EST allows express queue traffic to be scheduled
> (placed) on the wire at specific repeatable time intervals. In
> Linux kernel, EST configuration is done through tc command and
> the taprio scheduler in the net core implements a software only
> scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
> user indicate "flag 2" in the command which is then parsed by
> taprio scheduler in net core and indicate that the command is to
> be offloaded to h/w. taprio then offloads the command to the
> driver by calling ndo_setup_tc() ndo ops. This patch implements
> ndo_setup_tc() to offload EST configuration to ICSSG.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> 
> Changes from v3 to v4:
> *) Rebased on the latest next-20231005 linux-next.

The tree that the patch will be applied to is
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git,
not linux-next.

> *) Addressed Roger and Vinicius' comments and moved all the validations to
>    emac_taprio_replace() API.
> *) Modified emac_setup_taprio() API to use switch case based on taprio->cmd
>    and added emac_taprio_destroy() and emac_taprio_replace() APIs.
> *) Modified the documentation of structs / enums in icssg_qos.h by using
>    the correct kdoc format.
> 
> Changes from v2 to v3:
> *) Rebased on the latest next-20230928 linux-next.
> *) Retained original authorship of the patch.
> *) Addressed Roger's comments and modified emac_setup_taprio() and
>    emac_set_taprio() APIs accordingly.
> *) Removed netif_running() check from emac_setup_taprio().
> *) Addressed Vinicius' comments and added check for MIN and MAX cycle time.
> *) Added check for allocation failure of est_new in emac_setup_taprio().
> 
> Changes from v1 to v2:
> *) Rebased on the latest next-20230921 linux-next.
> *) Dropped the RFC tag as merge window is open now.
> *) Splitted this patch from the switch mode series [v1].
> *) Removed TODO comment as asked by Andrew and Roger.
> *) Changed Copyright to 2023 as asked by Roger.
> 
> v3: https://lore.kernel.org/all/20230928103000.186304-1-danishanwar@ti.com/
> v2: https://lore.kernel.org/all/20230921070031.795788-1-danishanwar@ti.com/
> v1: https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/
> 
>  drivers/net/ethernet/ti/Makefile             |   3 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   6 +
>  drivers/net/ethernet/ti/icssg/icssg_qos.c    | 301 +++++++++++++++++++
>  drivers/net/ethernet/ti/icssg/icssg_qos.h    | 113 +++++++
>  5 files changed, 426 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
>  create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h
> 
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index 34fd7a716ba6..0df60ded1b2d 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -37,5 +37,6 @@ icssg-prueth-y := k3-cppi-desc-pool.o \
>  		  icssg/icssg_config.o \
>  		  icssg/icssg_mii_cfg.o \
>  		  icssg/icssg_stats.o \
> -		  icssg/icssg_ethtool.o
> +		  icssg/icssg_ethtool.o \
> +		  icssg/icssg_qos.o
>  obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 6635b28bc672..89c301716926 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1166,7 +1166,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
>  	return 0;
>  }
>  
> -static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
>  {
>  	u32 hi_rollover_count, hi_rollover_count_r;
>  	struct prueth_emac *emac = clockops_data;
> @@ -1403,6 +1403,8 @@ static int emac_ndo_open(struct net_device *ndev)
>  		napi_enable(&emac->tx_chns[i].napi_tx);
>  	napi_enable(&emac->napi_rx);
>  
> +	icssg_qos_tas_init(ndev);

I believe the intention is for this code to be run before any taprio
offload is added, correct? But it is possible for the user to add an
offloaded Qdisc even while the netdev has not yet been brought up.
Is that case handled correctly, or will it simply result in NULL pointer
dereferences (tas->config_list)?

> +
>  	/* start PHY */
>  	phy_start(ndev->phydev);
>  
> @@ -1669,6 +1671,7 @@ static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_set_rx_mode = emac_ndo_set_rx_mode,
>  	.ndo_eth_ioctl = emac_ndo_ioctl,
>  	.ndo_get_stats64 = emac_ndo_get_stats64,
> +	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
>  };
>  
>  /* get emac_port corresponding to eth_node name */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 8b6d6b497010..7cbf0e561905 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -37,6 +37,7 @@
>  #include "icssg_config.h"
>  #include "icss_iep.h"
>  #include "icssg_switch_map.h"
> +#include "icssg_qos.h"
>  
>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
>  #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
> @@ -174,6 +175,8 @@ struct prueth_emac {
>  
>  	struct pruss_mem_region dram;
>  
> +	struct prueth_qos qos;
> +
>  	struct delayed_work stats_work;
>  	u64 stats[ICSSG_NUM_STATS];
>  };
> @@ -285,4 +288,7 @@ u32 icssg_queue_level(struct prueth *prueth, int queue);
>  void emac_stats_work_handler(struct work_struct *work);
>  void emac_update_hardware_stats(struct prueth_emac *emac);
>  int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
> +
> +u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
> +
>  #endif /* __NET_TI_ICSSG_PRUETH_H */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> new file mode 100644
> index 000000000000..c8c4450c41bb
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Texas Instruments ICSSG PRUETH QoS submodule
> + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include <linux/printk.h>
> +#include "icssg_prueth.h"
> +#include "icssg_switch_map.h"
> +
> +static void tas_update_fw_list_pointers(struct prueth_emac *emac)
> +{
> +	struct tas_config *tas = &emac->qos.tas.config;
> +
> +	if ((readb(tas->active_list)) == TAS_LIST0) {
> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST0;
> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST1;
> +	} else {
> +		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST1;
> +		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST0;
> +	}
> +}
> +
> +static void tas_update_maxsdu_table(struct prueth_emac *emac)
> +{
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	u16 __iomem *max_sdu_tbl_ptr;
> +	u8 gate_idx;
> +
> +	/* update the maxsdu table */
> +	max_sdu_tbl_ptr = emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
> +
> +	for (gate_idx = 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++)
> +		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx]);
> +}
> +
> +static void tas_reset(struct prueth_emac *emac)
> +{
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	int i;
> +
> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
> +		tas->max_sdu_table.max_sdu[i] = 2048;
> +
> +	tas_update_maxsdu_table(emac);
> +
> +	writeb(TAS_LIST0, tas->active_list);
> +
> +	memset_io(tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
> +	memset_io(tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
> +}
> +
> +static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
> +{
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	int ret;
> +
> +	if (tas->state == state)
> +		return 0;
> +
> +	switch (state) {
> +	case TAS_STATE_RESET:
> +		tas_reset(emac);
> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
> +		tas->state = TAS_STATE_RESET;
> +		break;
> +	case TAS_STATE_ENABLE:
> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
> +		tas->state = TAS_STATE_ENABLE;
> +		break;
> +	case TAS_STATE_DISABLE:
> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
> +		tas->state = TAS_STATE_DISABLE;
> +		break;
> +	default:
> +		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret)
> +		netdev_err(emac->ndev, "TAS set state failed %d\n", ret);
> +	return ret;
> +}
> +
> +static int tas_set_trigger_list_change(struct prueth_emac *emac)
> +{
> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	struct ptp_system_timestamp sts;
> +	u32 change_cycle_count;
> +	u32 cycle_time;
> +	u64 base_time;
> +	u64 cur_time;
> +
> +	if (admin_list->cycle_time < TAS_MIN_CYCLE_TIME)
> +		return -EINVAL;

Shouldn't this verification have been part of emac_taprio_replace(), and
have a proper extack?

> +
> +	cycle_time = admin_list->cycle_time - 4; /* -4ns to compensate for IEP wraparound time */

Details? Doesn't this make the phase alignment of the schedule diverge
from what the user expects?

> +	base_time = admin_list->base_time;
> +	cur_time = prueth_iep_gettime(emac, &sts);
> +
> +	if (base_time > cur_time)
> +		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
> +	else
> +		change_cycle_count = 1;

I see that the base_time is only used to calculate the number of cycles
relative to cur_time. Taprio users want to specify a basetime value
which indicates the phase alignment of the schedule. This is important
when the device is synchronized over PTP with other switches in the
network. Can you explain how is the basetime taken into consideration in
your implementation?

> +
> +	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
> +	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
> +	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
> +
> +	/* config_change cleared by f/w to ack reception of new shadow list */
> +	writeb(1, &tas->config_list->config_change);
> +	/* config_pending cleared by f/w when new shadow list is copied to active list */
> +	writeb(1, &tas->config_list->config_pending);
> +
> +	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
> +}
> +
> +static int tas_update_oper_list(struct prueth_emac *emac)
> +{
> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
> +	struct tas_config *tas = &emac->qos.tas.config;
> +	u32 tas_acc_gate_close_time = 0;
> +	u8 idx, gate_idx, val;
> +	int ret;
> +
> +	if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)
> +		return -EINVAL;
> +
> +	tas_update_fw_list_pointers(emac);
> +
> +	for (idx = 0; idx < admin_list->num_entries; idx++) {
> +		writeb(admin_list->entries[idx].gate_mask,
> +		       &tas->fw_shadow_list->gate_mask_list[idx]);
> +		tas_acc_gate_close_time += admin_list->entries[idx].interval;
> +
> +		/* extend last entry till end of cycle time */
> +		if (idx == admin_list->num_entries - 1)
> +			writel(admin_list->cycle_time,
> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
> +		else
> +			writel(tas_acc_gate_close_time,
> +			       &tas->fw_shadow_list->win_end_time_list[idx]);
> +	}
> +
> +	/* clear remaining entries */
> +	for (idx = admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
> +		writeb(0, &tas->fw_shadow_list->gate_mask_list[idx]);
> +		writel(0, &tas->fw_shadow_list->win_end_time_list[idx]);
> +	}
> +
> +	/* update the Array of gate close time for each queue in each window */
> +	for (idx = 0 ; idx < admin_list->num_entries; idx++) {
> +		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
> +		for (gate_idx = 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
> +			u8 gate_mask_list_idx = readb(&tas->fw_shadow_list->gate_mask_list[idx]);
> +			u32 gate_close_time = 0;
> +
> +			if (gate_mask_list_idx & BIT(gate_idx))
> +				gate_close_time = readl(&tas->fw_shadow_list->win_end_time_list[idx]);
> +
> +			writel(gate_close_time,
> +			       &tas->fw_shadow_list->gate_close_time_list[idx][gate_idx]);
> +		}
> +	}
> +
> +	/* tell f/w to swap active & shadow list */
> +	ret = tas_set_trigger_list_change(emac);
> +	if (ret) {
> +		netdev_err(emac->ndev, "failed to swap f/w config list: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for completion */
> +	ret = readb_poll_timeout(&tas->config_list->config_change, val, !val,
> +				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
> +	if (ret) {
> +		netdev_err(emac->ndev, "TAS list change completion time out\n");
> +		return ret;
> +	}
> +
> +	tas_update_fw_list_pointers(emac);
> +
> +	return 0;
> +}
> +
> +static void emac_cp_taprio(struct tc_taprio_qopt_offload *from,
> +			   struct tc_taprio_qopt_offload *to)
> +{
> +	int i;
> +
> +	*to = *from;
> +	for (i = 0; i < from->num_entries; i++)
> +		to->entries[i] = from->entries[i];
> +}
> +
> +static int emac_taprio_replace(struct net_device *ndev,
> +			       struct tc_taprio_qopt_offload *taprio)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct tc_taprio_qopt_offload *est_new;
> +	int ret, idx;
> +
> +	if (taprio->cycle_time_extension) {
> +		netdev_err(ndev, "Failed to set cycle time extension");

"failed" implies that the driver tried to do something, but it didn't work.
Maybe "Cycle time extension not supported"? Also, NL_SET_ERR_MSG_MOD().

> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (taprio->num_entries == 0 ||

Cannot happen. See sch_taprio.c:

	if (new_admin->num_entries == 0) {
		NL_SET_ERR_MSG(extack, "There should be at least one entry in the schedule");
		err = -EINVAL;
		goto free_sched;
	}

> +	    taprio->num_entries > TAS_MAX_CMD_LISTS) {
> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "unsupported num_entries %ld in taprio config\n",
> +				       taprio->num_entries);

Better to say what's the hardware maximum, than to report back num_entries
as being not supported.

> +		return -EINVAL;
> +	}
> +
> +	/* If any time_interval is 0 in between the list, then exit */
> +	for (idx = 0; idx < taprio->num_entries; idx++) {
> +		if (taprio->entries[idx].interval == 0) {
> +			NL_SET_ERR_MSG_MOD(taprio->extack, "0 interval in taprio config not supported\n");
> +			return -EINVAL;
> +		}
> +	}

Also not possible, see fill_sched_entry()

	/* The interval should allow at least the minimum ethernet
	 * frame to go out.
	 */
	if (interval < min_duration) {
		NL_SET_ERR_MSG(extack, "Invalid interval for schedule entry");
		return -EINVAL;
	}

> +
> +	if (emac->qos.tas.taprio_admin)
> +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
> +
> +	est_new = devm_kzalloc(&ndev->dev,
> +			       struct_size(est_new, entries, taprio->num_entries),
> +			       GFP_KERNEL);
> +	if (!est_new)
> +		return -ENOMEM;

You don't need to allocate est_new, you can keep a reference on taprio
using taprio_offload_get(), and call taprio_offload_put() to release the
reference when you're done with it.

> +
> +	emac_cp_taprio(taprio, est_new);
> +	emac->qos.tas.taprio_admin = est_new;
> +	ret = tas_update_oper_list(emac);
> +	if (ret)
> +		return ret;
> +
> +	ret =  tas_set_state(emac, TAS_STATE_ENABLE);
> +	if (ret)
> +		devm_kfree(&ndev->dev, est_new);
> +
> +	return ret;
> +}
