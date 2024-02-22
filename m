Return-Path: <linux-kernel+bounces-76107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D08B85F304
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4832841B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC822F19;
	Thu, 22 Feb 2024 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TZIkWqpc"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5D7469
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590732; cv=fail; b=SbbbIso1219hGD90wjgXA5FRpW/9cI0z15K8F6ab95Rq7btzjQMA/P2EbsS8FGD3b6IVoQ4gh7pOYgSZCHlUmWk00gL+JOLfTjF9DLuYGz0d2BNjySRRi0E2TVt5VJZPQ/RrQs0MV1pTatBBPxT5dwOcvY3SBWWB5ohgVFLYzJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590732; c=relaxed/simple;
	bh=zYXaRYfkeMbJthBu+vDvPRDP991/yxzmtxXdkpb0Wq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ot2F7Q90uqEX7vfVDEPnorSDvp4azanNk205Fao9s5EhXU8sFEaj8qtY7yjYkXnqHsebmmHVXQkLYKbU04S2PqXUNd1r5U3641FuDH5cpfpecRzwpfB8fxhR4IIncDQNYb+eWJC+0jXDGlFbCyKudLvxRlpAm2H3Uas61dkjUks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TZIkWqpc; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFGjCA3M1ixWmtdjHPCn9Ufh6CZzHru0X9bqz7ztRIwqgZROz3ktaFehIk+B+mAsAwtuCH7HF9jjNzfzzV4r/9EjRYBkPHhK7s9g9N4EWvbYY3SM1CA9jX5qnh7flO9mlngGwscjLNhJkFDz7Ot7KP8rIY6cJpoJ+TZTRgg2ALFQTIO13LGADRERHQ6fV4DQeGL0AGCVsdZ1EZpx/Q/VshbSqrCXWnviho3NVnIdHXBlL0LaobaQMKuLaaE1EnpjiPEDVHzq+GA7Nc2jFm2E0MmtQlPC6a1TiwGpCjMNxQ9mE6tH654u5w4cF1cAwe/L0SQpuaAYHWyVSMXA5gw3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkNKOVSSmLKkq4bSD/4Aq8hN75ePaEcD9MqH30hKDEk=;
 b=IK6QE4eG0eyvMyfrlPCVTsNhS4urb9xF1INswyq2I6On+yOOJNSRWKliFQAh9kEkkuE7KGuBXYGlF9Ria7VH9wXd20ApA1iH1wTglnBLF7xwuao7WjZZhkwfVDUA8jI9WgkOWZgbmqv4mP7iXrCJXasW9Is5XLN0F8zkXLRZCv42P5rOG422RD4w5KmNJkz8TZRHS5XBhY1fNFSrZb+4sq4tQm0c30FgX5mAWlKxNDzHaDRwnzWkly88m10FawflFTaaIPQQCgM22Gd50103bgxfd2RnqKBE1BHC8x12vRFF0T22g3zHl+VGDdAiMKZVzhAhJYuu/fL02Fc47f9q1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkNKOVSSmLKkq4bSD/4Aq8hN75ePaEcD9MqH30hKDEk=;
 b=TZIkWqpcapS5yA2q9ufixFi4//M3Y94NV4CQZ9WuGFzjCARVEexHvcQRtpJD0Z3F95qLEmc2SClPmKmsp6ywQhGqrma5DKr2rUQEScwoldRVQaOQa/lb59tvQY8/SOTDPffpZIQj5kNMQ/rEw1OjDGQU4aIwwMSC02NiWF3Z37A=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6994.eurprd04.prod.outlook.com (2603:10a6:208:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 08:32:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 08:32:05 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>, "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>, "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
	"souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: RE: [PATCH] firmware: arm_scmi: Add support for multiple vendors
 custom protocols
Thread-Topic: [PATCH] firmware: arm_scmi: Add support for multiple vendors
 custom protocols
Thread-Index: AQHaZRH7MikG8NLPekKH1+zRQtTN0LEWCODw
Date: Thu, 22 Feb 2024 08:32:05 +0000
Message-ID:
 <DU0PR04MB941736B537D71D920C8434AA88562@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240221220426.1205146-1-cristian.marussi@arm.com>
