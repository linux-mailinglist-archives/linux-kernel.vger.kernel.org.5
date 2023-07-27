Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92327765B63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjG0ScW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG0ScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:32:20 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EF326B2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQlD42RJWmgmgvpRNBWWlhCSnkDtqDwJJgdKkhqWVp2DPp0ib4nLBfSGRQasSC/BGoOsUjaKWxrJEmmREF68r/Vod97R18jTLVDapA/zmvRV0e+SlZuYpbsgXsWoNeFZrCJSOlFv+UPo4gMrIjdcnw/4Zvle/c4iTPkGcfIuljpGJCfZ7pYkHDCTFUoB9wwlyrn+IYm43ElTBvCY04/yxros+yw/qH8Brrhx5X2JWvJaZrs/tz0ptV8Gqu0rGsA++bEJF/eHokPUt2TqgVpb1HZo8tYzBP+b9gtdc27inc/eyVsJ3pxA9Jv7vk9F6NQ0VNWJ3tw7HmAgRDEvPiTY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxyiEetDULJODeEoL60cxyNA5xkyiEGES5weRMXFHpw=;
 b=CmFBrv53lYGoyQo9r45sPZthKPV9qV8NgLibxQvzDbnmUSrVBUozNdU/IoVpC27g4mPD8FJQ8xIIavZZjkLZIov9LEFhcfhtPOGSliU34ax2Z95gjknBAXnuk1f45eF96Wh4iQeVOXrONCdhhS+YcwE/AHUV/TVKtPxVuFUxAt8dTgsfAJqzqL/9q0HS6NbfjzVcKKwiG4lBtvIBvxo1MtHblhKvQbCIifc3IWILIAbWND96KbnO7+JZf8kXd2rnvYt0NkIW7Tyt0NXLkIuoJvp3WCrB5Gr1y9r11DwIl6sJGFhOIH0YHZIsS95zUavXClJ7LyheO7dmt/TajLx13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxyiEetDULJODeEoL60cxyNA5xkyiEGES5weRMXFHpw=;
 b=IAq6R6GB+ssba9wtF0wcBpa2Y7Hnm3nUcISK/zUZzuhW4XcL9Sf+N4jCaO3Cthb1JQh9goMNnWEchEq1jmBPNjYGRzEg8kP0kdObqFHljdPK1wloXy7zisoP8vyThYbqA58vLIWVb9FIDAsdF2UTBpQFyEV43rmLhl5uvmNcD78=
Received: from DM4PR21MB3441.namprd21.prod.outlook.com (2603:10b6:8:ac::18) by
 PH0PR21MB2005.namprd21.prod.outlook.com (2603:10b6:510:48::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.3; Thu, 27 Jul 2023 18:32:12 +0000
Received: from DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::f3ba:9bd2:7908:4ea9]) by DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::f3ba:9bd2:7908:4ea9%5]) with mapi id 15.20.6652.004; Thu, 27 Jul 2023
 18:32:12 +0000
From:   Steven French <Steven.French@microsoft.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
CC:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shyam Prasad <Shyam.Prasad@microsoft.com>,
        "pc@manguebit.com" <pc@manguebit.com>
Subject: RE: [EXTERNAL] fs/smb/client/sess.c:160:5: warning: stack frame size
 (1152) exceeds limit (1024) in 'cifs_try_adding_channels'
Thread-Topic: [EXTERNAL] fs/smb/client/sess.c:160:5: warning: stack frame size
 (1152) exceeds limit (1024) in 'cifs_try_adding_channels'
Thread-Index: AQHZwBLWbILdzQpn2UWwGHu8Gccq46/M9bnQgADcHYCAAB4WIA==
Date:   Thu, 27 Jul 2023 18:32:11 +0000
Message-ID: <DM4PR21MB3441914A2DE2DEC1EF115203E401A@DM4PR21MB3441.namprd21.prod.outlook.com>
References: <202307270640.5ODmPwDl-lkp@intel.com>
 <DM4PR21MB34413441C9DF320C24F5A84FE401A@DM4PR21MB3441.namprd21.prod.outlook.com>
 <20230727164003.GA79803@dev-arch.thelio-3990X>
