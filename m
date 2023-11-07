Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9487F7E3801
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjKGJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjKGJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:42:41 -0500
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A910A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
        t=1699350157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iw7QAZJpv2/t/WEGNgJgX9o82ZsApkInULH6r4kuz00=;
        b=ByLq7H8KmRReII3TnjowXg8iFJXq4z6sAUg4y/rJ8EKAcs02D+x+cZ9ZpiIonMMAmQbAaJ
        wkIK+Y7v5hZDl47u4SBnLiqd7+z9y3nm+lICuBnQBQNoWfSp7bihlQjACVopR7S2gaTUHP
        FhXSoXtirC+ZLnxRnxfJbT2nIIbmyBI=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-MKV1JAO2NeWu6yRcufyytA-2; Tue, 07 Nov 2023 10:42:32 +0100
X-MC-Unique: MKV1JAO2NeWu6yRcufyytA-2
Received: from GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:40::8) by
 GVAP278MB0120.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Tue, 7 Nov 2023 09:42:29 +0000
Received: from GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c00:111c:9d5c:7066]) by GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c00:111c:9d5c:7066%7]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 09:42:29 +0000
From:   Stefan Eichenberger <stefan.eichenberger@toradex.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] USB: dwc3: only call usb_phy_set_suspend in
 suspend/resume
Thread-Topic: [PATCH v1] USB: dwc3: only call usb_phy_set_suspend in
 suspend/resume
Thread-Index: AQHaDj+z53GEj9qQB0uSGx9v53wrl7Bozv+AgAE8U8KAAux5AIABqPKW
Date:   Tue, 7 Nov 2023 09:42:29 +0000
Message-ID: <GV0P278MB05896EF2725F208A93C0294FE8A9A@GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM>
References: <20231103102236.13656-1-francesco@dolcini.it>
 <ZUUkqeKFZmsubxu5@hovoldconsulting.com>
 <GV0P278MB0589921FFF5487D2F94D3FF2E8A4A@GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM>
 <ZUih4BJLkslLIMx5@hovoldconsulting.com>
