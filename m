Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D4777E6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjHPQxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344969AbjHPQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:52:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DF819A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfe2mvVMwluyjvgEDl+ARa3fRn15LHhG7JYbyNYbmSpgkrD77/UvBU2n8rlzK084zFFQnsk307/EzhPLP+ecc/merr6WzKnTOng7D9yB9UCZZNxQN6Y2VUNi8s87CAVBI6e1fo5YScf39hGtBwncySvOmuBRensCRCyjSfWkqbuNIXO1qGDLDwQrdsepLjTuuYp+tC46GvrHW7Uc/JBNopSioIojpJNnPi39LjLKz5369Yol2d+30t/S+QPWHkjvx3zPEVFE8pHcsUUXJ71l4tiU13hq88Itj1qT9uXa07ZTkeFIPTHzJtxyeHz3tiJBVAwpzxYW3KmeQBxx+4FiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO83d9mkL80x6+pRlbMX5wy4XXaAF0pfRDqvHI1VV3w=;
 b=CgOo2l6h1SaBnE+UgBaZAJ9AouXVaRF9BF0diuywPl1ekTz8P0I3dFpEQhXaf/ZcL27ooLVW/1UBYiAvDNc4mG9UtimUFhd2p0KncCsOnuJlJ26N9crZcKLxtGfaUE0LeQTxMUD9unw0DPeSap5Z3wa4Njvym/AXD8+Y36S6RD4sMx8BgHSnjwdfQVSDHFmFdg7WW2oIb/nQ+4BatZwpjYXl6UbYt73UmCKxAb90d2oKklO0pBWTBo71bxtb/GfCRo57DFeEEcVCWq3SbHN/ZdQpGO+VDvbWg2ZxheGSzPjnrFT4aFJVUf9IPpv/XgM4WxFcX7jF0IFe6GTDJ8D9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO83d9mkL80x6+pRlbMX5wy4XXaAF0pfRDqvHI1VV3w=;
 b=ASN8LUUJEOn30uMP9JJl25lcZYfN7f71/QKMcQlcHx5hy2i7J892j+rFNnBVGZLrnY8cMLRRutIt5S2AeGlt8fu4fAJxBNDcQJoeom38QsfFGP4lm/E9cXUQmxXkYfqyXz8YTbBd/4YDuZm5RWNgnr3jMwyI04AnDHo9iOaiKfg=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 SI2P153MB0704.APCP153.PROD.OUTLOOK.COM (2603:1096:4:19f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.4; Wed, 16 Aug 2023 16:52:47 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188%6]) with mapi id 15.20.6723.005; Wed, 16 Aug 2023
 16:52:47 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Zach O'Keefe <zokeefe@google.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Topic: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Index: AQHZzWA78fOP2PgBLkyBLwXjPivf+6/nv4MggAJlYgCAAAUiAIAAU2yAgAAnGYCAAoQs8A==
Date:   Wed, 16 Aug 2023 16:52:47 +0000
Message-ID: <PUZP153MB063529C4869A7A666C275B23BE15A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <20230812210053.2325091-1-zokeefe@google.com>
 <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org>
 <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org>
