Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7878F073
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245542AbjHaPhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjHaPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:37:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B37E4C;
        Thu, 31 Aug 2023 08:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ifl6L30xMKvV39jwsO5WxaCcQh4nkoF/TYLrD8FbNm4svnsMyTj+r4gAl+hm3fFlKfBh4Q0MW0TL+aSn6ts+swe9ffrEhqZvcsormnmvhVyTW77lfW8SkSC+jgkOkIQnYBQSXwWwq5PfmbJtFufPZUGtZmi8b7bgJfH+hW5+dnwnDtAG8n6ub0DFDRqBN3lvEhHAJ+KX7yXnopbtIsqkJsll7qld2/K6bs2RkYsdb48dU+bTImw0MT1kZb6mU5MwQYIjtSPGUfAoVblpOHk1MgGe8bp6pKCqb4FEcyNmVSLWz+aDlXrmttd7lPNdh55khMKd4mbGUhVf4jV9j03ohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggzSHislYYVx2GJ9EbZSnsAn7i40gbVbzDN8n8R9wHw=;
 b=Ex5AKWq8GW0hGXLUcumiZWjt2hqX/m638vxJsNUTkhXWc7vEaFaxs/dXxkuDFEWokqxe67W1yOTq+5g/mliuJZf7g7zcmIyBiRihrO0gre8/IvK3IbJmD+d5TseMCX2jgI8GfJfytop63u8+lQRDd8yvnQGDDwrrgs8SfRNYkKZPebEqtqd7c+TUI70MNS4MJf7Ut3+pICr0UGZRfMqOJZHyyJwrn1H2jc5Mjn7kbY52Q9CW60GwRJnltEZD5d3YhX3zm7CynyMez58hSopw03nKv3fRsvWI6orDEA3pfYr0GwTOHJDh5SVpcQ9uM93dwV6BwpwAstxL0Zy8JZWdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggzSHislYYVx2GJ9EbZSnsAn7i40gbVbzDN8n8R9wHw=;
 b=b3bB5S8FVpZipRvJfznxtjzaP0B6kgR8K3lM6kfwexB2YaHGQwvd7kuwKb0rJ3DjIq0ruGa2sa3CucwCCM7Jw5X2T2zeO4lu8Zg6vzLgfUpj7zJcoz75TiqAQlerZq2IZcnH8+8MQY4MqQoEBuJg27U6SdRn+m9fIyasjUMlcy/oLzWQMH5PxTQg3Xca65IJj+bIP2iqjpaL6haeoexObCWUlrSlJwV5eWpcWNJmiXnTE5msQXlCmGzWYPlxrF3IKn8j/BIVAqXLKtuCRegwIU/RSnOxoPUYkVUZkBjLtPlfpgIF/Viyqh4XXa+3EsSjjPJ6oI9B1+c2pG+4+JWHJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 15:37:27 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%6]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 15:37:27 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "\"Mike Rapoport (IBM)\"" <rppt@kernel.org>
Subject: Re: [PATCH 2/3] use nth_page() in place of direct struct page
 manipulation.
Date:   Thu, 31 Aug 2023 11:37:24 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <4B9F90AF-196B-4021-961E-4D08A8128272@nvidia.com>
In-Reply-To: <50EF53C6-0CE2-4256-B8AB-AE9BF290419D@linux.dev>
References: <20230830182753.55367-1-zi.yan@sent.com>
 <20230830182753.55367-3-zi.yan@sent.com>
 <50EF53C6-0CE2-4256-B8AB-AE9BF290419D@linux.dev>
