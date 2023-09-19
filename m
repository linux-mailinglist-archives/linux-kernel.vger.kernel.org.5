Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09917A595D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjISFbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjISFb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:31:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52CA100
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmgCtrWCziDK6bhLTdqjoG+tg4TFvl2FoNlCpyAksyU2LJhUIl+bag6JOTFErrcW2l7MpZD1MlhGNvhqGKGGHLLyP8Sf7iFhOHUsb/WODDAFrhS7OuhqwDk5XnQPO+OIhMd1Lnjcwu1rYVqyN89UQwrkUSUNjEtaiVcSB2xSrQsOADN/dyk0m7lirjXJxk1mg7xSxetkNN7DIFFDrx697ekNLrj3Nk22P8lFj2E8KWz4SSl/ixddeaigk5mv/odBQVsXBgRqIwY50u5zTNkuZYZPgxV1YjHqjD4XMQ+5rPV87WcLvgULaDKujvsZ4HFuwUnvzCiQofPeWB6EczXX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04HbM7rXZsRlMaJ2tW2fJkFeuJFLA+agD607Br7+Gm4=;
 b=XfmtCl8VtA2VUO/c+P41I5xkNl/JCREOP9wDAznyPOgS+09may43oVsywqJuQKHlCkXwVZJirfcNfChSmoDgAO3ljtoD9yjHiRH95ntN6HwPxxmGbRps4s9xg/t8u+Nrtqj5rdb2jRZ9rnxybWRPSuXS5lAzy7D70gveUfJSRb1Tor0Isjps+nW8fljjRBk+iaytKbpZowVFea/OzE9xeHqX65HdJ2lHd+WWGdf7wpKwvWHZKUxuZeSXunHlfdf6srU4inuA7A1v4hOfGjKgCLr1JhTJ9LkT/dPNRKyE7M0HJEZ/0Bv6XHYT1TBVQMfV7yE1f44RjcRO7dSwtIL/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04HbM7rXZsRlMaJ2tW2fJkFeuJFLA+agD607Br7+Gm4=;
 b=DSM4nJdzLUazZCCYNSf+IVZQWd57vqYHRaG+hnNxr/rfdcblbdar1nMtUSq5XzGbH/eJs0qjTadJpZpz09nYf5pqq+1GdUKpKF1GSJYPO2qBB4y+MrRgKfdrQHuASoN7OV26fllmGSZWSoceVEqZ/JXvCT1fFts+8KhOO9V8IIjVdisD00rbq7DrUtqG7d5s0+yhM/VCkSZB7yTjMyD5Mdc0EC3uxqTouZkZ0J8T1K7/13CoSY0WIuyDNnjXmpi4EXW8Jg8NGRRoSby1q5bmrXGUdfvn7iafXtJ2xtmpqD9X8k8UVgVDZWa2XPW4syGzhMIABbFi+DBW8xUPQax+XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Tue, 19 Sep
 2023 05:31:18 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 05:31:17 +0000
References: <20230912082101.342002-1-ying.huang@intel.com>
 <20230912082101.342002-4-ying.huang@intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH -V3 3/4] acpi, hmat: calculate abstract distance with HMAT
