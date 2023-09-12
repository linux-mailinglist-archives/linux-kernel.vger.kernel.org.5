Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B7079DC67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjILXD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbjILXDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:03:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2135.outbound.protection.outlook.com [40.107.237.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB51993;
        Tue, 12 Sep 2023 16:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnoBlqH/RpS/qC7eihpwdhIiDuK3eV6/PQ5AFF3y8ghKZzyX9lho2yu1sNsO2rpvfe57Ch5MLiWlYyHGAdvWSkXzwCoP8Q87dlr3XK7WISxBJ3yMU6WGGIOQrUVADO6VlnKDLnydbyxHqYNISXnHRi+KtLBDFZeZn+NHb82pHOoJ6+H0tmgacC5YVyF1HhHxiYx/c+9d8mbzdkoy2uukxcLPWI4mIhVjw5H0Cx2mjFVPnPTiAVbTy6fjga1ehxGVK6dSoodUgqcsZQr0dMGFi0sGcm3KItxKQhMBq1l8s3kWsTG2tokGJ+yTnpjErYGeO1gni0KATQu9v35WN8VpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns6iwinqmcqsbuVvvYCTz5sUJc3cTjXYSJHp2FvkPm8=;
 b=jTCA8kPAX+yNFSlCcBuwxoseOFS6ssIZ446/fESiztbmK73/HobX54hruo89OqXOp9FN5prekuQjtbRgocBzoFwljqWJkRX91oXcnBfhpfNNRP7DcKMnKRg4KJeyCWdgIvFT7BXnJJHlNWFupGGt8oo0oTDHx2uRpM2kxG2fOep73HiTscPqCXaJ0Bew0zRnSmSCyxZwJ48CR2N1JOWNN06z33GsDmZry+UFmBjU/q4NYMpXrjUFEV6b15Ab6KfUZr625QwXTZVkVfS8IKOZWktkPkV11mv7xn+70N1ejEnU4lEtHc4DRZqa0OgJ3Vd8+WFtSY1KOCYw680bkO5B3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns6iwinqmcqsbuVvvYCTz5sUJc3cTjXYSJHp2FvkPm8=;
 b=BxV2AFH44ExydsJQTMqgd19LueQt6KX07fssj5CM10XMDvikVtgAQ+fKuOFx+atqMt490D+Jc2JqpIoXj5G4GrFa4BEsM3+FtVpAmz+opVUspl+WZDHxj3r/DRVg2JsniFSONT1xF52zS1BBlox+/J/5mrsq+J1NCROo3oBJXOU=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 23:03:02 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 23:03:02 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "efremov@linux.com" <efremov@linux.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: general protection fault in reset_interrupt
Thread-Topic: general protection fault in reset_interrupt
Thread-Index: AQHZ4dBVFoFH13xMjUOAK05VtE1J+A==
Date:   Tue, 12 Sep 2023 23:03:02 +0000
Message-ID: <BL0PR11MB31064006356930AAD778ACCAE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|DS0PR11MB7531:EE_
x-ms-office365-filtering-correlation-id: c36775f0-bfc7-4a12-03b7-08dbb3e46a5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VDWBYjSe1K70MIkXkBjaEDxzQAHvRdVCBKCaNYhbhMkPqA6lYx0Iuz2nSTSF1U6uD6SA4lvgpl6hZEYtd79GwlV8EJhW2/M3vZw8F09Dg3aW3qsDm21Quk+B8N0vvUhqoENxcrCihx0syZUpWJ2rFA9XQA7C3I3w7qhqp/6HTzG9PR+FX9aosp5+O8AHGps54NlDo1SxEuPHf5dwlpcM8o6Y50X+pAzLi2XiB+OgJmLcn8cMeJOGBzS4GUii659eDg+7xl+1DsfQpLIwVY5v9ib/25m23KlMax/AcHBDtx7dla7IYXd7qk9wI3yXTXdZKRqYiG1LorrOqmtlPZ5opArhN1ulSMoaFQx1Ax/Zbhf1vKjXiK0YnBdWI6qzdSrrFisSwg63JMNugSd89Z0zQFG0ozCkNcZFf5F7kiY+kNhG5zJQahyvTKnimwNvCG0ykB3JnGm7Inrzp9OqdnNUziyxNcHXAXnbJu9Li4Dg/SgDsBZsHIMVLvBp/vzAf/7dWiN6iTe49lDg4/3kdK71fDx68yY7KxWmw4/SVJ8CnvWOeZSFSabipC1/bd09T3tGizSXIiXAXsAP6WnE/m/V1EAzUhKQ5wCVyzgg7dXn+LPbSZwfdqEdP+ay2rZ3uYoRgnqwHsAtsGKDx1exxOpFzmpAEzSrEb/b7qmm+7UG3o4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(366004)(376002)(1800799009)(451199024)(186009)(122000001)(5930299018)(6506007)(7696005)(71200400001)(33656002)(75432002)(38070700005)(55016003)(38100700002)(478600001)(83380400001)(26005)(45080400002)(52536014)(86362001)(2906002)(9686003)(41300700001)(64756008)(966005)(76116006)(8936002)(8676002)(5660300002)(4326008)(110136005)(54906003)(786003)(66946007)(66446008)(316002)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bf6B70mgoZWmJ51vu5s8VPsqxEa15611N+LIKfsHQTkdD6JgeEOq+LSbsS?=
 =?iso-8859-1?Q?x2I7wkke1xklS/FKFxeUXkDetodD1gqFVvAy20VEaWTgap2GeB/Oqu6752?=
 =?iso-8859-1?Q?NoJ1B4fFxjEDimLft5lav0dPFsTMCLZXIHGtoR+96cm2s84n+OZOphk/pD?=
 =?iso-8859-1?Q?m++fG42AvX95DDAPrHEjOiUZPKkOOWUwK5DCuuRgybd6EvPhRyERA5fqtq?=
 =?iso-8859-1?Q?g2GYVGnuq2sDU+P/4IQqzcESVztgvp6vLKE54hSVrnX+4VycJjBWys4l47?=
 =?iso-8859-1?Q?Q+91hxlzTCTr+xyuVxuvPG0/7/D9HwMzg13/TZ2lWFCSH6obZ95fqbD/Fs?=
 =?iso-8859-1?Q?/vs5Rkz5zQM8RL+7Y/6KLO2reWC4Fj6LLar9phyvsk++kFj04lcY8Qa6dZ?=
 =?iso-8859-1?Q?KP+CHQ+eHw33dj/ZzDZKHhPEtKlxWk2pPjf/jLZB+EIUTgVfLf9IkfiZ2j?=
 =?iso-8859-1?Q?egGIMnX4oUtQ4/zbCjMTr8t01vr0xxzC43B5meu0pnlYZOi2XX6wW6JeEP?=
 =?iso-8859-1?Q?yavkrLYRbLb0nsfCAA2KsW4lG1cR6BmvlXSkM9ll99+X1JySbDPF9PAkEq?=
 =?iso-8859-1?Q?6/QgVP8W+BLeGCo1y8LoqYvCEBuSlGGX3cCpDECdHI9gOHBJKuPm792mJn?=
 =?iso-8859-1?Q?uVRUL1HqT3ZBq5SzIk4TkDo81xfgKD7MSl8sJpbN9bylJrcGTlp9hP13Kd?=
 =?iso-8859-1?Q?8wOGzfgfRJ84gyAOs6povRInmIFXEb6mY7cJJUTjK/EA21EhRwXF2zDMJz?=
 =?iso-8859-1?Q?rYJTRzSFa50tpMIR4MNAZ9SKPrxObCh0WseyJ2rnxCz/hHZpZe+m9Fzyut?=
 =?iso-8859-1?Q?Ubhb5eh5WPF83f1nnP3hGTqxkxASRok2FIiYOMt7KvVif+ihjMhwvHQdip?=
 =?iso-8859-1?Q?1BQIBEoCV1WGqDpCKlsy0GmYHUpbYMDU3T4BPybxZgFtwLUgznV6BU0HbD?=
 =?iso-8859-1?Q?1vCD3Go3YW3VAeXg2t1MucVcwFdOR5XDQQCoNK7qUb+JK71kj2vMOAFxof?=
 =?iso-8859-1?Q?o4rAAvADqwlxO7KcP2zaJuJCjpbroN0CrD6bXrIUWF9CFVe7S6m6Vr+dY1?=
 =?iso-8859-1?Q?yacpwuZqoUAZZB24hzGuX1Q53ceV0fNhZLdCRPHKGC2DDoLH3qpV4Vc4zR?=
 =?iso-8859-1?Q?Pg1CNV2uOGZI1f2KrBhjqok0WtTjb4pJlWuJQQxPil9nhFLDPIr1qdn21u?=
 =?iso-8859-1?Q?oWcUfTQb6dLi24XM7A9reJXizl1Rsp/GFn/n8wNHJWwdskXTIux9+pcuwY?=
 =?iso-8859-1?Q?BqTjXhYUsD2YCfZheH3+itYjewakJPtsh2/Na9g5UvfXA9W0RXIWJzglnG?=
 =?iso-8859-1?Q?J9duhhLs13+rMy21RsBbKjyVu6nCb6EDZeDaKPN4f9rXDwWxaicCodwWFO?=
 =?iso-8859-1?Q?AxUD0CiELcWoNgjtZHj7gxHtcnkfT6iKwdM3KEowZtA1x1INbAsyCelWIw?=
 =?iso-8859-1?Q?j4r5h1vrcX3T3RK+ZvJz9OUD/BylEK6Y/nHQy1eCWEUwybeIIrvDFfvStt?=
 =?iso-8859-1?Q?vvi5GxVc3qxuDuH07m2UDS/ABESPNt8Z4RUSABhpCqsnV/9I4n5kfVbuk9?=
 =?iso-8859-1?Q?Z+rwuxxh/wj27ytdbjRfaw7RXN0vKlPWYenE1v8Bi33GxxAo4+xXhMRUoP?=
 =?iso-8859-1?Q?MT0SdVVCBQk8M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36775f0-bfc7-4a12-03b7-08dbb3e46a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 23:03:02.1394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Gy1Uua2avZSzjy6sSm01BCP/HubvwDnjOXKEKMzr2z71Rn+r8F4hk8rYJNuDv8JtRF2+r4xiDLlxmq5olkYsQ==
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
Kernel Config: https://drive.google.com/file/d/1KvqI7fZne2h3Kd3DpmOLyPGpSEd=
UBc2E/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1jzcFNmZ3cprWLTyPYdUhI6rXHT4DuP=
-3/view?usp=3Dsharing=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
cont=3D00000000cd5131b6=0A=
current_req=3D0000000000000000=0A=
command_status=3D-1=0A=
floppy0: floppy timeout called=0A=
floppy0: floppy_shutdown: timeout handler died.  =0A=
general protection fault, probably for non-canonical address 0xdffffc000000=
0001: 0000 [#1] PREEMPT SMP KASAN=0A=
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]=0A=
CPU: 1 PID: 24572 Comm: kworker/u16:64 Not tainted 6.3.0-next-20230426 #1=
=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Workqueue: floppy floppy_work_workfn=0A=
RIP: 0010:reset_interrupt+0xf7/0x230 drivers/block/floppy.c:1792=0A=
Code: fc 84 db 0f 85 83 00 00 00 e8 45 9a cc fc 48 8b 1d ae 3c fa 0b 48 b8 =
00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 8=
5 f9 00 00 00 48 8b 43 08 5b ff e0 e8 13 9a cc fc=0A=
RSP: 0018:ffffc9000883fd10 EFLAGS: 00010212=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000=0A=
RDX: 0000000000000001 RSI: ffffffff84b4edeb RDI: 0000000000000008=0A=
RBP: ffffffff8c927000 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000400=0A=
R13: ffffc9000883fdb0 R14: ffff88810ef3f800 R15: ffff888100089000=0A=
FS:  0000000000000000(0000) GS:ffff888119c80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fb088bbc000 CR3: 000000010d7fe000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 process_one_work+0x993/0x15e0 kernel/workqueue.c:2405=0A=
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552=0A=
 kthread+0x33e/0x440 kernel/kthread.c:379=0A=
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:reset_interrupt+0xf7/0x230 drivers/block/floppy.c:1792=0A=
Code: fc 84 db 0f 85 83 00 00 00 e8 45 9a cc fc 48 8b 1d ae 3c fa 0b 48 b8 =
00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 8=
5 f9 00 00 00 48 8b 43 08 5b ff e0 e8 13 9a cc fc=0A=
RSP: 0018:ffffc9000883fd10 EFLAGS: 00010212=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000=0A=
RDX: 0000000000000001 RSI: ffffffff84b4edeb RDI: 0000000000000008=0A=
RBP: ffffffff8c927000 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000400=0A=
R13: ffffc9000883fdb0 R14: ffff88810ef3f800 R15: ffff888100089000=0A=
FS:  0000000000000000(0000) GS:ffff888119c80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fb088bbc000 CR3: 000000010d7fe000 CR4: 0000000000350ee0=0A=
----------------=0A=
Code disassembly (best guess):=0A=
   0:   fc                      cld=0A=
   1:   84 db                   test   %bl,%bl=0A=
   3:   0f 85 83 00 00 00       jne    0x8c=0A=
   9:   e8 45 9a cc fc          call   0xfccc9a53=0A=
   e:   48 8b 1d ae 3c fa 0b    mov    0xbfa3cae(%rip),%rbx        # 0xbfa3=
cc3=0A=
  15:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax=0A=
  1c:   fc ff df=0A=
  1f:   48 8d 7b 08             lea    0x8(%rbx),%rdi=0A=
  23:   48 89 fa                mov    %rdi,%rdx=0A=
  26:   48 c1 ea 03             shr    $0x3,%rdx=0A=
* 2a:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping inst=
ruction=0A=
  2e:   0f 85 f9 00 00 00       jne    0x12d=0A=
  34:   48 8b 43 08             mov    0x8(%rbx),%rax=0A=
  38:   5b                      pop    %rbx=0A=
  39:   ff e0                   jmp    *%rax=0A=
  3b:   e8 13 9a cc fc          call   0xfccc9a53=0A=
