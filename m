Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA397F2C16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjKULxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjKULx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:53:26 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4229D11A;
        Tue, 21 Nov 2023 03:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2+cXEaNa3PU2J2uYXDu70UMSUzFGG7WCoN0UNF7s1SjKy9tY0sHV70zefNhqRNlK6njt/u1lK7Fu380Scu9A3UPEIeE6ppa7CyDCvaB2h51S8BNvu2m5eC8JSGsw4XAe47TV3AB8ZZj+5zMOJZ6XGgnS+pbobQ7Rf8JFTdSw/AhLh7S2ZZH5zPjYAY7BtataZeV7SRfy6D60xN/HI2B8J9tkqBksVRHOFmjkMt9nHha0uwK+A1SczQgMWQ85Pb9cuu2pFPxB3PM4u6f0AuHavB9ZIXRoRwaRLmTF71YfaML8VSY4EQxzqsgYOKsWNfrgKYeY71ARRLukMGztASVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjsgGGgE4yXUs0YKBScoy5f/seh4ApHj5uVUteuolWI=;
 b=PlTDDhyBRC0F7AFEsNKlDXapAP3cFE7ECmDoaF8vEOt403Mzo4OeZNk1in8prHL5ivwFJb+47+4AlX5Fz7uXhy5utik45E+MqAhwdefDrkQBYasvXkaMDGcuOwvhodcNgvFvrMo2oW1NAV+RxQcvjrFTXZZNC9JZ89NrAoDOnd0K34lGSJku7nDEvQ2XX1aDMfM8KI61KXkSmas6NosuMwnBWynqQKNegbDAOwP8SDYRQTkRv/NY/QdGItdw5sTeJf4q4vtTjYRouBggSacUADCxrUDF3jpX/biMYqjZeD4b5JaeKc2MQIdpqR0ihewH3fQUgk9nm233L5hZL6+GAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjsgGGgE4yXUs0YKBScoy5f/seh4ApHj5uVUteuolWI=;
 b=l0SjEvrD4zizizrXp86EfNFv+nGVZ2XO/OWN/O0KNR4YmEz2KflggfOt9MhjHz5okdeIjCJqAemw7PBnOImL66ecagFjB8o6urdnjYFzH092S8X7x1VPAErzlO2/rqiACq5KadJmdGOovFGt+MQK5M63+gI4M5FbtOh6AVSC2hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7942.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 11:53:17 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.017; Tue, 21 Nov 2023
 11:53:17 +0000
Date:   Tue, 21 Nov 2023 13:53:14 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231121115314.deuvdjk64rcwktl4@skbuf>
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-7-rogerq@kernel.org>
 <20231120232620.uciap4bazypzlg3g@skbuf>
 <eeea995b-a294-4a46-aa3e-93fc2b274504@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeea995b-a294-4a46-aa3e-93fc2b274504@kernel.org>
