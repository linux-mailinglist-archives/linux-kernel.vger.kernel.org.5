Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A477EE5AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbjKPRGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKPRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:06:06 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F0DB7;
        Thu, 16 Nov 2023 09:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egNLZ9iLAgDD6OwQADJmDcH70gC/qYVT10W1QZgn0vrRG7G0/94yuoVTvSblqYg2oYWYZYS1pnP3uV5g8CKr6duRbDbQfgDxRMXhj0QXfBeRkznlp3618+whTz1aHfHdPoiIRMtkxEU6wR2CXKhWAL6+bqRmgGXlloGE3UHIJ2uGEODzG+SUtxQQkSxHu8Ye0dgHJ4Dd67DZyN0ERYfRdakcXqxo/k2IM4E1LgLEAIwMIWsY56NjFp6OIVEjxfB2rrIsIHVTajty7AZc7rS6/N7cBzoGbhMOkfOHSe3CczeXytRCTyzBvmJ5EVWPzaR5o5SUGp/F0zYM6t5RQ2zTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kBjJ+4UBehqT2eox1c29qfDNbXego7G0mcFepCZXUY=;
 b=c8n06BLmZ3t6CNSIYWBl/Ulvzn8qRgI5Wup6r7PWiYwSjTZHaZuJijM/S94q9WGA+Cz17YV8jdG+Gxlu+fx5f6Kudmmta5bUb64WOBBlnoLp1BP8/Z+s5HELXyPP91F3yiQGvxBvP1F5gwLxeCFcD+6ssxw4Z3F8FGpxBrfWSXT3KSwd2eEAh3clJO1uS/+66ifveIIqpjr9YEpwL6bsN22ZZROCrb1AgjCEKsGCSe/1XRtx4hlcJgfaFtj4W6CliBruTstg+RXcucRstwVQcO1uSzGblvlVqEX+F5kOAd5CablVOhVD6Y25RPQZ8/a6CmzumV6AlqNh3GxJmZ4Upw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kBjJ+4UBehqT2eox1c29qfDNbXego7G0mcFepCZXUY=;
 b=BseKa4RHFshh8F1qtpT4JZVcP19WQ+JGRMI29AxZBf88h62JoLOFKKIhwpe0EQgQk5ABbWUprc9JAuO/1R9siDw+SGDBV4HHOq0egFl9HogDumN9bYySljbVobg6KeGfTBg1pttXNYYNTZCNzXZiwoXzdDXTbxu7zaDKn3LMfmILvFbYvKq/Z4j/OAXzG9VM9ZyO2lYJ89KLdKXlNCFFA0nwjv6G+q66kY+53mquyZTaXdPFaoOg2cPgkWmAoOjVnFbMXycjDFGsSAxoWV+5I4VY6Fu2O8WTMyf/bWQApOZXQyBcDLXwVYSD91NlcWk5h8/G13A1RkARB1Jw8vg9uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 17:06:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 17:05:59 +0000
Date:   Thu, 16 Nov 2023 13:05:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, lpieralisi@kernel.org,
        andre.draszik@linaro.org, quic_zhenhuah@quicinc.com
