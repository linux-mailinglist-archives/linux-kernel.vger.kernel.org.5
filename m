Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62DF7F5BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjKWJxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjKWJxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:53:08 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78411705;
        Thu, 23 Nov 2023 01:44:57 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN5WCsD015549;
        Thu, 23 Nov 2023 01:44:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=/nsaitrIU6rklJBYx3CeC9xgPbtR7umNKItSWwF0fH8=;
 b=CCKur3h7U9etrODjAhqtTgzdPUDDMvlqxBA+eSbQ81pjOi7BrtzeAvAHQf1nS7XUJIwg
 OCmNdI+5jae3xMRV7uHAa5UfVjIgDfD8uc+10oNTdWBrbRBQaA7E/OX4hpTPfejoBUcC
 CJFQqKBY3Xlz3I1vT2dh0rSXTdYqjhV2mnaElaOWJnLO7/1iunsAFuGcHx8s/wt+mbon
 TLpigUTksHk766EsIuRtpIidB37+uqTLpzCxklbYylD9JLyY08FWNs5r4pT1DnyYkoMm
 N6ykzmHk+DTA3J45LeVQtBmzJnz8GNNJCFDY7oV5lih1nBzY1JN8sjTtxcJpefFQl13k RA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uew5wx8ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 01:44:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1700732659; bh=OkMUnR2dRYRoR6b62o5Sk45SAe6bNnGELrzDjZG3h1g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=k5Snuzf2CKsZDtwIw32f9GGPzuTU9CK6bFhytqgq+InupB7BPjRqLgYP7q+8Lw4h4
         4zFJFcqcGJOepeCMTkFQJvhopwS+rmu11dQyqfbdoNmDP/gI1U+lbG7dOgPyrawCy6
         Mul+JFyryhx3RYYUWstBHvVowOfZNAO2jAts5CX4++/jB/y3k+kdBXO6C4HmJaRYbj
         6Iqh/RMwy4xJHgByRrkvdzh0S9T8Hu29NsD8GbJyYgB4b3mn6moDCbYKcUkvIWyaxS
         HxtSpgneTeV4/R59DyUlP8Fs+mkduUpxJm5PMMw0e4egR7p4N0xNpHZzn09WFYn+IZ
         Us/R1kXrS2p9A==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8F3CC40138;
        Thu, 23 Nov 2023 09:44:15 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 67F81A0072;
        Thu, 23 Nov 2023 09:44:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=owtgzHsN;
        dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5B8D940127;
        Thu, 23 Nov 2023 09:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpJJPPTBhMZ/kTmfgDIEKDNlvloY11aIZdue5Da7prUW8TLHv2G4kGIRewuGAK7uG82XeBzYc0fvMQdajP9W2hXRg7tQNLe6sU71JuWLVJomzMbAUE1Zp0Kzz7M5e74ecHzXCRjcNNniTedG/+lZevOSOEofprAfRu/Coc7tYdsNAEl7QmQIommPAGSBdRvnaNwEU5rjc4FQKb/Ekb1+ZNQ9SwOrFtDl5QGW9hijn5XCZ67PxWh1povpODwQCBHSrxwPRZM9z6RJeiI7aDvUzuCzpS6X9V9vMRWTOK4wkLOB7MLKvvkKMO/LLxQ5aVxnv5aGLZC/Sd9ea22Q0VRl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nsaitrIU6rklJBYx3CeC9xgPbtR7umNKItSWwF0fH8=;
 b=FlOD87HschKKDE6aH59e3lPmYhBDondyD7nCPqju3yPw9iw7jHMhxaKPhgHusqO1CpvmAL9iO3ORHLf6W408v7dfhtnNRs5DkChvSjv6/qxtvHEvjPXJb6Tl1sAIN2c6wbTKDTTyKKGcNqJ6fVs6kdhesIsueNUhy26MZIpa4IxcMtY11GNpQQq9jYWcjKHqLSe2LQRHPc0XpujyUwDk5H7gbMsOPpOs9nSK1yehbt2OgxjtwMi4M2pzT7jiAmoRespNO1hEDGWBQe61s1QceAVHqytQX+RHashr6wXyy0ocibL6+bp7sS2AfB0PA8357v/4QQWksvBL5sea+EsJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nsaitrIU6rklJBYx3CeC9xgPbtR7umNKItSWwF0fH8=;
 b=owtgzHsNmhTwBpwquiPLqLsI4mLv5Z1k65NM1VASwUyzn1dDlA3kKVTrwsZJoGtDmjLyiT+xLMl/lNa9bDxhzBP9TYqYAlBYjAX/scQTzFkQHcUGwemr3Br79aVMAMtLgEayjqb5ZmY6U4YqhqydjGFW2Xf4J+7hiVD2B2Yee8Q=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 09:44:08 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 09:44:08 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: RE: [PATCH] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH] net: stmmac: fix FPE events losing
Thread-Index: AdoW3Xfb3QHiuCaqTA2ROZ4444S4MgAFJ5GAADdg94AAAqmPIAEgkfEQAAW/RAAAKGjdgAAQG94AACbGoFA=
Date:   Thu, 23 Nov 2023 09:44:07 +0000
Message-ID: <CY5PR12MB63729B1EE424490BE0410664BFB9A@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
 <xo4cbvc35zewabg4ite73trijy6fvbsaxsy6hag5qsr3dyharm@predjydxblsf>
 <ZVTU4TTFYSMLswTs@shell.armlinux.org.uk>
 <CY5PR12MB63727BAD92930CB04DE4DB52BFB1A@CY5PR12MB6372.namprd12.prod.outlook.com>
 <CY5PR12MB637235F27E5114CFB4DE1AD3BFBBA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <aicr2gv4aqsgam4nc4wahacyakwn744xx52uojfkn7fjtd26pt@6lxmiizwkrqk>
 <CY5PR12MB637274F20E0AE776A315A79FBFBAA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <j5i4j343zqsuyubexjj4gqsz4ol3c7wmjpnsbxg5x4vzvtk7ni@uta6ssp4oj2a>
