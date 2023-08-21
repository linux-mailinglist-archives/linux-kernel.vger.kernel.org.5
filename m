Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334827828E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjHUMWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjHUMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:22:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD35BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P772v7nsjKbUZFk0uNYxgfuNnNBUiownGpjRon3yOXoqJqzms69eCgxmCD1pnVSjiK1Dls2+m/0U9ZwsfnZUzMc13mCj63O90JIAZRRcVDWOubMXVU2XoEGdAnoWIVPmQD0nN8w/vrtNYGWVjd3mGChI5lwUVMj7HAWubVYB4yDcpRwIh7Rfhm1CT2ZaElOjZGu8d1Bhg0f9wONnuLL7WEFDRngSEYZ0dy1ZPFY1jn3VWPLTw3sRIMlLsouG/kC7XZX2HUeh282rp3Y6jqvUlFk+IHCcrnlpGtXyesvA083bYv40xMG2FNTEezQV4v93WkZNZjU+sIoxTjEKpMh64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLa02MSSi2BUtnhbd0qRMOeAfSGZN8ovGVDoXFwokYc=;
 b=lR+8zYCPK3aLyjh+0HfKR2u8Fz4TpOnJVj92zogQR6dgbSdnhKTZg63Ilj0ZwqOHiIRdmNPOx/vfOVFNHNR8iNvv2NjficiYE/07A28rYuOz8B0ITDrfVRXVKrFCo2//1qYz4XjFYBetIubJEemXbT9TqRX2hJ6ljX0MP6Hv++meQlvo/Q+WWyRwx91/t9ZWt6jc0mVaNemB7f1/jowH552WCIyCcWPZTTcoaABt9ZTi9aBEyjYrEojwSxURw9pH8DyaepsC05Y5shGDDaXY9jSd3tJyVVbAKAY2GSmELqMDT0gd0sfCoMrUe0m6FMbRbfACZlbvY62MRb10IrC99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLa02MSSi2BUtnhbd0qRMOeAfSGZN8ovGVDoXFwokYc=;
 b=YlwL2jidvvAWKUSLqvO+YcFuk1k0F7ozNj/L7AxWVH9To8ZJuYap5sQOfVdhNfZHAsd+s7Sw5CMslOrnmCcOrHq04nWK9uQuGB21QA4W3N3kx9qd+FLLKVZ0XEy81hXsPDvB86ozpLny3nJen8nLro4rftgugJZ0M62TQSmkeWQ=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:22:13 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::5cff:cc6e:6241:168c%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 12:22:13 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     "bhe@redhat.com" <bhe@redhat.com>
CC:     "piliu@redhat.com" <piliu@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Subject: RE: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Thread-Topic: kexec reports "Cannot get kernel _text symbol address" on arm64
 platform
Thread-Index: AdnKK79OkD4zpG4kTFa/kOe2Uun+RAAOxmsAAHwHDeAAlUzuAAFfZ4gQ
Date:   Mon, 21 Aug 2023 12:22:13 +0000
Message-ID: <MN0PR12MB5953FFB655A208BD4FA32EE4B71EA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <MN0PR12MB59538822AA264031D0CAE468B70DA@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNL14lnrHvzbpRQu@MiWiFi-R3L-srv>
 <MN0PR12MB59535434E071499DDE439B08B710A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZNogKKZCp12Q92jh@MiWiFi-R3L-srv>
