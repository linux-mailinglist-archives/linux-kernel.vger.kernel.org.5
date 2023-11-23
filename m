Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704D67F5A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjKWIyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:54:18 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4792;
        Thu, 23 Nov 2023 00:54:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INYAZCI8uPXka7LbbRKsiZRrG8hiLi3eooRHZse8KNRTqBDoz70dAxgLgsCh6hXCIGOWp7EZtV3TgJ0z62Ot8tN1ZI1MwBavLT0dL+lYwMSTr/cBs21MU3TWfl83rn4DyA1kOgQl+9xaOA48mTCQUN0hSDBql1XvudWxM+ghMEu5Ql5Qi+RUPofVq0kj21w3vo3WlqaRFZuvEHUssiCrhvrpv6p2c7HtIs/kc/NhmmbRsTLLGrA9cgn0EZ685iG8/xA5iQmlbjtNw7ySEYpAybOc88EreVkg4vcjmVStmfV34gPV2PU4w6w4A01lPspJXalKeFAD3wecrgkDUNbbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gl0riZWCAde+rOOZY74WDBH0mXlu1QWiowkdklUDLBM=;
 b=NX3WU4NKxXmibwosjgeNw1xwEzDTnP3csQP7jtrAP5ygBpVhxhGhSoX9nNJbA+VbpjaRozew+9ccb8RibOUKAxeYaRpvMpXHEoK7l+CJ72eUGWhdXcki2cxC5kewZZGxs32OU4sqYWutROucwXy9hjINIxFi0gr99mtSsnDkFZSYuVLEpG48gnrgon2oC1CzZqI01Nr30UADBtBTY1ZMR/kg2Bs3TV5nQJKYv6UX92XgXfeCTWJ66N1z+JXUBNitPtF4f5vIbXHl9sZJD5bNtTF5G1G/84bNvdGL0vDk+arIryeatZZzneg/vom+U1U8ZJD3qb8rLrV5kvZlMyslEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl0riZWCAde+rOOZY74WDBH0mXlu1QWiowkdklUDLBM=;
 b=UirRGr1weHkkHAWuVsp7mg8g3/L28wQWkhC9lUsBLixmiCyKKzYoiE13EeL+G4ZJApW81UNbw/KSDdX+AOfrZDtaILB9aYFbew2mCsfRN0ok7Lt4CmXTF8e6VRC8s9xIrZesx71R0GoS2Gg4/YtR7wTkajk9uRUF6qBsoBcMQ74=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Thu, 23 Nov
 2023 08:54:22 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::581a:5593:3e24:1ee4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::581a:5593:3e24:1ee4%7]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 08:54:21 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpufreq/amd-pstate: Fix the return value of
 amd_pstate_fast_switch()
Thread-Topic: [PATCH] cpufreq/amd-pstate: Fix the return value of
 amd_pstate_fast_switch()
