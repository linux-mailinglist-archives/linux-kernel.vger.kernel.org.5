Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76FB78A139
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjH0Tlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjH0TlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:41:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B255124;
        Sun, 27 Aug 2023 12:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksyJU/rAup5qhq3xJ3A6OWD5kxGI+mBbu85hy7mBawlDKyWDd+pS6f6tez+QhgIumq5l6fYZoD69rGE/RlenFYVH6eVVV3wqwpNOR0Q45BtKkicv/nENRuCizh5XQht/hkx3aeiZi/8CymJD9wfbQO3m7AItOjeYDArT88c7rIzTV9Du3NURHcIdBAzmDKkfjqdYZ625DS5n69Ib40sG1w4kSZWjm16v3PQgWIlio/Aa1O3rOu6OvT0KNaLagiCMnIAyfYVFNmexKq9dIqlCBficsLvG5npz3Ew1LeYYT4APmSfe3eILnK6lFBwHQtMCwCjgpXY3OTtWO/jyJ2xwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNmHiyJdj44dx6eh04owvrAh3cO+waElrviFU78hVeQ=;
 b=bathsbpI8v7gLrIo48Oahp/gTxL3XfS/MIFG9wLyFP5tociCfIlE9IyCGNUTyhGrPEjFZxc2KYAZOg1OWt1RzYiFaQ1yaMNu6+hlyC0h5nGTohZQD+zGBLDNc/sYfovvaHLQisSWWI1CAERfOQ5LrVd/PgTEynLyxgDZoWoXZJq+5YMlX53Z4ZKluqiUEl0P+dZ53w0v2ihUsBUDtpzKJ5kSzQPBoYMETBTADIZyWjc+jADzzevu5jeJWj9QstdZMwffM3pXuvGKj9a2RuDcTkUFSnzcBoQQn4zSGgsMB6o2zg4cwAZz36cHagJQPaPTn0oiabWMFeYsdcyMLlSccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNmHiyJdj44dx6eh04owvrAh3cO+waElrviFU78hVeQ=;
 b=RZay4hKuxmsWuq7Aq4+eEpaSVWJs5Vna/TGG4MU3JI4rjZ/hx9IsgGmCfMC9Fud8fgCtWPN3UBC+gU1pC/JCc5hyBTrV7KW63U7Vm2LJE17AIlK7WRjiwqxbS3uzSKdG69TNO7MaUOyj6F4VS9Cm0TX1rXo330D8pYrmI1SALvUg6QxpZi7kkIrPJEYKE6YXjBF7fIF6VrO3ehxhLlwb8+MHnmZeaiFOCZHU5wWpaTFCtqnhngOUq6Iq+EgYPc0so0GEkgXfhsblMQQD6oHn2D7va5Yror3gaMW8xe2tA2EemNFKEIliLUBELf9RqZQTDi4NF9UG5IEWVil2xE0T3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 19:41:12 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 19:41:11 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kernel test robot <lkp@intel.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, oe-kbuild-all@lists.linux.dev,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] HID: nvidia-shield: Introduce thunderstrike_destroy()
References: <4c9a8c7f6b4eb879dd7ef4d44bb6a80b3f126d25.1693070958.git.christophe.jaillet@wanadoo.fr>
        <202308270307.EDe7t62T-lkp@intel.com>
        <b35c9f99-bdbc-6d7c-e7bd-0971fe72ccf2@wanadoo.fr>
