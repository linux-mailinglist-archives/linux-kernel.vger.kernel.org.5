Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B267EB506
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjKNQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjKNQkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:40:03 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1B1120;
        Tue, 14 Nov 2023 08:39:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM3wi61g1OR5HO5xuTEDm5qWS5ENVWmq5SpjJ02CXCWayQopMolqgA/gq5bf2Jb5T677eS4/QniKNKsKf7NJ61089OUZZRSUzUUPR9W5P5eCQbRTOIMGtXZEXtjIDf0R+6+2CX2JCz6hpHlIpbseqN/ZlSfg8zMiSbZ34wwYhGobdygHb9wLjN6n7AYgt84Dq3Fsm3os+flPfp15y8jg7wQ9PBU1wEJelzV890A3qY5KwRS29YX31mdpwU9IGNLQkhoLhHmdS1YAoy6HAE9V6GX7Sc9229WIOvWADtDGj1APccACKvdw6lRlsfDfhvkcHTVGw8EVf7pFbART5mswFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxCIhFU5stRvk7SPaS/5tWwJ725fEdIRWt2n4v0Cb/g=;
 b=BDwyqFltHyhgj+kf+I9NxdGWLrzDMRtctsMDnrAfMNIj6EcEURi5Qd8j1swsuYCxOeERNVHIWe4Dwvwrnr1GPAD3wtAJecgibEaVQNqC9yp249m/yknnfyN+guuMQ8XYzl98kRg2U6r9KlrzmZSp22b/M4Ne4zAK1MB+6A6rWsIxpldUD5eTbjzod2CRi34Q4gzE7VknuxlVJbe4ypzvyechmbCaedEYF3ddTz2EKjV/tzU8Af0HEDfMhmfBE6atWubDgRLagO+oFRxRO1G93+0ehNfLLJ0DPcyia4kV1FsFswjrHsRH2Slx2LvAffrhj4nptH0Wew0OBDj80mUE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxCIhFU5stRvk7SPaS/5tWwJ725fEdIRWt2n4v0Cb/g=;
 b=KN3m+IY/NXts6Hl3Z7/mjofVEzWjxqhNMGN2TJ6CzNUKakoNNW+dg2qgkJId1a6qxmrcyuYl9VfTI1yoeJmaPPD9qCi+hRAJuinzD186uab9fkwxUTdlV+Mjq1YGQqYFBTx4IXyeBMR3W7xBxr6dvotwjFddNQPYFVp9krTd3EI=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by TYCPR01MB6078.jpnprd01.prod.outlook.com (2603:1096:400:4d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 16:39:54 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::3f89:e42b:ed6a:489b]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::3f89:e42b:ed6a:489b%3]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 16:39:54 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Richard Cochran <richardcochran@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
CC:     Min Li <lnimi@hotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next RFC 1/1] ptp: use extts interface for the
 measured external offset
Thread-Topic: [PATCH net-next RFC 1/1] ptp: use extts interface for the
 measured external offset
Thread-Index: AQHaFnt1CkDQLo7CIUey3eYN7z24uLB43VyAgABYKgCAAM+88A==
Date:   Tue, 14 Nov 2023 16:39:54 +0000
Message-ID: <OS3PR01MB6593C29DA43E7C5E862ECD3EBAB2A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <MW5PR03MB6932F6DB45F5ED179DF0BA4DA0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
 <490abfce-47b6-430c-8fc1-99536284c1a6@intel.com>
 <ZVL0dIpwCE94ylfH@hoboy.vegasvil.org>
