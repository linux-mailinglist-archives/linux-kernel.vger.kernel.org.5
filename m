Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365E97B8690
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjJDR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243659AbjJDR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:29:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FCED7;
        Wed,  4 Oct 2023 10:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ44YiThTT1WwfjpCgYQ2+2bNS8gbkQykFeQzGAd8q4ED2XJtEokrWEQFqQKiNxu9cVoJUUt8NQ9OGSlq07YrJRAieAYCT68R6C2PYo3F76lr/LNrkY/RcbivoZnHd5CkU9FCeWgzMpAMLSXzfBeajKpi1Wtzd7HEXp+DQ6ctWNFfVhczNoXCLvagrzmcfvvVZo9yFUELtpnaJXGRtBPW+s3EaDaTceadaNprUdjIMOJuzcXIpzIyI7HlZ67lAbQDI/kEu08gJ0Vpgn/L9VgvpKvALJeKyUTntSbCv91nQpYw+6kJjM9Mv38wf6Hwur4X13R3rc+irRe+XyMI3thUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAXF46m/CPJayObdo/yO2Zf+QM4FW1e/fwL2cbCAoNA=;
 b=GZE+P1iJX3jwVpym3Uz8/4iYmueTjzH05jxGdbMhOzAcXpYEexyWc713vSje9C1Swu8r1TK129fZJQ2M7eTVEHh7g7g0hNfZYKtGdaDcTRh8d3aaHu8uTKHmVNFYyA97FoVbDgpnAU79JK6KvZgR5rM2rAJNa22+FQmPFG/llBu3xgj7gyJ11e7xfPA2rxyOG3h/k63e2mzIk7sRcZiG3Ijo/t1mnCBIcoqen8CPML/ttQttQmIyJbDCEm8SYpqQVw4daUDvQgh2RmjHHQm+Zj2SslsTvt9ggBkA3rFndoZZavvDyqnRL+zeU89ibuLk0o+eJxQiy7GlLE9nxIPk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAXF46m/CPJayObdo/yO2Zf+QM4FW1e/fwL2cbCAoNA=;
 b=YKZyRrg3FcPlhUnKuLTkGktpzeAuSp1oW7SCSSDhnVf9Ai6s6vWPHk8d39kJtpYHuVrHheftecrMLIkmBaiXsr5B2B8+N3vcFvrIkN+yeNABIqV7sfnAkhoRnnzXvieg9ez4qXzfry7v/LM6AI85qI2yKPz9RB6h0yzknXL1GtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 17:29:03 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 17:29:03 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 6/8] wifi: wfx: scan_lock is global to the device
