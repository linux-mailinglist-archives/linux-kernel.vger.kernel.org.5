Return-Path: <linux-kernel+bounces-66080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFBD855655
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C581A1F2BD63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E464A24B33;
	Wed, 14 Feb 2024 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1pNblrV"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE7182DF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950975; cv=fail; b=npXagY0NjDIpgD8dHh07O+x4VggwVTKpPmRqfVn/iHtbxyyxNuADT6TEvnpWJpaYph6ve6BoyD1llEK2xN3dlVPpBIEatYkXfjiMFe7VTXio+zBJR/9etwW36U2xVQN/U2Qq1Y8klRsfEem+owzwa7QQt60MsQLj48FHtQklmTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950975; c=relaxed/simple;
	bh=NxlOEC5RafyNWZJlGEY2YKmuIiL4xaIIc4lajc/Jja8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=R9sMWKJVhpc2hzD/mKmSHXK2zSdtiGylPoKwDsFQwTW/sHYMZ1fis7WU1yKsau4tHTR/C9c2RHxo0kKqMxV5XKsWi0QjzcjEQxdfwzxNnEe4kPdnVwnEGqLOAYepJdwSQQeaNYqTYjbQ6XQBPTHoFKUOCG+DOLX11w57bEsy11M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1pNblrV; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akb4o+w5leNcHaWOZ8vQHUmKo7kEkP8bjt3oIrKNJ8IMgpa3MhGXrb/WRT/XqCF7MMlAB2YxTv7P7+5fBYYRBhtjQ9NZsIOT519bWs5deZTvwd2sBig6Gam9N4MOrXkc4TzD8yt/nP8/iLVZ4RnwPuW7X5bJwQV92EKvnTrtBgVPCqiNsnzsI63XThBpzVx33dGhsPF01r+fr15qpZHcAjKQuitnN1CLTbRYv07GG1CVDPlxWbVxwJ4lDXW1dLyg+otbEzbuYsR91rpX96W5K0bhIFsOlHeLzFeM+B6lWgCqcWwOzLWgO2wiwAZNDdduW1bIEBtwQnZsxnrbhbFWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+WG1er3Yi94Fnzfgank8GaY4a1DHRHjbdc38f+UpB4=;
 b=kV6FNNpoUXzfzAFVCHkrtqhpS5zgqwnnxBrlIMMVSoWWLrookIOa9ID1xhwScSLGTawwMxjdz9ex7IV90MZtoQchnFIKU4UNO7EnAR9fvgWtB/apjeEe/v6H57cEehZvIcmNBZzj8ZpKaGINFBzD3uzCWSFRQKGTcNKGYaznzu7FA2Fw1QklKP/OqcJFggbx6tbw8Is5jYOVmafDOODux9x2Hc3O29+2lXlFucLcpP0foRFcer/GZl3kjKteIcCAoOygeu0HJubkZi2w2nsOriH7VEpt55B9tHeRRIPvjc4HvKB2vR4jWAIzBcpwwFKu/b3RruDpi9M9D6vaessuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+WG1er3Yi94Fnzfgank8GaY4a1DHRHjbdc38f+UpB4=;
 b=X1pNblrVfXgld63Q7BLCELPIk4J4nzJl1/ON+kZMq9RfEtk7KBoB95wlbuTUdS5I55MKgv0xu8InzN2enerIrijVvyZRwBpkeHCcwC6LrtJweyUXCJmH0EP3TU8tBEaGs3tKhRORaR7Y5qVpSm18flFtrP5kVO8PdQHNKaCrkor4eLPgmJITuzpi4YBI/2MpYjE5DtJcyAngs53vorWAF7X+1JjJG1dO2pKyBT4UUonL6I0IliyOyIzSdY3JO+y6sK9S97qr4qCc7x1tcSwsEnuD7MRc1kSqJ/2RM/T9ykMgKw0zEiB7aCBXxMORaoR2BMcdTYus+to4nyJVt34UTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Wed, 14 Feb 2024 22:49:30 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb%4]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 22:49:29 +0000
References: <20240214202055.77776-1-sidhartha.kumar@oracle.com>
 <20240214202055.77776-2-sidhartha.kumar@oracle.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH 2/2] mm/migrate_device: further convert
 migrate_device_finalize() to folios
