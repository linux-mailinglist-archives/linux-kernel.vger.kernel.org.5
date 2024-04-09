Return-Path: <linux-kernel+bounces-136070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C92F89CFBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA5F1C22680
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E278F45;
	Tue,  9 Apr 2024 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AmaSZzWI";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CxWfbWlg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D8BaOWMK"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5DC6138;
	Tue,  9 Apr 2024 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625667; cv=fail; b=g/Z3euWezmmBbv5kjYrzgwcGmqOh29o6JlvREQZUBl30R9rn9wz4wwRzlE/zO8qHTaHMK78vsZLPzzkBeIkYv3IZaC7MCdBhyMSmMJcYKnhhsns/6ubRlsvKr4wBBTk6/XCpEw09zcBw52TttHv3BjOD+0YeYgp9jeyo0ez/ehU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625667; c=relaxed/simple;
	bh=+/POp6dkA7FWlMU1X5r+fKx2pdNrLn7GZ4FnWHjMfRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxkRhyGktk/nvqvLYd7sbjdtJfrWJVMpepQ20X3Ay2TRsUsQoAflSZDxgR+lY2BFTDv8thFg2/TwB0rXX56MvxyOD/2drpqNu/c46bu5ImHGKea8URcAoD4146Lbzgo0YuD6TUfAxVWwzFmjCioTuvThYjhYkuUS2pAUWajMfew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AmaSZzWI; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=CxWfbWlg; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=D8BaOWMK reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4391GaX7002698;
	Mon, 8 Apr 2024 18:20:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=+/POp6dkA7FWlMU1X5r+fKx2pdNrLn7GZ4FnWHjMfRc=; b=
	AmaSZzWIItu8GraWfo/UNoGvwvNkFio6Yxjrkg2S/r4Z2RoZCB3f1upQs8HLI0H/
	GOJ+4aK7zsZBIlp15PrqUvqiDUkgTZ72UmQGs+BJPIIMxk4WN5eSxN38Jr7D08GZ
	ap0wdc8WXeh9Gu07kkLRi7YZqZGTyUPDKcCvq6dl0GYOwOP2UWjTWiUYJzZzV23W
	et6qH1HOTak+iuoiSm3W2s5TJlw03Jxu3iT1ezRS5vZ3wO249UNDm5UpIvlXGTgJ
	iW1KtvIf3GlN6G7bSwU5P87z0T9rav60BFDOjJkYqnxO8m2CHkOSL3pvWi3VzJbz
	4ZIdcFxtSZGL5QlpPzy9iA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5n3qc1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 18:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712625658; bh=+/POp6dkA7FWlMU1X5r+fKx2pdNrLn7GZ4FnWHjMfRc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=CxWfbWlgiiUnf6ZqQ6yFezUreNLzKktnftvA7VketojJiZ6/QkrdL2H/AFn9N34vE
	 4fc1g/x1Yo8gnngPc9MQ5gaBrj8IgzXgsO3yGxwnrkBmdto/TMlTCGJzqVz5a6QPZ5
	 a/62Oq7Sx08xwmFFDDxStswfK8g69a2PblypC3mm4xh2+hjgqERqaORcX2t2vRh3Qr
	 MxTMnBx2eSYcruWIFq5uVf9KxZ4652xw4VxWWBy2USZ9PMP5hFn9j917oB5lPZZoCx
	 BnOshrUJWbCdncP9ghNhRSuBd3xk3Z8HFI6DOdK8gl/nR/H4o1kQMaNwWYHmLUOJ11
	 RrtqSCDLu6dOA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4CA00404D1;
	Tue,  9 Apr 2024 01:20:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id F090CA00AD;
	Tue,  9 Apr 2024 01:20:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=D8BaOWMK;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id AC0A14045F;
	Tue,  9 Apr 2024 01:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz/1FO3ZrcP7xQtYGB8guzJQlazKwRgAghsZgsmbcf2f0Sa6XoyXEAR7VUASaJRxs3t4R4BNxau3zQ9lEMYylL+t+oinIn4b6CKiIX7uYawTlnLCY+iLHl1UDAQHaaWGttNT9XAcvscISp5nggAWh+dHEFAFL8YWYm8vseVmtjdE0TT1R3hN7FVc6X30tIdmHz0ytv539D3GZoDAbQKLXB+ISUyb4O2SpqW0+mAXFxSbfO6LMn0NxdjikeSvYY+QDgQqch3KhxBRvPwaAXe4dstwhPXSA3Vy0aay8BsPcRUDKGbj9Gt/29QZyzl7p1dYfHHy4un1aGQnjX9X/RIj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/POp6dkA7FWlMU1X5r+fKx2pdNrLn7GZ4FnWHjMfRc=;
 b=gg+Orcf7V3wqWEs0QE7poUUqen466LuOVX2lOgvZOI4VnFM0IylTXhBTksXhx+IYd9V3mUxd7O8XIBuyfybTMrPW6upBhLuhO9qsfF/RsYMHaJgRGwPilUamJhAjT5rILT5oMGRghkF+9/rOoGr//+z8PSMlwQVUBGrtnCAjrDunQ2TcIJ+cFu/NWaIsY7bgkCW6vWusj1JjSNnGmVIIV9YKg78a2UKkzVCOH19cGPULcYAkFuQJCfPx9XHVtQJCs5WQCGvROyN/8CDn4AqrVb+BlhoET9KVoQoEVS2Q1uKa1+1JJZ+AiMZoxiQketlPmAfOI8yPv9mI209UskIUgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/POp6dkA7FWlMU1X5r+fKx2pdNrLn7GZ4FnWHjMfRc=;
 b=D8BaOWMK/NF0FekS4Se7cUYXntn69MNO1kVAez8qaEdf3zdn2nhufbAHSO3rWQ3VbdGNzriVx2T9YEDDdqpZk8zS/vE0Kzlshyltd8Cq6HYcMXKcgIkbvBgaDrZ2oYC67oUDcoPz6OYiQLwWTscbAj16M7E2LlXeZ7WTzaVauSI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 01:20:53 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:20:53 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>, Johan Hovold <johan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v20 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Thread-Topic: [PATCH v20 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Thread-Index: AQHaibj5uJ/ZqTAIfE+jmNUv2lH0HLFfJN4A
Date: Tue, 9 Apr 2024 01:20:53 +0000
Message-ID: <20240409012050.btvctqh2ql2q5y7y@synopsys.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
 <20240408132925.1880571-10-quic_kriskura@quicinc.com>
In-Reply-To: <20240408132925.1880571-10-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA3PR12MB9106:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DkHMQbiUAN4+oAFEg+2uMDRLnJdMvzJsTJMaARbWDIIpTPH2gkNRNfMn5Q23gbEnqs0ez9FxG8WRiA0Q4ENSK0Y+eLLY5jpXBdyaJ3pbZXw7yKoaN+zYSwwYP0h9yAonEf9kxBeUMiTgYpzrkqnExQ66qKu1tY/EYPLcPKeRuxbz1AZR2WU6+lIvDxqoZpbIcVfxjdLENIPJm/DGl9Qjf9IuVLKKXC4or3sTOPA5KLGvyFq0oXrB6paBeH1qtsTO/9OokJkt02Ii7nr+VraQeuh0iBgD6uY2gzbvcLb2bWw4gEE0LXENQKZqPF9nStWCwexQi0ZWicX+0gFBwLnKr+Dpttr/hrtmz3R50nMn5dmyfHc+jjnkKHFq8Qczo+IxTTeEfAPL12iBzwmQHX1BIgeRnaN18pGQa9evhKzIWRs/KsjLxMbGRrEUly8O1fibfaXbCZycWMe+woteSqCuamVj7dgf1Tdqzj9VSgyK/I0xtA8PBuo9I507LWnkg2JinpqHZlJyTLz3NiO6q8Bfr3aZ4qicB0prZl7SJg6HB248KKPZAapmf29JJcD+18HMJ4HK1fYT2eFZ7z+WPOPN1rJvwviA8qWiWOvVimAKfkyPq+VRUlENb8XKzv61MxOI+cJ5lnqIJIWnkFbrnR2R8yLPD5EN7aJppjrrnV6xYvA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L0t3WS91djVGZGUydUxMUm13L01GUmgzMWVTaElKWklZVXY2czBCNzhidWdY?=
 =?utf-8?B?Sk9JaTVTU1JVWGZMRVpja24zZGpETlNzSmVSMGY4QjRsa1NkVnMvYW9XREtK?=
 =?utf-8?B?eU5uZjQzdnp6S1U1dXVxUEI4WDZnSHdKTWoxdks2bGlDenB1UWxrVUdyRjM5?=
 =?utf-8?B?ODU4SmYwblduV2lXMlNVSlZIU2VpQTA4VmdVSWEzNW15MkwwcVl3STZhY3d2?=
 =?utf-8?B?Qk50UkZIZm9VNzRNUS9jUmQ2QkJNN0JiOGxESDNCY3o4V1c4SHdXVDhOT1Fv?=
 =?utf-8?B?MVBJbzJPeHpJT2diSlpyQWt6ZXo0NEdwY0J3bWRKWGpVbmZOOENnSWhVU09r?=
 =?utf-8?B?SE9aajVISW4rNXVzaXovYWJHVXJRNkwzMUgxdFVFSHR2S0taQU1MakF3c3I1?=
 =?utf-8?B?SGsrajNGOXNUREpYWUFBY1o0WDJxTUVGQTdjWUJ3Vkttdi9Sc0ZuMGE4dFJF?=
 =?utf-8?B?elhFVVcxN3VLaEcwMS8yalZCQURaYWptMmNHZTlyWVM3YWNoRVp0aHJFQ3B4?=
 =?utf-8?B?MmRKaWZSSVUvelA4N3RhMmtXZXlFY3ZwUUxhKzFQREhKKzJqbmplS1hiNGgr?=
 =?utf-8?B?eWZiOW1vMXpEYVcrT2Jua2pQNmZIWlc4NlVlMjdkZ3hJTUh2elNiZzE1Y0F3?=
 =?utf-8?B?cmJyRUtsbnFSSk5CRHQwc1haYlBWU2F3eW1CaDRWQ0d0Qmx1b2hCd28vYmxU?=
 =?utf-8?B?RExMMElTd2owdnJYMDRpY2RTMWpnTHl3U0RSZUtiam9UeW5oTzBraWdPWDcv?=
 =?utf-8?B?UjRYTGthUVRHSG1VSWxYYmxOb3RNN2RBYk13OENkdEdlV29oQVNURVNaMENj?=
 =?utf-8?B?OEVrQjNobVp3MkQ2S0QwcWtLclhobmdTcFBTK1NmVE9GVTlTYldPUGczOHZs?=
 =?utf-8?B?M0c1RmVnZzFHVFVNZDhNV2pFalIvNU5qcTFpQ1BiSGpOQnlFRzluQ0ZQaVV3?=
 =?utf-8?B?am5PckVSUW01S1RYRkErdUowNFBvUy95Q210YTh0Q2QzdmR2OElxK3FGVHZr?=
 =?utf-8?B?TG9HOWJGbmtqUEk2KzM4UVJuY1JTam80ekJqcXlaRHVpTEZNVG83dVh5eTYr?=
 =?utf-8?B?ZFltdi94NjZuK1dYYVpXQWlOK3NqYmo0RzhPMU9ZdmZiVXN1djBzN3dzZTF3?=
 =?utf-8?B?eGErMDM2QWk3YW9Hc2ZWU0EyYzFJRGxFMXBncHZpcTE4VGZ0MW51ZGQ0UDEx?=
 =?utf-8?B?YkJvSlhsd2ttdjNBQjJuL0d2YlRxUk9ZcmRvZ0ppTW5XVXh3RForRTM4eUZU?=
 =?utf-8?B?QTdhYkVQRVkwTUFDeTBETUk0NHRaamF0bzU0Z0FBUFJtN2o3U3FDbGlObjZn?=
 =?utf-8?B?RmFvNURPaEtWZUxZQVVpYXNFdklRTFhKaFFvUzlQcjRYRGh2MTZWSStCMTFX?=
 =?utf-8?B?Njl3YWpqUTNaUGNTZFVFZ1pFeFA1eDI1KzBwZnFwT0pQS0VMSjU4T0NJTm92?=
 =?utf-8?B?dS9UK0dWcW9KSU5lOWluOFBkTzN3VURBci95ZDBHR0x1UUxhTHNyT2puM1B5?=
 =?utf-8?B?NTJmc2VJd210NmpITlArWlVRMS9kbUdCTkNqVDJORGduVU5iNEM0aVp0V3Jx?=
 =?utf-8?B?bWttZ3FuS0o2YWlwQ2E1bWp2T1VNWGJxcXpKWnVxWkxsYkI4OGhDU0VKMDlM?=
 =?utf-8?B?a2tJWXhJRlB0M0FhNnM3TVlEUWZoS29FZmlhTUtvTHBIZ1pEV2ZaRkl4bDVx?=
 =?utf-8?B?VThOczBRUEdoS3VwQyttQUpNVFRyZ29rRm0yM0FTZVBwUFJtN0FPVCt4dkZH?=
 =?utf-8?B?enAyVnhUSkFKNGxBNHMxcGxwSzQrZU8vMlhObEIxREh6bDdlNDN4bzdPQlNk?=
 =?utf-8?B?QW1Fb1pNbEc2KzVFVWd3Ri80WW5Rcmh3WGk4Q1JPaXg3bDZpNXpzampZR1M0?=
 =?utf-8?B?MTdrbUFUdklNV05XM3NEZXk0ZkliTHFxWEIrMXRrUDZLMlFwMkpzREJPRFBM?=
 =?utf-8?B?TWlCekovSSsxdFRVKy9GdTBrYVJkSUtLaTRoSlZwamVwL3RKT0I3Q2gvMFpv?=
 =?utf-8?B?T281Y3o0S1haOXQrbU1kMmxjOWF2dGdmWU9SaVRTVFRNWVZNTEhBcjI2Yzlt?=
 =?utf-8?B?RmswS2Y0V0lOTW9CS0J1UG51V3RqVHkycVpJZFIyUm9LbjN2YWcvV0dkRjd5?=
 =?utf-8?B?K25UK0ZxZDZuNFhpc3JPanZ5T1Jla0JYeUZndkdtZThpN0ZUeUNJTDlaMkpH?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <308AE23607D81C43800E83053898F608@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tAgXCf/liF3C6xKPlRr/QAj4DblTh9+/U6RuS0Ds9o4n3DAXXDlNQAjUfllbT+MTwSNk7jzM2eFZQ1uIWJARkFgyxPBb/jPlMOw3LaUwUUf6mkaD6vsy7Nlr9w2GLv0qeWm95qRF7JdaNGRhIgw1CpreTY+98TUbWoWYM73yfrAEdDdMLCyH+dBuKZUlylw2gpCNOWHHDtgbpe8Qr7cVfLrkshKf1/euwV0zOu2JvvHnXfnltKhPu5uj5vb3gK4SUJL7jJ2B3RVC0gLPyVJs6zvftGL6rJaHUrc1Di/X2LfxUydL4zdFvjFIUXMUuqReHKdPXR9Q3a9pCyZCqvr2JJ7tm0QZK2czPgjIl2s+YjM3awp0KRZJ+YAw57nZdXJb2wTC8aSdWPhW+g6m3kv5VcqVMkD/OQYD4426hxR5dVMP5Xtqk3qGYV+n2iB8Q15upsHli20qWkrMgGIv52HItU+Io3kxmFe9+uXLfaXe+ukZI8dli0aFpVZyirjbl5oFAEoSCEdznjzM29VJbDKXup5ND68jwdLIdostk+AHJhTPzZR+3uoZSwLRZpzRTH/6vNMUYtVv3rxEKnoPAz0yKQRfDJ432bgc3w4JqjmNwgSm++1eyPojjUIkKJDwz8wesg2Cs4SF42eI9w5Q0+QT2A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb910fc-849c-4177-12bd-08dc58334c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 01:20:53.1814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6nLmSGpnMFvVc2i6WjpiHLeHsGNlABecahKE8Ls9hNsKyCoERRuWIKUheiKiAKr3qYCAsYg+VWnZMB7fjuRLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
X-Proofpoint-GUID: Hc97VNGRkEjwY4n6dr8wPAoqtY_lYdsi
X-Proofpoint-ORIG-GUID: Hc97VNGRkEjwY4n6dr8wPAoqtY_lYdsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404090005

T24gTW9uLCBBcHIgMDgsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IFBvd2VyIGV2
ZW50IElSUSBpcyB1c2VkIGZvciB3YWtldXAgaW4gY2FzZXM6DQo+IGEpIHdoZXJlIHRoZSBjb250
cm9sbGVyIGlzIHN1cGVyIHNwZWVkIGNhcGFibGUgYW5kIG1pc3NpbmcgYW4NCj4gc3NfcGh5IGlu
dGVycnVwdC4NCj4gYikgd2hlcmUgdGhlIEdJQyBpcyBub3QgY2FwYWJsZSBvZiBkZXRlY3Rpbmcg
RFAvRE0gaHMgcGh5IGlycSdzLg0KPiANCj4gUG93ZXIgZXZlbnQgSVJRIHN0YXQgcmVnaXN0ZXIg
aW5kaWNhdGVzIHdoZXRoZXIgaGlnaCBzcGVlZCBwaHkNCj4gZW50ZXJlZCBhbmQgZXhpdGVkIEwy
IHN1Y2Nlc3NmdWxseSBkdXJpbmcgc3VzcGVuZCBhbmQgcmVzdW1lLg0KPiBJbmRpY2F0ZSB0aGUg
c2FtZSBmb3IgYWxsIHBvcnRzIG9mIG11bHRpcG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEty
aXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IFJldmlld2VkLWJ5
OiBKb2hhbiBIb3ZvbGQgPGpvaGFuK2xpbmFyb0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgfCAyMiArKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jIGIvZHJpdmVycy91c2IvZHdj
My9kd2MzLXFjb20uYw0KPiBpbmRleCAxMjE4MmUwZjhmNDUuLmQzZTZkNWQ1ZThiZiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2R3YzMtcWNvbS5jDQo+IEBAIC01Miw2ICs1MiwxMyBAQA0KPiAgI2RlZmluZSBBUFBT
X1VTQl9BVkdfQlcgMA0KPiAgI2RlZmluZSBBUFBTX1VTQl9QRUFLX0JXIE1CcHNfdG9faWNjKDQw
KQ0KPiAgDQo+ICtzdGF0aWMgY29uc3QgdTMyIHB3cl9ldm50X2lycV9zdGF0X3JlZ1tEV0MzX01B
WF9QT1JUU10gPSB7DQoNCkRXQzNfTUFYX1BPUlRTIGlzIG5vdCBxY29tIHNwZWNpZmljLiBGb3Ig
cWNvbSBzcGVjaWZpYyBtYXggcG9ydHMsIHBsZWFzZQ0KY3JlYXRlIHlvdXIgb3duIG1hY3JvIGhl
cmUuDQoNCj4gKwkweDU4LA0KPiArCTB4MWRjLA0KPiArCTB4MjI4LA0KPiArCTB4MjM4LA0KPiAr
fTsNCj4gKw0KPiAgc3RydWN0IGR3YzNfcWNvbV9wb3J0IHsNCj4gIAlpbnQJCQlxdXNiMl9waHlf
aXJxOw0KPiAgCWludAkJCWRwX2hzX3BoeV9pcnE7DQo+IEBAIC00MjEsOSArNDI4LDExIEBAIHN0
YXRpYyBpbnQgZHdjM19xY29tX3N1c3BlbmQoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSwgYm9vbCB3
YWtldXApDQo+ICAJaWYgKHFjb20tPmlzX3N1c3BlbmRlZCkNCj4gIAkJcmV0dXJuIDA7DQo+ICAN
Cj4gLQl2YWwgPSByZWFkbChxY29tLT5xc2NyYXRjaF9iYXNlICsgUFdSX0VWTlRfSVJRX1NUQVRf
UkVHKTsNCj4gLQlpZiAoISh2YWwgJiBQV1JfRVZOVF9MUE1fSU5fTDJfTUFTSykpDQo+IC0JCWRl
dl9lcnIocWNvbS0+ZGV2LCAiSFMtUEhZIG5vdCBpbiBMMlxuIik7DQo+ICsJZm9yIChpID0gMDsg
aSA8IHFjb20tPm51bV9wb3J0czsgaSsrKSB7DQo+ICsJCXZhbCA9IHJlYWRsKHFjb20tPnFzY3Jh
dGNoX2Jhc2UgKyBwd3JfZXZudF9pcnFfc3RhdF9yZWdbaV0pOw0KPiArCQlpZiAoISh2YWwgJiBQ
V1JfRVZOVF9MUE1fSU5fTDJfTUFTSykpDQo+ICsJCQlkZXZfZXJyKHFjb20tPmRldiwgInBvcnQt
JWQgSFMtUEhZIG5vdCBpbiBMMlxuIiwgaSArIDEpOw0KPiArCX0NCj4gIA0KPiAgCWZvciAoaSA9
IHFjb20tPm51bV9jbG9ja3MgLSAxOyBpID49IDA7IGktLSkNCj4gIAkJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKHFjb20tPmNsa3NbaV0pOw0KPiBAQCAtNDcyLDggKzQ4MSwxMSBAQCBzdGF0aWMgaW50
IGR3YzNfcWNvbV9yZXN1bWUoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSwgYm9vbCB3YWtldXApDQo+
ICAJCWRldl93YXJuKHFjb20tPmRldiwgImZhaWxlZCB0byBlbmFibGUgaW50ZXJjb25uZWN0OiAl
ZFxuIiwgcmV0KTsNCj4gIA0KPiAgCS8qIENsZWFyIGV4aXN0aW5nIGV2ZW50cyBmcm9tIFBIWSBy
ZWxhdGVkIHRvIEwyIGluL291dCAqLw0KPiAtCWR3YzNfcWNvbV9zZXRiaXRzKHFjb20tPnFzY3Jh
dGNoX2Jhc2UsIFBXUl9FVk5UX0lSUV9TVEFUX1JFRywNCj4gLQkJCSAgUFdSX0VWTlRfTFBNX0lO
X0wyX01BU0sgfCBQV1JfRVZOVF9MUE1fT1VUX0wyX01BU0spOw0KPiArCWZvciAoaSA9IDA7IGkg
PCBxY29tLT5udW1fcG9ydHM7IGkrKykgew0KPiArCQlkd2MzX3Fjb21fc2V0Yml0cyhxY29tLT5x
c2NyYXRjaF9iYXNlLA0KPiArCQkJCSAgcHdyX2V2bnRfaXJxX3N0YXRfcmVnW2ldLA0KPiArCQkJ
CSAgUFdSX0VWTlRfTFBNX0lOX0wyX01BU0sgfCBQV1JfRVZOVF9MUE1fT1VUX0wyX01BU0spOw0K
PiArCX0NCj4gIA0KPiAgCXFjb20tPmlzX3N1c3BlbmRlZCA9IGZhbHNlOw0KPiAgDQo+IC0tIA0K
PiAyLjM0LjENCj4gDQoNCldoZXRoZXIgb3Igbm90IHlvdSBkZWNpZGVkIHRvIGNyZWF0ZSB2MjE6
DQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoN
ClRoYW5rcywNClRoaW5o

