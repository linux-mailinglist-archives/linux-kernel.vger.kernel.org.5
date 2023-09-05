Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3A79262F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348499AbjIEQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354297AbjIEKhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:37:25 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013013.outbound.protection.outlook.com [52.101.54.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CEA199;
        Tue,  5 Sep 2023 03:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOdxZwm2fyltBhoYGrKMnm4Q1hAA7uVS/6vHKJwwpF6/axX52zpQF+trNbZGyzDRP7LmWlV+HB0lnGVWdwbeRxoegnRuQMbL7H0z+zqoKjZASF6T0oJayBlou7RTOezinFFBbP/Q6+rxW5jmrLbRoMEoWEwEnzPFY8snCM6Ai0meMCPfkCN+h9LBMkaWnHhr8cOBpPGA3L2p8n1olbzxLNp8ae1K0dNuotdlimCb0DDEeDU2UX2RA1tomjXbX+5gQxq34GlGZNbX8sbxgiBxYVG2T37r/aidU/pwndhiopkz0T8RrclS4ohczMd6td1aA+UNPx37slZcFu5SfKWT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUISHXSXZ9Ka1jT+VGMFd+gcL1cCJCxUY/PqYIWOIsQ=;
 b=n+b+/dtG5C7xmmRWYzWf2wyzUXpmYhwCAXSkLFjTULeRUg58/1x/+hVSKbMWkOo/tUvBoLp4SAND9fdQ3orR3XybViX9ZRAf9RGwN7M1Eqbfw7EZ4w8r/HZEloHikGqq36IW5gG8ZVnGKP+k+Vy+7/uDUnJNbtSKq9AWXV3MrfkI7u3aMOAwca6WqhCUoMPchIq5AZG8f3aohveahZoYqHJuhg9FvgC9aMfsuHQGWP91IwNwBci1A00IOOYBmtougn5vhXt/w+oGQAFUj1lnuoKNxDc7BWq19ZILF3H0Rzk/rCpDfdjfiR2PQcD/uMNhUVDBUGDWB/bAyN5bwIrsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUISHXSXZ9Ka1jT+VGMFd+gcL1cCJCxUY/PqYIWOIsQ=;
 b=jafF78x+qVpPc6vwegmRwczjfHAsBxTPDEWTGlfFNPJkdiE0QkAYqlv3DMBFs3b4zjlyONTRY8WQcG64DJ19V0zungQHL6GvYc4/1lbepzu1LqLySnOt54xGE0P71N2UkZNFf2uPJEud7ZH0dAj+O1tIRFan0lh0iIY0tRIegfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB4982.namprd05.prod.outlook.com (2603:10b6:a03:a3::31)
 by SJ0PR05MB7853.namprd05.prod.outlook.com (2603:10b6:a03:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 10:37:16 +0000
Received: from BYAPR05MB4982.namprd05.prod.outlook.com
 ([fe80::c1f7:4ed:2680:f088]) by BYAPR05MB4982.namprd05.prod.outlook.com
 ([fe80::c1f7:4ed:2680:f088%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 10:37:16 +0000
From:   Quan Tian <qtian@vmware.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quan Tian <qtian@vmware.com>, Lars Ekman <uablrek@gmail.com>
Subject: [PATCH net v2] net/ipv6: SKB symmetric hash should incorporate transport ports
Date:   Tue,  5 Sep 2023 10:36:10 +0000
Message-ID: <20230905103610.3087983-1-qtian@vmware.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To BYAPR05MB4982.namprd05.prod.outlook.com
 (2603:10b6:a03:a3::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR05MB4982:EE_|SJ0PR05MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cf7112-64a8-4fd9-c5b1-08dbadfc12e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2ZJY7KxFfTQHT2E7UTvfJ1N0B/cRyiDQ/pUkgmFxQgZ1qM+QzitNJE4mscj2foINtY9Pc65NaJSbiNceQAIbeWmqt5lLpxTvb+8ApBDG+0bjtUxSrAV1ePvZpyj1BPK5R79NOlQrqQhnpKJRjWGT3heKUcFq0SQgleCQCR/gf/WEXpNbAtvrZg2dy3hNre4stqeGccvb6PMQG2ca5Xm6Wpwj8m7J1h3lyF+bK38D1WUWFsOA0S/N2JSewOd+6BC1ygopNVU7ouLHWgmoI8fsCqfdADZSTEp2Fz5jQ9X/Qbl2dBVRav5AyximfiCxsUFMqx7zTyVp6vWPUCUONHGezGGLqSZMrP8S2oG4CDFm6+NRfPsz+LIXVlOHSKurIA8scnPu7gzdv0S1c55ubWSduBDGcj2rYDb7WDMelNEcKlk2QKKguWGirk1aLhkYR7EoeCHXQerl63LSzEoi3eWYfVghc8RgLCX/MVa9HMUNdEe7Pt/t8HBhGlBkvLfR0i9wxgTYblhrSi662QEwfXdcd+01Fjwu4Pi40xhFm4qR5zCW9w36tAU5IW2rnTWExDrFr1EsxJUPgBULgAAEFy+IiEXcze+BCt/UNUTAVmySKs67QPuS1Gseyz7nPWgRAF7/NxvNnHeap7mhy3nTeMS4NvTpa5SfFmkqHyod/cM4y1WzH15YAlT9uB9scvLIzwjr1n9bF1qM+q7pyZbKt1doQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4982.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(6506007)(6512007)(6666004)(52116002)(6486002)(36756003)(38100700002)(86362001)(38350700002)(2616005)(966005)(2906002)(26005)(83380400001)(478600001)(4326008)(66946007)(8936002)(8676002)(1076003)(5660300002)(41300700001)(316002)(54906003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yu6VqXK9o/yl7e2eAb4NFuxVNLt96LtKzQgpc3CxSCpc2zC65e0DNX/N1Ydw?=
 =?us-ascii?Q?Bgw0ztp1LVeRFvUdOSMbC0L9wzXRXb2h35NWZVQs32xTbF5VAtviEeSoIk7M?=
 =?us-ascii?Q?bBO9RjifhMWcD8zhQaevx+zCzuDq0tarVtzkprqraXeuDk00iof6r7AUYUn0?=
 =?us-ascii?Q?bl1hUxmGwQu7EUbtI28nU/lFv6Rw7Rq2CjbZW7GUdUSL4fXyH/mEC6WQkmq5?=
 =?us-ascii?Q?3NU/3AVe9HA6KS+2eXTFN/ofVtniGkoLdBR+b2A15A90MdALMnykuxvtju7w?=
 =?us-ascii?Q?vkNAkswHrLMPAb5nBpvTxpEbbVCgWA0jmu15Kos1Rb7WH2qYwGx64pwd+3H4?=
 =?us-ascii?Q?F6Vi8QFhjiWBDumG3aQQ0PckivO6ccQP1Q7+gBo9zfPPMh2wgMtMI7dg0hdG?=
 =?us-ascii?Q?owFuk77htMGeGrlMOeVtaIvW5MpCG3vqXqutzePQOrhMb56f5XM+dxQ7O9UM?=
 =?us-ascii?Q?v6kATV/Q3ryVa1sSi48VMrx+W1dGi0hSHSs8vx2kg7/CRwlxAQ+xnCb8D8y9?=
 =?us-ascii?Q?Or16etma6Rb5oApKrS2ph8/86jwhN7i/KxNcQmoJdANP3LXXAoa0iVfks3AP?=
 =?us-ascii?Q?pyqTq+hUIL+yUYgRar5BZwL9VTuOq14A+enzrX+u1OAMGFb1HGO9ZsLrTgd3?=
 =?us-ascii?Q?DRih7Pf7ezbeY1uDvhAzCVb9aKCdbLDCbVMEosNjvfMHJyZwjo8E/B9ZZuCV?=
 =?us-ascii?Q?OsFxjX/X4/BBKuL12FjNRoGE6yufIzKWmakB/LpEGoOFduRq/cmJAOzjPzze?=
 =?us-ascii?Q?bUwlnrFxujcdLEZ0fNmZVSL4mR+VXl6uPLL1fCFxvRYW+zCvMdCky9pZuT8+?=
 =?us-ascii?Q?BXX44R6LkXU2a3tcMA0j2TWhYMOMfKmZ7J4P2WCYWUXlN1I90StygRZq5wuh?=
 =?us-ascii?Q?UWeRPPJHJSy3uVpxx2v6WY+zvE+i7hDtIz0tHFfYQ+qWX15sm9960zSG1BbV?=
 =?us-ascii?Q?qDlQF0MCS5tFjIZKfLHONoBmV/8yRW9WoWBax1FzU9hiJnnAtvL9YvJFAty4?=
 =?us-ascii?Q?ZknM/VLvYvDc0OKW0qfksLINPMZm5T2qOLRel2Xym2Mrl2AMw7QnRCRxN8MV?=
 =?us-ascii?Q?NIo4+NVrKRY26CID5BncepawzsnVKUQD7e+5VZFxMSDWFjGx3Ai7UVmOLLws?=
 =?us-ascii?Q?wyOarh3z2iY2ekGL5Y/s60jT5rSa4HKuiVLLieSauQ3h40oBOMdCK9+hU/Bx?=
 =?us-ascii?Q?xK8T6Fj9fsxt06bNJoovvS/3KTenM6TmP6yz5+fLVb2kq+CJ66x44hJ1eBLp?=
 =?us-ascii?Q?gLM1Z06oYq6BZrIsn1Eu86tCNSO7m8PKREortdhf3Iw3Xe25IrtHyz9LsMaP?=
 =?us-ascii?Q?lqKtZrLMwzwEYY+3Ap29d7T1N3dG7qwT2HEFEKL1oOcNtjObd4GDIsU6XwzX?=
 =?us-ascii?Q?e8YGbBLYDk9GStWoUOW1jj2KPRPg0463K59cN9EPLkvN3Qdc0QjUrTZLECSn?=
 =?us-ascii?Q?Iyr8XX9d/NZ9/8hE9Pgj7y3gFwQ6P+UIopOW1Pk8ts/ia2vSHO9QDPnHdCPT?=
 =?us-ascii?Q?hEjCVuUDmN28kyOUvQu9WFmT5bMTfVensVgFFJ+IZI8Cm/no4Lpdizg3q9Vg?=
 =?us-ascii?Q?/rz/HtxjvWKqLkG40+tJQcBXNvqpvcBcTLaifMK3?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cf7112-64a8-4fd9-c5b1-08dbadfc12e4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4982.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 10:37:16.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lq1dE9IFOZ1oHvyP8QfGw7z4yhzgodvxpoaYqd3JCDwXL4R3tL8ubqx4R0xvY59ku4LaswvmGRydP43mQTLeXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7853
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__skb_get_hash_symmetric() was added to compute a symmetric hash over
the protocol, addresses and transport ports, by commit eb70db875671
("packet: Use symmetric hash for PACKET_FANOUT_HASH."). It uses
flow_keys_dissector_symmetric_keys as the flow_dissector to incorporate
IPv4 addresses, IPv6 addresses and ports. However, it should not specify
the flag as FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL, which stops further
dissection when an IPv6 flow label is encountered, making transport
ports not being incorporated in such case.

As a consequence, the symmetric hash is based on 5-tuple for IPv4 but
3-tuple for IPv6 when flow label is present. It caused a few problems,
e.g. when nft symhash and openvswitch l4_sym rely on the symmetric hash
to perform load balancing as different L4 flows between two given IPv6
addresses would always get the same symmetric hash, leading to uneven
traffic distribution.

Removing the use of FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL makes sure the
symmetric hash is based on 5-tuple for both IPv4 and IPv6 consistently.

Fixes: eb70db875671 ("packet: Use symmetric hash for PACKET_FANOUT_HASH.")
Reported-by: Lars Ekman <uablrek@gmail.com>
Closes: https://github.com/antrea-io/antrea/issues/5457
Signed-off-by: Quan Tian <qtian@vmware.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
Changes in v2:
  - Add Fixes tag to help automation.

 net/core/flow_dissector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 89d15ceaf9af..b3b3af0e7844 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1831,8 +1831,7 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 
 	memset(&keys, 0, sizeof(keys));
 	__skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
-			   &keys, NULL, 0, 0, 0,
-			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+			   &keys, NULL, 0, 0, 0, 0);
 
 	return __flow_hash_from_keys(&keys, &hashrnd);
 }
-- 
2.42.0

