Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF26797DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjIGVV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjIGVV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:21:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2131.outbound.protection.outlook.com [40.107.237.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A571BEE;
        Thu,  7 Sep 2023 14:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/fG1w4wtAAf7izmMUL4mNrUyXmdEHD14hHdEs0ncGZNbt0HUjJlJdXXp94U53JwdIQmpcVwSCdvFn7L6O51mXMLGIIZ1JGDPntT7BZ5SyBDVb1hMfOZP6jEjoTsYhsfsQFV8T4NAdh9ok1a9uIQT5omAwY1JLVzg58P9aRnb049vSqc4pukqsBSWT6/2Z/ZErcrYZP0VK69lW1+2wA5VTXVTGUPpuDKBPJ1WNmNZvVd8EVFia8Gxbnb0PP/JraEuJpGdSUOeZLk9JkWiT5jXIKoPSoKbyEBLe9hpIS5AIbmTJklCfMTyyroa0HM0aTDVbBq+eBi2Eo00OcJkj539A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkP2MEce26pBae4AuoqDbQPfui5EpCJYcYbq1iS/CiE=;
 b=CUVg2yA7CgT9lROoqst06d0jI4Q7CoGg9FErAYBzUx0vgfvakB826rofm5jmfenpj2Y5uo5YD5ZBTP6UZjO0300/HSHpyKiX6nqCROrE0PPRPb6XcIhX9y+q0gIufMV6luPSJHA/zBtWPIUNhAt+Ra66LskiyEoHagmUrCwdqCSApfuaRRvnomFX1s9v89Rn8mYytWZwoKbU2u1DPhQ4PjWA8klYMnAmhSNx3itHj2vsxj89Vf5sjLydCywQFKXKkpzypO+TGiQ+38E7JfQnefRbOs5Itq6U8Sn/HJTD5rILKzeGAguHBuspwPDBq26lPamnAX2n0mwMS2fVy4LtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkP2MEce26pBae4AuoqDbQPfui5EpCJYcYbq1iS/CiE=;
 b=c423XB3tve40GYd/HWWNQKUyVIMy5dm1T87PO8iHBPxWIRpevixuMSWuCMrCGhh1RSrFxzTsy1cal/as4VA7CsTk8ZAiqJT6e0zVDYy1XPPGJ6KCrGDT63z+IikzoC8MRW6+m2d0GPdd3flOE7v3LgHvuc2ztSLJOC7y19RsKX0=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 21:21:16 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::c89f:4b16:5fd5:11bb]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::c89f:4b16:5fd5:11bb%7]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 21:21:16 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "efremov@linux.com" <efremov@linux.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: WARNING in __floppy_read_block_0
