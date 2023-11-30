Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073BB7FF001
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjK3NW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345484AbjK3NWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:22:25 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F110DE;
        Thu, 30 Nov 2023 05:22:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA8J8gVVqotWOuY7t7iEetegHID4HAgDSmiTEFuozNoRVVSOyhpvdh6Nu73h4duo2hmoCD8SkKKwqp8higR3p8vMsdhIle6rhzPA6SIr/Ct8omNrAmL06ZsWP0IzpsVSErIWYAchomTlrkzhwVZ1nQpOMdPKOdCOirIiabsrFhFxtthFsAA8af24jCuO5bJqVv3ow1YUh1hrXKTg//y6UJt8uJZoIHlzHactgkKbj48SMHJMwEgjSssPEJFFWXz1dmfM0XSCSHr8vdqx0ZSBgWZftounYxn0wQvFkQSqOVUKhUBfWnSiBgZc1zHjiMmSnt1h1udd6tBjYxnln7vMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ikj4QD5WKgbwgeylvoexPUPyNstcdMCGLbXxMvZ1dc=;
 b=dt+3Z6A9OAfchIyJQ/Fk81x7TNbnkSBU9ZKGBCNesLni7RRNBy8XLtx9DLoYTTmOeUrd+w0vutQhrJPJ4IQVGPXtqTG4bG1snguQ9Mxpgz8PImoM6wxT6V1tL3K9Kn4ZPakrPmYvQ8JhMWmIQMZ8cuB+/CbV4QvK/9sDONokXW143B3H1h4Ms/9bT3D7qS1r5H3ySoXGgJNELR6SY7dBjJFgg06OSZRPw49H7hOjKR55g8ALBhqlDamQfO4hmHKtI4DpCdL+DBf5zwwZUW5HRGcinTRmaS8s5OAgaIIjgEXI3mMiVmTdBzGqhfQq+qL+/385/CknpRzPJTyMKEM1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ikj4QD5WKgbwgeylvoexPUPyNstcdMCGLbXxMvZ1dc=;
 b=O99eAuM3lSNvVyOX7SuZLQizjEOWjIKR1yMmorcriLLHZ47pFYHKLxn0o33utFDSZGLVTAmenzBmHJCMTAuE6Ao+V4wADc1mASYse0kMy3Xmo7+UsbMdq1IEoPlslYF/eG0xmNv0nGQUi8R9i/ew4KzXw2gq7QVaiHoZB72mJ6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Thu, 30 Nov
 2023 13:22:27 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 13:22:27 +0000
Date:   Thu, 30 Nov 2023 15:22:22 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231130132222.w2irs5c4lxh5jcv7@skbuf>
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-7-rogerq@kernel.org>
 <20231120232620.uciap4bazypzlg3g@skbuf>
 <eeea995b-a294-4a46-aa3e-93fc2b274504@kernel.org>
 <20231121115314.deuvdjk64rcwktl4@skbuf>
 <6def78e7-8264-4745-94f3-b32b854af0c2@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6def78e7-8264-4745-94f3-b32b854af0c2@kernel.org>
