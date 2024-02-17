Return-Path: <linux-kernel+bounces-70098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C12D859303
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F86C28295D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671580032;
	Sat, 17 Feb 2024 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TYi0W8Tr"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D167CF25;
	Sat, 17 Feb 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708205997; cv=fail; b=ItwYznKo5TC05w2wot8YUzSWi/e5ulQGcVynhNEGopLo/W6dFUx86iOw1bpliDAK69qIcnW/Hz5hLo6UIjUq1UK/nkFGioa4aRcqXzOHMQ4k02t76rXFs4IjcFf7SfeyJNzi7WHvPu9GMf9uqaE45sFE5wzCCJXtaYnwjL56EEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708205997; c=relaxed/simple;
	bh=NeJBaR+APTSi8XXWsJWKkW/d7K689YVKb1Ak3TFgyio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UT7dUtU5Qs6+fTdFMPBfvXql7ziCGzuK2Z4Fd4wktDVj/vrYfz4asukjqYVaughVeWLSKwAk9JR7VnL/wYPygjIXCBIKPSqxfNdvc+woVOHui2/ZAVS4KQkM1B5Smom8bTbG4QWhlfS7GY2PN7RtoCGB1akqH2R3DnabhwbcA8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TYi0W8Tr; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdqz135lPCcN1fJSZUEPU0FFxjQ0WP7Efmxekgv97LLsK7Jr9wsEIiYyYEOURuh7H6ru8xMXEIBiMcdFd5E/91EJ6ZkSEX738CwRow2u6aVXg2rV6PNSlEJQ8b7WbjY2U4rtebQ1uBwDXHAZcDNn3ABMEFP2SvLCWJCg9nxEoMHmDS4kHUiz4b7RMkUFQjf5QrYd9XOYZFDgeWlxg82PxZffLzGyqnz6DoN6cWEKg1r9W8cKU0alCcWBG6k1yPg+MCtAk/ZCZ0bYHNQG3SMaTKncXSeRR/Oak7mMmkbToPBQQzW3KIC2acN7QkqaeFJFpCckZ9EDv5CJuL4iFb2ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IUxS0vz7ZMjwl1gq7iJbtf9ZXuEVAfPpgejAJC9b8w=;
 b=jlezBCdWUmX2ffWyjmbsfxuFc0MRe2vlAJjTaSEzz5enGbUgZQyo5TlqkuaOLPW7skXv8XFc7NrrAZCi3dA/KBlzQyWxWfLievWTuNW4oCjTReqbZcs7pdAiKZM1F9nDbclCtYRJAuruQGxXjLzv3ka1MUCjcy+6C2/+iLR3OmB1QrTfWsIrUwk2Q6egtfnwqv80ypvvSYzu7mOYTWPKYZ8pqc7xFXrO1Wr0m+HCbxRGXgmurH6GMP5VKjDvXrh5cSGFAtOW4stmSA/x6AXelQG8kOS7I0gyJdjTXjM2lthgxU9fSRwRGzNJtP9M/gbdXOWvMevHliFtjNV9dzxKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IUxS0vz7ZMjwl1gq7iJbtf9ZXuEVAfPpgejAJC9b8w=;
 b=TYi0W8TrfhVPE7KnhtlqHb+qY4qKqC+qJNPnb1Q4Je9dgnA+35ZM0VplLLIRG2H6JRG6rHmKazvp56EgyIOXYsbbHN/zXMgWVbXTRMqeHY8xkBd2shGcuGeE31qicjdjas9CNrBPfioQPkftpKkV1H9A713AlSkc3KrF9JfgMqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Sat, 17 Feb
 2024 21:39:52 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7316.012; Sat, 17 Feb 2024
 21:39:52 +0000
Date: Sat, 17 Feb 2024 22:39:46 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: kernel test robot <lkp@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v5] lib/firmware_table: Provide buffer length argument to
 cdat_table_parse()
