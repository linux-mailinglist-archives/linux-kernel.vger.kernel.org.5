Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C597E4442
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbjKGPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbjKGPvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:51:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C22122;
        Tue,  7 Nov 2023 07:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo23FaUOpkF4wnlqeSsznJR1jX3cA/4l1sEt8zzZOkMn+b6EnPKnuT7lnbqqe9nK9YBnw0qmghnfQ889/twDcnF5VJPiLN5pIKXg9iWQnjvzeQBCcZYpjR57D2LSuHwa77+mKfcnmMRekAk6n9D+qPSkIevTijIUwtMP4DvdC7L0Z9gvZh6I8dl9WFoysgdH7ARo4d6CrXRf1zSN9g7wyYOMVhDTXCf5aSKoeWMpKDm6kB2sbTWfdUnKwKoCerMk8PsphS++u0eS2LJK9izEPdPL86m+uPvTFENq2+lJ16lvq+GKguSW4Eip2P8Kyqn2svCXhSztVqL+vN1zvd2yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egAHRgpD8RKXKvrOoKjNJlQW75scjgpNCgMKQwY3rrg=;
 b=YCnAhUEdjvJLlUtBx9w1SO0sfKv+O8K4k5jogpHVboh0vQhuRxbEwee1dlvmbFG1e14QSxznr3BwrBiy4T/hqmk6zQQaeXah7vvNxFmme2ciKa/j5d74iWu4TcZyOMpuZ7oFZMhf+h6Kv9LDTYovltxiYl+gFMUqzv5TIzg7Tx3sYshWU3cRD/F6IlsxF3K0WJSz3S1661eV36HEoKR9bix7FYqEl9H1ObO0cWGaic8k9YacUTWVupO7dRkWGf98pc09JO99ipTzX1ln8BTVIKW+ANkLJE3zMm+xeMzRSHTCN4yjiQHHyVttmhNbhxh3TEowX5BQCakFI5W2WemMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egAHRgpD8RKXKvrOoKjNJlQW75scjgpNCgMKQwY3rrg=;
 b=q5IATktWtJB7FyFoiM8A9G49MCpYaIEBksP7YzCbzUcKuhJPu4TxnTRzZsfq5JEqHcwK8I21NDct2kCF7hCK+6qCNwysBJ0UcRUbWUghabYZAE7XlydlsYSZ2YTjB14QzfBe1wCoYfF/g7S66tG5BZcA7gylxe3AopqvlGpZaNLkJReWVAGAvkz8lcLVApSuUkiYpmXpx2XRMO4wlugjKIZyESlXQBIKHTwms9y2E3Mk5ovlVK/BH0iRYpzaeWzwat88Lr040pqV73Pq1H7IwtTVqL6nrQs6Nw8VE8sZg9q1ExrpVDiPmTv045KRr4I2P7wcZh+9YRWgAFhRL2eLkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 15:48:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 15:48:50 +0000
