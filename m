Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6F7B0A62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjI0Qd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjI0Qdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:33:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1304310A;
        Wed, 27 Sep 2023 09:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaOiMBDvYckOVxPr1Hla+orERKqURHWZC5nWLsv98YMqdoUYS7/gz9qQ2y5VoBx564yECGtFn1DP2rtDVyQXr0xTCNN1jA5e24tz7aFKtC9dWuei8YN5GHxnmnwG8zLYjEb/YFWdSIc35s0WEBzobxSOa2NYLX4KSiOdpKujNI9IBAcYDA3r6UjqVHiedEZbiN6kbyq6iLkwXUlGM6GEYcuXn943NRK73WOn3wniyvv3pFIqir9Ju5YJHBeeodWFFnTxC04oJX/DHv6K4+0+/rKDijvSP4VZE+5Kj5sdCBe8gh7jJPBkO6etzYvIPxhJYxduPBBlGyoYfcKYlVYASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEeZTFKIH/xeImm70sYbyeuFRuutq8ymyWu0/ZJegaI=;
 b=WPW3uW70y0SVLIsEznsuICMnweOSicHWNzU9JbiQvMb9ViYgXt3dgtO8Fr4btWqll4uoYINYsjhckHncJbYz8CgUvwXuh+0N6uOxJTS9MmrCXhR1xBgPFh81fyn/iOmAdVIlIVFAUcyfpR6TIks+jlzni1PnH6tOBjhYSkj9a4Xra0N/IXRPJgPMCcSyTMR1jPVbmdFcEulLClNLUZTdGaru4cOmNzOo35FFtE4xKvEwKDSjiUVrBIojIMo1IkLxvqgQXLj0aA5rVR82YEH3WJQid2sBzhXd+gtfSlhSulkQxYoYkbTwCd07AGmIbzQntfqoILQJsO+Af+NSAemdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEeZTFKIH/xeImm70sYbyeuFRuutq8ymyWu0/ZJegaI=;
 b=fda/Ik9IfkYGLt0Et9jOztRJQQRTlutH0D/ml6f09djFqianiZuR92UySzSnd70kZggGlPt6e99E23w1LipeYz0HmkZx8YEU3XXuFoHF9fTmPILoIBqiPdzV/rLaZgBY/BR6ZuYXKC6EEHRuR9w6PJ4inx/EELHfljjPL5GCZyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 16:33:25 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:33:25 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2 6/9] wifi: wfx: implement wfx_remain_on_channel()