Message-ID: <ZdEnopFO0Tl3t2O1@rric.localdomain>
References: <20240216155844.406996-4-rrichter@amd.com>
 <202402171817.i0WShbft-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402171817.i0WShbft-lkp@intel.com>
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e1a59f-79d6-4b1b-07e7-08dc3000f98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tDiBkjMzk0gICUCz/CAvYGOQE6CLrFPtkhT/+EDsZmIpH9omFQHlbckjN741BmqzpND9CxNHXVqgECIhG5kEgMJDODwQ14Hd8somkvpLJ0DfqT8Wm1flDliBmA5tiGHq/jMPRxTadiLlwqlvbkbyQiKFAo8f6nngYQ8sE0ePDDprqNHRwU0WI12XrI2dJj7pDFLHHxz2FYF9FZkspp2NGPrmhN0YIIz84MPNHGQ/+20fMwmdmuFWog43TxYYlO3kMiOD2aphQKk9fJoNPpxzN1QAmiBM1BM18d5Bo3VoNzTXDjFfwS6R4CAqm13kOIXjIWWSkclOiWtXsglnKgEYhWIkHpXi+cZ0sVoKzFmCWr6XUIqDvmjzwfv3J22Tj77vsVOyKASVMC1qqg06Op9VRXbKU0lZ3MXkcPb0HZRrv2CaoLGyfdrDmf+J8RmA8psNZHdiSrypZcLFhKkK2ierRC21pp0rlbUyfvpI9ksuKo2ywKHt/kdjLFNFtsWF63CZ7Y0bjqs+8MW3z92b0niPWD3bdoB736AEWO3IXS85Rz83YKDK5HunGPPL4amjG7Lc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(7416002)(4326008)(9686003)(53546011)(6512007)(6506007)(6486002)(26005)(6666004)(66476007)(38100700002)(478600001)(966005)(66556008)(66946007)(83380400001)(5660300002)(8936002)(8676002)(316002)(54906003)(6916009)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Ywrt9L5MTLO8rwuHr1iqTDC/B0so5um2ZQ3CbDX5+b3Qe8+TNZFS9LT7l7Z?=
 =?us-ascii?Q?ZWf0Ybv1mdUgfP12zDIsy5YIqC0FS+u5XQ+XKyuJFP502tZFuM/6yZhFsqOp?=
 =?us-ascii?Q?V00krcJkM4fccByn/sZbzAUMlWLV11tS6Cv1pt5lKyFBE2kHXjCQVyCKV9Yi?=
 =?us-ascii?Q?Y3b6KCnyQ7/w1qjg//qiL6rcJwBqNf2cXtw97ueiAEK0uFmvFEYmLOgXdLv2?=
 =?us-ascii?Q?FWJt76sPOsurcDaSiwjegNBgYLiWLkYH4efZ5wjl9L/mC+8PALxY2k9t7HPR?=
 =?us-ascii?Q?4Ue6m/1a+6g84UPsc/s5uDRxX6AERWezSSF+pqhZvIRA+8nYWRxn5KD1k/It?=
 =?us-ascii?Q?+B/rbl7ayz3Gmq/CcEUG/e8O84SzRGrUs1rzErqDkMTiX1nSKf0tK30Bq+bB?=
 =?us-ascii?Q?exos4EDz2VpmKTo9hk4lSXukp9xDPRPzrrSBrHGkwodwnYIWBtqEvA1Y1Ez7?=
 =?us-ascii?Q?gHJ9FdtH7UJkmcuTOut5h85Fwc2MKuGKCnBqKWvxFQvFgZTNe+M0M0hfPJhM?=
 =?us-ascii?Q?3ykd5GwfzUB/MhXNcP2w6BgsABatZvMSLlgQcl0HQXT9XDbOG1HYBVeURT6z?=
 =?us-ascii?Q?kENTd8vtA0UNGf8fswxGm5VgD4OalAmOWCag8kGGq6aF5jerBa7/Cvkh+7M8?=
 =?us-ascii?Q?qdFDY0MSQbopBkXr21LGsfs0juX0Zr+bum+wZcJTUGzWgSYMLNpvAFEhrMGP?=
 =?us-ascii?Q?dachAhze/x+Zw6wri19sjPrU80mMWTUAdZ+rIxR3uDL7H0NLypTwDCZJAfcW?=
 =?us-ascii?Q?hBghQU29VBxZzYjLDacfsNo0xDzXjIZs+sCASLL2tmwbiBUBkn7Aluzl7124?=
 =?us-ascii?Q?5tg1Jx/F2H+s3p1OLroqnx7a+C18OcgIxw+AF0/Z3FBhVuTCG2XQDb4YWVXP?=
 =?us-ascii?Q?JibpXbDRDNdMcnIVxDRM8Vwr2Gjhm7AcnJnjbFbteoyWJOyMnUcIM+TUm0Qo?=
 =?us-ascii?Q?O324hNTaojMDckdfPu5QMBfxUdZh5L8G1nhDAaKpa0XVSbsCmpKTAWWmdVCx?=
 =?us-ascii?Q?DqOdj3Tu5TnFzRxwaEmwWb2NPSD+zBvzpjUTEv9IkA/UjmXXsqYDvwj6UR/f?=
 =?us-ascii?Q?w4haM8hCX40mCs+pOv5Z5/zZjW5f7oJcRLvJ/MKvAz2rrFBfYr4oHzzJ83iZ?=
 =?us-ascii?Q?exqMwVzRlJ/Zn6XbW1hPneBbf9CgtrFEXhCIotJxNI2JKHZfiZCq9r+L/JG3?=
 =?us-ascii?Q?7+r7/fs5J+Q1Ks6Ry4ksqbxpW6nfUMUQAhFAiawRu1iPEDpgopEYs11mIw48?=
 =?us-ascii?Q?S/ZF6BknCjO2RLBMTsWhxpxlPYdoi51LCIxRuv35atwk5tmmeJXGu43xMTg/?=
 =?us-ascii?Q?I5iXqnxTtYNZUobNsHl4U90hU7Pzd01/uTY+gzq05FdOtk3UHBi4Tzv4OtvZ?=
 =?us-ascii?Q?CNS0miJEricKOod1KMDujLRB1QioH4uKs/PVNHOdrzwZSVHmPKem5vOdrU9p?=
 =?us-ascii?Q?883a0FcFvqjxaQjrdYmChvYAm14RV6uM2YQbOlsnyZ9iVPpiW6aCjMbv//89?=
 =?us-ascii?Q?VJk27RZvQmGDSVaON3cWFzGlSXc/GKWltW3tojlZukudmeiFoC7+LsZ1VExu?=
 =?us-ascii?Q?X2Lqr7XTv4MUeL+VwLE92+aUs07R3rERw5e5V03z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e1a59f-79d6-4b1b-07e7-08dc3000f98f
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 21:39:52.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59B23cC/Pl0IzDwa8CUxniMi31oYfiQaifcOOfhRQjtMTzgISdebVPy5IzVQPeSD/QdN9RHWBAaQzY55F6sLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683

