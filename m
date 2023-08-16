Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76D077EA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbjHPUXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346034AbjHPUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:23:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D361FF3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVVS9tWh3hCQdicLb9IWox4muu0CQ+fPRmXyzgzixjQQkBlfhJ9xXyGr0Jhy5wIXAJ9lv27PYfz19KEQTpr71aNR1kNEy8yZeF/jbvJTdOT1DhzbAM+TqXL1lngCLLEcHKCiuyyG+vbSt/VR2TcFJ5vWDaXjLENJksYLu1gjiziBo8VCtZvEdOKJbrFLspNC6ncqAjmKY9ntmIkp4rrrJxsB4ZmPe10xNyzI9KpXvPHxbqYAW+CYu4KUH4hmWcS1RTgGk+U3KzhlYfimYj6ChWC8n5EMI3QMupVpZ3PTf8WUsycGDYRuv9tlZTldFxzy8QQQpCwSky+VUCwvuqp8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmHcrivSzekIIcqnIEpi6S9fp56Wvu6/vDcwMjWSizQ=;
 b=YJUu/58YCIg4vTYG1A04p8Gr0xB968ihQ/NbPwfR9XK9FkvsFumtOXWEipeEH9ZmXyjTO/V6Q4m+AylYp61kP6LYhVtrVGS+ufmHIHsDddx7GL11Ig09uW7QEdxfj5XhW74moudrDWbmd8D2d3iGLAdpptG8oSy0RBKJSxsdfF1n4GbkSgqBijDSRXm2pSFluSmJ4e149LWZLmJfnKWuNGSww8vJ+ngQYdkZis0elHoy9KoUYCIJrphcn8954LFfUvDK5JrlzCAlXBZEdD16VDWRwe7ZcJ/Qe+wtwVKkYRmwfUZDv3KIzLA6P5SI6a6+bNJHVnI2U+3zdt24qmt/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmHcrivSzekIIcqnIEpi6S9fp56Wvu6/vDcwMjWSizQ=;
 b=L8HiYZi5DgaM0bPDDdR1pBRrdPyP7TIW0WOvjSetGDeYIQMFSUc/Ij5dK8OFKdN6OW0da8KzE07AjkMIqC9DESk6IkHZ+uNz8pKA2IlnG5svzaKEeRpMHr5E1X4pSqvFg8mO3tvfyMEwOL2b3xwTtqtl6T4m409c1dEp67Qd20M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 CH3PR01MB8576.prod.exchangelabs.com (2603:10b6:610:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 20:23:03 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::67e1:3510:9ea0:8661]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::67e1:3510:9ea0:8661%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 20:23:03 +0000
