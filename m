Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0C678E4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbjHaCoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHaCoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:44:21 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49286CD6;
        Wed, 30 Aug 2023 19:44:18 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V278UL030887;
        Wed, 30 Aug 2023 19:43:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=qu3ZyD/7JigxIo15Q+tV0IyvXxntjh6loSp828F8YRo=;
 b=vBy4lXzmhvyD05g85TB5mUYYDUr2dE4SJecxn7rycsLS95H86AbTsofbmATpx/z7d5zV
 THKgWfV3pjOyMUlxD/K4DLGtGjZVCqy7qV9G44Qd0fpH2BZCf61XpqvXKBa7thyxhbg+
 bhIlanffrj4YNNzeeTwc0jl3pyRiMBUWbrUFgqBxyvzLGuDM6caZvcRlk4RLp/rMCtPb
 y6KOUer8rmGth1KFh4/EvTz3najlqOnoyQLUYfBOE8i3mwKXIPuHxLGKUNEbsQcGQ9ZV
 sfRRZWxDFMAozJ2WPkZHNp+2WN+qA/hF4+Ju9K06HAnXBcu3l9Emll8G002n8UQzJqp+ 4g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sqgdmm87a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 19:43:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1693449836; bh=qu3ZyD/7JigxIo15Q+tV0IyvXxntjh6loSp828F8YRo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QKRUjln4iTqA8Af+isJ7sQ91JNJEs0A2JNuaa8IBvYlJ2fKFjyj2XRkEvZDwamaia
         +aJup5/3y+a7jm4SPRoU2C0bSyQGXDMA9ptsTkHleCXyQeFbVAvob/nsphWGxnkAMl
         L40sF41IHXO/6+eky34KV8Wx4TWfaKhBjZ6eiVa8wfTraDFpMvBzV/8kjz67u7v4Yo
         5hDPIBTOXM+MZs5aTyW2WhhCND5f3cXlVkeC5fuA1m5ONAqoDJTc1BpOtxIS7r1tle
         UJNZx6MZqg0mjpK9fArf94Bh1DFWotj4whUTEelrRPl0wGMGE7/WetIhy9w/4/wzb7
         nDHbI/JuqmZHA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AC37F4012B;
        Thu, 31 Aug 2023 02:43:55 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 38744A007F;
        Thu, 31 Aug 2023 02:43:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=XkFobvDn;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9894940359;
        Thu, 31 Aug 2023 02:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGKb2C7cA+fx9+qTgXE1nplqtA2M2dYo8Iu4tpz5j2KGlTUaHs/TTLAWXmE/enQ5h/InSIS9+cLNaAto66QcY9hwEpkOBJf8HBHxRxWWrtebAgdFVbODGKjy3UeMxam9/NBEDnT06cumFdSkcj62+44rWHTxqvpyjE/cIYRGhkaVZXRJd1bpKFDIeZGXaIpM9TUqce3TWVsw7blyw8t8OhGT4eD13vX0lUGtRta+IqbPgk02wUCZHYrwH5pZXDSlBnkakMcjRLaL+W3YWUUI4hJUrEM/o7MP6ZUsOujnWPed88rdLpfbY8WYbVCvOxKeryZTUoLMO0TjymjhI1P99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu3ZyD/7JigxIo15Q+tV0IyvXxntjh6loSp828F8YRo=;
 b=Dt67yKlhZy52uYLZITFin48huqu0uyY5+v8tbArmp08YmqWiFvwFjga0hFxG1sbBLEUQNzuNrCADbZIDEg/nhUSXvrJCbKcnRgWnZ7TPbZRieQdnxXUveb60UUTSb4j+dNQA4YrlD3MI6831aJocNloto6WsY8T62TyqX6DpAXiPITXuNK6rQ7Jf5LZ8Rd3llvbcLA1qt+FVbTtnpS0IZHLobLQRC+QFAJ2NrTr0Bv5qAa5NBBoD/+YnaZQPfoB0Hjp4dviND9mdwDcXf/27I0gJpndtxzo28x27/Y5rpZashUQLBDbqqZ3JWyoLX/LO7rMnR8WC2+gAxRtn7Hcu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu3ZyD/7JigxIo15Q+tV0IyvXxntjh6loSp828F8YRo=;
 b=XkFobvDnu7r3ngDLrKZ10oolJXcs+I1dsh4FFs9skwaWtYb9rXx+FHw/ROz3z0ONKb0d+7LJeUEJsvJuQelJKT72Fsd7sx/lg+aW7uuflEs2wBEDB9yaH/+ajcCbNkj1uAoH/9rgT/tyq4dOpxREI+hSUkTOeKmu1wDH62KM92o=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 02:43:52 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::8dbe:70eb:1dee:71d2]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::8dbe:70eb:1dee:71d2%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 02:43:52 +0000
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
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAA+wcgIAA2rMAgAAtNoCAABaOgIAAMuwAgABCyQCAAxO2AIAAHuQAgAYtxwCAAN5PAIAAx/iA
Date:   Thu, 31 Aug 2023 02:43:51 +0000
Message-ID: <20230831024345.lwd6ehcbjdlczjpa@synopsys.com>
References: <20230823021429.rlgixqehry4rsqmm@synopsys.com>
 <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
 <20230823175903.bpumanwv5fkpwc44@synopsys.com>
 <08a3759d-4c6b-4034-8516-685e4d96a41e@rowland.harvard.edu>
 <20230823222202.k7y7hxndsbi7h4x7@synopsys.com>
 <9b175f9e-ab70-47a3-a943-bfd05601aa23@rowland.harvard.edu>
 <20230826012024.mboftu3wk7fsrslp@synopsys.com>
 <ba06679f-93d2-4cb4-9218-9e288065bdfb@rowland.harvard.edu>
 <20230830013222.ukw5dtburjnrrjko@synopsys.com>
 <61cf24db-9dbb-4bf3-aafe-d515fc37cca8@rowland.harvard.edu>
