Return-Path: <linux-kernel+bounces-128823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514BE895FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAA01F24799
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55245008;
	Tue,  2 Apr 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dNUdxq9C";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SG2Smpp+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lga2bufj"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61836224FA;
	Tue,  2 Apr 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099946; cv=fail; b=MVEfNF7oyns0aADrWM0ezkJ8oSbOyCTSbH5zQPNuUFJRebSxSgK40VUctiImKqOYeFZqOCfc+OEF/p8okOB8UEuG8LfK4YpnrTRitAq7SWipKGZDFuz/JTqKc7sb+JkvfKmYwlswLfhGaTIuGhiUFK9PgfqIX0QLuT8Uj+2oz4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099946; c=relaxed/simple;
	bh=p8qLC5HmvVL1v064zpcy5j6uEMIb1Zor/fJUjBjrDvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EXSNDQjwtAwAxY9ERO64IuZcQ0P95J2Fxvf2ccLqGLOHTP7wVVGNKNFbQfPsCXHL182Ed5p4sZUeN8gxoro2GMt+WD9sWvnr8ZR6KgKaJwDNh2icVS9dPy0GWAAdD1B5DChh8uDj7wQF/qXw2BB8nrPz7RxvqYpSNqugtsmkfYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dNUdxq9C; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SG2Smpp+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lga2bufj reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432IO41H011105;
	Tue, 2 Apr 2024 16:18:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=p8qLC5HmvVL1v064zpcy5j6uEMIb1Zor/fJUjBjrDvA=; b=
	dNUdxq9CQ9QN74oDdRJgZIAbbRhVj+p3GXMeYAw6hV0AubthLgMisHDS9UlYsC8a
	Z0icq/r1RzHmgrJ4cKQjzaC0Lba71JnmDFrH1LEuwtz14vJwxWnHq0W4esWNw9Dq
	18ArL9T84egMQ5XGpdvPyX7h5p/OuEOTVPFTb+N3th67I8yHpkcmj/T/A4E5Bux9
	oTwmgZ75xlehqjY+Ah7IQ3cImIPTjJL0Sb2KtMBuglM4vM7SWMTTabQv5HpTBWq6
	mSObMq0myvg0+/iG7dTkNiaSFyI3RIGMOQVvIQ5vhs6GhhPKGE4FiQSuKPZDIVmS
	fi9JUNxn/0N0YHHmzRollw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3x8q82114s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712099937; bh=p8qLC5HmvVL1v064zpcy5j6uEMIb1Zor/fJUjBjrDvA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=SG2Smpp+FQM/p/5jXeXOvOAsOtIkO6ncp1AH1TstQ3YLDAf4Gm2KzZuRo90d4Glg4
	 UxRTd/5SOG07j/tjBrFroyX1f/QDEbjLeUy5BocMRH04FnGq9v8XmNQo30h0evJKro
	 UdlcGk5Qkzoj5QwqpKQ09siW6AelENQXAEcptTAQTAux1vkFe8OfJCfCp7hJb0Fp6d
	 P4W41LK9wQapK0xkxniLVHk666zQ3nE+gefbTLj5EbuoMp4gO6FMhaxY1dPFgKfyyf
	 4XVluoxG8TUgTFMvnlH9EV2w5E8KvUrlmmucqlgtfxjVT3zw+xtaKiPUmdBY4jXtDp
	 3KwDG1WGtQMoA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D53BA404AC;
	Tue,  2 Apr 2024 23:18:56 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4E78AA0261;
	Tue,  2 Apr 2024 23:18:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=lga2bufj;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2A51140123;
	Tue,  2 Apr 2024 23:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYpP1Vrie/8l+mb8NtKXA83fODsi4bDOvy/YtrtqEoyKKSBqTfq0+JgpBomdVWWxpZdoorwDPnYhgQtybbyw8b/MfErDoY9JMIHlyuvtPc+ua/UXE44CvqMg3IuolMh/J87e9YL05ouY1QYI+MstqIB5LSp4H8e86zkzTAV0GRHojwWdEQ+gGERT7ajw5o/Wh9RmtuRWv6k9NVvUMWVjMuVYdJiFZK8gWNvlvY4yxs25ESp/zDJFPE4qCHTQaj0DOSJRRacpyYhHjfbuOdw6JjO1ydXm1ayNrNb22nrsd1z0UL03Qn1BH1zSa8KGx2UQTw6E1PMj7yIn/npjxkbOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8qLC5HmvVL1v064zpcy5j6uEMIb1Zor/fJUjBjrDvA=;
 b=bC/pl+d5P1Nq67DFivxm0QoBO5534AAUIFgBiftJLISWibS44sOqYWZXU22mubhp3J4SdT4GWllrczehxXsn5lVHEzsd5CVRPvUNj53NndyFRvjQtVCfj8bcat3wW9gPWTRge6XAg4S4/jS2kZdISDfRF+/XhsngioKIVwZa9/g1cXDfnUSle8yGfskUPa1z2lAWw4ImYV61PYA5sBQb4zfijM/JwulozLyaytQPXeV4QkPmTBE92YyJT6LnVxEP3Hy04rQm7dfxmnPeHr3+l679vs+4C7LgnSdDave7iwhC+Dr4Q1EMqb42XsVMMXPOMBPx/VR5F1rrVCyExC6V2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8qLC5HmvVL1v064zpcy5j6uEMIb1Zor/fJUjBjrDvA=;
 b=lga2bufjyT9y1TSVITbhDiVOQuHjru5jYiQ8w6GmSm7jKLP2XomjoDu2jI8iVdcWpiZkXMOU3WCdx1FqiLjyjBBZYhKQRvIRGjZXPVZ5v9lviFA6HuTD2D6RvDA3KZPmHLIkoHpJt+1mTbLrdFZL8uc0AyWUkr68P/wBncdPYxI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 23:18:52 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 23:18:52 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Topic: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Index: AQHahUf+Fjbt0R5rsESCdAPrKfiIcbFVmhGAgAADmgA=
