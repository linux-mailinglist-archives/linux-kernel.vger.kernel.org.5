Return-Path: <linux-kernel+bounces-130784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E820897D12
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F264BB2A1CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E814E23CE;
	Thu,  4 Apr 2024 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RHrX7EEk";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TuClmjxu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Mm3YDk7a"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE2634;
	Thu,  4 Apr 2024 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190593; cv=fail; b=K76PrGtGvHwNrHlhwiJqxWw46HgUxc80LnRmgGwn1XmCTmKJh6AYIA7AYJlIXUisUzRc66OncvGGNaQckN7+jQf3gL+Lmexq2aMOUg7QisXNR6HQN4McgTJx1SyjLpGlcwMLha2SVV451uHFq9yMPa5VQ6+h/piNVWV412W7IlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190593; c=relaxed/simple;
	bh=alPrxsl0tx/bnJekPrIG8f596FvEBqk0Wj/Wm7qqURo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HOZeLHMbYh6aiBnDl2uk41VZw1Gv5YoLgqZUZViFS/V8VVXZ8ZTRdS3RrWFrcP9QkMimWp1GWJUGhVw0QJRvWOeYPpNh3YPCvdJouAD60bNq8J+RMYbyiQm4cfwuW6U4nWZCj9yohxsbL4GVUQeO9CAJiCnYENqq6bLbXf+re6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RHrX7EEk; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TuClmjxu; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Mm3YDk7a reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433Nshtn014786;
	Wed, 3 Apr 2024 17:29:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=alPrxsl0tx/bnJekPrIG8f596FvEBqk0Wj/Wm7qqURo=; b=
	RHrX7EEkUkKPZdpVj9M1ZKGSli+9MlubrrYsRq7UAKYh4WMmeLjHTq+PNbaBQrHi
	QdCJmPZQ4OvcyTUueZeH/tShmy6pG/i1YpjgCQPyIeAcNXWCyb0H8cXVI4sC7GhF
	qN7Ai+QA1J7v+B7A1iNan4rBIWtQcbdiIVjp9JHd2xBk0De2ZxqV5OD2imhNz0Xf
	3LqvQ3fLXvoFsMrSbuj5TqtINSW1BwO+z/EWa1pELvpSioFEmqbBEVrQ9W53hw7Z
	GY4n+mIidEYkhiYPbPIpup4NrbATW2jq6DxLYfjhqyBIJ5r+aLGZhW9OtZbfT1uZ
	vcD6B74yKgaANzWmRYjh9A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3x9en3gh8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 17:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712190561; bh=alPrxsl0tx/bnJekPrIG8f596FvEBqk0Wj/Wm7qqURo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TuClmjxuqRepNZ7chyIOsiyHLK0MqptdTnO1vpWAANjQCy/C+qLurdquxwkumYjpz
	 qR3n0Wd172MunkyHR1g3Qk7r9bFpAwR90AwDXYAS+NQhpVj/T2vAOnbXee5JX7/UEz
	 SR5ORv8ecPjcTq5trKTVyqMEDz8CzM7WNE2CeU1XSLRp3D90aCqVxp7kpuGCPdW3qR
	 94vyDE7mNmrms2QnCpjNxwlwk7PQjo+EbgZ5SnOC6VUj6+dd9f2bgJgr0qHrFqtozt
	 yO07gvL7/ro98xTcRBkO6DikWCKox8Ay7sgvaAvyz0Gl9Ko2tP6ZO9s2KWzIb6+fmE
	 RHJHl0vWIthzw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E1C0E40540;
	Thu,  4 Apr 2024 00:29:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 318E2A00AA;
	Thu,  4 Apr 2024 00:29:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Mm3YDk7a;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1405D4055F;
	Thu,  4 Apr 2024 00:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYveboN+PPxT0TTcR7jYZA6fHCJBUC2TrXnKfDh9CHPvXgoKzXeCwmP5DQ/JZycn7vy6O2mnhJ0Mm5KGnVXmcoiC14+xfsUjTxsFmt2yU1tfkxzky7d15R4vA8Pmu+NskpFWwPPoFqNwBi6mlDDZNA+/3YZyHQ0n8iCflLg8kF/uTvkJYRAvORbngjGKgXCrfDsyhIiGewjgHiEBBofEV49a9gyI6Sl5ToscGTJ3cxtRZzxna/zaRmkG9GPkLZUWRaLGvaqLzTcy1EiVjyIurgb9jqOPVe0rYO7QwVn4trkPnYass5D2vJCC/dsgagjhcUO/TtDHzb+nRlVEajy1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alPrxsl0tx/bnJekPrIG8f596FvEBqk0Wj/Wm7qqURo=;
 b=e3KvaWIh9V27RriGOiatXqT/BfA2GTyCu0Zm8DK1zNIO6jhaJDAQaElpSixF+RXZTSEmCgup4ovh6pJV07SMwaCxD57j9+U/v2vVoG8rg6VOPuWu1C0XAYe6pj+d8h/5WrzAeBwr8ZuHMJfyQ8QNy9nxVgCYyPTnow01EvraUp4giygaJUPm0nHyx9OHWl3+LnPfNPzzYqJjdZCOMcWZuZfsRnDwHGOaMK1EsCfKnLBXiFfLb36Jln8NrwdezGpruVz2N1yPx7gPxTCFRshVNb3uDBANA9aG19J+E4O5eskHn7h6iP2Tk4opfQA9lM1mdU7xQPgkqSKLoMBbnMMHbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alPrxsl0tx/bnJekPrIG8f596FvEBqk0Wj/Wm7qqURo=;
 b=Mm3YDk7a0JmfiKLQoDJgf2yRnJp6cSnFZx0hIUdbWtcAsHUmcy0fKn5m9X48inQAiewrfOQYRIbZWBQq6UQzUA80lQBAc35TDaMruxtQrAmS/FOve3eCBR7kNgoWVGBiZmE9oIdAIfdC/GPwrqDI1Sdm2UFNiiJvDHtRvxgdkY4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 00:29:15 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 00:29:14 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Topic: [PATCH v2] usb: dwc3: gadget: check drained isoc ep