Date:   Tue, 7 Nov 2023 11:48:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107154848.GP4488@nvidia.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107094818-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107094818-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: MN2PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:208:23c::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d056b6c-1046-48a3-d89f-08dbdfa90935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Psodb0ia8OntSNcE9oyoddbPaUtm05oHNuHAl6ICRa0MlM+ABbO4ZliE1737ocVuzb7RIzm82N3RelNFCZqfkqhdOV3cqX8v55GjSakgnLmHCxGjb73Tbjh/IpqYneGnYLuBhnZDjynDbK6cyFHHHwaAEnagq/6lTXHDMCp01Y1HW+xKEtsUqvZvLxwUEsPP8cj/gETjwWIMk7fLj0s9WzNcTcg/J967b4OBZwJ8THcg4A5cEiiQ1oekL39AURI2La3jdsNxh18ZEbkQ8VenmgFa/i+3JlH5RX71BVNywJWz21aAvgZ85d8fOutlxrbToyuqu6oSbwiOg3mY1vRjaZGzbAL8eVQQDg1zFwzDFmEUVtpnB4iJb15o5jHXnMh3F9kV0xXoLDBsluzQTlEkyaN3Vjt1WYzyA6JXSdsWJbyGJokgsMtfgP1tpioyHL9gX3vdOIz5lg3aV6qo3J1fAumwOb7i0k5hnmdH5lrSWO2MAa7gms3L+wTdygYyDVaFNyEgI2TGyh6eZazGJFZSb9IiwK65FRtyvypTnoDY24ZW5LP0cwj19/iKikCR2M9ChQml4ScUeKj/DoT3T+x2GUEK5lRZSJ0A1UDAYf481lrqUhFYiYSdejs330gn+M6R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(36756003)(86362001)(33656002)(38100700002)(83380400001)(1076003)(6512007)(2616005)(41300700001)(66476007)(6486002)(6506007)(66946007)(66556008)(2906002)(26005)(6916009)(5660300002)(8936002)(8676002)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JWWnT9kKIaZ9cYa7fhaQjijjI7Rd0ayHBePEAlp8KrpDx/Og6z+WjY51NlJj?=
 =?us-ascii?Q?gCbBEKOh5USut3qhJNniJs/HtUQ76Anh2Qe9DN1UtC42jJouhmIXKFdLy9GN?=
 =?us-ascii?Q?VkQZAzftoYXr4VzyjIY4wqxd5V8StTPBpoppbi3GX8TRfmRXQA/Vas+e7gbx?=
 =?us-ascii?Q?aiPtileopLL0HPgZ3PdP/4a+QnMgWtC5yTCleYy1a/c0dTgH6dfj90MJI4KI?=
 =?us-ascii?Q?OsPgd2XFfKv3qqj5165dfQhMNS1bpOxfyJ982oEVHdP7o3T/iCsHV4KtVUE9?=
 =?us-ascii?Q?igL1zgB4Au11/PPwR2MX1YSQN8IFYV72YVnols9mInhYZz+yZt5YQ9T9VLVE?=
 =?us-ascii?Q?kpCNi0NDTR3lFw8/53FO8kSae/Bs4eZeAntNdLrhi83WzQtkquC0TWwR5Ijo?=
 =?us-ascii?Q?lr0z9jyaynmElStUxdwOGjf+sIFoxTA9cfgV+qIeez3kOLwc+LhMmzbkkQD5?=
 =?us-ascii?Q?ucNZN2dHAuofSMkytmyCmaKtW+4XUyr7Y/E8ZhLyMrIeSTI3JayVEY70G3xX?=
 =?us-ascii?Q?1Kc2vdddiU3PEGoJc00v0HB6Q51hZEYHmDtZ2H9rd1hcIBSuwsb+GaqqffGg?=
 =?us-ascii?Q?lHU8O/km6qiDe5YerAAZ2bjzzQd16bW8fhaTYfpdxz7KK7Mewf+RcLT6nGGY?=
 =?us-ascii?Q?HUC1AZJi0JJ/YB874QtP+hOHxg1AYGVfavbbp/YpSwbV0qm1vcwkLVjGlPY+?=
 =?us-ascii?Q?mPEFCfftKSP2fiS2AMhOxsuRLwwecKGBA4AnQSGu11sZVtL9iy6o7/VX1be6?=
 =?us-ascii?Q?bsl4U7s8pzFC+infjx5SCL+0qn93iJN/Zhfyvy7nmpA/zpCDPqnOtkPlIFFk?=
 =?us-ascii?Q?blPYFYzSQ8SJwFTsiEDmivUMdkHbi9RoBZtm2WIOHzd6Vtmw3Vv8W6yYbIRH?=
 =?us-ascii?Q?euqrylajglu/joJSYiRJ4aNXMagE6AlsaW5pH4ZVFvek9GGv0InewCvxP4kd?=
 =?us-ascii?Q?gZJe3kCQXokaKkIZayVQ1Eh1YlMw4ePILWjUII23lJE+usshoq8pi2mdRmOq?=
 =?us-ascii?Q?sgtkQbtEaJ1Vj9tQWTnke7ifB6MkPNa5Ihh4qBdtmmtcxb1mUzwxVtwyrvcG?=
 =?us-ascii?Q?IqeyDIjKbLwT0h/MmB4JC7qKE/zvareGqh/nNlvWA+wUmJbPT3ramQY/GwLg?=
 =?us-ascii?Q?vPCkRV+83FDsd3RdNifcbcm8TS4ynQvJyt2LoUa0i2Jrm073K1ltt7xoZ3er?=
 =?us-ascii?Q?bBhp0175qksXlezdCkSf++eauTJs2Ij1OdyaTYw2F9yDDBwsQSp+BelEiozU?=
 =?us-ascii?Q?VzC4tN1YFfYPGMan45lKMRKLMWZEQ4O63KFckqLF6Zx17AGncWfe4AgxK5vj?=
 =?us-ascii?Q?BHRpp9r/0XAcphuOuY4h3CFD4q/k81ouvspJXhH1k1nP6Io9qpByjTgVY8EJ?=
 =?us-ascii?Q?lJtFReiuVb1F92sJn0j+ou3hYpKWlQfSfLBbYlEMfF1CG6rCRZG2eBcQSsfL?=
 =?us-ascii?Q?cEFIdTjwinr/PGveOhDdr6PEszoRnBuKh2WZik7kRhMLOpRhbGmn173vELeB?=
 =?us-ascii?Q?QU1vtzAIKtuol0s074rb+HOXr8dnpgOnbawtI9LJrVD7u3IlNsOk55cqMI89?=
 =?us-ascii?Q?8DoMwM4tvJOZp3fhWFsc4ZtsLVuRmPcByULMEDMf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d056b6c-1046-48a3-d89f-08dbdfa90935
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 15:48:50.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPtvAeM7ZZ32iVAnsUe8zNDLtMzN8yySHvqOaCwUBOy8lcqwOorlwBLBRIV6FbQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:55:26AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> > IMHO, this patch series needs to spend more time internally to Red Hat
> > before it is presented to the community.
> 
> Just to add an example why I think this "internal review" is a bad idea
> I seem to recall that someone internal to nvidia at some point
> attempted to implement this already. The only output from that
> work we have is that "it's tough" - no pointers to what's tough,
> no code to study even as a bad path to follow.
> And while Red Hat might be big, the virt team is rather smaller.

I don't think Nicolin got to a presentable code point.

But you can start to see the issues even in this series, like
simulator is complicated. mlx5 is complicated. Deciding to omit those
is one path. Come with a proposal and justification to take it out,
not a patch with an unexplained #ifdef.

Again, I'm not talking about big impactful decisions I'm saying RH
should take it internally to get a RFC proposal to the level where it
is actually an RFC proposal and not a brain dump. Make sure it has
logical commit messages, make sure the basic thinking about the idea
is done and the proposal is self consistent and explained. Make sure
the patches and series construction meet a kernel standard.

The purpose of the RFC is to clearly articulate what it is you are
asking to do, why you want to do it, and how you intend to get
there. There is still alot of basic work to achieve this and properly
communicate it.

Training to do that should rightly come from the employeer, not the
community. We've seen some big blow ups because some companies have
been trying to externalize their training to the community.

Jason
