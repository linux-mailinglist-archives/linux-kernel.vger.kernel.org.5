Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A799476F7EF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjHDCmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjHDCma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:42:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE63C28
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ednuF96ktvksvpG7E2a0lv1abvKO34ke96XnLCqQ/s5tOzjNFYrmEc2Oww7zX4cDMFLAgGwBJXz/wFUvqlLMsSW5/QBN+I7inkpT/Q51JuTACM0MjcbrS5qMbLV/48Ku0oUvb5Sf0BO6eXbvEypfDQHcnt98UbkLo2AiNpRlTUrUCBATJ5d9pgaiXWWS2jozbZMlZivxhMyW1hF3/pHrQnTjPzBsFSJN70PHovSqeuxuT1/lHi0QK9qfpKXLsykk7ay+tM4Hglr4BrZn1/+mkvIJi6Lc/pwbqr+fX3j/BFOh0IpSd4tMbHzNOdYa1T9R9HX3bAhcGlbibujyhUCWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/wCgII4XUFjnDs83TR3xumiWJwu8SD4CJBJ2xhrOUE=;
 b=Ef5K3qQVJlWemOFQsmFGK78873ZtqeTWJGcGiLtHyXISfd5vNJz1dGrpx8O8eR1p/aQClkNvOAjH8wQw5hcElwl4VSq6V5/jMWHyH7s/LqH1VwuWjOBTjSvxshKEXVSC5y4wRmMpwF5FJ/uzNRAlsnwqxXrmuIO8krir4A5G08Zm+6cIlKzoG+MFaXiM+n47iSArtysC8IpaFYImnnHGeTyqpxmhtCVuYNOZzcSalpMt6T1bsagoijj9r/eQWVOy8col1NFASCV8S/4bJYE+TfT3z995dmOleoVbtW92+XlNnw8zLWCZ0bZR9fJMWpHKVJtVhGwobO/nQ7gjJBEfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/wCgII4XUFjnDs83TR3xumiWJwu8SD4CJBJ2xhrOUE=;
 b=ULnBWWeQIwzmWWLTbfWPHzB+lOF5xL+WjUU1EFV3JhaZkANmAB2Proa97epTwJ7S7OlHeOouOHDR+ckA4SeM7Sod4iVKyfeqUM9B1jxYOF1KCHxjS6jvTYN8TnA7ESWBksTmp2s3TM+usQ8In/RSn7jrI74kh+kpQZ55qTx+nVE26778Sv0n4BOpcnW0DoBv4Eoyq++wcJtyY4xuyOPYgSEhA5Rx1QPwQGbfJl4mMITktqBgqY57BEmwhOBaqnDfeKZih3V+2n+PpjdWVQcPpitN0ef9tjObyzziLTBM5x++vtv4SEpDZdWhzilqJshQe66cyhHnUFrSxO8TIZAQVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 4 Aug
 2023 02:42:25 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 02:42:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Date:   Thu, 03 Aug 2023 22:42:22 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