X-ClientProxiedBy: AS4P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: d35fffd9-8729-4d14-50a9-08dbea887372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1or0/O+jT6XAz5I4mBZLeyjZwM880PqkhVtjzraC1dQAICGJdkYu04rAmT2JzPvsB4bqQKiNjJk8v0E0Bc2x6TxZLqj0ZLKvHixvHjpeYfJbCTqY/1mpvq1PQaajmkraaYShjxH3YGms+upuhaMar51RgZx/+D+Wj9n1pSNZzxbi2iAs2b1ik4C9XjBE+cJv4LGY4C38UAfJ+KvBDrvBB7l+txjkJDKNUQJSlK9bO5mfs/j6LFNseMSp3YEEj+yYA4VwTqrnQI6OFxneS0qZHvl2yc2rxcOSJHx4S7P7DgA4roid6Jm0FiwFdCFFL54aqZdG+KdfQXjpXhPJiJvyaPZXTZv1eXj/F14H5KIhnlVpBTF175hrGkLQOt1KXupIickRUIqlrpizpj5qAHAnf7bgszlYU+5wZmPPow9Qewrs6zYTb5VQIZj7l4nTUfjCUYE93r3DR0q7tKLdW/WvWjK2smrXE0/CLOGRb0ISMJZu+y7paN9YoCRQf87vdNAfnmCYtUY6g2mDgnQk4dFHdCb52i7b3Pp7yzyFehieFFTIOymYpZT3Lj6Pn3XC4U7H5n3DHtcy88RxJxlRmkk2OvklBq0dIlS8exnzgr6rxPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(346002)(136003)(366004)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(7416002)(44832011)(2906002)(41300700001)(4326008)(8936002)(8676002)(66946007)(316002)(6916009)(66556008)(66476007)(86362001)(1076003)(26005)(966005)(6486002)(478600001)(6512007)(9686003)(6666004)(53546011)(6506007)(83380400001)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1liWJe7BoyLxCQgU7nlPEyV4618oYJoIq6i6c5/wOUe9/dZ5xBr2i/9n5cKj?=
 =?us-ascii?Q?foRNjBZ1q4L+e1dGfjUn/DpcXQz5bwq9XrPsaY0Bhyvf7mPPcVGRCPm5XNNj?=
 =?us-ascii?Q?aU1WHCyabkModd1cqaPBdNRez5o+jVknS6EE77Thk4NZX6DQRBWoWfvTE5N1?=
 =?us-ascii?Q?tbrXg4koY4cPeWiA5plqA292sSKCguhxOWYkZB8AqvW+Mpqna+5ra80RWX3q?=
 =?us-ascii?Q?fmYiDaE4rqGa7Z5oODa5X3AmR/sKBY+RnxHSlHNHJpy4BHVjO6j4vXRfjhyv?=
 =?us-ascii?Q?yqjdVolP6KIY/4IB9aaL77SfE61sQ6LF9085db9//evoT+SNPKIFqYuqeaSM?=
 =?us-ascii?Q?qIKWb8y0yx0vAA4L78NxFBHtf0YiYsyuRFN3Y3OWLjSe0lPfEoaq9QpI3po5?=
 =?us-ascii?Q?H4AvxMui/Ihv3uqc1QncQG4oRv0W5U4+KseRRCmE1fz6zmHz/+GQnmZ3x0TF?=
 =?us-ascii?Q?pzA5A9s2VbruI02uWLJJj6JXQYxo46D+zhjdj3hYMBv5RfjmDHh6nmIHPX39?=
 =?us-ascii?Q?SNGlFDqWOukQqBeVJCMlzSwXhsAHaMclSPor7szAAv9/ZoONuCgxQlcdKKQK?=
 =?us-ascii?Q?k/0pFHVupDNra7C15TNGShRoVOy8fp6mLRNTzB8wAQiRHPFlPoLAp3c0vN2a?=
 =?us-ascii?Q?IB7oko7na8SCd4yCqHDhghQN7chCxDmH8NiU58/FA2f+WchrbAjT1sC4lMEZ?=
 =?us-ascii?Q?wvRJhzEC5CsAaMGSBVBJbPsydEpJhimN4HCHhHw4aB2re8FpZzwmLn3G9XYC?=
 =?us-ascii?Q?1dPpm7lMfxuWdX69ejNCpRqyQ9MnRx30HO6wrAB/2zQqKeliygUis0d+u8q9?=
 =?us-ascii?Q?keZIw0GdiO01gtDMiEzR0Fw3m4Fm10aLvblEcUU68ZzfJzEz7c7c1eQ/vwLJ?=
 =?us-ascii?Q?mR7H/AMwdXfgG4Ja/9voyN5W6ZWfIS4JloM6ynuMfAmj6xcDn2YWI5kROTa9?=
 =?us-ascii?Q?Ea5DWy+/xN/gEoOIIznLfRwvyLC7euucSRPr1J0pKqQuVTBOKf0wA4PnNu2p?=
 =?us-ascii?Q?DBzxjiQDlDQpjiZaAtATR3RLesloff9xfjIKSchx9eo3l/2ZguE2yTK4xI0M?=
 =?us-ascii?Q?XDvZr401RpAqIq8yGw8Z9l+Ys+qa5gNC2Xpc4b0Ft4EbVSKpjVgXSw3nGtMA?=
 =?us-ascii?Q?Cd4PeV99SMqBfBgVtY55yzXSX/IJQhbyLdBbLUn4My/+xq/cgzcJtDjBl+su?=
 =?us-ascii?Q?gYmIBXBLrXoliYR0zSFaTfJb/0zHPPSj9LI+BnrHjoB8IFWAZUlcB/1Ye76Y?=
 =?us-ascii?Q?Gz57nCVjzBUQFoonN8oBZupfaByiWN0MBSXc+LIqdzh4vkPbdZm3EPAmf3H3?=
 =?us-ascii?Q?UvXAFWGMKaE5OCPmPagBM2gODMiR6wYCDMnptcRdsWAQctLKTFXDi5o7JOmU?=
 =?us-ascii?Q?8YN2ln01YvPj9G3YS8uRSEc6JNZiW9h8S4HHiYv6cpgHzbkrKpAymqQ7K5eG?=
 =?us-ascii?Q?6cZsaPuiyatNfSpveMYk06GnNWz4so58MtEQN2/h0YbCf+qeqfEntkRLG7w/?=
 =?us-ascii?Q?0mcYq4pMb2hruqJAbVDYb9f6AmbZeqawdwnXCcLuwhqyZF81HfXsV2y/y326?=
 =?us-ascii?Q?b1xGmiVJLYRoFoKxumEM7KSk/S67EDOdwCVb7gUSxLnLHqHIlsGHlWTIhuAn?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35fffd9-8729-4d14-50a9-08dbea887372
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:53:17.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VA1du45u9yaqFD5U2FxEMx4auL1Xz32e3R9JKGra0OAhasbKqdNwa5b0lfNGHxokJTR0oK1JfXhs9HJyN5Ww6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:02:50PM +0200, Roger Quadros wrote:
> Yes I'm using openlldp master.
> 
> So I just dumped the "ethtool --show-mm" right before the "lldptool -i $h1 -t -n -V addEthCaps"
> and this is what I see
> 
> # MAC Merge layer state for eth0:
> # pMAC enabled: on
> # TX enabled: off
> # TX active: off
> # TX minimum fragment size: 252
> # RX minimum fragment size: 124
> # Verify enabled: off
> # Verify time: 10
> # Max verify time: 134
> # Verification status: DISABLED
> # 
> # MAC Merge layer state for eth1:
> # pMAC enabled: on
> # TX enabled: off
> # TX active: off
> # TX minimum fragment size: 124
> # RX minimum fragment size: 124
> # Verify enabled: off
> # Verify time: 10
> # Max verify time: 134
> # Verification status: DISABLED
> # 
> # Additional Ethernet Capabilities TLV
> #       Preemption capability supported
> #       Preemption capability not enabled
> #       Preemption capability not active
> #       Additional fragment size: 3 (252 octets)
> # Additional Ethernet Capabilities TLV
> #       Preemption capability supported
> #       Preemption capability not enabled
> #       Preemption capability not active
> #       Additional fragment size: 1 (124 octets)
> # Warning: Stopping lldpad.service, but it can still be activated by:
> #   lldpad.socket
> # TEST: LLDP                                                          [FAIL]
> 
> 
> If I add the following lines at the beginning of lldp() routine,
> then it works.
> 
> lldp()
> {
>         RET=0
> 
> +        ethtool --set-mm $h1 tx-enabled on verify-enabled on
> +        ethtool --set-mm $h2 tx-enabled on verify-enabled on
> ...
> }
> 
> Is lldp supposed to turn on tx-enabled and verify-enabled for us
> or it is test scritps responsibility?

