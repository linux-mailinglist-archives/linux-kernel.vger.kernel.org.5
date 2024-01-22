Return-Path: <linux-kernel+bounces-33634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31895836C84
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE201F25CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339260EFE;
	Mon, 22 Jan 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eKFSq/99"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2094.outbound.protection.outlook.com [40.92.107.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579DC3DB98;
	Mon, 22 Jan 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938829; cv=fail; b=GtKpO08ZBSHo2vU3GQ9cZrs4swfdTLccDw0iMl5QojYTezp7mp0VwnahADdCGGJKJD+n1HDI0/M8h9lSJayg4FtVdmXy13Et2MEoWivG5jw4bmwwdMysBqCJi7lusCl6BxBmMpS5qH81rFjSXjihiXcSUnl/FdbWpujRUPAqOtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938829; c=relaxed/simple;
	bh=3ijhp17wHWsusWo6tkErYSMp0zLvkGE3oQ8VzVumjAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VtS7AlnJUrIa/RCsRePhhazRreX+nyAzHxDbFuDJXHF92eRzl+56v+llIl/5yvfAsoK+5Ynui+Fm73oLZ8TwwmN9WEnS2fPJ8MnqgN5/Z0roqey/Spp0khax0W04dB+hQhDNMI8aaenVdG/C9fsTNq1tS7U/kUWezPmovrobVnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eKFSq/99; arc=fail smtp.client-ip=40.92.107.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe/dR51MGYWyNXzX2XEhJAxDDWxlamBBVekOiWnILWLwH6D3aTAmnrhkqCDtKk8ZD9EEOgwVC8o+2kBBJGpGvMCXb9W+pgQZ4DXb8FoTsi9emGig0Vutd1tPG6QIDLwRXFC1uZNs356TInPK0fZ/6hRbXOEwR7fnpvd1oQhjhqQISFLaYY5Xts3KzokddTV+2gZdLdcMJlzkYUUfsjCO5HpnG3tubKWZFOpKuCugkV6ASirAs9ols4BJwiLNzEKWx6TipKI5WkhZMivixfxdOyZbue4z0EsbxVvDzwR55kuctB9gkgyKfV72exv2fze5K7kw/TUvH9sq6pqCkchZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XEg6cxerjWfFSYeEU37Ji9axPwj+NTZ65b9M1vpDyE=;
 b=gY3RIt95AioOQg3WTUeI5JaRzazO1lBgBZYTFd8w7gP1HiuyHONvzyyl6Et/4UV2F2D25GLcwOv6TTHKBcQZSESBrPJ8S2o8CaVZDchx7TWrRZUnb61OamFQVok1HzPS7FVOUv3M0QvZcWYJJonKTB82evo2L0JYxP2UC7mCUt+NMD6PmMk2c9zS+X2E+1vuw9mWJJ70GDJ0a8mvPfdiE7QyUX9iuTCakquqecTf+Ze4qiiJfTODJxM8Mur96HbuDXqlsRfoAblpTCYG+sfsE8NdcznAj2Z+4Dv6vhFMn3VbZ+V8IGl5Ao33ypow+rhYvX+EyhXgyBhoPTBJV2MJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XEg6cxerjWfFSYeEU37Ji9axPwj+NTZ65b9M1vpDyE=;
 b=eKFSq/99sEqWN4v5vlCKMvltdiIca15lghtvrbtiQ6GySACfoFegqagDwh+fgEMn0vI8F3NQM/Ai7kSNPHOJPvEKPp+xZqub07mGcNaRFMZNHw2wB2zjUVQOLiOCPrYFNrzNIL09CPVD3lFzLufllUHdsNjFpTNUIMjtXjWgJVLTcF8TyFLv29VTF2rgFT2qgQv4cGfwOcS/f68cKiMQ2NDa/GFDfP2svm63Pqp49ZFBgyOFqHTyLqGDDApqXM3DWKtxZVufJ6rsQiJKV3+LrhUDwyC3WewEG6MhuV+3dUa26rLeFuOCf9TAXj4+NAi41yu4bwpyBneClfmyu6Ymzw==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by KL1PR01MB5759.apcprd01.prod.exchangelabs.com
 (2603:1096:820:10e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 15:53:42 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::a639:b02c:5189:7140%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 15:53:41 +0000
Message-ID:
 <TYZPR01MB5556603EA4C5D7BAF9C27C6AC9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Date: Mon, 22 Jan 2024 23:52:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq5018: enable ethernet support
To: Andrew Lunn <andrew@lunn.ch>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556FA040B07F48AFE544680C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <b8510b38-3669-4a04-9ca6-dbe937ecbec3@lunn.ch>
From: Ziyang Huang <hzyitc@outlook.com>
In-Reply-To: <b8510b38-3669-4a04-9ca6-dbe937ecbec3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [0IRDUKUQfG4l5zt2hhhcomOj+XtQL6Xa]
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID:
 <22820ed2-135d-46f1-90fa-9b3c925bf92f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|KL1PR01MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c5ee07-38e0-4809-d43a-08dc1b624e2b
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnozpoe5DD7mC6QHwETenhSvcTJV0/3/2xM0U79+y5QKtvhkuvux0j6/UQU2njVsKIjiF8+aY9LlGtoyaEbeInVxnK5KXZqrjuXC2R4y6+mOjlPVRnDL3/aMtWLke9rCSw04YxrnFVum1PyC4l9qKaPzj3D80gBOz6vk3q//qrJ7HMTB9ubcH6MPNecSdwWMz/gzlZ2qTP/SouuvMLOodmdZ3Hw6WecDI5wCBR2X6W91+LhEfS4fIpiHjT2TOdQHGUN3Z2bCgzIDc/k/R0UTjmFzR5BjsiVAMftpJ1NVxtDSdMGSDsE5BOrINvIlHoRx3lofBHGphywThYbHwV5FjlVnjFycPzRKsG32NDsKIEC2Vq4aS/p+IR8MuZn5C7TCln+0ZsdqKuMZjwg0hAwhpL2hGamjqs0LLlPktbZ/kGijJmvrdU1vg0r2vmwZNlU3mXMLaFaiHIORfLz0KW/70dYgaF9V5BzwGAhFPf7Dju/5Rzt2ums2wbySKcWvWVo7jrngBY/L4cy1Bfn8XyIoVpRN2vBbXTN6U9uTXY+wPv9YCyPj1J6HtMMlBLw2Q/nyxeXaSYzR2NXiIzzazkgrvAkC1rEemuj8XAtZlphML2l9BEuj9B5UaA2x6nrazgs3vSboXEZuPRHDHpMh7I8V/iv4M/hUMpd3kyKjDLByq/rCCvL+adMxc1HgVmtu8YTijAJlwGcDzV/uoFxe4Or477M8GiDDKJE7GHNSSEf2eYwE/TyAhbqa8jubWdHh+U2nJGM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wkk/ItgTsl3Tk6cqI06PiE2vRyIO1tLUQTuEgQitoKoATCLabWbzPGEkGSFtn5lnaDbWjQo2XsFjSCcxkPijvrs6ZnOD07pNAsr5O5mOeg/0hMo7kMm6Q5MT7hXzJZvSeciLJapxpNZqN2b9iPpYGlqQSeVjWlTHSRnWW6x9powGvPnePgKxMUnYmFTxRtyCvwj9bgrGwlBdH/KTM8m5CKolCC4PuGAmmXTee0cVDa8yXC5/2GKJRkbtoDPvg+54XFLdxt/8W6kL6CHkm3zXcUumnp31fUt7KsDEuzqUbtgvW6CqNu7bWI3EA40UDolxFHUBOt+Hymg9QNrRMTjqgGwXhOLN0tzjdTOj/c8BLvqX7VdUvdj1fkDVRNlJWOtDOMv+t0/LzhglbWj3ap9qm8FxZkwX8PhL+NcRecmN6E2xePXOdDNNWNyX6xwGVDXKslZt/mS02NrwnxgTRgPnDS8y6UchiOi9r8+NNYGUs82sIT4QJBiTESI5Z7ki2cybWERSXo8Ll+FCWUMHP5U0+LwOUcTtc853E7mqjbe/EkrAeLbe9+xfinvkTFVGYXMh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHVoK2dpK1QvUTVtazZqSmNURm13VVZjRi94NVQ3RTV3d2dwM1lITVR1blpq?=
 =?utf-8?B?UFp3djRkOWNlZFNsVE1tTEMrclRxSWZBZ055YmY0RG5rcjZNdVMyWVN5eUwr?=
 =?utf-8?B?QUhxcGJyRFN3MDFVNWZtaUwyOVlSc3lVekNRSllXaXpBYTFqN2xhclVVQXNE?=
 =?utf-8?B?ajFpS1A3b3lWTXB2eERtY3NVVHZHVVZTaGpIOFZPVFN4MGVGUkl6WlNqbkxO?=
 =?utf-8?B?d3pER21WcjdHeHdMa1hhZWpmbFpwS2YxZjlUc3lNYXJSeVQ5cTNDRHZ2Z0l3?=
 =?utf-8?B?cVlYVXEvUllFVHJQZWt1elVCRTZPMjl0bEFkb1AzVEhnSTFUTDdja0FHc1Vh?=
 =?utf-8?B?SU9xMzBFQmswdzFoRVI1b1p1Mkc0ZEtTOUtnQjR6elRRRTVHRjhPWUxpalJk?=
 =?utf-8?B?R3JVd0ZQRVIvWEppRVpFK1NWK0NWQjl1SGJRdHJ3K1J4dHVuMDJiZk5TV014?=
 =?utf-8?B?RUo5VUw5VDdLcTRlTS9Udk0ydFBPT1hmY3FkTjRsRnJpTTIrdDhSMVVNbFVk?=
 =?utf-8?B?bVF5NTZpb1JFT09nV0YxMGtkb0FRWjJMNFdXNjZoOWpiRlFVSktyeHdpWXQ4?=
 =?utf-8?B?dlJlRDhTc3VLMCtXY29VYi9mWFVHZW9pc25neUROV1FXT3REMWpWdFV0Zndn?=
 =?utf-8?B?eVAvS21SQmN2QTNjdWEvTVZCZlpZQyswNStLaUlIQVZkYlFWMkxGeDQrWjdT?=
 =?utf-8?B?bEtyaWIvV0ZBVHEvejUvR0NuYklRMWsweDdydnF6L3FSRTBOK2pYSEdjMnhC?=
 =?utf-8?B?bG80T1dpcTFPOVZyeWx2elRrY1FDbEJaK2tLTm1sT0sra3A0L3FpcnpCQVY3?=
 =?utf-8?B?UlkvVUR4OFN5WHhRT3l2TndTL29IYWE0c0dtNk45NkNsc203N1VCaXpoYS9p?=
 =?utf-8?B?Szl0K3FLNzhXZTVBVnRWYzlCQUF0ODhwNks2b2Q4N2lwU0FKVHVpbUptSmIz?=
 =?utf-8?B?RHZTYklUcitlUVRGTmpId1VIRVhuSXR5UDYybWhQYUh3R1JwSFhJajJ4WTlo?=
 =?utf-8?B?elQvNnNVY3NMVUlvdmtsU1VjUkp0VEs5U1JCMDgwcGlPZkc2MWN0bWNMN2tt?=
 =?utf-8?B?em9zNUVEWnJ6Uk9DbkU3V2xNQWk0Z0szVkJLUjkzZysxcW9tSGJRd2JJYk9u?=
 =?utf-8?B?ZWZUYXVPblFsaEFFRWRKNGxTRTdIMHY2Z21FRlRoNHA1YzBNdEEvSFFOdnRB?=
 =?utf-8?B?WXdmQmNRVzRISVJXUUNBa3FUUlB3cFVEMFVFdll6amMvdlluVU9HaE9jTFZo?=
 =?utf-8?B?VHpIdjRDc2s2V2t1Rm1UYWZWc1RDbit6cU52MFdGSUhVbUM2aldycFBHbXVn?=
 =?utf-8?B?ZHBYWTczZjNnR0pEMXFHT2xlNGs0QmFJMXYxTUJ2VGczN3VTUzJpKzdzK2hp?=
 =?utf-8?B?UEp3V3UwSnpVT0VHdTRBSElJcitaNEt4Z2MvZnhRb2wwMVcyV3V3VDNsdXZl?=
 =?utf-8?B?K05RSXBiRFlIeGVHckRJVlRacmF5N1ZsN2cvWHU1OHRZbHRURVAxZG5iTENM?=
 =?utf-8?B?ODM1KzhVVGVEd2MvSmlKVHA5YXNqdTZvN3U4cjFUSXJHU2pIdGZXcGRVUTI0?=
 =?utf-8?B?MlhEcGM5WGdnakgrcFlOSkRhOVIydTcvZjdYY0pJNUtJZjV6R0FHbFRKZ3JC?=
 =?utf-8?B?OXY5YWR4UXFPT3lIRDhRTzNJclBUYnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c5ee07-38e0-4809-d43a-08dc1b624e2b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 15:53:41.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5759

在 2024/1/22 0:45, Andrew Lunn 写道:
> On Sun, Jan 21, 2024 at 08:42:36PM +0800, Ziyang Huang wrote:
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 120 +++++++++++++++++++++++++-
>>   1 file changed, 116 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index e502a3ecf4b7..b36e5c2136b7 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -94,6 +94,63 @@ soc: soc@0 {
>>   		#size-cells = <1>;
>>   		ranges = <0 0 0 0xffffffff>;
>>   
>> +		mdio0: mdio@88000 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			compatible = "qcom,ipq5018-mdio", "qcom,qca-mdio";
>> +			reg = <0x88000 0x64>;
>> +			resets = <&gcc GCC_GEPHY_MDC_SW_ARES>,
>> +				 <&gcc GCC_GEPHY_DSP_HW_ARES>;
> 
> What do these two resets do? An MDIO bus controller is unlikely to
> have a DSP in it. That is something a PHY is more likely to have. An
> MDIO bus controller does have an MDC line, but why is it
> GCC_GEPHY_MDC_SW_ARES not GCC_MDIO_MDC_SW_ARES? So this again makes me
> think this is a PHY reset, so should be in the PHY node.
> 

IPQ5018 has two mdio bus. mdio0 is an internal bus which only connects 
to internal PHY while mdio1 is outgoing and can be used to connect PHY 
or switch.

So I thought GCC_GEPHY_MDC_SW_ARES is for mdio0 and GCC_MDIO_MDC_SW_ARES 
is for mdio1.

GCC_GEPHY_DSP_HW_ARES is seem like PHY reset. But if we don't deassert 
it, the phy node can't be scaned. So I add it here like what reset-gpios 
do - to reset PHY or switch.

> A device tree binding will help sort this out.

Base on the functions I explained, I can't write the accurate names and 
number of resets here.

> 
> 
>      Andrew
> 
> ---
> pw-bot: cr


