Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8857DFE12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjKCCOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKCCOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:14:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15919D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 19:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpkM5NXW7HXgqqeQxqwyGsTxhaLom+weSkVHSrxseXLEX8jj6+JmHx1vZd1TIEKZjG42Z2uqOrwbdvW6a3+vKopxljd5X7uu5QCZH20s74M/ATh1CTW+OZHSyHwCQYglj+/IgVWw2HeCqUovEMv1lR/Y/JVJfKdZIraiJLodvHuWBCgwOhFi6QSDz+ACEYR78uehl8s2tsNkCVOkkWfVWj66gyjmSM+I7Tgi/UZv03YHC1exTpGVyTuC3wWJXHaNLiArleZoXU8zQkLPSLjrnfD3P7DSwmcAeH+ZiRfFL8hLbXwf2VcBG6txlmKAkNj580Ui6KtRIu/AFBUbDBT/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15tZ2LJaOuu22E4NekJMAJW77eRSH/m8RrKRVzbjp6I=;
 b=HvP0xNNniFAixYIeBBsBdl6qNPgDkJ0hit61nvEf6K7wKGWViX3Mph1YaJUiHFF93V3lhsQc4TbRcmLotN+SRamw5XBGGmdQXpI1NT6wNgPu32zEUDRM8StLwarx43woq3frkRDky2x1x9ruXz1DfsXhTv8/W9IKOXmN+mtGb3GnBFSeNoJQYM1JEksGlv0JAau2hKGEWJOk49lsEaYAXoLE7uFJ3huu2uySUwwZkk8kkafyH9Wt31HLfd2QcDyU6ZB+W0PBH/ZsEreqMjcz4AExs8EVeBzAAX7fkTGgtXc4ZtmvqogX0Hsafqtmm6s/rMloIL9H+1VG3DsX0DEp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15tZ2LJaOuu22E4NekJMAJW77eRSH/m8RrKRVzbjp6I=;
 b=j46uNcRZZIiMBgmIfhXm0vWYGmScyFDYzJSoL1qWKg0zXkW+3mZnk7fLcN7JUT0mXMWYTLqKbx64gV1nCU9dRtJb5SUzFZ6a/n1gGFY8BSpmw7k40nce0WZYEi5lbJdTTYiff+jtxyM/nTIquVgJNXUtq/Vv0KBHDNAXowftuqjdsd6gkH0USSk1CRbRHOK0GUsfxhLmmLi+svg5KLrR91+26vusoS6QClZtZ788OCWjuckcEyfkui4j8upLtWritnV6oUwmoqcxU7osI4l/okh2WNjU5Yv8RpRFlL9uzBvrK/mo9SGyFXC4ZsnLAgcNETeMQ0j0Ok1TvgVhUsP1XA==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 02:14:29 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::f5fa:c2e3:56fb:fffe]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::f5fa:c2e3:56fb:fffe%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 02:14:28 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raag Jadav <raag.jadav@intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