Date:   Wed, 27 Sep 2023 18:32:54 +0200
Message-Id: <20230927163257.568496-7-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927163257.568496-1-jerome.pouiller@silabs.com>
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:8:54::30) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|CO1PR11MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: df86e403-c273-459e-e310-08dbbf7778a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psEKFvqlgqj6D4cS6qe0J8z72okMKj4lVDIsEs5aDKIjDgBEAZToemheGobdfmayAKIIqCHiEDlpe+wgDTkUqXhCI1Byh7ltMx7NsN7a5Tg9ezRdzABrGGMhiGCBFwOOGI7tuD7dwDltSgXZVpAcWAodUBfbi36Y+vO7q78ScCxPqwovsrPrtAUth6O0jVaUxOtBG+QvWhE6PDVD+wOyCKO37JxD7D2/yHW/B7INz+PttFeFwQNloo3Kuh4winYIK7+z8zIFfYFg5UCLCp2+2HHkw/m12TB7yOIF2ZLzPHNFYWS53x9uJEZLxTPX/RSy/UoXoLNvP5iRuP0gaoW3Vy69O1Hx5s9A3MjDaGuoenocKJezR9nOOxnZsKaFQ/l0BAa7dcw1tp0dcRtwOvIiuER6LhFYXZlMa4n+zlLnvY1xjMADPBLhmCgqeThK0NvAJwa1K9dv2kyAISrRqXnFvUSG3fRLWakMtr1+z8y/6rnUx3S+T5a0zRNNGC1Z7/PEzrqE4qDUrvVbQsAHjGj4DKsZ9z8SfVrOb8bmO6XwNjEvifrXlerAFZLUEOUpXaHY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(6506007)(107886003)(66574015)(66556008)(66476007)(6666004)(1076003)(86362001)(6486002)(52116002)(6512007)(478600001)(38100700002)(2906002)(83380400001)(5660300002)(316002)(6916009)(36756003)(8936002)(8676002)(2616005)(66946007)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmxmN0NaZ2twekRKem8zMWR2SzF5Wko0YVIySDBzSm9XSTBmK1UzYnFRaG5T?=
 =?utf-8?B?aktPRXN1S3ZUR1h4T3NsMno1d3k2SmhxVFF5T0liRlRxNXRtS25INE9EenBx?=
 =?utf-8?B?ZnBHaEVFYzI0c2Y3ZlhDOHNPL3l1N0sxKzNwR1ZUOEptdVZzaWp6N0xEdEo1?=
 =?utf-8?B?dGQzV0FoSTg2YSsreHBhYXJDTmdCV0hyRmpVeEozZ3h4bUlMNjFYQ0JNa0R0?=
 =?utf-8?B?QjJSOUQ1WUdlYmlHSE1PZFYyWjhaMDY2N3Z0eHNoMXNNekJMNllWNE1DMVQ4?=
 =?utf-8?B?RVQrM1JYbGVuMnpjNFVnK3h5MktqU3VLSkhHYmFxYjJ5UE9RdUozcFlOdGRr?=
 =?utf-8?B?NExXVS85dkRRd1B3VmJ5VUlpaFBlMjdoL1RBRDQxZVIrWlBFZDZOU084ejh5?=
 =?utf-8?B?WFFERkJ5K0ZWYmNwU1pFY2s2YzdOQS9ncmRKcDZ3RU8wQmx4V3Fxa3phRVhI?=
 =?utf-8?B?WWtkazFjclV5cFRQYTJwVWtSbUt5UUp6V0xKejhLV25GU2dZU0lSc2tVcXdM?=
 =?utf-8?B?RlBuMnVMa2N5ZlFMcitvbXdFY0tjODVoODc2dU8yUWVveXVHRE1RMnEvNGZr?=
 =?utf-8?B?dWZLdkdtdG93SC8wT3ZWSmo3ZjdEVUtZcm5ENk1McmRrT1JLcG1CWE9ORldD?=
 =?utf-8?B?WGVlYkxEUVdNN3NSZnh3bDZiTXo2ZCtlWGtuWWlEdUZTMkQxdFJkUkViSEZs?=
 =?utf-8?B?RXRkTm1TYm94dGVjMXBPaHY2NFZBcmI4d043VVdiL0ErU0U1V0Z6U1krc05o?=
 =?utf-8?B?TFc2dlY3bjNxUnRiMXNOMVUxRlZ4RUNNUWdvT0lVYzg0K1VpYXBCVm5mdU5Z?=
 =?utf-8?B?T0xxL1ZlRzdWOXhhbmVLTGRrbllYb0NPN29lZnZLSUM1d3BCazFKZkFodmVs?=
 =?utf-8?B?Sm5pdkNxODU3MlIvZnNNMjc0UGhVeDZNMTVjZjh3WldJMm5zSVRtNEpMU2FF?=
 =?utf-8?B?ZXUzcjV2M1ZQSzZ3b3M5K1g1VTdtYkNYNlM5SVMrbTlWMkFFanRqb1lPeXox?=
 =?utf-8?B?dVpPSCt6VWRDdGxWaFJ3NkJBNUEzMEdFOThkc2hyb2VSZUpLek0xa2tiU2k2?=
 =?utf-8?B?R1kwMEN5bEhCWGVnYjNBUVIvbVJLdFk3Rmc4TkZ6U0d6U0dpK3NvQVRIOFhE?=
 =?utf-8?B?T0dNdDZhK3VZeDhrY1ZkeGk4TmlhVGc2eWZjWWw2ZzhTWTZYYngvTTFycXI4?=
 =?utf-8?B?cEQxNzQ0L1hZNjMrQmdBRDVsd01JMEZNZm5ZaktNYzhybHBudzZCRjI5SzRB?=
 =?utf-8?B?RmtFTURNRHkyNlpsS1NoQXIxVERXV21LalFwVFVnQVBCeTI4S2pZbW5oNkUw?=
 =?utf-8?B?ZFd3eGNNWGg2N1JpR2tXdllzZTlrVmNPdmtmdllvcjNQL1cvSUs4bTRHd0xJ?=
 =?utf-8?B?TkNjUWtERzVpU1JPWU1WZnJ1cmx6S05nci9DR3RrdjNGNVljODNEQnJEMC9s?=
 =?utf-8?B?SkFGUE42Y1lhdWhEM0VUeWFSNCtValpSY0krT0k2a2xWYmNzdzhzaFZjM2tv?=
 =?utf-8?B?emxvVDVjZXRoWXFsRy9vSStaNkxDaTBQdDlXcmJYblk5UmZxdGlHYlcrR1lR?=
 =?utf-8?B?cjhtYVFNSDduVTZiV1lZMXFoWG00dFZYUmc5Ym9KZUdIMUtNYW1pa0F0WUp6?=
 =?utf-8?B?NGE1b0VaMHNoMGx4cVdaa1E2eUNlbUJKdkNVV2oybGNaRHR0UmVyL3p0c29h?=
 =?utf-8?B?NXdxRCtTSk1LdHpic0FDNkhVSHZEczNHYWNmOXRaVnMxWHRZd2h5eDlrVU5y?=
 =?utf-8?B?Q2cvZkdmV0crOFEvU0Jvc253WVNLbTZSYklkb1JxZ251WWNRMHliV3R6NHVJ?=
 =?utf-8?B?WS9MQmNLQ3MwRy8wZzBRbGxPd1RjUGdYcVozbWR6L1E3YVNEM2hmVFArSHM1?=
 =?utf-8?B?Y0l4M09mZmZJVVB1RUZOYTUrMTkwK1dRQlZiQlRVVFJObDF2azdMK0dTWms5?=
 =?utf-8?B?b1VKcDFuMXdlbGpCQ0NqZytMb3d1VTRXVlhhRUJJVGhnZ2FoZVVsd2ZFZkg4?=
 =?utf-8?B?bFRUbWxWNDNLYTJ3QlhRWHA5Qzd4Z0FRQmRZZk11c1g4Zk1seDEzREIveG03?=
 =?utf-8?B?Z09HUXpkeUhoNXZZMDFSd3JzYkhtOGs4eFpnKzM4a3NoT1hQNERxc3M2WEth?=
 =?utf-8?B?S0JFVkx2dkY0NWp2Q0R5T3BmTlRGWityT3NwN3pjeUxzQ0xuNUprRlNldHY4?=
 =?utf-8?Q?NUeep18txiM6C+H57y1C6fY0au20THgcfgB/WJMLTGnU?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df86e403-c273-459e-e310-08dbbf7778a4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:33:25.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EtFPXgzDBtIXhWii7FtMesjF4B5f+da96sPJQmjxipf8SE4wHoLh9Wg93dQKfUOin76Ni6w9ApAJnnZCuIT9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2l0aCBzb21lIGNvbmRpdGlvbnMsIHRoZSBkZXZpY2UgaXMgYWJsZSB0byBzZW5kL3JlY2VpdmUg
