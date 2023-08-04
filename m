Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C93770AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjHDV2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjHDV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:28:24 -0400
X-Greylist: delayed 3583 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 14:27:34 PDT
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44D6525A;
        Fri,  4 Aug 2023 14:27:33 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3749BXaA018796;
        Fri, 4 Aug 2023 20:27:21 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2171.outbound.protection.outlook.com [104.47.7.171])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3s8kh0gu0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 20:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsDSGxqXLl4RW6SNF9+EiVGGceTbJ+nBK3yB2OFTWI2Dfw492UAD7dIa6ma6ZaPLjGquKXLwfgbnuh7BPVnO61u4AWX1S2brIWlLpA8u9lSmLZLAD8UpgnqAAGPEP6pahl7pc/O8ZYl+komOjOypYcikJAU469fOh/XHF/8KKy9ksAVyt98ZIq3osR/t8AM+Y/7lMUbd+cAwg+m9mK1w9rf+K+K7VbHrVC8k5TgjeNjVGh5B8kvP3xzAbkasyLEWspQLbsPrkAlHk9Sg/0MpGAJuUtQQgp7ibb/daBzwIr1btQ9lHp9Zs+qoFo6jZEC4UqzoA2LnJndR7NRHp9SupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyX7CUOfYdUJXzNS5mopI7Ggmw+o4rPKN/aIhLAN1zI=;
 b=firczhuHGarRYf3FQ5XLTdg9Y67bZ+HMPypWFV0wj8YL0Cz8+lq6brpI+1fG6SggeiwENvW6+9ahmhF8YLCHbXIXebukxcCJ7gDRUGLzXLSWyt8fa1OtwfdocaTT8Dd29ir03COXcIVmzj4o9kuPGllJBQok/ye/Nr5rotcK6Q0knwyQril1QtchTSNdOMMKYe5zq6AQ1cqgDLTkOwOPAP0JSMLZTbuybLBz8FisXcrMiVpHHpkpbMaKYby2FdOWSHbcAFjVbPXyw1OM0pQfr3whpltKfnsmcQzBdY2k19uKsiZFxSddlCQTkF+bzeNp7wU3R1Uf4bRpOeVkm1f0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyX7CUOfYdUJXzNS5mopI7Ggmw+o4rPKN/aIhLAN1zI=;
 b=qjM/79oop4Pp9N7IvPFXfWWWg2fREuGQYMJiYqlXCQ00C/iBe3xaF9QsvmhVq2XuqCb6T3kpOI4VBKYKZvIX0zR7KfLIFNajmEARilTwTphogkj+9FXMPIoku3svARSiv7iPzYujZNWULPBxwj8BcvzL+tpSpVzVJcMS5GRJZ1JZ3sMcKoCLignT4J0BC/Gz5Rei3ithdf8655gBCeFvH2tekoSCCcdfIHIrMeyIgO3/r2BhhA01NECQXXNDxFwylYFd/C/zmVp5gbY/o80BnAHblUKZqY6IMtSvYdodYxun7fkaWnIB4pkAhEV/k//ofGe5I1umOzVNAo5KA1i8JQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BEZP281MB1974.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 20:27:11 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::200b:fe95:d1f4:7a3]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::200b:fe95:d1f4:7a3%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 20:27:15 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        "mkelly@xevo.com" <mkelly@xevo.com>,
        "francesco.diotalevi@iit.it" <francesco.diotalevi@iit.it>
Subject: Re: [RFC] IIO: MPU6050: fix level-triggered IRQ support caused crash
Thread-Topic: [RFC] IIO: MPU6050: fix level-triggered IRQ support caused crash
Thread-Index: AQHZv5/s8DaqfeMIx0OpvM1IJYR+va/Q10IAgAnDvYA=
Date:   Fri, 4 Aug 2023 20:27:15 +0000
Message-ID: <FR3P281MB1757BDF54460DAE5275590A7CE09A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230726090212.10641-1-andrea.merello@iit.it>
 <20230729154502.2aec850e@jic23-huawei>