Date:   Wed,  4 Oct 2023 19:28:41 +0200
Message-Id: <20231004172843.195332-7-jerome.pouiller@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: d599b826-ab11-4ed4-bf1e-08dbc4ff675d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdQkG3GFtGVgeME77MkkfPA0KZlDX9i2iinEZfnNXbmMLZy7h/e2RCy3t3dTknSluHXSCuObLvok1SOlz+DISjwPFJT9vgEwm8THYJdv964CSW2u9mJcGjmYEf0Ft2eEY/6eKKxzRtfKJSEC123zQPvsG3FgRCoCy45+26wwIGge82QZ25QrWk05VQ+aAbCgCOnFJ3Q5obQSrk7cYXfO97zxB2xbyXOAnGoZ8wlCxgxC0pLH0RmJtqDfanV3pAjqRYfjoaIhHpm373Y+0SZhQiyI2Nka5qjOG7dqeadTo3xAwzBYizW/sjNg3MomnB51S04daBXBfyzXOFWJLWpn9JP+swuqUJ/zYd/s14Z44dSpwXepufhYbk2DHuTKoKKkP1e6oXk4TBzfltG9P2d5KLlwyH8oAIJ4kZ0g8hRXxN9ck2uijrLYikWzdXAgoQkNDXsEI7P5BupPz2rton+lxU5Uh+knQmNxcHIjBQoQljlc0yKWBEnzaFHXluRI2v0mEgeJdgJB/SsAvjZBjQOJ1tR6QcpvKVEfl4Sk7NSVWIotVHiMERqYch+72bfsyimd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39850400004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(36756003)(6512007)(38100700002)(6666004)(52116002)(86362001)(478600001)(6506007)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(107886003)(1076003)(8936002)(4326008)(8676002)(66574015)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGsvSGdRK2NXRlphQ092U0RVM0MrNlhQek5SMUpzWU81NnV2R2dFNFlDK2do?=
 =?utf-8?B?Qm5YdG1qaWloRzZLRmhoL2djZ0ViN0g0Z3U4TWU0MEU1VlVYRWVRZzRwMzlV?=
 =?utf-8?B?L2UwcDJOK3ZmYjdJQ1huRHJLNi9oVHh5bUJFUm1SVmszQWlydjNUd3h1azRw?=
 =?utf-8?B?Q3R2ejNvUVBNajhkeFhnR3JGWTRmV1hKS1c4VTUyNm1WdGpkK1I3WGovTmJZ?=
 =?utf-8?B?VWU0MjI1K2VMMzd0UzljV2ZBVnc3Z1pTZFRKY1JhbnpKVk8zS2xTWk1tZnJH?=
 =?utf-8?B?Kzg2WnJuYlR1Q05scXorNGdMV0NaVVA4RDREdmxmVHg0OThrV3lEZ1ZuS0lr?=
 =?utf-8?B?SElxNHdMRmdVRU13YkEvSHpEell3elc1K2tyendBYWZxcWx5eWhiZEpEaXZx?=
 =?utf-8?B?U3lIY0FhanMxc0F6MUhRRmVZMkg0eENxUFZFTGJiNDVlUEtXbnRSQnpQRnJ4?=
 =?utf-8?B?NlNHMlBESUNZTkZ4OFFlQ3BXSlgzSWZzVDJ4TGJBWUF0R2QvYTJBcUNKUnRB?=
 =?utf-8?B?Ym4wUU9LNHgzbjZhQXZ1UFZiVXNqc3VmNDFwK05mWkVxMjJBZ1hvTkl4eGtC?=
 =?utf-8?B?eFlkUEh0M3BYQWVkSmV3RzRKbU5KV3pFZVlIYTNza1NBQ01MTnhpdVk1UG1U?=
 =?utf-8?B?NVF1RzBwV290OGdia2tKRHQydVJnTzFyTzRaYkwvdzN5QVgvK01SSUZpU2xo?=
 =?utf-8?B?a2pWYjNFcHZNQzNnejd1d1NPdHZ1SkV0cncwZ2hKeEREWXZYTklzSUFhOVps?=
 =?utf-8?B?NEdnOWc4ckUvN29UOUZtOU5TY0h6d2RIWU4wQXJiYlJXaUttNWRTbnVsN3pT?=
 =?utf-8?B?Q09DQnNQOGd1Qk5Tc3JzYjBiZGQxTzl6TjZCQnV3OXQzV2dpTDVSRGNXRy82?=
 =?utf-8?B?bDc4MjRLa3lXbDBmRjh1V3RzS29qUi9DQTNDR2ZUaXQzQ3haQnZ0MnFmdjdU?=
 =?utf-8?B?TlhOb0xJZnFON01VRWExZkJnQkRNSzVaTit3MHp5QisvY2ttYi9wanFxRmtm?=
 =?utf-8?B?V3ZtWFl3NDAzS3Z4OXQrR1E4UGtLRGF3a1F2NFNGRzBndlpFZzJ0YnMzYTRJ?=
 =?utf-8?B?dDZhMEUyUXhuVFY2amJ0SDU1YkNNaFBjN05McEhXWUNqdktRa2xFRVRZVis2?=
 =?utf-8?B?WGlqbzVZNTgxRUdpNTdCa2haOWRnV0VRKzJYK21GYVE2R0ozN1FwRWJyWU85?=
 =?utf-8?B?ZzlXM2lZTzFWUVo0VzFab3hjTGRDRmo2akpxQWRrcmt1dXY3Wjd2V3JDdkpG?=
 =?utf-8?B?SGdQbG5XK2hmenU1dExEZmpqSEJ2SjJxRG8weUhON24wV1VpTkkvSkcyV0gw?=
 =?utf-8?B?V25HKy9mRDB2aG1IdGVmd01qVnZIYTVxYWQ0NTdtVkxmS0JtZmQ1eUR2TTZO?=
 =?utf-8?B?NWlIRmVZVFlodXh0UGovR21ZYzFXRGtyTjA0MTFWckU2RkRsa25qU0llejA4?=
 =?utf-8?B?N3gzd1g3dnBPVkpGZHR0S0phTVhpTGpEUzhoc2dqMDBsRTA1aGRySFZHbHlT?=
 =?utf-8?B?WTFRYUxCSitVZXNYYWZKWThiWXdZUWIvMUlqT3dNb1p4aG9qaU9UTEJVU1Rs?=
 =?utf-8?B?MzgvZDVWOW11OWtpVFUvdldCWk5Db3BNNW9IUjFQcUtnYU93azRJQnZsa2py?=
 =?utf-8?B?ZGtyQ1ZZeExhamRaclAzY1ZRaUxieklweEFFYUh3SG9rMDcvVFRUREJNRkJB?=
 =?utf-8?B?N0RvRGtiUExVYWpzVFc4K0pBenhFdUYxL2xjaEQwRzUyNkpjbUNKZ1NzdWZD?=
 =?utf-8?B?djdhTE45bG9ObUlVdk9QbUhPYlkrWjlCRTJmU2VYYmZ6eHBDbXRRd0tvNmpv?=
 =?utf-8?B?dnh2cGFSdVVMc1BEd2F3cGU4cVhhZXgwSlJrdzFacllMQk0zV2Q2UU9tNHBp?=
 =?utf-8?B?anJYdW9kTGpOeFVmb0w0YjMxbDBieFV3VmR3ZUJMUmpXN0lqSXhHZFl2UWQ4?=
 =?utf-8?B?aC8vVGdkaGM1U09ENXZIOG1lclpZTGFMKzM5UEJ1R00wYVFqVFRhbTM2V3lN?=
 =?utf-8?B?V2phZmoxQUxrUGRVZkZkMzBBKzk4a0h6dFdDSVRFUTdBSi8wQXNMK2NvSk9l?=
 =?utf-8?B?bDdLQ25hTFEyM2xWN0xXbVZUVTNGVFp1ZHRPNElvVUdiUWFiR09WWEhNQVh5?=
 =?utf-8?B?cHQwV2JRaHQvUkhEVU9SVUNCb3NCdGQwdlRacVRtVS9Ma0JCRDBmM2krU0E5?=
 =?utf-8?Q?kHUtfh6sY31WThEwe2DZzviYWQBr54btwOBBQdwa0k7U?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d599b826-ab11-4ed4-bf1e-08dbc4ff675d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:29:03.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sawYa2969wMq0db4fkZUaWgadFlgdx9+gu50yiHV8RbkgjwxZOvTDFqw77B192wvyloPDh/Dph4UB8lU4DoFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q3VycmVudGx5LCBvbmUgc2Nhbl9sb2NrIGlzIGFzc29jaWF0ZWQgdG8gZWFjaCB2aWYuIEhvd2V2
