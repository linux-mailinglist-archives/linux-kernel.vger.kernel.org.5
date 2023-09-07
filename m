Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4593797DDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjIGVU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjIGVU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:20:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2104.outbound.protection.outlook.com [40.107.237.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B3CB4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbtMvbFyXmdM7GfzQfOj4ZH32feGeIylkcgJYs+OdO+zO9g9Bs1QePdGGlFr1ktTUDni9lMsEtmli7N87l1y8wHWNS3k322OZEiWrW/zkmBt4uHDUDJO6ait2NmvKPd08aUGwOrMC3A02XEUECayCBHIkCXTaLZnu8SMM8NBMrxqvoDGgzaVNZ5P+vvdOREPAMuQGyakqDIh3Ac9AdBL/dlcv0puTzV2P137GDkuSd/FYAi5Ozzv43iICH73f8RvljGgU/sEKGX5no7lctMC+Kng+/SLG4NDIdiTn3bZl2mMZF8RWVjkLYVeEl3sQirdIqvKmUn5c+LbLn0Gzdxamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sM92TDwKEcUD+OnQTb5RiaMCJWQRFOY05KYzhGXUtc=;
 b=b8h+vO4WcLYkaSzUKmKumCV+rL4M5doW5i9G2iEyn95NIYpneqwzPMWbaukr/ZBymndSUcWCy1kWzJFvQHD5Y1pQoj2t6+WcAr8HlvZFX1J94Ri30WPEyYzP7ONyCoiBdLlFpYPnAu5gMF+hQP2zeMjhHBulUrabgMSdJIXQU/1y9UPAQKdnlFMtAV2cBS898mHX+rZ0dFOrla0YvAfvpCzx3OO2xfy/D2TPueXie2DCB0O7DqggWIHFma9xbSMgdF2ZEf2rWhRcpJ9TGEvf02m8SRK7L5rOlxclwxOaXl9pU4vYJ6ZfdJjlJ1DYYa63TPdCfgPrqf/OLhnhEMN7/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sM92TDwKEcUD+OnQTb5RiaMCJWQRFOY05KYzhGXUtc=;
 b=pxnpNaY5/EWsugJ8+8h0V9papPGp20vKnjGa/tFMZkdsbQSek1J17aDZU5vbBue9cY/G312lv7RY6jBAPl2RLfrR8bOQXkcgezrHSh9KJjcZ3LWZhJoNLTIv9EFg0+OB6tyg/wb6QgkbOfI+x+oPVsjB1O2WJGIpVGHDN7Kkx8A=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 21:20:50 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::c89f:4b16:5fd5:11bb]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::c89f:4b16:5fd5:11bb%7]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 21:20:49 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "shaggy@kernel.org" <shaggy@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: kernel BUG in jfs_evict_inode
