Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3973A7CE1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjJRPvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjJRPvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:51:35 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7F118;
        Wed, 18 Oct 2023 08:51:32 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100]) by mx-outbound20-232.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 18 Oct 2023 15:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwLgvak71A5NRpibPFt90Ba0bNtAWlVNKHPx98/nnfpXqx+RC3QK8fUiGUvMb99iUn2IU4v/ulu5rxMCY3K2Kd9J45DLCwcITy36AJ4b92CufKFg2xXIIshR9spne64PPXE6m6t12gwFK9WScl6Sdo0LCTR8tjl8Z0HCDp1Wgo+48KS5CV8AqI74dKYylUcbjZHXBgWz+zqhU2hJg3wCrius9oCNqXhlDdw4Y4zl6YtMINioKhKpBzf5+iDOT7iVk6MlrsWs5Fce/uHi/JJ0J1KRUX35L3IlyLMyh9F0W4tHjAGQTUKBP66Z5aDELkN2/x1/Jk5wEm/6vaIiqbWyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRHf3TJEEaOdfQMgXcM3/aEX7ro3H3PhqQQLmZI9Joo=;
 b=Ds+Qc0I8fYCBAI36FZFuKrJfODKel5JCadY3gZImRhhaAWNX/QVVlUXoFt4fBfpx1Te3jxuqk7edNwkpD+T1IUHXyCAlWbYdkcecsfccIBZsTL7DXCKsPy6FvHbwcSjuh7IBMgpJ4vBl/oxxPuOHwKh4KCVu3vo7ej9S0hEGoaPIT151vPned032Nm5sE2f0qOXGyh219XmODGxZBpHGA1znJgNOAaU89/ZIiWA8NHNCd3aukeY/bAqxfomKFAZh/KnnzidR2crwDJNU1zzwWqK6dcxjTZrXXtfdiXwgI4k/B/FjJm9hlhoVCUTJcTRYhB9arBnPxRHbQk/vo/778w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRHf3TJEEaOdfQMgXcM3/aEX7ro3H3PhqQQLmZI9Joo=;
 b=lvAssUTbSNCnb/VmmF1bDB3cG4Of8l+zcdfMLrQ0tqtAOYxe0V7Yaj94LW4/ld0un4brvToKcbv188LHJW6BtN+wVrLPhIY2smGURQTULTCGb2ie4qxtm1rT7+kf+tAjd5dhiBX11pl3UCHZ/5TNfYOPm1B5oCkTUuaDNeApfi4=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MW4PR19MB5495.namprd19.prod.outlook.com (2603:10b6:303:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 15:51:20 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2%5]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:51:19 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
CC:     Miklos Szeredi <mszeredi@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT"
Thread-Topic: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
Thread-Index: AQHaAbRpOYa+0Y8j+kCP04IX3OA3s7BPbDcAgAABw4CAAAGgAIAAKwaAgAAD9wCAABPegA==
Date:   Wed, 18 Oct 2023 15:51:19 +0000
Message-ID: <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
References: <20230904133321.104584-1-git@andred.net>
 <20231018111508.3913860-1-git@andred.net>
 <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
 <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
 <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
 <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
 <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