Subject: Re: [PATCH] iommu: Avoid more races around device probe
Message-ID: <ZVZL9kZuVsb9VPnM@nvidia.com>
References: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL6PEPF00013E0A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c0caaa-4eb9-43c5-8024-08dbe6c64e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: douqPfGXkddJ07iNFGO4kEYyUppJ1BmLim1OAUaniKv3wXGk7oEsdoa9VMsHhEvbyQLttm9/BZM34rGdrK6Om09u7UTKOyHsoEeyydjvTweZ6YGlve6/76bMIdrxcVOUl6TzlXvzIEbkWrLg7NT9R+m+//qFePT4/3a1SI+TWK2eP7e9E4dt4S3BwXZOX4Tz/EBz/fi1TWz1PTM5Aj4ol6vNXLz1h694rT0E+m0Gb8pyaSeNT02HruDxGsZDQPTsi+RF87QryUCfauuj536JhSXqsfjVuOeXperDx23YPNEda3TxHo5NjQdLOHFZ+OKDoQu4LD/g7MKutK6kNnSzmWdaYBz9zgT64uyKBDocor8bXulwjyk7jn+1XtkhAUfKSuuyJEaz0tVegDzBhLy8X4fpWaeO9viZNcYXWKC8UguhIfJAJj4JghXxLCmOQSOzl76aY2ucUqnCBU9LVufvp74FsKAgPlgJDefUL6pC52ynbusKzc0NpV4eK4zhFeOPJNHXPeZ7hNWQd0osoi7O+dOvKAPnf2GidarybR4QAU2UHFaqIxIoXTXExJ0rT5rR1g3HWTHmVoqMimT2eT+t9s2v7BIsbTdNOfjkPXwMpOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(41300700001)(36756003)(38100700002)(5660300002)(6506007)(7416002)(2616005)(316002)(4326008)(6916009)(8676002)(66556008)(6512007)(26005)(66476007)(66946007)(8936002)(83380400001)(86362001)(478600001)(6486002)(2906002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7MWARaY9twvNtNKM959wEebynYWRNAMTlEFK4UEFwSoRm4A9wl5b4fLO1JNL?=
 =?us-ascii?Q?OAkoyP4e+LNDIUGX6zE60TSzMjpdlkPvwmRaDvBLKoJHNo4txEe+5SNr2wom?=
 =?us-ascii?Q?VOvnMv5Y5CJGZ3TjUsEeHqzeZaGe8LuH6CfldS9R659jkhjKGqlyDTAR9qdm?=
 =?us-ascii?Q?GIhdAQc9IrCBu9nX4+2GeNvWDpe0vHtaM7o0yYOioYSLAD7volBz4KCnTw5u?=
 =?us-ascii?Q?Q/uY6eMTeSUCdl1D3ABV6Zh9TJuBeRaEKLkVfF4U6ByzB0L2Rs8F9rJW0fsj?=
 =?us-ascii?Q?JhU+SZc8DM6oTisjpoZFQX5UyYhhOTfkWREgizmGpYZNCCS0y/9CRPSvjrEa?=
 =?us-ascii?Q?KvBGzkBGWDpbJKdKR4yo5yYJsZCSpfJp3Ho4XoHK/bPB7fDvMELxvSHIeHLs?=
 =?us-ascii?Q?tmLZA70OZ/rRXf18OHIkGazd3fzi2oo3/ERahq8o3QMjzKCUcESKtgferF/c?=
 =?us-ascii?Q?Y8D+Li5O9IVj1XP6llIAplHl9N1ClWrsGSOxHhmU4REWAQ+cAqSAV/6/YRKW?=
 =?us-ascii?Q?OYi8k8YSMCYQREKqiiX50p4WAenhK5EpAX9uRWyQus+Wi9SA9qN1TMyBilHl?=
 =?us-ascii?Q?VyRNWngdr0CvzAaLahFaUWdk4kEe5eqMjX8Tg8swx+ftTlcx1bsyscmo1x7o?=
 =?us-ascii?Q?R2ar0ClGXqpDAH0dGphoHL7GKLEn2gyZMB1OV4aGNXPZ0fwQ0mJdUBvqaGyp?=
 =?us-ascii?Q?kL6F+kOZpGi+Ef3QebtU7WFXiXroyNF02lTHzUrL35Bj5VAk+kGMCFBfRCUi?=
 =?us-ascii?Q?diH4jK0xo6Jv2huUDZgrZpzL6MY40NXJEzi7zgoTMwt6Y7wLjXyTeqYbWMCL?=
 =?us-ascii?Q?KAuWz8mv2j9FKZNToO5Bro0XJ2MVW5so7Oat0kk0Q/tA9gk7VI8B07HhZz4w?=
 =?us-ascii?Q?BwpXpWPoHmXdVaIruqSM4BXrp042pkhgC8LKAc8Kah4jKg3CJ/EGIx1UPbaL?=
 =?us-ascii?Q?c7kqPabOXaBXE5QHP+G5R901/Hz3rgVeix29/2cOqlsXQFlJcSObD+Dzz6HN?=
 =?us-ascii?Q?ygu75ckaOUTRjKrQnVVk8ArZjv2+2E79vnQDlNkuVFFOLSBZBHnmdhAPLwbt?=
 =?us-ascii?Q?YQB0U0THmIEAd2xVGyEWBbNzXO9EJ8Na8zQgG8JJIG5z8xeODZ9k4hcGygb9?=
 =?us-ascii?Q?Ha56rSa/PR8TLrbmviul8vPEQlEV7AtSvjz51sIw81nSI0py4MFQu6aC9BZN?=
 =?us-ascii?Q?/IMWuiBlzniSHS45e0ZMleum19cccIL0QDjldNHgoX7V/E2bITQj/qddjZ5U?=
 =?us-ascii?Q?hXWuJfdDvwCAY3ggBuLSBBksnx2IUXbgqLjJgnhUo+qgXi7moAhQwoOo5xK6?=
 =?us-ascii?Q?e+myX2j3iN4p9Rj6X8ddppmVsPKr6RyD94KRjglvr/QeDW5EQWnsCHse+U1E?=
 =?us-ascii?Q?gjlj3INWrIVa8iENKUMtOpI4STY9mVF8aGWlIqVDNwDTgXINW/l4wfng42W3?=
 =?us-ascii?Q?nmMz2RpcapV9Mzx8V0igJuTfOUQIp32BmAhOtiGFX/7v2/fF/k5LpA1p2KfB?=
 =?us-ascii?Q?kPWU4x7dlwsMS7yDVtiOrw5B/jKKnHqs9MjvzA8DEcVa+D8IQhMBQlY8ufQ/?=
 =?us-ascii?Q?lhia8T5tgAiX83xR6WExDZidj64gNczSjNbWBJLx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c0caaa-4eb9-43c5-8024-08dbe6c64e7d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:05:59.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0cKHpYt3kxWhjpKj3HN9SgQePNnx2JmVLfYV2EZup/SJdlh9YtgDVxsvw5bsjU1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 06:25:44PM +0000, Robin Murphy wrote:
> It turns out there are more subtle races beyond just the main part of
> __iommu_probe_device() itself running in parallel - the dev_iommu_free()
> on the way out of an unsuccessful probe can still manage to trip up
> concurrent accesses to a device's fwspec. Thus, extend the scope of
> iommu_probe_device_lock() to also serialise fwspec creation and initial
> retrieval.
> 
> Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> Link: https://lore.kernel.org/linux-iommu/e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com/
> Fixes: 01657bc14a39 ("iommu: Avoid races around device probe")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This is my idea of a viable fix, since it does not need a 700-line
> diffstat to make the code do what it was already *trying* to do anyway.
> This stuff should fundamentally not be hanging off driver probe in the
> first place, so I'd rather get on with removing the underlying
> brokenness than waste time and effort polishing it any further.

I'm fine with this as some hacky backport, but I don't want to see
this cross-layer leakage left in the next merge window.

ie we should still do my other series on top of and reverting this.

I've poked at moving parts of it under probe and I think we can do
substantial amounts in about two more series and a tidy a bunch of
other stuff too.

Jason