Content-Type: multipart/signed;
 boundary="=_MailMate_B7756813-2B54-44AE-80AB-A93BCB54B20D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fc362e-01b9-4024-f445-08dbaa382e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLSJxcgv7VSinp2QYrypmZK2+Lp+BzRvkjc/wiJRz8+1iNHuKybMI1VYDGPqfKOsR5WJw6+SPfZ2RMXKqj5Ezsv1477HWrE8PX67/JWrWX8QHBK107N93MDXvcbj4VFXB1ZOiIwhPJFhl2oPteWRF8vjkzXuIvb3ol8iwEN6SP/9ITqGY5wpjuJMZVCP6/kYOK0NOOYQxXBOqbhMV/+jOBmME+9MsbB6qASmuaI99/OP0dP/FZSDoIFToZvHkx+YDz49RmJ2xzGcAWrhITzSr2BO6EWUt/gHJybVE1+0Kz97u6Rwez+vCq7EFT0IzY9nRB9K3DU6/EkLzOC2as3c9RhgiFrEgAuFNRswk3nCws9/Uw3kwjSViUAeBLgiUqBc3ti6o6toFRqlhUosPnUHGZck5z5jF/hMtZ50OM8uXK/wyxHu+EgDdAXbPJ5N4RMKGbyC0AzG/OhB0cNTpMnLujn7be9DdCS2/E/FbQz1CifPFlrUbFYHbA8snkS9FmqShsE0aIjv80o/sGlVc7HCUoMsW+20+rWZ6wfHa2OXruVL4/tEwJ8BFxzbMlQIn1sjYwcI2EJ0Bhleao3EvKhbvtcRJQWa2cOvmS6iziYqWuWfVnSfdHlw7BWx0WneWyr4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(1800799009)(451199024)(186009)(6486002)(6666004)(6506007)(6512007)(53546011)(478600001)(2906002)(2616005)(26005)(7416002)(6916009)(235185007)(66476007)(316002)(41300700001)(66556008)(54906003)(5660300002)(66946007)(8676002)(8936002)(4326008)(36756003)(33656002)(86362001)(38100700002)(66899024)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JPZaltHP7zmvYxAQ0I4lxuFSSn8OhXXj1PaOPAwAynto1+UUcXJ0Z/BkHSKg?=
 =?us-ascii?Q?+CUfXF3gLHVfCKKtuUhsIQS1yfCIegpqe00+effe42As1t4fBwQe26eX1fox?=
 =?us-ascii?Q?11U3H9ofFUMJFpMPhtDiEbqVzQO9c/P4suqlmB6VvHdho/GXQE7hejn+Ir8c?=
 =?us-ascii?Q?YGmbynfkCP67kX0C0GhCQs6TgTPhZpHLIINefz/7romi4pacKlWjv+9mLRYR?=
 =?us-ascii?Q?baUgE7NUzgERrX22g4HVJH4zthDlp+KxgS1R1RR2MM8pbzCF4OymsMNjgoId?=
 =?us-ascii?Q?wiSZeYuWDabzoYtSUCe/2sF1ZiJAuF92VLbT6uue0+0fcbJblh0uTPtt77GV?=
 =?us-ascii?Q?dPUJ+d0GnOsrsDoV2p/kjKJYawfI+gt7OaLqvtgmAhvnLnN1O+EqmLa1Cx5z?=
 =?us-ascii?Q?50wJ/2bMrIMVyocs5HIFlk1lHXBkFZA8y/7qHlyffCZhGMN7e3MhZmxUazPx?=
 =?us-ascii?Q?/z/5BgkDrrZHF9tM39t5R5lvnM1yaLx7iHeH3n56qoh/+aNZyOgHct0q1IZD?=
 =?us-ascii?Q?ASF60FtcyIwivOzCXW3I92+5hw/tVOiG0vh6fbGmBMZV+gIkd9QX87wWU/+P?=
 =?us-ascii?Q?IUw2V9ZDrmXWLLTDYojVDhqgB9yzLucDjoH+x4nwKlGawY+uUoGow19lrsgR?=
 =?us-ascii?Q?WkQBsRbpbgLHeKN5AvL0pvpvjjurrDk5zA62eGnSdFUrp2wfq1R72bB3MdXz?=
 =?us-ascii?Q?UqcATZUV7w4CMzfQZ9jaSfpOhl2m1DORHX9uSJ7CVEZ8MDL/hNe/Y73PE9EM?=
 =?us-ascii?Q?UUlI3DfbNAtPruXiXwl2F+xbF8f+0X/KLBsJ2Hd++6x0HzT6ht+87zxnxmlN?=
 =?us-ascii?Q?+xKUfDkykem+F34lOdi4UpzxvHCbGJuYRXqadrBfFaW6zas6O6qqWlUw0/b3?=
 =?us-ascii?Q?yZVzdttzCkynEQC3AN7wvBUBw8YpSO3DjIRzA8YWsw+WfZyzpdGNWnpVnzWj?=
 =?us-ascii?Q?H1jtSrZcyAEGHhH2Q3weTeIVh3x7i12jdPpB9jc/2U7Fl8m1KL57M/qfVFzC?=
 =?us-ascii?Q?Q923/FHLdtmGlMolu8sP/G1AKo0eIeQpBCR9oyeTH6vQCmG0HGegunjX7Doa?=
 =?us-ascii?Q?kVVNmR9Mc0bw7KQUEClLHoOLKEwNDC5FhthEiqKoimTDmlfX/kOmnzlu0FJZ?=
 =?us-ascii?Q?9T/qHqM/w9dw315Vz6L+QSS7WAkkHknU4/l8ZzxZ5dDdAqO1BEHIaT3YhsEg?=
 =?us-ascii?Q?JsCq3m1hyg9hdlhsHCjO+OReT/Y0hs/l4byBwZtzBNq+7Y9byNPFNfwpSKQ6?=
 =?us-ascii?Q?3Jxk6sZ7EPZdAN95L13j2FIU3KH0m6J2xKVF1UgUi5NaOtR5M6Au2GFRo6de?=
 =?us-ascii?Q?9P6IuNSToNyM/meVx7JcrDzAoC+dTIq94YGzNdYuS28p//2F6nNWUVdXKE0T?=
 =?us-ascii?Q?o4YuGMDmxw6PwP5TS5r1/WrXDl5JNNGW1tzRV+zWLKGwH2XMjt0CG/+Ayp2S?=
 =?us-ascii?Q?IYM9zPaxJ6GrAtBfzauVoF6bdQKCY8Yd2hTWC9Ly65+ea8hOzJ+0L3VnZRcR?=
 =?us-ascii?Q?NA1hLCm08Z4eZFCgwnOZyzsU3Ob72aYWHtJuUfqlPaN5qobRbDsEEWlaOI5v?=
 =?us-ascii?Q?PdmhG1NlXvfzuBOl/eQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fc362e-01b9-4024-f445-08dbaa382e36
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:37:27.4879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCQSBzABFTvhKdAtAweqUu+/JH9KWFsWGmxRNa3AQYLrkIFgunnG9AQAb12yA/nR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B7756813-2B54-44AE-80AB-A93BCB54B20D_=
Content-Type: text/plain

