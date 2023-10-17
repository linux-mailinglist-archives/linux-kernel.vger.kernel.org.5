Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA27CBF93
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbjJQJjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjJQJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:38:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B3AF9;
        Tue, 17 Oct 2023 02:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USMXD98aq/fpFfgkk8It+KpyUOPghu4wBjlkk6rN2xIF8PuAuJ6jhCBGaadtYDw6hLWQNAwvUevCa9eKVZyCu7IranyM6KJIQrv/hebGFy2nWjRyFGb1bovkFVQ2rMVQPXftCrEYH2x/RLPSAFYKoRqczVY58l1G1Np9NGH3awnaf3ScdUT/WMw9O4AAzlM33Si7FhBr5GIBkaRyXeOTD3VI8XlntzoXty04qrvu7aNmvElVLZJu8P/YtITYi8zLlNT+2YekToC7qDjey+DHJAWro6+MuK9HIBf8HOjBKXVpV2asuaWA8+ObGJFmjLe8DhFuxvcM5L3twzW7ogXXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTSsOA6DY3bmXO4gdl0As6t9iR/Wo4T+Wf1LvAm81sY=;
 b=P1spMQW/AG3CasYMlnWXk6xa8hFLQQ7fWeQi+BkxzET8PAL5oNWsfOXctApKTvfZ19WBVFxgYZB0I3taFkkOuDE5YDWu33gZCxLfCQO+Rac3Bgr2vGoTHlcKDMkhbZ6n7RjKA9m5o1hmgWkJ29lakwgqXRLPfQC199lMp4eQSoqw8IhZIgYv7qzkVPSYgTXb6kp239gg4S3bp9XDcmYKkg+4YfiZcv6DVLF1BVUT3/u1MHmniD/4wkSEu8Ae36G/lC7A98S3KvodhN5kCVUWhxPE128Aqzt9QfebjAfl9jY67rjD+hYf85nv5kfxM4x/CjfJAQj00+q+KmKklWDNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTSsOA6DY3bmXO4gdl0As6t9iR/Wo4T+Wf1LvAm81sY=;
 b=i0xsaDm0N8vqw/Ntkty5350rvwfTUBp/U6jcUsAXnaw0nZFlFaC2B9Ph240IS8uTnz8JxIYdlqqvDDvAIzgkip4n3eHD/JQmLjhxTrqSb+oB/7acss8Nq7ULw0+2Iji7Lz1EBGBxFkfudO5fICy0xeoTpjKTmO4QPi9424S58hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 09:38:54 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98%7]) with mapi id 15.20.6863.043; Tue, 17 Oct 2023
 09:38:54 +0000
