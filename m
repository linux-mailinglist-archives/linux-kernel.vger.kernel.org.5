Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA837D2E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjJWJgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJWJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:36:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD6D10CB;
        Mon, 23 Oct 2023 02:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXIK4E5kHzMDDevLOtfhiwdlCrIadLCienZFr5ary1n+rktYxIG3gYEVJphjGOD3RzK1SrExZzb69RPgST4wZhPxVSbR5tx1MY0yw/oV0tH04XeaCfYg89RUmYCZx+PFVJond8n0dFuiuw/gxwJjiNVB7KJmBVkiVY1K5PfYaOaN1pg5glGNHq302ohfNoa+s81hVjyyVw/lWvPbhuqyj/iewhBe72zl5nQVyGpfFwPQ9xDd1634BFqVED4KiWNNtqZvhvrAFD10rut54F4YL2BLEh3/YpPEUjNOw7lGhgmMFQIw+LYdEEf0Yku8DlHmRfeYbfGiJ2Sijm6N20VUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+gOad+7rw2K6PgjHhMVVVDJYXhDYb+A5iSktIUMROU=;
 b=DaGvyhUQT2pqfmPSRazgrmStom0cyTXjCG5Ins6TU4DMimqDY+YBXOpLbzkTBMY9jcuUBFjGQiXzcVIHOmLgRdca76+t44vvt8U2xA2B1Hvg7+5jLqmCDDic5Psswup3znimTQs+0KxBo6jVd4v0Ylwcf9DoduZvd++ufe/3XrDt2s1wyGjlfdi3ZEJa8nnm4E4lqBGS86ESFjpJxVoLNjM0vjFTPynMBCByEnvjijjsazNqwobbi8Du7uQr4qS6LftAcL6aXHVOVgwYNczJzoEgavVUeRIAnl0iKiDQ38M8XjrVdpQ1pCmp+1mOCeB+LQTdi6BwVohiZRYr27pbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+gOad+7rw2K6PgjHhMVVVDJYXhDYb+A5iSktIUMROU=;
 b=Q8nva+JXoBjH/Iwj5NXXaIEF4pKjbM/vQZT1S9v48yfG9Bn8vtz5+zxoSIcLzi8gCYy8hQ7JaFD0fDq2QOYmqGWeTNIurXM/z5LmSrKdYnZa6cEcjq2ouDzkG0q1dwO0+QoTDGM2jl2EQ6xS4zA3w4EGgmhYZAHnnnonLm9E5zQ=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB10090.jpnprd01.prod.outlook.com
 (2603:1096:604:1e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 09:36:21 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb%6]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 09:36:21 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the pci tree
Thread-Topic: linux-next: build failure after merge of the pci tree
Thread-Index: AQHaBUS2jhNEtIx03k2RKE91Wq09irBW+UZggAAC+wCAACAKcA==
Date:   Mon, 23 Oct 2023 09:36:21 +0000
Message-ID: <TYBPR01MB53418269A5C6F1419D007338D8D8A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231023110556.6f704b95@canb.auug.org.au>
 <TYBPR01MB5341114CB14098217765790BD8D8A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20231023073446.GA593739@rocinante>