In-Reply-To: <20230727164003.GA79803@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=51cc16a7-28fc-4643-8544-1c684731851b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-27T18:27:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3441:EE_|PH0PR21MB2005:EE_
x-ms-office365-filtering-correlation-id: 5c28b41a-e9af-4af0-1ca3-08db8ecfcb1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSSNTzGdaE41/IODgPkTm/oILRYo14PjgIcxoP7ImPM7qfViJyNl5bCl9pVePmomwm1R7ZxfsSZ2eF8NZa1TllXTMRxa9It1SStxr1f9rrUNhY46JHeaVAR1S2NgTyV4HLcg4cJ45Cpaph1r+UUE4UVHRvU+jlDyNFYQX0edt4DZUQP6EtTUBtQE+o+MJtcat5Xx9R2mRcV2vSzsIwVS9Uy6Dy3CPvhPXwKS8ub5aVD66b7nKjmApnykMbxrshhEMkIWBjpvO8wBvXb1CjZx9+sOLtlfHwEIigdKV4nmzCzFZQTUTyA7eHoWNx7jrBg7luBBVRecamJo0NQ22NeqWdnhAEZEvMe9H6s4fo4bXw5gTB/Wz/Rj2OPWz4muito92qwJ4r14byT6Mj/dKGCW9R6Kr4OI5qsPl/D2UDFsfjaqbZlBQM6xCPbyfHVorUNtyxZrudVO2nfknWaxeVhvpJRto058fWgUfZB679RaWX0QUVbQZ21MzMzDcEb4KtKleVIoY2SBlqoWRfRpDhDjr7stbO4JKTNM6kdEHobZ/2TRKnPBU0QfBC3c0hKz0d/23hjM3er2TQjy3b3SCwsUUPmQXN8q9173aaNlPsVzEiU0n5KbXGQJDDHOvx65CF/nh0QYNo2dwpvZkxbHkv+gsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3441.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(10290500003)(478600001)(316002)(38070700005)(8676002)(8936002)(66446008)(41300700001)(30864003)(7696005)(38100700002)(2906002)(9686003)(4001150100001)(52536014)(4326008)(5660300002)(76116006)(66476007)(66946007)(966005)(122000001)(66556008)(64756008)(8990500004)(71200400001)(54906003)(110136005)(82960400001)(86362001)(6506007)(82950400001)(53546011)(33656002)(186003)(55016003)(83380400001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0ZTAq24t6Zhh61WVBPSugYeAKH1hFXWCdFAbVANmDQa+SQ7Fqfl2vx7nQ2lh?=
 =?us-ascii?Q?Le9k9GRwaJifCgma+cUT8EK9EN/BriU0g4Ndr3qZJv1k3oUc+DR0I3vLpjPU?=
 =?us-ascii?Q?Nrt96ePYq6IWaQgAVhov1z0F+34Y2NRjl5lvzYZVREQCQTH4UWxhAo8uC9DC?=
 =?us-ascii?Q?9LbE6eIIXXJEuyFgDd9zoRhmlo0f55BevngwmoIOarBOBKa2JY3lJzxFX+yk?=
 =?us-ascii?Q?v8YxWS7V88bXMIdemRU+3aOU0ykkEDCsd5Zo1gzRo/p3WYdMWPJSAINzf7s2?=
 =?us-ascii?Q?EgRm4pjX7DqL8Mn+uhWjyab4jEYXQjU80f4QZtaNoG7TR5Vpzq8Ee+0w4jiQ?=
 =?us-ascii?Q?dQlOROgwu5Swbf2oHL8/AxJiDwCad/yuZ/O9PChygjI6J9TbCK2gswd8sM6Z?=
 =?us-ascii?Q?IT/GtMkXo7hygsDzvn/F9TCVv/zRSsZ8W1OyW3pxhsW9LHi3TdhgEQIOJfXg?=
 =?us-ascii?Q?cSyDO/cXmZpggRkpEMhV+V7TElInOwMUCBnw1rju0CKKFSiSlKhZYBQDJhJl?=
 =?us-ascii?Q?RA0zmw6plyuh/e/4YzuXO84JxIFn2Kd+KR9K2+UMPZQ9GVTbOR6uX8JrWMk+?=
 =?us-ascii?Q?M7vMKR/vzZPX92zHrykqAs2/u92dC9Tad2FIfFz0gbnhdSyyQ2SGKchDEXbX?=
 =?us-ascii?Q?gaZ3V7NduMZpJfqNMUC1dgMMe1AUuCXgn0W7Ydl/Feq1WTDtjO/4bRp4Cd9c?=
 =?us-ascii?Q?nt0Pagv5lQ4gINdpdmFOvnvpT1KSUXT6roir7D6irqzbB5x6QJzyRMvMpbWq?=
 =?us-ascii?Q?dTl9tHgXN0o9vPp18km1BEHz9Kunv0dJtDQ2DZ46fZBxah9CngZREFUVH3L4?=
 =?us-ascii?Q?qixblxGSDT1iwuqkpLUIWlf2OH6TFap2uF1UACBHm/e9sXW3qG/nuYEygfAQ?=
 =?us-ascii?Q?sL8ANsa04vcQJSXbUGKDZkMMkhgyJe7bQfK+RT98bbsqVPb32scPMfijuLvh?=
 =?us-ascii?Q?VFmkbvfYXzKDXYFUKTz1pGzDLaNUbOOqkX1kF2aiMIaEAxq1QpvLSaC4gT9D?=
 =?us-ascii?Q?6U7el3bs16plLFalV9YC0hKJDcDet5OsCUuTAAOi3nbyzMwI7Z5gJSz9CIOT?=
 =?us-ascii?Q?IULl6MhkYN2b09Yn68IFTPjyXEQCR2YFQk0fr8ejR/I5z3SuSLEgCXHsRem7?=
 =?us-ascii?Q?Z5bawdS8ix+tTfvk/LX7LTitdy8ue1Sjyd7qL8pk6ta6t9qt2wZFRhHZUBt3?=
 =?us-ascii?Q?kvIosIrlbMOObhBCQDJy0loysWoHol02m1uxdYtG9DFgHRKoI1zh7pepJrbm?=
 =?us-ascii?Q?1pzvkpLGeELsq3GiF+4W2RJ4XlAtQYhdZ38X+CBGIWqnNcqLwGQhZ4FehzHV?=
 =?us-ascii?Q?xebvPGO7H8gOdYI0poQvDNeBEJdryzj2jG+yMW5HyK5af8E/z0g8weW0ishG?=
 =?us-ascii?Q?HIr8UkILkcj5wj1VFwciv2kjvqnY3wZfquhxxfSYsh3zSSGKIDdaX4IBIwGt?=
 =?us-ascii?Q?xOMpYrmR28EGvMGiKef0ZZlfPxGMDBglHUg8z8tqiMm694S4UhdbBLfFhawA?=
 =?us-ascii?Q?ESvGcWrrTOZ1KaoKVXU+gvSai9w3R0j3Xe4nY3S8hflLxfYM/bGCA2TZpfUL?=
 =?us-ascii?Q?6x9CA/clyOjknDqwInwcv288tQtGo/pkn/L8FrEFXGVKnfPIjz/QOeuJOiId?=
 =?us-ascii?Q?QQOEpZEb7LP1kHVBO/pXfAYsALi4unbtKsIm2ZvZLuUz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3441.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c28b41a-e9af-4af0-1ca3-08db8ecfcb1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 18:32:11.9802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSHhgPgr9wEexaVlcGBAZifbbcqa2R3tdDFxCbcyl4zn9KRTDrmf4irHfZpv8qLM80qil3v6OhgDaWaVQ0PsXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is probably more we can do on the compiler side to improve the spil=
ls but I suspect marking cifs_ses_add_channel() as noinline_for_stack or sw=
itching ctx to a head allocation would resolve this.

That makes sense - looks like the problem was introduced by putting a large=
 variable ctx (which is struct smb3_fs_context) on the stack in cifs_ses_ad=
d_channel() in sess.c line 363 for the patch referenced below

387ec58f339b0c45e3767395f11fa8dd3772131e cifs: simplify handling of cifs_sb=
/ctx->local_nls
(followed by "cifs: rename smb_vol as smb_fs_context and move it to fs_cont=
ext.h")

And could be fixed by malloc of ctx instead.   Probably not urgent and was =
only detected due to the directory move of these files from fs/cifs to fs/s=
mb/client so could do this for 6.6-rc



-----Original Message-----
From: Nathan Chancellor <nathan@kernel.org>
Sent: Thursday, July 27, 2023 11:40 AM
To: Steven French <Steven.French@microsoft.com>
Cc: kernel test robot <lkp@intel.com>; llvm@lists.linux.dev; oe-kbuild-all@=
lists.linux.dev; linux-kernel@vger.kernel.org
Subject: Re: [EXTERNAL] fs/smb/client/sess.c:160:5: warning: stack frame si=
ze (1152) exceeds limit (1024) in 'cifs_try_adding_channels'

[You don't often get email from nathan@kernel.org. Learn why this is import=
ant at https://aka.ms/LearnAboutSenderIdentification ]

Hi Steve,

On Thu, Jul 27, 2023 at 03:36:11AM +0000, Steven French wrote:
> Does anyone recognize the problem here - the stack size it is complaining=
 about has a small stack usage not a large one
>      cifs_try_adding_channels   has five pointers and five ints on the st=
ack.  That seems small - not large.  It is called by cifs_mount which doesn=
't seem too bad in its stack usage either.
>
> Any ideas why the stack size complaint is made?

Unfortunately, it seems like a recent-ish LLVM change removed the handy spi=
ll/variable information that would have shed a little more immediate light =
on this situation:

https://github.com/ClangBuiltLinux/linux/issues/1894

Building with a version that has that reveals:

  fs/smb/client/sess.c:160:5: warning: stack frame size (1152) exceeds limi=
t (1024) in 'cifs_try_adding_channels' [-Wframe-larger-than]
  int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_se=
s *ses)
      ^
  412/1152 (35.76%) spills, 740/1152 (64.24%) variables
  1 warning generated.

The spills are definitely not great but it looks like there is a moderately=
 large stack variable in cifs_ses_add_channel(), which gets inlined into ci=
fs_try_adding_channels(). Unfortunately, pahole appears to be borked for me=
 but -Rpass-analysis=3Dstack-frame-layout shows it:

  fs/smb/client/sess.c:161:1: remark:
  Function: cifs_try_adding_channels
  Offset: [SP-8], Type: Spill, Align: 8, Size: 8
  Offset: [SP-16], Type: Spill, Align: 8, Size: 8
  Offset: [SP-24], Type: Spill, Align: 8, Size: 8
  Offset: [SP-32], Type: Spill, Align: 8, Size: 8
  Offset: [SP-40], Type: Spill, Align: 8, Size: 8
  Offset: [SP-48], Type: Spill, Align: 8, Size: 8
  Offset: [SP-56], Type: Spill, Align: 8, Size: 8
  Offset: [SP-64], Type: Spill, Align: 8, Size: 8
  Offset: [SP-72], Type: Spill, Align: 8, Size: 8
  Offset: [SP-80], Type: Spill, Align: 8, Size: 8
  Offset: [SP-88], Type: Protector, Align: 8, Size: 8
  Offset: [SP-712], Type: Variable, Align: 8, Size: 624  <-- ctx, struct sm=
b3_fs_context
  Offset: [SP-801], Type: Variable, Align: 1, Size: 89
  Offset: [SP-816], Type: Spill, Align: 8, Size: 8
  Offset: [SP-824], Type: Spill, Align: 8, Size: 8
  Offset: [SP-832], Type: Spill, Align: 8, Size: 8
  Offset: [SP-840], Type: Spill, Align: 8, Size: 8
  Offset: [SP-848], Type: Spill, Align: 8, Size: 8
  Offset: [SP-856], Type: Spill, Align: 8, Size: 8
  Offset: [SP-864], Type: Spill, Align: 8, Size: 8
  Offset: [SP-872], Type: Spill, Align: 8, Size: 8
  Offset: [SP-880], Type: Spill, Align: 8, Size: 8
  Offset: [SP-888], Type: Spill, Align: 8, Size: 8
  Offset: [SP-896], Type: Spill, Align: 8, Size: 8
  Offset: [SP-904], Type: Spill, Align: 8, Size: 8
  Offset: [SP-912], Type: Spill, Align: 8, Size: 8
  Offset: [SP-920], Type: Spill, Align: 8, Size: 8
  Offset: [SP-928], Type: Spill, Align: 8, Size: 8
  Offset: [SP-936], Type: Spill, Align: 8, Size: 8
  Offset: [SP-944], Type: Spill, Align: 8, Size: 8
  Offset: [SP-952], Type: Spill, Align: 8, Size: 8
  Offset: [SP-960], Type: Spill, Align: 8, Size: 8
  Offset: [SP-968], Type: Spill, Align: 8, Size: 8
  Offset: [SP-976], Type: Spill, Align: 8, Size: 8
  Offset: [SP-984], Type: Spill, Align: 8, Size: 8
  Offset: [SP-992], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1000], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1008], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1016], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1024], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1028], Type: Spill, Align: 4, Size: 4
  Offset: [SP-1040], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1048], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1056], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1064], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1072], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1080], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1088], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1096], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1104], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1112], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1120], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1124], Type: Spill, Align: 4, Size: 4
  Offset: [SP-1128], Type: Spill, Align: 4, Size: 4
  Offset: [SP-1136], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1144], Type: Spill, Align: 8, Size: 8
  Offset: [SP-1152], Type: Spill, Align: 8, Size: 8 [-Rpass-analysis=3Dstac=
k-frame-layout]
    161 | {
        | ^

There is probably more we can do on the compiler side to improve the spills=
 but I suspect marking cifs_ses_add_channel() as noinline_for_stack or swit=
ching ctx to a head allocation would resolve this.

Cheers,
Nathan

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, July 26, 2023 5:44 PM
> To: Steven French <Steven.French@microsoft.com>
> Cc: llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev;
> linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] fs/smb/client/sess.c:160:5: warning: stack frame size=
 (1152) exceeds limit (1024) in 'cifs_try_adding_channels'