Thread-Index: AQHaHecR1ahp667F60iiBg0s6iMe+LCHl6RA
Date:   Thu, 23 Nov 2023 08:54:21 +0000
Message-ID: <CYYPR12MB86558615B2691F77DEFEE7319CB9A@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20231123082757.3527-1-gautham.shenoy@amd.com>
In-Reply-To: <20231123082757.3527-1-gautham.shenoy@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=18f429a5-f2c3-411f-a1d7-cdf55b2eeb08;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-23T08:47:43Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB6731:EE_
x-ms-office365-filtering-correlation-id: 5ac421a3-b2fc-4426-f1c3-08dbec01c8d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wVZAMQAGDHSIZ1oy2d2WTZVQUmFq6yqrY2vf6GMzEQXw5nQSxFy1flNhtro63SmDIjIOwiNadMmPceYsJfI2IUkSe9n/7ib0FLpgdXzSRc9mO7e7sOPNWhAIKt7dOwFUsBXC/Wr2O0mZ2TjLwmelII4lwpyKRfVsTvefrmTcPKNwtg2mVioMPmDoOPnWbKiXjVM7Vhhg/6vZSUwZGlFgPEPuW7n3U3h2i9KR8AfkhBq/tFYq1x4V2/RPgnRekvZXsGiuWtt1lMyTUzZ76tdUneiTe1Y0mqbwN4KEorSWMULbJJoBc4o6rXyQxfYykgx0XtQXcsNt+cWyBuIbYy5r1pG7KgN9IoVzX/XDYQrJ0Tdfs9yJmtfuKGlX72osn2wjYj4kH2Daob4vQdNsrunyNlfLBvXnOtDChbf/UGXVyj7xTw7pBcPJosIrleEXenV6A3EJa0jAyTpsJpNmZrqYe5+hHxfjBsVJEVgTAHcLSbZZVSCMR17E8SiOHEKJtU7dXURWQzkR13ysTajlsFGvQ+2XNCpYbKVCU987rzE8kw3vEY735H42YAlR6q2i1jabBcEeUycYtC4+ysDx06OMSdB9+ZcJ9cI6ZbS6Zbv4Zbq2609YujE86gThHFWUoE/HUeI/IMxqpGvvazdvpBCrFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8676002)(2906002)(71200400001)(86362001)(6506007)(66556008)(7696005)(26005)(53546011)(8936002)(9686003)(66446008)(316002)(66476007)(54906003)(76116006)(64756008)(110136005)(4326008)(66946007)(33656002)(122000001)(478600001)(38100700002)(83380400001)(5660300002)(38070700009)(52536014)(921008)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qSuLNeSE7YEYTDP4Y0eDXJLnvw0FuBNo4g1zqfH+1FI9HNwL0aBETaxwe7i8?=
 =?us-ascii?Q?/bXqCqorHT4Iu75K8AjF5Ykp/FUu7wiPd/bxu0pzvlJv1u1dw4oTz/zRSq5P?=
 =?us-ascii?Q?pRBMqe8rYz4goHlNoBOI5DN7oywc7QNNeSS7K1UmpyL0TDsLmJ9mFKxKu1jL?=
 =?us-ascii?Q?B0sDePTk7Juy4zX+KEJAc5mNaesmlhXxij5YvazV2KgeBh4jnfXmGsAA+BkX?=
 =?us-ascii?Q?z6RLFKoaIj2mXufc+U8EJJjVf/RFiQTDTGoVbJ3M6/7O804qtvQcpVIm8fxM?=
 =?us-ascii?Q?lRi5F2JtO532BW6iYNkKRnzss7fgS1TQFm9h6aQJH7qUaHd4Mf1fGYtPXOHZ?=
 =?us-ascii?Q?EV4QRIO3aAZDO30UQXmSsHOnQGAPSlwpVwG9IUAqo6roOwh0r88IiPgezjj+?=
 =?us-ascii?Q?sNI6JdHgP+tG9Qh37+Az9NwD0RP+pKYKoGXfbQjy23XYov4RJvDieTL7U9ia?=
 =?us-ascii?Q?fhpgHYVZs14DnMWLO3KzSM54H0hnLEJyvtce4WHp8/vcw1WHc5lukysC0xnj?=
 =?us-ascii?Q?6gvj88ZOA+mk4qQyGhzGGqwxRQRGcjU4pJ4Ww3VgqPVwbbkpQ/cu3acM6VtK?=
 =?us-ascii?Q?zAMq5hp7DX4RCdGzpm+q3+GhtRTC+4k2NE4eNOUsblgOvzSmI/BS12pfC4Pz?=
 =?us-ascii?Q?KISqns004ZGYVH9LhcV8ygTVW/aNgfPNSg2R+y5Qise+pDtuAvexdPOTl1rK?=
 =?us-ascii?Q?cpYWqs89G6kCDQTw/k/U3qW9xfOK4JyMToQoMAs2Ei4CYHkTX6sYRgsOmaaA?=
 =?us-ascii?Q?Jj9mdyEErt9sdtEAqrKAzSjwueLcbWxfgUIKPkxtak7jgia40q4vpl1ksBj1?=
 =?us-ascii?Q?4CwpLvRuEUYmUbz8Rs1LARyPj0LuNevqjSgXkJxKvm5QqqLMII7MQzmwpTVE?=
 =?us-ascii?Q?y5qrCpDHjupo1YDkEZZiZqslsGRqFjZCtgqTAAueU1JE7m0Ck/OokAJ889sc?=
 =?us-ascii?Q?hxq8alfzhc1h5W2Kd7NZeEWxLWqOKCDJaWW2+WP7Akj7Df2oyFdXCn0qZy4c?=
 =?us-ascii?Q?I91cCLgFrwGmxg1fZPlvaymiuC6IXdcmiIRR5uXbEdfCLlzQ8vHDq8JHBVSa?=
 =?us-ascii?Q?JCkXvw0kpiQ29XUSu/U+Q6dZHoMyWebQYXARcjHpVmF3TZ1WpwKPU/HY+QOG?=
 =?us-ascii?Q?DHOZWQnci7EIkztYaub1a8qSzjyZZF8Eub9Q6Kqpcz3VKVV6uVHpC0wWvFFD?=
 =?us-ascii?Q?Af6SAhiSf24BljT+wJeP5DeFHZKS8ryj02i49y8cdJ4kEOOCFF+I+dHuBpub?=
 =?us-ascii?Q?K0WyFwl38/J9vKkzPdLYwY6B9fzxpt9PNRNF128MMOPyrNxBrd7WRFh11Jfj?=
 =?us-ascii?Q?ah8L8ygD1CRhrWPX5iEFC32jae9ocw7H3rYj9Xm4kQ9w72JbsQwNEjQsJVIR?=
 =?us-ascii?Q?LG409i+H7P4zXVFDJILqeiQdjCHjWA/3oO0i9zcPoUQWjZ8o4FjeyE0vxC7b?=
 =?us-ascii?Q?OkKxVqqgDNsJgCaIUXRSFButdDXRvufHnXyk1R9K6xzohQvtmlXEcpMylHXM?=
 =?us-ascii?Q?GsF1SQRq2YQtaDZ6HA9s6r3Y84PZLJTF2b0uQU1oDppvK/EuC4C63f6OJHE1?=
 =?us-ascii?Q?SEkXqK/Sj7S0y47DMrw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac421a3-b2fc-4426-f1c3-08dbec01c8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 08:54:21.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6DHf3Z04BUPq7i81otlytWOD0yZgIhbvjFWbfTwmq++XNqH3nS08OQTadgPLXSJXq1CCNLVGmWxr4o/1+kinw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Thursday, November 23, 2023 4:28 PM
