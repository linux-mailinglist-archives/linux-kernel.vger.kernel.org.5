Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E46F7E41A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjKGOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjKGOMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:12:44 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C798AC2;
        Tue,  7 Nov 2023 06:12:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3jMmC3tpIZ8prSa4EohGwxrE4VkRQBK25xJ40qZWexs5cW9YFPgxZrUhBhKyd3kelMAl/dBw7KqJf3boWahYc5mC72NfZTQhGr60yZnNHxFWsr/NvUSdjBGdPfgUhdDe9/zoRxrNb+iEFXarAMbrvk990g6ziNaF6QW8Fz+oZ0Kqyz81MF8ewHjsCbKaEgVJKrB/K6yxQmbKaHltBWaeGrLQrv4ZLOqadTneseBY1F5driNyi+MfRsqHJIn+0MCCGfbBzExOsxmpYUOQoGmoAu3+LCblkNglpXyoFhft8SA7H9NiuXBnRxhzMTRaymf3XTtupFLso48dykQQnNDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT3DD69R9xNQi1GcHmXwiLYetj6hO7ORkSUzN5xGp8s=;
 b=MqLb4ei6q4Za9PvdhKQN1jzwDCBEfw6nAg0couFjtIPmF0hxoRJC2s2RMGJ0h3nh6V7CPrv0CCXq67aWBAaSo1tWWz/1Z4WC6cuyRutdvFE30byt1OG60pqM25sHz80pCPW7RmYkcTzU/5x7FZ/kMxQPu++eJbQKw2ccyKxhmtw31s/fmZnfqD73Ey98FTsZtJ8QEN4UJa+QABNdB61XOQGTR3AbgVnYin0GRT4hRmg3MxxxIAkxnL/voj7cgwdelJewG3lk+4L+IF8sQshuOlt+cOv5bjoMOlvwAyXiT7WVQmWrEmHwsksWxXyVXVpK8BZE8KRtlBY7rd2C28vG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT3DD69R9xNQi1GcHmXwiLYetj6hO7ORkSUzN5xGp8s=;
 b=J9fogmrCBPX4MdL2amRNSGqoE0KAvNEl6ZemuIH8C/gxPa4Muxp93JaBlUmMA87YWPIDHyDLYZiGRtAH35Ph7t7JQibzhhsJm/+LoynIjmlLpPRwjdk0GCh4Txl+4BY92eMMgvJPufmJb9WtOestOfY0ah04w2eH7mRp7gKPInDiwAYXo77mf28W6epNejh2joBPfr31XgT067tly0z6G3EdXR6i/AKvMKlc8S4hUHW3SJMCKwgkAXdqkjUPH5SueJx6b1Z+RutHvJF9VHz1lTxYZ910G+swfFFNt6rE9+y1c90sKQMYOzMV7LK2jitAUo0af10djz3rTKvAiT4uwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 14:12:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 14:12:38 +0000
