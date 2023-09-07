Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA09797DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbjIGVVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjIGVVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:21:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2121.outbound.protection.outlook.com [40.107.237.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF951FC6;
        Thu,  7 Sep 2023 14:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8I8Qk8DFXIJxLKEYHg9RAlt3APbznnsSaOZo/eTHsLB0/AnWlCrus3MQsCaG3RioxesdzVL9pwcm/nt47GExN26xz/35lNl230h0v7zea01jkAesrhcsfcpWOc332NDOKgubqHDqjQivhWJgH4UImTYre99/BZWfL3ukzo5vCHMIKWdrJI3/AZIKzLbKnZU9cGpXcv/OB3J4kkEtbLUKbQEe0YNONSp5y/5MURmqAiRoHz1rQOOWro+0ie5KR27aMBpAWMDIxmrTS5KQKT2R/ui5nG91CdV8kr4+PCBcIy/bchTKBsVF6STYf5lDq75FXTNkdKxF3jQp04A73WCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=911DNzM5uLWYKaJtUSrzEGKC1+YT22WzLdu/2lCBleQ=;
 b=iz5VHjXO9NlVhHl5iCDgWJ3l8AAQ781wcckZC8jxcBJAnq6GjCTqx4+N0zCQTk0dCgjVbRJ6pYh8/hqBih2+4pCMLy5zDRzuHfG/pc2m2bJTmezHof0QGg25rOzO0ZJzC+/0iHPm5DTkGVg7K3GEQ2aLb+B3Pee4vA37zhNYDwLsqQ4dJi+arbGsYOhEYnWdNt3wRp2UOz2qEtaEEmK93S58m+O5Xw2kBnDa/tJ7CeT96Y4QbMrGUI0NUp4w/gpfDQE8ursAHYuW8LylFCbwkXhIV+O9Vxq8LQgvepeTgddxkDg+9q8KGu1i0AIzJY5wZlfxkTTLvK7+WFklgeAuIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=911DNzM5uLWYKaJtUSrzEGKC1+YT22WzLdu/2lCBleQ=;
 b=XnLAOY+95l/gwwiXixLB2RTOSsz9T8ToL/Pu2uZ4vBsvA++FbkEVDtebQxvoZn/zQ4rttIzJqHi6st6LsvAKK4eAqiDy4E1fpoRlvoYQuRjTIv4v06DnAwsqD0Gtnhzpw4IKKhbA17QoYmtHY5URYgtdKYPjv2LfCLbZ0w8Czkw=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 21:21:32 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::c89f:4b16:5fd5:11bb]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::c89f:4b16:5fd5:11bb%7]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 21:21:32 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: KASAN: slab-use-after-free Write in sco_sock_timeout
