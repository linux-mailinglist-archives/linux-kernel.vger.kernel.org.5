Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6B76F683
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjHDAZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHDAZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:25:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF564207;
        Thu,  3 Aug 2023 17:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRYQYVnS8/V10mi/ufmz1dM9kHitQJWX4ow1D0dGARi2ou6lUdIAnRrzTbQ5q6zfURvcyq0uQRj+6CPwIzPoKzEajRyGjMXm/yeZTQMzW6HrH5c8i5t1ZcBtR4/qkdw4mYMu+MCZMYnIhZ34Bi4zrg4hDgl7uhvuVO51SMimeyv2ZdnGcsfD+Nnaht3FznP3DK9y3BZk4ttzELrjAxRvfEoVDvju2Wm/LE3TK4H1ZWBiEMLwj4OAHtqOykcPwRDC3sOMfhRWYgPAXUG685wpdAdzGJrEEssZfMGGlFQqr2Igv4ZaC86nvru4LmThz3vK80MfEPiLDDVW40cXgLP4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EcbvnMS9GvVjB7eTdpnHruQD6ZO/43ZgHqOppo4jUQ=;
 b=MCExHpEH+nQV7+538VpsXGqtbdMCNyd2/b5Cv/z8Y7FphUcvtG0qnMsLzVF16lCG4keSy2Gg4/ERJQiDDri1zLRgdxxw/9Szbi2VrIykV6LTFevsOwwZNJtDQHci0pPg5c1l4jyzVby/iqwRzX1kF7r8T6HdQtN8pmZPkBbo5mQnh/GCgE6+ZREGLWG7nFCJ1rDdmzIK9UypqeTLz/j7rSx2JRwEhocL3qp8eY7VzJWSr8E2NrFIMhuIWBBd/tFxFh/tk14o+PZ2I5V14JLj6F5BxChEc6x9RSoHpLVx+zVsAxHWVh+RzLcZPhLuWvyZHFt5yZIGggllXgpsd4KmkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EcbvnMS9GvVjB7eTdpnHruQD6ZO/43ZgHqOppo4jUQ=;
 b=jL0CB8hxUt8Crjb6esNbK8oYXSByFZfB+aQcMW7CvdKkRnPm9xJDtyGY4SzB9coPausjG6rhvDm0zf6sQvm0xuZGxaMGc1KcJJLnGTAkX1e0wnGTgWwWTIgb+gemvEt4MJ8N42oJ/KHT5vHejrapk8ni2T8e9RxnJHmYERR3n+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 00:25:06 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 00:25:06 +0000
Message-ID: <e5b0063a-ae41-41ab-b3a7-2084dfa7f816@amd.com>
Date:   Thu, 3 Aug 2023 20:25:02 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, avadnaik@amd.com
Subject: Re: [PATCH v1 3/3] EDAC/amd64: Add support for AMD Family 1Ah Models
 00h-1Fh and 40h-4Fh
To:     Avadhut Naik <avadhut.naik@amd.com>, bp@alien8.de,
        linux@roeck-us.net, x86@kernel.org, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org
