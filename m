Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704A68001C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376830AbjLACud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLACub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:50:31 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5321707;
        Thu, 30 Nov 2023 18:50:37 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUM3teZ019857;
        Thu, 30 Nov 2023 18:49:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=/HvGv84aExLIDkDEnmk6PRnrqEpWsqCofiYBJo1q6gQ=;
 b=MUidGU7OSTHwiQnQwzGP2zjpA7WPVY2QCvoeZfNvTZf/n8vRkCI3m2u8RUAdukpgnoAT
 +IpJqSS62RsdstRdSOv/Xcd4Q/eDtsOSkzLDyNgmE46+rYB8CfVbPVljCqeo3y99Ntbe
 KjOJCx3Uif3GtOk19VMnazd8wZYU71STHzEB+0rlr4bbPkVC6A2IXkHR+BCwSbN8ek+h
 8yewX3sZcBtIiNJzx9wpy1vr/yWrVrVa1y0+ukp1CXQwonxEExosJh+OYxDYzV8fMo7n
 JnH2r5TiU3e8w8xzz6v4pb6Jddx9D365Pk2N26NESU2LZWdq5Kxcv/eDJMJglD2S2iPU FA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3ukgemhvrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 18:49:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701398993; bh=/HvGv84aExLIDkDEnmk6PRnrqEpWsqCofiYBJo1q6gQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FUj3tMRmh9I5L22XOfwStq1G7vrIh2quNR3g78xtTqb1M0Jleg5Aau8di995Pc7lf
         FRQ3df+CMC7qh7Lp6+lV2YZxQ82QL4H6zepbVGGJVj78KpuBEsQSI6Ty8J1TgPWpd7
         kGPDCN3UIQTt397yAeo7s1bQbLvp87YYEKEUaN0vG8Tme+8cuXHLZYgz3myF4rMN1h
         +OU1eRMImSfhoa3y3Hsz+pZFrb91/+bmE5aOK6mlCx1ThXjTltge7sM8WAaJwTFX3i
         cmooqDltiE0+d7ksSeIYCqDh5ckTgAKrPSAb91NJps359AEFgNQgJlML5AEqt7AuXl
         5lIUMg9r/bNOw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 57C2940408;
        Fri,  1 Dec 2023 02:49:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C13C6A0085;
        Fri,  1 Dec 2023 02:49:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=o2H0Vr44;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 943004041E;
        Fri,  1 Dec 2023 02:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCkncV6/jkcXFeRtjyuywi/DZ7UDP7EUD5kfWgH5+gQ2TeA6g5OvyL8JXfHLfiFwOF075fQI9aDMJGNtpZN7x6nlfNDGXl7OD5C5WJG1SLI76BMUu8ELLcK2mfujT+BZF4OQeArQbrDBDusdC5lIrDeHWW0DHuHqK5RyPr23sR/BpV/9bTHHSAgnuk9tHn80Z2ML6zlvQLW89APgaV3lkgszmJjjTXexGhy57GIEX/N+ysGEHiVVHxe2yE5Au3YMJizaRSJ3Ya60zDBvCOky4G1uNhrZLI5kFCkQqdKhHf1dafgB0rgV51KEtoRLKd5aYTj3fx5mAyKiE/o4bWZ9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HvGv84aExLIDkDEnmk6PRnrqEpWsqCofiYBJo1q6gQ=;
 b=ZRq7wERZJrf25+BO7KgvUQTyzUidzmE89rQxdbelq2RxP06o9wPPxvJ8NWDv8b6qFzQ7VhYkRn/aFhyZ+b7FZVCno1ywmaJpH1GedhimNTysJsVnipIAYXZMky9JGbkBD82UtKZzv0+em0IBq1K+ZVlbTSRpOE0PtChDcYP4Rsa2rwYvErfy2f2ZptsthRBCke9ji7PVJvGYhgpUj2k0mwpwY4pTUhi0AuPSNdp5SfjFqV/2DrC9hSQXFK4V+b/lxR1DoKNsVySGW18oS4vUqTf31fLJi/c+RLWhjUa37iw2oiANvomuhWNNHR7i51wokzWcrXjlrNTuhUoNy7Fnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HvGv84aExLIDkDEnmk6PRnrqEpWsqCofiYBJo1q6gQ=;
 b=o2H0Vr44y/2R+D5tEb2yk82dv27AIyT0OHuiUkjZqTJ/WOt8kDabOhWulLj/OF4BwgQtI0Mdvmeto1SdXw39ttIvXmV1A7o9kAeTXPn1qlQIfrDVJfQrooLigdgodsQdM2a/g2x8j6YjztfzLFk/7+O45qHqzgM2SCoutktgvR8=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 02:49:40 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7046.023; Fri, 1 Dec 2023
 02:49:40 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Johannes Zink <j.zink@pengutronix.de>,
        "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: RE: [PATCH v3] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH v3] net: stmmac: fix FPE events losing