In-Reply-To: <61cf24db-9dbb-4bf3-aafe-d515fc37cca8@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|CH2PR12MB4311:EE_
x-ms-office365-filtering-correlation-id: 3a8cd055-92ce-4546-7399-08dba9cc1c71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m6xHx4d/NCJGeNQRSdXPHxGSwg9iKgLG12f4uu1luU7BsZMDhlRbq6hddxQce4FfTbr8KJS10A9mqzKq38KTq/vWAdGXYbTqDhT7BF86JTy8syXJI2cEzG6ws1P+/FTvykKN/uVaNNlsmMvLWOST9yzXXK2DKefvk7v05BS88V1ceW7LOY0AOsPSqN5jxxeZBZtVCWRxSjtS98MMturToEkyqqk5r70B2fEizAiYpUalOgr/Y5FOLZKKM2gn2f1i6HsrRskaVF/8wxkPjnpjKqFoOwXUCIaFr4Dhdotg8qx2Lwjsf6lYqA8RxqH11WWQ7si42vDJWeT1K77s/LPawr3H0/HOUyP+mz2m6dZ5zpkPB6imfYIdOofgFU/nQEH50xPxdomnr0AMS4UIduM5dHRGlf2FxSAuz5OqTawKY7eilOJLUbx2JgAYiyxElYlB/N1Mv3+kIA4HZulPvqU8F2cBCfDwsPJbix5281n9Ghcm9M1XwA6mkbuyZxvz3qiRwA10zmsEKoiGAW7wf3/F+6lf2famnQfOouVXEqYWYSIuICG/zwInzfWfuUaxmDSS+D/tes6mOWddslNhZ1QhMXwv8a/ZuLRcF8eQPpRDOw0P1rX57mfVPC/IZC0G782A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(41300700001)(83380400001)(8936002)(66556008)(8676002)(4326008)(64756008)(66476007)(478600001)(71200400001)(91956017)(66946007)(76116006)(6916009)(316002)(26005)(6512007)(2616005)(6486002)(1076003)(6506007)(54906003)(66446008)(2906002)(38100700002)(122000001)(38070700005)(5660300002)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG15N3I3WDZLaHEwL3RLYkJlRDFXMk5BVVVZZjYzNWxETXlyZUxnbDNpdjJh?=
 =?utf-8?B?SUFuVzJIR3FoQUdlUVBEYmdhcnY2YytsODRKampqYU1kV0dTanlQYlRKR2t3?=
 =?utf-8?B?Y2tFVDlxMGt0clUzR2tXSTUyaDc3RmNucGlXUFFCMU9vSmRwc0Nwa0VyNXpo?=
 =?utf-8?B?Q3lWUG1scGNITHZnZUR1aDdCWDROQVErK0l6TVRrMWwwQWxncCsyS2dxVVRh?=
 =?utf-8?B?K0cvT2JhbE5QUXRaNjN0UFhBakhSeXJqKzNnL05mMGJLMzIxVk1jS0RhaGtP?=
 =?utf-8?B?RGtRUEVBak5CbFlQUHVyQUF3YVNIY29vRktCT1JUS2hWNXRnMUdaVVNNVnBB?=
 =?utf-8?B?c3FQOVRTdEUzQ0wxNHpTTm9RMEo0cGN1Qml4TjhiemV1ZUozMWgvU25pQU1X?=
 =?utf-8?B?K2JlMXNsK0hVMmxZZDdZblc1VW51ZVRSUHJZYm02U29EaWZnL3hoUWpFbHk0?=
 =?utf-8?B?SFpZM1FuZmxwT2hRZm9FZ1VEWE8vc1Q1aFZNUERTdjF5blQ1V0hWcW5GVHYw?=
 =?utf-8?B?WFh3QWJpNTBBT1pkTjFOTDBTTUMxdE4rVVQrc0p1K2QrMStzbVNTZVl6aGhy?=
 =?utf-8?B?cEhFSnVGQm03V1IrZDN2VGROQ1dHZElQMTE2dnpDbDVsdjhpNU5xWWF6aXo5?=
 =?utf-8?B?ejY3aElPN1cyVWRMUy80S1JLVng3TWh3TDJacVFBN0p4UTlJUFN0VmNCVXNz?=
 =?utf-8?B?aWdFdmpNaTZkV0hMdGg3TXNDTFMwY3N2U0drM3lxMmlDeGgvUDBnRG8zQmNM?=
 =?utf-8?B?dW1Wc0kwbU5DNVBUakVXQlBlSVRKM2QzM2lEb0NaY3VyMTZlWUJMRys3R3d3?=
 =?utf-8?B?MndwdkpkZTNieGh4Z2o4cWM0RTI4emtCeGtBdkxkMWYwMEJhaDlnaVRBY1ZD?=
 =?utf-8?B?cnFuNXJEZEhWYkxzU3h0M08rbk96NzNRazhMTVR1a1VnZlNncVRLZ05NZXk3?=
 =?utf-8?B?c0hxY1VENWhZRU5MRDA1a3VLQ3hiZzFLdnYyTjhCckZFVUh4d3lGellqYVBN?=
 =?utf-8?B?WjFBUHdrN1Z0a2VHUWhseDZGcmpSRmtWZHBKdG93ZDJ5NHZjUFhWbVg5UjRS?=
 =?utf-8?B?bTVOOVFnZ3JPL3dvcXM1VzlzT0VIVGdzSlY5MHpvc3htVGltcE9JSmt2bnFk?=
 =?utf-8?B?Vzl5SFBKMnZINC8wNTRDenFkUzNiLzNiSnJCRHNRa1Y5cUVZNkRCZVp4aGhD?=
 =?utf-8?B?UWc3RE0yT3dVa1lsYm0rTGd0cjd3L2xMN3c1eGYvNW5mTERtM2dvTmpKVk12?=
 =?utf-8?B?YTFkdHBjNXlmSHNqd24rMmRUdzRwYmxoK0Mxa1p2MURGYXBwSDhRVXhKL0Nt?=
 =?utf-8?B?UE5udFM4eVFwVTltUU1aVmpPTDdSMHlKSm1rS3NPTE51Zm52alAyYWxKNVM1?=
 =?utf-8?B?WDBzclJObTZ6ZFA2cTAxWkZqWGpJQXBZQlFlMGJnMmlsd2pqZXpwTnBWbVR0?=
 =?utf-8?B?SXhVem9VY21tS1ZINkRjdmNWRFpSK1NLUm5yc2xUSjVyMjd0UERMU1FZdFVR?=
 =?utf-8?B?eHVEOGJ2bkxJdWkrMUJjODhvS0pOSWZudlBRSVJYT09WcHVuUitoalRJT0xC?=
 =?utf-8?B?SHdLanVRSVlvZWNRWXlyNzNFeERuWDI3R1hwYktRcTM3QkxwdTFQRzVMM3NM?=
 =?utf-8?B?cUk0b2ozNFA1cWt6MnhwS2x1M3g4cERzSzh6SjlHT3luWENTd1JQUXpmdW1n?=
 =?utf-8?B?YWg1U2FQa3lidDI0UHE3TE5JN3U5dHRjTkFhakI4OWRsTUF5T1RiNVB2OVda?=
 =?utf-8?B?ZXZ6UVAzU1VWdE85T0R3RkZQTmc0VE9MUnBObEtRYUhaZmJnU2VWV0F0dzY4?=
 =?utf-8?B?cUlrSHR5eWJWdWZpTCtOZGc0QmFmZGhLVkQ5d1FVYlZYSHB6dTBOc0pmYzFz?=
 =?utf-8?B?cXdWY0pHeXZHYjdxRUNhV2lxb1NCakFVaTFnQUFwT2xNSUttOGJNY2NZbG5o?=
 =?utf-8?B?bjYwajFUT0QyUkhpbzJpYWZBVy90U3NlaWtMdDVvRXIzZjliTlkzOE84eXFp?=
 =?utf-8?B?dnZyakdTWDBWSGVEYXV0QlVQczRmZWpBb3gyR2REZEZuU2UzM2VpWmpFUGt6?=
 =?utf-8?B?a3VNTGFVQnh2S3FwYzBNb0puSmVNWHJ6NjVYdkZOdkkySEswMTJYOTVqYVpa?=
 =?utf-8?B?R2JmanlSeVJDcURheGk0bGpLREdIQjYrWVUwa3FuYmdYWFNZdkdFaG9KOTNq?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D587E5AB27A5C4C9A3922F4C86A541E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MTRwUlNsZE5QWUlHeDExQXVBVjJGWlN5SDNpdFZ5L1I2U0pySjU3UlRzMGd2?=
 =?utf-8?B?bGlHSTE2ODVZcDRqMVVHN3RiRU40M3dFT3dESmJSMSt4bWZGa2thV3Qvb3Bw?=
 =?utf-8?B?Q0xuSGpYNk5venpKYzk3YW95QlRQVXFsc2NNWUpDQyt4b2RJd0Z0cjJIMjNJ?=
 =?utf-8?B?UGhhdSthMVNFTmVqNlNpdzdFb3NvZWlzaFA4VndXTWI0UFRQY3FiUmY5UWpm?=
 =?utf-8?B?ZUdCSnVwNVUvYkhSTmFvcU41Y2FwMlJmOEw4L2FvMUl6V25JUGVVQ2hYbFRj?=
 =?utf-8?B?RjVpR0dBZEJVT3lzeUh6Tlo0bHIwa2VxUGdiaEFlU2Npb2tzTEx3VWxRdUdR?=
 =?utf-8?B?TEUxUmVtR2ZwKytEWXEvWkVNNkdQVTUxQlVpWXdhT0pRbUkvVkpDSGgxMElT?=
 =?utf-8?B?ZEhpdUV0R2JRNGRNRmZHbzE3eGkweTlnV2MzQXRUaFJQUjVvamhkbENOS2Nl?=
 =?utf-8?B?MXVuYTdmbmZ2eXJsaEJ5dWNLTGt6Sm5TaFU2N0M5c3FVRUl3Ym10RlMyRmlt?=
 =?utf-8?B?TTIzb3lIamFjT2tycTI5Nkk3elV0Q2c3OWxEZVZSQlRydnluZUJPcm1LMSta?=
 =?utf-8?B?SHB3Qzl5Vk56OHBCY1E5bUlZc0h3ZTUrTFFkUU1sWW5qNTdBRkVhMDV2MGhv?=
 =?utf-8?B?dSs4OTF3UFNiUkMvRWdDVzlOWU4vK0Z2cThCcStibkdFb1h5QkFkb28zUkh5?=
 =?utf-8?B?dVdTcjVMRGxGZnJxc1lpbWlKemNlcHJpU3JLQ05DOW1jVng2UzA3UVNoeFZQ?=
 =?utf-8?B?dUR4MXBIVUNKSG5sQmMwM1RXS1pZcmpiR1ZvUTVCYkx2VW1XcWZIR2F4Rmdk?=
 =?utf-8?B?MXNvcWtyQVNhZkkvbUtTVWd2MnJzcHBVbndaU2lRS21UaFZFUVFNSnRXaVR4?=
 =?utf-8?B?RHRKeG8vV1loOU9TcEh6VEJLajBlbmJQamFrRFBLei85aWNlYzBDMHlUWGVp?=
 =?utf-8?B?T1FFc21ZN0RpWFVLdXRqQm12UjNGdnNDejZaVkNwQWNaU2t0aUJycEltT3JB?=
 =?utf-8?B?ZXZnRmc3ZlF0WVM0eE96dGV3bmFzVjQ1L0pBdG1Sd25NMy82NTJGOE9ZRmxG?=
 =?utf-8?B?R2xYc2g2a3hhUGVreHhWbmg0UTZnc3RnZHh6NUlpU3AvNFJ3bU5WY3dLN0F5?=
 =?utf-8?B?MVVab2NqOUVIVFBBYjhQcDZRVndTTDllRmpCOWNlSzZoNGxDZ1pTUExJMmhG?=
 =?utf-8?B?V1pBelBJNVo4ZUt4aFc2MlpYTzFvcGhaYjM2Z0VxVGlDVkZUSTNjcTd4TkVR?=
 =?utf-8?B?dnZOTm9hODlrWnVRYmgxT3Q4RUJRNlN5d0UwZlFFOURFMFZuZz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8cd055-92ce-4546-7399-08dba9cc1c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 02:43:51.8675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoAQLGxX9zJQN5iiy2yt0CTZnkoZdAgf2j0YU9tNKci2B7kdoZ0GwuijKF0VLbJfbC6ceQ094NRhXIGPwWQuww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
