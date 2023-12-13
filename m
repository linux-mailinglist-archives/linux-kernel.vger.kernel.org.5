Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2081191B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378719AbjLMQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379146AbjLMQUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:20:51 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCE8E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:20:56 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=X6W9y0W5N0C3ZFUEp/oT4pICKUZKy7EK9rEhzZomB2A8n7JON55pjXOAO/4mm1EGBsX9uJ0S8RO23WhbDsIenL1wK9gy7/jgZJmUPicM0J7aDqahXsKXGN1yT/w/5blnUJA+ruDQZBg90Eb2VJB5ZVh5YbKJYllkvf2Y0VMPrxW9sa3l+CIEHNxtJIRviQOFnUPeiHsvVhH/I5YqcVmocvnRtB1H/C/jYKAc3pyK4pyTGQQXzJbtKWPGDuwGp4dm1LetddzlhtjXaekD8cPnNpzD6G2Ps+0OYFujs6SKuAbU1WG//TV3J6m4o7/Pw9BbLLOwNz9WBzD9MtyqegWT8Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9Hr91LKLiaorhm33hKw/IvEiwleSMVp3/b6ua4xghg=;
 b=noae8oMNos2ztQ2qw8wQd08r0D+X/FS28iMJpixQg0wEIHQZrIrBB/ywbLf6qpdqWB7mtNuyp7UePT+LITKM3wjJncxKztSdVu1BTUdEmGtg8Rn3oPeLCJr86SF2+I/fi3w7JqwKp6Ib2oKd7C1BI/hNwViKHFdA/Lps2fjiutxG6xGlJTq6TXw3xArtZWPj4VV+eKHAlYXmIvvvIdiwFu8J5S5Bh1mFRFgIYJ6Kv4CvjpIchn2mP3QSbO8Ip7FEB536dcfe1XlIRESapUeHE14nsSTIiP0toaJr+bzB9Ju6051WhLpavskeyWKfIP/iZO2gIUz1RYB+2xg1tvHq8Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Hr91LKLiaorhm33hKw/IvEiwleSMVp3/b6ua4xghg=;
 b=cDMzpbd4E3rqLWGQU/6Oa9Ap3NT+ntSooSq5yY9F70tqnWWjYXADkQELkxZoUfb6QUY1770zPtLDbn57TanLkioE/x+koXGBqH0GMRILm2hxVIbx96w+WPWv2Sko+uQj78i/Q26Q8Qu4SzCAMOHerAtqZg8UfTiu7aryxXZn11g=