References: <20230706171323.3722900-1-avadhut.naik@amd.com>
 <20230706171323.3722900-4-avadhut.naik@amd.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230706171323.3722900-4-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eaa964a-5f32-4bcf-d853-08db948140af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWf1QT2KxH9zjK2c0jSN1UesnyxgmdeQHAf/rKCc9L3YkMO0GqrSJuw+GDCYjNz8uHA2CGryDuZSzGRlTZGRmFfAyTUSmlVFruz7XVzDY1wJCNFilzbc/Fl6ctyt55rUQinVL3/RYkQTW2H1L36p8joQJZe4Ka1w0DzVgJxg8MOBp9FDuW3Sntw1LSqxOCF+07MZdjB/iowLB2Z1IOTZrxMewI3/lBTYBw9Ljve4yeNHBFaYpiV0xqXBANn7mMSGoGMcIAxZPtJKpL7G8KaGtohVmkU5gYaqDLWFuaW3N/OH5sD6qZrVGy6ZPTrHnRM2NZqszfLFXIdn2XW9WsMGqW8zMosA+4UMssYio7N42pltjSjIqu6yjK7H8zXYhzdaKg04g5HLCF+BAIAC1Uqd8zDXisWX1EpoPsVb6n1UCsntzHQzNVkpI2zuwS+CQHBC1jEkF9X9f/v9LMrTA4arpwKk0JgvquByPld/RtyRIFwwpxLL4aFKOp2ywLBY2HJZNIbpgBHyob6pI/tKEsFnULK8PT+ACc1gsjDI9ANtSKsTQwFShq/N3fHOIq+7soRQmQ5RTrIbl5GjN2ykgLMlfW5OlVCpAyUcicgXyC7YjSzdeP1Kah0uOKPf1b4o5eHJvo7191mAFM5ql/I/bVO9aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(186006)(1800799003)(31696002)(86362001)(36756003)(31686004)(478600001)(38100700002)(2616005)(8676002)(26005)(6506007)(53546011)(41300700001)(44832011)(8936002)(6666004)(6512007)(6486002)(66556008)(316002)(66476007)(2906002)(4326008)(5660300002)(4744005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU4xWlliLzY1NHZmS1NlK3lZVWdTQkJmbkVOK0trM3lrakJCQ1krSnErejhU?=
 =?utf-8?B?dmRIcHpHQXo4V29VRGdoSmRYYVUzaDhSQ291ZFRKVEh6S0xDWng4QWY1UHp1?=
 =?utf-8?B?bXVFZzQwbGlDWjd6V0tVdld2Rkg5VWxQVmxLb3FvaHI0TmxObzVBaDV4b3Av?=
 =?utf-8?B?VytIT2ZSR3FXK2VEOW83VHJMb3VNeTZ2ckxUMWVnNVVxUUxnaXZCY3IzeGJw?=
 =?utf-8?B?dExEQVdmdXFoNGV4b2k3TEh6a3plNTJ5OVRqbkhGM0kveXlEeVlXVy8vNW1T?=
 =?utf-8?B?UmdOQStDbmNHUW93OFlITm9NVmg2SHA4ZW9pdWJFY3RtNEFMdkJ3RlJjTzlU?=
 =?utf-8?B?QjArQTdiSjdjendsVFMrdzZjb1JOUGlWeVFQSU9tWFFpTjgzUFhYMHdSdmFs?=
 =?utf-8?B?Vjd2Q0tLQ25xSmo3UVliWVhhNi9DZkorYkRFa2ZGd0Iza0JOZzc5WjNnSWVL?=
 =?utf-8?B?ZUJzVStaenhLa05Gbi8vdE13NWx6ZTdzQkUvQVc1WGVKZDZFcE1PaW5VTG1K?=
 =?utf-8?B?OFpkVlZlQVAvZ2RGeGw4SzF0Z3RzWVgyY1BEeUpFa2lONDVRRjU3UU16aXF3?=
 =?utf-8?B?SHhwanZpaWVvd1FZWmRCMW9nQnJ2OG9zVmMxUCtyMnZIcW1MalNDd2pMdHJM?=
 =?utf-8?B?VjRuYnRqTU5HTHlta2NGTXA0bi9sSStpU3dKWHZlVzQ3S3VmNk1oZVhXanFN?=
 =?utf-8?B?R3NoN0J5UEJwMzFqbTcycWRiczR1Y1Bzd3hhR01SUUNyVmw3K1ZSVDVHU1hR?=
 =?utf-8?B?amdwUUhmMjZVMm1TczNVZ0hBZVFJQmZzWWllbFduV2svOG9FVVdvbUkxTklG?=
 =?utf-8?B?ckthSWEyekVvUEU1SkZIcXFyVkE1K0xoNkdYMDNiRlc4MElOaVlIK1NqWldS?=
 =?utf-8?B?dm5tMXkxQmpJclIrM3E3THp6TG1ma04wQ3BwQkcyb2tJZjFYcW1oNXZaVnBu?=
 =?utf-8?B?VUp2cGtrMnlVcjN3MjBYL0F4VE92V0c1TjlQWS8wRWszbFNjV0ExTVkxRHJW?=
 =?utf-8?B?ZklzUmFUbFVRNm1sWHJYVHUvWlVmNmx3bnVScUxhdDVYRkdsSkgzRkpZcHhG?=
 =?utf-8?B?OHEwNEZFZkhQSzc4VVljK1VSNE1MOVFwb2dsblBoK2d6dkROWkpCWk82REdR?=
 =?utf-8?B?TE9iZE1uSTdmMjF0MmQ0RmNPOGJ3QmlVUGJ1TjVZVXZKS05WMzJxMVlrdHFu?=
 =?utf-8?B?RXczQTNaZmdiMGVTTW5ic1RwZzRvMnhXU2FVOERlcWswbExBc09PYzlRLzRz?=
 =?utf-8?B?RUNCNk8rSGZrbWZEUENMRFcrU2RudU9naVV2cEw4YkVBU1ZvOUtQVTZyZC9V?=
 =?utf-8?B?ckpkNHdHSVFhTnlyQlE5YVM4NzV2NzJYdGxGaVgycXo4SUF0Uk1lc01iU2Q1?=
 =?utf-8?B?WnFGbUEvL0x3ZkdCTDVzRHFOQk9wODE3cWtBai94ZDg4Z3ZNcWJNMk1wSVB0?=
 =?utf-8?B?M2RDd2ZDZ2dsd0NlUytUUFVEZ29nSFNOZmpjUnBkWU5COThvN2hiUDQ2Wmlw?=
 =?utf-8?B?dC9sdXdEZXFKd2pHRkpHRnBRV1pmRXFzV0UxT1VPZUFwUnN3QUpZSUhtVmhv?=
 =?utf-8?B?alZ5VVM4L2JmNzNlcStoUFhibWlWeFpaai9SU0JKbzNBV3czRElWWjhwbXRr?=
 =?utf-8?B?UFFFTjhIV09yb2R3MCthVXVnUmNqdENhLzdDV3BkcStuWWRpalFnZGhEMmRM?=
 =?utf-8?B?bHI2NkNBNkExUFdiVklVL0FJNlY3QkhCdFZ1L3FoQmpwV2hIbjhCYTFBb1py?=
 =?utf-8?B?K3pSc3ArWDVtRS90WmV6VFNyT3E1SEtUMWg4Mmg0ZFlOWmJiVnJZU2xuZlFt?=
 =?utf-8?B?aXhnZE1ZVlR1T05nMHdscUFrK3JZTlRBTjFEZmpLRGFZVmVPY3FmT0E2UXBs?=
 =?utf-8?B?STJHRUxkV2luVjZiVy9CanVaTXV1eXJ0UWVVdm9DZ1Q0SXdOTDZxSGZBL0c2?=
 =?utf-8?B?Q2FWRzJwbnQ5N2xFdUwreVdhM3o0RzZQanI1SkpGOGRZeTdWV3FxRFFSUlFT?=
 =?utf-8?B?L1FzRUMvUkZIZnh6SlNKTzAzVmw1cFNIMDB2cE5GVWFsbXZweGRXbmNaL3lz?=
 =?utf-8?B?bmdjdGxuaHVzL0ZlUW01enh2RTNiOGJkY0J0K09YcnpmN3NBSzBGUkgzZVZ6?=
 =?utf-8?Q?FZxD+C7HLhH8E/dP2Slz82zk6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaa964a-5f32-4bcf-d853-08db948140af
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 00:25:06.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHpgvhNJYyczVPr5EXq8ik4F/4coO4GCXRb4p4wWUbFeLk2d5Ajc6BgFeQOgM6fG4mSQOriPqo2wY11Jb0enWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2023 1:13 PM, Avadhut Naik wrote:
> From: Avadhut Naik <Avadhut.Naik@amd.com>
> 
> Add the necessary support in the module for AMD's new Family 1Ah-based
> models 00h-1Fh and 40h-4Fh.
> 

The first patch in this set adds PCI IDs for models starting at 20h. And 
this patch adds support for models 40h-4Fh.

Can you please elaborate on the discrepancy?

Thanks,
Yazen

