Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA42D7B868E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbjJDR3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbjJDR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:29:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9183B8;
        Wed,  4 Oct 2023 10:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnB6a5pnSsK6FWaVsvwnJs0fY8zkzVoSOpLAxFAPSkfjJH2dqOm0eAH0LRAoAvKiUYpfYJBBkssit5HaUffPFxSHBpLpYRtkPVycv7RhXip40KUvND45eyJj56gDArcNKymDlhf/WC2FS3cM1pyVB/rn/IJTulwb1ILfFLNjqt1eBEBaOKeWYINgM9XNQDPDvgIbEfZkQWMT0LJLJlCfqlkKk11banMMW3Bkc31L7EuuHGFOue9LvoAYwcjI8rkvGvze3p5hhj755VrVTUDqjrrHR55lE6ucpJO+fNPbcP6nVh46nqjHhcQADiquQFkOfrGqQtT/UpbOdqxRSSIVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFAaoOX/wsVCx+7JK4GuOCjNe4Hcm8a4PR49uuM5L30=;
 b=n87cAiA/Owitrv7Ws7m+frM9D8WqrwxoCt0h2IIB1SxWniCPC3qtMXw0iHNdYnhQxf5cDCML532Ihn/MxyKNziOU8xDhkhnM9rygH7n1u3o1Jlje5dNCllwtQ7O3T8oMVPWADjhkR1ZZFTfHsLHQtUBAr2b2yCH0LJA4xSq+HEgIqNIyaF0iryWuSHyK6qwny2sy7ng1XZ6l2a7pK34qHNit5FRl7Ddqr591L2FM63c1YR4aKmhqjeUTQfgUFomWwylbI9GtU20nWetrZ2KmeyvM1lhP1AljMQp8J7l8izjfdv0H1N+DPVuWyN1keZy48pNJR1yLWluzCqlJC9kduw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFAaoOX/wsVCx+7JK4GuOCjNe4Hcm8a4PR49uuM5L30=;
 b=RY4UrxmaRFj+kcA9bBjhOo7Hr5vN3q+H8kOuqOAIh5AGhE8E/gxturAGU5FzOtCv7WSc7yGwys0nsG7+Nd0F5FHWly7+eLMHdd1H07WBcqmWGHb9/FCmV8gmXEgmtOv5hJRwc8RfFKLL2zofeQ20Q44M3Tsn6U1F7Lkv6ii2P/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 17:29:02 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 17:29:02 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 5/8] wifi: wfx: simplify exclusion between scan and Rx filters
