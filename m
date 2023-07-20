Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14075A50A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGTESS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTESP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:18:15 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47641210B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 21:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eybqSQebkHcgctjzz8fHMW1Y51RRUoCdxxcEL7TIzpkIISGic9uyASZ4KInR7yKtoPfk/vGpBtFT3NgxOow0EnxhBooGUpf8uFvLdr+2XGS+4x//G1ARb0urv4CDWKp5eeXjoHV+8b4PNgwj8YFODR0YmvxjwZSLbwC/SC7fRye6wZqCKuBzbKdhFkUmoX5D/gTNjDvUI93h3L+580CGIAnq10LuUQoXoIvwTzJKkIMOP2RkYuZra2yXJUWelYLXhYJU3Y6lMXuFw9dBAXiGkLp7Pb+SNJeIgcjphTGGtQlRfJ+B/rFD5udzDJ5Zl8UZjWGzAxlGr+gzdmQpTemVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/IGExVxGWATZkullZmogyJ3o1JZeaFreVCmTfXBmY0=;
 b=CdHkDXL9VZ/i1i6QIQx9YSMa1x9us7CR4saWHodxnZYw/m3ieb/yzibzrgWm2oHRTiz1vrm4HsksSIT5kQOHkyBhzezsvNTwMgFqaZMt1LlVihiab8iuAODoD9pFrXIU5gJHco1XN2BFxCyH5hOE9GxNoryQ2ukpBgsL5FusthpBrOF0m5ry5Q2kyc6O5pFxat0hyFIW3Ryie6PWPsaEsHzLibvq9/lq0VH8Ls5N6zdO74XNIpTXQOXwONwFt9otrOJAP7x7cVBo9eqhBjJsIrBTr7Oa/U/qYyRmzLGRILv2USudQ8C+MB5TWTm1ZNd6KR3iHU0nACIgpt0Xg3ludA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/IGExVxGWATZkullZmogyJ3o1JZeaFreVCmTfXBmY0=;
 b=PoM/zBfXd0ehp+Zo0iHd++GR2JCa/1a6NHAwkXKJkC/CabtJst8fJvtnG6ZQoTCgGDQxDuwq2x38SsxIl2hnBqrD4k6iAaknd8NKthyPRHmwCePfEaMVQN+6Uez+RprPYf3kljec+ixfGI3lQfYGyr/gLaFz2k9qHIlZcIyXVPY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB3024.namprd21.prod.outlook.com (2603:10b6:510:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.7; Thu, 20 Jul
 2023 04:18:11 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136%4]) with mapi id 15.20.6631.011; Thu, 20 Jul 2023
 04:18:11 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: RE: [patch 19/58] x86/apic: Get rid of apic_phys
