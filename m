Return-Path: <linux-kernel+bounces-52102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6F84941C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE709281571
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E11C8DD;
	Mon,  5 Feb 2024 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="PiMuTRAK"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D210965;
	Mon,  5 Feb 2024 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116381; cv=fail; b=itzn/LPXcF9dZ9MWyj6xDXbvp2YeFeiSSd62bk73g27OuxTvuIlvmnpA+bqB3VGis4lSSMleKCryebtHwRN087pGzXHiendTO7VUPuESd+6b3mynBg81Ws4eTCkec7rjx+XGyK7DpLC4ZZWt5NkX+0Wdt/PT7jt3l+cjOaPwb5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116381; c=relaxed/simple;
	bh=sYWS0kVvISurkVSYv9d6/wYFCEEfqiJHIwHI49m5a64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBvgQi2yZ82dGLJ/09yDj60Hy+I8Ly2FZEtmtWmnJnY74DV4mQ4sCRMHk5yvdCLXRp6gcCK27FmlOSCon2PZnb1N9x20YZyfT98tHcBc5HdNNJ6p7V6rN9nEYl/15GvomzyPPHuwUkpxccZ/NjZFZH5Q9hADw22xYwIxETxmCis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=PiMuTRAK; arc=fail smtp.client-ip=40.107.215.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IosF83yMewDhmOHC/bMpG+AabNOEJmijVmuhaG9ihs3PXNm9ct1nFxH6hvOQ/ORuJkvu/0CSRjDsKRPJNeW0Bw71fdCGCEX8w1Sbf8l+ADHnv66jmpkw8YWAGE2kEXDj9eohLMlK4F4D4pPe2GbRNOT+SlCWvMScT6UBNgGfZTaM7aZK5zf8envJNnBr8sYccHb/YiKfp8CV225t6V4qGsPlCO5GmCjiBJbZIQcJeSv/Zv+aequpPbKFYMfcq7ZySIbWx/Ec43MRHGeHADei7NB+zacf/0Mq8di4HkaewzuPd1NIkaufrg4OXspUn3HLpwU2CGs5PNHnyccjBER4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tT02xkRqPxg1XRHUgKyZA8jkAcH2b2dN6YdtOzLCmU=;
 b=HTDXELqgcr1WRhhdIcAG+o2gopzBDyQrwSZBvw/NYmwNIUYKLt9AxqZrQJQcoS32M9JIWHxuAEnCmEM8HdfUVVeJ21XkRmqPV2Y2SqcCo4VFQFF1rHM/9riMZqy/Xx9gu3++sBJIUHyqisWq2V6yJr6QuMAT+NMEXzQoAI8aX1Yq3jd12zAkirihc8EOHSD8TtmspGhQpWIFN2s5Lba6Kh6QdxFBDQOLmdPhafnqIZdhJjSgNKH3v7JCY1deGNIUzZhUviVdAyVaJja2ZYq+T65r1URpRDR86xMSGwwREuaK8kyCav7mZCR3d/gqbgQ9Q0h/fCvqxLYVjBSHj8Xqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tT02xkRqPxg1XRHUgKyZA8jkAcH2b2dN6YdtOzLCmU=;
 b=PiMuTRAKNB3BW2h4AvCKYO5BZlM9171dUkxEGpyves3Chf2y6JRFgKv55jqcOSAanDXsuKUbmupORPWtfQYCjcI+8dwfqaafDR7ady/4MowUKN3eqxK9maNey/OhE6sFz3+aN7T9++B8RZgusRDFk9lc9Bg/Cnz61n7pYX/MuO0lzLgeD1WkxrfMcN90N7I5oz36dKVC03BfDSI7YTSTTOrtnpC9Rzqu+0FbxXET6pkIAPgvPyGYQM+kCOX5i+piF8TJBNQbgzVtOiIpo4bHsbUzrXctc/lSFKrLci2jkC93f9hXyrON691assiYEwIzBeBpJTvmDkgNNv5plI7lzQ==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Mon, 5 Feb
 2024 06:59:27 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::5322:42aa:bc2c:acac]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::5322:42aa:bc2c:acac%7]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 06:59:27 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "corbet@lwn.net"
	<corbet@lwn.net>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "naresh.solanki@9elements.com"
	<naresh.solanki@9elements.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>,
	"patrick@stwcx.xyz" <patrick@stwcx.xyz>
