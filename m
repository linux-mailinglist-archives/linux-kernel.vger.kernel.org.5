Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F062980E40C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjLLFlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLFlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:41:04 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C47BC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:41:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJv/AyGdJlVDOR5kOKf/Fuc8wWECcENaxsaqR6DJOXXIQNILtjdHiM5zLOFO4bawwG+zTC76gz9h2snRxmYRtIEIpJTaNkLAzObJJC0AlWYTCmm81U1dkhbYi8WqfDfb4mb0toB1J91fR5R5OHCSk8W/+r/B3kqr8ZKqOgmeTTusHrVmNAC7/sLKdGgsT+TuczSjKTvTBXct8bteuw/o1E8ePbkKUdZlcKt0TqNl1o7nfZzS9gDbeVCK3wNcJpEp1UuCAHMFi6qoWFbIL8OtP8pja4xm5EX2po9mGnc/oUeS3daiz6G9kjZtICYAA2m9pIskpONU3e8lVge5vvQsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9iPU8j9tGfsc5CttKqcoeEJ4UmY7IcN6Ij0+bwA1Xg=;
 b=PkfUs6tfcCPjn/3fMIe3FN4tNqPy1iO05n9+Rub3VjWTcznLl6fIBH/7KoI097dkI0apfEfj5nhJ3assxJtgEBjpHMxvD1eW/I3zhQukJrIFpl+VuINknFul6XjSCMtR32KlthzG2WixGc+GbW2H7VPICga4Eeu2hiVzTmoMCn5QiYlqTo/2hDkTqrXpAnvTphwpRGQMHqIUuCmsm5u2MWXZKgNuH8Ae750pJkLR8Q+w5DxCGuUesnTOpPn9v4fxxWT5CBiNUIwkDemXJesoOF9a/qe+ONOjZqOUaMg5rFMWl/dJ3EwuxSa0Om5O16jkQ48ngvbfci5audjsnSsvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9iPU8j9tGfsc5CttKqcoeEJ4UmY7IcN6Ij0+bwA1Xg=;
 b=JuCufiv1/nmML+r068dAZq+R/uuyghO+g6/KiKkTTjzBc9fqs80RgraxAKM/RUouyPo/V2CT299OG1O5aOHZurQzH8SbtdN2Q/cRLnlr0KcNM0HFshDD6a+Im7z3E+w7iIUPjNCU6XLJY0KM2YmMN0L9v6A+6x4makr7XJqc81XEKp8GfYEAqf/zAh3nml3y+VXNOleg2iNBUjdeo7MUMcohG3HVN6MxYaULs+QCFTNqF69AxT7KwqkjM1qY41wFuQWwhb41e176qJmudfgXg7Uxbr/CRJfMx/Q3jBD0iMDu8ncrOBYkhffpxD2IRjx3OGabBRIp//o2Qxgf70arUg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 05:41:06 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 05:41:06 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 5/6] nvme: add csi, ms and nuse to sysfs