Thread-Topic: kernel BUG in jfs_evict_inode
Thread-Index: AQHZ4chLMX2vKk4Bd0mXsN2z4pfqqg==
Date:   Thu, 7 Sep 2023 21:20:49 +0000
Message-ID: <BL0PR11MB3106C6EF24E1C6B03F15B258E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|LV8PR11MB8558:EE_
x-ms-office365-filtering-correlation-id: 815100c0-6d0e-414f-dfaf-08dbafe84f26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g99/bGiVTi0YRdKtWqYus9Axtvt0uTtIV0QITEA4WdET7FmFgAA8e/sfEBqNGIZ67on14YhJ2G94EESX7QllpZnvVyStdMsnUdteEZdCHkrCYPzmZpnt2WuMec5T1J90JcVY0T7ZimnwC+5G2uYc4/MlynAbnw7Zo+hrGXfLw1jnRYrsi1aZrciD3/QuRrSxjVkILf3M/77itq9R6CEv5OWrQy+TYVmiNQCmVeNJEMFCvCSvZ6dV/nRYnW28V0VTNtklrejKw3HKkJZ0gW/e102bimYwM1QcuTMJGs/jXXKtLp6jThvaXyje5xSO7XQKDWptL6f59GMU3V4XPyPrnZTWRZBlLv1eDwjn4thy1v6f0R8hLK+mYnWDNPSejfZLo/LzV5ms7wkag4uY0XYQ26uUWoXPklgUKL3rM4mQQwSeP1UVpBQuvVIKmL5PGQf/l3P46EUbzf3E95MR0ICPFTVUKQX7XfQmpyZFhVOynuP4ZLvQVK/SRQb75VVy1Ba2DHur8wdbCN4vJTnKyj4xvQJTU+n1MdYdoQ6jNkmHR7d9oKrRBy4onxDURGwlNDArVS4iG258Nie4kw/hMA1U2Au+eU9H2b3QxtBqVVW+jfdpjk8+M49H1eyuPpC9BkY9V9PmR+qgUoGhT+2pPctdhEWJf7TNJoInE1IDn1kOvyg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199024)(186009)(1800799009)(91956017)(76116006)(66556008)(66946007)(66446008)(66476007)(64756008)(4326008)(5930299018)(5660300002)(52536014)(316002)(786003)(54906003)(7696005)(8676002)(41300700001)(8936002)(75432002)(9686003)(6506007)(83380400001)(110136005)(26005)(71200400001)(55016003)(966005)(45080400002)(478600001)(2906002)(86362001)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cZ2lAsIKfBIXpiDVHsnYIcO/92+SzZpfgJIwmqONDChjrJtQEqOm7E7PFW?=
 =?iso-8859-1?Q?Wamm+a0XH6gpG2OjY/GmRITSFw2aHzCW4d+3NPNeRq5cKAQiJJdifU550c?=
 =?iso-8859-1?Q?HPM0KCdevY76i/kxUB6MpeWfzeY9mY60GNH/wel/DD3HS3/F66Vvx0MEkK?=
 =?iso-8859-1?Q?2P14or1b8i27B1OgSMzTt76DhhZ/Yfc/oztyx3MPjrzBr88sJm5x/lV5ey?=
 =?iso-8859-1?Q?lVtNRU6JX1BFP3cOR53SVqUWNvsXhc35nS1nIWQgunorGeROWrPw6ketyM?=
 =?iso-8859-1?Q?xEKzUyXdEFLVmUTVmMdYP/IjvomDtOFHhQSmNY8gZXIjMRT1clH918SBZI?=
 =?iso-8859-1?Q?fUpmjrTvDXsitdaqQLjEM5FjNcbK64s3adqwXI8LK5AR3i1m/DUjWreYm7?=
 =?iso-8859-1?Q?3ZOgYqmI7ZkpXj7WJBbxZRnAV0hWvHdDoTw42Amz6Ej/jSDP5+BEkc0NNh?=
 =?iso-8859-1?Q?0igHDB0QPZHxa9ccjL/jGeNMRACGNAvY/UYPl8JOpWqCQSaAKDH9vbh+67?=
 =?iso-8859-1?Q?3sg3g+SFO8Z3Cr7Br+Cf6uT07/hy55VRrpxf3QuQXv7uRjHyNsJQKqKtkK?=
 =?iso-8859-1?Q?TlJNOPdR3cVn8wlVphyAdpKMItmZrnGvmXP1rTQ92n5Kk9khUjnDZ1kIzL?=
 =?iso-8859-1?Q?U+Fcu36Lxjxtpmcl7pzo6j6Lw/4c6Dx9AYA0SXlKMRVoh3pnSlKX/zAHU3?=
 =?iso-8859-1?Q?EeK8yEsjyGVRjUVI+IjXikCX2iNM7UnyERAHnVySmVW9ERAz1TBT/R/kLf?=
 =?iso-8859-1?Q?W/lrHWJWdidjM1Bp3jsXm5uB5SbQE4/O7FW1Pw/8HBSmORXQRoI7DWSTS1?=
 =?iso-8859-1?Q?ZwZQ449YWoSIOnpRkkpuN0b/gOb4E91OBs1a1NwjXGmlKubWxDDJ9J6cYS?=
 =?iso-8859-1?Q?5xru1YM3vtPl/c1iyPYtnr1Z5GdxIYSf+Oz3ixgjEbvAsgOLtXjvLg7rHg?=
 =?iso-8859-1?Q?y8CfCajsyZ6ufnyXEUFJZlZpBdVeTh6hjSzjaFUszR6AlopbMf+mKYuc8K?=
 =?iso-8859-1?Q?wRHe7DeFQd9O1gAqr5Bfz0nEw4PuDN5yJd/YRYS7Jh9p3YJjdkKTtYgipq?=
 =?iso-8859-1?Q?Mcg/Z7ZZjBG7YcvPpxRjYnfGBjpFN9kDN/0zhT2arBB/wNo6CoUV2szBni?=
 =?iso-8859-1?Q?UTAqPIJjcya9QHAs67aCpoDb/DYhuzpb2pe7abgPG43iu3Z3ICC0PlE7hI?=
 =?iso-8859-1?Q?G9ntpfwUa3bYkq9TiwmUCpqsa8VzC5hZWYKvF+1X3M1qW0xSm9NjIRrF4A?=
 =?iso-8859-1?Q?Q+1Fh01+Dx058KsFXvt+jBojQ/CvOgOzu0TlNvenwy+mEIBwuaXGObAz7A?=
 =?iso-8859-1?Q?UsKjn1wdIE10OoOvUuFi/PuT4c8mGb9bHrM/SkIILj+UFkUg4wgBsP5Oap?=
 =?iso-8859-1?Q?kbVjUJSpiMYnjAyeViBTt/5nWWLVLb8UUbWHtGBgVIEj8dhNNF7S1e+kcA?=
 =?iso-8859-1?Q?LRQpcHkrfEV9Mbl3vxwMNVFXodHWBkBJYZHkUTeu+ypQU68wxLnwWpyD2s?=
 =?iso-8859-1?Q?NQb71n391DGAEcgKQWvmwxLENPgncbIY+kOhE4/6koiPE7Fh+u1Xb5rA+r?=
 =?iso-8859-1?Q?7TvMTyCxRMF3FOQSoQ8HWYKjsltxIuMbv+gxKwm2/gDZ8UvtVzVHGlxrIn?=
 =?iso-8859-1?Q?bgb2lnJ+lwGwA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815100c0-6d0e-414f-dfaf-08dbafe84f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 21:20:49.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drWp6r3Xfxn9t6cOa7KpB3jIqwjL6FcFrDrsC5uhrr6f99Zbrag00Mek+tADHyixLrNKLTMG9zOprViqpApCYQ==
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
Kernel Branch: 6.3.0-next-20230426=0A=
Kernel Config: https://drive.google.com/file/d/16JKx3e-lqX9uQFDinkLwGNE9YWG=
yNH3o/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1OPF8Di2dWSX10ejBfqopxpBU0BIZyq=
WW/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
kernel BUG at fs/jfs/inode.c:169!=0A=
invalid opcode: 0000 [#1] PREEMPT SMP KASAN=0A=
CPU: 0 PID: 4961 Comm: syz-executor.7 Not tainted 6.3.0-next-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:jfs_evict_inode+0x3eb/0x4b0 fs/jfs/inode.c:169=0A=
Code: 7c 24 80 00 74 0d e8 a4 6c a9 fe 48 89 df e8 fc 5f 02 00 e8 97 6c a9 =
fe 48 89 df e8 af e4 28 ff e9 e3 fc ff ff e8 85 6c a9 fe <0f> 0b 48 c7 c7 2=
0 67 2c 8c e8 67 a5 f9 fe e9 44 fc ff ff e8 5d a5=0A=
RSP: 0018:ffffc9000b6578e8 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: ffff888076d0d770 RCX: 0000000000000000=0A=
RDX: ffff8880467cbb80 RSI: ffffffff82d81bab RDI: ffff888076d0d760=0A=
RBP: ffff888076d0d3f8 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888076d0d848=0A=
R13: ffff888076d0d798 R14: ffffffff8a084920 R15: ffff88807d8f8a00=0A=
FS:  0000000000000000(0000) GS:ffff888119c00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007ffc88d736c0 CR3: 000000007cee3000 CR4: 0000000000350ef0=0A=
Call Trace:=0A=
 <TASK>=0A=
 evict+0x2ed/0x6b0 fs/inode.c:665=0A=
 dispose_list+0x117/0x1e0 fs/inode.c:698=0A=
 evict_inodes+0x345/0x440 fs/inode.c:748=0A=
 generic_shutdown_super+0xaf/0x480 fs/super.c:479=0A=
 kill_block_super+0xa1/0x100 fs/super.c:1407=0A=
 deactivate_locked_super+0x98/0x160 fs/super.c:331=0A=
 deactivate_super+0xb1/0xd0 fs/super.c:362=0A=
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177=0A=
 task_work_run+0x168/0x260 kernel/task_work.c:179=0A=
 exit_task_work include/linux/task_work.h:38 [inline]=0A=
 do_exit+0xb07/0x29f0 kernel/exit.c:871=0A=
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021=0A=
 get_signal+0x2311/0x25c0 kernel/signal.c:2874=0A=
 arch_do_signal_or_restart+0x79/0x5a0 arch/x86/kernel/signal.c:307=0A=
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]=0A=
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204=0A=
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310=0A=
 exc_page_fault+0xc4/0x180 arch/x86/mm/fault.c:1615=0A=
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570=0A=
RIP: 0033:0x7f4acfa8edd5=0A=
Code: Unable to access opcode bytes at 0x7f4acfa8edab.=0A=
RSP: 002b:00000000fffffe80 EFLAGS: 00010217=0A=
RAX: 0000000000000000 RBX: 00007f4acfbbbf80 RCX: 00007f4acfa8edcd=0A=
RDX: 0000000000000000 RSI: 00000000fffffe80 RDI: 0000000058208080=0A=
RBP: 00007f4acfafc59c R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000=0A=
R13: 00007ffe57fcc43f R14: 00007ffe57fcc5e0 R15: 00007f4ace9fdd80=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:jfs_evict_inode+0x3eb/0x4b0 fs/jfs/inode.c:169=0A=
Code: 7c 24 80 00 74 0d e8 a4 6c a9 fe 48 89 df e8 fc 5f 02 00 e8 97 6c a9 =
fe 48 89 df e8 af e4 28 ff e9 e3 fc ff ff e8 85 6c a9 fe <0f> 0b 48 c7 c7 2=
0 67 2c 8c e8 67 a5 f9 fe e9 44 fc ff ff e8 5d a5=0A=
RSP: 0018:ffffc9000b6578e8 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: ffff888076d0d770 RCX: 0000000000000000=0A=
RDX: ffff8880467cbb80 RSI: ffffffff82d81bab RDI: ffff888076d0d760=0A=
RBP: ffff888076d0d3f8 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888076d0d848=0A=
R13: ffff888076d0d798 R14: ffffffff8a084920 R15: ffff88807d8f8a00=0A=
FS:  0000000000000000(0000) GS:ffff888119c00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007ffc88d736c0 CR3: 000000007cee3000 CR4: 0000000000350ef0=0A=