In-Reply-To: <20240221220426.1205146-1-cristian.marussi@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB6994:EE_
x-ms-office365-filtering-correlation-id: 8e72e6d1-3624-44f8-e5c9-08dc3380c068
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 agivnyakeab6AIs9+VL1Vmx2liHRsDZtx12G8B/S0L8VPQSvMmYlcHC/7ZMSui038rVkR/Kburmwb47hoKymkPOOR7qO/jY43vjtKDsiVoJylrWRGZUip+KvkawTprY6WWWeEfZuyMq2P9/kXd53fGOJD0Dls61eU/zN7ZghEQknVs8fGo6RgIXr0343HmbNAyLKloPHtWoWeI7w6GgQ50DG6vkoEwsC1gJH5UzCGkriJij0Kj9vHyXIkYHkFcV/2fgIp88h6PhrOvu5kqMRqaJpSzo7HXS9GZANiF3I6jNDUgFYJECEL9GE/RXxDWtpCacDbnf983cKob3SdbGIFdbi3xvI0eJVscpS8HhjzEKDHaF9YO3QjDGxmOjO/Xf5FXJDJJqPKZejC67q5japTx0G0n8ha339oaXyXnESH1OFOhlxFdZK+SzOQ4fkH3uNFBJICrGAkguZXOtlHTTLNo0bW0byTp5H8xe/v7wI49/7H0w6uggdGZwF2bH/k2AKoO7nx7S1Z/JWBj2PJY59uHo5bPmLTKrVf77VdZy6tpH8R8u1R8ogQ1RrkqKHV41AjIaTJlko0B7eQ8V66hEA7MUZ/8NAkMF6MFelq89DBEDZ0IexEcsdTOz0BB4Kzi81
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+T/gL5lLky1JnHIhnUJgyU1I4VYW+N/yBdzMgccwX4Kg27LDut3ZA1OgvRU4?=
 =?us-ascii?Q?Whg2b9zZeh4ou1nVZn+f4cucC69NJduhVruTzIn/YLMRGvJj+OjWlGRzlcFp?=
 =?us-ascii?Q?YDtIUJci9KI91FTUBr6Mxt++GXmFW0b4kvCOs9wptM37LnHliLn/nsNyII26?=
 =?us-ascii?Q?GK9C+PpkHcIG6AVmFUYUT4K/GxbxvzeqtZXli4+GH0UVqTggUAiZDzX2ydX4?=
 =?us-ascii?Q?PzyoeYbT1Di2sh3MOVdv7RfYnRtzyUU8ygED5lmz6r8I48DwxbxqLjXIffej?=
 =?us-ascii?Q?buYV7O8vI6J9uY2da0Lgmp0ktGDw4hZ7EeYgZSCcUvFcGR8f1MmchVsrEl2+?=
 =?us-ascii?Q?D1jy3rscD1fFlQrBOmjHVOleuKXWvv9502jZ05Zzn5qsZ8ZcXP0XQucdtBHk?=
 =?us-ascii?Q?tAiXmNFRHEvqkmeg0GxIO8H/E+5QLty5w437oA1G2nofq4qxe4rX0EAIY58i?=
 =?us-ascii?Q?7D3dEtlYLl8owPyHWnDSRanRtxwhV/2bm0MFreUUg4QRv2R+HU1LbPNX8x5N?=
 =?us-ascii?Q?N0cphmRF2Jx0UDuDZtAdpXTblhTIfkwqjXmO6MvO8YUVVgaAlIa/f5wcYm2c?=
 =?us-ascii?Q?ccrJt1CLG/lJUdlJaUDT5S8kyd4TzVYLiBrkIcMeLPgjuYE6vxBU/TPjQItc?=
 =?us-ascii?Q?aET/OZSZ9JPQyPH03h+ma5apn/tWf9jAW+U1leHixCgeV02MdTmmAk7cLGc8?=
 =?us-ascii?Q?h8fJDDKU1pwTm6DPPE696GhTviwl/G9W1OtQPR7seaSQxZkTImH0MhZLMkG7?=
 =?us-ascii?Q?N7fV44+QBN0SiV3ta7hKmIM+L/LCiDg29BDk/4wIenJESqW25rMkEEioFSWS?=
 =?us-ascii?Q?61/Z4AKGUFXkGdFwzaAmcgG8Pc7y/MRNFlURlsjG7o/M1n1ayZ85NsgdVmmh?=
 =?us-ascii?Q?ghEGfsG4AKg309N89iU/7S8sjiesEOStjND9Lqmd7GCLI8z+BSxUf4FOke0E?=
 =?us-ascii?Q?AdHADZ8Cbhm1YoEoXOg6w7e0CjaZG2/A7b2Q0Tn9rTO05K4jNEJXMGmdFgKR?=
 =?us-ascii?Q?ocFDj9y2NzloCcgmaUIVZbuY82uRCkpo2+0J+BL6k4UK5t3ebfwWQN4CHPx0?=
 =?us-ascii?Q?huJNrvfdWK1Y3hGbqceJHwKY7DYaOCmjkp08toRcITI+3Vb6rVPc5TIaG6Jo?=
 =?us-ascii?Q?IAWlcmViu+WtDmnj70Rc7HRkMrDYsz7ZDaAquyqDAsj6JpfeUup5BBQF4Etm?=
 =?us-ascii?Q?WIAN/GChW5eEwmYF8SyfAv9jAcOKnu9l4OBSLvy6iqi4469gUpEjB6fDo90I?=
 =?us-ascii?Q?YHSfLYK2Zf7heUUD1uSj9xsKafjH2h/E5NzwuckgqhiMQ9axg5AtzUWtlsAk?=
 =?us-ascii?Q?N+DETBGfmkXlm4exFU/oOAe/lHhyNBZwCSIebnR5Env4T7Heh2ZyGeoAetlj?=
 =?us-ascii?Q?le9Z526Ck/pqirReEnN2KwcX5t+BFcInYw2Av73yBZNrwNySMyMzbz3JWDWP?=
 =?us-ascii?Q?F8O5oZ+LTUyc1jJQra2ekXdgUzTNeZBAAphGhWYVjX4cllpdib4x0TCLTdhS?=
 =?us-ascii?Q?arXoVvAYQpggphcHR8Y3rfIsZdSaJ7clKZdhauK+xbyM1paHpyChSiViXVmU?=
 =?us-ascii?Q?XXvWshLrp5T6xUshZnU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e72e6d1-3624-44f8-e5c9-08dc3380c068
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 08:32:05.6379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKp14hPSNKGK8nydPCPD745D0AvPP8Kxk9luNaycDt/wG649zqtFSJpNrVZZcyz5Gl8UrVHfypXziXZrLoxh/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6994

