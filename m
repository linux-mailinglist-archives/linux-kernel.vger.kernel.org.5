Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA37E7FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbjKJR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjKJR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CE13823D;
        Fri, 10 Nov 2023 06:00:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgTZCNJXZz0NKEi4P9XVIAwEzjD0pLbv1iOy6is4eJ2arD0rXLNXJxoQV0+IuDeqWEhRAhXSPccc2H6jPcGLudmrjIph8acQh6/3A7O0ty+EevU/EZsdBOArHl5W82eRzK8Qmzzc5m0LXP7XvJHVgpXF1zXgB2rMek+F8oFgiWtIoMgHT7QL6mmccF62KgkPeq6u/Zvtz04ppqu3CbD/uF4Z7B8dbo15VqlwmxFpWKAfEGA87gkoEFiRByQma3QdsaXHeBVrQxxz6Bh8lDHoaY7NF4jZh2bv4QCwUPPqB+IuweMn6WS9Lk58vSRc//b3OZp88j0zuk83muIEoivylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuN8PfpIeT9UnXQZWeBV5ZzsURlpizv2l5Stj3rx57E=;
 b=WYqmcfDqK29+DKz/aaoe1FmcbTOrR5uyRqjpnfMf5GCwchOerMcKoMI51dfbl2JdlFrlW2xWK5ruJL7d2fU0u7leVohzEGAAb6f+xxMzPqKvTgIV9VzAGt0LyvlqR0NyPYUDoLAJgx5coRlTGq3XlP4CTHJLes7TMtm1RYCQw2przS2Tki4ULfgg/V1liM25QiYKL+UMZ59GNNMGZiR631ZRvfl7U65sm74XWje2cwjOonO/rIlwVWd5F1g+ajsqGmOJAHiHp5Wr4zpiSdiLfePsZA1ZN1ecMCku9gx6JMiCPpjz9lqw311avzJo9UlRtqqi+GdqLJ8kb+Qo6SmOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuN8PfpIeT9UnXQZWeBV5ZzsURlpizv2l5Stj3rx57E=;
 b=lScjdRfS8FPQ80J1PIaSYpVQcdD+5syAcT39F6x3crJdGUwXE3UHEAa5nls+F2ary5wbZerjwMNLvdTsqwd/xuX9zuraLDNzF0mK+gjYMCmshCtq9KnC5n1I5DvyXPcp2ArPl2Q5+XSX3RwlKPR8gHfXD0CSufc66C12blBuOGcf52BTPioszqU3lI9G0nNgRlRyuGa1TUDnKxSEm9iPy2K/NknzeB+k4fqYK6Rgi/i0oeUC2H/jJqH0HVfnleH9K7TBYgXsQzDgtrOqqv2b1/7NlyCMHNf9de+4Mdyfvo224gSDr/NKp7dJhatKgi5OtOo5Uu6xVMkeIJ+fFv7etw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 14:00:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 14:00:09 +0000
