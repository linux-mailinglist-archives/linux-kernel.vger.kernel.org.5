Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C279C2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjILCcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbjILCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:32:25 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23846174387;
        Mon, 11 Sep 2023 18:15:17 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BJZM0m031979;
        Mon, 11 Sep 2023 16:44:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=qnvKNbo6NXGni1eOS5aGoKJRtU0RzqanfSgWMdyrZwk=;
 b=nJcfiKxDUqZrHxnmrGdcqS0uSa2Uw5ReXudITXqPIO1XTgznKHDkOyNa2FGG18pISFfT
 ouvLX/YRnEiGa7kupLd2ybIMZdbmhcsAgnZye5i7CbZaNz7b95WT3f0usO53BGP46TpI
 zqgM5R+jT95Qk+vekqsXCRxKaPBrdMr09x602OJR27ACNsdS5AE8tUw54p07tPP4h01H
 rM9MXLBUgQC1K+Cc/vqItsq9GAMJ4mwgjKyMtSdgcFTgl2nitBGo+NOdMcYXSBusl0HC
 dYR9sjOy6XaI68Z9jlKPtbAGXYySfCeAgds0T/LbEtM/BV6PiwfyxIosvSOwnVOsc12Y zg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3t0qbf3qpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 16:44:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1694475864; bh=qnvKNbo6NXGni1eOS5aGoKJRtU0RzqanfSgWMdyrZwk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bPTaDjcNbxbklngweiG6ZUXvR8UokYHYgfNZ0j14qcDARuLu0H1rw5u4+twHI7KeS
         o0mt487WalgdzGXyJ6H4ceYXXJnzRGKhE35MEgvdx2Ffb+vThvwre39NsjjEJ7KJRz
         57GSz+bqH9JF0v95PllUu1l/qd+5Pyybc5w1SuE5Wr1lwoRYXhWIEABWuqen/U7sVF
         y1Tp7qCo1JdNQFLLAf7CcU+Y+5qeyvlny1VM/IaBaaX77WzdyWMQz/wBDmlHPTU1DQ
         bTn7tRxQjAr3hUSEYdt2hOJDK1DMowwVmzlKYyG8TbSBdByaJT9qdXJOOFcd+3P2eP
         BoFIwMCBzhdXQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F1AFE4024D;
        Mon, 11 Sep 2023 23:44:23 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CDC2BA005F;
        Mon, 11 Sep 2023 23:44:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Uj4sxyBX;
        dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A810E405AB;
        Mon, 11 Sep 2023 23:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFQP/gIhmxMprtoFYk4Dq5kiMor0Tg0bnYMU1gWtpG6syVyYA53iP50vhOL+//PDzobBXerpGilB4BpABowcOAdHx+8azUr3yZhDU3vY8SSD6Nj8aJXJFM+dZQqpPQM3PywFvbNCSpOSlNUZLxvFXqejiMRXjSoO9Qrp8/VrtTiNTTN+yPDXuf+qC48alz3pzisnN6lAf3bn9emS+5YKPohBeCU+wl/njDQ434Zs9Uevbh8ypR1tncStEqpk832gjM4g9TNwRPpthGb/drP8PxEtSRYHpmjlYcwwIF1IOm7nZGjeIEsiHHNEH86cuXQUBE8RZoOJ6sCqzXGte1O4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnvKNbo6NXGni1eOS5aGoKJRtU0RzqanfSgWMdyrZwk=;
 b=MrmckPdqEpdnijkNkVzN0U55y07PqnvalF55drI090Jh2kqjFesYt/QT0RcxWMva1xkqha/mJDFnLE4bElkrc86BwDQ+KIyscR/glpy5ua313w+qO86ma/rt28J0LwkQmLcJ1liLwDCuKSHNz8b2h1F8WsBg/HN4ggB5E0FNKCggxJlorLozEH7/0VYLod1OAdOWB/1ORSv0DaWvmuHapX5ZFR/85SWoPZuHoF7CtMFMw7dGBlRDYMJzHC5DjsClMT+LRKMoAYzjdafJX8aQoR1PaKJ78clcc1qQsylEql6NDFgpuWnHpvCvmLETfQm6JLEUhA11Z04zoQL+zNL38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnvKNbo6NXGni1eOS5aGoKJRtU0RzqanfSgWMdyrZwk=;
 b=Uj4sxyBXNUff3bHCsi+1eDA2QSdCtllRmL2Q1UPY8MLLEW6BOt4Lvo6F/jbcYKJwU1h+nvziJtguvf0G7AP7qzX7iV97suThIVc7zGYEkOZus1nY4xVruR8JZWVcY4KxleZARcwZ1X8RuOM1PNAvUKNniISg0QUmaB1FjOJsLq8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Mon, 11 Sep 2023 23:44:15 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 23:44:14 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Stanley Chang <stanley_chang@realtek.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND 1/2] usb: dwc3: core: configure TX/RX threshold
 for DWC3_IP
