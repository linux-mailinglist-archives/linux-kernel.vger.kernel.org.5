Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2A776F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjHJFLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHJFLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:11:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2131.outbound.protection.outlook.com [40.107.93.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77705196;
        Wed,  9 Aug 2023 22:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbkgY23cZN+yic2Jd22858E/2QHY6c1MQJd9onuMxxGoVhW3oryEaoJAWKCYcSjEsKFUEB5/4HIeEGbPn7e4EkipkOz9LnK7YZAkrveZpVMlrKvInW7mKAlQ0x3KxBTMcBU+6cS8fGzVNLNIFtKq9J1exW79UGRQuOo4frh+TMYT/KoZi0CGHQjqTx6ZLU3Ara3pP8cJme4t57hRrDVzLH0+Hfdc23FOZwbQGHqDRCci40KFYDCVnLJ+uUZPLVa05qDVjVUWlOo9OK+lyFS4jZVAgzTikW9we/Zixcd0lMXBjwCQ4CH92MfmJX80ck1jakh6rrzmtuKKBbu36jNsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUZQc6QjcrArPBbii/DtoKwXptWdANRmKLzdI70UGIA=;
 b=dxuUxWjZaAFlHz/jigTs7/8gJfmk7BlJMLQE2KS4jiFhKk0hGZ7bPa6Qs7W/ESgyPufUFw8SWrbkF8wbbQZy+F0YqO7EV0ZuQcs8zwA6Q8nxRhDgUF8wqcGjx15yafpvrd1xnp5U/3bfGPtdWxeYhwZSbfiV4HII9IDFJtCEL6WkaU243syZSj2lVUft+fgouDP9zShI6ngfMgRIC1Ze9LBNy4q8CNrKxQGz/l65KYAVxEWh7JDCadLwDuQBh+JJoT3U7W7huSA5ZT+ndcCp3Bd1Ve7rQ8CRGUWdIUPk/8/TE8ud4XqqZRlNRUf3mGuuwml6unZmVb/vh3SnOl4zRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUZQc6QjcrArPBbii/DtoKwXptWdANRmKLzdI70UGIA=;
 b=Gcj0fXnlMRyLZE9Kd+z7Eo7FW1ffuc341BAo0mhoCrtM+7NxCCv4SL1FiqCXj0ulUHPSfhP3YzMkUtKhmUf+vurn7O9vtRNFHVrNq+33AnaHDKRrI9GUe+C4F2B+1UlR+5RvIwNb2e8ZU4jZ4BIHsfgUfPx7fQaDGcGLIlu4UQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ0PR01MB7249.prod.exchangelabs.com (2603:10b6:a03:3e4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 05:11:05 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 05:11:04 +0000
Date:   Wed, 9 Aug 2023 22:10:51 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     John Garry <john.g.garry@oracle.com>
cc:     irogers@google.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilkka@os.amperecomputing.com
Subject: Re: [PATCH] perf jevents: Raise exception for no definition of a
 arch std event
In-Reply-To: <20230807111631.3033102-1-john.g.garry@oracle.com>
Message-ID: <373e8253-656c-84dc-c05-b578e3725d@os.amperecomputing.com>
References: <20230807111631.3033102-1-john.g.garry@oracle.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:610:b1::12) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SJ0PR01MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: ca815d23-2a37-4841-0864-08db996031d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edtmM99xp+cgqTCTuk6OwyCpjA1o5+DM8tcnyz6zmCRRSZl9cI3e3pgYMfkSWNT4kzk3fq1zO+V1i2CS0kcX3AoyYREEAERHoVJ8RIEod9S7v3+G6eDjv/e15ybHC/zm29tu17CdMbFoFJvxSPskNyCJa0pvRV1UTw1fGWRtns4pI9rRGZv8QDkJPDw9+uzkQFl6VJlVf8hImLxIncuBRv52fpL5nS1fmEh3apDdxJZ2tbOcCbSL7rXEzKXKUaYQM/o/JB3Vr15/NkJUFswjQmgtzXFGrO4m2BRoeWsHMVdE00bS4SprZ0WFIP0xjbg9FhGkqj3hcTB+YW6w1RqfqLjJq5Om1Roni8G3hN5I1AZpYPtOH4yn1jLHNm3NfzUOlVuNwnP2NO+snyYO5UxruP3Ym+yq8dKAvVAL+icYkU2lTTcHC2f3sktT9sN5Hcnr0kSS9MQAII2IlUC2BQOlGvlTCRaBb8qpLn9LnJqQzsk4a5nij+9WDAOYVlAagf6wT9PGxZpzBXEtZ1hQSYo5ki16tzNt8ZnEX6GK6vm4SHGgQwMSesBDbYs3m/y17jQuEZzPZ1POIBxjGvePuFqiiHRNuWXBxJRNeBmp/eZohws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(396003)(39850400004)(1800799006)(451199021)(186006)(6666004)(83380400001)(2616005)(2906002)(478600001)(41300700001)(966005)(6512007)(6506007)(316002)(26005)(66476007)(66556008)(66946007)(6916009)(107886003)(4326008)(38100700002)(38350700002)(86362001)(6486002)(8936002)(5660300002)(8676002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQV+j4+Iy6Lm3qfxUfxyOSubTRZMyIASf+kz4goGZXj34hVztBCY9ntEWria?=
 =?us-ascii?Q?h/7QL+5sauK4Pe8yQdwG9fl0Hy9HmHZ9DaB+yeu/Kd3wRWGUjks/p6ipveg6?=
 =?us-ascii?Q?7X6EG9nJi64lkFwMV8cJQBPdnXakAIMNR0wgSyE8NGGxpaZisXPUJq/Phy8i?=
 =?us-ascii?Q?aVe2SOZZ4Eg5aBbH/jUi4XqmwhJfmYcAQoHOCoIF7NCUJmmNjoMk4NhahgU7?=
 =?us-ascii?Q?2327zZyCH1K+faDSYPPOXH0RAufRztW73Cu9pGX9O70mBadFgK2W41J68oo2?=
 =?us-ascii?Q?LXCCaJqlOcnnxpfzVTVLkfE8E9vD6pFv1le0H5PtaT+5gNQnOyulPlS0e7XX?=
 =?us-ascii?Q?Lw9kpK+DD00+VZw064lNipHN8StbUEaEkAtmvblsYytJsrAVU4wAle35yrba?=
 =?us-ascii?Q?O5tSFpLYp+TiP6l1yNURBZmZxuFNIiAEmoU2jxXA98dSJanEp3jAOo1ipHQT?=
 =?us-ascii?Q?ayCBrB6egrHDcJsBKcMVsFC9QtamDpbnGGqR67Y13Hi/7wjUPaYrvgCX888T?=
 =?us-ascii?Q?sweIyddeRUOy7yGUgPeFYxx6jvTvg/K9zn3W9XhgdqSsqFMlfoZRENWobbrl?=
 =?us-ascii?Q?fCQXgGWNgvB1WpP+cqcCMQCogGNEjsIdS2yiuiEdYtAMf5diwXZFW4cQF75/?=
 =?us-ascii?Q?j7UmX42q2woHd67JB5KvngJFH8jWvKD8WsQlma5k/tADL7l5TmHu1ScMO4cA?=
 =?us-ascii?Q?JOewrJiMKYZtxDHh80cudAmDwMm77EMSHsB/W2mOZuyO4T0H8ECUQ57d3Pdl?=
 =?us-ascii?Q?OZt1L7jgRXHfJuqG67+eWhfuQXocq4+eUUjgyeyolPV6HjGDDN8hmDgXfTI7?=
 =?us-ascii?Q?3qqZqXJefjt6nU2p49PqlpX3/yEgSbMVSrrwT5PlQ+uf/tIqIQpf/aKq380i?=
 =?us-ascii?Q?KQFSJoCFhxUfPJxmUsrI3NJ10XiLg0bQGAOOEfVHli726qD+/IOCRamEKSum?=
 =?us-ascii?Q?l0W4jHqrgFWwyVF0n5TUhfNp3Cbb65K/oiRky6ht226yUC0RYbSKkoIdNIo0?=
 =?us-ascii?Q?+ePrpefFR2YieP/73bZMTGy5ozF/mhCW4kC0ZwM1NlDGjh7YE28qgf0EfPMX?=
 =?us-ascii?Q?6QQNqGhkJwevofFoGkGlAfSqPpXHMniO/kmclnQe51VEdZBqbrRVc64XFiGI?=
 =?us-ascii?Q?kK6C4sYUBxWaehiLBkfyp9SCWT50IFd1d2D1vWNmg1Boz14EqyuHMWso5LvE?=
 =?us-ascii?Q?tD7YapohFyQks7dtNbA/0rhmE0JZv4NT59SvA2D2hwvhmgIPyXbEG8OWfz2G?=
 =?us-ascii?Q?P4gQ4XcjBB3vO+ZLphTBBoQr9bkSpr8GkMrpoMWi4J6HRiRrN2fMLaprxUHz?=
 =?us-ascii?Q?DN8G/o+f/dDtbvOHJpm8RqTogmQVy1vwgFc0i23Y99WRVBmCBhsDq3EQmBTR?=
 =?us-ascii?Q?qHjONKGnqv3dNnD0Meox8XrdjPG9IPX96n1h8lqxaZgXOX2mKBspb8HAFamP?=
 =?us-ascii?Q?6tFtLZZrqgrSS8KE5kOxT9wVgTpj0w3ZfRfZPIRfStloxXoIJ0EEij1KHZRe?=
 =?us-ascii?Q?WX1FfQ6ZZUynTcRvGA2NsZXWjghn8CuyT/fZSoggUTnHgAihyjJtTqoyReqd?=
 =?us-ascii?Q?q//6nscTp2Eg+n4ODdqxS+h/v9QkFRunYIYxIyzsyZQOu+3CgOkAFczA62p8?=
 =?us-ascii?Q?3PvBjhcXLo3B9wUn2JP3x9E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca815d23-2a37-4841-0864-08db996031d8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 05:11:03.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwHS7MfKLww6FcO6gelPfkta6STVmFgO2110w0XTKK5AWRZHXohTVlh/p4+wTMuYSVya0Wk4NmkLv73EGPcfYUPWjAZ+rgCU8fptfFzUKnNvRSCj5ZACG4yDg8rz3HPa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7249
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi John,

On Mon, 7 Aug 2023, John Garry wrote:
> Recently Ilkka reported that the JSONs for the AmpereOne arm64-based
> platform included a dud event which referenced a non-existent arch std
> event [0].

I wish I had found the bug in my patch a long time ago but, in fact, it 
was Dave Kleikamp who initially pointed it out to me and figured out the 
difference between jevents.c and jevents.py when porting the patch to 5.15 
kernel.

http://lists.infradead.org/pipermail/linux-arm-kernel/2023-June/844874.html

>
> Previously in the times of jevents.c, we would raise an exception for this.
>
> This is still invalid, even though the current code just ignores such an
> event.
>
> Re-introduce code to raise an exception for when no definition exists to
> help catch as many invalid JSONs as possible.
>
> [0] https://lore.kernel.org/linux-perf-users/9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com/
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Thanks for the patch! I quickly tested it and it worked as expected. Just 
in case this is needed:

Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


Cheers, Ilkka

> ---
> Please do not apply before [0], above.
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 8cd561aa606a..98cccc3fcbbd 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -347,12 +347,15 @@ class JsonEvent:
>       if self.desc and not self.desc.endswith('. '):
>         self.desc += '. '
>       self.desc = (self.desc if self.desc else '') + ('Unit: ' + self.pmu + ' ')
> -    if arch_std and arch_std.lower() in _arch_std_events:
> -      event = _arch_std_events[arch_std.lower()].event
> -      # Copy from the architecture standard event to self for undefined fields.
> -      for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
> -        if hasattr(self, attr) and not getattr(self, attr):
> -          setattr(self, attr, value)
> +    if arch_std:
> +      if arch_std.lower() in _arch_std_events:
> +        event = _arch_std_events[arch_std.lower()].event
> +        # Copy from the architecture standard event to self for undefined fields.
> +        for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
> +          if hasattr(self, attr) and not getattr(self, attr):
> +            setattr(self, attr, value)
> +      else:
> +        raise argparse.ArgumentTypeError('Cannot find arch std event:', arch_std)
>
>     self.event = real_event(self.name, event)
>
> -- 
> 2.35.3
>
>
