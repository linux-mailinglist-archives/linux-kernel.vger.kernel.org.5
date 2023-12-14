Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D2E8132C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573415AbjLNOQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjLNOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:16:52 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3407F129;
        Thu, 14 Dec 2023 06:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfK+lhMZJc/YEv7DHZieG/T8xjm/Ir3HR3MP98T7OALTNFPdjegLty1saP/rEAwLiifMVJ+xF3rJH4wpGtVFls/fNdAtDFBI39dIu/uT7FIjN9OWdTv3lHsh2ylrAa2toFTeVE8SM9Y1XZjT8CFWshj7ob5dYN/Hf1yz101rmQ/d64xKdS+PAMYYbS69N0YUkfFYCEJbGmKvRuL9Lx9aIEVmsBK2+/8ApmNkNMNBu6FlxGkY/nDpZEIizZQROujgWguiU5Q3i7p1/TKohXtqhNn+wLOsmhh4ZkHhe2H/ozOgNr6mfTh3QzMapKqJHd/LDWwePNcILHFc5u/igeE8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opf1HphXX+pLIhUaZUsxGo3e7rbzCC5liWJYZNQAR1E=;
 b=ZKtXn8V3eDO14Llb4JQEGukcsyh2HuvOCmEmT+atmwC/W9iT0wifbne84JYYyupXpJvFC08QyfJ8RUQVva9TZ/Wu30j9qsqvf+4JAp26bjFrYaVvKWc1zBzeM0ovcWwaY0oEe31Oq333Au4cDtkjZBKaKjx9L//ayqFPyvR11aCIrS+xR1JoUUDYZ2gZ+mP8eeyTZNR81AR+BGuuM8ICcpkSqNp4FEB53oB7uM4gMVb3EAlBHsOtC38nIyfZlpR0Y1VtYtWRL2WriDS/M3HLA/XcVCjLEFIj0Z7CYqDKzsl65mEJADoCgzP5udm2WGfiCZF5xTZzVhWiOyrc+uAWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opf1HphXX+pLIhUaZUsxGo3e7rbzCC5liWJYZNQAR1E=;
 b=D8uGsd/BE3OWlEWMNznijbDKtPKxe84TN0XtWUdNtgZWkfSWLdm6F8xcpkti+3irpPHxv3mWkqqj9DpU5KjVzoNY/Yrkw23rq0GvYWTjXX71EDtj5M4JqKbQ11IxAm4SN/M8ErkGW8CYX9r2CbqC8ZwQMDVcqJauGyCloxJZh0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DUZPR04MB9746.eurprd04.prod.outlook.com (2603:10a6:10:4b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Thu, 14 Dec
 2023 14:16:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 14:16:52 +0000
Date:   Thu, 14 Dec 2023 16:16:46 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 net-next 02/11] selftests: forwarding: ethtool_mm:
 fall back to aggregate if device does not report pMAC stats
