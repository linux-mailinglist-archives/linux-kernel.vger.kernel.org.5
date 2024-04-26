Return-Path: <linux-kernel+bounces-159661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C28B31AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFF91F23172
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029BC13C8F0;
	Fri, 26 Apr 2024 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b="MynVijkz"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11012017.outbound.protection.outlook.com [52.101.154.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B413AD25
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117718; cv=fail; b=kDn4zDhWQW9dcp8/q8O+lynIj4nmjYsWB0o/qhisctipCTJjlsBpOCDi4m//0oj+5T2QXL5CCp6s25g9zijsTQrHDBThzNWw+SrTYus9horE7A3SNT72wQV/lb1JccB+RX7dw4O8Ss2hAupS7b2qMq0K0rzt3rJqJipF6+Nev3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117718; c=relaxed/simple;
	bh=9l64nAY+qweYmextm18nJo8wZuSf2goUFzrL+4nv2Hg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iC46qN49lp+JP4pOGGYf1X+9XBwMqVc4/JqaWK9CMF/QWJ9YZuK2sQhA+R4yXvvtpMx7fPr0zIXts0nD1V5lf1znA2n4OAzB5gX70wOF5hah4LFYUg7TIyYiodKHX5ZKIFOgQqwujB0gciZuXAJd0Op7uzIEakTefUDqIhO/EZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com; spf=pass smtp.mailfrom=skyhighmemory.com; dkim=pass (2048-bit key) header.d=skyhighmemory.onmicrosoft.com header.i=@skyhighmemory.onmicrosoft.com header.b=MynVijkz; arc=fail smtp.client-ip=52.101.154.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyhighmemory.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skyhighmemory.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evT81zpIid4G4xmKGttojiRe2Jo9Pt4v9XCsK4peH6lJl+hUo/PhmTLYDGp12SAkgj1CTGLl73ZIZn+ysrlkjrxc7C7yLHaeB2OJCyovCKNrBQZhHSBvHiRP2TdOPF0iOsALq5B8m+16Btu4EdVV6VdcUpkBzUprfkd1PwQvKqJMCuISjNdYD6bx7FWcuwLn6qiAJajYLSTba28C3fx//1ArYV8cr6pjOeNCvqQct40tuKAitnKq4e0FEKGtQhIqyH/mBTBSnwletu8GDd8a4LtyZ4LtO8ggzmc9BJmcTtDOkNDhVUBoAMHHVOOfKFiCXZ5RLnl6Lgb8fJ890SFQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9l64nAY+qweYmextm18nJo8wZuSf2goUFzrL+4nv2Hg=;
 b=iBPwz+x3xJH+E70qo3KU55IQo+mBUiUUN+51q9Dzev7oeJUGXzzt6hthBoMZAP9S77k1T2uaBqNUfOLuTdh4KFMTZnORI7EA5MTMN1qzvgjjX+phtz5yHAc/xWEy85hgy1X/bPwtYoYrwpGYUDM8XvqSBuHLw760jz9uWQWAGbVLdPpSgaUTG0T5HeKmLFc4F/gD12acnP2AXfThr4Nx641Y3nGscUNofFvqMxmR9VxCxxffVOeirnM0ngwZy23Zw0zAUS3gJpe36qa8CdGZUsCKg9/HRGhvrZNWxtJf34x87HB4SST0bRFIfXV5vojH91eQng7h5icr9SnfQIu+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=skyhighmemory.com; dmarc=pass action=none
 header.from=skyhighmemory.com; dkim=pass header.d=skyhighmemory.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=skyhighmemory.onmicrosoft.com; s=selector1-skyhighmemory-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l64nAY+qweYmextm18nJo8wZuSf2goUFzrL+4nv2Hg=;
 b=MynVijkz0mM5KzBcoiTd/H2kuplc25ScZUvTUhvOhkqe6JwzDYqeZZiHtMTHf3I2u1ZjZDleQaJd0Rt4Iw8ArxLQAm4Rw2G69TYQ5NK8iEzU5F6+3yV2dcGQAQqQesTDf2HgNUEP0Dd/h5ecLY5G1Ac+cK+WTooLF9w83U/emVPXtG5OJcFZSy1EidRdok26Q6wI2BN2QGQNp0IMExLVxwiCRhktwVFiQ5TXSmSsxXrbLJ0ypUbsRXlj58d7y+t27yJTRBFJ+FvRaJaUhKZbmmZLUXk50KCu7wq2zrDdYNsCy6bFpMHe8oOzeUYkZFr5sZUgvs9SWY+pUlFO+gNg3w==
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM (2603:1096:101:11b::5)
 by SE2P216MB3120.KORP216.PROD.OUTLOOK.COM (2603:1096:101:28b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25; Fri, 26 Apr
 2024 07:48:33 +0000
Received: from SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c]) by SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
 ([fe80::b40e:6aa9:78cd:c4c%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 07:48:32 +0000
From: Kyeongrho.Kim <kr.kim@skyhighmemory.com>
To: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>
CC: Kyeongrho.Kim <kr.kim@skyhighmemory.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"michael@walle.cc" <michael@walle.cc>, "tudor.ambarus@linaro.org"
	<tudor.ambarus@linaro.org>, "acelan.kao@canonical.com"
	<acelan.kao@canonical.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, Mohamed Sardi <moh.sardi@skyhighmemory.com>,
	Zhi Feng <zhi.feng@skyhighmemory.com>, Changsub.Shim
	<changsub.shim@skyhighmemory.com>
Subject: Recall: [PATCH] SPI Nand patch code of SkyHigh Memory
Thread-Topic: [PATCH] SPI Nand patch code of SkyHigh Memory
Thread-Index: AQHal64i2vOvr+sPEkiXbPWeex1RNQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 35
X-FaxNumberOfPages: 0
Date: Fri, 26 Apr 2024 07:48:32 +0000
Message-ID:
 <SE2P216MB210266F74115B23C2BF14C6D83162@SE2P216MB2102.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=skyhighmemory.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE2P216MB2102:EE_|SE2P216MB3120:EE_
x-ms-office365-filtering-correlation-id: de3f1049-65aa-424e-92da-08dc65c5454f
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NhhkpvYE9NN8rPtIBjNnOKGYS1MpK9NZFacjvSMYfnrDvLEIl5qvISjTtOBw?=
 =?us-ascii?Q?7PGvQw4Ui6UKhgp49eY16AGZuk+7jOk8NG0EQYTI4y7ZVfXMShTuh4AbfInE?=
 =?us-ascii?Q?OSFVU1QuZQl4aapxleN+lZYsQmpwjYt72j0p3ck10/FWdh+oI7nt/a04+IAO?=
 =?us-ascii?Q?4flTzUd1RkFe79S/1XYDGxQUG26jUp9LaCdPq52buKKF7YdPgr3SMPRTghJJ?=
 =?us-ascii?Q?+FrDF/HmmxkTLOHwvKJbjJoR8AuSwxLAzZsjUPQxGTLDUz+dgNtE9Mladgdg?=
 =?us-ascii?Q?4LVRhIGciahtlRASC9nr1g9FhA9PmrmeiNkBd3oSjPVihFGU5lKY194uNxXv?=
 =?us-ascii?Q?FZc4x+5ttv+XBX5XAI4+tIfLcOUVgBya5MWSScOOu7jtdD528dlV78qFqxvz?=
 =?us-ascii?Q?+Sh/1sV+JdL3GJQAB4JFbRrBYnjothqvqwEwiVyvpB5xL5ffmsgOi2cR3dRL?=
 =?us-ascii?Q?UMa3vdRl5fwZ5pBbQEhpYjoSUVb54S08KqqSSZNVGY6h0m07uhOy9Vk1O0Py?=
 =?us-ascii?Q?qrAiqMRsJyvKKGPImCZIXFgHOMLPxpHQIVyxRkWJLIY4eIAFh8RLjsDGWW2/?=
 =?us-ascii?Q?1qhMAt4w84xyeVEjlhNYMPn6QVlNgzz36qtylcCM63d32gz1KROJBSj7JQsE?=
 =?us-ascii?Q?Rhop8Fk627njoa+H5j9IylZyzbkTz6GQoz8C/9/WlekKV6FlsI8FgpjE+yjo?=
 =?us-ascii?Q?XgbMJFO0D1i/BnS+1yVpLCa48TgMKgmNK4I8WV/hyBPXaW9Kta5WRDVTAHtf?=
 =?us-ascii?Q?CW59THfmxguFI/oRCPwP1zG5pO2RERKbHl+rgEkqDXCja8kPS80cAM1xN4VL?=
 =?us-ascii?Q?DCuINiFR/ebP5lD8YhkSFUSx+8qUVm8XVs+2Ui8HA79Pqi2ju1fQsEW1uBWi?=
 =?us-ascii?Q?eiOC7yAPdBqBFxTliRoeITsbDNHyx8Mmx3kLn7ZR3gX+d2m9T9sdnv4v3cz3?=
 =?us-ascii?Q?k8+PZIepzjZrl06Nlx7f+qwajacVyMT6AHX7hgPMkemiBIKzmT/jwD2CHYep?=
 =?us-ascii?Q?CvTGN3o2B+sToVZpwbJKKoNEEk1ivKWK+jHGd7vE3EK8y6Y4Boc4E39zqu/0?=
 =?us-ascii?Q?lRDb9/18BNMTt6AjCMxYHetaFg8irghnjzAMDeozxBmXhlicTfZSxOjeiNhA?=
 =?us-ascii?Q?b9m7fE1vQ3y62LQWnPYXLRux5McIkRZljIFXVMsMNot8yDD6rgmMFTsE+Scq?=
 =?us-ascii?Q?4NwDdwUUmulleuhuID5pWlLxDqfC2GpS86/9XQjAlAOy5cylmO0huRhGDRyO?=
 =?us-ascii?Q?ykJ9BEG8VniWn9nJLZLWsh88nhZMEBL4SWo9NzjLGw+x78eSCbVRRkGv2tNy?=
 =?us-ascii?Q?mOF84uVsyXV9ssURy0J3rOcj9nuXhtBCRsOG9mltDBHDvA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB2102.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gHTkEDt0m1j69lj8qO6myN/gVseByBuX2eqCwgJgI7YnlNqMoBl8gTZ0PEoc?=
 =?us-ascii?Q?cFrwejDxcb6H/Y1VGVVb6zMsBWBrDzb2QqobOayvNSMFX3HCkd8XZ7ntPdD7?=
 =?us-ascii?Q?LxSgqoJH1K6IcWapis5e/SCy0GRxIybmhItmypweEow2Z8obybwlJ3K6DaEs?=
 =?us-ascii?Q?1GhUb/qsKumwtAC4s5idHI31ogOe605u54e1rR/+H7txU15j/nnIEjJ4qXhe?=
 =?us-ascii?Q?zfL88Jf9mFK2r1j9oF/bTB9Jb2juvefPJDGHPcGGIKbCqGsZgGgrl5zIyJ/V?=
 =?us-ascii?Q?WB4Klc4IE5abJrPlYNPAteZpi9gOSjtGC4ibzZ/DvxwSEeigZvInjE10oo1x?=
 =?us-ascii?Q?0COD3b8rWAkIbVEpwuLxZkqkNozdJ4eOu8edcMvx+T0DCDcXxjQxX6UBY6mV?=
 =?us-ascii?Q?l2XRa+L/oxpnB0sgSaHE6CtiP2o8JA5JxGhFBBjSq4Z45/VMkDU/UA8tUh0d?=
 =?us-ascii?Q?2KkT2Q/I0ThUXqff246zqNrHNmdDbb3IIAdE+eFnX+gUVYmVNvUvVwU5w9my?=
 =?us-ascii?Q?j/P8lGNCZV0mUrFRty9cop+ilzkrzDB9CYTETtNoW9erkERI89xg6Ggk7eCb?=
 =?us-ascii?Q?gvbVfabnpQURTcJZ5b+YM2ncJzx4DWBpZFDZsF0eVD1jKeUjIwPEIGp3w4TW?=
 =?us-ascii?Q?UbFn1t140BTy4J/hjhIP0IOCTLZ3vDNSITVi3H/L2NaLoMUQKYa1KOpNNW9w?=
 =?us-ascii?Q?2jaMcwMsDmat6MyYRhEvI7PLCzxyxuRO2Sp5prwaZw536yAHs/Gf7S0uXyUM?=
 =?us-ascii?Q?PF0e9bDkyFgdMMWlSnORl0iTuaz4WnB3YbSXjPvb/7H1AYGrIZzluX7Iwr8M?=
 =?us-ascii?Q?fMYJwbFxmIWUzLeRD7QXqSGVNbcEUrOQA750wYgOfmWNQaNpdHAWXXYQ5USG?=
 =?us-ascii?Q?KFwNae0hR8D9OJb0PByqEPiphXq2L/8IplEbEMnKtmin3qBF9JCW6iKOpqhW?=
 =?us-ascii?Q?HJbT4tyAcMzpSkOPApdli3dnCRXorTOV7xVoHZuuXOn2vV7j6RX/ghaj5bdS?=
 =?us-ascii?Q?8D37GylKJ56fihDW5tnTtmRP8YqVSwtIxfnojVOs1I9JctxGB5s9+hadkVrW?=
 =?us-ascii?Q?/M1mljO2xpx8GUR545Px7QN1jFY4+QxPu6I6WNTThR8mk/tIEIaqBtT6c3zR?=
 =?us-ascii?Q?D8RAYPCfhBUONDCI6gwwr9J39+SElerekv6C/6Nc+FAFD9ZRXKiKHqhq8AO2?=
 =?us-ascii?Q?wO7JhruFszGCa42m/vmMsA2gnqw6sNNujDVwjqCeMnMUx8jQRaJC9TJ9FXvH?=
 =?us-ascii?Q?QugsUX81jncqMjiYnbf4D/asKw9G4brMOwKyn9N5U4MCrb+v4Ut6+OugQNga?=
 =?us-ascii?Q?ChAPagk21++VrRDDaLaw8QepmMLm/X2XJa/1eu/bhkxTU7loLXMuZgR4bwAT?=
 =?us-ascii?Q?NP7J5p4mSMR6zr1BLLmPWMq+VNZRFFxJ9C2IkyMe9dP4rd39Shm1dnZe1zQY?=
 =?us-ascii?Q?V9V2PDjbHB4SZtWsqVPvi/Axp3bswi2N0Ol0jErFeUo68lA9zk4KK7zzsBQ6?=
 =?us-ascii?Q?FZEvucyd0Lgb44lHs3Fe5cWNL4PVtjMexl/T5a6HN6+dZdjgC31DnourtBDZ?=
 =?us-ascii?Q?Wn6ovu656JnqplnFLmZLT+dxFsU+CO4Rfu4h/5nO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: skyhighmemory.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB2102.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: de3f1049-65aa-424e-92da-08dc65c5454f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 07:48:32.5028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 39b82b34-0966-49dc-81a7-5bcab7ea53c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDE321D9oHIe8YJodWXyrq0SZhIS4TPW/xGKHYsx7AHkNwtFZrM7Dw1H590suLpHEOzrvEV7aiO1kiriczWOX3a6kQk8rg4EAweIr1QMOj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB3120

Kyeongrho.Kim would like to recall the message, "[PATCH] SPI Nand patch cod=
e of SkyHigh Memory".=