On 17.02.24 18:43:37, kernel test robot wrote:
> Hi Robert,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 6be99530c92c6b8ff7a01903edc42393575ad63b]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/cxl-pci-Rename-DOE-mailbox-handle-to-doe_mb/20240217-000206
> base:   6be99530c92c6b8ff7a01903edc42393575ad63b
> patch link:    https://lore.kernel.org/r/20240216155844.406996-4-rrichter%40amd.com
> patch subject: [PATCH v4 3/3] lib/firmware_table: Provide buffer length argument to cdat_table_parse()
> config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20240217/202402171817.i0WShbft-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402171817.i0WShbft-lkp@intel.com/reproduce)

>    In file included from include/linux/device.h:15,
>                     from drivers/cxl/core/pci.c:5:
>    drivers/cxl/core/pci.c: In function 'read_cdat_data':
> >> drivers/cxl/core/pci.c:672:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>      672 |                 dev_warn(dev, "Malformed CDAT table length (%lu:%lu), discarding trailing data\n",
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix below, it basically uses %zu for both format strings.

-Robert


From 08685053a91e370fd1263b921aa3e8942025c4e4 Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@amd.com>
Date: Sun, 7 Jan 2024 18:13:16 +0100
Subject: [PATCH v5] lib/firmware_table: Provide buffer length argument to
 cdat_table_parse()

There exist card implementations with a CDAT table using a fixed size
buffer, but with entries filled in that do not fill the whole table
length size. Then, the last entry in the CDAT table may not mark the
end of the CDAT table buffer specified by the length field in the CDAT
header. It can be shorter with trailing unused (zero'ed) data. The
actual table length is determined while reading all CDAT entries of
the table with DOE.

If the table is greater than expected (containing zero'ed trailing
data), the CDAT parser fails with:

 [   48.691717] Malformed DSMAS table length: (24:0)
 [   48.702084] [CDAT:0x00] Invalid zero length
 [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22

In addition, a check of the table buffer length is missing to prevent
an out-of-bound access then parsing the CDAT table.

Hardening code against device returning borked table. Fix that by
providing an optional buffer length argument to
acpi_parse_entries_array() that can be used by cdat_table_parse() to
propagate the buffer size down to its users to check the buffer
length. This also prevents a possible out-of-bound access mentioned.

Add a check to warn about a malformed CDAT table length.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/tables.c    |  2 +-
 drivers/cxl/core/cdat.c  |  6 +++---
 drivers/cxl/core/pci.c   |  8 +++++++-
 include/linux/fw_table.h |  4 +++-
 lib/fw_table.c           | 15 ++++++++++-----
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b07f7d091d13..b976e5fc3fbc 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -253,7 +253,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 
 	count = acpi_parse_entries_array(id, table_size,
 					 (union fw_table_header *)table_header,
-					 proc, proc_num, max_entries);
+					 0, proc, proc_num, max_entries);
 
 	acpi_put_table(table_header);
 	return count;
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 6fe11546889f..012d8f2a7945 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -149,13 +149,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
 	int rc;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
-			      dsmas_xa, port->cdat.table);
+			      dsmas_xa, port->cdat.table, port->cdat.length);
 	rc = cdat_table_parse_output(rc);
 	if (rc)
 		return rc;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