Date:   Wed, 16 Aug 2023 13:23:00 -0700 (PDT)
From:   "Lameter, Christopher" <cl@os.amperecomputing.com>
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
In-Reply-To: <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <1f21c7bd-4bba-e72a-c998-0e11fda8a5b1@os.amperecomputing.com>
References: <20230811090819.60845-1-ying.huang@intel.com> <ZNYA6YWLqtDOdQne@dhcp22.suse.cz> <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZNxxaFnM9W8+imHD@dhcp22.suse.cz> <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: CH2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:610:60::24) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|CH3PR01MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: f41ff91c-8152-4814-a166-08db9e9697b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSApb05R4DnaJPAwZGlEhU9UoVtqCHvzsJqTJckG+Jw5petz/arNJ5KMBAEdH9hxptK8HPaqJotf1YbtVOeVcdDKJCgZ+Ey9M27owlbnBry7Y0Dx8sc8fDX5X/CSVtWxG6XjBMaU6RjCZivx2XpOWawbxgxsupbxQiDKDTo5X5eJ4KOm/4w8nQ4ijVkAI5m3+8LVXgpqI0q3HLDslwnKhPOB/kUzJJj1mQtDFtDONMEkcNAKBxWyUG5Y/g+6nPz2F7QQjlQ+5EuOHtwd9v8WUOnsjLwn5nRg1jmC0854B/8tX6ZdomlHHtXYA59effu3AZ0baVmQJLOcuBP26gKmvwO//pkFg/Y5+ErnOboDPJ4oKd/txw5wJkCiZLw6HopFvoY/Tz3e+G7MGaMc+al4rkhj9+uyywPfLffRJ9pcsxgzaEIiNeZ6no1WjNA+8ZN6mV+0ylfo67Um4w/cG1YnNY97n5QZBGlpfyAbW/V6VoslfGOkUyQYzgGEoYHbvPlDguC6D0TkEEsFJ6GQqnPfXJrH8Xqnalj9i9dQJdd3qu94YdJgP5hXhYlBvXS8vF2r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39850400004)(346002)(186009)(1800799009)(451199024)(478600001)(86362001)(41300700001)(4326008)(8676002)(8936002)(38100700002)(5660300002)(66476007)(54906003)(66946007)(66556008)(316002)(6916009)(31696002)(26005)(2906002)(2616005)(31686004)(6512007)(6486002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmJ5akJDdGJTc29aSUdYaWgzZmE5Y2pwcWJxNWRybTk4M0dRWVdnRHQ2Rlpi?=
 =?utf-8?B?VDJUZWoxaER5cjNXc01GWlhLQWVhM2FYczd4NVRZazNEYmoxUC9zYU1BRDIr?=
 =?utf-8?B?QWM0TjY1Smp0dkN1enZHS0M5MTRhYlJ3OTFlcGp5bDgycFUzSlpuUlJ0U2p2?=
 =?utf-8?B?RjVwQjdFY25CZy8rUDVJbWFpNzk3VFVvUU9oTWxBazlVZksrRE12MENsTFlG?=
 =?utf-8?B?TU9PTENGM0NzODFibmprb3dEWUZWb1VUYVBIUThYWmRXdGowSG9mbFZzSEND?=
 =?utf-8?B?UnY3Qi9TQWpBTXlZdlQwMjl3aVhYcVpTMFRKanZvN2xYK1Z2TjdpcXN2bWt2?=
 =?utf-8?B?SVZ6VWdNYmNlem0zdWJ2dE81ZjVsQWFwNUU1K3p0R2p0V0pXWWcrREhXY0N6?=
 =?utf-8?B?dXR6KzVEazY4WW9kem1JMHpyeldNWnhjbkNRR3NFemRmM1hQaktBd3J2UUNS?=
 =?utf-8?B?Z3hiUDRrQU9UL1FVdkloVWdxUlpLNkd2WUpmbTdSemE5MkdudmNtSnNGY0RQ?=
 =?utf-8?B?T0czUmlaZGo1a3lyTHZZcmhWOFY3enJ3dU9QU0M2Y2FORnJuNEhuWkdXcGoy?=
 =?utf-8?B?SVNxdWVzdXF6ckFLV0lVTHFvQWhnL0licnY5NHNmUzBVVzQ4OVJOdm9MU3p6?=
 =?utf-8?B?U0sxMWkyeEQvYklBZzhGbDAwMENXV0tIQ0d5ZXR3UU5iQUhMQnhuQ0ZmNkE5?=
 =?utf-8?B?elcxMVdhYUtDL2hrRCswb3puaUlrVWFRWTRCa3JCaWhPS25PYmVYUGdJNVRJ?=
 =?utf-8?B?MENJdDRncDVNb0QyZHRWMVVRS0g3emN1cmUycElkSEMvNHhFejBac0F2Um9I?=
 =?utf-8?B?RW0zR2R3blNyRzFYbVVrZ0hKL1ZpNEt0S1lLSlU4Nk5aNUtic0xpM3BwaGVG?=
 =?utf-8?B?YXFpUVJFRmFDR3o3cmZYWjR6Y3U1MndKS3dqMEFZQ3Zna2prQ0FDMmNMWnNo?=
 =?utf-8?B?UlhaT0RGRy9Uc3VrWkJMelZlNitmTmJIM2cybmxDY2g1eXh2WkhXaklmNzdn?=
 =?utf-8?B?NFI0azBRNDVRZHdLc0YzWDREYVJPRFRjbk5HSmJ0cWt3eU1OSkdqamFqb2ZM?=
 =?utf-8?B?RzdJUncwYlNvM1RzNVBTZ1pvZ2pBaDJoWmZWWU5XaGUxK1ZIRWwyM3NUcHJC?=
 =?utf-8?B?UGdSYkVmOUZ6bHgwV0NlSFl3V2EyY0svdFBwTXB4VEpham9OZks2dWpJM3Fk?=
 =?utf-8?B?VGdWSitHQXllNGx2VXNXMmQvbWNHbjcxQUx3Q2RkNVk5RHlINlVxUTY2eHJr?=
 =?utf-8?B?WHZtT3ozZllKUC9QblQxNXlyL3FkMjBPT2FXNEpKekdjcU84Rlc4TGp2NWRp?=
 =?utf-8?B?Y0tpb3pER2E5enNjM3FvR0ZwWEFMdFVISW5Fb3c5T01zRHNEOWtFR2NkYTJN?=
 =?utf-8?B?YnNkSW4wTnI4cU1xTU1nYmxVYXZEREQ0eUUvK0VPRjcxaHEreHhUNC9WODBh?=
 =?utf-8?B?Y01nRXhYMlovaVUvZTh2V0NiMElhTFl4T2c2N0Y1RFc0WVlidW9XM2YvemZt?=
 =?utf-8?B?RXNJdEc5ZHNkdWw5L2R5YzRDdWRTdlBJYkVVR3dJb1NXdmJJLzBSU1NRSEtB?=
 =?utf-8?B?ZUZuUDRvaURjdGQyTDNDVmNWWjROMkJTaml3ZDFBTjZwRVBmcGZXYkp6Z0Na?=
 =?utf-8?B?MEFxMDBJbml4N1orSTBhOGdkb0ppV0J3WGsrb0FKU05tR0FsdWtFaEo2NTkw?=
 =?utf-8?B?eTNaUWlBMDdNbWxidGdvZ0VRa3ZZQ3NlMngvRStZcWl5US9yOUE0THJ2bGtE?=
 =?utf-8?B?eGw0dk0ySVY0eUphcSt6bVNOdHN5SUhUSFBDSmZ0QXV6NkMxUFJBbjM2OFRq?=
 =?utf-8?B?ZUdjY0tUUEhZVHlUVVAwaE5yWUpJV2ZMNWtKcmpJM3lJQkVKQVNZaEN3Nytx?=
 =?utf-8?B?VFA3YjJObkQrbGs2NWkrWEw4Mk9TZjVtNGxNUlhkYktZWG5rdlZSNS9qbHlH?=
 =?utf-8?B?MllFaTNyQzNBSUlMNWJKZklUYWFHNGY1M0pHVENzMkZpMGhIZGw1cjlRRDhu?=
 =?utf-8?B?YUMxVnhHNkhoOUJrN2xKcms5UEtROUhWUXFEVTJ3Z012blNwLzRWNFg2NmJL?=
 =?utf-8?B?Q25tbGYxeU9ib2t1M2t5dUNFTG83emJDZDhpb0p4clM4amE0V1hEemJzTCtt?=
 =?utf-8?B?cjhqY3loUi93UThqMklDUWgvN2ZuVElsZUxKWEdMTHBFNDcwL2dUVlBENWdM?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41ff91c-8152-4814-a166-08db9e9697b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 20:23:03.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIHGgL9Us2SCtEL8SjuVTe4HqswbvNYI8Y0fJzQ3k78KMxlzrkRa6BbcExfak7Y0GDFiFVKkGLAzQUJE9emdz+3nfd2Uv3/9gY6nfU/j58M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8576
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023, Huang, Ying wrote:

> Michal Hocko <mhocko@suse.com> writes:
>>>> Why is that a problem?
>>>
>>> The pages of the remote zone may be kept in the local per-CPU pageset
>>> for long time as long as there's no page allocation/freeing on the
>>> logical CPU.  In addition to the logical CPU goes idle, this is also
>>> possible if the logical CPU is busy in the user space.
>>
>> But why is this a problem? Is the scale of the problem sufficient to
>> trigger out of memory situations or be otherwise harmful?
>
> This may trigger premature page reclaiming.  The pages in the PCP of the
> remote zone would have been freed to satisfy the page allocation for the
> remote zone to avoid page reclaiming.  It's highly possible that the
> local CPU just allocate/free from/to the remote zone temporarily.  So,
> we should free PCP pages of the remote zone if there is no page
> allocation/freeing from/to the remote zone for 3 seconds.
>
> This will not trigger OOM, because all PCP will be drained if allocation
> failed after direct reclaiming.

I think this is a minor issue but its cleaner behavior. 
vmstat refresh's should continue as long as there are 
pages queued in remote pcps.

