Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68476D0B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjHBO5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjHBO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:57:38 -0400
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024EE134
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1690988208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXYtGyeDyghHLi1405pB5TkTgoWtkAh/lozF79fdnVU=;
        b=iLmKC0Yn7UP0o1va3FBi+74PBfJwuad8hObo2VGjst6kl3wKaX5cihAdth5VVlHpfE+W/U
        ffb9ZM9lqoxc2OX9u0zSY9TMV+2ZxhL7Qe0MIdqM0jkaBDKeV+oIXzh8Lgq/XL0GjsUXGb
        cP2+GBgpO9CFiXhYTDzaXAXbuVXemfA=
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-FrEmypWNP5yVjTm8YGTyvA-1; Wed, 02 Aug 2023 10:56:47 -0400
X-MC-Unique: FrEmypWNP5yVjTm8YGTyvA-1
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by DM3PR84MB3468.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:56:43 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cd0:b5a5:f173:60f7]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cd0:b5a5:f173:60f7%6]) with mapi id 15.20.6609.032; Wed, 2 Aug 2023
 14:56:43 +0000
From:   "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "hayeswang@realtek.com" <hayeswang@realtek.com>,
        "jflf_kernel@gmx.com" <jflf_kernel@gmx.com>,
        "bjorn@mork.no" <bjorn@mork.no>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Eniac" <eniac-xw.zhang@hp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is
 enabled
Thread-Topic: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is
 enabled
Thread-Index: AQHZumfGWALIKL1Qf0uRlSRmGE3IR6/BawiAgBXCwgU=
Date:   Wed, 2 Aug 2023 14:56:43 +0000
Message-ID: <SJ0PR84MB2088F20891376312BA8D550A8F0BA@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <2c12d7a0-3edb-48b3-abf7-135e1a8838ca@rowland.harvard.edu>
 <20230719173756.380829-1-alexandru.gagniuc@hp.com>
 <3c4fd3d8-2b0b-492e-aacc-afafcea98417@rowland.harvard.edu>