Thread-Index: AQHahUf+Fjbt0R5rsESCdAPrKfiIcbFVmhGAgAADmgCAAaX5AA==
Date: Thu, 4 Apr 2024 00:29:14 +0000
Message-ID: <20240404002906.wk6xbz2wp2tf2xwn@synopsys.com>
References: 
 <20240307-dwc3-gadget-complete-irq-v2-1-8c5e9b35f7b9@pengutronix.de>
 <20240402230555.xgt5uilc42diyr4m@synopsys.com>
 <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
In-Reply-To: <20240402231848.4hzzrxegjrcmdab2@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BL3PR12MB6644:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tIGlBzgGY9+ViTgpvMmfuwekGw719MlDkBWvJa/fWM8P8Cde9ggi3LoNWEItydlZ7nsl7W9fkfZSRCgfV+qICbLtmQ/CskvVNw/KP1qn150Nhb0kYAVfv54Hrrk9bxmI1rCicgPPbQf9XzmGhFIBIb6kVal8Jm7RkkI/kYtoEwIuFile5LoZ765Ew4MuRL309a1rm1rGfiTvFgDbLvA+pLlQa3fhPgjSvxQlKeJYDOEtjcHgiFnjZGd2s7T6SxoI973Kz79T2wNZBJ0PCAqYfZcE86gOrzH7hC65SCHWlLm3Xx6/YVKNsyQdvG6vvS99iALspcMtFsAvg8H0+qv78JdYh9yZM0CWg8b2rROvuvmnPxmpKp6cQxj359ZQMQXt8RL+Ul1+TegmIbPFTlNBuMZgV+uDEEmv8hfCC40DH7rc0vufkmCQSys9MtkJeTIlWg9ClQWySEhxUZPjN7RbdE+TB0YskedaTxNm4vLmwlmfDAOeqKszSaHi+h6VXdX5joE4CDghlPDDWRGKykPbajjvb49o5uuth4OO4ht9iq0TAYxBfG0CSTpdo3Pa7fFe2H4SNGvCr/PjmSeL7CdBp8GC+lFqtaGdo4ZINy0tBhDUDu6ZFixIi4R6vVe1Kg9y3mUbz0ZVIeJ8C3czJfWfkTD1LCo7MM4M6yJvJQ071mo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SU9Lb0c0L0tsZ2hjVXU3am51ZDIva0I2VjdJeXlpY3poY0pCcUZNOTVFMGFz?=
 =?utf-8?B?NGU4WTZXakNyY0pzUGpCQVNsa0l4dHBzbGFSbzZ6QVNhNmF1cjRUcFZGSXVu?=
 =?utf-8?B?UU9NZFdJTGM5V0RrVzlvTDZna0FxMTgrdmgxOE02M3dtSFJtRGE5dExpcVFh?=
 =?utf-8?B?Y3l6UE5STSt1LzZNWmZ6UlU1Qk5jNEQ1b1M4SVhMSldCNTlsUDBrRWJKeCtp?=
 =?utf-8?B?aEhOLzRxeEMvdlQ5MmdsVGJvL3QraXJxWnJBNngvVVdtaVovMGNyMUNWYUI4?=
 =?utf-8?B?K2pqb0xhNWVQMkEwTDJCNE9wa0pObkI5QTg4WERhRzhsNUVKaHdJWG1ZeENZ?=
 =?utf-8?B?N1lacmQxMkx1YTRXdmR4VzRncHNGb01aR1VGTzZJNXc0anRzZ1ora1RyQjB0?=
 =?utf-8?B?ZjNlVnpTUVNkVmVxallGcXhDczllT0srS2NrOVhRUEVMQ0tScGxia0Zab09X?=
 =?utf-8?B?NTZoZWNTd3cwZTR4dDdmNXVGV2lBdWV4eTRJVzdma0RnT0RuVlpUdUljVEY3?=
 =?utf-8?B?alRhbmx3bXJtQXJqMWpFRWRnVHJTU0Z6ZjdjWG1LdlkxUHZOZ2x4dlZOSkx6?=
 =?utf-8?B?K3c0VGJhYUJ3U3F2ZVRBSHJuZExNTjAya2tkTUM1QkJlTTFUZXFIUjB5c2p6?=
 =?utf-8?B?TWxrSk5RaE51QzFlVWI1SWFkRmVSZVdjR3BHaFgxeXhpNUY2TEN2ekt6Z3Qr?=
 =?utf-8?B?MXJlSDRqWGpEYlMyZThmSkFxa01wV1Rta2VRVlVPdFRRK2RLTG1tWHlmV0lR?=
 =?utf-8?B?MVlQNE1zYm43QzZDRkVPU1o0alh4ZW55RVV5NDhXS013aGhoZzB5TVcxa1Ez?=
 =?utf-8?B?RXMyK3g4WXVMRVp2dzdhYStNODZOU1pUWWpIL2lCanNHTnZ6UkVFN001VFdp?=
 =?utf-8?B?U1ExTTVIdjdIRmFaSGJJWm52Q2dFTU9EQk4vdCsxME9venIvZUE4ZjliUFNx?=
 =?utf-8?B?b3BTWVNBVkJxUWFsVXZSTURReENVaTVad2g5R3N3czJtcVpOZnVvWk9VaVpP?=
 =?utf-8?B?MEw1VEVQVVdqNGNLZG83SnJPRG9oZ3FmVE5xZlNrSFR0VjRmZmZzaVRjb0xQ?=
 =?utf-8?B?ZXZBMEp2NkFySk9mVUdiUm9hYXE5cGdYMTZuYzZ3V1RzeUxpdThpQS9GTmJQ?=
 =?utf-8?B?Q2hVYmpVVmNiZytHNkdFK2hQdm9aamQ2a3lOTG01RXJRQTJ6Z3BUSXBrK1BS?=
 =?utf-8?B?QkoySkZrSHpSR1pCNFJtT0RSaE02cU5mSGZhU1NZRmdNSjEwOUUvaG1kYWhD?=
 =?utf-8?B?OEZvRWV6aWtFcVgyNDJXU2F5eFdzb3gvQ0FQdTl2RGZ3S09tNU1pT1dUWlRt?=
 =?utf-8?B?RkgwK1JNQjBZSG9PMDdYSC9zMFJGcGs4VUhreVB3OXRnb1VrVVVBTm1LU0JJ?=
 =?utf-8?B?cU1HVlBIbWs4eW5vYXpJbmpyYWZFZG9ydkhDZTRLdEhvSU1kTlJ1Z2hHNzFF?=
 =?utf-8?B?ZnQwM3lvN3Qydy8rUFUrWlFaSVlXenZrWnFta2ZxVStDdHZGbzNLSXdBWmhk?=
 =?utf-8?B?RmZ1eEkxOEZRZHJJMTB2OEhBZ3duWTB3ZWhwdXVBUkN3VUR3S2JxZkk3UUFV?=
 =?utf-8?B?S3VLTVVDT3p6RXZ2L3g4Qi9zRXcvTEd2T0lPTG53Y1ZXZER6WmIzVEpDOUxp?=
 =?utf-8?B?cW0wQXI0bXhGRkw2ZDhXczAyMCtMODF3SndnaDUwT0kzOTQ5MEt0ZGYvUGlx?=
 =?utf-8?B?dUJNTUhhd3dsVmlDSmVNVnB0SXpHM1RTNUlXOWRZN3hzZEhBMkNId2x3QVJ3?=
 =?utf-8?B?bmdxaE5CdDZLeGhldCtESDV4M3FTQWRzMy9WYk9UbEp5TU8ydHRQNnljZERF?=
 =?utf-8?B?SGV2T2pYSGp4WWc2bjBSakg1SFNiLzMwSmE2d0wycjA4L1JRMFo3L0VTTFpR?=
 =?utf-8?B?clRrQXFiQzVPck9aNkFtbXRaSDNBVm9TS0ZTNkx3UVFHcEwxeXMweW9HVGNk?=
 =?utf-8?B?cnUyaDR2L2FpbHh6RTlVaEh0bnlQSk8vL0o2V3RaQSsxdTBlOFgzYk5jeWlF?=
 =?utf-8?B?bHRQQjZ2Q00yYTNCRUw4VXZROGxwcXVENmdwRmVteCtva2lXK2tQVTVvcHdT?=
 =?utf-8?B?OFlqK09PRlk1Ujk1TDJMN1JLTVU5a1FmZ3lrQlRQVHB2OC95MnhJNGxsNmU3?=
 =?utf-8?Q?nnW1ozSRtkHcigbyeGVgghF3E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDD104CDD8D90441A8E1F96D79CB1878@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nxVEfgGbMGQqrmPsA9ceTiFUuQUtAPTVH/SkBol+M7fQbUGSwGUXoA4SSuTmYYJyjYtR/FJ/WtN87EvnQ2mOBQNQEfP5Bs7KQ+8i4n/j6dACNfmksy5AZaXc3wGwzBPH/6sGECgYGayUhqS75GixTbns75i6VGiTNmaSw+Mg0CMlmLmDbD8N8ztRCWYj9UdYorld66K9XOHSgH58zYyuvwPKsd786PYD7iQA4lG6wsX1Y15r2OyDaH/YpmKj8k86jCc6tU6bRnbTa0v2TkSovKfVG2whMp2V9pwwt4Gpk1n3qHpcBFMjCEIgYfeI9wU3Y8kAVuC8k6mGP1T5S4JHYjml0KhfrUtSKpofcvtCRqUI5hXMmNkB28620tpaYPIWjU58xkYQaGB3mYk/gPHizK/6sKPZXGJoycKAmqgpG1qvqqzoLRpTyJVw7adBgQMAWCWf+UQLnW1v+KUQ07MdvDsoSZdmxzJKH/R/mX7u28SXwU0uR8cQKfrk3HS5/uIXTcuoWbgT3B97Nno8nY77j+EirUQH+BkK3rVTrAPcCRIjM/FoXHwz0/0zxB1X8OQSN/8tqUo/NxD+2ZUJSKULy3Ij61iTrv0xYExea/4HcGkEnnwpC/KnUCYBc1ooZ04T60kM3mw4BQNNLCI6TyMb9A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170c0dab-f261-4f1f-0e73-08dc543e41d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 00:29:14.8689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE/yxUlhDjhALdVk7GvNcJXSZzHaGfD7G689AFvBgoAt+atOVe2hOe/Z+xpreNOle5vmpRdaxVTsFV1i3O9iIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
