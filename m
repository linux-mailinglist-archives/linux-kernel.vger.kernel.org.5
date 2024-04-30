Return-Path: <linux-kernel+bounces-164556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6268B7F43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE71282C93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C721181B89;
	Tue, 30 Apr 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FP8sgPBh"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F27175560;
	Tue, 30 Apr 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499449; cv=fail; b=JpEtaClrSWCi3kdGztWFE05CV6GEJjqxt7BXIfuHtUIdqH1G6dLqtQA79W36nMYxKTzFxQF16a1cSVctXNhRb8spHjkcgz2ge/mLIC1DdjFYZpvbzobC5lQAIMnixB+BAZG3qb2DQxfIT95wYYEoWv7vOg+OeVK3L7+Zju1Qq1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499449; c=relaxed/simple;
	bh=2LwJv5iF7Ve8FEpMKfocSdv1fseNhdC3+vjlXZ68oiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQguVY2vxvXytf1nJCn+Qmu+NLFUPYVPj3W0oKo9FrzemK4fxoszn4nD4frm6ZfPSB3DzlgqGZbd0a3/pjTfHXMcuZNpZtp7RiVSG02xgL2xjzHIWt2QGrGQ6NWCqsKpzwzHR4wdHvzPIdpvvR4HWX5121n/raDY5yPp0JTKqXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FP8sgPBh; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqT6BkpUHaO/rt+lRSPg1/sVGI+6Y5YIkwqI0CwsZJfPBopPo42mB6NsXS3k32i7zKDW9J+32mhgeeuOBv2FY54JIBgnpSxNoR438lG6ZYdR8a872C+ZAkqbW8KarQZnj1sDwJPA+OZQUOzx+5KsTN1jMVKfc5mm64f100dJb7J9X+RS6zibme64C7TQoFcWLLqBOavVzHik9h8FvqUayzTE8zFmGn1mI83vsu4jwZjd1ObkhjrnQgjxTtCxHLo+frgvMW+iqE2SlhVoHho+ZEhXZ4A0BHpCS/AtxZsRG6Mp7HTxj8QxBNJk7hRSsXfHJaAqpgRIFmPZPveAUCessA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr6r+26weRNw6SvX9pmdrMClTzEq/EcxfsOgnCrKFB4=;
 b=L8u3S3AJt3lZH+jyeNIJ9Z/eRPZOb1VDbeswnWkNxmHDZ5q/8XRgHCVh/IdQW3esw1YuDw78qKB3GinWAUeapyFEh7mCBBzPLQsLsD87Aby9QVq7Y2fPcNtepKUpuky4oiI8rBlwQ52aW0sR0CURTw0wxKddxFaMUH+/vei1ZvYzGT1S1v0PQ6owOZCIBaYGXcRYCveG3x8EpLMwvbOwxMaJip1q2fLwZtQ6+zYZp8uIDc7JmxF3faUnPvLodsZ4IdNkPprOWyg62bdxmkUqh23PfXZ/7IpCwZCsgjAsvrZK/zpiYuwZpiBP7QFy01bK/PTq7PXBZR1IR3vyKGi2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr6r+26weRNw6SvX9pmdrMClTzEq/EcxfsOgnCrKFB4=;
 b=FP8sgPBhop/Ekd3zYLZpBaIiQXxpsmP7cIcxnGo5rd68c4ijleOuQyoIoseS9Wx4wuIk78b14XjrD7sQajn8XzlUDuJwcxBM1nA9/gBm3ji7UiPyXM6/bMjAulp6cDR4iLKCQA0rui0LKpsRl1sZKicAzM7JIQzn7bgV3kshW2DuEI1LwaB8cxrDIqFPjRWu2ECRhckAbGjB6/U3JFwOaHNdrq6DeELNnSZKd0T/pXFR39oOklLX1YZvnv48DOJg5enoL8pTYyQTgTsr/qLZCMxiVCcWOWtZcCJPLgxibwbk5lGuciXtYmhi3agGnsCbO6x0+jmirnFZ0TtjqLdPTw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 17:50:40 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::abdb:7990:cc95:89ce]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::abdb:7990:cc95:89ce%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:50:40 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: "acme@redhat.com" <acme@redhat.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "james.clark@arm.com"
	<james.clark@arm.com>, "mike.leach@linaro.org" <mike.leach@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"alisaidi@amazon.com" <alisaidi@amazon.com>, Vikram Sethi
	<vsethi@nvidia.com>, Rich Wiley <rwiley@nvidia.com>, Yifei Wan
	<YWan@nvidia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Jon
 Hunter <jonathanh@nvidia.com>, Sean Kelley <skelley@nvidia.com>
