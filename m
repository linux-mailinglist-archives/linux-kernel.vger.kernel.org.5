Return-Path: <linux-kernel+bounces-20056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D3D8278CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C102846DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A0F54FB7;
	Mon,  8 Jan 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sVYqX5Mg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8855C05;
	Mon,  8 Jan 2024 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408HrtvQ031424;
	Mon, 8 Jan 2024 19:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uVwT10PMgazQATHJa5vlJDnKd93+2U9U9hTTgES6aeU=;
 b=sVYqX5MgecjDKJcIcBw65R5miWwPoTS82wHPazm4POKsMZAK12xEdxKIJSh5eoJCetzF
 a0oC4LyUHqv3G+cdxV65LUQ0o3O8sPhzsve90clsrwBMPSDvv1xGywDr/Dr5f45ouUfV
 H/YlN5Bju9D4uj1v+4xnB1lfbyR+BiuyA8PPPBpZVd3x5KuNEVFADpqgr8gdZNzoh48o
 IhhH3kzb4F7JoPAl5qEg7HkXXNyN6A+C1Q8NkwDUh8rpXrDzaqdHRAqHPAd1OBBFAMAG
 llYEJsl9GZxQLLsKJyrHxti+bpS1MDoikn+h+Kb0R5IFbbqJ6y6pxrsVYo0GcjattaLV zA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgnfj34du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 19:56:10 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 408JtVqb027387;
	Mon, 8 Jan 2024 19:56:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vgnfj34d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 19:56:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 408JBSw1026992;
	Mon, 8 Jan 2024 19:56:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw1suak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 19:56:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 408Ju8Ms12714716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 19:56:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CF3958050;
	Mon,  8 Jan 2024 19:56:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18D1F58045;
	Mon,  8 Jan 2024 19:56:06 +0000 (GMT)
Received: from [9.61.145.235] (unknown [9.61.145.235])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jan 2024 19:56:06 +0000 (GMT)
Message-ID: <7ff0e3ca-98bb-47d9-8cf8-20a4e6aadd1e@linux.ibm.com>
Date: Mon, 8 Jan 2024 13:56:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] ARM: dts: aspeed: System1: GPIO, Fan ctrl, Led
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org
Cc: patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org, geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-7-ninad@linux.ibm.com>
 <1b19af6f-645a-4913-b9db-49b1f3ad54f9@linaro.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <1b19af6f-645a-4913-b9db-49b1f3ad54f9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n7OUMVLs0ZxVJpCaR3pkbmA29BSI5A5j
X-Proofpoint-GUID: _aB1q7Z9nfR0_O9BbgYWJrn1HoFgIx5S
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_08,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080163

Hello Krzysztof,

On 12/12/23 14:25, Krzysztof Kozlowski wrote:
> On 12/12/2023 17:40, Ninad Palsule wrote:
>> This commit adds following devices to the device tree.
>> - GPIO pin assignements, GPIO expansion devices
>> - LED brinker devices
>> - Fan controllers
>>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 547 +++++++++++++++++-
> Squash it.

Yes, I made a single commit for device tree.

