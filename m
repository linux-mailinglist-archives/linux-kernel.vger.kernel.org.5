Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106A077A00E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjHLM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 08:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjHLM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:57:40 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A877010F;
        Sat, 12 Aug 2023 05:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIYnSJ6hazW+jKd+UMDjI9liM5KcvXXhCEOpL1aFVHklp4WD0QiHpJw4Ss8CFOfDhKGVn6dbiiod1Gywcu5pimzgK1NCffuGWz8gYz3LjiNy55Oy/QnlKyr2SgFsQuAR9+BnxNjSteSXatTRHM+/0obipmgd5/Kjf38An/McNj2DUitRi2Lhkl4umtERXgC2p8AnRVmKocayPW6jWLX7epKKZRHGQnqRuJfnZZjC78Kl1iufKe9X0ZOKYTIhz3daAy+0N5qUE1dhWnQzKNvOnIuFio6kuM9Kmb2/OX5n22F8HfK8c6C+9/zN4pWIOZAerYucIQSyq0EzAjYRhMHi6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/hqtoHTV472AePJ10Ol/vUwnLp3kvMhWceNj4BIO70=;
 b=kP379G/bBFfnMbtvtIg3Rb03zaEqsaJUIPg1qUUpXmDeQ4coSG8hQUMJ7qkMF3L6dFvLJNZwqzJg4qki47Y6uha6eCCK+3/DYQDr+NyCQd+WnlsxfXchaU/BCA/6zfeurxeHLFfOOqVwFs/Fjxl89ZAJfiIlcNaYZ+IGtWw/YLNvav1njORggZcJWTvJLmQL3NSZ3VEACmJxzyyY8nfojEvF3FDqa82/1G6BLVKzc4cuIqcoOSbunqn3ZfyBoBAyOyF5jaysNLL3iIWsmvfqb19vj49Lvh4vmNDVWm2yvxSn9p+y1kiAJkUGG7ZBUwuUz8xXwx5CZp+iVHzlrt5lIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/hqtoHTV472AePJ10Ol/vUwnLp3kvMhWceNj4BIO70=;
 b=SsXyVvIDzGWdecxY36XJOQJSNyxrjYLjNPiyzbQ0kBFky7QxM8i1pWtKq0zvhg2pJEErFrnKHTRV/eS/+AFDpwIzkhUlRLTa5UU8reqHZGhL8rRZmtihy9QvkllOUhZHEpHenp1GD9tiFoP+C9JV0yHoEMb6C2zNrw0F1nIc3qI=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Sat, 12 Aug
 2023 12:57:40 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c%7]) with mapi id 15.20.6652.029; Sat, 12 Aug 2023
 12:57:40 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v3] dt-bindings: remoteproc: add Tightly Coupled Memory
 (TCM) bindings
Thread-Topic: [PATCH v3] dt-bindings: remoteproc: add Tightly Coupled Memory
 (TCM) bindings