Thread-Topic: KASAN: slab-use-after-free Write in sco_sock_timeout
Thread-Index: AQHZ4cqv3/m4OMjg/k6ruZ/VN+OO9w==
Date:   Thu, 7 Sep 2023 21:21:32 +0000
Message-ID: <BL0PR11MB310671097F01D8AF2EA0DB0BE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|LV8PR11MB8558:EE_
x-ms-office365-filtering-correlation-id: 074eac3b-aef1-4476-f6fd-08dbafe868c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKDx0D2PbatpFIHrfO9RJtxrga7r/bOPRNczeOEieP2tcTXFBQTPILy5Zw8EA/nfGcEXvbS9Hp0bj0AXa2ORe84AoOv6w0qZckNJDTolRz0zj8Bhp4QphTDg9iyzTlKpIcuJMn7sCu2WomZo0WuloKIs5LQBeYkjST09d4UyLkVhIYPmb5CwwZjsVPcUw6vo99YiqVooXXEsS5BEG71wgWn25ybtU7r39NRgjHpX6znnUqmzzmlcCquVAPJBAki2MOHNvceWD0GHDCC7yDf8o+W4IV2y+lLmt01AJhxByZW/ewFmXiUgbbYeZh4SmGZB6jwOvAo+lJcWQObWz+UMI+blqegP4fcCUie5pZ1QseTItcYP399ub46TmI9wSimzgdcoUL+oOC/NI8tApN4Dr3HKSLd6pECKdlVJGiOpyqQs1/8mSouriC74d02eJ4evNPGeYgjm8RPBs1kA+rZMmK323mxtpI/W7mtW40a8tBL0o8Vtan76ur07Gey2HVkc18U7Fag+Rw4QwtWaQt66124FoX1R8ClezXayyha9PONCKYLHOFTcvaWuItCUJePJt3IBCgpsdOrFgRm4LxHkBjSBD270efSFIwxKpgJvcqdvw1ieH6AibU35TJhqVlDExgsagaBOQupluXLaLjA8FyzTZ877UpX94sbghce4q6Fe99MJb7T5gRZKbFZHx3MZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199024)(186009)(1800799009)(91956017)(76116006)(66556008)(66946007)(66446008)(66476007)(64756008)(4326008)(5930299018)(5660300002)(52536014)(316002)(786003)(54906003)(7696005)(8676002)(41300700001)(8936002)(75432002)(9686003)(6506007)(83380400001)(110136005)(26005)(71200400001)(55016003)(966005)(45080400002)(478600001)(7416002)(2906002)(921005)(86362001)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FMueV/DDM2cIHGqSwW20H/9mvHk7UtjC3hXweAkSsDN9x7VpstR+bu9GfN?=
 =?iso-8859-1?Q?bGLBAhFi7zi4d1ZrYl1K7Xf0Gy1wJKedHo3xKnZQ5ba8fkYVg4+ncFNvK4?=
 =?iso-8859-1?Q?0VIvD/wfa9igszwewjchTBoDSNAIy7rliVVy+gLFThfkmYWBk/fQID+etH?=
 =?iso-8859-1?Q?nmfIZBNgUbhu5Xufc2yrG6YzVwu8OOa5Vl6hXia4EEIWlOBXHXmsabj+OV?=
 =?iso-8859-1?Q?0UXirUMFrD4FgJdPnjVht5vlER6TuZYBqDQWCdPWbsxk1jbvEFBTBIrdKI?=
 =?iso-8859-1?Q?c8fOltkBhDp0FixoZ9HSpszGzx7VaCRpCHjSaQC2sOVnvVATkfhw4LKp7N?=
 =?iso-8859-1?Q?LrMMnUA31wV9IprgcbGB9p9G6LNgc6i9yTVxtPIrb9GVaAqTwmFitsvFEK?=
 =?iso-8859-1?Q?JMzg72p/VtTYTodmKRnfhLPzektaft+vooo7BApxU5kIRSeP7/TUnGtaWX?=
 =?iso-8859-1?Q?x7cslkFtMqKZb9PBedDEf9ZD9r9WmctvEFVDCVDcgFlLtJ10OeuhKDk7ls?=
 =?iso-8859-1?Q?81ORfxHSPipoLXMl4QUppZnWILs8eGo1IEfn3KNFwZUFg61Tb2PfSKY9Wq?=
 =?iso-8859-1?Q?B3oCANceGJxjY26IvEnnlHAWFui1yMJIdkJDI9IsZepGZ+LaeskfqHX95l?=
 =?iso-8859-1?Q?sH1MkfxTsXaDH9JAu5YEqTXeDq7Drvfb8KgfwtN//+N7YkWKVxSgEt5jIN?=
 =?iso-8859-1?Q?jSZ4PXUrxUn9sPNhfXjN0cT4Qt43QkSWc7FHxEZZI8DJmredifi2uARC5J?=
 =?iso-8859-1?Q?sLqTNfP9i+H5ldlDQIFlXpfkFoNeIe2lrXR8RxRK0+G0XAJ0SFNl6k8kjs?=
 =?iso-8859-1?Q?4zoWPLNOOIlSxbbThrPwd/5/XQ98cMXYPeAo+F0jQ7LthFOf4ppG0oO1d6?=
 =?iso-8859-1?Q?vA7FLNkBNpVSUcqJ2hO2KilVxMTjn6YMnfegww0ncA3ari5ww4+0SHKeHe?=
 =?iso-8859-1?Q?6bUhr03pNRY8B9Kov/eEnBGPQkXDleJMGfAr0ELWHFB3lOnzk4lhpJVCf9?=
 =?iso-8859-1?Q?+WaFRMCwBRLhXn2wM08TImbX1xJYpV7zUzAUK4Eo1LnA6ltfSi/2ZRQ0ro?=
 =?iso-8859-1?Q?qRqhAIb7/Aay8KVpgHhqYCKi8dLHbVyAp9Cn2QpPwkzNOU2RyRRs5ywmf9?=
 =?iso-8859-1?Q?EBTq3LXQagR65aajttmN4TxhZrEvJK8OD1pZBSaB1++kPmaQq/s425P1Ap?=
 =?iso-8859-1?Q?ZCzpalOmgjD3DrSi+YtzA+MW0wfM6vAIB150wdL4oOU47WVYkyqSvqdYuU?=
 =?iso-8859-1?Q?7Ti0b+/s+iWoPZezkmDClPtdptvF5jBijIJDD/gqxMjQiqACoyzhKYbhtU?=
 =?iso-8859-1?Q?lDJ4w+o6/CGOgTKdp4BTC0c66PqI1z5vagvBIY2I25yczABFuBkPYbfc4+?=
 =?iso-8859-1?Q?7lNxnK60vJk5EbutVTHms1l/OcH4ceMFLYxfBJwYENIcJhrLluggptpK8Z?=
 =?iso-8859-1?Q?qsrTHwYFDCgA3j6lqjJ4zRdsYLRzXMY+FvStne8YtHkw5/dxDbHRRN8sbB?=
 =?iso-8859-1?Q?E1kIfRuJb61ozcM9BEgpwvqDjyUJKTZz4XVIQLH+IdKI9u/KCZIQwsOzjB?=
 =?iso-8859-1?Q?/HGqeOsKUapeyjYykCPLbZwZk3pOOXl6aIvkV0YiZVu7zIPyFGQe553W14?=
 =?iso-8859-1?Q?aZWqPsBirSsrI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074eac3b-aef1-4476-f6fd-08dbafe868c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 21:21:32.7924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5HpjcccTwhzBZcJqVkCIKbaobVofFAr5SNxQKPrwpp7wNEex+mAxZl/s52PWeffdBB2PWyd7iUryBTZphhZPA==
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
Kernel Config: https://drive.google.com/file/d/1hdxgrCVVhxsp3XFWi046VSKx14Y=
-QCR7/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1Pm-DN-CF7AeFnocccO1lg8Qa5JIkeC=
aA/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: slab-use-after-free in sco_sock_timeout+0x6e/0x240=0A=
Write of size 4 at addr ffff88801df87080 by task kworker/4:8/14653=0A=
=0A=
CPU: 4 PID: 14653 Comm: kworker/4:8 Not tainted 6.3.0-next-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Workqueue: events sco_sock_timeout=0A=
Call Trace:=0A=
 <TASK>=0A=
 dump_stack_lvl+0x17f/0x260=0A=
 print_report+0xc5/0x5e0=0A=
 kasan_report+0xd7/0x110=0A=
 kasan_check_range+0x153/0x1a0=0A=
 __kasan_check_write+0x18/0x20=0A=
 sco_sock_timeout+0x6e/0x240=0A=
 process_one_work+0x9f0/0x16c0=0A=
 worker_thread+0x68e/0x10f0=0A=
 kthread+0x356/0x460=0A=
 ret_from_fork+0x1f/0x30=0A=
 </TASK>=0A=
