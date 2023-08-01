Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8365376B9DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjHAQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHAQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:45:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4734F103;
        Tue,  1 Aug 2023 09:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+4viUedJThsFzYfiPcPbiBUDgI1/TH6m0Qbyc8ElTE2jLlwqvtcshjwBjJeb/lbL/JTj8yKhJ16ZGZQa80YB3nFmYOUTaXa1HCTAcJAxJYXnURdlmmT9xI6EKIg2u9+DlnPsBgEQ84xjM1v9E1ULjYk2UFE+hBwCmxHHgVw9YpVy/wImrjwp0ODrG7+i20LZ/di4SYMs2BD7xSmDJsDBsQyRLEWimddMaUsFLFpu6OIezJN86zn7iUTjfdSPKi5CVsfK3UqGQhpFqbSqqrDWXhtm4Sf58BbYtQQC0/k2tM1fO7XstCk4k/QOtPOjKKPRSlq5zUj9F0gEeQvBdfb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvdKIfuI4N7Grf/btDkJ3o8FIqFeOCv82B9s2O71Auw=;
 b=aUcGur0m4n7wHdFuHbdIT5UxypwWQjzwKgquW98VwZSh5NdriW5tdOGalYKfnLzdfidbl0U7OU/YDokECpX1j+yZnoN+n+LzeLIGj6qsVFQyFeoPr+xJ/dZ8LReN8dNF/glatJMQ689/T1rhoX49v92ht4LE2fgiq4I2NzZARSsBy49wt/zn30oFzZvjEU6/aPX3B9B/Od5GbUoFLMkNuSR0QItsjGZsrez/dNZkzeLibHDRP2oapKzfUfqf/h28bKX+wMhYO1tA+XZaFCwWqPPYUnANrf1zY13aE5ljeZF++mmMBnSTSjTjuvGnvmHNM8jp780eyDwqWGmknsZ9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvdKIfuI4N7Grf/btDkJ3o8FIqFeOCv82B9s2O71Auw=;
 b=ErHpiQHJlZiyGJ11al+i1345eRwnR4agPuPhjgkpbE/nyiU3ARUVv1qf6aljUju/7xCVRpfNavDRtlugNZEBgRKzBqARIoYfCU7i7cIku5u8Wu82wd+tna0PvqJmNk1i3D4BZ/0gzYhy6gosxs2VJUt7ATxw0OK1y0Q4qMFJsZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com (2603:10a6:10:103::19)
 by AS8PR04MB8929.eurprd04.prod.outlook.com (2603:10a6:20b:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 16:45:39 +0000
Received: from DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::ceae:2c83:659e:a891]) by DB8PR04MB6459.eurprd04.prod.outlook.com
 ([fe80::ceae:2c83:659e:a891%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 16:45:39 +0000
Date:   Tue, 1 Aug 2023 19:45:34 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: Re: [PATCH v2 net-next 7/9] net: netdevsim: mimic tc-taprio offload
Message-ID: <20230801164534.2nklcql2nh6x6p7y@skbuf>
References: <20230613215440.2465708-1-vladimir.oltean@nxp.com>
 <20230613215440.2465708-8-vladimir.oltean@nxp.com>
 <877cs5twqn.fsf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cs5twqn.fsf@intel.com>
X-ClientProxiedBy: AS4P190CA0035.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::11) To DB8PR04MB6459.eurprd04.prod.outlook.com
 (2603:10a6:10:103::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6459:EE_|AS8PR04MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: cb358dff-7c0a-4b2c-70fb-08db92aebc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxumKrTcW//ndwtDmjHH+dd1SajHhGkDrBn00XZuAmYLw7hOHew4kPxYTY0NTmAx44P33HkmGwuYtAdQCrsMAV33bvLjBInc7g2KbrDQGzMzQjAMuF9uL9YKTJNCrpFy4EVdvL27kBBmV3Wzr1GFz5Fyk4nxsv1WxKIWjqbxgBllUbItrAao1Sf0V/bTVf1mCYj3d3/5BV2k3a4XBzANMJfCKsC2wcUGi7yKfro+mV8PqvQLu/7WYvb+q0GI6N5CXzTE+nUdUyFV88nXgGCK1PqiQMQxXVbjOVd9YYMHjWWC3seMt7GDOXjJGAXLmYivfOSSu8BsuzHJzMvcJ7Kt6Rm/wyAptQWOH8VhEleKl5qmcAtdXoH14dRQ5Bs+HWBCuQG6aXSFB0t3PPACVOpx+YCEG8y5XZNTPPabqU4PAZlt//KoMughMnX01j1blUyyiQUml9Iv3MQtEXmaNe280ffMgIKF8ohHSu6D02ucNEmKUqoN7CuY5Tepym7eT00fltXu/ro+KBZDDeBLW281Cdw+DWEFg14259zywQ2mFNWj4qgRzKDXrLWxuzya/O80HmvWtmzq2soKl4kFs2pbWIeXLZggs82K9eXkJkXxHAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(8936002)(8676002)(6486002)(41300700001)(33716001)(478600001)(2906002)(6666004)(83380400001)(44832011)(26005)(316002)(186003)(86362001)(1076003)(6506007)(5660300002)(7416002)(38100700002)(966005)(6512007)(54906003)(9686003)(4326008)(6916009)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUE5WmNYakJTNFlpOHk3azl1REdja0syaEVYZjRpTHVkWk1qUkFMNWhZWGti?=
 =?utf-8?B?SnVEZ2tROHJ5TTk0RU9YQ3dQNTNVUE5oVm8wOXJCS1YxWmNHY1hpem93R3F1?=
 =?utf-8?B?WGhndkVYbWxpRkU4SDRMcU1lRGZocGlGOUlra3JlSHpLOGc5S29HYlRJNzNa?=
 =?utf-8?B?SUZSUWlOWnJYT2d3amVMUnRDTmZXbWxJQk5zYlk4V0NtVUtIQTYvS2x0b2xK?=
 =?utf-8?B?aUhQK3ZxbUh0N0JqQTU0WmpKZktNaGhsS2ZuWUc0cE0vbEJidjhHd2V2KzJE?=
 =?utf-8?B?a200emk2Vkh2aTNLaC8waVUvOUd6Z2VRaEJsWU1SZVpQZTVadXI0emNmb2FW?=
 =?utf-8?B?cUk2R2NoWExDajQ1ZzlvdllHUHZCZksrOXpwbU5IWDd3aGxCVDJWTytVeC9u?=
 =?utf-8?B?a0k2ektDU3N3TlY5ck5oRGpHTVlsNXBzZitmVUVwTHZzWGM1ODBDRWRWTCtB?=
 =?utf-8?B?OHYvc2Y4YW1HK2NsSEVzNTlGNm55bkw3WE1sQnVvaDhGYUFub011REZLWXd0?=
 =?utf-8?B?UU5XYnp1Y1AxcDFrUXgzMjhxUFZMNlZYZ1VXUUJ5TWpUcmNRelJwTERIa1FB?=
 =?utf-8?B?c3lPNTByaGFMY2l2SHA0RHR1ckc1VE9zWGhaMk1OMG8zU0pjZWhkNjNQWXNt?=
 =?utf-8?B?dFZPcVVBc2tKQ2pyTXk2OUxrMjYrWDBzbFVCMnN0QjFEQk1BZFZXb0pDaEJD?=
 =?utf-8?B?WGxqaFNBTXYxM2FEMUVkZGthdU94VWVleFVDcDlnUTR3N3pNWlR3L0EzS2Zv?=
 =?utf-8?B?OER0d2MvVVZLckZRSXFGUklCanpVb0IyOGwyUDRaUHlMb29NYWdRSzVVZzVO?=
 =?utf-8?B?aWNHR0wwMUdKMnNEZXozQ0FUM1VyaStUWFVFUWVDK3ZDM0wrSGRTZG5aTUp1?=
 =?utf-8?B?QTNpR3I2VElqUUxsbUE0VlhLVjRUOUxka2VWTzZZeCtHZ2FJVnFzRzJDSHJB?=
 =?utf-8?B?Vlorb0VJTThMVjgzV1pVNktQWjl0eVdnTGNUQzR1N2dyTkpFeldFR01IU2ZP?=
 =?utf-8?B?TGovemFKRFd3SE5pNi9pbUh4RmxINGNIYmVZUE4ybG5WSlJNUjlabHdJOHhF?=
 =?utf-8?B?cnluVDBpREFlQnhhQnVaVHF4cXRVZURJUGVuM1c1ZGY1QjBRZ0QrZ1R5OUt0?=
 =?utf-8?B?dG9obzJYNEVSMFZHOERCbjFxSFZDeWhHVjRKUTRENi81Z0NocEtDY2t0VXFX?=
 =?utf-8?B?VjdCMXd1VHowdEplb0tLbFQ0ZHNXSnBVYjFXY2hHWC9rN0dSQ01VSTNuamxL?=
 =?utf-8?B?bHZrZ1VsaUNhNEtQMXUySStJbUpYSDNHT2EzcTNGb3p5aVYyVjZuRHRUL0xO?=
 =?utf-8?B?dlVvZlF6emhrK3FxYWs5RklGUnk1UndPQzlqdUVvR20rZEt2Q1dOSjZVT244?=
 =?utf-8?B?NTJYellVK3J4a0xhakFVVjd5ZjEyUnU3TjJnaXB1Q0lPRXhwMDFpRXRhTXRo?=
 =?utf-8?B?NXg1dGhuaU5Od0ltTGQxUmcrUS9ZK0lCL1VXWlM1ZzJJUHhiSEoyTm1scmVk?=
 =?utf-8?B?Sjd0WnNsMCsyblNFZjgvb2Fzd1dmWUk2L0xFOWtHamg0OXdlQU9FSDRNYVND?=
 =?utf-8?B?bmpYMTRVd0dPOTlmanJwTVdYKyszMWsxa29Gay8vc3lJRUhYTmwzVkUyS0pJ?=
 =?utf-8?B?aVNMOXY1bEc4dUk5MEtmR2JTUGhZSVhvYm1FWDh5c3NDRGwrNEZPMjIyNDdy?=
 =?utf-8?B?S0IrUi9ZYUFKSUl6SXBvVE1OeVJmUTB2YUJKYTZIY05lTEFNWXZ1QzQ0bXZS?=
 =?utf-8?B?b3czRDQvZldBQ3JBQ1JyMmdZR2tuSHYvd2JkcFc0ejFxdnVyUnl1Qi9paFps?=
 =?utf-8?B?Tm13ZXBhMkFQbCtTU3VRYmhQaEhQcVg2R0pJaFdiZUZKN0ZzV0plWXpBbXpo?=
 =?utf-8?B?SEZleTlaSVNJNksrckN0SFNZRlRmQk9WOEI3N2FPN0RRVy9zZnR3eWZOdGlT?=
 =?utf-8?B?KzhsdUgwb09XLzlhSlFVTC82cjgwcjNqTk8vdHpuZlRGanlxK0t6NW5DWERI?=
 =?utf-8?B?dno3WUhkVXZ3NCtXQUp2TGhnRlM2cXI2MTlNbVNUblllMWZBYjk3MXlvWEk4?=
 =?utf-8?B?THl5dFFvcTgyblNFOVAxSjVKMi9UWWxrcm5DSGVtaElVbzhyTzdsRlpFVzdo?=
 =?utf-8?B?VDhrMDdaQWI3OExuY1kzTWdsUUliMU1mWWFHN0o2VW5GM1ZIY0Y0V1VjMS9y?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb358dff-7c0a-4b2c-70fb-08db92aebc8d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 16:45:39.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2d/kBmsp8kAbjIkeuZcHw/OvImAn9gUmRrZIoWDiqRpWckoj6EtidcUkRZmFkSYEMAuoDVUtUeDgYi3bZI1sTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:06:24PM -0700, Vinicius Costa Gomes wrote:
> > +static int nsim_setup_tc_taprio(struct net_device *dev,
> > +				struct tc_taprio_qopt_offload *offload)
> > +{
> > +	int err = 0;
> > +
> > +	switch (offload->cmd) {
> > +	case TAPRIO_CMD_REPLACE:
> > +	case TAPRIO_CMD_DESTROY:
> > +		break;
> 
> I was thinking about how useful would proper validation of the
> parameters be? Thinking that we could detect "driver API" breakages
> earlier, and we want it documented that the drivers should check for the
> things that it supports.
> 
> Makes sense?

Sorry, I lack imagination as to what the netdevsim driver may check for.
The taprio offload parameters should always be valid, properly speaking,
otherwise the Qdisc wouldn't be passing them on to the driver. At least
that would be the intention. The rest are hardware specific checks for
hardware specific limitations. Here there is no hardware.

The parameters passed to TAPRIO_CMD_REPLACE are:

struct tc_mqprio_qopt_offload mqprio:
	struct tc_mqprio_qopt qopt: validated by taprio_parse_mqprio_opt() for flags 0x2
	u16 mode: always set to TC_MQPRIO_MODE_DCB
	u16 shaper: always set to TC_MQPRIO_SHAPER_DCB
	u32 flags: always set to 0
	u64 min_rate[TC_QOPT_MAX_QUEUE]: always set to [0,]
	u64 max_rate[TC_QOPT_MAX_QUEUE]: always set to [0,]
	unsigned long preemptible_tcs: always set to 0, because ethtool_dev_mm_supported() returns false

ktime_t base_time: any value is valid

u64 cycle_time: any value is valid

u64 cycle_time_extension: any value <= cycle_time is valid. According to 802.1Q
			  "Q.5 CycleTimeExtension variables", it's the maximum
			  amount by which the penultimate cycle can be extended
			  to avoid a very short cycle upon a ConfigChange event.
			  But if CycleTimeExtension is larger than one CycleTime,
			  then we're not even talking about the penultimate cycle
			  anymore, but about ones previous to that?! Maybe this
			  should be limited to 0 <= cycle_time_extension <= cycle_time
			  by taprio, certainly not by offloading drivers.

u32 max_sdu[TC_MAX_QUEUE]: limited to a value <= dev->max_mtu by taprio

size_t num_entries: any value is valid

struct tc_taprio_sched_entry entries[]:
	u8 command: will be either one of: TC_TAPRIO_CMD_SET_GATES, TC_TAPRIO_CMD_SET_AND_HOLD
		    or TC_TAPRIO_CMD_SET_AND_RELEASE. However 802.1Q "Table 8-7—Gate operations"
		    says "If frame preemption is not supported or not enabled (preemptionActive is
		    FALSE), this operation behaves the same as SetGateStates.". So I
		    see no reason to enforce any restriction here either?

	u32 gate_mask: technically can have bits set, which correspond
		       to traffic classes larger than dev->num_tc.
		       Taprio can enforce this, so I wouldn't see
		       drivers beginning to feel paranoid about it.
		       Actually I had a patch about this:
		       https://patchwork.kernel.org/project/netdevbpf/patch/20230130173145.475943-15-vladimir.oltean@nxp.com/
		       but I decided to drop it because I didn't have
		       any strong case for it.
	u32 interval: any value is valid. If the sum of entry intervals
		      is less than the cycle_time, again that's taprio's
		      problem to check for, in its netlink attribute
		      validation method rather than offloading drivers.

There are no parameters given to TAPRIO_CMD_DESTROY.