> To: Karny, Wyes <Wyes.Karny@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> Yuan, Perry <Perry.Yuan@amd.com>; Rafael J . Wysocki <rafael@kernel.org>;
> Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Shenoy, Gauth=
am
> Ranjal <gautham.shenoy@amd.com>
> Subject: [PATCH] cpufreq/amd-pstate: Fix the return value of
> amd_pstate_fast_switch()
>
> cpufreq_driver->fast_switch() callback expects a frequency as a return va=
lue.
> amd_pstate_fast_switch() was returning the return value of
> amd_pstate_update_freq(), which only indicates a success or failure.
>
> Fix this by making amd_pstate_fast_switch() return the target_freq when t=
he
> call to amd_pstate_update_freq() is successful, and return the current
> frequency from policy->cur when the call to
> amd_pstate_update_freq() is unsuccessful.
>
> Fixes: 4badf2eb1e98 ("cpufreq: amd-pstate: Add ->fast_switch() callback")
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9a1e194d5cf8..300f81d36291 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -518,7 +518,9 @@ static int amd_pstate_target(struct cpufreq_policy
> *policy,  static unsigned int amd_pstate_fast_switch(struct cpufreq_polic=
y
> *policy,
>                                 unsigned int target_freq)
>  {
> -     return amd_pstate_update_freq(policy, target_freq, true);
> +     if (!amd_pstate_update_freq(policy, target_freq, true))
> +             return target_freq;
> +     return policy->cur;
>  }
>
>  static void amd_pstate_adjust_perf(unsigned int cpu,
> --
> 2.25.1

LGTM
Thank you for the fix.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>
