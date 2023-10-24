Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7FA7D43D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjJXASH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjJXASF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:18:05 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFEA110
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:18:01 -0700 (PDT)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.173.48])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 918DF100004E2;
        Tue, 24 Oct 2023 00:17:59 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1698106678.974000
X-TM-MAIL-UUID: a910d70b-7f99-401d-89e4-52b906ad98ff
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id EDEC610045538;
        Tue, 24 Oct 2023 00:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhRf3p13LbxI+ZfuR47PQ1ILdZk6cepm80FHjtatR1G5uUxWc9KC6NHlIqTXKU1vAJOGQ33atS0T1wNsduUBxz6xX5/GbN+TQKMRCQYy1hID5V0Grzah6A9aSJLlPSqxk615R/gSEfpdc/EvVRDJa6jSqp5uWPcTi48G8K4IeEotkm2m2kLhhfNpWG+Qm77tOfbo3REanHkx1FNQEfirJNnq2usUnE/PpEuk15ZmR3mkpefOJzqfx2vdsSr5SpAkYJtGeX3jv7Ili6NmlV0JzEQy3bHAZd+6zNNWAvF/LjS5s3mkOmCJqxRVhgz9DvyweYus7o6ko4tMayCpjfxICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2sfI4UL35tgyF5Mf3jk7djFqrLBEz6i3pEIVSsAYrs=;
 b=MWL24mfCbjke5P9ya1oxP+ZQ+JUGI0dzFw9TI/roG8thEjxm5FByjUciQE/AP78iqFtxZSe+oO+armZkH4Ke6WC+1rwjEERhQq+HcpNqpk/vYUB8ZrBGs4ans1SIJXBoZX4mTRq5dYefQuPRGK3EObfDlcGVRusGwNha/ySb4DdI6r8tccc5j5N5GCFdO7AbSNUiJFxnVLTImUUeQgvOl8zNUkonM4ZLtz3ccLmIOlwIoonQvUmFveKnMyg5NES8XpU9SWfdkHuJOnQLsqjnBE4EK/jIZVvyjFP3Z4U2q/fYH3rBWgAVx+9y0hp+e4hBholfeCzaUCiyHlFlTYKj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <e23c1ab4-c501-4449-bf8b-62e209e56895@opensynergy.com>
Date:   Tue, 24 Oct 2023 09:17:45 +0900
Subject: Re: [PATCH v2] ALSA: virtio: use copy and fill_silence callbacks
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, mst@redhat.com,
        perex@perex.cz, tiwai@suse.com,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