=0A=
Allocated by task 10149:=0A=
 kasan_save_stack+0x2a/0x50=0A=
 kasan_set_track+0x29/0x40=0A=
 kasan_save_alloc_info+0x1f/0x30=0A=
 __kasan_kmalloc+0x84/0x90=0A=
 __kmalloc+0x61/0x190=0A=
 sk_prot_alloc+0x163/0x2b0=0A=
 sk_alloc+0x3d/0x7c0=0A=
 sco_sock_alloc.constprop.0+0x37/0x330=0A=
 sco_sock_create+0xd5/0x160=0A=
 bt_sock_create+0x16d/0x2d0=0A=
 __sock_create+0x354/0x7e0=0A=
 __sys_socket+0x152/0x270=0A=
 __x64_sys_socket+0x76/0xb0=0A=
 do_syscall_64+0x39/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
=0A=
Last potentially related work creation:=0A=
 kasan_save_stack+0x2a/0x50=0A=
 __kasan_record_aux_stack+0x66/0x70=0A=
 kasan_record_aux_stack_noalloc+0xf/0x20=0A=
 __call_rcu_common.constprop.0+0x9e/0x820=0A=
 call_rcu+0xd/0x10=0A=
 netlink_release+0xcd0/0x1e90=0A=
 __sock_release+0xce/0x290=0A=
 sock_close+0x22/0x30=0A=
 __fput+0x279/0xa40=0A=
 ____fput+0x1a/0x20=0A=
 task_work_run+0x196/0x2b0=0A=
 do_exit+0xbf6/0x2d00=0A=
 do_group_exit+0xe0/0x2c0=0A=
 get_signal+0x2562/0x2610=0A=
 arch_do_signal_or_restart+0x84/0x600=0A=
 exit_to_user_mode_prepare+0x130/0x1f0=0A=
 syscall_exit_to_user_mode+0x1f/0x50=0A=
 do_syscall_64+0x46/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
