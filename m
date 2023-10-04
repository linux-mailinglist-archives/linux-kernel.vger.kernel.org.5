Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1187B8018
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjJDNBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjJDNBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:01:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444898;
        Wed,  4 Oct 2023 06:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVaY0awV10POTH6UU1xzglcOOatTyHkkvPfMR3DYwHHF23XkWI+NwzUwPFykQ1r9BsjfGrRz7hMJ6tw2syEQ5TR6AWN9FGfbBLeI22v7lzeVUSh2abrVUR4pDHehzDPiaxtnmDBga1h/KJIbcWDefBccLeiCdulYN0ZOtLuI2IIUR7fRmm+VRBuBavbU/dLRT0M+G7JhGaIg3fAWWtW3NY0YLscgqwBXA8sKNLhgWvW1o7ZKcvE/8CSJz4UMRmZW+o/OH0B4CCHAcrwobm+6fInzJuj2ie762pIov2bQDbaZGdPVStOXiHrb0woJyjQqCPkTkGcCBjd4qrSdeRLZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAbL2IGkdSdGgWdFfT7Q2phYq7h5/rIL/A7UKqEgurY=;
 b=kH5jcJ6R50cJqsZqc+kqbB3hZCoZ2uF/4TlnmhRJjQp7W2G8ymCGmGkB8Ky5HYGvvk/Fw25/2DmpOwreI9fBQv7NSfUtMjxzqpAxnQSTeIDM4kZAUekEvN2V9GvKo1uPTP77veQjqKJIAbTHjEsgQJZqtDWHoik8cn12AqvaYqfYD3LbwOfkVkbFnTjIkdLGirRhmFMtDSOSZ+c/QDqvleLu3ecE3/JQujw0k9yod2SPWeAxr6ABajsctDbzDuF+zO4TT5VBqkpgSVMJNOQdETdglmW9huGvh3BP1JlZzczPbHgf85oaEFHGrCk7ZcM5jvdCgmxbZE7cWqKrrKqQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAbL2IGkdSdGgWdFfT7Q2phYq7h5/rIL/A7UKqEgurY=;
 b=ENPr5Pq0kzSGTSYZhF8ryB0SYH+s+W+UIPrrb7DF8l5nxo4B1R94tzH34/mnTMCw1qoLvSS3JkxhE8IV+Jk6v0lv43Vn48GvPVTWdUUp9ss/YlnrkrjgIvZag2sSPcqmMW/OO2L3BdNnXLvGeJnTHZY5zp8Oe9C2HqfOy05Au88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB6547.namprd11.prod.outlook.com (2603:10b6:510:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Wed, 4 Oct
 2023 13:00:54 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 13:00:54 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>,
        Olivier Souloumiac <olivier.souloumiac@silabs.com>,
        Alexandr Suslenko <suslenko.o@ajax.systems>
Subject: Re: [PATCH v2] wifi: wfx: fix case where rates are out of order
Date:   Wed, 04 Oct 2023 15:00:49 +0200
Message-ID: <2534699.vzjCzTo3RI@pc-42>
Organization: Silicon Labs
In-Reply-To: <8734yq7dg0.fsf@kernel.org>
References: <20231004123039.157112-1-jerome.pouiller@silabs.com>
 <8734yq7dg0.fsf@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SA1PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::8) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH7PR11MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a3ec1c-a458-43e5-0db1-08dbc4d9f17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YcpGEl1ceq7LO+mLRbXPU0oFtANjSdfttSEfhZq/wKvK9uIinKqhIqTqR15+KqeOx/IEoSdzMMOBgJiBTrn7pHSVTaathC3Gy6474r+HH/L5tAr2ghr33VcgEIGg7f6gW86KCoXhj6fzqbEtaeRGys+GmHpWDOCpvRG+Uh/JwnJ+C/xQ5jHQ0hXRKzqIOyJYlbdFIkFQ+D4O+67QhCq2g1sGBLxGpXYkCTtdr/85jAqqcr9E1oAOjf5WR3D1QmQ6Us8MWYwyyzKzeIOZiXsjtiw81F9jxAIuozuZwyUEN3JqvburQSIn7QZNqtyGueG15BWUzOs7WS/o0/Wl1zU43P83ZhkccQn7v7ThYpY4/1jKsKbeKjkJQE+Zq08R0t3Eu1QP7Qlg10UdapSAmkKt/06rROhmxSZ7Wo9o2qfdF+nRBM+AmGEjXo3OY53FlnvMMvZ3iT9Xlnwsw5ZyBZAGOKfNkz1QUCpEpyvuSNkWVwws1zQzJJDM3l++JkGsHhT6oekQlXFS/Wo3nRq5winBGLZv/qChJexZ0oxdlVbDWafsKZLx+st6vxISn42q4dsAe2iquT2DcudjUNu5+BEQU9joJGz3j8sYKeeWMup1aOlFPFO28WRMuXq4OWeNlwy3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(39850400004)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(33716001)(6916009)(66476007)(83380400001)(316002)(9686003)(41300700001)(6486002)(4326008)(2906002)(478600001)(66574015)(6666004)(52116002)(66946007)(36916002)(54906003)(8936002)(66556008)(6512007)(6506007)(8676002)(86362001)(5660300002)(38100700002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Bpax8I+sDQivjvFQDycO+2zX3Ebxbea+zrMWGhYZJDg44RC1f6uxn7l3eH?=
 =?iso-8859-1?Q?ExOQaYah71gC+J/S6kYew/3cE6dadwqdMPQ0Nd+QDAA6dP5lRJXwRD3OtZ?=
 =?iso-8859-1?Q?fa8tOV0gDvk8ITEMpa5KhjDGx/btRJ2Cgx15EbVAoR5geeY8Ws1H8tU70w?=
 =?iso-8859-1?Q?GL4RHmX7JPxETIkYTc3IZ4Ui07q7E4ReBh3Lc5Zw706NiXLklyChnYLnAj?=
 =?iso-8859-1?Q?syrx0I0tl2o0tF8V10R0H+xq1lobfluMx59wBXyeWNe4hA/6nGi6NZbIpx?=
 =?iso-8859-1?Q?9sqlMxRiAvyQ13xTKeVDToY8eLifouR8VRrCyNLtwcHKGGgWUvFcMyuRFa?=
 =?iso-8859-1?Q?JA2gw6Pxm9mT5oB8r8BaFwS+Dsna9MpqPqnqjQGcBWDYl+KTeys2SUfs8O?=
 =?iso-8859-1?Q?zUp7uLBaN2Tsbalbh+v89eJATplJ6zY9Zs4IM0fHD5YxrLvwZIVvbeKGFT?=
 =?iso-8859-1?Q?yR3bqpIGVsxZXxD3FFwGNBlyNHUJWczqNZPmKpl8b8WV8yBo49FpNOvTUA?=
 =?iso-8859-1?Q?L1QASS9lt40/SzJBMDx2VGypteqa1E0PBYyvUyHv+DZVJKvYSsp7xjezPo?=
 =?iso-8859-1?Q?pdqTjuk8tcYqcjucDMicz9NGInCJV74masarTxs+LGpkSsJO8AxR+KOItQ?=
 =?iso-8859-1?Q?M6dWhcLvLJEB1a3RhIV7eThP3Wdl8riJVE5isD5ezCiB8XE9qwDl+G8Jw7?=
 =?iso-8859-1?Q?/ntSRq0iZfmKCyvxhHheHNiCfwXQ/MQprpaRxcQsM7yF5F1H0KOLYGXn3y?=
 =?iso-8859-1?Q?STRPeWMRJH7PVztjr6q5WgJGbOGIEbDLnyADVINET+O8sBXxG85sn7YhEu?=
 =?iso-8859-1?Q?mLdm+4ZURLMqygahGxsaAjDKm7A68psThhb/peqDfxpLNLrxm85M/5pH5f?=
 =?iso-8859-1?Q?W/Bvih8uhvcpMswB0I6DTNKsVpA7Am6oqCWXWRNJmhedrvSi4kx2LqYEX1?=
 =?iso-8859-1?Q?AzhBrXYm7EYSb/2vtk56CCD4hSH8NKqyt81BZsihA2r20WhWIyPtwlZp0A?=
 =?iso-8859-1?Q?EZQOC8ILFplMtFF5248LYI4meQjX2IBO1ucAQTZYxmRqKTku6221w1kGue?=
 =?iso-8859-1?Q?5kCHGRXHRLfl/5dY+SByi9XRVMfIGXd5JFY3m06h2zDfkZbZFb83/W4KGK?=
 =?iso-8859-1?Q?YmVcgRzfEgrRGnxcNsM0pGuDOFZyrekoC0dH0MLu7UF2ZnTmm3VzK7aVLw?=
 =?iso-8859-1?Q?YNHbcPFeuYPARAt2ijeZ0+7KkRJMEvVvF+JGAADPaoauUkITepZ8Am3SAE?=
 =?iso-8859-1?Q?fCgo72XCxmclhWSw/WIYjwG4IHiNPY9YOe7Mc5RDsyCoSIKYcu4b9PAG4V?=
 =?iso-8859-1?Q?Kpd/Q4b4sIn1YOdeTeanBOHv4C5mbBnLzMBlKHiMAoFVkMCNQtwZnqnziI?=
 =?iso-8859-1?Q?mhuyiDQYpHKCykCWUJZghOEWaM/nqv1ZNH07pZJ8/WF5/qY71JsLjTAYHc?=
 =?iso-8859-1?Q?rxBy/ohUGnEhejvc9xEP5wj60LUYq2tmxaAk32p3BM5M2UTMe1sBGw0dM3?=
 =?iso-8859-1?Q?AEtKvwziT7OD/Rxc/o2743jcy1ZSl2mjv+bYAvfbCDs21OLyMaqopbTGP0?=
 =?iso-8859-1?Q?qBZ+7eIaFbPKbBE//USMwjtcA8z+U5PfSNbYseN59XwsUJY/oawffU9IIo?=
 =?iso-8859-1?Q?GZt0CtOgvUj5uyqf1tKCCcZ5RhVVBkqLDM2/gGODa6HiX38kNZxCn+wJ9w?=
 =?iso-8859-1?Q?9rsnnXtuf50GHIXtIbTLrauab41UbKGUnyYk33Ua?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a3ec1c-a458-43e5-0db1-08dbc4d9f17e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:00:54.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53mVJJewFTIZkwA0FvqZCd6m7dz0iuMQZtTwXyvGH8A3Gq8fG02hIrrM1LxRmeMTAZXlF6xX7437BGMr/6/5RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6547
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 4 October 2023 14:57:19 CEST Kalle Valo wrote:
> J=E9r=F4me Pouiller <jerome.pouiller@silabs.com> writes:
>=20
> > From: Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>
> >
> > When frames are sent over the air, the device always applies the data
> > rates in descending order. The driver assumed Minstrel also provided
> > rate in descending order.
> >
> > However, in some cases, Minstrel can a choose a fallback rate greater
> > than the primary rate. In this case, the two rates was inverted, the
> > device try highest rate first and we get many retries.
> >
> > Since the device always applies rates in descending order, the
> > workaround is to drop the rate when it higher than its predecessor in
> > the rate list. Thus [ 4, 5, 3 ] becomes [ 4, 3 ].
> >
> > This patch has been tested in isolated room with a series of
> > attenuators. Here are the Minstrel statistics with 80dBm of attenuation=
:
> >
> >   Without the fix:
> >
> >                   best    ____________rate__________    ____statistics_=
__    _____last____    ______sum-of________
> >     mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(pro=
b)]  [retry|suc|att]  [#success | #attempts]
> >     HT20  LGI  1       S  MCS0     0    1477     5.6       5.2      82.=
7       3     0 0             3   4
> >     HT20  LGI  1          MCS1     1     738    10.6       0.0       0.=
0       0     0 0             0   1
> >     HT20  LGI  1     D    MCS2     2     492    14.9      13.5      81.=
5       5     0 0             5   9
> >     HT20  LGI  1    C     MCS3     3     369    18.8      17.6      84.=
3       5     0 0            76   96
> >     HT20  LGI  1  A   P   MCS4     4     246    25.4      22.4      79.=
5       5     0 0         11268   14026
> >     HT20  LGI  1   B   S  MCS5     5     185    30.7      19.7      57.=
7       5     8 9          3918   9793
> >     HT20  LGI  1          MCS6     6     164    33.0       0.0       0.=
0       5     0 0             6   102
> >     HT20  LGI  1          MCS7     7     148    35.1       0.0       0.=
0       0     0 0             0   44
> >
> >   With the fix:
> >
> >                   best    ____________rate__________    ____statistics_=
__    _____last____    ______sum-of________
> >     mode guard #  rate   [name   idx airtime  max_tp]  [avg(tp) avg(pro=
b)]  [retry|suc|att]  [#success | #attempts]
> >     HT20  LGI  1       S  MCS0     0    1477     5.6       1.8      28.=
6       1     0 0             1   5
> >     HT20  LGI  1     DP   MCS1     1     738    10.6       9.7      82.=
6       4     0 0            14   34
> >     HT20  LGI  1          MCS2     2     492    14.9       9.2      55.=
4       5     0 0            52   77
> >     HT20  LGI  1   B   S  MCS3     3     369    18.8      15.6      74.=
9       5     1 1           417   554
> >     HT20  LGI  1  A       MCS4     4     246    25.4      16.7      59.=
2       5     1 1         13812   17951
> >     HT20  LGI  1    C  S  MCS5     5     185    30.7      14.0      41.=
0       5     1 5            57   640
> >     HT20  LGI  1          MCS6     6     164    33.0       0.0       0.=
0       0     0 1             0   48
> >     HT20  LGI  1       S  MCS7     7     148    35.1       0.0       0.=
0       0     0 0             0   36
> >
> > We can notice the device try now to send with lower rates (and high
> > success rates). At the end, we measured 20-25% better throughput with
> > this patch.
> >
> > Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
> > Tested-by: Olivier Souloumiac <olivier.souloumiac@silabs.com>
> > Tested-by: Alexandr Suslenko <suslenko.o@ajax.systems>
> > Reported-by: Alexandr Suslenko <suslenko.o@ajax.systems>
> > Co-developed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
> > Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
> > Signed-off-by: Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com=
>
> > ---
> > v2:
> >   - Fix malformed tags in commit body. (checkpatch still complains abou=
t
> >     missing Close tag, but the bug tracker is not public and I don't ha=
ve
> >     the exact URL)
>=20
> Just out of curiosity why does the checkpatch complain about a missing
> Close tag? I don't get it why there should be one.

I am on top of v6.6-rc3. I get:

    $ ./scripts/checkpatch.pl -g HEAD^..HEAD
    WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit =
description?)
    #26:
                      best    ____________rate__________    ____statistics_=
__    _____last____    ______sum-of________

    WARNING: Reported-by: should be immediately followed by Closes: with a =
URL to the report
    #57:
    Reported-by: Alexandr Suslenko <suslenko.o@ajax.systems>
    Co-developed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>
    [...]

--=20
J=E9r=F4me Pouiller


