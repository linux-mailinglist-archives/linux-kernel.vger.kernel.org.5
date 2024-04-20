Return-Path: <linux-kernel+bounces-152354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5898ABCD8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 21:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D702817A5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7040F3D963;
	Sat, 20 Apr 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vrB3U2g1"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB48F6C;
	Sat, 20 Apr 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713639858; cv=fail; b=jhT0/NK0fn7GmZ8+NffnOJh5HZf/XUKT01ESxhwcJDyIau4+4KtjmycHGQHkIhxkNOy8MQiGDmRZGUu8XhXTOe1QED/3CVUq9M/+o2dpvoM8bvcTYcLoZsH3ZeImIZOeSZNE1xqdxPbvwQYHWF7Y0jR6+bVqPAwuz9gSh3bUnB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713639858; c=relaxed/simple;
	bh=r1xd6Lej+U9KHb8A1sFyLPm6QMql9jI12Jp0m1eZF+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYCN3D7a/hX33vertwc4vd+6rCbaXb+QJgwK/ybI9MKQ0WCDpv7bi+rk9mTAqsKF4pOzsFxf1uW3WK/hbKvd3DN9yheju6bVIW+Kd8HYxonCm5sbQR78/WADpKZikqnFVkSIiwOoXZgPRgGqcpIaiFEowUSQ8eNP3TsspkpjlRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vrB3U2g1; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1biCcc3BpQxzBR/WEbcx5dlo5ioJn6sF4+xlNb/cXK4S/C6b4UevVVXnHEB4/em9ONZsBnFAlaWQ7EbQHm4q4AnyGuWZFXRcYnOyqep1SljCCaopq0jQ0WHI5Qi7Fznp/ie0bJgXraZ8Kdd2/gH5fIKoGX3XNAfXIGB5JttQC3mNvtOUOiAMrrzlc5N3d8CCMJNeCjvmVuM2p0HUbfZtx4hf6e9qMZdJ4ZYVZOwknkakMpLhYkkIdaGHIot61ucUaJ6TrSnb7I8b6bFm15bSaVXKJbdk03YbdPPq3tDdPAjAxtVY41t7mmUiF5ij7MdKlqZSZ8V8HG41DIvd0EdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoeXYBBHFgDMZox3a4UsjdPCtZl7DBepRY1Nd75IVys=;
 b=i2DjENVj/3qHFibzXqbfy29ag19+3quKZI+qQ9bpw2IA5TIcbRIr2CLdhDlNA8fG4oS26VZXZfBTO7Rf0xuypZ/8nwYhQRFPTcQbuag2Q5vCQqal1Oi0IcSJo3inPUQbFr5TriAAxe/Wc9XtOpuYUfgkP9xEyR3jQm3GI9zTt2Zu+cOaLKEmRDpeIpaD8Yr+o3+xQSb2rigfXZryCla1pxh+vPBuptmlosy8CTQTPRLkxxkFXI5uaZQe7eSe+Su3lpamS9/l00SDcuoIw0dzgmaBfK1wLqdml2Kihd3ikwPsV3fMT75tfPMMHT7gozrGTBYQw9InuWj+sAhNhYzPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoeXYBBHFgDMZox3a4UsjdPCtZl7DBepRY1Nd75IVys=;
 b=vrB3U2g1RN+1t2Rnnk7mAorswCYoKqQOVCF/zOgRYzcTWqiRD4i9cqDeoZawyIODSH5aDXDMR0Y3YNHEq7QRD2cDwV8nPJlR/STxE9mNxvYA5BxHbbpSYYoxT0En4wEJaepCjmDoiwK+7iWtxX61/k63bX0+hI5An+FEAEWSXXM=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 20 Apr
 2024 19:04:12 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::fa86:a86d:f94b:390d]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::fa86:a86d:f94b:390d%3]) with mapi id 15.20.7472.044; Sat, 20 Apr 2024
 19:04:11 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>, "git (AMD-Xilinx)"
	<git@amd.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"Gajjar, Parth" <parth.gajjar@amd.com>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"julien.malik@unseenlabs.fr" <julien.malik@unseenlabs.fr>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "Goud, Srinivas" <srinivas.goud@amd.com>, "Datta, Shubhrajyoti"
	<shubhrajyoti.datta@amd.com>, "manion05gk@gmail.com" <manion05gk@gmail.com>,
	"Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
Subject: RE: [PATCH 3/3] tty: serial: uartps: Add support for uartps
 controller reset
Thread-Topic: [PATCH 3/3] tty: serial: uartps: Add support for uartps
 controller reset
