Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FD17A7AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjITLrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjITLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:47:10 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2136.outbound.protection.outlook.com [40.107.114.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F9B0;
        Wed, 20 Sep 2023 04:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWEvWFK1D1ivA9ijiXhyjeUpj+UFNwuSdNEID9sRKfsEltoMu2c67fdpLtKe4q5KhaSqcMef5mkk4UuvQpzUI3Lau2E/+vXf0UHvHAgoqLFinpPPx1kLLmu82/DC8Dvh19JLYyOffUb/Nx2Bx2HR/4Tz5YfuxaJJ1gHG0RmYKJAhcFljByBqmODxQnQfRBRYq8k1wNiQBRHoHYEFbwR89AK0StxeACWHGTNjEaWP9U2bDDwoR5DkKasDwZOTjwqK9akBmoENfMEGHkB5FSWV0P7bYX5bBil9EpC05yQq2/53V+Y4cd40n6+VptQbzcHyM6P/0MBTeFp4aF0idBmAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9gSj/bUJ3giYfour0lSM/2pmT52qxMi14p/NX4CHRE=;
 b=OL06W4x/CQLM/NWZWuAkuO1ggRWyBi/fri3lJ0sf64ZYjIdLYVr8cVDbs8a8caJHf3kkxmMiwUwAFdyK02/aalYZP7iw8dkeYTT6lXhDa7erapFdVrJ4ELUnTV7wIC1LPrxkAkabj2fckRR0o9dXzDycsnp7TguCEVITkZceFeHcZuh1YuF4Xs20r8SQCnHdyO//DOYyCO8Vy1r6taS7APudeZvEs7QSFzVZpxj9rED29tzQQ9meyu65RO2wVrqdooPlvfb06Ytq8rLpgmqEXzA04GI2u3y6f9BHynKBxsSMizT0JynMvF2bWYZUi4i+mr1WU1SF0EHJU4vW/WQ6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9gSj/bUJ3giYfour0lSM/2pmT52qxMi14p/NX4CHRE=;
 b=n69Wp3sdAcMX32WopB7mjWQejRlmPhrEzcVyL34Y153KmYKdG5gtWm+8jXtzwXMnH0NXGMDadEWeTVem/u6huN6tIXVGm+uF/QqMZiOfDLX+ryxFBYmOujbVYmlIypl7BG3Vkype/+fYNyOBT+oIWI5EDtRRzhnjdsXKZMyzR70=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10517.jpnprd01.prod.outlook.com (2603:1096:400:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 11:47:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 11:46:57 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Trent Piepho <tpiepho@gmail.com>
Subject: RE: [Query]: Resource cleanup for Alarmtimer
Thread-Topic: [Query]: Resource cleanup for Alarmtimer
Thread-Index: AdnrmFAjUih7l1QlSdSObu7MvB/BAQAH7oWA
Date:   Wed, 20 Sep 2023 11:46:56 +0000
Message-ID: <OS0PR01MB5922E907FCC5B7638B9CA29A86F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <OS0PR01MB5922DD412F43E1C836E32AF486F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922DD412F43E1C836E32AF486F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10517:EE_
x-ms-office365-filtering-correlation-id: da2a09a3-12d0-4d8d-73eb-08dbb9cf4af5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nA11M2GFJEF+raIH1cymjhO4rGRpQciOgFvO2MELiEcIQRrS2MC89BrPPlgYsPtFJhwyE8L084cUcMqjZtPSWcBEnKv2U1mZ2yLXh9mmC4LIqihav88dPDkOmx6uc7pbcECwwO55XA8o8SDWuighIdFXqHe6ERW32DHgATWJ91GuSS0d1T9QUm+ZYprDYIzh+ifo/4D5GlVQxPduweDOwFDd2T5EKptHd9Vb7KntIJtsYB/z3PRDDRfqQF5dS/BxJ1uAQrsK4w38lyCbH4YKuU1YZX32a/6FDkcrxaHs2uS4BCry5aI5w+GDdo+wM5EUOsLlHRfh3rk48oUfDnGAxTGv6BW8wJNQMsTR1h8e7tBHQAMgtZzhErWassvFv4zoRhUZIV8CaRyw+vmgiSOoii5Hs+XAx3Qf0D233Vlo3J8v4K5uYSZ9WQcWT1lODnbDntT/2cz22Ok4HssruR9+/+esROxLEEj0tOmoBwbIUWUY+kmdDrzm46pyOvszvUR7QXV3u4vulG8MkNnh3kq4VBZZ7IUGOoJ6FVVn/hbvDsQTJP/HOZpYKk+UhFq93sOq1cN0xZC5hqfQaMCyTu5vtPnZ+7ovqkfGIs7QmqRC2R4FEpd7WK9prDPiLJHAtR93
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(1800799009)(186009)(451199024)(2940100002)(9686003)(6506007)(7696005)(71200400001)(122000001)(86362001)(38070700005)(33656002)(38100700002)(55016003)(4744005)(110136005)(66476007)(66556008)(316002)(64756008)(66946007)(54906003)(66446008)(76116006)(41300700001)(7416002)(2906002)(52536014)(5660300002)(8936002)(4326008)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4QbKqCyWfyzXSdQpNQrQ8nuWmB4tT9V1SIeOn0sS1DwxDdqFBsNKUu+fUEcw?=
 =?us-ascii?Q?eUxXRVoauCEZrtp3J0+NWvwsjZ60SjqyYLGT7G06Jy7zMcBoc8iugdXdqtjl?=
 =?us-ascii?Q?V+t7fodO8APd4FG88z2EiESK2VGqDGSp/6xfD42B5ZqGlYCrA2VE2Qe/rxnV?=
 =?us-ascii?Q?jMeB5YvcRURSpymEpFbz+BrqQmIOL0IGfCEe2GgBfG8pdGAV/34Nvz2sAD86?=
 =?us-ascii?Q?Rm5djXDDpemHaeUoQJpgJxpyIgEehb8qvCtOLizbm7NOAjbiKCKwrrq94iX0?=
 =?us-ascii?Q?gFztRM0HsvcLEPFC7KZfYH1jkVMAP8CdK8T/YHEpXstOCvX/DDFF+xasM3it?=
 =?us-ascii?Q?2EPHy/pUJOVUNrRiJFyP69DPUUya271ZfH4Yq+5BF6OkP1/Jv9v6CkB4dojR?=
 =?us-ascii?Q?rAAlBDGZ/qi+aMdPgB3alDMjsuwqwEMPkWJBqp6dF/5nleQvENXTlGEurx3c?=
 =?us-ascii?Q?J5YAqYVZyNzXIXZmW5IpGnjXKH3Febf/zPszvnd6PA+qOiHsoDp0LTfj3Obh?=
 =?us-ascii?Q?MQi2pvGnGLBV8LmpNAkURyttSsTajrfAdbKvfPxSMhq19AJS2ETWgQg8Gs/F?=
 =?us-ascii?Q?/S+PKyvkunbVdE/5IDKl0JhteHMD0ykNoXPvUeQCDQSSArBbfnQVF3NBywN/?=
 =?us-ascii?Q?b0vLOyyBZzRJg1Y+GUf+1yRvbJ875r+Ik5gxkOYJ9jJc3OcU4XdzvOfeIo2g?=
 =?us-ascii?Q?OXo6zJ312iSVLxfzj0d68fhSpzEBMORZtuHVtV7bC5XjokrxJ3ZvsqnAJxcy?=
 =?us-ascii?Q?kg/3g4eOaaUMcIsvo/iYwFs4rX9N84/XU8J3u7nFNX2auvX6nfiL4zRPeg7b?=
 =?us-ascii?Q?8e59BiK3mz1+TDojwhlGxbmvdjnyYGPtCfV5q1J7r9pEA6CAirzcO1hBUSwU?=
 =?us-ascii?Q?iHsrMOxnxRVPTXANxyraEXA4Z2YLt3WboPyRzwKadlLJGrEaGe8PxSedtIGV?=
 =?us-ascii?Q?0mnP7pJzFfn3sK6tGes+4QA/Y//yw84wFpGFdxq7Hi8JxvfJlLBav+zrbiQC?=
 =?us-ascii?Q?HJJ8QV1G5bjB+t5mcEcXELEcVVU6mJYCiRW5Vs7PDF/Y1or9aO4nt7hEYIEr?=
 =?us-ascii?Q?xa4Y6jO37Fx7Gxs01j72E4J31QoZ65SMUpQn87qEPMIedc6qbgf7tLnHrD2m?=
 =?us-ascii?Q?3dZFeDCyIeZgQRKmTrhMzxMfuMpHVgdc+gzu1BTf4NDLlg8/bmuedBFnnLHy?=
 =?us-ascii?Q?ivu2KRR+kTSYOVsOLoFoyKO1awwFfrZSdEg703dyM6P4+/AYJz2U4E2DdLlM?=
 =?us-ascii?Q?cAWzPbJZYprx+JqPp8QmgmVRO3tcoTUHocvOGyqvKQgnnxlP1xnN1BwuDxdU?=
 =?us-ascii?Q?KoDNrjNeRjPdLcAuwYbAdv//Mm/e9FqbpatFIl1ZT6yN5Xs81Jdla6c/Z3Nx?=
 =?us-ascii?Q?Iin56XwngKffc4v5jxR2sActKvephUxNImuieSSVQWIdeXYCToTNKpvf9xRu?=
 =?us-ascii?Q?wQWjVNY3u/JlnORsf4HiG2ufSTa/nxyXh9djzVuc/X3LZYDZrjB3BUuWdArk?=
 =?us-ascii?Q?Qv0WeLU6gsBVdJtdlsKhhwq5xvcnrREnuvtSMxco2NkVIIwOawrbomZHmnPY?=
 =?us-ascii?Q?roAGPEhmUS1makfkFVc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2a09a3-12d0-4d8d-73eb-08dbb9cf4af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 11:46:56.9779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BssCwHosGTEeijBuFrZsPcLwNa4kkGC1j60EOHe+xjzuKpHAqftC5oPnEmfu8W7Fnhn0MXwmH4w5mh1/znqShewnqUz2i2LGGVqFU7bIrUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10517
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI all,

I will send a patch to fix this issue soon. We will discuss
this topic there.

Cheers,
Biju

> Subject: [Query]: Resource cleanup for Alarmtimer
>=20
> Hi All,
>=20
> Currently unbind/bind is not working as expected on rtc-isl1208 driver. T=
he
> reason is put_device() is not calling rtc_device_release() as some of the
> kobjects are not freed during unbind.
>=20
> The commit 	c79108bd19a8 "alarmtimer: Make alarmtimer platform device
> child of RTC device" adds kobjects for alarmtimer device/sysfs, when we
> call device_init_wakeup() followed by devm_rtc_register_device()from the
> end point driver during probe().
> But these kobjects are never freed when we do unbind on the endpoint
> driver.
>=20
> The alarm timer device has alarmtimer_rtc_add_device() but it does not ha=
ve
> remove_device() callbacks to free kbjects.
>=20
> Q1) Has anyone tested unbind/rebind on RTC subsystem with
> device_init_wakeup() followed by devm_rtc_register_device() in the probe?
>=20
> Cheers,
> Biju
>=20

