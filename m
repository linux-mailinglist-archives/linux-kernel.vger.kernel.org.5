Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C047DBFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjJ3Scv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3Sct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:32:49 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011000.outbound.protection.outlook.com [52.101.47.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DDFC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF6pk47y2qFLZNrIZTnCgcSt1TxUmYnkbQgPufEUTB+4vTMs8qvg8vtqkVDUA2iUKYN44i2M2jQTOmFzPLDt+L2XbnfUuolm37scedghic452uxvmeClitH1yqIsonOWwf+WF2Hdwh0MIhEQTlG2IP2g+xTwwko7RryO4MqT/2eAQIi92URpwCCw6PKnlWq87rkwFcxAvXvQ0TcazrIdYGfVlIuht5w1+vWdTfkzThlf/ezlxPaoRg9foJqTUzjiDpHTKEWVag/1dmczShcLXhYfGWmywN0ac3l53XCDzToFffYeKUsErB3b5zeMYOgeRWhtYVWWYzNCrog/9XGu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3roYN6zdlJfkAUEop8j2N6/80w2g7QN8D29Q1LdK+00=;
 b=jwwEOAdbQpPHPff2g6CczNeufG0OUDajz/rKddAjePgW97BsAVwiJ+Py0n0skLXl2jr393AM7nSyViYZDiZWpWJapieQuDwQh49TQRpUiAmo97xwpPKRMhUi9VVbbq1RpbFSZ3B3dajzehYOWUIl7Utf5S3mK+jrsxd2HsWd5SHDodXy1OW/MeDJY/QrnfA0NAndBBhyvRVNgAHJUEHeVaWdhSvk2vbVYATD9vqhXQH6VyiegoXMTS+H78+Cu9yXwS1GVXtT0dwrhfYmsvObiMJsNGD6bU8KDgWYI90EvAS6S1nA6O5ODqnqX3I8Xn4BuvLGn3pB1hzP+RHoTnkL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3roYN6zdlJfkAUEop8j2N6/80w2g7QN8D29Q1LdK+00=;
 b=Pz6bBAiSR7Kg8+EktHV5Lwusi6qIIKi/wjk8mXwHwm2T+liggWwk4XDZZ8IbfUQCjbt2w7AB0gKHLpRrzRMzJXhLE8LuoRXevl4rCtyp+2yle/bMMd5I8YYUiWfPI3NQwFe08PTrDp+Un1jwXGI83eSadw1OxQG+8x48UcCAQKg=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CY8PR05MB9548.namprd05.prod.outlook.com (2603:10b6:930:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 18:32:44 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::b668:aef3:606e:923f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::b668:aef3:606e:923f%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 18:32:44 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Byungchul Park <byungchul@sk.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [v3 0/3] Reduce TLB flushes under some specific conditions
Thread-Topic: [v3 0/3] Reduce TLB flushes under some specific conditions
Thread-Index: AQHaCwJSJR5jMwj0WUubYvR8CZoC+rBinmqAgAAKdAA=
Date:   Mon, 30 Oct 2023 18:32:44 +0000
Message-ID: <43D76216-3410-48A0-9595-11045DCF3AD9@vmware.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <08c82a91-87d1-42c7-93c4-4028f3725340@intel.com>
In-Reply-To: <08c82a91-87d1-42c7-93c4-4028f3725340@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CY8PR05MB9548:EE_
x-ms-office365-filtering-correlation-id: 84127015-d03a-45a9-2ab8-08dbd9769b91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VtqO3bu3jAa8CpDtUr+3DxIZ0ZhDPqY4M44YuBswdIb/G/uJxxDiFVIh1X+pOxjRK0zsZwfhC42ojE0PDVRD4nNmUtew5d1zY3hzryN604BxI9NaP+OV6VpIhkFneSVA1+n+/iimUi+sNpAcbAKk2SSGEWzx6H3U4mgI6OoApSn4iV2ecN4a39sEJsH3kDe4H0O1U6+y24CiuP35R1YQmEISjM043Rtw2aP1VRPLnXo3qQiQQpUNZXyFcyopIiEcYmaflobwhgMjkI6TSFAfmXn1y4MTbSvLXcux4R5p2QmS0K3uyBZZ+WYQX+LKa1xldp2LdhqeWnIi4DlRk7bNHehDfSSYS6DNEN02XEZK+bEsLd1ZlpfkISpsDyWCZuuLwWNMd/uSxFrgAav3+MJ4yXvaI4ecA+QipIN/XM89yn9nPWkqnNBSKjUzQXzLo35kdJWkh3QBTDeOAq0f0aydroA/6QRzMQ3jUEgEtkxhAuIGRJdT3UhQd+CeWUZ2b7+IVne5tuhf0I34nHzJiTEa2nVwJM3gbUKxuk1bX5HT/0iR6fjK/wGeBG7RufU/pwt7VeF7g44mfS5Cww/b6jo7ZgugkpSOVF2uFmyVYU1wbicvxYQtmLPOBIKfWY/UukAHOIy1kb91IAHVPs+n5b39nsxMCi9ivLaOyymeiuQKhFvfJVof3YmvJUody/+CluX923jEIDdIGLEGg9zUjxenyIKvEJnaQh6NsG73Nv+XWmsWdfjemg4oAG/M2t46AjP7D53q3gsUIY29Iw/kNWRLLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(1800799009)(186009)(64100799003)(451199024)(66476007)(66556008)(54906003)(316002)(66446008)(64756008)(6916009)(33656002)(41300700001)(38070700009)(122000001)(8676002)(8936002)(86362001)(38100700002)(2906002)(966005)(4326008)(91956017)(478600001)(76116006)(6486002)(66946007)(7416002)(5660300002)(36756003)(26005)(2616005)(6512007)(71200400001)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s954u9RTGJwRs2OfTHHMlA4TY3wgi7ZVX7NAlmQgYVHIEmbnwXRd5wuvrq/S?=
 =?us-ascii?Q?f8QMRq2BajjRcyKRtopNi+POT1sVY2hHTC4dqfCe7qjI3o24ZLbpPkwGQFwm?=
 =?us-ascii?Q?EBwqtCHKJQTe2wrBTpXt42WNuVQg4Gur7b0URkl73bXUDnOwl2YGhmI0wnvX?=
 =?us-ascii?Q?PAFxgNwZZzrFOpBnzjSb1iF0nAJfR/ujewrpQ9oSVKZ0JK2kFdJLdxZSL9d9?=
 =?us-ascii?Q?IwZzBIbUvN+wqX8SyXA+1Txfe053ErGcTna3ZBOvfOPLIRsAYHO+RQlMgTy0?=
 =?us-ascii?Q?EjMLFewBG24W0YH4DhXWvzVhZvXOmKNHzfkaebh4DAIpqeRNpL2uPSloZo8n?=
 =?us-ascii?Q?GzAwhEgGOMAyFSrsWHYkW7YeDc/YllFj174h9YUoDczqHCn6XqWhxGyrgoAS?=
 =?us-ascii?Q?ces7sd9mjKhY/trLBJVEO+AEKbKcEHXjqirYKuxBP9Nerv18yKG52FFk4IIe?=
 =?us-ascii?Q?ZqymNPBzj8bP7+qC0fc90J3PreSwCCjkrlIyvwYqMx3jWobziNkLvscgA3Wd?=
 =?us-ascii?Q?C3eClbufxsoHnV8SXtzWxlzwD/fVs8BWZ9El0NQdVWhjZaKcJB6T34QcLKaD?=
 =?us-ascii?Q?zpumc4Z28CaKla4u/VxyvcwHzVpqH+6UfrAEWxap9NcnoVORzqg2jKMU8AOi?=
 =?us-ascii?Q?6qxdf1IZcA+xAAN9L1YyQSQbDL2GUewE8H071HHQj8ALX1+ESVoWoDi13I24?=
 =?us-ascii?Q?m788+Q39ziLhFF7giN4WBVKWjIhvyQIWkLK1RfkYa+sXn1jGZUDzCzNKPs02?=
 =?us-ascii?Q?E2e2cUVSveDoJ2Q6rkPTCgGJaWWngN22O+09aGUts+Vp3gws7Ni2HH0CIcMr?=
 =?us-ascii?Q?XP4a+ueVc9nwWa9PdIMWk1za7YKsRZZfGumLgpMpscqvap9wJi9efk4ZKSt4?=
 =?us-ascii?Q?MKuRFzL6DgnCyYpuuftfRwDRobI7M3g3JUuynZLOV6H6ijAbQXB++fiWIna/?=
 =?us-ascii?Q?cUpPaV56+iY8Vknx3y766qMezXulcuYSEL6JzFv1OunK6rTDohmvQrVT4Zoa?=
 =?us-ascii?Q?b44exEosEFLcLljKf8BJ1E3sUTvZ75+X+2BU7v0ZJ1idqfbNyLNintIgiVF6?=
 =?us-ascii?Q?dehGjj1/DAyPIPl+TCMXSZZaz5hH9fQv1EN1E9fiTD4x60/xWOcg/8qeZQTL?=
 =?us-ascii?Q?2s/kPRQAaXH9nb4ye9SPDh01wDmCxaW3m57xDaF+qol8q4HYzd5s/3r90kPb?=
 =?us-ascii?Q?qXTaRC2BD3lzJZS4t8X7v+7iT6icvUgt7a9Q7u2PkelKsOuAgGWaheGwdrBn?=
 =?us-ascii?Q?3DWBrR/eLvSOEj2GiooO9a9S7z1zyzU5NDlLw58azdQBsvTE8B2G2etliHsX?=
 =?us-ascii?Q?YxLCr/xB6+gNI424fGCIRTzviOn4BUydl8uXDu2khHyufVVUZXpSlCPcGA89?=
 =?us-ascii?Q?g5fV51Cf2/5ROzAh/c+SS+gnHB+f0LgCgRFbnt/1+l9wij+nd6ha5EsFqR2c?=
 =?us-ascii?Q?UIVsGNboAcg03YIE3Zao78IYArnA5w3jcHG/LHq0pFYrcxFdHdve0kLxlY2W?=
 =?us-ascii?Q?vKJ38v/iw/7umVU1zLmKpoO4ChiZfrM9GR6+HV3VFilg7bYOAMq/bMktTVTb?=
 =?us-ascii?Q?t3wR2A5CoItLbKiKD8LuKhTlAgKak8J1vqNt4f3e?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DCD1DFFD9EC4A4D962952884F600640@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84127015-d03a-45a9-2ab8-08dbd9769b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 18:32:44.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SP/nsR1Y1bmDHL5xzLHkqYSyd9OgcoCoYGYcmu3FIDvSwL3vOG6kb/9DYtZwRA8wkghXHRcEx9b92v/tk882Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR05MB9548
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 30, 2023, at 7:55 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> !! External Email
>=20
> On 10/30/23 00:25, Byungchul Park wrote:
>> I'm suggesting a mechanism to reduce TLB flushes by keeping source and
>> destination of folios participated in the migrations until all TLB
>> flushes required are done, only if those folios are not mapped with
>> write permission PTE entries at all. I worked Based on v6.6-rc5.
>=20
> There's a lot of common overhead here, on top of the complexity in genera=
l:
>=20
> * A new page flag
> * A new cpumask_t in task_struct
> * A new zone list
> * Extra (temporary) memory consumption
>=20
> and the benefits are ... "performance improved a little bit" on one
> workload.  That doesn't seem like a good overall tradeoff to me.

I almost forgot that I did (and embarrassingly did not follow) a TLB
flush deferring mechanism mechanism before [*], which was relatively
generic. I did not look at the migration case, but it could have been
relatively easily added - I think.

Feel free to plagiarize if you find it suitable. Note that some of
the patch-set is not relevant (e.g., 20/20 has already been fixed,
3/20 was merged.)

[*] https://lore.kernel.org/linux-mm/20210131001132.3368247-1-namit@vmware.=
com/=
