Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB69797ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjIGRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245533AbjIGRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:49:39 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012010.outbound.protection.outlook.com [40.93.200.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB42699;
        Thu,  7 Sep 2023 10:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0M0d3Vr9gwchiMtoDU2gP3ifoU0U1g/CxByQtYAVMXViMo7QhekoLZzgGGHBgQ0Iw7fQ8Ws43Kww7nCYiYThqkOTTpBs/+02OoKSyNlB3+KUR0D2qGo0j1/+auphjlAIBxanBomlQMMqlbgs8pYPd4Ku/bSTjhsYKoZZH1bOpKhwEPeDaBuJiOKODR1MAnUgCPRlxiZFBmBz+9J6M4yChftBufpnMRTd5LjIk0pLZGN9k2lcuoNlULZmfdYh+Jxmpbp0o/f88wk5d3SR+BT4sF9y3nMLEAiaF6/WS7NqQ8ni1fSyHdQ0mrjfxudSK3+qBMSk6JbLiZdBIxLLTDEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoK73DoPloQPL33wLH40N54ERhYOrtbQ6vCb30sgLAk=;
 b=ScRMQL+eNYZTdhnfCraTisKWly9LbA+NxSmOOIkNYP+2wOupeIG7E7qpihfjfh0z0fhOiokMnsbAi4FVzVGQgsJXliiXDePlMCwNvTx/ILW+ac+kwW7scDZXxHjxUVkyb3zfGoWYZfqkAkZrIHd2qeoDP5JuwRind5VRWZPjnInamCko3qPULldYjuamMGedvFvBiruwu661hCLpHwT7fqIBI22zNc6Vo0lTwRsBCU896swacGLc8IdVaV55nhVlYMpqiaJPIYN51wP1qzSmuOodO4B/MUMUExpOKsiYe2KNnR68HdKQQLLBOMZnlOTO0NbeyX/8SpuYRvt5BXYBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoK73DoPloQPL33wLH40N54ERhYOrtbQ6vCb30sgLAk=;
 b=vLxajJqmnwTGiNqC5ZN8BdEx82B8MRqzJnL2igcdSVZacfhL0EXq6s4ZPi7cy1xqG0NOWH5YFtpgoZbBiOwJB/oQLKrnpp0z7fuUkGQogfHA3EbTcHzy9m/gaLx8rDVSAgo1XlRg0v6ok2RIyH/1zXGjZssuKBJK62vSZApLOsE=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by LV3PR05MB10381.namprd05.prod.outlook.com (2603:10b6:408:195::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 17:48:21 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::f06:95fa:1a2b:9c4c%5]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 17:48:21 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nadav Amit <namit@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Subject: Re: [PATCH 1/6] tracefs/eventfs: Use dput to free the toplevel events
 directory
Thread-Topic: [PATCH 1/6] tracefs/eventfs: Use dput to free the toplevel
 events directory
Thread-Index: AQHZ4TW3+uBVHDN7QE+qvXwC1W5dsrAPpIMA
Date:   Thu, 7 Sep 2023 17:48:21 +0000
Message-ID: <7C38F28D-0277-42B2-9FB1-B4B59BBEC8FF@vmware.com>
References: <20230907024710.866917011@goodmis.org>
 <20230907024803.250873643@goodmis.org>
In-Reply-To: <20230907024803.250873643@goodmis.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|LV3PR05MB10381:EE_
x-ms-office365-filtering-correlation-id: f8cbf2a6-f8a5-483d-2aca-08dbafcaa04a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1mUJOBPUA4vTMIG573shSOxUnaH7krkC0zhZh6GNYnvKyGpnVn82p73XWnYwsR4WMJJWIk1CpD2+jr4HSPeJT3UOT13xg9lA/8xV7E2dAOKlOoHu2E6O/XW7FjMvWx3sHn3A4CKy/1xcyoSsAtaGbdp1YkYaYrc4tnowuparLfJYc5iBoT928VSopY2pkXbJQAyLdbTCahyLlsn9qxgH5tEqTpQsqz5o47AZaFYfhNy1jdrayFITwx8Tc//qndA38ZI+WoZFPqiDR8QJxeSTHe/ejqLxRjNXxKIosMOfKVtmpzhUUK/79qVYoW8Mt1mpSq3F0AHEB8SMW0X7M+zJDrtzKFGqMAvz4Y+z/HN7hFKRQjR8wpp+Wp8mi9PX4ytfmTgCDpNwc8X2EEd6IEaEExlJkNoelgWsOB4Fn1gmlmuS2IrKGCd4ChAgVgmzPZqp7F71B/adywF1Tb4Dix0EjLj/ruz5FQsnl/CiyMrwPuJYnEWRKgCD8BZClI/tLEY4E8MHvs8W1Xe2qmIHVQoH6n9zRuCLOLv9WxbmGFsAAN0lA38o9i6n8Ya8iC12vmflYO2xXG4kKqzztMaN7YKWfFRBPBwhctMhqKIjAZiRaoJosWA2f88zbwXpPTwiD2xPRvPizx18NRhIGqnc9WvhEyKLIRgI4LT47tcj+ordByySbe7a68d5t0YLZezt1rv7l6cxgaRCbArwlK+pxO0cvYx/PMFGLi0cwkkPrAgySo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(38100700002)(36756003)(33656002)(38070700005)(86362001)(122000001)(53546011)(41300700001)(6512007)(6506007)(6486002)(6916009)(66556008)(66946007)(316002)(76116006)(66446008)(91956017)(64756008)(107886003)(8676002)(4326008)(66476007)(2616005)(8936002)(45080400002)(966005)(54906003)(71200400001)(83380400001)(5660300002)(478600001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vl47AfOVMegSNSbfxZ9v4nOsKYx73xIvPXeP3mLs9KE9hLamgkL55LF99oKe?=
 =?us-ascii?Q?RzX8aMXvg7t7g2jk/8U9uDz9xUosybgCPa+dLI7Xsxz7SxSsOBoewmocjH4Y?=
 =?us-ascii?Q?67G3xiKL2q2PmFybCML1IhZEcTvKBmhSFKILupSVyRpyzcuCs0yu2x98PWe4?=
 =?us-ascii?Q?Py1m8SMNQy/233MdBKiGVOomznhFqQrkAeq0hgoHX9XgYl2gwIYtKad4b0Tm?=
 =?us-ascii?Q?EVfkBpf+pB83xtESLD/9Yj4cpyl98PxMbiSkbGDPKzkfoRbH+V7UB1sIvM9i?=
 =?us-ascii?Q?NxqhFnqmnlpXKV8WWMelx52BoBwRiorv6eL46w8IHwkd/8yI8agkKCU4HV9k?=
 =?us-ascii?Q?/j4Gc2Bu+z/wZIVWdmIR1/1VVdQsPWPGogdswPYmzQhV4DHWgKOc1/o+nrLN?=
 =?us-ascii?Q?EaSQfHQuftnbfT8vB6y65hsrALEJ/yYsht90E0X80+2Dz6NV2qp69IrFQGyR?=
 =?us-ascii?Q?VGDEHlGhRwY+3mSClR7D813JcEoJkGuglQBBfrZsqs4SY0N2d3qbWHgtLaJZ?=
 =?us-ascii?Q?1m9G9MX7hoLqfXE++/kUcaJWLfqpRegvdiUM3Kqb+DqBHjJRV0HUZ+tXMESP?=
 =?us-ascii?Q?4ksy3S3OXNlJXPq7kjHRKXYINGRgtoYiMjYsLvudQA9wsUpx39QGlyhQxcIt?=
 =?us-ascii?Q?6qwxJLTv7TSapf4AKksflXR2cRY9xyrTp80aqebbHOEZvlHmA1NJ2hSWvrXL?=
 =?us-ascii?Q?dywegQcYQlW7Y9gb0v1dRcyxWWazyLpGpAvgzzSuqNjVZSyZBTe62CE4u/iD?=
 =?us-ascii?Q?mQdV4TveeLorDNhnzSdW4TtKaGdkT7FWCDm266JhYCd1alU7QnDOE3pl3vgA?=
 =?us-ascii?Q?K3ghCPsyXuMy0Qblj2seZ5aTUhRpmHCLT8s2f8v1b5i74q5QYDdIVvXm/tO5?=
 =?us-ascii?Q?hcZHxPZ6bWeWfik1+Dg5tzZHwqGfEZSVHlFM6tLAZuoUWL/oS5KXMixFU7vp?=
 =?us-ascii?Q?BDwxgcl1sJE4Uv5hnDVSfkZB2rQ0XPyw1ZHpeQ/ScT2tzSN6re7SmnFy3x2n?=
 =?us-ascii?Q?8Iii2TpeI+14txtLz0Q8aSj8QYoypWjRFnqQ9Qq3+p4rBI0Vm6iwV56SOqRb?=
 =?us-ascii?Q?8Y16r346Rnd6apm3fYvuLrvsEgFxydeyDQJC/72DfvGjqmaAS3J9z8+cFZxq?=
 =?us-ascii?Q?HzWdHrL0o9BOAKXyAdYedgP0YTmwyOeuDrgHd+gRajeTYTrMu4fzdlCvsFCG?=
 =?us-ascii?Q?Qtlrs5H7gSy0kgDqz8TOX3Rn/479EMCFM+9fZ8cLGVrxOb6tX1wyLHgm5iGf?=
 =?us-ascii?Q?qHH4kavY/kgGJnlqAf4DBRV8y9QZII0Jm4uXbcFNmzAalv5H+TwxViV0Qx2R?=
 =?us-ascii?Q?skw8L+K9Yfb3Zd8huBUGr0ilI431fU89nt2kkHqJX4KdI0ScX0B8aKE25D8R?=
 =?us-ascii?Q?svvLe9UW/LmdBDSlZHNiqbsShaXpRs4QUj+ZzLiZB/I1a/dnldJwaAwclt7w?=
 =?us-ascii?Q?Ivga3zNiOYelPaA/OsxKSmOZ7B/7/l54+BXwwmJUgVVkVi6aOPHTgJV4LqO3?=
 =?us-ascii?Q?M+VWoSVJDuXgPm+c7+P221HPGSEOKySkqf5hyMGQbu9682qWbLEmCzVf4en2?=
 =?us-ascii?Q?bbrs9Dd9LzvDxfS2XPokJsqsbTniKGtg0pXOpJV8?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3AF87D498E27947B629B7FB8743677E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cbf2a6-f8a5-483d-2aca-08dbafcaa04a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 17:48:21.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUiiSCO0SjuMAoBthrbOOLnApAlaHsUHStaqq6fCIgLBJ7KJ22EFCeaH3oM6wKZzpVzetz7vKV2KSNdleDzt1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR05MB10381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 07-Sep-2023, at 8:17 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> !! External Email
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Currently when rmdir on an instance is done, eventfs_remove_events_dir()
> is called and it does a dput on the dentry and then frees the
> eventfs_inode that represents the events directory.
>
> But there's no protection against a reader reading the top level events
> directory at the same time and we can get a use after free error. Instead=
,
> use the dput() associated to the dentry to also free the eventfs_inode
> associated to the events directory, as that will get called when the last
> reference to the directory is released.
>

Nice catch Steve. Changes looks good to me.

Would like to know how did you map the backtrace with
use-after-free of eventfs_inode.

Thinking if same problem could happen for sub folder/files of eventfs as
free_ef() may get call earlier then dput().

-Ajay

> Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@hu=
awei.com/
>
> Cc: Ajay Kaher <akaher@vmware.com>
> Fixes: 5bdcd5f5331a2 eventfs: ("Implement removal of meta data from event=
fs")
> Reported-by: Zheng Yejian <zhengyejian1@huawei.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/202309051833=
32.628d7cc0@gandalf.local.home
> - Removed left over "ei" variable (kernel test robot)
>
> fs/tracefs/event_inode.c | 17 ++++++++++++-----
> fs/tracefs/inode.c       |  2 +-
> fs/tracefs/internal.h    |  5 +++--
> 3 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index fa1a1679a886..609ccb5b7cfc 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -185,17 +185,27 @@ static struct dentry *create_dir(const char *name, =
struct dentry *parent, void *
>
> /**
>  * eventfs_set_ef_status_free - set the ef->status to free
> + * @ti: the tracefs_inode of the dentry
>  * @dentry: dentry who's status to be freed
>  *
>  * eventfs_set_ef_status_free will be called if no more
>  * references remain
>  */
> -void eventfs_set_ef_status_free(struct dentry *dentry)
> +void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry =
*dentry)
> {
>        struct tracefs_inode *ti_parent;
> +       struct eventfs_inode *ei;
>        struct eventfs_file *ef;
>
>        mutex_lock(&eventfs_mutex);
> +
> +       /* The top level events directory may be freed by this */
> +       if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
> +               ei =3D ti->private;
> +               kfree(ei);
> +               goto out;
> +       }
> +
>        ti_parent =3D get_tracefs(dentry->d_parent->d_inode);
>        if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
>                goto out;
> @@ -510,7 +520,7 @@ struct dentry *eventfs_create_events_dir(const char *=
name,
>        INIT_LIST_HEAD(&ei->e_top_files);
>
>        ti =3D get_tracefs(inode);
> -       ti->flags |=3D TRACEFS_EVENT_INODE;
> +       ti->flags |=3D TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
>        ti->private =3D ei;
>
>        inode->i_mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> @@ -806,7 +816,6 @@ void eventfs_remove(struct eventfs_file *ef)
> void eventfs_remove_events_dir(struct dentry *dentry)
> {
>        struct tracefs_inode *ti;
> -       struct eventfs_inode *ei;
>
>        if (!dentry || !dentry->d_inode)
>                return;
> @@ -815,8 +824,6 @@ void eventfs_remove_events_dir(struct dentry *dentry)
>        if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
>                return;
>
> -       ei =3D ti->private;
>        d_invalidate(dentry);
>        dput(dentry);
> -       kfree(ei);
> }
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 3b8dd938b1c8..891653ba9cf3 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -385,7 +385,7 @@ static void tracefs_dentry_iput(struct dentry *dentry=
, struct inode *inode)
>
>        ti =3D get_tracefs(inode);
>        if (ti && ti->flags & TRACEFS_EVENT_INODE)
> -               eventfs_set_ef_status_free(dentry);
> +               eventfs_set_ef_status_free(ti, dentry);
>        iput(inode);
> }
>
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index 69c2b1d87c46..4f2e49e2197b 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -3,7 +3,8 @@
> #define _TRACEFS_INTERNAL_H
>
> enum {
> -       TRACEFS_EVENT_INODE     =3D BIT(1),
> +       TRACEFS_EVENT_INODE             =3D BIT(1),
> +       TRACEFS_EVENT_TOP_INODE         =3D BIT(2),
> };
>
> struct tracefs_inode {
> @@ -24,6 +25,6 @@ struct inode *tracefs_get_inode(struct super_block *sb)=
;
> struct dentry *eventfs_start_creating(const char *name, struct dentry *pa=
rent);
> struct dentry *eventfs_failed_creating(struct dentry *dentry);
> struct dentry *eventfs_end_creating(struct dentry *dentry);
> -void eventfs_set_ef_status_free(struct dentry *dentry);
> +void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry =
*dentry);
>
> #endif /* _TRACEFS_INTERNAL_H */
> --
> 2.40.1
>
> !! External Email: This email originated from outside of the organization=
. Do not click links or open attachments unless you recognize the sender.

