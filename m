Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D988977A517
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjHMGTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:19:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C990110
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIzex9YaEAKEo+1SUXE3Ct+DlKOuXjOeSuJQ6KANQJXXYtf4WrAIg/x9SL2V+zUz3gAs6VR8A4xVTHYUNUFs4NDGZw32DYZ0M9A1sZksVtwbIrUsUxIvmWZOUvozTEvqxwFyyter8TCItoQ10GRpnC+/+N06QVnGDci0j/KR5cyh8mZAlES939uQNgXuXG7pFDj8sZtxhMtwshlXdA62tVDkNa1jYjfKnGfyE+qPwvS53qW5x3D5enQhXJuaGML95YzwAHOztXDCo6p1kWlQqJjHHUwh0wY6m6vMxw7qUPXj1UVyJWeoJPCYHxi5BNn19dinXlQEeSwvJODgEINrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks3/ycVX0hY/yvAtQewmyLeZFFCRS5M1ZGPGkzdC7sI=;
 b=YGEj9na2JjMoFx2mQjoawuCdZthoe2Kpm8529upbVGZDhPRuHK1+DRpx3h8ZVuMkdZls5Z8B+HszbNahNd2dqpnKljbqbamPTKT0NxJyv9VufHoIVE1yu4TSQTe83xlRYrfrCcNA2lJQRha6uJp4Ygq3WMAJOVKPqKVGBtbA4jV/lk+qf/wUtA08ao30wVFjNWW2r2TQqPkbHccLB/eDIaSmt+tljYTBgnoXYJys6JQ1WVLrbEbGA0Nel8yeHOKrIHJsCWIJ+9OSXu8sklz7Zez0SgcVmDUZ9nKhF3nNA5WdpqkNMDVw10NN5mIMxcYzEU/z2uK49U3C1hG9ukwZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks3/ycVX0hY/yvAtQewmyLeZFFCRS5M1ZGPGkzdC7sI=;
 b=OWKSeBJCaq9dE4yIn2AmdNqN8oFjSN+Yw/nNx33JAhDAAEU3f4W5A9jZshgQXgzTiQGz2LZwKjrKf3kJU6Hv2L+BeXiFa+pMCsjZO3jYx/0SKFBX2xL3sP0lzdui4FZHu04kZk8YlH35PPHiv3EO/EL6qsFQNjfSODgJ/ppvgRs=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 KL1P15301MB0418.APCP153.PROD.OUTLOOK.COM (2603:1096:820:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Sun, 13 Aug
 2023 06:19:42 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::97bf:be96:1ebd:5190]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::97bf:be96:1ebd:5190%4]) with mapi id 15.20.6699.009; Sun, 13 Aug 2023
 06:19:42 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Zach O'Keefe <zokeefe@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Topic: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Index: AQHZzWA78fOP2PgBLkyBLwXjPivf+6/nv4Mg
