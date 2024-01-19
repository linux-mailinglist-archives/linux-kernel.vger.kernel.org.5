Return-Path: <linux-kernel+bounces-31220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B417832ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA0A283A37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE26537F8;
	Fri, 19 Jan 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="M/5PkVYJ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD054BFA;
	Fri, 19 Jan 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671994; cv=fail; b=DJ15XZhC61AkL5DcdNSeDnqj0cP9tkHUVt8JCSxgCRxWgzT5VL7gexjTgKhyVR/+jiqKW3O4dYUkFoBsReXLQtUvsXpGilbwLtCbaYx4Tr3vBDTl1qp7JrMsuTZkVJKqITaSrHcFCojl9sqTJYGVmvPFd4/sFh2/xESP3hfPX0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671994; c=relaxed/simple;
	bh=INPGQcR5gxhiW2l3QGgvF/fcFUp9JYdDX3tCCIgi72w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uex92YpiSS+bXzMleue0rayoqJ+m+nliVaQO4UPf3sEkMs1Sh+t2AIp5qJUqt8giJOQ0Kdwm534KyqV428ZZ523d3ezRHdgeOQMfGkmc4d6hA9oiRvNzWGxXej99YHVxk5EiFj8tvHpj2MYLbGK+rlI4z/j1SArwQGUWZh/lw0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=M/5PkVYJ; arc=fail smtp.client-ip=40.107.104.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIUwqqAfM7+mNrL8nNAcDQkxaSQdFD3KnPpJqYh+jDrY8WhIZifH3AKR5HeTTTKSInV751TG/jUN0IrurM5Ee5+eF/n0Q+AH8KuGqMD0l7/ptq92xXq6U4R3K+rwBP5uAzD/wOwRtBrB4BdpkPUqPtSSEjaY2zLOHCNLpX1hhTyc+9/zwfMief2krE7ZrtbpLK9qEjSW40H+EyAojEVU2879cnyFHQS5JW7KqFiOAi5HKpzK5KuoSJj2e4oYafLt3SDQxNaMfH6/QaQnNq8anVhkkwE4n1G3swb56qktQxhS/QYPiT3P90y0paqP9UgSSElRMx7RgHlcCPsQfN2jiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INPGQcR5gxhiW2l3QGgvF/fcFUp9JYdDX3tCCIgi72w=;
 b=QsH2Ht1ycOujXawnipYRwnUJIrlHddiOv/8lMlFBspFMFGul8SXB4/qgWF53gDsuWzVwCj5HCirnYnnw0pFavyxtsnFVS2ZaKBRVwDOlikzVkwyurMR185vo2Dr9whkgECKHhAjI3XufCiC1aaxkKaUVCmnUCG4m5ncdR61D2i9lbo/zzHGq6rZ7EuiXRK2u2Kv1xyq/42OnrgullFpaOPMQ18T7NxHpdJUNb/4fdPepRLr6pXTKQTOG0UCFZW253cGi8dFcYZOBaF4SUFeRpItYc6ZkyD70BQVpOnNl8Cz7PfNiviBRU/6Fe89foI2XOqpSlkj/c9iVyhKQLRdAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INPGQcR5gxhiW2l3QGgvF/fcFUp9JYdDX3tCCIgi72w=;
 b=M/5PkVYJsXJYyM5JXzl2ZIAhJ3LSiGP7OY07G+feXWTOUvnmNv+Q1pG4UA25XNQk/zN1Kzqkg6EwsmHwjs1w6osgM9Nixh7mkIqzLMg0SmW4M6t+KNBeHiIOKUgTW4BR6khEglEzctmK1dqIu12roM95jbW9+w/uM0Lp99CkJI8=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 19 Jan
 2024 13:46:27 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::1ca2:718f:8566:763e]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::1ca2:718f:8566:763e%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 13:46:26 +0000
From: Josua Mayer <josua@solid-run.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1 aliases
 to fix hctosys
Thread-Topic: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1
 aliases to fix hctosys
