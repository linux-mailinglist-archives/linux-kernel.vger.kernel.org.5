Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE67CDB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjJRMNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjJRMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:13:28 -0400
Received: from outbound-ip160b.ess.barracuda.com (outbound-ip160b.ess.barracuda.com [209.222.82.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A52E112;
        Wed, 18 Oct 2023 05:13:25 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by mx-outbound20-166.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 18 Oct 2023 12:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDL35RMTmLujKjktiowam5N4Jho+bAPLyDx4e/oBKTdTMPEbxkDiEW7E3Jcy5lijcInhIIJIsUcuJRFFAOV6OY1sRUnqhsQVVyNr/btddByo/MPzOF0hq2oBHEEZ0QueyF93pxtmT5ISrX8ynwNaxCF3OYwSJao2Fh/eU9GG4W/q7JRnAbevwX75pwSG8CnpzAsD/G5oyU7B2ORSQ4HAkx4PriyjjQPp/h3dFEgyZ4RtayzVc7Jy1x2YGVK4tW3KSK6cc5U578GAdzDBtb/K1G/pDFpWvWBskbD4Q4WHz8SKJ26Rnedhbu3UffcJhxLSXCmPBLh7SCXfrciLBqjVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRAxK0U7TYkpkhGzT5EPTfkXFtyMP7vsyr2Sk3KUca4=;
 b=dvtPpB9aBohJljRRHaiXWEtossuA1mEheYpdl6+F6lA2clAhzpqugHZDX6IS2ceUgpxgFAizk2rPAtQwIbEFvFgrkjLQVLAUjzCqF9Mkpx73CxbfuWgRGyckFVedC/uG97je1USU1o4bmmasNTUaygvqAQ6CeNg5c1VCSrdXKCWvfE6zXjw/q85gDykGDHCIcYoM0OcioePlarRmTD+9KpmZgN1Nneh0CtNswA+qyIFqZw+FVVSHhLg4Mmlvymyj/P9+phYuzLu6izw7HqvfOMNVMuZMU+hHFq2ghL1Tz9U2VzbRbpLY7uG/SrXZSnedcqUIB3W2iubtUUseq3qnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRAxK0U7TYkpkhGzT5EPTfkXFtyMP7vsyr2Sk3KUca4=;
 b=rGzYtMffE0FHXHf9cD/z6exJFFJqMCPbcgZ2S5aw/gGe1mYqDh3ahC5MbaQom2SlMqJatxUKoeOoF0CEHhSapRPPNYwRhXMrQTMOVeIJ4aQ9mnfu3bFXeOfTdJ3ux0uzmjROqV8ahUzi5FbENONEpLWy4z+Rv+XmZMgHYFgpvlw=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by MN0PR19MB6143.namprd19.prod.outlook.com (2603:10b6:208:3cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 11:39:56 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::b051:b4e4:8a2:33a2%5]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 11:39:55 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <git@andred.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT"
Thread-Topic: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
Thread-Index: AQHaAbRpOYa+0Y8j+kCP04IX3OA3s7BPbDcA
Date:   Wed, 18 Oct 2023 11:39:54 +0000
Message-ID: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
References: <20230904133321.104584-1-git@andred.net>
 <20231018111508.3913860-1-git@andred.net>
In-Reply-To: <20231018111508.3913860-1-git@andred.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|MN0PR19MB6143:EE_
x-ms-office365-filtering-correlation-id: 42c905b2-1134-48a8-4def-08dbcfcef303
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3RAqNvVYBd0clF5eVhy53uGwbbLsWvRlsolpae3sJA8LaW3sghkr9ithoB3l8OW7YJanfTMXjr38g9WQCMdjio0D+WhJ+9kohWb27vhx+BqlvMDJqVTJyNB1EjCUEkEkpIRU4MrhpO4d1wMWL6kHkYDJQ3Q/OTJaqrAk+FZbgmd5PXPRXe5xzEsMP+SlooWKKe9B/d+o/L99H8ab4bA8zCPrFn4vrYcRH+T2kFdwuhebVNU2MEYqQ7IFXejby3JsFT0VmrnGn23TbBHwo8JBLPOftKM4lHelO9cqMksItbJX+1W0U/En0Di3SPFk1DZiTZ0j5Wykfztb9/ejZaoKqdiQ7zKWeTMbUt4Aig5OLrOo5gSiMSNdjCSLNolaynICVJCYisAQYD1u7muym+e+3jXfM7wgwGRJkuV1WnlygzbE7g4qWKNH9c47RDQho5ErP8ofbrhepyWV9RZ37055AV60px8beEt6f4BhmLt8dm+yG2TNA1HoS+SYiA9XtPxyq6nlOD8VXf0wrMKKmRXV46uLzyTjyQZtYpHRk1z3H8LCJvYyn8yjzXZD4qdj5SvW+ld+YbxG1WoE4bGeaPUM98/nqzrKFhFM7bw39GqNkyQMBWqAfb9NtAUW7XcaGFB0VW87PiKujqLc1nnuubJlNOIWsgsP+16ydkfoiiJKAVfBzh5Rb9yO8MGXn10rMSUs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39850400004)(376002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(31686004)(6512007)(83380400001)(2616005)(53546011)(71200400001)(6486002)(6506007)(478600001)(41300700001)(36756003)(5660300002)(2906002)(31696002)(38100700002)(8676002)(38070700005)(86362001)(4326008)(8936002)(4744005)(76116006)(66556008)(122000001)(66946007)(316002)(110136005)(64756008)(66446008)(91956017)(66476007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnVUZUFXMk90STNrN3hQUzd4dG9oUy9VRVBkTWJ2VzhQTGh4S0dpVXVYaFpL?=
 =?utf-8?B?cVZXT1N4bUh0V0g0UXJHeE4ybTNlY29xaGFHU29FT2V3SVRNWmgxNVUwQWQ3?=
 =?utf-8?B?dk1iTkVRWEhyeUxUc1lNenQ1NG5sSGd2dHBwVk11cUZnRlRMUm9LTTJuTEdK?=
 =?utf-8?B?RDlFbDQ3UjdlWStmUFkxT29NdFBqaHFyR1c5d3VyZythbWY1L1NBa3o1eE9F?=
 =?utf-8?B?eW5FbDV0dmlURVVNZ0xJKzg3R1VUVmNuSDZpUmJpMlZtM08yMHZEYlRITVR2?=
 =?utf-8?B?VEVMWU5YVXBHVzJIT2U4dyt4S0JnZnBtUmVFSzBFVWNBaDFhazh0cFU4SzE3?=
 =?utf-8?B?aTRNaktVUWY1d1ZvZXQ5LzM2M0NLYVhvWDcrU0NsSGtheW1kSjlUeHo1UnFG?=
 =?utf-8?B?RjEvcmpOQXE4SU5OL2ZsVWdvbUpSZzB0UXNTU2RTd2FDbVhadzNVN3lhRGV4?=
 =?utf-8?B?b1VoK0hKU3J0dWVacjE3WWtVRExSbTdwOE5HdjRFRWNYMEFzblRUbHdpNGxU?=
 =?utf-8?B?eVRuTktJOENrWm5JSFZEOWJUMDA3dW5CUUxvdjF5b0xzSG5IZTJncG1uTFMy?=
 =?utf-8?B?cjYrQWpPMjI3cVZNSjBHWkIvMEtZTElBSk1KdFk3THRnb0hzc2FKclp6ak1N?=
 =?utf-8?B?T25NcmkzZjc0M01oRmZYSVFsYTNJS1ZpcUZvZlR3aXZ1K1FyZjZDRUcwRG43?=
 =?utf-8?B?dlpTdzhCcGpCTUNrMGIrK1c0T0VDZm16S0ZCNEV6c3dIUDhTaklHWHNDQStT?=
 =?utf-8?B?SDFOclMxMDM3aElZZnZjZ2FhMnd3YU9ldE8xZWFjb1RrQk0rUFJCbi94Y3Bm?=
 =?utf-8?B?YWVNZGFza1htRjlja3BUWTRKSXRseW5VeVRqUXdxUENKT3RVVFFEZk1OaFZt?=
 =?utf-8?B?MmJhTllaRHMvQXVvQk1DZGorbjNaRzJMUDN2ZHczSENHMGxKRzJibHNydmJQ?=
 =?utf-8?B?RXE0VWpkcHVpQmk2TXpaRlBXYzZJTTdLaDZ1Z1crczJnYWc4WGpvVzlEdk52?=
 =?utf-8?B?UTVMaUVxS3ZyRGkvTGdNQWxwWXhTNW96MGJ6NFBnOW5NZXUrN3ZiN3NYT0M1?=
 =?utf-8?B?SHNoTFZSV1h4RWdteGR5WmtHVlJNa1BrZHUyeGJNajFpek1KbFNFcnY5UUh3?=
 =?utf-8?B?VU13eGJpN3JwTFJYMHVvRDlabFVVaitoVEFIUkZlaE5NbnI0ZitHRlJ5aW91?=
 =?utf-8?B?OGZycDhwT1lLRTRYemZMWStmak9ycC9ubTlXWG41MWE0RXp4akI4L3hnWUw5?=
 =?utf-8?B?cUliNm0vM1RPN3FFYlVVbktNY0svU2hWSFhEWjljNjZURVNneHlOUGlyOWpi?=
 =?utf-8?B?WnNSdnQ0bTNCWFBWNklvY3YzQmwxeGVLdTRUUXVrakxNRjBKcHM4VlFWY1pM?=
 =?utf-8?B?d1M3Wi9NbFFNb0xSY2VLOFYwcVBTYlR4NDJvVjBwYXE0STJzSHJ2UjM5Y3VD?=
 =?utf-8?B?YW5qenl5dHJwU0cybHdnVkZnYXFvK1E5c3BWMy9HTEV4NWM5dUxuZ0dkRi85?=
 =?utf-8?B?SmliVUk3MFhza1p5c0RtcTRJa2JpbGd2MEcxNTEvbkh1QlZHTXZqUzRkYVk1?=
 =?utf-8?B?cXZDUnlvMlBxNEUrZjdUTHd3NWtoaEU2TUZLMG1CT1crZjJKYVZ4cUJvblZX?=
 =?utf-8?B?ekJpM1dUMldVZW82UkJEeEtZRnFpRlFGUUlZb2VtRGNndHFCd1RnUVVBNWFJ?=
 =?utf-8?B?TkZ5TC9NSWF3L0F1ZHg4STJmVndPbWhPeFRHQWxMQzYzSDM1Rzd1a3VzOENw?=
 =?utf-8?B?bVRNSkNRUFFqMnBJS1NjUFM2VEE2MkNzTzVNaE1KL1RoU08wdEttWnV3dTJW?=
 =?utf-8?B?SU9hcjRkUWg2YlVRcG5CNmdKOUpVUjI3YzZ2WndoN0t4M3dDcWhQR2tBZ2lJ?=
 =?utf-8?B?WkFZa21rMlZBSXF6MXNHR01uKytjTCtPbVdKZ1pidnNjR1B0Z1YzZHEvYndC?=
 =?utf-8?B?T0lqbE5UTE5mZUlsSytFUnFNVUptbkZWdHliZkJyWU9HZVlpT01iQWpPSy9z?=
 =?utf-8?B?dmdjVFRqOWhFRHlnMFI3cnNPRTBMd3plblVlbGdFZUJkZVRPQlVSSm93Y1pS?=
 =?utf-8?B?cHNTVXR0OW9TM0ZJZnZYcTk4R2NhY2FYWWZzdXFzdnNZMGVGd2t5WGd0RUZM?=
 =?utf-8?B?TkUxMnhRc3NxcEF3VmRBTHNjTDFYWU1FeFN6dXZ0Y2V6anptbVhkS2YvM0N5?=
 =?utf-8?Q?tU03OUNI13Jv+MACXnbgFsw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA1F85FF76D0364F811C2F9D183BB007@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T1VEU0FQOXdwWHZiL2l6c0xDVExwRTE1OGFjWTYyYUNpVEh3L0phUUR6WVZU?=
 =?utf-8?B?Q2J2RStVNFdZYWlFQkNzKzdWZ0hxbHlQRWtNNjhWTFBiRk9wVkxUMUFHRHhs?=
 =?utf-8?B?b2xKSnNFdTc0eXZoN1RDMXMvSjFVMktMeHlGZjhDSUQyU1VWYXFidmN1M080?=
 =?utf-8?B?dmVRQmpCTmh6Mjd3U3VhOGlqaC9ZK3pGQzhEYUZrZ3dYUFlWRE5jVGRHOHJl?=
 =?utf-8?B?S1kvTTg5UHYzbW1JMUs3MVY1SlBicUkrQW0vanFJLytTbDA3MkwrZWtoVysw?=
 =?utf-8?B?UVJrVlA2K3Q2N3BmUVVIS3pPbnVJQVlpNGRVaE1VdC9lTDVqM1NCU3dGR0U5?=
 =?utf-8?B?QTcyQlJlcnBySDU1Z05yYWRiNXZVbS9pTlVpTTl2cVR2RUpBYzl2cEJSTXVy?=
 =?utf-8?B?QUJSSEtMdzJmUE8zVmlWaTROa3F3S0xBZWNnNGxvdUw1aHNTNU02b2I0bllV?=
 =?utf-8?B?MStqZUswcGQrMlc5TWlQKzIyUlR4Yi94azIyTjlPQkZ2WFhDUUYyNkw4NHhU?=
 =?utf-8?B?MVpXSk9td05MUkFhLzhnZWRBTkgreGttWnlrMmlTTVdBeTgvelYxMVlvdy9D?=
 =?utf-8?B?bTh5aUpmNzZjSWloSGI3OXhqUzRrSHY2RDFlZUJwdmR0SkxManVVaDJGSk9P?=
 =?utf-8?B?SUUwRkdnWkYva0tNSkxRbHVtbnBzdmJGckozQzJRTTRTOEEzRCtFb1grRUQw?=
 =?utf-8?B?UmRRRXZra2xucG9Fd0VZK3FYOWIzcjlZWUprblVZb3owR0JuWU9ha0JBYmdQ?=
 =?utf-8?B?enFNTS9SOWxIMUQzazRMak9ETWNtN2tWQ2VEMVRjSnRORXRhV0lPblhLRlU4?=
 =?utf-8?B?VzVIVUlPNmlueVcxTXQ2cVFvVkVQVXNiVk5UQVBKeTZvKy83S05ON29RMUE1?=
 =?utf-8?B?cE9HTUF6STRqMFdOa2RTY01PcVdQRnY2Y1o1b25NS3cxRFg4Mlp3YXRML1dS?=
 =?utf-8?B?cW02bVJ6clU3MTdkNmMyLzJiSHlQRVhaTjZmdHlockhzQ2czcys3SFY5aVRN?=
 =?utf-8?B?TERSY1c5QlJjWWdUMjQrb1ZvSWtBREY4YUhra0ZSaGlLTUROZ253SGhXZXph?=
 =?utf-8?B?cDNLcE1PN0o5cmNDZm56Y1FtMDcwd2R2YjBJMmlXdHFFVUdZN0QwZnRyRzBt?=
 =?utf-8?B?THNDcmZuTDBZSTdjdnJoYWh4T0YrOVlDM1hiaGRET1o5VFlzRHdOYW5IS1Yw?=
 =?utf-8?B?bHAxdHpJU2VDUXZSLzdiQmFhd01tV2hIWmkwczBHaUVTcFlqdVA3aGJVN1VK?=
 =?utf-8?Q?nkUsXS0GZ8Sfn/b?=
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c905b2-1134-48a8-4def-08dbcfcef303
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 11:39:55.0140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLg9qXFsA/NkjpP3w5WBGK3iwQZGPJ2aTebhjfiEyf2V7aTDK+JO58OsxBJyaZPCAijgXmPBwU1JHiflkAsFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6143
X-OriginatorOrg: ddn.com
X-BESS-ID: 1697631201-105286-12369-10972-1
X-BESS-VER: 2019.1_20231013.1615
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYGlkBGBlDMwNDEwsTIxMLULN
        HSNNkg1cLSNMXMzCwp0dLALC3ZwlypNhYAwo34K0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251524 [from 
        cloudscan22-168.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTgvMjMgMTM6MTUsIEFuZHLDqSBEcmFzemlrIHdyb3RlOg0KPiBGcm9tOiBBbmRyw6kg
RHJhc3ppayA8YW5kcmUuZHJhc3ppa0BsaW5hcm8ub3JnPg0KPiANCj4gVGhpcyByZXZlcnRzIGNv
bW1pdCAzMDY2ZmY5MzQ3NmMzNTY3OWNiMDdhOTdjY2UzN2Q5YmIwNzYzMmZmLg0KPiANCj4gVGhp
cyBwYXRjaCBicmVha3MgYWxsIGV4aXN0aW5nIHVzZXJzcGFjZSBieSByZXF1aXJpbmcgdXBkYXRl
cyBhcw0KPiBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCB3aGljaCBpcyBub3QgYWxs
b3dlZC4NCj4gDQo+IFJldmVydCB0byByZXN0b3JlIGNvbXBhdGliaWxpdHkgd2l0aCBleGlzdGlu
ZyB1c2Vyc3BhY2UNCj4gaW1wbGVtZW50YXRpb25zLg0KDQpXaGljaCBmdXNlIGZpbGUgc3lzdGVt
IGRvZXMgaXQgZXhhY3RseSBicmVhaz8gSW4gZmFjdCB0aGVyZSBoYXZlbid0IGJlZW4gDQphZGRl
ZCB0b28gbWFueSBmbGFncyBhZnRlciAtIHdoYXQgZXhhY3RseSBpcyBicm9rZW4/DQoNClRoYW5r
cywNCkJlcm5kDQoNCg==
