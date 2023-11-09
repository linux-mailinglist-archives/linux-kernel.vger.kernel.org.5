Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEEF7E6A83
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjKIMYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjKIMYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:24:50 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CAB270C;
        Thu,  9 Nov 2023 04:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIdrLtVx4MXknCDHwGWsQMARX8WeJinETGj5QfA4BQmSEkFPo2e3WaPNQ6qTDkYwT88KKEfbVLqvKZTIwXdBmD4errA2y8lBeBWIApHjopn6A6Xi3ZfcLy7/LStI1Xe3d5u/yoBwxa+DeYKi7x5FC7kfEu/x0XAjeGF2QBnc+xxWu+djTLWP+UScqO0m5dXt6V4frjif0TmQyYlKogyiczTgjPGaF05eXDdosVf5AhsyqizA+bxHFj8uCxB6TPmScSjVM3NwtYzJ266VEdmlIUVbaBA6s5uwXmmkR1GWcQeO3HouBei45NiZlYrUEEqkDOejA2Y9Cpdd9PyfrZNW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NAB6gKaDL3gmCh+X+BaXzw9RqDf0dShp0ugpawXMFE=;
 b=Sm1e8GBQDbQGQ7ZXK+tAvTJSMUPVVL5dRYi8S2vJ17mICMJo+ZWmvyLxjgYDUhvEtm8GHsp9PtPo325Rgs9X2Zrllbq9Te4L4/v+1sWhwWTD2LGuInpb5xJCfV38D3U3jwHPOSLI72jBAOCvIBJQ005DDWhyaIeuJrdFFKbq5RXO7yOUWp8QnvwbfiHrnMZs8d30mciuibMh5SNrqAvgqGV8my1GhhRxfWIUBnP5IMF9czEXZmr2JztUjdG/fV4nrtbS3yB/mUrW7ruah0Hl+TMB+HfoK3X5uiNy+7QMLlHwutbOXb+kJ0/uG2WkqBe7KPa2L8LaKMVYQLU2LokzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NAB6gKaDL3gmCh+X+BaXzw9RqDf0dShp0ugpawXMFE=;
 b=Y4YoZNKv49OBbQaauJxkVouqkC8UUSDB2iI3FA63s6DrrPHFKFxdLMspUqL3RNYE1r1R/iVWzCcXyTod9jEZJAWP6KrOIZL0tCI7ZtBTW9vAzuOXghEEBtKHE8fyJAH9ky1ZdCdEUwLTItQ1wtBXPv+g1iW7G4rwfStwWnc49X8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB7869.eurprd04.prod.outlook.com (2603:10a6:102:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 12:24:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%6]) with mapi id 15.20.6977.017; Thu, 9 Nov 2023
 12:24:44 +0000
Date:   Thu, 9 Nov 2023 14:24:40 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 5/7] net/sched: taprio: fix delayed switching to
 new schedule after timer expiry
