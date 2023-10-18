Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC767CE670
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjJRS3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjJRS3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:29:11 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D46119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtr7YFaTpb6hfGNUCkiz5BsXLLPUL/oUjWa5p2GTWtX70sUAZDzXPI+DZTimbwLJ+5KdIHqcsjJFNljbPlG/Sw5kItiUblaWnhXL9APqxqc8nmj8e0977z8CkMTQpFvYxuL+E8WfYTBFXEGiC42hMO54LNanVpqAAY62TpP4JVMaJn4VBg6azefQ7Kyx3uW82vgveKoh3KrLHYYNXHZdfRt0FvVGxQuxjaqjJ5QMYoxJPKBEKHUk3KcMXdh+adrFTdpLqEgkhPkBB5sFjKjBd1C8Y7kmexbvaItQcwDdexm4Opp2i1eEvQP1UYVOZrroY/lSxMZgfTyBmHBBQycgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TQ8OqxxE/AubFi6PC211xDdAzZt2IJIEf6rzY7lzm0=;
 b=eiI6lQyEHGAppweZp3XMfvcQUehrg7Pt6qzfbxV8sJNDCv6i1UMh2G+r79Ad9XCfYS21m3r8ixkJ42KnsubWkoJYqor2UfydHVGYVzgwtO1OivMAGOybRzVQYzzTOg1FLKQl1WCJvjP8+37ZY1sg0Rpjhn5xO9zryIoJXET8lJ/7SbxMFIQwSFAXF3TNka9p4ePx/dhdOasitZ2Odw1mg8LJSohdUoRxQ7ZelnCD/Nwz2cLVntGSCtlhio13JzLXd3YtwW5qirgX3B+30ggF2kZ7DlPEGv5uv5TCE7lYaR2Og3O1mlFSl20eb58o0Ww6+RnJQdSwTePXuVLR/KprRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TQ8OqxxE/AubFi6PC211xDdAzZt2IJIEf6rzY7lzm0=;
 b=W92AKtrSITjXbeSVF/XJAeFHzEsIlfFSq1zhz8xAq7Ph+5Ed1WnaxVJ2orfDAet6p7nwcgGWAmvaZsMNmkjNcoDPcVIpR4n5G5uMvfJMGk1r+uaM437kHZhzFqM1Dxuv9N+Au4vFkWicLA/H6Q/9SXU5B5wqsw46SmFvYxqltj0=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB7946.namprd05.prod.outlook.com (2603:10b6:510:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 18:29:06 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6886.039; Wed, 18 Oct 2023
 18:29:06 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Uros Bizjak <ubizjak@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Topic: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIAHqOMRgAAI04CAADzyiIABTsvzgAADAQCAAB/hAIAADVOAgAClpgCAABXQAIAANUA7gAAQyoCAACJcPoAAE0DxgAAcTYCAAAW/gA==
Date:   Wed, 18 Oct 2023 18:29:06 +0000
Message-ID: <6D0B6A98-9C4B-4889-896E-3C412BFC5397@vmware.com>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com>
 <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
 <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com>
 <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com>
 <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com>
 <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com>
 <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com>
 <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
In-Reply-To: <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|PH0PR05MB7946:EE_
x-ms-office365-filtering-correlation-id: 478a2e00-f019-4ba8-5095-08dbd0081ca3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJDIPFeS9fSVINPAqc5yLF59RrPuYE8ycu6P3kJiZ2fvlRJQRK5ZgG+pm0i3ruFC9xS3kmFhwvWecnhzcCPg9FyhSOCCvUnRxlRD211q9H/AZfY+f75668zkkINDujG0jP/qYLfZXRQjLYcmZmoT3VjpSbIlpmphQSKGAx8ipFSid/O0o/KlGK651AukZjxdGh7iKc0X8GLa9f8UdYl8/2kgDKKDPaq3UjhpOEiEEj2bkxhed5ScjUz53AUOTL6ebPX/tM/FE/ZmDRpXvaftP1NKq/tRboITm2CTxvD7VNoPw0nkYd5dzui/rT9E5wj/RfCNH06k99MApNIn1Cib7+k/FAJFY0EvEKvK5twI1nadbe9zh4iYICHIF96PCvwYIfoEtAJgpGPjIevT5xrUYmTLotrvBlwjH9iiIauK+9fH71JJnG9/VFf/wmNiLmZhtA3Xpd4QZV67Dq/8OT6OIVPntdt5cHHELJVVUIjdXcz1NtibFIOzaCXGeKMrYHciU59EIIx41KTF5uhvPftuZuPEYEO2X36JOhPsy4PoR0ikFhiJhE4Ns/URIpAwm5ESra0/dnwtNsyA5169+529Sh2kLzPdx4cHMlVK6Hx5w/dZarrjGhz6bIqV+5lx09mSMPRyb0ZRfimm3LcpvXoswwm6sQNqFUZd86SrPJxBce6NFe2E7Oqog6a1V9wHiR/xNRBc/b9l1S08Vl9bYGF5LA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6506007)(53546011)(71200400001)(5660300002)(2906002)(26005)(4744005)(83380400001)(122000001)(2616005)(33656002)(38100700002)(86362001)(38070700005)(6512007)(7416002)(66476007)(316002)(478600001)(36756003)(6486002)(66446008)(41300700001)(66556008)(91956017)(6916009)(76116006)(64756008)(54906003)(66946007)(8676002)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/hIDP6wqTGZ5EamGmnFcIwP+5N7Wo0CS6Ni8o7Rn9dvhTvHytqnP6+QiiIl9?=
 =?us-ascii?Q?YxoQU+qTRYQCz6B7P3N0v3xNfKgWBHgjrtYTzuRjfMfseyKHnOLpnpq7IaXk?=
 =?us-ascii?Q?3RjyUdNBgOXcZgJaLZfyZm+IucK/+DJVy87FGYQqmcTjU5i/66Vg7i1/KCwP?=
 =?us-ascii?Q?NV7AI7yM0MySB9wQ+tqgObYQgbMeYbNOlQuaYWnVfnPyC5gx0/6pfp0ZuFY4?=
 =?us-ascii?Q?YcEAQe3g34jJkyDqY5j7jc32C8ZXOZn6rLrdrz/pk/foWz6MrErcL9IXLDHE?=
 =?us-ascii?Q?h4y6ZrFko2IxfnhaOBc0y1VHHYQDmjGawTSXspLRRLfPfLvG4LZ1QRZLCMNv?=
 =?us-ascii?Q?7kZgAE432kSQFfT1YoPDpcViEOyAj3dfUo6xrubKvMUnVlDGWR5uplwl2O+v?=
 =?us-ascii?Q?ILCwMQwXmQU+cTt6f/k2ABsdWba/VaJ8Sy8xIkqtVN98Ffkinc0jrFkQzz3u?=
 =?us-ascii?Q?ARYApwK/f9tykrG7hb3YeUCxkZjjntJbjzPvLS8+bMVTP5acEg0EHztNkO45?=
 =?us-ascii?Q?QyUpOmClFCopgU8oWkjarfHca+X7k4Lqjkm/+idGO3+/yQOcvQwIywmtOh8W?=
 =?us-ascii?Q?ysL5Lp7UjMYslWgWPnH2yYCuemMcm4awdeGv7TvEs5l89Azsb8N9VfnjypmN?=
 =?us-ascii?Q?hvnpUaV8gFaW0Iy2Pv0YMXvgh2YbkCbZVDo1RXmWlQsY2YtKfxjVz6tnvF+4?=
 =?us-ascii?Q?dlh+/pef5Zoiz2ttvht86s+kvZo7Kx+PR9L+8s9vIrf4q0ZYfXwxoUG5FjQZ?=
 =?us-ascii?Q?Q1hO6XnkO0uGfB43XPqesPQldAZoFNE0Z0kGDOqYg7ZvSXdyDziJ3CguC1Gz?=
 =?us-ascii?Q?312OE3vvEK12aLjzcYnvY1hlu3ZvHrkRp513auiZ251EV49fyuNzfuia8cq9?=
 =?us-ascii?Q?DYhGE6Fr8vlDJsxWOW8C/q+Ea8/SZwrtmMTGIqV4UYkme2zynQ5worPnZDXc?=
 =?us-ascii?Q?xYIaeDsPIXcdE/Tsvb4r1S3A9+9HYjJysQ0qzyqfegsTKwOim+xC6tLrwwAb?=
 =?us-ascii?Q?KqHenDu4Ui+2G+1KH/wAHTyGO1onp47WvCPUti7UadAtQAzWURWn3WyMlcDc?=
 =?us-ascii?Q?GvjaErk43SY0AP5Aet+Zg4c1PoQymHtHBTaB6yxmN0lwfjTbJc3iDNTTCMWf?=
 =?us-ascii?Q?4RamhzUd0BdDLEWLAecP/72T2bXXF27EJ2BxAYpr+l7Y33difOaTCl1JlkgG?=
 =?us-ascii?Q?nGVJDBVlW4I8W4L5DjZqSwVGF51gPDix6319NpiW77RNKExDinG0PjY+DxKr?=
 =?us-ascii?Q?o3n1MczZiylpnZ+td9LvDqY5rSMgk3Nt3ynqNei7RN6ogjBHdKx/ap230gAe?=
 =?us-ascii?Q?KCyYr/uvEn9tY/EhOcJDO2uvZPtyE4rOXasUOFT35sy5gCyWO+AeNglwNQ82?=
 =?us-ascii?Q?tYl3oVh23EqadhsYpgwVlua2MtIYUyOrrOU/GJl7B6B3uOdxGMfu7DKgsfbg?=
 =?us-ascii?Q?3uE5r663ADZBVI+9bZIwoYbY0LaTGiJULg//AmynE/EpEPUDoiwKrwJ/FMYC?=
 =?us-ascii?Q?b5KPQS1QKsfTCrWhcDs9Pg1PD7HQpawK+X+oLRygxjCCjZpONVysoYhQ93kc?=
 =?us-ascii?Q?/vGdfyhkBLdCY3bPcXLCWI7GkbljsPiWIGV7j7AS?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB99CF3DFB188E458EA7C54A69916A43@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478a2e00-f019-4ba8-5095-08dbd0081ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 18:29:06.1233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtoP0CZKbInlGjCV4Y2X1EmfrCtWLIc+744OFRGT27v9cDC/YDJE1ffNBGO4djgUJ5kT8nH/x6DTwbxxuktkyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7946
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Oct 18, 2023, at 9:08 PM, Uros Bizjak <ubizjak@gmail.com> wrote:
>=20
> We can use alias to __seg_gs non-const memory, so the value can be
> accessed without asm. __barrier() will then force reload. Please note
> that any memory clobber, hidden inside asm will also force reload.

For the record, at the time I tried to find a creative solution to
have fine granularity barrier control. I looked into address-spaces,
pure and const function attributes, and use of the restrict keyword.

I did not find a better solution. The behavior of most of these
mechanisms was non-intuitive for me and inconsistent across compilers.

You may succeed where I have failed as you seem more familiar with
the compiler code, but be aware it is a rabbit hole...
