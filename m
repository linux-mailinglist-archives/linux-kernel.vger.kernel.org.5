Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F17E0F3F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjKDLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKDLxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:53:05 -0400
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Nov 2023 04:53:02 PDT
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2685ED49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
        t=1699098780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LuKmG01VgCnA6Ed3ojYdNagDTwinph9EBpGlDMah87c=;
        b=o9b2cZ7z2K947wdWXEfWrr0M7IFKjz9FRoWPKvgudYQt0y99XYs7UcNv08L9DaeL/3SYSi
        QGu55flSLt75RVUYoMiKfkINeEgE5rj8RgtJwtRuSzcr76HJWrxc+mlKAMr/wDVX4cFjmR
        L8SjV+jiOq8lrp+Eu9euqKfB86Sk79g=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-50-rzOTtaixMTiTUqdZJRMgGA-2; Sat, 04 Nov 2023 12:51:27 +0100
X-MC-Unique: rzOTtaixMTiTUqdZJRMgGA-2
Received: from GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:40::8) by
 ZRAP278MB0899.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Sat, 4 Nov 2023 11:51:22 +0000
Received: from GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c00:111c:9d5c:7066]) by GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c00:111c:9d5c:7066%7]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 11:51:22 +0000
From:   Stefan Eichenberger <stefan.eichenberger@toradex.com>
To:     Johan Hovold <johan@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
Thread-Index: AQHaDj+z53GEj9qQB0uSGx9v53wrl7Bozv+AgAE8U8I=
Date:   Sat, 4 Nov 2023 11:51:22 +0000
Message-ID: <GV0P278MB0589921FFF5487D2F94D3FF2E8A4A@GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM>
References: <20231103102236.13656-1-francesco@dolcini.it>
 <ZUUkqeKFZmsubxu5@hovoldconsulting.com>
