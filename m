Return-Path: <linux-kernel+bounces-63352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8B852E09
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC17282947
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E222BB0D;
	Tue, 13 Feb 2024 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="q5vxIuYd"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2090.outbound.protection.outlook.com [40.107.247.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373023754;
	Tue, 13 Feb 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820592; cv=fail; b=TNMoB9g71wAaEPcF1oeUm9SB3BbBZW4R7NqO277rVqcHyEaMOujjqyBGmyny5O6yoP2jL5FdSZeB7vITRIr34FEbOzLJ2LglHlG8xVi0iAvkUW9NBFOakZSudtmPOzdpl/OkqIB+bdAEinq00fzR4l4uX4/e0ABeuAWU06FUYiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820592; c=relaxed/simple;
	bh=eCh60O+D8G3e6vyOWJlLgbd9PB0XT3G3IZzNcmVY7Vk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rb36fZuyUL4jJ+8J2w3r5mrHhilfft9ktqqM7buc1JL0EAR2tc9JMhzfnFitYnIzd3iTvTGb4qNWTo7FIlMUYTYDFeVNHxoYqC2hhiN0kTcaMkf/06T61zjkiQNizns7FEBkSSjivYHobkLKgbCe8IHhKr9VoCqjd8aoxJ7PPms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=q5vxIuYd; arc=fail smtp.client-ip=40.107.247.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fC6tJr+rkpXlV+DKJZCrl1wtAOIHtpitACWihS72gGhcoEXE+/A3saBUiE7h+3/zTAlabhbHIlMErzn3aVpsp0Yd2ZxOTzhXpC3DhDDz4xTOAUsVvJFwMlnSVDhmw5v1q9ypItF9DZnDXg2SzmEX4f8Jp7/NWRmsm5MPBU4Zh7b2fMoi3JgXaFKgPM+AQcUuduBBhEb0CUin5MqI9CEEga1o0Q43glZQL4xgG0vAuUG4A40lSaPvelNN25dqHNRKsa1Dul/mRkKUVMk0uMZip4XvNHLclFJBWMs9/IwT3fyslf2TrGeNTwGYzHsCk/UT9EVmdiNwtJM7SZ7skZvFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4imtw8GQBpYNjDrhDMFARn02wWhnL4xlSFDmy8PAae4=;
 b=PQXKW+3RZzVAUijMY8Hr2N3d7kQVlKapamkD9q8tJVbX3ke3k+t6J+/Y5RATWzojH5yZOze0HipSCrmXvZfI4Iea/l4emO/i8pzo7lno1hyeiBBQwaGJH+SR71lvf5MXwvfKHloxOS0lNdu8DIcGvazQuNg1P76g+RHAljUlfFdzUNXplfPlOT+xqSdX3Rei9Ve00cjxgLqq7BHcLG4sc1Yk0aidjuvLYZZfF1VrL4pwuHkqJkiFth3l2cPj7qgSRR247DPEmjNEh75FDKJxptMFH1Oe5tzOxTjpupn1rTnRKc0hh45WYVTqoSs1NyzF8TEgyMRYedvwuEKPa1ecGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4imtw8GQBpYNjDrhDMFARn02wWhnL4xlSFDmy8PAae4=;
 b=q5vxIuYdNhyRw3cWUwxxz4q1t7iDkRpbubGtPdXVGrs8GwZAogEW2+R/jaubyOcUtx1iLU1qUNdDJfnfvShTR4MgVfuOb9ftULQwTCTK98ghv5FqiO8Rve79NUoF6mZDs3vo08YoMnq4RHBdZCcJnVVYDhJyFtxx5LehQQrVvUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB5890.eurprd08.prod.outlook.com (2603:10a6:20b:281::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 10:36:27 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::e661:f010:4f67:a6c]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::e661:f010:4f67:a6c%6]) with mapi id 15.20.7270.031; Tue, 13 Feb 2024
 10:36:27 +0000