Thread-Topic: WARNING in __floppy_read_block_0
Thread-Index: AQHZ4cl9KifaQm6buEK8aERwaB8JhA==
Date:   Thu, 7 Sep 2023 21:21:16 +0000
Message-ID: <BL0PR11MB310616FC87790EFFEDCC7CD0E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|LV8PR11MB8558:EE_
x-ms-office365-filtering-correlation-id: 26dc0dde-cf39-42c4-8187-08dbafe85ee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tf9jYL9OulJOqwhvtHg4v/z2UiiyWV8yVBt8rHfPARITkus3WoNSOCiYhax/GgXfbZi9pg3wSJf5LphwFoTq1eGIjnb+av9ITEVRV03P8F7O4oyH3XptJX1sTDQcwRrzsxCaR6h/ESnRZbHZI1Q8qC0DvYaoZ7ycjwm6ktCNNcljdBHyQ037nrbUA4UslgmIN1/9bz0gVwYUVlhdHHfWQf15T22ISQvOgu9CiV27XTriIvWwfaRFp1HkiQYeqnaw/nD6Ud85HY1RL04q2Eg4ajEEFirF3ay9xvd2NXFqGOJ+iupZHRuq+NkMnjAKbBxv3rs1/zl+X+/NxPoZAP+yngm/3IMwFALtgm5BHj66zQ6W/xWrrcV7JPHqMAxpeimReWeqsE+1gRgUpT1eoAGh1zLJCh+LYYPApdEjdJD/KRnvulQdy4P1dv3XtVjglZxx5hb8oIi8grm0V9/vKcPolklVzqf80JFxX5vECAHk19xhGBdzjowM94r2EiJGwaN1/EGPGWmynNs8rPNvY2mhjgg01VBUffpJ5dnEMnmxlggh4NynI1/d4Mz649oppGy3TyHvryhGV+vv5wtZGpfMqw52fG4gy+Pao8BgzZsAx+DnrLTn2GDsjrE6cA+sWG+kRZZgxxRdMd/bE1NaSPvvC4AtRkkXLndf+2E47O7gB6RcUUi7h+2vN2PgiZoFdZrH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199024)(186009)(1800799009)(91956017)(76116006)(66556008)(66946007)(66446008)(66476007)(64756008)(4326008)(5930299018)(5660300002)(52536014)(316002)(786003)(54906003)(7696005)(8676002)(41300700001)(8936002)(75432002)(9686003)(6506007)(83380400001)(110136005)(26005)(71200400001)(55016003)(966005)(45080400002)(478600001)(30864003)(2906002)(86362001)(33656002)(38070700005)(38100700002)(122000001)(58493002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4DQM/Q4AAWbVWMgXyP26/tyOtuLtZHGwqok1UqC0APsG5mQrtHpT4PGVnS?=
 =?iso-8859-1?Q?EpPxuGxJS84GGaQrc+53y8rXvZB5gCY7VNLkEpQ+FqFRKWW4kWlfowxwi+?=
 =?iso-8859-1?Q?Akmnf1xljb8ZXA6fVjIZCBrMbN1BxtIsZVCuEsNrrudwbsGuUxCHrUIaCc?=
 =?iso-8859-1?Q?qyKqVuTktcFHOCamY6zWaCUp82z5pndC0EOzKUmwEGhG/ZZvHrvkQgVyZ6?=
 =?iso-8859-1?Q?e39YH0TirMcnMWOQTFbYDtfY7GXfFxFJCOLyOA1lJhz53xK0jOeWeBh1qu?=
 =?iso-8859-1?Q?stujvjfLmvSMW4v1WuqfwrrLpwivGNoXTaHk/B9kyNqDXEWRMLyshMWSuo?=
 =?iso-8859-1?Q?z8m792jfdjHnOlN9hD4bRhP4C6rPEySM3Jfzl/FDFB7BqLXCcuu3DIU4hX?=
 =?iso-8859-1?Q?jJ3vPWIEnvGUBD5plCAlt48wXvDtRgQlWJ5sctIsJ4/tXi4mt+SWKCMsMJ?=
 =?iso-8859-1?Q?BdOVzBs+fOiayYqhWzUDuny5cp4+Quya3yNc6nlUFtNAfVo/1n4FbJlaxv?=
 =?iso-8859-1?Q?sZyugSp6UyMali6zUazYia3mMMTI/dZQRIQA4ChBoY0cfDxxhtQal80mwF?=
 =?iso-8859-1?Q?04oAsJreEDe5Pn7pr2jN8cVNM8hnjITsQpMQFoYm4hqVN72Gbkgum8K4u3?=
 =?iso-8859-1?Q?NOyHoQawsuIig8M5RAZxagj/t4q55N/zQWgO1I1k4gp6OoxbZuGyhJtwBJ?=
 =?iso-8859-1?Q?dVHMSzW2SjNdVN/6KwwT8Fp66HDqd0PzamDGW6w4VLz+2WxVf7CihTb9BP?=
 =?iso-8859-1?Q?xcNYRRlDxYDESASC25rWCNgdsSk81p6i1N98oPg3aPJt/o2cIQjhhST4Kx?=
 =?iso-8859-1?Q?a5/4UcSHGCpVsgReJo7+eOf9vTfqw/xngTicUYCVKpD3o6Yf8wwoMWXYVW?=
 =?iso-8859-1?Q?YmY0r4Psx17CvKR9FLB4jXkBkI5Mx5U9V8SMimMHn/VyA23Rc2xxK5hW5y?=
 =?iso-8859-1?Q?4Z8KcMCN6wS636PN1QhqXUQjLebozFPKb9J7Pugu3rXNgdvseThqBnvIs1?=
 =?iso-8859-1?Q?TpxgBnrB5L/FCAagAJ88gxxd73KwOybpxRE20d+Zr12Jg5CDn4grEwdaBb?=
 =?iso-8859-1?Q?XcKQUrZuWJDJiglFbgWlispwoSdsZvGgHpOIf965mS4Cic9s1h5CQ2H4d/?=
 =?iso-8859-1?Q?xWP42e5/HeGUXMPB31M+dgoMFCsWzmbi93OOMQxEI/IoFgtIPjo5tmqOfU?=
 =?iso-8859-1?Q?erHfVh1AvedJ62pM2nASNEPsN96i0iPPg+uwUrfgYAPCLQ3zHDZTIti2Oo?=
 =?iso-8859-1?Q?2N7IRh/Qa+iXXHKnFs6jzecut1DOOKHV6v/lqz+VoG/Jv+S1E7g521sTQ6?=
 =?iso-8859-1?Q?Ael9k1xkmKNzu44R6n2/c7ugiAsZjT7AO0qeomooV+cF+nHQcRDqMDLACz?=
 =?iso-8859-1?Q?PaITyxGOFWsA/TFYr5M29zFmw30TlcxeTkT77hLHn3CEoMwtTl0ED1JjLF?=
 =?iso-8859-1?Q?fzwnDZcDnt6gfGnXeWTtJDvA89klNSylNcf7Fw1ugU3urpwv0+AL0hMk20?=
 =?iso-8859-1?Q?vjWpDSPZIszF+WSWleXWuWEQsnFfJn2A7C25fQ0HVKjDCIzhuDLIoFD6bC?=
 =?iso-8859-1?Q?XAfneyFKF8aHar4ysNT/fy8VcFktQ+wVafWkeuj7m2pNRXny/KwqY3P18D?=
 =?iso-8859-1?Q?thYyfmYYZHIaU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dc0dde-cf39-42c4-8187-08dbafe85ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 21:21:16.1867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Deo61pQ2qQbniiRVofVZ9a+pCVh2NMkk2o9sxqFz7wHkkLWOTb873F/T5N9LQcEToZqQGRtzSROQ8WfmHEbGSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, dear maintainers,=0A=
=0A=
We found a bug using a modified kernel configuration file used by syzbot.=
=0A=
=0A=
We enhanced the coverage of the configuration file using our tool, klocaliz=
er.=0A=
=0A=
Kernel Branch: 6.3.0-next-20230505=0A=
Kernel Config: https://drive.google.com/file/d/1CWOQciTTXKzVb4DgU4k4_8G_EBn=
sj5e_/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1URA2qDJHiSLilF49m9XAutOZCd3CNg=
52/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
current_req=3D0000000000000000=0A=
command_status=3D-1=0A=
floppy0: floppy timeout called=0A=
no cont in shutdown!=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 3 PID: 17310 at drivers/block/floppy.c:999 schedule_bh driver=
s/block/floppy.c:999 [inline]=0A=
WARNING: CPU: 3 PID: 17310 at drivers/block/floppy.c:999 process_fd_request=
 drivers/block/floppy.c:2847 [inline]=0A=
WARNING: CPU: 3 PID: 17310 at drivers/block/floppy.c:999 __floppy_read_bloc=
k_0.isra.0+0x28b/0x320 drivers/block/floppy.c:4160=0A=
Modules linked in:=0A=
CPU: 3 PID: 17310 Comm: syz-executor.2 Not tainted 6.3.0-next-20230505 #1=
=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]=0A=
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]=0A=
RIP: 0010:__floppy_read_block_0.isra.0+0x28b/0x320 drivers/block/floppy.c:4=
160=0A=
Code: 65 48 2b 04 25 28 00 00 00 0f 85 a4 00 00 00 48 81 c4 88 01 00 00 5b =
41 5c 41 5d 41 5e 41 5f 5d e9 6e 3b 16 04 e8 b5 f3 c2 fc <0f> 0b e9 65 ff f=
f ff e8 c9 5c 17 fd e9 8a fe ff ff e8 9f f3 c2 fc=0A=
RSP: 0018:ffff88806c9ff690 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: ffff88806c9ff818 RCX: 0000000000000000=0A=
floppy0: floppy_shutdown: timeout handler died.  =0A=
RDX: ffff88806d252040 RSI: ffffffff84cac7db RDI: ffffffff84cac73e=0A=
RBP: ffff88806c9ff840 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0001b1b740=0A=
R13: 0000000000000001 R14: 1ffff1100d93fed3 R15: dffffc0000000000=0A=
FS:  00007f57dfc11700(0000) GS:ffff888119f80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f7a805bd0b0 CR3: 00000001178e4000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 floppy_revalidate.isra.0+0x80c/0xc10 drivers/block/floppy.c:4206=0A=
 floppy_open+0xadc/0xe90 drivers/block/floppy.c:4058=0A=
 blkdev_get_whole+0x9b/0x2d0 block/bdev.c:606=0A=
 blkdev_get_by_dev.part.0+0x5da/0xbb0 block/bdev.c:756=0A=
 blkdev_get_by_dev+0x7d/0x90 block/bdev.c:790=0A=
 blkdev_open+0x14a/0x2e0 block/fops.c:493=0A=
 do_dentry_open+0x683/0x1270 fs/open.c:920=0A=
 vfs_open+0xa4/0xe0 fs/open.c:1051=0A=
 do_open fs/namei.c:3636 [inline]=0A=
 path_openat+0x1d5c/0x2950 fs/namei.c:3791=0A=
 do_filp_open+0x1c9/0x420 fs/namei.c:3818=0A=
 do_sys_openat2+0x17c/0x540 fs/open.c:1356=0A=
 do_sys_open fs/open.c:1372 [inline]=0A=
 __do_sys_openat fs/open.c:1388 [inline]=0A=
 __se_sys_openat fs/open.c:1383 [inline]=0A=
 __x64_sys_openat+0x175/0x240 fs/open.c:1383=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x3f/0x90 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x72/0xdc=0A=