In-Reply-To: <ZNrh6w9ICu4rMrhV@casper.infradead.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=165822fb-d334-4f61-907e-c4155a3c5358;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T16:50:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|SI2P153MB0704:EE_
x-ms-office365-filtering-correlation-id: c7c3784b-845c-4211-2ef1-08db9e79380a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WjW8wCUckbKSCRju/uZDopaVVqcnJgwTgDg2HZykC2j+iQXmcr4Ml9vGw2NezMpf37f5NnsGRWpKxNOpYym9lDKCS55eDy+YLGrTw4eCWPzDV5uF4MsGkj+tCcLTxGgSOq84wHQg0zkXJa4oLs3YBQc/EK6yZWCmrElXFiJUY1mOpKZxl9XrLHQ1BdQZio9ci7MMYVhWkqI1fS/tvkMbmBN2jKW1QAITxBdePo9MnYaXwdZutN2uwR7cID+9YLSX1Hs05rUTbBLzT33LgwxsPGaFBvRBuMkloBCMALc46u41YJ578GARaPMsdCcuYhue6QV/rCqDhn4d7F4dmh2cDZU8eqEXpWJQxDEWYj0bxBbEIH2grxt94dad+thlylwDiiAn/O2kNAayu0fURBgHoJShzjK2tQzsxM8ypmR1Q75WNwzTiuvu8PKmpEFhmLyQvL630OHgpJoDxFIvokETaFm80NBoCVA//r084ODO9seXuQpRRc4z4vH6dfWaWs9CFlGThcw2n9Qhdm7W079bULX4u3JED6PssQXDyEvxjEZrgJYvOzsRLAYKokTfcdWiE+MT8lGSQ0DUV37TNdLeolA1ClitfloGdgkOIs2Ih9S6vKI1xZevj9Iw5E2RmHEZJuhrOI+jzB1I9RoTQWknkYx7Y3Tb+hs4ywlaF0VgMZP7WPPfM7STjYiD9+le2b3Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(1800799009)(186009)(451199024)(12101799020)(10290500003)(478600001)(7696005)(55016003)(110136005)(9686003)(33656002)(83380400001)(86362001)(38070700005)(8990500004)(2906002)(6506007)(71200400001)(52536014)(66476007)(5660300002)(4326008)(122000001)(38100700002)(64756008)(66446008)(76116006)(316002)(41300700001)(54906003)(66946007)(82960400001)(66556008)(82950400001)(53546011)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tH4vdj9DgTNZi06K0iihePvC7fMkfXe5sN2BDDk+m2RORp2Bmo3JYQaiM2Ih?=
 =?us-ascii?Q?KDyyjr1LBeCeBFlZX0nnoqLzctWuR4tRetznZ6XzrY5jFY/VmhXYQOKXxNjA?=
 =?us-ascii?Q?bOa3Rb7xBwx5/uAjTIvNwIO8k8QCy8onjIXkOCNT5nUnOHhpmFaY6UnEd788?=
 =?us-ascii?Q?9ZS8ml/LjVa+wNsdc1oW5b7Mz8xvzK2LhRBen+OpEQwYR9JluweRTYeKi/Ke?=
 =?us-ascii?Q?1Rms920BNIZwM6qvjVDWtviCg3KIZmrKFdnweXhIIx3jTBrVdqBorVT72wXM?=
 =?us-ascii?Q?ygvJMFOOxUAvMYOVsdqSLtA8ZOwi3UTX4W0yQ/mztBD4ZKI4LWKmcI4dN71W?=
 =?us-ascii?Q?LTSxIVCOQg7hfRmLbyBNzgwJvNPdTRzgutqdbkrXfUkphoF7EvWXQ33MTrTU?=
 =?us-ascii?Q?4umuqUkqiTtG2P1OUGMOyJXTTq1ncSmo90PMKreI730DE0P9dSzRgC/mk7vX?=
 =?us-ascii?Q?GCcmdv/+Gc6io2M3obeSFxYJm4TNj9OkioJR1Z7lwk4ymVjU5CIUOrIWqpx4?=
 =?us-ascii?Q?YsNKP4CIxH0erY0WapcZ2pZurQtuXipGcpUSXRNEPQxDPdwaZqfuWgtbWmF3?=
 =?us-ascii?Q?foJPyQPaV2kJvpzuZywuIVRtr1+5AgfBDe/vXrHtIZS+mBvhFoo2a/0i4q14?=
 =?us-ascii?Q?Vt4KTu3zOVuYDpce44V2tLcnBWyKxyTl2nMWyR9mJzYgOoT2TCwTNpQvjETk?=
 =?us-ascii?Q?DbxDHZnhl057SEZ0mervnZOeYF2pWoUKUmPfcfjkfvDAE/uEcWABF1wGEfaK?=
 =?us-ascii?Q?YuN527STZxVpX5XE24cAVhJWBrT5qqrYG722dgdZxmTOKk/cUGl43Ws2ip2o?=
 =?us-ascii?Q?Eqn7zezfJJQiW2/b5APtNrc8zLeTCvOlVzQzqxbp+FIcr4EmfmH7fUgnLlA/?=
 =?us-ascii?Q?aOjQFQoPbbPYWH2L6OQUCiRe0m1B2E3UzWbzLFHdJXIl6ROu95BQ9za6Cwjh?=
 =?us-ascii?Q?Q/LztIPSAc3zANeep8eftNWOQS6LPIrk0HUCs3AzqgQDw1OkfPldx21znsdM?=
 =?us-ascii?Q?uVr2jbmCvo5mEE0sEMLQvHspl9yC23lEYX1WCxMqK/89QpeZToI5dJrb1eLK?=
 =?us-ascii?Q?H9hRRMYgzAVtYxbYfeotpIRBsO4R06yENDSjnqkqdo9gPN8AGb6okxlfh0eH?=
 =?us-ascii?Q?cxJ1LqXKBuBiRYVsWgTvyS6FLQ1HUGqxM7aofOvmO9XDLqUjC7BDrl2ITSij?=
 =?us-ascii?Q?dsXUk87U8DReXD2az0dBPcU5IF/S6RliDMZsVNVoBQmQ81WBBS3s9obPCp4X?=
 =?us-ascii?Q?PjOHfFNsP+Lq5SzP+asLH0NsBOCSJff6H+IUCilVqurjBd53CXc/3ohPAKCt?=
 =?us-ascii?Q?PDEc6Y2Bo6XYxerYJMz+OhMtJq8m1dYMTz1wKKbyE9CYxLgrbMLsnnM/Ek0y?=
 =?us-ascii?Q?zbidAlHuArgWgDehpAWEqv7s+wibzCb3tbj8f9lIJ80dRclcEES5w85XN0YT?=
 =?us-ascii?Q?G2FwgVrjQT8TsHlrbX9VxtAm+I4jFGx8on5JCAqbBmzd1NJDMq8TRpdI3VVz?=
 =?us-ascii?Q?29OVWX7QNbKqMCIC0QSzpA/leM39S2qZhbTEDp90rUmt6xsQArgQPh+4LJ/P?=
 =?us-ascii?Q?jhZA0S2SB19MJ5pyptaSCGvOc0FJ3Y6i8eQC5Ehz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c3784b-845c-4211-2ef1-08db9e79380a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 16:52:47.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5KdBuEHN1sH5+8JW4ta5HbKhIXlR0qYosvxIH8CQWIRHqoeWzthWO6pYDEZ/SVYwYj9ka1NVHdpimVS45Zzsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0704
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Matthew Wilcox <willy@infradead.org>
> Sent: Tuesday, August 15, 2023 7:55 AM
> To: Zach O'Keefe <zokeefe@google.com>
> Cc: Saurabh Singh Sengar <ssengar@microsoft.com>; Dan Williams
> <dan.j.williams@intel.com>; linux-mm@kvack.org; Yang Shi
> <shy828301@gmail.com>; linux-kernel@vger.kernel.org
> Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
> __transhuge_page_enabled()"
>=20
> On Mon, Aug 14, 2023 at 05:04:47PM -0700, Zach O'Keefe wrote:
> > > From a large folios perspective, filesystems do not implement a
> > > special handler.  They call filemap_fault() (directly or indirectly)
> > > from their
> > > ->fault handler.  If there is already a folio in the page cache
> > > ->which
> > > satisfies this fault, we insert it into the page tables (no matter
> > > what size it is).  If there is no folio, we call readahead to
> > > populate that index in the page cache, and probably some other indice=
s
> around it.
> > > That's do_sync_mmap_readahead().
> > >
> > > If you look at that, you'll see that we check the VM_HUGEPAGE flag,
> > > and if set we align to a PMD boundary and read two PMD-size pages
> > > (so that we can do async readahead for the second page, if we're doin=
g a
> linear scan).
> > > If the VM_HUGEPAGE flag isn't set, we'll use the readahead algorithm
> > > to decide how large the folio should be that we're reading into; if
> > > it's a random read workload, we'll stick to order-0 pages, but if
> > > we're getting good hit rate from the linear scan, we'll increase the
> > > size (although we won't go past PMD size)
> > >
> > > There's also the ->map_pages() optimisation which handles page
> > > faults locklessly, and will fail back to ->fault() if there's even a
> > > light breeze.  I don't think that's of any particular use in
> > > answering your question, so I'm not going into details about it.
> > >
> > > I'm not sure I understand the code that's being modified well enough
> > > to be able to give you a straight answer to your question, but
> > > hopefully this is helpful to you.
> >
> > Thank you, this was great info. I had thought, incorrectly, that large
> > folio work would eventually tie into that ->huge_fault() handler
> > (should be dax_huge_fault() ?)
> >
> > If that's the case, then faulting file-backed, non-DAX memory as
> > (pmd-mapped-)THPs isn't supported at all, and no fault lies with the
> > aforementioned patches.
>=20
> Ah, wait, hang on.  You absolutely can get a PMD mapping by calling into
> ->fault.  Look at how finish_fault() works:
>=20
>         if (pmd_none(*vmf->pmd)) {
>                 if (PageTransCompound(page)) {
>                         ret =3D do_set_pmd(vmf, page);
>                         if (ret !=3D VM_FAULT_FALLBACK)
>                                 return ret;
>                 }
>=20
>                 if (vmf->prealloc_pte)
>                         pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_=
pte);
>=20
> So if we find a large folio that is PMD mappable, and there's nothing at =
vmf-
> >pmd, we install a PMD-sized mapping at that spot.  If that fails, we ins=
tall the
> preallocated PTE table at vmf->pmd and continue to trying set one or more
> PTEs to satisfy this page fault.
>=20
> So why, you may be asking, do we have ->huge_fault.  Well, you should ask
> the clown who did commit b96375f74a6d ... in fairness to me,
> finish_fault() did not exist at the time, and the ability to return a PMD=
-sized
> page was added later.

Do you think we can restore this earlier behaviour of kernel to allow page =
fault
for huge pages via ->huge_fault.