Received: from AS9PR04CA0071.eurprd04.prod.outlook.com (2603:10a6:20b:48b::20)
 by GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Wed, 13 Dec
 2023 16:20:36 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:48b:cafe::3d) by AS9PR04CA0071.outlook.office365.com
 (2603:10a6:20b:48b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 16:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 16:20:36 +0000
Received: ("Tessian outbound 385ad2f98d71:v228"); Wed, 13 Dec 2023 16:20:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ecf9f359545b4125
X-CR-MTA-TID: 64aa7808
Received: from 1aad5ab84e3e.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EFC0E872-7F15-49F9-AB1B-5782DC59E3C6.1;
        Wed, 13 Dec 2023 16:20:25 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1aad5ab84e3e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 13 Dec 2023 16:20:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi8j6UWIEcb2hcXI4VJ6BCCmVJe3LfmBIy8Kqd3D6RTgOo/bW1GGzdTqYk46DIvhKQ2ElPDrpbUVyYwrlAYYQtqJ/UQKS0DLIMCl4FHG7OBcIltdduSPMROpLFBmkwqlxLdHEFDck8b/HXY2aZJD/z+IQHIltWd70R14jPVU+ONeed6thQacPwR5Zvi3FnYJCiLkGAqPMmBzNs6bTR3IbvBa+NtuZZ1sq4QUMh/3jzM9nVJ8w16wu1fsyZtneUQi6ilq2jeVxWVWcyeZIEwqoipCxA+2IBPqEn0fMX8pH3q4BicC1Sf0pyjWRpVSudFkMiUo31SloJsOE9ZAHvVSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9Hr91LKLiaorhm33hKw/IvEiwleSMVp3/b6ua4xghg=;
 b=RxWQ1Fdw1qvHM6LmfKm7fEHd+zR54w3uQ24aPJ4yWqkZ4TR36kxiGyiY7Yknx8KhLFcmDLi4d+BgS/rF0emQKIzaSD+Ni+GJsvZd7GimtoP+LBS4gOMeJzmAQlVy7+ETebmcHR1672L6GBQzOT6rujcco7nrwXZ1CGpNdS8TGlyzk2LFFRvZnNtCUPPowrgLdhrdiQ1mZVc/8QInBdKqLg0xBLq0F2EdFqIJ9WrVH2FxSZouAvH2uLj8YpODm0/Qatsp73Y1FFFtBSXY2glJxn4JGXd6ehwqCYWz5QVBMjIDjrkTf2VIKpKaYYWZ5xlPIRpI0C2XF1ucqYKD107nCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Hr91LKLiaorhm33hKw/IvEiwleSMVp3/b6ua4xghg=;
 b=cDMzpbd4E3rqLWGQU/6Oa9Ap3NT+ntSooSq5yY9F70tqnWWjYXADkQELkxZoUfb6QUY1770zPtLDbn57TanLkioE/x+koXGBqH0GMRILm2hxVIbx96w+WPWv2Sko+uQj78i/Q26Q8Qu4SzCAMOHerAtqZg8UfTiu7aryxXZn11g=
Received: from DB9PR08MB7820.eurprd08.prod.outlook.com (2603:10a6:10:39c::18)
 by VI0PR08MB10448.eurprd08.prod.outlook.com (2603:10a6:800:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Wed, 13 Dec
 2023 16:20:20 +0000
Received: from DB9PR08MB7820.eurprd08.prod.outlook.com
 ([fe80::f04a:285f:4be0:cda1]) by DB9PR08MB7820.eurprd08.prod.outlook.com
 ([fe80::f04a:285f:4be0:cda1%6]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 16:20:20 +0000
From:   Metin Kaya <Metin.Kaya@arm.com>
To:     "jstultz@google.com" <jstultz@google.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>
CC:     Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "joelaf@google.com" <joelaf@google.com>,
        "youssefesmat@google.com" <youssefesmat@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "zezeozue@google.com" <zezeozue@google.com>,
        "qyousef@google.com" <qyousef@google.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
Thread-Topic: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
Thread-Index: AQHaLY8iD1tjKN8/n0yjONvrRu9kurCnZWiA
Date:   Wed, 13 Dec 2023 16:20:20 +0000
Message-ID: <5d9c994140e7375979bc3d58a216c8eb261275a9.camel@arm.com>
References: <20231106193524.866104-1-jstultz@google.com>
         <c6787831-f659-12cb-4954-fd13a05ed590@amd.com>
In-Reply-To: <c6787831-f659-12cb-4954-fd13a05ed590@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DB9PR08MB7820:EE_|VI0PR08MB10448:EE_|AMS0EPF000001AA:EE_|GV1PR08MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e906b87-933b-4745-9506-08dbfbf77059
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9Vg+8AyYOWleTvZR9eerTHiq20AY0O0OSdAO38eIdVzDuyGlWLBXPJdjECmI+KP+ywLDwNwhfMg7wPeD1zStA+WnZzFpImIjwz3KFNGw638rd9j60Vl/xbfQwCrvkIFx+F6OHgSBQE23RAkms06qfX9/wikJOOskEdQjpqZRD6qIKao35s5dU4kBYyZOo+6S6UNnUGVTAk+3/ww0toSuRJ0865RkrH7buVPludEq6jsFxe+nlw6tRjots2xbuGy22dbIvkD5dAhhU4mKilFC6pWnyYAtM8Se5URRw1+23NOUqe8u3ykaytpAprAm5uD+Q3x8/zAfG1JRQp3f/LoswzoL48I9FxAfg8lRaYwW+Yy+cGEivTQsk8H7P/uKHT6PzRNtvDKbiMF25pfKSMvEq2ip4Mv1sDAN33dDJ2N3MvASLNECzxyBK+S+g3QU+Z+mX4LgyMxAWnwX+mItZhTge2pImameHP4z50fYlpTl1EQBJWoFLdvMVS601WOTboP3HMejOoccTK0QRYpBYmsLg2qmZCeWgy9wf99Q0sKalbhW20pQzgM7HshpGSDcN+D6HBbcWHrG/UWIuw02CuhZDTNuPhpiwvI43qBTzDrqhkCJxR40YUeJHblPjjfG2cq+xHSY8Aag3zCLwp3od7k+EQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7820.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(2616005)(38070700009)(36756003)(86362001)(38100700002)(122000001)(83380400001)(7416002)(71200400001)(53546011)(5660300002)(478600001)(4326008)(6512007)(6506007)(76116006)(66556008)(91956017)(110136005)(8676002)(8936002)(6486002)(64756008)(66946007)(54906003)(66446008)(66476007)(41300700001)(4001150100001)(2906002)(316002)(218113003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <77281FB1D91B604FBA4EC77B95F75C31@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10448
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 99a445cf-ae0d-4aad-c2a9-08dbfbf76722
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qc11s/uaZoGfanYX7ZhUmxyLVRMMpZycm78l8dl/EbGrCcWm5bVbPCYHT3idieIaIVqd/KoR8OjKAhxGwzPuoUl8b9SOzPpJQhxf116B2bgNCrmJ9Sd4MgkYuStooUr8Ux58xB8NPZvxy8nVCFGF3iymrR0dyWNnuHA39XOnr/AiNgnbKN110jYe0PaaOqLGzeKWSpPcM6s0zuwV/eFcJLGm9YQtk18Px2UOWn9oswkbq/bThRNhruBmkj8bc9VDOsA/QLeHWYe/DoCcjIxST+oq5+ehi72qA5MLDYXBuPPUcF3jY6SHI3fIMnsvg1ibKG/koKdsYUvcWs/rmFy8pgzDsFPpXrWsjADEWBcxG78E/NTqZ/arxwIfGCfAcLm5Rk+uVBwPYrCjjGurPwE0mVvoEA/k8mo/wHo3C5LAFivxU2MQswPQYy+YxYkGsuwO0+S0Ty4kKagloB4A6fyN14zCWk0QFYc38n8kjQbOauHW9v/kabPoXX4B4uTsODOyi4xdn4+DNjMJEcJ+Eu79gYXxoTQARImhT/00k9YNYMFos1tBCaVaoztUrBU2AUUDLxQbmHot2YOgs/k9qrxF7SpCsXC+/WZ4KnR7XXhC0MOuTWHAK+4qaKV9YwQY1P1wFMkDLytXz+NK7BclEA7VZERWlKR4vwS1y6qACM1t9ZpsyaupmyB1G4BCXHArM1xrZ3IKJVnwwPBjWUT+q0JntWKHqZVGZEcR92U42mETnpsu6YcTuylAXhtkXdvV8Z+HGwtjr6C1OtNmUTHxJ2y2Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(70586007)(54906003)(70206006)(110136005)(47076005)(82740400003)(6512007)(40460700003)(53546011)(40480700001)(478600001)(6486002)(83380400001)(356005)(36860700001)(86362001)(316002)(81166007)(6506007)(2616005)(107886003)(26005)(336012)(8936002)(4326008)(8676002)(4001150100001)(36756003)(41300700001)(5660300002)(2906002)(218113003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:20:36.2845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e906b87-933b-4745-9506-08dbfbf77059
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8426
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDEyOjA3ICswNTMwLCBLIFByYXRlZWsgTmF5YWsgd3JvdGU6
DQo+IEhlbGxvIEpvaG4sDQo+DQo+IEkgbWF5IGhhdmUgc29tZSBkYXRhIHRoYXQgbWlnaHQgaGVs
cCB5b3UgZGVidWcgYSBwb3RlbnRpYWwNCj4gcGVyZm9ybWFuY2UNCj4gaXNzdWUgbWVudGlvbmVk
IGJlbG93Lg0KPg0KPiBPbiAxMS83LzIwMjMgMTowNCBBTSwgSm9obiBTdHVsdHogd3JvdGU6DQo+
ID4gWy4uc25pcC4uXQ0KPiA+DQo+ID4gUGVyZm9ybWFuY2U6DQo+ID4g4oCULS0tLS0tLS0tLQ0K
PiA+IFRoaXMgcGF0Y2ggc2VyaWVzIHN3aXRjaGVzIG11dGV4ZXMgdG8gdXNlIGhhbmRvZmYgbW9k
ZSByYXRoZXINCj4gPiB0aGFuIG9wdGltaXN0aWMgc3Bpbm5pbmcuIFRoaXMgaXMgYSBwb3RlbnRp
YWwgY29uY2VybiB3aGVyZSBsb2Nrcw0KPiA+IGFyZSB1bmRlciBoaWdoIGNvbnRlbnRpb24uIEhv
d2V2ZXIsIGVhcmxpZXIgcGVyZm9ybWFuY2UgYW5hbHlzaXMNCj4gPiAob24gYm90aCB4ODYgYW5k
IG1vYmlsZSBkZXZpY2VzKSBkaWQgbm90IHNlZSBtYWpvciByZWdyZXNzaW9ucy4NCj4gPiBUaGF0
IHNhaWQsIENoZW55dSBkaWQgcmVwb3J0IGEgcmVncmVzc2lvblszXSwgd2hpY2ggSeKAmWxsIG5l
ZWQgdG8NCj4gPiBsb29rIGZ1cnRoZXIgaW50by4NCj4NCj4gSSB0b28gc2VlIHRoaXMgYXMgdGhl
IG1vc3Qgbm90YWJsZSByZWdyZXNzaW9uLiBTb21lIG9mIHRoZSBvdGhlcg0KPiBiZW5jaG1hcmtz
IEkndmUgdGVzdGVkIChzY2hiZW5jaCwgdGJlbmNoLCBuZXRwZXJmLCB5Y3NiLW1vbmdvZGIsDQo+
IERlYXRoU3RhckJlbmNoKSBzaG93IGxpdHRsZSB0byBubyBkaWZmZXJlbmNlIHdoZW4gcnVubmlu
ZyB3aXRoIFByb3h5DQo+IEV4ZWN1dGlvbiwgaG93ZXZlciBzY2hlZC1tZXNzYWdpbmcgc2VlcyBh
IDEweCBibG93dXAgaW4gdGhlIHJ1bnRpbWUuDQo+ICh0YXNrc2V0IC1jIDAtNywxMjgtMTI1IHBl
cmYgYmVuY2ggc2NoZWQgbWVzc2FnaW5nIC1wIC10IC1sIDEwMDAwMCAtZw0KPiAxKQ0KDQpJIG9i
c2VydmUgc2ltaWxhciByZWdyZXNzaW9uLiBUb3RhbCB0aW1lIG9mIGB0YXNrc2V0IC1jIDAtNSw2
LTExIHBlcmYNCmJlbmNoIHNjaGVkIG1lc3NhZ2luZyAtcCAtdCAtbCAxMDAwMDAgLWcgMWAgaW5j
cmVhc2VzIGZyb20gMTMuOTY0IHNlY3MNCnRvIDE4NC44NjYgc2VjcyBvbiBteSB0ZXN0IG1hY2hp
bmUuIE90aGVyIHBlcmYgc2NoZWQgYmVuY2htYXJrcyBsb29rDQpPSy4NCg0KPg0KPiBXaGlsZSBp
bnZlc3RpZ2F0aW5nLCBJIGRyZXcgdXAgdGhlIHJ1bnF1ZXVlIGxlbmd0aCB3aGVuIHJ1bm5pbmcN
Cj4gc2NoZWQtbWVzc2FnaW5nIHBpbm5lZCB0byAxQ0NYIChDUFVzIDAtNywxMjgtMTI1IG9uIG15
IDNyZCBHZW5lcmF0aW9uDQo+IEVQWUMgc3lzdGVtKSB1c2luZyB0aGUgZm9sbG93aW5nIGJwZnRy
YWNlIHNjcmlwdCB0aGF0IGR1bXBzIGl0IGNzdg0KPiBmb3JtYXQ6DQo+DQoNCltzbmlwXQ0KDQpJ
TVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRl
ciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3Ro
ZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBp
bmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