Hi Cristian,

> Subject: [PATCH] firmware: arm_scmi: Add support for multiple vendors
> custom protocols

Do you have an example how to test this? Could this be used for pinctrl imx=
?

Thanks,
Peng.

>=20
> Add a mechanism to be able to tag vendor protocol modules at compile-time
> with a vendor/sub_vendor string and an implementation version and then to
> choose to load, at run-time, only those vendor protocol modules matching =
as
> close as possible the vendor/subvendor identification advertised by the S=
CMI
> platform server.
>=20
> In this way, any in-tree existent vendor protocol module can be build and
> shipped by default in a single kernel image, even when using the same
> clashing protocol identification numbers, since the SCMI core will take c=
are at
> run-time to load only the ones pertinent to the running system.
>=20
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Hi all,
>=20
> this is meant to address the possibility of having multiple vendors
> implementing distinct SCMI vendor protocols with possibly the same
> overlapping protocol number without the need of crafting the Kconfig at
> compile time to include only wanted protos (and without the need for a
> lottery :P)
>=20
> Basic idea is simple:
>=20
> - vendor protos HAS to be 'tagged' at build time with a vendor_id
> - vendor protos COULD also optionally be tagged at build time with
> sub_vendor_id and implemetation version
>=20
> - at init all the build vendor protos are registerd with the SCMI core
>   using a key derived from the above tags
>=20
> - at SCMI probe time the platform is identified via Base protocol as
>   usual and all the required vendor protos (i.e. IDs defined in the DT
>   as usual) are loaded after a lookup process based on the following rule=
s:
>=20
>   + protocol DB is searched using the platform/Base runtime provided tags
>=20
>   	<vendor> / <sub_vendor> / <impl_ver>
>=20
>     using the the following search logic (keys), first match:
>=20
>      1. proto_id / <vendor_id> / <sub_vendor_id> / <impl_ver>
>=20
>      2. proto_id / <vendor_id> / <sub_vendor_id> / 0
>=20
>      3. proto_id / <vendor_id> / NULL / 0
>=20
>   IOW, closest match, depending on how much fine grained is your
>   protocol tuned (tagged) for the platform.
>=20
>   I am doubtful about the usage of <impl_ver>, and tempted to drop it
>   since we have anyway protocol version and
> NEGOTIATE_PROTOCOL_VERSION
>   to deal with slight difference in fw revision...
>=20
> Based on sudeep/for-linux-next on top of
>=20
> 	1c2c88cfcb2b ("clk: scmi: Support get/set duty_cycle operations")
>=20
> Minimally tested ....
>=20
>   Any feedback welcome
>=20
>   Thanks,
>   Cristian
> ---
>  drivers/firmware/arm_scmi/driver.c    | 166 ++++++++++++++++++++++----
>  drivers/firmware/arm_scmi/protocols.h |   5 +
>  2 files changed, 149 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/firmware/arm_scmi/driver.c
> b/drivers/firmware/arm_scmi/driver.c
> index 34d77802c990..8fb2903698c9 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -33,6 +33,7 @@
>  #include <linux/processor.h>
>  #include <linux/refcount.h>
>  #include <linux/slab.h>
> +#include <linux/xarray.h>
>=20
>  #include "common.h"
>  #include "notify.h"
> @@ -44,8 +45,7 @@
>=20
>  static DEFINE_IDA(scmi_id);
>=20
> -static DEFINE_IDR(scmi_protocols);
> -static DEFINE_SPINLOCK(protocol_lock);
> +static DEFINE_XARRAY(scmi_protocols);
>=20
>  /* List of all SCMI devices active in system */  static LIST_HEAD(scmi_l=
ist);
> @@ -194,11 +194,90 @@ struct scmi_info {
>  #define bus_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info,
> bus_nb)
>  #define req_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info,
> dev_req_nb)
>=20
> -static const struct scmi_protocol *scmi_protocol_get(int protocol_id)
> +static unsigned long
> +scmi_vendor_protocol_signature(unsigned protocol_id, char *vendor_id,
> +			       char *sub_vendor_id, u32 impl_ver)
>  {
> -	const struct scmi_protocol *proto;
> +	char *signature, *p;
> +	unsigned long hash =3D 0;
>=20
> -	proto =3D idr_find(&scmi_protocols, protocol_id);
> +	/* vendor_id/sub_vendor_id guaranteed <=3D
> SCMI_SHORT_NAME_MAX_SIZE */
> +	signature =3D kasprintf(GFP_KERNEL, "%02X|%s|%s|0x%08X",
> protocol_id,
> +			      vendor_id ?: "", sub_vendor_id ?: "", impl_ver);
> +	if (!signature)
> +		return 0;
> +
> +	p =3D signature;
> +	while (*p)
> +		hash =3D partial_name_hash(tolower(*p++), hash);
> +	hash =3D end_name_hash(hash);
> +
> +	kfree(signature);
> +
> +	return hash;
> +}
> +
> +static unsigned long
> +scmi_protocol_key_calculate(int protocol_id, char *vendor_id,
> +			    char *sub_vendor_id, u32 impl_ver) {
> +	if (protocol_id < SCMI_PROTOCOL_VENDOR)
> +		return protocol_id;
> +	else
> +		return scmi_vendor_protocol_signature(protocol_id,
> vendor_id,
> +						      sub_vendor_id,
> impl_ver);
> +}
> +
> +static const struct scmi_protocol *
> +scmi_vendor_protocol_lookup(int protocol_id, char *vendor_id,
> +			    char *sub_vendor_id, u32 impl_ver) {
> +	unsigned long key;
> +	struct scmi_protocol *proto =3D NULL;
> +
> +	/* Searching for closest match ...*/
> +	key =3D scmi_protocol_key_calculate(protocol_id, vendor_id,
> +					  sub_vendor_id, impl_ver);
> +	if (key)
> +		proto =3D xa_load(&scmi_protocols, key);
> +
> +	if (proto)
> +		return proto;
> +
> +	/* Any match on vendor/sub_vendor ? */
> +	if (impl_ver) {
> +		key =3D scmi_protocol_key_calculate(protocol_id, vendor_id,
> +						  sub_vendor_id, 0);
> +		if (key)
> +			proto =3D xa_load(&scmi_protocols, key);
> +
> +		if (proto)
> +			return proto;
> +	}
> +
> +	/* Any match on just the vendor ? */
> +	if (sub_vendor_id) {
> +		key =3D scmi_protocol_key_calculate(protocol_id, vendor_id,
> +						  NULL, 0);
> +		if (key)
> +			proto =3D xa_load(&scmi_protocols, key);
> +	}
> +
> +	return proto;
> +}
> +
> +static const struct scmi_protocol *
> +scmi_protocol_get(int protocol_id, struct scmi_revision_info *version)
> +{
> +	const struct scmi_protocol *proto =3D NULL;
> +
> +	if (protocol_id < SCMI_PROTOCOL_VENDOR)
> +		proto =3D xa_load(&scmi_protocols, protocol_id);
> +	else
> +		proto =3D scmi_vendor_protocol_lookup(protocol_id,
> +						    version->vendor_id,
> +						    version->sub_vendor_id,
> +						    version->impl_ver);
>  	if (!proto || !try_module_get(proto->owner)) {
>  		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
>  		return NULL;
> @@ -206,21 +285,47 @@ static const struct scmi_protocol
> *scmi_protocol_get(int protocol_id)
>=20
>  	pr_debug("Found SCMI Protocol 0x%x\n", protocol_id);
>=20
> +	if (protocol_id >=3D SCMI_PROTOCOL_VENDOR)
> +		pr_info("Loaded SCMI Vendor Protocol 0x%x - %s %s %X\n",
> +			protocol_id, proto->vendor_id ?: "",
> +			proto->sub_vendor_id ?: "", proto->impl_ver);
> +
>  	return proto;
>  }
>=20
> -static void scmi_protocol_put(int protocol_id)
> +static void scmi_protocol_put(const struct scmi_protocol *proto)
>  {
> -	const struct scmi_protocol *proto;
> -
> -	proto =3D idr_find(&scmi_protocols, protocol_id);
>  	if (proto)
>  		module_put(proto->owner);
>  }
>=20
> +static int scmi_vendor_protocol_check(const struct scmi_protocol
> +*proto) {
> +	if (!proto->vendor_id) {
> +		pr_err("missing vendor_id for protocol 0x%x\n", proto->id);
> +		return -EINVAL;
> +	}
> +
> +	if (proto->vendor_id &&
> +	    strlen(proto->vendor_id) >=3D SCMI_SHORT_NAME_MAX_SIZE) {
> +		pr_err("malformed vendor_id for protocol 0x%x\n", proto-
> >id);
> +		return -EINVAL;
> +	}
> +
> +	if (proto->sub_vendor_id &&
> +	    strlen(proto->sub_vendor_id) >=3D SCMI_SHORT_NAME_MAX_SIZE) {
> +		pr_err("malformed sub_vendor_id for protocol 0x%x\n",
> +		       proto->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  int scmi_protocol_register(const struct scmi_protocol *proto)  {
>  	int ret;
> +	unsigned long key;
>=20
>  	if (!proto) {
>  		pr_err("invalid protocol\n");
> @@ -232,12 +337,23 @@ int scmi_protocol_register(const struct
> scmi_protocol *proto)
>  		return -EINVAL;
>  	}
>=20
> -	spin_lock(&protocol_lock);
> -	ret =3D idr_alloc(&scmi_protocols, (void *)proto,
> -			proto->id, proto->id + 1, GFP_ATOMIC);
> -	spin_unlock(&protocol_lock);
> -	if (ret !=3D proto->id) {
> -		pr_err("unable to allocate SCMI idr slot for 0x%x - err %d\n",
> +	if (proto->id >=3D SCMI_PROTOCOL_VENDOR &&
> +	    scmi_vendor_protocol_check(proto))
> +		return -EINVAL;
> +
> +	/*
> +	 * Calculate a protocol key to register this protocol with the core;
> +	 * key value 0 is considered invalid.
> +	 */
> +	key =3D scmi_protocol_key_calculate(proto->id, proto->vendor_id,
> +					  proto->sub_vendor_id,
> +					  proto->impl_ver);
> +	if (!key)
> +		return -EINVAL;
> +
> +	ret =3D xa_insert(&scmi_protocols, key, (void *)proto, GFP_KERNEL);
> +	if (ret) {
> +		pr_err("unable to allocate SCMI protocol slot for 0x%x -
> err %d\n",
>  		       proto->id, ret);
>  		return ret;
>  	}
> @@ -250,9 +366,15 @@ EXPORT_SYMBOL_GPL(scmi_protocol_register);
>=20
>  void scmi_protocol_unregister(const struct scmi_protocol *proto)  {
> -	spin_lock(&protocol_lock);
> -	idr_remove(&scmi_protocols, proto->id);
> -	spin_unlock(&protocol_lock);
> +	unsigned long key;
> +
> +	key =3D scmi_protocol_key_calculate(proto->id, proto->vendor_id,
> +					  proto->sub_vendor_id,
> +					  proto->impl_ver);
> +	if (!key)
> +		return;
> +
> +	xa_erase(&scmi_protocols, key);
>=20
>  	pr_debug("Unregistered SCMI Protocol 0x%x\n", proto->id);  } @@ -
> 1888,7 +2010,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *inf=
o,
>  	/* Protocol specific devres group */
>  	gid =3D devres_open_group(handle->dev, NULL, GFP_KERNEL);
>  	if (!gid) {
> -		scmi_protocol_put(proto->id);
> +		scmi_protocol_put(pi->proto);
>  		goto out;
>  	}
>=20
> @@ -1952,7 +2074,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info
> *info,
>=20
>  clean:
>  	/* Take care to put the protocol module's owner before releasing all
> */
> -	scmi_protocol_put(proto->id);
> +	scmi_protocol_put(proto);
>  	devres_release_group(handle->dev, gid);
>  out:
>  	return ERR_PTR(ret);
> @@ -1986,7 +2108,7 @@ scmi_get_protocol_instance(const struct
> scmi_handle *handle, u8 protocol_id)
>  		const struct scmi_protocol *proto;
>=20
>  		/* Fails if protocol not registered on bus */
> -		proto =3D scmi_protocol_get(protocol_id);
> +		proto =3D scmi_protocol_get(protocol_id, &info->version);
>  		if (proto)
>  			pi =3D scmi_alloc_init_protocol_instance(info, proto);
>  		else
> @@ -2041,7 +2163,7 @@ void scmi_protocol_release(const struct
> scmi_handle *handle, u8 protocol_id)
>=20
>  		idr_remove(&info->protocols, protocol_id);
>=20
> -		scmi_protocol_put(protocol_id);
> +		scmi_protocol_put(pi->proto);
>=20
>  		devres_release_group(handle->dev, gid);
>  		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n", diff
> --git a/drivers/firmware/arm_scmi/protocols.h
> b/drivers/firmware/arm_scmi/protocols.h
> index 693019fff0f6..cb8dbc93584b 100644
> --- a/drivers/firmware/arm_scmi/protocols.h
> +++ b/drivers/firmware/arm_scmi/protocols.h
> @@ -29,6 +29,8 @@
>  #define PROTOCOL_REV_MAJOR(x)
> 	((u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x))))
>  #define PROTOCOL_REV_MINOR(x)
> 	((u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x))))
>=20
> +#define SCMI_PROTOCOL_VENDOR	0x80
> +
>  enum scmi_common_cmd {
>  	PROTOCOL_VERSION =3D 0x0,
>  	PROTOCOL_ATTRIBUTES =3D 0x1,
> @@ -330,6 +332,9 @@ struct scmi_protocol {
>  	const void				*ops;
>  	const struct scmi_protocol_events	*events;
>  	unsigned int				supported_version;
> +	u32					impl_ver;
> +	char					*vendor_id;
> +	char					*sub_vendor_id;
>  };
>=20
>  #define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(name, proto)	\
> --
> 2.43.0


