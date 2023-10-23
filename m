Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7397D4183
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjJWVNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJWVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:13:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF28A4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXEprVZ7r80EE4wP24BUEhrNNup7z4UMdkKN0QXVsnH1FBKEQe/GSm31gcHA2vlZEiIoWFGqFmV6blV5vj/V3rTp/542z1aSMbMi4diAJz/l5cfW6N4XicfSfav/wOML0fimBY3At5gA5GpmRsfgyhY7npD7foTl4VAzsPmL653IBcLwEW5Wg5/cFpIO1QyZMIPRoVpasd36D5pEh7GHdfOeEXJlkXyTboWM1fW2THe6ItNcAEftLZIblm86PhBMq912u0FHA/7je3lA0qNu17p5LNKt3MDQYDED9cCqufhPShxq3S/n9CyJSJ72EZS07dYsV5KJUCG0C5C+8IFtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Tocd79HUO5f/BT67DV67itcxJOH/iq92f0MTWW6sZY=;
 b=DaG29gzetOhd1154L42lAn1AQlp57rbvGT/SG7pcdQLe8h+M0GzkDx2lvJg9NJDz1xxHBa/AaJReboquboH6sF7Plftruh2LFdaPfFkKiXSf3MumviuWT8L5y6S2M62cvNp051MaY1cmCIJRKTrY+V2jGq80FmRXNd1qXAxF3Sb8r9bYffsceWqXYeGk1uwavodWVleDGwWrNVL4bgrQuVMDam2zcRPK+c0VEDDpCH/zg7xopU6BsZkRVzpvEF/zryASwgJpB4RW10FFRDh2aZ+r0C3O7gMIu7qPty6Pjr5YK9ZUQUYS2o7ghIdPsZZXaRflPVQzT15zqcVMUU3Z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Tocd79HUO5f/BT67DV67itcxJOH/iq92f0MTWW6sZY=;
 b=pVw2gu6yvByeX499AhuZTs3gddnkf4ROzqWaF2R4Pb6FDiGoX700Lrhl0dMuQXOu5ZGNy2Ighe4YnKsYOaMZ896X9zUyaLo1JCH6SwxIsw92Ak0rddw5rRq8QVecXlCi+KkBa+2Z9+xfEJBM9bycQrrLDpIBnnaThbt5kbhG3vPP/uNJCoIZyzRLsMOxuD4YLOnwTFvSyEy3A/NYeARPGWgsWa3Sbo9ERos2HIa3GK7xozbvlMf4UFepj7en2spydkXB0cBlVK4Q0HfDvg4CxyQGJdXhUq9q5QMJXLSOKt6y7flctjuFloVpmjdi4Hca/Vx+1KtXo1a2TdH2w2zOJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.29; Mon, 23 Oct 2023 21:13:43 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b90d:78a0:f664:ffd2]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b90d:78a0:f664:ffd2%3]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 21:13:42 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "\"Huang, Ying\"" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/12] mempolicy: alloc_pages_mpol() for NUMA policy
 without vma