In-Reply-To: <ZUUkqeKFZmsubxu5@hovoldconsulting.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV0P278MB0589:EE_|ZRAP278MB0899:EE_
x-ms-office365-filtering-correlation-id: 71912f30-62a0-4532-e6b6-08dbdd2c5df5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Lij1AQ1b1oo0eyN1iswABdQzsj2folXl1eWlJWtpQDIE5dolnkjx4t7Z7GxcoGEqM7b/ENYZCI/txeDE59Bs37D/eXsuU5a4+e8tzLxDiRH+EsFLvDpVIv479T9NRWkuzTnqi5LdkKdBjUGgnz/JofEMBq1wBQ1aB3emn1aiJUvEFC9GyyQ6MmNvxFGFKCSBEqsXNQ4TdiC7gdWvStxzEys23wmWn78/IareA7eIpzOfFKEXe9XNPuiiHclAAoHV0K083d/hsIltX3hfqD2g+COxe4T5vGbGBrR5J+tloptXb37CCa9aqaZDND3uBlUr0zF1njkCLdEoI87TbEwgA6kPsWk2/TX8xo9lFsSlA+ElC1VtB2zVDpclrEOQUX5mvXr9L8GClwKBOqyPg78FeMcQVGvmtFyvpnrlwUzlxFqnP417OkmlIy82w5Kr+iAUTXDa23V5IXVqotKGSM/uGObILlMxb+U/PW4uy36B/6ceiYM+yKPra9nJIAexZcTIdPE/r1EXUJX3IbjahP71G7JafWrGqHzl9O7w0xo+PAP/s5UdmPsZPJp/3ytjDMPqnpVuB9GPkXxo1oXgVowi7BZQVtX7hwnaU8HYOQfoNEj7I5wNpqac587Dyq3jxc5RldO9uLKGFAiZMQF3LDLXyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39840400004)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799009)(186009)(55016003)(38100700002)(33656002)(86362001)(4326008)(8676002)(8936002)(52536014)(44832011)(122000001)(38070700009)(966005)(83380400001)(107886003)(7696005)(6506007)(71200400001)(9686003)(41300700001)(316002)(66946007)(76116006)(110136005)(66556008)(66446008)(54906003)(66476007)(64756008)(2906002)(478600001)(15650500001)(5660300002);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s5OhvYHHikBooriDFDl0VKmq57vQ0gNP18hoBc+dJRfovVHiEJkd7T4wIg?=
 =?iso-8859-1?Q?nki+w4wz3EC1IgAA1M4yItYChoLQKwf3CT+sWI5E9t1Q9nYg1pgJyp4h74?=
 =?iso-8859-1?Q?BqeVDmlTkRAYEtPBOzQbZbm4ZUjZMnBPtV5UmYgJ5IXnfmH0zrkDrkZ6ge?=
 =?iso-8859-1?Q?aT7DOAsBQdFLIFKBZeZLHyYSGBWYoxEUjoL9A0uJb3goJ8gEWBVXxF6wzE?=
 =?iso-8859-1?Q?+m3+rKHEBJUkCbFvBQqxxkk1IXyj9+Re1xJNr7sHRA/9cKr0SRU//tRunq?=
 =?iso-8859-1?Q?D4HRWE6TmbDYmTUz7IRG39l/g6IG6ZNhwYqLZjH0m4btOWyR0PbHByMr8z?=
 =?iso-8859-1?Q?bwrHejPOYbc081KIRr/qOSaxzAlcef1KK8HVdJ8UfkLc7cSvX4l3Fh0Oy5?=
 =?iso-8859-1?Q?rTavAUBUZN3EQMrG0ScamFWLgQ5RIYrO7F4tUez33LD9c5oCISs/9vaCEO?=
 =?iso-8859-1?Q?ijrKvtt8eG4KCIKldcb9OeWYCyxSoVUVScK4+siVtWjzgHqdsfuZQHkUOw?=
 =?iso-8859-1?Q?cjHpIMJl+yab3OSYApdajJCOzQYK6THgjcoYBKmipdjjkNkJJTekSyMlUv?=
 =?iso-8859-1?Q?sX/xx0ExubwYsj2lBR/av5oYhvtdxvKQmySyg1tyzxntiCa3J5yGik46L4?=
 =?iso-8859-1?Q?F/jUusBJbCWFDWrw+RN4PTnM6OS4NtkKlQuSeF/zakwO6izI54v6HWJi9/?=
 =?iso-8859-1?Q?JwVNXwv71Bk3KhDUo++iGpKZYeP6JyMYT3fXeIDesONXlEfL3qizWKx7af?=
 =?iso-8859-1?Q?YozqqYz8Gw4oNXQ6xVLt/0C6pIJl6xzqR0+iC9MidcWMsYieIpuT/yEbo6?=
 =?iso-8859-1?Q?DOcmgpUxvjR+askt0wr8BBeCKxjuEJjfvpVArPrTx/W01sl8KiapPtW2Vn?=
 =?iso-8859-1?Q?QPxluAKoRpt2CmFOf9+Ylt2k4OHcsZ7L7re3SgIMyo5FTa2AdbDLtwD/sU?=
 =?iso-8859-1?Q?GV7cEindQOrD75QnNYHhDBOaCjfWoW/glJHeryd9lVfcaA6sslAIx/PIiL?=
 =?iso-8859-1?Q?vwlIO2kxurQPcPlZFpo9sL/ExZ385xOnF75WJlWe1uhs+c3Hp3Z5M9bHqd?=
 =?iso-8859-1?Q?KadbZN8j5E9YOQHPAw1ni7xiPwas/SzVSi/gNSU/kOuTCv5OU5mnuhxmyL?=
 =?iso-8859-1?Q?vOmEg7eUJ/d/geB3lEApZoyfnl5tN4Eak35ODf9+Hy9UIQL3Gu1816dvBv?=
 =?iso-8859-1?Q?WPZgfaanQznbSQH5maKLrRi21fUyiGA8tntsg7A+R9biZvtOPy5nmmPuUq?=
 =?iso-8859-1?Q?7OYph9qOpIHsps5V2GiPbic1zXGoH3vji4FFl6rvo0b3ePc1mtYyZ+KzKA?=
 =?iso-8859-1?Q?W+DVysXf8bVDzR3cyGp/Z3ARELXUof7pLoW4tZvMQOIVY+IF3UXSE3S5bx?=
 =?iso-8859-1?Q?rraS3qWEJtLGUeUxpBuj04H87s06Y+56HokFkqDJLVDMQMJM/cZWmv+uYv?=
 =?iso-8859-1?Q?gKHPG9CrXgHvEUPxfnnGKDvFOvbYJ6PX2klvNlgMpQhuXqv2tN+ceoJP2W?=
 =?iso-8859-1?Q?R/kkyd9XNXoB5/BtTsSfFuqWHFfRhe6/IonZ4KEE9KQAWOxJKlQAKeWsvX?=
 =?iso-8859-1?Q?9D2/8CvDZB/8FrTL04ZG//4UrKwKoBCJ1VUtjFbQ2JwRru7lcK6q9Imxn6?=
 =?iso-8859-1?Q?I6rbK0goFbwzIqHyJDnxiarBayTZUvOvFqKPZ0QAFCOQM9HnXM1Oi1orNE?=
 =?iso-8859-1?Q?Fp0wseYknbL/mPFY12SQrHAkS/RadF3DD3oSC0Ug?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV0P278MB0589.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 71912f30-62a0-4532-e6b6-08dbdd2c5df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2023 11:51:22.7371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HMPKed3OdMhEmKGPuTTHZyc3AbRzk3baiZ2YxMDDpGIisXMGXUjyHENB6hETGzqA7mkSeh2fH4KXj7IBN/QjwIZlIw12pnvgd8n+VeHR64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0899
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,=0A=0A> From: Johan Hovold <johan@kernel.org>=0A>=20=0A> On Fri, N=
ov 03, 2023 at 11:22:36AM +0100, Francesco Dolcini wrote:=0A> > From: Stefa=
n Eichenberger <stefan.eichenberger@toradex.com>=0A> >=0A> > Currently we h=
ave the following two call chains:=0A> > dwc3_probe -> dwc3_core_init -> dw=
c3_phy_init -> usb_phy_init=0A> > dwc3_probe -> dwc3_core_init -> dwc3_phy_=
power_on -> usb_phy_set_suspend=0A> >=0A> > If we look at phy-generic we se=
e the following calls:=0A> > usb_gen_phy_init -> regulator_enable=0A> > usb=
_gen_phy_init -> clk_prepare_enable=0A> >=0A> > If we call usb_phy_set_susp=
end we call the following in phy-generic:=0A> > nop_set_suspend -> clk_prep=
are_enable=0A> > and we sent a patch to also call:=0A> > nop_set_suspend ->=
 regulator_enable=0A> >=0A> > Because clk_prepare_enable and regulator_enab=