On 31 Aug 2023, at 3:17, Muchun Song wrote:

>> On Aug 31, 2023, at 02:27, Zi Yan <zi.yan@sent.com> wrote:
>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> When dealing with hugetlb pages, struct page is not guaranteed to be
>> contiguous on SPARSEMEM without VMEMMAP. Use nth_page() to handle it
>> properly.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com <mailto:ziy@nvidia.com>>
>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>
> It's better to add a Fixes tag to the commit 38c1ddbde6.

Thanks. Will add it in the next version.

--
Best Regards,
Yan, Zi

--=_MailMate_B7756813-2B54-44AE-80AB-A93BCB54B20D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTws7UPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU/2sP/iFdiEGWz260q4dzF/QC+y0/OWRYNLHP36Ka
imYAMR7K80f/RdHDTw7hwmZFjIqrNVZaoc2ymVvrmsyhsWNzxyMiOm216eLyEoI7
1CWsj6x1MPuEGR2JRW5t28eIxH/OOrg1T/OPFY5/+2/iIKF1wI507bKQGawr1n+q
eKLKA2pc3wZkkjcJtBlZ6Y/YyGVcUSciNPkphxq9p5qMAbbAXlip83+dLXjKdH+f
X7FDLD1odSfoqt3a/5u1JPF6+D/oYo4N2n9aFh4GzvOxAOcdV27x2j9HFByFYV7Z
Rtf8QTJwV+4QWDO0LRP6ViQBMtkbeus+EEMQun9A7w8+chRJXzoEW53d2EwOcEgZ
zca63AwsK+mGZFrpztfSHXYN84pPbMxIxEoI0Wezw3HSIhYmAwmh7DX49+LYjGu4
EpRAwuIIDbUKiIEVwE9niRMZyERLtGNiZkA4yzDEvClVC9z3dfuS0aIBlX8oRcj9
MWJ73OF6tGTxsORBLBBG35yaL9vuWadydJ1CRsIx3UyMNh9S9KrdcMEzk65ybdxq
c+5lp1xoeUqVV7V4DPsyoukZC69OmVcx2N5cnorR9QTQqrfIGZHTLIyAWaAupC6f
akobx8jYbkHMN6S73b+OI+SWX1ijfuARQsproyzwdnYjZPr92obr32pPkDDHcxr+
RxopIYNT
=K6lo
-----END PGP SIGNATURE-----

--=_MailMate_B7756813-2B54-44AE-80AB-A93BCB54B20D_=--