In-Reply-To: <20230729154502.2aec850e@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BEZP281MB1974:EE_
x-ms-office365-filtering-correlation-id: 27cbdea3-5c46-4cdb-33b8-08db9529314c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBHfY4gQpQB1iYZl6TN8fm2I3WOGFDJfxTBfhh+Aw7+6TPsPacXoC0ocvKxsPxPFam8+DM5qUqjmjIEu9YRiG7NwczRJ+fAxwDxzt3NeGN2/p3UdrswdjLqmfsXFVXJXaUkxqJ/oQe81KhbOlgKr7uNJWvQUiLdhD6hqlgVx0JrW7F4Sw/tuPJxZOL5b7j2yGcZG1QPM/xyMftfXjJQmKn0IGwoutGmWkAIZ6zREb0yq51PyhIJlNF7y2W3IhzQJHN19bkR6eAGZsWMzO3qs3P7+Bk/Z2IY3CmmWD2d0xV2Itu8wxGr3VfMaw8MRa2YYD3eFTdv5jcckR+1Yctnkp17XNin4wLFlAWRiEuDcVsfxapqge99VoiCwB80bdNu7LQesXcqzE391rnvELXZjIj07cv6Js5fyHtM8mNB1uSiwESKHLB85pug9ht/KKBk7qecJG6p/OxYaYtW3IZdH6PdT3EIYQpkDUYQpRZQ5LcydhxMSBXxiFOYNJGmAx74HtidGZUnT9RztR8WcjbXCM8JwqErNW5SypbiKF/uxv6oo/EWE4iQB44hgg1VY/hzigQIfZEtib06mC5/w/QOTKrAM13dy0ny2mdNBcF8+4gYA0306GKlV2JwaR70inDyh17cqy9TMjB8H9RVSDvRh52RKX60oXPE7qcXcJtg+UO4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(376002)(39860400002)(186006)(451199021)(1800799003)(6506007)(122000001)(53546011)(38100700002)(38070700005)(83380400001)(2906002)(30864003)(52536014)(5660300002)(54906003)(478600001)(8936002)(8676002)(110136005)(86362001)(9686003)(4326008)(41300700001)(55016003)(7696005)(66446008)(66556008)(66476007)(91956017)(71200400001)(33656002)(76116006)(64756008)(66946007)(316002)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PommEnly5CQHhyqiJWlVW1kqHFiQIC6LMgwPAZ35bPAj5uFiist7HpnJR3?=
 =?iso-8859-1?Q?pCf3aQKw4PNwMZLwnkt8R4C4eJ4qjETO36ofZvv58t6t//crCOMlTkRZ0l?=
 =?iso-8859-1?Q?IW66trtHp3ePbSbW7Eun1Ypz9zC/ctFBVRoup8AgmU8s2fHP7S9/P21cut?=
 =?iso-8859-1?Q?omDi1Rtb5x8Ipkcq2PnX76LzgqcUS2s7zgEI1veOAnmd5axo6/K2/UkX+y?=
 =?iso-8859-1?Q?1s6rQGpYb40lKWeQSfRzPKvEfrPh3qz4QMJRwOUXYZg1ZB1+Tn4Apz30FF?=
 =?iso-8859-1?Q?+ZUCI1UBHP0QWZ7KJbtJBIh2jOGNCDW8zyOPFaCd0VmZ85iqggh6TXdIzp?=
 =?iso-8859-1?Q?eHQQWDtxQIi4tG5hysGFyD0VqYe5IeGt7I9vyFRnmEleEYP5B9VCxsuoy6?=
 =?iso-8859-1?Q?wb7GIlI90l4rZH8/5Z5v+0tZ/HPfaqOJqntuu5YFM1TeIDYNL4qXvynmkt?=
 =?iso-8859-1?Q?ds9X4gRXLyxfhVu+LJYNSI8XWDQdBRw0MgMX0/4ah9zAb+xLOhHaA6F7QO?=
 =?iso-8859-1?Q?pNLgfMchuYh5Xcv1p5yNnVT9AUUS7SfyOT6kDhiqlCsE42XNnzkSL6SY0h?=
 =?iso-8859-1?Q?eGlKPOU2eKmiw1wRNp8xLlZTFIlrT334XOn/3rRTVBitr2dhNciPYU976C?=
 =?iso-8859-1?Q?XWu9hrcqOD7bQGA3osDhAD4W8TgLoZw8BL5eaNp1y3xpOggqmIQMBbOW2m?=
 =?iso-8859-1?Q?gLHIedn3YYPt1FGTjWngQZg/bBeEFnoG25PukIaiWXbLpzheJYHHeCDVV6?=
 =?iso-8859-1?Q?UGwvaU0mJvZsEM1kfdJ+uvWKqKP4/Wg45J1qd864LcBgV9II9JZQlQPIT4?=
 =?iso-8859-1?Q?6MoY/eurQQjxXzO6zE0P6kWlvniUkd5sNdTE//7SQcli274f5VGGH6sqER?=
 =?iso-8859-1?Q?f2gFWZiShi72/LeCJGyVRs5NOb5GfS+40Dbs2LUVjRIr2lYdJlH1LW49Ur?=
 =?iso-8859-1?Q?+Y46mYa7qTZ85GP2M3rQhIIT6TkfYLahmMKHsNf456WvMTEw9co8Hra8/J?=
 =?iso-8859-1?Q?5xpYG3dP20388yqhQadazUCY6ixYwENHb07zgfH2ZaOFRHz4lGk/Z4yKSX?=
 =?iso-8859-1?Q?lgzD9qN0F+IW1pPjF26QuX+PjYsA/vMwLgmu6LS5lkgW8mZoBIA1rARMkW?=
 =?iso-8859-1?Q?NZla4OZ7z4HR1ffRxhy943JuljDDurPpvTxd7Mec5/ncVXsVvAKSW8+BAa?=
 =?iso-8859-1?Q?XK5aKRxnlmvm5AGBjn7Ia9IcFtx3OygwLR4TDwjD1Rh4UjZWbkcgQuG29y?=
 =?iso-8859-1?Q?c4p1lVs+pyExt7CLwa1f52wmn6xb45+4JI5sxtCwqj8sSF+Dqssf5JCcrj?=
 =?iso-8859-1?Q?1EZeVE0X4LIrlKhvr0XoiYtg0c+07MphwtdwzO5m/yiBiI1nq+fsmVmppz?=
 =?iso-8859-1?Q?i95ndrJ0kuudeoEg1Wn8MUZ7GWcH7ZuH0LaHOFl0vgORNBb9duemN41+W6?=
 =?iso-8859-1?Q?8tBErgX9vMYdacmF5hc2hoOLtTeSvgE7b+pAuggHxvgtaeQe4r0QsLu6lp?=
 =?iso-8859-1?Q?0j1DR5UPiQ8UMKfADshUSrM/lnaJxKuyOzbp6QAu1yU/Ux06C5D8NRdbyW?=
 =?iso-8859-1?Q?SisqxES03x4xETBsbgSz4nyebXHE0zdCNys808uK4xbuGpLLxEQmYJNee9?=
 =?iso-8859-1?Q?HhjLWgbIPp4KUF2Bsd9QDnIlMGhRseuc4v8Ky0S0RuuzYZ5ph6qC3syN2C?=
 =?iso-8859-1?Q?0AF4/OQAWJlm7xhRtF/d4YGI1nTZrijo4eMdnGmoMjiR6mysAMV+cuMW48?=
 =?iso-8859-1?Q?IeTQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cbdea3-5c46-4cdb-33b8-08db9529314c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 20:27:15.6044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxz19jJqekxOKjpgxxGTwffu8VFskkzWrJwfQXx8JMLBd+3J6ZfFPeCdInxk0upFiDu+K8tySFyy3MLoGawIUJhTxeJJDbjcUkOwVVUAsyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan and Andrea,=0A=