le do reference counting we=0A> > increased the reference counter of the cl=
ock and regulator to two. If we=0A> > want to put the system into suspend w=
e only decrease the reference=0A> > counters by one and therefore the clock=
 and regulator stay on.=0A>=20=0A> No, this does not seem to be a correct d=
escription of the current=0A> implementation.=0A>=20=0A> The driver always =
calls both usb_phy_set_suspend() and=0A> usb_phy_init()/usb_phy_shutdown() =
so those usage counters would still be=0A> balanced (e.g. see dwc3_core_ini=
t() and dwc3_core_exit()).=0A>=20=0A=0AYou are right I missunderstood that =
part.=0A=0A> When reviewing the driver I did find a bug in the xhci-plat dr=
iver which=0A> is likely the cause for the imbalance you're seeing. I just =
sent a fix=0A> here in case you want to give it a try:=0A>=20=0A>         h=
ttps://lore.kernel.org/lkml/20231103164323.14294-1-johan+linaro@kernel.org/=
=0A=0AI tested it and it solves the issue we have. Thanks a lot for the fix=
!=0ABefore the use count for our regulator always went up to 2 and now it i=
s=0A1 as expected.=0Aroot@verdin-imx8mp-14773241:~# cat /sys/kernel/debug/r=
egulator/CTRL_SLEEP_MOCI#/use_count=0A1=0A=0AAlso when going to suspend the=
 regulator is turned off now. With the=0Asuspend patch applied from us the =
use count will be one more but=0Aeverything still works as expected.=0A=0A>=
=20=0A> But, also, why are you using legacy PHYs? Which platform is this fo=
r?=0A=0AWe have an external hub that we want to turn off when the system go=
es=0Ainto suspend. For the i.MX8MM we use the phy-generic driver to achieve=
=0Athis. When I saw that the dwc3 driver would support the phy-generic via=
=0Ausb-phy, I thought we could use the same approach for the i.MX8MP and,=
=0Ain the future, the AM62. Maybe I misunderstood, would the right solution=
=0Abe to add a suspend function to the fsl,imx8mp-usb-phy driver and use=0A=
vbus instead? But what would we do for the AM62, as it doesn't have a=0Aphy=
 driver if I'm not mistaken.=0A=0ARegards,=0AStefan=0A