>
> Hi Steve,
>
> First bad commit (maybe !=3D root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   0a8db05b571ad5b8d5c8774a004c0424260a90bd
> commit: 38c8a9a52082579090e34c033d439ed2cd1a462d smb: move client and ser=
ver files to common directory fs/smb
> date:   9 weeks ago
> config: mips-loongson2k_defconfig
> (https://dow/
> nload.01.org%2F0day-ci%2Farchive%2F20230727%2F202307270640.5ODmPwDl-lk
> p%40intel.com%2Fconfig&data=3D05%7C01%7CSteven.French%40microsoft.com%7C
> b15fd25d8a424332574308db8ec022d5%7C72f988bf86f141af91ab2d7cd011db47%7C
> 1%7C0%7C638260728110528650%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA
> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D
> ONikRy3GwMEm0EWCqwfjVxodTVYK3XGUitvOCtdwkEI%3D&reserved=3D0)
> compiler: clang version 17.0.0
> (https://git/
> hub.com%2Fllvm%2Fllvm-project.git&data=3D05%7C01%7CSteven.French%40micro
> soft.com%7Cb15fd25d8a424332574308db8ec022d5%7C72f988bf86f141af91ab2d7c
> d011db47%7C1%7C0%7C638260728110528650%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> C%7C&sdata=3Dm%2BNLdUsC7MNxn5YoYWroka3ANYO7CaMmQXCl2vVnoyU%3D&reserved=3D=
0
> 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce:
> (https://dow/
> nload.01.org%2F0day-ci%2Farchive%2F20230727%2F202307270640.5ODmPwDl-lk
> p%40intel.com%2Freproduce&data=3D05%7C01%7CSteven.French%40microsoft.com
> %7Cb15fd25d8a424332574308db8ec022d5%7C72f988bf86f141af91ab2d7cd011db47
> %7C1%7C0%7C638260728110528650%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sda
> ta=3DiFqAsjC5UOLz42Hhh4iM31%2BS7F1TAtLoreO9LbeK3tI%3D&reserved=3D0)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore/
> | .kernel.org%2Foe-kbuild-all%2F202307270640.5ODmPwDl-lkp%40intel.com%
> | 2F
> | &data=3D05%7C01%7CSteven.French%40microsoft.com%7C2cc584fd937a4cd5b9d0
> | 08
> | db8e29f75b%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638260083130
> | 23
> | 4737%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> | BT
> | iI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DAauGIxZRPM5DK1J5j6ly
> | Ep
> | jOkArxfVtIUAnmPcxcCQs%3D&reserved=3D0
>
> All warnings (new ones prefixed by >>):
>
> >> fs/smb/client/sess.c:160:5: warning: stack frame size (1152)
> >> exceeds limit (1024) in 'cifs_try_adding_channels'
> >> [-Wframe-larger-than]
>      160 | int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, str=
uct cifs_ses *ses)
>          |     ^
>    1 warning generated.
>
>
> vim +/cifs_try_adding_channels +160 fs/smb/client/sess.c
>
> b54034a73baf9f fs/cifs/sess.c Shyam Prasad N  2022-01-03  158
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  159  /*
> returns number of channels added */ 387ec58f339b0c fs/cifs/sess.c
> Ronnie Sahlberg 2020-12-14 @160  int cifs_try_adding_channels(struct
> cifs_sb_info *cifs_sb, struct cifs_ses *ses)
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  161  {
> 90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  162   struct TC=
P_Server_Info *server =3D ses->server;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  163   int old_c=
han_count, new_chan_count;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  164   int left;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  165   int rc =
=3D 0;
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  166   int tries=
 =3D 0;
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  167   struct ci=
fs_server_iface *iface =3D NULL, *niface =3D NULL;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  168
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  169   spin_lock=
(&ses->chan_lock);
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  170
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  171   new_chan_=
count =3D old_chan_count =3D ses->chan_count;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  172   left =3D =
ses->chan_max - ses->chan_count;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  173
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  174   if (left =
<=3D 0) {
> 88b024f556fcd5 fs/cifs/sess.c Shyam Prasad N  2021-11-19  175           s=
pin_unlock(&ses->chan_lock);
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  176           c=
ifs_dbg(FYI,
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  177            =
        "ses already at max_channels (%zu), nothing to open\n",
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  178            =
        ses->chan_max);
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  179           r=
eturn 0;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  180   }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  181
> 90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  182   if (serve=
r->dialect < SMB30_PROT_ID) {
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  183           s=
pin_unlock(&ses->chan_lock);
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  184           c=
ifs_dbg(VFS, "multichannel is not supported on this protocol version, use 3=
.0 or above\n");
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  185           r=
eturn 0;
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  186   }
> 53923e0fe2098f fs/cifs/sess.c Steve French    2022-02-16  187
> 90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  188   if (!(ser=
ver->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
> 9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  189           s=
es->chan_max =3D 1;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  190           s=
pin_unlock(&ses->chan_lock);
> 90c49fce1c43e1 fs/cifs/sess.c Paulo Alcantara 2023-04-21  191           c=
ifs_server_dbg(VFS, "no multichannel support\n");
> 9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  192           r=
eturn 0;
> 9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  193   }
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  194   spin_unlo=
ck(&ses->chan_lock);
> 9c2dc11df50d1c fs/cifs/sess.c Steve French    2021-05-07  195
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  196   /*
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  197    * Keep c=
onnecting to same, fastest, iface for all channels as
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  198    * long a=
s its RSS. Try next fastest one if not RSS or channel
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  199    * creati=
on fails.
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  200    */
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  201   spin_lock=
(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  202   iface =3D=
 list_first_entry(&ses->iface_list, struct cifs_server_iface,
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  203            =
                iface_head);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  204   spin_unlo=
ck(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  205
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  206   while (le=
ft > 0) {
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  207
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  208           t=
ries++;
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  209           i=
f (tries > 3*ses->chan_max) {
> bbbf9eafbfdaa2 fs/cifs/sess.c Steve French    2020-05-30  210            =
       cifs_dbg(FYI, "too many channel open attempts (%d channels left to o=
pen)\n",
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  211            =
                left);
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  212            =
       break;
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  213           }
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  214
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  215           s=
pin_lock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  216           i=
f (!ses->iface_count) {
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  217            =
       spin_unlock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  218            =
       break;
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  219           }
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  220
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  221           l=
ist_for_each_entry_safe_from(iface, niface, &ses->iface_list,
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  222            =
                   iface_head) {
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  223            =
       /* skip ifaces that are unusable */
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  224            =
       if (!iface->is_active ||
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  225            =
           (is_ses_using_iface(ses, iface) &&
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  226            =
            !iface->rss_capable)) {
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  227            =
               continue;
> 65a37a34145ca6 fs/cifs/sess.c Aurelien Aptel  2019-11-20  228            =
       }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  229
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  230            =
       /* take ref before unlock */
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  231            =
       kref_get(&iface->refcount);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  232
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  233            =
       spin_unlock(&ses->iface_lock);
> 387ec58f339b0c fs/cifs/sess.c Ronnie Sahlberg 2020-12-14  234            =
       rc =3D cifs_ses_add_channel(cifs_sb, ses, iface);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  235            =
       spin_lock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  236
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  237            =
       if (rc) {
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  238            =
               cifs_dbg(VFS, "failed to open extra channel on iface:%pIS rc=
=3D%d\n",
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  239            =
                        &iface->sockaddr,
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  240            =
                        rc);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  241            =
               kref_put(&iface->refcount, release_iface);
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  242            =
               continue;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  243            =
       }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  244
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  245            =
       cifs_dbg(FYI, "successfully opened new channel on iface:%pIS\n",
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  246            =
                &iface->sockaddr);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  247            =
       break;
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  248           }
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  249           s=
pin_unlock(&ses->iface_lock);
> aa45dadd34e44f fs/cifs/sess.c Shyam Prasad N  2022-01-01  250
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  251           l=
eft--;
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  252           n=
ew_chan_count++;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  253   }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  254
> 724244cdb38285 fs/cifs/sess.c Shyam Prasad N  2021-07-19  255   return ne=
w_chan_count - old_chan_count;
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  256  }
> d70e9fa5588476 fs/cifs/sess.c Aurelien Aptel  2019-09-20  257
>
> :::::: The code at line 160 was first introduced by commit
> :::::: 387ec58f339b0c45e3767395f11fa8dd3772131e cifs: simplify
> handling of cifs_sb/ctx->local_nls
>
> :::::: TO: Ronnie Sahlberg <lsahlber@redhat.com>
> :::::: CC: Steve French <stfrench@microsoft.com>
>
> --
> 0-DAY CI Kernel Test Service
> https://gith/
> ub.com%2Fintel%2Flkp-tests%2Fwiki&data=3D05%7C01%7CSteven.French%40micros=
oft.com%7Cb15fd25d8a424332574308db8ec022d5%7C72f988bf86f141af91ab2d7cd011db=
47%7C1%7C0%7C638260728110528650%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DkSq=
8AIXuw4aqvh6X7af5shWbFVmIVgXpBpiLJEuKReE%3D&reserved=3D0
>
