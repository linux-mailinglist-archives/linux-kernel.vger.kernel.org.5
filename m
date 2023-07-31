Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285C6769BED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjGaQKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGaQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:10:23 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB8E170A;
        Mon, 31 Jul 2023 09:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m66E7OsDt0yfVCBhXizEAiuFqGr1gTAx8qPE53WN3B9QB/IwV+jndNwe29589JoESFP6lNtNUJPq9XUFmHEf2NfulTCxJjFE8WPwIoByylwU+QOsb3xs4L7HegEjSChDh4Wf5ciFUSL3N80baH+6r0q1KCj6PuNAtgZv+Zm5N3/zdeq8UENJaWAsEkQFj25FqMwa6DXiDb8to9NXZn4qA0TM6nDqoLaLeKKZxKn8yeLIW8g2wJwlqKjhtoIoYmsv+ZprxqwGMl3hjWBMW/ZCo+huGcQ3qDGuLle/WYf5V/+uuvpFEVqgTsYNIe/ukg8zzEg/nbQIpGJwcYLNHNZCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBgatLdp3YJlj3oUR9816n3CVwQdIa5T3hEUXiMma+4=;
 b=h6SmZIoAFR16qOnOh1oCl8xJvvsGVTVd92CPOmhF3nsB2LyFe53XjnqZE1ZVdaodp35TNSKQplRX70hAWBoZhMYjL7Jw+tZlzBfZiZzE808nSKr7f8rRUQPUWCqnXWgL7DXbv6UK7IhCyGPMyBzItloHA8f0sQfdhTUu9AQcI68UdrONls76B2Q0nhVNb5BFkvD7SooA2KEywh+c4G3MdOQJeFEJYLbJOl/8kwTopDb1tc28aUuBmwjo7fdquCAvpRwelSMqNnsi7d435rPf42PTePx4BzBAkhwVzjpAAD+pdVXyFZ3Fxxc7LnDjU1P1JQ2iKGZRDQthn4khkKUwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBgatLdp3YJlj3oUR9816n3CVwQdIa5T3hEUXiMma+4=;
 b=HfBM/bex8ifZdALm07Yw6qvodb0gLCzwoTM++p0INqjcuMwN8BrLmCHqyzvON7k1ecjJtSlETUzPGWi/UXDMOnhIBB1jplgfhWQaIYG3Fp3zY40aOiGkfv4eHkcEjXrzNQRisPrW/++g/jkeRb8nTkPmWra3An7GptjYKCuwsu8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA0PR21MB1883.namprd21.prod.outlook.com (2603:10b6:806:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Mon, 31 Jul
 2023 16:10:12 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Mon, 31 Jul 2023
 16:10:12 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: RE: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Thread-Topic: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Thread-Index: AQHZwU0WNJnrG48S4EOlGyY6cNlaEa/TN7UQgACcb4CAAA6xAIAAJKKAgAAGaoA=
Date:   Mon, 31 Jul 2023 16:10:11 +0000
Message-ID: <BYAPR21MB16885EA9B2A7F382D2F9C5A2D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
 <20230731132714.GH29590@hirez.programming.kicks-ass.net>
 <87sf94nlaq.ffs@tglx>
In-Reply-To: <87sf94nlaq.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8ff996af-0596-4f62-8c0b-36733fa343c2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-31T16:01:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA0PR21MB1883:EE_
x-ms-office365-filtering-correlation-id: 35d13701-ae2e-40bb-d849-08db91e09e56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kmBB7v52J4ki9Pn0RZJjstjXphLcb0UrGkDxm955fnnQkLrbFNwHeh8+exaD8DkBRhGHHcWVAKqX+1s+D56sjjdJ3Jx02sXbnmw+ekAkvnBK+0uSgpbKc+3VWbMp2B1ysPPPN+RUkLK0MB48XnWG5YIQWkIMYS4be7rW225msaVUuj09t1sfu97Cq+3c/5M/ouHEFdqLRq68h6K5GI+HSZKYNBhtjhRyttOC7kRhMiIK6yJU6OO6Q2aDTN+90dG8ZSbtV/AdnekQ0PN6ZgK2kb166sEJSm0ulMWUr8u1z5WWkNXm56yMkPrrAItWb4u/vpILyXk//hpwvR3rQUMQlMJcoQ2Lvi3OU+lP/oCqaNl7Evje9Y0zXecYq1TF2lULjMLaAUqtCij83OOWZBirrRVjiWbjfCJ9S6EIXhskfGIKu78K6wDRfpXrHYI8i8Rc8TDuSox09OXBTQf2pbNgGoderqEdzaw4tMfup5d1VoWl2FyxZiJb1Y9tpp24uBTABYm+EgO6hAZVkNzyVNhsm4O82nR/iFQseNNnTXmErF/XEwSoHokydF8cwpj+KGhqa/dG+GzIyIOyWwWUW5GOix/XTqUxd9x0R1NQJENv6P7e1z7U7/E7u2PJAnPJ/RXt2WjAY2yJJFE80kOAfH+lfCP3E/a8yK+uxuAoLtbkWTA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(71200400001)(7696005)(82960400001)(82950400001)(10290500003)(478600001)(6506007)(9686003)(26005)(4326008)(110136005)(64756008)(122000001)(54906003)(38100700002)(186003)(76116006)(66556008)(66946007)(66476007)(66446008)(7416002)(5660300002)(8676002)(8936002)(52536014)(2906002)(316002)(786003)(41300700001)(55016003)(8990500004)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TdTZ9bArR41cs/lbL1rSIT2LQFH7C1Lw/tQSS82Aly6xucrTXrPkfs+GPh4H?=
 =?us-ascii?Q?3/GrsuVZhRS2N+M1t8UFOmEK6vzL3Pwa4iGI8jK2geBCwyZQeKxMzS1OivMF?=
 =?us-ascii?Q?lC4uF9ZrE4j72SkJf97ekIvgAI5fETNzrjsjygQn5ABxHw1Dee1+I7Hixdvy?=
 =?us-ascii?Q?AMSoX/lfVblhCrcqSLqyuj1dXBlJHfEsrbIlPMm5ofh14ZK2dsroLeI2I3M6?=
 =?us-ascii?Q?0WSzh1/XoPtBLkmEYr03uFGe/gJZR2FS2jspKQIYzPn5Gk/wpkK1r6Ii4Pup?=
 =?us-ascii?Q?fAig8BAohLwgblMgRUZmqGCy3Pr/OYeOEsHzDsxxcdMlG2kCxmA5glh3HM+R?=
 =?us-ascii?Q?/Yr3nZfFlgO2y0O3g61XwqRtkhZPUdxHAapuckeIVS5Ob+RWMzAc7SvCPFGd?=
 =?us-ascii?Q?w6Hsk8Y31YaFw4YVV4zsEzz7PhITIK1wRagQD2yQZid4rKsh//I+ljTpuGM6?=
 =?us-ascii?Q?L0hPsBgLSVXvIhdga5KVQxBWF6w4AEctRR/VVyN/SQ5vQWHGJcCkKR1IOfC/?=
 =?us-ascii?Q?/+1T723bdYT41Wr8P0PQaV7bhDDAuhHo8QRq6QOT2ML895e8TzIIANZkE83G?=
 =?us-ascii?Q?zOuhFbXDJ1CBwxIXg2i2Taaztjju4yycDphQCS+RM67zMiTUv/g9dISQLGeK?=
 =?us-ascii?Q?dRVQS7wE2YUKjve3bAkqBYOcVFyDXLc+P0hiShaUhvlfHCiiVFM6YuRDD7JW?=
 =?us-ascii?Q?/7IalJQuhlkum9XTa7W9vxZzzMFRckPbty7BD2NhUHNM/wgKmAUESbFV5VUr?=
 =?us-ascii?Q?NPVMJRBUjJE+VW5nUzrWr+iX+Ux49eszmYWjLlxEQOL9/wt0PGN8fhgHcV63?=
 =?us-ascii?Q?0qUOXfgnMs12Zlp2edutcNivvF16+x/8wlEmurjt4zVmVAuoey458phoWbAR?=
 =?us-ascii?Q?rNWCFR4s0kRDGK8HNNlJcryJPBnC4wEZ8+WCT1nXDv3D5/jgfiLa1UebseZI?=
 =?us-ascii?Q?nwCRjuDhCj1S/2uBAuOQDAL3nzLjsBJDBiyuKrcFllqqhv010bSa+SWZM4ZF?=
 =?us-ascii?Q?J08Z0tiSUBgMdLPIgZl1gMDR1zpIJBTLCp3whk+zwResbT09VO2jm/7glFGz?=
 =?us-ascii?Q?iDA2Q1/Q8q6+6FDZAUc4fzLW0EjXa9pHqCoGg32L03Xt+/PNIkdzxRfWh9Y4?=
 =?us-ascii?Q?yS2Gpi2zRBLZs901iybgTK3syOwYKgkvW36Ym4UfZu69r13syOKF//e/6K25?=
 =?us-ascii?Q?KqbVxi/XPW+UE7JY+hj81xUmHHzWee3jZr70WRbFTU6b69poU+0tLtqJZ/N3?=
 =?us-ascii?Q?Dh/aCskMy9gxxrEKiVtNKCdgEojIeKFx7kAvanOJgg+XFOMQ5YlSY1a1GgRs?=
 =?us-ascii?Q?ZFQooGifH/dYz4K//AQ/F4pdrRrvOKN3e1XBuL0l34qbs7YzFDpgGKwkdXlB?=
 =?us-ascii?Q?qn97eE9zxcyvRKDJ3aTKXIgNf4QJC+1Xvr8XMmNV9VwtW8+AI/gPCNMLa4FJ?=
 =?us-ascii?Q?ZcTR2tqSSqNHZzbFynedLZCi4kgEIcBoRYCbi/JrhwTy0kKvyqMN+aN6Z9+m?=
 =?us-ascii?Q?hS2z7AgWzTko4OuD421YkRSorWfTmN/QYUUZ16NpeMXBVca25OWqzVC9AYPc?=
 =?us-ascii?Q?RaWFJlqK07CAkJnImKOA3bVeb5PD99wwbOHEYgMmIiIn8vGxR1w0iFk5Bmmn?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d13701-ae2e-40bb-d849-08db91e09e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 16:10:11.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkSrmLBj+d0jIZiigzBsJ5QBNuGFxLvQP4a/eorCcJ/6mHtpbZtU1b/5ExAiE3S/OywiFCu/RwcwMJSf/DeUnmyKcrhmyt0l7RAvcwY/Y34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1883
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Monday, July 31, 2023 8:38=
 AM
>=20
> On Mon, Jul 31 2023 at 15:27, Peter Zijlstra wrote:
> > On Mon, Jul 31, 2023 at 02:34:39PM +0200, Thomas Gleixner wrote:
> >> This collides massively with the other work I'm doing, which uses the
> >> MADT provided information to actually evaluate various topology relate=
d
> >> things upfront and later during bringup. Thats badly needed because lo=
ts
> >> of todays infrastructure is based on heuristics and guesswork.
> >>
> >> But it seems I wasted a month on reworking all of this just to be
> >> stopped cold in the tracks by completely undocumented and unnecessary
> >> hyper-v abuse.
> >>
> >> So if Hyper-V insists on abusing the initial APIC ID as read from CPUI=
D
> >> for topology information related to L3, then hyper-v should override t=
he
> >> cache topology mechanism and not impose this insanity on the basic
> >> topology evaluation infrastructure.
> >
> > So I'm very tempted to suggest you continue with the topology rewrite
> > and let Hyper-V keep the pieces. They're very clearly violating the SDM=
.
> >
> > Thing as they stand are untenable, the whole topology thing as it exist=
s
> > today is an untenable shitshow.
> >
> > Michael, is there anything you can do early (as in MADT parse early) to
> > fix up the APIC-IDs?
>=20
> I don't think so.
>=20
> Michael, can you please provide me a table of:
>=20
>    APICID (real/MADT)		APICID (CPUID)
>=20
> from one of the tinker VMs please?
>=20

The VM is an F72s_v2 in Azure running your patch set.  The VM has
72 vCPUs in two NUMA nodes across two physical Intel processors, with
36 vCPUs in each NUMA node.

The output is from /sys/kernel/debug/x86/topo/cpus, so the initial_apicid
is from CPUID, while the apicid is from read_apic_id() and matches the
MADT.  As expected, the two values match for the first 36 vCPUs, but differ
by 28 (decimal) for the remaining 36.

initial_apicid:      0 apicid:              0
initial_apicid:      1 apicid:              1
initial_apicid:      2 apicid:              2
initial_apicid:      3 apicid:              3
initial_apicid:      4 apicid:              4
initial_apicid:      5 apicid:              5
initial_apicid:      6 apicid:              6
initial_apicid:      7 apicid:              7
initial_apicid:      8 apicid:              8
initial_apicid:      9 apicid:              9
initial_apicid:      a apicid:              a
initial_apicid:      b apicid:              b
initial_apicid:      c apicid:              c
initial_apicid:      d apicid:              d
initial_apicid:      e apicid:              e
initial_apicid:      f apicid:              f
initial_apicid:      10 apicid:              10
initial_apicid:      11 apicid:              11
initial_apicid:      12 apicid:              12
initial_apicid:      13 apicid:              13
initial_apicid:      14 apicid:              14
initial_apicid:      15 apicid:              15
initial_apicid:      16 apicid:              16
initial_apicid:      17 apicid:              17
initial_apicid:      18 apicid:              18
initial_apicid:      19 apicid:              19
initial_apicid:      1a apicid:              1a
initial_apicid:      1b apicid:              1b
initial_apicid:      1c apicid:              1c
initial_apicid:      1d apicid:              1d
initial_apicid:      1e apicid:              1e
initial_apicid:      1f apicid:              1f
initial_apicid:      20 apicid:              20
initial_apicid:      21 apicid:              21
initial_apicid:      22 apicid:              22
initial_apicid:      23 apicid:              23
initial_apicid:      40 apicid:              24
initial_apicid:      41 apicid:              25
initial_apicid:      42 apicid:              26
initial_apicid:      43 apicid:              27
initial_apicid:      44 apicid:              28
initial_apicid:      45 apicid:              29
initial_apicid:      46 apicid:              2a
initial_apicid:      47 apicid:              2b
initial_apicid:      48 apicid:              2c
initial_apicid:      49 apicid:              2d
initial_apicid:      4a apicid:              2e
initial_apicid:      4b apicid:              2f
initial_apicid:      4c apicid:              30
initial_apicid:      4d apicid:              31
initial_apicid:      4e apicid:              32
initial_apicid:      4f apicid:              33
initial_apicid:      50 apicid:              34
initial_apicid:      51 apicid:              35
initial_apicid:      52 apicid:              36
initial_apicid:      53 apicid:              37
initial_apicid:      54 apicid:              38
initial_apicid:      55 apicid:              39
initial_apicid:      56 apicid:              3a
initial_apicid:      57 apicid:              3b
initial_apicid:      58 apicid:              3c
initial_apicid:      59 apicid:              3d
initial_apicid:      5a apicid:              3e
initial_apicid:      5b apicid:              3f
initial_apicid:      5c apicid:              40
initial_apicid:      5d apicid:              41
initial_apicid:      5e apicid:              42
initial_apicid:      5f apicid:              43
initial_apicid:      60 apicid:              44
initial_apicid:      61 apicid:              45
initial_apicid:      62 apicid:              46
initial_apicid:      63 apicid:              47

Michael