In-Reply-To: <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-2-wangkefeng.wang@huawei.com>
 <ZMpKYfNWA/jNgEuL@casper.infradead.org>
 <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
 <ZMud3RreEpsvFKuA@casper.infradead.org>
 <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_98C5A17B-E4BF-413D-93F7-ED1C12BF55C9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:32b::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 119a0b2e-1b80-4ffc-de7d-08db94946f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STRummhs4X4y0BiV8ulnIENmoc1Xzy2QkRCf9Xx5/e4Wd3KDkfKuMEiDuggj9iaSYeg2KAjF84NVKY+2SfgNad4xvwArWQ8+VZ0+NXtJ2+tjVSIGne/tYLbmZo7lx+ESu8s1yS5N9lYNvXzrkMuf/9iijOBOx6wk8qEtXns/D9JbFd7Gv/4zfo2rVAte1CnVbipIyVHjbSVUkIyFk1dKPyqzMbj+bfcXWbLEnFBhyX+8I+dF/314D9qMC0fFg2tKZAAIY0BfO2U7oVkxMCarTFrd0CKQud79rJPoAoU6WW3i7xiYGHHYelMqkLxHaAGaKfeqDYw6auqhzu0SfJawTv8w3BV4eEsJFOGOssIxjleK7WMtcJpr6buCPim+I5Na1G8nQWqgV+k6nf/Q3d3mMRiS4SZ+OGxgU88SjTYNS4eFzLVo3SPFfA9rzOyS9IqWS0b+I2PHAR0rE0RcLfTpm/ucWzdKgVcBvINi19B1UoU2gesBLKA/Ytgg9Us23AMLzdmo+EV7XOBaLwXPR2Cd2/zjNhZrrqVLA3nY29diAt00rMYi9HmuI5W4uEYdS3KUquF4N7MXPNNQax6Ncs33pXTwxpdS2cmejokv2VLVuB0bsCsgj0HGKBzupOMDKqwUlDxJGcL0SKOrPB9isaFIPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(1800799003)(186006)(6512007)(6486002)(36756003)(53546011)(2616005)(6506007)(26005)(66946007)(54906003)(38100700002)(4326008)(316002)(86362001)(66476007)(235185007)(41300700001)(6916009)(8936002)(8676002)(5660300002)(66556008)(6666004)(33656002)(2906002)(478600001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ZtUk2K7KA1OxGRqIznx6YGWZNKuelS4HrRZ3PrTuiwPiUpN0WpvtxQJRmDk?=
 =?us-ascii?Q?mzzzTnPZ0JDq+gQsNSVtBPZiGdPtVX9fG/DvINKShTOlDhFrqj712ctMCmuZ?=
 =?us-ascii?Q?818Vgt+WhJmxfKD3smJuhfzVWJVFzPweGkhQo/izCnD2xX/ZCCUYtIDgdMLR?=
 =?us-ascii?Q?O3ykrky/NB2uVuYfcuIloZvueqH+0bd3WfvL0p86pSpgwPfp5bluKfvA12yY?=
 =?us-ascii?Q?x0Gyn/yfrfalefUt4rOWdnvRzcJkkGFzfNNr+/owHO6y5bJiR5X0NV1Jdz/j?=
 =?us-ascii?Q?cIpL2kvycHHyLX3UwVGlxVk8RMqe9Z6Bs/LXcfFoxrgF99hyGityC6dSGLIn?=
 =?us-ascii?Q?iTc9v/TxYD4DU2nH8+TeQVUAEOCSU0aWeln8xryAvcnW5g9JGR84rtVyc0VU?=
 =?us-ascii?Q?RiuYP5cI2k3MuXH9/8ahIw2NN9cpHND7Q3sSyq7FoNFbCmYfvm5RdPAFIIn8?=
 =?us-ascii?Q?nM6FXleD9gb+0dXmk2Up8Euqba3B8qniKiqh2p3PuDE/PLRDm+eB7mJPoWMN?=
 =?us-ascii?Q?nGPc1V6owjxADdk4AV/TO7fU2QIK7VzeCDYfPhij47I4FkzPWHZhSYPrB6IM?=
 =?us-ascii?Q?Cz2ktHpPpNv67bBDkXFTlMskttznFpSJT1FVG5Ti6C+63P540RHdqTP0gmyc?=
 =?us-ascii?Q?dOXwbL3TviH3+OKi+tf4IuproLRgrRz/UKdRY79FkNVFXK0T2mFlO6wUhHLk?=
 =?us-ascii?Q?bTH/f3buFoXi9yQFxkHYk8swclaMV8yg4+cb4q8r2Tr7XmcvxjE8oSkFYT5J?=
 =?us-ascii?Q?1M9X/fYqORG2DH09dDBHrLbkbxdKNr1319JeSANQXjn2mYVxHlwlFztsF+BL?=
 =?us-ascii?Q?9LWVICm8+HSHkjxnZ6Jpntgid8FizQuTjcVhGnmu8bZ7N/O7efqjMfR6tLjX?=
 =?us-ascii?Q?sVFY45xLLnxejrhjQM8+uQ3AR9LIWa4MK9PcU9a3lTgZfLVHjJfE8dXjSqpo?=
 =?us-ascii?Q?Y3FigyCifsnkx5ZUUoA8P3XqDl4zB+WmZb2PG7pyYzRh1tos1krwc55vLICy?=
 =?us-ascii?Q?L61oshxYYLVtc2Y3+ImpuEn4gXiqUjoTPhxHX73hreURwdzfu1xT3az0kmaV?=
 =?us-ascii?Q?hk7isloX4N8fR0svpgyVHK+q7ztYWf5oFdNzXidSa6SlKVe8Iw/uyNG/yphT?=
 =?us-ascii?Q?+0aDUYxPUpv/RPT/CSFKEk/Ooi9XlSjnkmSjuRS+VICvZjGf/gT6MhROUXYg?=
 =?us-ascii?Q?+POC97jQ/4ZsTecPQCCbj3vmizLJdVw+nezDUB7oTNItwTbCNV4qfzV5kKuU?=
 =?us-ascii?Q?lI5KWf5aEKS1fXfcXjFYemqh9DtO3kZccHJNF8wOZ5ppTbwSrOAfhUz22ACZ?=
 =?us-ascii?Q?q8OFSgOd8U7ixqz0CPd8RJQAiukIE3fFyJkXZeWbw499un/ZAtzAhlqRvLAE?=
 =?us-ascii?Q?zaHwwUV9kS9yBsFzkSuOfqLdlnEFYjWzLm7nRPJlMzXkG3Dt+XVz6b2XmuxX?=
 =?us-ascii?Q?ODJf3YM9f8EkCskrKXkvSCLEYStjQZNyn8ITuhBnS5dBwTJSQwrjO/vxAdrr?=
 =?us-ascii?Q?YBjwW8j+hH56fxN5CTvkwuewF8I6hoqI6rVoRM7Qnzn5h558XtdQzMdk1ioh?=
 =?us-ascii?Q?dcteVfgEp071CiHze8W0XqYohlp2CqD1OV245Act?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119a0b2e-1b80-4ffc-de7d-08db94946f5e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 02:42:25.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLyyQjvq5Ejazco4Mg07b503fQTkzmgUNnm2vJikOiOs1WB3o9mdIfpxAuUqtus1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_98C5A17B-E4BF-413D-93F7-ED1C12BF55C9_=
Content-Type: text/plain

On 3 Aug 2023, at 21:45, Kefeng Wang wrote:

> On 2023/8/3 20:30, Matthew Wilcox wrote:
>> On Thu, Aug 03, 2023 at 03:13:21PM +0800, Kefeng Wang wrote:
>>>
>>>
>>> On 2023/8/2 20:21, Matthew Wilcox wrote:
>>>> On Wed, Aug 02, 2023 at 05:53:43PM +0800, Kefeng Wang wrote:
>>>>>    	err = -EACCES;
>>>>> -	if (page_mapcount(page) > 1 && !migrate_all)
>>>>> -		goto out_putpage;
>>>>> +	if (folio_estimated_sharers(folio) > 1 && !migrate_all)
>>>>> +		goto out_putfolio;
>>>>
>>>> I do not think this is the correct change.  Maybe leave this line
>>>> alone.
>>>
>>> Ok, I am aware of the discussion about this in other mail, will not
>>> change it(also the next two patch about this function), or wait the
>>> new work of David.
>>>>
>>>>> -	if (PageHuge(page)) {
>>>>> -		if (PageHead(page)) {
>>>>> -			isolated = isolate_hugetlb(page_folio(page), pagelist);
>>>>> +	if (folio_test_hugetlb(folio)) {
>>>>> +		if (folio_test_large(folio)) {
>>>>
>>>> This makes no sense when you read it.  All hugetlb folios are large,
>>>> by definition.  Think about what this code used to do, and what it
>>>> should be changed to.
>>>
>>> hugetlb folio is self large folio, will drop redundant check
>>
>> No, that's not the difference.  Keep thinking about it.  This is not
>> a mechanical translation!
>
>
>   if (PageHuge(page))  // page must be a hugetlb page
> 	if (PageHead(page)) // page must be a head page, not tail
>              isolate_hugetlb() // isolate the hugetlb page if head
>
> After using folio,
>
>   if (folio_test_hugetlb(folio)) // only check folio is hugetlb or not
>
> I don't check the page is head or not, since the follow_page could
> return a sub-page, so the check PageHead need be retained, right?

Right. It will prevent the kernel from trying to isolate the same hugetlb page
twice when two pages are in the same hugetlb folio. But looking at the
code, if you try to isolate an already-isolated hugetlb folio, isolate_hugetlb()
would return false, no error would show up. But it changes err value
from -EACCES to -EBUSY and user will see a different page status than before.

I wonder why we do not have follow_folio() and returns -ENOENT error pointer
when addr points to a non head page. It would make this patch more folio if
follow_folio() can be used in place of follow_page(). One caveat is that
user will see -ENOENT instead of -EACCES after this change.


--
Best Regards,
Yan, Zi

--=_MailMate_98C5A17B-E4BF-413D-93F7-ED1C12BF55C9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTMZY4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUCIMP/0ualyhZUGqRIFOFmvEsNe/75f4Y1BNAAUuZ
ux0UJtBho7My4RT68/M7a1F+iPireef0tRGy8cAuA/dlBXMLY9yS1ot8mA6//HvF
IOJfu3a1QeuuKRlTj6ufKhT2VtGR8ddkB1Bj05xLeqq2sAaZNACbZ+Q/WsF3PpqO
lOn0F5/Iz7d2ksKv78rVBdk8yq8pzlusCBRAW44bbFzuNyvNeKRtlHjrcM1AV0EP
MxROkahrQZl8g4fqi0LJU1MG+TJguTrECEJTjF6ZbvEN6U7HTYrGN+hbVglLbdcw
dCNAk8vajtqo1eRK0oXvLKbLtfXgOnVGc1vMPcZ7/Jn5BcBhX/KQOwOQo5utz0f+
/MaojBpegkZ8vbhoOPFugtJmsarwlRDeVUF5YsGhDdrWFuuNCcpyBx4LZuDbAeOu
AKhTYTg+dPBICu2RW21OZGMrS328VDDvT65iGT8WDy1pibxRlHntwkhqW02ATaLT
WV+o+VwaV+ojUXiHjEHRFWQvjjeJJiOIjwlwn4OtV1U97C7ffpnF+9XWqi+w0lXT
2Cih33qpdbqF4s9Lr5OeJOcX34k4roIEauywUqHEuehkA0PgCm5vERPwsb6pTpIe
IKanaD0PFTKfDbetZ+6sHJCkhiarinoPhkIPdxhdcKcreYXIygVSsMoheO85bltU
lLkMaCZY
=0/4R
-----END PGP SIGNATURE-----

--=_MailMate_98C5A17B-E4BF-413D-93F7-ED1C12BF55C9_=--