Thread-Index: AdohvweHzQycQ8B4Tb64fZ2hsahwgwBtFToAAAbG8YAAAhhLAAAAJRuAABpKexA=
Date:   Fri, 1 Dec 2023 02:49:40 +0000
Message-ID: <CY5PR12MB6372746BBD8D1EA18E5B52E4BF81A@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB6372BF02C49FC9E628D0EC02BFBCA@CY5PR12MB6372.namprd12.prod.outlook.com>
         <1716792a3881338b1a416b1f4dd85a9437746ec2.camel@redhat.com>
         <5djt72m664jtskz4i7vu63cqpb67o4qeu2roqb6322slsypwos@vmf4n2emdazd>
         <081b3aab0c9350a42fdb69149b563c7aef4af0d5.camel@redhat.com>
 <1a47789d8b56370989f469aa5508738eabb1f798.camel@redhat.com>
In-Reply-To: <1a47789d8b56370989f469aa5508738eabb1f798.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|SA1PR12MB8985:EE_
x-ms-office365-filtering-correlation-id: b7d02829-f307-4988-2ccc-08dbf2182a17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVCI36wLuj0yKfScBgNGe6x/2neoVVCctp37LlCr9spb1ctJ5r+qjg0IpXCPncBX8aUamxs27Sdl0XfYbVkFgKsMeejjRITZcpfdrQiekCb/AQlTywCY27zIa8gUKSMr14HQScFpXriEi13wIvh17JAWZrpA7xlG8zf9IbEF0Qqe1Y1bqXEN+62/36w6W0Su91IReXcxu4ZjXJgiMFVXBVmuGV8g8e44CiAEdKweHIRrM2cwHoLsjr42n4gJ1j4lYvA5V/OIaUj7hmgM9eGr/EhHRsE2OLfcAgKIOga/3lklVg1Y7+6CeToXo0zejtyIXwwigNlc1dOELF4vIt1QqyrdwCsftNKpz1o8LTvsK7lRXgohoMrapN8JpYLK2kbq6qpkN0gF8znUPi0+HKDFxjCHi5zGaUpBGrki0ElL00aklNrgtyC1/Xac7yamRZnqhU9VXQR7gPhn5OOoRUsBtOe7EtEy55gfhW6WRHPB26CujLC/1ESngPndwGN2joi6npmuOzxS0RkRYHU5lQbl+A1aJu8oF7zpu8ZCvvCGcdTSs23ytBi3XObiDz9JARMRrq3BbV9Z7vFaQ04mPgrCeXpWSvBlUUno9lIjdbcemezhQJxdb4e27kMHwaybX4JV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(83380400001)(6506007)(26005)(66574015)(9686003)(53546011)(7696005)(107886003)(4001150100001)(478600001)(7416002)(8936002)(5660300002)(8676002)(52536014)(41300700001)(2906002)(110136005)(4326008)(66556008)(316002)(66946007)(64756008)(71200400001)(66476007)(66446008)(76116006)(122000001)(54906003)(38100700002)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmVlNGZmMkx1ZFpFQndMWlIxYVhXbWNyM1lKNnYyS045c2dYNFd3VDRiMkNZ?=
 =?utf-8?B?d3dvRmU2b1JsdWxZb2RKZ1RGUldjRHAzYWJ4c3RhMFI2YkVIa29sZVNaWjhR?=
 =?utf-8?B?RFJmRjFCNzBtZTRybSthalcvV01zRHhIVzdBZVVnRG5waGNhNXJIQTgwK3Bo?=
 =?utf-8?B?c3NKd2JUZFVyeWtCUmhaRjQrdjRGRXRqYU9KRXpJOGUreHRIWi9xMElpeW9x?=
 =?utf-8?B?d3JHNDdHdi82b05BaGxxUCt2cTZYa2xiSXZNWElUVVRZb3E2VkhjOTlhRDN5?=
 =?utf-8?B?cHFyOUVqeFp5dHVhSGkyUkxwTUJpWVVBT1phODlDc3hMNWgzek1ObGdrL0JY?=
 =?utf-8?B?ZkdldVpWLy83YzdtanFlYzFQR2tIYlJTN3p1ZGVyZi96Y3BCSGE4bkxVNjVX?=
 =?utf-8?B?QmZWVjQvamhVRXNlMjBlRkJhejV5cXdVT0ZBNHFnRzh6SjBXNVhpZU16Vmhp?=
 =?utf-8?B?dTN1dEJkSVpObTVPcUJrNVFFYmVYd3Y0TnJ4SHVCNUZha1ovMThHZGtXUkwy?=
 =?utf-8?B?NmIxY0xvM202Y09QSmlwMDR1UWs4R1dCWjFGV213R3ZwdjJOTXQ2ay9qbk5y?=
 =?utf-8?B?cURLSEQ5bVU2UGRucXpUSzJhY0pQcWtCTGMybE4zdUErRWZORGpMZ1g2RVo2?=
 =?utf-8?B?Ym84bEk2VFAyRjVRVzdqUVluQ0VvYnVPTGVTckkyMk9Jenp3MHlLbE1HUFBq?=
 =?utf-8?B?SnRpODJtdllnbUdPdUhYcFZhTURoVDFvT0JEaGpMY0hNWEFvN3lSemtBM1Fx?=
 =?utf-8?B?bEVoSjZMNDVnMWNyeE4zclkxaFAzU0prcHorWDVUZVluR3VFLzk3N0JuZ1B1?=
 =?utf-8?B?MFBJMlpaVWZwYzQ1MzBZdFhubkYzc0FBNUxBTk93WTlHaUFlYzNWTUhXVnhz?=
 =?utf-8?B?ZnA2QTl3Vktod1dGYk1EbWJOeEpMbG9DaFdENE9HVDNETEloa2FGQ0p4d3Zh?=
 =?utf-8?B?dXRUbTlUeWF5RThFbzh1eng5K3FFeGV0WFo1bHBxZngycU9hdHovR0lxd1Rq?=
 =?utf-8?B?Mm9IOHFGNjJ5WnJkcDV3TkM4SW5CWUxoeTFrQ1dUa21yRXJjYjBsbHR1bUZR?=
 =?utf-8?B?b2NZaHZYd1BXR2VncnVHdkM5bHljWGJjQ2wwTmxVTjRXMlhNbURmcTgzUFRE?=
 =?utf-8?B?RHgxYTFxUWJNZWhNQS9iMTVFOTJibXJIRFFpOGR0VWZ2RDVha0IyUVhZNUpm?=
 =?utf-8?B?NXRrcThkMy9HakhIOFlYSTVIWjJwTU9IZThuWjZnUkxvMWZaL3hlWHJZMDFi?=
 =?utf-8?B?clVNMW9HNk1oenk5OEI5UmVncnoxVmo4SzlWcG8zRU1zMURFbWNsdnNpaitH?=
 =?utf-8?B?cExiUXRUL3RCL3lRMHBFRUNsdFNESTdtTTdxeTg2Z1lrdFk0aFRyMldzMEpF?=
 =?utf-8?B?R3NtOENaOVM4L2kxQkRDcW1YQjdBazVpTnVHKzU5bVIvbHk1b0FHRGxSTzkv?=
 =?utf-8?B?TTNUcEtOMm5LeXpMUytJVHozWVRwOTQyRmx6SWxScThPTTVId2lOV1lQaTVy?=
 =?utf-8?B?Wkx2MFJwREdQS3NGZWhpRDJnWWo5eWczWGFDR3hrVlZiK0dPWGtvdGZvZU5P?=
 =?utf-8?B?ZGJhVkczRWRFZW85SDkzOFkyblpCdXJJNlQzQU5TUUoySnFNWjIwVzZHN2hJ?=
 =?utf-8?B?TDFQQmV0SVBEY0RTWDlnVGdPV0JETEMxaFR3cC9OS3Z4UUZvZmEvNEhFYkIw?=
 =?utf-8?B?TXFyaUVON0VBZU9WL2tidC9WakNNcTJTWmh3OHpyajk5Y2w1SlZySWRmdkxu?=
 =?utf-8?B?OGFJNERJWWxhL3RFNm1YTGUrazNtcW50ZzNhd2ZFU3NQeUtPN2drZ0d2R1Fw?=
 =?utf-8?B?TDgwenpJdlIvbHRYbmxxTzhJaWhrMG5MbVc2Uy81MmdlamVXWG0zZ1FkbVNG?=
 =?utf-8?B?a2tvbzNUZ1djTE8wVUlmZ3dpajU3Z000SGJaMk9oMGF5bkxqU3JSZjRxdjIy?=
 =?utf-8?B?eEdBQWlFOVM4clZBbUI4MXB2YTNaUThjcUtYUzJISVNJRlZreEhjeEFDVEQy?=
 =?utf-8?B?aDROWERMdWNKMm1qRkZ0L1RLNldPM3RWVHFGTHpoa3lsMUZCK1hySFIvWEw3?=
 =?utf-8?B?eG5ZTnoyeXBDaTd4WXFtVmxGMUwvSUVZMlhZUTdaRGpxdFJyQ3ZDL09tbXRz?=
 =?utf-8?Q?hiD5QQjGQ0lxnlRmeMFehHOni?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NzFzWEZ6WkdCcU9iT0o3SkNHSmF2TWpBV3M5WDJPRklkZ2F1d0pQRldMa3ow?=
 =?utf-8?B?bW9XdkNoMDZGYllTYWV4RE1ZM3Q1SVpvR3V6UzZldDIyZVJCbXpxV0VyRGM0?=
 =?utf-8?B?Y0kvWEhia00xWVNmZ2JVVGhHMVlWVUFwdTg1YU9nUGdWd2w5UnZKc2JPUW02?=
 =?utf-8?B?aFB5UE54Z1NVclQ4STVTQWlCNXQ4R0syaGU3V2RxckZtSlpVU1NPYVdTNFpi?=
 =?utf-8?B?Ykx2Umg1OFViOFRpNUh0TTNVWmk3SXQ0bGxBcjV1N2Z4Q0ZtQXNKMDViMGN0?=
 =?utf-8?B?RzFjT05ZTkR2alR0NWdhNHFJdDlGdHhqay9HTU4vQzRDWGptSDZhb2RlK3E3?=
 =?utf-8?B?ajd5Yzh0VmNTcEFucUhRMVFYNzBkYlFyTGpDa3NhREdrc2xMazYvWlZSdDlh?=
 =?utf-8?B?RysrMStuZVJpT2ZidHliNm9Nd2c5QnJqNUcydmJsUkZSTmovS3ZVYndoSHNP?=
 =?utf-8?B?Y21oUzNsNmFMRFIvVHp4NXNOaW91aURnNmE4S1owSStOZDlmK082YkhiZ1Iv?=
 =?utf-8?B?VUZUVy96eWQ5SVNlMER0RlBVWUFGQytob3l1OXBGNHpEMzlDTWYvK0diUzFW?=
 =?utf-8?B?YnFWcDdVRkJiU2RyZmx3NklBd3Awa056TUo3MlJ6RDRsNmY3QS94WXVPZ0g1?=
 =?utf-8?B?ajJGWXNkd2hEOFpLVUR5SHVHWkhFVFZEWnRLUHhBSmFoK1h0K1k5dHJhNTAy?=
 =?utf-8?B?TDVTNkRxd0xxbk1DMjBoVGVHM2lDb3hQOGRBdUx0NUlYYU9HZVZMc1JWQUNv?=
 =?utf-8?B?d2NmaHoyTVJ1N2lld0h6WDlod1JsSnlYU0dyTkhtcGJlbWNqbFR1bWdXMjQz?=
 =?utf-8?B?ZmJKcG0wdlczSkE0dDcrTk5xbEZnRVhKUTB1RTNSMVluV1BEditDZFZ1Wm1W?=
 =?utf-8?B?K2E4M2ZiSUNXYmJ0TnlpS01xOXZseG10dEJwZ3JmRkMvV2YybWpFYjFWSHVa?=
 =?utf-8?B?SDAwOTlSUDltQlhBUVJPZTZNK2NPbkdEeTRZWFc0dUc3aWJScFRDRm1xaE5T?=
 =?utf-8?B?N1E1dlVJeFdjOUV2M21oS2pCU0o4STVYVWw5bzJscFdWYjlqeUJMbmpMWHpP?=
 =?utf-8?B?bWFnQTdZbTZ4NFEyL1dETFQzcDJFYXBPWURyK1luQmhOdlR2emE2aEVoMkZk?=
 =?utf-8?B?bHArZFpmZ0xLdHB1N3RNN1J5UEJLcHFxOFJPUk4xb1BTR052dnpkZlhPcmdL?=
 =?utf-8?B?cEthdkFWRmJ1K25TL0JaQ0dScFR3d0UyWW9pMDNHa0Zna1d6Uk5UNGhhc0hM?=
 =?utf-8?B?QUtZclB4M051b1psd2o1WlM1YTZoTU5IVEx5dFc5WFp4MkUxbWdXZm9aTlU4?=
 =?utf-8?B?ZlE5UjJEbTJaK01RR1BhNHNwbEJ5WU5ZMURZejgrdHJtV0dBbmRJUDlKQnph?=
 =?utf-8?B?U2o2Uy9vSEtZb1IzSXRqdFh4bnN2VmgzNDNJOTFJSWp4V3hTWXVDZzZwdk1y?=
 =?utf-8?B?bzBLRkJDOXlSNlBlbXJEdHptNmhjR3Z5UzFraGJIZ2c5dUFCcE11M2FDU2J0?=
 =?utf-8?B?akVYWS9BMG56M3BlUklCd1NDSHV6S2V4UWpub3BNdFZXaWRQT05ER0QyZnpU?=
 =?utf-8?B?ZEE1MmVjcWlMbWYwYjMzRGVxaHhaVnFpVjFTMDI1Z29tSWRhL3psdUdLRFpI?=
 =?utf-8?B?UHJVWmpBSENlUEJCc3NIdnRPQXIyYUJiYkQ1akxCQjdPRm42TUEzZVFQRzBW?=
 =?utf-8?B?OTU0NXdRcnA0bUFKUEFHZ0ZvbGpWRFVWd1djVk9zOGhZR2NzS0xycmxmMldz?=
 =?utf-8?B?MkRzdjlXTUlNWGhnMnBKMTdEQnp3VGlTOHNsT0dVNENqdXh3NGIzc1ppZCtw?=
 =?utf-8?B?UTVWeTUxaUpNUEJxSUN1UT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d02829-f307-4988-2ccc-08dbf2182a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 02:49:40.1998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T169yJagWpI2OA/InYCKcLorwPP8MEiM4rkjG+mdgDSRS5tXpCHMRkTSWGVbHbUezXZoJCdbHmXIn7h0Vk3ZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985