>
>>   1 file changed, 542 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index b8e7e52d4600..75562aa63701 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -114,6 +114,99 @@ vga_memory: region@bf000000 {
>>   		};
>>   	};
>>   
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		bmc-ready {
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
Fixed names.
>
>> +			gpios = <&gpio0 ASPEED_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
>> +		};
>> +
>> +		bmc-hb {
> None of these were tested.
Fixed names
>
>>   	/*A0-A7*/	"","","","","","","","",
>> -	/*B0-B7*/	"","","","","","","","",
>> +	/*B0-B7*/	"","","","","bmc-tpm-reset","","","",
> Really? You just added these lines. There is no point in adding a new
> line and immediately changing it.
>
> This points how your split is artificial and not helpful.
> ...
Now I have a single commit for device tree.
>
>
>>   &i2c2 {
>> @@ -486,6 +744,20 @@ regulator@43 {
>>   &i2c6 {
>>   	status = "okay";
>>   
>> +	fan-controller@52 {
>> +		compatible = "maxim,max31785a";
>> +		reg = <0x52>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> Why do you need cells?
Removed cells.
>
>> +	};
>> +
>> +	fan-controller@54 {
>> +		compatible = "maxim,max31785a";
>> +		reg = <0x54>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> Why do you need cells?
Removed cells.
>
>> +	};
>> +
>>   	i2c-mux@70 {
>>   		compatible = "nxp,pca9548";
>>   		reg = <0x70>;
>> @@ -522,6 +794,48 @@ i2c6mux0chn4: i2c@4 {
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>>   			reg = <4>;
>> +
>> +			led-controller@60 {
>> +				compatible = "nxp,pca9551";
>> +				reg = <0x60>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +
>> +				led@0 {
>> +					label = "enclosure-id-led";
>> +					reg = <0>;
>> +					retain-state-shutdown;
>> +					default-state = "keep";
>> +					type = <PCA955X_TYPE_LED>;
>> +				};
>> +
>> +				led@1 {
>> +					label = "attention-led";
>> +					reg = <1>;
>> +					retain-state-shutdown;
>> +					default-state = "keep";
>> +					type = <PCA955X_TYPE_LED>;
>> +				};
>> +
>> +				led@2 {
>> +					label = "enclosure-fault-rollup-led";
>> +					reg = <2>;
>> +					retain-state-shutdown;
>> +					default-state = "keep";
>> +					type = <PCA955X_TYPE_LED>;
>> +				};
>> +
>> +				led@3 {
>> +					label = "power-on-led";
>> +					reg = <3>;
>> +					retain-state-shutdown;
>> +					default-state = "keep";
>> +					type = <PCA955X_TYPE_LED>;
>> +				};
>> +			};
>>   		};
>>   
>>   		i2c6mux0chn5: i2c@5 {
>> @@ -542,6 +856,44 @@ i2c6mux0chn7: i2c@7 {
>>   			reg = <7>;
>>   		};
>>   	};
>> +
>> +	pca3: pca9539@74 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
Fixed node names.
>
>
>> +		compatible = "nxp,pca9539";
>> +		reg = <0x74>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +	};
>> +
>> +	pca4: pca9539@77 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
Fixed node names.
>
>
>> +		compatible = "nxp,pca9539";
>> +		reg = <0x77>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +
>> +		gpio-line-names =
>> +			"PE_NVMED0_EXP_PRSNT_N",
>> +			"PE_NVMED1_EXP_PRSNT_N",
>> +			"PE_NVMED2_EXP_PRSNT_N",
>> +			"PE_NVMED3_EXP_PRSNT_N",
>> +			"LED_FAULT_NVMED0",
>> +			"LED_FAULT_NVMED1",
>> +			"LED_FAULT_NVMED2",
>> +			"LED_FAULT_NVMED3",
>> +			"FAN0_PRESENCE_R_N",
>> +			"FAN1_PRESENCE_R_N",
>> +			"FAN2_PRESENCE_R_N",
>> +			"FAN3_PRESENCE_R_N",
>> +			"FAN4_PRESENCE_R_N",
>> +			"FAN5_PRESENCE_N",
>> +			"FAN6_PRESENCE_N",
>> +			"";
>> +	};
>>   };
>>   
>>   &i2c7 {
>> @@ -809,6 +1161,191 @@ regulator@41 {
>>   		compatible = "infineon,ir38263";
>>   		reg = <0x41>;
>>   	};
>> +
>> +	led-controller@61 {
>> +		compatible = "nxp,pca9552";
>> +		reg = <0x61>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
> ...
>
>> +		led@15 {
>> +			label = "pe-cp-drv3-perst";
>> +			reg = <15>;
>> +			retain-state-shutdown;
>> +			default-state = "keep";
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
>> +	};
>> +
>> +	pca1: pca9539@75 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
Fixed names.

Thanks for the review.

Regards,

Ninad