In-Reply-To: <ZNogKKZCp12Q92jh@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|MN2PR12MB4504:EE_
x-ms-office365-filtering-correlation-id: 4b159833-66ab-4364-cb5e-08dba2414037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQlxHH/9QnUqOlUqbWbpa8XgqTqouK/qJAB3470MSR2oX8Guf8MPA15LXJHSJBNQe+97x0Yps2xZEatuOZ3VufCM48j3GTYIwq2m0N70fOYIhepv+55cJob5Zze/0qAk1xiyQslWKmnxWvemaYwD16tPfznZtwbXIlF7pMY/Nlo8bwN2WJxlVdBQLERIDmiIp+M+B6cE67N/Hl/r7QAgawmfws9cQgqEmqvosR8Y40jvsUBb/AUPxzFLXJaz5SCOt4/Srj5iEg28Galsxr8mwYzb3sbXLRv2kH6i0IHZcpTvyCvtdxowvwN6B88MqL3iiAUBW+o+Iluw4PZYQXArNqfVPf+x/uKoR036PZMNjNFzDnHukcbcwVIrGW+QDAGV4PhlwydafAUZg4d7vpcjIjU/ZDMuB6bJV3C0zPeCMz4pT/rqygEbsAaBgoXGey/1hReofqzLRdX91DUqzU8afrDduW7InA0/4DUTfNImmewk9x0s5CbFbkh4YbFDnv5Xl++8tpx6uQHybt43q5vp503fXJk1+cWHskgwYsU9la8dXeLeG/NAUuYUW4Rif4NhUtLTbXM6sXC4Gbrk4NzWLg4EZDAVlMI6sgiH472/lOqx/gwACjrMptDrqlF1/xGx66fDV9OxnaqM5fg1bXHSDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(30864003)(45080400002)(53546011)(38100700002)(38070700005)(6506007)(83380400001)(5660300002)(52536014)(33656002)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(54906003)(6916009)(66446008)(66556008)(76116006)(66476007)(966005)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PYtI1MDLrkYDdyOjOZ7myokSmnEPMdxQyRvCkl2cCOxc7F5HvIc86N7wDXUA?=
 =?us-ascii?Q?0XLkwcaeTbf0glIap3cY7uvLQmbH9ZCfGZCZy5+qyB4pOYMTh4WzA1LRvf4i?=
 =?us-ascii?Q?99TlMbQI3YWLeEw/sc0cSB99S6RoUqV9hjxLGIdW2VwuC1L2vTv81aTAoQ0y?=
 =?us-ascii?Q?SiCqUKn6RBubgFEOJDaoQic2onllmc3yLrNb1J3QEGoj5naTzHvDY4RoEFIs?=
 =?us-ascii?Q?Ty8SqiCmJvq1Ns/++1Ri6GWWSlSL7joJaBBgedLOXRbqJlBlMnRdNb4hjSvA?=
 =?us-ascii?Q?lfvaErBDvrvxgje+LmCLbt8BzIzq+SLqhZ1Bpj1DoJmd/msO/noFK8DJjz+i?=
 =?us-ascii?Q?8jIR2ZctgvesfKO49JWzRXuZwW9reaFDAftha8pRpP0s94/NE6yYQ1EHRXPa?=
 =?us-ascii?Q?BUzqYOZkOv7sgPho1ZM57Ir552KCKzVnosspKrkyX2IVEoHUkWSvh0OlJ8kE?=
 =?us-ascii?Q?2ZmQ5/DZ5XvPXmu2/yA1tUuXf2qk1p6WQjy9y8sgA/PIS6uyRBRQefz13vSd?=
 =?us-ascii?Q?Fz88zCcEBmWWb3jWM0uFovKPSX6KsEq3fRSIybSUeM9SkPL0B6bZwMh5TNlE?=
 =?us-ascii?Q?jhVLMqUI81+Vfnt9BEuFxTOia7TxpbJHIrOl21DEdzY1CuJkC64CtotNwOSi?=
 =?us-ascii?Q?tv58amgxDhn7YLwBO20xIFUrBWhXXc5QU7InwUlYDqMAhOQ6Aud/dgFC1ZRd?=
 =?us-ascii?Q?X1vfSk+RSnde0xNzC2LMAdexxF/05816nMlGBzMb3h9GKRSJs4W6b1saTy9Y?=
 =?us-ascii?Q?XYQfnH+FywnLRovqZrc7W+4kRUHq3iI6GzYOt8OPKtEXe0cf5l6e34SqCiLZ?=
 =?us-ascii?Q?oOk5TJ5iaOoBhB001vafARlLLAail54ZWvbPvwL6rKbF0uGQ60Q0wY7MwF/2?=
 =?us-ascii?Q?/S9TtEAMXdXpUk0pVUid9Z+eLLfhuEfHlqNpn/rNXDSZdh4FRDJNoikUxOe1?=
 =?us-ascii?Q?f/jsEJg7HfuFBjaj4gEYGB6RokommSoMinntZNhUgc1p5SgDq4U4FKHHmIRo?=
 =?us-ascii?Q?tv8wYNxbn9xX441KeaMH/S5fxc9tM5S84BX6TmsmQofxDMzjOTIWZzslLs7g?=
 =?us-ascii?Q?cSlRunoJsStWesm6QeQwDvwVo8827/a57IVLvMAiQUZn1iF4zcopPPKTZ8Q1?=
 =?us-ascii?Q?7kDqmXrU9sI3aDg2IIdlqbxjNto8/rjRkNY1Qaq3tYcEjlxskXUfoWLZ6AlG?=
 =?us-ascii?Q?3v4YBQZaNumUwJVgDlBqI4ujdLXpyt3d08g7sQS5L9opW1QH7IzufHOPC3tg?=
 =?us-ascii?Q?JHcH4kYkSr+4N4dR8ilZ57Hqmf2cF/55UweLH3AogRaqyq4o0jnu5z6uqyhv?=
 =?us-ascii?Q?uKM7zxkncZarpKv6Bft8++r4CoVR7VMFHXTT76ar8uuOqooi+z3eyaoKXvu9?=
 =?us-ascii?Q?RFe1cVFzd0D6e2IMr1G/6ruoj3Wplv1coYPZWmaL1KwY4NY7MdX1h7kPOeFG?=
 =?us-ascii?Q?N1sfL/3K5I4ZPxF6HNgiNYPK0JG/2fzaPaq8zUAv83S5l0vP+uPsRWuz+/iA?=
 =?us-ascii?Q?TIAJCKCZMkHnoeIUfE3itUI9HdFzXoegC8En8oXCac+jykTH6/oacq9+K6rs?=
 =?us-ascii?Q?v4haxNo2XM+28aqNcyXhhWUQR2WFU5Yx+9u91bVxL4wPZifOE8srp8gJcf22?=
 =?us-ascii?Q?GroCO/MgbyW9azKKEdABtIs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b159833-66ab-4364-cb5e-08dba2414037
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 12:22:13.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3i1SQGiyoWm10WqsbBl6Pz848Tpv298McnCNx26ywUpayA5mT0o6abYPjTQMdpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: bhe@redhat.com <bhe@redhat.com>
> Sent: Monday, August 14, 2023 6:08 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: piliu@redhat.com; kexec@lists.infradead.org; linux-
> kernel@vger.kernel.org; Sarangi, Anirudha <anirudha.sarangi@amd.com>
> Subject: Re: kexec reports "Cannot get kernel _text symbol address" on
> arm64 platform
>=20
> On 08/11/23 at 01:27pm, Pandey, Radhey Shyam wrote:
> > > -----Original Message-----
> > > From: bhe@redhat.com <bhe@redhat.com>
> > > Sent: Wednesday, August 9, 2023 7:42 AM
> > > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
> > > piliu@redhat.com
> > > Cc: kexec@lists.infradead.org; linux-kernel@vger.kernel.org
> > > Subject: Re: kexec reports "Cannot get kernel _text symbol address"
> > > on
> > > arm64 platform
> > >
> > > On 08/08/23 at 07:17pm, Pandey, Radhey Shyam wrote:
> > > > Hi,
> > > >
> > > > I am trying to bring up kdump on arm64 platform[1]. But I get
> > > > "Cannot get
> > > kernel _text symbol address".
> > > >
> > > > Is there some Dump-capture kernel config options that I am missing?
> > > >
> > > > FYI, copied below complete kexec debug log.
> > > >
> > > > [1]: https://www.xilinx.com/products/boards-and-kits/vck190.html
> > >
> > > Your description isn't clear. You saw the printing, then your kdump
> > > kernel loading succeeded or not?
> > >
> > > If no, have you tried applying Pingfan's patchset and still saw the i=
ssue?
> > >
> > > [PATCHv7 0/5] arm64: zboot support
> > > https://lore.kernel.org/all/20230803024152.11663-1-piliu@redhat.com/
> > > T/#u
> >
> > I was able to proceed further with loading with crash kernel on trigger=
ing
> system crash.
> > echo c > /proc/sysrq-trigger
> >
> > But when I copy /proc/vmcore it throws memory abort. Also I see size of
> /proc/vmcore really huge (18446603353488633856).
> > Any possible guess on what could be wrong?
>=20
> I didn't reproduce this issue on a arm64 baremetal system with the latest
> kernel. From the log, It could be the iov_iter convertion patch which cau=
sed
> this. Can you revert below patch to see if it works?
>=20
> 5d8de293c224 vmcore: convert copy_oldmem_page() to take an iov_iter