Date: Thu, 15 Feb 2024 09:45:16 +1100
In-reply-to: <20240214202055.77776-2-sidhartha.kumar@oracle.com>
Message-ID: <8734tu7jbe.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0045.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 39074dc0-e532-431a-a4a2-08dc2daf3412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D16yba8lM4ZtsMkdOsCFDYbPkIC7BJFIQPohgvzKGwVgoGt3piAmLsnPFt65kmBNEeXl+TMNYbAYGj9j3dzI2CX9ZOj+Ws/gx+GZsC8MUZTA9xJg61+A4BMijnjCy5pnnnb7OjB8y0VrznNogMXchSCR2r3B/2y8COB/RZgcheqHqaAIq/MxOG/38BvN+VLLqdslO1Zv/WVO0jb1fsccMtWRDfFdoejHmi3jhTgvZ6BQgHE9Z9ki24kfJiklIy5i8Jur6so3b3JGkpz/Si18dtxMmMU/qazSM2+BISu9dFPqjb0X+PApqHWHtnYLlGn9O7cCer48FwbgmFYKt23pjnDU/xQdmb8cYUh2AHC2/Rrb+R47wuE+QHm8ibXcxcyBAmT+HDZqd8ESTZGl56y9rq5G+7Xyz7urnrZx9WViXy4wEOhpecYAzETLFaNTqAWBp/vo03AWIKBPvkX8FyRBY9VdJGd1jTD5mvXyA6uGCzItiQEBPjSRC+P6Rhr6XFJDlUGmnRbtTm2t8MAVNBsGuawE953UTs74oYlIuEYFUI1r+MKG5JLOcqL0QDUKa+IX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(41300700001)(9686003)(2906002)(26005)(8676002)(478600001)(316002)(6916009)(8936002)(4326008)(66476007)(66556008)(5660300002)(6666004)(66946007)(6486002)(38100700002)(6506007)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uf8vkbjYqk5h8VdCyyx+ZNhFDirsek9hqLca0E138nL1Jm4DARVC4trwYNih?=
 =?us-ascii?Q?T5z7VtM2nuaZU/yxdOuD6Ixpit6CLNFfZg3XhRZP3ZjuIHrfGfsYTn5PS661?=
 =?us-ascii?Q?106QUfCBPljvEJ7evkMct+/snM4P7spw5qdBhGf4pePnLa/FkBYQB15XaoKh?=
 =?us-ascii?Q?2yfY/XuQvcV+wIYQSHzUgkV64WtagoS4hjcDzEps5S3+gP38rQdUqe6jF6QJ?=
 =?us-ascii?Q?tGKlpCwWomYOX5zQtBr7mmmMydW4Er2Z08OUiAA/B97qx+Owu9wXDob9i1EF?=
 =?us-ascii?Q?GM1O2a8/sJgBM+6FEVAaCH3e253l74E8JTRacvHci2Kbh+2aHUJctllDWT/V?=
 =?us-ascii?Q?AwjaU26QkzLLxu2Ju3ncxh9rfqf1yIMdMfuX2z8KEWyEIiE8XNGuS23W8C1Z?=
 =?us-ascii?Q?oG6IZA2NZTD+2K+FL4vOMMMR+bceCIuzDEzVdceWP87FMGN1CB3XZCgimWyt?=
 =?us-ascii?Q?+hi6Hn8OYnmY7X3bl6jNx12aN2P432l7xdrwgBLX7b1XU12+SN398eNu9wP9?=
 =?us-ascii?Q?cofZVNGDbDEZfKZpFemucTB00IU2nkru4XsmJGx8ofg3/H+1wAAuh8LI7JVX?=
 =?us-ascii?Q?FHi8l7uK0GPk83BfO4yF8vRI0JpYdMWYCKtf6jCnyHkAeU7bEecNHfWpmJE4?=
 =?us-ascii?Q?dL7lHPi871343k3mLymu/UITjVe+gfcjXmda25NXXd+nUXuGOsu++PR8Eie/?=
 =?us-ascii?Q?PVIQSMf1fNbdMLvCjdR5EN/FH8dILIi09n3s48AlGKnp3KlNn7LHLUu+KEzC?=
 =?us-ascii?Q?lFlcb4lNJ3hm9cFOJ5CmVohbhuQBs/6NeKkJjALFzIc0DrmvJ65qOhUcQI/T?=
 =?us-ascii?Q?qfsjYk87sGyLaSsCGuVmXHJGRaRtOSuYPF+WQgrW/rYsfMLczhcETsgbBKPG?=
 =?us-ascii?Q?MdDcJfVZzck/61SSINoZdF1ijAFk7EEdE9bBC19mA9LsHmHXWitiTtHjhoXh?=
 =?us-ascii?Q?gErT90jPqyjLeEaZHM6gsXYcPSkXPrNQ+ONAPUSt279g+GRh0sgbTgtjf/O4?=
 =?us-ascii?Q?3ieCMD+cCNwORyATbdzWnRJwz1hkCiGkEXGneVG+gDFPW/0gLVAodNY06wXd?=
 =?us-ascii?Q?JfA6CSq25tcMwbQHaAU5INHMvZ1O6eLgFzny465BiEzFcad/Ntn5HvT3kgKn?=
 =?us-ascii?Q?9zxAX8o7DEjuN5HsMBDirAchkVX9/oRS2lbXDfDWQJoDvRjngBbCnZz+sNX6?=
 =?us-ascii?Q?MC3d3pjJccT7D9IbxHq583C69nPJfGNqcyjpk8vlR/cBFGjfgBRs5gfFESBG?=
 =?us-ascii?Q?QQFpgCQhztvq3nrij91dK3R3ec3BnQ/qpOjg9XrGGFqS8l0gQJnABcm7Rr+d?=
 =?us-ascii?Q?H5ANQaaUp74muyaSTtsaH9UBVALeRNIBL3qRr60RVXJ8EWg4BuNNGOKn6Icl?=
 =?us-ascii?Q?dqt3cbwv5SkfbEy0LjH9TDr7RQW/t/KnOdhtnpeChTu296oDiDgtc3meNQjp?=
 =?us-ascii?Q?c6T5rBawaBFmJxejz0B2FwMYeYsDSFzsbYfImVvEEOmJuQqsLFaTynpUyGX4?=
 =?us-ascii?Q?42FqqB075yNRBZw85LxmzyR60xqsxmE4e8lvqnoNpgR4NyC3PC2xx3pHXQQk?=
 =?us-ascii?Q?FVovyDEfOoenQeChWRGncIZioCB4vUhpym1YQ8GS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39074dc0-e532-431a-a4a2-08dc2daf3412
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:49:29.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCVbZ2EnfzEQnQ6NqUWylvky2Pa7gSOIGxh5lAD42npOoFDGGQUtj5RUxXm9OrBLcSCamf7XQiMe4C4gF7AkXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995


