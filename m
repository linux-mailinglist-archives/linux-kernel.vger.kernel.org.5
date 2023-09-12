Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D843B79DC65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbjILXDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbjILXDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:03:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2094.outbound.protection.outlook.com [40.107.237.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE8D1711
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhxQQ2Vjc+2f79JpJs2kLHCDNhc3KSbyW2SX6ATZG+HBSFI3D8Q9r7Z09tdUF7FbemPh1QM6/se4mKUHaH4HP5xnxX+qr9Y1VjWEKrmFpGaSol1udOd3A72iSd9XsMfjXIcwV3QXYx7meezY4h8mRvpHDci/FjXfbRYJPDjJvaejI0TNhsdVD5WAX/HFq1Yn50PtwnSiLeC7hKI3wZyp1vHDFviqOme5TG/V2Nj1BII0Kx7IrzI0noUaZ/rNv0pVdNZkQKCDOIOXhfE/c4q5xgVz5LdhJ9D4l13q6TDJ8nSUSwl38oLl3NhAycfjZCfO0RIDX2IKTzVC8Htl/HOA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T++vSLzpU74V5eOD9fG7qLIyfHknflV1UfP2Bg3sjmM=;
 b=Mjog2qM5zZF5HzguPKj6uygiuIYF8tnSxsj4OEu5rz2QOCwttVp9LXdbtUqaVyHQvgm5gcfJHh3VB1uKoiexbqxMolXOvxE7uN/KiDrWQPX2dT2pt513z/7SFrTVbUrPOu6Zhya1Uw3eX52UsKT6clEpfbQN9wY/ZYwOyxgTOqy0ozNOJd01Z8YBQM6U0kK7Kbl1dGm3klVP/YvkSoEAGI9TPjG0qkjJG77/YpZ8r8TmRYtRny+J0WRP8lapcNC/+EY/lxxdeL8keQMBtW7iuyyV0phnVMAt0xDRBSkuMQSVhLqAIo+pNz1ypEXBQtOkzQ+7q96zas7+VmuW2i0/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T++vSLzpU74V5eOD9fG7qLIyfHknflV1UfP2Bg3sjmM=;
 b=Ra9J9Vp4fFy15TfPr0g2y6Vqv/oKrGDjSyu+opxdhErh83joxu5ZfD0ovB2tnjEATwlWAdvSpJmwm7FjsYD/RXdmlBRWC1sEvKNzVK95HRck6j21NmmY6Jw8Vkzv4GvTCph2DFhgR1xpAsaBLI8pu0t/EzCGXMrFcylclnLBBiA=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 23:02:56 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 23:02:56 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: BUG: soft lockup in smp_call_function
Thread-Topic: BUG: soft lockup in smp_call_function
Thread-Index: AQHZ4c/9IQOvFVS8NkCGmaw1dYR+Ww==
Date:   Tue, 12 Sep 2023 23:02:56 +0000
Message-ID: <BL0PR11MB310606A8674B391DEA659089E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|DS0PR11MB7531:EE_
x-ms-office365-filtering-correlation-id: 966be481-9834-4681-aef2-08dbb3e466ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gutdezd4miD5ooV9Q7MViyKANPLuhTfWIJMwx7GLkBt9Qf994ynqzRigHOuUSJNmoI4s7KezStEpYAXo3WPeGh6/+SCp4R2LT/2sdfYrIJ/9sV4gDhksfRZaysv08QbTAo8Ze3/antvhI2koX4x2Ho/manCoVO9bFaMDXN4FUlQw6O58/TwRXlPz4JFyNoKpSQJRYKEKDW7qmjpFX/bFVIaah6OEfli4SUqSaJFYwLMqYdGhSqw+Abb/IvTsz/px6k7xISlZY0lcKR6qjH5iGLJ60kNwzhv6xj3gf9os1NWFSJC1QBUhBo4rrhmXwj/FugiXrnREPjCv9TXBB52YYoDkJEaGganq+jyyRY3T2Lo6CQnOh/geysp7alVVelXm34CEnglHVHd0jVS5/tPZdw1Dv8vhiR2RV2nO6b7ojg5ovkEXb7qgSPXoISEuCZaqaaTShQirZ0nqVMtaxlDcihFgBTU9QnOoyJ8vWgQzGIZph7XpLDl0msDhtDAkIZkbbfV27ztOvhmUwG5a+L4Ih/kSwklZma2uP9+p2W/uYlYH51NjX/uSiFGvQ6Z6zdm+ge+eXrC3PN0h5CNnUGIgn6VfC3g4riTHrrVGuEhP4VvAxL6Fyuo+cvrvGAzRe8XntXZ6e4ejMV65OhqOCiQBnmDFx08JbCkPHExAMeziU8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(366004)(376002)(1800799009)(451199024)(186009)(122000001)(5930299018)(6506007)(7696005)(71200400001)(33656002)(75432002)(38070700005)(55016003)(38100700002)(478600001)(45954011)(83380400001)(26005)(45080400002)(52536014)(86362001)(2906002)(9686003)(41300700001)(64756008)(966005)(76116006)(8936002)(8676002)(5660300002)(4326008)(110136005)(54906003)(786003)(66946007)(66446008)(316002)(66476007)(66556008)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QLhsbvSr+avAPqRfQCJJV4wXczxHqGuePJwVjXWKVEFrSg4spf7TdQBYmd?=
 =?iso-8859-1?Q?37GJZUKxIVMgNPu6H9OdjlSBIeAAXq/677FBtG/LD6FdaeKkZUhLaqcEhA?=
 =?iso-8859-1?Q?LrosY1w1/EAwKhYRio75PQuhN8gkr9K32XCqUtf07qogm7DzukyiHLu+Dl?=
 =?iso-8859-1?Q?d065UjEr/xiwK8NinPaD3d1/ZlsXKESRJlBRTREzIJgmc7t5kuH21iGNQv?=
 =?iso-8859-1?Q?R0Fpf9DeKK4fAtjf1CpJjmCNQxAalHFPgRD2gJtuI6E7j3hoejZQKBK5Uf?=
 =?iso-8859-1?Q?wwvKtco5wClFP8qU6XST/GR5lzxbcuhOFSXoNhunFsct878Jr8i1Bm6qYv?=
 =?iso-8859-1?Q?rWc5FNJaRTmC85Xj1INUoEaK8Ldem4aY7d1xAH0tpHFfA5FNK7Jri8YnPR?=
 =?iso-8859-1?Q?ltPR7AMZ7hHcXM/u6/dOBdc9qZyzv+ULDhICGoB0BDL0jwwA7cf+sw0cAi?=
 =?iso-8859-1?Q?nQgfr0Es3XIc6TGYcoZijQz6Trc+EUF3ionLwHCU4glY1jC8sfc5InIM5k?=
 =?iso-8859-1?Q?C1ZiLXhncTgZBxfJR1b608nrB63BpD2qZZmXdRmWu9Ed4U6RMllHw15JZi?=
 =?iso-8859-1?Q?j0GfPZVaCugxeODAjs/spECIcCL4l6s4xvDDsXGMZ65rQcVHR5UfFAQLHi?=
 =?iso-8859-1?Q?+oFey4r/y0jlaE0hNFbIX9p1bY9ENF4XFJ0w7j6/AlGpQr2RooQqJF8/pN?=
 =?iso-8859-1?Q?8syk0hPOsdb2tw3QOCVPkaucQoF4D1R77XLO3eZ79iysNT/BpbIO98ICCV?=
 =?iso-8859-1?Q?6cqo/7IfyGdaU9PlnBqpOdGq3uEtt0TxTwZiUwgxGXVtQyZZSRJiapWZdt?=
 =?iso-8859-1?Q?NV6wbC79iJ8yY75fDZk21I/c5UWyIKvj7RSW55YWygMswcUpaMU+njXJZA?=
 =?iso-8859-1?Q?Uuw+iDoAj7QJZ0UIQacBgZa+6lsIsUTIYlrxECnaUlrbPzF5wCqLZIMVLT?=
 =?iso-8859-1?Q?1qxnIgigQeWywLYZGWPr74n7/CUaOMDXM6ET6f9HS0u8TcZDt2HJxj4WoU?=
 =?iso-8859-1?Q?LSQqTUrow5iz/46wf+JOpCV8YJPMjUYD1dg8UQZGnU8wpg0PTSzx0yvmyj?=
 =?iso-8859-1?Q?fkFx7dg38lxUFZ1gECWgxNwgWKUjhlfpL/Nmi9YbX4pCkZ8uNx/NhcXGt5?=
 =?iso-8859-1?Q?ZJVIDqWcos8r8iPWum+wP45SPIBjZQ7BYeedafVDi30yZp6pTGgacSA/z3?=
 =?iso-8859-1?Q?VERH9rlAN4+bN2i4O+16OZxdGjwRZ1VlVCLW2tY76IuCgIxnbIl71hmQL9?=
 =?iso-8859-1?Q?0ECMOJE1AKPhNOeHKAukJV1UgeAX4z2Fs1x/6Wo+zvhMrm04o5k6W/jN82?=
 =?iso-8859-1?Q?DWsqFv+P2f8qxNTj/U7WeiwAQJiCAveKtqMpoOkQqcfXk4xBKguXI+GUhz?=
 =?iso-8859-1?Q?mjB7fHW4VGajnRA/CzvY1oKKJrcuR41Aqe/7t8C6cF0mtjDawaa/pHKtTJ?=
 =?iso-8859-1?Q?LqQD1D06MCmNxwi6OMgJkvZYzpjqivW+siPIGUncf+Q9omBmodE/ByO59P?=
 =?iso-8859-1?Q?1eb0UzR7sUvor95PqqqX+kcSmJBvaKVUFCmVgj4DXlkSeIhwpSVqmbtzat?=
 =?iso-8859-1?Q?my2kVPdTfmXigGD8rfDgfXh7SJp8lvKphA7TmBoOcaC1KuwsIAEYhFFcGF?=
 =?iso-8859-1?Q?MlBT/6fGIGrbk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966be481-9834-4681-aef2-08dbb3e466ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 23:02:56.3827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syAprdQP5pjpUWh3Zc+ma8tcj3NGyytYWoQYP38+U24UJf8HQgqmpUQCmg3Gre/aseN4tShSk2iwmbuKgMKIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
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
Kernel Config: https://drive.google.com/file/d/1WSUEWrith9-539qo6xRqmwy4LfD=
tmKpp/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1pN6FfcjuUs6Wx94g1gufuYGjRbMMgi=
Z4/view?usp=3Dsharing=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
watchdog: BUG: soft lockup - CPU#5 stuck for 26s! [kworker/u16:1:12]=0A=
Modules linked in:=0A=
irq event stamp: 192794=0A=
hardirqs last  enabled at (192793): [<ffffffff89a0140a>] asm_sysvec_apic_ti=
mer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645=0A=
hardirqs last disabled at (192794): [<ffffffff89975d4f>] sysvec_apic_timer_=
interrupt+0xf/0xc0 arch/x86/kernel/apic/apic.c:1106=0A=
softirqs last  enabled at (187764): [<ffffffff814b94bd>] invoke_softirq ker=
nel/softirq.c:445 [inline]=0A=
softirqs last  enabled at (187764): [<ffffffff814b94bd>] __irq_exit_rcu+0x1=
1d/0x190 kernel/softirq.c:650=0A=
softirqs last disabled at (187671): [<ffffffff814b94bd>] invoke_softirq ker=
nel/softirq.c:445 [inline]=0A=
softirqs last disabled at (187671): [<ffffffff814b94bd>] __irq_exit_rcu+0x1=
1d/0x190 kernel/softirq.c:650=0A=
CPU: 5 PID: 12 Comm: kworker/u16:1 Not tainted 6.3.0-next-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Workqueue: events_unbound toggle_allocation_gate=0A=
RIP: 0010:csd_lock_wait kernel/smp.c:294 [inline]=0A=
RIP: 0010:smp_call_function_many_cond+0x5bd/0x1020 kernel/smp.c:828=0A=
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 =
c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 b5 07 0b 00 f3 90 <41> 0f b6 04 24 4=
0 38 c5 7c 08 84 c0 0f 85 46 08 00 00 8b 43 08 31=0A=
RSP: 0018:ffffc900000cf9e8 EFLAGS: 00000293=0A=
RAX: 0000000000000000 RBX: ffff888119cc4d80 RCX: 0000000000000000=0A=
RDX: ffff888100325940 RSI: ffffffff8176807b RDI: 0000000000000005=0A=
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: ffffed10233989b1=0A=
R13: 0000000000000001 R14: ffff888119cc4d88 R15: 0000000000000001=0A=
FS:  0000000000000000(0000) GS:ffff888119e80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 0000555556a6cc88 CR3: 000000000bb73000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:996=0A=
 on_each_cpu include/linux/smp.h:71 [inline]=0A=
 text_poke_sync arch/x86/kernel/alternative.c:1770 [inline]=0A=
 text_poke_bp_batch+0x237/0x770 arch/x86/kernel/alternative.c:1970=0A=
 text_poke_flush arch/x86/kernel/alternative.c:2161 [inline]=0A=
 text_poke_flush arch/x86/kernel/alternative.c:2158 [inline]=0A=
 text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2168=0A=
 arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146=
=0A=
 jump_label_update+0x321/0x400 kernel/jump_label.c:829=0A=
 static_key_enable_cpuslocked+0x1b5/0x270 kernel/jump_label.c:205=0A=
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218=0A=
 toggle_allocation_gate mm/kfence/core.c:831 [inline]=0A=
 toggle_allocation_gate+0xf4/0x220 mm/kfence/core.c:823=0A=
 process_one_work+0x993/0x15e0 kernel/workqueue.c:2405=0A=
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552=0A=
 kthread+0x33e/0x440 kernel/kthread.c:379=0A=
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308=0A=
 </TASK>=0A=
Sending NMI from CPU 5 to CPUs 0-4,6-7:=0A=
NMI backtrace for cpu 1=0A=
CPU: 1 PID: 20602 Comm: syz-executor.3 Not tainted 6.3.0-next-20230426 #1=
=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:hlock_class kernel/locking/lockdep.c:228 [inline]=0A=
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4747 [inline]=0A=
RIP: 0010:__lock_acquire+0x489/0x5d00 kernel/locking/lockdep.c:5024=0A=
Code: 41 81 e5 ff 1f 45 0f b7 ed be 08 00 00 00 4c 89 e8 48 c1 e8 06 48 8d =
3c c5 00 6b 2c 90 e8 5f 90 6e 00 4c 0f a3 2d d7 35 c9 0e <0f> 83 5c 0c 00 0=
0 4f 8d 6c 6d 00 49 c1 e5 06 49 81 c5 20 6f 2c 90=0A=
RSP: 0018:ffffc90002aa7350 EFLAGS: 00000047=0A=
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81633521=0A=
RDX: fffffbfff2058d62 RSI: 0000000000000008 RDI: ffffffff902c6b08=0A=
RBP: ffff888042995940 R08: 0000000000000000 R09: ffffffff902c6b0f=0A=
R10: fffffbfff2058d61 R11: 0000000000000001 R12: ffff888119e2b818=0A=
R13: 0000000000000063 R14: 0000000000000002 R15: ffff888042996598=0A=
FS:  00007fdaad065700(0000) GS:ffff888119c80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 0000001b30623000 CR3: 0000000101969000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 lock_acquire kernel/locking/lockdep.c:5691 [inline]=0A=
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656=0A=
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]=0A=
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162=0A=
 lock_hrtimer_base kernel/time/hrtimer.c:173 [inline]=0A=
 hrtimer_try_to_cancel kernel/time/hrtimer.c:1331 [inline]=0A=
 hrtimer_try_to_cancel+0xa9/0x2e0 kernel/time/hrtimer.c:1316=0A=
 hrtimer_cancel+0x17/0x40 kernel/time/hrtimer.c:1443=0A=
 __disable_vblank drivers/gpu/drm/drm_vblank.c:434 [inline]=0A=
 drm_vblank_disable_and_save+0x282/0x3d0 drivers/gpu/drm/drm_vblank.c:478=