In-Reply-To: <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|MW4PR19MB5495:EE_
x-ms-office365-filtering-correlation-id: 61459f3f-4f75-495f-c825-08dbcff21229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PRpWV3SNWA8kXimrUIByy6gGNskv38iMVjAnYpm3bHBe9Dpqy3zX0Y9/DUjb8g3wXNJdeCCOozNtI4wVzDG8B1Y6+SEMWpNmTdeqG5N1YlqhInzbJZTSfvJlIeL3GntbUEtXZVBK/sMJpbArPnpcBO4wceIF7wBD+4dHlav4NJHmZVmeow8PdBxLTa6QkMTDtNs1FXhwSgGYMDOr4mVowKO/KZ7B2Neih8/91GsDiQCjEMYMHcM/JZSVvb7Y/Ll2/Pw/W6uT3oZ8IR1icNBalFmT1UOKTa6cVT1CTHcp0p7PMeQKKLR0fyJrqdh0LtZhRvLeAUGuke4u9YwmIvZNOBTnGqvHpxEJEpvseEc8uhNSM0seqkjeKCrHhGXU9cXOc2rcoudROVdbErszATs2uZNjwyGiMsrIzSOIQHzy4Qjj5gF9CZOUGKjjsmJ4/5FtRXzjG41cDIC79I6y8dGSDJDZv33kXv4GW9EwM15rcA2pnj/lENusbE5QKHAg+W0r6o6hBP63SLNPZ0/aoWsAKWrzazVdoe9VwzKWdoCYCtF0kw9O1dXLq27JPAauvmZNVzGS1Z1gxrrEqVFGODB71WM+QoVCpZYW8PeXEwOkUin1lHQlIMSjkjG2gyXkpt9rdWK4bwNEl63zF4iYBpjMNCC+fK5MiXFReO5Wl9lc23p+7Q5a8sqP8a/Jdi0idImx7o+PLrcmaUkIbY17cwC5vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39850400004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(4001150100001)(2906002)(6916009)(4326008)(316002)(91956017)(8936002)(8676002)(76116006)(66556008)(66476007)(54906003)(66446008)(41300700001)(64756008)(66946007)(2616005)(5660300002)(36756003)(122000001)(38100700002)(478600001)(86362001)(31696002)(6486002)(38070700005)(966005)(53546011)(6512007)(71200400001)(6506007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWQ5czFwcGNFWG5QL3hpNzNWNXBmOFBhaTRpU0E2SzYzVHVGWGJyNG5wMjh6?=
 =?utf-8?B?UXc1WkR3MTZWdk1EU0JqR0owZXN2ZklUZU54cmVnb0VWeVVkZzNoK283S2tV?=
 =?utf-8?B?ZzNvSTBhNmZNT3Z0V3ZWMUFTUFc0Q1hZbW1wdm5vMERNMTJMR3MyTWl0K0hT?=
 =?utf-8?B?VlJvZi8zU1dxTmtoaEhMWDdSMWltSnN6elcwRFcrMlhBWEhRbThUYVp0dGVt?=
 =?utf-8?B?alVaaW41UkRuMUhvMmxBMjdXTEVVSmJzcHlYREcvMzRiQzB0QUJ6QU15N0R1?=
 =?utf-8?B?VHlTUFRiV2R5M0RmZDBhS1MwU1pjVndlZDdmU3N6QWxMeE91ZU5aOU5lMXBS?=
 =?utf-8?B?NXhDZEJMOXVQdGg2QjFIcGZoWnNKR1AzZk1zak5rZjJlUjd3R3ZTWGhzbTY3?=
 =?utf-8?B?QXNxOEF4ZGNZaFJGT0VYZkJmR3pWcGFFRTN1MWU1QjBuQ1BWZkFBQ0pKNVVx?=
 =?utf-8?B?ZlpyNEkvOWd0bnlHTFdOOWtJK1NsU3ZGbWx1THBWR3JBOEppMzBWeWFyMGtj?=
 =?utf-8?B?eFZlY0RIYTQ1eHd0TTEreUpueSt5dGQ0cnJBQWo5aU83aWRxSE1VUzdCa2xv?=
 =?utf-8?B?RTR4SnNRZUs5aHdQWTdvTjNNeTJoU2hweXZQdVl0SjYyclErRWR2K0h1Qmpy?=
 =?utf-8?B?eXNnTm82SkRVRFlJYWs5bjVYdUl5UGR2dk12UDVIbzZOc2FBYUpBZ3M4VDVl?=
 =?utf-8?B?MVNvaDFCQlpRZlJaSGpjRUdDOVNFbG8rbHJOT0FtbGc4NXk4LzNqVy9aaXhG?=
 =?utf-8?B?MXBOeEdEOE8veStaLzdKK1FXaUQ3NG5RTEM5UlZsd1pwaVVhd25ZMnVaNXV2?=
 =?utf-8?B?SzlkRHdXRnIwRFdGblU3ckVmb0t4ZHdxNHc2WDFHSU9WOE1JbHEvdjUzNi9u?=
 =?utf-8?B?M2NqeXpldXlyVEQrb2dPYnduSkhLYUlac0thbjNJbGR1VWtMN3Nna0Y5QzZp?=
 =?utf-8?B?b2VCSHJRR01jVHZud2VlNWhoOFErYUtxM1d0Nk1yWjBIeDFlVjFxSmY2ditD?=
 =?utf-8?B?TjZLb0VSNXM1Zk0yVU41V3lOc3BmNTFBV3dzYzFYeStzc0x4OXNkSERIYWtp?=
 =?utf-8?B?SWtJMlA2bjVSb3RXMk8waU40cUxXSHlwV294dS80V0s5dXM0WjFGb2Ruam8w?=
 =?utf-8?B?bTA0T3ltTDczS1NlUWZsN0M1REdWZ3phaE5sU3J5YVhrZHh3QWszbTBQTGZ1?=
 =?utf-8?B?NWEzRG1uZDhCU3M0M3o5NVpMN01pbC9SU2FNUElxQVM1NjBMcUFpK1NpTVhR?=
 =?utf-8?B?NUJmclF3ZXVmcmk0MXR2NCtTV2ZKVVVGQm9Od0EyazhnNlVTcTU2cmFhOTRo?=
 =?utf-8?B?TXFGbWZhMmEzNE5HTHdwWGZUdGpGR1MvUUVkb0lwTS9zbStzL251Ymdqbysr?=
 =?utf-8?B?ZHBRdkRLU1pSVlNLdWd2RHhQZmgvdTBHSnhmOUptcG1CZk0rUVp4WTl5UnJZ?=
 =?utf-8?B?bjl6anFhdzM0UnZOV1V0TmxjVEpYMGpQMWU2WHlIK3BxaGVEeHErd1BUS0w5?=
 =?utf-8?B?ZWI0eDdRckJrWU5jdTFmN0JtR2pYVnk3ZVgwcjh6RG5XcUppdVVzREFGcklK?=
 =?utf-8?B?dmVQOFN4bjR0OVZkU1lzVHUxRTE2UTdQZnNuM0h6RWhQKzdtU1pteXZIMFh5?=
 =?utf-8?B?czBkM2VXSnZtZWUrVFN3RS9UK3FkVEw5M2Y4UWJmUThDN1RuMUoyRThlLzVK?=
 =?utf-8?B?WmV5ZG9WaEpHa1F1MGo0a2h2ZlF4a1hnL0xqYUQrcmNPRVBtMXgxc2RCaENN?=
 =?utf-8?B?V293Wmk2S1l3T2hlTGZITzNpbnlkMHFmN2FzOGwvVHhIRGFhcE1aM2N3ODU3?=
 =?utf-8?B?TW5Md1RkNkRoSGxKaXJCcTFJSnRtU2MrbVdUbXgrdnVBc09oZUJkUmY0U0NM?=
 =?utf-8?B?ZWpObER6NDBONVVIZUZQenZ4YThOaVhsSlYwclB5UXZ1QWt3SVU5VnQyNmN5?=
 =?utf-8?B?RTdvVW91VitTRlFYWnl6Vk5MV2JpMDZTam5kZmpqdnFvZWhyVDZkSE0rU2N6?=
 =?utf-8?B?eWJZUWFRWVdXUUZGM0g3SGZUS3M1KzlETzJadjFSOENEVmJGU1JKcXNuS0xY?=
 =?utf-8?B?aXYvMjB5cnlSeUVNOXFDQ0tzcEZEM0tGUEdrd2tXQ0dHQ2kzUyt5K0t4RWhi?=
 =?utf-8?B?VjZ4ZkIxa1NwYnkzeFh6Zk96aHlPQTJSdm13RWRqUFdpNjV6RDRMVHc0T08y?=
 =?utf-8?Q?+Hz9Ewnx1x8JV1XxqHb1FCY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE6B1A16FFABC348AE0A3C3BE75BBAD2@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TzM3dFEwdXJvcVI5ejVhK1pWZmpVUURKeGIzNVhSUGg1QWx5Mmx1OFArYjZB?=
 =?utf-8?B?VEx2NW1yY2tWVGFERWluY2xEVlBCaEMzTmVqTmQzWDlQNGF6elNJRVM0L1Rn?=
 =?utf-8?B?MGZORXduZVRpNk1JaEVUM1ZtWnQrOE5jN0lmcW00NzBNRSttZms1bW9vbW5U?=
 =?utf-8?B?ZHRES2FTNC9PRldJeEJNdzZpWnlrUzM1L09mdnFyK0RxOHFsTnAwTHByTFN3?=
 =?utf-8?B?bkJnQTZETUdZSVNqMnliN2ZhbG1nQTlqWEdMcXl3NnBzUzIyb1RmNjdlZXBz?=
 =?utf-8?B?ejkyd0JHcTlmZWVhQjhITjhtN2E1OFltdC9tcVdWQXFXWWF4elVlUklDRVFD?=
 =?utf-8?B?bkJpN0Y1N0psRnNVZjkzQmF5ZDM0LzllNWFyMXF4WFBaUEs5QVgzTXFkZFRq?=
 =?utf-8?B?RE51SkVJUTVXbHBFVnlBZXRLOTJ2bEpqQjIwcFNTWjMxRkU0WVZlMGZDRkJ3?=
 =?utf-8?B?eFVaUFFmWjJ3VW16OXpSOXM4S3Flait6emxWZjZHTUxlSlV4clcxQnZGNDBz?=
 =?utf-8?B?MzVjN2FEeEROVGtDSS9WZE9IYm55ZzVUZHhraVFsRDZOaHRnVUNJcE9kc0FX?=
 =?utf-8?B?a3I4Vmh2YmlQNnZHQjI2aldpU1FQVDVBSFkrWk9VOSswT2FONi9HSGVEYXdG?=
 =?utf-8?B?dUlYTzBlTmUyTnFvaFBUSTNtWjlHZVdab01lTitUUTVJUmFsK0JoaEJWTlVz?=
 =?utf-8?B?b1dkcVBjMFpxVENEckpLUEtudnRqNi9La3lVcFNrQncwYWxGNmxESWVSdGJ4?=
 =?utf-8?B?elpaZnNNYUVvcjM1b2RqRTMxaXFsYUdCbnY0M1JCTjIycEhZb0ViWENOeWMw?=
 =?utf-8?B?NEY2bFVkb3dheWcwaEdpenJSNzFMY0xyVUVjOHNreHpCZTY5U1R5NzZQb05M?=
 =?utf-8?B?K2V5LzlWNXRPeVJKNEVmalJZbHlYMFZLbVpMM2ZJOC9iT28ybmRhR2cweTZr?=
 =?utf-8?B?UERRaEd1VUpIRFZ0ZEY2Rkpld1o5cng4MndLb01ZZXV4Sm54S3ZwdlB2VzVZ?=
 =?utf-8?B?cHIvOVEyUHZWTUZlbTNMMXRQM09tdW1WbmkycVF1UHZ3UFpxTU1RTlRhL3hZ?=
 =?utf-8?B?WEpEMCtyNmxoYTNCWTVxZks5dy9UL2c2dmdleGVoem5SaWZtN3Q4QmJIYlBE?=
 =?utf-8?B?S0U3blNjL1hYSDl3S2FiNXBYQ2lVWXRoRmJxN214UlRSSzMyT29mRGlDeFR4?=
 =?utf-8?B?Vi84YnlUVmJXUHdkdWYwbTFJeURuckl6Z3NkSnY4K2JHNnltY3RBRCtqRk5K?=
 =?utf-8?B?bWl5NFlpcVcwNnAxNWJSTEVsZm1qQ2dLRVh5TlBQWHVKOFhNaldJM2xPM0Zx?=
 =?utf-8?Q?XwXHaBi79YL23/RyUEISho4rEAh+qlmFo4?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61459f3f-4f75-495f-c825-08dbcff21229
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 15:51:19.6421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPwdjee57TN2tnb0j+43EnTY6P7XB6IT4zaMw6/RJD9ZnntMam4bb209ldgw2O7R7ehviEbWHCMGZsAAh1m5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5495
X-BESS-ID: 1697644286-105352-12346-4480-1
X-BESS-VER: 2019.1_20231013.1615
X-BESS-Apparent-Source-IP: 104.47.70.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWpkZAVgZQ0CjRODXZzCLJOM
        XcOMnCwMQ0xSQxMTHJxCDR3MzUwCJRqTYWALdjByVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251526 [from 
        cloudscan13-75.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTgvMjMgMTY6NDAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPiBPbiAxMC8xOC8yMyAx
NjoyNiwgQW5kcsOpIERyYXN6aWsgd3JvdGU6DQo+PiBPbiBXZWQsIDIwMjMtMTAtMTggYXQgMTE6
NTIgKzAwMDAsIEJlcm5kIFNjaHViZXJ0IHdyb3RlOg0KPj4+IE9uIDEwLzE4LzIzIDEzOjQ2LCBB
bmRyw6kgRHJhc3ppayB3cm90ZToNCj4+Pj4gT24gV2VkLCAyMDIzLTEwLTE4IGF0IDExOjM5ICsw
MDAwLCBCZXJuZCBTY2h1YmVydCB3cm90ZToNCj4+Pj4+IE9uIDEwLzE4LzIzIDEzOjE1LCBBbmRy
w6kgRHJhc3ppayB3cm90ZToNCj4+Pj4+PiBGcm9tOiBBbmRyw6kgRHJhc3ppayA8YW5kcmUuZHJh
c3ppa0BsaW5hcm8ub3JnPg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyByZXZlcnRzIGNvbW1pdCAzMDY2
ZmY5MzQ3NmMzNTY3OWNiMDdhOTdjY2UzN2Q5YmIwNzYzMmZmLg0KPj4+Pj4+DQo+Pj4+Pj4gVGhp
cyBwYXRjaCBicmVha3MgYWxsIGV4aXN0aW5nIHVzZXJzcGFjZSBieSByZXF1aXJpbmcgdXBkYXRl
cw0KPj4+Pj4+IGFzDQo+Pj4+Pj4gbWVudGlvbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZSwgd2hp
Y2ggaXMgbm90IGFsbG93ZWQuDQo+Pj4+Pj4NCj4+Pj4+PiBSZXZlcnQgdG8gcmVzdG9yZSBjb21w
YXRpYmlsaXR5IHdpdGggZXhpc3RpbmcgdXNlcnNwYWNlDQo+Pj4+Pj4gaW1wbGVtZW50YXRpb25z
Lg0KPj4+Pj4NCj4+Pj4+IFdoaWNoIGZ1c2UgZmlsZSBzeXN0ZW0gZG9lcyBpdCBleGFjdGx5IGJy
ZWFrPyBJbiBmYWN0IHRoZXJlDQo+Pj4+PiBoYXZlbid0DQo+Pj4+PiBiZWVuDQo+Pj4+PiBhZGRl
ZCB0b28gbWFueSBmbGFncyBhZnRlciAtIHdoYXQgZXhhY3RseSBpcyBicm9rZW4/DQo+Pj4+DQo+
Pj4+IFRoZSBvcmlnaW5hbCBwYXRjaCBicm9rZSB0aGUgZXhpc3Rpbmcga2VybmVsIDwtPiB1c2Vy
IEFCSSBieSBub3cNCj4+Pj4gcmVxdWlyaW5nIHVzZXIgc3BhY2UgYXBwbGljYXRpb25zIHRvIHBh
c3MgaW4gYW4gZXh0cmEgZmxhZy4NCj4+Pj4gVGhlcmUgYXJlIHZhcmlvdXMgc2lkZS1lZmZlY3Rz
IG9mIHRoaXMsIGxpa2UgdW5ib290YWJsZSBzeXN0ZW1zLA0KPj4+PiBqdXN0DQo+Pj4+IGJlY2F1
c2UgdGhlIGtlcm5lbCB3YXMgdXBkYXRlZC4NCj4+Pj4gQnJlYWtpbmcgdGhlIEFCSSBpcyB0aGUg
b25lIHRoaW5nIHRoYXQgaXMgbm90IGFsbG93ZWQuIFRoaXMgaXMgbm90DQo+Pj4+IHNwZWNpZmlj
IHRvIGFueSBwYXJ0aWN1bGFyIGZ1c2UgZmlsZSBzeXN0ZW0uDQo+Pj4NCj4+PiBIb3cgZXhhY3Rs
eSBkaWQgaXQgYnJlYWsgaXQ/DQo+Pg0KPj4gQXQgbGVhc3QgaW4gQW5kcm9pZCwgY3JlYXRpbmcg
bmV3IGZpbGVzLCBvciByZWFkaW5nIGV4aXN0aW5nIGZpbGVzDQo+PiByZXR1cm5zIC1FRkFVTFQN
Cj4gDQo+IEhtbSwgY291bGQgeW91IHBsZWFzZSBwb2ludCBtZSB0byB0aGUgY29ycmVzcG9uZGlu
ZyBhbmRyb2lkIHVzZXJzcGFjZSANCj4gbGlicmFyeT8gSSBndWVzcyBpdCBpcyBub3QgdXNpbmcg
bGliZnVzZT8gQXQgbGVhc3QgSSB3b3VsZCBsaWtlIHRvIA0KPiB1bmRlcnN0YW5kIHRoZSBpc3N1
ZS4uLg0KPiANCj4+DQo+Pj4gwqAgVGhlc2UgYXJlIGZlYXR1cmUgZmxhZ3MgLSBpcyB0aGVyZSBy
ZWFsbHkgYQ0KPj4+IGZpbGUgc3lzdGVtIHRoYXQgcmVsaWVzIG9uIHRoZXNlIGZsYWcgdG8gdGhl
IGV4dGVuZCB0aGF0IGl0IGRvZXMgbm90DQo+Pj4gd29yayBhbnltb3JlPw0KPj4NCj4+IEkgZG9u
J3Qga25vdyBlbm91Z2ggYWJvdXQgdGhlIGltcGxlbWVudGF0aW9uIGRldGFpbHMsIGJ1dCBldmVu
IG91dHNpZGUNCj4+IEFuZHJvaWQgdXNlciBzcGFjZSBoYWQgdG8gYmUgdXBkYXRlZCBhcyBhIHBy
ZXJlcXVpc2l0ZSBmb3IgdGhpcyBrZXJuZWwNCj4+IHBhdGNoOg0KPj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsL1ltVUtaUUtOQUdpbXVwdjdAcmVkaGF0LmNvbS8NCj4+IGh0dHBzOi8vZ2l0
aHViLmNvbS9saWJmdXNlL2xpYmZ1c2UvcHVsbC82NjINCj4+DQo+PiBXaGljaCBtZWFucyBhbnkg
bm9uLUFuZHJvaWQgdXNlciBzcGFjZSBwcmVkYXRpbmcgdGhvc2UgY2hhbmdlcyBpc24ndA0KPj4g
d29ya2luZyBhbnltb3JlIGVpdGhlci4NCj4gDQo+IFRoZSBwYXRjaCBpbiBsaWJmdXNlIGlzIGZy
b20gbWUsIHRoZXJlIHdhcyBub3RoaW5nIGJyb2tlbi4NCj4gQW5kIEkgZG9uJ3QgdGhpbmsgdGhh
dCBhbnkgb2YgdGhlIGFkZGl0aW9uYWwgZmxhZ3MgYWRkZWQgYXJlIGEgDQo+IF9yZXF1aXJlbWVu
dF8gZm9yIGxpYmZ1c2UgZmlsZSBzeXN0ZW1zIHRvIHdvcmsuIEknbSBub3Qgc3VyZSBpZiBEQVgg
YW5kIA0KPiB0aGUgb3RoZXIgZmxhZ3MgYmVmb3JlIHRoZSBwYXRjaCB3YXMgbWVyZ2VkIGFyZSBh
IF9yZXF1aXJlbWVudF8gZm9yIA0KPiB2aXJ0aW9mc2Qgb3IganVzdCBhIG5pY2UgZmVhdHVyZSB0
byBoYXZlLi4uDQoNCg0KTG9va2luZyBhdCB0aGUgYW5kcm9pZCBrZXJuZWwgc291cmNlOg0KDQov
Kg0KICAqIEZvciBGVVNFIDwgNy4zNiBGVVNFX1BBU1NUSFJPVUdIIGhhcyB2YWx1ZSAoMSA8PCAz
MSkuDQogICogVGhpcyBjb25kaXRpb24gY2hlY2sgaXMgbm90IHJlYWxseSByZXF1aXJlZCwgYnV0
IHdvdWxkIHByZXZlbnQgaGF2aW5nIGENCiAgKiBicm9rZW4gY29tbWl0IGluIHRoZSB0cmVlLg0K
ICAqLw0KI2lmIEZVU0VfS0VSTkVMX1ZFUlNJT04gPiA3IHx8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgIChGVVNFX0tFUk5FTF9WRVJT
SU9OID09IDcgJiYgRlVTRV9LRVJORUxfTUlOT1JfVkVSU0lPTiA+PSAzNikNCiNkZWZpbmUgRlVT
RV9QQVNTVEhST1VHSCAoMVVMTCA8PCA2MykNCiNlbHNlDQojZGVmaW5lIEZVU0VfUEFTU1RIUk9V
R0ggKDEgPDwgMzEpDQojZW5kaWYNCg0KDQpTbyBwYXNzdGhyb3VnaCBnZXRzIGJyb2tlbiB3aXRo
IHRoaXMgY2hlY2sgYW5kIGFuZHJvaWQgaGVhdmlseSB1c2VzIHRoYXQuDQpXb3VsZCBiZSBpbnRl
cmVzdGluZyB0byBrbm93IGlmIHRoaXMgY291bGQgcmVzdWx0IGluIEVGQVVMVC4NCg0KDQpUaGFu
a3MsDQpCZXJuZA0K