Sidhartha Kumar <sidhartha.kumar@oracle.com> writes:

> Use folio api functions from the already defined src and dst folio
> variables.
>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/migrate_device.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 9152a329b0a68..a48d5cdb28553 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -843,17 +843,17 @@ void migrate_device_finalize(unsigned long *src_pfns,
>  		remove_migration_ptes(src, dst, false);
>  		folio_unlock(src);
>  
> -		if (is_zone_device_page(page))
> -			put_page(page);
> +		if (folio_is_zone_device(src))
> +			folio_put(src);
>  		else
> -			putback_lru_page(page);
> +			folio_putback_lru(src);
>  
>  		if (newpage != page) {
> -			unlock_page(newpage);
> -			if (is_zone_device_page(newpage))
> -				put_page(newpage);

Defining migrate_pfn_to_folio() would also allow the removal of the
newpage and page variables entirely which I think would make this
clearer.

As an aside is there any motivation for making these changes other than
as a general cleanup? I ask only because I have been looking at allowing
device pages with order > 0 so have some of these clean-ups in a local
tree as they're a pre-requisite for that.

 - Alistair

> +			folio_unlock(dst);
> +			if (folio_is_zone_device(dst))
> +				folio_put(dst);
>  			else
> -				putback_lru_page(newpage);
> +				folio_putback_lru(dst);
>  		}
>  	}
>  }