Date:   Tue, 7 Nov 2023 10:12:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107141237.GO4488@nvidia.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107082343-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107082343-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: BL1PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: b97d8f91-b230-4548-4d03-08dbdf9b9912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McdDCa6yW1xw9wx3Qq1AYV2sTw4rhnNdYNeXvcgMYWvL8BwLeMXCrDQrAMZmF7WmE0xnNZOzYxEDC6rj1W/DLb5zt/1LYMI0h5Xx1bd1dBA77OcTLASfCZgo85cbnouSjPVRAn7Lf+Jdwr73othuFedAEbzSnlzl0XjjQ93z7CRYusW7fF1evS8zOTySEwqYOlNWfzCzso6C1ELIAJ/Y/eq8Pn5YlOQlo/N/PqgYspf3ArT8NZMNCrLKUYlACBRB6T4jpjg36/P+V2qGHstyGb4TJ8UCa9/NoUyzUVHFnjp3d4/i3GyxG6220aKHgLq7ow6d3OREVCSiBtDHCL09Q1sD17PkWkRoL9infRvuh8bJDmL5L02HRIHo7ef8yRq1yERGXzaj5OfwZ5uPPK354l0humk4xK3iJdYR2gV7oRtr4jJ8k0g6Tgg337BF0HQ1MFC/1qi8q2Uyujdws7tQyVAEJbIBEG4amua56Dt69mQSdWSEwJB4baaEiCN+R5qTIscmkleRGQ8XywoPnW9WgAdiqebZJRCwQpcBB/ZGa8gJdnPJjgOFilH/2l5u9ifV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6916009)(8936002)(8676002)(4326008)(41300700001)(36756003)(2906002)(38100700002)(5660300002)(6486002)(66556008)(6512007)(66476007)(33656002)(316002)(86362001)(66946007)(26005)(83380400001)(2616005)(1076003)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oFD5t+/c5UeOtQv4gD1L6SaROgkBNKRRkrfH4RX8wus1oY0YIn413qw0FsJw?=
 =?us-ascii?Q?nBun3kr0Ewsb/wyP3/UwWXXJH/68Wa3EB0+F/3SHeDUPVAaeZWlI5Og6Mljo?=
 =?us-ascii?Q?3CaQ0Iv8gcscq1cglOz34wYpf0jUtF+FSY7eJnABBu45wCDLpRUcpFMTd0vS?=
 =?us-ascii?Q?1QR7CAthGpbpBygFOpFAtT9/RXftDzNQDUEc8jW5LFXL5kXfc8voiSLwwjUd?=
 =?us-ascii?Q?sjAFhqiO/z3tF9xE2WxsvF2G/y1YY25kym4Jj/BOlwsTN88Q+4uLWi6YueOw?=
 =?us-ascii?Q?+2vLuKC6WdTOnk6sC5WEbqibhGp2EF/G9ZZ3iBS4JmUChNzujWbBxUGFmtT/?=
 =?us-ascii?Q?VQ1K2qkPNijrOgYAGpqs/05vAEL5sTkiufAryajGLXp6xNHEIXIBv0uxL6pz?=
 =?us-ascii?Q?Vs6zhRowpKV30XHGpu2QcMCj9BwjTw5QdEEjY6sQmabxC6s8OR/W+XT+WWQq?=
 =?us-ascii?Q?D8lyHLTUa9OWqWX4lpk47bxiZ1glYEbcl35ivXUsCjz1wZHM04EW4YXKBSn5?=
 =?us-ascii?Q?LfkXwjJ9xljyvC3QdQsl3N3iprkOpJqbmr5/gjq56OtsTIAiRmlslA/wsAc+?=
 =?us-ascii?Q?1jSNkH/lEgKBjQFqD6G3a7mKapZ8aabkRuEwoVwFgPgE+A53xAwFGTnzaumg?=
 =?us-ascii?Q?aeNL91jvVJJqJDcK3oeFtOualwmPJOZQtwqVfF430bjzfDNm4/oZlM3BxgfB?=
 =?us-ascii?Q?UDtwvsA9RJXyja8ogZ5qilxjw+vSEen58UvGPDelHyV1MEySJVKFusvTlpkA?=
 =?us-ascii?Q?CHpHFX6J7Sw7SR8JVhkxP/C7geX7KihYvu4f0vUhd/5ha4W6DBYRXLHcShDA?=
 =?us-ascii?Q?2Tk8Wuu1ZSTN76cT3I6RGvgVKyCUoiH3TfMNhrpBhBIZqqCf6y86MXIQXiJm?=
 =?us-ascii?Q?+Hh7SgWlxIh5YdWUUbLA0uKq/3cURFNMARFFwDG+TEbPVBHXuGsxbKzx96+6?=
 =?us-ascii?Q?f8Ridh6p2w40NTSxqJCk/5bZ9PYlhB8cHIUqWZgtsGd9E7D2FpJL78S/48g8?=
 =?us-ascii?Q?tUUtYpMCeY/keOJCb/wYIteTI7Acyj9mSjatA/Dc4C59Fe3OaYUWyhOnsSIV?=
 =?us-ascii?Q?cMOppHxkedB+YlERWs9u95tl1ZKfOOZxqTqQk1i9oCobVArPnk3G/AUVJROq?=
 =?us-ascii?Q?sUIBcNG0NrKKUy9Af8+8gXTVbrZ0cmFxhCEROGSrZPCnGVVR1aevNtuRdCN/?=
 =?us-ascii?Q?7dIDxKDf02bqBljJP7qAaOpWxCwc3qSJEoJeaSDLmSpye/bpbfc71sXMNO0v?=
 =?us-ascii?Q?R/06JzBhjLxMSApfpaimZq70iMRifn+YGpxmV5jO+8m5V2u6N6KXu0NVZU7F?=
 =?us-ascii?Q?Z0fYOy5Ww3kZLEq5odmgH8Ug3xuCOwYxooBFRg7ozKaW9n1zKXwjVrnSSLJu?=
 =?us-ascii?Q?+YdEq7iDJopYGmn/fRsaCTABE7vYp1AksP52oJ6Pqn4Q82craosXc6qS8m60?=
 =?us-ascii?Q?kGCp6TKRR/2Ok7Q6j+Rx9fMQ30VErdNJ5qGgFl1dOp5ld7iFfZ22Q8ARQhiZ?=
 =?us-ascii?Q?K1ZwYptA0Un8Wm+OvnE1sXHULaEVs3LCYTrOu//tQEX5xapOtAt7pjsoHfsU?=
 =?us-ascii?Q?mPrpy4vxG3MiaxFYqZ4p0NX6rgQY4CJY35M6AIt3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97d8f91-b230-4548-4d03-08dbdf9b9912
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 14:12:38.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dGy5IJRwqylA4G8oSOD4k9ie3Z6iKs21f6KZ3exrCMQvfR4hihnG8K3Gy2AMv2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 08:28:32AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 07, 2023 at 02:30:34AM -0500, Michael S. Tsirkin wrote:
> > > On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> > > > 
> > > > Hi All
> > > > This code provides the iommufd support for vdpa device
> > > > This code fixes the bugs from the last version and also add the asid support. rebase on kernel
> > > > v6,6-rc3
> > > > Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 
> > > 
> > > What kind of problems? Understanding that will make it easier
> > > to figure out whether this is worth reviewing.
> > 
> > IMHO, this patch series needs to spend more time internally to Red Hat
> > before it is presented to the community. It is too far away from
> > something worth reviewing at this point.
> > 
> > Jason
> 
> I am always trying to convince people to post RFCs early
> instead of working for months behind closed doors only
> to be told to rewrite everything in Rust.

The community has a limited review bandwidth, things should meet a
minimum standard before there is an expectation that other people
should review it on the list.

> Why does it have to be internal to a specific company?
> I see Yi Liu from Intel is helping Cindy get it into shape
> and that's classic open source ethos.

Big company's should take the responsibility to train and provide
skill development for their own staff.

> I know some subsystems ignore the RFC tag but I didn't realize
> iommu is one of these. Is that really true?

At least I've looked at this twice now and been disappointed. Neither
have been a well thought out RFC, this is a brain dump of unfinished
work.

Jason