Subject: RE: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
Thread-Topic: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
Thread-Index: AQHaQzFqj8OB2Vjf/EipAzIhMbFp+bFqE+DggBexEbA=
Date: Tue, 30 Apr 2024 17:50:40 +0000
Message-ID:
 <SJ0PR12MB56767ECAF499949C4689E91BA01A2@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20240109192310.16234-1-bwicaksono@nvidia.com>
 <SJ0PR12MB5676F0DC2CFBBC96534CDD65A0092@SJ0PR12MB5676.namprd12.prod.outlook.com>
In-Reply-To:
 <SJ0PR12MB5676F0DC2CFBBC96534CDD65A0092@SJ0PR12MB5676.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|DS7PR12MB5815:EE_
x-ms-office365-filtering-correlation-id: 766c7f53-9722-4ad3-6112-08dc693e0cbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009|921011;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+ZtXBhAKb6T8fsN09P9Ivk7mhbumUpF6BaWAAPHqe6psGQH1JpImfW02IqMd?=
 =?us-ascii?Q?MumxFLkRld+tafwKHb9joT20nDq0x9iQDX+Yf7Fqq5644J5AxtcWR919oZIe?=
 =?us-ascii?Q?mzQsIIYBgkT0fZVzspVw/M6YJHWaFRcKYffcEj6iK1779JwOuS6BxCu9H3u3?=
 =?us-ascii?Q?UvGE+AZvEvgipMkg7elvj+6sMauICrV7EYck7Ie56gjbaygFww7d6tSbEs0l?=
 =?us-ascii?Q?dCqbCi+5heiqH9O11/v1qmfhYUzd40zi4fJVeR7otPjGxPYsMdrn0rDfhBhD?=
 =?us-ascii?Q?UXa5iuSXlHNqQZ93qMO+YbvoBVbEXLIeV7H9AYm3vSBBHItZazJ/avde52B6?=
 =?us-ascii?Q?1+ysfl/XGsdC7POinQAHlSh1hsIna/wLo/IZXrXK0hIohVXJLIYlkGgfiZFs?=
 =?us-ascii?Q?+yc8PVrZv4BqbY036LzxPKjvqxlnrM3TzN9TIAzo+Rm1CXe8FQHg9uIhzNL+?=
 =?us-ascii?Q?bKpRhfXem6MA4w2EG0EOFZR4a7a9qcrlJqiWCkQvOgZD6Jk2OU/TpDR7Pmml?=
 =?us-ascii?Q?YQlBc1Gr7GtPvF/KK0de5I0DM2KDNLmc+gRqPbrmUspsg0yALk/BLqGtqLqC?=
 =?us-ascii?Q?Pne4/LQBzJhfCL3eRc+zrDg4IQbRROM2US9cC9loNfSDiRoa6XJELKGDgh32?=
 =?us-ascii?Q?AQiUQ0sse3mgb8h22tylASFdE7C/ac6SBEpmjROPmMIfK6hvhZH47ydDPBK3?=
 =?us-ascii?Q?bX19AF0M8DM1u8RMWZA7+5g3naiIxWn+n++5DY+bXdzYo5I0+bbCkRbgE9aa?=
 =?us-ascii?Q?fv3d8MaA7wYTxutRpV0FRWM/ajU4xgqPyA5jzrtghzim/cGxXSALBN+kA1BI?=
 =?us-ascii?Q?TRUlPaZUWPe7WbBczOvih+iMGMhDrn0QKX9/y5WpfEVIPvg9i/AjaVOJ2Y80?=
 =?us-ascii?Q?XLzosQKCQDsBVShf6pZw8MXJI0wunkyS3INp6j0vLKjsguRiRJIsGeX4Jkwy?=
 =?us-ascii?Q?8xUa2Da96r8jFG9Yi2zVLcQ5S7qdrelkHYbMRFLr6uebJTRlkzZL/6BVMFY4?=
 =?us-ascii?Q?rxICyMK1HE8RwGzAhr5/ZYQkgQD+vWvI2cRychtbQ7x0iRaojJ+S3DATnPlE?=
 =?us-ascii?Q?/xRAXRMSl54PbVoZAApNpE8gm2SLuOxry5LqAeC3QbpUHw5EHWnq/FAKsn9l?=
 =?us-ascii?Q?p0zX+RM26GDbZraWVvo1THP2+eXd7fTORpi6fxRu8gzC21VrfjlWDji4BvQo?=
 =?us-ascii?Q?5fW9hktr1zKCdoRRLPwV8kQe3iX1Nm5ummp4BTRpJGiWmGmbZ5ACj3l++u0U?=
 =?us-ascii?Q?NV/3E1aYNx0bpMvgqQevYfTf64ypeI/GgWuHXuhbsXrkibqjW1WOTCp0es3d?=
 =?us-ascii?Q?ZIB9P5OZzp9vI7+37mowyb0wnebjJYSY3Y9MSuORACGGuOq85Gjzevzd6zyB?=
 =?us-ascii?Q?ofSDh/o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?id5Zqyj2HY8qhio9bi5FgN62M1gTKmxcB30ycuA4rgT7zgstVeBSzsUwXCsD?=
 =?us-ascii?Q?7Mypd04i741/4UWpGipqgOa8eG6K4RdEV6KFaeWNnvyIk7oEjFnGQhCmvKm2?=
 =?us-ascii?Q?4hWRsNj3L3Fhua+WfwzYsSw3fXErbsuoRQa0BEIvxtmUL2YEOCF4Vh0MtEFA?=
 =?us-ascii?Q?5svBzfacelzvWw1sr/Po0O5oCfsrNKPCPkv53x3gHrbhPILPi1ZiPDOz0zrr?=
 =?us-ascii?Q?7Wjg9CbdpFYAc1LhUpOLpNGUt5DNuJKbR84gRwltIu3UNdM92VEkTSgFB8EZ?=
 =?us-ascii?Q?ZH9ZpTR3TEJuY/TUhBdaEs1UM9v2jlhT77sWmOhWh1MxSRNXKSR3mAKteDeI?=
 =?us-ascii?Q?CqLkjJDLnXKfHGTGx9l76agKt7z61GUO9R/ekO5LrWOucUtbV07pSBK2hNIQ?=
 =?us-ascii?Q?lqn+FqukdpiH5VGbXlQEBgJD+QIu0Yu6Wy0hgtU2Ui8WlAd7QGsmyMwDCA65?=
 =?us-ascii?Q?MtRrTSa/aTklQU2G7pTjbM2rWG+QH327vZ7j9JtIxjb9BIQ7FKgelQ+wrCs1?=
 =?us-ascii?Q?/BLgIdSg2rLxawO/Y3iPsqT3GJ1YOiYLvjkuipjuqRJC8fsMBGP91riXur/A?=
 =?us-ascii?Q?NSGfqdxxivQEi0gaV+kHKc7KtfCmWtDSLOoqmrahgCshMDGrFWSxRmGKFtRa?=
 =?us-ascii?Q?Q/3zQ/mt06hK8lFVtGEnMHandUO5AEYtMfiJJeAm+jTNr8CwdNlupe1im/Bh?=
 =?us-ascii?Q?b+mGqtX4sgDDlHJ+2VRmPE2ucNKKrRo7sukdZ8pDzH8uqxebFUmCXpgymqe1?=
 =?us-ascii?Q?4eBxN6oe8dmRFi7kAc+uhPB9p5n8RiHMnOPQcLCYNamRBPpjJ6PdUv7x1V3d?=
 =?us-ascii?Q?lI92d4bU688/GwJQzPp1IthTAW1vYozULYVMqwimyL1lNgOOIZ2TM0reuYwg?=
 =?us-ascii?Q?Yt4Rxw8lVApvSb39qpZvGMIX6tEfDTDTA5CXBraab2JJwolbMlZ3RmZZ6ESg?=
 =?us-ascii?Q?XRJGyN8I5O9TlAvmk/XfNqvPj6Zo8Dhlbeus82gjre4t14MUpGpyF9Cfg+ZM?=
 =?us-ascii?Q?PGIK7WkMSyyO3POtwrhVzxTk/XcGwr5feF6AUHY5q0bvJgBP6+ifjIFOePO7?=
 =?us-ascii?Q?wHWMD1EkYj8lAnWUwMHZv2Yo+WWaTrhClKB/XQ4DJmR2FHNhCu6vXAszCJHn?=
 =?us-ascii?Q?Q5B6YGkrnobWuLowdUODveVaOAyTdxOfmXwCXDSaXm/QJZOgpr324M8JWtL0?=
 =?us-ascii?Q?FgA+vbEo9/+8Fx3iLxySUByn7iZoNUcUxBUGcUQ6bPEvos4dVqXsmF26B/6L?=
 =?us-ascii?Q?ZrBqAC+y284Cf9rqJhnuG0WriBOfP9Y4cdYE9SO2qLTFpfEUo71PBUlfBjS7?=
 =?us-ascii?Q?pnPnfkijWKmtDdQoBmWncNoq4/ytBm0Nn41Q/vF64ClncZmpNtjcQktLvwZL?=
 =?us-ascii?Q?70oNrmWu0h5R12xzI35fpTn7uh5oNS4cerU0bYipzghKm/yr0wcrtR0Yaxpo?=
 =?us-ascii?Q?K2dlh4Cq6ac9H9TvJKsVk/64zIXbHN6ttfeKLpU90w/lZ79PKxSxeAhnSfTi?=
 =?us-ascii?Q?6eU+bdHemCS49Fo7DeQ0wW8lp5vxtgeKpGu6izBm9TTLIqbHS3q1e8h9zodm?=
 =?us-ascii?Q?vnjBPqFrjwZO+JyqaJJELzS9kzyPUoEdy/7kUzdP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766c7f53-9722-4ad3-6112-08dc693e0cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 17:50:40.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WG8qc7Qmeq9OtlTxMAhHRZlkePMIVJSfZh9rjxFgDdpWVL+Z/UtJUyF2lwMA2wuWsAqKGR8vNBbb1G/FG6/RVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