Subject: Re: [PATCH v13 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
Thread-Topic: [PATCH v13 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
Thread-Index: AQHaTouU6UuA7DszbkS0jmW8LTy9jLD4yeUAgAKZNBc=
Date: Mon, 5 Feb 2024 06:59:27 +0000
Message-ID:
 <OSQPR06MB72522452AF463172AD54D4EA8B472@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
 <20240124060705.1342461-2-billy_tsai@aspeedtech.com>
 <e1b1c69f-a2ff-4fa5-80a6-3ff0a3de6ce6@roeck-us.net>
In-Reply-To: <e1b1c69f-a2ff-4fa5-80a6-3ff0a3de6ce6@roeck-us.net>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|SEZPR06MB5897:EE_
x-ms-office365-filtering-correlation-id: be3b79b4-bfe9-4a5c-4bef-08dc2617fe83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sIsm+N/HzTnM+AsSQhZR03nJNGvi2PyWCsAhKmAhiwjns1cef+ueQmnJ3xov0QG1eZMvb7JUOJfjo4whQv6cXbFE8oSUhDrsZ/BmPE7lSCqN65dMHnRrl8+m/y0bnle25dc+Gj/nxUKADrruonXR/MGd+mCgSMrzor+LoGO0+mCkrBn+vdTjci/Kb6WiVAG6jgtLpmCtp9JQ0SqAAIxA7uE2YLZNvE8wECuN705+nYT4SxUa4LNTIcK5an/s5JPKxjafVBM+0xq2g13TXXDBi3HA93/LaLYgSSohaJSXzOUTh+3TClnqHc8OgR8+98N+/T2g60CACFa8FC/KfOss4iafVpAZNKhgk4W58Fz0t3jPSp2R1nTHYDXvK0vn6z+2/9qwxVyIW5Y/Q+yQr6drXJsPBaFjaElsnrAX+PeAuwbwIbxgzaOx3Ngi9W3NkbXIKwI/HPIQ8Fkyh5Vg4MwMwrSOQZpbiUIsThk8mYqEIJRpJAk+mdWNbSG/rnbO1vEV2U7bWzV610JsiIy5BpP/W+75Kp5KzrQhlwVgXsoJYBo2kiBPkjdbMtOVlMw9ZHj2Ud2lxwWsKP9c05L9P0cI+8s/12/EIDomtQfCqO2tRpihjIahOaPKAP6r6/yLMfCb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39850400004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(33656002)(9686003)(55236004)(478600001)(38070700009)(71200400001)(41300700001)(26005)(83380400001)(122000001)(6916009)(7696005)(64756008)(4744005)(7416002)(66446008)(2906002)(66476007)(4326008)(5660300002)(66556008)(54906003)(52536014)(91956017)(66946007)(8676002)(76116006)(8936002)(38100700002)(316002)(86362001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?z+1qTVR+hZ4ZnII1gmc/97BC62JkX8Pr8acvmOZGN+JtVP5PYrD4cQ6vF6?=
 =?iso-8859-1?Q?skHpH1+Ye0snjS6rYHyuD2ozb85b1jACWJb49QBMPznRqwK8sXkZgirZrD?=
 =?iso-8859-1?Q?LRScMUMxU9oH3hQElFgBgPos+wqgCN5yHheEQL2P5Jt9IU7ZjblUzymuhw?=
 =?iso-8859-1?Q?+RLIrGzLA6kWixBz/oi3baHS28UbX8+CAYHO6kEIDhuTvEC6k4IawsWhuv?=
 =?iso-8859-1?Q?oQjj8Ntw0IJxi0gN+zLIh8lDdxS9p5cimxRqr14iM5GB43z3kGLRR9cdBc?=
 =?iso-8859-1?Q?UwPunXvqKq4xq0EfLFq1PhfisUefZTfl2mevyxjD6+FU6OZUrmUFZ8OTeE?=
 =?iso-8859-1?Q?hVPODVv79SIkrompo+EycgIBNpVX0zpUWNIoIvwFwuVeCzyxxE0Y4qIq1J?=
 =?iso-8859-1?Q?ziAnM8n2iE1U7fchSmNAuzn5LwIv8je8+/OE1+eU/y82Bs52hmMiqekLiT?=
 =?iso-8859-1?Q?YemBgRU5MuVlRxQiG8/r9MZdoVe130LK2U9f2tgXISUeMB5ThdaN4jzgR0?=
 =?iso-8859-1?Q?Uo6gYVcz4xIp4Y+jfUYdDiMlEFwqlZa/FdfkWI2ZjX43bJfAJnaFmdE073?=
 =?iso-8859-1?Q?3NezkqVp5VehtSzKhQiiqFQtBQ6VIU6VSrXHNSDsfW4/G8sPeTzUhbW/Re?=
 =?iso-8859-1?Q?0wAtvTEfOd492BjCDqc+xrI6TkqJaq9FvM5x5SAxAS9O/0SBaUXG+DF7Fv?=
 =?iso-8859-1?Q?xJIuSRraKTYC1vtEd7mBTSdeJxoUDY5AL/LHzyqPMIpDDkjVI0kwO50DVa?=
 =?iso-8859-1?Q?5gWgUb4DQAHotNYLE5T6ATIMOCJtWP+fv2UxLkFRkotwBQgNqrgxhefuet?=
 =?iso-8859-1?Q?23RA7YuQHdKar/DmAo2Bl/sXvm+874pJFl4weURIrbi0U8elqDYKXjkzlM?=
 =?iso-8859-1?Q?UrtpRN0raD6aSQS6an+xqCF944PqqZ+pR5rVP0YI1fgb8X9T0ZtBEj8V9Y?=
 =?iso-8859-1?Q?A4hKW9stu3qpzC1Dex7e7iRKabc+uKyw1vtEyNqh9zIQYb0WAwsDC5mNEg?=
 =?iso-8859-1?Q?lOMfHkXlKVcCqEHEsPcjcUB5HRNYorepGYoxH4dcmvmWTZQJfvH96iSq1a?=
 =?iso-8859-1?Q?S+fjCaIBCGsXIrdtA31FeVA3JMB64YJMOtif044AizF1Pbnk+775qKwMXc?=
 =?iso-8859-1?Q?XP7dTqCGbYokawrIT+JxvEFqe71+Tmit3ciTf9682EFZoz+Lyn0W9Ll9WN?=
 =?iso-8859-1?Q?imwcaA8QC386r/tjnwhtatG+IEe3DkHKgibBZfz8khmNXt3WNfgfl7DWL2?=
 =?iso-8859-1?Q?gAHI2Cp40fcFk9LRJ7FTBhQOWCMomTJwjeup4Y/ywpMLJ6u9ydkdWUwruE?=
 =?iso-8859-1?Q?oR93OX5zLP1Ahyww+CIYC/eJLusAmJ4jMqbCar+V1DIS7IyVrwcWV6/eW5?=
 =?iso-8859-1?Q?xz1iWyhu5NTPLnZpmXfijSMFLuD1cfX5jUf9Q19sKaCvI8rs9BNj6XwEzR?=
 =?iso-8859-1?Q?DjZDqgTqOmCBJrwDBF3lG6WHylp7YADpgeEVyeiqupKl4d82sNiBaaEcJG?=
 =?iso-8859-1?Q?wQeEnM6U8yJIK+jIYUheqaM2lra2aT/aTykqoOIXUCQdPGiDzXfSYavjUk?=
 =?iso-8859-1?Q?ONhKg0zHV1/ciCY5WQd83NPE85mHCHo4R5+c41efYV8B/d/V1dRb9wWW5H?=
 =?iso-8859-1?Q?7i2U2Lfm3NY5G0FxThY4ukM2ROiiRMTFnd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3b79b4-bfe9-4a5c-4bef-08dc2617fe83
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 06:59:27.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEP7+YU2drOy4aGBqYmevwv0ctSAerzXPjgqRxdfeZF+2cocshSOUfPJIFn0NqoTnOvYBk0riGMYhkHmI/NhqU2lsilkkL4eoXAxYV+LHr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897

> > From: Naresh Solanki <naresh.solanki@9elements.com>=0A=
> >=0A=
> > Add common fan properties bindings to a schema.=0A=
> >=0A=
> > Bindings for fan controllers can reference the common schema for the=0A=
> > fan=0A=
> >=0A=
> > child nodes:=0A=
> >=0A=
> >   patternProperties:=0A=
> >     "^fan@[0-2]":=0A=
> >       type: object=0A=
> >       $ref: fan-common.yaml#=0A=
> >       unevaluatedProperties: false=0A=
> >=0A=
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>=0A=
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
=0A=
> v12 of this patch got a Reviewed-by: tag from Rob.=0A=
> The tag is gone in this version, presumably meaning that there=0A=
> was a substantial change.=0A=
=0A=
> I don't normally do this, but I downloaded v12 and v13 and did not=0A=
> find a single change. Why did you drop Rob's Reviewed-by: tag ?=0A=
=0A=
Hi Guenter,=0A=
=0A=
The fan DT-binding for version 12 is identical to that of version 13. I=0A=
apologize for forgetting to include the 'Reviewed-by' from Rob when=0A=
preparing version 13. I will make sure to include it when sending=0A=
version 14.=0A=
=0A=
Thanks=0A=

