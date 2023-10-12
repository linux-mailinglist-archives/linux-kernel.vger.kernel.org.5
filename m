Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C167C7C6F06
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbjJLNU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjJLNUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:20:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D71B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3FbMY3bf+fbyiuWjIFsZRM4hZh6LymOIA6N1Wkw1wZYf0jM0Wb+NKq5mle2cri5xh9lmyM4fu7p9Z+RB+JMLJllwyuFwt8eWT8e2jUrbhcpdJbyQDu6YNTM+k7V10EWUvWor2DLxe8830Zu5Xya66R42S6uXeVzlrgXnAQ6jqz/Xt3n1X0MVXAfKbGUscpaZFDiZfM74v03yEOwWmwRga5O/YLYAPMMXEPBjPE4z7z8jTfR0GRiiC1HzRXdeJsMCcOxvN8pOx6yi0GSA78nlwcsfqDMUu6ohaF0Y934J6Aeq61DRrO90EQEscscEY0PbCRP02tfJONbPubT+8fOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJJZKw4QXyxsVV++w8/o0cUom9IRcKIploB9B9mG+ps=;
 b=M6qdYyGIViyR3qWsyU/xNWlBDuChXSdV3rUOfld7QuRwRyxJOXJNtNtauHbLxkVhrGp4sQnjIu6l5lAPCeZpnJ0PBdc7hsKPLg0AZDfbFNjdKoX6HXwVcpp1a69xTLdht33m3hZ780pza47DSeCOhjQkLgAo6sKjztUiRO8Lnz9Cq4iVWOs7WgAhZIREXIJa5vodnf/pBNkKUjgmZCafF2eqgG1q50yt3Gw2j295xkZxB/Fy8YjSyO1rmkVjiJVkwEHv8QJAA92Uhs8BOpQwzD7QsbPEiqKnjX6weW4W/sbYlGz+6QnzCHX3T+XSuOKiJp+ose35RdBcQjuhLPgNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJJZKw4QXyxsVV++w8/o0cUom9IRcKIploB9B9mG+ps=;
 b=aTBzIoVetvW21P3i0Yj4yb9DKVATzUKUT/KoW+98umI57wgENP5wEstkFDEyryjcK8qXzphatdoazJOV2ItZN/SkOWlU+pi/h8NZeMBI4sagruewq8jcjjg1gEBqq/3XTY+b7mclLttRrTckdMFWOoR3bUXoJq4DTT1WU/PJm314Ed5k9gAwSMkjNLpsf0zGc5AqFrfHI02B0W1BA9I7QuzbvrSvP4tgNXJV8KsSR6YdAOmBFVnEK7Q0ffgQ8KCGsdOgQB4USS69CyvtR1u8WMVA8WsJkkIjscNA3qtrSqaLAZ5Rve3DTc2ptMqhIKfOVGLWxas5f7p2tnOXycRSuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:20:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 13:20:46 +0000
Date:   Thu, 12 Oct 2023 10:20:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231012132045.GI3952@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
 <ZP9MQdRYmlawNsbC@nvidia.com>
 <ZQHUifAfJ+lZikAn@lpieralisi>
 <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012123541.GB11824@willie-the-truck>