Thread-Topic: [PATCH v5 5/6] nvme: add csi, ms and nuse to sysfs
Thread-Index: AQHaKcTqoDfd816rQkC9f77PA8t0NLClKBAA
Date:   Tue, 12 Dec 2023 05:41:06 +0000
Message-ID: <7b993ee5-ad67-4df1-805c-7d4246fac18a@nvidia.com>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-6-dwagner@suse.de>
In-Reply-To: <20231208105337.23409-6-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6418:EE_
x-ms-office365-filtering-correlation-id: 8dc002dd-02ba-4be8-90fd-08dbfad4efe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: njtlDBOmwNTzQIqlZpxak9qJnTg6nRZ8Sx7RhPSfVyIRq9y5s5Q//sUjEVczpXWCHplDGAMbAYdkIvaqOCu3dsq+aOwiSdgdiQdOj9PoCK9db9AVCjt2cKSw43NfQhdycZfU6ZGHQEBF6CeoQvYkvOnqUqhkll6YEM1HzjfRsJVYlJpvdNRg7nCLTD6CUN0wFlMMiP4Fax4EcTIpJqnFqy4YJHsNA7VpwxBffAFjAhdngtQZ2zkkXxiAipxfBkeHEUIMqO8dEKUbeNEsO7UoWMX6zt4WG4KNaqSObXhVpgdj5oOKgnBA9i9NiIKtGnj6Q4KWZwIP0a+I1D0duEEVE/pOVo/ZjrzsspBnTBvDnUkIAdCluTVL4QZLJa0Qdvh5otJfCt22jR8O43KOxEYXtAtN93iMjCJWESUp1APm3bW8S1JBnm/I1Gqswg8z9leeAYTvxl/IJBguVULKFILxTGP0hsy5nQvyoFyMWsyhzBj59Qbl1osOhnTVpvcn8U2QyuUPkSfwmE56bjVul4hKvp+YbabifIkhwUFNR2vYIdYr4EVCP+m2sH3+lAis2Td2/HWrnPByF6BzWKZ+wdRBgRZUlDhWtEI1CaKaWz8JB7d+FRQbibi1+HHISu5BmS8lg2usHxBYc5hAv3jNvoSnRVyjczawsJviVF2VQYTjBcFXCyq5MHqhK/Rdk9+CXEZp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(5660300002)(26005)(2616005)(36756003)(64756008)(38070700009)(4744005)(6486002)(66946007)(66476007)(66446008)(66556008)(76116006)(54906003)(91956017)(2906002)(31686004)(86362001)(478600001)(41300700001)(8936002)(4326008)(8676002)(31696002)(122000001)(110136005)(316002)(38100700002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkgzS3FXSTNuMWhZTmwrVlJBa3o4RU9VdGpZZm9kcERoaVJhTVpTVjk3RUQx?=
 =?utf-8?B?SHFhdlE5aFpZVDdsdnlkd1FrVEJWYjRhdHI1dkxSYjBlM2IwN0pTNUdFTU1B?=
 =?utf-8?B?SFRZU1FRTnFWZm1Ic25QSUNEcWx1N095djAxRnFIRjdIemhJblI1bmgrNXJP?=
 =?utf-8?B?UFBpakU0VDdwWE1CTjVPM1YvREQvYjUybG80QlR6WmlBVFlzOXpRTjRRVUlW?=
 =?utf-8?B?alNFb0diYkNkZzB5OHdGeWMyV1ZoMm9pM2QyajcybklmbXJDaTYrYXlRM0c4?=
 =?utf-8?B?QUVrSHhqS0ZwVkJZNFc3d2UwRUNQb29GekhWNmNhYUlWV25pTEtPTVQwNnVI?=
 =?utf-8?B?QnFJeDVlUFFTZk42ZSs2ZnZQRmNYdVhkWllpOVVzSGV2bW5jNEZSeVFsSjBa?=
 =?utf-8?B?RVdBTmJJc3c5KzlpRVplaWkrK2JJYUpXOVBMa1JLa0tpVHpKMGlyY3hqSno2?=
 =?utf-8?B?TjBxR3B2REJhYmM1UGxoSFF2UjI4NUFHSjQwZjFWSTdBUDc4UmhyMEt6c3Nh?=
 =?utf-8?B?aEVCTmdEcnFPak5KbDZQMUJPS0d5QmJHalpJYVZJbkZvRmNuZXRDVVUrSGxX?=
 =?utf-8?B?d0kvd0JZeGNHRi9RS0VoMW9IVjN3T001WlVhTnNIbzUxc25lY0xzV2tTV211?=
 =?utf-8?B?LzFTZmQyNkE0ZDRqK1lPajg5UWRKaU82Q2x3TXlpSkx5ZjRIak9kVU05bG1m?=
 =?utf-8?B?dFJBUWd0aHBhcG12QUxMS2FPN1JqdTZiVk85bDZzVVBmeEVPbU4xcU5FNXVq?=
 =?utf-8?B?cmh4OWNTUHNjY1hiOVVZNU94UWpQU3BpN21qTzBvV0N3UkxNYnBTMzh5TzFp?=
 =?utf-8?B?Q1NZY2plWWhtdzBwd1BieTdKRHdFYTVxN0xlb1FOcmVDdng5aFBSc0EyUnFK?=
 =?utf-8?B?dllaOWZ5MnFpcU5STGtEclVqUFY2RFFkQi9nYUgwUDJCVit0SGZidEdsYmx3?=
 =?utf-8?B?aWtGTkMvS1VTd2VQbUpZTFVMSU8ySlQ4ZU05c2haMy9jREo4T0t3eG1TaDZy?=
 =?utf-8?B?TGtTMGZBNm1ueHp2MWsrUDZzQ2xiZmxldlVhcEljeWQ2MzNROUE4L3p2aDMy?=
 =?utf-8?B?YTYyMkRqcFNXSDdpeXBCeXh6cWVMSVMyUndLZUtPWXU1d3lLQjM5R3JHSnpT?=
 =?utf-8?B?VG5wRHh3cFM2THJJelpzQjRWQ2gvckxQVlplZkZsSUdJS01SMVlCbUJXV085?=
 =?utf-8?B?UDVjS2hUK29YT29Zc0V1MDVvK1oxbmVpcnA0MjBMaXBWUHFHUWJVRlFkSnJG?=
 =?utf-8?B?cG9NMjdJcWlZMWZYUTR5ZUZ5czlQZEFubTlpYU51UHNSUVJHaDlTd3I4WndT?=
 =?utf-8?B?VURHWWk1U0IwWk5EQkhHTWQ0UGdxTTc3d2NNb0ZPOG83anJqTDdmYUZtR1hx?=
 =?utf-8?B?MjZyL1BNeXhFUzArYlBrY002UlN1OFB5WHk1UDZ2MFV1RnFoNDZiM2EyS1Jm?=
 =?utf-8?B?QldYUUk1dEVXaFRSbXFpeUFOQ0l1aWtQbG1OWVpiN3k2Z1M0TlQ0ek9sYkgv?=
 =?utf-8?B?YnJjMzY2djB0dWVrV0VoVmRSeHlzYzZhcDJDV3lTV0IxMnJ5SFo5TS9uc2Ur?=
 =?utf-8?B?Nk05OFNaanUrSU5uQldHQ1h2NWJUUXhRNVNIWmp2THg3V0M4Z3V5TVFMaTd2?=
 =?utf-8?B?YmRuUW9laEdhUStuc3FtY2VxWS9xaEtJWngzLzEra0QveVNlUFlENmVycHFl?=
 =?utf-8?B?RFZTTlZ3Tm15RmpCNmk1aXd6MzA3Z1RJZENnV1RUWUhEbVZGVUhlaFpEYlpw?=
 =?utf-8?B?cGoySjdHb2VPRWZiWFVXNlZ2OWxIWVBpNEdsNzVxajR5OWsveTI5VjM2ZXNE?=
 =?utf-8?B?ZU8ycno2QVhJSlQrZ0lxMENQbHNRbHp0TlVaYUlNcmRsM0pLWjZDT2d5bHJZ?=
 =?utf-8?B?dVRrV1ZIYlc5VVpudmNNQXBCNXlJNllJTXl6YWpVTlRHQ0hJVzJKTUNQTTRI?=
 =?utf-8?B?ejhWY3RpZDlTNXJvN3ZxUXVJZUtiWGxMQzhUek9Ed0ZNL29za1d2ai8ydUNj?=
 =?utf-8?B?R1UrYVorUjZyeWpCVTJqQUxDUWU4VkxmQmtvMEtnRVlDY2d4SFBucjYxbjNO?=
 =?utf-8?B?UDZWcWNmd1BBV3kwdVJkNE4wbzc4NnlTeTFETVlPTmNXTml5QXBiQk9ubXQx?=
 =?utf-8?Q?HmQVxugPC//QEd+MiuCJ5HVoz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B950D93D21AD444B99A1C893C7E9EB5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc002dd-02ba-4be8-90fd-08dbfad4efe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 05:41:06.7225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoL4X9etI6BEHDQd6zLX5r64RJgP9gsmPobcvquBfOCrxdTK82IneFp+0hLhd2ctwgao3+xaWgRSeYiMTmoUPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qvc3lzZnMuYyBiL2RyaXZlcnMvbnZtZS9o