Message-ID: <20231109122440.374wlo5oqk2eua5u@skbuf>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-6-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107112023.676016-6-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VE1PR03CA0033.eurprd03.prod.outlook.com
 (2603:10a6:803:118::22) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: c89b88a3-0cd0-4267-2146-08dbe11edaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gc0EEYPUBbiVTCKIa9TAFKgXrkjtNuIya0PL1ptd2M8V+ybWP+JL01N164LBpShtoUXFQHiMV/8i1FqeDieftJAvRzR053jp/uKakH7u7BJXScKVhGmCZ4UJDa47hY270jXnGCfWmtC3Iw0RplKowY89a27dCFGAo47uHlDxRM1j67TiWcB/AWagb/vdopWR7KRaBx/z8JLEZlL3facCi7qzeeqRYdl6k1INW9Lv+WRRyLSFG71wqW3uhOxMQyuR8F5lkGPx5tm7I9nu+ZBZqIa4uYkpEDU+/8Y3qILK7+vPsP4P+WbHA0uzyLREvuo9sLvFrFbtv5C+XnR7EYLrvlNeckbCUNcp3V3mdU8OtIMf5wveUIcw/kHYSOY2gCIxldNeauxoQ8+WUq+4YYvN2tae+8xEb43R2pjenTw3ZOBY0zXvOZtwzVAHIMXOFE0DxfKhtxg086VgKj718h7bM8YEmSg63JaXCUyV8+snzxZa0dNX8yGLUBfggG9PFp0Ku2b6H6AeNX8lKaqBzo2/Fq5CcVAHOqSoqdB3+fUSurEZbaWuqd24rhG84eR07ejl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(9686003)(6512007)(86362001)(6666004)(44832011)(41300700001)(33716001)(6506007)(1076003)(4744005)(2906002)(26005)(83380400001)(7416002)(5660300002)(478600001)(38100700002)(6486002)(66556008)(54906003)(316002)(6916009)(66946007)(4326008)(8936002)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b1HHd9TqojXoOKhiFvCEWze/yoWCe4R/92tmSI+39i3MJoieeRTaoIXFOD7a?=
 =?us-ascii?Q?N3B1TfJwk1wZ3KqATG+tSTka0bE1gzjggUlAGLxw2tJHG4SbUlXw6Kh8fwse?=
 =?us-ascii?Q?jZqXmdcuvN76hH27XsMf2HfnY9KRdowzfpdOsUH4zC98eTzCU4ESKxj7kLRG?=
 =?us-ascii?Q?QHNNkWtAs5TIsiu89xLWKgH+OxC202LOjj9WaRCZp6VTGJFd230mQcRTusfH?=
 =?us-ascii?Q?oyRe9apeqRvdQ7icpobq6n3LtNL39wYG0DWbvqjsYlJPYT1QoeKOFjQkzhIJ?=
 =?us-ascii?Q?npHVOFAj8zxOK3Qslg6y3qSuqU/m3jukSoCcM5HdPAkTVlhSQ3i3mGRPPcbn?=
 =?us-ascii?Q?3wJeCZ8A9xudlXfYWv9wRgh8S2aOOLfU9Pe7nkAEltRllmiKUun5ledoCPjd?=
 =?us-ascii?Q?kT5Z/bLpcFHMwT3PgOORd9yMh/X4Dg4vav1fFt8Rsjrv/1LjKyZcXXy/Ptx/?=
 =?us-ascii?Q?Vq4SdfseLOdEbAWPxMPUkzmp6QvbgzB5hQcd1c6Y3DkLzCB5Vg/4GtUZtD0i?=
 =?us-ascii?Q?YWEqxDBIUSzAMEBKnxg6xFH0N+8WEitjdY3wLadmndEiixr6oqZ5wf+tcEiO?=
 =?us-ascii?Q?jrI284g7Hdpd1vQRWbJGqzuUW9pdpZsVvRLIWKuNuUmsf7Tr92UROIRHU+a8?=
 =?us-ascii?Q?NCEe0Dzb9taTxyonEw712kdo1E8GFIg5Vs6zGR/O0oyM7U7bFqd4hI6g5ioQ?=
 =?us-ascii?Q?5EUl3kjB4xhvZiP5eMD8fsd1H4cSWzWfp3uAgqJjGqcMyz1eMWkoKAeKKjNt?=
 =?us-ascii?Q?OFgNzjAqPNk1qojY7l1f0QIbWwxVTZ4QBPcks9710Ld4324hYZbA069f4C/Z?=
 =?us-ascii?Q?cx6hSeqcMLUL6R+Nl8HPXbwBtU8KMz+dFQNbUHPYqvDKRA0S/jBRbksd3g7W?=
 =?us-ascii?Q?h1QxgoCb5FElD235DXXnpK28Nn8bqpw42xayx53mhIG3vxbze1WG0MXsrT5r?=
 =?us-ascii?Q?dQAYKVpSOb1o2ED7fGebeWJKG354zJSnBQypEhMqK2HSM/HR79CzvCRt3Y4B?=
 =?us-ascii?Q?qZBMFKEXw8iL0lUUWQ/cotslsFXlgjcXsOY0uIYPefyIuh1xicygswkvx6vA?=
 =?us-ascii?Q?d8mUqpuVJVAPuqhI0R578uAoeyjqby19XuCwg/7qA17VZhWQ7ZbvLMgjvhs6?=
 =?us-ascii?Q?lHyeiB5UWWvW3XEi0xT/OVyr3dEtC3VxA+x7S3kzbBwob9wLeoF+x8gC4lm/?=
 =?us-ascii?Q?Fu6t1aTHetl08IzgIFsLvmAM2eXd2LOoIZvpwuBkytOZ0eHf3TnWNrVZrpj0?=
 =?us-ascii?Q?kIn/thZm5wojWl/xVyaVcn7yHVI8EMXjUd9EdiYeUGpheBDZ9GXc/Sl5ufEr?=
 =?us-ascii?Q?J7u2zsi0f2EmA5fLEe/Rp+KSABMpUqhYicCHCZGC2SUkE3fgnnb3nrnNpsdG?=
 =?us-ascii?Q?jafO7OBdX9CjFhxwSXDeO4gS7LMjZr3tQG/NEEZSiTJPEPgipzcl4axJ08jA?=
 =?us-ascii?Q?rUfry6k9nNc2cz3rFUuSEZcNoiDMqk4xWGRqurWgcK/R2/bIk82jeHxNHQJp?=
 =?us-ascii?Q?8O1s4rI0SHpga0Cyfwwf0KRh7483xlQTpS9Bn64f9jhdo4cWGC307QaBhYQF?=
 =?us-ascii?Q?dmR81E7P2LIPO3EBAyuQigARG8e7FZDVEOz9o/8AqVetPBU+3jn895baOUxE?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89b88a3-0cd0-4267-2146-08dbe11edaca
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:24:44.0254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AulKrcFKzZywXPu0jKi9MEW+lRGXrh3Nliy+dGxYG5fvqL+wg6fsGnySa8fvfh9jB2FwuSsww3im6RHgXL2c0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7869
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:20:21AM -0500, Faizal Rahim wrote:
>  static void taprio_start_sched(struct Qdisc *sch,
> -			       ktime_t start, struct sched_gate_list *new)
> +			       ktime_t new_base_time,
> +			       struct sched_gate_list *new)
>  {
>  	struct taprio_sched *q = qdisc_priv(sch);
> -	ktime_t expires;
> +	struct sched_gate_list *oper = NULL;

No point in initializing with NULL if this will be overwritten later.

> +	ktime_t expires, start;
>  
>  	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
>  		return;
>  
> +	oper = rcu_dereference_protected(q->oper_sched,
> +					 lockdep_is_held(&q->current_entry_lock));
> +
