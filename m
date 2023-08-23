Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745FF785CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbjHWQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjHWQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:08:05 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E35CD6;
        Wed, 23 Aug 2023 09:08:02 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDDU4n020929;
        Wed, 23 Aug 2023 16:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=bKQTxueKneoBuapkK6Fxm3TgXSZkk3qyAkOvuf2DOoA=;
 b=czM+BNtVwL44BzoJ44eOYKX6Mfh8xmFdzQUlDHZeSdbV08KboXgUWGkRV/UX1uDFkNvq
 wEvRiSa5MG2XuALumdsTJHQNbPgU2QlEt/dzHyAgT9S37pPPh5lniCoX3vVkjDBr8orh
 egg+ZqrKFdnXt63+H7yp1JyGWMwkqKssOyINntQgcj6eJKQmPh8nmWIq+j7eN6GLJXMF
 iMot35+uzYduk8aFAQTudHSCpp9JaMeDgdL1hzKfytzLgcK42sXhvancLaW/Z1JP8Jb5
 3jEn4UtClQhoQ/yGxjAs8mzBdG6LQz3S6SzrttPt4XMcLSXPQOFz8J6nsYDQERCNJ7pv tw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sn2kthj2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 16:07:56 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 751CC801731;
        Wed, 23 Aug 2023 16:07:55 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 23 Aug 2023 04:07:55 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 23 Aug 2023 04:07:54 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 23 Aug 2023 04:07:54 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 23 Aug 2023 04:07:54 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQmZxGnPyBQfBB/Vqe7+iGzIC7J71VRcORdM3RVYJXm1dVa39zTbYajjW3tqGMr2HQo/YKZnL2wyBF12RcDPnccYlyGjpysLGP2qJ2c3eHOujayoVKT5nsq6/zLIUfDnw9233JvD86L2mkn/8zM0N86BA6Sr26WfwhjGuGIz7DrKt9sTl7Kr7O5kSyTrdA/ZGlTwg+foI4kDhfH+qkqxtgdYTeryNQCeLbO+uLWlJSSTZ97kW++1PllvSwinyfF2xLpc8K9WBWYIUUr9EpXlgUeViDEGm2MypFY+oA9dow0uux7x+syc7Mky6ALrlonisk3hYD+J1Y0jzd3uLW4NPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKQTxueKneoBuapkK6Fxm3TgXSZkk3qyAkOvuf2DOoA=;
 b=eQoLkgktnUNB4u25q4sJTHbanfJFhfcwgzqDLlYmjLdI6vSxACEocs3ImJn+gl1gnL0IIUmMONVAoJQgShBePilx05hTiF+UnJ35rFYZI6qbGQLyPeDk9LdkCzZlAv/ZQoCMiGRvZ9R5t8Agt/LksS3MAwtRgwAPJ8Tf+YHLO1CCRuDd3qFA3fsW0qAru+cQDT2/kF1+jkhPTLYJ1sUOKzvXpgr40XzvfPBWy0akN+JX9egEKupM3iBYBoyHDPRJp5NWm1q6ZdJhFVhHygek8pmaLHANFk7rbi7DIqILFRZ4J3v/g9/cnrJAray3kjE7xK6Q2BTHOtk5gjtesvIpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::14)
 by DS0PR84MB3452.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:07:52 +0000
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1fa9:6270:fde2:ccb5]) by SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1fa9:6270:fde2:ccb5%4]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 16:07:52 +0000
From:   "Yu, Richard" <richard.yu@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chang, Clay" <clayc@hpe.com>
Subject: RE: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
Thread-Topic: [PATCH v1 1/3] dt-bindings: usb: Add HPE GXP UDCG Controller
Thread-Index: AQHZsFXDXRwLTnyj+EG3EOG0eweVQK+t+ScAgCfp9zCABlytgIAF9gGAgA///wCABggEEA==
Date:   Wed, 23 Aug 2023 16:07:52 +0000
Message-ID: <SJ0PR84MB20859D909E55BB1BC62EE3C68D1CA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-2-richard.yu@hpe.com>
 <9f1bd0f1-d93e-243a-4622-721319fd1235@linaro.org>
 <SJ0PR84MB20854B4A444283E31025FA398D0AA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
 <e2e7c830-07f4-a34e-6bf8-c9e8dc33bf57@linaro.org>
 <SJ0PR84MB2085BDDFD7C46A73C489A6E48D12A@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
 <834800aa-65f4-4c99-4586-51a24355bc59@linaro.org>