=0A=
thanks Andrea for spotting this issue.=0A=
=0A=
The problem I see, is that we need to read the status bit to check what is =
the interrupt cause. Currently, there is only 1 used (data ready), so it co=
uld work. But we are planning to add support for the Wake-on-Motion feature=
 that will generate an interrupt when data is going up a certain threshold.=
 In that case, reading the interrupt status bit is mandatory to generate th=
e threshold event and to know if there are some data to read.=0A=
=0A=
And reading the status bit will automatically clear the interrupt of course=
.=0A=
=0A=
We may need to disable interrupt before processing interrupt status bit and=
 reenable interrupt using the reenable trigger callback. I don't know if th=
ere is another way for doing that reliably.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Saturday, July 29, 2023 16:45=0A=
To: Andrea Merello <andrea.merello@iit.it>=0A=
Cc: lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio=
@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.o=
rg>; andrea.merello@gmail.com <andrea.merello@gmail.com>; mkelly@xevo.com <=
mkelly@xevo.com>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; =
francesco.diotalevi@iit.it <francesco.diotalevi@iit.it>=0A=
Subject: Re: [RFC] IIO: MPU6050: fix level-triggered IRQ support caused cra=
sh =0A=
=A0=0A=
[CAUTION] This is an EXTERNAL email. Do not click links or open attachments=
 unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