Date:   Tue, 19 Sep 2023 15:14:10 +1000
In-reply-to: <20230912082101.342002-4-ying.huang@intel.com>
Message-ID: <8734za6869.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0007.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 654292ba-423e-4c63-465a-08dbb8d1a5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8GOjaBxdFK4B3Odbc1kkKqGDCtNhodPJGNF73rZOlOArge4JjyZ3pTvzyYaU8h/PUFLKNSgMOTdmZg276DUCKzO4p2u2fTP4H9Ix9clDBy0z44/GRw9RSKz9m3sn5zklq2QcfWoawW0DHim9g+9zHa/PepZelLJ0TmiPdcEYTQPktFCsxAjS/D5YXdFsCgf3cCRSYcbfFymJCQn7IHb14s7PiS8/mXdObHIh7fKUNZVoWhnT+8K+dfkVnNPOytHdznkcYjJxgdH5Ap6B+BJcUsw+ze7fJn/Zs1K0crhBSnKIig+3yh3Q2TEPG9n7lh9eldjniHutShSwhqNHSJxSNuKBQLB+ziLkY/2w/qxCZUfi/RGPeWN/v+oPMl3EBWtmKeXy8YTzt/LWmj8lDEVOdYFL3jPrbQQO6/+h8V7VSgezKSEKIn1LKqZTaQYJvLR5S5i4sMbpHVWT60ku+5oMdbZTUjqHP8n8C7bkKYjfOVL7jNyZWxeTNWBDcb4MoZDr6G9+++5NsGeVQmPGQMj9bqTKBD0Q2VtavGbLeuBZtuRrjSqtoWqqyf03rLMJ68y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(1800799009)(186009)(451199024)(26005)(8936002)(8676002)(4326008)(7416002)(83380400001)(2906002)(5660300002)(86362001)(6506007)(6486002)(478600001)(6666004)(6916009)(54906003)(316002)(9686003)(6512007)(66946007)(41300700001)(66476007)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L7odoNvVE96lmpWLEk1JMI4WtsFQ9w9oMhQ6gQ8mfiuVDn4xM1gROgy7u8hB?=
 =?us-ascii?Q?PK0d4ZESkzsqaP1Yb4wGcFPTkuOzYJ+/CI6Hn9c3ppmfOrD6AcdkieFjkj1t?=
 =?us-ascii?Q?XA1If2kkTcO4f9bg83KihOqy7pBbqR5XQXORoxIYDyNpXPTISvMBNgPd6Dwg?=
 =?us-ascii?Q?PZ3JL1IekQjXZp8Q3DGExAKzMAJkEhl9sbhkDhg/jTIfV8zQYjnyBn83D3GP?=
 =?us-ascii?Q?22nCZ51hjVuqetHZikInN6u9KG/Lw0uQmAakRgEfAT7/4wIiJV6fKrGLxAMQ?=
 =?us-ascii?Q?lKJ+wozcsLGigDUWjfpvNCRs8Jwoi+7WBKIo3O6fh0XCnb16QrkKK48vNK0v?=
 =?us-ascii?Q?Cquat+DfHKIR8IdmS18A0DLZQXp+d3UuqdWd5/wE1HNjlVhobinb1FeOJtNj?=
 =?us-ascii?Q?AsIJcnIOiZxwRCPyFSmEq3189mzYtmcLGwsz0GJO8foHyL0ypOKfv0cBjxQ+?=
 =?us-ascii?Q?+ZPVnUpFCowLvmK+WU1KbdAEXb1TeZr1Gbtm9jaW0+k4yU8Tsn6eOhJBf9eF?=
 =?us-ascii?Q?K+PUvKB7c/j5omyOcEfkIfxrXHX/3PCLRxBCWv+Tcl8mxajOcDWtT5wchPP/?=
 =?us-ascii?Q?Uq0zri1Au5kBq2VIWKAkLpWD+SC90RIyG/yH05ZRf7nyy0huKazbKGjJByp8?=
 =?us-ascii?Q?lm5WIS4yrTwJZdOdwrmx9bzihyIbMcLYIjenIznYrvMSeyDjPF8fHdKcKS0I?=
 =?us-ascii?Q?dAxJJ09xFwm8jvdMEhb3k2C7Q8BWF3cBp5rjywNigHGCgZtcVLMSwhDunqgk?=
 =?us-ascii?Q?D3EVUbAJgrqVYuYl01fEQsvlJr0VI1uFkkOWPj+CURa2cpRi1PoTrzW8eseB?=
 =?us-ascii?Q?4JiSKrNarZduscP5K/S/2pWCHRMOxeJ/h+YSWzREOttJ+ZNElHX1/seEgLaf?=
 =?us-ascii?Q?cQzQ0XbOTz79eGU53KI9n8+sx4v2AWes9eXyajME7tbGsKSxNC8iU0dj16Bv?=
 =?us-ascii?Q?pHZ1z5AdS4tsoLY7H1YzKu+LuuQ7J9m0yCPeVPzKPrlWXeBOOkaV/i7AqFr2?=
 =?us-ascii?Q?5BbFPGsUFysu10ZJ2JjolsGDY012TNBvm21UGMaydff7DcOBTF8si3MZxn68?=
 =?us-ascii?Q?hd7X5+hWi1BULHAL27h5WupAWd6kEIZYeZ2hQCpMSOLOzYOqSneMtBdSLDZd?=
 =?us-ascii?Q?UMsYJyygrPxoOm3fjUz0xgZeMLrSLAlpVQ9K3tAAxg+wl5/9k6UQKK/aHsJL?=
 =?us-ascii?Q?0Yq85BEsNKGBAGSoUYep3UY+gi+NFdDr5gtNkbLGj8ZaWK3k4Nnmemz45aal?=
 =?us-ascii?Q?wlJgkZK4DFUzoOLtCpBkWuuPES/I7JplzLFmfZO9bZcNq8W49b2MikEncffC?=
 =?us-ascii?Q?h/hvXHbO7Cia5RuWJzKoEMuGywhmDQPrB3zMWRVniWM2DKliXTAZcIwDPg/E?=
 =?us-ascii?Q?jiUE00ZMK5z4pZb7O/9I+GthyF3aa/gDW0kPNo9+X09M83RqOx9mIAuX9sGS?=
 =?us-ascii?Q?+7yU1ljyDrBgs2qJ6vy5bHiFekGmJ0w5qibnuRIISjNS9kmi/AB2aivJVdmM?=
 =?us-ascii?Q?tF2bp+9HVwX97NbyNSEJz1QEQz/Wzke6LYAsKB+nCJq0bD+VYCBxBiCZeis+?=
 =?us-ascii?Q?hzwAb1mtXcpWGKadb9AS8IOPI17D4l3mgTl2qmIs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654292ba-423e-4c63-465a-08dbb8d1a5db
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 05:31:17.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5yxDQn9RpKRVyCbNENWtyGLLf6Mnd6yUFGBrEFStM0eV971DBGRPD01cfxH3rNfnrxSFf9NbPdVr/+bawz8yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for making changes here, looks better to me at least.

