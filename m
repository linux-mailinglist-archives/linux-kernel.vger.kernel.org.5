Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4C78C834
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbjH2PBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjH2PAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:00:39 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2095.outbound.protection.outlook.com [40.107.114.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA8A184
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F019AOtlL6dLNV/AUPy2tjesaIv53bvYqY6YrMM6KnSL7F8wpFp4bUSU7vG1u6xrnwxpX+z99tjVM6/LUdYzBg5ad3cwF2bnBzlFRB62nzkVrzj0Ut1rbpClYNaMVO23wlppzAOF2bBm7mENyfodra1MXunY+4d9l9xwJKgRMeY6PD1uyvMOO24Aqwq2xsWAAhxAXcGIa4qJL7N04Vruapww0jjDj9erVYW6CmtjRwiK9JJoQVGGj4qAxKbNFJfLuMabhqC4QbTNHXkFVWM5AbFrCUiexFOfQDbDVJSjCwt/lIj2bJRmPiXdA0Gu1DaEYrtrUahQ1rQ+RB/bMauU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC3I7S8j8cLKbaSrf9a6uL75WGPtX11xcbwbcbPK5Es=;
 b=MKTxqNw64zNEStK2YHxYMRtg5rDzBGbtNB8yLzNVicu/tPz4RjfG2sK5AkIeO/u9R+NQ5qSbnsclM98IzRj8dGaaWl1YVtD7cdiA0vBenU+oWgl9fWGC7+5qezmMi9jMcBmo7tSuTIGcEtWR8ntaSVvircNLYYfvzReZ/0Wg2jkRZMSfPieut6OZNccmtKFW+Q9xXJANRnPviHxsML1EgWR0snfcMOP/hI75nrfpOOT2LPWipSTJJOBSxGBaWB6DmTKEbIfWC2Xdjn7hn5CbsCxKTSThBlWrgVmtYBOlV1UGxWZIoW1HsP6QM96mmwiuNCnp9Ra9cxZ3Q1qifxtiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC3I7S8j8cLKbaSrf9a6uL75WGPtX11xcbwbcbPK5Es=;
 b=mLKdo/F52Od8HOH/begROir66G31Il4XwkIsrls3AnbqmwoECdvTvWrBy3Svsot53bQjJ9cVEMlvyBSSUrHqhE0BripRo98yu+PzBHRgW6KyEw+mGEzKjqXqyHmDRPZp7OrBiNIoirktJT1uDr0AkFWaFjx9G5cFRdok0630K3o=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8520.jpnprd01.prod.outlook.com (2603:1096:400:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 15:00:34 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 15:00:34 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] ASoC: tlv320aic32x4-i2c: Simplify probe()
Thread-Topic: [PATCH v2 2/2] ASoC: tlv320aic32x4-i2c: Simplify probe()
Thread-Index: AQHZ2eNQZPF0GhfjqUe5ZwzG+CwswrABXvsAgAAAN/A=
Date:   Tue, 29 Aug 2023 15:00:34 +0000
Message-ID: <OS0PR01MB5922EE87436B6F74F5AB311586E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230828191014.138310-1-biju.das.jz@bp.renesas.com>
 <20230828191014.138310-3-biju.das.jz@bp.renesas.com>
 <ZO4HxMErjEPvHuM2@smile.fi.intel.com>
In-Reply-To: <ZO4HxMErjEPvHuM2@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8520:EE_
x-ms-office365-filtering-correlation-id: 1026f647-7ada-4111-f9dc-08dba8a0b270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPsz8biM8A5KvoSPXyeST8qit1C3d95QdPNDMoONT4HxAC45LcrEBDQsDiZ1sE70OFbuIUdClHqTN1QG5BRe9JAn2FQp78Ou/3c/VvCxrQ/UZIq0a8lJT73F+2hP4X3/FUcIJtT2FzZHKI1j+rGKSvxtnxF4HjQisqqO5OLcByNBog00T1twOQGHByikmmD61PpNcB7L386hMr2qKmjJwPcNnne1zGFp9xirjhCKsaypPB6yPeiAmbYIm4jJHyl3uwzMBQCJTMLxg/LpiwyPyfv+djsGk3bH2/leKkRlA9aox/BVB2O1uHjARJG0riijLpg7/cHM3qtOW6xfyf9ct2nTbcs7v/2ZW+rxJP3nXfT6wBr6QOhzTR+rVj9yCuK0jYJ8nQHsCCIFpBWXFK0Fx5MNSaZWJAAH84sr9Tru82gk+Vpg/+7uMts6NDY8MldNjzWbvaOM6biXCB6InRqzKYD+z96C6pRrivPohNlv65iJZQeVBmMPZwBG5KMnNOD18JKCz190hu9qhhuYTJ/7P3ikVrGdP5c82H+1Y9Huc7FDvVvu8g2PjeY3/1nEEMhjuXxWM9Ol6RQ2jPUJcGbFrbd+GAMEJm9bO/mHu9hUJmIxVaSR+CKCiSe2EpuqmYOY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(186009)(451199024)(1800799009)(6506007)(9686003)(7696005)(71200400001)(478600001)(4744005)(76116006)(2906002)(7416002)(316002)(54906003)(66446008)(6916009)(64756008)(66946007)(66476007)(66556008)(52536014)(41300700001)(5660300002)(8936002)(8676002)(4326008)(122000001)(33656002)(55016003)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CvUvTcCT0WDZqhVrmwu4mlAsmGwXznJW9gZmjqkx4i/5iilbYIjvTf+66h9w?=
 =?us-ascii?Q?Udwpz3G55GUJlx8MFkuEiDdR1KUC1rxyMBMVskKKlMavhasGrKuS27PfCb5q?=
 =?us-ascii?Q?LBP2Z+c6ELpJ+lanDGnr84j9fqiRhQ5IxsiJYW59iCnKkJyUh7cK+bySY4C+?=
 =?us-ascii?Q?+XWNOCqPo6xt3NiWTgvOkkXuUICGrFZecZwrrXs3F0e/UEynK+eqPhcOXa0z?=
 =?us-ascii?Q?t9Lm7c1msLyBQ6Ogb4E8Qck6Lk3LDzFhQ+LER18kzjsdj+N9i+a9xJu2YU9L?=
 =?us-ascii?Q?1tzR3FGfw0710fvuw+UPCTPqbQ0eS+6ATi7pXkumW78uJDfRR62UEMsthdm2?=
 =?us-ascii?Q?xNez1Y+uCWWVnFEs4ikha+doooVU8tj6W30FwaMQypn3AIgrRSdH9j44GOO2?=
 =?us-ascii?Q?aWSkmHvWqemkL4zitXMTQ14+og9L14/yjJyc9Z2KjUNOlSpqdmUfu40cH61n?=
 =?us-ascii?Q?4X1ziyTcLTO2yHk75rwcapgV+g/lcFYwL8HzWoYH82QCOYqRKLtLunAx7A49?=
 =?us-ascii?Q?DO3MUbuL+MInGg0NgEAsEdpbLzD1qXlBCxPzRPoelbvqj3aeC3bCEaDRtde5?=
 =?us-ascii?Q?sU9YiaMJ28DZc8YMZwKcybEkFcCwd9L1tXG6z3M+HGItljIQSpiRd03/b73y?=
 =?us-ascii?Q?pNDjfLiV37QcC2/uYVsiWD34zS9EAOoFyFXGxXZglvL5UPtj4dd/WGxs2rc8?=
 =?us-ascii?Q?LgcyWNKVxDG2TNRfANqegbbPEc9jW6dB/HXYBzedv2e7gEheJMBB2GDnvGyq?=
 =?us-ascii?Q?Lz1Qp+evfH6+vcN7XC/ZQaEnWiqugWNOct7GxTcLGmanBuiELStxYkJliKCy?=
 =?us-ascii?Q?u+feDqICR6NfF7hRcDhB5lvOZIcVx00YqfDMarZTVdcc49x/Y+Qz7RIQdt8P?=
 =?us-ascii?Q?+kJGJ8I+8ncExLOyc0w8O0RcmC3ZjtQ6bm3XWvWGdMRv4CSmJKhcPmDG5PsR?=
 =?us-ascii?Q?no7Gne5/JP/EQ/5jD2eaYc2Dc4WY13AdtrLCZSHiF45GGeAnbLH2lBRhyXCS?=
 =?us-ascii?Q?hSN2AeplyTGMWKQrHSC1FPhZnRcRWKGDhLHkP9FhlXAxtOBAhc8QSv0PR+1G?=
 =?us-ascii?Q?Xa6Oi/lGaqrfTJxN+FITzPDxojC25zhMEgx7aj6BRTUOTajIxd/ue5ZNR8Xr?=
 =?us-ascii?Q?e/dYjaEVRLyFVsw58VMXzfMb57vnflmwxxb94DdNhh13Yg8lnQ7v48gNmonQ?=
 =?us-ascii?Q?VL41+oFTHBYeSDO4DVYOAowtEnrclIsDSy5W2tZSKP35jTNjKcmIBJxuZwKK?=
 =?us-ascii?Q?rpjUNWpwHgXs7pNHbGmGmAeKUxhnvtv+52ROAVq9Zwnu5/UskvzrCqS265Ha?=
 =?us-ascii?Q?vP3YZtsvWGFtFTUgpAOr6ACRuQSTc6qttvHwBCuR9RTsE2+DwQqF8mMfii7j?=
 =?us-ascii?Q?T+uGXmALmQPb7/cNw3LgKmyTLN9IidRgLgCOL3p/ucyejALR26ZOtuRlymEk?=
 =?us-ascii?Q?3rURtqr3BTK7gqlUbC3tnopYZay7jq8gzSjh7GKavhpYBcfPWZzSoyPxL+md?=
 =?us-ascii?Q?ONoGbmjoHzSxh8saSV16IVU790FEEU0VqCbWO0LsNCAemT/mmqzdMJYmO5zG?=
 =?us-ascii?Q?R7kScl5OUGbDj9W5nGk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1026f647-7ada-4111-f9dc-08dba8a0b270
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 15:00:34.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGpE0ZEoO0Bb14rdcinkMpLinGC4iUYFFeEaALXm4moUYiki9ih0tf4WFuQS639lm5F3l42VzrAv9cCtn1Zxs8CFpapu4etP2eRL2gjmdwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8520
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH v2 2/2] ASoC: tlv320aic32x4-i2c: Simplify probe()
>=20
> On Mon, Aug 28, 2023 at 08:10:14PM +0100, Biju Das wrote:
> > Simplify probe() by replacing of_match_node() and i2c_match_id() with
> > i2c_get_match_data().
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> assuming that you finish this by converting SPI part as well.

Sure.

Cheers,
Biju