On Wed, 26 Jul 2023 11:02:12 +0200=0A=
Andrea Merello <andrea.merello@iit.it> wrote:=0A=
=0A=
> Updating kernel on my board caused crashes while using a MPU6050, more=0A=
> specifically when enabling its trigger. This seems due to commit=0A=
> 5ec6486daa98 ("iio:imu: inv_mpu6050: support more interrupt types").=0A=
> =0A=
> Since the said commit, the MPU6050 driver supports also level-triggered=
=0A=
> interrupts, other than rising-edge interrupts. Unfortunately=0A=
> level-triggered interrupts don't work here [0] causing IRQ floods [1],=0A=
> Oopses [2] and crashes. This even affected a previously-working setup [3]=
.=0A=
> =0A=
> I have to say that I'm not honestly completely sure how to interpret my=
=0A=
> Oopses, and that they are also pointing to the I2C controller and to the=
=0A=
> serial tty driver somehow. However I think that there is a real problem=
=0A=
> with the said IIO commit anyway; support for level-triggered IRQs seems=
=0A=
> broken to me due to the following reason:=0A=
> =0A=
> The handler for MPU6050 hardware IRQ is iio_trigger_generic_data_rdy_poll=
()=0A=
> which doesn't acknowleges the IRQ (i.e. the IRQ line remains asserted); t=
he=0A=
> IRQ is acknowledged only in the bottom half of the IIO softIRQ, registere=
d=0A=
> with devm_iio_triggered_buffer_setup(), which is inv_mpu6050_read_fifo().=
=0A=
=0A=
Agreed. iio_trigger_generic_data_rdy_poll() is only suitable for use with=
=0A=
either edge triggered or pulse type interrupts (which are basically edges=
=0A=
as well).=A0 The interrupt handler should not be simply returning IRQ_HANDL=
ED if there=0A=
is a need to disable / mask the interrupt (which there always is for a leve=
l=0A=
interrupt).=0A=
=0A=
> =0A=
> I think that in this way the hardware IRQ is re-enabled before the IRQ is=
=0A=
> acknowledged to the IMU. When the IRQ is level-triggered, the IRQ line=0A=
> remains asserted causing the hardware IRQ handler to be reentered,=0A=
> generating a (fake) IRQ storm (while when interrupts are edge-triggered t=
he=0A=
> IMU just generate one pulse until acknowledgment, I guess).=0A=
=0A=
Makes sense.=0A=
=0A=
> =0A=
> Just adding IRQF_ONESHOT to the hardware IRQ flags apparently doesn't mak=
e=0A=
> any difference, because it would just defer the IRQ re-enable to the bott=
om=0A=
> half of the very same (hardware) IRQ handler, while, in my understanding,=
=0A=
> here the interrupt acknowledgment happens in the bottom half of the *soft=
*=0A=
> IRQ, which is another IRQ indeed.=0A=
=0A=
Lets go with sort of for that - they are conceptually different interrupts,=
=0A=
but the top half of the pollfunc runs directly from the iio_trigger_poll ca=
ll=0A=
as well masking the downstream interrupts and kicking off their threads.=0A=
=0A=
Key here is that the top IRQ handler is return IRQ_HANDLED so that stuff=0A=
is all irrelevant - the interrupt is unmasked.=0A=
=0A=
> =0A=
> The following PoC patch moves the interrupt status register read (which=
=0A=
> also acknowledges the IRQ) to the bottom half of the *hardware* IRQ=0A=
> handler, which now becomes a threaded IRQ with the IRQF_ONESHOT flag.=0A=
> =0A=
> This seems to work. The softirq handler doesn't hopefully really need to=
=0A=
> look at the interrupt status register because it will give up early anywa=
y=0A=
> when it finds no data in the IMU FIFO.=0A=
> =0A=
> I have to say that I'm not really sure this is a good way to fix things;=
=0A=
> possibly someone has advices for a better fix (RFC).=0A=
=0A=
One common approach is to mask the interrupt at source if that's possible=
=0A=
(or at destination in worst case).=A0 The triggers have a reenable that=0A=
is then called only once all downstream consumers have handled a trigger=0A=
- that is used to then unmask the interrupt at source.=A0 Here the challeng=
e=0A=
is that overlaps with reading the register.=A0 We tend to cheat a bit when=
=0A=
this happens and either not have a reenable callback or have one that=0A=
reads the register again (to support other consumers of this trigger if=0A=
this device isn't consuming it's own trigger).=0A=
=0A=
An Ack before reading the data back isn't ideal but it may be the best=0A=
approach for this particular case.=0A=
=0A=
> =0A=
> In case this fix turns out to be not adequate, and no-one has a better on=
e,=0A=
> then I'd propose to revert the level-triggered interrupt support (and may=
be=0A=
> make the probe failing whenever an unsupported IRQ type is requested?).=
=0A=
> =0A=
> [0] Here I'm on a custom board with a Zynq7000 SoC (IRQ controller suppor=
ts=0A=
> both raising-edge and level IRQ) and an MPU9250 IMU. I've done most work =
on=0A=
> a 5.15 customized kernel, but I've tried also with latest mainline tree a=
nd=0A=
> I got the same results.=0A=
> =0A=
> [1]=A0 when running:=0A=
> =0A=
> root@arm:/sys/bus/iio/devices/iio:device2/buffer0# echo 1 > enable ; slee=
p 5; echo 0 > enable=0A=
> =0A=
> on a 5.15 kernel the system somehow survived, despite Oopses and=0A=
> complaints, so I could give a look to /proc/interrupts:=0A=
> =0A=
> 64:=A0=A0=A0 1119991=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0 GIC-0=A0 68=
 Level=A0=A0=A0=A0 inv_mpu=0A=