Thread-Index: AQHZvAMchwgx+zTwNUuGuVr0d0h8Mq/JHGQAgB2jLMA=
Date:   Sat, 12 Aug 2023 12:57:39 +0000
Message-ID: <MN0PR12MB5953E72D7950581A8FB5AD82B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1689964908-22371-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20230724161632.GA3686365-robh@kernel.org>
In-Reply-To: <20230724161632.GA3686365-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|BL3PR12MB6378:EE_
x-ms-office365-filtering-correlation-id: 5a244b00-5ee5-4776-8f1c-08db9b33b5d9
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vDT+p4GKI70r2xKm58DG5tXJCQCtF84RibBKpqLlOEe82QN6VYeUymlki4wHsys4NWzjsFjmO7ZyQhwSZqrHI2vmHvbN3gLj5QfcNTufJm0Z/xJXocZnhoYXUOibQ1tgQ0oWXbyJ8UuSh5XyBraORMkyVNh51K3u+meQ2Ak5xBHMWeUe19WTrr6HUuLYuBnUbeHYePZ7/xFLQiALCPFKDQQ8etxGsgNx3TLXHKtmgGja5nIeM8CeHlr+Q2kOoFmnUeSab4ejMF9l1kAPUjprij5RTKW1HliuCjAyJH8VNKcqdSMJnq0zh7/ABBmdknTa+HI6E2C9GtCCUJsA0hSyRwgkcHgMU2x8hGEtLsiwwmQhKKHum6jCxnrCFnHo9EBV9JtmPB8/HPyMu7YFM+76k02LPiwkhY15QxKKIUURbaIXOM7N5iDe3P6FIkLXw8YPtOnmVsvsaj3UWdvSwfPdZRpCZRThnE0gDj+isjXjEa+nHDPHhZ/38ctwmmebaQZ2hF/S/lTciUFyXXZOLUvdN3cIFsBMPiJudJ1wvHHilxIzVbAIMSHAyNBZWDgDgTitDSNL9SgbpkVnS95dw56i/nANxgH5ddyku+ktTclZ5GRy8NTsodqPv8Q+Nu/0iu5q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(366004)(39860400002)(1800799006)(186006)(451199021)(8936002)(66476007)(8676002)(76116006)(71200400001)(7696005)(41300700001)(33656002)(6916009)(316002)(66446008)(64756008)(4326008)(478600001)(52536014)(5660300002)(38070700005)(122000001)(66556008)(66946007)(9686003)(54906003)(38100700002)(2906002)(86362001)(55016003)(83380400001)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eCYzHFU31W9RddpX2KPxYJ3IqlyyGRpf8pqSTtt6lX7krX358jU1+NROihww?=
 =?us-ascii?Q?JhdjEKmZKHTH7eZ2xFyGq24ry3tsfMjSPTDSFcese1MivtDlDwJtc1JTsDwt?=
 =?us-ascii?Q?Us1JyL+UdU6+Y8IXHbhlrD6AVyibQerhPU3vqi0Pw80UPhpkRuKC4rg4/fWQ?=
 =?us-ascii?Q?RA5sZQV5jDkabp3YLGsecND4YB+l/z0eMCqIjvPvXiRThAGUqqJJGhW+75VD?=
 =?us-ascii?Q?BdLgbNaC7YZY0HmY6xHz4zAriiiOstYcFEwRTwkYaMFfEqNhcb5MIl9Xce3U?=
 =?us-ascii?Q?4CAU65FMR6pWoNkkChnaQ6MoRQW+f/SBWdySPxjgtOGlXB5Crf4H8bx/dKfW?=
 =?us-ascii?Q?7wl8T52l7ulc38XDQgojrV04PKldxl6lqqNbZyrr7MPewOqWqo2kZzpNgWmJ?=
 =?us-ascii?Q?3UavA+k84wks2QCF1FiaXusXmGy1z0JrYoQbvWABAP+v9MAGHKp2QVKsMBkx?=
 =?us-ascii?Q?jYaVWsMGs/9cuprvipnT/boZ6oJYaxObJAubKdudJ8B406UyA9hmGbxUooXC?=
 =?us-ascii?Q?8RlLGvjh34QIUpgx6sgs8oNHIOnak41vhJ3039S2V/n3dIO0C0SClmFOBNr3?=
 =?us-ascii?Q?DW9mx0vSjECqhNoEqfbmrECVD/MBus1JPiJWVtM5FbIcDL4LK23bN9oRvWMX?=
 =?us-ascii?Q?gwcgJzTx3FBI64f1NX0JonFqAC6/8sainpVYoO818n69Qa3bFf6JpUUcN2pl?=
 =?us-ascii?Q?AhQh/lpy6HGAwx21pQ+NKdRqR1DRP0441jrXcYjdrK9aD89Uh8YvnvlUAaVe?=
 =?us-ascii?Q?95ZmpotA4DqGIVzg79GIiOJ4CAh9zYOHF19oH5ThYaH3Y2MX/SRbCNlqCp11?=
 =?us-ascii?Q?Z1imJ8ZaTm3aBuml02Tyw6hdcnHh3kRS52JTMl0FqVqpqoNHmgVjZbf/J3ni?=
 =?us-ascii?Q?UpzYP5kIFEsuRsQdGo1SnmbgFmS7prGT0kH7YUN5SgsjcIx81bxPFff/hpIO?=
 =?us-ascii?Q?m7Jr64IIvALh3mpMBTCf01CrZ6fV0COrf+d+cC7EwAvfOdVHGsB7LUQuLibX?=
 =?us-ascii?Q?c94U+LTzbEAaGRrxBNCxgdmg811Sd7kh9OJtADP3Bb4ivAOVw3nvKXk66fjZ?=
 =?us-ascii?Q?S0+wuln7ENNIw3luAOVKQUIl0TtqiRtuYyGKJ/fJ8Wm1oMRdACIldCtqsmje?=
 =?us-ascii?Q?Bnmao/nTNR+AEOQxIhYFlMz0f+259NUq/N+tp3xVHeZMahagqopV9XchATCt?=
 =?us-ascii?Q?nG0b3T+S3pHsjV3/dnfg8UBFLiZPcoGK9fkqwl19RpEivc5/Xkds2RbQcZuO?=
 =?us-ascii?Q?EzmDwIQQSghu6uAWKNJpmx9Nvpk4wCzObGG5SWGO9B2T0uVhShe0Y4Cj0aCp?=
 =?us-ascii?Q?Ci8PUl16LoqFdXZXFZFIlRwvzI692AEev6BhcFCYW1M/u3Xa1bVt+QBakCEK?=
 =?us-ascii?Q?RrxpPIRepxQh/GW0ahroXGt9lNifDS2kYX8fKa2+Lr308lVodYD/43bFxiov?=
 =?us-ascii?Q?BldfYmXoQbMhjhr70Pum5SDtItO/II1ACMXCVbjrS/GXCsVm96gKYWJJ/S3G?=
 =?us-ascii?Q?DmYZGZXTNjp3SMrHEi/UbLFEKFVnXvOEGOoFijS436MgWG3U1GCWzDLXDuqg?=
 =?us-ascii?Q?IOsFwjm707UX0VhR0TE1p/B5hBMY3AaQ1BPnszJ14ZONL63OHHnvihIPE0yH?=
 =?us-ascii?Q?YxbC7rwm/pceQbpVRQhaxls=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a244b00-5ee5-4776-8f1c-08db9b33b5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 12:57:39.9522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrCSzh/C+hs5M46cmls1/H2nQQxZER8mTheCWh/uv/dARmWfpv3vjDDsKLxNb70a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, July 24, 2023 9:47 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: andersson@kernel.org; mathieu.poirier@linaro.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>; Shah,
> Tanmay <tanmay.shah@amd.com>; linux-remoteproc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH v3] dt-bindings: remoteproc: add Tightly Coupled
> Memory (TCM) bindings
>=20
> On Sat, Jul 22, 2023 at 12:11:48AM +0530, Radhey Shyam Pandey wrote:
> > Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> > UltraScale+ platform. It will help in defining TCM in device-tree
> > and make it's access platform agnostic and data-driven.
>=20
> From the subject, it sounds like this is a binding for all of remoteproc =
for
> TCMs.
>=20
> Otherwise,
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thanks for the review. Just checking if this patch will be taken through
devicetree or remoteproc tree?