Revert of this commit resulted in lot of conflicts. So as a safer side I ch=
eckout
v5.18 kernel version before above commit. Still I see the same issue.

/ # ls -lrth /proc/vmcore=20
-r--------    1 root     root       16.0E Aug 21 12:16 /proc/vmcore
/ # dmesg | grep -i 5.18
[    0.000000] Linux version 5.18.0-00001-g689fdf110e63-dirty (radheys@xhdr=
adheys41) (aarch64-xilinx-linux-gcc.real (GCC) 12.2.0, GNU ld (GNU Binutils=
) 2.39.0.20220819) #37 SMP Mon Aug 21 17:38:24 IST 2023
[    2.494578] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.18
[    2.514941] usb usb1: Manufacturer: Linux 5.18.0-00001-g689fdf110e63-dir=
ty xhci-hcd
[    2.555265] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.18
[    2.575621] usb usb2: Manufacturer: Linux 5.18.0-00001-g689fdf110e63-dir=
ty xhci-hcd
[    3.152182] usb 1-1: new high-speed USB device number 2 using xhci-hcd
/ # cp /proc/vmcore dump
[   86.204704] Unable to handle kernel level 3 address size fault at virtua=
l address ffff800009b75000
[   86.213677] Mem abort info:
[   86.216464]   ESR =3D 0x96000003
[   86.219508]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   86.224812]   SET =3D 0, FnV =3D 0
[   86.227856]   EA =3D 0, S1PTW =3D 0
[   86.230989]   FSC =3D 0x03: level 3 address size fault
[   86.235945] Data abort info:
[   86.238819]   ISV =3D 0, ISS =3D 0x00000003
[   86.242646]   CM =3D 0, WnR =3D 0
[   86.245608] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000430490=
00
[   86.252304] [ffff800009b75000] pgd=3D1000000061ffe003, p4d=3D1000000061f=
fe003, pud=3D1000000061ffd003, pmd=3D1000000043c12003, pte=3D00687ffff82007=
03
[   86.264828] Internal error: Oops: 96000003 [#1] SMP
[   86.269696] Modules linked in:
[   86.272741] CPU: 1 PID: 298 Comm: cp Not tainted 5.18.0-00001-g689fdf110=
e63-dirty #37
[   86.280562] Hardware name: Xilinx Versal vck190 Eval board revA (DT)
[   86.286905] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   86.293857] pc : __arch_copy_to_user+0x180/0x240
[   86.298475] lr : copy_oldmem_page+0xa8/0x110
[   86.302738] sp : ffff80000af6bc50
[   86.306041] x29: ffff80000af6bc50 x28: ffff8000097de3b0 x27: ffff8000097=
de228
[   86.313170] x26: 0000000000000000 x25: ffff80000af6bd60 x24: 00000000000=
00000
[   86.320299] x23: ffff800009b75000 x22: 0000000000000001 x21: 0000ffffffa=
1e5a8
[   86.327427] x20: 0000000000000000 x19: 0000000000001000 x18: 00000000000=
00000
[   86.334555] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800009b=
75000
[   86.341682] x14: ffff800009863568 x13: 0000000000000000 x12: ffff8000080=
00000
[   86.348810] x11: 00007ffff8201000 x10: ffff800009b75fff x9 : 00000000000=
00000
[   86.355937] x8 : ffff800009b76000 x7 : 0400000000000001 x6 : 0000ffffffa=
1e5a8
[   86.363065] x5 : 0000ffffffa1f5a8 x4 : 0000000000000000 x3 : 0000fffffff=
fffff
[   86.370192] x2 : 0000000000000f80 x1 : ffff800009b75000 x0 : 0000ffffffa=
1e5a8
[   86.377320] Call trace:
[   86.379755]  __arch_copy_to_user+0x180/0x240
[   86.384018]  read_from_oldmem.part.0+0x160/0x1f4
[   86.388629]  read_vmcore+0xe4/0x214
[   86.392109]  proc_reg_read+0xb0/0x100
[   86.395763]  vfs_read+0x90/0x1dc
[   86.398981]  ksys_read+0x70/0x10c
[   86.402286]  __arm64_sys_read+0x20/0x30
[   86.406111]  invoke_syscall+0x54/0x124
[   86.409852]  el0_svc_common.constprop.0+0x44/0xec
[   86.414547]  do_el0_svc+0x70/0x90
[   86.417853]  el0_svc+0x50/0xa4
[   86.420899]  el0t_64_sync_handler+0x10c/0x140
[   86.425247]  el0t_64_sync+0x18c/0x190
[   86.428902] Code: d503201f d503201f d503201f d503201f (a8c12027)=20
[   86.434984] ---[ end trace 0000000000000000 ]---
Segmentation fault