Message-ID: <20231214141646.kdf5rnldpyglwvdd@skbuf>
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-3-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110721.69154-3-rogerq@kernel.org>
X-ClientProxiedBy: AS4P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::11) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DUZPR04MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da1d5e4-4023-47dc-2de1-08dbfcaf518c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJKydCwlmGpBavkO45GKj3kLoNTwOrpT8rqAZzLK6aOfCQbnzPTYPubQhmnFmnOgWCd+Zqtmmx/3M73T6U093JFxfHrDMnEx7flb4FkiHYmZieI89f6xQQSaZmuL9Cqqp1HBydWN5f/LXA7S31GIKYh2PkuZvUyjRk8ffqqd0yK3RB7LZq2ZNdUA1e+pBf7OHFJmmLceWBTI5xLCKtoqgy10fIFpOtwtWY6xbmJND+aA79TV6YyUeBFTZSV+CrDHappktb6Rvj8Rf17tdge8fnGZ7cxTfaWgvhXhQs65Ww4w02y1/KR6iwI7X0RE3YQrY4+gSLVSIjedzxySZscbFNr5g1xbryIZMDZr+9BGGTQ0w5hYX4CWXRZuLAVLEgcoGQ5wFYvrDtWf4p5wO1P2a1jNWNbIKAucc4F3lSwMA5Gofccvl64U6/YnXnPoc+70jkE/jlMW8zE0JiJom8dMXmslcw624m1I8/mvvkTRTWJ8b1AGw0GzI/cuewo12StotrrICOX1ieVQGEUKT5hvAnlwFUXpPKphUPU53jaQdWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6506007)(1076003)(26005)(66946007)(8676002)(6486002)(44832011)(9686003)(83380400001)(7416002)(6512007)(5660300002)(2906002)(33716001)(8936002)(4326008)(478600001)(966005)(66476007)(6666004)(41300700001)(6916009)(66556008)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HAmd+PK14BYdgYUN3+SUv5V074PVz4j7Gu9s/UeB0w6LxJcSaCG+WSe1LJzu?=
 =?us-ascii?Q?mma6ayGgqPcjiJqgyy0jW5PkJbCbNVxkxZZzDzZDG7KeBiWVKvRMQ60C91gU?=
 =?us-ascii?Q?6RHzNDr3SV4HYak+eUMYXhrcAZ/4CQ+osnLqz12Q4M4O+FBDDnYdGqe3W/Ov?=
 =?us-ascii?Q?gn3xDbF78/EWJCQkI6Iwv13repELRzO7Uxtfo41AFPe5uVJFpx+yNviIkqJL?=
 =?us-ascii?Q?GxWZtu56YZfD8nEHaJ+FkaGX2VLb7SD8w5ti3U80HfRxlXpI5mWv2v4sd2bJ?=
 =?us-ascii?Q?GUWfYx75EFrLiZPw3c5xPiK7J5iWuFUNr/5jWPksdO8aQxnLms5dNBx24Csn?=
 =?us-ascii?Q?WxN4qayat7d0JDVVMSa+M6IHu0RERUcRuCGGsQW+JqRXRLfIiSCDEYxBrdz1?=
 =?us-ascii?Q?1T2Etc0Ffz9qmLRQ/AVL5bTMN+gv5J78ns9Ayz9PreADgbtStJMumz70SCSS?=
 =?us-ascii?Q?QFB1ssVjZrT7nMgMcCc/+deTRmQqBxHLsLxNcFLifA/msfx2ZkscYZrapYap?=
 =?us-ascii?Q?4i68qpqs+8ttsthFlVGbb2PHaXyIsBVsi42cAvU58cG4NqgMM6yi3Yq1S3zi?=
 =?us-ascii?Q?pdWWSKojqxNrte0eehApPK1Dbk+j2tvSyDK1jnz1CHzvbHuI8BA3aU2+3rrr?=
 =?us-ascii?Q?bcq+AIcl4nKRY3wNvjAYbzXilG2fWKXM+u4y0L3PmWthL2pucL4kiNBCSr6o?=
 =?us-ascii?Q?Z/WzcR3eyeroq05A6GbuhpAIdVy4ua7jVgsosoIh2KMPMrUVv7/Bt36g+dAT?=
 =?us-ascii?Q?nnHdm306h7+JzXKuHxZfAohyBLcJpvN/DlD0rljs0jaTMwAL+DxKiZa90DR9?=
 =?us-ascii?Q?gTN3a3y1twDODQj4D2Dl7g23htExvcmaPzdXxdi6VKWWob096H3RH2qnvWcO?=
 =?us-ascii?Q?hnjvmnXBH5fUXGYfNHb0lmxUa5NsPzF9ngB7/w96v/V30jSRkhjmr/muGlT8?=
 =?us-ascii?Q?k1eAAZv+/7nJWU8tnufOTO6qGP7ZTrwlZVPFEbPCsFVZALFtX+9Ws2t2VDyB?=
 =?us-ascii?Q?0RmWXaRf7PKuhdP3uPzscuNyJ6cgZMBiERIK5NXBvMBu5NDW5W/9aLP4oS0q?=
 =?us-ascii?Q?dq8wwHPzPCRCcW+Etr3Nb0WzJ9as2ucLKwWq2PC57BF+mANAZJXU71WY3z75?=
 =?us-ascii?Q?JiW4kiww0Kp3rQLMECo+cUg6uxI7mi2ukUvqoUhCgz1YNO2Trye9Cln5GK+g?=
 =?us-ascii?Q?7e94kpILoXRCLF3zXwAsG2YxUHYfbJF0UkYrqqjNFgdQk8OYypxfiJWGU8+3?=
 =?us-ascii?Q?SnLdB53QXLGWJ7XAkidJIH21s5rMWwRvnKTOU//tQjSbRF5J2kmaDr9CN/zp?=
 =?us-ascii?Q?dVpcx4h8REYHj8G1zHKSfqR7Akemcq/D7Nb6t8fT+qMVbj2iCkO873ZtLmlG?=
 =?us-ascii?Q?HxTdoGKINHtbwQlf5yWtTnLSpuuB9EBoVSztL37+R972j6aeeNu1OSuX8GrN?=
 =?us-ascii?Q?tdOnUJlkW26EMdOGkG+3Mu7IXwJMNYzsPm33/zzUWROdjIpbPZ5v1/Q9GMyC?=
 =?us-ascii?Q?7bGIsCXviNprl/NK0NRJ+XCF1zbHxCTgOlRINDyMcFu0WvWhShy+RSJYmT6m?=
 =?us-ascii?Q?Ud+3D0LdovxjtFyg1IzNLsuaZKcTg83BPf7l+GCyKW3Rgpg3MVJ0O7d0ch3c?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da1d5e4-4023-47dc-2de1-08dbfcaf518c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 14:16:52.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A2O0LDNohC45zvckV+B6eKyixCImKA1iHXD0fShprKleYQwWsovITxsFC2pyIrZeXlLohIJr+xaKPK1EHFXyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9746
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:07:12PM +0200, Roger Quadros wrote:
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 8f6ca458af9a..763c262a3453 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -146,6 +146,15 @@ check_ethtool_mm_support()
>  	fi
>  }
>  
> +check_ethtool_pmac_std_stats_support()
> +{
> +	local dev=$1; shift
> +	local grp=$1; shift
> +
> +	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
> +		| jq '.[]."$grp" | length') ]
> +}
> +
>  check_locked_port_support()
>  {
>  	if ! bridge -d link show | grep -q " locked"; then
> -- 
> 2.34.1
>

FYI, there's another submitted patch that touches the exact same spot,
and it looks like it has a good chance of getting merged.
https://patchwork.kernel.org/project/netdevbpf/patch/20231214135029.383595-9-tobias@waldekranz.com/

You need to pay attention to merge conflicts, so you don't waste a patch
iteration just because of that one thing.

I guess you might be able to wing it, because the other patch does this:

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8f6ca458af9a..e3740163c384 100755
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -146,6 +146,15 @@  check_ethtool_mm_support()
 	fi
 }
 
+check_ethtool_counter_group_support()
+{
+	ethtool --help 2>&1| grep -- '--all-groups' &> /dev/null
+	if [[ $? -ne 0 ]]; then
+		echo "SKIP: ethtool too old; it is missing standard counter group support"
+		exit $ksft_skip
+	fi
+}
+
 check_locked_port_support()
 {
 	if ! bridge -d link show | grep -q " locked"; then

which quite coincidentally does not change what your patch sees in its
upper context, aka 3 lines like this:

----
 	fi
 }
 
----

You can check if your patch set applies on top of Tobias', by formatting
it as patch files on top of net-next/main, resetting HEAD to net-next,
applying Tobias' series and then your patches.