Date:   Sun, 13 Aug 2023 06:19:41 +0000
Message-ID: <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <20230812210053.2325091-1-zokeefe@google.com>
In-Reply-To: <20230812210053.2325091-1-zokeefe@google.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=11674c55-70f2-4c3d-8135-b60f5aff9a68;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-13T06:12:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|KL1P15301MB0418:EE_
x-ms-office365-filtering-correlation-id: ea5e31b7-33a6-4624-da26-08db9bc547b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bVO8oDkVGwhhTkMW0SbVqoiR0FZqe0bvquoCD/HgW8U4vTsiJjx0AkCH0JrYZJnHEZuGfvPCvazUDeYLh/zScN5p7WoHaQIlw4Z+zat6p0kL8RoPh7uPkj3NTgIwRDxcY9XhiHl2f07rOU+3DDZRrd0UZhXONEtQOLs+oyOm4y//F/HQmgRSuwzMkZLsbSfYbqTmZYfPWHWB/qWdpJT/2HIV3DkFwqp8xJAX7bKmTTwZ/KJRTuv7x8h2ZkblbqVuudKJIObLy7vONxmGDm82r5CT8CLHwEF/Y+M7JYtbnIIL8b/v3OKqsjtvhNyTUjof9CWIGo3nSZRbGSgYc950fXr1pfuXDiWPtFgCWi6F+rrzFMve81vMLySoVYS3ouO4smjnkcfoNZqQvnFw4mWkTyumzFYfN+tLDW6J805Php/5YYOXMf9gGe7rEExomw+EeTjKpAQ7UBQp/1CZAUOTfx/LPIGlrQkqaEXW6LdYbM1+ktieB4tetkSPfPeicAetfdjKn0NRYp7OlObzUSkIQm4RXi78rypHlZVIPRmKcHu7Vf97U82lDcdjiL1u7LOki5a0CTq0BOWoHEpR0kVa85JfwqONgS9H56R7BZYR8PLOT+lWRxlyDzHbMU8/OpwolzLS/NMD7juP7z44H6SwBD4vbcnc0mmHwgNq+92ZdLUTOuQM39L/HwSqSdapyNyrbWLpPjDdtol75hi650jWgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(1800799006)(186006)(8936002)(966005)(9686003)(478600001)(7696005)(110136005)(83380400001)(6506007)(71200400001)(2906002)(10290500003)(52536014)(5660300002)(8990500004)(66476007)(66446008)(64756008)(66946007)(66556008)(76116006)(53546011)(41300700001)(4326008)(316002)(8676002)(33656002)(86362001)(55016003)(38070700005)(82960400001)(82950400001)(122000001)(38100700002)(12101799016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DWx5+r+zJdRu+UW/j2Y6yFkL7ZdzDOoKlfbD+Ta7lUgo7kj1YuTIrQ7hNZmC?=
 =?us-ascii?Q?V4AOQoYDQ4nVCgTuAfu2ixlCmDUFtbByEfad/EmyfqJ+eGOz55xfpU3L0Dtb?=
 =?us-ascii?Q?uhzEDMzRCbhPsSKnK/tDqyJfi38r4x/XyCN6hq4v9u8MVNWHwvEQgxS8bT0a?=
 =?us-ascii?Q?2EJG2sxXr7B7ea3l3DG2Z5J9and7j6+Bf3wcQNQtgw2ZwZtHiKiWlY58Zvfx?=
 =?us-ascii?Q?HwzV6AteeTeh9RR81Y+2cmsakEqulX1DyYkakDqSFd8d2/8sofcrRxRMMgdo?=
 =?us-ascii?Q?f6dCQwsPVk5XkJZMwXBpZJhzOD9icpaW/XQj2WIn8zxzgB4ccqeWEMdRBSp5?=
 =?us-ascii?Q?9OqGCjpcojSlFoUm/5YnTKCjJhxfii0HeNTEllEr1b0yWiEXN1uhbZp6z469?=
 =?us-ascii?Q?l/qZ803+zRtHRBfFbgawdhHWlSY8achSEaE/S23wEBCa8FM/Hzw8uSyRuHZt?=
 =?us-ascii?Q?nujahMKkJVS6vhx25scIYjASb046W82yavRY0oJGg6LF7RX08GA/gu/BRJfU?=
 =?us-ascii?Q?4XsOqc52HKxt+x/1rgI4fbUrIx9huA/MSEHhUlL6AjMb9OIEMoqF6EK/XGuA?=
 =?us-ascii?Q?GSA3A5aEbde+kIplb6DYtMLY2efc0B2SvFIpAqKvPkp9xnBSsjEPkpmbGa2K?=
 =?us-ascii?Q?7I7bMJUeOHbMCmW6yzyMRhuGMJCrdETBfcPNEzL9qleS+3ARfxwNQ/ihoSIv?=
 =?us-ascii?Q?FD4K0Zb61w2jr4ckXapz79Vi3PjvllJ5tVXm+A5IqfK+fYH0ywmfi2zGRaaM?=
 =?us-ascii?Q?8cixpJxB2u0lHtb2POBEkLuERXwCmA0vg4bY4RS3cHVxgekM+xV1fomGbgDE?=
 =?us-ascii?Q?pqG1IWYR0qkrRwYpuGnh7KSF/HbMz4feL5WCuWslkV+oOhKMRZq7cKAYhmTt?=
 =?us-ascii?Q?QM8kjYIEzp0SusSBGJoPOWETjmBBf2WRy/i8xpDYxkhs77WLxTjG7Rai8YnP?=
 =?us-ascii?Q?iD7RdYa38tBefXD2g8e0cpoJ/EIShXM+kZyhgsN78rNB8/kF6wMJIoRoEsYR?=
 =?us-ascii?Q?nTWl+1IxNQ6XSLRVVTQdtB7qWZ+w6HvIHocoDDBPdQPwhOeV0wa2F33CBKdl?=
 =?us-ascii?Q?4FQpR06VwgFghcNAVVNOickxH8kav9OceyLoukIXdDSRvNOt/fJC8LJcF7pp?=
 =?us-ascii?Q?BGg2N+ClCZeA8hPXgeHtYa/Pxgc12/xg8faE6+dkFR17+AuP2E0d+smAbALn?=
 =?us-ascii?Q?u7PA0udbfeAW3LbNj6G1QaD/sYN5MkFxO8R1rnjdHjPl7V0tS8RKuG916oP/?=
 =?us-ascii?Q?txdKq9GBOxKiTUqENvqwb01XmYB6lMlay57xX/37hGY78h0ARWZ+BJIefLMm?=
 =?us-ascii?Q?k+fJfkMExZAKzxgtRw0kWzl5xYtIONeH8J57SY8l1Xfvez/klHz6p1u7lgZt?=
 =?us-ascii?Q?sLW0DyaMsyIOd8+kQD+Ez5dGAyItUYzlVvQojgJ0Na0nDp3Fdka/veO4FP+t?=
 =?us-ascii?Q?ef10jrEy1kASKo/lIA09B8Bhp1SmiSLB1Xyojr4m4hGfkqqVgkHyzq7sDwJJ?=
 =?us-ascii?Q?liZ6QS4+Eo9e3QTGrxqVbtjyHBDs280W+iDy5DeO1yT7YEzm7BpTDfGoRfKB?=
 =?us-ascii?Q?vrmKF9qohW9l4EoW33ima7Bcv3VqSgaKPCsMyq89?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5e31b7-33a6-4624-da26-08db9bc547b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 06:19:41.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSMnmdxtTWdlKmbrs5A7TYKVJmHfGZWWv46gwBTooeQG42rHhRTZSLq7a40U/fGWqYnMHs9aLpXdbVbXuYYR4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Zach O'Keefe <zokeefe@google.com>
