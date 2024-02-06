Return-Path: <linux-kernel+bounces-54249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB1A84ACD0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E801F22D44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4C745F7;
	Tue,  6 Feb 2024 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="psF+K8mn";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AeBXE6Gn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fMsVU9mT"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DE745D8;
	Tue,  6 Feb 2024 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189814; cv=fail; b=W4IyJxjKtrMguFnIYpr2i64n9ht6gr83yybvQVCK+Af6445D2HBDNn5+wAY/tEEcyFYG5nXJKlpq7aJFXC93kt9Url5XcBxP9qe35bQJTxXeITxtzXZsNYYIuPZL2RD1nw7O7Rds0WwUybxpM9RvHSdbw7bhDXJUCo92oEB36eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189814; c=relaxed/simple;
	bh=eatwfPdiIQtCypYtSyCvuba5jEa6J73zgOpEIh3mDXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j48M4xdM8ltb+7ct9q3GrCgYoXLMUANLwE4j5JoPWrUoI3sQYNnaYNmDH0hA8s6D9cAsXY1A6dIGRljiLtkUOdUB4R1VgMsmN7XtSyM92+r5Jg6K4KCLAOFf/Nfi/NYASQVvzqajotEmWrGB56yU8dUk5gHKVwPJQxNKAiSNNHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=psF+K8mn; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AeBXE6Gn; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fMsVU9mT reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415KYQ5O022766;
	Mon, 5 Feb 2024 19:23:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=eatwfPdiIQtCypYtSyCvuba5jEa6J73zgOpEIh3mDXY=; b=
	psF+K8mnPN50WlSLbW7zODV4tcU4q4EfvbHxNRadUUR8YfdY4zRf7Qd9OUiAtcQf
	NoN46GfuEB0xjf7e7gzaE6NOWHRazxQve+9pg3hTLeVGjUh7fBq99S9U3QWcOaeE
	/rbaUo/XPdSAa4f3LFbueaqEevDXjwpYBn8os0eHEY6Ep/byckVbmaMsl/dWRDTS
	bLbxKngDh7KzpxC+L4Rp/oNgDUhmwAKqeENj28tbC4Ks0X0Scr/NmiI4iQxyMk6f
	8hO82A05XO5EzUzVJRp7NcgGwDDnhhyV9Y9VgygtLQdNe4FYRWoWZqXmctiRzjax
	GqhtvQR3clzF0n+VXChh0g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w1nm6sepc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 19:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1707189803; bh=eatwfPdiIQtCypYtSyCvuba5jEa6J73zgOpEIh3mDXY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AeBXE6Gnj+rKvygM3qdssrjDQc0uRctvJzVNgtLo1ysAv/lu9oxMuuf2JcdeK7YAs
	 j1zgIuDp0sroU9LZ2uj+Q0wqzx/T5AqPqQz2KhhejIZAkVnsW0Edb6+YLPPD/gqhSv
	 1np2zfTykwzWhJgwxC7P9l89KaWAYZpp+HcSuVLsLzNWnCs08DG+PuTo80UzGtyX/A
	 UobHrEwmop+U2EEZIOvziYwzskbrcr3uqd7ABQQcXOKBIJ955bm/FwJuT2PEBDRYei
	 52rZIWWtEmV5CmpdQ7tGBep7PkU2K52ZvbWUYokELKa5ftNQCqBfMWAO9qTbVSs2he
	 LSX7m81IEEzjg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5F1764064B;
	Tue,  6 Feb 2024 03:23:22 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A789CA0077;
	Tue,  6 Feb 2024 03:23:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fMsVU9mT;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id DD4F440138;
	Tue,  6 Feb 2024 03:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2yLRM0K3po2tK7ckQdZZsTyRpl32BhYYcqWsWRaEe87ME87u9/fwpy8fRHVFKzVnPjQKR00qenowb2jUZnQkctf16J8V38EnSsFHeYfMZtOGOQNe9QpiSBkhWTligTeGJyz9nb80E1vST94ky3F67F1fCxqfxtte66zEyWls5nRwJXISi33jIkY+UOaAfTlJEQGqeAPIYUhZOXQy4twkulTIrowaFNcRdP0EPHJ2zi2rDVD8o/glyHSDjsBZEX/w/VRCDlddBLIsHQueAQyyPNrbXJ7kpNh6pcnBSvX/nmQyJn6nxpbnnBe69KVcDM6Jpi7ghSoPqKszIV36F/NeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eatwfPdiIQtCypYtSyCvuba5jEa6J73zgOpEIh3mDXY=;
 b=VYT/N7wPWxN73DXAIOTKIRWEmXx1cP3p6Yk59GJ8Kxdi1nHCco45pHY94DUWPehmz3o5AMKh1mWzIjF3a2BFXuyyIvcFrXwvG3TVTiFaz1vaoSVHDcEj9ag1OVRxFBl1gtlndhElurrOlMTCfMF0JI9hcrNEiHBfhBxiY+n4KJNOzwb1VGYrjtDSvJYq/Py2+9YIoUoa9aqLev4/XZhbUVeVyJFA9gZT6ckQGE/bQhWic9lKbdonDTI6Udbvnr8oCgRhZN9H5AtdTOE1AmvkL0QKitZmMQKQAQMSTcOxDWb+XOdCpWq4vk7KicBjS1XW4Y+MONm904MXOfJeGvpADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eatwfPdiIQtCypYtSyCvuba5jEa6J73zgOpEIh3mDXY=;
 b=fMsVU9mT76a+qw0Xz44vlAUUTXXJAzdXitaLVEwm2gekfhpTrLX6WNAMCP2Ac9u09LB4YPRB4jsHdbTpUReGXQMMeH/qGRjZlW0OTPRiIsCA420uJm0Eh/H7IUC9DWv5r1QPF6Fiictpnufv10Am0v7Ti0+UvaumbU+gQ1vZ3jE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Tue, 6 Feb 2024 03:23:18 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7270.009; Tue, 6 Feb 2024
 03:23:17 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: duplicate requests on host side while streaming via uvcvideo
 gadget