Thread-Topic: [PATCH v2 RESEND 1/2] usb: dwc3: core: configure TX/RX threshold
 for DWC3_IP
Thread-Index: AQHZ2XPbT3nDD3HafUCfXa73QfjMT7AWYM4A
Date:   Mon, 11 Sep 2023 23:44:14 +0000
Message-ID: <20230911234408.xb5higafb6ssajyt@synopsys.com>
References: <20230828055212.5600-1-stanley_chang@realtek.com>
In-Reply-To: <20230828055212.5600-1-stanley_chang@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM8PR12MB5413:EE_
x-ms-office365-filtering-correlation-id: 43f901e2-87cd-49b5-4c66-08dbb32101d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfhee45L0GijFosYgYZIwP1Sg0+5UU+YT68hklJQhrGCCH0irEQqeeYATcTgz4nd24y/mXhgittOaJMcuL2V0WrFbQBudzRTST8/cWeXEClSZXHNWZRvnb2XmCNUjDUL544P2m3T54B9h6fsQ6C/eJh1rJ6xxIq0g96mCZdObu1ql06uJaAL8deIMtJi+sHDksS9eXuSKmIHYwjbzwj4g6rz44AlslgVpeKagw2Xr2CQg3Oo2bHdHUzlwyZscp7HFl6XK7KGKA+lfD62EyGASmiUCHuWUiinJDPde+y2O6RICecEXCjiR9pAHJMQco9f3ZSRDKHGfoeqUfXeKyIeYu/z8/B/ILqOdg2EAKZng5HPMq3MI52JzKINUUyDjyl7aJvN9taxueF/H+jxZlC6os64aBb0NJQT+a/HAK32bqhxdaEwQP5V/t1byKRXLfziJsKiqs1LnNSr6U6CbepnvBbcV039W9WpgNs1joaVs8alFUNztSV5/DWX2dZZzd+LIYUiRDoOZTUXPmjAw6jk2pDz7yW9B4dIWEd10fK17FfwqVeqZYB7ekslRoan/kgrLb8YS2LxfRi8DqozKB4oQdHT7uF8Ot2qG0X6T3HD9eeBMctgpv/abQt5bF74Lq7r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(1800799009)(451199024)(186009)(36756003)(2616005)(64756008)(76116006)(54906003)(66446008)(66946007)(66476007)(66556008)(122000001)(86362001)(2906002)(38100700002)(38070700005)(1076003)(8936002)(8676002)(4326008)(5660300002)(41300700001)(478600001)(6916009)(316002)(26005)(6506007)(6486002)(71200400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3ZVT0owQkI1WUk2N2krVndXZzJ0ZjJ1MmVkcWZicXYzOEZYa20xMUFrYTVO?=
 =?utf-8?B?RCtPNklaUFV2djE5Ym1VK2lRQmVqNnBaa0JpRzdhUHpKRmxqcjVKelhLcjNM?=
 =?utf-8?B?V0hyd2dGaEFCZDE4dTB6YWdQNXFJOUVUWThyTjRodmlqUFlOVzRjQ2tJMUQz?=
 =?utf-8?B?YnpPWlVzWFBQekQxS0M1aGRIV01oVVVRY0JGanZGUi9yaG96cHF1aGoxeXFQ?=
 =?utf-8?B?OW1FRnVMWVJjVE9KWlJWZFB1bXdNMnpMTTdxOGNvcERvbFNHakpvSHFGRXcr?=
 =?utf-8?B?bEVEbElhOHlQMWp1NklUYzNMOUxEN1QvYXI2cWVpbzZtSytQWm9aZk80TzVF?=
 =?utf-8?B?OWUrRVovU3A4K3QzWmlZNHZTSGJNMDJqYjZBRyszUXNHOHFHL1BvWDBpaE1E?=
 =?utf-8?B?c3hSVjB6dVA1UTNlZXMwYmd4d1ZxNy80anVUdTJUb2t2TVk3NEV2ekJFUVdC?=
 =?utf-8?B?VytZUGRKTGROaFlVUWNhK2I2ckVQQWFKOXVsSlFFVTBFdjR1b3B4MGJHMDQ0?=
 =?utf-8?B?cGoyR3hnOXUzZUFuUTVRV0lCaVo0UlFEd3ljKzVLTXM1c0JJWUltNHBSNHMv?=
 =?utf-8?B?eVRzaDVJYnhIL0dCUW1IQ1hVUWMwS09aejJoUFcvWEhBU3BTS1YxYkNGMzds?=
 =?utf-8?B?TWQrbXN2eXJhZFpYSEpUWUNMaVRWQ1NRZXlvS3lXQmhzcXRrdnRRR3RVSXZa?=
 =?utf-8?B?VENvTHhFR25zcUIvN0QrTjFCQVZJWmtUTVdsR3M1MndHZGRLMjk5MmN0TzJ6?=
 =?utf-8?B?QzZzL2IrWkFZbkxiWDJrWkk1K3QvM3Q1dG9CVXVuQ1hDNHZxdm9IRngyQmwy?=
 =?utf-8?B?UGNzQlp2RzJzaXNEejBiVnkzYkQrME45V3JnVHN4a2ttdlMySXhtMGZBd2Rk?=
 =?utf-8?B?RFNpRlFPQ3RSdWRCeGxaQ2JDZ2RwY3Q0ejBCTkhVVmxOSXY1RW95dmp5L3NS?=
 =?utf-8?B?L2ZtNy9sTWlKRTh0Qkl2Ykg1VGJ3MmU3R01oR1d4UzRkRE0zc29CalFjek85?=
 =?utf-8?B?TFZCR1B5MHoxYnE2em9QU2pvczVBbW5nUWJqVWZydkpYbFhQdjVZUTVtNVph?=
 =?utf-8?B?VlNYRlRFTXFDR09jQmpGZXZPVmxUOStoclZveXR0SzVTcjlhd3M1dk9zdjRn?=
 =?utf-8?B?NFRKQm1RRHJXek9NM01EVG10V3BPaWFOckM4YlYyMkNpeVNVU3N6SWtBMDht?=
 =?utf-8?B?dEhzNW1raFJXejVOWWZtVW1Vend5NndZMG03MjlDU3paM2VBNGhubzlVQ3dL?=
 =?utf-8?B?Z1VvVEtlelg4czlXZXltalk3OWZ1YjdSRWoycXhSUC94emY0cVBqZEVabytI?=
 =?utf-8?B?blZGRi8yeW1FNHZEU1BsSkJRNFlYMWN4dnRXb2ljVWhTd2F1VndZKytvazRR?=
 =?utf-8?B?cXphbFB2RlNFVHNXN2UvNndrV1MrdFVkb1BpNzBhZ2k5SjEwZVN0Wk9KaDE1?=
 =?utf-8?B?SVFmQVNXYUY2WWZIUHJ1aEYrZzNzb2xIaGxsSW5Xa1ljYS9SMHRiSGh6OVBG?=
 =?utf-8?B?WnBWQTdiQ2J1dTJoL2Q0azhHRnB5R3RIN25OSm1kZGhnNVZhNm9DZERRSVM5?=
 =?utf-8?B?RlVaTDh2UzhMQjlNbFR3YVovYW5OMDM3U0NtbVU4Ump5dzJPMm1qSFpjM1p3?=
 =?utf-8?B?TkRzWGREK3c1amVQSElqNENqeFFiZUZkMWZrbGgxVlVKeUs0Nk1FcjZjSnhx?=
 =?utf-8?B?ejZaRFUrZGt0OXIzVG1CblNpaUVwUGx3M2RqdVpMRkVKVSt1cGVLZ2RYV3B6?=
 =?utf-8?B?bXZMZXVMV2Evc3doZWRkMlB3UEhSYXROWG5Zb2I5ZVJONzNxbXlZQS9NN21v?=
 =?utf-8?B?UTFoR3RFdzIyQ0txUWY0QXJlRXZ0VW1FZU8zQTFtaTdRU1NEQVhNSXJqUmwv?=
 =?utf-8?B?RWMxK2lvTnJ6VGdyNnhQdmh1RDAzbWhCS1A0R1laeEcreEQ1YlhMRVR6R1pm?=
 =?utf-8?B?eXdlMjNHNHpEUnplb0R3cGMyanZGclh1bUtiRmt3QUw5VkNWRnlnanJxTlly?=
 =?utf-8?B?SjdCYWVFVDcydHV2eU5HZVJtNFNkV3MzcGZ0QnZTMnFjeEhsTnhCZVo5OEdH?=
 =?utf-8?B?bGp0V1ZhbGRFRlFiaWxEVnhkanA2RWNVaU82ZTFJME5XVjBNc3ovTVlPSXh4?=
 =?utf-8?Q?B3GprMEBgUxWnLTqdD8HiwNf3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71CB72BDF7E0BC4894AF898504B4BDA6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L1B3YkxobGtFdTFiTEptUzFxLzkya1RTdlNWbHl3NXE5L0FXKzlSeFJvWFZs?=
 =?utf-8?B?NURlb1haczkwbytVQlVsVStRelNsY0xlZC9VNGhDYm1pWFpnaUVJZWUzbWRG?=
 =?utf-8?B?Mkh2cExXL29LN2kxZ2pQbGUxVEtjVTFIZytHSityMnVtV1V6VUdEd1Jja0gr?=
 =?utf-8?B?QUpPNjc4NzN4ZlRNR3UyMkYvN0dQZVZZVmN1TlM3NytlTjRvbS9oOW9zSGh3?=
 =?utf-8?B?WlJRZFpDSnBHQXVpemwxMTJhZ0xIbXZmNFVYYUswQ0NwSHVyc3E1QkVpVDc3?=
 =?utf-8?B?TU5mb1RXZ3AvMGR5K1h3ZFU3b2dUWUNNbUxrdlZOTnpSaFJ5RFN1OTM2dk5j?=
 =?utf-8?B?Rmk5SnBMOU9KeEUrUGwvWHJFeWRkYUNPZ3VuRmMyWWVIS2NJMmlGWG5SNUl5?=
 =?utf-8?B?UGFUeDk5N0hrbWVvUEx2akZGbW85VXc0VDVXdUVURGJWS2trampEY2RidnMv?=
 =?utf-8?B?K2I2TzlmNFdrYmlvQWRWUy9kdTdMcFZvQnZFTHQzZkJBV1VtT0JLQ1ZJOXdF?=
 =?utf-8?B?akhJM2xhMkg2UTlkZUtHQnhCUzMvK3NBK1NZRmlDbzMyVXo5d25aSzUvRnV4?=
 =?utf-8?B?YVFJYmN1Qkt3K2NEcm1uL3BHTkh0UTUvMnZhNXRraUl6a0h6djRmNW5ZeDk2?=
 =?utf-8?B?OWNjOUsvTkdZd055S0dabjMvSVVzSkhrbnlibFhmNGlOaG1vUElqditEUWZr?=
 =?utf-8?B?NTlZUHdiQ1hPWGh3SkVIaGJSY2ZJL2FLenE1dGt5NlF2b3R1c2g4dnVKd1hu?=
 =?utf-8?B?SnFjYUZnWXhaZkNQTFhxd3BibXF4d2p2ekhnR3JPQW5HblZzaUFNSEs2a3Z4?=
 =?utf-8?B?dUxKK2I2ckk5d25sc0xLai9pS3JWcUxEWEE3Sjd5OERmOFRDa1diNmdDSCtq?=
 =?utf-8?B?em9vdkVGaStzNW9KQURYK0FXUUpjZTloQ2h6cW9jTmhFRy9qWEtSaGVFQ1l5?=
 =?utf-8?B?ZXlhbFRJTndiTXQ2V1hCNURWZXFKcDFETy9iSkptaWhwWWpNZklqcm1ZaVE4?=
 =?utf-8?B?UDFPNmVPVUhCYmdsZzVCcjFwZzlwS251NnIyYTBRWVpKSzB5eldNdkxkZUdE?=
 =?utf-8?B?aElqNElFZ21vT0lvRk13OS91N25pcksvL2F6Rm9kVkJhM2VrUXNVR0FJVWlv?=
 =?utf-8?B?LzhNRjI1WFVqbXBZZmNTYkVsLytxMmNzTE9CQ2N4N1ZUcElQTkdzMG9OcnZP?=
 =?utf-8?B?c0VmbWVuMm1mWnpOci9qdlV1MVlhNWthMzlnVTVXMEM0RDV0RHdYWk1jVXRZ?=
 =?utf-8?Q?642M9Ce8ijQoXTt?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f901e2-87cd-49b5-4c66-08dbb32101d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 23:44:14.8645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ME58YHTTuxDCbVYaPXb0t6sB8+eEVb+Hg4RDwxnWgi4NlPERUGfx/vC3NtSsnhQpVitlhCihtHmPDfEMMV/N8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
X-Proofpoint-GUID: G5o0w26UVcP_xCKL0SSkYys9MLrBmaD_
X-Proofpoint-ORIG-GUID: G5o0w26UVcP_xCKL0SSkYys9MLrBmaD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309110217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RhbmxleSwNCg0KU29ycnkgZm9yIHRoZSBkZWxheSByZXNwb25zZS4NCg0KT24gTW9uLCBB
dWcgMjgsIDIwMjMsIFN0YW5sZXkgQ2hhbmcgd3JvdGU6DQo+IEluIFN5bm9wc3lzJ3MgZHdjMyBk
YXRhIGJvb2s6DQo+IFRvIGF2b2lkIHVuZGVycnVuIGFuZCBvdmVycnVuIGR1cmluZyB0aGUgYnVy
c3QsIGluIGEgaGlnaC1sYXRlbmN5IGJ1cw0KPiBzeXN0ZW0gKGxpa2UgVVNCKSwgdGhyZXNob2xk
IGFuZCBidXJzdCBzaXplIGNvbnRyb2wgaXMgcHJvdmlkZWQgdGhyb3VnaA0KPiBHVFhUSFJDRkcg
YW5kIEdSWFRIUkNGRyByZWdpc3RlcnMuDQo+IA0KPiBJbiBSZWFsdGVrIERIQyBTb0MsIERXQzMg
VVNCIDMuMCB1c2VzIEFIQiBzeXN0ZW0gYnVzLiBXaGVuIGR3YzMgaXMNCj4gY29ubmVjdGVkIHdp
dGggVVNCIDIuNUcgRXRoZXJuZXQsIHRoZXJlIHdpbGwgYmUgb3ZlcnJ1biBwcm9ibGVtLg0KPiBU
aGVyZWZvcmUsIHNldHRpbmcgVFgvUlggdGhyZXNob2xkcyBjYW4gYXZvaWQgdGhpcyBpc3N1ZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRl
ay5jb20+DQo+IC0tLQ0KPiB2MSB0byB2MiBjaGFuZ2U6DQo+ICAgICBBZGQgdGhlIHByb3BlcnRp
ZXMgZm9yIFRYL1JYIHRocmVzaG9sZCBzZXR0aW5nDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdj
My9jb3JlLmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAxMyArKysrKysrKysrKw0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCA5YzZiZjA1NGYx
NWQuLjFmNzRhNTM4MTZjMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTEyNDYsNiArMTI0NiwzOSBA
QCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCX0NCj4g
IAl9DQo+ICANCj4gKwlpZiAoRFdDM19JUF9JUyhEV0MzKSkgew0KDQpXb3VsZCB5b3UgbWluZCBh
bHNvIGFkZCB0aGUgY2hlY2tzIGZvciBEV0NfdXNiMzEgYW5kIERXQ191c2IzMj8gQm90aCB0aGUN
CkRXQ191c2IzMSBhbmQgRFdDX3VzYjMyIHNoYXJlIHRoZSBzYW1lIGZpZWxkIG9mZnNldHMgd2l0
aGluIEdUWC9SWFRIUkNGRw0KcmVnaXN0ZXJzLiBUaGUgbWFjcm9zIGFyZSBhbHJlYWR5IGRlZmlu
ZWQgZm9yIHRob3NlIElQcy4NCg0KQWxzbywgSSB0aGluayB0aGlzIG5ldyBhZGRpdGlvbiB3aWxs
IG1ha2UgZHdjM19jb3JlX2luaXQoKSBsZW5ndGh5LiBDYW4NCndlIHNwbGl0IHRoaXMgbG9naWMg
dG8gYSBzZXBhcmF0ZSBmdW5jdGlvbiwgcGVyaGFwcw0KZHdjM19jb25maWdfdGhyZXNob2xkKCk/
DQoNClRoYW5rcyENClRoaW5oDQoNCj4gKwkJdTggcnhfdGhyX251bSA9IGR3Yy0+cnhfdGhyX251
bV9wa3Q7DQo+ICsJCXU4IHJ4X21heGJ1cnN0ID0gZHdjLT5yeF9tYXhfYnVyc3Q7DQo+ICsJCXU4
IHR4X3Rocl9udW0gPSBkd2MtPnR4X3Rocl9udW1fcGt0Ow0KPiArCQl1OCB0eF9tYXhidXJzdCA9
IGR3Yy0+dHhfbWF4X2J1cnN0Ow0KPiArDQo+ICsJCWlmIChyeF90aHJfbnVtICYmIHJ4X21heGJ1
cnN0KSB7DQo+ICsJCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HUlhUSFJDRkcp
Ow0KPiArCQkJcmVnIHw9IERXQzNfR1JYVEhSQ0ZHX1BLVENOVFNFTDsNCj4gKw0KPiArCQkJcmVn
ICY9IH5EV0MzX0dSWFRIUkNGR19SWFBLVENOVCh+MCk7DQo+ICsJCQlyZWcgfD0gRFdDM19HUlhU
SFJDRkdfUlhQS1RDTlQocnhfdGhyX251bSk7DQo+ICsNCj4gKwkJCXJlZyAmPSB+RFdDM19HUlhU
SFJDRkdfTUFYUlhCVVJTVFNJWkUofjApOw0KPiArCQkJcmVnIHw9IERXQzNfR1JYVEhSQ0ZHX01B
WFJYQlVSU1RTSVpFKHJ4X21heGJ1cnN0KTsNCj4gKw0KPiArCQkJZHdjM193cml0ZWwoZHdjLT5y
ZWdzLCBEV0MzX0dSWFRIUkNGRywgcmVnKTsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmICh0eF90aHJf
bnVtICYmIHR4X21heGJ1cnN0KSB7DQo+ICsJCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywg
RFdDM19HVFhUSFJDRkcpOw0KPiArCQkJcmVnIHw9IERXQzNfR1RYVEhSQ0ZHX1BLVENOVFNFTDsN
Cj4gKw0KPiArCQkJcmVnICY9IH5EV0MzX0dUWFRIUkNGR19UWFBLVENOVCh+MCk7DQo+ICsJCQly
ZWcgfD0gRFdDM19HVFhUSFJDRkdfVFhQS1RDTlQodHhfdGhyX251bSk7DQo+ICsNCj4gKwkJCXJl
ZyAmPSB+RFdDM19HVFhUSFJDRkdfTUFYVFhCVVJTVFNJWkUofjApOw0KPiArCQkJcmVnIHw9IERX
QzNfR1RYVEhSQ0ZHX01BWFRYQlVSU1RTSVpFKHR4X21heGJ1cnN0KTsNCj4gKw0KPiArCQkJZHdj
M193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dUWFRIUkNGRywgcmVnKTsNCj4gKwkJfQ0KPiArCX0N
Cj4gKw0KPiAgCXJldHVybiAwOw0KPiAgDQo+ICBlcnJfcG93ZXJfb2ZmX3BoeToNCj4gQEAgLTEz
ODAsNiArMTQxMywxMCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBk
d2MzICpkd2MpDQo+ICAJdTgJCQlscG1fbnlldF90aHJlc2hvbGQ7DQo+ICAJdTgJCQl0eF9kZV9l
bXBoYXNpczsNCj4gIAl1OAkJCWhpcmRfdGhyZXNob2xkOw0KPiArCXU4CQkJcnhfdGhyX251bV9w
a3QgPSAwOw0KPiArCXU4CQkJcnhfbWF4X2J1cnN0ID0gMDsNCj4gKwl1OAkJCXR4X3Rocl9udW1f
cGt0ID0gMDsNCj4gKwl1OAkJCXR4X21heF9idXJzdCA9IDA7DQo+ICAJdTgJCQlyeF90aHJfbnVt
X3BrdF9wcmQgPSAwOw0KPiAgCXU4CQkJcnhfbWF4X2J1cnN0X3ByZCA9IDA7DQo+ICAJdTgJCQl0
eF90aHJfbnVtX3BrdF9wcmQgPSAwOw0KPiBAQCAtMTQ0Miw2ICsxNDc5LDE0IEBAIHN0YXRpYyB2
b2lkIGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJCQkic25wcyx1
c2IyLWxwbS1kaXNhYmxlIik7DQo+ICAJZHdjLT51c2IyX2dhZGdldF9scG1fZGlzYWJsZSA9IGRl
dmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiAgCQkJCSJzbnBzLHVzYjItZ2FkZ2V0LWxw
bS1kaXNhYmxlIik7DQo+ICsJZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTgoZGV2LCAic25wcyxyeC10
aHItbnVtLXBrdCIsDQo+ICsJCQkJJnJ4X3Rocl9udW1fcGt0KTsNCj4gKwlkZXZpY2VfcHJvcGVy
dHlfcmVhZF91OChkZXYsICJzbnBzLHJ4LW1heC1idXJzdCIsDQo+ICsJCQkJJnJ4X21heF9idXJz
dCk7DQo+ICsJZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTgoZGV2LCAic25wcyx0eC10aHItbnVtLXBr
dCIsDQo+ICsJCQkJJnR4X3Rocl9udW1fcGt0KTsNCj4gKwlkZXZpY2VfcHJvcGVydHlfcmVhZF91
OChkZXYsICJzbnBzLHR4LW1heC1idXJzdCIsDQo+ICsJCQkJJnR4X21heF9idXJzdCk7DQo+ICAJ
ZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTgoZGV2LCAic25wcyxyeC10aHItbnVtLXBrdC1wcmQiLA0K
PiAgCQkJCSZyeF90aHJfbnVtX3BrdF9wcmQpOw0KPiAgCWRldmljZV9wcm9wZXJ0eV9yZWFkX3U4
KGRldiwgInNucHMscngtbWF4LWJ1cnN0LXByZCIsDQo+IEBAIC0xNTIzLDYgKzE1NjgsMTIgQEAg
c3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVydGllcyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgDQo+
ICAJZHdjLT5oaXJkX3RocmVzaG9sZCA9IGhpcmRfdGhyZXNob2xkOw0KPiAgDQo+ICsJZHdjLT5y
eF90aHJfbnVtX3BrdCA9IHJ4X3Rocl9udW1fcGt0Ow0KPiArCWR3Yy0+cnhfbWF4X2J1cnN0ID0g
cnhfbWF4X2J1cnN0Ow0KPiArDQo+ICsJZHdjLT50eF90aHJfbnVtX3BrdCA9IHR4X3Rocl9udW1f
cGt0Ow0KPiArCWR3Yy0+dHhfbWF4X2J1cnN0ID0gdHhfbWF4X2J1cnN0Ow0KPiArDQo+ICAJZHdj
LT5yeF90aHJfbnVtX3BrdF9wcmQgPSByeF90aHJfbnVtX3BrdF9wcmQ7DQo+ICAJZHdjLT5yeF9t
YXhfYnVyc3RfcHJkID0gcnhfbWF4X2J1cnN0X3ByZDsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBh
NjlhYzY3ZDg5ZmUuLjY3ODJlYzhiZmQ2NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTIxMSw2ICsy
MTEsMTEgQEANCj4gICNkZWZpbmUgRFdDM19HUlhUSFJDRkdfUlhQS1RDTlQobikgKCgobikgJiAw
eGYpIDw8IDI0KQ0KPiAgI2RlZmluZSBEV0MzX0dSWFRIUkNGR19QS1RDTlRTRUwgQklUKDI5KQ0K
PiAgDQo+ICsvKiBHbG9iYWwgVFggVGhyZXNob2xkIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgKi8N
Cj4gKyNkZWZpbmUgRFdDM19HVFhUSFJDRkdfTUFYVFhCVVJTVFNJWkUobikgKCgobikgJiAweGZm
KSA8PCAxNikNCj4gKyNkZWZpbmUgRFdDM19HVFhUSFJDRkdfVFhQS1RDTlQobikgKCgobikgJiAw
eGYpIDw8IDI0KQ0KPiArI2RlZmluZSBEV0MzX0dUWFRIUkNGR19QS1RDTlRTRUwgQklUKDI5KQ0K
PiArDQo+ICAvKiBHbG9iYWwgUlggVGhyZXNob2xkIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgZm9y
IERXQ191c2IzMSBvbmx5ICovDQo+ICAjZGVmaW5lIERXQzMxX0dSWFRIUkNGR19NQVhSWEJVUlNU
U0laRShuKQkoKChuKSAmIDB4MWYpIDw8IDE2KQ0KPiAgI2RlZmluZSBEV0MzMV9HUlhUSFJDRkdf
UlhQS1RDTlQobikJCSgoKG4pICYgMHgxZikgPDwgMjEpDQo+IEBAIC0xMDQ1LDYgKzEwNTAsMTAg
QEAgc3RydWN0IGR3YzNfc2NyYXRjaHBhZF9hcnJheSB7DQo+ICAgKiBAdGVzdF9tb2RlX25yOiB0
ZXN0IGZlYXR1cmUgc2VsZWN0b3INCj4gICAqIEBscG1fbnlldF90aHJlc2hvbGQ6IExQTSBOWUVU
IHJlc3BvbnNlIHRocmVzaG9sZA0KPiAgICogQGhpcmRfdGhyZXNob2xkOiBISVJEIHRocmVzaG9s
ZA0KPiArICogQHJ4X3Rocl9udW1fcGt0OiBVU0IgcmVjZWl2ZSBwYWNrZXQgY291bnQNCj4gKyAq
IEByeF9tYXhfYnVyc3Q6IG1heCBVU0IgcmVjZWl2ZSBidXJzdCBzaXplDQo+ICsgKiBAdHhfdGhy
X251bV9wa3Q6IFVTQiB0cmFuc21pdCBwYWNrZXQgY291bnQNCj4gKyAqIEB0eF9tYXhfYnVyc3Q6
IG1heCBVU0IgdHJhbnNtaXQgYnVyc3Qgc2l6ZQ0KPiAgICogQHJ4X3Rocl9udW1fcGt0X3ByZDog
cGVyaW9kaWMgRVNTIHJlY2VpdmUgcGFja2V0IGNvdW50DQo+ICAgKiBAcnhfbWF4X2J1cnN0X3By
ZDogbWF4IHBlcmlvZGljIEVTUyByZWNlaXZlIGJ1cnN0IHNpemUNCj4gICAqIEB0eF90aHJfbnVt
X3BrdF9wcmQ6IHBlcmlvZGljIEVTUyB0cmFuc21pdCBwYWNrZXQgY291bnQNCj4gQEAgLTEyNzMs
NiArMTI4MiwxMCBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJdTgJCQl0ZXN0X21vZGVfbnI7DQo+ICAJ
dTgJCQlscG1fbnlldF90aHJlc2hvbGQ7DQo+ICAJdTgJCQloaXJkX3RocmVzaG9sZDsNCj4gKwl1
OAkJCXJ4X3Rocl9udW1fcGt0Ow0KPiArCXU4CQkJcnhfbWF4X2J1cnN0Ow0KPiArCXU4CQkJdHhf
dGhyX251bV9wa3Q7DQo+ICsJdTgJCQl0eF9tYXhfYnVyc3Q7DQo+ICAJdTgJCQlyeF90aHJfbnVt
X3BrdF9wcmQ7DQo+ICAJdTgJCQlyeF9tYXhfYnVyc3RfcHJkOw0KPiAgCXU4CQkJdHhfdGhyX251
bV9wa3RfcHJkOw0KPiAtLSANCj4gMi4zNC4xDQo+IA==