ZXIsIGNvbmN1cnJlbnQKc2NhbiBvbiB2aWZzIGlzIGV4cGxpY2l0bHkgcHJvaGliaXRlZCBieSB0
aGUgZGV2aWNlLiBDdXJyZW50bHksCnNjYW5fbG9jayBpcyBhc3NvY2lhdGVkIHdpdGggYSB2aWYg
YnV0IGl0IGlzIGFsd2F5cyBsb2NrZWQgd2l0aApjb25mX211dGV4ICh0aGVyZSBpcyBhIGNhc2Ug
d2hlcmUgY29uZl9tdXRleCBpcyBub3QgYXNzb2NpYXRlZCB0bwpzY2FuX2xvY2sgYnV0IHNjYW5f
bG9jayBpcyB0ZXN0ZWQgb24gYWxsIGludGVyZmFjZXMpLiBTbyBjb25jdXJyZW50IHNjYW4Kb24g
dmlmcyBjYW5ub3QgaGFwcGVuLgoKU28sIHRoaXMgcGF0Y2ggcmVsb2NhdGUgc2Nhbl9sb2NrIHRv
IHRoZSBkZXZpY2UgYW5kIHNpbXBsaWZ5IHRoZSBjb2RlLgoKU2lnbmVkLW9mZi1ieTogSsOpcsO0
bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgotLS0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jIHwgIDIgKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L3NpbGFicy93Zngvc2Nhbi5jIHwgIDQgKystLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9zdGEuYyAgfCAxMSArKystLS0tLS0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC93ZnguaCAgfCAgMyArLS0KIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMv
d2Z4L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCmluZGV4
IGVkZTgyMmQ3NzFhYWYuLjRiZjE2YmNlYjBiYmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFi
cy93ZngvbWFpbi5jCkBAIC0yNDYsNiArMjQ2LDcgQEAgc3RhdGljIHZvaWQgd2Z4X2ZyZWVfY29t
bW9uKHZvaWQgKmRhdGEpCiAKIAltdXRleF9kZXN0cm95KCZ3ZGV2LT50eF9wb3dlcl9sb29wX2lu
Zm9fbG9jayk7CiAJbXV0ZXhfZGVzdHJveSgmd2Rldi0+cnhfc3RhdHNfbG9jayk7CisJbXV0ZXhf
ZGVzdHJveSgmd2Rldi0+c2Nhbl9sb2NrKTsKIAltdXRleF9kZXN0cm95KCZ3ZGV2LT5jb25mX211
dGV4KTsKIAlpZWVlODAyMTFfZnJlZV9odyh3ZGV2LT5odyk7CiB9CkBAIC0zMTQsNiArMzE1LDcg
QEAgc3RydWN0IHdmeF9kZXYgKndmeF9pbml0X2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIGNv
bnN0IHN0cnVjdCB3ZnhfcGxhdGZvcm1fZGEKIAkJZ3Bpb2Rfc2V0X2NvbnN1bWVyX25hbWUod2Rl
di0+cGRhdGEuZ3Bpb193YWtldXAsICJ3Znggd2FrZXVwIik7CiAKIAltdXRleF9pbml0KCZ3ZGV2
LT5jb25mX211dGV4KTsKKwltdXRleF9pbml0KCZ3ZGV2LT5zY2FuX2xvY2spOwogCW11dGV4X2lu
aXQoJndkZXYtPnJ4X3N0YXRzX2xvY2spOwogCW11dGV4X2luaXQoJndkZXYtPnR4X3Bvd2VyX2xv
b3BfaW5mb19sb2NrKTsKIAlpbml0X2NvbXBsZXRpb24oJndkZXYtPmZpcm13YXJlX3JlYWR5KTsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2FuLmMKaW5kZXggMTZmNjE5ZWQyMmUwMC4u
ZDZmOTgwMzVmNjg0NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dm
eC9zY2FuLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2FuLmMKQEAg
LTk1LDcgKzk1LDcgQEAgdm9pZCB3ZnhfaHdfc2Nhbl93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAq
d29yaykKIAlpbnQgY2hhbl9jdXIsIHJldCwgZXJyOwogCiAJbXV0ZXhfbG9jaygmd3ZpZi0+d2Rl
di0+Y29uZl9tdXRleCk7Ci0JbXV0ZXhfbG9jaygmd3ZpZi0+c2Nhbl9sb2NrKTsKKwltdXRleF9s
b2NrKCZ3dmlmLT53ZGV2LT5zY2FuX2xvY2spOwogCWlmICh3dmlmLT5qb2luX2luX3Byb2dyZXNz
KSB7CiAJCWRldl9pbmZvKHd2aWYtPndkZXYtPmRldiwgImFib3J0IGluLXByb2dyZXNzIFJFUV9K
T0lOIik7CiAJCXdmeF9yZXNldCh3dmlmKTsKQEAgLTExNiw3ICsxMTYsNyBAQCB2b2lkIHdmeF9o
d19zY2FuX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJcmV0ID0gLUVUSU1FRE9V
VDsKIAkJfQogCX0gd2hpbGUgKHJldCA+PSAwICYmIGNoYW5fY3VyIDwgaHdfcmVxLT5yZXEubl9j
aGFubmVscyk7Ci0JbXV0ZXhfdW5sb2NrKCZ3dmlmLT5zY2FuX2xvY2spOworCW11dGV4X3VubG9j
aygmd3ZpZi0+d2Rldi0+c2Nhbl9sb2NrKTsKIAltdXRleF91bmxvY2soJnd2aWYtPndkZXYtPmNv
bmZfbXV0ZXgpOwogCXdmeF9pZWVlODAyMTFfc2Nhbl9jb21wbGV0ZWRfY29tcGF0KHd2aWYtPndk
ZXYtPmh3LCByZXQgPCAwKTsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93Zngvc3RhLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCmlu
ZGV4IGNiMDNhNWNmN2ZmYTQuLjg1MzNiYWQ2Y2FlYWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2ls
YWJzL3dmeC9zdGEuYwpAQCAtOTcsNyArOTcsNyBAQCB2b2lkIHdmeF9jb25maWd1cmVfZmlsdGVy
KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCB1bnNpZ25lZCBpbnQgY2hhbmdlZF9mbGFncywKIAkJ
CUZJRl9QUk9CRV9SRVEgfCBGSUZfUFNQT0xMOwogCiAJLyogRmlsdGVycyBhcmUgaWdub3JlZCBk
dXJpbmcgdGhlIHNjYW4uIE5vIGZyYW1lcyBhcmUgZmlsdGVyZWQuICovCi0JaWYgKG11dGV4X2lz
X2xvY2tlZCgmd3ZpZi0+c2Nhbl9sb2NrKSkKKwlpZiAobXV0ZXhfaXNfbG9ja2VkKCZ3ZGV2LT5z
Y2FuX2xvY2spKQogCQlyZXR1cm47CiAKIAltdXRleF9sb2NrKCZ3ZGV2LT5jb25mX211dGV4KTsK
QEAgLTYyMSwxOCArNjIxLDE0IEBAIGludCB3Znhfc2V0X3RpbShzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSwgYm9vbCBzZXQpCiAKIHZvaWQgd2Z4X3N1
c3BlbmRfcmVzdW1lX21jKHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBlbnVtIHN0YV9ub3RpZnlfY21k
IG5vdGlmeV9jbWQpCiB7Ci0Jc3RydWN0IHdmeF92aWYgKnd2aWZfaXQ7Ci0KIAlpZiAobm90aWZ5
X2NtZCAhPSBTVEFfTk9USUZZX0FXQUtFKQogCQlyZXR1cm47CiAKIAkvKiBEZXZpY2Ugd29uJ3Qg
YmUgYWJsZSB0byBob25vciBDQUIgaWYgYSBzY2FuIGlzIGluIHByb2dyZXNzIG9uIGFueSBpbnRl
cmZhY2UuIFByZWZlciB0bwogCSAqIHNraXAgdGhpcyBEVElNIGFuZCB3YWl0IGZvciB0aGUgbmV4
dCBvbmUuCiAJICovCi0Jd3ZpZl9pdCA9IE5VTEw7Ci0Jd2hpbGUgKCh3dmlmX2l0ID0gd3ZpZl9p
dGVyYXRlKHd2aWYtPndkZXYsIHd2aWZfaXQpKSAhPSBOVUxMKQotCQlpZiAobXV0ZXhfaXNfbG9j
a2VkKCZ3dmlmX2l0LT5zY2FuX2xvY2spKQotCQkJcmV0dXJuOworCWlmIChtdXRleF9pc19sb2Nr
ZWQoJnd2aWYtPndkZXYtPnNjYW5fbG9jaykpCisJCXJldHVybjsKIAogCWlmICghd2Z4X3R4X3F1
ZXVlc19oYXNfY2FiKHd2aWYpIHx8IHd2aWYtPmFmdGVyX2R0aW1fdHhfYWxsb3dlZCkKIAkJZGV2
X3dhcm4od3ZpZi0+d2Rldi0+ZGV2LCAiaW5jb3JyZWN0IHNlcXVlbmNlICglZCBDQUIgaW4gcXVl
dWUpIiwKQEAgLTczMCw3ICs3MjYsNiBAQCBpbnQgd2Z4X2FkZF9pbnRlcmZhY2Uoc3RydWN0IGll
ZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYpCiAJY29tcGxldGUoJnd2
aWYtPnNldF9wbV9tb2RlX2NvbXBsZXRlKTsKIAlJTklUX1dPUksoJnd2aWYtPnR4X3BvbGljeV91
cGxvYWRfd29yaywgd2Z4X3R4X3BvbGljeV91cGxvYWRfd29yayk7CiAKLQltdXRleF9pbml0KCZ3
dmlmLT5zY2FuX2xvY2spOwogCWluaXRfY29tcGxldGlvbigmd3ZpZi0+c2Nhbl9jb21wbGV0ZSk7
CiAJSU5JVF9XT1JLKCZ3dmlmLT5zY2FuX3dvcmssIHdmeF9od19zY2FuX3dvcmspOwogCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3dmeC5oIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC93ZnguaAppbmRleCAxM2JhODRiM2IyYzMzLi5hNDFiMmMz
NWZhNDE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3dmeC5o
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvd2Z4LmgKQEAgLTQzLDYgKzQz
LDcgQEAgc3RydWN0IHdmeF9kZXYgewogCXN0cnVjdCBkZWxheWVkX3dvcmsgICAgICAgIGNvb2xp
bmdfdGltZW91dF93b3JrOwogCWJvb2wgICAgICAgICAgICAgICAgICAgICAgIHBvbGxfaXJxOwog
CWJvb2wgICAgICAgICAgICAgICAgICAgICAgIGNoaXBfZnJvemVuOworCXN0cnVjdCBtdXRleCAg
ICAgICAgICAgICAgIHNjYW5fbG9jazsKIAlzdHJ1Y3QgbXV0ZXggICAgICAgICAgICAgICBjb25m
X211dGV4OwogCiAJc3RydWN0IHdmeF9oaWZfY21kICAgICAgICAgaGlmX2NtZDsKQEAgLTgwLDgg
KzgxLDYgQEAgc3RydWN0IHdmeF92aWYgewogCiAJdW5zaWduZWQgbG9uZyAgICAgICAgICAgICAg
dWFwc2RfbWFzazsKIAotCS8qIGF2b2lkIHNvbWUgb3BlcmF0aW9ucyBpbiBwYXJhbGxlbCB3aXRo
IHNjYW4gKi8KLQlzdHJ1Y3QgbXV0ZXggICAgICAgICAgICAgICBzY2FuX2xvY2s7CiAJc3RydWN0
IHdvcmtfc3RydWN0ICAgICAgICAgc2Nhbl93b3JrOwogCXN0cnVjdCBjb21wbGV0aW9uICAgICAg
ICAgIHNjYW5fY29tcGxldGU7CiAJaW50ICAgICAgICAgICAgICAgICAgICAgICAgc2Nhbl9uYl9j
aGFuX2RvbmU7Ci0tIAoyLjM5LjIKCg==