In-Reply-To: <20231023073446.GA593739@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB10090:EE_
x-ms-office365-filtering-correlation-id: 9312ae46-f6fa-43f7-6e8b-08dbd3ab842a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZR6gPH1YXvLnkg8JdE1gjzyXIWSiYq9Mt9VPSPT2LIzlp4GXBGwiBc+o9nXf1Dw5ASSIUH0IA+/ZXf27jx6WIrDE99rvRqZl2Sqb0W4MbK8hl1+Ga/WMM77Al5CcDwzt4qDKR0mJUVArKtPaV4WRbeqeaHzxNHTJ8MLmMVgzn/NcOy8aaFblZiHM8rwqVRyo5lxOJzQePaJsX8iRcNM1xAm3GddTNMJjfMdisHMmgH4hB++QfYZIQBiP2ZtXsIi7DfjNaRdyxfwNHTovtnK9EOwfD0EpnDqPLp69OnDYeZyw0nfK6nVO/k0jC0mrowsyRaYc/dG5m9kSxI7NuLOjQQxe18XEaiCAaItp4H5Bf9n2naB/PHqWDtgVqz3ev9XsEiNkHpn+LfAScF03wxCZ/mIPcC4/lSCQWvyAGk3qY5pi2htNgIVmi0yvFv5NOwQgjQ1U56yzYuBt3BtHasiUXHMW2TQ5HuyUvBkm6of7jNA+pcZKIpAC+p0saY8mdUZ76waMIES+2YmL3I32WukkaeWUrtbJf18CkM0VVhHvrZ3q1D0ph/z8sGBYoUSvFZ1kDdJvQRgn7ITwZAvMF2BZD8NvcGXviGOi8qltPWH922U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(38100700002)(2906002)(55016003)(41300700001)(86362001)(52536014)(5660300002)(8676002)(8936002)(33656002)(4326008)(7696005)(6506007)(478600001)(71200400001)(66476007)(122000001)(6916009)(66946007)(76116006)(316002)(64756008)(66446008)(66556008)(54906003)(83380400001)(66574015)(966005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?m9ZtLFNz2AFGDsmdhk/NEUPIB3fVGpu2/gUBLooHHezsZR+KNEPaQA/K8K?=
 =?iso-8859-2?Q?LUqh0ztZdy/anq83G1qpYFvdlGqW8jiQeS+aIJiMcGUIRKqbxtNzpU0JiC?=
 =?iso-8859-2?Q?ZRwtl+mOt4eAPqWRiB/HqsxQSW0EcnA6bvtuOP+b5yjI8Ls10aQUoYLEhE?=
 =?iso-8859-2?Q?jw3Q+Q4qAEyhmtR1E36KnsKhnS8gj7faSNNLenwbVXR4cIJLyfsEhju4ao?=
 =?iso-8859-2?Q?8sm74AetnxvGxpT8kMPNSF3KaNj0xD4H9PkRrkKhhrHGcog6eeJijvtpuR?=
 =?iso-8859-2?Q?qyCj7v1snYNwIVQpCiB0ng+B7/aLZsR20jNrzv9wpDsx8fC9EHXdh7b+fJ?=
 =?iso-8859-2?Q?Y9nvm1+kbzfJzqx5qMsGA2VCXDj1UFum3sIalwZY9deRtM0CG5Llf22HtY?=
 =?iso-8859-2?Q?rypVT8Rh6Wp6Bq2y2r0yQqGAGVDQeeRAMaD+VYGsCZJw34HzeAPkfQcQjf?=
 =?iso-8859-2?Q?TKpFe1ay+Kxo4L9g9gK582I6vnTG0SMglqqS0Euab/XBjbtPpWGNOgGA2+?=
 =?iso-8859-2?Q?1ZwcbvfGdIX3ZnCotTnRrC9byL6LIQJiUFtnfCaGHmKDrC2zeko8i5wWSM?=
 =?iso-8859-2?Q?VRJJUKnz0tkVQ4an9mmK7WU/D+ovVjScnVp8DE6/RW/1rnGj9DWKYuRIkx?=
 =?iso-8859-2?Q?52VyRUiiJTDMNQRE6Xr1QuEmF9QGZ7pAoFsYMQAJZktjhj3eQULUxzTD3U?=
 =?iso-8859-2?Q?7yHxHTjqs2dW5qwjij/Wge3RT5eofbl6vqYmz+1aFL2uMbYn/svsyueu/r?=
 =?iso-8859-2?Q?VKtdJLfnAO00LI/CYUByhgRPDEu7s33NVJ3bMoE/F9L1Rwmjq0drC6wvE5?=
 =?iso-8859-2?Q?OrJ2/Z5bWmCqa2R6eRbwtYieZiheMnCoNzUpqDmi3LBKiAOollfrcqflfZ?=
 =?iso-8859-2?Q?x0tAQhBRrGvG5O1/qNVidJ2A6XDrKgbp3Y2MuivZONrruqjSg2HACZk1ig?=
 =?iso-8859-2?Q?vFRswN3R0pUHUoF8FxBihwVDMc3mmwniMm6fDjD5vYfM0y6Lvi/N/62Ja3?=
 =?iso-8859-2?Q?dkOLAXbKD5NJwMFUqpoiNXeQHDuzUA+0LYDeuCgVfsj5bkGZOaloSlTGaw?=
 =?iso-8859-2?Q?MBl7vBzf3UeDEVUq2SY+fOjeZePnsnbPGlRM4SFcxeDjupBajCuIzYQNnV?=
 =?iso-8859-2?Q?vLPfsz1M8SWgEDI0i8oibZYg0XzMLHsUySy4ASh/xvGCtaCUsOim8/bJpP?=
 =?iso-8859-2?Q?+XJ+sZsFW3QxJVLRzly/BL3d95h1D1R2urrqr9mg52Ani/wbjrf2NM7mie?=
 =?iso-8859-2?Q?k5VMZNCTmER9v99hWChgcS4bfMT76z708DLPYcE6f6/iNdODHkHtzvEWl0?=
 =?iso-8859-2?Q?opm3HEevVRuxGdgK252QA2VYMmsf0eVtcQMe/GCKVdW7t2u2HKVkZuwcVX?=
 =?iso-8859-2?Q?Pb2F80t9RXz6h3m5TF5fKAdT1u06p0ftG7NKKx6mhTBi5HBXa2Yqb6TWfm?=
 =?iso-8859-2?Q?etxO3gqe66t94XvTUpHzJaN9i10bOIlSI+Vq0CrLdpAtNTWvQ09jI0l/+o?=
 =?iso-8859-2?Q?5ti1bgX7BdVMZ3Ua35/FziEbRfDD4b9duUk6oz6WAA6fbIZyJr2UddweOQ?=
 =?iso-8859-2?Q?ClcIriLz0PQbfj4cyeWPh3Sw+d3mFffA7cLkVeVT4oCo5FGlKuUKQpE1/A?=
 =?iso-8859-2?Q?f1+1Pt67pZpwH/xjw8uw0SFAEWHO9wjIZb54Y+Pbr90n7MATEjxXRvQDsd?=
 =?iso-8859-2?Q?XhCH3u5axCRLbZcinbbbZI2e1ujT/mjwCvgb0KCsCW0h5gw3Xwu/Bq2LtQ?=
 =?iso-8859-2?Q?41Rw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9312ae46-f6fa-43f7-6e8b-08dbd3ab842a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 09:36:21.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8W8rd4r9rOC1wzrVKdWe0QGgzhmhkNWxLH3yEqVBT+9L0XXkGy4oNbajOgjU4UZPXMuL/UGl23vPPUkqW676PD3m/QokgUjeo6Qh5cerOxmi5MUT4XxTByY3kt3pJUJk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

> From: Krzysztof Wilczy=F1ski, Sent: Monday, October 23, 2023 4:35 PM
>=20
> > > Hi all,
> > >
> > > After merging the pci tree, today's linux-next build (x86_64 allmodco=
nfig)
> > > failed like this:
> > >
> > > ERROR: modpost: "dw_pcie_write_dbi2" [drivers/pci/controller/dwc/pcie=
-rcar-gen4.ko] undefined!
> [...]
>=20
> > However, I completely forgot it...
>=20
> That's OK.  Don't worry. :)
>=20
> > https://lore.kernel.org/linux-pci/20230926122431.3974714-8-yoshihiro.sh=
imoda.uh@renesas.com/
> >
> > I confirmed that the patch above can be applied on the latest pci.git /=
 next branch.
>=20
> I will take care of it.

Thank you very much for your support!

> > However, should I resend whole patches with the patch above as v26?
>=20
> No.  There is no need to send another series.

I got it.

> Different question: aren't RCar systems based on Arm?

You're correct. R-Car systems based on Arm.

>  I wonder why this
> even built on a x86_64 - unless I am wrong about this.

This is because I added COMPILE_TEST to the Kconfig like below:

---
config PCIE_RCAR_GEN4_HOST
        tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
        depends on ARCH_RENESAS || COMPILE_TEST
---

Best regards,
Yoshihiro Shimoda

> 	Krzysztof