RIP: 0033:0x7f57dea3dca4=0A=
Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 86 f9 ff ff 44 8b 54 24 0c 44 89 =
e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 32 44 89 c7 89 44 24 0c e8 b8 f9 ff ff 8b 44=0A=
RSP: 002b:00007f57dfc10720 EFLAGS: 00000293 ORIG_RAX: 0000000000000101=0A=
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f57dea3dca4=0A=
RDX: 0000000000000000 RSI: 00007f57dfc107c0 RDI: 00000000ffffff9c=0A=
RBP: 00007f57dfc107c0 R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000=0A=
R13: 00007ffdd213b57f R14: 00007ffdd213b720 R15: 00007f57dfc10d80=0A=
 </TASK>=0A=
irq event stamp: 889=0A=
hardirqs last  enabled at (899): [<ffffffff816ff504>] __up_console_sem+0xf4=
/0x180 kernel/printk/printk.c:347=0A=
hardirqs last disabled at (908): [<ffffffff816ff4e9>] __up_console_sem+0xd9=
/0x180 kernel/printk/printk.c:345=0A=
softirqs last  enabled at (298): [<ffffffff8154f646>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last  enabled at (298): [<ffffffff8154f646>] __irq_exit_rcu+0x196/=
0x230 kernel/softirq.c:650=0A=
softirqs last disabled at (193): [<ffffffff8154f646>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last disabled at (193): [<ffffffff8154f646>] __irq_exit_rcu+0x196/=
0x230 kernel/softirq.c:650=0A=
---[ end trace 0000000000000000 ]---=0A=
=0A=
floppy driver state=0A=
-------------------=0A=
------------[ cut here ]------------=0A=
now=3D4294973631 last interrupt=3D4294973631 diff=3D0 last called handler=
=3Dreset_interrupt=0A=
WARNING: CPU: 2 PID: 5690 at drivers/block/floppy.c:999 schedule_bh drivers=
/block/floppy.c:999 [inline]=0A=
WARNING: CPU: 2 PID: 5690 at drivers/block/floppy.c:999 floppy_interrupt+0x=
46e/0x4e0 drivers/block/floppy.c:1765=0A=
timeout_message=3Dredo fd request=0A=
Modules linked in:=0A=
CPU: 2 PID: 5690 Comm: syz-executor.4 Tainted: G        W          6.3.0-ne=
xt-20230505 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]=0A=
RIP: 0010:floppy_interrupt+0x46e/0x4e0 drivers/block/floppy.c:1765=0A=
Code: ff e8 76 45 c3 fc 44 89 e7 31 db e8 3c 92 ff ff 41 89 c4 89 05 93 90 =
10 0a eb 94 e8 6c af 17 fd e9 cc fc ff ff e8 52 45 c3 fc <0f> 0b e9 a4 fe f=
f ff 48 c7 c7 00 f2 c0 8a e8 ef ae 17 fd e9 bd fb=0A=
RSP: 0018:ffff888119f09e38 EFLAGS: 00010046=0A=
RAX: 0000000080010001 RBX: 0000000000000001 RCX: 0000000000000000=0A=
RDX: ffff88810d818300 RSI: ffffffff84ca763e RDI: ffffffff84ca74e1=0A=
RBP: ffff888119f09e60 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000002=0A=
R13: 0000000000000000 R14: ffffffff84ca0b50 R15: 0000000000000000=0A=
FS:  000055555577b980(0000) GS:ffff888119f00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f410fd88d78 CR3: 000000010ca57000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <IRQ>=0A=
 floppy_hardint+0x1b1/0x200 arch/x86/include/asm/floppy.h:66=0A=
 __handle_irq_event_percpu+0x239/0x840 kernel/irq/handle.c:158=0A=
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]=0A=
 handle_irq_event+0xb1/0x1f0 kernel/irq/handle.c:210=0A=
 handle_edge_irq+0x268/0xd30 kernel/irq/chip.c:819=0A=
