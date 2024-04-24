Return-Path: <linux-kernel+bounces-156084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1278AFDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3181F23A41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209AFC0C;
	Wed, 24 Apr 2024 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j9tx9chX";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XTiXk61B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IaJGX8tl"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35534C6D;
	Wed, 24 Apr 2024 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921532; cv=fail; b=Ef1WIKaYcSeezwA9IQoq8cRoz4xAdrFvK6hwU2q7L6C6uvl/0/4NbVE4MPzaSkIWXj9Wn/W1EjnWWp2jo4KZN5y7CDZeFRO9X36U5ZiEfFCfduAReHuC4EfKze8666yxq7AwKBq+Bsa5VIjgnpj8EUc4/qYmWAKekXqmPzTrJhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921532; c=relaxed/simple;
	bh=XtXPZYQt88PqC8Np/N44jKgfxBGyIAlB7JRa6BVMNPs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4gHSG8ljgf/vsrU/p0LBYY1DRLfTT7xeVjw4//JcXPG4gSH13gSy/bJBF7wWQhD+j0Ww1QFyoJfCkmFjHrraGy3pFq5tDt35YtvfgQTP9A6h4iQNG5SWFo5lCXeGaGBJXeHdYRrSDXhb6Ww+qXlw9HI0olFoUguuMOoGKoAoVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=j9tx9chX; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XTiXk61B; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IaJGX8tl reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0xL6d015991;
	Tue, 23 Apr 2024 18:18:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=XtXPZYQt88PqC8Np/N44jKgfxBGyIAlB7JRa6BVMNPs=; b=
	j9tx9chX299c/n0Utr32gqmcPlB1b5LeaCkyiNHQYFxKKQd1XaNwsGaxJmut8K0C
	ehA5nnIID/t2sLVoeM6TUMTmdlZJ06HO0aPDF4RknsaLmcYPuTMs/mNm4Cc8vWus
	/O4zHsg+Mb+ZXePYMr3VQKO96+NnPwXXjata+PUFdITUkGWULZZo4jf4l3mQgiK+
	C/6Zv9rglinOUbazLUtNumyR3wu0tvfVRgSTd5ZfS8aoxd9QzehTcA0b9H9jZBuR
	bkYl3Na+GB6TaQZOVrYXdY6S4opf3ZnzeYRca12Cxol2579mb46kDu0aI2dFmeEi
	SRRwkOW9jDBwheB0VrcVWw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6xae7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713921523; bh=XtXPZYQt88PqC8Np/N44jKgfxBGyIAlB7JRa6BVMNPs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=XTiXk61B4qh10iQBvCWdR/hx91cqLK7b3bGcl5ZoOAJoQC4w8jt9BzDsE3vb/RzZE
	 lBytXiay+EWexWvI2te762KTLOgpuZO5O8uYW4QELdl64QCCvf1okxw5yl8QWaNxU+
	 odlI9t9QpsQ5Pg2iOuTbW8GZlg5YbVGk+gTqN5xmvrEMyx9DGwW9skVfV6TfeLPrMh
	 ZCbQzQRIgjtfi/VW32lhgCcF597TvMSFwUzkIEFY1rgqczWyUGKijyKCdEerEWL1gr
	 lniA8WFBGs3pNJ7+Cas0ww7OJrKPfnwR8Vmv7OgwZ+n4SeR0nMkyYCb0nIFe8I6/am
	 RTIrfDysATyZA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9E9D040352;
	Wed, 24 Apr 2024 01:18:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 40579A005E;
	Wed, 24 Apr 2024 01:18:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IaJGX8tl;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id CF65A400A2;
	Wed, 24 Apr 2024 01:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyVUQ9wNNJSO01hlmGyxzFfgay54+9u6zR3QDW9bDqY0tgmE+f+TAHNUf5TnM2RJLyx8sHs9e8OwBPchTIDxC14CiHA1Uy7S0g2144XbmSC3P2qJ+Rqapr9CnsTq2ss+kGiQIzfUUm0NoFPxNVXGdXLTuatYsuV0RmNASpVlC9gc5oy0XfBOfnfQAahbBL6V4J7UQ87KEXdSaVoBbkrh8IW6682VAaPL0PuDcXgMuMYgFY+F2WA4tdMZhAxyGBQclTUYJKXEuw7f2QHifgMz01+T5fonGwTpiIAUCC4breA4911vxnB90Eg5FZRgdPui3felHxvhbfBXt19xCPMXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtXPZYQt88PqC8Np/N44jKgfxBGyIAlB7JRa6BVMNPs=;
 b=iUGcQTFpRjDr5g4QLxv8zvQdovNUDP6cYs7nZqZPX42IJY64S1SXl2sR6pH68HAUWgcXBeT9wrnXL+k0+UXIqEY+xeLFxenldmd/d2dsKXrcwSbpdNwYOMBLrI4cyTFhOaXiagE5qUdCuuQ0I1mU2ucu3EMxp7b02aJqNdH5gCY5DwG5+90aYeeXPMDU0NJ10EugvQTbhNE6isqiU0q65Yji0O9+/ESGKI6JS9kVFTXcq/Y5bXZVednm1Wci8TufZjFYKZnanv6p8KGaiaeMjzp4kWkCQrUNhhyTx4axjHVcXZ+Xrv37Fi2AtrckAFBXcL+Im/JM4FNxbnRC0e4UtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtXPZYQt88PqC8Np/N44jKgfxBGyIAlB7JRa6BVMNPs=;
 b=IaJGX8tlkPsyEzKrztzBeVRGkfgG6yl8QPXTgHJIUcXydsowkM5tlqRpwrUH7BagNZllSKMIJw5T4a5XP77M2WtImf0SGH86jrT2nPAKTGeU5l5IZ5Yv4Y82zVldVYGtvBCHYaxdAEKc8IF3ZXJRvMiX5MD9P+LjWnyLWaPzpAE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:18:38 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:18:38 +0000
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
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v21 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Thread-Topic: [PATCH v21 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Thread-Index: AQHakt5DiN/NFwpUH0We2RT72PCjJrF2pOuA
Date: Wed, 24 Apr 2024 01:18:38 +0000
Message-ID: <20240424011835.mcbt4o5rlqh4n6zo@synopsys.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-10-quic_kriskura@quicinc.com>
In-Reply-To: <20240420044901.884098-10-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7682:EE_
x-ms-office365-filtering-correlation-id: abda0d68-19f9-46b2-d58f-08dc63fc78a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OHo3cUdJVmIvZTQrakFRT01lTWx1bkxGSXlzVVVwcDYyeDUrbmJSbUovdU5u?=
 =?utf-8?B?QjdKcHFZUWw3WUhzQVIyNENGNitnWmQzN1ZFNmxUeUU0MUJONFhsYkpkU0dB?=
 =?utf-8?B?clVTTXRRa3pJWnZTb0g0bERVS1QzMXEyTStlY25pSW01VGN5MWo2L0pyNUxS?=
 =?utf-8?B?a3hGUG04L3huaUlKMFQxMy93V1g0TDArekZ1OFdYN2tUNUtkaUpOd1p4ZGFZ?=
 =?utf-8?B?aWM4VWVVZ3hUZ0NsRU5nWjRPTzJ5QmUxU1ozL3JkTk9KOVZwWHpVU082NC9Y?=
 =?utf-8?B?K001Y0RHRHIxZm9sZWZNWjVzZEhtaWkvSjRtQlo1UFhuZGdlRnp3UzM2WEND?=
 =?utf-8?B?SDhKSFo4NVBRalpIcWZTYmpiSEpuZ2lLaUZXQlM2L1lMemp6REVWY3ZwVUR3?=
 =?utf-8?B?dE50elU4TGxEWTNFaENET25PdDlaUGpZc2xMa0hnMTJPcVFXWi9iV3h1MXBZ?=
 =?utf-8?B?M25mMDBWeXBiVWJtRzhTU25yRXczWkovZWJndFl1a05Xa1gvYUJ6U1E4anFE?=
 =?utf-8?B?Uk91L0pYS29zbWRnWkFVOU5yRUR4QmNmLytGVG9wU2p6OHdQa3ZLUXFqbFJy?=
 =?utf-8?B?UGRpLzN1Z08wVjQ2ZVEyS3ltaDZ0WnAwVEdmR0xZT3prcXljVmZQWTlHbWVv?=
 =?utf-8?B?d0xSeDh3WEliMFZlazdXTUxFYndscWU3NXNCMHdNU2taWjNxMkRrRXNWdmJv?=
 =?utf-8?B?NitSODhySW04NWo5WHpRODFqY2Y1ZlZHU2VVUHFXNGVkVGs2S1dOOVpKalpQ?=
 =?utf-8?B?OERqeDg0WCtxeHVjd3ZsWUYydW1oTXNHTTFhNnQxb05kZ2VZL1RWdmlad0hn?=
 =?utf-8?B?K1djdlRaTmZTcmtBZFNZcnVFQVNSaHNuWGJ0U1g2UlFCTm05OHBiUjExY0lL?=
 =?utf-8?B?SmVkVURrNzUyWFRubmhGd3NBaDJYWkVlVUFXSGJaV1pkeWQraytGb3RKQjha?=
 =?utf-8?B?dWpucy9JTmhrNXJuQUZPWkpwOG5OV09VYzhDY2VtVG1vbGlrQWw3S3ZsaDA5?=
 =?utf-8?B?anhKZFRVaU00NnR0OVlrNGJaSm9ZS0I5LytzaVFhdlAxSVJSbSttT3FvSjl3?=
 =?utf-8?B?VDhGbDd4VUN1Rjcxb0FKazd6dUozZFBzWkh0TTRNUlZZMExMMWpieDhYSTNt?=
 =?utf-8?B?aEpIK1V6dGhzVklLTC8ycW1mSG10aGRDZ2NHV01iMm9YZTB5ZnErWFhMN0cz?=
 =?utf-8?B?QXRzSXpZYnJneUFWTTNEYkNiR3BuNThUSXpVcitwYnVvbmhyZjlSZVNTUFM4?=
 =?utf-8?B?QzRRMDR5STlWQmJxa3FLazMwTExlTzRpaFJiNzFuRXU0eHNBQ1BoSndaTU1k?=
 =?utf-8?B?c3ZIWkE1b1JWdTJnbmRDUVNoWmQybGV4MzA3L2RLUWV5SVJTb1lIdzRQVkFk?=
 =?utf-8?B?aHd2aUNwNnU3eGxRTDNqNlJkSDVRZWpkejNVTy9hWTdENlBUczJPY3FWUGF4?=
 =?utf-8?B?amhreDZMcWRzRHJjMGNDTTdzREgzaHlZenp5MVplUFZwSENsT2ovaThISW5a?=
 =?utf-8?B?ODJvRFFMRFl2cytNbzNDRStaQWtETTMrMTBsQjZGeUFGZTFJMHpTWDFLU2lX?=
 =?utf-8?B?UVlvU1VrNTNUeXh6eGFsMEUwK2xjYnlPcUdGTEd5RDNFTHZ0VmdTT3crVDlK?=
 =?utf-8?B?M3BuZk5IM3RjVmRLSDJ0SWU0Wk45am1DNXlCQmtjZnFMUVdEWEtWYTZydW03?=
 =?utf-8?B?SzBoai9keVlJN1Z6TEgrZkxJWmdwVDN2c0MzVGlRS3FUNFhnMk82SmE3cGVh?=
 =?utf-8?B?Z2RBVzQzQ0oyWFVIMTNwNzFVWCt6NnZhWCt1Ry96ejNNTC9ZRDltSFF6eWp3?=
 =?utf-8?B?bkJCdWVuR09VU0puYmRIUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z1BUOFFHWi9RMi9VakxudUNtYXdmSS9IemtxSGZaVEZ6NUgvaXZXMEMrQk90?=
 =?utf-8?B?TGhUd1hNOWFxVE9aWWZBN0ZURFMvUTFJczdTRzVISU5qYitvMk1MQ2kvdUg1?=
 =?utf-8?B?UVNqc1pRWEdHU1piYnVscXQrOG4vdUhhNW5wdnZzNkgwTEZrYjJiK1E1YU16?=
 =?utf-8?B?SllxS09sQ0R4SERXZXV3RXRIYzgrL1BvMVlDNjA5endtZmprSUp1YmxVQVRX?=
 =?utf-8?B?SXZXMjVIcWFmUm1PMXRDdy9QUkRFaytucUkxaHl3YWRNZHNIRG4wNm1GNFVx?=
 =?utf-8?B?ejNCZnFVNGFxRjBEM0lTOTVxWXdlcnoyajhndldOVHBhMlZTTjNoSTE0OERK?=
 =?utf-8?B?TnJYTmV2ODBTbU5RWEkzTm80Y3N5TjNOcTV1YTdaSXRPdHBRYllkVGRnWEN6?=
 =?utf-8?B?UTRoNGpMa3JtQ0s5OWRSeCtkMk5ldjNwMFRKcUpaVEg5VWxWL25KZkIrOWlZ?=
 =?utf-8?B?OXFzcFcvUVErMlJvQXRndksxNnJCd3R6WktXSXh0QkRRc01hbHBZYmFSLzFl?=
 =?utf-8?B?bVQxNU5WYlk2V3JpVmtZMWY2YzV0Z3BVU25RUi9JZDFadHNMOWcwd3pJMUZB?=
 =?utf-8?B?WlNESHV2K1h2bWJmclRQMWpVOFQxR0I1SVVHYklsVjRWQlVScXRCcWprTjFL?=
 =?utf-8?B?TFRTbmJuaVNLa0J4WURraUVjWEtvWjA2TlJEcm8rczA5OWtPemVTb3hNanpF?=
 =?utf-8?B?dmNwNWh3c3VTZGJadjUwdnJSMXJ2WUdVa0RXZW1xbVhQSDZoODlpUFNBVWVy?=
 =?utf-8?B?Y3doQXFRcENUQ0FBald5bXNFUjhPVkdEREFTOXc5UDVKV3dKUVRPSnNaL3pG?=
 =?utf-8?B?cHQ0d1A2WWZ5ZmlBSGdOb3lINmdDZ1YyYk1aaEZHQWthZ0MwZnpzMTBLbGo3?=
 =?utf-8?B?Y1pZdDBlQWlXR3dNOUtoY3c5WmVNR1BneXY0SFhidjJ4YUVZZjBkTzlqdFRl?=
 =?utf-8?B?SCtnTmZaRGd0S2lTTDEvYkdNV3BaVEtscjBBU3pCU3AzNGNBNUJQZEtLalF6?=
 =?utf-8?B?YmZwVkZtWDZCYlo4S2p2QUFNRWhyVDRyMkNkdXFkeGRMaE5WVXQvTkhIWFUx?=
 =?utf-8?B?ZFlScEtZVnhmam9jMVRBVG41ODlOTXBXaWZaeE5ncGd2MkpPaHFhZi9QSWFB?=
 =?utf-8?B?NGM1djlRaE1yZm5ob1d6WEVicEdscXVaZG81YjFkWTNwYUJRdUh5QklkV3Ix?=
 =?utf-8?B?WmtQZ1Y5bXhZaWpjRS9aUE9XSEU0UDM2M3c1SzllOWRFUDVLRHp3WDNDL2tr?=
 =?utf-8?B?a2ZZK3VES21rK1NtR1ZCNlI4NDVBNW1VRThaUHRkVXBjQmpUTFJRSGttSUZJ?=
 =?utf-8?B?R2VhVmhWalVNVlhGYUVQL3lLS1hvL3RVYnNMKzZvL2dDWWs2MUR0cld3N2Jj?=
 =?utf-8?B?YTcwVFpESWJ0SzRvMjJqNVBrWXRyOGllNXJ1THY1cE1LeitHWUFQSXpkaUlN?=
 =?utf-8?B?eE9OK2crclJ3RmFGYnpUVStkcmlNWEQxSDRZWnJWdjFkTGxSYzRKdUhneW9J?=
 =?utf-8?B?LytxMGZKQVZwbWNRZzJnbk9DMTRyVGVMVWJWSGVvamtrMkhuVnQ4YnBNYmMx?=
 =?utf-8?B?QzZuZUZqOHJPQlBrRytPYkVqbEJEcVVUZ0VHZDUydldUenI2a3psL09sRGZ1?=
 =?utf-8?B?WjVuRlpzanF2NEROTUVSb0sxUktOdHdrelBVR1gxZmphQ3J5M3BFbGkxVXZu?=
 =?utf-8?B?NzkxR0s2OUJmcFNVRys3bUVZcFdUZmZHemthUlRPeTRaMWpiMHFOLyt2cUxr?=
 =?utf-8?B?eGJhQmEycG1yQTF1WlNIWTNLMUs4cDl6SGRMVFlZTDJaMHRRMTBZUUJ6QTQ5?=
 =?utf-8?B?YXZWcWRPVjBFTWI3VENTWkdmT3RWVlppUXlPb3VJT0xJY3JVS0s2dXpPQkdS?=
 =?utf-8?B?TWl1YndKYlZwN1g2ZkVESm03OTQrYzYybHgvaFVxN3dwSEUvZjF5b2h3Q29Y?=
 =?utf-8?B?bFp1bWEvZk5aT1JKSXQyM2pBQ2R6SWVSOUFqZ1J4MkFOSk9hUjl4Z3dKZndX?=
 =?utf-8?B?d1BGbW9CRHAvZVhXcmRnKyswYkZ4V3JvbFhzSXRSaVNLczI5aUl6YnJUWjdW?=
 =?utf-8?B?TC9DSTM3dmI0OE9jVUdGSGxOSWptV0lSM0dUNnZxWEtqdEMwcVpaSVlRT3hQ?=
 =?utf-8?Q?GE1Or0mheruWWSWHGEVIdk1fe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7DF7EE9F56DC5448BD938F584B85EA1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/wQT9guuSWXgOIJFl+CPWwOEwhTnphthKGICSioqwTdNG0k+40hcB0ts7FgBEViupWlpBnLyOHznq/1xQUc9GCM8oyRXpzNSs5w73kvvCoJ54p5lzAzXdJMDs54yjDaokBQMonCS61lpF373bJoBPuGFvo7RyZ01er6Lr+d/HS/gqhrBkpLSLrVU3p03yi06Cp0DpUBinwdfwvvRj5gIPapTI8eY0SaH9vlLYhAjojsaTNdDdkMNrRA6vdiLE+AN9cboKOshnDrcwTXISzQByACRR4poFrwrn2gwqNvYJ9TJ5k2zjS8MDCO2mWYI7X+BgRv5UKkDtseV9xB4FLE2EBdXomtRbw/d7rpQvMuWC0PcamerLLV9JKbT1IgsAgrMVhHkdG9accooDIjamkgB0OnVWNs2sYtKz199dHgyRV8nuROgCgUPiohFDoBYBzyPRa1Mg8X8aR3PFHTkc/7eDUGIkChKIrO0mzVI046eKNTowFKoHkoeqz2DhF8wTiBGyGWaTIgxT4xsZKBGKXp8zPz+QKuLC2dcFSJ0db27s9vKCWqfdADV4vFlzNgPXtz4/5bdsSoflhOTZmMrRVOiy3uTTJ3YUn/+tanqPybW4Wkv52VB+XR22mP08kl6x+u5cRofUO/M42z5qgzc3fsrdg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abda0d68-19f9-46b2-d58f-08dc63fc78a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 01:18:38.5967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RTl8/K7NeJcOoXg2gS9LCY9vCAN9GC6mrn5jsHJgf1K0ssHN+/721c3ENjis4BAON8P7ezYWhI3WW+K8KDwKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Proofpoint-GUID: vbitGyUmNhSSzEMYeSyDzVt6zt2qhHaP
X-Proofpoint-ORIG-GUID: vbitGyUmNhSSzEMYeSyDzVt6zt2qhHaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240005

T24gU2F0LCBBcHIgMjAsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IFBvd2VyIGV2
ZW50IElSUSBpcyB1c2VkIGZvciB3YWtldXAgZWl0aGVyIHdoZW4gdGhlIGNvbnRyb2xsZXIgaXMN
Cj4gU3VwZXJTcGVlZCBjYXBhYmxlIGJ1dCBpcyBtaXNzaW5nIGFuIFN1cGVyU3BlZWQgUEhZIGlu
dGVycnVwdCwgb3Igd2hlbg0KPiB0aGUgR0lDIGlzIG5vdCBjYXBhYmxlIG9mIGRldGVjdGluZyBE
UC9ETSBIaWdoLVNwZWVkIFBIWSBpbnRlcnJ1cHRzLg0KPiANCj4gVGhlIFBvd2VyIGV2ZW50IElS
USBzdGF0IHJlZ2lzdGVyIGluZGljYXRlcyB3aGV0aGVyIHRoZSBIaWdoLVNwZWVkDQo+IHBoeSBl
bnRlcmVkIGFuZCBleGl0ZWQgTDIgc3VjY2Vzc2Z1bGx5IGR1cmluZyBzdXNwZW5kIGFuZCByZXN1
bWUuDQo+IEluZGljYXRlIHRoZSBzYW1lIGZvciBhbGwgcG9ydHMgb2YgYSBtdWx0aXBvcnQgY29u
dHJvbGxlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jp
c2t1cmFAcXVpY2luYy5jb20+DQo+IFJldmlld2VkLWJ5OiBCam9ybiBBbmRlcnNzb24gPHF1aWNf
YmpvcmFuZGVAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXFj
b20uYyB8IDIzICsrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2R3YzMtcWNvbS5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiBp
bmRleCBiNmYxM2JiMTRlMmMuLjg4ZmI2NzA2YTE4ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91
c2IvZHdjMy9kd2MzLXFjb20uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5j
DQo+IEBAIC0zNiw3ICszNiw2IEBADQo+ICAjZGVmaW5lIFBJUEUzX1BIWVNUQVRVU19TVwkJCUJJ
VCgzKQ0KPiAgI2RlZmluZSBQSVBFX1VUTUlfQ0xLX0RJUwkJCUJJVCg4KQ0KPiAgDQo+IC0jZGVm
aW5lIFBXUl9FVk5UX0lSUV9TVEFUX1JFRwkJCTB4NTgNCj4gICNkZWZpbmUgUFdSX0VWTlRfTFBN
X0lOX0wyX01BU0sJCQlCSVQoNCkNCj4gICNkZWZpbmUgUFdSX0VWTlRfTFBNX09VVF9MMl9NQVNL
CQlCSVQoNSkNCj4gIA0KPiBAQCAtNTUsNiArNTQsMTMgQEANCj4gIC8qIFF1YWxjb21tIFNvQ3Mg
d2l0aCBtdWx0aXBvcnQgc3VwcG9ydCBoYXMgdXAgdG8gNCBwb3J0cyAqLw0KPiAgI2RlZmluZSBE
V0MzX1FDT01fTUFYX1BPUlRTCTQNCj4gIA0KPiArc3RhdGljIGNvbnN0IHUzMiBwd3JfZXZudF9p
cnFfc3RhdF9yZWdbRFdDM19RQ09NX01BWF9QT1JUU10gPSB7DQo+ICsJMHg1OCwNCj4gKwkweDFk
YywNCj4gKwkweDIyOCwNCj4gKwkweDIzOCwNCj4gK307DQo+ICsNCj4gIHN0cnVjdCBkd2MzX3Fj
b21fcG9ydCB7DQo+ICAJaW50CQkJcXVzYjJfcGh5X2lycTsNCj4gIAlpbnQJCQlkcF9oc19waHlf
aXJxOw0KPiBAQCAtNDI0LDkgKzQzMCwxMSBAQCBzdGF0aWMgaW50IGR3YzNfcWNvbV9zdXNwZW5k
KHN0cnVjdCBkd2MzX3Fjb20gKnFjb20sIGJvb2wgd2FrZXVwKQ0KPiAgCWlmIChxY29tLT5pc19z
dXNwZW5kZWQpDQo+ICAJCXJldHVybiAwOw0KPiAgDQo+IC0JdmFsID0gcmVhZGwocWNvbS0+cXNj
cmF0Y2hfYmFzZSArIFBXUl9FVk5UX0lSUV9TVEFUX1JFRyk7DQo+IC0JaWYgKCEodmFsICYgUFdS
X0VWTlRfTFBNX0lOX0wyX01BU0spKQ0KPiAtCQlkZXZfZXJyKHFjb20tPmRldiwgIkhTLVBIWSBu
b3QgaW4gTDJcbiIpOw0KPiArCWZvciAoaSA9IDA7IGkgPCBxY29tLT5udW1fcG9ydHM7IGkrKykg
ew0KPiArCQl2YWwgPSByZWFkbChxY29tLT5xc2NyYXRjaF9iYXNlICsgcHdyX2V2bnRfaXJxX3N0
YXRfcmVnW2ldKTsNCj4gKwkJaWYgKCEodmFsICYgUFdSX0VWTlRfTFBNX0lOX0wyX01BU0spKQ0K
PiArCQkJZGV2X2VycihxY29tLT5kZXYsICJwb3J0LSVkIEhTLVBIWSBub3QgaW4gTDJcbiIsIGkg
KyAxKTsNCj4gKwl9DQo+ICANCj4gIAlmb3IgKGkgPSBxY29tLT5udW1fY2xvY2tzIC0gMTsgaSA+
PSAwOyBpLS0pDQo+ICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShxY29tLT5jbGtzW2ldKTsNCj4g
QEAgLTQ3NSw4ICs0ODMsMTEgQEAgc3RhdGljIGludCBkd2MzX3Fjb21fcmVzdW1lKHN0cnVjdCBk
d2MzX3Fjb20gKnFjb20sIGJvb2wgd2FrZXVwKQ0KPiAgCQlkZXZfd2FybihxY29tLT5kZXYsICJm
YWlsZWQgdG8gZW5hYmxlIGludGVyY29ubmVjdDogJWRcbiIsIHJldCk7DQo+ICANCj4gIAkvKiBD
bGVhciBleGlzdGluZyBldmVudHMgZnJvbSBQSFkgcmVsYXRlZCB0byBMMiBpbi9vdXQgKi8NCj4g
LQlkd2MzX3Fjb21fc2V0Yml0cyhxY29tLT5xc2NyYXRjaF9iYXNlLCBQV1JfRVZOVF9JUlFfU1RB
VF9SRUcsDQo+IC0JCQkgIFBXUl9FVk5UX0xQTV9JTl9MMl9NQVNLIHwgUFdSX0VWTlRfTFBNX09V
VF9MMl9NQVNLKTsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgcWNvbS0+bnVtX3BvcnRzOyBpKyspIHsN
Cj4gKwkJZHdjM19xY29tX3NldGJpdHMocWNvbS0+cXNjcmF0Y2hfYmFzZSwNCj4gKwkJCQkgIHB3
cl9ldm50X2lycV9zdGF0X3JlZ1tpXSwNCj4gKwkJCQkgIFBXUl9FVk5UX0xQTV9JTl9MMl9NQVNL
IHwgUFdSX0VWTlRfTFBNX09VVF9MMl9NQVNLKTsNCj4gKwl9DQo+ICANCj4gIAlxY29tLT5pc19z
dXNwZW5kZWQgPSBmYWxzZTsNCj4gIA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTog
VGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGlu
aA==