In-Reply-To: <3c4fd3d8-2b0b-492e-aacc-afafcea98417@rowland.harvard.edu>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|DM3PR84MB3468:EE_
x-ms-office365-filtering-correlation-id: 467dabf2-1995-4d99-c33f-08db9368afac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: sE4Qy+wvZmfFfAl4+TAiBGIYfqoJkRaXcOEKjOv+n5n4/9c6SynMSIqEL/ZI7jqvIvUA2APAJloXj9ySLUZUgQiniZkR3EF8USrkT+wQgHE88WM1AWSQ3py8K20zS7pMr3+WL2Hr61I7Sln/3M/m872nmESIbVgzqQkQQT+2q1POkZk8Jpc44DRSE7pZO5DbAwbzsZEoCZzqDd3yY8YGeQt5RBOHWPdG3q9xGGyMTmyFzNOomjyAePmiGmZIrteW9kf9i011RzshK+H0i/dV4dHFXbBVX/aJNZapz8+mpKjDCeLAtoQ47GGj5I3z/SAoB9pH9TvjcwGBas1FRykhewmf90WFiyq9/gcNOqfblxltRezDfZbJq+k3Ym/V/ImxK2zHV4yY5YAKPMX1w15WDErNeuxLBALwAQGCeZYe1nuiHwUY6XC41BCXU3awjBmjfggiiNBdTjv3e4kn2cVgW+13M9nSE3ibhgqRfSJ1W8JAutR9D+rEo7kT3v6Jcsj+/+KTvzLW6Yy0F2xdDHtpk9/31GaUyWKCe7T/swY7WwXOaYGmBHfjqhVVzJx+pKIQ30UUd0LI/psMurY2ZfW1UvUN0zILge0aZ1R/J5Bgvy43JFoCX5m3YrHZ+Qs03YV7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(7416002)(5660300002)(41300700001)(15650500001)(83380400001)(122000001)(82960400001)(38100700002)(316002)(186003)(8676002)(8936002)(6506007)(26005)(38070700005)(4326008)(6916009)(86362001)(66946007)(66476007)(66446008)(64756008)(66556008)(52536014)(76116006)(2906002)(9686003)(91956017)(7696005)(71200400001)(33656002)(478600001)(54906003)(55016003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JQWqMX+VfP/zqeBz9FOeDVXpMjCKzejeD3P2w6LeYEobnwTzDY45S+m6fc?=
 =?iso-8859-1?Q?Cmu+42s/9jwDegw2+/UdHIwgMA7SftXTuQv2YezEgKQm/aa0OYXwb6Hs+A?=
 =?iso-8859-1?Q?nkY3G8R0KdTLx+5VArApd/9+FWN0aDEUCYF2/P+33/epExb5CoBbNUbuFI?=
 =?iso-8859-1?Q?p9nvyDGHMCj40F6CwBQyd5OgZghiQ+r4eBmI0Mh8rGDsy4OJ+pHngcBBsH?=
 =?iso-8859-1?Q?81+YkV6dGtaXRWeYFcVyjkLnoU9rDtPz1oBNH79/0KCr9lfdRa6val0wOz?=
 =?iso-8859-1?Q?24/i1z8JNcHT0XRn1WK/OlHccuvEZx+x8V45J3O3xU6VWxAZS3qTIuPrRY?=
 =?iso-8859-1?Q?7xEShDpJ+W0uUtJZwoFKHxA2cliQO49zC3rpeDvVCpmNTV7oYWfdpvpo8x?=
 =?iso-8859-1?Q?Io2DSFNg1K2ZEr9QRkLlElRIz31ZGI8SWyHDUHh/xBUit3Pkh53BkVJShX?=
 =?iso-8859-1?Q?O+qY08sFRAmT2yN6WqXYQV4JuyOBKaAxDWDnIVbFlu4Nzxjn1CK6AbM3lS?=
 =?iso-8859-1?Q?TNd7EK5Ca7SCVTO6w4Af2T+Oprs1LiPYEXtmY69Dwj4Y5DKLNQD1DQZM0i?=
 =?iso-8859-1?Q?CVaaw46hqFOu11fknU6Bkew0XKpSbpCnGxrptG4lONGFClMR/lNQhTleGS?=
 =?iso-8859-1?Q?eBogx76w+/rItm/K9OKhw6HprGgGwGOkgdVs2ycFtRlVzCjLIBqFJQQwKs?=
 =?iso-8859-1?Q?inTBSA0z2s+dBu/G7CXKuO8xM874uesTlKf0mdcw/JckRhLSE3DMYrZxLR?=
 =?iso-8859-1?Q?4H06kRSrix3oxZ9I4NaGdIB6TfgjUBXY1xxqub7NJw0CnIw6ekt0saRjtQ?=
 =?iso-8859-1?Q?/5ONRgj6N1XE1LCRuPeG/KA3nNdVNsj4iFXjoxk0B2DcWQTMzyxW4Qf/Pj?=
 =?iso-8859-1?Q?24oqWlcFgHUlbM9j84WQn0HvuckfANWRNW7FwLRNLeARVES4UvlEcHcqL7?=
 =?iso-8859-1?Q?05j/MNjDOlgED06skaXqgHjOLjFe/WCuKgFi1ceU+qG3vuqoryM9wzCXTe?=
 =?iso-8859-1?Q?I0I6EcsBHFVZLBecH9xZvlFYet5a2rQC86MzzI+b6H9C8SjJ9ubKBzZECP?=
 =?iso-8859-1?Q?AUfFxT7EqfVQzy6KaNuUuLpuxPHh9Um8nc70plz2VYwDP3XquRoLgO8EH1?=
 =?iso-8859-1?Q?YGynDj3vY55E4VibYmIgUcmSeADU6yrjTgox7xjPWGfDwHnhRWRCME/YMd?=
 =?iso-8859-1?Q?koJ450fKIf0cj+XFh8Ea6VNGu0SRvg94cz74KLqsjPERjMQtChgsF4vzpj?=
 =?iso-8859-1?Q?PxnNHh1oQV4pT7Os5ssRDJ/N30DlM9hDjT7yv+4ReZXs54ih6XcSaq1Tyw?=
 =?iso-8859-1?Q?CWYnXob1kljAcd5VEbhXlcVzAyb5IMKVEiMKGSOEZxXuEfa/gGe9IuBvDN?=
 =?iso-8859-1?Q?412vjghjUtukHTUF/CpIi7PJp5xLz8K/4oHVI3L/KGHASpPmR3v2B6jVMF?=
 =?iso-8859-1?Q?Zl4HL7q4Mqv9nmcws/j4Tul24GDn3Bq/sVD+j/hnYRT9iPb4MFi7hX/ihL?=
 =?iso-8859-1?Q?yScFt7iX+aMzZDfuDUOr8QnsuPHGFGkwSga32ECF8J+3oo5K4jGcEjbtJf?=
 =?iso-8859-1?Q?kwAejJ2nLS8vEyn0csmX124f4efFEgRgrZNvxMEvMFINdLY03j/4ym8P9k?=
 =?iso-8859-1?Q?k3+OMiKEiMF3oQzXiyAaeUvfylhhKMwg+S?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 467dabf2-1995-4d99-c33f-08db9368afac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 14:56:43.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4v2qF4lTAx+16/qTPifYz4ZjfvO5rclUf3ZaM7PjGgpnAsOId6HHrCK20olFdS5W6EhDMlWdY20l/Bi7kRNra7/B972SGecnYCrumhcPVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR84MB3468
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 02:36:25PM -0400, Alan Stern wrote:=0A> On Wed, Jul=
 19, 2023 at 05:37:56PM +0000, Alexandru Gagniuc wrote:=0A> > For Wake-on-L=
AN to work from S5 (shutdown), the USB link must be put=0A> > in U3 state. =
If it is not, and the host "disappears", the chip will=0A> > no longer resp=
ond to WoL triggers.=0A> >=20=0A> > To resolve this, add a notifier block a=
nd register it as a reboot=0A> > notifier. When WoL is enabled, work throug=
h the usb_device struct to=0A> > get to the suspend function. Calling this =
function puts the link in=0A> > the correct state for WoL to function.=0A>=
=20=0A> How do you know that the link will _remain_ in the correct state?=
=0A=0AThe objective is to get to xhci_set_link_state() with the USB_SS_PORT=
_LS_U3=0Aargument. This is achieved through usb_port_suspend() in drivers/u=
sb/host/hub.c,=0Aand the function is implemented in drivers/usb/host/xhci-h=
ub.c.=0A=0AThis is the only path in the kernel that I am aware of for setti=
ng the U3 link=0Astate. Given that it is part of the USB subsystem, I am fa=
irly confident it will=0Ashow consistent behavior across platforms.=0A=20=
=0A> That is, how do you know that the shutdown processing for the USB host=
=20=0A> controller won't disable the link entirely, thereby preventing WoL =
from=20=0A> working?=0A=0AWe are talking to the USB hub in order to set the=
 link state. I don't see how=0Aspecifics of the host controller would influ=
ence behavior. I do expect a=0Acontroller which advertises S4/S5 in /proc/a=
cpi/wakeup to not do anything that=0Awould sabotage this capability. Disabl=
ing the link entirely would probalby=0Aviolate that promise.=0A=0AThink of =
USB-C docks with a power button showing up as a HID class. The scenario=0Ah=
erein would disable the power button. I would take that to be a bug in the =
host=0Acontroller driver if the S4/S5 capability is advertised.=0A=0AAlex=
=0A=0AP.S. I sincerely apologize for the delay in my reply. The corporate e=
mail servers here=0Ahave "difficulties" with plaintext and  interleaved rep=
lies.=0A