Message-ID: <91104ef7-c9a6-4c65-aad0-61ecb3c29ea0@amd.com>
Date:   Tue, 17 Oct 2023 10:38:49 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From:   Kris Chaplin <kris.chaplin@amd.com>
Subject: w1: coding-style - naming for master/slave for new driver and dt
 binding
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0519.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::14) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 436dd338-c596-4c7d-3c57-08dbcef4e05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mK/wXgKFRQfVgDEecwiwFQjiBkL5e34mJOGjjt6/J97lJCfh8NAZ32dJi5wVD1T8S8IMiS4bibMJDUHFUYXD/SLBNha8lpmhMPVcF3aDdrzMH/1xZcl19HKOHcUmF66/XSCkWoa6TIwOAKDtDWUJD3sFRVg/6i/08p+esVkGTR3ZeR7gKRSokKCdTOf1p2UWIfQ+Pdn2kG8mdMeM1kkfoAd0CCX6lwrD0xgcY7d61E4rL2qeWg27nqIe/iOy8KA++WOchiKMH/yODLGq5OOAYW1/1x+KN6dx8svMA5l/9fEV37lP3gFNKy509Wel5ECv0h2/KslOqBajh3gBDcrrnQvyeXF14MwPIzpTCnopvTAkjxvcjBkghIdajr02z40D3JQ/CiT2LyTPAF5UObmuUV9IPZ8Ey4PQ7LE0slARXaRt80WnG8ASbeyDhCr1dp3fm88mkIov6tOm6GmEs/PPcJoSFAEbf/TobqFLw6wXXzBFXAk+r+wQsjTststc0jy2gT+ZoKAslWNzpRDKjWzwEeovehX0jeoEak5BgQOiN+iIbKi8xaD1+xixC9SYXiXhGwjxpKS5z1rbY5OxKQUbIxoEdZyDeSRb4MbSaJe5r0+FLcBOvt60Bh7jdqn8saf4sezLR/1tMt+i9nVUZdIOmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(2616005)(6666004)(6506007)(8936002)(6512007)(83380400001)(41300700001)(44832011)(4326008)(8676002)(5660300002)(2906002)(4744005)(6486002)(478600001)(66946007)(66556008)(316002)(6916009)(66476007)(31696002)(38100700002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2NqRDM2Sy9ESW13bjEyejJ2eWZQcWhuQVdTVWJuVFVTMW55MDlEQytySE9D?=
 =?utf-8?B?RDZpVjBHZnRzeHZocDZKY3dQcHlJMGVnR3JMOWt1eHg1UTE1YW9tZ2FKUU1C?=
 =?utf-8?B?WFFESFViWE5rdjdmSDJVd2lIb2dCV2dIR0hWNFJtT2h1R2RXU0NvdTMwWTA3?=
 =?utf-8?B?ZTBERGcyU2Z0TytKcFJQVWpHSzNEYVJQR2lHazVjS0ZsMDNSTXRINUVUajRk?=
 =?utf-8?B?aXllSmpPcThjZGxXQmh6N0RETCtzemFDblVJK0JLbFJWOGFzZGxNOXZ5SFBN?=
 =?utf-8?B?aUpoYktFTHNEK2RSUzR6eDA0UjRMV282Q0tUMmJWeU5CWm1TZWhEYVJsK1Rs?=
 =?utf-8?B?bVRFaU56d3hBOWhsd1lZcmtPZkcwMnQ1YU13TDZkcnFDcjR5RHVHcEZRanh2?=
 =?utf-8?B?NkpQcDVrTllyY1VIdTVrc291OG1XRERvNVRCVzJQWGRDd05Ka0RIREU1b21p?=
 =?utf-8?B?NzJyQzAxZXpHSTlYeEJSK0xZV0VhUGwzUHlLeFZNSk1UL3F1OUFONnZMUXN2?=
 =?utf-8?B?SHVmM01aeFg5blpvcE5HSE9tRVJyc2M0Vm56UDVWa1RxZjZBZlNyY3pJbW43?=
 =?utf-8?B?bndBUlZqMk5xalJSU1V4cUNSd2MydUZhUU1OaGxMTElJYmt4YnJ4eEZ3REJM?=
 =?utf-8?B?THV4OStQYWFiUlJ0ZnplLzhyOWpDYnROcjJOZmNPTHpTZkVFTFN0RjNDNDhi?=
 =?utf-8?B?MjVNcWw0cXh6SHYvV2NZb3lBYUlxazVma3d1N0l5enpobDBVdy9sa0VYN242?=
 =?utf-8?B?YXo4aWhEWUx2V3R4dkhONkY2UHZDQkpjbG1EU3JnbXByaVg3K05EQU1CWExJ?=
 =?utf-8?B?dzI5R2xtbHlLN1Y4TVZsZE1nbnVRVTJCZWlReXFRK2cvRnlIeGNPVlMySDQr?=
 =?utf-8?B?bjh1V3d0NkVCWUIzR1YwbTZmWm9mZWdGQWNVTnJ5VnRUd2s4SHJyRm4vQmRp?=
 =?utf-8?B?M2RWYTU3cS9LUWYwdGRFMFZBdkNYM3J5cmxZWkMxRXJnSnJwR0RXQWtkaFE2?=
 =?utf-8?B?TWEzcWNLQytuMDN1TGZVb0ZXSTVqdGtOK0c5TE9Sa0MvWlRmb3kxZ3kzd0tk?=
 =?utf-8?B?WDJaT3VuZ1ZuRlR2WkJWaUptazJ0V3NnT2VyTFNkYmR2cjBwcGtyV0pXWmg1?=
 =?utf-8?B?MVl4dERUNUZndDk4dWZrK0Iwa3orMHNrSU5Ud0tla1lMRXNKRExCRjhRY2Nq?=
 =?utf-8?B?SGxTdTRIQy8xK1VnTGhjRkwvMDlmdmJBemlVdEpLYW9GNTdjVFRqQ1dtWGRp?=
 =?utf-8?B?Z015c2V3Nld3NDFlaDZVSEJpMkR2RHVWUlJ3c3NJUGdmbTFLZit3aFFtblZQ?=
 =?utf-8?B?OWFUZFQvNmRlSFZReWtjMUdRUEN4ejkwNzEyMGhyVXYxUC8xcFhuaXZHSW5y?=
 =?utf-8?B?ZmIvYUtPOGVUT1pQTkpaT1lsRWIwVHlhK3d2V3Q2dWN0UHFvOEREUytWRGJ3?=
 =?utf-8?B?RXdOdTRFWGQ0MFRiQmRVZUlLSGlJdE1XUG1ybEc2STg5ZmhKMEpabjNDQ29w?=
 =?utf-8?B?RFQxbmdob2xoczJoOFFKc3dzL0xqcUpudThST2IwM25OK3c5emVxdTMxbEJN?=
 =?utf-8?B?a0trQVlrRmVoNXlBYXJHOXA3VENzbmh6aFhOV21JQTVoMjFQQWxvMTJlMFJG?=
 =?utf-8?B?UERpN0tqMmpQZDNRdG9udmUxQTlQOHRUdDRpQ3NjS2U1L1YyQmQ5eW1KcFg2?=
 =?utf-8?B?SzJtdmxvanhnWkZiWmltTmNxd3RreU1vWlNISmZtdU9IYngvYnYza1ZDTW8r?=
 =?utf-8?B?SVZwdk51Uk82RXZzeWVjWW9adE1CQVhlSzN2RmhFQ1lhb1JOd0lySnYzWGxK?=
 =?utf-8?B?VEM5VDdJQU1aSUhYWDcwWXI3WWl0c3JKcTVnMVVUcGxZWU9rK0pNbkFPaUtG?=
 =?utf-8?B?VXlRMUQ2SjZJem5DVTBuci9oREJ1YlZEdlpJaUJheWxCclVKU0tXbkU4MFdy?=
 =?utf-8?B?MFFGMllkbEpmaEp6ZmVIK094cThaUVJjYU0zSHJYTUtwZ0k5V2pWa1BBMFUz?=
 =?utf-8?B?Ynl0d01KcUdoVHJnajV5Y3FsQ08rS1VJVlkvWW53M3RnVisrU3R5S2xNclVC?=
 =?utf-8?B?STJlOWw5eE0yTjZnSWkydEVGTTZUM204aU5hc2V1U0JVTUIvcmhMNHNLTnB2?=
 =?utf-8?Q?EnEM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436dd338-c596-4c7d-3c57-08dbcef4e05e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 09:38:53.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uC7G3+vFDvW6Vgzw0IQkW72j1oLDJWq1aXbv3o20KJ/KKTUtrpt28qovO9DW1kHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzystof,

During review of my dt-bindings patches for a new w1 driver 
(https://lkml.org/lkml/2023/10/13/959), there was mention that the use 
of 'master' is not considered great terminology nowadays.  Are there any 
plans to replace the usage of master/slave in w1 as mentioned in 
Documentation/process/coding-style.rst ?  As we are in the final stages 
of our W1 soft IP development, I believe there is a small window in 
which we can align on our new IP name if appropriate, prior to my next 
round of patch submission for amd,axi-w1-master and get the binding to 
match.

If there is a preferred choice from the example alternatives in the 
docs, I can look to see if we can align the naming and update my next 
patch round accordingly - however if the guidance is to keep to the 
specification-defined terminology (pre-2020) then we can do so.

regards
Kris

