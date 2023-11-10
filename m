Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E857E7FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjKJR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjKJRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4BE24485;
        Fri, 10 Nov 2023 01:28:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9Ln8lIztQECjVOPuaN6oZTSIUukP2QVG8CWermSO6gHWklVYDCSQ7KexrGg9UBGELd227cBKMY6sAnL8q3+tRW5XyMEhV4xrmIY3GmaRgeOJj7H2ZTrVW5KVpY3Jm8ukdNzRQQJZ1eQfiRzR4UN6kTDextLEtzebXADmPHDVS0VRWXPl7jxhQeu5fTglfI+iH64yszdJxm00/8wcVC+btIAHATTRsRz65eSMpePho/vYfY/VJi2yqPhFkrZWTiTR0dnAlhSly7kYqUgKWb5NkSEcF28ZbOq4ifAnFTryHuIBDZh3A03kmfEay+cizaTUDFzsi6gFjcvBMDgoOvVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0qRfr1msQijQTrSWrcS9QbGkrNRBJOY5Lm/8T3AjlE=;
 b=ANmyTpxvnyTHtZP0vhXOK2gdYsOx1pGH1vuF/yon7pU58ZrELHiYbIBXGY0kwJj23v7HIea2kaJ6UJseiUzsFQrOpTK9jmgXWN/7DEJDcQ0S9mIfWZVWw++AWqzvYLxfY3y26sPeA3ISeYJUkZET20WqiQx+hX2sZGl3LGGEeWfipcBTHMxcTwF4WTE7qPA5ACW9yNMK9Esv9doMGFg9tKKrifN9sNOx+BuatBYI8rOTa5SHj4pdrvcJxXQPJU0P7LE97JwiB26ab6/n+PLzibKHU89fzGyJ/LECbpz1C1RSybVZG9cB9JZUPzafwBtf2N8crUSh5ny5vIWf9F2rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0qRfr1msQijQTrSWrcS9QbGkrNRBJOY5Lm/8T3AjlE=;
 b=h6z4oSgGfG/P6Z4IWJ2MPkbXh3ttCbabNJbBMxABbFs+TEI4NssiL7yzIo+cIxge7PtmROq0DbAVZToKx4O/O1BTZqmhfmjHOvbz/Kq21rByKYMixCIPxNrac2sU8tmOxK4NZ5PZROOru3iph2ty9r3ud8BPzZqkCw1s4A21y+A=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.31; Fri, 10 Nov 2023 09:28:40 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::46d8:a18a:12a:5e1b]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::46d8:a18a:12a:5e1b%3]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 09:28:40 +0000
From:   "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "jacmet@sunsite.dk" <jacmet@sunsite.dk>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH] serial: uartlite: Use dynamic allocation for major number
Thread-Topic: [PATCH] serial: uartlite: Use dynamic allocation for major
 number
Thread-Index: AQHaEwlt1sGLuI9yokCsNfjgH8r8ILBx+OyAgAEfE5A=
Date:   Fri, 10 Nov 2023 09:28:40 +0000
Message-ID: <DM4PR12MB6109220B13FCD2B1D7B48B3C8CAEA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20231109123640.1740310-1-manikanta.guntupalli@amd.com>
 <2023110915-trusting-pointer-40b0@gregkh>