> 65:=A0=A0=A0=A0=A0=A0=A0=A0 55=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0 mpu9250-de=
v2=A0=A0=A0=A0 Edge=A0=A0=A0=A0=A0 mpu9250_consumer2=0A=
> =0A=
> The hardware IRQ counted an unreasonably huge number of interrupts, while=
=0A=
> the trigger softirq counted a reasonable number of interrupts.=0A=
> =0A=
> (On a working system i.e. before the blamed commit, or after my patch,=0A=
> these two counters count the same number of IRQs)=0A=
> =0A=
> [2] Depending by a number of factors (e.g. RT-patch, kernel debug=0A=
> configuration options, kernel version) I got some different complaints. T=
he=0A=
> following is the one I grabbed from the latest git tree kernel.=0A=
> (irq/47-41620000/45 refers to the I2C controller to witch the IMU is=0A=
> attached to):=0A=
> =0A=
> [=A0 250.941155] sched: RT throttling activated=0A=
> =0A=
> [=A0 275.557147] rcu: INFO: rcu_sched self-detected stall on CPU=0A=
> [=A0 275.562749] rcu:=A0=A0=A0=A0 0-....: (26689 ticks this GP) idle=3D89=
dc/1/0x40000002 softirq=3D20591/20592 fqs=3D6234=0A=
> [=A0 275.563143]=0A=
> [=A0 275.563148] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> [=A0 275.563152] [ BUG: Invalid wait context ]=0A=
> [=A0 275.563156] 6.5.0-rc3+ #17 Not tainted=0A=
> [=A0 275.563163] -----------------------------=0A=
> [=A0 275.563166] irq/47-41620000/45 is trying to lock:=0A=
> [=A0 275.563173] c20ff850 (&port_lock_key){-.-.}-{3:3}, at: cdns_uart_con=
sole_write+0x130/0x164=0A=
> [=A0 275.563226] other info that might help us debug this:=0A=
> [=A0 275.563230] context-{3:3}=0A=
> [=A0 275.563235] 4 locks held by irq/47-41620000/45:=0A=
> [=A0 275.563242]=A0 #0: c147d510 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_=
clock_irq+0x87c/0x12f0=0A=
> [=A0 275.563285]=A0 #1: c1416b30 (console_lock){+.+.}-{0:0}, at: vprintk_=
emit+0x100/0x320=0A=
> [=A0 275.563327]=A0 #2: c1416b98 (console_srcu){....}-{0:0}, at: console_=
flush_all+0x68/0x664=0A=
> [=A0 275.563361]=A0 #3: c1416c24 (console_owner){-.-.}-{0:0}, at: console=
_flush_all+0x1c4/0x664=0A=
> [=A0 275.563395] stack backtrace:=0A=
> [=A0 275.563399] CPU: 0 PID: 45 Comm: irq/47-41620000 Not tainted 6.5.0-r=
c3+ #17=0A=
> [=A0 275.563412] Hardware name: Xilinx Zynq Platform=0A=
> [=A0 275.563420]=A0 unwind_backtrace from show_stack+0x10/0x14=0A=
> [=A0 275.563450]=A0 show_stack from dump_stack_lvl+0x68/0x90=0A=
> [=A0 275.563474]=A0 dump_stack_lvl from __lock_acquire+0x61c/0x1778=0A=
> [=A0 275.563494]=A0 __lock_acquire from lock_acquire+0x1e4/0x368=0A=
> [=A0 275.563512]=A0 lock_acquire from _raw_spin_lock_irqsave+0x54/0x68=0A=
> [=A0 275.563534]=A0 _raw_spin_lock_irqsave from cdns_uart_console_write+0=
x130/0x164=0A=
> [=A0 275.563564]=A0 cdns_uart_console_write from console_flush_all+0x220/=
0x664=0A=
> [=A0 275.563595]=A0 console_flush_all from console_unlock+0x88/0xd4=0A=
> [=A0 275.563624]=A0 console_unlock from vprintk_emit+0x25c/0x320=0A=
> [=A0 275.563653]=A0 vprintk_emit from vprintk_default+0x20/0x28=0A=
> [=A0 275.563682]=A0 vprintk_default from _printk+0x30/0x54=0A=
> [=A0 275.563715]=A0 _printk from print_cpu_stall_info+0x2b0/0x490=0A=
> [=A0 275.563742]=A0 print_cpu_stall_info from rcu_sched_clock_irq+0x890/0=
x12f0=0A=
> [=A0 275.563766]=A0 rcu_sched_clock_irq from update_process_times+0x54/0x=
8c=0A=
> [=A0 275.563793]=A0 update_process_times from tick_sched_timer+0x50/0xac=
=0A=
> [=A0 275.563825]=A0 tick_sched_timer from __hrtimer_run_queues+0x2f0/0x59=
8=0A=
> [=A0 275.563851]=A0 __hrtimer_run_queues from hrtimer_interrupt+0x130/0x2=
ac=0A=
> [=A0 275.563873]=A0 hrtimer_interrupt from twd_handler+0x30/0x38=0A=
> [=A0 275.563897]=A0 twd_handler from handle_percpu_devid_irq+0xb0/0x2b4=
=0A=
> [=A0 275.563928]=A0 handle_percpu_devid_irq from generic_handle_domain_ir=
q+0x24/0x34=0A=
> [=A0 275.563950]=A0 generic_handle_domain_irq from gic_handle_irq+0x84/0x=
ac=0A=
> [=A0 275.563981]=A0 gic_handle_irq from generic_handle_arch_irq+0x34/0x44=
=0A=
> [=A0 275.564009]=A0 generic_handle_arch_irq from call_with_stack+0x18/0x2=
0=0A=
> [=A0 275.564032]=A0 call_with_stack from __irq_svc+0x9c/0xb8=0A=
> [=A0 275.564048] Exception stack(0xf0935e48 to 0xf0935e90)=0A=
> [=A0 275.564062] 5e40:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 ffffffff ffffffff 00000001 00000403 ef7cb080 00000000=0A=
> [=A0 275.564074] 5e60: c1be107c c4b01040 d1377d58 2e465000 c0d4b0d8 f0935=
ed4 00000000 f0935e98=0A=
> [=A0 275.564082] 5e80: c015a054 c015a058 600f0013 ffffffff=0A=
> [=A0 275.564089]=A0 __irq_svc from finish_task_switch+0xe4/0x2b4=0A=
> [=A0 275.564119]=A0 finish_task_switch from __schedule+0x394/0xd9c=0A=
> [=A0 275.564149]=A0 __schedule from schedule+0x60/0xbc=0A=
> [=A0 275.564176]=A0 schedule from irq_thread+0xd0/0x238=0A=
> [=A0 275.564201]=A0 irq_thread from kthread+0xf4/0x12c=0A=
> [=A0 275.564231]=A0 kthread from ret_from_fork+0x14/0x28=0A=
> [=A0 275.564251] Exception stack(0xf0935fb0 to 0xf0935ff8)=0A=
> [=A0 275.564261] 5fa0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00000000 00000000=
 00000000 00000000=0A=