lldpad should absolutely do that.
https://github.com/intel/openlldp/blob/master/lldp_8023.c#L701

Try to see what goes on and if there isn't, in fact, an error during the
netlink communication with the kernel.

Edit /usr/local/lib/systemd/system/lldpad.service:
ExecStart=/usr/local/sbin/lldpad -t -V 7
                                   ~~~~~
                                   increases log level
Then run:

$ systemctl daemon-reload
$ journalctl -u lldpad.service -f &
$ ./ethtool_mm.sh eno0 swp0

During the test you should see:

lldpad[4764]: eno0: Link partner preemption capability supported
lldpad[4764]: eno0: Link partner preemption capability not enabled
lldpad[4764]: eno0: Link partner preemption capability not active
lldpad[4764]: eno0: Link partner minimum fragment size: 252 octets
lldpad[4764]: eno0: initiating MM verification with a retry interval of 127 ms...
lldpad[4764]: rxProcessFrame: allocated TLV 0 was not stored! 0xaaaafd7cfbe0
lldpad[4764]: swp0: Link partner preemption capability supported
lldpad[4764]: swp0: Link partner preemption capability not enabled
lldpad[4764]: swp0: Link partner preemption capability not active
lldpad[4764]: swp0: Link partner minimum fragment size: 60 octets
lldpad[4764]: swp0: initiating MM verification with a retry interval of 128 ms...
lldpad[4764]: rxProcessFrame: allocated TLV 0 was not stored! 0xaaaafd7cfd30

