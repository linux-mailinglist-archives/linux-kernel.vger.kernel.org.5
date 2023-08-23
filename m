Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7216F786354
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbjHWWWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbjHWWWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:22:33 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A5E6F;
        Wed, 23 Aug 2023 15:22:31 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NGjiqT017265;
        Wed, 23 Aug 2023 15:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=GK6rh2ohnfLs4JxqWk7PROOZA8UZT9EeOQhg3kTzN3o=;
 b=DWbOzeMqdEJTLl9/4SehYrIItotlBU6G2GpqQZUhlU1cGGvTa+l6ZQXqwwi/wL0L6Ury
 NcjIgmyG83OrwWDAOKwKOeTH8cB61Z5qCWjHre0YSvPTSW3mZUSbiPTO59ob49RY0aDW
 BBvCs33GjCzCHtCgGS1ivuEVh1CdNx4vjFeQG33Jio5vBieGMpww2D7jA2cWYt1uBPOG
 3/eYdhk7Mc/HM0665AhJgguVs+PJAA3vymx2XGqBvgaTjpTCbr9YyoytZ3K0TRWhcm14
 YII/p9wci37E2rjYJYUQQ7gz7c+mEDC7XfEoPCz8AerSuJb86B1HHJ66koY0VEGYaZbs /w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sn21qf42y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 15:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692829343; bh=GK6rh2ohnfLs4JxqWk7PROOZA8UZT9EeOQhg3kTzN3o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=X2oAZIb9m0a8nCVFzvzAtGJxzOHTSm/LO5cmNXDEzHgLypcTEYgYHni9C7GxRTlBV
         e4G4rTG1DtsBBT924Mk4ABW9xYCl4lTFwQJT3LN4M+3jM0Qp90OYnrMKuHEDlVm2ot
         td8JimBFHiCGznWcd7INKmuucqqrLh3QuREuSiKIFjwhyJnlgnc7M77Ob3qvJGs3ex
         flg7W7evUnKElG73J2q/D9AoZS6PrpNCm2xQD3PpJ830F1R4r/pdSQPBHNWwDLsGuy
         dogLdd2Hw6tNJhvvvcZnxZ0NPYuQjaJA0B27bvbspDmAJhiWwchj860+flcs/Ddj2U
         zCHuqnMi66lKA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F23D340520;
        Wed, 23 Aug 2023 22:22:22 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 06037A0080;
        Wed, 23 Aug 2023 22:22:16 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=D2ftat/f;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6B4B340563;
        Wed, 23 Aug 2023 22:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzN2Fa2vCeeNhF5/evBLRkmSXeOeK+nruS2jBKAORDvQ0nJJywz9oBqX1FMf5wrwIW9zkYvhRh7UjSUTUaL0+DBS0uAjMhk8N/8t5KpbA2r2D1hoNwZ4zAnNsFoPr/r2FU4VmUi+Ll1Ild+2TnYWGapDzWYfgWMOdOv9PX8q4lYfUTfA0jcU5RV9+w1P8NKZzwvH83ILLMwpoBZ1sXOItzvTUm+zfrk0NrITsyBRbqi2y7lBo5NOujSsj5wpaqoHFjfztS0ZA8jqiiIaMLTpoRXZjIS4X4iED+nfSNwwBdz5vdh7BtSyudMbR+jvb7w0vuDVmhT84eNfqInrdAfjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK6rh2ohnfLs4JxqWk7PROOZA8UZT9EeOQhg3kTzN3o=;
 b=GO3hEXbpT2/iIpI4oRucz1aPgy+tREmK/kPPvR+DP7BCV1prUB7iNZZHkcKNtQZI1/Uo4kvi3EVFLsQ8uryaCqvuVBoxOcAwA522hargKcNmpBN/c5Lp9u4SxaqOIyUuPwGXPYJHS0bWoTsGHHccpMmV8NLsRC+9Pnr13KnFUP6PfBRd0oWKcgJe9ouHaq6cXf+a5B0+WeA2E1m2pbaxbbX44cAL9L5wPKuKc9ocyjr+hY/BAGyqUs2mDjzZAYYy43KDT6RM+yq4qcULqpr63H3vCXN549KkmdAt7jnCpC01aOdGFI+R57ny7aNR3Ie6s/zDu4Occ7B9zVEckVxsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK6rh2ohnfLs4JxqWk7PROOZA8UZT9EeOQhg3kTzN3o=;
 b=D2ftat/fuRF9WrgTmTvA8lDzPliU8meLMMicGtiz0EUbatrGGLrAwLNu62Ntcon5isXAEi3LRtA0x8GqXNSVLmtQjm7xKg+7/zbJQX49Y9+963cmMn6QPFJJT2hcKyJV4OzEMakgPM9UPMljl//kLeUyfyW5dx7hC9Hi7Wz5iK8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 22:22:08 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 22:22:08 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAA+wcgIAA2rMAgAAtNoCAABaOgIAAMuwA
Date:   Wed, 23 Aug 2023 22:22:07 +0000
Message-ID: <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
References: <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <20230823021429.rlgixqehry4rsqmm@synopsys.com>
 <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
 <20230823175903.bpumanwv5fkpwc44@synopsys.com>
 <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