last output bytes:=0A=
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]=0A=
 handle_irq arch/x86/kernel/irq.c:231 [inline]=0A=
 __common_interrupt+0xac/0x240 arch/x86/kernel/irq.c:250=0A=
 8 80 4294973607=0A=
 common_interrupt+0xb6/0xe0 arch/x86/kernel/irq.c:240=0A=
 8 80 4294973607=0A=
 </IRQ>=0A=
 8 80 4294973607=0A=
 <TASK>=0A=
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:636=0A=
 8 80 4294973607=0A=
RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:701 [inline=
]=0A=
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:135 [inlin=
e]=0A=
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151=
 [inline]=0A=
RIP: 0010:_raw_spin_unlock_irqrestore+0x79/0xa0 kernel/locking/spinlock.c:1=
94=0A=
 8 80 4294973612=0A=
Code: c7 c0 a0 c3 e1 8a 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 =
00 75 1b 48 83 3d df fc 00 02 00 74 08 fb 0f 1f 44 00 00 <eb> b0 0f 0b e8 1=
e cc 1f f8 eb bc 48 c7 c7 a0 c3 e1 8a e8 60 5e 01=0A=
RSP: 0018:ffff88811237fbd0 EFLAGS: 00000282=0A=
RAX: 1ffffffff15c3874 RBX: 0000000000000286 RCX: 1ffffffff193c081=0A=
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000000=0A=
 8 80 4294973612=0A=