=0A=
 drm_crtc_vblank_off+0x312/0x970 drivers/gpu/drm/drm_vblank.c:1366=0A=
 disable_outputs+0x7c7/0xbb0 drivers/gpu/drm/drm_atomic_helper.c:1202=0A=
 drm_atomic_helper_commit_modeset_disables+0x1d/0x40 drivers/gpu/drm/drm_at=
omic_helper.c:1397=0A=
 vkms_atomic_commit_tail+0x51/0x240 drivers/gpu/drm/vkms/vkms_drv.c:71=0A=
 commit_tail+0x288/0x420 drivers/gpu/drm/drm_atomic_helper.c:1812=0A=
 drm_atomic_helper_commit drivers/gpu/drm/drm_atomic_helper.c:2052 [inline]=
=0A=
 drm_atomic_helper_commit+0x306/0x390 drivers/gpu/drm/drm_atomic_helper.c:1=
985=0A=
 drm_atomic_commit+0x20a/0x2d0 drivers/gpu/drm/drm_atomic.c:1503=0A=
 drm_client_modeset_commit_atomic+0x698/0x7e0 drivers/gpu/drm/drm_client_mo=
deset.c:1045=0A=
 drm_client_modeset_dpms+0x174/0x200 drivers/gpu/drm/drm_client_modeset.c:1=
