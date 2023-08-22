Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF347784976
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjHVSgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjHVSgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:36:39 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::713])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8B8CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nagq0/MXk5oFMuHm5DWESuDz4xtb/1DlZAKbmRatsATWKEaoyYLYA+l2M8jAxYnTz3nUV/mzJjq0kg5gsZjKhkVlGvAnGnOdJpzfxaXVhH5jjB7wobe00m20eGcSkdgUc7ygA2GVDicMKgh6xXUBH7z7EuFSm9goOInz/7Rdf0GF4C9bAH1GfxN3JiH4G/kZyt66CDTF+9Z2MvRavObb8v+2U9wVs0RHRBfjtkIwFng2m9fsJ3MNOAi1ZWPPX9F7DkzYcWr++q2ejrSOflnnV3zJ3AsDZk6nzd5p5t0IQDCwvGIZ22A7mYNhjwlfmFn2JGW2GpvrpYbWQt2lGZnTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fm7HRC4zVwD2tQPji/iRXiymkX32yikMPcRNOquvqSU=;
 b=iQypqNYBlPH5/ZN7pz9OnkXhKSVrbIVwXbvmrdn+TDSCRuMozBUmZuByp5ktA53Qcz7Ru0hLjULBYUFqsnvflebM0B3EFwHUQwY6svwKP+fkuDd3uRcjbU6cQPjYjzYSYyQKHe7eq2WWGOuZfwIqKPaSTzHPQ1Y1RE6vEqabSqiLa57xoGIh24QLh71ra8e0WFRsz3PSMYUacwb2S9RfNmzpeZHGCMEDmItwUW5vWC8cebt8TgsZ+Udo1szyH+CQwbD/qvpvbTFTRUlynl6w/Umz5MNqS445wKmdGYDGGtzNbaT9GPiXNiKQmFEl4ehygKkdRj3jnq+Ii5EAGd6fRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fm7HRC4zVwD2tQPji/iRXiymkX32yikMPcRNOquvqSU=;
 b=nNYtmLnyqwk0OTpqNWH9rojw9DWrPnd/JaY1PrxjVAdll7Ga7yVqeIGZNBFpW+lVEbcv9nG7TVrShLV3jK07JVYsaXI9VuHh+AIR2fjOyCnrJqh5qUcH2DT2xzEx3EBLK3UpCHtc45ufPue5ZP8m6uQCDmnWmzo5QiHo5J/NKsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB4780.prod.exchangelabs.com (2603:10b6:5:6b::16) by
 CH3PR01MB8405.prod.exchangelabs.com (2603:10b6:610:169::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Tue, 22 Aug 2023 18:36:32 +0000
Received: from DM6PR01MB4780.prod.exchangelabs.com
 ([fe80::1f9:1d97:19f9:40b7]) by DM6PR01MB4780.prod.exchangelabs.com
 ([fe80::1f9:1d97:19f9:40b7%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 18:36:32 +0000
From:   Carl Worth <carl@os.amperecomputing.com>
To:     James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc:     "D. Scott Phillips" <scott@os.amperecomputing.com>,
        Darren Hart <darren@os.amperecomputing.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        Akanksha Jain <Akanksha.Jain2@arm.com>
Subject: Re: Initial testing of MPAM patches
In-Reply-To: <74ed130f-d191-d8a2-084c-ae096ca5a47d@arm.com>
References: <87lee8l9pb.fsf@rasp.mail-host-address-is-not-set>
 <86bced4f-06c1-73de-9aa5-bb23998479fc@arm.com>
 <87o7j4ba2z.fsf@rasp.mail-host-address-is-not-set>
 <74ed130f-d191-d8a2-084c-ae096ca5a47d@arm.com>
Date:   Tue, 22 Aug 2023 11:36:23 -0700
Message-ID: <87350agc0o.fsf@rasp.mail-host-address-is-not-set>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:610:32::6) To DM6PR01MB4780.prod.exchangelabs.com
 (2603:10b6:5:6b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4780:EE_|CH3PR01MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c4d1a8-0ea4-4211-5a41-08dba33eb273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1W02+LCAGqpcCiQLyOysBl/VYgKE1noWRiK8TWY9PdbFlLOWHs7Qoc4yA/enfadF9Kd8BHjQuPvcDffSM0b7uXHk5Bpf2tiGzOflsphhYm+J5MZRfeZM04it6UnuJTw6u13rTUo92H4cxHXKPdzTngoQZ/tu2jH3+TloDprA/WP1Z6nLIFQLmtO+PsNE60W8zwABuycDrGOY+rItLykaNLXna3TmT1xW3vGao3xEnEzuQgCeQpplg3nbOcmks9jbEFtea6AYc5NXStjNrNsJuVIt1WMw/rCs4QpofJGAny87Lmaa0BglVkGsFC/b2w4E86n2dMZfK4bH/+sWGkGoBpaUaEHJHXQCg86bZ+293udEZ9EZ9fUiWeDovFN90ndjDWuL4T+3wJuKggdX6eyRwL8oyyy9KeGq6EEK7zv2Sk5N+LzVbl+3/GH8JhPN0j/DR5IuWxWsAtK9Ffa1iuHjUmI+7RUHOhdAMYJqwXWmRfH/x9lrSnCrxBwtVjTZfqxs1aMjTP19iN54cKbvmn7raSDHi8pBZyHl8tjpAjwkQc9sx7Scs3nxjeWTLMQ0no/ZCMUJ54Z3u8Mw6lWeKxsb4maP+UcRx8S7gnuItuHILZ933LnbHyon7rf/Z3JAyTFx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4780.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39850400004)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(4744005)(38350700002)(52116002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(66946007)(6512007)(9686003)(54906003)(66556008)(66476007)(478600001)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSE+2oL2cupUFlHDseLBjaT2jlDrRpPIlQVB8JljyTvoSLuPtBuijdombGPj?=
 =?us-ascii?Q?J5xN0nCUEUCpw2lyeb7ZLYOvRSGMjj7r0NharPAPNzjk7+teJCwT97Su7fXT?=
 =?us-ascii?Q?l+XyP/1ChOAyfdNmODAwJGO9GaRCWikuEXGUrf6n6al2u1hTl2MifebXR8RX?=
 =?us-ascii?Q?gGC2uyIC5r+7aqcGUohFDUIhbDwL6m4yr6zrUKFGX361KUaQk5rTYXQLhxx6?=
 =?us-ascii?Q?IwuaROJe2oYLPLJLBJKiVzFAI0O/exrSQimewmjRgq6RLBEFPPR1vuT55xCu?=
 =?us-ascii?Q?Z61bp2lU09fhpz6zHfxzvN4MeVc1ZA79zsc9Ei9ETviQZv7ubduCJVYm2jAT?=
 =?us-ascii?Q?qE6914V7RpZxzmuncJVQ2/X0xZiwwzQxzlNUjN+7R4gp0Nx8nzP1CIommByS?=
 =?us-ascii?Q?RXFovYHz1KPMmIhSOrmjhmJJ2WGndTGDWHStd2y3S3lkDAFfCMbGkzZX4fiM?=
 =?us-ascii?Q?rNrsfvFUoFX4hd00RSbVfCOfe1lnxZ0MeWezX3JN7Jlio6+MNWRlWCNomk6L?=
 =?us-ascii?Q?Rh4nxuTdfo6rlZf06ol8SM9CqtSfvFsthYda9VfSEPZPd1/4qoqsADHVUUkD?=
 =?us-ascii?Q?PNusRtpI1NHRQskYJ3355U6ZxeT05zmZUn8lfm92lAGo4JDp3dMOzw+o2rS+?=
 =?us-ascii?Q?4I898s4S3NFEDon/iwZcVt0nR3p7Wdqr8ViVlJwFN+V/lLT2CXQlSeVhAnFW?=
 =?us-ascii?Q?Nt5JV0V61djZxmlYE9XLvhmfdOEBoVSGcxHZffb9koHvucc4x/7ewzvH/aZl?=
 =?us-ascii?Q?xYdREpqRYBf/buxD/eIkN+CdJKe3brp4HgCCa0bN5pHyRO/W7hqXh3PkHfJK?=
 =?us-ascii?Q?90bCrUkC7I9PT/Te2K0yj39m+qmmvMxtvFdjdyQ54N/KLy4p3tgAHlpFBGTO?=
 =?us-ascii?Q?+g0cQz/RrCHntjvomNkldFMhu1FppOnZjRIKFoXEJ4hBFHCNYuT96MGyyI4x?=
 =?us-ascii?Q?0cTyP7wWFVKCc0rlqcItZ5JeeSlr0cD2DyPHdMNd8+h9dfApFnMeJHiDwqZD?=
 =?us-ascii?Q?HqaqwoBd65wI6OMtdPGn/7ax/K2Fgpx/GypQS8TwH0uD8txDvNWrCYjYWZOi?=
 =?us-ascii?Q?8+vS2Q59qBnSsRZHkoIM69Y/wGWRTnRFR5lEBxwVvSbRXPAbwOZUFMiFiraR?=
 =?us-ascii?Q?ZUCd72du6CJRpJ22HuvxaIZpPBgZ4S+u6cSwoiwXatXrwcOmBiZGrKFdXO9K?=
 =?us-ascii?Q?W1BsMhbNdnakaEk5i+e48Kq+adKVn/PpsPFk/0KnpnuctzoK+pW12sjt79d5?=
 =?us-ascii?Q?olb/kIBa0cGsl5r8CL9JcKIi2rX8CNaY6F569s82EyY8nI2KJRNmN8OB4vB8?=
 =?us-ascii?Q?h3MVa1bm6izktRzpbK/CXJ667EQlbJ420a45+nzp2AfpN89TUd4seIu5666Q?=
 =?us-ascii?Q?tcbGeGQufjxDSpcCaHwEOSnk2Vstxg5tuqEfdiJMF2W7Tc/y5ujaaSexS7q7?=
 =?us-ascii?Q?1Tk1Q/hNQBGhVQkIprqXNtw4Xo7ga3vb52lO+QdxyfZj/B+W7D17cSUzXF9K?=
 =?us-ascii?Q?iiz8+OC8tNxEud5HBeNjqvZCjfsaPzDgsJ1UBH9WHj9ZMBVBkfn4OKZMYsg6?=
 =?us-ascii?Q?n3eKijrhHi7BTrVPN0YdCnMJb5BM/2mTah/s0V+pH565FcW85MdbLfCuzZ9V?=
 =?us-ascii?Q?GI6sCnZvDL/96SB1+Xf1qvU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c4d1a8-0ea4-4211-5a41-08dba33eb273
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4780.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 18:36:31.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsNui39GBzCSbHv3O3xOe521eeNz2A2T6QNSoPgEAVFR7kx3YbryPNbr27NyHtr4iuI16tbBn+WwomJMvwVQwzvamDBXfQIXIt2WqBuKOrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8405
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Morse <james.morse@arm.com> writes:
> There is some noise around having a discussion about how we make resctrl work on wildly
> different platforms, maybe at plumbers, but there is nothing solid yet.
> Can I share your name as an interested party?

Definitely. Please do.

>> Beyond that, I hope to be able to provide some Reviewed-by and Tested-by
>> soon.
>
> Great! Could you do that against the most recent branch on kernel.org?

Will do.

>> Otherwise, let me know if there's anything I can do to help with there.
>
> Any review or testing of those patches would help. The maintainer needs some indication
> that people want this stuff, and it's not just me!
>
> I CC you on the patches, but lately I've been getting 'inbox full' bounces from your mail
> server.

Thanks. Please keep up the CCs. And sorry about those bounces. That was
a temporary problem that should be resolved now at least.

-Carl