> Sent: Sunday, August 13, 2023 2:31 AM
> To: linux-mm@kvack.org; Yang Shi <shy828301@gmail.com>
> Cc: linux-kernel@vger.kernel.org; Zach O'Keefe <zokeefe@google.com>;
> Saurabh Singh Sengar <ssengar@microsoft.com>
> Subject: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
> __transhuge_page_enabled()"
>=20
> [You don't often get email from zokeefe@google.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> The 6.0 commits:
>=20
> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()") commi=
t
> 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
>=20
> merged "can we have THPs in this VMA?" logic that was previously done
> separately by fault-path, khugepaged, and smaps "THPeligible".
>=20
> During the process, the check on VM_NO_KHUGEPAGED from the
> khugepaged path was accidentally added to fault and smaps paths.  Certain=
ly
> the previous behavior for fault should be restored, and since smaps shoul=
d
> report the union of THP eligibility for fault and khugepaged, also opt sm=
aps
> out of this constraint.
>=20
> Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c index
> eb3678360b97..e098c26d5e2e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -96,11 +96,11 @@ bool hugepage_vma_check(struct vm_area_struct
> *vma, unsigned long vm_flags,
>                 return in_pf;
>=20
>         /*
> -        * Special VMA and hugetlb VMA.
> +        * khugepaged check for special VMA and hugetlb VMA.
>          * Must be checked after dax since some dax mappings may have
>          * VM_MIXEDMAP set.
>          */
> -       if (vm_flags & VM_NO_KHUGEPAGED)
> +       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
>                 return false;
>=20
>         /*
> --
> 2.41.0.694.ge786442a9b-goog

Thanks for the patch, I realized with the commit 9fec51689ff60,
!vma_is_anonymous restriction is also introduced. To make fault path
work same as before we need relaxation for this check as well. Can we
add the below as will in this patch:

-       if (!vma_is_anonymous(vma))
+       if (!is_pf && !vma_is_anonymous(vma))
                return false;

- Saurabh