In-Reply-To: <ZVL0dIpwCE94ylfH@hoboy.vegasvil.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|TYCPR01MB6078:EE_
x-ms-office365-filtering-correlation-id: a41970a9-db2c-4ce6-74af-08dbe530548c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: reDAjN1AjRWDsR8mktqcWXiA9i5uf6L8gpXIkrDkwTfofr5RMvxV0jzlALJhN7PdkGv7rqzUWSk7Bi3+m0lTW/gJc5wT+NW5j5npZ2nxM6cU4JlduYnDuAkhqErMiuLQV2/MF9G6p6LIDoreOMMYNBg16gQRMBfN2Qwz+u2e4V0DU+5mUih5rhBVEnc8mistNQi7jfIQ7rO1b1XQTUFKWIYTp+Peilis14fVDfGvm8SyE6dvZHsCYX42RxTaVd5edj2jN7rk3/JYlp874WluoLgPvkihQXch0V1jFm2b5cguh8NKone3SCcpYLfdP6XBG4rasKq8k8+x9a/ewd6yVxUlpQBViNRQlgcrkuJOCxJ/8bNGd42yxqHdpqAjX5nvgxgmzsCwG29b8W7kmjc31PSKzXXwSy1gmalFQGQDO7q/Ebfbjuf840lm963cH6hguT6gv5CTbrIwdnpkvS7K72BnuiLRTohb9iNP3Rn4Gd8z6HYLQ1iTYwT6+Vvy3WVclhDBdiqm3O/O//gxlSqO3HPb1BSE01P+/cUVuWj6akp6NLWya6p0CPfRgGf9fUBdNQ5Opr7oBTm4p52PavORmmvwvT7EabdVtHWXLsA89bplh5rxUl+8ygw9R8yYYDps
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(9686003)(26005)(478600001)(52536014)(86362001)(4326008)(8676002)(8936002)(5660300002)(41300700001)(33656002)(2906002)(38070700009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(110136005)(6506007)(7696005)(55236004)(71200400001)(38100700002)(55016003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JjsutibHbysE0bkq8H47l7amXyVdkGdKgR2hyYENHOKf8NOtqc0pDmXkeOAa?=
 =?us-ascii?Q?k0eu8UMKvuPmn8r9YGWIfqbi6pNoHY/M4Ru5BzaAlH5QtjcRvc5ZioFdOLyx?=
 =?us-ascii?Q?eqP+s1NnE9y+G7t4WjYfj1wJYYQU2BW1FrsXZoXCrzkqGM7dgkq1GATdHPsE?=
 =?us-ascii?Q?oRPeins+jeLJl/WfftCas6rp0woRdUMrlZxM+9PPKTz/y6MlYrmIQQBfapPJ?=
 =?us-ascii?Q?mB/00gPRqdyBRzUngNmJRtACZxAfRy0FHQEM11dVSIWEpBOnAUqRwarvJ6We?=
 =?us-ascii?Q?JalS30WQFdLRD2xRpwvykh8HgykZRChJtmUch+jK6fJ53qsdUV85RwiDfW4q?=
 =?us-ascii?Q?BSTjdkViZDBTuNPagnwtrWPyFRL0iTs47USo9iPY8uUwhfODlHmUDJ3tqqev?=
 =?us-ascii?Q?2NGqwZ1yZmgXQrk0NR1J+b4i7xbaDDI3JvZDkf2iWlc5y8VFxK1IRkJ8GBym?=
 =?us-ascii?Q?q602Xh4OD2n44V/bbU6oP5sP3PFqMkiMzDtB9DfBX7MX+XM/UeNYDZNZpuyg?=
 =?us-ascii?Q?SBOT77g8tJVl0sot/mafhrrhRVb3zVAhzOgGbDD5JIzaGTgQnAwGHLLMhFXV?=
 =?us-ascii?Q?ft4FmQSlyiNGm90aq7hZaEb5ax0xXZv/BazaTfksfrFDJCF22NAJ6i4QN5VT?=
 =?us-ascii?Q?FDo7guQRHuzrPWgwDPj+8+gmMy0wXs7uPitrHPOoI8SiINtaPlK4wNGotmxZ?=
 =?us-ascii?Q?jDCjwzg39sqh0vhs1iIj144qabM6TH/kOAIOQCO5REXBdIjnJltaCJH0N0vm?=
 =?us-ascii?Q?1gS8DQqnf1vBx3io1zgKMAns1shUVOZeS7e4+rlH2PwbPOEVNhD90Ppj7k6M?=
 =?us-ascii?Q?p/rXsZQegR3trCNgeOaFA7XYRUTWPeU9M86GaqTIeHlxkUVDCW1CQatNmsKH?=
 =?us-ascii?Q?8uai8ZrYA5RTaNNddZghd95dX9FN4BV6h/tp5R+++kuuSHWXrzpt1soHCElE?=
 =?us-ascii?Q?ii70F2Avg6rmZslNhUFiN0LfruBJzkIXkkdCmgRM8ZlqpvjNOu8+kololDxY?=
 =?us-ascii?Q?0oRpTg0f6jgflbdKS8zCJ6zh1v3wgqMq01/x3YTiNN50iIs5BxDWCREzNXPJ?=
 =?us-ascii?Q?2W/0g7AwjRKmCbe8oWXKTCBBdIxJDUTnENFKMa51ZS5/s/73m2v9kRSUsl0T?=
 =?us-ascii?Q?HRR9MH2SMNyRiyyds38fLhlzDWQEYVmZiifc4tm3vH0F+bpN/DPsdtYFDA22?=
 =?us-ascii?Q?DaLyfo+NjJtuPkK5ELlOym0Ti3t6mjDmDS+4ZQaexg98syyhB4wkRT2r+xD0?=
 =?us-ascii?Q?euZiWPMjmbIEgRUYoWn0dgFhRYmzyxqUqJL+rFN6nJJ2iDZbKfnxSGzRdhFV?=
 =?us-ascii?Q?yOA9HLO0vod2md21Vt8kZfIDtx2oDimcOGTU5/UlYNha2Si86VVKeYH61VQ0?=
 =?us-ascii?Q?mKpfR4FR5JLeyfuJxH4gMw2bKeb2lkmHiYq50y2OHoLLDDz/rerhFE+Aw4mM?=
 =?us-ascii?Q?jfkcwlFJ3gO/OheWm/7XyIbRsFX2viasCZEsQP8kPdnlUHro9pD0vFPXAT33?=
 =?us-ascii?Q?6WxMMvKbwU2fJ2X1S71sDsLU3BMUc2oMOd5l4Tk699cV4QnlO8v3REaI7OIf?=
 =?us-ascii?Q?kuZ6ESZ6UnRAEctnEy8ovUP14AWhdQOGp6idJc14?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41970a9-db2c-4ce6-74af-08dbe530548c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 16:39:54.2618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVDoG2sndoHGrT9IVuSrfXbKL5UHPBSWiHDOYP1/PjINrNDm242NKFmoqEQj9RBrGzxlk80x5x0brPUwRp393A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Mon, Nov 13, 2023 at 03:00:15PM -0800, Jacob Keller wrote:
> > You mention GNSS, but is there an example or a link to a driver change
> > you could provide to show its use?
>=20
> Yes, the new option must wait for a driver that implements it.  Can you m=
ake
> a patch series where the driver change appears in the second patch?

Hi Richard/Jacob

Thanks for the review. Unfortunately, I don't have the patch based on the=20
Existing PHC driver.

But I have a brand new PHC driver for our new timing HW that implements=20
the feature. The measurement is done by the HW using the=20
Time to Digital Converter (TDC) that performs the function of a stopwatch a=
nd=20
measures the elapsed time between a START pulse and STOP pulses. So I have
GNSS 1pps input to the HW and TDC will perform continuous measurement
between the input 1pps and the 1pps of the onboard PHC.

I also have the ts2phc patch ready along with the PHC change. I already=20
tested them on our HW and proved that ts2phc can align the 2 signal using=20
the existing PI filter.

Please let me know how you wanna proceed. Do you want me to attach the
new PHC with this patch?

Min