>=20
> >
> >
> > [   80.733523] Starting crashdump kernel...
> > [   80.737435] Bye!
> > [    0.000000] Booting Linux on physical CPU 0x0000000001 [0x410fd083]
> > [    0.000000] Linux version 6.5.0-rc4-ge28001fb4e07
> (radheys@xhdradheys41) (aarch64-xilinx-linux-gcc.real (GCC) 12.2.0, GNU l=
d
> (GNU Binutils) 2.39.0.20220819) #23 SMP Fri Aug 11 16:25:34 IST 2023
> > <snip>
> >
> >
> >
> > xilinx-vck190-20232:/run/media/mmcblk0p1# cat /proc/meminfo | head
> > MemTotal:        2092876 kB
> > MemFree:         1219928 kB
> > MemAvailable:    1166004 kB
> > Buffers:              32 kB
> > Cached:           756952 kB
> > SwapCached:            0 kB
> > Active:             1480 kB
> > Inactive:          24164 kB
> > Active(anon):       1452 kB
> > Inactive(anon):    24160 kB
> > xilinx-vck190-20232:/run/media/mmcblk0p1# cp /proc/vmcore dump
> > [  975.284865] Unable to handle kernel level 3 address size fault at
> > virtual address ffff80008d7cf000 [  975.293871] Mem abort info:
> > [  975.296669]   ESR =3D 0x0000000096000003
> > [  975.300425]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [  975.305738]   SET =3D 0, FnV =3D 0
> > [  975.308788]   EA =3D 0, S1PTW =3D 0
> > [  975.311925]   FSC =3D 0x03: level 3 address size fault
> > [  975.316888] Data abort info:
> > [  975.319763]   ISV =3D 0, ISS =3D 0x00000003, ISS2 =3D 0x00000000
> > [  975.325245]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [  975.330292]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [  975.335599] swapper pgtable: 4k pages, 48-bit VAs,
> > pgdp=3D000005016ef6b000 [  975.342297] [ffff80008d7cf000]
> > pgd=3D10000501eddfe003, p4d=3D10000501eddfe003, pud=3D10000501eddfd003,
> > pmd=3D100005017b695003, pte=3D00687fff84000703 [  975.354827] Internal
> error: Oops: 0000000096000003 [#4] SMP [  975.360392] Modules linked in:
> > 3  975.
> > 63440] CBPrUo:a d0c aPID: 664 Comm: cp Tainted: G      D            6.5=
.0-rc4-
> ge28001fb4e07 #23
> > [  975.372822] Hardware name: Xilinx Versal vck190 Eval board revA
> > (DT) [  975.379165] pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT
> > -SSBS BTYPE=3D--) [  975.386119] pc : __memcpy+0x110/0x230 [
> > 975.389783] lr : _copy_to_iter+0x3d8/0x4d0 [  975.393874] sp :
> > ffff80008dc939a0 [  975.397178] x29: ffff80008dc939a0 x28:
> > ffff05013c1bea30 x27: 0000000000001000 [  975.404309] x26:
> > 0000000000001000 x25: 0000000000001000 x24: ffff80008d7cf000 [
> > 975.411440] x23: 0000040000000000 x22: ffff80008dc93ba0 x21:
> > 0000000000001000 [  975.418570] x20: ffff000000000000 x19:
> > 0000000000001000 x18: 0000000000000000 [  975.425699] x17:
> > 0000000000000000 x16: 0000000000000000 x15: 0140000000000000 [
> > 975.432829] x14: ffff8500a9919000 x13: 0040000000000001 x12:
> > 0000fffef6831000 [  975.439958] x11: ffff80008d9cf000 x10:
> > 0000000000000000 x9 : 0000000000000000 [  975.447088] x8 :
> > ffff80008d7d0000 x7 : ffff0501addfd358 x6 : 0400000000000001 [
> > 975.454217] x5 : ffff0501370e9000 x4 : ffff80008d7d0000 x3 :
> 0000000000000000 [  975.461346] x2 : 0000000000001000 x1 :
> ffff80008d7cf000 x0 : ffff0501370e8000 [  975.468476] Call trace:
> > [  975.470912]  __memcpy+0x110/0x230
> > [  975.474221]  copy_oldmem_page+0x70/0xac [  975.478050]
> > read_from_oldmem.part.0+0x120/0x188
> > [  975.482663]  read_vmcore+0x14c/0x238 [  975.486231]
> > proc_reg_read_iter+0x84/0xd8 [  975.490233]
> > copy_splice_read+0x160/0x288 [  975.494236]
> > vfs_splice_read+0xac/0x10c [  975.498063]
> > splice_direct_to_actor+0xa4/0x26c [  975.502498]
> > do_splice_direct+0x90/0xdc [  975.506325]  do_sendfile+0x344/0x454 [
> > 975.509892]  __arm64_sys_sendfile64+0x134/0x140
> > [  975.514415]  invoke_syscall+0x54/0x124 [  975.518157]
> > el0_svc_common.constprop.0+0xc4/0xe4
> > [  975.522854]  do_el0_svc+0x38/0x98
> > [  975.526162]  el0_svc+0x2c/0x84
> > [  975.529211]  el0t_64_sync_handler+0x100/0x12c [  975.533562]
> > el0t_64_sync+0x190/0x194 [  975.537218] Code: cb01000e b4fffc2e
> > eb0201df 540004a3 (a940342c) [  975.543302] ---[ end trace
> > 0000000000000000 ]--- t message from
> > systemd-journald@xilinx-vck190-20232 (Tue 2022-11-08 14:16:20 UTC):
> >
> > kernel[539]: [  975.354827] Internal error: Oops: 0000000096000003
> > [#4] SMP
> >
> >
> > Broadcast message from systemd-journald@xilinx-vck190-20232 (Tue
> 2022-11-08 14:16:20 UTC):
> >
> > kernel[539]: [  975.537218] Code: cb01000e b4fffc2e eb0201df 540004a3
> > (a940342c)
> >
> > Segmentation fault
> > xilinx-vck190-20232:/run/media/mmcblk0p1# ls -lrth /proc/vmcore
> > -r--------    1 root     root       16.0E Nov  8 14:05 /proc/vmcore
> > xilinx-vck190-20232:/run/media/mmcblk0p1# ls -lh /proc/vmcore
> > -r--------    1 root     root       16.0E Nov  8 14:05 /proc/vmcore
> > xilinx-vck190-20232:/run/media/mmcblk0p1# ls -l /proc/vmcore
> > -r--------    1 root     root     18446603353488633856 Nov  8 14:05
> /proc/vmcore
> >
> > Thanks,
> > Radhey
> >