X-Proofpoint-GUID: HwFl9xOy2umFdKtZXugedtTQLD2Dm4Cw
X-Proofpoint-ORIG-GUID: HwFl9xOy2umFdKtZXugedtTQLD2Dm4Cw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_25,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=585
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040001

T24gVHVlLCBBcHIgMDIsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gVHVlLCBBcHIg
MDIsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBNeSBjb25jZXJuIGhlcmUgaXMgZm9y
IHRoZSBjYXNlIHdoZXJlIHRyYW5zZmVyX2luX2ZsaWdodCA9PSB0cnVlIGFuZA0KPiANCj4gSSBt
ZWFuIHRyYW5zZmVyX2luX2ZsaWdodCA9PSBmYWxzZQ0KPiANCj4gPiBsaXN0X2VtcHR5KHN0YXJ0
ZWRfbGlzdCkgPT0gZmFsc2UuIFRoYXQgbWVhbnMgdGhhdCB0aGUgcmVxdWVzdHMgaW4gdGhlDQo+
ID4gc3RhcnRlZF9saXN0IGFyZSBjb21wbGV0ZWQgYnV0IGFyZSBub3QgZ2l2ZW4gYmFjayB0byB0
aGUgZ2FkZ2V0IGRyaXZlci4NCj4gPiANCj4gPiBTaW5jZSB0aGV5IHJlbWFpbmVkIGluIHRoZSBz
dGFydGVkX2xpc3QsIHRoZXkgd2lsbCBiZSByZXN1Ym1pdHRlZCBhZ2Fpbg0KPiA+IG9uIHRoZSBu
ZXh0IHVzYl9lcF9xdWV1ZS4gV2UgbWF5IHNlbmQgZHVwbGljYXRlIHRyYW5zZmVycyByaWdodD8N
Cg0KQWN0dWFsbHksIHNpbmNlIHRoZSByZXF1ZXN0cyBhcmUgY29tcGxldGVkLCB0aGUgSFdPIGJp
dHMgYXJlIGNsZWFyZWQsDQpub3RoaW5nIGlzIHN1Ym1pdHRlZCBhbmQgbm8gZHVwbGljYXRlLiBC
dXQgc2luY2UgdGhlIHJlcXVlc3RzIGFyZSBub3QNCmdpdmVuIGJhY2sgeWV0IGZyb20gdGhlIHN0
YXJ0ZWRfbGlzdCwgdGhlbiB0aGUgbmV4dCBTdGFydF9UcmFuc2Zlcg0KY29tbWFuZCB3aWxsIGJl
Z2luIHdpdGggdGhlIFRSQiBhZGRyZXNzIG9mIHRoZSBjb21wbGV0ZWQgcmVxdWVzdA0KKEhXTz0w
KSwgdGhlIGNvbnRyb2xsZXIgbWF5IG5vdCBwcm9jZXNzIHRoZSBuZXh0IFRSQnMuIEhhdmUgeW91
IHRlc3RlZA0KdGhpcyBzY2VuYXJpbz8NCg0KPiA+IA0KPiA+IFlvdSBjYW4gdHJ5IHRvIGNsZWFu
dXAgcmVxdWVzdHMgaW4gdGhlIHN0YXJ0ZWRfbGlzdCwgYnV0IHlvdSBuZWVkIHRvIGJlDQo+ID4g
Y2FyZWZ1bCB0byBtYWtlIHN1cmUgeW91J3JlIG5vdCBvdXQgb2Ygc3luYyB3aXRoIHRoZSB0cmFu
c2ZlciBjb21wbGV0aW9uDQo+ID4gZXZlbnRzIGFuZCBuZXcgcmVxdWVzdHMgZnJvbSBnYWRnZXQg
ZHJpdmVyLg0KPiA+IA0KDQpXYXMgdGhlIHByb2JsZW0geW91IGVuY291bnRlciBkdWUgdG8gbm9f
aW50ZXJydXB0IHNldHRpbmdzIHdoZXJlIHRoZQ0KaXQgd2FzIHNldCB0byB0aGUgbGFzdCByZXF1
ZXN0IG9mIHRoZSB1dmMgZGF0YSBwdW1wPw0KDQppZiB0aGF0J3MgdGhlIGNhc2UsIGNhbiBVVkMg
ZnVuY3Rpb24gZHJpdmVyIG1ha2Ugc3VyZSB0byBub3Qgc2V0DQpub19pbnRlcnJ1cHQgdG8gdGhl
IGxhc3QgcmVxdWVzdCBvZiB0aGUgZGF0YSBwdW1wIGZyb20gdGhlIFVWQz8NCg0KVGhhbmtzLA0K
VGhpbmg=