=0A=
Second to last potentially related work creation:=0A=
 kasan_save_stack+0x2a/0x50=0A=
 __kasan_record_aux_stack+0x66/0x70=0A=
 kasan_record_aux_stack_noalloc+0xf/0x20=0A=
 __call_rcu_common.constprop.0+0x9e/0x820=0A=
 call_rcu+0xd/0x10=0A=
 netlink_release+0xcd0/0x1e90=0A=
 __sock_release+0xce/0x290=0A=
 sock_close+0x22/0x30=0A=
 __fput+0x279/0xa40=0A=
 ____fput+0x1a/0x20=0A=
 task_work_run+0x196/0x2b0=0A=
 exit_to_user_mode_prepare+0x1e3/0x1f0=0A=
 syscall_exit_to_user_mode+0x1f/0x50=0A=
 do_syscall_64+0x46/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
=0A=
The buggy address belongs to the object at ffff88801df87000=0A=
 which belongs to the cache kmalloc-2k of size 2048=0A=
The buggy address is located 128 bytes inside of=0A=
 freed 2048-byte region [ffff88801df87000, ffff88801df87800)=0A=
=0A=
The buggy address belongs to the physical page:=0A=
page:00000000f6d79403 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x1df87=0A=
flags: 0xfffe0000000200(slab|node=3D0|zone=3D1|lastcpupid=3D0x3fff)=0A=
page_type: 0x1()=0A=
raw: 00fffe0000000200 ffff888100040800 ffffea000127c210 ffffea00045ad310=0A=
raw: 0000000000000000 ffff88801df87000 0000000100000001 0000000000000000=0A=
page dumped because: kasan: bad access detected=0A=
=0A=
Memory state around the buggy address:=0A=
 ffff88801df86f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc=0A=
 ffff88801df87000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
>ffff88801df87080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
                   ^=0A=
 ffff88801df87100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
 ffff88801df87180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