Date:   Fri, 10 Nov 2023 10:00:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231110140008.GM4488@nvidia.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107082343-mutt-send-email-mst@kernel.org>
 <20231107141237.GO4488@nvidia.com>
 <20231107092551-mutt-send-email-mst@kernel.org>
 <20231107155217.GQ4488@nvidia.com>
 <20231109183407-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109183407-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA0PR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:806:d1::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: c592bc35-e77d-4b3d-761b-08dbe1f55a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bcz46YU+zSdzi8uDSImw1UTnF+13onZuk8iw7TBw0aDKEkM2wSVUDCHSXLIelPvDJvdB5qOrr9a5ebDSYea3Rtu3goDeGnAcEiuFdiR6zqfOr4OZe8dHpxQHKkYlgdJDvNmCIygGG8eRDwM1y8J0h4ees4F8Hai5on2DO40zjVr3U+1c81qdeCDdIYAY7wOLxHi1+JfjDmucoSqMfOuDdbLItCY/YUSYwCaCaANkXiO1z0i+ObYSRigQcIbCCSXMhLvx+t+ed+rTSjksykY9X42kiyVdeeuyngiAlEyKUkKIcnBowdeD/0tAdBJyBt+sN5Wr6AkS0LaQa20D13oExLfcHpwed7438BN+OaYJEwprsSDah5zj3wriy/IpXji7p9tpEUM5bujgqbw4X8frKrwM1AuIidHGtehdiOSoArWP6/JQ5/qldEVeRl5xi/iaW+9+3TvHaQZI9rxBZW8/co4RYJlABooJv5kXNQBf3NUOfFDCQPLw8qMJ9Hcj9xLHjbNzxO8QwnA6j7GGSRtSBs9SWkcDdJljm17/ImsYvKvx361dLcIiCQkm/BGph2iNgL/i6ZmyXtZ1k9DUfjPcGozTFPwSFn8wGQbgpQaWv49lCeBRdZ/vicPE6zISnBd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(478600001)(41300700001)(6506007)(86362001)(6486002)(6512007)(2616005)(66556008)(1076003)(5660300002)(316002)(8936002)(83380400001)(2906002)(66946007)(66476007)(26005)(6916009)(4326008)(38100700002)(8676002)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cnfs7gXUDTUbx8ko9J80GNhEIvfdAaHEa+jGol57iXK/YYIhBwLxO9BdNEnL?=
 =?us-ascii?Q?/bGH8Hd2WOi04VilmPQ8U6pyVlfz6XVLkeEdkdC/8fqYP03BTQJ4QP1yfwG/?=
 =?us-ascii?Q?ab53qLsibCFbLb46ktGiEjBftzzYp0zDAsPGzHZ3LNOd+0AO4N0s3v1w/Xj0?=
 =?us-ascii?Q?smioI/66zV6SP/YHdpOsfJIDlxHhSWapmpMXqUlQEPMmYpwCkg/1rFlYPqf4?=
 =?us-ascii?Q?SW6TwO76mIBioisoKg3ezH9dVP7MBLpwUyBIqlSR3v7vP0oRC/dt3/GE8tsf?=
 =?us-ascii?Q?oTa2EPLdhtOR50Q+RDj6fdA5NeoGAp0H6nD12IysQZyQ6sPF0mqa73/Gy3PA?=
 =?us-ascii?Q?m7S2F1hAm3XFgHjNM2Ab6ZfsBLXv8TkED+X3ksMyxGnalpHY+Bhn1VFm2vXU?=
 =?us-ascii?Q?/FOAA8YM1hUqWwfAbdbmOI7zc8QSInQM8QjUlJR7/pnNwv2Y/m1FeT9zMAPE?=
 =?us-ascii?Q?HwhFo4e3+IxaeW0wxXHFIkpLveHdGw8AMlVVO1qYsilhxNrwezpcRv6CKsuP?=
 =?us-ascii?Q?io9Jdf6bhMXUlt4sLMMkrrH6HKGZJZfjLHrKnBeDCNa98or8xkgT3ARlcwbz?=
 =?us-ascii?Q?ydGuZmZ1sqpkl6Y5WmGI7JLAxBEeQ06H3xS+BMlSD5jF1Do/s/XosHUiHhRr?=
 =?us-ascii?Q?UakHBJppTsOdldXC35ZPR1S6MxkZPpHbrexGtoXUGMSJIr9EjXjfob/kPcVp?=
 =?us-ascii?Q?V+i3MUO5w5EOQoMf4TDVhYIV26uEinFgntjybEuFRK2lXHaBKW/hF5PLxeVD?=
 =?us-ascii?Q?43qDwNEsasuqfl+ewQPERMd0sBg0LfYsgqV98WptCW2WHf74kdukyPxnybUn?=
 =?us-ascii?Q?fdMEQSSetMMEG+8wWMSTqrxqFY0u+UpD312phxoyLotScXLyZjilEYPeVC5d?=
 =?us-ascii?Q?NnACjQIwNHoyqA0GgVJheXWwqT9LuAYuCwoOxnIy7LBjWD0HddoD0dU34Z03?=
 =?us-ascii?Q?e9ObFqN7O2Go7u6wVXc1NwLyrsJx0shJcpKNVFvo/o1BTbv+k+5dxQXYlpP2?=
 =?us-ascii?Q?5mANq93kanbyhrDFwtFY+g5d4/H+IMcmCgQz4h2AA0YPJGKoE21io4cUqpSA?=
 =?us-ascii?Q?jkDzVjcpAsb2p36cq2uBzjGw3woBL9BgTLvjT9H2pjTg7WtLi2OlYq4IfXyq?=
 =?us-ascii?Q?49aWSfPQ8X/uZothNaYM9tsMW/T8lrAYj+NukNF8PJ9pE+qGvbU5OS1vuZuR?=
 =?us-ascii?Q?EAh2IwLx77+d59aiq+z0ET9yMLwT/IQdYalBmDcUpG4Whuapi3q4BUPwjKci?=
 =?us-ascii?Q?yRpfBLma2kPSoM/CLLZEb6QtwwqGu3WLJ4TQ/xbDsKltMXXNgFFr//kK1Y85?=
 =?us-ascii?Q?3hAI1JLim4lRtfFOQTcMKuxSXIBxZODRpYoWk02XFUOn+jtIDl3LvgJ3hJD/?=
 =?us-ascii?Q?7eySSeQVukb1wTUlky0m4GN41rmZ3O2xSu+gqBkofGJYVvZyhLkerVnU3LFM?=
 =?us-ascii?Q?TNH9QSWw/7N0th3VVO1XbUTiFKDq8qhaoJyFAUAj6DUWW6tqkHP0xqS5b55H?=
 =?us-ascii?Q?M5nmSEy0uOWoYFzYI6NssWvgE8R9EPisyopQnHhn0XcsQIfMBceRjxEryQob?=
 =?us-ascii?Q?IIoxtxifT/UHqInmbu4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c592bc35-e77d-4b3d-761b-08dbe1f55a00
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:00:09.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vwFBlj8aLoQatn/4xQP0DWZU3lJamWSMOYDrgGA3Pd3kDasGatohQvm1xkWANkA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 06:48:46PM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 07, 2023 at 11:52:17AM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 07, 2023 at 09:30:21AM -0500, Michael S. Tsirkin wrote:
> > > On Tue, Nov 07, 2023 at 10:12:37AM -0400, Jason Gunthorpe wrote:
> > > > Big company's should take the responsibility to train and provide
> > > > skill development for their own staff.
> > > 
> > > That would result in a beautiful cathedral of a patch. I know this is
> > > how some companies work. We are doing more of a bazaar thing here,
> > > though. In a bunch of subsystems it seems that you don't get the
> > > necessary skills until you have been publically shouted at by
> > > maintainers - better to start early ;). Not a nice environment for
> > > novices, for sure.
> > 
> > In my view the "shouting from maintainers" is harmful to the people
> > buidling skills and it is an unkind thing to dump employees into that
> > kind of situation.
> > 
> > They should have help to establish the basic level of competence where
> > they may do the wrong thing, but all the process and presentation of
> > the wrong thing is top notch. You get a much better reception.
> 
> What - like e.g. mechanically fixing checkpatch warnings without
> understanding? 

No, not at all. I mean actually going through and explaining what the
idea is to another person and ensuing that the commit messages convey
that idea, that the patches reflect the idea, that everything is
convayed, and it isn't obviously internally illogical.

Like, why did this series have a giant block of #ifdef 0'd code with
no explanation at all? That isn't checkpatch nitpicks, that is not
meeting the minimum standard to convey an idea in an RFC.

Jason