> 
> The test fails later at "addFragSize 0", but that is because we don't
> support RX fragment size 60 due to errata.
> If I skip that test then all the rest of the tests pass.

Hmm, yeah, the test is dumb. lldpad has this logic, so if we request 0
it should still advertise 1.

	if (config_add_frag_size < add_frag_size) {
		LLDPAD_WARN("%s: Configured addFragSize (%d) smaller than the minimum value requested by kernel (%d). Using the latter\n",
			    bd->ifname, config_add_frag_size, add_frag_size);
		config_add_frag_size = add_frag_size;
	}

I guess that logic does engage, but the selftest doesn't expect that it
will, because it expects that lldpad will report back exactly the
requested value - and it will report the true value instead.

Luckily I know what to do here, see the patch below.

From 0ed218345f16a0f2c0efd5eba1838ccb3d8e4921 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 21 Nov 2023 13:42:14 +0200
Subject: [PATCH] selftests: forwarding: ethtool_mm: support devices with
 higher rx-min-frag-size

Some devices have errata due to which they cannot report ETH_ZLEN (60)
in the rx-min-frag-size. This was foreseen of course, and lldpad has
logic that when we request it to advertise addFragSize 0, it will round
it up to the lowest value that is _actually_ supported by the hardware.

The problem is that the selftest expects lldpad to report back to us the
same value as we requested.

Make the selftest smarter by figuring out on its own what is a
reasonable value to expect.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../selftests/net/forwarding/ethtool_mm.sh    | 37 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index 39e736f30322..6212913f4ad1 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -155,15 +155,48 @@ manual_failed_verification_h2_to_h1()
 	manual_failed_verification $h2 $h1
 }
 
+smallest_supported_add_frag_size()
+{
+	local iface=$1
+	local rx_min_frag_size=
+
+	rx_min_frag_size=$(ethtool --json --show-mm $iface | \
+		jq '.[]."rx-min-frag-size"')
+
+	if [ $rx_min_frag_size -le 60 ]; then
+		echo 0
+	elif [ $rx_min_frag_size -le 124 ]; then
+		echo 1
+	elif [ $rx_min_frag_size -le 188 ]; then
+		echo 2
+	elif [ $rx_min_frag_size -le 252 ]; then
+		echo 3
+	else
+		echo "$iface: RX min frag size $rx_min_frag_size cannot be advertised over LLDP"
+		exit 1
+	fi
+}
+
+expected_add_frag_size()
+{
+	local iface=$1
+	local requested=$2
+	local min=$(smallest_supported_add_frag_size $iface)
+
+	[ $requested -le $min ] && echo $min || echo $requested
+}
+
 lldp_change_add_frag_size()
 {
 	local add_frag_size=$1
+	local pattern=
 
 	lldptool -T -i $h1 -V addEthCaps addFragSize=$add_frag_size >/dev/null
 	# Wait for TLVs to be received
 	sleep 2
-	lldptool -i $h2 -t -n -V addEthCaps | \
-		grep -q "Additional fragment size: $add_frag_size"
+	pattern=$(printf "Additional fragment size: %d" \
+			 $(expected_add_frag_size $h1 $add_frag_size))
+	lldptool -i $h2 -t -n -V addEthCaps | grep -q "$pattern"
 }
 
 lldp()
-- 
2.34.1