In-Reply-To: <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB8442:EE_
x-ms-office365-filtering-correlation-id: 93d85c0e-5c95-40a1-a690-08dba4276342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gL69o0e5CHGeMHDTSPl4RsSRmaTLC0dyEVxjw+n5SE0jMImtkxCOL5KVgecUjOeD+q8AFsrR809qT1GqaoXRqGURftTo/gpcyK2tBfkEqkc+OgHCuyENZF3L7cFdlupKIS4pPk+sSnIiWCl4cNdQ0IJbcoPboYj2NsJbIaghOCM6W8ojamoEgOWdZ7aK4AocGqp/gIYRQt9VS6LIY33xuJXQvaSCNN/Op1hyxM8b92S2yZ7cRRNLM9CzJtsHRyA477iAuLEeiO3UthMbL24MNws9M6LAQeUBMCECI/QSD4b+PzZJAtAJLIpMvUJKOfye7L6aVuuj4xuhXdqT9MM/IqIU/XPDl7VPUGcMti0LptB3swxAqhxAR1FqKnjkMtyVeCmwQaOIe7iZQ3bT/C77rMkANzPmaocJLMM+c49JXj5omn+ZTKazR9j+SICBuM/04H4XivysJaQgG7z6k8mxe7WJkRU1oo/+kS+NKs6m2+IJGt+Yfo83kq4Bz3Yf4VFb/Cno/pYu1aRkYlTVQNUlFzRCfLX4SrXrwL2isP1TGySMYOSJohU8u1O5BTBLe14LKSTUm9sU0venzKKfG0Q4FNUSEirIeBh6Iin3qu+0ypJ03YsVd1QV3tqN1ZP9r9k4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(1076003)(2616005)(6486002)(71200400001)(6512007)(26005)(6506007)(83380400001)(8676002)(5660300002)(4326008)(8936002)(2906002)(478600001)(76116006)(6916009)(66446008)(66946007)(66556008)(64756008)(316002)(66476007)(41300700001)(38070700005)(38100700002)(54906003)(36756003)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anUvVDNDNTdRNkpKa1RSLzlhU2RGM3dZZVplclhUUHNxSkwrcFI4Mk9zem9h?=
 =?utf-8?B?LzhKc1dyVmlubUtRVlMvdFdTNlpwM2ZLdi9oZ3lsandZMGNKbnhna1dtaWtr?=
 =?utf-8?B?Q0NtZ2xyS3ZVU1JWcThlS045OS9SazRodHJpc2JkTVNqZk11ZHErblZPVnNh?=
 =?utf-8?B?Rm1NUGczVUdnb3FLWWhUaXk5cGhDVnFGQi94RHVkU0s4NlVVYk1NSnplRzd4?=
 =?utf-8?B?NkZ1SkFIRTZLcTRhVzEyK2NvczZwMldmVWRZdmNPaVRBSkIyRk02TkVqTVRQ?=
 =?utf-8?B?Lytod2ZsUWZpaE1ubVNCZnI4UFZGUVJlbXViMkdraDIrRDUzbzA0OXovYnI3?=
 =?utf-8?B?bC9jNmE0Yi91VE5RNmd0c2RaUWJQcU5jTWhWa3ZYMGZLNW04bDNVRHlnaVhV?=
 =?utf-8?B?UGlIN3pRUmtOamRWL0hFQVA2c3hmTlJ5ZjdOUlJjUG1uZjB1VVVhVVBIWUxD?=
 =?utf-8?B?eStTb3Z6TysxL0JsaDlnem1rVVpnN0l1cGtYcVhYcTZ3cUg2SFNVeU1GM3NV?=
 =?utf-8?B?NVVGZzN1N2ZtcFNIRGc2YlFrZjFHZ01ZbWV0WHMyUmprRDJ6V283aml1Qngw?=
 =?utf-8?B?aXhBc2Y2a2ZJTHNVRUtZM0lvYmdDUERrQjNGc2F3WGMwTWlXR1R4T3d3WmE5?=
 =?utf-8?B?R0VnalRzY1A2TURPRE82RG1ETFZpSE0zczE2THZ1QVNMd0MwakZlQU9ISHNY?=
 =?utf-8?B?U0E5SmxHLzlVeFBpS3RsY09Ld3FlLzVTQzNyditXdjcyYWVWTThPWlUyUkFo?=
 =?utf-8?B?MlA0aTJZYzRMaWpSNE5PYkQ4KzNjUE13N1hLdnhHMDU3WkhSYU1UR0VKTUMz?=
 =?utf-8?B?RmlBd3RNd1dkKzkzRFdOSUNGb3B0VXM4WEFWYk05UmxnODJ5RTk3V0luR0xr?=
 =?utf-8?B?STJzdmtUMXE1eWVpOFhuV0dMVGh0VUVIeXFCVFBvQzJuRTVsWkd6T3BqSGFR?=
 =?utf-8?B?d0NMSkhZS1FaZ2NQQlAvaXRyQ0V1YlZxZjg1QWpQSWVaNG5EZzEwWHVYaDVF?=
 =?utf-8?B?MmdyRGxEb0VXa3JCMVE2S2krVDJ2R0ZCdzZ5bnRQbTFOa0JOSmtHNW1tOXBw?=
 =?utf-8?B?dG0zekFuTUpjOExuNllobHJDcDFhNWxDL3R3aFd2TGpqWTg2TU1jelE5aU1j?=
 =?utf-8?B?aHZOd2drZnVLSmVzQy92TzR4TjBLU1U4MkExc1J6ZmFHSTdzUVdlZTh0RlhH?=
 =?utf-8?B?VkhINDFiNXZhSFlWcHpBdXVJYTYvaUw4ZDFXd1dseXhlOUZETkQ5SUtnM0ZB?=
 =?utf-8?B?SVp5RlpjdEw5Zk52V1VtSnNOd3d3WXdSV3hhcjV4M2RQN0pVcDRQWm9wZ01H?=
 =?utf-8?B?K3VvVVF1bWtXaDJ5ZGd1UnVpQ0ZxcFduYXZJeCt6eU9vL0dmQlhRWThicWph?=
 =?utf-8?B?djJxWG0rS1FUeGVTNld2UGJ5MVJyS1BZa3h1UDluL3l5RGZ3S095cU83T2hj?=
 =?utf-8?B?bmM1TThYTmEzZ2lvclhZblBMcHRZQ05pYXY5Zi9qb0kxTFpmRk1ZNjU0cmlv?=
 =?utf-8?B?d2lQeHpWWGJMd1FsamIwUmxYWEJ3ZEdWVno0Sk9nYXRUeDg3aFJlWjRYdjZn?=
 =?utf-8?B?WVVuc2xyOTFXVndhRWoxZmZIa3l1cHFvcWZSdGpJbjBDV2FESUkxb1RDOTJR?=
 =?utf-8?B?Q2FISk9ndUFxbHlCWXpYZ0ZuaERCdmNLdXFKaFhIOXVJV21WQ0xoWjRDZ2dx?=
 =?utf-8?B?RVhscHBmaVZaVFFQcWJnSFBOOVBqTzA4Y05TMmVPczQ4Sjl1NlBPQUFrQU1X?=
 =?utf-8?B?NnJqMElkbkZrVU15TUNxY2IwSWtmcmNsWVdCWmdCNTgrak1wSEtaQkhPMVdE?=
 =?utf-8?B?N2MyUHZuNWR0ZVcvUFRFUTByNExodEErMkNiUVNLOE00QnpkZmxxRUxyQ1Vv?=
 =?utf-8?B?RmVjOVN0N2RTemtvZXJnTFpiTjNmSm9uTUdpNDNpL1JTSU5JQWZ2WnBrV0pC?=
 =?utf-8?B?bytHeStrQys5cVBmRDExNitEZis0dFc2UFlmSVBZdE5FL1NmQUREcXNodFdq?=
 =?utf-8?B?TVE1YXFZZWhrVURRUjNIeEFISnoydDBRbTVxc21UdkxJVkQwRzVCeHUybGly?=
 =?utf-8?B?d0tVbUpVcXNkOUdUQmJsTHpHMlEwOXo2MVhWNzdNbUpqY2t0WnhtZjlHVXFm?=
 =?utf-8?B?TFFkTzQwNFkzcTgxbzRVdDR5Y3FHbWI0UUlCK3lmNUdqcHpDOWNDaVlnTkFx?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CD0E072944A9647984B23E72C3E31A7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TEdWZy8yVkFYRjZMMUJCL1FpQzJOVVZndUU2M1h6NEhwWWdaUmFNQm5LTVMy?=
 =?utf-8?B?aGt1RDdGY0VvZG9mcWNoTTQxa2xTYXRlaTVkTVM4c005Q002aEJhNW9XMTNn?=
 =?utf-8?B?UzdZMmJGdFJaTm0wWUlvckVHOTd3dGxwVmlKbFRQL1FOdWFtSWVEYjFPU25J?=
 =?utf-8?B?U0Z3TGs1Y3YyQmthUUc4REZuN2xCV2gwckZEYmhwSU5QbzZRbW5jMDFHdi9r?=
 =?utf-8?B?cTV4TXc4MWl4ejFiREdxVXptQ2tnRUpDc0NiQWdsNEZkYncwV0xkT0ZBNnpn?=
 =?utf-8?B?QmMvdkpWelk3ZW9raklkTkFUelNhUXdQZkFIekhvblNnSXFCUDdGZ2FFSnN2?=
 =?utf-8?B?RndHYzA3aXB5RWZlN0dURnB6RWloMU91TDloNWdtNjZ3UkEwUFI0Q3I5dzBm?=
 =?utf-8?B?WjFSUExFc2xBNlhOekZab3gyNERTMklyN216dlJHYVNoQUJoMWN6ZzNzaWVE?=
 =?utf-8?B?eWdBbHVkd29kOUpoSktPNHA0Z0tuOVZpNWRkS1crQUpGbng5aHNRajl1dWJW?=
 =?utf-8?B?T2xUbU43Q2ltMS9HVGk1Wm1HN3dCVlZyY1hQN3o2TVBZTno4cnM4Mk9ma2RZ?=
 =?utf-8?B?aXg0a2hYdHdXZzdScHdVUDAyQ04rK2o0YUxSRkxBeldEQjFLU2VZdTROYUFK?=
 =?utf-8?B?Qk1rN211NkdndlNvYThVRDBET1p0UHZBdS9laFkzYzVXcUNUcGtUOHFsRHEy?=
 =?utf-8?B?M1RuV20vbEwxV0M2NS9zd2dGclYxWmtwYlVKR2pQcG5hcGJNa2xOU2hnZXkz?=
 =?utf-8?B?dG9BRGtyaFlRam5xOU11ZWNCVVdpNGxYNS9vc0hwQkp3eHZBUWg4SHFtOWdh?=
 =?utf-8?B?eU5hNjc3MnM4c0xIbWhVQ1JxNklUNU5xcDJrRC93OEpEeUFBM1B2NUdWOUdv?=
 =?utf-8?B?TURyMjRqWUFUUkZ5aHRFUUhyZDZJM2JNd3ArZ2Vna1g3dDloSlhoMitqaVo3?=
 =?utf-8?B?dHZibFQxUE5uN1M4NGQ5Tk1rSzlpUjJTRUxIWStQSURBVDdBRlBvSWV1MFBI?=
 =?utf-8?B?c2prb2FoV3NoVms1MnFzTHZzNDMvcldxSzdoSFhmV3VZV3B2UzZqQ1JMNlNL?=
 =?utf-8?B?bXdodXhaMlFUS0kydjJNbGtMelplU04zUjhuUloybXdvaXFMaUFzOVBDYlAz?=
 =?utf-8?B?UHJ5UkNJNFBZcyttTGdPTU1RWE95bjZWaE9iWXNwMWFwVndRaUlyRDB6WDFl?=
 =?utf-8?B?ME9SRjE1ak9rUlJ0YjFKTEQ3d3JnY2lySDF2QUUxaGlpdjhDbXU3RXpHeTNy?=
 =?utf-8?B?SlZmTEwwd2hUME9LQVM1V1FDNTNrRlE3M2R5bjBudklHcWhoUT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d85c0e-5c95-40a1-a690-08dba4276342
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 22:22:07.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Vyd8s6Sk0xBsRIJNJhnzp1nQ0wjNaF9tS+cHswjG+0z9w2bKGqEXChUgWd52lff3cplbrggwr6n2o/tD6aODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8442
X-Proofpoint-ORIG-GUID: gtPH8WMaR8xMTo06SegYxR44Zjc-pHYU
X-Proofpoint-GUID: gtPH8WMaR8xMTo06SegYxR44Zjc-pHYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_14,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxlogscore=903
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMjMsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDIz
LCAyMDIzIGF0IDA1OjU5OjA3UE0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBX
ZWQsIEF1ZyAyMywgMjAyMywgQWxhbiBTdGVybiB3cm90ZToNCj4gPiA+IFNUQUxMIGlzIG5vdCBh
IHZhbGlkIHN0YXR1cyBmb3IgdXNiX3JlcXVlc3RzIG9uIHRoZSBnYWRnZXQgc2lkZTsgaXQgDQo+
ID4gPiBhcHBsaWVzIG9ubHkgb24gdGhlIGhvc3Qgc2lkZSAodGhlIGhvc3QgZG9lc24ndCBoYWx0
IGl0cyBlbmRwb2ludHMpLg0KPiA+IA0KPiA+IFRoZSBob3N0IGNhbiBzZW5kIGEgQ0xFQVJfRkVB
VFVSRShoYWx0X2VwKS4gVGhpcyB3aWxsIHJlc2V0IHRoZSBkYXRhDQo+ID4gc2VxdWVuY2Ugb2Yg
dGhlIGVuZHBvaW50LiBJbiB4aGNpIHNwZWMgKHNlY3Rpb24gNC42LjgpLCBpdCBzdWdnZXN0cyB0
bw0KPiA+IHNlbmQgdGhpcyB3aGVuIHRoZSBlbmRwb2ludCBpcyByZXNldC4gVGhlIGVuZHBvaW50
IGlzIHJlc2V0IHR5cGljYWxseQ0KPiA+IHdoZW4gdGhlcmUncyBhIHRyYW5zYWN0aW9uIGVycm9y
Lg0KPiANCj4gSXQncyBpbXBvcnRhbnQgdG8gYmUgY2FyZWZ1bCBhYm91dCB0aGUgZGlzdGluY3Rp
b24gYmV0d2VlbiBhbiBhY3R1YWwgDQo+IGVuZHBvaW50IGluIHRoZSBnYWRnZXQgYW5kIHRoZSBs
b2dpY2FsIHJlcHJlc2VudGF0aW9uIG9mIGFuIGVuZHBvaW50IA0KPiBpbnNpZGUgYSBob3N0IGNv
bnRyb2xsZXIuICBUaGUgaG9zdCBjYW5ub3QgcmVzZXQgdGhlIGZpcnN0OyBpdCBjYW4gb25seSAN
Cj4gcmVzZXQgdGhlIHNlY29uZC4NCj4gDQo+IFNvIHllcywgdGhlIHVzYl9jbGVhcl9oYWx0KCkg
cm91dGluZSBvbiB0aGUgaG9zdCBkb2VzIGEgDQo+IENMRUFSX0ZFQVRVUkUoSEFMVCkgY29udHJv
bCB0cmFuc2ZlciBhbmQgdGhlbiBjYWxscyANCj4gdXNiX3Jlc2V0X2VuZHBvaW50KCksIHdoaWNo
IGNhbGxzIHVzYl9oY2RfcmVzZXRfZW5kcG9pbnQoKS4NCj4gDQo+ID4gVGhlIHByb2JsZW0gaGVy
ZSBpcyB0aGF0IHR5cGljYWwgcHJvdG9jb2wgc3BlYyBsaWtlIE1TQy9VVkMgZG9uJ3QNCj4gPiBz
cGVjaWZ5IGhvdyB0byBoYW5kbGUgQ0xFQVJfRkVBVFVSRShoYWx0X2VwKS4NCj4gDQo+IE1TQyBk
b2VzIHNwZWNpZnkgdGhpcy4gIEkgZG9uJ3Qga25vdyBhYm91dCBVVkMuDQoNCk5vLCBmcm9tIHdo
YXQgSSBsYXN0IHJlY2FsbGVkLCBpdCBkb2Vzbid0IGNsZWFybHkgZGVmaW5lIHdoYXQgc2hvdWxk
DQpoYXBwZW4gaGVyZS4gSXQganVzdCBpbmRpY2F0ZXMgQ2xlYXJGZWF0dXJlKGhhbHRfZXApIGZv
ciByZXNldCByZWNvdmVyeS4NCkhvd2V2ZXIsIHRoZSAicmVzZXQgcmVjb3ZlcnkiIGNhbiBiZSBp
bXBsZW1lbnRhdGlvbiBzcGVjaWZpYyBmb3IgaG93IHRoZQ0KaG9zdCBjYW4gc3luY2hyb25pemUg
d2l0aCB0aGUgZGV2aWNlLg0KDQo+IA0KPiA+IEZvciBXaW5kb3dzIE1TQyBkcml2ZXIsIHdoZW4g
dGhlIGhvc3QgcmVjb3ZlcnMgZnJvbSB0aGUgdHJhbnNhY3Rpb24NCj4gPiBlcnJvciwgaXQgc2Vu
ZHMgQ0xFQVJfRkVBVFVSRShoYWx0X2VwKSBhbmQgZXhwZWN0cyB0aGUgdHJhbnNmZXIgdG8gYmUN
Cj4gPiBjYW5jZWxsZWQuIFRvIHN5bmNocm9uaXplIHdpdGggdGhlIGhvc3QsIHRoZSBnYWRnZXQg
ZHJpdmVyIG5lZWRzIHRvDQo+ID4gY2FuY2VsIHRoZSByZXF1ZXN0LiBEd2MzIG5lZWRzIHRvIG5v
dGlmeSB0aGUgZ2FkZ2V0IGRyaXZlciBvZiB0aGlzLg0KPiANCj4gTm8sIHRoYXQncyBub3Qgd2hh
dCBoYXBwZW5zIGluIHRoZSBNYXNzIFN0b3JhZ2UgQ2xhc3MuDQo+IA0KPiBGb3IgdGhlIEJ1bGst
T25seSBUcmFuc3BvcnQgdmVyc2lvbiBvZiBNU0MsIHdoZW4gYSBXaW5kb3dzIG9yIExpbnV4IGhv
c3QgDQo+IGRldGVjdHMgYSB0cmFuc2FjdGlvbiBlcnJvciwgaXQgcGVyZm9ybXMgYSBVU0IgcG9y
dCByZXNldC4gIFRoaXMgY2xlYXJzIA0KDQpObywgdGhhdCdzIGltcGxlbWVudGF0aW9uIHNwZWNp
ZmljIGZvciByZXNldCByZWNvdmVyeS4gVHlwaWNhbGx5IGZvcg0KV2luZG93cywgZm9yIHRoZSBm
aXJzdCByZWNvdmVyeSwgaXQgc2VuZHMgYSBDbGVhckZlYXR1cmUoaGFsdF9lcCkgYW5kDQpzZW5k
cyBhIG5ldyBNU0MgY29tbWFuZC4gSWYgdGhlIHRyYW5zZmVyIGRvZXNuJ3QgY29tcGxldGUgd2l0
aGluIGENCnNwZWNpZmljIHRpbWUsIHRoZXJlIHdpbGwgYmUgYSB0aW1lb3V0IGFuZCBhIHBvcnQg
cmVzZXQsIHdoaWNoIGlzDQphbm90aGVyIGxldmVsIG9mIHJlY292ZXJ5Lg0KDQo+IGFsbCB0aGUg
c3RhdGUgb24gdGhlIGdhZGdldC4gIFRoZSBnYWRnZXQgZ2V0cyByZS1lbnVtZXJhdGVkLCBhbmQg
dGhlIA0KPiBob3N0IHByb2NlZWRzIHRvIHJlLWlzc3VlIHRoZSBNU0MgY29tbWFuZC4gIFRoZSBn
YWRnZXQgZHJpdmVyIGRvZXNuJ3QgDQo+IG5lZWQgYW55IHNwZWNpYWwgbm90aWZpY2F0aW9uczsg
b3V0c3RhbmRpbmcgcmVxdWVzdHMgZ2V0IGNhbmNlbGxlZCBhcyBhIA0KPiBub3JtYWwgcGFydCBv
ZiB0aGUgcmVzZXQgaGFuZGxpbmcuDQo+IA0KPiAoSW4gZmFjdCwgdGhpcyBpcyBub3Qgd2hhdCB0
aGUgQk9UIHNwZWMgc2F5cyB0byBkby4gIEl0IHNheXMgdGhhdCB3aGVuIA0KPiB0aGUgaG9zdCBk
ZXRlY3RzIGEgdHJhbnNhY3Rpb24gZXJyb3IsIGl0IHNob3VsZCBhIEJ1bGstT25seSBNYXNzIFN0
b3JhZ2UgDQo+IFJlc2V0IC0tIHRoaXMgaXMgYSBzcGVjaWFsIGNsYXNzLXNwZWNpZmljIGNvbnRy
b2wgdHJhbnNmZXIuICBJbiANCj4gcmVzcG9uc2UsIHRoZSBnYWRnZXQgZHJpdmVyIGlzIHN1cHBv
c2VkIHRvIHJlc2V0IGl0cyBpbnRlcm5hbCBzdGF0ZSBhbmQgDQo+IGNhbmNlbCBhbGwgb2YgaXRz
IG91dHN0YW5kaW5nIHJlcXVlc3RzLiAgVGhlbiB0aGUgaG9zdCBpc3N1ZXMgDQo+IENMRUFSX0ZF
QVRVUkUoSEFMVCkgdG8gYm90aCB0aGUgYnVsay1JTiBhbmQgYnVsay1PVVQgZW5kcG9pbnRzIGFu
ZCANCj4gcHJvY2VlZHMgdG8gaXNzdWUgaXRzIG5leHQgTVNDIGNvbW1hbmQuICBBIGxvdCBvZiBN
U0MgZGV2aWNlcyBkb24ndCANCj4gaGFuZGxlIHRoaXMgcHJvcGVybHksIHByb2JhYmx5IGJlY2F1
c2UgV2luZG93cyBkaWRuJ3QgdXNlIHRoaXMgDQo+IGFwcHJvYWNoLikNCg0KQXQgdGhlIG1vbWVu
dCwgdGhlIGdhZGdldCBkcml2ZXIgZG9lc24ndCBoYW5kbGUgQ0xFQVJfRkVBVFVSRShoYWx0X2Vw
KSwNCnRoZSBVREMgZHJpdmVyIGRvZXMuIEkgZG9uJ3QgcmVjYWxsIHRoaXMgYmVpbmcgaGFuZGxl
ZCBpbiB0aGUgY29tcG9zaXRlDQpmcmFtZXdvcmsgb3IgaW4gdGhlIGZfbWFzc19zdG9yYWdlIGZ1
bmN0aW9uIGRyaXZlci4gVW5sZXNzIHdlIGNoYW5nZQ0KdGhpcywgdGhlIFVEQyBkcml2ZXIgbmVl
ZHMgdG8gbm90aWZ5IHRoZSBnYWRnZXQgZHJpdmVyIHNvbWVob3cuDQoNCj4gDQo+IEluIHRoZSBV
QVMgdmVyc2lvbiBvZiBNU0MsIHRoZSBlbmRwb2ludHMgbmV2ZXIgaGFsdC4gIElmIHRoZXJlJ3Mg
YSANCj4gdHJhbnNhY3Rpb24gZXJyb3IsIHRoZSBob3N0IHNpbXBseSByZS1pc3N1ZXMgdGhlIHRy
YW5zYWN0aW9uLiAgSWYgdGhhdCANCg0KVGhlcmUgYXJlIG11bHRpcGxlIGxldmVscyBvZiByZWNv
dmVyeS4gRGlmZmVyZW50IGRyaXZlciBoYW5kbGVzIGl0DQpkaWZmZXJlbnRseS4gRm9yIHhIQ0ks
IEluaXRpYWxseSB0aGVyZSdzIHJldHJ5IGF0IHRoZSBwYWNrZXQgbGV2ZWwNCih0eXBpY2FsbHkg
c2V0IHRvIHJldHJ5IDMgdGltZXMgaW4gYSByb3cpLiBJZiBpdCBmYWlscywgaG9zdCBjb250cm9s
bGVyDQpkcml2ZXIgd2lsbCBnZXQgYSB0cmFuc2FjdGlvbiBlcnJvciBldmVudC4NCg0KSW4gTGlu
dXggeEhDSSwgdGhlIHJlY292ZXJ5IGZvciB0cmFuc2FjdGlvbiBlcnJvciB3ZSBwZXJmb3JtIHNv
ZnQtcmVzZXQNCih4aGNpIHJlc2V0IGVwIGNvbW1hbmQgd2l0aCBUU1A9MSkuIElmIGl0IHN0aWxs
IGZhaWxzLCB3ZSByZXNldCB0aGUNCmVuZHBvaW50IChUU1A9MCkgYW5kIHJldHVybiB0aGUgcmVx
dWVzdCB3aXRoIC1FUFJPVE8gdG8gdGhlIGNsYXNzDQpkcml2ZXIuIEhvd2V2ZXIsIHdlIGRvbid0
IHNlbmQgQ2xlYXJGZWF0dXJlKGhhbHRfZXApLiBJIGRvbid0IHJlY2FsbA0KTGludXggTVNDIGRy
aXZlciBoYW5kbGUgLUVQUk9UTyBhbmQgZG8gYSBwb3J0IHJlc2V0LiBIb3dldmVyIGl0IGRvZXMg
ZG8NCmEgcG9ydCByZXNldCBkdWUgdG8gdHJhbnNmZXIgdGltZW91dC4NCg0KSW4gV2luZG93cywg
aXQgZG9lc24ndCBkbyBzb2Z0LXJlc2V0LCBidXQgaXQgZG9lcyByZXNldCBlbmRwb2ludCAoVFNQ
PTApDQphbmQgc2VuZCBDTEVBUl9GRUFUVVJFKGhhbHRfZXApIHdpdGhvdXQgcG9ydCByZXNldCBp
bml0aWFsbHkuIEl0IHRoZW4NCmNhbiBzZW5kIHRoZSBhIG5ldyBNU0MgY29tbWFuZCBleHBlY3Rp
bmcgdGhlIGRldmljZSB0byBiZSBpbiBzeW5jIGJhc2VkDQpvbiB0aGUgQ0xFQVJfRkVBVFVSRSho
YWx0X2VwKSByZXF1ZXN0LiBJZiB0aGUgcmVjb3ZlcnkgZmFpbHMgYW5kIHRoZQ0KdHJhbnNmZXIv
Y29tbWFuZCB0aW1lZCBvdXQsIGl0IHdpbGwgdGhlbiBkbyBhIHBvcnQgcmVzZXQgdG8gcmVjb3Zl
ci4NCg0KPiBmYWlscyB0b28sIGVycm9yIHJlY292ZXJ5IGlzIHN0YXJ0ZWQgYnkgdGhlIFNDU0kg
bGF5ZXI7IGl0IGludm9sdmVzIGEgDQo+IFVTQiBwb3J0IHJlc2V0Lg0KPiANCj4gQnV0IGFzIHlv
dSBjYW4gc2VlLCBpbiBlYWNoIGNhc2UgdGhlIFVEQyBkcml2ZXIgZG9lc24ndCBoYXZlIHRvIGNh
bmNlbCANCj4gYW55dGhpbmcgaW4gcGFydGljdWxhciB3aGVuIGl0IGdldHMgYSBDbGVhci1IYWx0
Lg0KPiANCj4gPiBGb3Igb3RoZXIgY2xhc3MgZHJpdmVyLCBpdCBtYXkgZXhwZWN0IHRoZSB0cmFu
c2ZlciB0byByZXN1bWUgYWZ0ZXIgZGF0YQ0KPiA+IHNlcXVlbmNlIHJlc2V0Lg0KPiANCj4gSW5k
ZWVkLiAgSW4gd2hpY2ggY2FzZSwgdGhlIFVEQyBkcml2ZXIgc2hvdWxkbid0IGNhbmNlbCBhbnl0
aGluZy4NCj4gDQo+ID4gQXMgYSByZXN1bHQsIGZvciBhbiBlbmRwb2ludCB0aGF0J3MgU1RBTEwg
KG9yIG5vdCksIGFuZCBpZiB0aGUgaG9zdA0KPiA+IHNlbmRzIENMRUFSX0ZFQVRVUkUoaGFsdF9l
cCksIHRoZSBkd2MzIHJldHVybnMgdGhlIHJlcXVlc3Qgd2l0aCBzb21lDQo+ID4gc3RhdHVzIGNv
ZGUgYW5kIGxldCB0aGUgZ2FkZ2V0IGRyaXZlciBoYW5kbGUgaXQuIElmIHRoZSBnYWRnZXQgZHJp
dmVyDQo+ID4gd2FudHMgdG8gY2FuY2VsIHRoZSB0cmFuc2ZlciwgaXQgY2FuIGRyb3AgdGhlIHRy
YW5zZmVyLiBJZiB0aGUgZ2FkZ2V0DQo+ID4gZHJpdmVyIHdhbnRzIHRvIHJlc3VtZSwgaXQgY2Fu
IHJlcXVldWUgdGhlIHNhbWUgcmVxdWVzdHMgd2l0aCB0aGUgc2F2ZWQNCj4gPiBzdGF0dXMgdG8g
cmVzdW1lIHdoZXJlIGl0IGxlZnQgb2ZmLg0KPiANCj4gVGhlIFVEQyBkcml2ZXIgc2hvdWxkIG5v
dCBkZXF1ZXVlIGEgcmVxdWVzdCBtZXJlbHkgYmVjYXVzZSB0aGUgZW5kcG9pbnQgDQo+IGlzIGhh
bHRlZC4gIFRoZSBnYWRnZXQgZHJpdmVyIGNhbiB0YWtlIGNhcmUgb2YgZXZlcnl0aGluZyBuZWNl
c3NhcnkuICANCj4gQWZ0ZXIgYWxsLCBpdCBrbm93cyB3aGVuIGFuIGVuZHBvaW50IGdldHMgaGFs
dGVkLCBiZWNhdXNlIHRoZSBnYWRnZXQgDQoNCk5vLCBjdXJyZW50bHkgaXQgZG9lc24ndCBrbm93
LiBUaGF0J3MgdGhlIHByb2JsZW0uIFRoZSBkd2MzIGRyaXZlcg0KaGFuZGxlcyB0aGUgQ0xFQVJf
RkVBVFVSRShoYWx0X2VwKSwgbm90IHRoZSBnYWRnZXQgZHJpdmVyLg0KDQo+IGRyaXZlciBpcyB3
aGF0IGNhbGxzIHVzYl9lcF9zZXRfaGFsdCgpIG9yIHVzYl9lcF9zZXRfd2VkZ2UoKSBpbiB0aGUg
DQo+IGZpcnN0IHBsYWNlLg0KPiANCj4gQXMgZm9yIGhhbmRsaW5nIENMRUFSX0ZFQVRVUkUoSEFM
VCksIGFsbCB0aGUgVURDIGRyaXZlciBuZWVkcyB0byBkbyBpcyANCj4gY2xlYXIgdGhlIEhBTFQg
ZmVhdHVyZSBmb3IgdGhlIGVuZHBvaW50LiAgKEFsdGhvdWdoIGlmIHRoZSBlbmRwb2ludCBpcyAN
Cj4gd2VkZ2VkLCB0aGUgSEFMVCBmZWF0dXJlIHNob3VsZCBub3QgYmUgY2xlYXJlZC4pICBJdCBk
b2Vzbid0IG5lZWQgdG8gDQo+IGNhbmNlbCBhbnkgb3V0c3RhbmRpbmcgcmVxdWVzdHMgb3IgaW5m
b3JtIHRoZSBnYWRnZXQgZHJpdmVyIGluIGFueSB3YXkuDQoNClRoZSBVREMgZHJpdmVyIG5lZWRz
IHRvIG5vdGlmeSB0aGUgZ2FkZ2V0IGRyaXZlciBzb21laG93LCBjYW5jZWxsaW5nIHRoZQ0KcmVx
dWVzdCBhbmQgZ2l2ZSBpdCBiYWNrIGlzIGN1cnJlbnRseSB0aGUgd2F5IGR3YzMgaGFuZGxpbmcg
aXQuDQoNCj4gDQo+IChBZ2FpbiwgdGhpcyBpcyBzb21ldGhpbmcgdGhhdCBhIGxvdCBvZiBVU0Ig
ZGV2aWNlcyBkb24ndCBoYW5kbGUgDQo+IHByb3Blcmx5LiAgVGhleSBnZXQgdmVyeSBjb25mdXNl
ZCBpZiB0aGUgaG9zdCBzZW5kcyBhIENsZWFyLUhhbHQgDQo+IHRyYW5zZmVyIGZvciBhbiBlbmRw
b2ludCB0aGF0IGlzbid0IGhhbHRlZC4pDQo+IA0KPiA+ID4gUHV0dGluZyB0aGlzIHRvZ2V0aGVy
LCBJIGdldCB0aGUgZm9sbG93aW5nIHN0YXR1cyBjb2RlczoNCj4gPiA+IA0KPiA+ID4gLUVTSFVU
RE9XTglSZXF1ZXN0IGFib3J0ZWQgYmVjYXVzZSBlcCB3YXMgZGlzYWJsZWQNCj4gPiA+IC1FUkVN
T1RFSU8JUmVxdWVzdCB3YXMgZm9yIGFuIGFib3J0ZWQgY29udHJvbCB0cmFuc2Zlcg0KPiA+ID4g
LUVDT05OUkVTRVQJUmVxdWVzdCB3YXMgY2FuY2VsbGVkIGJ5IHVzYl9lcF9kZXF1ZXVlKCkNCj4g
PiA+IC1FWERFVgkJRGF0YSBkcm9wcGVkIChpc29jIG9ubHkpDQo+ID4gPiAtRU9WRVJGTE9XCVRo
ZSBob3N0IHNlbnQgbW9yZSBkYXRhIHRoYW4gdGhlIHJlcXVlc3Qgd2FudGVkDQo+ID4gPiAJCSh3
aWxsIG5ldmVyIGhhcHBlbiBpZiB0aGUgcmVxdWVzdCdzIGxlbmd0aCBpcyBhDQo+ID4gPiAJCW5v
bnplcm8gbXVsdGlwbGUgb2YgdGhlIG1heHBhY2tldCBzaXplKQ0KPiA+ID4gDQo+ID4gPiBUaGlz
IGFwcGxpZXMgb25seSB0byB0aGUgLnN0YXR1cyBmaWVsZCBvZiBzdHJ1Y3QgdXNiX3JlcXVlc3Qu
ICBDYWxscyB0byANCj4gPiA+IHVzYl9lcF9xdWV1ZSgpIG1heSByZXR1cm4gZGlmZmVyZW50IGVy
cm9yIGNvZGVzLg0KPiA+ID4gDQo+ID4gPiBIb3cgZG9lcyB0aGF0IHNvdW5kPw0KPiA+ID4gDQo+
ID4gDQo+ID4gVGhhdCBsb29rcyBncmVhdCENCj4gDQo+IEF0IHNvbWUgcG9pbnQgSSdsbCB3cml0
ZSBhIHBhdGNoIGFkZGluZyB0aGlzIHRvIHRoZSBkb2N1bWVudGF0aW9uLg0KPiANCg0KVGhhbmtz
IQ0KVGhpbmg=