Date:   Mon, 23 Oct 2023 17:13:40 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <D7B862BC-C7D7-4877-9B71-D29B5CD9EA32@nvidia.com>
In-Reply-To: <8c933f5b-983e-a332-e410-6ee6872f839f@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
 <74e34633-6060-f5e3-aee-7040d43f2e93@google.com>
 <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com>
 <61FB8BFF-E3CB-4C99-8A6D-845A69E4E76F@nvidia.com>
 <8c933f5b-983e-a332-e410-6ee6872f839f@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D86EACED-A378-4159-9984-CA9DCCBBBC59_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0098.namprd02.prod.outlook.com
 (2603:10b6:208:51::39) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae223c3-077b-49b2-a0d2-08dbd40cef91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7o8K5IaRRYczY1z1wDdqAqi4+mtv5IbdLQ4BuixaQCb8lVZkLYbsKsp6slRFjQE/8EDpW1HJFLD1zqmeBwh/GQd+JReBhyPHtmp48v7D/gYYfo/CrghWym1SnakaxZqeDV7EmCGnqYRQ0m09zCM6+CSSGZMfycG+kYf7uo6tG51F2InswRtYFjW2B7yddMYEZI+LiI/F5m9wznpWldKP6hS6idgWOeCLF8gc1tNZzXnjlgO738FCjUhiHWe4pHtuplBlp2IMFbmKbBDS65YU4bjOr3hIgLygoXXd2IOmC3/5NlLRtIv47LF/UdlOu3n5ScgGWzX+Pj13Nf/AVmwd8jffZgeF75JPwC0JlCoeq7svtwSCuvNmllsbs/aDCDyBGHt1SvTAc0OxrBK/jVZsM9Ipds32HWAgjw8nZdku2I+gdbB/LxNNGzuIYm9ZfvlDRtbu/Pv9//HqZQrxsq3F7qdelFLIlr17pE6nLwlV+MSLQzfr+cvqIV7a/pCNnYWGAWbRBvIzKB5MmQ5Qz+RrVpnXJ+zOOGKH+gwEx7rzhXOcyjYyWpWqKCJBPKx5vOrqkB9G5wUvQOoNBc44BNAUtEPv2vE3UVsr0thmHNkavcjkmYUvV2q0wQ16SzAeyjK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(33656002)(36756003)(66899024)(6916009)(66946007)(316002)(54906003)(86362001)(66556008)(38100700002)(66476007)(53546011)(26005)(6506007)(2616005)(6512007)(6486002)(2906002)(8936002)(478600001)(7416002)(235185007)(5660300002)(8676002)(41300700001)(4326008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WpYvQn/pgJOphORmmHUrOlQaYcITOVGmMpJb+uAksmqg6pFSQX539LOgcgV+?=
 =?us-ascii?Q?8cBIXiWXAOURUZGOkzv2c5yzaYvh51+X66j2DgghCvoCz+e0I6XGpDUC7fQ1?=
 =?us-ascii?Q?Wj6pvYwfjJo8AMLNAYqs6qAQcfPCf1E2m5fKPuNygIgIIrCSwmuVgzdvJ8m8?=
 =?us-ascii?Q?7esLiXGsyY7nHbwZh7ftglnvVNgQAxXR4E5FYP4dD3j9c9sGZ0oHAREflXot?=
 =?us-ascii?Q?7U82cgeGlk7n4IQBxxk26569QCaP5fTGhaw3928FO8ECI2RByQdParoLhr2Y?=
 =?us-ascii?Q?FaGTwILycYCtZMg3fuLyElO6MzJXfwKa4sv6qWwRLbLod3pkK/NkQfHhO3Hd?=
 =?us-ascii?Q?Jd6KmBl5Dwn5wgWaEN3VHHPH4c9rVNAbtkLB4v9xDRL7kKZBxzO6TmT0IjGK?=
 =?us-ascii?Q?JBA1nRViz81vKnFfr85Ed3vLYPHJYPICZwNnUDXSOOnZ5GRPOusEV3vvxVV1?=
 =?us-ascii?Q?6czQlYEBIVZjvrM8mKtDkVDYq1O1PWQKcCNYo7ZYH1VJLXLjFYx1D9KhY8by?=
 =?us-ascii?Q?xlQbRQlnR7zFD/0ESQxiEa6onWZzgXhOc+5IfVzZ4ed70yKrU/VcgyZDC3gO?=
 =?us-ascii?Q?nkR3/T8k6Llm1Lx7ntde8OqKMCwc+Z+YfR8LXqdDAXtlhufgAp8hlrpzlhbB?=
 =?us-ascii?Q?eIhOTYUWxSROcnFPbB8hBNVU31E7cAIsu/rrEVjdgYXEZGwz89zQdcs32+Rh?=
 =?us-ascii?Q?1Jg75hde1XkktlbhXmfSuW+P9YpF86SxhJTORpQ9ophWKrH0lHRJ/qeWQ2AX?=
 =?us-ascii?Q?h33k4yuv0+Uw8a2NcWKbz0aSwddI752bUsm5yBLAvoCX5ysk8xB4VF7RcepM?=
 =?us-ascii?Q?NuSse6ueuoi84tT9vJSV6F/A73j98jbrsYFz5F72UD2p1RfF8avi7YXXJbZP?=
 =?us-ascii?Q?zHWHH5ag0UAmclfK+7+IBrfrkLsfcU+z7I9HqsReWqX1Ds9VOxHGAOpQxMX+?=
 =?us-ascii?Q?aidoZhbxHFuTfSghAgDtXo2KRJ1yet+T3mvCOUq41NGS2odYBNWXunEUo2ne?=
 =?us-ascii?Q?sSRtQLzzQYr2q6hUp5l4mjy7PeQIasmpk8ndB55YF7QEql/6ZLdslVaHDBKR?=
 =?us-ascii?Q?vq+ttXB25iOV5tf18/kHHkjDlB1bSeKeL6zRar4N04geJjbKZJqjeIV+x9WO?=
 =?us-ascii?Q?BNpq++EfSKrMJuSZVw5oXxADKsw67xj20JkzGxqiwT7wTS4UQJEpRATSpUMX?=
 =?us-ascii?Q?jGH+ZTldaMNPf2JzzF45FVvt1opuCOwco9PFkRPt47MxQHVdqP01DeeAU2hp?=
 =?us-ascii?Q?CKKgI2cgbuLWgvMDh71LUR8QKv5jV+4yr1xUT/djwhmkzVwBXyu+xLnWotno?=
 =?us-ascii?Q?tp6Y+KuU7r0XCTvSr+rn4TcGmwb9ZtIyocM9U4sSfoxPknxHXf168VS7Y6G9?=
 =?us-ascii?Q?sWyv42NK7YsWlqKZiXhZSgI4Hro1N2SO0dfTHIJUxx6VoZoagnlMZ8C/boxk?=
 =?us-ascii?Q?ReGb9lPrp3fLv9U2v3tTfbNVJKVtxQcVzVU2CF6DbpHdlXWrW86lbDeXNtHi?=
 =?us-ascii?Q?m95iaotw6zlNv4fkHruEbd/esBshdhMNp2PHPLHBfPsEKIyd45DFgy3Mbn/z?=
 =?us-ascii?Q?I3RVsGqPz6pe5nYVTcs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae223c3-077b-49b2-a0d2-08dbd40cef91
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 21:13:42.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz0HYUE0UBQvwFNQ0YBlgDCTMSyhlsQJpx7zlNdOXHGzWc7wlN0F7o3tT9UZn/Sj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D86EACED-A378-4159-9984-CA9DCCBBBC59_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 23 Oct 2023, at 17:10, Hugh Dickins wrote:

> On Mon, 23 Oct 2023, Zi Yan wrote:
>> On 19 Oct 2023, at 16:39, Hugh Dickins wrote:
>>> @@ -1170,6 +1170,15 @@ static struct folio *new_folio(struct folio *s=
rc, unsigned long start)
>>>  			break;
>>>  	}
>>>
>>> +	/*
>>> +	 * __get_vma_policy() now expects a genuine non-NULL vma. Return NU=
LL
>>> +	 * when the page can no longer be located in a vma: that is not ide=
al
>>> +	 * (migrate_pages() will give up early, presuming ENOMEM), but good=

>>> +	 * enough to avoid a crash by syzkaller or concurrent holepunch.
>>> +	 */
>>> +	if (!vma)
>>> +		return NULL;
>>> +
>>
>> How often would this happen? I just want to point out that ENOMEM can =
cause
>> src THPs or large folios to be split by migrate_pages().
>
> The only case I know of it happening was when a file was mapped, then t=
hat
> file truncated (cutting out the source page) before migrate_pages(&page=
list)
> reached it - rather a syzbotty thing to do, not of great reallife conce=
rn.
>
> I won't assert that's the only way: I've a ghost of a memory of another=
 way,
> that I can't quite resurface, from a long-ago version of queue_pages_ra=
nge().
>
> But in the end just didn't care enough about it, because this is really=
 just
> to save a bisection point from crashing - the possibility goes away in =
the
> 11/12 commit which follows this one, which takes VMA out of it altogeth=
er.

Got it. Thanks for the explanation. I should have finished the whole seri=
es.

--
Best Regards,
Yan, Zi

--=_MailMate_D86EACED-A378-4159-9984-CA9DCCBBBC59_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmU24gQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUqoAQAJFk8tmZNpx6vUdhzE3SbIIxSlp9fk6bRe76
/zHj7yQFMmtQjlOIbO12GfySnFFPrwSqJruMwda0NVbXWMl/7QP7Ehe2PlADhjHz
kt2bLm3/dRJxCcRXruFouIMJEtl5VV4mhdzJ8+mwUBSycdCgfUA3LIpvwQYfuLoN
CR1EjsXNsQqjPIDVdRsZ4y7ofg9SToLsfuTxbh//h9fcN/61MZ+FzXtUqvB00mqp
j6TUPx7FGf1KWCnO3WBfCa4ljbV0rCOK2+x+OH/TUMoUkOoAXYKWCB+Ph3F/4zOp
YQg9g/yhLdlYEKRg91DaRcvxTMC/CMg5F9oY8x6BgD4KEJfPuTOEBsjFTWvRE0n1
UDulZOjIpzJaHPYLNuRv81RS2H3MJA2pJ+4xZhTT2uWMmfGdehcEJ3dN3rR68AWn
9X90z6FEZQR9pfEOIzKlHorDaQd3rWzCqxIJmI39GBI2SVyf6al6tZeNoT2WxNA/
PwsFff1dKDDTGAYN3RuYQYvOBqPbzVX49TizOM9c3StPmNIGirtxCRlCQNoDZCeJ
w62Ov8zqs+EKBEJmdLX1lHyxFE5Lfx+0H4/QUH1lkTuNq1Pafj1sd1mXAYGnKum7
l0weoKJaDznjIHY7bZeW7fEpK0+8HrgboIdz4DgmqNCWXJlJ5VyAxlqYA7l+uAIA
NYzV3KdT
=WZrP
-----END PGP SIGNATURE-----

--=_MailMate_D86EACED-A378-4159-9984-CA9DCCBBBC59_=--