------------[ cut here ]------------=0A=
refcount_t: addition on 0; use-after-free.=0A=
WARNING: CPU: 4 PID: 14653 at lib/refcount.c:25 refcount_warn_saturate+0x18=
5/0x200=0A=
Modules linked in:=0A=
CPU: 4 PID: 14653 Comm: kworker/4:8 Tainted: G    B              6.3.0-next=
-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Workqueue: events sco_sock_timeout=0A=
RIP: 0010:refcount_warn_saturate+0x185/0x200=0A=
Code: 07 31 ff 89 de e8 6b 98 92 fd 84 db 0f 85 2b ff ff ff e8 9e 9c 92 fd =
48 c7 c7 40 73 7b 89 c6 05 b6 95 eb 07 01 e8 4b 1c 5b fd <0f> 0b e9 0c ff f=
f ff e8 7f 9c 92 fd 0f b6 1d a0 95 eb 07 31 ff 89=0A=
RSP: 0018:ffffc90009e97cb8 EFLAGS: 00010292=0A=
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000=0A=
RDX: ffff8880465de1c0 RSI: ffffffff814f0e8b RDI: ffffffff814f0e7e=0A=
RBP: ffffc90009e97cc8 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 00000000000c2550 R12: ffff88801df87080=0A=
R13: ffff888044fddc08 R14: ffff88801df87080 R15: ffff88811a43d100=0A=
FS:  0000000000000000(0000) GS:ffff88811a400000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 0000000000000000 CR3: 000000000ab45000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 sco_sock_timeout+0x1e1/0x240=0A=
 process_one_work+0x9f0/0x16c0=0A=
 worker_thread+0x68e/0x10f0=0A=
 kthread+0x356/0x460=0A=
 ret_from_fork+0x1f/0x30=0A=
 </TASK>=0A=
irq event stamp: 821585=0A=
hardirqs last  enabled at (821585): [<ffffffff88f8f95e>] irqentry_exit+0x3e=
/0x90=0A=
hardirqs last disabled at (821584): [<ffffffff88f8e534>] sysvec_apic_timer_=
interrupt+0x14/0xc0=0A=
softirqs last  enabled at (821420): [<ffffffff8554fefd>] wg_packet_tx_worke=
r+0x33d/0x780=0A=
softirqs last disabled at (821416): [<ffffffff8554fdf5>] wg_packet_tx_worke=
r+0x235/0x780=0A=
---[ end trace 0000000000000000 ]---=0A=
------------[ cut here ]------------=0A=
refcount_t: underflow; use-after-free.=0A=
WARNING: CPU: 4 PID: 14653 at lib/refcount.c:28 refcount_warn_saturate+0x11=
0/0x200=0A=
Modules linked in:=0A=
CPU: 4 PID: 14653 Comm: kworker/4:8 Tainted: G    B   W          6.3.0-next=
-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Workqueue: events sco_sock_timeout=0A=
RIP: 0010:refcount_warn_saturate+0x110/0x200=0A=
Code: 1d 4a 96 eb 07 31 ff 89 de e8 dc 98 92 fd 84 db 75 a0 e8 13 9d 92 fd =
48 c7 c7 a0 73 7b 89 c6 05 2a 96 eb 07 01 e8 c0 1c 5b fd <0f> 0b eb 84 e8 f=
7 9c 92 fd 0f b6 1d 13 96 eb 07 31 ff 89 de e8 a7=0A=
RSP: 0018:ffffc90009e97cb8 EFLAGS: 00010292=0A=
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000=0A=
RDX: ffff8880465de1c0 RSI: ffffffff814f0e8b RDI: ffffffff814f0e7e=0A=
RBP: ffffc90009e97cc8 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 00000000000c2e38 R12: ffff88801df87080=0A=
R13: ffff888044fddc08 R14: ffff88801df87080 R15: ffff88811a43d100=0A=
FS:  0000000000000000(0000) GS:ffff88811a400000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 0000000000000000 CR3: 000000000ab45000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 sco_sock_timeout+0x1f8/0x240=0A=
 process_one_work+0x9f0/0x16c0=0A=
 worker_thread+0x68e/0x10f0=0A=
 kthread+0x356/0x460=0A=
 ret_from_fork+0x1f/0x30=0A=
 </TASK>=0A=
irq event stamp: 821585=0A=
hardirqs last  enabled at (821585): [<ffffffff88f8f95e>] irqentry_exit+0x3e=
/0x90=0A=
hardirqs last disabled at (821584): [<ffffffff88f8e534>] sysvec_apic_timer_=
interrupt+0x14/0xc0=0A=
softirqs last  enabled at (821420): [<ffffffff8554fefd>] wg_packet_tx_worke=
r+0x33d/0x780=0A=
softirqs last disabled at (821416): [<ffffffff8554fdf5>] wg_packet_tx_worke=
r+0x235/0x780=0A=
---[ end trace 0000000000000000 ]---=0A=