Thread-Topic: duplicate requests on host side while streaming via uvcvideo
 gadget
Thread-Index: AQHaWIy4+bRzcAJsc0KCNz3P73sMPLD8pnqA
Date: Tue, 6 Feb 2024 03:23:17 +0000
Message-ID: <20240206032301.6e4tmbvmk7vs72gg@synopsys.com>
References: <ZcFx7P30Su_Mx4AV@pengutronix.de>
In-Reply-To: <ZcFx7P30Su_Mx4AV@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5820:EE_
x-ms-office365-filtering-correlation-id: e79d2249-e1a6-4cc1-8f47-08dc26c2f626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NGBQ6ioYvWtTamVTvczfB3xcRQDX7hticuvEqhe4LMU7yCQeOnf3o1EWzN9yVOWH2PvyhEDaN0p+kmUJnIr2tnC92+ELCFPwgD9BYh5dCX7krmLfGMp1bMLlUlMjPdd7X+H6DvLtP8t7PtG6J0yGgBR5hAEvr6GnJUNSO7o865bq5VSyb64i5MZjSN6Rmsr4GWvBbxTSYLmLE5TjqfpLZdLuDqP9hgwI2+nsCbg8VMyTThJoKNOBAnPHvagm9VK+yz7Xg+AbBt8k+9Vks60NdhBTmEjfEvt7HEzko0QGY4sBe3GVp1/lfpY0+PRpT3+39n/14UmT5GG9oGQMM+/3f900HGi1yZri5y6r7OosmGmwUXw25GSoxf51muX2NvWDFTGDN0VcziTmzmL7r3k8gk0W68G4CmMDByTC8zYBG89Ipj8XfwznfW8GKWdG2IVBuU9kUFa1ImUYm1N7BBnok5s7PQ1rfQ0GakGmU/VPGXgg2TM+1zhRmicNbpaMeAItWF51gTsEf94Ajlx0lZR1ucqmJ7YUn1ODJpZcQscGEo3k/jO5lwCFYQmVlEzJRFR1ba9ZeOCKp3NbLxDVNkOnXAWhi2YAhLt0Oxz2Ooi0e9zJ4Kb2zZSRyf9Drn4S0FCu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(86362001)(41300700001)(6486002)(83380400001)(38100700002)(122000001)(26005)(66476007)(8936002)(71200400001)(6512007)(6506007)(6916009)(36756003)(64756008)(66556008)(66446008)(8676002)(4326008)(5660300002)(76116006)(54906003)(316002)(38070700009)(2906002)(66946007)(1076003)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eWdFWEprS3ZZWHBvL2U4c3lLU3JvQm5aOTIxTXljeUxZcmRnQnkyTXhUaDZO?=
 =?utf-8?B?MXNTVVJXL2wvelRYcS9qZDBKQ29HdTZDeEdTZEpjd0N5Q1R1cUw5VGRNSUhL?=
 =?utf-8?B?UjV1NTRFallFYUplSDlNZE5nUjhYYlQvMjd3anhET1VQL3VZZzNGRFBNblQx?=
 =?utf-8?B?R0xHdkE2UThFczFKTk9wWFZidjZSclI2cmlzYTJCZnZrQzNkUXdTUC9ENUhL?=
 =?utf-8?B?OVpseG5lbXUyWnRuWDIzdjZ4bnFTQjcyaHdVRE56dUFHRStrdjNVRXpaVjdp?=
 =?utf-8?B?Nzd2OWl4TWRLRHljNEYrVU1VdUI3ajd0ekNGL2p2eVgyK0RHUG1zWXdkcUpq?=
 =?utf-8?B?aXZOdFhKRTJ6RU5CcnJ0dmthMUFmMTVwTjBXOG9abG1BS0Vic0VGTFZrM0hP?=
 =?utf-8?B?aDN2emRLQnFwS2xYejB6TUcxb2xDYi9EZDBIT3oycENmTkJjamhmOVZzSzVE?=
 =?utf-8?B?TDl5cEVPS01WaVdPSU0xYmpvei9JVTUxbkhZZHkxaEZ2dnE1cEM5MU8ybkY1?=
 =?utf-8?B?RzJ2ZTBTQXhlYk5zcGxyaExDU3FhcTVubGpTc1lBSW5CNnY2VEU3SkZFejQr?=
 =?utf-8?B?V3h0blorTTVGZzhCZllRVUI2cGhIdjBDMWpWaFIwOCtZMitwV3UySzVtTmFM?=
 =?utf-8?B?eGQ2ZDlwVyt0TXYwYnlEbkx3OEE3cXlwd2N4eGF2TWRGT094UHd3amg2SWVw?=
 =?utf-8?B?bHBSMFZtZ1ZkZFFRS0xHdHBwVGdYWkM4aFlFMnR5azRQQTdZT0ltbnpOM2Uw?=
 =?utf-8?B?RmlCbTZqTzJsSnFnQmFuSXl6bFhzeFJpeXo2MDhSMHpOSDhrTW0zNlU4YzZR?=
 =?utf-8?B?SzlhNTlGUFc3QXVleWdFVjNPTGtsSEZaVEFRcFo1VFBMbFJvK1hiMDgvVm5F?=
 =?utf-8?B?cEFMcVpNSHplMGdva0ZSM0N5YWdFa3hpYmF6V1poaG1ZWjkraE9VMElLQVcr?=
 =?utf-8?B?VEJMM3ErK0Q5K1ptWHg0YlQ2V3JNMi9pbVZ5N2ZBWFBBTWpjL0hjUC8xbHVy?=
 =?utf-8?B?cE5CQzFtaFZXUnl1bGsralFCTjZ5cDNCMFBCR0tZSGtkc1dFeGdGLzVxR3Qy?=
 =?utf-8?B?MjIrbFhEZGpEZjI5UXBtcFVWM1UxRVhqSnJ4RHYrbUlRY0E0dHd2VWJ3SWNB?=
 =?utf-8?B?bWJHS2pacHJ0VWZKb0diODVreWRrOE52VDFlaGdzNjBzZEVCOVNiYkczd1hX?=
 =?utf-8?B?VWxXdFlYVzNXcmZNbjRRS1I4U1JkMFJHTzYrREVLeWFsKzl4aUJZQzBsL1lM?=
 =?utf-8?B?akxHang4OFY1LytOdDdTdC8zVms0WlhPK2RKZWJJRXpxOXJ2cnZhNWxCeUlD?=
 =?utf-8?B?YnhvMGJ3YkxybW1DSmpRSlRSdjBQVGNWQkRYZVQ2NDVhNCtrbXVUck5TNzh4?=
 =?utf-8?B?cE1tQVpLS09CTEdWakJzOVl5aldPaEk0MnQ0M1AvRmQ5dXJqOGFnOUdBN243?=
 =?utf-8?B?eFlBQUtRVDdXVUhpelp2MDZCNk9EaHhiUGFwckd0ajFrTjVpcU9lNlpTalZm?=
 =?utf-8?B?aHpKcklnNmpZNEpSRE1NTGZ0U2tQeCtGQm1JUkN4TExod0k3Rm43czhwYWZs?=
 =?utf-8?B?M2ZGdFBFVENSNkhmcXhjaDhweVBONzRFcVZTVTBKTko0L2NiZ2JwbE1mVXQ5?=
 =?utf-8?B?N2U2YlpIdlNFVVVxL2JpbmFZa2pmQndVTUhlUHJSa0hDQ3NCMWZDZW9sMnJ5?=
 =?utf-8?B?T2RtSE9Yblh2eFM4TWlnSGl1RWZQeTFKbG5ESW80K25TZTJlNmdab0tGLzI3?=
 =?utf-8?B?V0JKWlZmc1V0MGhKdEdkU0Z6M2doRnBBajdUaWU1MTVMMFMwQWN3S2xTTGFC?=
 =?utf-8?B?WjM4ODA1b05pa0toY1MxN0U1S21lZmpaNkRJTHdMZW9IZjhTSW1RVHo0QkVU?=
 =?utf-8?B?eGMxWXdrL2l5ODhEbVUxSEtML2loZUNneS8zMFlZdGtXcFpRcHM3ZDI1NXlv?=
 =?utf-8?B?bW1POTBHcmRKVStKbERXT1FrYmNtRE93c3NrOVpCNjB4VlBudWJCeWJiSWpI?=
 =?utf-8?B?bW9lakRTVms4bmdwbVBGbkVLL0paUXI1bmJKSi9nNUNNTWRBZUlnZnJkODNY?=
 =?utf-8?B?K3BpUWxyMmdENEFRajdkaVlHOUFQbTkvSVMzRmorZXJuelVzU3pGZ3B4dEtl?=
 =?utf-8?B?ZnR3YUZHVmQ4dXVvL001cE1FN0pKQy91QytSeVRGeHNHQk1qcHFMNml5UWZS?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD1E6C4EC7AD6C4C9E41A3BE845C8262@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gSWoJsMSyNW1kBYh+ZZ2DfewUWLVQUGLaII6ow8Qc0uD2jP/FJ4hg/PPXrhvZ2CF+pVGhIj3BxJXCoQ29GM1AfxH0FZzvgT/UIQ2Bkx+25li6cNQP8FD+3NMmbhu4GnYUIcEhpPMnppMD8Edv0pTz9MeZ5B2MJ2/klsh9+7MJp8TU92C7gqfPZuwhKqMGKFc3aANsxxkvYCyFteoj3WJ8yIyTdc58koRZi94iSlen5gWsdQV7Os/wWnA1WKBCAL2HUtTZzXRWIt0LwZAt0qqIENpK61gz8mSUGvuoiKS0GNLUceE4p+tp41ledZ4KHP9+kW03HyIE4NA+1XW5DVclNF9il94IxRxCSD0qhvgvPIDSo4k4nFfeeKh3cV0/hw7N5vYeGGo/gBPw4uNbdd94ioLn0+fS7ckXGTuH1I+1KVvahaDR7+t654Wqu8k2UDIFVUqI6jXutS/Zi8t3CbU0PAX3wcM8BHrlXph2Wf4WIFws0f7CXvGmNt9NKpk3TjIeTnHWhwYEznqcjsHjWu7Wdc36U6fIs6E/DlQ3MTKCw0W3WK9DARvwglXWpkp6jgZYaCRY6NnX5wDmuKF5tHI9ivyMoOuo4fBrOXk1C+yaRUSPey8B2eOIzKBA4hYi3dCW2kz+5Ee32kJztOG55ChKg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79d2249-e1a6-4cc1-8f47-08dc26c2f626
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 03:23:17.4766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+Lm/r7lCwJWzdKJrRAfqkakP0VW6FwHOzjp03HydB9+kc7mkvQkko+nlE3S10wbuQoW4RI61mBKQoj8ndgGew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
X-Proofpoint-ORIG-GUID: OnVaTCC_X7x6pAxUawlJYWHrc8EH1M1v
X-Proofpoint-GUID: OnVaTCC_X7x6pAxUawlJYWHrc8EH1M1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=662 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402060022

T24gVHVlLCBGZWIgMDYsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBIaSBUaGlu
aA0KPiANCj4gSSBmb3VuZCBzb21lIHN0cmFuZ2Ugc2l0dWF0aW9uIHdoaWxlIHN0cmVhbWluZyB2
aWEgdXZjLWdhZGdldCB0byBzb21lDQo+IHVzYiBob3N0LiBJdCBoYXBwZW5zIHdoZW4gc29tZSBy
ZXF1ZXN0cyBhcmUgbWlzc2VkIGR1ZSB0byBoaWdoZXIgbG9hZCBvbg0KPiB0aGUgZ2FkZ2V0IG1h
Y2hpbmUuIEluIHNvbWUgY2FzZXMgc29tZSByZXF1ZXN0cyB3aWxsIHJlYWNoIHRoZSBob3N0DQo+
IHR3aWNlLiBJbiBteSBzcGVjaWFsIGNhc2UsIEkgYWRkZWQgdGhlIGZvbGxvd2luZyBjaGFuZ2Vz
IFsxXSBmb3IgdGhlDQo+IGhvc3QgYW5kIGdhZGdldCBzaWRlLg0KDQpEb2VzIHRoaXMgb25seSBo
YXBwZW4gdG8gc29tZSBzcGVjaWZpYyBob3N0cz8NCg0KQXJlIGFsbCB0aGUgZGF0YSBvZiB0aGUg
ZHVwbGljYXRlIHJlcXVlc3RzIG1hdGNoaW5nIG9yIGp1c3Qgc29tZSBiaXRzIG9mDQp0aGUgdHJh
bnNmZXI/IFdlcmUgeW91IGFibGUgdG8gY29uZmlybSBmcm9tIHNvbWUgdXNiIGFuYWx5emVyL3Nu
aWZmZXINCnRoYXQgdGhlIGRhdGEgb3V0IHRoZSB3aXJlIGlzIGFjdHVhbGx5IGR1cGxpY2F0ZT8N
Cg0KPiANCj4gV2hlbiBhcHBseWluZyB0aGUgcGF0Y2hlcyB5b3Ugd2lsbCBmaW5kIGFsbCByZXF1
ZXN0cyBtYXJrZWQgYXMgZXJyb3JzIG9uDQo+IHRoZSBob3N0IGFuZCBnYWRnZXQgc2lkZSByZXBv
cnRlZC4gSG93ZXZlciwgdGhlIG9kZCB0aGluZyBpcyB0aGF0IHRoZQ0KPiBlcnJvciBjb3VudGVy
IG9uIHRoZSBob3N0IHNpZGUgd2lsbCByaXNlIGhpZ2hlciB0aGFuIHRoZSBudW1iZXIgb2YNCj4g
cmVxdWVzdHMgd2UgaGF2ZSBhY3R1YWxseSBtYXJrZWQgYXMgZXJyb3Jub3VzIG9uIHRoZSBnYWRn
ZXQgc2lkZS4gWW91DQo+IGNoZWNrIHRoZSBudW1iZXIgb2YgZXJyb3JzIGZvdW5kIG9uIHRoZSBo
b3N0IGJ5IGxvb2tpbmcgaW4gdGhlDQo+IHN0YXRpc3RpY3MgYW5kIGNvbXBhcmUgaXQgd2l0aCB0
aGUgbnVtZXIgb2YgcmVxdWVzdHMgdGhhdCBhcmUgYWN0dWFsbHkNCj4gbWFya2VkIHdpdGggVVZD
X1NUUkVBTV9FUlIuDQo+IA0KDQpbc25pcF0NCg0KPiANCj4gLS0gSG9zdDoNCj4gDQo+IFsgMTc2
OS4yMTMzODddIGVycm9yIG9uIHV2YyBwYWNrYWdlIQ0KPiBbIDE3NjkuMjEzMzk2XSBQVFM6IDE2
DQo+IFsgMTc2OS4yMTM0MDBdIFNDUjogNjQNCj4gWyAxNzY5LjIxMzQwMl0gU0NSOiAyMjkNCj4g
DQo+IFsgMTc2OS40NjEzODZdIGVycm9yIG9uIHV2YyBwYWNrYWdlIQ0KPiBbIDE3NjkuNDYxMzk0
XSBQVFM6IDk2DQo+IFsgMTc2OS40NjEzOThdIFNDUjogODANCj4gWyAxNzY5LjQ2MTQwMV0gU0NS
OiAzMw0KPiANCj4gWyAxNzY5LjQ2MTQwNV0gZXJyb3Igb24gdXZjIHBhY2thZ2UhIDwtIGR1cGxp
Y2F0ZQ0KPiBbIDE3NjkuNDYxNDA4XSBQVFM6IDk2DQo+IFsgMTc2OS40NjE0MTBdIFNDUjogODAN
Cj4gWyAxNzY5LjQ2MTQxM10gU0NSOiAzMw0KPiANCj4gWyAxNzY5LjY1NzQwNV0gZXJyb3Igb24g
dXZjIHBhY2thZ2UhDQo+IFsgMTc2OS42NTc0NDJdIFBUUzogMjI0DQo+IFsgMTc2OS42NTc0NDld
IFNDUjogNjQNCj4gWyAxNzY5LjY1NzQ1M10gU0NSOiA4MQ0KPiANCj4gWyAxNzY5LjY1NzQ2MF0g
ZXJyb3Igb24gdXZjIHBhY2thZ2UhIDwtIGR1cGxpY2F0ZQ0KPiBbIDE3NjkuNjU3NDY1XSBQVFM6
IDIyNA0KPiBbIDE3NjkuNjU3NDcwXSBTQ1I6IDY0DQo+IFsgMTc2OS42NTc0NzZdIFNDUjogODEN
Cj4gDQo+IFsgMTc3OS41MjUzNjhdIGVycm9yIG9uIHV2YyBwYWNrYWdlIQ0KPiBbIDE3NzkuNTI1
Mzc0XSBQVFM6IDEyOA0KPiBbIDE3NzkuNTI1Mzc4XSBTQ1I6IDIyNA0KPiBbIDE3NzkuNTI1Mzgw
XSBTQ1I6IDE1Nw0KPiANCj4gWyAxNzg0LjYzNzM1OV0gZXJyb3Igb24gdXZjIHBhY2thZ2UhDQo+
IFsgMTc4NC42MzczNjddIFBUUzogMA0KPiBbIDE3ODQuNjM3MzcxXSBTQ1I6IDIwOA0KPiBbIDE3
ODQuNjM3Mzc0XSBTQ1I6IDg5DQo+IA0KPiBbIDE3ODQuODI1MzU3XSBlcnJvciBvbiB1dmMgcGFj
a2FnZSENCj4gWyAxNzg0LjgyNTM5NF0gUFRTOiAyMjQNCj4gWyAxNzg0LjgyNTQwMV0gU0NSOiAx
OTINCj4gWyAxNzg0LjgyNTQwNl0gU0NSOiA2Mw0KPiANCj4gWyAxNzg0Ljg0MTM2Ml0gZXJyb3Ig
b24gdXZjIHBhY2thZ2UhDQo+IFsgMTc4NC44NDEzOTRdIFBUUzogMTQ0DQo+IFsgMTc4NC44NDE0
MDNdIFNDUjogNDgNCj4gWyAxNzg0Ljg0MTQxMF0gU0NSOiAxODYNCj4gDQo+IFsgMTc4NC44NDE0
MThdIGVycm9yIG9uIHV2YyBwYWNrYWdlISA8LSBkdXBsaWNhdGUNCj4gWyAxNzg0Ljg0MTQyNF0g
UFRTOiAxNDQNCj4gWyAxNzg0Ljg0MTQzMF0gU0NSOiA0OA0KPiBbIDE3ODQuODQxNDM2XSBTQ1I6
IDE4Ng0KPiANCj4gaG9zdCQgZ3JlcCBlcnJvcnMgL3N5cy9rZXJuZWwvZGVidWcvdXNiL3V2Y3Zp
ZGVvLyovc3RhdHMNCj4gL3N5cy9rZXJuZWwvZGVidWcvdXNiL3V2Y3ZpZGVvLzQtODEtMS9zdGF0
czplcnJvcnM6ICAxMA0KPiANCj4gDQo+IC0tIEdhZGdldDoNCj4gDQo+IFvCoCAxMjYuODI2NTE3
XSBkcm9wcGluZyBmcmFtZSEgMQ0KPiBbwqAgMTI2LjgyOTY1OF0gUFRTOiAxNg0KPiBbwqAgMTI2
LjgzMTc2MV0gU0NSOiA2NA0KPiBbwqAgMTI2LjgzMzg1OF0gU0NSOiAyMjkNCj4gDQo+IFvCoCAx
MjcuMDkwMDY5XSBkcm9wcGluZyBmcmFtZSEgMg0KPiBbwqAgMTI3LjA5MzA1OV0gUFRTOiA5Ng0K
PiBbwqAgMTI3LjA5NTE2NF0gU0NSOiA4MA0KPiBbwqAgMTI3LjA5NzI2MV0gU0NSOiAzMw0KPiAN
Cj4gW8KgIDEyNy4yODgwNDVdIGRyb3BwaW5nIGZyYW1lISAzDQo+IFvCoCAxMjcuMjkxMDQxXSBQ
VFM6IDIyNA0KPiBbwqAgMTI3LjI5MzIzM10gU0NSOiA2NA0KPiBbwqAgMTI3LjI5NTMzMF0gU0NS
OiA4MQ0KPiANCj4gW8KgIDEzNy4xNTM0OTldIGRyb3BwaW5nIGZyYW1lISA0DQo+IFvCoCAxMzcu
MTU2NDk0XSBQVFM6IDEyOA0KPiBbwqAgMTM3LjE1ODY4N10gU0NSOiAyMjQNCj4gW8KgIDEzNy4x
NjA4NzFdIFNDUjogMTU3DQo+IA0KPiBbwqAgMTQyLjI2NTEzNV0gZHJvcHBpbmcgZnJhbWUhIDUN
Cj4gW8KgIDE0Mi4yNjgxMzFdIFBUUzogMA0KPiBbwqAgMTQyLjI3MDE0OF0gU0NSOiAyMDgNCj4g
W8KgIDE0Mi4yNzIzMzJdIFNDUjogODkNCj4gDQo+IFvCoCAxNDIuNDUzNjM2XSBkcm9wcGluZyBm
cmFtZSEgNg0KPiBbwqAgMTQyLjQ1NjYzNF0gUFRTOiAyMjQNCj4gW8KgIDE0Mi40NTg4MjVdIFND
UjogMTkyDQo+IFvCoCAxNDIuNDYxMDA5XSBTQ1I6IDYzDQo+IA0KPiBbwqAgMTQyLjQ2OTEzMV0g
ZHJvcHBpbmcgZnJhbWUhIDcNCj4gW8KgIDE0Mi40NzIxMThdIFBUUzogMTQ0DQo+IFvCoCAxNDIu
NDc0MzEwXSBTQ1I6IDQ4DQo+IFvCoCAxNDIuNDc2NDA3XSBTQ1I6IDE4Ng0KPiANCj4gTm93IEkg
YW0gdG90YWxseSB1bnN1cmUgd2hhdCBjb3VsZCBjYXVzZSBzdWNoIGVycm9yLCBidXQgd291bGQg
ZXhwZWN0DQo+IHRoZSBpc3N1ZSB0byBiZSBzb21ld2hlcmUgaW4gdGhlIGdhZGdldCBkcml2ZXIg
YW5kIHRoZSBtYXBwZWQgdHJiIG1lbW9yeQ0KPiBjb250ZW50LiBGb3IgdGhlIHV2Y192aWRlbyBs
YXllciwgSSBjb21wYXJlZCBhbmQgdGVzdGVkIHRoZSBlbnF1ZXVlZA0KPiByZXF1ZXN0IGxpc3Qg
Zm9yIGR1cGxpY2F0ZXMgYnV0IGNvdWxkIG5vdCBmaW5kIGFueS4gSSBhbHNvIHJldmVydGVkIGFs
bA0KPiByZWNlbnQgcGF0Y2hlcyB0aGF0IGNoYW5nZWQgcmVxdWVzdCBoYW5kbGluZyBpbiB0aGUg
cGFzdCB5ZWFyLiBJIHN0aWxsDQo+IGZpbmQgdGhlc2UgcmVxdWVzdCBkdXBsaWNhdGVzIG9uIHRo
ZSBob3N0IHNpZGUgc2hvdyB1cC4NCj4gDQo+IEFueSBJZGVhcz8NCj4gDQoNCkknbSBub3QgZmFt
aWxpYXIgd2l0aCBVVkMsIGNhbiB5b3UgZ2l2ZSBtb3JlIGNvbnRleHQgb24geW91ciB2YWxpZGF0
aW9uDQphbmQgZXJyb3IgY291bnQ/IFdoYXQncyBQVFMvU0NSPyBJcyB0aGUgZGV2aWNlIHNlbmRp
bmcgc29tZSBlcnJvciBzdGF0dXMNCmJhY2sgYXMgbmV3IHJlcXVlc3Qgd2hlbmV2ZXIgdGhlcmUn
cyAtRVhERVY/DQoNClRoYW5rcywNClRoaW5o