Thread-Topic: [patch 19/58] x86/apic: Get rid of apic_phys
Thread-Index: AQHZuQS0jOAaAu5OoE2Fx4d6ljj3Ga+/gMIAgAKNfOA=
Date:   Thu, 20 Jul 2023 04:18:11 +0000
Message-ID: <BYAPR21MB1688E1BDE9B6D1225E590FF1D73EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223224.207131427@linutronix.de> <87edl5xt2n.ffs@tglx>
In-Reply-To: <87edl5xt2n.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7dd3fb5c-d833-42b2-9ad8-1e22623ceead;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-20T04:10:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB3024:EE_
x-ms-office365-filtering-correlation-id: 64bb0956-3340-4b15-a97a-08db88d85484
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RMDVHYuO0cR2pYKS0Fl30pjaN5+4EzYSavC+pEF93YJorQ9UmmbktY8dFDCHp75OaAQHWMjF8RxRp9MLF1MmULGgcY+f0EMNLSDuXDlID+wVjIzTEELIG2Y1GmCQsM0D0SKZZKnw9h7uNOOkobmT5PPSCVzSETgok2nEnfof+jIMcLLUrQMx94ItTgHhzsTu8Mv/GyVl8MJMuNYXUEeJtxTGasLEWerO25vqM1TAvr+EkIzSs6IM/mb9QPb+kv6I1VQZFf5h+RNnRijSdw62uohxXwnm2pSz8ILDpieGq0n1KE7MNNYo36EBXnEDQHL84lS4zTnZLzYfWKIXop5m5irD6vNP8xDUSwlahvU3Z0GvEsYmSjp9UkevRNrcnJ2GmxUuE/1Bvp7J7mJZjso+8rYFML3jUerx7xwn8ezS5KdKgDTmDTsqQBGUMIjNx3s5M4slVnW/MYyZ57kFR8GzjSFfWyNgO8RVu6r9tCGPoG5lU+Y86vBCfo/1wWKdqWB2QfFLDi+zYzrIqtWoUH8G0FPYCuXLNGaBLWCUDj5+mzXlA0sQU84l7uW644UdqPrLJkAxbJvOtShLmSqEyfHHfKTk259jrCcDXm0eWX4gFFb2UjeqA2cXh5GBpQLNmVF89VU63OOhiby+xen727fjqzq+KI/nsQBopk3kgmwkidq4KANlShAGrWGkNkzUXmEO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(66446008)(55016003)(478600001)(122000001)(10290500003)(66946007)(64756008)(8676002)(41300700001)(316002)(7696005)(38070700005)(8936002)(76116006)(4326008)(9686003)(71200400001)(66556008)(38100700002)(66476007)(82950400001)(6506007)(26005)(83380400001)(52536014)(186003)(82960400001)(7416002)(4744005)(86362001)(2906002)(5660300002)(8990500004)(33656002)(54906003)(110136005)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cw0JBtiF6skmC2/FNMkfPnOh6eR8c0yfhgvb0IfBhq3e7sMgwM0aUxxIXKVB?=
 =?us-ascii?Q?LkPrsT02Yv51vkZroC1sc1ZHlz3AL/BBZDbeKp4196507rZAz2z9od64vAyv?=
 =?us-ascii?Q?VIzzKuo7BGFb5ET7CZl5UN0Ln5BhVw516TKCW19+DkaO12R4pwjpHk1ifBGw?=
 =?us-ascii?Q?yHJ4foX3UDhJCOaCKDzMGvcY+tnJ6sjyH6XXbMDoeZtW9d2PpDjE5goA6uJo?=
 =?us-ascii?Q?3OvEAk8LjSP9qI1rpg09bvtVerIjd0fT0tjVQQUMr/MPEX0OGPc9KqFwbtzi?=
 =?us-ascii?Q?ry6VVc+WhtEByt7jJtcsGGHIkmMher3k3jQMPK0MuEfo7n///xgfwbj2st8b?=
 =?us-ascii?Q?1cHYZiUCGclHSUXUSYo3PaJNMEZN8w/Jfuxb/F/6er8LdlI+ToSAM6/iUtKq?=
 =?us-ascii?Q?jeMyx9BZ/k2LZETtNVlJ986gnZGVsyPk+3rXlKGVVY4Ne8WJaF0QQaoD+c4M?=
 =?us-ascii?Q?Hd8g5dNAw8Dd+uBX81PBi5+Z9QXGvDZ9KGL+YzA5ihO7Pd2YOj9qa3zaJyVn?=
 =?us-ascii?Q?9fY+DBiJW1VHekTUJ2Ca/xz97tauyFlnRNpRS5CZQWoTgdi/HC/vKhqAQOut?=
 =?us-ascii?Q?MddOaXbsaY4EiwkXTtY0qCU7eEb3Oxu8ZdQxbW/BCeM6K6cm6lmMdtWz9vU0?=
 =?us-ascii?Q?+eof7hwEFUBxCc4bse08Vjvr3cqU9B/hbE80GV+UGw7z54SiUlamDKXTr9Kj?=
 =?us-ascii?Q?xWROMhql1MbzkVl0Ct0MjKceIYYiV0loQR54gTsHocJeHTiGRy+sOiBr/QNw?=
 =?us-ascii?Q?4DQ98C8A4DmvyrbUrBhYYGMFf4rtFrJ1XYK3KHhLOJZMapSYYj4Dw75ikpYV?=
 =?us-ascii?Q?DWm2quHFv1Cy9d7dKwdObsQCaPrg9AHxIW6eGw2gGtmLnaSFxAY6ws87N4D1?=
 =?us-ascii?Q?W53AAQL9PeiMqrhl1kkFIQUtnjSMCDuCr7qH5/+Pqa3XeH9QUDn1h41QgRnW?=
 =?us-ascii?Q?uhX2V7zVLf4u5+7Niuq/AqR3R/k11OsDzZ0jo6FiFoDfWEgl0c4rirrfKl9p?=
 =?us-ascii?Q?cXPe/ZH3Ry1xpYGS8jo2Xq8eprgsyjtA0kByWnhYhh77CFlM3e8nVph+BNVs?=
 =?us-ascii?Q?q23fjhIwfylhv/o7TTJ9V6ht6A/iq/VvRdhBOHqayGftUB/gOyirc6xfgHua?=
 =?us-ascii?Q?SL97yfwj3HpQbxspNKeDJi2Oi9YSdYSlTjN2zBYmncFWoxETe44F+YsNotfI?=
 =?us-ascii?Q?KivJ7W6quzdt2NetZ3QXqyLT3BY+gpq1uEelczm3/ZiXDFuJ7YPnTypbTnyK?=
 =?us-ascii?Q?+y/E/Pz0szecaKisEafPKkyy6F1uaElpXxeaFWVj8X31zjn7MCayZ4IlIJuF?=
 =?us-ascii?Q?8Up12Si/xAaQZRR+eKwb5/nO9JSKx10XJTa+VsiQgV+n4mWjkL0AjTIdsHDi?=
 =?us-ascii?Q?h+OqBlRq6enK5ZsoUmhiI4gleqWamXVu/8vwgr1WB5Uk5rufyGdRbuuqJY3K?=
 =?us-ascii?Q?J0AJxOx5AxgrMbHmBH4NXaImiauMHPYFTlOe5mwVyP1w7J2HSi8X+ixWTxyx?=
 =?us-ascii?Q?+G1TkRzu7QHPw3blf1Az/vZc0NHWs/nXhxIuA/Keic5mApmX7l48i/uTxrcp?=
 =?us-ascii?Q?qkFN58QobpnLh86SzQrAVzbbiGhZg8TOrTrhTxCvJcGKC9Z3dYmp51wwz3V2?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bb0956-3340-4b15-a97a-08db88d85484
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 04:18:11.4925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sD9sClBJxXngtOy9mpRkQ/AkdFL31EAegHETCDe94jX/QEOYDkPZ0QOpc7Bh+NBfcgDt7Py5/yMsp4FplYXdjQ+PDeGdTF5CS5duDhYp47U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB3024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Tuesday, July 18, 2023 6:1=
2 AM
>=20
> On Tue, Jul 18 2023 at 01:15, Thomas Gleixner wrote:
> > @@ -1921,7 +1922,6 @@ static __init void try_to_enable_x2apic(
> >  		 * be addressed must not be brought online.
> >  		 */
> >  		x2apic_set_max_apicid(apic_limit);
> > -		x2apic_phys =3D 1;
> >  	}
> >  	x2apic_enable();
> >  }
>=20
> This hunk is obviously bogus. I just noticed on a VM which takes this
> code path...

I'm testing guests on Hyper-V.  The case where the x2apic is enabled
in the BIOS works, but when the x2apic must be enabled by Linux,
the VMbus drivers never get initialized and things go downhill from
there. Your comment above is somewhat cryptic (as I haven't studied
the patches in detail), but I'm guessing it explains the failure I'm seeing=
.

Let me know if I should debug the failure I'm seeing.  Otherwise
I'll wait for a new version and try again.

Michael