In-Reply-To: <j5i4j343zqsuyubexjj4gqsz4ol3c7wmjpnsbxg5x4vzvtk7ni@uta6ssp4oj2a>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|IA0PR12MB7697:EE_
x-ms-office365-filtering-correlation-id: a2d9ed9e-90ea-4c24-8978-08dbec08bcf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qyVPZYKrpFJ1h3RKie+1P+gEK69ky53z+USwp7tElCplTD2+3/sUBznHOqZ8ukWO6rmdPl/vkPiYaQDkyMpwv57ajspXdmjDHErXlJBPrybQm37B74ZCB+UXYGZYCfbAdaBi80A6Q2nTj4tCyZitbx3LGBGIQcC0axag4wKHHQcZJrqI1dUdPC7M3hX+Zk/TwVa15kgwqwh8gNEDvlGsxU1btxVwSYlZXLzE4oCpjenO5an0YrqCpflwvoAJ7s16rJUYn3VWkH92KM8Sm5gjRqKzWC6N5xxykR9zHqkcUHuFNmpgCefHxz66aYGf0oo66oVa0fCzBIXDyN/cqX6AKoSvgqLRVw1spqL/jagmb8xnuNJ00JRlu+uFb6DIvnsLUGOw9yODp9QKyXyXpqPhcod90b9IlepXHQTgpL0XFXjTm/qjJe2k0x0rlF8L2AdJM0iHSv5fi3bQ5n6Qfw+lD+w3atPE219MrNEJp9LOWT9moBu+dEIT4Oecn6OzqMbGrrJX8jsq32veddk/q/1KphHEnThSl14GM0YTqzI2ixQ53yRe8JnMCz8JzqNYu3vNaQ6Ym9/0tC/2yedgzdxSPwjE5qCovG0YVb+5LzUpUA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6916009)(316002)(54906003)(66556008)(66446008)(66476007)(76116006)(64756008)(66946007)(9686003)(53546011)(7696005)(6506007)(71200400001)(26005)(107886003)(478600001)(38070700009)(38100700002)(122000001)(33656002)(83380400001)(86362001)(966005)(52536014)(30864003)(2906002)(55016003)(7416002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VGJzdHA4UkFpMzRDWVVmdTAxenR4RDNzRFlHaUlPSk1jbnJtMzA3dkcy?=
 =?iso-2022-jp?B?TGVaTVJ3Y1pRTEI0VW5FaDFpL3lGVURGREd1dGxFc2JBZFBEaGRvZzJR?=
 =?iso-2022-jp?B?eDBJZTBIT3AzWkMySWNsNERSOFp1YllBSWdtWVk0YjV1ai9NenZOdTd1?=
 =?iso-2022-jp?B?QVJOUXVKTGd3RDBKSlhtUWwzY0h5Q2YzRDJwa0U0dEFqSFk3aXAzdUJo?=
 =?iso-2022-jp?B?cFl3NHRjY3E4NXlCNFlscGJXS3BvQmp4bUlpRkFGN2s1dkZMemQvVUlx?=
 =?iso-2022-jp?B?TzlTVmZLNjQ4cnQyMVFSTjZFOW84UXFtcTdMV0tLbmR1RVd6N1NtSlY3?=
 =?iso-2022-jp?B?bk9McEMvSkhYYkV2TXhtNmE2ZW55L09raWRLaWRLNEEyOEJVRkUxazF0?=
 =?iso-2022-jp?B?QU55QUNwZmhMTzNyd016WnJFWC9kN0ZoYWM0RVRzd3RtRkZhQi9zKzhH?=
 =?iso-2022-jp?B?d0tyOEJvWlVxazBva0RIcXBWdWpISmVhbWFzbEsxdXRKYU1XR1FVWHRQ?=
 =?iso-2022-jp?B?dG5KdlRLSkVDYnN4Y05yRHpZSXBWaGVQVk9jNng1SUdPTElYaDZCeXVT?=
 =?iso-2022-jp?B?bEtmK2NVNEt4SVRNanFGa2NCNlRlRVdLaDRUYUJObGhUcFhyS1VLT0la?=
 =?iso-2022-jp?B?WTFpTEdhRURtWGdTQVplUEtyM2tIVDR1aSt2MjZNcXpwWEE1YzZGYTYr?=
 =?iso-2022-jp?B?RTFuSW9QZjVoNVdOZWpvRHZkaDlhdU13KzN4Y2NhL0Q1RGdTTWF1Smgv?=
 =?iso-2022-jp?B?NG9XY2x3YjNjbnV2WDlVSEU4UWNZWHNJUVl6RDc3c2pxK3BrdFA5eUlQ?=
 =?iso-2022-jp?B?c2U0MVpxcVYycEU3ZTVVRllLYzZPc21HZ21oK2NzcG9kOHBTbTdNZXUv?=
 =?iso-2022-jp?B?MHpmTjJ0c1hsd2d5V1ZrMkRtOFJZcnFDdEhiUVNWUkpTYk5KNnF0MHl6?=
 =?iso-2022-jp?B?akNweDNMWVFxRi9NQXdPbFIxYWZoUkh2cDRVb0RnclBDK1BHMEt4VmFq?=
 =?iso-2022-jp?B?emZOTlE2YThvK3BkR20rOEViaGlybHNySWFmbVd6SytmclNMWkZrYXJM?=
 =?iso-2022-jp?B?cDE3YmJxOXJ1Qm5CN1dXUEtrd3BRTVhWVkF3b2RGVFU3ZDlmc2EwRHhw?=
 =?iso-2022-jp?B?VVp6eWhTcGxITE1QM3FTcm1KdWM1d3JwZG5yRVJ2K2RxRkZtTEVVWnpW?=
 =?iso-2022-jp?B?bDZWZTZ4TWN1YlIvbFV0WTRxV1FVRFJpT2VGWWZLN2Z1bzE4QkRRQ1ZY?=
 =?iso-2022-jp?B?U0NwNWxPTlhhYWFOM0FDR2FLZjVrSEkySHZFYmpOVWFPYStjMUc0WHQ5?=
 =?iso-2022-jp?B?Szc5TTJSRDRkbjZLRU9PakV2bTd0ZHBvQTdDTTlpMlR5YklJRGlRVWx2?=
 =?iso-2022-jp?B?ekRQVnFNMmhRbkVHRlVFaEVGQ1Z1bnU1OUVRdVZOc0VSM0wvN3NhSlFr?=
 =?iso-2022-jp?B?OGcwOFIxQkhHK3pxUE1lTHBnYXZySldqOFNrMjF6QURYQUlNQ21GeVN5?=
 =?iso-2022-jp?B?RTNYZENxQ1RZaG9IRWg2Umhpa0o0RnY1bkdxQndiNDJjRFlpRTV3YkxL?=
 =?iso-2022-jp?B?N1RhZW0zQ1QyTm12K0R6Z2FsQnNzbXFzam9palJtdjBlS3UyTDB6c1lv?=
 =?iso-2022-jp?B?RHgvbTZrVXpSZFM2SlRLcUpaSFIwNzEvL2RnOXp5NlU0akNLY2lOcTVv?=
 =?iso-2022-jp?B?ajk4M3I2REhZRkMzcXBUd1FESWhYS0kzWDgxdVRPL252NzNWUjM1VUJY?=
 =?iso-2022-jp?B?ZHZnQ21zNkxDamJWYlpWNXpqOTdwelJjNEVqblN6WkUwbmhoWFh6RkFJ?=
 =?iso-2022-jp?B?ZHNSVU1tYmdWa25kSDdNSlN0K1VLbEZqOHdPUTJINnduaEV5QnhhTDgx?=
 =?iso-2022-jp?B?bGF3NHVUbVJHQXBoejkrRVFEWGRkc1NvdHpuWVdNM2RhdUJ5eVczc0RE?=
 =?iso-2022-jp?B?Y1g0aTl5ekI4N1dQNnBjdjh1VEkvQ3RDZnBUNUZXcnlwTm4vdkVRZVBW?=
 =?iso-2022-jp?B?RTlvTmdYM2hPdHlNVmJDYndKa29QdG1OQzE3Nnczdk5PSEJ6djNHemEr?=
 =?iso-2022-jp?B?eVB4N1MvMm0xTjZtN2srV1lrSFRPUWpSQjF1Z1FJWmtTRmI4Z2tlVjB4?=
 =?iso-2022-jp?B?TThWdFJQelRPNW0wTng1WnlxMHd6aFR4T2NuMUdMV0Rjdnp4SDZLaHRM?=
 =?iso-2022-jp?B?Q211dXh1TU5UNTJGczJxVlJJUTNHNnBuSElDSEFhY21iRUhPWHhIRkUx?=
 =?iso-2022-jp?B?NDFPczRkL2hQT0xnekZnVm8zUURmN3crUnNUMGRSMDN6blBKdFRxVjJq?=
 =?iso-2022-jp?B?SjNCOA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?emJFMDR4dGV6QTZ4c0IzYWxlMjlSNkllTWx3YVEvc2lBVllBdWRwOUF5?=
 =?iso-2022-jp?B?V2doYmFEOFVOaUV3WiswRjVlbTZ2SFNialJMNGZxdEpsSEtlL29oMnNS?=
 =?iso-2022-jp?B?L0VVN3FQQyswQlpyMjBsOUVROTFMWlFLNWZyN2VSdENUcktZcFkzSzRS?=
 =?iso-2022-jp?B?bzFhbkNWbW9QWW9lTkhJc2VkdDBQVTB1WW1QdkdUNmZnbVNXU3pIQUdn?=
 =?iso-2022-jp?B?WXBWNkp6UTZRaG5GNWJJOXlld0pnWDBmZkgxSDlHcHNpcytXcW5kWlZi?=
 =?iso-2022-jp?B?T096bnJidTdRdTA1NitqZVE0Q0dUN3l2cFczNUdxRnRyQlNndnVoeEE0?=
 =?iso-2022-jp?B?Y3B4SFBqOVVCdzhzNXZyc0VKdUJSNGgycTRlZ3BzeW9MWnNnRHFSUEtP?=
 =?iso-2022-jp?B?N1hsTW1tUnVtUiszbnhiM2hacUlIaWlSaHFabklhSnFESmhCM0dMRmts?=
 =?iso-2022-jp?B?R1NWSVFHVCtscExXZnRSMEVqdXV4UVRrdmFUb2dXTjRNMWpQdzViR0tl?=
 =?iso-2022-jp?B?aWNHbkV1cE11anlMc0ZqSkFjR3lqcUxrcG1mNU1qVkFCMmlGdE9FVzZY?=
 =?iso-2022-jp?B?bjFqYU5NcU9mZWZmaEU1VXJYMytGTVN0VWdLbjMzdDVkYWJJU0N4dng1?=
 =?iso-2022-jp?B?UFlnM1I3QnBxN2h0UGNYT1FuR1FqUlJHSERwcllIU0FRdGg2bTdlQXBI?=
 =?iso-2022-jp?B?a21DNnpMS3pYemZRTmxuS2RabU0xZFJIaFV1azlyUXNrNWNuclphK3hm?=
 =?iso-2022-jp?B?ZUQrN2kxbWFYWHBYVExMdERKMk5aTHY2UjhDWVAzVmlqVm9HTVl2VVBZ?=
 =?iso-2022-jp?B?OHExazI1OW5TZmNxVGJiamN2V3BpK3RYTTZLTEdGWVJaTUppd2hFa1Fp?=
 =?iso-2022-jp?B?ZFJiYlMvSVF1c1YvZGNqamtBRGE3N0JkMG5Ib2hzcEt6TnVBRlFXMklj?=
 =?iso-2022-jp?B?ZnZwUEhLWndHT0pCQk9SOUJxdENhK2ZRZ2FvVEp6M2ZuM1NNUHdCV3JV?=
 =?iso-2022-jp?B?Y2o4US8zNWVzaWV0czRmTlBKZExJd0lHR0Q5LytCTGRKaTFodXJITDlr?=
 =?iso-2022-jp?B?Rk9oYXBMdlllYzFVWEt3b1pkODhWK1huU1VSTGJIMGNoVVNTK0c5TDJW?=
 =?iso-2022-jp?B?UmNRdXdEV3BTY2poWDlSdXVNajNaTmIzamx0RWJ5TXJXOUkzM3YyQmk3?=
 =?iso-2022-jp?B?MjA3QnMxdUdaUnk2eFFDVUNnV09tdHcwZGlwMUI3dEZzT0hwOVZWb1No?=
 =?iso-2022-jp?B?cDZBT1dRczR4TnpVR0NkMXlwSnFteWpBNDdvVjE3OUJHWkVVR2JudFVI?=
 =?iso-2022-jp?B?UXYrOE1JWG83bktTbnJhUEpWeFU0NVI5UVhnODJDWm9jN2VIUjU2QW5u?=
 =?iso-2022-jp?B?Z0Q2T2NQUnBBVUZ3M0NGRG5pRkJzeVRReXoxU0cxaUpwdmJiZytUUXJu?=
 =?iso-2022-jp?B?WXZOMVRETnRnVVpIN1RGSnBDdFpxc1dYd0lVUk80Uk9MZzU1S2dhcEw5?=
 =?iso-2022-jp?B?RFlNVDhKcG1qWHBGVERYbFBHeDlraTJwQ1Zyc1RxWGtuTzFFcWVEZ2dE?=
 =?iso-2022-jp?B?cEpESnI1VFp2RVF5MFB6UnRhQ2hhTjRDUXVFTmRwbzhUTENXc3FvK2hh?=
 =?iso-2022-jp?B?MzI2WWdTQXRGN2JSUVFtL251V1ZpdjVjd09rUkF5amlYNkpWaFpvWjhk?=
 =?iso-2022-jp?B?cXhob3grSHhKWDQ4VGJtclVGNEk4ZU1RbjM4TDJTZndjUjhOS0M3ag==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d9ed9e-90ea-4c24-8978-08dbec08bcf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 09:44:07.7327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQ424JKGNZ9dK54v6NZ11UWIH5JokFej5wrVH6O7/KflHcm/iV6HI0N8kg7bJ5mSefHwVh0XvDwiyXVKbb9AIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
X-Proofpoint-GUID: oxxDVrpsSnvDsqNj6T2LuJdbIMG5hmt0
X-Proofpoint-ORIG-GUID: oxxDVrpsSnvDsqNj6T2LuJdbIMG5hmt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311230069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Wednesday, November 22, 2023 11:07 PM
> To: Jianheng Zhang <jianheng@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>; Alexandre Torgue <alexandre.tor=
gue@foss.st.com>; Jose
> Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>; Eric=
 Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pab=
eni@redhat.com>;
> Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@int=
el.com>; Ong Boon
> Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>; =
Mohammad Athari Bin
> Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradea=
d.org;
> linux-kernel@vger.kernel.org; James Li <lijames@synopsys.com>; Martin McK=
enny
> <mmckenny@synopsys.com>
> Subject: Re: [PATCH] net: stmmac: fix FPE events losing
>=20
> On Wed, Nov 22, 2023 at 07:37:51AM +0000, Jianheng Zhang wrote:
> > > From: Serge Semin <fancer.lancer@gmail.com>
> > > Sent: Tuesday, November 21, 2023 8:09 PM
> > > To: Jianheng Zhang <jianheng@synopsys.com>
> > > Cc: Russell King <linux@armlinux.org.uk>; Alexandre Torgue <alexandre=
.torgue@foss.st.com>; Jose
> > > Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>; =
Eric Dumazet
> > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni =
<pabeni@redhat.com>;
> > > Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan=
@intel.com>; Ong
> Boon
> > > Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.co=
m>; Mohammad Athari
> Bin
> > > Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infr=
adead.org;
> > > linux-kernel@vger.kernel.org; James Li <lijames@synopsys.com>
> > > Subject: Re: [PATCH] net: stmmac: fix FPE events losing
> > >
> > > On Tue, Nov 21, 2023 at 09:31:31AM +0000, Jianheng Zhang wrote:
> > > > > From: Jianheng Zhang
> > > > > Sent: Thursday, November 16, 2023 12:01 AM
> > > > > To: Russell King <linux@armlinux.org.uk>; Serge Semin <fancer.lan=
cer@gmail.com>
> > > > > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu <=
joabreu@synopsys.com>;
> David
> > > S.
> > > > > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;=
 Jakub Kicinski
> > > > > <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime Coquel=
in
> > > > > <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@intel.com>;=
 Ong Boon Leong
> > > > > <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>=
; Mohammad Athari Bin
> > > Ismail
> > > > > <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > > > > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.=
infradead.org;
> > > > > linux-kernel@vger.kernel.org
> > > > > Subject: RE: [PATCH] net: stmmac: fix FPE events losing
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Russell King <linux@armlinux.org.uk>
> > > > > > Sent: Wednesday, November 15, 2023 10:26 PM
> > > > > > To: Serge Semin <fancer.lancer@gmail.com>
> > > > > > Cc: Jianheng Zhang <jianheng@synopsys.com>; Alexandre Torgue
> > > <alexandre.torgue@foss.st.com>;
> > > > > Jose
> > > > > > Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.=
net>; Eric Dumazet
> > > > > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo =
Abeni
> <pabeni@redhat.com>;
> > > > > > Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.m=
in.tan@intel.com>; Ong
> > > Boon
> > > > > > Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@in=
tel.com>; Mohammad
> > > Athari
> > > > > Bin
> > > > > > Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.o=
rg;
> > > > > > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@list=
s.infradead.org;
> > > > > > linux-kernel@vger.kernel.org
> > > > > > Subject: Re: [PATCH] net: stmmac: fix FPE events losing
> > > > > >
> > > > > > On Tue, Nov 14, 2023 at 02:59:57PM +0300, Serge Semin wrote:
> > > > > > > On Tue, Nov 14, 2023 at 11:07:34AM +0000, Jianheng Zhang wrot=
e:
> > > > > > > > The 32-bit access of register MAC_FPE_CTRL_STS may clear th=
e FPE status
> > > > > > > > bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS co=
ntrol bits to
> > > > > > > > avoid unexpected access of MAC_FPE_CTRL_STS status bits tha=
t can reduce
> > > > > > > > the FPE handshake retries.
> > > > > > > >
> > > > > > > > The bit[19:17] of register MAC_FPE_CTRL_STS are status regi=
ster bits.
> > > > > > > > Those bits are clear on read (or write of 1 when RCWE bit i=
n
> > > > > > > > MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
> > > > > > > > MAC_FPE_CTRL_STS control bits makes side effects that clear=
 the status
> > > > > > > > bits. Then the stmmac interrupt handler missing FPE event s=
tatus and
> > > > > > > > leads to FPE handshake failure and retries.
> > > > > > > >
> > > > > > > > The bit[7:0] of register MAC_FPE_CTRL_STS are control bits =
or reserved
> > > > > > > > that have no access side effects, so can use 8-bit access f=
or
> > > > > > > > MAC_FPE_CTRL_STS control bits.
> > > > > > > >
> > > > > > > > Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner=
 hand-shaking procedure")
> > > > > > > > Signed-off-by: jianheng <jianheng@synopsys.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 12 ++++++--=
----
> > > > > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > > index e95d35f..7333995 100644
> > > > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > > > @@ -716,11 +716,11 @@ void dwmac5_fpe_configure(void __iome=
m *ioaddr, u32
> num_txq,
> > > u32
> > > > > > num_rxq,
> > > > > > > >  	u32 value;
> > > > > > > >
> > > > > > > >  	if (!enable) {
> > > > > > >
> > > > > > > > -		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > > > > > +		value =3D readb(ioaddr + MAC_FPE_CTRL_STS);
> > > > > > >
> > > > > > > Note this may break the platforms which don't support non-32 =
MMIOs for
> > > > > > > some devices. None of the currently supported glue-drivers ex=
plicitly
> > > > > > > state they have such peculiarity, but at the same time the ST=
MMAC-core
> > > > > > > driver at the present state uses the dword IO ops only. For i=
nstance
> > > > > > > the PCIe subsystem has the special accessors for such cases:
> > > > > > > pci_generic_config_read32()
> > > > > > > pci_generic_config_write32()
> > > > > > > which at the very least are utilized on the Tegra and Loongso=
n
> > > > > > > platforms to access the host CSR spaces. These platforms are =
also
> > > > > > > equipped with the DW MACs. The problem might be irrelevant fo=
r all the
> > > > > > > currently supported DW MAC controllers implementations though=
, but
> > > > > > > still it worth to draw an attention to the problem possibilit=
y and in
> > > > > > > order to prevent it before ahead it would be better to just a=
void
> > > > > > > using the byte-/word- IOs if it's possible.
> > > > > >
> > > > > > Yes, this exists for configuration accesses, and is damn annoyi=
ng
> > > > > > because the read-modify-write of these can end up clearing PCI
> > > > > > status register bits that are W1C.
> > > > > >
> > > > > > I've never heard of that problem with MMIO though.
> > > > > >
> > > > > > --
> > > > > > RMK's Patch system:
> > > > > >
> > > > >
> > >
> https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches=
/__;!!A4F2R9G_pg!ZnsQc
> > > > > >
> > > > >
> > >
> 7LKbdCiIj_nLBkt44MRSL8W8YD4WvMmPNkHFlDMrjrVqEVOVA1-P-9BVE3Oa5bC1ymKXLNV5C=
9mJ_rfFtLW
> > > > > > Fg$
> > > > > > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at las=
t!
> > > > > Thanks for all your mention about the potential risks of using re=
adb and suggestions, I'll consider a
> > > new
> > > > > solution and update the patch.
> > > > >
> > > > > Best Regards,
> > > > > Jianheng
> > > >
> > > > Thanks for Andrew's suggestion. I consider the solution of set
> > > > MAC_CSR_SW_Ctrl.RCWE carefully and found that the MAC_CSR_SW_Ctrl.R=
CWE
> > > > is efficient for many other interrupt status registers, and some ar=
e used
> > > > in current stmmac driver (LPI PMT MMC etc). Those registers work fi=
ne in
> > > > clear on read mode with current code. So, I think there is no need =
to
> > > > set MAC_CSR_SW_Ctrl.RCWE that will make a large impact to current
> > > > interrupt handler.
> > > >
> > > > I try adding a new member variable(staged_fpe_state) to stmmac_fpe_=
cfg
> > > > that is used to stage the MAC_FPE_CTRL_STS value read in
> > > > dwmac5_fpe_send_mpacket(). And in dwmac5_fpe_irq_status(), use this=
 staged
> > > > value and current value of MAC_FPE_CTRL_STS to check FPE status. Th=
e
> > > > draft patch is below.
> > >
> > > Are the status flags in the MAC_FPE_CTRL_STS register cleared on
> > > _writes_? (I am asking because for some reason my DW QoS Eth v5.10a H=
W
> > > manual has the status MAC_FPE_CTRL_STS flags marked as R/W, which is
> > > weird access mode for the status flags.) If they turn to be _not_
> > > changeable on writes, then what about just converting the
> > > dwmac5_fpe_configure() and dwmac5_fpe_send_mpacket() methods to alway=
s
> > > writing to the MAC_FPE_CTRL_STS register, and if required preserve th=
e
> > > shadow control MAC_FPE_CTRL_STS flags in the stmmac_fpe_cfg structure=
?
> > > AFAICS the only flag which needs to be preserved is EFPE - "enable
> > > FPE" flag.
> > >
> > > Such implementation (if it's possible) shall be free from the _status=
_
> > > flags race condition and won't require additional serializations. On
> > > the contrary your suggestion AFAICS causes unresolved race condition
> > > in here
> > >
> > > > +	value =3D readl(ioaddr + MAC_FPE_CTRL_STS) | fpe_cfg->staged_fpe_=
state;
> > > > +	fpe_cfg->staged_fpe_state =3D 0x0;
> > >
> > > and here
> > >
> > > >  	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > +	cfg->staged_fpe_state =3D value;
> > >
> > > Depending on the IRQ handling and the task scheduling timing you may
> > > end up with loosing the status flags anyway.
> > >
> > > * Note I am not concerning here the MAC_FPE_CTRL_STS control flags
> > > * race condition which AFAICS already exist in the current frame
> > > * preemption code. See the configs performed in the open/close/suspen=
d
> > > * methods, in the link state change callbacks, in the worker task and
> > > * in the FPE status IRQ handler. Control flag accesses don't look
> > > * coherent there.
> > >
> > > -Serge(y)
> > >
> > > >
> > > > Best Regards,
> > > > Jianheng
> > > >
> > > > [PATCH v2] net: stmmac: fix FPE events losing
> > > >
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c      | 9 +++++++--
> > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.h      | 1 +
> > > >  drivers/net/ethernet/stmicro/stmmac/hwif.h        | 1 +
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
> > > >  include/linux/stmmac.h                            | 1 +
> > > >  5 files changed, 15 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > index e95d35f..8917fd0 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > @@ -736,12 +736,15 @@ void dwmac5_fpe_configure(void __iomem *ioadd=
r, u32 num_txq, u32
> > > num_rxq,
> > > >
> > > >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device =
*dev)
> > > >  {
> > > > +	struct stmmac_priv *priv =3D netdev_priv(dev);
> > > > +	struct stmmac_fpe_cfg *fpe_cfg =3D priv->plat->fpe_cfg;
> > > >  	u32 value;
> > > >  	int status;
> > > >
> > > >  	status =3D FPE_EVENT_UNKNOWN;
> > > >
> > > > -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > +	value =3D readl(ioaddr + MAC_FPE_CTRL_STS) | fpe_cfg->staged_fpe_=
state;
> > > > +	fpe_cfg->staged_fpe_state =3D 0x0;
> > > >
> > > >  	if (value & TRSP) {
> > > >  		status |=3D FPE_EVENT_TRSP;
> > > > @@ -766,11 +769,13 @@ int dwmac5_fpe_irq_status(void __iomem *ioadd=
r, struct net_device
> *dev)
> > > >  	return status;
> > > >  }
> > > >
> > > > -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpa=
cket_type type)
> > > > +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_f=
pe_cfg *cfg,
> > > > +			     enum stmmac_mpacket_type type)
> > > >  {
> > > >  	u32 value;
> > > >
> > > >  	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > +	cfg->staged_fpe_state =3D value;
> > > >
> > > >  	if (type =3D=3D MPACKET_VERIFY) {
> > > >  		value &=3D ~SRSP;
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > index 53c138d..022c1a2 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > > > @@ -156,6 +156,7 @@ void dwmac5_est_irq_status(void __iomem *ioaddr=
, struct net_device
> *dev,
> > > >  void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 n=
um_rxq,
> > > >  			  bool enable);
> > > >  void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
> > > > +				 struct stmmac_fpe_cfg *cfg,
> > > >  			     enum stmmac_mpacket_type type);
> > > >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device =
*dev);
> > > >
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > index b95d3e1..5496781 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > > > @@ -415,6 +415,7 @@ struct stmmac_ops {
> > > >  	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_=
rxq,
> > > >  			      bool enable);
> > > >  	void (*fpe_send_mpacket)(void __iomem *ioaddr,
> > > > +				 struct stmmac_fpe_cfg *cfg,
> > > >  				 enum stmmac_mpacket_type type);
> > > >  	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *de=
v);
> > > >  };
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index 3e50fd5..6a29f55 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct=
 stmmac_priv *priv, bool
> > > is_up)
> > > >  	bool *hs_enable =3D &fpe_cfg->hs_enable;
> > > >
> > > >  	if (is_up && *hs_enable) {
> > > > -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
> > > > +		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> > > > +					MPACKET_VERIFY);
> > > >  	} else {
> > > >  		*lo_state =3D FPE_STATE_OFF;
> > > >  		*lp_state =3D FPE_STATE_OFF;
> > > > @@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct st=
mmac_priv *priv, int
> status)
> > > >  		/* If user has requested FPE enable, quickly response */
> > > >  		if (*hs_enable)
> > > >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > > > +						fpe_cfg,
> > > >  						MPACKET_RESPONSE);
> > > >  	}
> > > >
> > > > @@ -7280,6 +7282,7 @@ static void stmmac_fpe_lp_task(struct work_st=
ruct *work)
> > > >  			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
> > > >  				    *lo_state, *lp_state);
> > > >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > > > +						fpe_cfg,
> > > >  						MPACKET_VERIFY);
> > > >  		}
> > > >  		/* Sleep then retry */
> > > > @@ -7294,6 +7297,7 @@ void stmmac_fpe_handshake(struct stmmac_priv =
*priv, bool enable)
> > > >  	if (priv->plat->fpe_cfg->hs_enable !=3D enable) {
> > > >  		if (enable) {
> > > >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > > > +						priv->plat->fpe_cfg,
> > > >  						MPACKET_VERIFY);
> > > >  		} else {
> > > >  			priv->plat->fpe_cfg->lo_fpe_state =3D FPE_STATE_OFF;
> > > > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > > > index 0b4658a..1322c78 100644
> > > > --- a/include/linux/stmmac.h
> > > > +++ b/include/linux/stmmac.h
> > > > @@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
> > > >  	bool hs_enable;				/* FPE handshake enable */
> > > >  	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> > > >  	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> > > > +	u32 staged_fpe_state; /* Staged FPE state when read MAC_FPE_CTRL_=
STS */
> > > >  };
> > > >
> > > >  struct stmmac_safety_feature_cfg {
> > > > --
> > > > 1.8.3.1
> > > >
> >
> > Hi Serge,
> >
> > Thanks for your suggestion.
> >
> > > Are the status flags in the MAC_FPE_CTRL_STS register cleared on
> > > _writes_?
>=20
> > A write of 0 has no impact irrespective of the value programmed in RCWE=
 bit.
> > This is safe option when writing the MAC_FPE_CTRL_STS register, which w=
ill
> > ensure that bits[19:16] are not modified unintentionally.
> > When RCWE bit is 0 and status bits[19:16] are read, those will be clear=
ed, a write
> > of 0 or 1 do not have any impact in this mode.
>=20
> Great! Than always writing shall do the trick.
>=20
> >
> > > then what about just converting the
> > > dwmac5_fpe_configure() and dwmac5_fpe_send_mpacket() methods to alway=
s
> > > writing to the MAC_FPE_CTRL_STS register, and if required preserve th=
e
> > > shadow control MAC_FPE_CTRL_STS flags in the stmmac_fpe_cfg structure=
?
> > > AFAICS the only flag which needs to be preserved is EFPE - "enable
> > > FPE" flag.
>=20
> > I think this is a good solution, pls check my draft patch below.
>=20
> Some comments are below.
>=20
> >
> > -Jianheng
> >
> > [PATCH v2] net: stmmac: fix FPE events losing
> >
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 26 +++++++++-----=
--------
> >  drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +++-
> >  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 ++-
> >  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +++-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 ++++++-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
> >  include/linux/stmmac.h                             |  1 +
> >  7 files changed, 28 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > index e95d35f..9575e84 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > @@ -710,17 +710,15 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, =
struct net_device *dev,
> >  	}
> >  }
> >
> > -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_r=
xq,
> > +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg =
*cfg,
> > +			  u32 num_txq, u32 num_rxq,
> >  			  bool enable)
> >  {
>=20
> >  	u32 value;
> >
> >  	if (!enable) {
> > -		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > -
> > -		value &=3D ~EFPE;
> > -
> > -		writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > +		writel(0x0, ioaddr + MAC_FPE_CTRL_STS);
> > +		cfg->fpe_ctrl_sts_shadow =3D 0x0;
> >  		return;
> >  	}
> >
> > @@ -729,9 +727,9 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32=
 num_txq, u32
> num_rxq,
> >  	value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> >  	writel(value, ioaddr + GMAC_RXQ_CTRL1);
> >
> > -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > -	value |=3D EFPE;
>=20
> > +	value =3D EFPE;
> >  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> > +	cfg->fpe_ctrl_sts_shadow =3D EFPE;
>=20
> What about just:
> 	if (enable)
> 		cfg->fpe_csr =3D EFPE;
> 	else
> 		cfg->fpe_csr =3D 0;
>=20
> 	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
>=20
> then ...
>=20
> >  }
> >
> >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev=
)
> > @@ -766,19 +764,17 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, s=
truct net_device *dev)
> >  	return status;
> >  }
> >
> > -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket=
_type type)
> > +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_c=
fg *cfg,
> > +			     enum stmmac_mpacket_type type)
> >  {
>=20
> >  	u32 value;
> >
> > -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > +	value =3D cfg->fpe_ctrl_sts_shadow;
> >
> > -	if (type =3D=3D MPACKET_VERIFY) {
> > -		value &=3D ~SRSP;
> > +	if (type =3D=3D MPACKET_VERIFY)
> >  		value |=3D SVER;
> > -	} else {
> > -		value &=3D ~SVER;
> > +	else
> >  		value |=3D SRSP;
> > -	}
> >
> >  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
>=20
> this can be replaced with
>=20
> 	u32 value =3D cfg->fpe_csr;
>=20
> 	if (type =3D=3D MPACKET_VERIFY)
> 		value |=3D SVER;
> 	else if (type =3D=3D MPACKET_RESPONSE)
> 		value |=3D SRSP;
>=20
> 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
>=20
> >  }
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > index 53c138d..aca846d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > @@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, str=
uct stmmac_est *cfg,
> >  			 unsigned int ptp_rate);
> >  void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *de=
v,
> >  			   struct stmmac_extra_stats *x, u32 txqcnt);
> > -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_r=
xq,
> > +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg =
*cfg,
> > +			  u32 num_txq, u32 num_rxq,
> >  			  bool enable);
> >  void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
> > +			     struct stmmac_fpe_cfg *cfg,
> >  			     enum stmmac_mpacket_type type);
> >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev=
);
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index 453e88b..a74e71d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -1484,7 +1484,8 @@ static int dwxgmac3_est_configure(void __iomem *i=
oaddr, struct
> stmmac_est *cfg,
> >  	return 0;
> >  }
> >
> > -static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
> > +static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac=
_fpe_cfg *cfg,
> > +				   u32 num_txq,
> >  				   u32 num_rxq, bool enable)
> >  {
> >  	u32 value;
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > index b95d3e1..68aa2d5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > @@ -412,9 +412,11 @@ struct stmmac_ops {
> >  			     unsigned int ptp_rate);
> >  	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
> >  			       struct stmmac_extra_stats *x, u32 txqcnt);
> > -	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> > +	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cf=
g,
> > +			      u32 num_txq, u32 num_rxq,
> >  			      bool enable);
> >  	void (*fpe_send_mpacket)(void __iomem *ioaddr,
> > +				 struct stmmac_fpe_cfg *cfg,
> >  				 enum stmmac_mpacket_type type);
> >  	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
> >  };
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 3e50fd5..7791e9b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stm=
mac_priv *priv, bool
> is_up)
> >  	bool *hs_enable =3D &fpe_cfg->hs_enable;
> >
> >  	if (is_up && *hs_enable) {
> > -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
> > +		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> > +					MPACKET_VERIFY);
> >  	} else {
> >  		*lo_state =3D FPE_STATE_OFF;
> >  		*lp_state =3D FPE_STATE_OFF;
> > @@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac=
_priv *priv, int status)
> >  		/* If user has requested FPE enable, quickly response */
> >  		if (*hs_enable)
> >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > +						fpe_cfg,
> >  						MPACKET_RESPONSE);
> >  	}
> >
> > @@ -7262,6 +7264,7 @@ static void stmmac_fpe_lp_task(struct work_struct=
 *work)