X-ClientProxiedBy: VI1PR08CA0267.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::40) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5797f5-b33b-4603-bad8-08dbf1a765ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugO4qzEydaY9l6cRbaDwwuBZfePBWrmuSmqIsLCvId23y/cFwxhKqvcx+w87S7IoGbMfqu5opavP995Z2BRbpTy5NvgT8SuiLOoJfBn30pScf0GA+5CI5mT3aU5GMttyms7q2vhmzTRl5PBw5p3iN4V8GN5hrjtPIawAWO73i9MEbgqTIOCfllR5PSdx7X5mzegxfFep7Hsn747EA1Z3kfKad97SfnI/ANbB9YqfmEf1rokO8v61Q/rTXRrsd2GP+TWvRU1MtiKm7JWdLs6jDxnvyjGLpINbOSE3iwceQbSlTFvH/9IACIsU93u1FXrx2b1LZHczEq1izb90qlndY2hoZCKzK6Vfy2VFdFtGvdBEC4yc6rec0aJy0X70OgJJg/EpC0ngcWpOzbhX4pXjCrOyn/6Pk7n4pmN7qnMij31R+IxqRjshnYynld3/7c7OkRZIzOtzt8EQnk+HLh+hT9MhIwtfM9shSVNJXad7SZV8niXTdPUig/fzZ5THZYqFLor6cFRZalGVbwTwM2aqFpLhP8knx3cFRWr2G2w+gCv9J+B2bF9mSzs7ST6xkRWK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(478600001)(1076003)(6486002)(6666004)(26005)(9686003)(6512007)(6506007)(38100700002)(86362001)(41300700001)(66556008)(6916009)(5660300002)(33716001)(66946007)(44832011)(66476007)(7416002)(2906002)(83380400001)(316002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?U4v7UPRhF1DpMAuqRBThsxt9U7rfn6Th+30HdpRfPy4ytjQIpImV7S0eUG?=
 =?iso-8859-1?Q?3FPaP2dpzdXDKpdY/ohZYfTEmIV8qQGuwh7DKrUei08WvKqgOznWvRrBjW?=
 =?iso-8859-1?Q?KpqXyocVQwtdmfOHgtWxWFE7WhuSHKmUEQp3cCd2lr1Yc6V0PA2/B7h7nP?=
 =?iso-8859-1?Q?KSI52u1WcDo82cHZfoUD00eJ2H6sg/oR8Ut5SloWd/7OiZngARGy7t1ObH?=
 =?iso-8859-1?Q?tP6LbINKgLyJhR01m22NG+gRELzB3HzNUqkINQNmEE9KJutLER0Uc6V2J2?=
 =?iso-8859-1?Q?BVZrdDQguBj+kpQ0bnfc4e14rXS0CG+Ykzg48je64B0O9Lm8UIcMgBmHgv?=
 =?iso-8859-1?Q?cTJbG1XCMMCz9qnz60K40zmW04vftje6e2LvdqKPpsH+oYODg71xUmPTki?=
 =?iso-8859-1?Q?cym+aA3NMl9FXmyS6v8wHc9Wx6f/bx77nhGsb0H6B9s6mreJn+yLlDQrEy?=
 =?iso-8859-1?Q?eBRFk3KXxclRm9XUggcam9/nchXU+/VVv0Hxhy81NmB1Prvl63Ie57Icqk?=
 =?iso-8859-1?Q?2L5hwKArBnq+0v1KSlqnFHQNnmmf1LKyEcx6PcJq6KF3TxFGcwSHuM4VQn?=
 =?iso-8859-1?Q?7INlRzZAAaDTgm0J7kbuykxHF4WE/2aYnrIZ9dZUHNoMe5ZK2DxR+XygWt?=
 =?iso-8859-1?Q?RW0DkXQNI8SciabVRk3BBnE/HYqt+pnls6k5+uA+2WQS9NQJrIqXUgOBmj?=
 =?iso-8859-1?Q?MAfbUCgo2a/ZJpHtOWkVfGYSjLdDZCHDPH9upRMxpLfGFZa/5UYf1fipDj?=
 =?iso-8859-1?Q?WyDIEnTvI7fQGzyYT3cKYK9wJCd8F9WwrimlfJ0GDkh8rHyosdGeLLtlEk?=
 =?iso-8859-1?Q?79cbbMavEVkxzb4YmQyGeDlANOfJoa1PckUw8btiKjo07CE164M0b1l7QU?=
 =?iso-8859-1?Q?gEhFrZV2NEEtVq63dtZgA7M4QIQFz23ypCjqlHkHbKMJy1kMRWiI/f9VIu?=
 =?iso-8859-1?Q?mFuZ+AD/yN+Ecn4zcR9//e/CM7mb/yrrwv6yZUyZx7dfgREzc4rPpoUsgX?=
 =?iso-8859-1?Q?jXjrqt9lTLdIYIJniEuMI02owNl5yIjknqMe4A31AQY7k92Z/xp2/Ffz53?=
 =?iso-8859-1?Q?qFHcLQXd0shlBukg5rfJq6OuYSWS502Gxw8Mg7wrSukGNhrkm8ZUBqxV7a?=
 =?iso-8859-1?Q?TgeLq9m6jOTydYySh5sraYHCsHTLA6l9DWD0BhQuMeHXcn+i22WlSh4pMd?=
 =?iso-8859-1?Q?oO6lFVo1+WYGTCzflUYAaX4OxHDWNFDkXS5ngU873+uF3hQqJgPm50b8Eh?=
 =?iso-8859-1?Q?OpkqGIu9cxdAqmSAENXecm3H5MuCgKV+6kEozRLh5m8mWEP8eB47QUoaai?=
 =?iso-8859-1?Q?U0r/tTDvODkISXxOaf/qps25zqvoYWsOMFWTG3KDbxA/48w0DwlxcxhLbK?=
 =?iso-8859-1?Q?IqfrfjwdR+NseZ/UpEA1GySKSx3gA1Q+Nn1+WU5U0ZHMvveGqKVZlBT+jo?=
 =?iso-8859-1?Q?Q2GVrgwnZ7hvp6bXE/qVazyY2a6OKw2N+u/dfbbEVGn8kCAzUPpbq/R7+5?=
 =?iso-8859-1?Q?Vm7PECsYIE+ATkKvo/zUKteTKLcKt5o4ee6IA3eQgSdoXikm5oI5YnOl4I?=
 =?iso-8859-1?Q?53yEZvJRdUC129bD55KIZPxEdgsJRYK2+vBUjwcZUX4hwlUpOhn78O610Y?=
 =?iso-8859-1?Q?RtWmTuxZbmjtOnnNUkwo+YfuT2T88TQ/97sUs9ssEyo7s60awDSjq2zg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5797f5-b33b-4603-bad8-08dbf1a765ed
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 13:22:27.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN+5eGJFpdDy0WSbNDVGMM03aoVo65fD8wufmvsC5g/P/PmeUbCgZnD59q75mOGaA2r/0+D2DmkIVm8AYcMLkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:49:03PM +0200, Roger Quadros wrote:
> Thanks for the debug instructions. Indeed lldpad tries to enable MM TX and the
> network drivers set_mm() hook gets called and returns success but still
> lldpad sees some error.
> 
> I've also confirmed that ethnl_set_mm() runs successfully and returns 1.
> I suppose something is going wrong in user-space with libnl?
> 
> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability supported
> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not enabled
> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not active
> Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner minimum fragment size: 124 octets
> Nov 21 11:50:02 am62xx lldpad[708]: eth0: initiating MM verification with a retry interval of 134 ms...
> Nov 21 11:50:02 am62xx lldpad[708]: ethtool: kernel reports: integer out of range
> 
> 
> full debug log is below.

Ah, you got confused. Openlldp issues multiple ETHTOOL_MSG_MM_SET
netlink messages. What you observe is that one of them succeeds, and
then another one returns -ERANGE before even calling the driver's
set_mm() method.

And that comes from here in net/ethtool/mm.c:

149 const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1] = {
150 »       [ETHTOOL_A_MM_HEADER]»  »       = NLA_POLICY_NESTED(ethnl_header_policy),
151 »       [ETHTOOL_A_MM_VERIFY_ENABLED]»  = NLA_POLICY_MAX(NLA_U8, 1),
152 »       [ETHTOOL_A_MM_VERIFY_TIME]»     = NLA_POLICY_RANGE(NLA_U32, 1, 128), // <---- here
153 »       [ETHTOOL_A_MM_TX_ENABLED]»      = NLA_POLICY_MAX(NLA_U8, 1),
154 »       [ETHTOOL_A_MM_PMAC_ENABLED]»    = NLA_POLICY_MAX(NLA_U8, 1),
155 »       [ETHTOOL_A_MM_TX_MIN_FRAG_SIZE]»= NLA_POLICY_RANGE(NLA_U32, 60, 252),
156 };

You are reporting in .get_mm() a maximum verify time which is larger
than the core ethtool is willing to accept in a further .set_mm() call.
And openlldp will try to max out on the verify time. Hence the -ERANGE.

The range I chose for the policy comes from 802.3-2018 clause 30.14.1.6,
which says that the aMACMergeVerifyTime variable has a range between 1
and 128 ms inclusive.