ZnJhbWVzIGR1cmluZwpzY2FuIG9wZXJhdGlvbi4gU28sIGl0IGlzIHBvc3NpYmxlIHRvIHVzZSBp
dCBpbXBsZW1lbnQgdGhlICJyZW1haW4gb24KY2hhbm5lbCIgZmVhdHVyZS4gV2UganVzdCBhc2sg
Zm9yIGEgcGFzc2l2ZSBzY2FuICh3aXRob3V0IHNlbmRpbmcgYW55CnByb2JlIHJlcXVlc3QpIG9u
IG9uZSBjaGFubmVsLgoKVGhpcyBhcmNoaXRlY3R1cmUgYWxsb3dzIHRvIGxldmVyYWdlIHNvbWUg
aW50ZXJlc3RpbmcgZmVhdHVyZXM6CiAgLSBpZiB0aGUgZGV2aWNlIGlzIEFQLCB0aGUgZGV2aWNl
IHN3aXRjaGVzIGNoYW5uZWwganVzdCBhZnRlciB0aGUgbmV4dAogICAgYmVhY29uIGFuZCB0aGUg
YmVhY29ucyBhcmUgc3RvcHBlZCBkdXJpbmcgdGhlIG9mZi1jaGFubmVsIGludGVydmFsLgogIC0g
aWYgdGhlIGRldmljZSBpcyBjb25uZWN0ZWQsIGl0IGFkdmVydGlzZXMgaXQgaXMgYXNsZWVwIGJl
Zm9yZSB0bwogICAgc3dpdGNoIGNoYW5uZWwgKHNvIHRoZSBBUCBzaG91bGQgc3RvcCB0byB0cnkg
dG8gc2VuZCBkYXRhKQoKU2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5w
b3VpbGxlckBzaWxhYnMuY29tPgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
c2Nhbi5jIHwgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL3NpbGFicy93Zngvc2Nhbi5oIHwgIDEgKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9zdGEuYyAgfCAgMSArCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3dmeC5o
ICB8ICA1ICsrLQogNCBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2FuLmMg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4uYwppbmRleCA1MTMzOGZkNDNh
ZTRmLi41N2EyZDYzZGQyYTYyIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L3NjYW4uYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4u
YwpAQCAtMTQ2LDE0ICsxNDYsNjQgQEAgdm9pZCB3Znhfc2Nhbl9jb21wbGV0ZShzdHJ1Y3Qgd2Z4
X3ZpZiAqd3ZpZiwgaW50IG5iX2NoYW5fZG9uZSkKIAljb21wbGV0ZSgmd3ZpZi0+c2Nhbl9jb21w
bGV0ZSk7CiB9CiAKK3ZvaWQgd2Z4X3JlbWFpbl9vbl9jaGFubmVsX3dvcmsoc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKQoreworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0gY29udGFpbmVyX29mKHdv
cmssIHN0cnVjdCB3ZnhfdmlmLCByZW1haW5fb25fY2hhbm5lbF93b3JrKTsKKwlzdHJ1Y3QgaWVl
ZTgwMjExX2NoYW5uZWwgKmNoYW4gPSB3dmlmLT5yZW1haW5fb25fY2hhbm5lbF9jaGFuOworCWlu
dCBkdXJhdGlvbiA9IHd2aWYtPnJlbWFpbl9vbl9jaGFubmVsX2R1cmF0aW9uOworCWludCByZXQ7
CisKKwkvKiBIaWphY2sgc2NhbiByZXF1ZXN0IHRvIGltcGxlbWVudCBSZW1haW4tT24tQ2hhbm5l
bCAqLworCW11dGV4X2xvY2soJnd2aWYtPndkZXYtPmNvbmZfbXV0ZXgpOworCW11dGV4X2xvY2so
Jnd2aWYtPnNjYW5fbG9jayk7CisJaWYgKHd2aWYtPmpvaW5faW5fcHJvZ3Jlc3MpIHsKKwkJZGV2
X2luZm8od3ZpZi0+d2Rldi0+ZGV2LCAiYWJvcnQgaW4tcHJvZ3Jlc3MgUkVRX0pPSU4iKTsKKwkJ
d2Z4X3Jlc2V0KHd2aWYpOworCX0KKwl3ZnhfdHhfbG9ja19mbHVzaCh3dmlmLT53ZGV2KTsKKwor
CXJlaW5pdF9jb21wbGV0aW9uKCZ3dmlmLT5zY2FuX2NvbXBsZXRlKTsKKwlyZXQgPSB3ZnhfaGlm
X3NjYW5fdW5pcSh3dmlmLCBjaGFuLCBkdXJhdGlvbik7CisJaWYgKHJldCkKKwkJZ290byBlbmQ7
CisJaWVlZTgwMjExX3JlYWR5X29uX2NoYW5uZWwod3ZpZi0+d2Rldi0+aHcpOworCXJldCA9IHdh
aXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmd3ZpZi0+c2Nhbl9jb21wbGV0ZSwKKwkJCQkJICBt
c2Vjc190b19qaWZmaWVzKGR1cmF0aW9uICogMTIwIC8gMTAwKSk7CisJaWYgKCFyZXQpIHsKKwkJ
d2Z4X2hpZl9zdG9wX3NjYW4od3ZpZik7CisJCXJldCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGlt
ZW91dCgmd3ZpZi0+c2Nhbl9jb21wbGV0ZSwgMSAqIEhaKTsKKwkJZGV2X2RiZyh3dmlmLT53ZGV2
LT5kZXYsICJyb2MgdGltZW91dFxuIik7CisJfQorCWlmICghcmV0KQorCQlkZXZfZXJyKHd2aWYt
PndkZXYtPmRldiwgInJvYyBkaWRuJ3Qgc3RvcFxuIik7CisJaWVlZTgwMjExX3JlbWFpbl9vbl9j
aGFubmVsX2V4cGlyZWQod3ZpZi0+d2Rldi0+aHcpOworZW5kOgorCXdmeF90eF91bmxvY2sod3Zp
Zi0+d2Rldik7CisJbXV0ZXhfdW5sb2NrKCZ3dmlmLT5zY2FuX2xvY2spOworCW11dGV4X3VubG9j
aygmd3ZpZi0+d2Rldi0+Y29uZl9tdXRleCk7Cit9CisKIGludCB3ZnhfcmVtYWluX29uX2NoYW5u
ZWwoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCiAJ
CQkgIHN0cnVjdCBpZWVlODAyMTFfY2hhbm5lbCAqY2hhbiwgaW50IGR1cmF0aW9uLAogCQkJICBl
bnVtIGllZWU4MDIxMV9yb2NfdHlwZSB0eXBlKQogeworCXN0cnVjdCB3ZnhfZGV2ICp3ZGV2ID0g
aHctPnByaXY7CisJc3RydWN0IHdmeF92aWYgKnd2aWYgPSAoc3RydWN0IHdmeF92aWYgKil2aWYt
PmRydl9wcml2OworCisJaWYgKHdmeF9hcGlfb2xkZXJfdGhhbih3ZGV2LCAzLCAxMCkpCisJCXJl
dHVybiAtRU9QTk9UU1VQUDsKKworCXd2aWYtPnJlbWFpbl9vbl9jaGFubmVsX2R1cmF0aW9uID0g
ZHVyYXRpb247CisJd3ZpZi0+cmVtYWluX29uX2NoYW5uZWxfY2hhbiA9IGNoYW47CisJc2NoZWR1
bGVfd29yaygmd3ZpZi0+cmVtYWluX29uX2NoYW5uZWxfd29yayk7CiAJcmV0dXJuIDA7CiB9CiAK
IGludCB3ZnhfY2FuY2VsX3JlbWFpbl9vbl9jaGFubmVsKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmKQogeworCXN0cnVjdCB3ZnhfdmlmICp3dmlmID0g
KHN0cnVjdCB3ZnhfdmlmICopdmlmLT5kcnZfcHJpdjsKKworCXdmeF9oaWZfc3RvcF9zY2FuKHd2
aWYpOworCWZsdXNoX3dvcmsoJnd2aWYtPnJlbWFpbl9vbl9jaGFubmVsX3dvcmspOwogCXJldHVy
biAwOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zY2Fu
LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4uaAppbmRleCAyZjgzNjE3
NjkzMDNlLi45OTVhYjhjNmNiNWVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9z
aWxhYnMvd2Z4L3NjYW4uaAorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3Nj
YW4uaApAQCAtMTksNiArMTksNyBAQCBpbnQgd2Z4X2h3X3NjYW4oc3RydWN0IGllZWU4MDIxMV9o
dyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsCiB2b2lkIHdmeF9jYW5jZWxfaHdfc2Nh
bihzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZik7CiB2
b2lkIHdmeF9zY2FuX2NvbXBsZXRlKHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBpbnQgbmJfY2hhbl9k
b25lKTsKIAordm9pZCB3ZnhfcmVtYWluX29uX2NoYW5uZWxfd29yayhzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspOwogaW50IHdmeF9yZW1haW5fb25fY2hhbm5lbChzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKIAkJCSAgc3RydWN0IGllZWU4MDIxMV9j
aGFubmVsICpjaGFuLCBpbnQgZHVyYXRpb24sCiAJCQkgIGVudW0gaWVlZTgwMjExX3JvY190eXBl
IHR5cGUpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEu
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKaW5kZXggYzU4ZGIyYmNl
YTg3Yi4uZjQyMzQxYzJiYWZmYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2ls
YWJzL3dmeC9zdGEuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5j
CkBAIC03MzMsNiArNzMzLDcgQEAgaW50IHdmeF9hZGRfaW50ZXJmYWNlKHN0cnVjdCBpZWVlODAy
MTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmKQogCW11dGV4X2luaXQoJnd2aWYt
PnNjYW5fbG9jayk7CiAJaW5pdF9jb21wbGV0aW9uKCZ3dmlmLT5zY2FuX2NvbXBsZXRlKTsKIAlJ
TklUX1dPUksoJnd2aWYtPnNjYW5fd29yaywgd2Z4X2h3X3NjYW5fd29yayk7CisJSU5JVF9XT1JL
KCZ3dmlmLT5yZW1haW5fb25fY2hhbm5lbF93b3JrLCB3ZnhfcmVtYWluX29uX2NoYW5uZWxfd29y
ayk7CiAKIAl3ZnhfdHhfcXVldWVzX2luaXQod3ZpZik7CiAJd2Z4X3R4X3BvbGljeV9pbml0KHd2
aWYpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC93ZnguaCBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvd2Z4LmgKaW5kZXggMTNiYTg0YjNiMmMz
My4uNWZkODBjNDIzZDZmNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC93ZnguaAorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3dmeC5oCkBA
IC02OSw2ICs2OSw3IEBAIHN0cnVjdCB3ZnhfdmlmIHsKIAogCWJvb2wgICAgICAgICAgICAgICAg
ICAgICAgIGFmdGVyX2R0aW1fdHhfYWxsb3dlZDsKIAlib29sICAgICAgICAgICAgICAgICAgICAg
ICBqb2luX2luX3Byb2dyZXNzOworCXN0cnVjdCBjb21wbGV0aW9uICAgICAgICAgIHNldF9wbV9t
b2RlX2NvbXBsZXRlOwogCiAJc3RydWN0IGRlbGF5ZWRfd29yayAgICAgICAgYmVhY29uX2xvc3Nf
d29yazsKIApAQCAtODgsNyArODksOSBAQCBzdHJ1Y3Qgd2Z4X3ZpZiB7CiAJYm9vbCAgICAgICAg
ICAgICAgICAgICAgICAgc2Nhbl9hYm9ydDsKIAlzdHJ1Y3QgaWVlZTgwMjExX3NjYW5fcmVxdWVz
dCAqc2Nhbl9yZXE7CiAKLQlzdHJ1Y3QgY29tcGxldGlvbiAgICAgICAgICBzZXRfcG1fbW9kZV9j
b21wbGV0ZTsKKwlzdHJ1Y3QgaWVlZTgwMjExX2NoYW5uZWwgICAqcmVtYWluX29uX2NoYW5uZWxf
Y2hhbjsKKwlpbnQgICAgICAgICAgICAgICAgICAgICAgICByZW1haW5fb25fY2hhbm5lbF9kdXJh
dGlvbjsKKwlzdHJ1Y3Qgd29ya19zdHJ1Y3QgICAgICAgICByZW1haW5fb25fY2hhbm5lbF93b3Jr
OwogfTsKIAogc3RhdGljIGlubGluZSBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqd3ZpZl90b192aWYo
c3RydWN0IHdmeF92aWYgKnd2aWYpCi0tIAoyLjM5LjIKCg==
