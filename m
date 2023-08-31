Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3984C78E4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjHaDCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345603AbjHaDCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:02:20 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77659CF1;
        Wed, 30 Aug 2023 20:02:02 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ULPvYw003906;
        Wed, 30 Aug 2023 20:01:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=fVsBC7NiV9b9+81hDmbDTSty7GYrDoMgnMKp7ychiHA=;
 b=rxXMRo0dM88SpBcNfaswnvQ5xOBLR2qss7EOOBVUTIN9GGqnBZt01ddEZd7R+QBWXRtl
 ADWJ+FyluFcGFdeCXY8jKxrvRVSwQW9HfK8D9Vmr8tzELQWoHqEis4upe0L6htkj3M0I
 6aGEpJ8pcXqVWnvTpzAgCIampMqDzztdMd4ga1iqeN06IsCqa3P1Bg75RdJ9XfjOM0Bh
 RKjm8bYemf/VFApwf81sH0dEnidt8QWal6tnsHrIXAd5LKJ5ctE9jE59OyGlCMi0+3TL
 5mrjIiZgVscnJeunOtJwulDk9687W+c925VUEdSt51SXMYffRVbPZxUfMF8KrVL0tNqr 6w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sqgav05q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 20:01:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1693450906; bh=fVsBC7NiV9b9+81hDmbDTSty7GYrDoMgnMKp7ychiHA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Rk1neR7tDZsXuLwwdfVEZd2pFcEXyrI6PsEfhPEWicKoNW6AU5/1r/kuKWO5GS66L
         iwgK3UXtpN/uPqhplUWY7P+3B9XSx8qRhkZNd79qs05mW5Hi4lW0Qm30fdjhT9o3fq
         IL7Aj8pagFYbvBcTxpGSdXB5bM0jWVyKGkJrHhjKP1FUbxSHBHiajy3O4DNMCos0lc
         pJ0FvBs004ryIYuYaiefMYvXVIujI2KowhvwwKpBuL50oqfktoYrqIfj7TuJeZ0zq3
         YdyHNrgefMJokSVRjj35SWXpJ1/gOyebh6t9Blr8kfVaLSXtXfTVtNhRKCNRgLlHub
         6Bu2tb/Q3oAYQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3643840467;
        Thu, 31 Aug 2023 03:01:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 14F4FA006F;
        Thu, 31 Aug 2023 03:01:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=HvTBj7L/;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BB7FE40583;
        Thu, 31 Aug 2023 03:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJCZESirsP8wtR6AbIyJR8RMzFmRpbCxUTkY8fW/JkxckmdwuHAFjjKcNJXMkNDEypf9Te9Xk42EN9H6ikeT6Y8CEk552ni0siMKZbRHNRtieYEwkjMuq87nbW09kuteSeZabnuIAIoUhWnMKI+z+WDqY+IFcA8khTstw5jilcHWe1Lj4bJ8cIHrhpwg01uSXL7l5bZpbYM9Gj1ClVpic/MuF254Iw+4RCYbDw2WpktwUhAZqgn6+6+YKRT9jA3cl1N12o1qi4r02W1xuMa8L1SrP2ZtyEcRaM6bpL9tZQjURCP2Ov0WY53a+zp2+dBTrUyeK4gt64spj1iuP6ddPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVsBC7NiV9b9+81hDmbDTSty7GYrDoMgnMKp7ychiHA=;
 b=Pwk4C8CJP5i4ryenAXECRqo6LYtn6LLZN/C3tMbnvx/Y4JJjWmWb072JXfFDW97Pkak6iw43vRLds2d0OHuapSp5Nuy6f3ZkrQ57/dM+ogHaJp7Nwe+DzQ39mdwfWtzL+47A6GVEkWmQLmrRaiDoFpIqJ0AU7sPYwl1LJqoMpEWx9frblh79vHHFsnEiU7sQ+Qpwuf7Wl8N3s7I+J/X6tmXWW+/4Nlys2I2tLJB36QG84+bnNxLgBvLexbfeAPNeBStRJ/+nU8JGY8TEzIVDsRieGVfqweZtDuxot31Y2UiIEgmNRffmC9WF3CJv+aVwStbkcXuCCF/ucnuaKpzrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVsBC7NiV9b9+81hDmbDTSty7GYrDoMgnMKp7ychiHA=;
 b=HvTBj7L/mt7Bw8WUkKkdCI1kBLJtocIAxDVarZLz8W823jJMcM2lLOoy5RIQlxFbPg4SQIrFQMsHINGm57069Fji9GVGZHBJKByVs+vTWhRWGQXia/So2Wef6esx88JyWPl6Ar5iLuDY+do8eZTV/c3NCjG7tzjfggVOxtMYN7o=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 03:01:39 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::8dbe:70eb:1dee:71d2]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::8dbe:70eb:1dee:71d2%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 03:01:39 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Roger Quadros <rogerq@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Thread-Topic: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Thread-Index: AQHZzuBFIbiQId3K7UqIXmJcc9s6yK/sa62AgAQHiICAAPALAIAFqBsAgABumgCAABksgIAETzCAgABxe4CAA/1PgIAB1kOAgAAwoICAACr9gIABTioA