b3N0L3N5c2ZzLmMNCj4gaW5kZXggZDY4MmQwYTY2N2EwLi4zY2ZhZTBjM2FmNzYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3N5c2ZzLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3Qvc3lzZnMuYw0KPiBAQCAtMTE0LDEyICsxMTQsOTcgQEAgc3RhdGljIHNzaXplX3QgbnNpZF9z
aG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+
ICAgfQ0KPiAgIHN0YXRpYyBERVZJQ0VfQVRUUl9STyhuc2lkKTsNCj4gICANCj4gK3N0YXRpYyBz
c2l6ZV90IGNzaV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmF0dHIsDQo+ICsJCWNoYXIgKmJ1ZikNCj4gK3sNCj4gKwlyZXR1cm4gc3lzZnNfZW1pdChi
dWYsICIlZFxuIiwgZGV2X3RvX25zX2hlYWQoZGV2KS0+aWRzLmNzaSk7DQo+ICt9DQo+ICtzdGF0
aWMgREVWSUNFX0FUVFJfUk8oY3NpKTsNCj4gKw0KPiArc3RhdGljIHNzaXplX3QgbWV0YWRhdGFf
Ynl0ZXNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICsJCXN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLCBjaGFyICpidWYpDQo+ICt7DQo+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAi
JWRcbiIsIGRldl90b19uc19oZWFkKGRldiktPm1zKTsNCj4gK30NCj4gK3N0YXRpYyBERVZJQ0Vf
QVRUUl9STyhtZXRhZGF0YV9ieXRlcyk7DQo+ICsNCj4NCg0KZG8gd2UgbmVlZCB0byBjaGFuZ2Ug
dGhlIGZvcm1hdCBzcGVjaWZpZXIgPyBzaW5jZSBjc2kgKHU4KSBhbmQgbXMgKHUxNikNCmFyZSBu
b3QgZGVjbGFyZWQgYXMgc2lnbmVkIGludGVnZXJzIC4uLg0KDQotY2sNCg0KDQo=