Date: Tue, 2 Apr 2024 23:18:52 +0000
Message-ID: <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
References: 
 <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
 <20240402230555.xgt5uilc42diyr4m@synopsys.com>
In-Reply-To: <20240402230555.xgt5uilc42diyr4m@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB7597:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 as2eghEUOYnCkalGgNSUcLQZXCTmfiFT/zFgyN0fuhcy5b9Y3DbIlL6VtYknVelvMA/6d13FgStu5qZXVCxSfjm5bltnzoTFhVczbgIpSr19Vqsd+pZDmo+rG5qT9b51KdKxdyeq+ftMKwwqWCSm9O2hSDRpICyNL+O9hOLNQfjer2hgsFmhDUu8yFZkrmKqim4VGprkz3EHGgF5PKySrENU6c7oH9eCSBXR8qtFUZUM9Nj2f33yzY1LM71HPF34DR7zW6c7u3WvbzPX+9SRDpTnssAlT6/1Ol5+M8axkC1Af6UiHZ5rX7Leo5Cbab4i+kiIBQAs9og0AaT117/ZKA5MdCoV5lT1/nq7zQmKz4dAtUEL5gHkK5Txsr+PDzCaxma+rBgTnhZK6WGmwlgmEeqSGstqGyBNrV6umvP8y2RMZgFlvG0qAr2sR51aWzUucjuEduWJ1Aq8gWTW0I9cPcG8Z4L5KbVeYeIksCN5g22tZJSVVC+S8mr5qXSA/ot4ukmvcNPuQwzMZJJnBqYe3F2JQZC1W2aIMQOpMBMskpmu4j2shZuNVYUoQg1MQIqf9LNglXqDRM3ryS4NN75p6JTAHpVJSDi5fBoWDzEjNNbD8CREsddY4I7xlABF3liTjpmrkym+0gLs+8yVt+HicbXxI7vrM12R/nVI04xJh4U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dHc2MXY1TVFraGNneTM2MVBtNnE0ZVJwb3h2dDF5UFlGVkpPc2w2RzFrUlp0?=
 =?utf-8?B?MFlZZkVvZE15RWYxSWVrLzFKSGNCSldsK2s1eUpXMVREM2dyMDlrQWQ4U1Q4?=
 =?utf-8?B?VjV2dHA2NEtJY01VZjYxcXBJVkpmdVRRclIxRmgwT2VxREI3UUdqbytFZ0VF?=
 =?utf-8?B?eHlidisxSEYvMVRETjFYS05sVytmNk15czlnOGtLUzBHZmkwcTMvaXJHRDFG?=
 =?utf-8?B?aTFhaEV0K01MNkY2WTl2eng0S2pPWWVxZWJtK1Q0aUdLTWNUdkxyV1RkQTNj?=
 =?utf-8?B?L1BYeFRlS0dZazBhV29CTEtSTTBzRXRVaUxWK1g2d2ZXN1NMY0VYaHVDeCta?=
 =?utf-8?B?MU5rYlVFU3QvMkVvSWUwWWdWeTVUZWFSb3dneHpFOTB0MWtRWEgwSjd5eE1w?=
 =?utf-8?B?elNnaVErbGFhRHpNMnM0Z3RWOExYL1BNV293bDFlTzREUllTdHBUWm9kM0tD?=
 =?utf-8?B?TCsxWWFqRUlXTjNvNVROREEzMTlLQnU5NVN6b0pwWitzRGZ2VDdwdTRNdmVh?=
 =?utf-8?B?QUVQTVdvNlprSjVScFRyR3FmcHpWNEp3SEJRYWcvY2liU01lclc2UHYxd2NO?=
 =?utf-8?B?NW9obnh6K3ZUWDVxNnllRjF4VVNNMnFEZVFmTTIrSGliYVNsSFYzMm9xNXNL?=
 =?utf-8?B?U0IxSTMwNng4dFNQd3d1THF5R0VGaGUreUxTb1pZOUcxUmFRWlhvU0xvSndi?=
 =?utf-8?B?NHRuTGtSczd3TlVxRHV3Y042NFBzR1Zkdjl5TGRWUXVuOFdpZk9oZWJ5OURV?=
 =?utf-8?B?YUFrLy9lUEplb2FmL1JMWWg1ZVJvampIOEoxU25Oc05BcStsM0hZbGtRd21p?=
 =?utf-8?B?bTRkWWV3c2tsNHJnSlRzOGcyaVlDbG4wbE5TaDFuYVNTZEdndkx4dnZLUHhq?=
 =?utf-8?B?bVp5ZWpBZ3picHFSVzR3QlFOcEc1UWVlQm9jZjNDNzRXSHp3YysxV2FlU2Ra?=
 =?utf-8?B?OU9kMHNwUlZ3VHlvbU00UlhTMXRLVTM0OFloOUpBWDFnQVVqUCtnbDArcVJQ?=
 =?utf-8?B?VkR1eWRtc0ZFZXBYbGlVRU1kVkEwMGExTm52MHZKQk9OdGsyZWtPWHRXcnNZ?=
 =?utf-8?B?TE51eVRzVFMxeWJvUVBiSzBoQXJoREVNQSt0M0ZCQ3FtV2I0Z0s5Um83MVJa?=
 =?utf-8?B?MjZ2MTgxRXF3QytWR3NFVno2aGhCQXErTlFuRTFKTEprQkcvc0FOWVVQT1Av?=
 =?utf-8?B?Zk5GU0VVeWpETEJQVUE3WVhHWEthcmxCNWxFWVk5V1BIcmhGUlRGZm5FQ0Vo?=
 =?utf-8?B?NFRraWFPSjZEVCtrd3JWT2ZSZE1ub1VnV2VzRkFBVTVxTnhvOEkrUFVucFh3?=
 =?utf-8?B?K2Ira1pPVUZCSGNHTzdGdW1UVUNpaDNVV3BNRkVYWGxLTDJmQTQ4Rm9ZcDJl?=
 =?utf-8?B?SXFJL1FQUUhlbjNqV2dVUVdrWWY3QktIenptaU5MY0g0MUg0amJMK1dFWnpo?=
 =?utf-8?B?czd0dVhoQW5zbnEwb3Y1RTQ2UTg2MzFVMUpuVmdMdmxyT200ZmxTUmFjckpX?=
 =?utf-8?B?K1p1ODYzNHJYTXhWWHF6Zjk4QjR3aWZxWDNOU3Yvblgvazd2djVselQ5Wkx1?=
 =?utf-8?B?SFVpOU5SWkFrUzk2UmpRMmEremZxa2lTWGVuRnE3SUVWR1QyZHY0amVGbWpt?=
 =?utf-8?B?WEVkZE9YRDBkbjNVTnVUakxzTXpOVTZNdkkrZUNSRytPSVdna05MY1J6N2pB?=
 =?utf-8?B?OHZxOGFseWhJYlR3Wks4T1hxTTVPM2JMV0VMUHdIVm9JYjR5TTZaZlI0TGpu?=
 =?utf-8?B?ZGp1OU1hSGRscEVqWG8vV0xOamhFMTZ3K1NOT1lSUmF0eXhhaGVia01MQTlL?=
 =?utf-8?B?R2tBNldtbHVudnoyZ2hnUkd2eGFNcGE4U1AvbGc4OW15dVlqOEY2SVJSbzdI?=
 =?utf-8?B?ejZva2d0YzJRQ1FqaDh1K3B5YkFFaXBmbzdtQVQ1R05PeW9teXBXbDVJbStX?=
 =?utf-8?B?NlpuRVh4SzZIc3pZS1hsZ1ZyeHNOc3lSNkpzMzFEeW56UXZHVUlhd3ljY0hl?=
 =?utf-8?B?Z3dNV3Q0a3FxUzNNaHpQOGlEaHhDRFBRb3k4cmlzNnZGUmV0aGFESDlzelZC?=
 =?utf-8?B?M1B0anlOODJsUDV5emlqeWR2eTEyblVpWHlRT2pJNDhmN2xMNGFFa01zRGRF?=
 =?utf-8?B?OWVLd2ZxblpOdFN5RG9xMElpamNPQU5QY25aeXUrMDUyZzBoZ1p1dVhMcHg4?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9201B37ED7804840B524B586039FC3B2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c471mtG6vFSzG3a45aDoyxVCo/TAJLL6wXTIzzagmkqlc9IChfvkbq968y9kFCx1QjH5pmKg1jo76jw/kXwk9gjBXSiZJskvp4Kkt83Sr5c5JnVh9ClQqsgwrHeg1AkACNWDxJsrfXv9EpEUrxkuIA8N6NBIFqhxzw9R22Rpd1t2WoamPMyXlUj1SgX5Zv9tCXPmGDMQIeG2xXFnuFtjSV7wGZqB+5puXhy1qOTlQIQyo3sv6sJGK1uKONwStMJsNHK9mjrhUdnOmheWQujsa85FNrPA9lmtZn9+ewtiyFWR9iF8vUcLVO+WQ6OYc8xw6eKogm4jWXcyVkFsUCbtg7/unwtgjedF++gfSrzfHjetTjDrg8obroLyPjXJZ1zjwj38YH+Mz7eDILY/T5dVC25M9K2S953IToZRVpaFt2uRln7WBPIn6FP31XS4Ms7vnAsW9HcknTN07qgKZ9Tn20zpXp+3VCmmYoeGH7VHuUVDbaaJJ+fyyunqJ8P0rjz2jCMYCqzD24RkQ5dtKGRDY90N6+h3x0LL8Lk2FgtCt8OEi1lJJ6yK7LMQv4k6GhlgJdC3KGuhHBZxrKpz09koxt4uH2YOMNqOl6CoEIDQueEtyM6sBUwY/qJn+09GIpwIIUX0EiEoDG9a3o2V0I8jAQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae3246f-e504-4696-a3ea-08dc536b4275
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 23:18:52.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSiYfJJwojXQi7FxJGIAaQplv5v+OEZLDNs+lk8JRrvGYQKMTa4YHgbLOfsdrG3qNLS8unPn+etnHrYVJYyUaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
X-Proofpoint-GUID: Y_iMIMFSW0VCROLZro-GG8uaEQ_PZjSn
X-Proofpoint-ORIG-GUID: Y_iMIMFSW0VCROLZro-GG8uaEQ_PZjSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 bulkscore=0 mlxlogscore=629 mlxscore=0 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2404020171

T24gVHVlLCBBcHIgMDIsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gTXkgY29uY2VybiBo
ZXJlIGlzIGZvciB0aGUgY2FzZSB3aGVyZSB0cmFuc2Zlcl9pbl9mbGlnaHQgPT0gdHJ1ZSBhbmQN
Cg0KSSBtZWFuIHRyYW5zZmVyX2luX2ZsaWdodCA9PSBmYWxzZQ0KDQo+IGxpc3RfZW1wdHkoc3Rh
cnRlZF9saXN0KSA9PSBmYWxzZS4gVGhhdCBtZWFucyB0aGF0IHRoZSByZXF1ZXN0cyBpbiB0aGUN
Cj4gc3RhcnRlZF9saXN0IGFyZSBjb21wbGV0ZWQgYnV0IGFyZSBub3QgZ2l2ZW4gYmFjayB0byB0
aGUgZ2FkZ2V0IGRyaXZlci4NCj4gDQo+IFNpbmNlIHRoZXkgcmVtYWluZWQgaW4gdGhlIHN0YXJ0
ZWRfbGlzdCwgdGhleSB3aWxsIGJlIHJlc3VibWl0dGVkIGFnYWluDQo+IG9uIHRoZSBuZXh0IHVz
Yl9lcF9xdWV1ZS4gV2UgbWF5IHNlbmQgZHVwbGljYXRlIHRyYW5zZmVycyByaWdodD8NCj4gDQo+
IFlvdSBjYW4gdHJ5IHRvIGNsZWFudXAgcmVxdWVzdHMgaW4gdGhlIHN0YXJ0ZWRfbGlzdCwgYnV0
IHlvdSBuZWVkIHRvIGJlDQo+IGNhcmVmdWwgdG8gbWFrZSBzdXJlIHlvdSdyZSBub3Qgb3V0IG9m
IHN5bmMgd2l0aCB0aGUgdHJhbnNmZXIgY29tcGxldGlvbg0KPiBldmVudHMgYW5kIG5ldyByZXF1
ZXN0cyBmcm9tIGdhZGdldCBkcml2ZXIuDQo+IA==

