Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645681156C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442027AbjLMPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441983AbjLMPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:00:08 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2135.outbound.protection.outlook.com [40.107.113.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C5C93;
        Wed, 13 Dec 2023 07:00:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/iEnRP/LqznH1oF4zLfzg1dYjs6SH5mo6XTgfIZRD0ZzDU8OdtChmuvD637Uv7R+qercZv5z9H2g2uoh6tb6jAly9suHm3VBAhKrVTrJ2AYZR7i1+XrW6p3fxaRc6e+aE+Odg5JD+bzld/3Br7Wp1XKjgqqfFTiNtWeR+xxHU9sDhfJ/rFASMwuIPn2+VERMRkl1kSDatQykeXI2ty1LUMbgCtpj1qaRUk5TAnMt/mRe4igk4AjK+D/qAUZtl8W4u9VQN21PJfwsIrkFdWrxbHYmIybBUCudZuF7UcuH66qrVE/CMhheYYGiGwI9nDP3VrzVNPHoH4+K3aHYzaPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTW7FxZjybcPNPkrb7oE1bAPUAFpTHEr1ofr+8t5N9Q=;
 b=CsO/ZP9bu+xFjxSGXit7DEuiVYF0hfrG38lzeJMizsZlChach1xqXT8j2lm1ROIdRzScRqvgIUaxQrWcYBHVz6Un2IxW9aY6JG/129czkkwZu8bbW8Ik8rKl/TXL1/LaAHR2GccNSSukILCUFhs6wjoabpezEod93NrddWyJfOsdZI4IxsLS8PyPWHGCs2tpJ+p8GyoqQeF5SMJLeQCHZzXaV+P5IwJrNYb/j0SLvKKuRUtGlSYnl2sP3yV8zuOWPPXaQ9a7FxqNlfCD9IoLZ441Oa7+k8/TNxzaJ4dQMSlXvXb99BVi7jwQBpzxbBy6v9wI/pNb+jDw5P/MmvjhuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTW7FxZjybcPNPkrb7oE1bAPUAFpTHEr1ofr+8t5N9Q=;
 b=GKCxkCchXOx2tMVypKhMdnc0PPQNaXDxWvWHePf2EJ9/jf4r1hkL0n+6xEGIHeS/cUJvl6q3cfox3f8is20ytavp4r44tBbgRaLbsxv7omSi/gpQ2a+d0Fpk4x8nYZZWOGbx1xxQX70wAP7g+ZzNe5F7VLpLiS7y0KlckjP8DEs=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OSZPR01MB7819.jpnprd01.prod.outlook.com
 (2603:1096:604:1b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23; Wed, 13 Dec
 2023 15:00:09 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::f216:24ab:3668:3a48%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:00:08 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "benjamin.berg@intel.com" <benjamin.berg@intel.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "miriam.rachel.korenblit@intel.com" 
        <miriam.rachel.korenblit@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: next: arm64: gcc-8-defconfig - failed -
 net/wireless/shipped-certs.c:92:1: error: expected '}' before numeric
 constant
Thread-Topic: Re: next: arm64: gcc-8-defconfig - failed -
 net/wireless/shipped-certs.c:92:1: error: expected '}' before numeric
 constant
Thread-Index: Adot078PtDDEl6shQJysZ7bF7F4DCQ==
Date:   Wed, 13 Dec 2023 15:00:08 +0000
Message-ID: <TYCPR01MB11269DD29E89EF09A4B053C1C868DA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OSZPR01MB7819:EE_
x-ms-office365-filtering-correlation-id: 1d54cc6a-8773-4fda-d218-08dbfbec32f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMe/HB2vOMNAtdpgaUj0csQ/h7QAf1z4AHwafiYZRTZtlcpAVMN5QZyAJgNyvsXK7skdIE8FoJGsphBnv6H5Y5mVqvhceYnQnnp2TG5wTVkVbZvfU51nK3/naP3Va6tacM6gfFRnkNcztTlxJsc7bdrHk4C+xLosT2EFXZfWLovimT0xkgYXcwhp/O1EQCVZ9nBjdZqsLRv55K75DlsrtxeauV8P90HKCHQanrcbfYtyIvYnfr1kig75nUrXGFiWwJ9MxkXYCLZ9FeMJl28N4Pi/9RH65iZgwr3rxmKLeGncGPJEE2w9LWj7tKc6F5qgZV+cOxBtsVSzBecpQNuJyRg40ohiOcR9y5g9iaHjfC5Wytq6+Pn+wICZ/DYCDqJ78F0WH9R07Ry03XRpVZmkCBkPFoJMEzmEmdMuV5f5L4KMCbIU707NWx6WXpTQwE/b8RfNTK+/KowdyVh4pZN8KQ/gIvwrKBPwCMr3tdO9S1rv5NSSNdFuWKnXWpo+RqsTEsgU9IfKcydikUYKzCUiVhF6I++PxujbxgtzT79HF9398/f5FE75lydQ5NldfuqcQ5Rvd3Sb9IDiYMJUzYIK8c8wIcvuFwMqyGIqyTReEpg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(41300700001)(7696005)(71200400001)(9686003)(76116006)(7416002)(83380400001)(5660300002)(52536014)(8676002)(6506007)(6916009)(4326008)(2906002)(478600001)(54906003)(966005)(8936002)(64756008)(316002)(66476007)(66946007)(4744005)(66556008)(66446008)(86362001)(122000001)(33656002)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?50DaXjQ5oD+cALmj/TaVD4AyuH53PhPDm2wquo+AijBiXUGKcW2Ife3tA7Ez?=
 =?us-ascii?Q?KNu6q2RXp6zTDf/pfgfGD5p9rtByHNc9vRz6NKshHh+prSv3qccvqUYPphhS?=
 =?us-ascii?Q?/OyMxFsC+qd4SviEMeYuG5ys+b2kiZ49YtyADYwHigYGGCNZH3ZKMqfDVdrv?=
 =?us-ascii?Q?WM+6HDzZeO3jeDzUSXDEUdlwbtrs2BkYlQNejF5IuOwWTtPQ6IN0sIs0zXJO?=
 =?us-ascii?Q?FGwNFTQl/YDDRjKW5MEaEmcKFOo9KaK3QUdtZLtPRBcsf2S6BIM2sC7a96O7?=
 =?us-ascii?Q?RCzytfu+atbXdIGz+F1+PBAfO0BXiVSknycTDEjNx78Ru+e9qzmkFjPJZTTV?=
 =?us-ascii?Q?irzYpTDZ3g46UE6nsWI6nEEAxNTu7AiWiZYP+q2lSdEpY86f3FZTAFN6tc3E?=
 =?us-ascii?Q?DC8cszVjGO3oRo7c44TDNZxN+A7jJowOyjNIFVODUTBf1eJzvRkZfG+SLpz1?=
 =?us-ascii?Q?HuVnrU9eLoW2k+yzkCg5m8l8Pid7AAXltZcSRnkgQlvqPr5bZlJx70fsuTl3?=
 =?us-ascii?Q?OipWAnffRdUXPinVHRika46Q9haMaIiyRJGlcyIBSN9eM3J+HGUghJdlCkxj?=
 =?us-ascii?Q?2D1eZoOkAlSV6CYk6zNkG0mkAu4CNc4PGeHzMV1gRlsvuAcJw48ahdd423lz?=
 =?us-ascii?Q?sfC9fQAVsYKJq+YmFAdb29ZeAThMY0B1iROsKqWh7Hezcf4IG6qrf23IBAe7?=
 =?us-ascii?Q?o28QcM1mA+yto2TfGi16iJoWcmRewFpYyOO3K1VN3JSH6v1hiaTaYFFMH5Dl?=
 =?us-ascii?Q?+yY/jx9SpQ9PTCtbPgohzYFeg252scF4uB9MebKMO8viZsPR46B5dbgLla7Q?=
 =?us-ascii?Q?Ue+U1aLNY9D/TdmHJIrXG0MKQSDVcTAaoL+5YW66BVVwfLxu6ZpNmKKQfjHj?=
 =?us-ascii?Q?O8YPSgiF/kacKU27fAkXxV/XPGBGQpX8wSVfzw29Uw1rozlumW53KMnCEowt?=
 =?us-ascii?Q?sz4J3z5vzVqEU6AldjTyCIbi+XCAb7YH5HgzTvkmNTb1UElu4vAvtj7UWpdt?=
 =?us-ascii?Q?pNkzEYXtFhe1OMbFniDOMDskAWhG7Sq9AKRkyHuIZX4dUcAibJE8YpDaI4f7?=
 =?us-ascii?Q?kS+22764HXBgPjFNE2sAd1TBgIr3fOkjb9Qy57DSk+MbHneC/WkN5FQYiOGD?=
 =?us-ascii?Q?B/pDqNf9B+3Dxg7ZIgnF7gczFHG41JrCZ6G2JnBxmeBIutfg5zNgpM7p4663?=
 =?us-ascii?Q?fnxV2O1QetP7rUouMVFJOmj4NFBvZ2WBK8qOqQbGrYLdlZTqFL8B7UXaJaNz?=
 =?us-ascii?Q?1UXnwSwwl/E9NC4ddJ3tRyAIF1qpT4USY8naXp6SkBuGNCISYPx2RNqR6HOq?=
 =?us-ascii?Q?nj3vYCsZCLwsuCTZ3z9cyd8YWyKxRcyX8YhJ4oEyLz2xeyfSTHNX4aVJq/LP?=
 =?us-ascii?Q?Ss1MeSgyZeshyEUjP1+0v51ILBtpavk12Q/1n/VWDGrnQJmhXDgis4KdyFkH?=
 =?us-ascii?Q?vkGUHCbI020koaV612k4S6Rni+AS0S9OAbznPayn6fgaUj5LyQ0/+AkT3BeF?=
 =?us-ascii?Q?sUJOFAFGuxL6CIAk1Kfbj1uxhZ9vSfBrnK81/TlhsTrrSP9kE6ao96j0x+Rh?=
 =?us-ascii?Q?t04/pchXitkgS1mkzKT9Ed5Mb5jy+5OJjBLre2G0FxV6G2LYNQkmRxFH3VDc?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d54cc6a-8773-4fda-d218-08dbfbec32f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 15:00:08.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baB7QRlwht5gkkf8sZYetwV1hlKN95slfehIoQJibYYj8qShcfBlTfQObN9WP3OlRotnZUeVJvlZk9NmJWxdzR9H3ly/oEhpzz5ACbE9UNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7819
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am also seeing similar issue[1] with below tool chain[2] on linux-next.

[1]
gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu

Looks like latest code in net/wireless is not buildable with older toolchai=
n.

Can we revert the change to unblock build failure on next?


[1]
https://lore.kernel.org/all/CA+G9fYv9j08=3D+-CpJdtAV1z9-8KYbYcH8YOvWjbz4TgP=
7pB2TA@mail.gmail.com/

Cheers,
Biju