Huang Ying <ying.huang@intel.com> writes:

>  static __init void hmat_free_structures(void)
>  {
>  	struct memory_target *target, *tnext;
> @@ -801,6 +857,7 @@ static __init int hmat_init(void)
>  	struct acpi_table_header *tbl;
>  	enum acpi_hmat_type i;
>  	acpi_status status;
> +	int usage;
>  
>  	if (srat_disabled() || hmat_disable)
>  		return 0;
> @@ -841,7 +898,10 @@ static __init int hmat_init(void)
>  	hmat_register_targets();
>  
>  	/* Keep the table and structures if the notifier may use them */
> -	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
> +	usage = !hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI);
> +	if (!hmat_set_default_dram_perf())
> +		usage += !register_mt_adistance_algorithm(&hmat_adist_nb);
> +	if (usage)
>  		return 0;

Can we simplify the error handling here? As I understand it
hotplug_memory_notifier() and register_mt_adistance_algorithm() aren't
expected to ever fail because hmat_init() should only be called once and
the notifier register shouldn't fail. So wouldn't the below be
effectively the same thing but clearer?

    if (hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
        goto out_put;
       
    if (!hmat_set_default_dram_perf())
        register_mt_adistance_algorithm(&hmat_adist_nb);

    return 0;

>  out_put:
>  	hmat_free_structures();

Also as an aside while looking at this patch I noticed a minor bug:

	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
	if (ACPI_FAILURE(status))
		goto out_put;

This will call acpi_put_table(tbl) even though we failed to get the
table.