In-Reply-To: <2023110915-trusting-pointer-40b0@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|DS0PR12MB7727:EE_
x-ms-office365-filtering-correlation-id: ded4364b-5da6-4a8b-4c31-08dbe1cf6d0f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qoaowA2KtnfAfU21m6oSYAB4ILNF0D/GqMwvcVUxc6rSASAyzdIRlyKcJUC7s5bUp2/EJHuDBsjbNMKmLScfdERl0djwDZ2WZxOzjwbg+Cyk6981TkEoE1m20sG6iSHwkKY/8Oe/xUHF6iSHfaqhpEURcXlAuHeYwX1bUxlN2PQ5XSNhOr/F4fpz46LRxOEtve/uLJnnac9dKPdztYXaM/PQnhuYvyajBtj79uctrl8Gpjka5ZFvVorlKNEm9LU3p5CB1y0k4pR1QZnanOyeZlautXZO2u9QRSR2JJbqpKnCL0NvE0MEfUUnWJMvpVi4nOaVzrhy3QMg/TKgon4gRRubPLlRxgCAOg1XQo5VTU/9OUHp60fFHM5SKRi7vfiJwY4BeXN+jZkvlsXuDv+/n72YSe+FruFgyCKOlcz5Xc9A0G/4xrAc1hVmaQz1UtNeh3QISXcIfcPb5sZH/Y88uMXNuh/6E/X9hK6YE7IvXda3/q0r0telUGMORrqam2+E2SqIs1/GxDTV/LTjyuXnP+YiuViHB/lhUH3S6MZV0m20OvOxfuMaoHD3Aco+/M+GxE8JCx/ETqL9D/ReV+/QxGiSRLtpgKSwkBlDDBWCg8s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(9686003)(966005)(7696005)(6506007)(71200400001)(53546011)(478600001)(2906002)(83380400001)(41300700001)(26005)(5660300002)(64756008)(6916009)(66946007)(66476007)(316002)(66446008)(66556008)(76116006)(52536014)(8676002)(8936002)(4326008)(38070700009)(33656002)(38100700002)(122000001)(86362001)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EjzqKr8m8BrRmXzn6epY4Qua+IJdgBawcgJYczoSdtcvAc5ctAKdrhcMykfp?=
 =?us-ascii?Q?5kUrnAaBm/zsRul482ojdBUVkmuv3sp5yAB7D+suiNARSHLkxcPRssoCaRbh?=
 =?us-ascii?Q?st2k415XhfvvfLmSaouvD22Bwl3gXnFVg0d+Z/8dDAT8MS7BeSltpDAddB0r?=
 =?us-ascii?Q?R2GhjMOKfnLBRE8gCiXIE8NmiM66ER/LTnHYH5BckR5uR3cUhNHCbTj3WdUA?=
 =?us-ascii?Q?4nZclZa06JXdm2JkwH7FRMG+niZqhb5uFk0zXJcZBPE/+E4TU/ooA8WCsWIV?=
 =?us-ascii?Q?XzkLszsq1lAO6TEaArjKQcwXNRQVax9o+ajLDDet6l5Uj68jdYFiKCcDtD6c?=
 =?us-ascii?Q?gIBmVSw2agclKn2bIuz08EGpoXKuuKsJPAnFZcLKFRMFDtUmdI9VMbaDOdrx?=
 =?us-ascii?Q?AKzoQDmNzcIJz73TtQo8ZnXBCKePqfJOSeeezg0wF2q8l6bxSTpGzuSpTw2y?=
 =?us-ascii?Q?VEEd+qnswaexuf3E/BVjzU0W7uHKBTBrrKM5bhnXArILFWeAIipm7uuH5u3/?=
 =?us-ascii?Q?q+RS4dfNwBrBVLnUepS/VPyvvuEhfXYrUA5utUk7jNKn+V547fz/m5GDgLdR?=
 =?us-ascii?Q?ASX3ooFGyWImMaFbWPsCnxgy1F06thoExy8KyxNlPpkaUxo6OHhsmIFZffm4?=
 =?us-ascii?Q?PCjxIt81WxG5l+G1BYNftc5UDzIYSE2RBv+gT3ZgmHrm7/B0gLIiRbyyaJea?=
 =?us-ascii?Q?/tiBelrm9LxXnroAdMLYCVuSA1ZkwFdhEqhB18dnMgqFHAqXH6arDOlUNs2O?=
 =?us-ascii?Q?xiAuSO3EYKWPzC3eGXjX0yoBUBtpqrLcRk7ODxuN/yUFLaaOGDGPESlkYkH1?=
 =?us-ascii?Q?tmNuCS942MCuBey5R2ND39qd65t5qiTbLtfHSDQL29tS8N0DPY+9q6nXKnYr?=
 =?us-ascii?Q?pq0PgC/BLYcodcw/0ol7hlxObis5v1Y06yVJCqhjHUcqbmqEOxgY00hpn/wp?=
 =?us-ascii?Q?kKbNTjSWJ+dncTrVBYzlpEL0l9k89ZO55x1kzv1w6+jRBLH8eV6pDteFZhW+?=
 =?us-ascii?Q?bDlUYr17lESXuCIbwh5lD8PQN5dq6jbJLwsZJmbUM6QQT1uEMRi1X2hkQH2v?=
 =?us-ascii?Q?UiMzocPjJsJBU8yvGIyhnonA4BvB7fBN1sx3JGrVBYUGFSvOmtqmox+ENcFf?=
 =?us-ascii?Q?S2yu3e2PN9I5zGPb5X4tLcEQK1WujObTlVq7blbWDdezZuNqozc+PcYHP+rn?=
 =?us-ascii?Q?+1f3DJRbXzxbNu5jYh17VA6IyCUgmHKg1ht8pjN2+Aei2p7ULz0S6e00N0go?=
 =?us-ascii?Q?1sAJG1YlavrvlT4JR7g0fRORQxWoh0y2zzhWMRrOKDngofUs2MZQ9QxHWSTF?=
 =?us-ascii?Q?jXAoKF0yibxKvJtJ7D3mZtxcvGsK/MCBUopV9uPqy4CHEultwjc8Ddgp66Cr?=
 =?us-ascii?Q?9KbVt1Si7tzAR9s1dVDLJBzAJrBMy3tNwZ3TVUQXCrifmhAeaF8itHkKCzlu?=
 =?us-ascii?Q?2H2/QzEqdsPkt3KvPsYbHA0Go7k+k6rkzBpsggpIs5tNQuTOFWlKW56drKxf?=
 =?us-ascii?Q?5P9SzALn84oNQWvxp9P4YtPFu7BGgB9wmfOviLjS+0lckFyLa6pl/naaY/Ng?=
 =?us-ascii?Q?3UCavxSJPLGdp8TX1YE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded4364b-5da6-4a8b-4c31-08dbe1cf6d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 09:28:40.7224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYF1ofRKPoLrpki53qhOv7vBTER5Jx9pryO+yP2n1O/Y1PobcuAkkLo7gNShB77tozw9G0hPF1RJesRIcTDDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, November 9, 2023 6:50 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> <michal.simek@amd.com>; jacmet@sunsite.dk; jirislaby@kernel.org; linux-
