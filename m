Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837597F56B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbjKWDGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWDGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:06:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B4CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:06:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQv+eTyNc4IRPEsuX5IyHcOO0DOyhq1o6yRRZkvunYc070ER4M2CzFaHZN98xiBTic0motrhvDaTO5KzDU4QN7gBBsGUJQpuww/TA3zNkoFt93X3GHxvdAO3Zg2CGVjbbMfpIirhctDOXr9xeSKMc9/wuVqlaCTdt0hrV+qk5p5/MzpseUWaVEaLR7grTyrMoHGt/dccI+s0oxGDZuF1HQHeuxaxvaAwknUK5fylU+EnlQetmwJyRX9D6d5wFrOBnCWcjZ+DBxDm5v3bQM7o6l9ufTfKlndPYVfbaPhrPLFgigbe28xLJXUqHN0eLflJjlr8WBx9SLox5/y/kMBKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1eAYCy1XdBsins6DYxMxY7TnoJhYfgmSDrbo/2LVeE=;
 b=J0PSMLjhN5a66ywA4JuhJcowzaOi3d9pUqXfwQK1wDDOsU1k21DqOBdUCEgxcAb89UE/1v8QLAewz996yesm1BURtz+911+g0IouTcnpCXax46V67VohbxAP7C0EdLegd76pVV1YhILGnRasFO0QY3YpdEeorqMNKgB8mkGKOfVBVHe5h8YrFhqEhy5T88CLBe+gTIX06YA3BwL6J/ozDWoonjR8F5kjXDsp0JHI+rYYecJgnxIMZM0a8LpPrvRxhXbPV5ttzypuCpSCbDkbmOIx5vRPrHtk9glckIT3M8Q5b3l14e3UhI+iIFbnv6wAc/uvVisk35U7QcDOjyQpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1eAYCy1XdBsins6DYxMxY7TnoJhYfgmSDrbo/2LVeE=;
 b=Nkgmj4cW8RJz4/2Emxtmi0LN/bMo+DH3yyOlCqfuF6pJjQIR2yTzTX4RhUQ4R9wQDSCE9CZwoDU1ORuck6om75QU/eIxnBA7WaQOFK1J/f866UaqTE/oqBvEM0LZjf6LRmN/cizdpz6UZdCjf/WvcBAsSAVFry4koMVmj3lhumJxkcNodcqgSd06XuuoBebVZGFhMZwfWRLU980F13pglShGHEQA6T3nvpxI+NwNsbANd7U7oJbwLRGcxBx8uJkUJ7KAZ41guYcmeOQjixKt6LxSR36RibhM6BUJmOaAb/M6/mAihU4Nzzt+F4hAdfH8FHqYoOBEoO5XKvJK94+fmw==