X-Proofpoint-ORIG-GUID: v4kbOyeKvz-Aiai818KDQbY24jS7gfB0
X-Proofpoint-GUID: v4kbOyeKvz-Aiai818KDQbY24jS7gfB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_25,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDMwLCAyMDIzIDEwOjE0
IFBNDQo+IFRvOiBTZXJnZSBTZW1pbiA8ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+DQo+IENjOiBK
aWFuaGVuZyBaaGFuZyA8amlhbmhlbmdAc3lub3BzeXMuY29tPjsgQWxleGFuZHJlIFRvcmd1ZSA8
YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT47IEpvc2UNCj4gQWJyZXUgPGpvYWJyZXVAc3lu
b3BzeXMuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBE
dW1hemV0DQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2Vy
bmVsLm9yZz47IE1heGltZSBDb3F1ZWxpbg0KPiA8bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47
IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47IEFuZHJldyBIYWxhbmV5DQo+IDxhaGFs
YW5leUByZWRoYXQuY29tPjsgQmFydG9zeiBHb2xhc3pld3NraSA8YmFydG9zei5nb2xhc3pld3Nr
aUBsaW5hcm8ub3JnPjsgU2hlbndlaSBXYW5nDQo+IDxzaGVud2VpLndhbmdAbnhwLmNvbT47IEpv
aGFubmVzIFppbmsgPGouemlua0BwZW5ndXRyb25peC5kZT47IFJ1c3NlbGwgS2luZyAoT3JhY2xl
DQo+IDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az47IEpvY2hlbiBIZW5uZWJlcmcgPGpoQGhl
bm5lYmVyZy1zeXN0ZW1kZXNpZ24uY29tPjsgVm9vbiBXZWlmZW5nDQo+IDx3ZWlmZW5nLnZvb25A
aW50ZWwuY29tPjsgTW9oYW1tYWQgQXRoYXJpIEJpbiBJc21haWwgPG1vaGFtbWFkLmF0aGFyaS5p
c21haWxAaW50ZWwuY29tPjsgT25nDQo+IEJvb24gTGVvbmcgPGJvb24ubGVvbmcub25nQGludGVs
LmNvbT47IFRhbiBUZWUgTWluIDx0ZWUubWluLnRhbkBpbnRlbC5jb20+OyBvcGVuIGxpc3Q6U1RN
TUFDDQo+IEVUSEVSTkVUIERSSVZFUiA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IG1vZGVyYXRl
ZCBsaXN0OkFSTS9TVE0zMiBBUkNISVRFQ1RVUkUNCj4gPGxpbnV4LXN0bTMyQHN0LW1kLW1haWxt
YW4uc3Rvcm1yZXBseS5jb20+OyBtb2RlcmF0ZWQgbGlzdDpBUk0vU1RNMzIgQVJDSElURUNUVVJF
DQo+IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBvcGVuIGxpc3QgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBKYW1lcyBMaQ0KPiA8bGlqYW1lc0BzeW5vcHN5
cy5jb20+OyBNYXJ0aW4gTWNLZW5ueSA8bW1ja2VubnlAc3lub3BzeXMuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzXSBuZXQ6IHN0bW1hYzogZml4IEZQRSBldmVudHMgbG9zaW5nDQo+IA0K
PiBPbiBUaHUsIDIwMjMtMTEtMzAgYXQgMTU6MDkgKzAxMDAsIFBhb2xvIEFiZW5pIHdyb3RlOg0K
PiA+IE9uIFRodSwgMjAyMy0xMS0zMCBhdCAxNjowOSArMDMwMCwgU2VyZ2UgU2VtaW4gd3JvdGU6
DQo+ID4gPiBIaSBQYW9sbw0KPiA+ID4NCj4gPiA+IE9uIFRodSwgTm92IDMwLCAyMDIzIGF0IDEw
OjU1OjM0QU0gKzAxMDAsIFBhb2xvIEFiZW5pIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIDIwMjMt
MTEtMjggYXQgMDU6NTYgKzAwMDAsIEppYW5oZW5nIFpoYW5nIHdyb3RlOg0KPiA+ID4gPiA+IFRo
ZSBzdGF0dXMgYml0cyBvZiByZWdpc3RlciBNQUNfRlBFX0NUUkxfU1RTIGFyZSBjbGVhciBvbiBy
ZWFkLiBVc2luZw0KPiA+ID4gPiA+IDMyLWJpdCByZWFkIGZvciBNQUNfRlBFX0NUUkxfU1RTIGlu
IGR3bWFjNV9mcGVfY29uZmlndXJlKCkgYW5kDQo+ID4gPiA+ID4gZHdtYWM1X2ZwZV9zZW5kX21w
YWNrZXQoKSBjbGVhciB0aGUgc3RhdHVzIGJpdHMuIFRoZW4gdGhlIHN0bW1hYyBpbnRlcnJ1cHQN
Cj4gPiA+ID4gPiBoYW5kbGVyIG1pc3NpbmcgRlBFIGV2ZW50IHN0YXR1cyBhbmQgbGVhZHMgdG8g
RlBFIGhhbmRzaGFraW5nIGZhaWx1cmUgYW5kDQo+ID4gPiA+ID4gcmV0cmllcy4NCj4gPiA+ID4g
PiBUbyBhdm9pZCBjbGVhciBzdGF0dXMgYml0cyBvZiBNQUNfRlBFX0NUUkxfU1RTIGluIGR3bWFj
NV9mcGVfY29uZmlndXJlKCkNCj4gPiA+ID4gPiBhbmQgZHdtYWM1X2ZwZV9zZW5kX21wYWNrZXQo
KSwgYWRkIGZwZV9jc3IgdG8gc3RtbWFjX2ZwZV9jZmcgc3RydWN0dXJlIHRvDQo+ID4gPiA+ID4g
Y2FjaGUgdGhlIGNvbnRyb2wgYml0cyBvZiBNQUNfRlBFX0NUUkxfU1RTIGFuZCB0byBhdm9pZCBy
ZWFkaW5nDQo+ID4gPiA+ID4gTUFDX0ZQRV9DVFJMX1NUUyBpbiB0aG9zZSBtZXRob2RzLg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gRml4ZXM6IDVhNTU4NjExMmI5MiAoIm5ldDogc3RtbWFjOiBzdXBw
b3J0IEZQRSBsaW5rIHBhcnRuZXIgaGFuZC1zaGFraW5nIHByb2NlZHVyZSIpDQo+ID4gPiA+ID4g
UmV2aWV3ZWQtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT4NCj4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFuaGVuZyBaaGFuZyA8amlhbmhlbmdAc3lub3BzeXMuY29t
Pg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3Jv
L3N0bW1hYy9kd21hYzUuYyAgICAgICB8IDQ1ICsrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiA+
ID4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWM1LmggICAgICAg
fCAgNCArLQ0KPiA+ID4gPiA+ICAuLi4vbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3eGdt
YWMyX2NvcmUuYyAgICB8ICAzICstDQo+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0
bWljcm8vc3RtbWFjL2h3aWYuaCAgICAgICAgIHwgIDQgKy0NCj4gPiA+ID4gPiAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4uYyAgfCAgOCArKystDQo+ID4g
PiA+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY190Yy5jICAg
IHwgIDEgKw0KPiA+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L3N0bW1hYy5oICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxICsNCj4gPiA+ID4gPiAgNyBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNl
cnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYzUuYw0KPiBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjNS5jDQo+ID4gPiA+ID4gaW5k
ZXggZTk1ZDM1Zi4uOGZkMTY3NSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYzUuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjNS5jDQo+ID4gPiA+ID4gQEAgLTcxMCwy
OCArNzEwLDIyIEBAIHZvaWQgZHdtYWM1X2VzdF9pcnFfc3RhdHVzKHZvaWQgX19pb21lbSAqaW9h
ZGRyLCBzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqZGV2LA0KPiA+ID4gPiA+ICAJfQ0KPiA+ID4gPiA+
ICB9DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtdm9pZCBkd21hYzVfZnBlX2NvbmZpZ3VyZSh2b2lk
IF9faW9tZW0gKmlvYWRkciwgdTMyIG51bV90eHEsIHUzMiBudW1fcnhxLA0KPiA+ID4gPiA+ICt2
b2lkIGR3bWFjNV9mcGVfY29uZmlndXJlKHZvaWQgX19pb21lbSAqaW9hZGRyLCBzdHJ1Y3Qgc3Rt
bWFjX2ZwZV9jZmcgKmNmZywNCj4gPiA+ID4gPiArCQkJICB1MzIgbnVtX3R4cSwgdTMyIG51bV9y
eHEsDQo+ID4gPiA+ID4gIAkJCSAgYm9vbCBlbmFibGUpDQo+ID4gPiA+ID4gIHsNCj4gPiA+ID4g
PiAgCXUzMiB2YWx1ZTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0JaWYgKCFlbmFibGUpIHsNCj4g
PiA+ID4gPiAtCQl2YWx1ZSA9IHJlYWRsKGlvYWRkciArIE1BQ19GUEVfQ1RSTF9TVFMpOw0KPiA+
ID4gPiA+IC0NCj4gPiA+ID4gPiAtCQl2YWx1ZSAmPSB+RUZQRTsNCj4gPiA+ID4gPiAtDQo+ID4g
PiA+ID4gLQkJd3JpdGVsKHZhbHVlLCBpb2FkZHIgKyBNQUNfRlBFX0NUUkxfU1RTKTsNCj4gPiA+
ID4gPiAtCQlyZXR1cm47DQo+ID4gPiA+ID4gKwlpZiAoZW5hYmxlKSB7DQo+ID4gPiA+ID4gKwkJ
Y2ZnLT5mcGVfY3NyID0gRUZQRTsNCj4gPiA+ID4gPiArCQl2YWx1ZSA9IHJlYWRsKGlvYWRkciAr
IEdNQUNfUlhRX0NUUkwxKTsNCj4gPiA+ID4gPiArCQl2YWx1ZSAmPSB+R01BQ19SWFFDVFJMX0ZQ
UlE7DQo+ID4gPiA+ID4gKwkJdmFsdWUgfD0gKG51bV9yeHEgLSAxKSA8PCBHTUFDX1JYUUNUUkxf
RlBSUV9TSElGVDsNCj4gPiA+ID4gPiArCQl3cml0ZWwodmFsdWUsIGlvYWRkciArIEdNQUNfUlhR
X0NUUkwxKTsNCj4gPiA+ID4gPiArCX0gZWxzZSB7DQo+ID4gPiA+ID4gKwkJY2ZnLT5mcGVfY3Ny
ID0gMDsNCj4gPiA+ID4gPiAgCX0NCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gLQl2YWx1ZSA9IHJl
YWRsKGlvYWRkciArIEdNQUNfUlhRX0NUUkwxKTsNCj4gPiA+ID4gPiAtCXZhbHVlICY9IH5HTUFD
X1JYUUNUUkxfRlBSUTsNCj4gPiA+ID4gPiAtCXZhbHVlIHw9IChudW1fcnhxIC0gMSkgPDwgR01B
Q19SWFFDVFJMX0ZQUlFfU0hJRlQ7DQo+ID4gPiA+ID4gLQl3cml0ZWwodmFsdWUsIGlvYWRkciAr
IEdNQUNfUlhRX0NUUkwxKTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gLQl2YWx1ZSA9IHJlYWRs
KGlvYWRkciArIE1BQ19GUEVfQ1RSTF9TVFMpOw0KPiA+ID4gPiA+IC0JdmFsdWUgfD0gRUZQRTsN
Cj4gPiA+ID4gPiAtCXdyaXRlbCh2YWx1ZSwgaW9hZGRyICsgTUFDX0ZQRV9DVFJMX1NUUyk7DQo+
ID4gPiA+ID4gKwl3cml0ZWwoY2ZnLT5mcGVfY3NyLCBpb2FkZHIgKyBNQUNfRlBFX0NUUkxfU1RT
KTsNCj4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIGludCBkd21hYzVfZnBlX2ly
cV9zdGF0dXModm9pZCBfX2lvbWVtICppb2FkZHIsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+
ID4gPiA+ID4gQEAgLTc0MSw2ICs3MzUsOSBAQCBpbnQgZHdtYWM1X2ZwZV9pcnFfc3RhdHVzKHZv
aWQgX19pb21lbSAqaW9hZGRyLCBzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqZGV2KQ0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gIAlzdGF0dXMgPSBGUEVfRVZFTlRfVU5LTk9XTjsNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+ICsJLyogUmVhZHMgZnJvbSB0aGUgTUFDX0ZQRV9DVFJMX1NUUyByZWdpc3RlciBzaG91
bGQgb25seSBiZSBwZXJmb3JtZWQNCj4gPiA+ID4gPiArCSAqIGhlcmUsIHNpbmNlIHRoZSBzdGF0
dXMgZmxhZ3Mgb2YgTUFDX0ZQRV9DVFJMX1NUUyBhcmUgImNsZWFyIG9uIHJlYWQiDQo+ID4gPiA+
ID4gKwkgKi8NCj4gPiA+ID4gPiAgCXZhbHVlID0gcmVhZGwoaW9hZGRyICsgTUFDX0ZQRV9DVFJM
X1NUUyk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgCWlmICh2YWx1ZSAmIFRSU1ApIHsNCj4gPiA+
ID4gPiBAQCAtNzY2LDE5ICs3NjMsMTUgQEAgaW50IGR3bWFjNV9mcGVfaXJxX3N0YXR1cyh2b2lk
IF9faW9tZW0gKmlvYWRkciwgc3RydWN0IG5ldF9kZXZpY2UNCj4gKmRldikNCj4gPiA+ID4gPiAg
CXJldHVybiBzdGF0dXM7DQo+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC12b2lk
IGR3bWFjNV9mcGVfc2VuZF9tcGFja2V0KHZvaWQgX19pb21lbSAqaW9hZGRyLCBlbnVtIHN0bW1h
Y19tcGFja2V0X3R5cGUgdHlwZSkNCj4gPiA+ID4gPiArdm9pZCBkd21hYzVfZnBlX3NlbmRfbXBh
Y2tldCh2b2lkIF9faW9tZW0gKmlvYWRkciwgc3RydWN0IHN0bW1hY19mcGVfY2ZnICpjZmcsDQo+
ID4gPiA+ID4gKwkJCSAgICAgZW51bSBzdG1tYWNfbXBhY2tldF90eXBlIHR5cGUpDQo+ID4gPiA+
ID4gIHsNCj4gPiA+ID4gPiAtCXUzMiB2YWx1ZTsNCj4gPiA+ID4gPiArCXUzMiB2YWx1ZSA9IGNm
Zy0+ZnBlX2NzcjsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0JdmFsdWUgPSByZWFkbChpb2FkZHIg
KyBNQUNfRlBFX0NUUkxfU1RTKTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gLQlpZiAodHlwZSA9
PSBNUEFDS0VUX1ZFUklGWSkgew0KPiA+ID4gPiA+IC0JCXZhbHVlICY9IH5TUlNQOw0KPiA+ID4g
PiA+ICsJaWYgKHR5cGUgPT0gTVBBQ0tFVF9WRVJJRlkpDQo+ID4gPiA+ID4gIAkJdmFsdWUgfD0g
U1ZFUjsNCj4gPiA+ID4gPiAtCX0gZWxzZSB7DQo+ID4gPiA+ID4gLQkJdmFsdWUgJj0gflNWRVI7
DQo+ID4gPiA+ID4gKwllbHNlIGlmICh0eXBlID09IE1QQUNLRVRfUkVTUE9OU0UpDQo+ID4gPiA+
ID4gIAkJdmFsdWUgfD0gU1JTUDsNCj4gPiA+ID4gPiAtCX0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ICAJd3JpdGVsKHZhbHVlLCBpb2FkZHIgKyBNQUNfRlBFX0NUUkxfU1RTKTsNCj4gPiA+ID4gPiAg
fQ0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+ID4gSXQncyB1bmNsZWFyIHRvIG1lIHdoeSBpdCdzIG5v
dCBuZWNlc3NhcnkgdG8gcHJlc2VydmUgdGhlIFNWRVIvU1JTUA0KPiA+ID4gPiBiaXRzIGFjcm9z
cyBNQUNfRlBFX0NUUkxfU1RTIHdyaXRlcy4gSSBndWVzcyB0aGV5IGFyZSBub3QgcGFydCBvZiB0
aGUNCj4gPiA+ID4gc3RhdHVzIGJpdHM/IHBlcmhhcHMgYW4gZXhwbGljaXQgY29tbWVudCBzb21l
d2hlcmUgd2lsbCBoZWxwPw0KPiA+ID4NCj4gPiA+IFRoZSBTUlNQIGFuZCBTVkVSIGFyZSBzZWxm
LWNsZWFyZWQgZmxhZ3Mgd2l0aCBubyBlZmZlY3Qgb24gemVybw0KPiA+ID4gd3JpdGluZy4gVGhl
aXIgcmVzcG9uc2liaWxpdHkgaXMgdG8gZW1pdCB0aGUgUmVzcG9uZCBhbmQgVmVyaWZ5DQo+ID4g
PiBtUGFja2V0cyByZXNwZWN0aXZlbHkuIEFzIHNvb24gYXMgdGhlIHBhY2tldHMgYXJlIHNlbnQs
IHRoZSBmbGFncyB3aWxsDQo+ID4gPiBiZSByZXNldCBieSBoYXJkd2FyZSBhdXRvbWF0aWNhbGx5
LiBTbyBubywgdGhleSBhcmVuJ3QgYSBwYXJ0IG9mIHRoZQ0KPiA+ID4gc3RhdHVzIGJpdHMuDQo+
ID4gPg0KPiA+ID4gTm90ZSBzaW5jZSAndmFsdWUnIG5vdyBpc24ndCByZWFkIGZyb20gdGhlIE1B
Q19GUEVfQ1RSTF9TVFMgcmVnaXN0ZXIsDQo+ID4gPiB0aGVyZSBpcyBubyBwb2ludCBpbiBjbGVh
cmluZyB1cCB0aGVzZSBmbGFncyBpbiB0aGUgbG9jYWwgdmFyaWFibGUNCj4gPiA+IGJlY2F1c2Ug
J3ZhbHVlJyBoYXMgbm93IHRoZW0gY2xlYXJlZCBieSBkZWZhdWx0Lg0KPiA+ID4NCj4gPiA+IE5v
dCBzdXJlIHdoZXRoZXIgYSBjb21tZW50IGFib3V0IHRoYXQgaXMgcmVxdWlyZWQsIHNpbmNlIHRo
ZSBkZXNjcmliZWQNCj4gPiA+IGJlaGF2aW9yIGlzIHdlbGwgZG9jdW1lbnRlZCBpbiB0aGUgU3lu
b3BzeXMgSFctbWFudWFsLg0KDQpUaGFua3MgZm9yIFNlcmdl4oCZcyBleHBsYW5hdGlvbi4NCj4g
Pg0KPiA+IFRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLCBpdCBjbGFyaWZpZXMgdGhlIHRoaW5n
cyB0byBtZS4gSSBhZ3JlZQ0KPiA+IHRoZXJlIGlzIG5vIG5lZWQgZm9yIGEgcGF0Y2ggY2hhbmdl
Lg0KPiANCj4gSSdtIHNvcnJ5LCBJIGhhdmUgdG8gdGFrZSBiYWNrIHRoZSBsYXN0IHNlbnRlbmNl
OiB0aGUgc3VibWl0dGVyIGFuZCBTb0INCj4gZW1haWwgYWRkcmVzcyBzdGlsbCBkb24ndCBtYXRj
aC4gQEppYW5oZW5nOiBwbGVhc2UgZml4IGl0IGZvciBnb29kIGF0DQo+IHRoZSBuZXh0IGl0ZXJh
dGlvbi4NCg0KT0gsIHNvcnJ5fiBJIG1peGVkIHVwIG15IGludGVybmV0IGVtYWlsIGFkZHJlc3Mg
d2l0aCB0aGUgaW50ZXJuYWwgb25lLiBJIHdpbGwgZml4IGl0IGFuZCByZXNlbmQgdGhlIHBhdGNo
LiANCg0KQmVzdCBSZWdhcmRzLCANCkppYW5oZW5nDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBQYW9s
bw0KDQo=