> >  		if (*lo_state =3D=3D FPE_STATE_ENTERING_ON &&
> >  		    *lp_state =3D=3D FPE_STATE_ENTERING_ON) {
> >  			stmmac_fpe_configure(priv, priv->ioaddr,
> > +					     fpe_cfg,
> >  					     priv->plat->tx_queues_to_use,
> >  					     priv->plat->rx_queues_to_use,
> >  					     *enable);
> > @@ -7280,6 +7283,7 @@ static void stmmac_fpe_lp_task(struct work_struct=
 *work)
> >  			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
> >  				    *lo_state, *lp_state);
> >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > +						fpe_cfg,
> >  						MPACKET_VERIFY);
> >  		}
> >  		/* Sleep then retry */
> > @@ -7294,6 +7298,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *pri=
v, bool enable)
> >  	if (priv->plat->fpe_cfg->hs_enable !=3D enable) {
> >  		if (enable) {
> >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > +						priv->plat->fpe_cfg,
> >  						MPACKET_VERIFY);
> >  		} else {
> >  			priv->plat->fpe_cfg->lo_fpe_state =3D FPE_STATE_OFF;
> > @@ -7754,6 +7759,7 @@ int stmmac_suspend(struct device *dev)
> >  	if (priv->dma_cap.fpesel) {
> >  		/* Disable FPE */
> >  		stmmac_fpe_configure(priv, priv->ioaddr,
> > +				     priv->plat->fpe_cfg,
> >  				     priv->plat->tx_queues_to_use,
> >  				     priv->plat->rx_queues_to_use, false);
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > index ac41ef4..6ad3e0a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> > @@ -1079,6 +1079,7 @@ static int tc_setup_taprio(struct stmmac_priv *pr=
iv,
> >
> >  	priv->plat->fpe_cfg->enable =3D false;
> >  	stmmac_fpe_configure(priv, priv->ioaddr,
> > +			     priv->plat->fpe_cfg,
> >  			     priv->plat->tx_queues_to_use,
> >  			     priv->plat->rx_queues_to_use,
> >  			     false);
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 0b4658a..48385c7 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
> >  	bool hs_enable;				/* FPE handshake enable */
> >  	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> >  	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
>=20
> > +	u32 fpe_ctrl_sts_shadow;		/* shadow of MAC_FPE_CTRL_STS */
>=20
>   +	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
>=20
> I would have had it named as "fpe_csr" - short and well readable
> especially seeing CSR is a well known abbreviation for Control and
> Status register, which the MAC_FPE_CTRL_STS register actually is.
>=20
> * Note one more time: current FPE handshaking implementation is vastly
> clumsy, needlessly overcomplicated and prone to races. I would have
> seriously considered having it refactored.
>=20
> -Serge(y)
>=20
> >  };
> >
> >  struct stmmac_safety_feature_cfg {
> > --
> > 1.8.3.1
> >

Hi Serge=1B$B!$=1B(B

Thanks for your comments and for pointing out the defects of the current FP=
E
handshaking implementation. I know that my patch cannot solve all the
defects of the current FPE handshaking. So, I want to know if it is necessa=
ry
that I continue submitting this patch if you want to refactor the FPE
handshaking further. Moreover, I want to add FPE handshaking support for DW
XGMAC (add fpe_send_mpacket() & fpe_irq_status() to dwxlgmac2_core.c) after
fixing this MAC_FPE_CTRL_STS register read issue.

-Jianheng
