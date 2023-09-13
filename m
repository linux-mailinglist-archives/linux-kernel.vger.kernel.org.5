Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA6F79F171
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjIMSzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjIMSzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:55:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC16170F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/TffqaZa4mZm+n3zzY1i+/yYKIh30i6tQbDsbcl/X1kDhDc++qTYSmfT8ywrGGFBO+0wBo9ZrrWs50rpK7xyGgdYyiLUofLWK6zduHmmg7OXIzLfUTnhcbnD3YE1bgScbMo/TfWgbkguRyAebqXzKlD7hWY7eCoRnMdfxxSAA8H4XVAbinU8Xru7uQ8ipF/R/nvRTccKrvhk76qrEE0cuVdUhDsWGKv88cUpYl6vpelJNbUXWdJRDZ8k4Lp9aR3ZqL36rWyLM9yQRGqZLQ8GrhqkNfLDMQBFhnROhty8dSZ556bIZlUvllk1LsgnNlBgxAxWHUvSR8vej/sPXpxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmYUEH7zAmp6yNcPf3SeCKX02JOlcsMH2sWErPz4eKM=;
 b=WiKsvm1Oi8bIlR9ve7PSjL+AVRL5babyyusKsq31Ws610jcJn8PgQ4Ho+0ZD9vQ1yZpusBM1k5Gz10tcuOyS/2YPuBRF01/79pRikypU7tQKfu6mOngRyhJq1857iSmISCNb29/9pD336w6ep1zWeHXOkBrBas2td9PTgDRyu01U38FevT4cHHAUXWuO4gOzOfzvz8foA5dnQzbDPSOd4iJPOyopXsf0CgeAGySDCr6pqUdIK3h0IeB5MTSrihJoNZGr79xJppsr8/pasfNjN6AxhmLwMa4AqmYxLPXmsnSNdvxsfg+ChX9Xf0hRU2flWCbGqyhzGfBAmdYkrZlaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmYUEH7zAmp6yNcPf3SeCKX02JOlcsMH2sWErPz4eKM=;
 b=Sunzcc5IIfFsTyj13g+EsaXdY33NppO8kSQ8kS7rS+K5UpnOwrgE21UWcX5GhCwXA3xA+EpawlF3lytpZbuNI9XLBTkBZ9kX7gu/6dYcvZyFW5B2D94j0F0PuheANbwTvlgPwzkmIngMYNdmYCPFIGjcU8veQwGv3L3LX0plftSPKAZNh9ya9EkEgk9G74BKKfBuMm99WSP7AJJmmUkCxsUgI8cZhr8eP4ELqWj0VrLKD30/0lq5yF8nnBD32hEJ9Y5adVQ6o9cF4DzjBiMbboEKpyrqZrw3fjmd23/BMid6cHMuTWo7L1VR10Xp+X7dKYC4bKBytYm0+0+KoJ6cNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Wed, 13 Sep
 2023 18:54:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 18:54:56 +0000