> [=A0 275.564271] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000=0A=
> [=A0 275.564280] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000=0A=
> [=A0 275.886419] rcu:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hardirqs=A0=
=A0 softirqs=A0=A0 csw/system=0A=
> [=A0 275.891989] rcu:=A0=A0=A0=A0=A0 number:=A0 2641898=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=0A=
> [=A0 275.897561] rcu:=A0=A0=A0=A0 cputime:=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0 12997=A0=A0 =3D=3D> 13007(ms)=
=0A=
> [=A0 275.904523] rcu:=A0=A0=A0=A0 (t=3D26010 jiffies g=3D36053 q=3D115 nc=
pus=3D2)=0A=
> [=A0 275.909924] CPU: 0 PID: 45 Comm: irq/47-41620000 Not tainted 6.5.0-r=
c3+ #17=0A=
> [=A0 275.916891] Hardware name: Xilinx Zynq Platform=0A=
> [=A0 275.921413] PC is at finish_task_switch+0xe4/0x2b4=0A=
> [=A0 275.926213] LR is at finish_task_switch+0xe0/0x2b4=0A=
> [=A0 275.931013] pc : [<c015a058>]=A0=A0=A0 lr : [<c015a054>]=A0=A0=A0 ps=
r: 600f0013=0A=
> [=A0 275.937280] sp : f0935e98=A0 ip : 00000000=A0 fp : f0935ed4=0A=
> [=A0 275.942505] r10: c0d4b0d8=A0 r9 : 2e465000=A0 r8 : d1377d58=0A=
> [=A0 275.947722] r7 : c4b01040=A0 r6 : c1be107c=A0 r5 : 00000000=A0 r4 : =
ef7cb080=0A=
> [=A0 275.954249] r3 : 00000403=A0 r2 : 00000001=A0 r1 : ffffffff=A0 r0 : =
ffffffff=0A=
> [=A0 275.960777] Flags: nZCv=A0 IRQs on=A0 FIQs on=A0 Mode SVC_32=A0 ISA =
ARM=A0 Segment none=0A=
> [=A0 275.967914] Control: 18c5387d=A0 Table: 04b8404a=A0 DAC: 00000051=0A=
> [=A0 275.973661]=A0 finish_task_switch from __schedule+0x394/0xd9c=0A=
> [=A0 275.979258]=A0 __schedule from schedule+0x60/0xbc=0A=
> [=A0 275.983806]=A0 schedule from irq_thread+0xd0/0x238=0A=
> [=A0 275.988442]=A0 irq_thread from kthread+0xf4/0x12c=0A=
> [=A0 275.992990]=A0 kthread from ret_from_fork+0x14/0x28=0A=
> [=A0 275.997702] Exception stack(0xf0935fb0 to 0xf0935ff8)=0A=
> [=A0 276.002757] 5fa0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 00000000 00000000=
 00000000 00000000=0A=