Thread-Topic: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
Thread-Index: AQHaDescIVtwfbYixEa1fBHa2Td+xbBn2knA
Date:   Fri, 3 Nov 2023 02:14:27 +0000
Message-ID: <SJ0PR12MB5676C2514A46721EB8D60505A0A5A@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
In-Reply-To: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|SA1PR12MB6752:EE_
x-ms-office365-filtering-correlation-id: b7ec6963-1455-402f-9a42-08dbdc129b93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xVI5Fc5mvXxZjigg4Lptyexkb643IO23b9I7UEC/OSNazmXTia08JGS+gU85dyBGrZCpFMF7OdQ3hABlP66RHQqkKOzxiSUhePKXfjPMZXevSzwPjyIKgsKL0u02iGAo0m2cGnGdP0D30twKXp3RVI10iBiZkYbeeCPCPvRrU0Y8Aj/cWDlvWagV/56n5A/svTinuTy53eQAIqPIwkyu1bMciFpREEJo9MmDbVdtNh29wIzbI9uqn4Am0Y9DpsvD+T62Ou6EH0eDRoCRLt7Mu0TueyUtHfCPldc1gVupOicYDQVcwFz9xqV5irrt2xsWDZ6FVyRsrGgwzuiionFMj+EvkE4zhez8tesfPuJAKnPOGnutzn4uTL3PyzLzBt+bRh67f7V3nzJo35/FM9Hzgi/zNHngPTNDzssAgKDyGu0BgJM5CegxLKU+RUmvEShyLE9lemOhdBXtwYNMVuXXMHMVUinOkseTDjZMQm+ds32pXGHoVLYBmiXqx/SoKhGBr9mWoGGfXWBK5pijeIonnSCcDFCoMBxOc2QFkD2zD6JjlKPabbfy0RKYIhENIh5DFxi8TIrDOg6H+vNVwQ+IOJU6aIS9kTTATazlyBoINImOyjEgBU+vx6x+AWsFjfKFCp9AVuHcDmMy211BHcQVI/VNyIFVQdV6tc+hPRSOXQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66899024)(26005)(9686003)(55016003)(38100700002)(38070700009)(33656002)(86362001)(122000001)(2906002)(83380400001)(478600001)(6506007)(7696005)(53546011)(71200400001)(4326008)(52536014)(66556008)(66476007)(8936002)(54906003)(316002)(8676002)(66446008)(5660300002)(41300700001)(76116006)(110136005)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3muSJm/EBwBanmb17f+kUK0Eed6DbYVcXvzN7RZusUpdewDXxIHEF/4A4UXX?=
 =?us-ascii?Q?0v+Lhu0zh+AIn0bKxCAC2OfqoNqe0LfNwibNpMtXiZkSes3Gr+IFy141ev/U?=
 =?us-ascii?Q?cdN7O0dsjQMbYIFAzeL47rcuIAoRWL51iOWWDB6ZYRrzYK+lgPcXO2Sm6vdV?=
 =?us-ascii?Q?Un91o7/fE7jdyATEoIAw8NzlcyZ3VAaYqjcesdJKOSZAJDC6PJ7ZnbJbjggr?=
 =?us-ascii?Q?DLWIkJzSTfGYl47lolRnxePc1n6euvXGRhjwLZQI2AyFSOBmihTYAbK1wUHt?=
 =?us-ascii?Q?+4ODbdPEWROk41ZZ4EWlmtZzUUBw4mlTcfXJiVJvEYaLpeS1e9zK97tQdpF1?=
 =?us-ascii?Q?XeLCEZDzPneUI43lGCKdPm9XgOWxNHNGu82kOXYpff+7TDEyr8yOIBhRKuQ6?=
 =?us-ascii?Q?TwnHQ9rkxfIovQX/M6HJpUrwg2p5zXtvkcDNRJz5CeKK+hKfF00YjeeJwMYd?=
 =?us-ascii?Q?OtMi00d8xVnKJRP7WXL+Z+mFmEosg2cjPm3HzlG8L3jRxHnZqrxTAsZ603/W?=
 =?us-ascii?Q?oaw8EOzAofW6hrsmKzbggbLUqUG8eCoEnNNPnhcieXrqC5AdsI+/JgEl/HcC?=
 =?us-ascii?Q?Ai5Nefv2R8kyQeDdP5+ZmfgRy9hXFRqLlH5svkz+21gU7jxKDh+g++2BTQWO?=
 =?us-ascii?Q?1SrYH0fqWgOarpiAcOaACch3Exn+39+9KoxpYihG8MvDnPptqJ3JarMqZbW0?=
 =?us-ascii?Q?yhQte8vJOxHBDVfeXTQR5yq9K+qwEVgnJDXj14xOUP9tIsEDbHXSz10G8q7w?=
 =?us-ascii?Q?rWqB2VDMA7hQ7trmynb4FlYn2ZD7TwSGPYMCC0JRFoto4Nh2VP5NvXeg50st?=
 =?us-ascii?Q?VJ1FzsxDgxF4p0Z0HJMb8FUh7KJV6HYWPkScVXF+U7W1RJ7Wcywcl+9vHO3c?=
 =?us-ascii?Q?jRDcrT8qU0tL3QDX9afCUmSQLAko5KN4XihU0vt9v7gl9cRJluX0vL0doBjn?=
 =?us-ascii?Q?1BAyuUrGyLx5ZlcFr/ILSXVhOG+gsPd7b+vLe/5u/CT4b0ELLHcD4tqc/+qE?=
 =?us-ascii?Q?3XkffA9nFOoDo2raf6CMckH/IK4lMrd27/p457gGAfHOJ4tn4a3rgU5ONyiv?=
 =?us-ascii?Q?pQmyDoISnObOh31ZfLIWG/tku4LNRNGIN1HLUQ85MxnHnIjRLR1+hDmjX0XV?=
 =?us-ascii?Q?op3XxuewCMsV+tQavlzkstcl+jJtjvfJ7s/uZMvGVN3E66Z9Xr8nBPXx2gT8?=
 =?us-ascii?Q?+Wh8/Tdl6DFLrNm9Erl79WbgqgTKQ6xWGBilIuKFQZbRlrofg/03WYzzmAkj?=
 =?us-ascii?Q?LPNcYUkBYKJuWFzZWFhog26JeZdh9M3zpwKTbfqhss5/BPNhWmImgo/5qt+g?=
 =?us-ascii?Q?+jLO3CzYTnxrqNCBoBKfaLqrq5t1CtzWoF4eQ5PHjZdRlx57mJqjJ32COOpQ?=
 =?us-ascii?Q?jaO8i3EU+quMhnsOJ/7AAm4VERHi+S3OzaMIWq2MQHOLE3KYMckbb5huMcKB?=
 =?us-ascii?Q?yvdpYeIqtd1bzIAxqsMEZMW3jr/VZcIkGqZYV/uLGlGETfyaCcYhA5RYPJp5?=
 =?us-ascii?Q?f3TZDN4hmSyGdxjO5BP5PilLdn34p+ZmP+klUVvYOjuED/5qXMS/j0XedlZJ?=
 =?us-ascii?Q?2WWcLKAa1W4kNrLNSQA1TdgZdkNnWMP0qZcZY7um?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ec6963-1455-402f-9a42-08dbdc129b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 02:14:28.0397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOk0wbAgqdiBFSjZGIxYpbG4N/6xKhgT5CEAqB+KezNiChUvoZj57t9+ECqN7PMFLxdbUGdKM5BNRVfs2E/kfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilkka,