Message-ID: <36b813ad-fdcb-495b-9d27-3573b6177831@wolfvision.net>
Date: Tue, 13 Feb 2024 11:36:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] usb: misc: onboard_hub: rename to onboard_dev
Content-Language: en-US
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 Matthias Kaehlcke <matthias@kaehlcke.net>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-1-f85b04116688@wolfvision.net>
 <ZcJynrwp7zcs-aIT@google.com>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZcJynrwp7zcs-aIT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0097.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::26) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM9PR08MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 263a7a03-1672-4feb-0c3b-08dc2c7fa1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kab9DsSA0hnpY7gzaKlUmq3Uu9uh/iaN180WphB9bL3X6p/wF5szGdt9L4YLPyTCC7ZPiKxMEEU7SkD1H86Qfp5lvRlR5XZ1KTcaTbqoys2iSpKvQ9qnMv7Et6Ujodkwe2h+s8b9ujfD//2VhRir3vOXy4KbiQPZdDPNmYVKsAQRyoO5d9hOL2hw+Ylk/5iTTu4bOAob/GaMmJ3Y36656B/xhAGGpdL6JoMvyeQuzJlLEAMEqOFpMdLgEc66+wn+/7OovCOaSwKaMaSNmEqAbnlTYHqvi5SdV7gFfX9vU/mG6BSqLhdXkqDxE8HAqsq5owGchLlitoYoe2w8UEsnsSfT9xHQu8K0QJqTIHEAXqbmn8VpsqihttL1IDQUurTrURC1JlaGb1n5yM4MbMAFYuqNeclDRgibkArTLm62xieRy4kVtv0caWKByS1KS+3nDBakpJbu82ayde2kCx5Re9JTKcJzzhRwK1VlsipCJDAfwho/ZuJhIIIoQ5F8UAVbsDg0yTEaCd9otcEN0aan5+ZFp4+UMqeRKZAVlhpM8Tc6en3mu70R93jesYbw2xEi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(86362001)(36756003)(38100700002)(31696002)(5660300002)(2906002)(44832011)(7416002)(26005)(66476007)(54906003)(66556008)(66946007)(316002)(8936002)(6916009)(8676002)(4326008)(478600001)(6512007)(6486002)(6506007)(53546011)(41300700001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejIzdVRTTkhmbVRyd2o0a0YwMzJab1kvTXJsNmRRRDJ0RGNKa3dKa05kQTlu?=
 =?utf-8?B?RG1HelhnR216WG9ydjRrL01kbVpOS05BZWltRFRCU1RLUGRtcmhwMklvWHpm?=
 =?utf-8?B?VDR2OWltamt6d1h1b0FudUNyYVBsdE5mZEJsOUw3NnBTT0pYcW0yVE5YSFdp?=
 =?utf-8?B?UGs3eEFvU1Y0M0h6cEhFQjE5ZnpWNWt2VElwYnRBeXg2ek9zY21xNFN5ZXRU?=
 =?utf-8?B?eStVTGNmN0Y5WmhiVS9qOGRLWWRWdHZwRExPSlFNblEyNmhKSlpNNGVENU52?=
 =?utf-8?B?OTFHZHJBS2krdE5za3g5dkthZ3VZQ1p6Z2thQTVQZTQycHdZNmdaNTh0NU80?=
 =?utf-8?B?NGYxNW03YjhRQTRaZVdRelpUdVBvT25TeGhySzBwNWpYRWR2cUJQUnYrbDUv?=
 =?utf-8?B?cG4xYVZRQndHMGZaSGI4eFFXSGxTbVAxQStRaGMvbWliN3pydjRjTytLQjds?=
 =?utf-8?B?WDhWQUlPOUhVVm1vSzI1TmVUY3owWGlOWVJYVzUvUXhoa2x5OUdqcFZRNXJK?=
 =?utf-8?B?WHB0bzVCTGN1NnljMnpaZy9zTWxiMmZlSC9DdWtEUVpDREZXeU1tVTR2MVFX?=
 =?utf-8?B?MFRkR1lWS3NlME0vNG1OSmJGemh0aUNYMGp4MkJKU2pLanV1ZTNnajFob2ZK?=
 =?utf-8?B?OHhreUxaOTcyaWo3UDdvTDJ0d0lsTWhLeWNvaklXV2w4WCtXVzVCL0czZ29m?=
 =?utf-8?B?VDliMk1OSG5qMEEzeGJQSDNLYnN5UzN2RThLUU9HSjVVbVgvTzUvMUtWZ3Vo?=
 =?utf-8?B?OVZSNTAwc2luNTd1YzlZdktrSEo1YUdXSFU4UDZaeVpYUWswNHBXaHZXdmtZ?=
 =?utf-8?B?T2p4NU5TN01LcjYySHRqNXMvQ3Y2N0swYmovcDRDZEpnSjVaY3piV2dwWjBq?=
 =?utf-8?B?WmxtOVM5Vjc1d1U5UktwYWtZR2xzN3R4UHdJTElSUmlKWkc5Q1YrWDUwNXpE?=
 =?utf-8?B?UTlCdzM3K1dhNUN6SWNSaFRKZXRWQVNiclVTU25PcEhOVVN6Rm4zUXVaNjds?=
 =?utf-8?B?dStRRHk0cFNmOHVMOXIrcVlqVmpMUXJFZjdoTEdvTFV3NXMrakllYVh1Zjhi?=
 =?utf-8?B?MEkwWDAyTk5JRlNSOTJhT0dHeW5GTFkxQ3VxWXM5QkFVWVdGQ2ZSK2F0bWkz?=
 =?utf-8?B?emxwMjl1V2d1Z2lNNnFKQWZWUXgvaGhUTWVucGhnSVR4Sm9MTUl5alBtSU9w?=
 =?utf-8?B?WDNoN0RFb3lUc2M1SndMdGhkUVk1ZTNKY1ovZEYwbXkxZUpqVnpzc2RpK2c1?=
 =?utf-8?B?TmYvL3NHeXREcGx0OXpwTVZvclhOK0JqRk80QjJsVVhPQkowSmhLdStxb043?=
 =?utf-8?B?dVIzVTF2NTJISEFyNjU5aXFObm1sZjhOc2h2d3FpeDhsWjZMNzB5WDRtd215?=
 =?utf-8?B?R1lCTWdMVFROV2MvYnZnNlU0WEpWY09OeVhDZWhoMXRtM2JLK0taQkhYeG92?=
 =?utf-8?B?K1ZtSFdvR2FRU0g0UmtPVVRrVXlEK3JJMG14N2MxR2krQzY3a3VsQmh6YWxT?=
 =?utf-8?B?ZUxpM1o0SVQ1LzVFUUlOL1JLLzZsTlpPTCt5eWJHWHlsdStnWEZsbXRucHU4?=
 =?utf-8?B?RGZ1ajdINFVvKytpMnh6d2FLTHcwdE5LT3JoNnE3RmdWRk9FUWRJSE9OcWFC?=
 =?utf-8?B?RFdGNjlTMWVaNFdxQ0grZW9YMWk4amJNb1NIUURheEpvNUtQTUFUek5jSm55?=
 =?utf-8?B?VmN1a2RIUjBHRE9sNXo5NDZob3hSa2I4a2MrTDRNeUQ2NXBCdDFraVlDaHQ1?=
 =?utf-8?B?Q2ZuQWZWbGc2dWc4VHdWZFNTMUN3ZzFYRzVkZWZtaFhvTG9xVWV2Z25aUzk4?=
 =?utf-8?B?NFZvUGdsQUNaYy9WNDBTcXJYUGFLTUZMSlBZanlzVENMQWhiRHVuYWVQbjM2?=
 =?utf-8?B?emdvMjh6T3lCL3VIRzVBMXFNY2tHUUpGcU9KbENoV2U1a01UbDlEVWx6cTE2?=
 =?utf-8?B?WkRIREU4WmU2Zk1GN0FacHhZc2tJTkdqZzh1OXZ5T1FHOW5CMTkraGUyUDNa?=
 =?utf-8?B?cTFxMm5Ed0tWZGxtQTlvTlhZdzVYRlNRQjA3S3I0MnlPZUFwZHJLVURWaGJI?=
 =?utf-8?B?TVE2MFVsYjVKeHpOWEt0ZGhQRHhDZ3hLWU1VQjF6N080SDAwZTVoQmxUd0lJ?=
 =?utf-8?B?dlpjdW1VWmhSWko0ZURKM1pIdGp2NmdhaEYyWERRemJxZzMvbld3Y0JjSUdT?=
 =?utf-8?Q?6yxN1AEN4oBkxgZtybQzwKg=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 263a7a03-1672-4feb-0c3b-08dc2c7fa1e6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 10:36:26.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njt+9cwpukEYG9s5Ad6KLwVGi6b7UXKQNp6ylSxAG6VrEZWp2UxoDobvkF4PN2jR2Vc32q8jhjQigwXKArtifoYpiDR3y3BGIfs8yQxJM/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5890