References: <ZS+392ZzVIoEyv8n@fedora> <871qdrn6sg.wl-tiwai@suse.de>
 <e50c5a67-d2b7-4ef1-8aaa-309437fa8cb5@opensynergy.com>
 <87y1fzkq8c.wl-tiwai@suse.de>
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
In-Reply-To: <87y1fzkq8c.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::8) To BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:5c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2374:EE_|FRYP281MB2191:EE_
X-MS-Office365-Filtering-Correlation-Id: 69184d26-3d00-43bb-71ad-08dbd426acf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwUM2rtP7vToNf3vrY5ysHoDHYNMsf8PbWLa+QDjSAC2s3x4oxhpFFIizqkYEBOA6PvtEqFFN1VwBvcXfuA+O88C7lzQ3GkEtC7+C3tG1CRIzwg9l3zyGvlbyKXsCKypa9S4phXll2/d1ACGpsUK4JDq4BEMzgK03aPE1+uX4gbyGYzl9WETLLzuYTseBG75GQc+poqx3mSFz/Qhxmm3pHwMnmlF1Cu7mAtUiArh+Z6vqUbeytkYpxEo1p4UkkbTkt5p0LdY2z0kXWvEdZNjZnE74geRYlsTkFcxN2+6WKBbSGN9OAwIGTOmsAEsNpF6or+3XJ6fatUGfGuvo810HGEmNE9+Jwfokg/syLxiJ/2ct7NmoTMHiYrxNJJeC01Mujj+2Fmy3IZ4vZoN73DMqP0LtKjh59pZhha7Foc0kukHxajwzIFX6dEdc0mD2SKhM0WWhPppHieyCSMgd/g3KmOY+IjFxQE8sw1INwabLHyrG15Psq1lywtgu+hQFa95Tsd34X9NamuOA0v8NmzY0pRpdYxqKzzRIxBBkexvKUlJanmwOFaL0bqFNL7CYUT7RFDneD+KQgeLSexxMbQ/vkwGTOJTyMs13am3pIAT5TSQ4clOK2dzRCJL/WbFhZEAcSByIhmZ64tF+BVtCBBKxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(2616005)(53546011)(38100700002)(31696002)(86362001)(36756003)(41300700001)(26005)(2906002)(44832011)(7416002)(966005)(83380400001)(478600001)(8676002)(8936002)(5660300002)(4326008)(42186006)(66556008)(316002)(66946007)(66476007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUtDbXhVSUNERFc2YVFOZG95alJwQlR4alpQdG5RQ2xrRHlOSVNGUHRrdnc1?=
 =?utf-8?B?K0RLWXRORDE0T1NKT2hpRjVycjc1V0VvMS9VTDBrZzdPaURDeElTbDQyZitr?=
 =?utf-8?B?YlNNS2RvUTFrd3h0bXJWc2RhN0I5d3NncG5zZzc3M0JucU83bEE4R2FZR1RF?=
 =?utf-8?B?Z2hqUWxER1loeTF5TU9iUEdnU0pmWnBvd2xMUUEyUkVQZ0FEMEVUYnFTc3I5?=
 =?utf-8?B?cWE3bXhhNnNabkswZmJGMFJjM25XVDA5WmpCVmJEU2pkS1U0bUpUb1ZWbG9Z?=
 =?utf-8?B?aWpGa3JsdDN3TjA3T0JhSmZOdTR3LythVGFUeitkMmZuZ0E4bDBrRUdqSVV2?=
 =?utf-8?B?YUVrZXBvTy8vQWJWamo4VXVmQ0YwZUk2SmJGYXJnTnJUM2NTNjI3TEd5ZHhv?=
 =?utf-8?B?K1cvMzZ2S0pLcHJCNkRpdEErcC8zdkpWMWU2SExsVUlDUlAxaHJRMlJRNTVE?=
 =?utf-8?B?OVFta1loWmh1V0pmTEtzUDBoR3lpUTNKeVFMYUVEZ3dhWGxLRE1EeTJ0TzZU?=
 =?utf-8?B?emM5RnZiSFJPaFZudVFFbmJKZTB6U1IyRVIvdzRhYnZldGpFa0NDdHQxNXNv?=
 =?utf-8?B?RGVUTHlHZXNraFd3SEkvTW1IMy83Tm5yQzlLU3Z5Z0wvUFNxS2JDSEMyb2dQ?=
 =?utf-8?B?MllYR29PZGUrdFE3Tlpyb3J5aWxzYmlESzFjMk9ESjhhNW9XTytiUnFIK0Ns?=
 =?utf-8?B?MEE3NHQ2cVRNRFZkcm1zaDlXT2RBcUtSejJzM1A2bi91OCtOeVBOZG1sRmVK?=
 =?utf-8?B?TTJwNFFRNmhTd3lMNlZKUmZLRTJqWnJpY2FmdHFqUE8yeC9IWWVkc1ZUSms0?=
 =?utf-8?B?NCtlYVlUSG1MaUEwRnh1U1RMci9Bemd2Z0xnd1Z3WlFaYmJqUEZMclA0amJE?=
 =?utf-8?B?dTJ6K0Jhd3NsOTI1d0owckJYWWlPSGJDN3lQM3B5enJhTlNQVDN3STFlRUN3?=
 =?utf-8?B?UTdXVHlmWVN1dnR3RGNVcGU1RmlncEVFalJ0c2hmTmM2anVhTGdybk1ST3pQ?=
 =?utf-8?B?NjJzZ0N1c3BtVHR2R3dXbE0yUk9BU0IyWTFYOWZjVGQzWFArMWdmQnJzV3Mv?=
 =?utf-8?B?UjBMcnNFbEdKZkRhRlFSNk1ESldRa25mNVlCcU4xdStpelR5aFVoRFE0ZzQv?=
 =?utf-8?B?d1JZS01Vb0lVeGpWVWlGV3pHY016UHhPYnJjSnBuRGZud0tEM3lkMzlYUDFJ?=
 =?utf-8?B?QzdOMy9IZ0NsWDBBb3R3bE9TZTlRaEVtaG50TXk0L1pkdEowK0pYbjZNRW5k?=
 =?utf-8?B?QUUwbm4vcEpCS2ZEck1ITlUrY1pWR1Q4U3Q4Z2l3UGNoREVQdmNTZkRObHIx?=
 =?utf-8?B?djVhTFZYdGtnTFA0YjdzYmttTm5qaDk2Smtqd2YxTkNFUjZUekF1aWQweHZO?=
 =?utf-8?B?aEVCV1hwd0Z1V2Zmc0pDT2QxRTQ0S2U5dFZLLzhMV2c4OTJRUXhiWitzd3dj?=
 =?utf-8?B?MDZ0dnl4U1FMR3RocWIwZnVsMUhSZzVNUTJtbFUxbE5HSm5kbi9SWG9nbkM2?=
 =?utf-8?B?bmlJcWRwWEZBVWZGRUhDdEdZSFZKK0hwRW1DaWlZT1VoSUJzRyttVGZTcFY1?=
 =?utf-8?B?UEJ5aDdIU05HWElySVE3V1FlMVBwVkl1WHRrRHVlQVNuZ2NpK0dpRm9oc2Qw?=
 =?utf-8?B?UTRxdXNIOFJQRzlaOEo0d3k4UmpiSUVkWEVUdVNPbFg3VCsycFptWHhpWWM0?=
 =?utf-8?B?NjFqa0VqV3hNMStRUHdja2ovMEdNMGRnTHFXL0haYWpRdm1YZ25IQktocTFQ?=
 =?utf-8?B?NlVLWis3dHFsa3ZhWGh6dU9xampMUmFXTDQrSEh1RFlLeFhHazdHZkVrS1Q0?=
 =?utf-8?B?d2JGYmhvelhadHo0amhnelUzU0E5VllTMXMxZFhoMmg0Sis1UUsvVTl4alpv?=
 =?utf-8?B?QjRKdllsQmo4citMYlNWdnNpR0ZZTldsWGdqVDFuNU9GVDRha21iNURXREMv?=
 =?utf-8?B?T2VzMHNzL0hSYmZURS9JVW4vV0ordE5haFhVQm84YmRZUUhyaWR5cjhMNDMx?=
 =?utf-8?B?V2MxQW1YSUlYa29IMGM2YXRUdE1vOUJKT2Z6Qm1HaWFtQ0NIVXVmWTYrNFRT?=
 =?utf-8?B?aUlhSnMzMmhvaWxTb0pWeFVaMk8xY3BQbGxtVmJaWmZBa29RTHFaVzl2SUFt?=
 =?utf-8?Q?RWTbnj+pzl+9G+B972SX6ItgY?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69184d26-3d00-43bb-71ad-08dbd426acf3
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 00:17:57.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1nnio8ipY1ZJSd/y88AG+/GTXCsqLfFRioKuZRwN6qud9jy06jjk2bPAEZjaPBmrfFRVUPNQcop1u9Jv/Wxwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2191
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27954.003
X-TMASE-Result: 10--32.723200-4.000000
X-TMASE-MatchedRID: I31hiQfYWUN6u8Ra7Bkp4ww4DIWv1jSVbU+XbFYs1xLykUQ3+1QpKU3S
        C9bkE9YyNr5aA8MV0XkcydMA6f+1WPujgI8W3VQdrf03Gvoif/fn0oaU6WM++6WXeo1JBrZgw5n
        Zy2X+Nx7e+5l0TSAQlxCNJOxfs3EOC5yGwbf+IdgsJRkKgHlrKG8lDAHJQfo4uxtkhcNHU8oUS+
        eIOZZCPodKFEXU7ctQ12qbvVPRySQoDQ4wSBO3SRdLtszs/yIYEkUS8Erng9q2gwaXPtBp+ya2Z
        Yhi6NLbDbopmLJYchOBariVNrrFRXX/e6Wwhp/J6x+Q+uPsJqpxd2b9FYfw7aFRWC8HCKx2feEy
        sJu+yTJopHFvth7VZA5pdByl/RFheQczFQh2XEsD7AbA+ThQk9ztvqTn5fr3MCyfT2VAUIXaiin
        ot3yvwUI5EMS4xHCcY6NiQNWkjVsldkOpPw3c45/KMn5sGLoglZroRtOiCG2L12p7cZqBWHUhg4
        grojSzdl50cfr3QRNKV13hwcvu9uPXzq8/z8gYsX4aFYAMIYOVlsxwvB691Zq9yKH2z9zouhCa9
        ZJvTFsnCwTCNGqnQA2HX3i8MKssm5NwnYNFEjv4MTnOvlqF3Dsagavr4+KJ6tkHohQPHjORRBU8
        Vo8ZNKLLsDc1PtWmb3nGPsY3QU4Fj7XTcz5qmB+Vg9COO3pLVtZ+Gx0x6EGjVDAOsB1ayo4t8qc
        G15s+gbCMk71n72nrEDQC9rvecA+bXnHKG3yVxO9DHo3LYKv6wx6weWCky4Qk2DIFImWyKqGN4s
        3K9Pt4bd6tiMFuXX7cGd19dSFd
X-TMASE-XGENCLOUD: 51ceab06-949a-4aad-ba0e-00cad12c3620-0-0-200-0
X-TM-Deliver-Signature: F43A2F6D898276D314EC018A75DC4DDD
X-TM-Addin-Auth: 5btoCiWjgPn390joqJqffObtAHXkMswORHhAKDxg9KC7UZTXslMhPHEOBCF
        B54hdxYC+d+MBdNNUOcR1I55bz83qs8K6upOMIgzNL9CjWZd6SJPRM1Du7UiFcHO8c7MrKOQNxd
        M4JpW0mBLybXHz9koR6XGBWln8nGoZYkrpvEqBrJNgFL1G2ix8JifWeNWrbu5nVbnGt7LEDbsX6
        HPzS6RmmOPHMtne92bXy88mYZwQHO1fpPMPu1pHDygGBxiee5XAceq7eSDZ2kFIiXDvEOrAPOt/
        Ri3X+3Lo2a8S8fA=.Hjk+dwE2zhaz8syU3y8Hyv0ROD02zgwcffdgSr6/WEv0n4KERTsFbs9A8Y
        +u2IrKCcCh4ENhU9Ode1jMWf7F8/XgWrehRLbIxLA16JJFy1qMU+p2he4r2MqYUM0lz2/pFxRSu
        G2RxGWkPPVXUUR+DSbCpG49kVehm9ZcwaLT+dE1nT2aXzY8srk9TUBZt9hHj+59PQR2UZ7Z08Pp
        SkTL0bn3WI+XhWgewBI8H5NK5G1aFuIunWhonXWPZCK4/MdXoG6A83WILbHwv/fAOvd/iDOeHkZ
        BknMwca0BjWzzEQoWPkkPH+Y2bjgdWE9RudvD/0Vf184om6hjY22GqYu//Q==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1698106679;
        bh=7CBbNDD6jMaN9hEhtkNn+3KhdmUFqmpPkPP9McSoMW4=; l=6690;
        h=Date:To:From;
        b=MYUgw9j0+rEpaky3GmwW/AYylBoF2jQXdnBGCCd9sCDuoyb1/y48quY46qHWiEGkS
         tSZ1YqehoeEOHouH+lRgrOafYSrUskrsZj0jsFb3YZHcqFtMWy6wReIosmqr7s2xJB
         4EOQNOhIexu0ECx7VOYbiPhVl/xb0aoZBMUJjOpKCVWQA5eSprKoceK2h1scvIQvbi
         rtIY2YecuFmIw/3ERa6/Jp/6ntUB1c17ib8Qtxpz0ssbi1WkSwvjR5/UBZafFSh4Yh
         vgIEDNxxiAmCkElMuHcg074jxbtH9pONn9/Yuc6a7xUg2WQJaUeE87WV4dgwYGtw9s
         0YFl0Vk+1i1dg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On 19.10.2023 16:48, Takashi Iwai wrote:
> On Thu, 19 Oct 2023 03:20:19 +0200,
> Anton Yakovlev wrote:
>>
>> Hi Takashi,
>>
>> On 19.10.2023 03:07, Takashi Iwai wrote:
>>> On Wed, 18 Oct 2023 12:48:23 +0200,
>>> Matias Ezequiel Vara Larsen wrote:
>>>>
>>>> This commit replaces the mmap mechanism with the copy() and
>>>> fill_silence() callbacks for both capturing and playback for the
>>>> virtio-sound driver. This change is required to prevent the updating of
>>>> the content of a buffer that is already in the available ring.
>>>>
>>>> The current mechanism splits a dma buffer into descriptors that are
>>>> exposed to the device. This dma buffer is shared with the user
>>>> application. When the device consumes a buffer, the driver moves the
>>>> request from the used ring to available ring.
>>>>
>>>> The driver exposes the buffer to the device without knowing if the
>>>> content has been updated from the user. The section 2.8.21.1 of the
>>>> virtio spec states that: "The device MAY access the descriptor chains
>>>> the driver created and the memory they refer to immediately". If the
>>>> device picks up buffers from the available ring just after it is
>>>> notified, it happens that the content may be old.
>>>>
>>>> By providing the copy() callback, the driver first updates the content
>>>> of the buffer, and then, exposes the buffer to the device by enqueuing
>>>> it in the available ring. Thus, device always picks up a buffer that is
>>>> updated. During copy(), the number of requests enqueued depends on the
>>>> "pos" and "bytes" arguments. The length of each request is period_size
>>>> bytes.
>>>>
>>>> For capturing, the driver starts by exposing all the available buffers
>>>> to device. After device updates the content of a buffer, it enqueues it
>>>> in the used ring. It is only after the copy() for capturing is issued
>>>> that the driver re-enqueues the buffer in the available ring.
>>>>
>>>> Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>>>> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
>>>> ---
>>>> Changelog:
>>>> v1 -> v2:
>>>>    * Use snd_pcm_set_managed_buffer_all()for buffer allocation/freeing.
>>>>    * Make virtsnd_pcm_msg_send() generic by specifying the offset and size
>>>>      for the modified part of the buffer; this way no assumptions need to
>>>>      be made.
>>>>    * Disable SNDRV_PCM_INFO_NO_REWINDS since now only sequential
>>>>      reading/writing of frames is supported.
>>>>    * Correct comment at virtsnd_pcm_msg_send().
>>>>    * v1 patch at:
>>>>      https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flkml%2f20231016151000.GE119987%40fedora%2ft%2f&umid=323acbff-2d10-45a8-bbe1-78fc8583abec&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-6526c5e588ae6e2c247d0c967e0504e4fc7f307a
>>>>
>>>>    sound/virtio/virtio_pcm.c     |  7 ++-
>>>>    sound/virtio/virtio_pcm.h     |  9 ++--
>>>>    sound/virtio/virtio_pcm_msg.c | 93 ++++++++++++++++++++++-------------
>>>>    sound/virtio/virtio_pcm_ops.c | 81 +++++++++++++++++++++++++-----
>>>>    4 files changed, 137 insertions(+), 53 deletions(-)
>>>
>>> Most of the code changes look good, but I wonder:
>>>
>>>>
>>>> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
>>>> index c10d91fff2fb..66d67eef1bcc 100644
>>>> --- a/sound/virtio/virtio_pcm.c
>>>> +++ b/sound/virtio/virtio_pcm.c
>>>> @@ -104,12 +104,11 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>>>>    	 * only message-based transport.
>>>>    	 */
>>>>    	vss->hw.info =
>>>> -		SNDRV_PCM_INFO_MMAP |
>>>> -		SNDRV_PCM_INFO_MMAP_VALID |
>>>
>>> Do we need the removal of those MMAP features inevitably?
>>> Usually mmap can still work even if the driver implements the copy
>>> ops.  Those aren't always mutual exclusive.
>>
>> The driver uses a message queue to communicate with the device. Thus,
>> the audio buffer is sliced into several I/O requests (= number of
>> periods) of the same size (= period size).
>>
>> Before this, all such requests were enqueued when the substream started,
>> and immediately re-enqueued once the request is completed. This approach
>> made it possible to add mmap support. But for mmap there are no explicit
>> notifications from the application how many frames were written or read.
>> Thus, it was assumed that the virtual device should read/write frames to
>> requests based on timings. And there are some problems here:
>>
>>    1. This was found to violate the virtio specification: if a request is
>>       already in the queue, the device can safely read/write there at any
>>       time.
>>    2. It looks like this breaks the use case with swiotlb. Personally I'm
>>       not sure how the application handles DMA ownership in the case of
>>       mmaped buffer.
>>
>> To correctly implement mmap support, instead of transferring data via a
>> message queue, the driver and device must have a shared memory region.
>> We can add mmap in the future when we expand the functionality of the
>> device to support such shared memory.
> 
> Ah, then this implementation might be an overkill.  You're still using
> the (intermediate) vmalloc buffer allocated via PCM managed mode, and
> the actual data is copied from/to there.  So it doesn't conflict with
> the mmap operation at all.
> 
> I guess that the problem you're trying to solve (the immediate data
> transfer to the queue) can be implemented rather via PCM ack callback
> instead.  ALSA PCM core notifies the possible data transfer via PCM
> ack callback right after each change of appl_ptr or hw_ptr, including
> each read/write op or mmap commit.  Then the driver can check the
> change of appl_ptr (or hw_ptr for capture), fetch the newly available
> data, and queue it immediately.
> 
> Usually together with the use of ack callback, the driver sets
> SNDRV_PCM_INFO_SYNC_APPLPTR flag.  This prevents the mmap of the PCM
> control record (not the audio data) and enforces the use of
> SNDRV_PCM_IOCTL_SYNC_PTR ioctl instead (so that the driver always gets
> the ack callback).

Thanks for pointing out this possibility!

I'm wondering if TinyALSA works correctly with this flag.


Best regards,


> 
> 
> thanks,
> 
> Takashi
> 
> 
>>
>>
>> Best regards,
>>
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>
>> -- 
>> Anton Yakovlev
>> Senior Software Engineer
>>
>> OpenSynergy GmbH
>> Rotherstr. 20, 10245 Berlin

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