Date:   Sun, 27 Aug 2023 12:41:02 -0700
In-Reply-To: <b35c9f99-bdbc-6d7c-e7bd-0971fe72ccf2@wanadoo.fr> (Christophe
        JAILLET's message of "Sat, 26 Aug 2023 23:13:01 +0200")
Message-ID: <875y50qnn5.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 213cc692-c1fe-4471-91b6-08dba735911e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rd8sZGSaUjSkX6trENm5gpf6KDVHOCb2HnoTIIhNG4yZKcqOp68fiBQ21xSr3xbRW+T5fH1LX/w8B1ZTw5LEFrU9p5tJs0ttTrzPMJG4zo0Rrmu+t+TfRZ5r7EVywdHe+X6UoMM+gQD//jF9nRem0B0fNkjqN0Km6Q1gZtdPYVCfSLvHu52ewoy8cBxJHaaMts9JYLigAxUbZVV51dLyxG7weomeSYKjRCy7U1t9fxWXCDkvhA57fQ9WHY8Oyl2uMmhvhCHs+oqLe3IbysvJqHP83D7ZaQeVX9k0wpNfLo41UCa8gYI3PuGhyh7FXtpvlREBCkR74vYrpxYqeM8kCMcp0lVGxo21//CI6Ylyx5zcYLhrVGIBQI/qgMkAoV5kwrNaejfzq6laesqdsBCyjH1cwaaTVEXNNdd5iFTIhneAT+c/p6opA7+ncnD3tlv4AVqzk5sS1YiVNplfyO5FvgtVlN1zwDZNutShXS3dprqLcmhCaDM8vY6CF96aHHfzq/ir2W7KAVJ8CKzhmKxdB03smaz7Nr+Y22zwuURpPmvLS8nzlxav63WH8IwA76/uWDHOCPP9UVRr5/03lHn8gxI9xNAl4aL1FkAoQ19YDYzcIvlsrprfXoYGpKpdRjfQpN+66KTFVZuxbgj9IdUJjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6512007)(6506007)(6486002)(2616005)(2906002)(5660300002)(86362001)(4326008)(8936002)(8676002)(66556008)(66946007)(36756003)(66476007)(41300700001)(316002)(38100700002)(6916009)(478600001)(966005)(83380400001)(66574015)(26005)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FMMmg0MUJ5UUlLUFdhYzNYSXh0V3RhSjMxWHNaT21BYUY0RW1RRTFINTFC?=
 =?utf-8?B?bThWSEY1aFVQaUN2dzlMbjYySTZXV0xkWlI5aFo5MnhwVjRJemdrVVVXM3hZ?=
 =?utf-8?B?SkJOUzdienFsTGlGMU5yM3NSTk1xWUR5Y2lmMVJkOE0wMm5iZlhZMi9ldk5Z?=
 =?utf-8?B?ZzVESmxoM3NxMGtyMUhscHdjYXpvOFlTSmM1di9PeXN5dUw4Z0lWME1KaUht?=
 =?utf-8?B?TWZMTlVQenRXUFVxYm1uSkh3UnRSaERYWDlETTRJOGJyRGluVGlYR3JTY2lh?=
 =?utf-8?B?REJxelptNzVDUVFmTTg1LzFpanhQQXJXYXRPUm9obmpxYTZiUXRXVXlyWDFI?=
 =?utf-8?B?SThVNXZaYnNhWnNseUJmMWNtMDZaelEwOG5rMmltQUQxZ2hwTWxZQUNCNHIy?=
 =?utf-8?B?TC9JdGk2cCtzb20rMFJhWWdPK1czRmxBRUN5ZldYVTBxaC9UeVY4VTVna2pH?=
 =?utf-8?B?djFzWmh1bFFudkNiS1lzWFZGZi91bXUzTWNVQjg5MElwck1raStJNURud28z?=
 =?utf-8?B?R2NsSUhZK2pPelhUN1NXNlVLNFM4dVhsTEdVdTVENTBabmJNdWx0TDdnSGJx?=
 =?utf-8?B?bnQrYzQrSVA3WVNWSkovYXhWTm5aeXpTN1ZKaHljVUxmeVhpRVBIa1ZlZjF4?=
 =?utf-8?B?bEdCVU01b20vSzVnaFIyeWlKT3BZSFpZZ2kva2NEeGt4SENJbmd0bThJNE1j?=
 =?utf-8?B?clQwNWxBbG93N3ZXNFNwc1lCdERzdlVGL2xLL1dZalRpSG9oL0NrR251Z3Jz?=
 =?utf-8?B?SU1ESk1oQzhoOVVVcmlNWTdHQXZhRFRDTXZ1Zm1sMFlZRS9tdmU4eG10Z2dO?=
 =?utf-8?B?bE9hQkhoVG5CVzFzRkF4RU1oLytRcHRrcG5nTDJtVHZ1UnZXYW9CUVhoY2tn?=
 =?utf-8?B?Uzdzc1hTRkVnTHIyeFJ5TWl5elhuZ056UzBqazdmK2lZWEgwcnE4SjZ5SzB0?=
 =?utf-8?B?RnZTYWhEWVE1UmlaWmhramlPTHpKREp3WDNBdGdQQldHZHlZeFQ0UW9ENDVW?=
 =?utf-8?B?TzV0UHNSYW5aakgvNWlnWC9QMkRncGxJZ0ZqOTRnWE85Mjh3dE5PT2hTVGNl?=
 =?utf-8?B?MGQ2eEJCRFBoeUJSZ0Zva29WcWUwNG5kb2NoYmZLc3pUSVg1TU9Hb29DUmND?=
 =?utf-8?B?azhTR0VPYk9wWFdpRzRjM1dGSGozV0M5azVhVnM5aldiRDBNeVR2d0R1YVE1?=
 =?utf-8?B?L24yb3ZCb2ZJbTl5cW9vdXIyTXZYMG9SK2NPWXB6aEtQd3ByRDk2VHB3NXpI?=
 =?utf-8?B?ZlJhaXpXdjFhTm92bnhHUitiS1VhSTNVbTdBckpRYWx3UEpjY3htQ0tMSkRM?=
 =?utf-8?B?MnJKVlpCVlE3QjNwdmdPaVRHY1hxT04zOE13ZkJmak53K3V3YWZMOG94dmVW?=
 =?utf-8?B?NlBYZ0ZpamdGQkhoL3pmaUEzc05TanlsNGlqeHJYNjFGSnlFSVV3eXhRQVVS?=
 =?utf-8?B?amcxS0lDYzVCdEdmVGpIRU51WDY3WGVZZ1owSWdsTTNWcGRsZ0lwUXQzZXNt?=
 =?utf-8?B?U1IwM1Yrd1h1c20zVm5KM3NXaW56OGRxYkZRRCt1MVFOdWhxYmhxbDBYZUNT?=
 =?utf-8?B?b1ppT3IzUHJnaGo5aFRISGJxRi96OU1FRW12MFBPZWJGcWNsL3R1WXc2WFJp?=
 =?utf-8?B?Y1B4SUl6WEdlMzdDWDFJL3BHUlFxaUsrOFV1eVVjSm1ZMnNJdnJUWlY3K2V6?=
 =?utf-8?B?Sk40T09Yb1JKeldRV1ZjQlVSaitxdlpRSWdCUGZOVkNLK2RQVlpjYzA2N3VF?=
 =?utf-8?B?dEJwNkk4aUtKaU5yQlFtREJDRTNueThqR2N5NDIyeGVvd1BoTlNSU0tTaFNJ?=
 =?utf-8?B?clZOeFlaTnJ5QnlGTlBhNEM3cVhYdGJPbHIwT2lkNGZDalRzNEdwTS8zeEJ0?=
 =?utf-8?B?bmVzSEFtdGROVmxDTEgvcnB0Q0lleURwcGo5TnhrTXRiNDR4cFdEb3pBUm5o?=
 =?utf-8?B?cnBPbXY0OFVKdGwrZXI0YTJwTzB0OVllT3IzZENyOUxNUGJ5bHN3TFpaankw?=
 =?utf-8?B?M24vU0NmV2cxcUIvOUphV0pmdFB6QWVFN1JlVTVVaE53UXVaa3ZERjQ2c3Qw?=
 =?utf-8?B?bVU5bXM0U3hOQ0JrU2UzbzZTSG5VM25ES1hzczV3b3d3NGZTNUJpaHpsYVVF?=
 =?utf-8?Q?pRD+pQUE0/OOiBNE2etz/3+dp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213cc692-c1fe-4471-91b6-08dba735911e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 19:41:11.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JVLwJsCCDL8L3YK/lLH8QJV9Vu762sj21313MNnw3i3FkYXRPBWMSgZZnUQBmBIM1pNqROtj+UT0bqUVLlvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug, 2023 23:13:01 +0200 Christophe JAILLET <christophe.jaillet@=
wanadoo.fr> wrote:
> Le 26/08/2023 =C3=A0 22:00, kernel test robot a =C3=A9crit=C2=A0:
>> Hi Christophe,
>> kernel test robot noticed the following build warnings:
>> [auto build test WARNING on linux-next/master]
>> [cannot apply to linus/master v6.5-rc7]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>> url:
>> https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/HID-nv=
idia-shield-Fix-a-missing-led_classdev_unregister-in-the-probe-error-handli=
ng-path/20230827-014602
>> base:   linux-next/master
>> patch link:    https://lore.kernel.org/r/4c9a8c7f6b4eb879dd7ef4d44bb6a80=
b3f126d25.1693070958.git.christophe.jaillet%40wanadoo.fr
>> patch subject: [PATCH 3/3] HID: nvidia-shield: Introduce thunderstrike_d=
estroy()
>> config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/202=
30827/202308270307.EDe7t62T-lkp@intel.com/config)
>> compiler: hppa-linux-gcc (GCC) 13.2.0
>
> On x86_64, gcc 12.3.0 does not complain. :(

The key to getting gcc to spew the warning is passing W=3D1 for the make
variable to get the compiler to invoke the unused warning.

  [nix-shell:~/Documents/linux]$ make help | grep -i W=3D
   make W=3Dn   [targets] Enable extra build checks, n=3D1,2,3 where
 		Multiple levels can be combined with W=3D12 or W=3D123

  linux on =EE=82=A0 cjaillet/shield-fixup [?] via =E2=9D=84=EF=B8=8F  impu=
re (linux-6.1.31)
  =E2=9D=AF make -C $dev/lib/modules/*/build M=3D$(pwd)/drivers/hid W=3D1 m=
odules
    CC [M]  /home/binary-eater/Documents/linux/drivers/hid/hid-nvidia-shiel=
d.o
  /home/binary-eater/Documents/linux/drivers/hid/hid-nvidia-shield.c: In fu=
nction =E2=80=98shield_probe=E2=80=99:
  /home/binary-eater/Documents/linux/drivers/hid/hid-nvidia-shield.c:1046:3=
1: warning: variable =E2=80=98ts=E2=80=99 set but not used [-Wunused-but-se=
t-variable]
   1046 |         struct thunderstrike *ts;
        |                               ^~
    MODPOST /home/binary-eater/Documents/linux/drivers/hid/Module.symvers
    CC [M]  /home/binary-eater/Documents/linux/drivers/hid/hid-nvidia-shiel=
d.mod.o
    LD [M]  /home/binary-eater/Documents/linux/drivers/hid/hid-nvidia-shiel=
d.ko
    BTF [M] /home/binary-eater/Documents/linux/drivers/hid/hid-nvidia-shiel=
d.ko

  linux on =EE=82=A0 cjaillet/shield-fixup [?] via =E2=9D=84=EF=B8=8F  impu=
re (linux-6.1.31) took 4s
  =E2=9D=AF gcc --version
  gcc (GCC) 12.2.0
  Copyright (C) 2022 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is N=
O
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

Hope this is helpful.

-- Rahul Rameshbabu

>
> Let see first if there is some comment on the serie, then I'll send a v2 =
to fix
> the warning.
>
> CJ
>
>> reproduce: (https://download.01.org/0day-ci/archive/20230827/20230827030=
7.EDe7t62T-lkp@intel.com/reproduce)
>> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion
>> of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202308270307.EDe7t62T-lk=
p@intel.com/
>> All warnings (new ones prefixed by >>):
>>     drivers/hid/hid-nvidia-shield.c: In function 'shield_probe':
>>>> drivers/hid/hid-nvidia-shield.c:1046:31: warning: variable 'ts' set bu=
t not used [-Wunused-but-set-variable]
>>      1046 |         struct thunderstrike *ts;
>>           |                               ^~
>> vim +/ts +1046 drivers/hid/hid-nvidia-shield.c
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1042
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1043  static int shield_p=
robe(struct hid_device *hdev, const struct hid_device_id *id)
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1044  {
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1045  	struct shield_devi=
ce *shield_dev =3D NULL;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08 @1046  	struct thunderstri=
ke *ts;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1047  	int ret;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1048
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1049  	ret =3D hid_parse(=
hdev);
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1050  	if (ret) {
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1051  		hid_err(hdev, "Pa=
rse failed\n");
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1052  		return ret;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1053  	}
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1054
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1055  	switch (id->produc=
t) {
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1056  	case USB_DEVICE_ID=
_NVIDIA_THUNDERSTRIKE_CONTROLLER:
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1057  		shield_dev =3D th=
understrike_create(hdev);
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1058  		break;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1059  	}
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1060
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1061  	if (unlikely(!shie=
ld_dev)) {
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1062  		hid_err(hdev, "Fa=
iled to identify SHIELD device\n");
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1063  		return -ENODEV;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1064  	}
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1065  	if (IS_ERR(shield_=
dev)) {
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1066  		hid_err(hdev, "Fa=
iled to create SHIELD device\n");
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1067  		return PTR_ERR(sh=
ield_dev);
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1068  	}
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1069
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1070  	ts =3D container_o=
f(shield_dev, struct thunderstrike, base);
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1071
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1072  	ret =3D hid_hw_sta=
rt(hdev, HID_CONNECT_HIDINPUT);
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1073  	if (ret) {
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1074  		hid_err(hdev, "Fa=
iled to start HID device\n");
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1075  		goto err_haptics;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1076  	}
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1077
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1078  	ret =3D hid_hw_ope=
n(hdev);
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1079  	if (ret) {
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1080  		hid_err(hdev, "Fa=
iled to open HID device\n");
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1081  		goto err_stop;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1082  	}
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1083
>> 3ab196f882377ed Rahul Rameshbabu   2023-08-07  1084  	thunderstrike_devi=
ce_init_info(shield_dev);
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1085
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1086  	return ret;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1087
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1088  err_stop:
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1089  	hid_hw_stop(hdev);
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1090  err_haptics:
>> 2cc4637842495c6 Christophe JAILLET 2023-08-26  1091  	thunderstrike_dest=
roy(hdev);
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1092  	return ret;
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1093  }
>> 09308562d4afb1a Rahul Rameshbabu   2023-06-08  1094
>>=20
