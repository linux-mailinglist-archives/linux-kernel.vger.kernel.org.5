Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565C780F5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376638AbjLLTG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:06:56 -0500
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2114.outbound.protection.outlook.com [40.107.121.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A8AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBJThJFbaG276TEU721SbEAhT00xcREmf+52Bw1Tv2WNwAVXzvXVd1I0r0GjF4ZcCuUDZa18E5B3+DlUMbvEiSUOjetQfBt8QhPmSAGMJc+O9fndoRBC50TxxPZ51UUnmJh37HQcQLTKWsDg+tbXiqKvmzQbsPz9uJxG1gjr+3PxDFKXCYxGpO8m9YLopqIbPHnVIWlsPjRryy16Q5l2KVCCuV1xOK3BZFh9AdlX9RqVs6SURp9pzvz7SAvjLgCP7v5H4ge08Ags6bv7HvhPJ2s2/+BdzVdj0+tkBcGPQ5bFLNM4TEZxK9klG8CXmVN6fXBcgG0klI5oe4dHX5RFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyywjWF12aTnmCUaZ16SqqoYfeU14aRZlpilYdAz69U=;
 b=Y/sVeJnw3YK2tTpBQC5Vfkt4AiUXuWZ3rJL0ens+4UeMIIdVo6oRV3F2jx0Z9Uz0H6EVjf97b93ePIwJxdzcDhdvjmy6mo4lcf9QhbcI9eGMsm/RGXT64FErGz6yAYNEDD7I//ihkjOf8q7pj5CyITJMZYu38NyJoagZMudXWTK1uPNf09Z2ievrlTW6H5hidO1Gb9ZdPbS9IBSYeVv0k1jWmL++PDJx7tO2eWCLAjxO64sBddgXCeU+LiCQuHp4AioO6a8Afa7B1e6Txpu9l+UpGAjRMpLOiCedrI7DhCF20e1w3hrOyaH2p9DTXIg6Y+QoLcv8mh0O4+ozesRDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:be::10)
 by CWXP123MB3352.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 19:06:59 +0000
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3b78:fbc7:bda3:1033]) by LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3b78:fbc7:bda3:1033%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 19:06:59 +0000
Date:   Tue, 12 Dec 2023 19:06:48 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <6l7ytemuf3uluzh4ejugnrh4r2shjyvprrnkvxeesg5cgdarev@fo6bbbmwwskk>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
X-ClientProxiedBy: LO4P302CA0004.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::9) To LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:be::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB3531:EE_|CWXP123MB3352:EE_
X-MS-Office365-Filtering-Correlation-Id: bba20492-e0f7-49bb-c904-08dbfb457e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55ggwc9isXSaBPYGSfxsqpU6LLFyaYTleI8Vsic0DxZ/O6R5rN8B+L22sQqcV9hOjUeAh3lqQ4qGKMcSqso+6A7yX7RTVhkDlxgaCM/3IjGvzuyPdqFd3BVrDWwl5Ut4stzk/bjFIhxlCOG3h1qtjh2gkJt1TB3n7JVl8Z3chcJzzgWx7sArnRfJ/rGJtaDAQJKDnicjJF9DjcL01VYdZBVJxPiCk3N5Jvx7TT9Q//Pemxkkmdx7fa2zLndAiVZTXrmdo+j8Mkh12m4eWSsmmFJZj+gIpSQ89UlHBsMYNAnG3kKpBTieNl/qJ1Vsb3bCMSQSgAE/gjQ0eaVVMThEdEPGwZ8D9mTzLLxzjmfKkHpL52qsrevxH+iS5xLOHmZMRMbjm+zGDqwPwi+dxh2/TDdcrX/daSAH6NBd7eb7MFk34F2OMbvnzIGjN/BS51PbaqwRAnicIJRaJrpuJCKk4HGVBKUm2YouHgQSViSsbZ5/uytWTjwwN46vIDAXtW5c++p2t2OIKSx6eFheYuAg03rLamWpkJs0lK+JNhwKRTV/yS3nxpHeUZuh3UkJgFMa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(39830400003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(6506007)(6666004)(6512007)(9686003)(5660300002)(33716001)(41300700001)(4326008)(2906002)(4744005)(478600001)(6486002)(8676002)(8936002)(66946007)(316002)(6916009)(66476007)(66556008)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHdKMno5blM5OFpQWEZxbkpHbUtBOWNDQWlHYWoyODRqL1I4eUhRQmdBYXlX?=
 =?utf-8?B?cC81dDNRWGdrQm1DaHM2ZjJCWUR3SWRxdXl1OENnTlJQWTlrQjdnSGhydUp4?=
 =?utf-8?B?QUtFWUFvNmJwdkxoNTkwbzRQMGYxa3dyYnNVbjEzb3U0WURQb1VaMDNVK2pv?=
 =?utf-8?B?d01PNUUyUURDSy9LZ2lvOFhEWm4rU3l4cGdld1JZbitNOW53WGlITUhQdWcz?=
 =?utf-8?B?VW1lYUpqWHJIZzdVL0F4cUl3eUZmSHNrYjZXS3NxT0pIL0ZCRlJtWHZiU2Mw?=
 =?utf-8?B?VFVMTFFxMHRRU0M4SGVvN29LRGJmM1ZLV1NhNmRMMFpiaHdjTE5NRXhsQllr?=
 =?utf-8?B?TWFEaU11Y3E2SjIwUFByYm13YTVSOTZsVTF1dVJMZlR2dHRCOGtvWDd0SlpJ?=
 =?utf-8?B?U1pUV0xxMVpUUXdVdnFwc2M4NWs1c0hrUGhobjBjdElwL3psNlRyK3FYeGZx?=
 =?utf-8?B?N2JvdFV6aUIwdXZTVHNOT25MWTBVbE9mckFZdk1Na1lNSXl3MEZqVFEzSm5a?=
 =?utf-8?B?OXhoOGZJTzJ0OTFvc0w5TE43MWJPa0FwczZETEpoa29pbnh2SElCakFTNzdD?=
 =?utf-8?B?TVZWYkpKY3VvTVNIMmpVeDkrOWgwak9GR3UxQ1RFMm1BdnFmUGs3NGtzQWds?=
 =?utf-8?B?UjUvUnJnUEFveVpVYTlTU0dMMjFKYll0Tk9RWDVETUF0dmVERWFyd3RXV3ZI?=
 =?utf-8?B?RmRTVWZHcjUvR1NHeFFUUGQ3WlhPSDNCU2kxc250RitNVTVEdWpmOERFa3A5?=
 =?utf-8?B?cUUyTGkzbWcxdjdwT2R1UWdLbm9yV0lYMC8wVE5NMmd4cDdVcGNTWkJQSjJq?=
 =?utf-8?B?c0VpTEt4ZXNhUVc0KytMTjBmdE03VzFJZUxDMW9FRnQwNE1vZmxNUHY3Kzgy?=
 =?utf-8?B?OVZ0TElmeWs5clJGdUV6Wm9RMSs3K1VkenptWmZIKzdyVGt4ZTFTaG03emNN?=
 =?utf-8?B?ZEVlKzFwSzBtTTUyYzNjVS9LMGNqNStPc3FwaFI4NWZtUExyVzZmZEJmbFAv?=
 =?utf-8?B?bUI0QTJRYnVIdkdMWlFOUTZhMlZ2K0krSWtVd2tBbFk2MEZqcGpzNnBhb1Jo?=
 =?utf-8?B?RTVJQUlOOXdzU1Jad3hzSm45Yno5SjZ3RnJFRTQ5ZXhaMmFUQUdXM2FBNFk3?=
 =?utf-8?B?UklQMkorWW9ETjRlZmN6d0tMTXM3cmdJdDNkNWk0OFhsSkZMdUVBbE5DU2ph?=
 =?utf-8?B?TjZ0Nk9PNkFjdWdDTFFQNDlQSDNudGJDcUEyaDlVZmNlUHowc3MzZXd0Qm1N?=
 =?utf-8?B?QkdOOURQTTlQUDkydHA3dG1jRzhKTUFucUVIN3JCaDN2NWc4bmI3QnE1aUZ4?=
 =?utf-8?B?QmdOVDJlU1dlTkpaNGhxdlVIUi9vNS8vbWJaNGcvc2MwOVdla1hYSExBVGFP?=
 =?utf-8?B?RkxKTllCcjJiVzhoUS9tUVliaFZwMytYVHpYazNMYjVrZ0Faam5mazgvYnJC?=
 =?utf-8?B?SFNBakhqRk1DVk10OG04QTQ0SWFIUERnVHFKbUhjOFY2MjZYb2ZjSVFKaWVo?=
 =?utf-8?B?S3ROUWp1RkJyQVdZTC9JSEN1ZzludlQ1cWs1ckMrVEdOLzlIRnlXbFJSUy9u?=
 =?utf-8?B?Vkp1MVk3L015SGlhYzJpb2gwTWVOcmZkYzhETUZJSWJLcEVTaVFUdWFSVjRO?=
 =?utf-8?B?OFk1T1hhQlgzbzlleEUxSlpteHVUSDM5blpsRU5vUTBrdktkcXBRemlMNTM4?=
 =?utf-8?B?Z0g1TzhycTVxbHNEa0kwK3hVemFSOFJXT1phOTA0ZHltZmpKTW01MUtGWDVN?=
 =?utf-8?B?QUtIZSs2ZDl1dkZ6c0htenoyeC9SR2ZTb0RHSzhIVVkwWmU3OU9nQVpraENs?=
 =?utf-8?B?amFueFp6YjYrSm1sNTA4Rm9OUWJjTmxiZDRRZmwydjFrOVAzK0ptQWZ4WmRk?=
 =?utf-8?B?MGZkWVM5WXkvUVAxK25rM3A2ZFB3ampJWlE0b3VVc1J2QnhCL09BRk9OTGtS?=
 =?utf-8?B?K1I2UXNHUWpraEdxL3JIZlpJeHBpenRkbThXU3hVY3FmZnVLU0VaeURKOTFI?=
 =?utf-8?B?R3p4TC9ieUE0M1dxcXhoamtrMFR4bFdwL0Q4SlRqNTBsZkhidVNCUzFpRTdH?=
 =?utf-8?B?TU9JYm1HZlBWTGNOeVF2YTlHWE5jcFEvbXMrVzJrY1c4MVE2elc2d0NRcFBx?=
 =?utf-8?Q?EU9gszdxYQIJK6Zutogha7Avh?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba20492-e0f7-49bb-c904-08dbfb457e4e
X-MS-Exchange-CrossTenant-AuthSource: LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:06:49.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyf6RQ60tL6IdEMonZ3onKZX45BXajKoy6kpBub29I/3YiBjHH/xSpqh/aWgDQJWjLDaS+3G++xkMa3dwMTQkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3352
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:14:48AM -1000, Tejun Heo wrote:
> Hello, Juri.
> 
> On Tue, Dec 12, 2023 at 10:56:02AM +0100, Juri Lelli wrote:
> > Hummm, OK, but in terms of which CPU the rescuer is possibly woken up,
> > how are we making sure that the wake up is always happening on
> > housekeeping CPUs (assuming unbound workqueues have been restricted to
> > those)?
> > 
> > AFAICS, we have
> > 
> > send_mayday ->
> >   wake_up_process(wq->rescuer->task)
> > 
> > which is not affined to the workqueue cpumask it's called to rescue, so
> > in theory can be woken up anywhere?
> 
> Ah, was only thinking about work item execution. Yeah, it's not following
> the isolation rule there and we probably should affine it as we're waking it
> up.

Hi Tejun,

I am confused.

I thought by design we want a rescuer kthread to execute on any CPU, no?


Kind regards,

-- 
Aaron Tomlin