RBP: ffff88811237fbe0 R08: 0000000000000001 R09: 0000000000000001=0A=
 8 80 4294973612=0A=
R10: fffffbfff193c6e2 R11: 0000000000000001 R12: ffff8881079096e0=0A=
 8 80 4294973612=0A=
R13: 0000000000000286 R14: ffff88811237fd18 R15: ffff88811237fd20=0A=
 8 80 4294973617=0A=
 spin_unlock_irqrestore include/linux/spinlock.h:405 [inline]=0A=
 remove_wait_queue+0x113/0x1a0 kernel/sched/wait.c:56=0A=
 8 80 4294973617=0A=
 8 80 4294973617=0A=
 do_wait+0x68c/0xc40 kernel/exit.c:1639=0A=
 8 80 4294973617=0A=
 kernel_wait4+0x175/0x290 kernel/exit.c:1777=0A=
 8 80 4294973622=0A=
 8 80 4294973622=0A=
 8 80 4294973622=0A=
 8 80 4294973622=0A=
 8 80 4294973631=0A=
 __do_sys_wait4+0x14b/0x160 kernel/exit.c:1805=0A=
 8 80 4294973631=0A=
 8 80 4294973631=0A=
 8 80 4294973631=0A=
last result at 4294973631=0A=
last redo_fd_request at 4294973631=0A=
c3 00                                            ..=0A=
status=3D80=0A=
fdc_busy=3D1=0A=
 __se_sys_wait4 kernel/exit.c:1801 [inline]=0A=
 __x64_sys_wait4+0x9a/0x100 kernel/exit.c:1801=0A=