> [=A0 276.010936] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000=0A=
> [=A0 276.019110] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000=0A=
> =0A=
> [3] Previously, even if the DT node configured the IRQ as level-triggered=
,=0A=
> the MPU9060 driver changed it to edge-triggered, because it was the only=
=0A=
> supported mode. This made things working in my case. Now with the very sa=
me=0A=
> DT the IRQ is configured as level (which in principle should be correct)=
=0A=
> but things stopped working indeed.=0A=
> =0A=
=0A=
We will want to prune that description down a lot for any patch going upstr=
eam.=0A=
Just keep the relevant parts to actually spotting the problem which I think=
 is=0A=
mostly a comment on there being far too many interrupts and rcu errors due=
=0A=
to that storm.=0A=
=0A=
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>=0A=
> ---=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=A0=A0=A0 | 11 -------=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 31 ++++++++++++++++---=
=0A=
>=A0 2 files changed, 26 insertions(+), 16 deletions(-)=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_ring.c=0A=
> index 45c37525c2f1..b87ca50dc1c1 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> @@ -122,21 +122,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
>=A0=A0=A0=A0=A0=A0=A0 u16 fifo_count;=0A=
>=A0=A0=A0=A0=A0=A0=A0 s64 timestamp;=0A=
> -=A0=A0=A0=A0 int int_status;=0A=
>=A0=A0=A0=A0=A0=A0=A0 size_t i, nb;=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
>=A0 =0A=
> -=A0=A0=A0=A0 /* ack interrupt and check status */=0A=
> -=A0=A0=A0=A0 result =3D regmap_read(st->map, st->reg->int_status, &int_s=
tatus);=0A=
> -=A0=A0=A0=A0 if (result) {=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st->map),=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "failed to =
ack interrupt\n");=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto flush_fifo;=0A=
> -=A0=A0=A0=A0 }=0A=
> -=A0=A0=A0=A0 if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
> -=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!(st->chip_config.accl_fifo_enable |=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.gyro_fifo_en=
able |=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->chip_config.magn_fifo_en=
able))=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> index 882546897255..b1384d729ced 100644=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> @@ -217,6 +217,26 @@ static const struct iio_trigger_ops inv_mpu_trigger_=
ops =3D {=0A=
>=A0=A0=A0=A0=A0=A0=A0 .set_trigger_state =3D &inv_mpu_data_rdy_trigger_set=
_state,=0A=
>=A0 };=0A=
>=A0 =0A=
> +irqreturn_t inv_mpu6050_trigger_irq(int irq, void *private)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D private;=0A=
> +=0A=
> +=A0=A0=A0=A0 iio_trigger_generic_data_rdy_poll(irq, st->trig);=0A=
> +=A0=A0=A0=A0 return IRQ_WAKE_THREAD;=0A=
> +}=0A=
> +=0A=
> +irqreturn_t inv_mpu6050_trigger_thread_fn(int irq, void *private)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D private;=0A=
> +=A0=A0=A0=A0 int int_status;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=A0=A0=A0=A0 regmap_read(st->map, st->reg->int_status, &int_status);=0A=
=0A=
Why do you need the lock?=A0 =0A=
=0A=
It would be fine to cache the content of the register in st so=0A=
that the pollfunc triggered handler can see what was there.=0A=
*sigh* - why do people think read to clear is a sensible hardware design.=
=0A=
It saves an access cycle, but makes software messy.=0A=
=0A=
As you say, that may not be necessary if there are other paths to cheaply=
=0A=
check if there should have been an interrupt.=0A=
=0A=
General approach looks fine to me - but I would like inputs from=0A=
others more familiar with this device than I am.=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 return IRQ_HANDLED;=0A=
> +}=0A=
> +=0A=
>=A0 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)=
=0A=
>=A0 {=0A=
>=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
> @@ -229,11 +249,12 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio=
_dev, int irq_type)=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!st->trig)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
>=A0 =0A=
> -=A0=A0=A0=A0 ret =3D devm_request_irq(&indio_dev->dev, st->irq,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 &iio_trigger_generic_data_rdy_poll,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 irq_type,=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 "inv_mpu",=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 st->trig);=0A=
> +=A0=A0=A0=A0 ret =3D devm_request_threaded_irq(&indio_dev->dev, st->irq,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &inv_mpu6050_trigger_irq,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &inv_mpu6050_trigger_thread_fn,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 irq_type | IRQF_ONESHOT,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "inv_mpu",=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st);=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>=A0 =0A=