Thread-Index: AQHaklIJX+674eaJ10uDWbb88wDDkLFxhBPA
Date: Sat, 20 Apr 2024 19:04:11 +0000
Message-ID:
 <MN0PR12MB5953AED63BC895B09D90DED7B70C2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240419120531.3775919-1-manikanta.guntupalli@amd.com>
 <20240419120531.3775919-4-manikanta.guntupalli@amd.com>
In-Reply-To: <20240419120531.3775919-4-manikanta.guntupalli@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|DM4PR12MB7600:EE_
x-ms-office365-filtering-correlation-id: 1f005e23-4623-4e0b-250a-08dc616caa1d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?428E2PB5WuAeJoxQSucr1Q2dlnUHnRMrAuEJvV9gN464x25e1fXaH8QG5Bmg?=
 =?us-ascii?Q?MhtPmKCA9NzLAFdOspbIRmdklumHs7RK4Yl1URATH5oeR7jXlEUArm/cjdwS?=
 =?us-ascii?Q?j7jDJmQnljunSBCdOiJBH7qUd8ur3if+ZrebVyu449DtaUecrE3JZuXgyUm2?=
 =?us-ascii?Q?vRf6p2lAdD3YZTjhE+b5huDss1YVmugUmZE6CX6sxPxwtTFAn8V19W+qprSY?=
 =?us-ascii?Q?DLxqHz4fGmzgfZiKnRB8X+17p921CHNhchTnlIdCP1uGQoOVOcu8AI8H0XZy?=
 =?us-ascii?Q?oLoEgxKIKoZCTCAvGc22pCw70k6kG/kOU0BcYZejTocFqpLCRmUEnMevJ6SS?=
 =?us-ascii?Q?YluLrYcoPGloeqHvdfbeNbiKqeZaO9llgMXSrlEZu3vFnAYBZFqwhGiNqk44?=
 =?us-ascii?Q?tRDuBFlD2Y5Qjsb/e/EQfdkEuP/BVQxeZsjNQPuiGsz43RjlBeR9AjdIzG9k?=
 =?us-ascii?Q?dotWauSaSqG5HozlLYXvkzy/bNH0xhV8LFYpynFqzsHozmbiKT3lFAVn38fi?=
 =?us-ascii?Q?UaTdrIB8+fUB7+iAsFz4u3hp8CKNzI6bq42LbaXBSt5clwWqtiHEFiAGn99L?=
 =?us-ascii?Q?CN91PT9kzyp9u6TONmw5tpkABLNfxU8jBNTbYviuWNgKntJL9Fgkc18kshJK?=
 =?us-ascii?Q?pfZ55490Xjz0k3e+6rEBCouL5Tw1epD3lmTIG1ECqfBOLlkT3DmOapcJfZAa?=
 =?us-ascii?Q?v6I+PRgoYfy97QaKSmN4yTqLgky/caQlWVgT07vEybh83qbi8h5DSsryVj2E?=
 =?us-ascii?Q?u5OeuOJaBWBXHoMltzkiqpGp3lAqkJyomCSGngintjx8ZGi5yDAsD7ON5uzN?=
 =?us-ascii?Q?/q1kw+fCSQ7x5n/iaV5Km5SxlDHWBiEl2oyAImbwxWusJBSM4a4Rjix+MMyT?=
 =?us-ascii?Q?EsSyPa1QQ4QxwPi9vNAFciHz34ZrW29yGgnGn+qcO+0OrSIq9uCK9Em4GeXt?=
 =?us-ascii?Q?h9SAhyOsI0LK/5po6jaB346RvwPuP3mhUykHzDhcLF3ya+j2uwOm+iUId3be?=
 =?us-ascii?Q?hup1SGiE61oywqKPdrMN0xUJF2SxWVfwaT3hWoyDDgrsC0RvIjZ/m1i/R1Lf?=
 =?us-ascii?Q?MAK6svFFiNz3x9C5htVJx+Yk0Tiuj/PyPenhVfM++dQ6uzqk6tbcnFNxBlBB?=
 =?us-ascii?Q?5FU31PgXLaWTcj25EB7B/4+mW0PjXnl/B5ls5Wb6fdqbfpDyyxVlCXCHynoJ?=
 =?us-ascii?Q?XY/IHPfwpvdLYKSQ/HWRZpZgbgu/GYhbhOCArC/8I0j9M7dXi6Q34WUufNWg?=
 =?us-ascii?Q?w++K7lZGzSklYV+t8Epm9m/I88gtMQPhIv0OECoMNzeOYQCj10lkEF0ExH1A?=
 =?us-ascii?Q?Ko0GLn269zb72CEzLraqiaqot1sdinzvMDHU2jAQ/BL8ufP8G7olroWH63Rv?=
 =?us-ascii?Q?/H5Ot2s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2qc148gnCEr4nvEyrhfUsgyLtig1H8TiqlzdV37EQahoTNLhxhZlKoMMAry2?=
 =?us-ascii?Q?cXfr0SzCUZA06PcN60GeJp+RceeW/H7fjCrGh+RSHzn1f/ffE8L8mjtNqZeP?=
 =?us-ascii?Q?Ptrn43vII1EElA3d2mPE+hUF9p6L1EusLhzt6l+gYLBBp4Vly5PJmFP82FAH?=
 =?us-ascii?Q?7nri5RbSL9SBW7xasqEwiEmKGSTUiAEMq0Yx7XcwE0eM29W4GpRPy7TP8xn0?=
 =?us-ascii?Q?YjnOUwd3GtjwD4se3rQHP1QafiyixS4eq+V8NmwxSUjJvc6tKIz49aC9Fkub?=
 =?us-ascii?Q?KuGPuno99uGulFed3P4IouJlYe2htp5KbJJe65GrTemAwB7Mdbdbx/8HpYgU?=
 =?us-ascii?Q?jBwuyMiPoXy3qUeMu4mcbOcjs5ceWJYhgN9AQIltp/aQ6j3oEOAT0XkhGJk9?=
 =?us-ascii?Q?E6I7gv9jMx6Cks3jIw+h1D92kLptw4JF2mBPvmGUVRQ7j4AYyVbiLYnSsgtW?=
 =?us-ascii?Q?v9WmnugffcVioYIE5cbxOxBqfwOwpC8FbAyAovvLChmP+DSPqFOmPbv9LO2m?=
 =?us-ascii?Q?DAgouigV3EF5eYbZiPgNLfSk5se2NiEvyCT3jXC1VK1BUIWrU1JsR1k0Klfd?=
 =?us-ascii?Q?Tgki9ebH+gx59Z7lCMOiHJRADDt+ixxEqO2vHR4k9CtHTQderH0FHGWuicBD?=
 =?us-ascii?Q?yVF9XKy0I0SBLGSGBdYnUgEV3fjhBpO/Bm9BnxmQa3lR/w6j5EWEstTpAE+k?=
 =?us-ascii?Q?Momurg4e8l1RuEJJ+OKQjkwuVnlQYgmRYxFghQc/Rwf/RD0H50y16MKJqsIg?=
 =?us-ascii?Q?kGS6w6ZhvcemZKm67DkNpcl24E9UsHDUncguMs7G9VP5QRQCmaeKVS796R1A?=
 =?us-ascii?Q?OMelYl6JVCfxjvYPFOB3TPkVzakKfafgLBpLD5qIVaHhXz8WqqnMWCnOtOEo?=
 =?us-ascii?Q?z5dpR87Aii+0KBJcp6c6vAz0z3zDB4NaETQ6Vfh+SugdWwlPSz/7xvZJUmf+?=
 =?us-ascii?Q?o4IU487Be51+0wXIasJMTLwuX7fGBvBtgIoqRNtUrWP5D2yYdTl2v46MWJEZ?=
 =?us-ascii?Q?HqqbGf/8LBS/UFM8uZE0GZGmLB0F/vlgeRQY8OOgty5Bj5HZgz5p6Wr1/Xgz?=
 =?us-ascii?Q?kgd/T8adq6SSD3kDJmYoMSBwYY/7X9gz+W6/hZul+1EbCsdlDNLRGW+HC2Q0?=
 =?us-ascii?Q?oovGKEnnzvnlpkIReWiE3i+Ex1xX39NnLRx9/eF2KpPDaMFZHKBLvOJoXvyo?=
 =?us-ascii?Q?0Z1jVs7dM/fzPqXOl7l9tbg9goLYRomnNsk1KdT7wIUpYBQ25yEUP6Kt+rHg?=
 =?us-ascii?Q?Vo/J7EaxJohnI/qT3WGNRIy+te63qKi0DAjjdNPIjM6j6riM4ZWQ4htjg49I?=
 =?us-ascii?Q?PnjEaeW1I6pYMWO49I8mrEHbqj5Tlk0tY14/BsGLBi3AZUXf0OYFgrt3ZRAc?=
 =?us-ascii?Q?9/K08ART1uW7cUsCcMomrHXuuSZuzMcVLOXyhkVtbTJ3Zc0b2m0meolI8W4+?=
 =?us-ascii?Q?s3YB9NbaM24VmuNvl/PF/A0pXhPqwBhtE4Phd9dG1ZlQL/OmgE1W9KoDi9/G?=
 =?us-ascii?Q?avxOaydzKKAjmTiCldASPDtJQcdRcM1+bKlYTTRTfbvd0QhHmmSFBab6ghgx?=
 =?us-ascii?Q?+tK5+kWu40uewQR+VNY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f005e23-4623-4e0b-250a-08dc616caa1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2024 19:04:11.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+lVSGT9U9OtQA/wfYcqWME4SCdRyjjQfcDh++ueNv8bLtqSmYkmlZ2B4ycO8Hot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600