Thread-Index: AQHaSh83Bz2MXkS5bUKUDFs8xYpYK7DfvIwAgAFPfoCAABuCAA==
Date: Fri, 19 Jan 2024 13:46:26 +0000
Message-ID: <24c24b0b-da49-4452-b6ad-64c4c2d20e11@solid-run.com>
References: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
 <ZalMsJZKrpwncEDp@shell.armlinux.org.uk>
 <79f9bd25-a05f-43b2-8d93-5d51adae1824@solid-run.com>
In-Reply-To: <79f9bd25-a05f-43b2-8d93-5d51adae1824@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|GVXPR04MB9879:EE_
x-ms-office365-filtering-correlation-id: 5cce7069-a91d-4c2c-6866-08dc18f5088e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tIM6OPVjRYXEXFqVgL041KGo2EdkOp1FVTItYD3PwIcqQQoeZxiE7d0DtRkLm9xT9ddABk6Q0XrS7J4I40j/pMeDo+IG71dyLIDzy2cI0CrhgI9SReo8jH2O6ymkRGsd3t6WyMvILR9zZegb41iQu6xv4QjPnqRP9vVFFGZP1TTyUvttuK4opGAwz7b6XaLTUQCDgfZXQECbTQKtJUp6IPlpMoGlAWyZE+b2AhlJF/J69JHgE+z47JGjDzsONQvNqn70G5h9xmYRA+MK+2xjtYlCb5o9IAuJieZq0aqNxNQqtWwQSKA3mjlZ0pP60wuJKpwcVseH8pNukEexjckq6LUre1OfVHxBRFj6i3eVuAt6EYMe5JQOGPT/c8k0CwrQeuWHbb08K/JOB8413SKwdCkvJIrz6ecBEqATkpQuBCwLMkVTyFBiIFB7u2aV+c7qR1ATf17MA3WRao+N88GDCKafvxz2CvdVlv7S72ABY4e3ooEdm0HQGAst6WEkc6Zzc5C8Nqm9sWULvmZXKhEhiBkhfq8ElUYWjKHaz01KkHrWEjX6Y9Me4uPNOSsdyPA4i2sD2ETJF/2q7O3lyNxPBm/z2pLOHlwQJ+QCoEriBMHYJXbcccrRf8GCPEvDi6s2xxwDtWkkz0DC2AJfFh8+Dfz3PnOfyIUnIV4gbB4FIikDmFFCP6EBsT8VgwxrXrModM26DeryPVRZOU6lRlc1CA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39830400003)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(6512007)(71200400001)(83380400001)(6506007)(26005)(38100700002)(36756003)(2616005)(31696002)(86362001)(2906002)(6486002)(4326008)(41300700001)(122000001)(316002)(7416002)(478600001)(66556008)(5660300002)(38070700009)(8936002)(91956017)(76116006)(8676002)(66946007)(6916009)(66476007)(64756008)(66446008)(54906003)(32563001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1Q5RWgxeGxlSlhQWE9hMFJ4VVEwKzN1a1BFVEhtY3lLcHU1UmFGZlBBK1JP?=
 =?utf-8?B?N1I1Z2xnSFVwMDVZcWZZUHU2V3BWVmduREVKZ3JrVlJ5M20vWFdkamlvbkpJ?=
 =?utf-8?B?RGRMa3JCcmxDcmhVSWNEZnh0cDZ2R05Gd21PSU53K3pBOWVJcTlLanJTei9M?=
 =?utf-8?B?RTE1WHFTQzlXOGo1SmZPTzFybVdxWFVxWnpmcEVtK1V4TGRmRUNGdE5mditj?=
 =?utf-8?B?SnArYVgwTEZEYy9SazZXUlFiYXEzMHJTRDNtOHdRZlpvMmVyTGJwc3gwUkE2?=
 =?utf-8?B?bVpEK0NuOHhYNm53YXppVk5WNkpSbHhBaVZ5cGVLOS8zVVVXUUJ1bjVocklE?=
 =?utf-8?B?MjMrcGo2cDFjOXdYaFpVUGd4S2NLWmZlZDhLajQzRkppNzRuQkwrc09nSkRE?=
 =?utf-8?B?czdzSENQL0VFYWg0Q1lwYWVvcytUaW1RakRTT0RuNGxCbEs3SWN0YyswNzF5?=
 =?utf-8?B?U1g4TXdwZmROdUFRemsxUWZCOFJLRDE2bEJsSlkva1FnSHdOQlZqMk9kLzZF?=
 =?utf-8?B?T0dNVTlOVmsvT3lxek9ZWDRUbVhGd2lmdGZBU2pKdkhQalV2UWFBbTloUkc4?=
 =?utf-8?B?UjhBWUlCYUpXcEhoWVd3d3Zzbkk0T3VJYU1WbVFoWXc0VkJjTHdtVXBvQzJr?=
 =?utf-8?B?NjV6Z3dJSkJBem94cmdHTE81d2MyVXhkRkpTRlJNSkdjN01kSUpqcW5oTUUr?=
 =?utf-8?B?ZmduMzk1V2FlaDMzTk1ORjNPY3pUVmNVWElraU1Xa2tqNlBSOGtCNC9XTnVM?=
 =?utf-8?B?N28renptbklKb1VOa2FUL0pKV09rdHBJSElLKzdtRkFLSTYwczBSclFBSllF?=
 =?utf-8?B?ZU5WMTFlN2t2VVVmemttWTVWd0RtVW41dVpVdGtqc3NyTVN0QWZHTGM0NkZT?=
 =?utf-8?B?ZnFnZndmVnQvM2lNMS8yQ1FsQThicmlJem4vU25FdmYrYzNmY3FGRnVLb3Jx?=
 =?utf-8?B?Qk9uMEhLdXJoaEJMSys4QnNnVFpXejFDQXB5Y0hMTnFYUmIyRUd3dmxYZnJs?=
 =?utf-8?B?R01MNzhITEFQQ0tWOHV1L0hHMHBHQVpVY3U3aWYyaDgyS1oxN3p4ZWc5NkVk?=
 =?utf-8?B?dENXVllXM1lTTjhNTG9rNFNhWFR3QzEwd2ZTdnZ0TERiZ2pqSEo1VytiYjZC?=
 =?utf-8?B?SW1uZ1B0U0RnQTUxaHNvS2xOdHBsaUNIb0tUZ05BWTN2SXZZYWR2eDMvbTkz?=
 =?utf-8?B?cWJ3M0lBUS9iUkFIYnNrU2ZCbFRXYzVlTXUvYys4TVYvbUVxa0RDbkxFMXdY?=
 =?utf-8?B?YXA4eEJDaFFPSHZycEFIbCtEamxDUVR0d05HVG1lc1RWQzZpcXJZSng3VDdI?=
 =?utf-8?B?bVVVN0x6b3Bmd1lzbVZZYnFPdDBwSXZORDhORUR4L1J1aXd6cldXNFJkWjZx?=
 =?utf-8?B?bjRIb0VxV09zYmJhRzFnWjE0WFFXQmtZa1BKU2FZVkhkTSs5bFY4Sjc2NnpE?=
 =?utf-8?B?V2laa2lQMUNzd0ZXTVowM3NXRlBSck5IQmQ3bXZZQ2hnaU15cGhEbE55RllJ?=
 =?utf-8?B?Rm1PRzdFWllESlIzU3djdk9oWXNucHJEaS9XaUVyMG5Tb1puV29va2RsZGtt?=
 =?utf-8?B?YzFLUVJ6UXpWS0FaWnRWZERsazA5VzFpMStZZVVoZlZ0U2JuK21JQVZXbnNO?=
 =?utf-8?B?bnovbEFZaW5KVFdKc1p2NzVCSHZzMDFGeVVXQjdsVHZSc2RRR2VoREM1WjFt?=
 =?utf-8?B?R1lCYThPUEFIa3pZc2YvU2dNTDBoMmdWMFlqTFdkcmNldkJ2WnRuK2RCYU94?=
 =?utf-8?B?MTQ1c2VjaTBodEFHS1EyMDFIYlAvZXYzWjRtSDhqY2cyMnlBSVh0b2o3S2ZP?=
 =?utf-8?B?RGlzRjQxc2I1Tkhya1JRQmFoU28zM3lSRVZ0aDREY280aVMrR1VjWVc5N2M0?=
 =?utf-8?B?QTNCTXAxdzNhaHBBUWVKdmVVc2xxdXg5eTFrZnhsT3pNMUdaZ2JBRC9hSE9n?=
 =?utf-8?B?ZDhIeG56WG1kMEluMTlsYVB5WnZ1NHRhbi9JcVJvWDdxK2tDVlpONWw4QmEr?=
 =?utf-8?B?Q0VSNVN1VVNpLytFWVJ5TXYyUU96UHVNS3RYYS93S2hhSUViWkdKY1B2M2Vz?=
 =?utf-8?B?YWhWZWkyMUR6aVY1MXZUTkU0dE1LNWxRTkYrZmtDVzJEdUFIeE0rdnZoZmlG?=
 =?utf-8?Q?/zkEokwwLiMmBgU0ztfbts64b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7084AF3BD91354BAF8F85D893D2A743@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cce7069-a91d-4c2c-6866-08dc18f5088e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 13:46:26.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0UIWdyilu5Tz4nhmW+3T7Le2FXHSs16zYRqGZlwO3wDBkMmVgZ9DGpskX26NfN5zmkhOWYXTIgmtcc6bQIJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879

QW0gMTkuMDEuMjQgdW0gMTM6MDcgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gQW0gMTguMDEuMjQg
dW0gMTc6MDcgc2NocmllYiBSdXNzZWxsIEtpbmcgKE9yYWNsZSk6DQo+PiBPbiBUaHUsIEphbiAx
OCwgMjAyNCBhdCAwNDowMToxMFBNICswMTAwLCBKb3N1YSBNYXllciB3cm90ZToNCj4+PiBIdW1t
aW5nQm9hcmQgaGFzIHR3byBSVENzLCBmaXJzdCBpbnRlZ3JhdGVkIHdpdGhpbiBTb0MgdGhhdCBj
YW4gYmUgdXNlZCB0bw0KPj4+IHdha2UgdXAgZnJvbSBzbGVlcCAtIGFuZCBhIHNlY29uZCBvbiB0
aGUgY2FycmllciBib2FyZCBpbmNsdWRpbmcgYmFjay11cA0KPj4+IGJhdHRlcnkgd2hpY2ggaXMg
aW50ZW5kZWQgZm9yIGtlZXBpbmcgdGltZSBkdXJpbmcgcG93ZXItb2ZmLg0KPj4+DQo+Pj4gQWRk
IGFsaWFzZXMgZm9yIGJvdGgsIGVuc3VyaW5nIHRoYXQgdGhlIGJhdHRlcnktYmFja2VkIGNsb2Nr
IGlzIHByaW1hcnkNCj4+PiBydGMgYW5kIHVzZWQgYnkgZGVmYXVsdCBkdXJpbmcgYm9vdCBmb3Ig
cmVzdG9yaW5nIHN5c3RlbSB0aW1lLg0KPj4gR2l2ZW4gdGhhdCB0aGUgc252cyBSVEMgaXNuJ3Qg
YmF0dGVyeSBiYWNrZWQsIHNob3VsZCB3ZSBldmVuIGJlIGVuYWJsaW5nDQo+PiB0aGF0IGluIERU
Pw0KPiBJbiBpbXg2cWRsLmR0c2kgaXQgaXMgbm90IGRpc2FibGVkLg0KPiBBY2NvcmRpbmcgdG8g
Sm9uIGl0IGlzIHVzZWZ1bCBiZWNhdXNlIGl0IGNhbiB3YWtlIHVwIHRoZSBzb2MgZnJvbSBzbGVl
cCwNCj4gd2hlcmVhcyB0aGUgZXh0ZXJuYWwgcnRjIGNhbid0Lg0KPj4gQWxzbywgaGF2ZSB5b3Ug
c2VlbiBhbnkgaXNzdWVzIHN1Y2ggYXM6DQo+Pg0KPj4gWyAgICAwLjkzMzI0OV0gcnRjLXBjZjg1
MjMgMC0wMDY4OiBmYWlsZWQgdG8gc2V0IHh0YWwgbG9hZCBjYXBhY2l0YW5jZTogLTExDQo+PiBb
ICAgIDAuOTMzNTA1XSBydGMtcGNmODUyMzogcHJvYmUgb2YgMC0wMDY4IGZhaWxlZCB3aXRoIGVy
cm9yIC0xMQ0KPj4NCj4+IHdoaWNoIHNlZW1zIHRvIGJlIGV4aGliaXRpbmcgaXRzZWxmIG9uIG15
IFNvbGlkU2Vuc2UgYm9hcmQ/DQo+IE5vdCBvbiBteSBIdW1taW5nQm9hcmQgR2F0ZSBSZXYuIDEu
NC4sIGJ1dCBpbmRlZWQgb24gbXkgc29saWRzZW5zZQ0KPiB1bml0IHRvbywgd2hpY2ggaXMgcHJv
YmFibHkgc2FtZSBhZ2UgYXMgeW91cnMuDQo+IE9ubHkgdGVzdGVkwqBpbXg2ZGwtaHVtbWluZ2Jv
YXJkMi1lbW1jLXNvbS12MTUuZHRiLA0KPiBidXQgc29saWRzZW5zZSBvbmUgc2hvdWxkIG1ha2Ug
bm8gZGlmZmVyZW5jZS4NCg0KSSB3YXMgcmVhZGluZyBjb250cm9sIHJlZ2lzdGVycyAxLTM6DQpk
ZWJpYW5Ac3ItaW14Njp+JCBzdWRvIGkyY2dldCAteSAtYSAtZiAwIDB4NjggMHgwMA0KMHgwMA0K
ZGViaWFuQHNyLWlteDY6fiQgc3VkbyBpMmNnZXQgLXkgLWEgLWYgMCAweDY4IDB4MDENCjB4MDAN
CmRlYmlhbkBzci1pbXg2On4kIHN1ZG8gaTJjZ2V0IC15IC1hIC1mIDAgMHg2OCAweDAyDQoweDA0
DQoNCl5eIFRoaXMgbWVhbnMgbG93IHZvbHRhZ2Ugb24gYmFjayB1cCBiYXR0ZXJ5DQoNCkFmdGVy
IGEgZmV3IHBvd2VyLWN5Y2xlcyB0aGF0IGVycm9yIHdlbnQgYXdheS4NCldoeSBwY2Y4NTIzX2xv
YWRfY2FwYWNpdGFuY2Ugd291bGQgZXZlciByZXR1cm4gRUFHQUlOIEkgZG9uJ3Qgc2VlLg0KDQpJ
biBhbnkgY2FzZSBub3cgdGhhdCBwcm9iZSBzdWNjZWVkZWQsIEkgcmVhZCB0aGVzZSB2YWx1ZXM6
DQoweDgwDQoweDAwDQoweDA0DQoNCkFuZCBjb25zZXF1ZW50bHkgd2hlbiB0cnlpbmcgdG8gcmVh
ZCBvciB3cml0ZSB0aW1lIEkgcmVjZWl2ZQ0KWyDCoMKgODguODQ0MDM4XSBydGMtcGNmODUyMyAw
LTAwNjg6IGxvdyB2b2x0YWdlIGRldGVjdGVkLCB0aW1lIGlzIHVucmVsaWFibGUNCg0KQXBwYXJl
bnRseSBhbGwgb2YgbXkgSHVtbWluZ0JvYXJkLTIgLyBTb2xpZFNlbnNlIGhhdmUgY29tcGxldGVs
eQ0KZHJhaW5lZCB0aGVpciBiYWNrdXAgYmF0dGVyaWVzIHRvIDAuMVYgb3ZlciB0aGUgcGFzdCA0
IHllYXJzDQp3aGlsZSBub3QgaW4gdXNlLg0KRllJIHJlcGxhY2VtZW50IHBhcnQgaXMgTVM2MjFU
Lg0KDQpMb25nIHN0b3J5IHNob3J0IEkgZG9uJ3QgdGhpbmsgdGhlIEVBR0FJTiBkdXJpbmcgcHJv
YmUgaXMgcmVsYXRlZA0KdG8gYWRkaW5nIGFsaWFzZXMuDQpIT1dFVkVSIGltbyBwY2Y4NTIzX3By
b2JlIHNob3VsZCByZXR1cm4gYW4gZXJyb3Igd2hlbg0KcGNmODUyM19sb2FkX2NhcGFjaXRhbmNl
IGZhaWxzLg0KDQo=