Thanks for fixing it.

Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>

Regards,
Besar

> -----Original Message-----
> From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Sent: Thursday, November 2, 2023 7:17 PM
> To: Besar Wicaksono <bwicaksono@nvidia.com>; Suzuki K Poulose
> <suzuki.poulose@arm.com>; Robin Murphy <robin.murphy@arm.com>; Will
> Deacon <will@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Raag
> Jadav <raag.jadav@intel.com>; Ilkka Koskinen
> <ilkka@os.amperecomputing.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Coresight PMU driver didn't reject events meant for other PMUs.
> This caused some of the Core PMU events disappearing from
> the output of "perf list". In addition, trying to run e.g.
>=20
>      $ perf stat -e r2 sleep 1
>=20
> made Coresight PMU driver to handle the event instead of letting
> Core PMU driver to deal with it.
>=20
> Cc: stable@vger.kernel.org
> Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight
> PMU driver")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
> b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 42b72042f6b3..2cc35dded007 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -676,6 +676,9 @@ static int arm_cspmu_event_init(struct perf_event
> *event)
>=20
>         cspmu =3D to_arm_cspmu(event->pmu);
>=20
> +       if (event->attr.type !=3D event->pmu->type)
> +               return -ENOENT;
> +
>         /*
>          * Following other "uncore" PMUs, we do not support sampling mode=
 or
>          * attach to a task (per-process mode).
> --
> 2.40.1

