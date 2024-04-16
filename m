Return-Path: <linux-kernel+bounces-146375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD98A6471
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C80828193A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844A371B30;
	Tue, 16 Apr 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PdgSdka2"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751C6DCE8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250910; cv=fail; b=n1P/3yI+sb9t1MfeB8OnfoLXUWWcEKrqwLr0PjFVuK4vkgQwAR/T5r0Q7BZM34y4GMDskX/uPciAStQCS3pDMDBFFsDTzw+1QtF/R2D2Z9xPPrl+5ycA3rEff9jOvc6uIiQg2TQxgRqOnLVlUxDR7Tet8zn/O33mfxXueUuMFUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250910; c=relaxed/simple;
	bh=N6eHiGMG1BYbjiN+nNcm5r8zUN1HP4g9bsR/ZjbGl/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5dYaj062aotdj5jTVde2tFjMz8/fnz0m+kjJxku5/+V9Ctt8W8yff1q7ofOcmBFrtcwuD7Lu8QQy7syhlLr/DKbVl84a6GD7d01iVrf6+nJXmVjVL0UwKeUeCVE0SSVvsM+lue0S/m2QRNu9w8eGkDIUP9BOYw+2JxzOY+j/8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PdgSdka2; arc=fail smtp.client-ip=40.107.8.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g62u8qfH3MKV92NcoGhYahB5wO9OFT4wCuFuRiQDmuVayJRLV+hfYErmczqWbWnHbQGRg4/c3+Ej9LDO9Dz41FBJp0cwwk5cC0Lqj+KrcO/mSyjwdZrzK+Br5YCQf1UQjMq1JBcVQa6QJTY5edERVhCVgNvNQStU8psb59yZcYTlK5clftMCjC+XMtRNio0CIDRdXY9lIQwmX8pipbwTqdSzGtEof0YrG+Q+hMwyW/2vA48vqvYEQnrHKJse9t8xfhDqlc5wOMQ+9I1COip08Yz/0NWIU7LcwEOXiSly3YVnB+RqEbkop9QdmH4GRjwdPSJGulS7vPUc6T6FCs6R+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw/IHF5MtnixgLwCw1daeffbHeAWIjj1tFLMBtBxE6E=;
 b=CK/R7UP+mpDKkc3Mm4X31eK6hGUh68ixouPUldKjL5B9BXvIRAGrWGmEc2G+DSjKxD8WNrXOEjaGJNXoxGICI5vkfVD/QwhNVWbwBo7UIL5cTuSXn6nKpgrwgEyybW/S5TWg71hYJ/sDkXhVZmjsDxwRPG4/oAJ3s901DO+EW2Z+D4DDpAdnBq1kHxX5BPYFuiCy31Et77xMr9GoGrC/tHYb/fHhMa21ytsNB71m19CB3TsKY+nD/LV/n3xgzf1yZ21k0QgRwILxRmr9lJivgEizKyuVGdkzyYPytWsKVxZP0/oMU6gmxUND7whH1o/tJ/imBKq9qydUB9pIJ43IoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw/IHF5MtnixgLwCw1daeffbHeAWIjj1tFLMBtBxE6E=;
 b=PdgSdka2fwC5m9rI01Gbgc8sdPOmqzpuZQDrVr4ek6I7zYgMD1/YIfRImjz9+ngPuUdwFHqkkBT7DVGVCWtVMe2md1rXwXr+rHK6alu3hWPS5y3UwYvhhHoFGH0uwYVKgUUKBW1S9AvyRdCqQtQKNs60DsSxj+xUtkcsxxcwXjY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB10197.eurprd04.prod.outlook.com (2603:10a6:150:1a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 07:01:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 07:01:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Thread-Topic: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Thread-Index: AQHajxwygJMjjnYsXEamYB79VvBL0LFpzXAAgACrohA=
Date: Tue, 16 Apr 2024 07:01:42 +0000
Message-ID:
 <DU0PR04MB9417AC020C28AD5847CAB24088082@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240415101141.1591112-1-peng.fan@oss.nxp.com>
 <Zh2R4FZPmVOigfT9@pluto>
In-Reply-To: <Zh2R4FZPmVOigfT9@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GV1PR04MB10197:EE_
x-ms-office365-filtering-correlation-id: bdb67739-d3bc-4bfa-198f-08dc5de3122a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vdZX4nbumY+2CoeLey15Y+H2Db8lPkWfVOzV1JPiEBii0oOjlYfzJME91GuGSayUxL2r15/DFGNb7BmKHH1M5mtgf3jeqF2KmctIDTFZxTr/v1xCqstGYPVHcbzNMmYCUCPthx8TiYIOHodhghR3vFB6EyyObb7TsuZdAqrFeTpW8pYkdzAY1m+CwebVmmF7nuI07xRqcI+dgeWjz4UwJc2h+Z1pWcf5FUAvgO0e0/N7T1osgoVYaBxjfNzZh9Bl8p1G+CUD0wfn8TxjdA1XpQVkUqCpAW8OkTxZjpbnKUb+DEGoB+ImYLXKjxw2xWIS2XWhHkds3k/mSn+ArF2K1faAW2ec0qZVuoKv1eEqSGD+HBTraQVkOdwhdR9E0359NY9eVUAcTQRFPKWZcv77Kdo7wPkrXK+ueEJzDsMXePKwVTu58aqeYSQYAadNJIVJ7oRQe2J7yyOcao+SbP3b8qd4utBuKjUZ+ccusvim0+y2uAiLsi/+9ziCgS56kH4ZAISC/H2jWsNDaCD/VQiplmAoNISDfb/K31JDmGamJHOFpRZFoAxjdG5AakDQXaON1V/N1vScQdRLLk8lDkjMmGU0WUTtuHj5iwTECzLktFgbTA5I8SV4xd1BGQx6P7eEOlXpGgxz8HwNi9Q8keEKZ5eOxsW1e5fnU6aD3yer4uTUF2rLOfJghnDSWyexiYi0La2uG4Kn56S8J1RNvvkvfycYJnKfo256NP+8ff8SJ3Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?27kNXSx3LpwcffKxDma6F8037B986rJ484kiFlggqr3QRRbCR3y9kFmp+KbK?=
 =?us-ascii?Q?5Ke4BqqDt8bje2vB5uqqAbfDBef+AGnHVLSRUCRtQ+ExLF9jTF4YXZ8Tpo9Z?=
 =?us-ascii?Q?zWK8pSVcddGhmVWJzxgsT0gJyb7BGCch5avTO/iY1byx6ntSQk24DX9cRDxm?=
 =?us-ascii?Q?nPqY7/MFIzdqEJcA7LcHZWxnK39bOo3XF/1+9GsxiMsX8ck4PsVw4sDY26eC?=
 =?us-ascii?Q?Zyp23CqnhLUSyMhEUw9ZLqsRDmMMzqWumfOphyXThwOzKZ8cmCZEZkGNsbVO?=
 =?us-ascii?Q?CKrncV7bTClrjWViAJsDdpL6hWjQw6KH9aSWd8YCXVLFdIk5EUDehG7338Y1?=
 =?us-ascii?Q?A3kOm4Ml9nMioeTdjekQdqevIZTzaJHsUrVrsODrlCeIlcFnnqrZPZjW2Cqp?=
 =?us-ascii?Q?LxEYs4hEwW4zCJnXxZHdryFonf7O8sbW6mUwUIzLUoXZha3pu3/PWdwn3ii8?=
 =?us-ascii?Q?H+V4f39+2qAT76CzQXgMI/83SXfgJGxC5UY/1O3g8ZBSFqhf3JHgzARbEZ6Z?=
 =?us-ascii?Q?FrbZRmuRsbidVxOBJ5hC1N5rfWQr+y/2JFA5L3DiOHnI7A0VySbGWB6LjR1q?=
 =?us-ascii?Q?D6VBnA7eBGco8ClHWiStjqgYCTKRJThNRFdJoLeKWGWfe/Zq+UalnYsd+PUY?=
 =?us-ascii?Q?AOTOdw5rPr6D/99n87uNiLM4F/qFBZWNfIDvf/0EkraGC+i3Uo2pFDsYs/mR?=
 =?us-ascii?Q?M9PftI3gh4G2IEgoM9zmV/qMwIvHNZyfNN2l70TBOzGM5A79SiYlIQb1iaFe?=
 =?us-ascii?Q?rwfJByx2B9DNprr701egAS+EMj++Few62OiJlrQfep9yx5rWHRqdmpVy0lCG?=
 =?us-ascii?Q?jFF4vjDV096d9zrrz61B0DsN6rX4ZS+dq9pr1bMxggJerYi4VYwF3/Bc93sD?=
 =?us-ascii?Q?+BnlO3b7+/udSKUt9FLSnNOJXPrX+nXKrXNeAx6jkgnfG0yGoZ+BacCiSPHx?=
 =?us-ascii?Q?cci25Q4wrRDUoGKwRDPr4ZBfhedOnrYsIhqzjVgHrFt3Yu5o9JspnASxe/f+?=
 =?us-ascii?Q?Y04U5s4iVWC6B9d7B2xyBHXu3M5iKAZK5///fy0LWD4pgMphVfDkr0jitB8g?=
 =?us-ascii?Q?LW4VTl+3A+YhjVJl5F1E2kAnO0uL9KNhXCg2KbldMHJZThOQQMARWOFDZtNq?=
 =?us-ascii?Q?c66W0KhNp3DngOXO77Q8C9QTYoS1dT0jRYc5QdmkAmE6S/qMa+92XOzRVhRz?=
 =?us-ascii?Q?TMevOlNrSPN8lbnlqSPEPi2KHfHhdXz/J0vAi4L5mqYC2TuKyR5XZNMR83lO?=
 =?us-ascii?Q?tzt9ASuWcwYNop3Aaq4vvfyi5S8/EmuynSzpDqjsg/cZLHtT9srsPCOQBDcW?=
 =?us-ascii?Q?rkRi9SlRtPUqz0q7goPv2TS91T15hcLX0I7bgl8jEuFS3iscdxEAdJGp8Tdn?=
 =?us-ascii?Q?EQrcdZr2W9RCC0AslN29mp08Dh4txTwAsjFxAz8hoLUJLipE067sx4JZYGMR?=
 =?us-ascii?Q?x7DkqEA/enmf1/Jxa/tO3mHPZtzAM794M23XugXsyMySoCCE1F5u9Ql3FBIf?=
 =?us-ascii?Q?EY+kfIdPDk9TmjncXTS/9mFeP0xrf+Z/7AxH+2Jm+4qK57XLns2ECkJGW8Qh?=
 =?us-ascii?Q?JoaXn6EeKUfdai+9m3M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb67739-d3bc-4bfa-198f-08dc5de3122a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 07:01:42.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LH6Gv1oyHsvbkHlucQdRtEyZjAeqYpFEtok1lstGLuBNQS5fYNcfiHXD8hX7Lz69tdJVHVaYv7hnzYSXlPaIuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10197

Hi Cristian,

> Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
> command
>=20
> On Mon, Apr 15, 2024 at 06:11:41PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Support System suspend notification. Using a work struct to call
> > pm_suspend. There is no way to pass suspend level to pm_suspend, so
> > use MEM as of now.
> >
>=20
> Hi Peng,
>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../firmware/arm_scmi/scmi_power_control.c    | 20 ++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
>=20
> This LGTM in general, the only obsservation here is that while on shutdow=
n
> by issuing a orderly_reboot() we in fact ask PID_1 to start a shutdown fr=
om

Would you please share why PID_1 is involved here? orderly_reboot is just
schedule a work.
> userspace, when triggering a system suspend with pm_suspend() we do not
> involve userspace in the process, but I dont think there is another way i=
ndeed.

Userspace process should not be involved, otherwise the freezing process wi=
ll
never finish, and suspend will abort.

Thanks,
Peng.

>=20
> Thanks,
> Cristian
>=20
> > diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c
> > b/drivers/firmware/arm_scmi/scmi_power_control.c
> > index 6eb7d2a4b6b1..beafca9957c7 100644
> > --- a/drivers/firmware/arm_scmi/scmi_power_control.c
> > +++ b/drivers/firmware/arm_scmi/scmi_power_control.c
> > @@ -50,6 +50,7 @@
> >  #include <linux/reboot.h>
> >  #include <linux/scmi_protocol.h>
> >  #include <linux/slab.h>
> > +#include <linux/suspend.h>
> >  #include <linux/time64.h>
> >  #include <linux/timer.h>
> >  #include <linux/types.h>
> > @@ -90,6 +91,7 @@ struct scmi_syspower_conf {
> >  	struct notifier_block reboot_nb;
> >
> >  	struct delayed_work forceful_work;
> > +	struct work_struct suspend_work;
> >  };
> >
> >  #define userspace_nb_to_sconf(x)	\
> > @@ -249,6 +251,9 @@ static void scmi_request_graceful_transition(struct
> scmi_syspower_conf *sc,
> >  	case SCMI_SYSTEM_WARMRESET:
> >  		orderly_reboot();
> >  		break;
> > +	case SCMI_SYSTEM_SUSPEND:
> > +		schedule_work(&sc->suspend_work);
> > +		break;
> >  	default:
> >  		break;
> >  	}
> > @@ -277,7 +282,8 @@ static int scmi_userspace_notifier(struct
> notifier_block *nb,
> >  	struct scmi_system_power_state_notifier_report *er =3D data;
> >  	struct scmi_syspower_conf *sc =3D userspace_nb_to_sconf(nb);
> >
> > -	if (er->system_state >=3D SCMI_SYSTEM_POWERUP) {
> > +	if (er->system_state >=3D SCMI_SYSTEM_MAX ||
> > +	    er->system_state =3D=3D SCMI_SYSTEM_POWERUP) {
> >  		dev_err(sc->dev, "Ignoring unsupported system_state:
> 0x%X\n",
> >  			er->system_state);
> >  		return NOTIFY_DONE;
> > @@ -315,6 +321,16 @@ static int scmi_userspace_notifier(struct
> notifier_block *nb,
> >  	return NOTIFY_OK;
> >  }
> >
> > +static void scmi_suspend_work_func(struct work_struct *work) {
> > +	struct scmi_syspower_conf *sc =3D
> > +		container_of(work, struct scmi_syspower_conf,
> suspend_work);
> > +
> > +	pm_suspend(PM_SUSPEND_MEM);
> > +
> > +	sc->state =3D SCMI_SYSPOWER_IDLE;
> > +}
> > +
> >  static int scmi_syspower_probe(struct scmi_device *sdev)  {
> >  	int ret;
> > @@ -338,6 +354,8 @@ static int scmi_syspower_probe(struct scmi_device
> *sdev)
> >  	sc->userspace_nb.notifier_call =3D &scmi_userspace_notifier;
> >  	sc->dev =3D &sdev->dev;
> >
> > +	INIT_WORK(&sc->suspend_work, scmi_suspend_work_func);
> > +
> >  	return handle->notify_ops->devm_event_notifier_register(sdev,
> >
> SCMI_PROTOCOL_SYSTEM,
> >
> SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER,
> > --
> > 2.37.1
> >