Date:   Thu, 31 Aug 2023 03:01:38 +0000
Message-ID: <20230831030134.z46fjwyr6edl3t7x@synopsys.com>
References: <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
 <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
 <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
 <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
 <20230826015257.mbogiefsbz5474ft@synopsys.com>
 <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
 <969988f6-f01f-0e31-6a98-7d02c5a3a4ad@quicinc.com>
 <20230830013739.srnh2uyhly66yvu2@synopsys.com>
 <d30a8d6a-236a-b6eb-76d7-115cc9950ce1@quicinc.com>
 <6f70a710-c409-23c0-890b-370ccd23e088@linaro.org>
In-Reply-To: <6f70a710-c409-23c0-890b-370ccd23e088@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|IA1PR12MB6410:EE_
x-ms-office365-filtering-correlation-id: 2af42ea5-10d8-4a6e-1880-08dba9ce9878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JYGOaXwb6CnbFkk/xSR/GNuZY3rgXrssWQMN8lPEtCA/zzxHW+nzzaUuL6QS4iTWW01CjzasfVCBIqdA/mleCkhLI9vLnmMZefBIX7HkytIKI8tfdr6IXYYNOp6ys37VBuXExWRBpe6FLgLR08xdy+/jtd4XI19heHlW5BXZ8Koj1xpDH4fhVkB6xN4OcLw9iwEuCI8z3v3zIhZU8n0vJDYcPssIamBCuoDcQFDpXNR2iFy+CXArEy0tG14gPXb5nhMQfFLpKx6R1CtrP9Db3H4VmjtgzIpm9XZccwGFu6kSYQhe+JgkD/j196r3h5bXHtQkmi2NKwvTYaxnJHJASIg5ZiNJZgzRshxhGP0W6rNgZdSvZVxeScfjEBWfST8iZQDk7wvsOtU+40+cU/kPqxxIUyra9KOQVgM9eTIAVsZ7/hVB3lDLuAHyj86C8Ku3UvHgqfINZxZNlMRNnm0mT9WMiWdJoXcnR+gI1B2gAWC3CqbuR3015oGn8i6AKnXUoaa0Yu+u1BCmFtvyrQrdH+0d6e4Dk+gEsIO0mucvkUUrRdfjcTWV8iaK9cmfLA5loy6Y2qKeTdEu41X5FnSg84ExZwcZjCsOCMEuPHRLMNlPiFsmLAim6F8bh4rQRxfL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199024)(1800799009)(186009)(71200400001)(6486002)(6506007)(6512007)(53546011)(478600001)(83380400001)(1076003)(2616005)(26005)(2906002)(7416002)(54906003)(64756008)(66446008)(66476007)(66556008)(316002)(41300700001)(76116006)(110136005)(91956017)(5660300002)(8936002)(4326008)(8676002)(36756003)(86362001)(38100700002)(38070700005)(122000001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUNPaysvUDh2Njc5blVyQXhZdlZ1czV6ZldHNXk1ZzZMMWVrcVFMb01SQXN1?=
 =?utf-8?B?N0k2VWlMV1ROUE5XUmRuM2xnSFpUNXoyczNXKzl2UThIN0FOVmVvYUk0UmRs?=
 =?utf-8?B?TEFKOUJzempFSGlqSDFlc0R6MjBoWkdBY2M1SXhJMjV3c2JxNThEaHZzR2NN?=
 =?utf-8?B?K2JEZW1FdXdNRFFobFluR3dlL0dHdFRoRWVuVmw5UldIcjlqbjgxNDZpaG9s?=
 =?utf-8?B?SnA3dkd3eTBKQ2VMbGpmMnJJdUJPSThKNFpvM1huUVk2QjV3cHpBZXhxdlNl?=
 =?utf-8?B?OFB4d0FScHExUVh2SHRkSjNjT2FKY2VSbjRQam9ITVZPUXlrb00vL3V2RTdE?=
 =?utf-8?B?QlhHb0xxcGxvMkRuZTJGa1hpUTVSdSswK0xOM0cyN3B1UFh2c1lmZVFsV1Jn?=
 =?utf-8?B?SHc5YTNNd1BUYmZ3eXI4aW45cmtJN21ENGt5c1RoNmx3clN3ckdtWHJzb0k4?=
 =?utf-8?B?SVNzQnF3U0tTN3p0eG5GRGR2VTdyczAyWlNnZjhsYlhzM1dFWCtkM3g5M3N4?=
 =?utf-8?B?bnFicmRlSUZyZnRrWHdNRXp1NUhQYzdxNml2eUVuT0kyUWZ5cWVoVEZVSVNO?=
 =?utf-8?B?YTRvZTNnSC96M0hHL1l0eHBtUjlML2o1K3JrMXBjM25oZSszMnVDOXh3U2t6?=
 =?utf-8?B?QnNEVTZHTEhST3VzTStJeWludStnRkFGRUVudHhyS1NUYmhsVXhjOWVoMmR1?=
 =?utf-8?B?R2tqQUhUWmprYUFoV0VjcFdiMWtVYnlKck4ya3JkUC9uSC9HR3QxeHIwUFVt?=
 =?utf-8?B?c3ZiVC8rekl2TUFOTU1UeXYyS0tvN3R3K3ZvOXNxNGE3cjdGQ3RkaElpcHkw?=
 =?utf-8?B?Z2EzcjRaZGU1VWloeU1ZVXI5S0tjNzZVTEUwN29vV29WalI0NEtjTkNmVXQy?=
 =?utf-8?B?UjNFaTJyTUhBVnpucEFKVXAvR1lBSENHU3Y3Z1BtWUF0N2czYVY0WjhUbVBu?=
 =?utf-8?B?eFZZaXpFVGVvOHN1dHdxSmcvdEd5ejI5TTVNRHZGYmlYVnk2TkkwQk9QOWt5?=
 =?utf-8?B?QklRQW1SSjEyMnplVlpaOXFKaTRDckZia1VxblJrVC9XZWRtZkdqNGtXdVN3?=
 =?utf-8?B?K2lXSWNjS0dHRzZVaVRFV3dhMjM2VnZIV0ZTUWpHbWQwdmoybFZadmFISEs3?=
 =?utf-8?B?cmlRMFNET0N5dzAyWGJ5SGgrdDYvZ3JQUkl2ZjdZOEdGOGtYMUY4VGFnOFhX?=
 =?utf-8?B?dDZQanRKemgvN3A3ZGU3TVhET2UxSEZqQkdOTnRXNlVMZzNCNzBsMG9TZVVZ?=
 =?utf-8?B?TFJIQ1JCUE1iRmdMSzRxMnVjczY3ZFpYK0ZZL2hPUFBvQXFoT21RZm95MjNh?=
 =?utf-8?B?RXg4MnZUOFJZS041em1ZQzE2RzNicU8yeWpYK1ZxRHp2TzEwQWdVYitMMS85?=
 =?utf-8?B?VFp4ekJ0b0ZmSlErdmRLU2ZHRy9qOGp3SVlPSU0xamJQOXBCSmM0QkxVMTdw?=
 =?utf-8?B?SElrdHh1RnlDeWsyRVp6bmgwSEo4ME5aem5XcE53MHR2TzhUeFg0Z24rZUxI?=
 =?utf-8?B?Zmh1aWZjT2I4QVM1ZjErUjJ5dWJEbmY1UlR6bFFKSUlDdS94UHNzZnhOTE90?=
 =?utf-8?B?QzAxL1dHd0ZlaXpRd214NktBN1FpdnQ5YmhuR2JrQVlGM0FmamVvM0tRN0pU?=
 =?utf-8?B?SWJERTB1M3RrL3dva3cvS3g3RWJQcEZCSXRPUFVVYUhKd3NuVlJackR1ZUZk?=
 =?utf-8?B?RCt6RmVYcW1FRUozNE1qaEIvK1pNNzV2eG5NM2U4YmZSWlhGTWJ1Mk9EWXF5?=
 =?utf-8?B?UkoyVDhyNVdpZW1aTXJvajNRaWs3b2phTUdkMFMrU2lvTHozaWZHeSthbyty?=
 =?utf-8?B?QUp5U2V4R1RHM3lzbmk3WHlpWUVSKzhnZlZpcHpLam5yTk9PcnFuUFFabUVl?=
 =?utf-8?B?NVZucnJHMFRXWkQ1SzdaWTNBOHhLNEltOERxaWF2L3Q4UXIvVWxFTUdjVVRY?=
 =?utf-8?B?WDJmb0ZxZWIvSVZBRzJNdHJMbDZ1YjJENUsxbTA4YVBrN0FSZHBsaWpkMEl0?=
 =?utf-8?B?Z29pcE92bE5EeEJiNUNFd2dSTWpnQ0ducFVRb3dvOTZ4YXI2MEVnQ2x1Si9C?=
 =?utf-8?B?OHZNbU5Zd05DeGkyQU52UE1FQlEwTFZadTBqdFhKQmY4b2lWMXh0SlVOMjJh?=
 =?utf-8?B?ZGZZWXl4WGcrOVNGTFR2Y2YyTmY5clZ2RzR1cXNDSHhTZi8vbnRqMERSYnBm?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <488F19394536C64CB339BDD77CE93364@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UHlLTDdCc1NUWUVlQXdGVk01U3BxcVBhbFh5RHJJT1dLdUtOZ3NucXB3bVRp?=
 =?utf-8?B?d21IK1VGWVU5S2tkWkw0T3dwMWZ5cndSZU03MGpRcWdqazJLc3Frcm1qQ0Ns?=
 =?utf-8?B?aGEyWHR3Z1NIZDlJQkpzODdORG1oM2tpaGl5UTA4T3BYbVZzaXZ6MTRxSEY2?=
 =?utf-8?B?NTFuaW1ZdWNEN3BVd1M1eHd3WlFvUWdNN2pzN2VmaW9ZU1FlTzVrbEFKTktt?=
 =?utf-8?B?VzVJdk81cHg0U0hVRUZ1ZXJFSHZTdzBrWlBoY2tLUEM1byttTWk2MEdQQkJt?=
 =?utf-8?B?b3ZCUnJ1RnNlUzJqSXc1UlV3WFlSV01rRWFQMHA5bXBnYklPbktkOWJMRTZ6?=
 =?utf-8?B?VnRIMEUvbTQ4TktRMWk2Z1RpTWQ2RjVSK2EvODJyYzE0RXI4OFM0SWVRNzRF?=
 =?utf-8?B?TU9saEc2TmpTaUpBdGtZN0J3MjRTTjlXSnBKQnpIL21VTzlVU3NzU2JSV1I5?=
 =?utf-8?B?OFBNT25HQ3ZRTWpucWdFS2lSdTJuQU1QeFpYSEhneDI5Y2xObEV5Tk9ZZjcv?=
 =?utf-8?B?c3hnWUJ2QnNqRW1LQXJtcnZVd296UzVkcHdvN0hIdUlRNFcwZlFXZjU2QThm?=
 =?utf-8?B?b3BsYWtJZmI0STVMYzdzL1ZtN3RWY0ttS3MzUVhyRG1Dc1pkWlFJeUZ0NHBy?=
 =?utf-8?B?emhWRE9pWVlXRXlsNm9Qb2pyWHJpbUp0SXdCZXArd0luMDdteHBZRW1hU1ZD?=
 =?utf-8?B?NlBtUzBDdnlSYkxLVUdYVXlTM1N3RDBlaFNrbFpFanJYNm9aK3p1V05tV1JE?=
 =?utf-8?B?eURJdDlwMUZCTnNUTEphbUZYb2xaVlVuZUJ4cWM2bE1vRG9UN0tSNzlhdzhF?=
 =?utf-8?B?MlJ2UG1hQm5BeFh5dWdUVS9nTlpGM2dPbWF3dXk1VTFIakl4TDdlZzNiYnV2?=
 =?utf-8?B?UnFnN25vRlduZFNGVzlmdzQzU0dZSnNOamZSZUl0czcvMU4wcTExeng5UGFV?=
 =?utf-8?B?YlJIeG5yaW1mTzhGUFMrTnkzQld5T2xyK2hVdGtWaWRlSUFORTFiVVVkN3FS?=
 =?utf-8?B?UUVzZzQyZUl3UU5kTVE2ODRibGRZUVdtelZmbTBPTml6YUovU0lsM3hLNm9N?=
 =?utf-8?B?UHgwbkdhU2E0SlQ5aGV4VDhDV2RXMG1oODdjMmN1V3ZuUmFsY3lDazA3dmZL?=
 =?utf-8?B?KzFwaVpxY2J6eGRBc3Zra1lzTmpBaTZuTkJybEV0eUxaVUZWOEJmenpLaFJO?=
 =?utf-8?B?bXhQODhQV0tCWVV2U2JKQllhYitNaEpOUkZqenptK0tOTzROSWswVDE3ZUFy?=
 =?utf-8?Q?Gg2iRuG/aS770O4?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af42ea5-10d8-4a6e-1880-08dba9ce9878
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 03:01:38.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWpA8hbBJCiuwzfOwKU6rmA4fbZunh9oP6rBXxNSi9sXlSLgt8IagOWuei3k6sURqTQs9DWd2YohHgUg1NCSTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
X-Proofpoint-ORIG-GUID: 0svy_sfQOwVUJzgDvCqve_2thST81nm_
X-Proofpoint-GUID: 0svy_sfQOwVUJzgDvCqve_2thST81nm_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_01,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=947 suspectscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMzAsIDIwMjMsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDMw
LzA4LzIwMjMgMDY6MzEsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBPbiA4
LzI5LzIwMjMgNjozNyBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+PiBKdXN0IHdhbnQgdG8g
Y2xhcmlmeSwgdGhlcmUgYXJlIGR3YzMgcHJvcGVydGllcyBhbmQgdGhlcmUgYXJlIGR0IGJpbmRp
bmcNCj4gPj4gcHJvcGVydGllcy4gT2Z0ZW4gdGhlIGNhc2UgdGhhdCBkdCBiaW5kaW5nIG1hdGNo
ZXMgMS10by0xIHdpdGggZHdjMw0KPiA+PiBkcml2ZXIgcHJvcGVydHkuIE5vdywgd2UgbmVlZCB0
byBlbmhhbmNlIHRoZSBjaGVja2VycyBzbyB0aGF0IHRoZSBkd2MzDQo+ID4+IGRyaXZlciBwcm9w
ZXJ0eSB0byBtYXRjaCBjYXNlcyB3aGVyZSBpdCBpcyBwbGF0Zm9ybSBzcGVjaWZpYyBhbmQgdGhy
b3VnaA0KPiA+PiBjb21wYXRpYmxlIHN0cmluZy4NCj4gPj4NCj4gPiANCj4gPiBUaGFuayB5b3Ug
Zm9yIHRoZSBjbGFyaWZpY2F0aW9uIFRoaW5oLg0KPiA+IFRvIGNvbmZpcm0sIHdlIHdvdWxkIG5l
ZWQgdG8gbW9kaWZ5IHRoZSBkcml2ZXIgdG8gcGFyc2UgYSBuZXcgY29tcGF0aWJsZSANCj4gPiBz
dHJpbmcgKHNheSAic25wcyxkd2MzLWV4dC13YWtldXAiKSBhbmQgYWRkIC5kYXRhIGZpZWxkIHNv
IHRoYXQgdGhlIA0KPiA+IGRyaXZlciBpcyBhd2FyZSB0aGF0IHRoaXMgcGFydGljdWxhciBwbGF0
Zm9ybSBzdXBwb3J0cyBleHRlcm5hbCB3YWtldXAgDQo+ID4gZGV0ZWN0aW9uLlJpZ2h0ID8NCj4g
DQo+IE5vLCBpdCdzIG5vdCB0aGVuIHBsYXRmb3JtIHNwZWNpZmljLiBZb3Ugc2FpZCBpdCBkZXBl
bmRzIG9uIGVhY2gNCj4gcGxhdGZvcm0uIFBsYXRmb3JtIGlzIFF1YWxjb21tIFNNODQ1MCBmb3Ig
ZXhhbXBsZS4NCj4gDQoNCkhpIEVsc29uLA0KDQpVc2UgdGhlIGNvbXBhdGlibGUgc3RyaW5nIG9m
IHlvdXIgcGxhdGZvcm0uDQoNCmUuZy4NCmlmIChkZXYtPm9mX25vZGUpIHsNCglzdHJ1Y3QgZGV2
aWNlX25vZGUgKnBhcmVudCA9IG9mX2dldF9wYXJlbnQoZGV2LT5vZl9ub2RlKTsNCg0KCWR3Yy0+
bm9fZGlzY29ubmVjdF9vbl91c2Jfc3VzcGVuZCA9DQoJCW9mX2RldmljZV9pc19jb21wYXRpYmxl
KHBhcmVudCwgInFjb20seW91ci1jb21wYXRpYmxlLXN0cmluZyIpIHx8DQoJCW9mX2RldmljZV9p
c19jb21wYXRpYmxlKHBhcmVudCwgInNvbWUtb3RoZXItcGxhdGZvcm0iKTsNCn0NCg0KWW91IG5l
ZWQgdG8gZW5oYW5jZSBkd2MzX2dldF9wcm9wZXJ0aWVzKCkuIFRoaXMgbWF5IGdldCBiaWcgYXMg
ZHdjMyBhZGRzDQptb3JlIHByb3BlcnRpZXMuIFBlcmhhcHMgeW91IGNhbiBoZWxwIGNvbWUgdXAg
d2l0aCBpZGVhcyB0byBrZWVwIHRoaXMNCmNsZWFuLiBQZXJoYXBzIHdlIGNhbiBzZXBhcmF0ZSB0
aGlzIG91dCBvZiBkd2MzIGNvcmUuYz8NCg0KVGhhbmtzLA0KVGhpbmg=