226=0A=
 drm_fb_helper_dpms drivers/gpu/drm/drm_fb_helper.c:323 [inline]=0A=
 drm_fb_helper_blank+0xd1/0x260 drivers/gpu/drm/drm_fb_helper.c:356=0A=
 fb_blank+0x105/0x190 drivers/video/fbdev/core/fbmem.c:1088=0A=
 do_fb_ioctl+0x390/0x760 drivers/video/fbdev/core/fbmem.c:1180=0A=
 fb_ioctl+0xeb/0x150 drivers/video/fbdev/core/fbmem.c:1204=0A=
 vfs_ioctl fs/ioctl.c:51 [inline]=0A=
 __do_sys_ioctl fs/ioctl.c:870 [inline]=0A=
 __se_sys_ioctl fs/ioctl.c:856 [inline]=0A=
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7fdaabe8edcd=0A=
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007fdaad064bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
RAX: ffffffffffffffda RBX: 00007fdaabfbbf80 RCX: 00007fdaabe8edcd=0A=
RDX: 0000000000000004 RSI: 0000000000004611 RDI: 0000000000000003=0A=
RBP: 00007fdaabefc59c R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007ffdadeffe9f R14: 00007ffdadf00040 R15: 00007fdaad064d80=0A=
 </TASK>=0A=
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/includ=
e/asm/irqflags.h:48 [inline]=0A=
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/=
asm/irqflags.h:86 [inline]=0A=
NMI backtrace for cpu 0 skipped: idling at default_idle+0xf/0x20 arch/x86/k=
ernel/process.c:729=0A=
NMI backtrace for cpu 3 skipped: idling at native_safe_halt arch/x86/includ=
e/asm/irqflags.h:48 [inline]=0A=
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt arch/x86/include/=
asm/irqflags.h:86 [inline]=0A=
NMI backtrace for cpu 3 skipped: idling at default_idle+0xf/0x20 arch/x86/k=
ernel/process.c:729=0A=
NMI backtrace for cpu 6 skipped: idling at native_safe_halt arch/x86/includ=
e/asm/irqflags.h:48 [inline]=0A=
NMI backtrace for cpu 6 skipped: idling at arch_safe_halt arch/x86/include/=
asm/irqflags.h:86 [inline]=0A=
NMI backtrace for cpu 6 skipped: idling at default_idle+0xf/0x20 arch/x86/k=
ernel/process.c:729=0A=
NMI backtrace for cpu 7 skipped: idling at native_safe_halt arch/x86/includ=
e/asm/irqflags.h:48 [inline]=0A=
NMI backtrace for cpu 7 skipped: idling at arch_safe_halt arch/x86/include/=
asm/irqflags.h:86 [inline]=0A=
NMI backtrace for cpu 7 skipped: idling at default_idle+0xf/0x20 arch/x86/k=
ernel/process.c:729=0A=
NMI backtrace for cpu 4=0A=
CPU: 4 PID: 20623 Comm: syz-executor.6 Not tainted 6.3.0-next-20230426 #1=
=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:kvm_wait+0xb7/0x110 arch/x86/kernel/kvm.c:1064=0A=
Code: 40 38 c6 74 1b 48 83 c4 10 c3 c3 e8 93 d3 50 00 eb 07 0f 00 2d 4a 04 =
92 08 fb f4 48 83 c4 10 c3 eb 07 0f 00 2d 3a 04 92 08 f4 <48> 83 c4 10 c3 8=
9 74 24 0c 48 89 3c 24 e8 d7 d4 50 00 8b 74 24 0c=0A=
RSP: 0018:ffffc90000300b50 EFLAGS: 00000046=0A=
RAX: 0000000000000003 RBX: 0000000000000000 RCX: dffffc0000000000=0A=
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff88810b0803d8=0A=
RBP: ffff88810b0803d8 R08: 0000000000000001 R09: ffff88810b0803d8=0A=
R10: ffffed102161007b R11: ffffc90000300ff8 R12: 0000000000000000=0A=
R13: ffffed102161007b R14: 0000000000000001 R15: ffff888119e3d3c0=0A=
FS:  0000000000000000(0000) GS:ffff888119e00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007f28183bd0b0 CR3: 000000000bb73000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <IRQ>=0A=
 pv_wait arch/x86/include/asm/paravirt.h:598 [inline]=0A=
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]=0A=
 __pv_queued_spin_lock_slowpath+0x8e4/0xb80 kernel/locking/qspinlock.c:511=