In-Reply-To: <834800aa-65f4-4c99-4586-51a24355bc59@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2085:EE_|DS0PR84MB3452:EE_
x-ms-office365-filtering-correlation-id: 732ae011-4ca4-436c-7227-08dba3f31ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmR0FeVsfi6FGpXCsWJmozYTz/L1k2KHzxdyJFNVDBD2zgcMEbyZG2fXTxutQZ0hH0pUBqU0AfZFptQi8aSQEyuQFKEeP6JkAvAvm8swCdDXKMH748ZuJfWurNi1lpUkNFuG/B7/ec/s4DCUhH69GIlwXG3cCbLohEToejsXXHPtb3lx+mistB6/mMWe52qkRAoatzxawQkqY+IpmbP7r/QSj7XTS6W+JFalDp9PG/rJZmHl60wmntRkAmqyNmuBC7lv2irCntQBz1+b1LQDE9cW3b/X7ZMlIGyz/mb8BiKM038xF044CljwRqeYtO3NIrY6RIzOqeJxwWWHs/oSlUJvkfgLNLcTsAyCYG9y53hZHM5eXnkYFFyzjFDqDr7KzTZl4UypOZjDGbBMhXWHgZRkF8qFXRwucfNd6LK7RDZzlRUgP8y3u7AcrDa4BrSqBqnPEuU4GrIBcSc135/r7QBh5OzUOddVDDVr7+7pNEU8hQXSTPhppff9SctPOD1EM7RITODn8Oow5RlCPmfOa0FTIJH3P1jERpnQUdqt+o0+nFd16NaUU6ar8eSev9Gjt73+UJ17FsmXk7VbQMDwgrgFlpLDgTRBnwpXVK/OiusUUMzCljnR2EzaNt429Tgp5PtE2H5ucvW+fKZZd+ruEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(2906002)(83380400001)(6506007)(7696005)(38100700002)(5660300002)(52536014)(26005)(33656002)(38070700005)(86362001)(8676002)(8936002)(82960400001)(9686003)(66476007)(316002)(64756008)(55236004)(6636002)(66446008)(66556008)(66946007)(76116006)(110136005)(478600001)(122000001)(55016003)(71200400001)(921005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUZYTGJLWWNyQzVvd0VhR1hXQS9ZQ1FrNFJQN3ZieXZ1YVFnMnROQmxTaWlo?=
 =?utf-8?B?U0trMFdGeTRpY1Z1djNLa1k0RmlyVTRraXBJemRLai9XUEMzMXFiaS9oOXdD?=
 =?utf-8?B?NW9LR0FXVUV5RUh3WUtiTjZycVhjaEpYc3YzSHZINHFCeEZ3KzR6NE96UUNk?=
 =?utf-8?B?YUl2Vk1ucTRZOFNZaVZuMUQ4VDhET3BOeEVJbWw1S2tQZG1zL1F0Z2FHczVE?=
 =?utf-8?B?dEQwblNMZzRaZ2RUYnBrT2RsV3piV3Q4aEx4THl4eTFtdlBQRzRuNVZlM2tL?=
 =?utf-8?B?Vm95bWRYd1R4NDQ0ZGtLeG9iSmJJQSsrTWNYM1k3ejU1ekZuTm5sTVJoVEhp?=
 =?utf-8?B?OWtYc1QwQk5uZW83Y1NTSUMwSDBlMTRvNlkwcitVNFZQdDV5SDhkRnJoRlVw?=
 =?utf-8?B?Yi9vL1RmeXAxalUzQ0dqdkFQSzBUbnJRaTJ6SXZrRm5xZXNSMy93UnJFam5v?=
 =?utf-8?B?cGFXSXV6dThJUVR6NlYzb2tXZndldE9BQjVhT014VGwxVzVVSXVUcDhEcndY?=
 =?utf-8?B?YXRLNUlDRU9Zc2J2bUhQWVZjcGp3U2xuQjFYSlp1MFlIZ1dWMEIvK2kvWGRa?=
 =?utf-8?B?QUJOWFZjckRlUXFUM3ZPS1N1cHRyR2R6VEhIdlBXYVdXQlRRcGxGMEdBUC95?=
 =?utf-8?B?QWFXK1ErTVArSG9QL1hZZjU3Vk5Pd01CQmRoeStXN1FCYmZiM2VhSGR6Y2FH?=
 =?utf-8?B?Tkg2c0ZWTmFmaEI0eUpvQm8zS3k1UkFoeVZuRGhaQWtZdXVkcWhzSFJqaUVm?=
 =?utf-8?B?Q3FaYXBXQnIxOEdBVXNUOG5CcUw5cVc3YnZTY3VWVXNtNnpIWEpDSDE2Qkt6?=
 =?utf-8?B?aDZqVmZEalk4MEIyUnhvNWdtTkRpbUYxb3k0T1U3YTZhM2l1emNuQTB0UXNF?=
 =?utf-8?B?b1V1Y1kva2I3YldNZE9wMUFwbDRsQVh1NVA4TjhyZGlRSXlUT0tMUlBGNWFP?=
 =?utf-8?B?RGg4MERSYzJvMjNSWlQ3aUhYS0cvZG9GcnhsSmRUQ29KRi9STytXd2J4WXp3?=
 =?utf-8?B?clhNd3NoRWpic1dSNU05Vm1qaUVuUzY2WWRZM1hEL0YzVXFRSlhGV29XVHNQ?=
 =?utf-8?B?R1R4Z1IxbUhjYUFYejA0QXJFMDFjTGxNb3hoNDBoZlNWaHBoVnRxUllTYkNJ?=
 =?utf-8?B?Q2JMNGJBRzZiT0Fxc21TcHJJWWlFWm9RQWFnSVhIcWV3UngxTHg3M2NUTy91?=
 =?utf-8?B?RXhlaXJ2ZmtOQ0ZMcUkwOXRNZWgvZ2Q0dGhtdWcxeTdJL3B5cHU4a0xqYk1U?=
 =?utf-8?B?MjY1VmlkOHYxZitEaFJhYXFzZ0xtV2NDc2l2ZUtiYlhtMmFyekd3UkhjeEZI?=
 =?utf-8?B?dWsycElQNGNiK1RHbGdnM1h3YTZXNWJBaWMvUDBLMUFoN2xncmN4V0hTWldh?=
 =?utf-8?B?UWQzUWMzcWtlMVl4ZjM2ME1WcDZIVzVQS1dTekt6SmNnOG1aNFpQcENvR05o?=
 =?utf-8?B?TjFQMVhMaVJoK2VMTVR0aEJrdElqeU5EMk5IMkZseDVLajk4Qjk0UXk2NlN3?=
 =?utf-8?B?V01WaVcrdnc5UEN4dWduQ3BYaVN2eGdKVlluK3JIYXhhQmNLbVdCZHRYU2lk?=
 =?utf-8?B?cGNYM2h0OUpMQ0EyU1dCK0NvWFdIMk0zMG4xOXJBNjFoUlNKbTE5OVB6WGE1?=
 =?utf-8?B?cDk2VHNCZUNaTldxRUZRaVA4RmxQVjhpZDFPU0pqOWxhM2dWeGxFQ1JHcXBz?=
 =?utf-8?B?akZ3Q1E1NTQzYkdJL0RiWTVPS1FPQVY2ZWRud3RmalR1NEp4OFZQdWZTUHIx?=
 =?utf-8?B?ejhydkN4OFVHTVptQjRhTHVtaVE4cEZ0UWNQZ01rWkFDOUNXamR1ZndiRVlH?=
 =?utf-8?B?WmZpUEI1VTExcWlSeG81VGhrakRNU041QWQvL2Q4dkFIM2VYMmVwOWI5dmk4?=
 =?utf-8?B?RHZkYW1ObzI1c1dVZmtRVmp3MytMb3Y5c2NsK0YzSjN4K2J5VWRnSjdkZjNC?=
 =?utf-8?B?NVc1OXBEMi82QUFDWGNCVVRDRThpY2VoOTFrbWZVSW56cHlVTUVrUllQbVdn?=
 =?utf-8?B?M21xbjlWblZrWnRSbEpKbG43alUrczQzSzUvYUZWZm9vbC9tZDMzYVUyNlQ1?=
 =?utf-8?B?dmEvMEpGMHp0aytPdmVGNVVpUCttSTFFcElaRnhLRnNKSVY2UDZzWW1heS9I?=
 =?utf-8?Q?JZvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 732ae011-4ca4-436c-7227-08dba3f31ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 16:07:52.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIoFqtJRUc3Ey49jpdaou/rgNDjmVCUDDFb++vEFfLkqPLejLXciyPeMLhVQPAxrOHT+MExy1DrSb+946WVcyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR84MB3452
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: sNJxSI8VNk0PQ0CNzzum7cRTCEwU3aZh
X-Proofpoint-ORIG-GUID: sNJxSI8VNk0PQ0CNzzum7cRTCEwU3aZh
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=479 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308230147
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGFuayB5b3UsIE1yLiBLb3psb3dza2kuDQoNCj4+IEkgYW0gaW1wbGVtZW50aW5nIHRoaXMg
ZHJpdmVyIHVzaW5nIHRoZSBBc3BlZWQgdmlydHVhbCBodWIgZHJpdmVyIGFzIGV4YW1wbGUuIA0K
Pj4gDQo+PiBKdXN0IGxpa2UgdGhlIEFzcGVlZCB2aXJ0dWFsIGh1YiBpcyBpbiB0aGUgRGV2aWNl
dHJlZToNCj4+IA0KPj4gdmh1YjogdXNiLXZodWJAMWU2YTAwMDAgew0KPj4gCWNvbXBhdGlibGUg
PSAiYXNwZWVkLGFzdDI2MDAtdXNiLXZodWIiOw0KPj4gCXJlZyA9IDwweDFlNmEwMDAwIDB4MzUw
PjsNCj4+IAlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+
IAljbG9ja3MgPSA8JnN5c2NvbiBBU1BFRURfQ0xLX0dBVEVfVVNCUE9SVDFDTEs+Ow0KPj4gCWFz
cGVlZCx2aHViLWRvd25zdHJlYW0tcG9ydHMgPSA8Nz47DQo+PiAJYXNwZWVkLHZodWItZ2VuZXJp
Yy1lbmRwb2ludHMgPSA8MjE+Ow0KPj4gCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiAJ
cGluY3RybC0wID0gPCZwaW5jdHJsX3VzYjJhZF9kZWZhdWx0PjsNCj4+IAlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KPj4gfTsNCj4+IA0KPj4gSW4gbXkgY2FzZTogIChJIGFtIHJlcGxhY2luZyAidWRj
ZyIgd2l0aCAidmh1YiIgYW5kIHJlbW92ZSB0aGUgdmVoY2kgcmVmZXJlbmNlKS4NCj4+IA0KPj4g
IHZodWI6IHVzYi12aHViQDgwNDAwODAwIHsNCj4+IAljb21wYXRpYmxlID0gImhwZSxneHAtdmh1
YiI7DQo+PiAJcmVnID0gPDB4ODA0MDA4MDAgMHgwMjAwPiwgPDB4ODA0MDEwMDAgMHg4MDAwPjsN
Cj4+IAlyZWctbmFtZXMgPSAidmh1YiIsICJ1ZGMiOw0KPj4gCWludGVycnVwdHMgPSA8MTM+Ow0K
Pj4gCWludGVycnVwdC1wYXJlbnQgPSA8JnZpYzE+Ow0KPj4gCWhwZSx2aHViLWRvd25zdHJlYW0t
cG9ydHMgPSA8ND47DQo+PiAJaHBlLHZodWItZ2VuZXJpYy1lbmRwb2ludHMgPSA8MTY+Ow0KPj4g
fTsNCg0KDQo+IFRoZSBodWIgaXMgbm90IHZpcnR1YWwsIGl0IGlzIHJlYWwuIEkgdW5kZXJzdGFu
ZCB0aGF0IGl0IGlzIHNvbWUgc29mdHdhcmUgYmxvY2sgb3IgRlBHQSwgYnV0IHN0aWxsIEkgcHJv
cG9zZSB0byBza2lwIGFueSByZWZlcmVuY2VzIHRvIHZpcnR1YWwuDQoNCkkgd2lsbCByZW1vdmUg
YW55IHJlZmVyZW5jZXMgdG8gInZpcnR1YWwiIGluIGNvbW1lbnQgYW5kIGRvY3VtZW50YXRpb24u
DQoNCg0KPj4+Pj4gKyBocGUsdmVoY2ktZG93bnN0cmVhbS1wb3J0czoNCj4+Pj4+ICsgZGVzY3Jp
cHRpb246IE51bWJlciBvZiBkb3duc3RyZWFtIHBvcnRzIHN1cHBvcnRlZCBieSB0aGUgR1hQDQo+
Pj4NCj4+Pg0KPj4+Pj4gV2h5IGRvIHlvdSBuZWVkIHRoaXMgcHJvcGVydHkgaW4gRFQgYW5kIHdo
YXQgZXhhY3RseSBkb2VzIGl0IHJlcHJlc2VudD8NCj4+Pj4+IFlvdSBoYXZlIG9uZSBkZXZpY2Ug
LSBFSENJIGNvbnRyb2xsZXIgLSBhbmQgb24gc29tZSBib2FyZHMgaXQgaXMgDQo+Pj4+PiBmdXJ0
aGVyIGN1c3RvbWl6ZWQ/IEV2ZW4gdGhvdWdoIGl0IGlzIHRoZSBzYW1lIGRldmljZT8NCj4+Pj4N
Cj4+Pj4gVGhhdCBpcyBjb3JyZWN0LiBXZSBjYW4gY29uZmlndXJlIHRoaXMgVkhVQiBDb250cm9s
bGVyIHRvIGhhdmUgb25lIA0KPj4+PiB0bw0KPj4+PiA4IHZpcnR1YWwgcG9ydHMuIFRoaXMgaXMg
c2ltaWxhciB0byB0aGUgYXNwZWVkIHZpcnR1YWwgVVNCIEhVQiANCj4+Pj4gImFzcGVlZCx2aHVi
LWRvd25zdHJlYW0tcG9ydHMiIG1vdmluZyBmb3J3YXJkIGluIHRoZSBuZXh0IHBhdGNoIHdlIA0K
Pj4+PiBhcmUgZ29pbmcgdG8gdXNlICJocGUsdmh1Yi1kb3duc3RyZWFtLXBvcnRzIg0KPj4gDQo+
Pj4gTW92aW5nIGZvcndhcmQgeW91IG5lZWQgdG8gYWRkcmVzcyB0aGlzIGxhY2sgb2YgcGh5c2lj
YWwgcHJlc2VuY2UuLi4NCj4+PiBBcmVuJ3QgdGhlc2UgZGlmZmVyZW50IGRldmljZXMgYW5kIHlv
dSBqdXN0IGZvcmdvdCB0byBjdXN0b21pemUgdGhlIGNvbXBhdGlibGU/DQo+PiANCj4+IEkgZG9u
4oCZdCBmdWxseSB1bmRlcnN0YW5kIGhlcmUuIElzbid0IHRoZSBsYWNrIG9mIHBoeXNpY2FsIHBy
ZXNlbmNlIA0KPj4gc2ltaWxhciB0byB0aGUgQXNwZWVkIHZpcnR1YWwgaHViIGRyaXZlcj8NCi4N
Cj4gSSBkb24ndCBrbm93IEFzcGVlZCB2aXJ0dWFsIGh1YiBkcml2ZXIuIEluIGFueSBjYXNlLCBk
cml2ZXIgaXMgaXJyZWxldmFudCB0byB0aGUgYmluZGluZ3MuDQoNCj4gV2h5IHNldHRpbmcgbWF4
aW11bSBudW1iZXIgb2YgZG93bnN0cmVhbSBwb3J0cyBvciBkZXZpY2VzIHdvdWxkIGJlIG5lZWRl
ZCBwZXItYm9hcmQ/IA0KPiBEbyB5b3Ugc2F2ZSBzb21lIHJlc291cmNlcyB0aGF0IHdheT8NCg0K
VGhhdCBpcyBjb3JyZWN0LiBFYWNoIHBvcnQvZGV2aWNlcyB3aWxsIGhhdmUgdG8gYWxsb2NhdGUg
cmVzb3VyY2VzIGFuZCBjcmVhdGUgZGV2aWNlIGRlc2NyaXB0b3IgZW50cnkuDQpDdXJyZW50bHks
IEkgc2V0IHRoZSBudW1iZXIgb2YgZG93bnN0cmVhbSBwb3J0cyB0byBiZSA0LiBUaHVzLCBJIHdp
bGwgaGF2ZToNCg0KL3N5cy9idXMvcGxhdGZvcm0vZGV2aWNlcy84MDQwMDgwMC52aHViLzgwNDAw
ODAwLnZodWI6cDEgICA8PT09IGZvciBrdm0ga2V5Ym9hcmQvbW91c2UNCi9zeXMvYnVzL3BsYXRm
b3JtL2RldmljZXMvODA0MDA4MDAudmh1Yi84MDQwMDgwMC52aHViOnAyICAgPD09PSBmb3Igdmly
dHVhbCBDRC9EVkQvSVNPIGltYWdlDQovc3lzL2J1cy9wbGF0Zm9ybS9kZXZpY2VzLzgwNDAwODAw
LnZodWIvODA0MDA4MDAudmh1YjpwMyAgIDw9PT0gZm9yIHZpcnR1YWwgVVNCIGtleQ0KL3N5cy9i
dXMvcGxhdGZvcm0vZGV2aWNlcy84MDQwMDgwMC52aHViLzgwNDAwODAwLnZodWI6cDQgICA8PT09
IGZvciB2aXJ0dWFsIE5JQw0KDQpKdXN0IGxpa2UgYXNwZWVkOg0KSW4gZzUgKGFzcGVlZC1nNS5k
dHNpKSwgYXNwZWVkLHZodWItZG93bnN0cmVhbS1wb3J0cyA9IDw1PjsNCkluIGc2IChhc3BlZWQt
ZzYuZHRzaSksIGFzcGVlZCx2aHViLWRvd25zdHJlYW0tcG9ydHMgPSA8Nz47DQoNCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KVGhhbmtzDQoNClJpY2hhcmQuDQoNCg==