In-Reply-To: <ZUih4BJLkslLIMx5@hovoldconsulting.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV0P278MB0589:EE_|GVAP278MB0120:EE_
x-ms-office365-filtering-correlation-id: b813b5da-b5d5-4dd8-52a8-08dbdf75dbd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: RoNYUrz/91bIkzVQM022r3qjqY3QdodRa+vs9mYUDAcScGHoX7JCPZe3SzjCmcesfaSOTNoze7qnVput5c4Ttcy2c2psJF6W7L7mSwtfYb/kKhV/d1xU+jSIL7NOCvQIhy5p1YtJfcTa7F8sNzllggomfoEMaUbl0Fff2tGtgn2CrMMNHm7WgXxGizz52iEHcKeNOW7nOUgR9C5W9RqZ5U7bbharSPhpZ1F66gqBxrPeV7KKGqvwE9I9JACSa3JaaZ8lfTnGnPUqs6ULK7fXkyOsRthYwk4KCfMBMZphB8TFSsvhY1DYDwkC12eaFMWlcyvdcVn9qTMDDwhejVE+5CIwsP08v+Uey5QWsZOWnhmaQwlxGLSZSJcSM6qbTS3lqNcoTD9OFPd5c9l/KyWU3TrGR63jFujv9480GVQPI7VbyodzAWrBO9yAhNpRQE0TMEP2d1mixvclLHyt5hvrum6l4SqBRl2o4CzDR7ey8v35DVClikxLbzFRhusu+xxSusjPv/GWJtHN6SRvK/xd3o6M5tmArEeMUwUlxHHujldhjy4y0iE9NQy3Hkjv0XYa9Qim35HWAHf/vf/1FL1t5x9DaoV7pITCGrnzZrSgSzNpI9fXH+tmkpljI0JIztbI2UlPOOwCQ9gjgNzfoX6+vNl7bo9kP+zq5zfGtpBYOmo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39850400004)(366004)(396003)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(122000001)(83380400001)(9686003)(7696005)(71200400001)(107886003)(6506007)(6916009)(478600001)(316002)(66946007)(55016003)(66556008)(76116006)(4326008)(8936002)(8676002)(52536014)(64756008)(66446008)(66476007)(54906003)(38100700002)(4744005)(15650500001)(2906002)(41300700001)(33656002)(44832011)(86362001)(5660300002)(38070700009);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u47blGj/Jd75Twf4bTys+Lo/TG4onlDSxmMO1EKBxoV4Pcd4gm2E+NMTca?=
 =?iso-8859-1?Q?G43oKQHFZSPBIMlBAztUj9hFZp/JqEJO9xMQzh4UCziawosXkwhcMg3BVE?=
 =?iso-8859-1?Q?6GopeGawaDYra/1qONRjNAaawhzRcUzVrpI486iS+yWYgu6zywBPTHFiFT?=
 =?iso-8859-1?Q?oTXiBNb3mxPbCGL8/2Od1cRbd1VcdR5ocfmhx6gaOH3mwRsmhLpfC0u1jf?=
 =?iso-8859-1?Q?O/V/ojgrxGRG3sOwwx6g8pTPEIWBni7Z7aBjHe9SjfPAu6FYpiS+IyyxWE?=
 =?iso-8859-1?Q?sIDt/0688rehgLqouH90TsDeMG2umR5G4ThdVbf8gTXLH9RtCVOD4SkMt8?=
 =?iso-8859-1?Q?/eg73vcV+r+RRpRC+SAy+jp6qPGNYqN9uOZN7q4hnS7/LxN+Tp/bxv5P+m?=
 =?iso-8859-1?Q?vb2oINzBX5ShevjzU8JDuxh91Sm/0Kp2Fmmx7jxpcGHGRKTnBlD3Y5A0U/?=
 =?iso-8859-1?Q?OOPrSqNZNt8PDk3ClqC7TrbGbUWsGJrGepxQFP8gCBIaFnpkAhQ4ZEkurd?=
 =?iso-8859-1?Q?tTN5ZOYnPql2OiTUzuM0VJ8iLR1VeRh4OUQ74nWfHMFfhW3rOOiXumHW+X?=
 =?iso-8859-1?Q?kFSXUSiZuvWe8hLWnWI99MflX71F9N4DY02cKWoKvUXxkHeEUejwJ1sA79?=
 =?iso-8859-1?Q?4URPLAJdEA0/M5hY1o0i5srAqVbXBJ5iI0Y83WJvOS/nuUbJ4wYblTcnZK?=
 =?iso-8859-1?Q?xRdNz2/g2a7wvdD2/rRsDTva8t0SWijIftBrB5YsmmOWrS7rUmR/CIqMxF?=
 =?iso-8859-1?Q?ntWUm1wI2rL7xFWlSrFQdKZ/nE7oat7UlKWEGNOCpB18U8whiFp3CZEIwh?=
 =?iso-8859-1?Q?WQqUUw17Foy8oQ9w1Ic9e20LleR8prBQkZeWK3I67YVDWua7pohb5h8v5/?=
 =?iso-8859-1?Q?JRLTKTrSz8dmB8xJxhcFx1WJDbDBNCXcT0A60e+VXin1O/c0gK8W9ErGtz?=
 =?iso-8859-1?Q?0oiqxqnW1c7KuOSxUFNV/LL71FsIlX0IFPULTynMHGJvSURTYSN2zMVOkp?=
 =?iso-8859-1?Q?rhWoDbP3DBEZcTo2zQKXRxHDwDpUGuXWvp7Coxr88QAdHcCeSy+x04Uw0c?=
 =?iso-8859-1?Q?uBIhSDb34y2b3FjinwWQnRnqxx2ArK19iqPLAwaU5bMq5EvLdSI6A+9+/0?=
 =?iso-8859-1?Q?xk9g6IUUDZlsHQwlOQ/78DzXxSvDojuZTtiFhSS4IT+EbKN70nSxTmJYKI?=
 =?iso-8859-1?Q?YGYQ1kBPe4balXm2xQ1/qj+jPGffoMEmAKUUInQK903Ln/9uDmXjeokj/3?=
 =?iso-8859-1?Q?PLcDz/dpeZoHF9+KUM+oZJGf1uZmjKkJNBpSt0L+Uev/v8hoO3CcxXIk2e?=
 =?iso-8859-1?Q?mNTGE2NkxvSXxleqZjw5zF79uO9j27trP4kZwh01frYH2Bsbc/IoXYI9fL?=
 =?iso-8859-1?Q?vE2Mp56B0FruHrkPh22qHI6bJHFXC/LyckfOja0rI0AVDi98edRrAdFT52?=
 =?iso-8859-1?Q?d1yaTszmq9XZVrHCf7zlg4gX2YOxVrIQfDmpUJ7LQbaj5M3cYVvSsp0khH?=
 =?iso-8859-1?Q?hV9HIp4pzQIr6s5HCsZ7Dzy5mc3BZdLtu93v1A3isU8p94BWot8mN3TAA2?=
 =?iso-8859-1?Q?2PuOahKTSe4dVvqIunVyqDMVFYYt0xwFJsg2UbmenGHjZnESsEb5aduKJk?=
 =?iso-8859-1?Q?rO4dn2lkZUJwRNVlv5AlFMhNLfsPJFEoYwnvzGb0R55XnM3C+ijR0JnwDA?=
 =?iso-8859-1?Q?RyyldhAdOTU8xr5H0JTUIPzHhH7zC8/j1Sfh9KsxLeq8mvqJNdDY18k7Qj?=
 =?iso-8859-1?Q?LxRQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b813b5da-b5d5-4dd8-52a8-08dbdf75dbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 09:42:29.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0zI67mdoH6Bgkx7CIdsyEf2txhccgqESkx09zz7cfcAWvMK68ip55dQ1aGg3yZ6rW9LWj+spBO92Tb8J5/1PNgnGcUG7zMG47cIVZRgCwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0120
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Johan Hovold <johan@kernel.org>=0A> >=0A> > We have an external hub=
 that we want to turn off when the system goes=0A> > into suspend. For the =
i.MX8MM we use the phy-generic driver to achieve=0A> > this. When I saw tha=
t the dwc3 driver would support the phy-generic via=0A> > usb-phy, I though=
t we could use the same approach for the i.MX8MP and,=0A> > in the future, =
the AM62. Maybe I misunderstood, would the right solution=0A> > be to add a=
 suspend function to the fsl,imx8mp-usb-phy driver and use=0A> > vbus inste=
ad? But what would we do for the AM62, as it doesn't have a=0A> > phy drive=
r if I'm not mistaken.=0A>=0A> That's not how the phy driver is supposed be=
 used, and for on-board hubs=0A> we now have:=0A>=0A>         drivers/usb/m=
isc/onboard_usb_hub.c=0A>=0A> Have you tried using that one instead?=0A=0AT=
hanks for the tip. I have now tested it and it seems to work for our=0Ause =
case. I will see if I can use it for the other devices as well.=0A=0ABest r=
egards,=0AStefan