> -----Original Message-----
> From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Sent: Friday, April 19, 2024 5:36 PM
> To: git (AMD-Xilinx) <git@amd.com>; gregkh@linuxfoundation.org;
> jirislaby@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> p.zabel@pengutronix.de; laurent.pinchart@ideasonboard.com; Pandey,
> Radhey Shyam <radhey.shyam.pandey@amd.com>; Gajjar, Parth
> <parth.gajjar@amd.com>; u.kleine-koenig@pengutronix.de;
> tglx@linutronix.de; julien.malik@unseenlabs.fr; ruanjinjie@huawei.com;
> linux-kernel@vger.kernel.org; linux-serial@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Goud, Srinivas <srinivas.goud@amd.com>; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com; Guntupalli,
> Manikanta <manikanta.guntupalli@amd.com>
> Subject: [PATCH 3/3] tty: serial: uartps: Add support for uartps controll=
er
> reset
>=20
> Add support for an optional reset for the uartps controller using
> the reset driver. If the uartps node contains the "resets" property,
> then cdns_uart_startup performs uartps controller non-pulse out of reset
> and reset in exit path.
>=20
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
>  drivers/tty/serial/xilinx_uartps.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/tty/serial/xilinx_uartps.c
> b/drivers/tty/serial/xilinx_uartps.c
> index de3487206bcb..e45d6993ba05 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -25,6 +25,7 @@
>  #include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
> +#include <linux/reset.h>
>=20
>  #define CDNS_UART_TTY_NAME	"ttyPS"
>  #define CDNS_UART_NAME		"xuartps"
> @@ -198,6 +199,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-
> 255");
>   * @gpiod_rts:		Pointer to the gpio descriptor
>   * @rs485_tx_started:	RS485 tx state
>   * @tx_timer:		Timer for tx
> + * @rstc:		Pointer to the reset control
>   */
>  struct cdns_uart {
>  	struct uart_port	*port;
> @@ -211,6 +213,7 @@ struct cdns_uart {
>  	struct gpio_desc	*gpiod_rts;
>  	bool			rs485_tx_started;
>  	struct hrtimer		tx_timer;
> +	struct reset_control	*rstc;
>  };
>  struct cdns_platform_data {
>  	u32 quirks;
> @@ -948,6 +951,12 @@ static int cdns_uart_startup(struct uart_port *port)
>=20
>  	is_brk_support =3D cdns_uart->quirks & CDNS_UART_RXBS_SUPPORT;
>=20
> +	if (cdns_uart->rstc) {
> +		ret =3D reset_control_deassert(cdns_uart->rstc);

reset_control_deassert already has NULL check , then any need for this addi=
tional
if check?


> +		if (ret)
> +			return ret;
> +	}
> +
>  	uart_port_lock_irqsave(port, &flags);
>=20
>  	/* Disable the TX and RX */
> @@ -1721,6 +1730,13 @@ static int cdns_uart_probe(struct platform_device
> *pdev)
>  		dev_err(&pdev->dev, "clock name 'ref_clk' is
> deprecated.\n");
>  	}
>=20
> +	cdns_uart_data->rstc =3D
> devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(cdns_uart_data->rstc)) {
> +		rc =3D PTR_ERR(cdns_uart_data->rstc);
> +		dev_err_probe(&pdev->dev, rc, "Cannot get UART reset\n");
> +		goto err_out_unregister_driver;
> +	}
> +
>  	rc =3D clk_prepare_enable(cdns_uart_data->pclk);
>  	if (rc) {
>  		dev_err(&pdev->dev, "Unable to enable pclk clock.\n");
> @@ -1881,6 +1897,7 @@ static void cdns_uart_remove(struct
> platform_device *pdev)
>  	if (console_port =3D=3D port)
>  		console_port =3D NULL;
>  #endif
> +	reset_control_assert(cdns_uart_data->rstc);
>=20
>  	if (!--instances)
>  		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
> --
> 2.25.1