X-Proofpoint-GUID: YSPVXoYxf-KS7G0WdwkDLEmhj7vSooxN
X-Proofpoint-ORIG-GUID: YSPVXoYxf-KS7G0WdwkDLEmhj7vSooxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308310023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMzAsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDMw
LCAyMDIzIGF0IDAxOjMyOjI4QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBUaGF0
IHJlbWluZHMgbWUgYW5vdGhlciB0aGluZywgaWYgdGhlIGhvc3QgKHhoY2kgaW4gdGhpcyBjYXNl
KSBkb2VzIGENCj4gPiBoYXJkIHJlc2V0IHRvIHRoZSBlbmRwb2ludCwgaXQgYWxzbyByZXNldHMg
dGhlIFRSQiBwb2ludGVyIHdpdGggZGVxdWV1ZQ0KPiA+IGVwIGNvbW1hbmQuIFNvLCB0aGUgdHJh
bnNmZXIgc2hvdWxkIG5vdCByZXN1bWUuIEl0IG5lZWRzIHRvIGJlDQo+ID4gY2FuY2VsbGVkLiBU
aGlzIHhIQ0kgYmVoYXZpb3IgaXMgdGhlIHNhbWUgZm9yIFdpbmRvd3MgYW5kIExpbnV4Lg0KPiAN
Cj4gVGhhdCdzIG9uIHRoZSBob3N0IHNpZGUsIHJpZ2h0PyAgSG93IGRvZXMgdGhpcyBhZmZlY3Qg
dGhlIGdhZGdldCBzaWRlPw0KPiANCj4gVGhhdCBpcywgY2FuY2VsbGluZyBhIHRyYW5zZmVyIG9u
IHRoZSBob3N0IGRvZXNuJ3QgbmVjZXNzYXJpbHkgbWVhbiBpdCANCj4gaGFzIHRvIGJlIGNhbmNl
bGxlZCBvbiB0aGUgZ2FkZ2V0LiAgRG9lcyBpdCBoYXZlIGFueSBpbXBsaWNhdGlvbnMgYXQgYWxs
IA0KPiBmb3IgdGhlIGdhZGdldCBkcml2ZXI/DQoNClRoZXJlIGFyZSAyIHRoaW5ncyB0aGF0IG5l
ZWRzIHRvIGJlIGluIHN5bmMnZWQgYmV0d2VlbiBob3N0IGFuZCBkZXZpY2U6DQoxKSBUaGUgZGF0
YSBzZXF1ZW5jZS4NCjIpIFRoZSB0cmFuc2Zlci4NCg0KSWYgaG9zdCBkb2Vzbid0IHNlbmQgQ0xF
QVJfRkVBVFVSRShoYWx0X2VwKSwgYmVzdCBjYXNlIHNjZW5hcmlvLCB0aGUNCmRhdGEgc2VxdWVu
Y2UgZG9lcyd0IG1hdGNoIGFuZCB0aGUgaG9zdCBpc3N1ZXMgdXNiIHJlc2V0IGFmdGVyIHNvbWUN
CnRpbWVvdXQgYmVjYXVzZSB0aGUgcGFja2V0IHdvbid0IGdvIHRocm91Z2guIFdvcnN0IGNhc2Ug
c2NlbmFyaW8sIHRoZQ0KZGF0YSBzZXF1ZW5jZSBtYXRjaGVzIDAsIGFuZCB0aGUgd3JvbmcgZGF0
YSBpcyByZWNlaXZlZCBjYXVzaW5nDQpjb3JydXB0aW9uLg0KDQpJZiB0aGUgZGV2aWNlIGRvZXNu
J3QgY2FuY2VsIHRoZSB0cmFuc2ZlciBpbiByZXNwb25zZSB0bw0KQ0xFQVJfRkVBVFVSRShoYWx0
X2VwKSwgaXQgbWF5IHNlbmQvcmVjZWl2ZSBkYXRhIG9mIGEgZGlmZmVyZW50IHRyYW5zZmVyDQpi
ZWNhdXNlIHRoZSBob3N0IGRvZXNuJ3QgcmVzdW1lIHdoZXJlIGl0IGxlZnQgb2ZmLCBjYXVzaW5n
IGNvcnJ1cHRpb24uDQoNCkJhc2Ugb24gdGhlIGNsYXNzIHByb3RvY29sLCB0aGUgY2xhc3MgZHJp
dmVyIGFuZCBnYWRnZXQgZHJpdmVyIGtub3cNCndoYXQgbWFrZXMgdXAgYSAidHJhbnNmZXIiIGFu
ZCBjYW4gYXBwcm9wcmlhdGVseSBjYW5jZWwgYSB0cmFuc2ZlciB0bw0Kc3RheSBpbiBzeW5jLg0K
DQo+IA0KPiA+ID4gSSB0aGluayBpdCBzaG91bGQgYmUgdGhlIG9wcG9zaXRlOyB0aGUgY2xhc3Mg
cHJvdG9jb2wgc2hvdWxkIHNwZWNpZnkNCj4gPiA+IGhvdyB0byByZWNvdmVyIGZyb20gZXJyb3Jz
LiAgSWYgZm9yIG5vIG90aGVyIHJlYXNvbiB0aGVuIHRvIGF2b2lkIHRoZQ0KPiA+ID4gZGF0YSBk
dXBsaWNhdGlvbiBwcm9ibGVtIGZvciBVU0ItMi4gIEhvd2V2ZXIsIGlmIGl0IGRvZXNuJ3Qgc3Bl
Y2lmeSBhDQo+ID4gPiByZWNvdmVyeSBwcm9jZWR1cmUgdGhlbiB0aGVyZSdzIG5vdCBtdWNoIGVs
c2UgeW91IGNhbiBkby4NCj4gPiANCj4gPiBSaWdodCwgdW5mb3J0dW5hdGVseSB0aGF0J3Mgbm90
IGFsd2F5cyB0aGUgY2FzZSB0aGF0IGNsYXNzIHByb3RvY29sDQo+ID4gc3BlbGwgb3V0IGhvdyB0
byBoYW5kbGUgdHJhbnNhY3Rpb24gZXJyb3IuDQo+IA0KPiBBbGwgdG9vIHRydWUuLi4NCj4gDQo+
ID4gPiBCdXQgcmVnYXJkbGVzcywgaG93IGNhbiB0aGUgZ2FkZ2V0IGRyaXZlciBtYWtlIGFueSB1
c2Ugb2YgdGhlDQo+ID4gPiBrbm93bGVkZ2UgdGhhdCB0aGUgVURDIHJlY2VpdmVkIGEgQ2xlYXIt
SGFsdD8gIFdoYXQgd291bGQgaXQgZG8NCj4gPiA+IGRpZmZlcmVudGx5PyAgSWYgdGhlIGludGVu
dCBpcyBzaW1wbHkgdG8gY2xlYXIgYW4gZXJyb3IgY29uZGl0aW9uIGFuZA0KPiA+ID4gY29udGlu
dWUgd2l0aCB0aGUgZXhpc3RpbmcgdHJhbnNmZXIsIHRoZSBnYWRnZXQgZHJpdmVyIGRvZXNuJ3Qg
bmVlZCB0bw0KPiA+ID4gZG8gYW55dGhpbmcuDQo+ID4gDQo+ID4gSXQncyBub3Qgc2ltcGxlIHRv
IGNsZWFyIGFuIGVycm9yLiBJdCBpcyB0byBub3RpZnkgdGhlIGdhZGdldCBkcml2ZXIgdG8NCj4g
PiBjYW5jZWwgdGhlIGFjdGl2ZSB0cmFuc2ZlciBhbmQgcmVzeW5jIHdpdGggdGhlIGhvc3QuDQo+
IA0KPiBIb3cgZG9lcyB0aGUgZ2FkZ2V0IGRyaXZlciBzeW5jIHdpdGggdGhlIGhvc3QgaWYgdGhl
IGNsYXNzIHByb3RvY29sIA0KPiBkb2Vzbid0IHNheSB3aGF0IHNob3VsZCBiZSBkb25lPw0KPiAN
Cj4gQWxzbywgd2hhdCBpZiB0aGVyZSBpcyBubyBhY3RpdmUgdHJhbnNmZXI/ICBUaGF0IGlzLCB3
aGF0IGlmIHRoZSANCj4gdHJhbnNhY3Rpb24gdGhhdCBnb3QgYW4gZXJyb3Igb24gdGhlIGhvc3Qg
YXBwZWFyZWQgdG8gYmUgc3VjY2Vzc2Z1bCBvbiANCj4gdGhlIGdhZGdldCBhbmQgaXQgd2FzIHRo
ZSBsYXN0IHRyYW5zYWN0aW9uIGluIHRoZSBmaW5hbCB0cmFuc2ZlciBxdWV1ZWQgDQo+IGZvciB0
aGUgZW5kcG9pbnQ/ICBIb3cgd291bGQgdGhlIFVEQyBkcml2ZXIgbm90aWZ5IHRoZSBnYWRnZXQg
ZHJpdmVyIGluIA0KPiB0aGlzIHNpdHVhdGlvbj8NCg0KVGhhdCdzIGZpbmUuIElmIHRoZXJlJ3Mg
bm8gYWN0aXZlIHRyYW5zZmVyLCB0aGUgZ2FkZ2V0IGRvZXNuJ3QgbmVlZCB0bw0KY2FuY2VsIGFu
eXRoaW5nLiBBcyBsb25nIGFzIHRoZSBob3N0IGtub3dzIHRoYXQgdGhlIHRyYW5zZmVyIGRpZCBu
b3QNCmNvbXBsZXRlLCBpdCBjYW4gcmV0cnkgYW5kIGJlIGluIHN5bmMuIEZvciBVQVNQLCB0aGUg
aG9zdCB3aWxsIHNlbmQgYQ0KbmV3IE1TQyBjb21tYW5kIHRvIHJldHJ5IHRoZSBmYWlsZWQgdHJh
bnNmZXIuIGllLiBUaGUgaG9zdCB3b3VsZA0Kb3ZlcndyaXRlL3JlLXJlYWQgdGhlIHRyYW5zZmVy
IHdpdGggdGhlIHNhbWUgdHJhbnNmZXIgb2Zmc2V0Lg0KDQpUaGUgcHJvYmxlbSBhcmlzZXMgaWYg
dGhlIGdhZGdldCBhdHRlbXB0cyB0byByZXN1bWUgdGhlIGluY29tcGxldGUNCnRyYW5zZmVyLg0K
DQo+IA0KPiA+ICBUaGlzIGlzIG9ic2VydmVkIGluDQo+ID4gVUFTUCBkcml2ZXIgaW4gV2luZG93
cyBhbmQgaG93IHZhcmlvdXMgY29uc3VtZXIgVUFTUCBkZXZpY2VzIGhhbmRsZSBpdC4NCj4gDQo+
IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSdyZSBzYXlpbmcgaGVyZS4gIEhvdyBjYW4geW91
IG9ic2VydmUgd2hldGhlciANCj4gYSB0cmFuc2ZlciBpcyBjYW5jZWxsZWQgaW4gYSBjb25zdW1l
ciBVQVMgZGV2aWNlPyAgQW5kIGhvdyBkb2VzIHRoZSANCj4gY29uc3VtZXIgZGV2aWNlIHJlc3lu
YyB3aXRoIHRoZSBob3N0Pw0KDQpZb3UgY2FuIHNlZSBhIGhhbmcgaWYgdGhlIHRyYW5zZmVyIGFy
ZSBvdXQgb2Ygc3luYy4gSWYgdGhlIHRyYW5zZmVyDQppc24ndCBjYW5jZWxsZWQsIHRoZSBkZXZp
Y2Ugd291bGQgb25seSBzb3VyY2Uvc2luayB3aGF0ZXZlciB0aGUNCnJlbWFpbmluZyBvZiB0aGUg
cHJldmlvdXMgdHJhbnNmZXIgYnV0IG5vdCBlbm91Z2ggdG8gY29tcGxldGUgdGhlIG5ldw0KdHJh
bnNmZXIuIFRoZSBuZXcgdHJhbnNmZXIgaXMgc2VlbiBhcyBpbmNvbXBsZXRlIGZyb20gaG9zdCBh
bmQgdGh1cyB0aGUNCmhhbmcgYW5kIHRoZSB1c2IgcmVzZXQuDQoNCj4gDQo+ID4gVGhlcmUgbm8g
ZXFpdmFsZW50IG9mIEJ1bGstT25seSBNYXNzIFN0b3JhZ2UgUmVzZXQgcmVxdWVzdCBmcm9tIHRo
ZQ0KPiA+IGNsYXNzIHByb3RvY29sLiBXZSBzdGlsbCBoYXZlIHRoZSBVU0IgYW5hbHl6ZXIgdHJh
Y2VzIGZvciB0aGlzLg0KPiANCj4gQ2FuIHlvdSBwb3N0IGFuIGV4YW1wbGU/ICBOb3QgbmVjZXNz
YXJpbHkgaW4gY29tcGxldGUgZGV0YWlsLCBidXQgZW5vdWdoIA0KPiBzbyB0aGF0IHdlIGNhbiBz
ZWUgd2hhdCdzIGdvaW5nIG9uLg0KPiANCj4gPiBSZWdhcmRsZXNzIHdoZXRoZXIgdGhlIGNsYXNz
IHByb3RvY29sIHNwZWxscyBvdXQgaG93IHRvIGhhbmRsZSB0aGUNCj4gPiB0cmFuc2FjdGlvbiBl
cnJvciwgaWYgdGhlcmUncyB0cmFuc2FjdGlvbiBlcnJvciwgdGhlIGhvc3QgbWF5IHNlbmQNCj4g
PiBDTEVBUl9GRUFUVVJFKGhhbHRfZXApIGFzIG9ic2VydmVkIGluIFdpbmRvd3MuIFRoZSBnYWRn
ZXQgZHJpdmVyIG5lZWRzDQo+ID4gdG8ga25vdyBhYm91dCBpdCB0byBjYW5jZWwgdGhlIGFjdGl2
ZSB0cmFuc2ZlciBhbmQgcmVzeW5jIHdpdGggdGhlIGhvc3QuDQo+IA0KPiBJJ2xsIGJlIGFibGUg
dG8gdW5kZXJzdGFuZCB0aGlzIGJldHRlciBhZnRlciBzZWVpbmcgYW4gZXhhbXBsZS4gIERvIHlv
dSANCj4gaGF2ZSBhbnkgdHJhY2VzIHRoYXQgd2VyZSBtYWRlIGZvciBhIEhpZ2gtc3BlZWQgY29u
bmVjdGlvbiAoc2F5LCB1c2luZyANCj4gYSBVU0ItMiBjYWJsZSk/ICBJdCB3b3VsZCBwcm9iYWJs
eSBiZSBlYXNpZXIgdG8gZm9sbG93IHRoYW4gYSBTdXBlclNwZWVkIA0KPiBleGFtcGxlLg0KPiAN
Cg0KVW5mb3J0dW5hdGVseSBJIG9ubHkgaGF2ZSBMZUNyb3kgdXNiIGFuYWx5emVyIHRyYWNlcyBv
ZiBHZW4gMngxLCBub3QgZm9yDQp1c2IyIHNwZWVkLiBJdCdzIGEgYml0IHRyaWNreSBjb252ZXJ0
aW5nIGl0IHRvIHRleHQgd2l0aCBhbGwgdGhlIHByb3Blcg0KaW5mbyB0byBzZWUgYWxsIHRoZSBj
b250ZXh0LiBJZiBteSBleHBsYW5hdGlvbiBpc24ndCBjbGVhciwgSSdsbCB0cnkgdG8NCmZpZ3Vy
ZSBvdXQgaG93IHRvIHByb2NlZWQuDQoNClRoYW5rcywNClRoaW5o