floppy_work.func=3Dfloppy_work_workfn=0A=
cont=3D000000001716a029=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x3f/0x90 arch/x86/entry/common.c:80=0A=
current_req=3D00000000c74d3a02=0A=
 entry_SYSCALL_64_after_hwframe+0x72/0xdc=0A=
command_status=3D-1=0A=
RIP: 0033:0x7fd7eb28c8bf=0A=
=0A=
Code: 89 7c 24 10 48 89 4c 24 18 e8 dd d9 02 00 4c 8b 54 24 18 8b 54 24 14 =
41 89 c0 48 8b 74 24 08 8b 7c 24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 2b 44 89 c7 89 44 24 10 e8 0d da 02 00 8b 44=0A=
floppy0: floppy timeout called=0A=
RSP: 002b:00007ffcf66bb8e0 EFLAGS: 00000293=0A=
floppy: error 10 while reading block 0=0A=
 ORIG_RAX: 000000000000003d=0A=
RAX: ffffffffffffffda RBX: 0000000000000110 RCX: 00007fd7eb28c8bf=0A=
RDX: 0000000040000001 RSI: 00007ffcf66bb95c RDI: 00000000ffffffff=0A=
RBP: 0000000000000bb8 R08: 0000000000000000 R09: 0000000000000001=0A=
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000058d8f=0A=
R13: 0000000000000001 R14: 00007ffcf66bb95c R15: 0000000000000032=0A=
 </TASK>=0A=
irq event stamp: 1130498=0A=
hardirqs last  enabled at (1130497): [<ffffffff88e0c69e>] __raw_spin_unlock=
_irqrestore include/linux/spinlock_api_smp.h:151 [inline]=0A=
hardirqs last  enabled at (1130497): [<ffffffff88e0c69e>] _raw_spin_unlock_=
irqrestore+0x4e/0xa0 kernel/locking/spinlock.c:194=0A=
hardirqs last disabled at (1130498): [<ffffffff88de310a>] common_interrupt+=
0x1a/0xe0 arch/x86/kernel/irq.c:240=0A=
softirqs last  enabled at (1129182): [<ffffffff8136dda8>] fpu_clone+0x368/0=
xc30 arch/x86/kernel/fpu/core.c:630=0A=
softirqs last disabled at (1129180): [<ffffffff8136dd42>] fpu_clone+0x302/0=
xc30 arch/x86/kernel/fpu/core.c:611=0A=
---[ end trace 0000000000000000 ]---=0A=
floppy0: no autodetectable formats=0A=
floppy: error 10 while reading block 0=0A=
general protection fault, probably for non-canonical address 0xdffffc000000=
0001: 0000 [#1] PREEMPT SMP KASAN=0A=
kobject: 'loop2' (00000000bf49ae8f): kobject_uevent_env=0A=
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]=0A=
kobject: 'loop2' (00000000bf49ae8f): fill_kobj_path: path =3D '/devices/vir=
tual/block/loop2'=0A=
CPU: 7 PID: 87 Comm: kworker/u16:3 Tainted: G        W          6.3.0-next-=
20230505 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Workqueue: floppy floppy_work_workfn=0A=
RIP: 0010:reset_interrupt+0xfb/0x240 drivers/block/floppy.c:1792=0A=
Code: fc 84 db 0f 85 8f 00 00 00 e8 61 af c3 fc 48 8b 1d 2a d2 10 0a 48 b8 =
00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 8=
5 0b 01 00 00 48 8b 43 08 e8 82 f0 16 04 48 8b 5d=0A=
RSP: 0018:ffff8881020dfce0 EFLAGS: 00010212=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000=0A=
RDX: 0000000000000001 RSI: ffffffff84ca0c2f RDI: 0000000000000008=0A=
RBP: ffff8881020dfce8 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8bb2e200=0A=
R13: ffff8881020dfda0 R14: ffff8881014efe00 R15: ffff888100079000=0A=
FS:  0000000000000000(0000) GS:ffff88811a180000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f57dea61c40 CR3: 000000010db84000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 floppy_work_workfn+0x19/0x20 drivers/block/floppy.c:992=0A=
 process_one_work+0x9f4/0x16d0 kernel/workqueue.c:2405=0A=