=0A=
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:586 [inline]=
=0A=
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]=0A=
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]=0A=
 do_raw_spin_lock+0x20d/0x2b0 kernel/locking/spinlock_debug.c:115=0A=
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]=0A=
 _raw_spin_lock_irqsave+0x45/0x60 kernel/locking/spinlock.c:162=0A=
 drm_handle_vblank+0x11e/0xb80 drivers/gpu/drm/drm_vblank.c:1986=0A=
 vkms_vblank_simulate+0xe8/0x3e0 drivers/gpu/drm/vkms/vkms_crtc.c:29=0A=
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]=0A=
 __hrtimer_run_queues+0x599/0xa30 kernel/time/hrtimer.c:1749=0A=
 hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1811=0A=
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1095 [inline]=0A=
 __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1112=
=0A=
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1106=0A=
 </IRQ>=0A=
 <TASK>=0A=
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:=
645=0A=
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]=0A=
RIP: 0010:__sanitizer_cov_trace_pc+0x11/0x70 kernel/kcov.c:207=0A=
Code: a8 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 =
66 90 f3 0f 1e fa 65 8b 05 0d 33 82 7e 89 c1 48 8b 34 24 <81> e1 00 01 00 0=
0 65 48 8b 14 25 40 bb 03 00 a9 00 01 ff 00 74 0e=0A=
RSP: 0018:ffffc90002be76d8 EFLAGS: 00000286=0A=
RAX: 0000000080000001 RBX: 0000000000000001 RCX: 0000000080000001=0A=
RDX: 00007f2817c77000 RSI: ffffffff81bcd756 RDI: ffffc90002be7ad8=0A=
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000001 R11: 0000000000000001 R12: ffffea00014fc480=0A=
R13: 0000000000000000 R14: dffffc0000000000 R15: 8000000053f12007=0A=
 zap_drop_file_uffd_wp mm/memory.c:1352 [inline]=0A=
 zap_install_uffd_wp_if_needed mm/memory.c:1371 [inline]=0A=
 zap_pte_range mm/memory.c:1417 [inline]=0A=
 zap_pmd_range mm/memory.c:1564 [inline]=0A=
 zap_pud_range mm/memory.c:1593 [inline]=0A=
 zap_p4d_range mm/memory.c:1614 [inline]=0A=
 unmap_page_range+0x1046/0x4470 mm/memory.c:1635=0A=
 unmap_single_vma+0x19a/0x2b0 mm/memory.c:1681=0A=
 unmap_vmas+0x234/0x380 mm/memory.c:1720=0A=
 exit_mmap+0x190/0x930 mm/mmap.c:3111=0A=
 __mmput+0x128/0x4c0 kernel/fork.c:1351=0A=
 mmput+0x60/0x70 kernel/fork.c:1373=0A=
 exit_mm kernel/exit.c:564 [inline]=0A=
 do_exit+0x9d1/0x29f0 kernel/exit.c:858=0A=
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021=0A=
 get_signal+0x2311/0x25c0 kernel/signal.c:2874=0A=
 arch_do_signal_or_restart+0x79/0x5a0 arch/x86/kernel/signal.c:307=0A=
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]=0A=
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204=0A=
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]=0A=
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297=0A=
 do_syscall_64+0x46/0x80 arch/x86/entry/common.c:86=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7f281828edcd=0A=
Code: Unable to access opcode bytes at 0x7f281828eda3.=0A=
RSP: 002b:00007f28194c0c98 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca=0A=
RAX: fffffffffffffe00 RBX: 00007f28183bbf80 RCX: 00007f281828edcd=0A=
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f28183bbf88=0A=
RBP: 00007f28183bbf88 R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f28183bbf8c=0A=
R13: 00007ffd5038e1ef R14: 00007ffd5038e390 R15: 00007f28194c0d80=0A=
 </TASK>=0A=
NMI backtrace for cpu 2 skipped: idling at native_safe_halt arch/x86/includ=
e/asm/irqflags.h:48 [inline]=0A=
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt arch/x86/include/=
asm/irqflags.h:86 [inline]=0A=
NMI backtrace for cpu 2 skipped: idling at default_idle+0xf/0x20 arch/x86/k=
ernel/process.c:729=0A=