Date:   Wed,  4 Oct 2023 19:28:40 +0200
Message-Id: <20231004172843.195332-6-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004172843.195332-1-jerome.pouiller@silabs.com>
References: <20231004172843.195332-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:8:2b::25) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH7PR11MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7fa7f1-9d66-47df-7391-08dbc4ff6695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92xNgbdznuIU8Sa8ZRVhDGfVh6aH2t/ltM4YDFa/Xmo3M5768xLoNbTSKcsv1ONOTHkqr6kmHgYGwCf9YCftEVvb9lPcX19VmE9hAatQhn10Tl40FK0byDLx4z5jv2QVF8gHHK9B4IdRBmUKuMq1fKqLIeyCYjwJETxeg26mHxyhveJwPffS4HdIdlNVPB4VdKCxR8T3ikj+xUOr5v1Lf5F0DJM+s24OG/cRAcNhLRdjKKJsAqG2ahzxJqmb1gBdcepxhlEuExm16k4H07OaU6SNfL4VauThQ/uwlp9+K9VpkhyzKx0Mc00P/PdadD/PXoKRyClr0sYk6RpZIogUFk4JjvZOuNZju9SIoi6SPIVhQJG7p1Ql2G9+loIU5UOphaQXQeZV8CkfCircgKAgdvGExE0in0/2VI3a0Fo2TskgJL1fUNTVKJbzI2Y2UG5GqPbBzWR6S0jykM2EO9J+Shhiu8iAo0HJ1p1EA4kuaLCVXt8OfnV+zVJVJZZ+LZEXydneY2isFK+6IPHNQ8yytk8mVi78IGVPbNDd9xikcKiuTbFTwJHh0x54Mlu1xJpX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39850400004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(36756003)(6512007)(38100700002)(6666004)(52116002)(86362001)(478600001)(6506007)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(107886003)(1076003)(8936002)(4326008)(8676002)(66574015)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlF6cFl3MjVHQ1dRbjhwcVVEV1NHbmVJelNHSHZTVHM2a1ducWZpVU1VYjVu?=
 =?utf-8?B?Rms2eHpNYnpDUVRJejY2andINS8rRnRKQ3lpc0E4aXVtOWlheSs0U0wrblFP?=
 =?utf-8?B?azZCUWozU05oejRhbXRDVHVEZnZQa0hnaDJ6YmtiZ1hNRHBkNTA3SUp6WFdN?=
 =?utf-8?B?RWhBR0xtZlFjRmh0MjJsRWx4d3pVVFNrQ29tVVdZeTV1U0F5OG5oZU8yOTRZ?=
 =?utf-8?B?ZXZiR0c4VGxHZUdJbDBVd0ZsVzc3eGxTWkVNL3NKcU0wTHkvYm11M09vMDFS?=
 =?utf-8?B?YmQ5ZXBJUVVmYlgxS2dpakNhUS9yNEdYQlFqZ3FkSGwvMWNPdUZGRHErUDdL?=
 =?utf-8?B?TGdsMVdqYXVvSGxMU2JoN1VNNVRTenZLYXZZK0tsYnNSNS9zOFNUZnBFc0tP?=
 =?utf-8?B?SFFUWDVjOG9QZlEvK3BYVEdxdThNcGNWL0hGeWl0VlEreXF1UlBJM2daQXEy?=
 =?utf-8?B?UzlyTFNPd3FhMG9ZL1Z3bFNxdW5HWVNPb2gzYUk3Y2luTGJGUVlYcmlVVXQv?=
 =?utf-8?B?SlhXenQybUNLNThKRy9qV1NVT3ZXN1k1bEJCRmpidnA4NXdMSStseHdwZVQz?=
 =?utf-8?B?MXBiSlJIZVEwUGlPN0ViWDdWU3pOMEo3N3RjVWFpTlpzY1pDMUU1V0hrYVJR?=
 =?utf-8?B?S2tOdW00L0pzTVJUVGZoaEorMkpQNlhCeldtS3dFYUVMNVdINE52UFhpZnBF?=
 =?utf-8?B?dzkzakpRYTRibFB1dVZlT09TVjFTalJRblgyYjhZNmVQNmgvMmZSU2JxSVRn?=
 =?utf-8?B?dzI3TmJMVTZ6YTE0UWxPODhQOVlKU3BnNE5XV3Z6L1M0MWRoOGNmckFzWlU2?=
 =?utf-8?B?ZnpZUTVBVFJwalVtWjg1YU9aelBJYmdLazhvWmVvN2kwOUdBQVFNUUlhOE9Y?=
 =?utf-8?B?NTI3ZlFMUC9TZGpIQzJCekZUNmE2b0tnQVZrT1ZTdVJXOU90N08vSHg0ajVY?=
 =?utf-8?B?bEN6NXdOL2t6SnVabkRJdlQzZU5zNjRJTk5PVXJsQmk5ajk2UW1Sdi9YY3F1?=
 =?utf-8?B?MjhEenc3RjdoaWdFODVEQmVnczNjMTRaYUwvM0ExakYrRldPa2JMRTZEM1Ja?=
 =?utf-8?B?ZzZnTUtsYkhUeW5Sckc4MktLZmdkMlRaWTJUQnVBYUtTS2svdE5rNnlIUTd4?=
 =?utf-8?B?SzNHNlI1T0lhUHJBYlhhUDlrUWt0WXphRnc0Rzl2VEV5dTh3TEp1elpsVVNi?=
 =?utf-8?B?SUpCbmdmejB2Szc2WVVVcm44WHVIVktyT2ljdlJkU0ZvVHh3cC9vR25LNjYv?=
 =?utf-8?B?THRkWGM3d1NwTTgxVmNaL0lXVmNqTzBCRExWQnZUYmhocHFCNFVCWmRLTXhT?=
 =?utf-8?B?c2ZBaW45YkhyQmhOZ0g2ekxVeXk3TjBpTG5tUzBhc0F4bkRob3FDeS9WVWlJ?=
 =?utf-8?B?TGV4WGJiSWZoMHNWenByTWx3NHF0ZWdySzJJd0JjVytpdVAvdzF4RHExclhB?=
 =?utf-8?B?YVg1eXBjUktyS0Q2VG1ZaWlaTGJqdTZWZnNsejBIaklyQ1Y4TVlWR1BOMkxi?=
 =?utf-8?B?ajlGU05qd0s3TmQrcXRzRkpNTm9GSm5aeklrYnkydmNMdXFvNFpTT1VtOHJ4?=
 =?utf-8?B?L1NMTEd5dEhRVzVrT1YzbHdMSjh0V2FLNDJyMzN3TFpodUptc2dKc25jTlpk?=
 =?utf-8?B?RVNsaVdOK1lJMXBmNkttTG1oMEE4bi9NU2FsSHJVeDNzcmhsSCsvRjNDYkhw?=
 =?utf-8?B?K2ZuQ2l6Qyt0blZjc0h5c0JHaTNRMlptR0k1cC8yWWpCU2pFVEhLa3VrZGZJ?=
 =?utf-8?B?U2k1UFhRdTVYcUxlbTVTNEE1SXBGd0RQb3R1Q3EyU25DSXF0NE02a0VPK1Y3?=
 =?utf-8?B?ekpQZ0RFNkdHSTMxR2swU1J3dVB5dVhid0lrNEcyd29VaXRqLzZYRDZlTkJ1?=
 =?utf-8?B?N1A5bDlQZndhdTlmbGxOLzAyRXhONEtyQitId3lPMW5tWjhkdkN2M0YzOGMz?=
 =?utf-8?B?bitISGNnRlRiNGtEYXB5Y2FIZ0RLMnRaSG96ZzNaN1ZkK2FEMWVUcXpjeEZG?=
 =?utf-8?B?WGFYNGtEZEp3b3pCakk1QkYydERpUXA4UjlSeFNGM3J3czBNbTIyazM4RTdQ?=
 =?utf-8?B?NE14VDNqdk0xZ29kN1lRRjJGMzFLSGhpQ3EvU3cwTlpqN3hlMEEvd3lXdU9j?=
 =?utf-8?B?TkNqdGJwcm5qN1hNcFdmQTFta1pjaithU3BwM3lCYWxKRjNvNTRXSXIvbWdU?=
 =?utf-8?Q?ohQSCtWTGB6jt0NPrABRxaU5SOLVzCeQsghpUre1rsAX?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7fa7f1-9d66-47df-7391-08dbc4ff6695
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:29:02.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxqjaRYIJIJCh8UUWHXpByDAGqyqSfgzthxs9By7LykSge+hRlaZ59Bgb4anKLCscTwt0m/2fYDzIu2pBH8pRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRldmljZSBpZ25vcmUgdGhlIHJ4IGZpbHRlcnMgZHVyaW5nIHRoZSBzY2FuIG9wZXJhdGlv
bi4Kd2Z4X2NvbmZpZ3VyZV9maWx0ZXIoKSBhY3F1aXJlcyBzY2FuX2xvY2sgdG8gcmVmbGVjdCB0
aGlzIHJlc3RyaWN0aW9uLgpIb3dldmVyLCBpdCBpcyBub3QgcmVhbGx5IG5lY2Vzc2FyeSBzaW5j
ZSBtYWM4MDIxMSBkb24ndCB0cnkgdG8KY29uZmlndXJlIFJ4IGZpbHRlcnMgZHVyaW5nIHNjYW4u
CgpIb3dldmVyLCB0aGUgdGhpbmdzIGFyZSBjaGFuZ2luZy4gVGhlIHNjYW4gb3BlcmF0aW9uIGlz
IGdvaW5nIHRvIGJlIHVzZWQKdG8gaW1wbGVtZW50IHJlbWFpbi1vbi1jaGFubmVsLiBJbiB0aGlz
IGNhc2UsIHdmeF9jb25maWd1cmVfZmlsdGVyKCkgY2FuCmJlIGNhbGxlZCBkdXJpbmcgdGhlIHNj
YW4uIEN1cnJlbnRseSwgdGhpcyBzY2VuYXJpbyBnZW5lcmF0ZSBhIGRlbGF5CnRoYXQgZW5kIHdp
dGggYSB0aW1lb3V0IGluIHRoZSB1cHBlciBsYXllcnMuIEZvciB0aGUgZmluYWwgdXNlciwgc29t
ZQpzY2VuYXJpbyBvZiB0aGUgRWFzeUNvbm5lY3Qgc3BlY2lmaWNhdGlvbiBlbmQgd2l0aCBhIGZh
aWx1cmUuCgpTbywgYXZvaWQgYWNxdWlyaW5nIHRoZSBzY2FuX2xvY2sgYW5kIGp1c3QgcmV0dXJu
LgoKU2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxh
YnMuY29tPgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgfCA4ICsr
KystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCmluZGV4IGM1OGRiMmJjZWE4N2IuLmNi
MDNhNWNmN2ZmYTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
c3RhLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwpAQCAtOTYs
MTAgKzk2LDEyIEBAIHZvaWQgd2Z4X2NvbmZpZ3VyZV9maWx0ZXIoc3RydWN0IGllZWU4MDIxMV9o
dyAqaHcsIHVuc2lnbmVkIGludCBjaGFuZ2VkX2ZsYWdzLAogCSp0b3RhbF9mbGFncyAmPSBGSUZf
QkNOX1BSQlJFU1BfUFJPTUlTQyB8IEZJRl9BTExNVUxUSSB8IEZJRl9PVEhFUl9CU1MgfAogCQkJ
RklGX1BST0JFX1JFUSB8IEZJRl9QU1BPTEw7CiAKKwkvKiBGaWx0ZXJzIGFyZSBpZ25vcmVkIGR1
cmluZyB0aGUgc2Nhbi4gTm8gZnJhbWVzIGFyZSBmaWx0ZXJlZC4gKi8KKwlpZiAobXV0ZXhfaXNf
bG9ja2VkKCZ3dmlmLT5zY2FuX2xvY2spKQorCQlyZXR1cm47CisKIAltdXRleF9sb2NrKCZ3ZGV2
LT5jb25mX211dGV4KTsKIAl3aGlsZSAoKHd2aWYgPSB3dmlmX2l0ZXJhdGUod2Rldiwgd3ZpZikp
ICE9IE5VTEwpIHsKLQkJbXV0ZXhfbG9jaygmd3ZpZi0+c2Nhbl9sb2NrKTsKLQogCQkvKiBOb3Rl
OiBGSUZfQkNOX1BSQlJFU1BfUFJPTUlTQyBjb3ZlcnMgcHJvYmUgcmVzcG9uc2UgYW5kCiAJCSAq
IGJlYWNvbnMgZnJvbSBvdGhlciBCU1MKIAkJICovCkBAIC0xMjYsOCArMTI4LDYgQEAgdm9pZCB3
ZnhfY29uZmlndXJlX2ZpbHRlcihzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgdW5zaWduZWQgaW50
IGNoYW5nZWRfZmxhZ3MsCiAJCWVsc2UKIAkJCWZpbHRlcl9wcmJyZXEgPSB0cnVlOwogCQl3Znhf
aGlmX3NldF9yeF9maWx0ZXIod3ZpZiwgZmlsdGVyX2Jzc2lkLCBmaWx0ZXJfcHJicmVxKTsKLQot
CQltdXRleF91bmxvY2soJnd2aWYtPnNjYW5fbG9jayk7CiAJfQogCW11dGV4X3VubG9jaygmd2Rl
di0+Y29uZl9tdXRleCk7CiB9Ci0tIAoyLjM5LjIKCg==