> serial@vger.kernel.org; linux-kernel@vger.kernel.org; Pandey, Radhey Shya=
m
> <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> <srinivas.goud@amd.com>; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> Subject: Re: [PATCH] serial: uartlite: Use dynamic allocation for major n=
umber
>=20
> On Thu, Nov 09, 2023 at 06:06:40PM +0530, Manikanta Guntupalli wrote:
> > Device number 204 has a range of minors on major number.
> > uart_register_driver is failing due to lack of minor numbers when more
> > number of uart ports used.
>=20
> So you need more than the 4 allocated to you?
Yes, we have a customer who has 32 uartlite instances in his board.
>=20
> > So, use dynamic allocation
> > for major number to avoid minor number limitation on 204 major number.
> >
> > https://docs.kernel.org/arch/arm/sa1100/serial_uart.html
>=20
> What does this break by doing this?
uart_register_driver() is failing due to lack of minor numbers when the cus=
tomer
has 32 uartlite instances in his board.
>=20
> Also, you forgot to update the documentation :(
We will update the documentation.
>=20
> And how was this tested? =20
We tested on both ZCU106 AMD/Xilinx evaluation board with 32 uartlite insta=
nces with customer design.

>What about older systems with static device nodes,
> are you sure none are out there for this old hardware anymore?
Shall we use below approach to support both legacy hardware and hardware wi=
th more number of uartlite instances use case. Please suggest.
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 404c14acafa5..517f1f34143d 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -24,8 +24,13 @@
 #include <linux/pm_runtime.h>
=20
 #define ULITE_NAME             "ttyUL"
+#if (CONFIG_SERIAL_UARTLITE_NR_UARTS > 4)
+#define ULITE_MAJOR             0       /* use dynamic node allocation */
+#define ULITE_MINOR             0
+#else
 #define ULITE_MAJOR            204
 #define ULITE_MINOR            187
+#endif
 #define ULITE_NR_UARTS         CONFIG_SERIAL_UARTLITE_NR_UARTS


Thanks,
Manikanta.