-			      dsmas_xa, port->cdat.table);
+			      dsmas_xa, port->cdat.table, port->cdat.length);
 	return cdat_table_parse_output(rc);
 }
 
@@ -511,7 +511,7 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
 		return;
 
 	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
-			      port, port->cdat.table);
+			      port, port->cdat.table, port->cdat.length);
 	rc = cdat_table_parse_output(rc);
 	if (rc)
 		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 763c39456228..4e07465bf29e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -623,7 +623,7 @@ void read_cdat_data(struct cxl_port *port)
 	struct pci_dev *pdev = NULL;
 	struct cxl_memdev *cxlmd;
 	struct cdat_doe_rsp *buf;
-	size_t length;
+	size_t table_length, length;
 	int rc;
 
 	if (is_cxl_memdev(uport)) {
@@ -662,10 +662,16 @@ void read_cdat_data(struct cxl_port *port)
 	if (!buf)
 		goto err;
 
+	table_length = length;
+
 	rc = cxl_cdat_read_table(dev, doe_mb, buf, &length);
 	if (rc)
 		goto err;
 
+	if (table_length != length)
+		dev_warn(dev, "Malformed CDAT table length (%zu:%zu), discarding trailing data\n",
+			table_length, length);
+
 	if (cdat_checksum(buf->data, length))
 		goto err;
 
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
index 95421860397a..3ff4c277296f 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -40,12 +40,14 @@ union acpi_subtable_headers {
 
 int acpi_parse_entries_array(char *id, unsigned long table_size,
 			     union fw_table_header *table_header,
+			     unsigned long max_length,
 			     struct acpi_subtable_proc *proc,
 			     int proc_num, unsigned int max_entries);
 
 int cdat_table_parse(enum acpi_cdat_type type,
 		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
-		     struct acpi_table_cdat *table_header);
+		     struct acpi_table_cdat *table_header,
+		     unsigned long length);
 
 /* CXL is the only non-ACPI consumer of the FIRMWARE_TABLE library */
 #if IS_ENABLED(CONFIG_ACPI) && !IS_ENABLED(CONFIG_CXL_BUS)
diff --git a/lib/fw_table.c b/lib/fw_table.c
index c3569d2ba503..16291814450e 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -127,6 +127,7 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
  *
  * @id: table id (for debugging purposes)
  * @table_size: size of the root table
+ * @max_length: maximum size of the table (ignore if 0)
  * @table_header: where does the table start?
  * @proc: array of acpi_subtable_proc struct containing entry id
  *        and associated handler with it
@@ -148,18 +149,21 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
 int __init_or_fwtbl_lib
 acpi_parse_entries_array(char *id, unsigned long table_size,
 			 union fw_table_header *table_header,
+			 unsigned long max_length,
 			 struct acpi_subtable_proc *proc,
 			 int proc_num, unsigned int max_entries)
 {
-	unsigned long table_end, subtable_len, entry_len;
+	unsigned long table_len, table_end, subtable_len, entry_len;
 	struct acpi_subtable_entry entry;
 	enum acpi_subtable_type type;
 	int count = 0;
 	int i;
 
 	type = acpi_get_subtable_type(id);
-	table_end = (unsigned long)table_header +
-		    acpi_table_get_length(type, table_header);
+	table_len = acpi_table_get_length(type, table_header);
+	if (max_length && max_length < table_len)
+		table_len = max_length;
+	table_end = (unsigned long)table_header + table_len;
 
 	/* Parse all entries looking for a match. */
 
@@ -208,7 +212,8 @@ int __init_or_fwtbl_lib
 cdat_table_parse(enum acpi_cdat_type type,
 		 acpi_tbl_entry_handler_arg handler_arg,
 		 void *arg,
-		 struct acpi_table_cdat *table_header)
+		 struct acpi_table_cdat *table_header,
+		 unsigned long length)
 {
 	struct acpi_subtable_proc proc = {
 		.id		= type,
@@ -222,6 +227,6 @@ cdat_table_parse(enum acpi_cdat_type type,
 	return acpi_parse_entries_array(ACPI_SIG_CDAT,
 					sizeof(struct acpi_table_cdat),
 					(union fw_table_header *)table_header,
-					&proc, 1, 0);
+					length, &proc, 1, 0);
 }
 EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);
-- 
2.39.2