X-ClientProxiedBy: MN2PR22CA0014.namprd22.prod.outlook.com
 (2603:10b6:208:238::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfd1de2-4754-406f-0437-08dbcb260b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+iChhI+V4DWAie3sH43wUZHC+/67UDW94hOu3saZetfnY489OBi4NCFi9p3w+g16Xpme5R5e7lkcD6IWfFOCsr6i3gV/f+kMIzNre+4E0NYm8I2q+SQjjuR9bv6AM+Tqfji9gayXuvAkfz7f8y6JemgCFWKGhY5f2sUdaPESEBuFqm7MffCawXOdExjlCR03kNpeqskNJRMXHBVGymLag33qpFdHqvz6raq6lI/EUFCAESgzOA+yoENqurgA6YLOMCLBXHlBagjdxGP+SGOJMcmAynCq1PkkrRuetLjcBPCAdLcEL3xO8/P99a+TTwKbW1VMmaTCNCGBtBH9rOZ1LvaxN5VmYak4JUtdSKVYDnvdZ4IbXeFD9A1qxFDZ8Cu4Cq+JFiKOS2jLitXApNIrQol7a0uBDdeSvtPWBLzyHzrJt2Y5YvUXLDYQXc6RPp78daKHm8p6LVcUVZhgX0D6VvadVHO2e78ONpPdSC9g/DfC3x73sZO3R5f3+ondGPd6g5n+l/LdxOeHCoVjbO593CY4lbVLiUQsnvoEJukLIRlrMmVWqAqmXVA5tS3sp2A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(1076003)(2616005)(6512007)(36756003)(33656002)(86362001)(38100700002)(26005)(2906002)(83380400001)(6486002)(6506007)(478600001)(8936002)(8676002)(4326008)(6916009)(316002)(41300700001)(66556008)(66946007)(54906003)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QEmzUlXwxliFfPfi+RTaaI6R6FEWrTZhryi0cIQdoNjxeBb/rXVgXiyjX849?=
 =?us-ascii?Q?15HgrTJOPJxjeVTYqE+A9r20v5hCJf3Y/cHL9fjfycQ2NeBqJsjI+l6dLmGX?=
 =?us-ascii?Q?slJOx3jwjAceoDUAk4C/4u1aMkLSX+WSjifdf12rURGC0+8JA1g9A4YwJSQM?=
 =?us-ascii?Q?Ilr/RS/WqvaV02AqYM5MqlgG79XkMS9Ft5phgb3ioe/eht9TzJxjmyy0kdKy?=
 =?us-ascii?Q?o4NXgb1/qgrVgOR/Jq95cnnsezsXRdlW21CZ0BA4Qnk3BWOk8mYlrtjiBUmZ?=
 =?us-ascii?Q?Pd6wk0GhLaMdLMg7xqSRwnvKLl9Evd2MFtCfesdlkum/2m/l0OvTK3RRRZff?=
 =?us-ascii?Q?aM2cj8VOi+6uKBoZVPO1xT58oSKM3vv7jRORkoDNVXydChvyYycYEzb/9Ps5?=
 =?us-ascii?Q?PdfrfFBDIn2LakygQLWucSGk83iZ/YT5qJpsFnSoAaqy5LE4LoeuONf3445q?=
 =?us-ascii?Q?wFujABN9bAPxFwwZEkBNKMSUo8HH2LGvsylD1014wvXHrW7USXLZbYyk6eUW?=
 =?us-ascii?Q?3FpD6teHkE7ddp+B7jUtEeUSnLNUMVmfzr2w6jTnBHfUlpJuJ9DYZdGL3yFT?=
 =?us-ascii?Q?Ct35HHb23IheGPJI/ZQ88E36VND2e7HTsRJ8lHlBSbK29YX4QQdQKLLMg8BD?=
 =?us-ascii?Q?pSNPKhaYQsCa0BriezcNDSvJJhqb15AftzjKRsYzWHccxTocjbxAdjPDEU7d?=
 =?us-ascii?Q?cPfb3bzTM4sbx0h/6LQrVio9ZMs8X0DHA9mcC2e4kDsQc8f6Fr6vgjfaJVyx?=
 =?us-ascii?Q?k5GE3xWDNY1YBjd1RCQcXLw5n45LDTPApg0Nycy29i/PvQPxL57wDh88XJ3v?=
 =?us-ascii?Q?oPLvvkmQ9l8HoEV+N9djlfRv6t/2PH3AHoJl9FhQtc/ueFi1mYyJ1+ToHqcH?=
 =?us-ascii?Q?xdBhmaYC54kf6FOZJqzOUhFr4TShw7K63oQsqrAjtMRc0CnC/jG1C/osb7JM?=
 =?us-ascii?Q?1y426nvoS92XJDzCgBS/xIjzpzRk6ucr+c/baE2FMa1zZ8wOgz0rhMCa8kIE?=
 =?us-ascii?Q?eQ1OOIxMQIoMUvXnihI+rD+Opv8dVsGC+YNnmBAS2wV3u5o5vhnsHmxZUQay?=
 =?us-ascii?Q?LUI7ZO1YbqT5cTyoXDUuaANqWK2YB9njgFqsGMB3LeoWK+aIiwZACuQGbIUz?=
 =?us-ascii?Q?1MoPn9lo2A5d0RaWcQupiBNW51GWmGbEZZ4UwGzqRJ51+vRWTUsmT5b9cn3X?=
 =?us-ascii?Q?adfq1YpQroh22jTRBohB2bl4/9yBIo8Rd2pI3pHu4V8pn1XRgqjp+SdRBnAQ?=
 =?us-ascii?Q?TMWPo1BmH90usgRgpq2vpohDZYLUnrpUOgS6sWAlm1qNNAtMdBjuBuTesg8I?=
 =?us-ascii?Q?mL/6NZKXlyElEVB1V3KCFHY5lQiDaFjfoM8kp70Wa6wPIQfYC8TBQ4BRK97x?=
 =?us-ascii?Q?VUqcOPiyHZ6ZIIyJMKN7XUlyhewD31450R55RMBN1Nb2Y181NNOpw5n3PEXI?=
 =?us-ascii?Q?uFPiP2uO6v9t0kBaxCVmIiBoyut9Ma+U5mHO0tERq2mz1+uMY72Y1/SOOR8b?=
 =?us-ascii?Q?h6MZJAsBuftkDS5VHj9ahRwCzTP/Vg9NSkOsuYVpw+y1qAGiVtvOBuhPo7UK?=
 =?us-ascii?Q?nM+VOE5GifE+qcjyk0AUBdj+0lkmwuexX1ZC0ks8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfd1de2-4754-406f-0437-08dbcb260b5c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:20:46.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxHZva/Xtq4yRA3ltfafgX1EUWNHtGlGOlvL2K0jNhkbn4+tW7SumhkJDwGpgdvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 01:35:41PM +0100, Will Deacon wrote:

> > Failures containability is a property of the platform
> > and is independent from the memory type used for MMIO
> > device memory mappings (ie DEVICE_nGnRE memory type is
> > even more problematic than NormalNC in terms of containability
> > since eg aborts triggered on loads cannot be made synchronous,
> > which make them harder to contain); this means that,
> > regardless of the combined stage1+stage2 mappings a
> > platform is safe if and only if device transactions cannot trigger
> > uncontained failures; reworded, the default KVM device
> > stage 2 memory attributes play no role in making device
> > assignment safer for a given platform and therefore can
> > be relaxed.
> > 
> > For all these reasons, relax the KVM stage 2 device
> > memory attributes from DEVICE_nGnRE to NormalNC.
> 
> The reasoning above suggests to me that this should probably just be
> Normal cacheable, as that is what actually allows the guest to control
> the attributes. So what is the rationale behind stopping at Normal-NC?

I agree it would be very nice if the all the memory in the guest could
just be cachable and the guest could select everything.

However, I think Lorenzo over stated the argument. The off-list
discussion was focused on NormalNC for MMIO only. Nobody raised the
idea that cachable was safe from uncontained errors for MMIO.

I'm looking through the conversations and I wouldn't jump to
concluding that "cachable MMIO" is safe from uncontained failures.

Catalin has already raised a number of conerns in the other patch
about making actual "designed to be cachable memory" into KVM
cachable.

Regards,
Jason