Date:   Wed, 13 Sep 2023 15:54:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZQIFfqgR5zcidRR3@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQHUifAfJ+lZikAn@lpieralisi>
X-ClientProxiedBy: MN2PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:208:236::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 472c9b6f-d452-4392-8e39-08dbb48aebfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXADcvQMgiDtUEiYGXg8wwKV87QsQyUc4CR4uUqza+dDN0LinTsQCi7WfL2omqDYvmsN6QRqCitzFZIGTcmEM7imqSSXdXbjLnbghlAsJC6OPZBdR7vhzzkBEqkervgpWiq7WMOTooa4yYFT1Le9GPR6zQlaU5Fwqh8s0eYwQGklgcXbbjNEP9jjQJ/sjy26668mkRNBDEY0a3cJfVJ+lZf3y9wsLGG+n5adXaVklItV8oyxOJNU2x0mNEdv2JpkDTDc5/c0JiEjk1wGuQhLHBDf+iAp+nXUeu/+YM3EvhTYvmf+hxdIU5hJszTga3BCL4BRrngiI4sTOzU5X24UWpHl+JlztcCQIj9lkloul1zRIOhIf/T5MORIgbavjGRCouG7rxqgtPFJWT4e95z1roeMXE22WBrSn2OVbK4pf038OX1nsSUa9//heoRIIwJ5C6+C4kPAjEoToqiKr5BqIb84eZb5W2psc6mVMk5Z1TSiSznZQ7wH47BVKWJ2ivc9G1gAOGHXjvtdzDnQrgk20F/6yaYwuDGN9UnxPUyoha/3/lPzGW3tfFPdSEpBEFWM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(1800799009)(451199024)(186009)(8936002)(36756003)(4326008)(8676002)(26005)(6506007)(6486002)(5660300002)(38100700002)(86362001)(2906002)(83380400001)(2616005)(41300700001)(6512007)(66556008)(66946007)(478600001)(66476007)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?235szihIBF41HvT6aij6PFcMjXvYBQjsx157UIeahSPVvZYOz1yfRYS+GERJ?=
 =?us-ascii?Q?2uS6xpkVGd6CRXROfys6V5Qlf6TUJFs8gTKtdCaNHMEoN/HFge76Crxo97Pa?=
 =?us-ascii?Q?RVQi3L6sH2KyJsFt4GTXUPKAJNEEKAigByVHN0HM/AXFYa7OTPHAcaYndUPQ?=
 =?us-ascii?Q?WaXpCWI09S3h8d5V5PoQrxiAZoygfrVHmNA1NFG5Rz0nFP+20U12EsIj3U65?=
 =?us-ascii?Q?WDuz+e7xIcCyER9HWD0NksuK1HJAOr4Yl8+J+EfFXOGcgS4yry832NMWs97r?=
 =?us-ascii?Q?fKvLWyjaCBSTkU+fPjxXthwvizL1ESayjaHwyZXe93mLvVnVjJo4dI5OehVS?=
 =?us-ascii?Q?31ACr5xDgjbqA8qIQMfvLF9ihxQxd/Tip4BYACRNGSj4OoC9Pa+5QVKXXjwK?=
 =?us-ascii?Q?vwVWmiiUuV7NXpz9etRCxPR12IwvptJ90FVXBpesP2b4IaZ9HOsRYxe1c7gl?=
 =?us-ascii?Q?D8TCg52KbvozZeM2ujpUgg7aGf3qimnr6ehdPTEbK3SFO979yonV1IUeL0pL?=
 =?us-ascii?Q?HEMt7M3bb/QC2wg5whoKiZGoBz6DwgJq+uGBZ2k5PAINd6ObUmOUBq6wMeqB?=
 =?us-ascii?Q?KO1+/LowILId9DN9e92urqxK9QgYLb+yVoNFQ5ugrzloAGEUGAGK8rBOLcrD?=
 =?us-ascii?Q?/PwAZlYD8r3995MvIGNnHTfK6bnE7S7sGwQfbnNNN0a0k3sih7mrJPkMsSat?=
 =?us-ascii?Q?teRRMLndlLVoaI1oH85RtgCaug3Iwk0hSaOr1vuuZ85NC24LWfwxoWU2Cny6?=
 =?us-ascii?Q?s8echst2BoL2Z3cyQoSsIwa47tyOIZZ4cICberluXI2JIfsy288FPcRgp4Sb?=
 =?us-ascii?Q?hKdOVpjNsZcFaK4/owgTT4sL/oZbJvaqo6tKHo0hjxMnfUZIKmlcZ1FQOs9T?=
 =?us-ascii?Q?wznGpg9wrOxXunE5aNgDbrGADMn6BqCmxkIquJzb+wMUUJT4LWXmsL48agTC?=
 =?us-ascii?Q?EXEcqzpE15FBpF6tPCo3pAUazwqwef4t81ANHfXm39GnUdZHoiMszl6cqRiP?=
 =?us-ascii?Q?9IgmE7RCDK6QqkBY6P+bPM22YjgsdrykJ37no5d3LFD4yXiw4gxyO1lZiyOf?=
 =?us-ascii?Q?+qgo1CEbImen6U0mvW9RhLY/WO4vdiQ/90jfrr9MKpJzkMbBzR7O3B7tw/B6?=
 =?us-ascii?Q?MnsL/UQlLSUczHWzdQUHeuQFuAYy6dCPw8hldv8TNfMD/bqtSpNA6f6SsD42?=
 =?us-ascii?Q?B7DM+cf5Au3NPHfza29s/hcCdg2dZF2sq8kZaauuOXaUR53yOpeVJKG+msQg?=
 =?us-ascii?Q?pLyyxgRcoS17Ktqbu3RmgQ3IjvljErddrMpntGkxqnjINeSDeicoBJ1+NDX3?=
 =?us-ascii?Q?KTSLseXU/OFuB/UExZtH9OiZnKe/9dQLqKnjlesGq2JeiUHqoaY0IZflWLYC?=
 =?us-ascii?Q?fxYGd8MSjqxsBg6cRWlcT2qblZMoIWBAQTxvIljg+I6LQdQBNEelkq6qUj7p?=
 =?us-ascii?Q?P9iAteZREKdltxftw/8s/PNXnEupMzMoezZ360oVMIWJvXWEaRRdBTJQcHRd?=
 =?us-ascii?Q?tNilw5IN01jRk9vdJgMwg+TaXDD2KWcQOJDIGkl/u/FK3ewyRQbXkxs+uvAp?=
 =?us-ascii?Q?tS4NM8TrkKmS41O00KAEX853bT25piJCrCpmLOlD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472c9b6f-d452-4392-8e39-08dbb48aebfa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 18:54:56.3383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgiS6lquW3gxnk3wWi7Se1tmkmUMYicC9Y+u9JNX1AqdLPfroypQ2XYPRhLOJHtx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 05:26:01PM +0200, Lorenzo Pieralisi wrote:
> > > I understand that's the use case you are after but this change is
> > > targeting all VMs, it must be clear.
> > > 
> > > Then WC and mapping to PCI TLPs, either you describe that in details
> > > (NormalNC vs device-nGnRE and resulting SystemBus<->PCI transactions) or
> > > you don't describe it at all, as it stands I don't know how to use
> > > this information.
> > 
> > How about another pargraph:
> > 
> >  KVM prevents all VMs (including Linux) from accessing NORMAL_NC
> >  mappings, which is how Linux implements pgprot_writecombine(). This
> >  prevents using this performance optimization within VMs.
> > 
> > I don't think we need to go into details how it works beyond that it
> > requires NORMAL_NC.
> 
> I think it is worth summarizing the discussion that led to this change,
> I can write something up.

We tried here, in short the reason we all understood it was like this
today is because there was a belief that DEVICE_nGnRE allowed
fewer/none uncontained failures than NORMAL_NC.

AFIACT it turns out the specs are unclear and actual real world IP
from ARM does not behave this way. We learned that at best they are
equally unsafe, even perhaps NORMAL_NC is bit safer.

What makes it safe in real chips is not the unclear specification, or
the behavior of the ARM IP to generate uncontained failures, but
because the combination of all IP in the platform never triggers an
uncontained error anyhow.

For instance PCIe integration IP does not transform PCIe TLP failures
into uncontained errors. They generate all ones data on the bus
instead.

There is no spec that says this should happen, it is just what people
do - c&p from Intel.

On top of that we see that server focused designs built to run VMs
have put in the RAS work to ensure uncontained errors can't exist and
truely plug this hole.

Thus, at the end of the day the safety of KVM and VFIO is effectively
an unknowable platform specific property no matter what choice we make
in SW here. Thus let's make the choice that enables the broadest VM
functionality.

> > > > Fortunately real platforms do tend to implement this.
> 
> Is it possible please to describe what "this" is in details ?

"prevent uncontained errors for DEVICE_* and NORMAL_NC access"
 
> What does "real platforms" mean ?

Actual real world deployments of VFIO and KVM in production that
expect to be safe from uncontained errors.

> Let's describe what HW/SW should be implemented to make this
> safe.

The platform must not generate uncontained errors :)

> I can write up the commit log and post it if I manage to summarize
> it any better - more important the review on the code (that was already
> provided), I will try to write something up asap.

Thank you!

Jason