Hi Arnaldo,

Could you take these changes for perf?
  [2/3] tools headers arm64: Add Neoverse-V2 part
  [3/3] perf arm-spe: Add Neoverse-V2 to neoverse list

Thanks,
Besar

> -----Original Message-----
> From: Besar Wicaksono <bwicaksono@nvidia.com>
> Sent: Monday, April 15, 2024 10:57 AM
> To: acme@redhat.com; catalin.marinas@arm.com; will@kernel.org;
> john.g.garry@oracle.com; james.clark@arm.com; mike.leach@linaro.org;
> peterz@infradead.org; mingo@redhat.com; mark.rutland@arm.com;
> alexander.shishkin@linux.intel.com; jolsa@kernel.org; namhyung@kernel.org=
;
> irogers@google.com; alisaidi@amazon.com; Vikram Sethi
> <vsethi@nvidia.com>; Rich Wiley <rwiley@nvidia.com>; Yifei Wan
> <YWan@nvidia.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; l=
inux-
> perf-users@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding
> <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>; Sean Kelley
> <skelley@nvidia.com>
> Subject: RE: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
>=20
> Hi,
>=20
> Do we need any more feedback to this series?
>=20
> Thanks,
> Besar
>=20
> > -----Original Message-----
> > From: Besar Wicaksono <bwicaksono@nvidia.com>
> > Sent: Tuesday, January 9, 2024 1:23 PM
> > To: acme@redhat.com; catalin.marinas@arm.com; will@kernel.org;
> > john.g.garry@oracle.com; james.clark@arm.com; mike.leach@linaro.org;
> > peterz@infradead.org; mingo@redhat.com; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@kernel.org;
> namhyung@kernel.org;
> > irogers@google.com; alisaidi@amazon.com; Vikram Sethi
> > <vsethi@nvidia.com>; Richard Wiley <rwiley@nvidia.com>; Yifei Wan
> > <ywan@nvidia.com>
> > Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;=
 linux-
> > perf-users@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding
> > <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Besar
> > Wicaksono <bwicaksono@nvidia.com>
> > Subject: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
> >
> > This series support Neoverse-V2 CPU in Perf Arm SPE.
> > The first patch adds the Neoverse-V2 part number in kernel header.
> > The second patch syncs the kernel change to the tools header.
> > The third patch adds Neoverse-V2 into perf's Neoverse SPE data source l=
ist.
> >
> > Besar Wicaksono (3):
> >   arm64: Add Neoverse-V2 part
> >   tools headers arm64: Add Neoverse-V2 part
> >   perf arm-spe: Add Neoverse-V2 to neoverse list
> >
> >  arch/arm64/include/asm/cputype.h       | 2 ++
> >  tools/arch/arm64/include/asm/cputype.h | 2 ++
> >  tools/perf/util/arm-spe.c              | 1 +
> >  3 files changed, 5 insertions(+)
> >
> >
> > base-commit: d988c9f511af71a3445b6a4f3a2c67208ff8e480
> > --
> > 2.17.1