Hi Matthias,

On 06.02.24 18:55, Matthias Kaehlcke wrote:
> Hi Javier,
>
> a few comments inline
>
> On Tue, Feb 06, 2024 at 02:59:29PM +0100, Javier Carrasco wrote:
>> +static struct onboard_dev *_find_onboard_dev(struct device *dev)
>> +{
>> +	struct platform_device *pdev;
>> +	struct device_node *np;
>> +	struct onboard_dev *onboard_dev;
>> +
>> +	pdev = of_find_device_by_node(dev->of_node);
>> +	if (!pdev) {
>> +		np = of_parse_phandle(dev->of_node, "peer-hub", 0);
>> +		if (!np) {
>> +			dev_err(dev, "failed to find device node for peer hub\n");
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +
>> +		pdev = of_find_device_by_node(np);
>> +		of_node_put(np);
>> +
>> +		if (!pdev)
>> +			return ERR_PTR(-ENODEV);
>> +	}
>
> The above branch should probably be guarded by 'if (!onboard_dev->pdata->is_hub)',
> this is also a change for ""usb: misc: onboard_dev: add support for non-hub devices"
>
I am not sure how to guard the branch like that because onboard_dev is
retrieved by means of pdev->dev, which is not available if
of_find_device_by_node returns NULL. The non-hub device will not have a
peer-hub property according to its bindings anyway, right?

Thanks again for your feedback and best regards,
Javier Carrasco