kobject: 'loop5' (000000007e339653): kobject_uevent_env=0A=
kobject: 'loop5' (000000007e339653): fill_kobj_path: path =3D '/devices/vir=
tual/block/loop5'=0A=
 worker_thread+0x68e/0x10f0 kernel/workqueue.c:2552=0A=
 kthread+0x359/0x460 kernel/kthread.c:379=0A=
 ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:reset_interrupt+0xfb/0x240 drivers/block/floppy.c:1792=0A=
Code: fc 84 db 0f 85 8f 00 00 00 e8 61 af c3 fc 48 8b 1d 2a d2 10 0a 48 b8 =
00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 8=
5 0b 01 00 00 48 8b 43 08 e8 82 f0 16 04 48 8b 5d=0A=
RSP: 0018:ffff8881020dfce0 EFLAGS: 00010212=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000=0A=
RDX: 0000000000000001 RSI: ffffffff84ca0c2f RDI: 0000000000000008=0A=
RBP: ffff8881020dfce8 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: ffffffff8bb2e200=0A=
R13: ffff8881020dfda0 R14: ffff8881014efe00 R15: ffff888100079000=0A=
FS:  0000000000000000(0000) GS:ffff88811a180000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f57dea61c40 CR3: 000000010db84000 CR4: 0000000000350ee0=0A=
----------------=0A=
Code disassembly (best guess):=0A=
   0:   c7 c0 a0 c3 e1 8a       mov    $0x8ae1c3a0,%eax=0A=
   6:   48 ba 00 00 00 00 00    movabs $0xdffffc0000000000,%rdx=0A=
   d:   fc ff df=0A=
  10:   48 c1 e8 03             shr    $0x3,%rax=0A=
  14:   80 3c 10 00             cmpb   $0x0,(%rax,%rdx,1)=0A=
  18:   75 1b                   jne    0x35=0A=
  1a:   48 83 3d df fc 00 02    cmpq   $0x0,0x200fcdf(%rip)        # 0x200f=
d01=0A=
  21:   00=0A=
  22:   74 08                   je     0x2c=0A=
  24:   fb                      sti=0A=
  25:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)=0A=
* 2a:   eb b0                   jmp    0xffffffdc <-- trapping instruction=
=0A=
  2c:   0f 0b                   ud2=0A=
  2e:   e8 1e cc 1f f8          call   0xf81fcc51=0A=
  33:   eb bc                   jmp    0xfffffff1=0A=
  35:   48 c7 c7 a0 c3 e1 8a    mov    $0xffffffff8ae1c3a0,%rdi=0A=
  3c:   e8                      .byte 0xe8=0A=
  3d:   60                      (bad)=0A=
  3e:   5e                      pop    %rsi=0A=
  3f:   01                      .byte 0x1=0A=