Received: from PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 03:06:42 +0000
Received: from PH7PR12MB7937.namprd12.prod.outlook.com
 ([fe80::3bcb:91ce:4206:c579]) by PH7PR12MB7937.namprd12.prod.outlook.com
 ([fe80::3bcb:91ce:4206:c579%6]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 03:06:42 +0000
From:   Chun Ng <chunn@nvidia.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ankita Garg <ankitag@nvidia.com>
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Thread-Topic: [REGRESSION]: mmap performance regression starting with k-6.1
Thread-Index: AQHaHPR0v+xZPq8pBkqP4B8aQrrfrbCHHAEAgAAdy+c=
Date:   Thu, 23 Nov 2023 03:06:42 +0000
Message-ID: <PH7PR12MB79373516F591C102110B4251D6B9A@PH7PR12MB7937.namprd12.prod.outlook.com>
References: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
 <ZV6oYmVYsyYizvgg@archie.me>
In-Reply-To: <ZV6oYmVYsyYizvgg@archie.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7937:EE_|LV2PR12MB5848:EE_
x-ms-office365-filtering-correlation-id: 31b0531f-98f9-4b44-8f46-08dbebd137d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aR2b+GwPVwubC4XJL9gQcRGveG34prMVYoqe9oC32q146jKYczMRA2IXw33pvVHVHs6fo0TJVPWUqCnZltvah1CYu3/0kP1gIvTOV2lgw4mUgUATgSZW62ZhkYR84p5xZQvlsKedpY5wp4bY9s7X4Lf99FVFyei3ahXOmI3xscTELs92EigAw83p1sj5Fn/t6AK00v3AeBo0q4JOKdiNSRadKcySXBCY/VZzekQLJxnqBaN7F44Q9GVHL8XCZEeDm/SsrLik7VT/aYiqEewQGxC2NxBC5I2KVF8+1ZeC4eCKQoA7elR/+zJfcNMyYABVTC2kFIYezMn+CnDdOkvi3UXjMLnlyKUrwLRZmaBD6puBaN735Dv9qmWnwqGsYyS/oAOkXb7lB9TlxSiUa9bSOIIOQrLGrJhJnowOX+oEieW2B5LdRQiV3l1JmRS3gxFFt3V5Ex9Ldpv9jyMl7sSbjayDbMkF9NPBJJdW4iZUgpD8rj2rE0ngzDN6FOfDM5w9nuHeReHaGXOUmS9ASvHYYSrn6STeqoQMa3mNPprPBWdh4dOamxA5o29aaeSlVfstqImLkdaHFQW68pfVVu+JE17N6/GYTEX9tVqMbB61uJFSjHjG/sInOvUOjqJp13F3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7937.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8676002)(2906002)(86362001)(71200400001)(6506007)(66556008)(7696005)(26005)(53546011)(8936002)(107886003)(9686003)(66446008)(66476007)(316002)(76116006)(64756008)(54906003)(4326008)(110136005)(66946007)(33656002)(91956017)(122000001)(38100700002)(478600001)(83380400001)(5660300002)(38070700009)(52536014)(55016003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0mPZzn246qwtT1+TPEWpYO3lR9khPP7TiW2NRuGu/g5H/ejpC4aGPFRLZs?=
 =?iso-8859-1?Q?HUtwUUrGFJv1YRNmaWiWc8M6b3uy2KN8iN2TuVIUiPe/blkIauqQJa2lRv?=
 =?iso-8859-1?Q?WwbC2700IZas7Lw5LyL82QQxLwcYxBxWtHqRk2KHLOI30tTb/xjauAvShU?=
 =?iso-8859-1?Q?QBUYgjIEuVnrT5fChdTF2PU1fpy2ivjWcg0+Ax5h5yUwY8Wi8e4EU7Uuap?=
 =?iso-8859-1?Q?5KjFpzpxc6lo368SsD3zRe/cEB7TJFeUwkjLbpaelne1d0wxlM8g9o/Rnr?=
 =?iso-8859-1?Q?ofC/OOWD8VDZL6aVwFLdun5lFCzqsTdmLxK4Qpi8WxqbUKQbWTbC3BPt+7?=
 =?iso-8859-1?Q?ZOrk2SoJKVmGkuEiDU/5JzQdnIuI/FkQo+NcaxMMflPx2Pols0fPnF8AfE?=
 =?iso-8859-1?Q?jflHBpvA6ZZegiH+/i7sTWzW0fwCO7GxOgQt3XYB6KJx3k/KRC/Uv6CnQg?=
 =?iso-8859-1?Q?OcTn74FiBCaEDOdqTmz4l5wKWasSopmPSOmKs8L6CsnNKKLVF7xTDUbzmu?=
 =?iso-8859-1?Q?7Myucmz1nviD3SlbqNxNBhSiCsMMtjzLtejbAB9Fi08Z/gfaoGRnLaNY5V?=
 =?iso-8859-1?Q?d97H9Lw6nd6MjdXTdGJrxNexjLFLBhTWw9aTgMA2MJA4bXUrwgJWEogrVA?=
 =?iso-8859-1?Q?3tDVm6lCC6dJOWH0o/bo1yp5Fe8SZ+OpJgrrcCyoI+6RlIMjYBD8VBF7Oa?=
 =?iso-8859-1?Q?6JHc+dzVD4KV3clCqnbI8ARgBDdm7PfIVwrRVcQox/oizPESIjLsLqaCIm?=
 =?iso-8859-1?Q?HZq+rkos+KqqVfW5GsWpoTazdvPOSNq92KVBXO9ywajULaIYG86Um2IzrR?=
 =?iso-8859-1?Q?FiAcNO92PXeWb8bapGjXguiJZYZJiBBAoQH9Mm93P6llYmLUrI9lpk/roX?=
 =?iso-8859-1?Q?mawBwAMfA/6gj1Mz/AL8KPptCHIhjEyzPOCGl8KQLy0uYvZn0ny2qEqWon?=
 =?iso-8859-1?Q?AeE2ehj1ki7snH58ljDsBbSzdSGFPFLfPbGD7hzd0lJ+A/Q27XpuSCWdrX?=
 =?iso-8859-1?Q?dzovpA32oSOV1NqcqvIw3IF/fzwzxbkPmgCBs/fye2AwcIDioZEYZUPXsJ?=
 =?iso-8859-1?Q?nAicWeRJ5f8uKI/GJ5Avru5T3GfLNrbLPP1P3CBTV2bxiBWIn3QjyErOQ3?=
 =?iso-8859-1?Q?64tKdZJNKA3A8kRFvZfSVB+vGK7GtHGTTN2SBfIMyhDXiqz/KFGXei6cp6?=
 =?iso-8859-1?Q?P7rUJKa2ILUR4SdZD2Vyhhes/2B95EhAT7ooG+0VZAkxcO9b7AkIXumDm7?=
 =?iso-8859-1?Q?7uCg2oLOSfnO5LdJ68n/1scJfFLvNQs7Yp1bAwKVhpEqvnKBFswadYebNo?=
 =?iso-8859-1?Q?xIkNiDs4L27pSbdm4gJBt07KPhUwpECcL/Q0J+l4rOUm0ecM4Z1qfAHYrF?=
 =?iso-8859-1?Q?IwDP7sTVT9maU1iQlJj378shpQBUVXt7wRv7G5DrJR9ffrNCGssWES/wpc?=
 =?iso-8859-1?Q?yA1Oi2elJT1bK5Bh0jhhQsjBAqVwJpnN+RGe76LeJ2LmJZmEvRt1NgJqHh?=
 =?iso-8859-1?Q?WuIJdnRiTvcCAtzbseRUIbHhQrIfWHqsDwJzBcwpXC0l243O/eHeKvxExj?=
 =?iso-8859-1?Q?6aLjmYgdl7o57AbCffDgCHABArwcRSTKuBEsknypVrEeZDBTfBz6sKiy9m?=
 =?iso-8859-1?Q?r6vhJ2FO5d8Gk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b0531f-98f9-4b44-8f46-08dbebd137d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 03:06:42.0203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSZ9Lzj82LlqhYZ6BGicjRwOhYMrKtyy6EF2Jgo248Ge72cdunV8KXrzDTZmrHFJuToJgM3OQ1o7AZxyo/XePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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

>> Did you mean that v6.0 doesn't have this regression?=0A=
=0A=
No, k-6.0 does NOT have this regression. The regression starts from k-6.1.=
=0A=
=0A=
Best,=0A=
Chun=0A=
=0A=
From:=A0Bagas Sanjaya=0A=
Sent:=A0Wednesday, November 22, 2023 5:18 PM=0A=
To:=A0Chun Ng; Linux Kernel Mailing List=0A=
Cc:=A0Linux Regressions; Andrew Morton; Linux Memory Management List; Liam =
R. Howlett; Ankita Garg=0A=
Subject:=A0Re: [REGRESSION]: mmap performance regression starting with k-6.=
1=0A=
=0A=
=0A=
On Wed, Nov 22, 2023 at 08:03:19PM +0000, Chun Ng wrote:=0A=
=0A=
> Hi,=0A=
=0A=
>=0A=
=0A=
> Recently I observed there is performance regression on system call mmap(.=
.). I tried both vanilla kernels and Raspberry Pi kernels on a Raspberry Pi=
 4 box and the results are pretty consistent among them.=0A=
=0A=
>=0A=
=0A=
> Bisection showed that the regression starts from k-6.1, and the latest va=
nilla k-6.7 is still showing the same regression.=0A=
=0A=
>=0A=
=0A=
> The test program calls mmap/munmap for a 4K page with MAP_ANON and MAP_PR=
IVATE flags, and ftrace is used to measure the time spent on the do_mmap(..=
) call.=A0 Measured time of a sample run with different vanilla kernel vers=
ions are:=0A=
=0A=
> k-5.10 and k-6.0: ~157us=0A=
=0A=
> k-6.1: ~194us=0A=
=0A=
> k-6.7: ~214us=0A=
=0A=
> Results are pretty consistent across multiple runs with a small percentag=
e variance.=A0 Ftrace shows that latency of mmap_region(...) has increased =
since k-6.1.=A0=A0An application that makes frequent mmap(..) calls the acc=
umulated extra latency is very noticeable.=0A=
=0A=
=0A=
=0A=
Did you mean that v6.0 doesn't have this regression?=0A=
=0A=
=0A=
=0A=
Confused...=0A=
=0A=
=0A=
=0A=
--=0A=
=0A=
An old man doll... just what I always wanted! - Clara=
