Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107B7A7580
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjITIMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:12:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4F39E;
        Wed, 20 Sep 2023 01:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcJz0jANSzFSrf2QJDp4kgjWSKbPWTcn0NVV4g5fEdVwvnDPBAct77/KDX7Di8QM5wLh4iOkoa3Pkabmukx99XqD8A8XNX9rb6RVpjtsxuZx6t9mxU+9LpwjZHjU9esGxDAgmmcCpskY4MVP/cw2pUT5O4W7UfG8Vpz5lP/1te6VFO8ZAW+KPj3abmiT1mJNeGWuojQH9RFmxfM33Y0Q6dFk2TFQ+0EY5D54VsMbZ0cWyennF8EMMlQxUQcVB/If6dyZ6cSy0YofycYvAh1mTUOUPVWloApU4GAGWC74OvqN/Xiu89ZvtDcwmZp9M1dIqjDK5ZDtVlTCM/s592GMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkPnjaBBAxXaEklcO/ETek/zT5+h6gxKwuAsUJ5YLb8=;
 b=ee/oi1DbcGM7BNuvImp1gPIAfFRBtcImGAgnR0N40dG4NMS0lJ/AS8miqtIvT7MlQy1q5dEo9mZEz9Izj2vDV54/U6/OJQaUxrPH42ATJ1+WTLMtjr+uJBgvdAyixP5Dvx3UHw+z4DGq1PvkCDK0R/G6mCCnyBOZ9DkFYu0imkf7srjDRQBHc6ZMqbqxdP2+THc6X3epI+OMln3SPdV9WduzT2cVOLW1cXpsgexYpzyfxMKXaGDynOAygu140CXzb7WJ8k6PSVLlEnaQ31gbOT0xbp9Z7XP3zfnG7nlBCw+DzZOap7dy11cshSiw5yC6n4vpl5sXqTDsd06RNaPhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkPnjaBBAxXaEklcO/ETek/zT5+h6gxKwuAsUJ5YLb8=;
 b=E8iCEj/nlnxPbOK5KA0XVs0NxPWRcj5wjOxEeyoEh6Wh44xvRAHpXn54LByV+CbpUFhoH8IF/PHfd+tG3hsnlMOInv/XAAcbKb4jxXFOws36QIaLtNJPWozV0f3rnRYUJQElEppSKhQi2np0/+WClOkIRB3Ud7DwOYPNlBa69Ng=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5999.jpnprd01.prod.outlook.com (2603:1096:400:4a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 08:12:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 08:12:10 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Trent Piepho <tpiepho@gmail.com>
Subject: [Query]: Resource cleanup for Alarmtimer
Thread-Topic: [Query]: Resource cleanup for Alarmtimer
Thread-Index: AdnrmFAjUih7l1QlSdSObu7MvB/BAQ==
Date:   Wed, 20 Sep 2023 08:12:10 +0000
Message-ID: <OS0PR01MB5922DD412F43E1C836E32AF486F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5999:EE_
x-ms-office365-filtering-correlation-id: c1465bd9-5f54-4226-7126-08dbb9b149e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdBmv+eSZI26auFVwNL6yCLBjfUpFZfMBdAI7ZYafZjjW9fLSvHzZtnf5/JFuQ5qWZgeJkET40Wb+l4OJ2aNJrDcIxZUVg6fvZXUKLypJJYmbdWNEs4zIGvparfJWSdYF8Cqgj5QUvce1J8FWntMx6bDxzIQnvZmtt9NHz9Y9tfxqngvQyxTmnLQA3UZt2tPL3VvlAybA7Z4igapB2bPeRzs6axR5d9PAc3hMSnD+DI14mPgpRNYkZbhxLSZ7+tFDWt50025FEo3MSAxDCmMsQ0OTNWszB3qz6vpq4wjyiCemlRk21Z/26YBAEadWz7oACFefF0wHZeG9HjZrmENLlDxVG+IWIX4uMMi+ONacbNv21h+5ND7ERi9D1YOWdNdoAEYjVyWTar8L3SISnUFkIdu8wbjsvNdENAKPmcEXPcigXHmQFGBfkzBTA+c2G9vlpp/gVSeBWJPa8safl3IUFl4Dz2mWXSJFh0o8NsQjBQB6rrdFrKrc2WVn+4qo/5InBDCur1Y4nAULTSb9xbq3Fd4NxyhH44Ny9rMmAiJUJPAvnQgjVx7HffEdVBwKpyXSbQtYPoqa/cmKTS3Ql4d+x72U+4cdERWE1tc/Cqnp6oghLGEOohSCOYsFlN2kF/x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199024)(186009)(1800799009)(2906002)(5660300002)(52536014)(26005)(55016003)(66446008)(64756008)(54906003)(7416002)(41300700001)(316002)(66476007)(66556008)(66946007)(110136005)(4744005)(76116006)(8936002)(8676002)(4326008)(478600001)(71200400001)(6506007)(7696005)(9686003)(122000001)(38070700005)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0qAuBHCGHAvbWguVYRFQVGk+glbOQU7ht41FxLOTsyEbut7BxbWnhCPKUKXT?=
 =?us-ascii?Q?ub8tp0U77ErzZuWMJhpwde/D2gb2P6ubfbbC2jeQqAmM748NzgXSDyJEu22r?=
 =?us-ascii?Q?sbZ3cZTJrLCe4ew1Vh086dovHX1SE9PNjEUUG2PIKOVanyHA586zisYZUBxC?=
 =?us-ascii?Q?6n2XpKZqB2F/6/Tn5sIuM93pEGLqRSAgQFlooUDoFe69rZVRGBvg3C+Jbho+?=
 =?us-ascii?Q?HwQcCY1tNKL9Vhf3FfoOPyC9U9kAH0eO0STjDqe8beD50+5Rwi3jclOAKb3N?=
 =?us-ascii?Q?jhInv2An+KhPJcRZf5CuSVBpSg1utw7sb0YzqizId7R8A/H9DtlMW9aBa7gI?=
 =?us-ascii?Q?k0rZo0BBAkAuC8FdxAUuhWszP2bpY+TrZ3E+xWlaFa73Sk+tmMD/f8UAVNhc?=
 =?us-ascii?Q?Jmoc3cMmAJmHbca9P9nJP1pGgkEWqkq9JuXQ+1l0o2xoF6OvdgeQ8AcB4Dti?=
 =?us-ascii?Q?JP9hScq32ZGZZXuPMTsVVYzP2lw9VmAeyXuM7c6Ctl/Rbdh3NXpl/yGYDUVa?=
 =?us-ascii?Q?FDK4I89qH+CYUZsBg1HmnYL8dTcQL/4ez5c7METnCy04pl4jCVhPZfIC08E5?=
 =?us-ascii?Q?mM7YSD10z84l5C1MPu3TTEukDkb810ewYQ0D6BlgaVMOlpiWqenHn0eckqhR?=
 =?us-ascii?Q?I1GwAQLy+yM/rq+oBkWT3nw+pigtRuc/Nq9GIF+ML8vMkRhV6XjYhvYcBALc?=
 =?us-ascii?Q?uG0OIcPlXXSwMs54TgzELWqlYHQr9ZPOljz2Kjv22wCp739nlvd7oAyGIicA?=
 =?us-ascii?Q?lE1MMKjV12JI9u2zgC8WbIQ6PA50p3TXmwr5uT6rF0wtHq8R4WdDAiC/z+oM?=
 =?us-ascii?Q?IvI/76mOhG+Ap4od+fC5BNYjnU+eyVb9u9JGtfsT3ZDby5tXF0AI9FSG40uB?=
 =?us-ascii?Q?QdRWUsnWlTtDWjC8KEOmp+rI6pnmCFLjurw0bH9MiSy/VVYCHGU0zFH/mf+H?=
 =?us-ascii?Q?67cSQhTBqSS2Thwy8BCdqdfu9qgNr0YoTXe1I05fanemLeoyoBtvNO2cHBN9?=
 =?us-ascii?Q?SFGodol2ClwcP5nGAtP0g8u+CQKFyCDQ5sFuV5JR0188jAarDwa0OgJF2SV/?=
 =?us-ascii?Q?5mp5XtNvq9fKiXaa/e4Bh0OfBaY5bgSSE4mhK3AYidLrQkFJS3PJfDk9Udid?=
 =?us-ascii?Q?b0+j7mN2mngz6kxSJYxCFfdib99JDTu9Dy7NVuihPvApQIxKWctny193Rpug?=
 =?us-ascii?Q?mJ7W3yFEE4W4k6rD1YluiIjJSJ134P9SjtRB/ibtoa2NqJnIBE6Df1/j9lYr?=
 =?us-ascii?Q?WnL/+1/oJ9hEy/wm7A45mkHUOH626Urw94jN/WOjqKbb6iSj0qLTJlOMMms5?=
 =?us-ascii?Q?G3ezKJonRlMiRmOqbNpr8vdpKIk11Skgs3hV1VP84fgTe5sC3WjlIVAeXMtU?=
 =?us-ascii?Q?JYfjZTD1gtcMDT4HCyxZOod6f6scjA5gzS9V+6JLKU3RllzNJo1r0hut+P9i?=
 =?us-ascii?Q?5NmN1w/I07VdLeVJLv3nlVskekGZNE1+AV5PBVyXC/GeMwNmflTujmUsa/Ut?=
 =?us-ascii?Q?+Ey8crNoLDzDLbKipv4FWHqMffpEiLz4AxgFteLq9qBHn7RB1aahjTFiSP/4?=
 =?us-ascii?Q?f/HB2f/wSSwF3rnxSlcetdIvwBpU9PIO0n6drntyWWFnmfSZGNqqhr11XGa8?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1465bd9-5f54-4226-7126-08dbb9b149e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 08:12:10.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6TYDM0RhEUOXa2Fpf3J+GNg+WSCgXECUlWesBW57h7JtJZ7OKtp6zpH9jj4zqnsS4SLxBsVsyqRFxM90KtVgRzB7tdb1GEsGi2GaszHjrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5999
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Currently unbind/bind is not working as expected on rtc-isl1208 driver. The=
 reason is put_device() is not calling rtc_device_release()
as some of the kobjects are not freed during unbind.

The commit 	c79108bd19a8 "alarmtimer: Make alarmtimer platform device child=
 of RTC device" adds kobjects for alarmtimer device/sysfs, when we call dev=
ice_init_wakeup() followed by devm_rtc_register_device()from the end point =
driver during probe().
But these kobjects are never freed when we do unbind on the endpoint driver=
.

The alarm timer device has alarmtimer_rtc_add_device() but it does not have=
 remove_device() callbacks to free kbjects.

Q1) Has anyone tested unbind/rebind on RTC subsystem with device_init_wakeu=
p() followed by devm_rtc_register_device() in
the probe?

Cheers,
Biju


