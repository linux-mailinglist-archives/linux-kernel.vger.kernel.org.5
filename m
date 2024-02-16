Return-Path: <linux-kernel+bounces-68616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB5F857D36
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9561C22556
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A2A129A71;
	Fri, 16 Feb 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tKaHWARr"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78F7869A;
	Fri, 16 Feb 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708088883; cv=fail; b=F0Lhic7ML5Toqmacocpzlh/eSQ5X4wmfmgvPyhmXUILPIy9wsHS88CX+8LbHXaT5Tg0koXuIDTtcvrkrWHvKa0GhvdOE48v4UrNkn8TP3I4q1kbflv+hG5b9R+oGKh0moxGRRS+B6iBZ6JjmFR1Di8UFy3OhTQ5/kyQZtGns9mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708088883; c=relaxed/simple;
	bh=7B3r5JDwmwWB7THZMaKWzb2Lnvg5DdFnueEC9vEtN8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pXjHyXfKYiZSHHxV7uXPYPcsiD1zQG/BrS0/YvD48H/Y2c2utcK4RtIOvY19fRqyr9wINKYWqThzcl2BuLmFkSTNsoRiugRWcq69vq/v7c4OukPKLLIrvZY2xsfutdtd9LIcz+AlDbzdHuog3jZRliyddkROqoLDV+RQQznGbK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tKaHWARr; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5OrL28HTi7SL06ANn1glVq88gpn80NUKLPt6jh1ZzHcTOePaCbZLxhJvermo8Py1ZtfmT1+1V6LaoPLCguZ/FtNhsBTXXRZEF10WFLAIoDx1gQ74u5sioo0aS7zEnbI3fR5YxPFVrrtFgGXCzpfqGl5lFq3R1wjVNy8cflaeuhT+2xfujKlgDFvMBgbparIMwsGF3ivBu+wOQPJdtmHWfzWMY9g2MSUqzEkR5qVsFSpph+fyhOJSCHQBN2WrretH498RdFgPi+GGhxl87iCLe9qD2mhjHGBK7TGLw9ja9NITOwSWieMyseFZzyKl4CqQAn5FxqAVwTyC+yCPDJd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kWcGsv5KWBLzWKub0KgtxdiKf7sTl06c+cZt7U9KN8=;
 b=aqlodmJEU/Xe+UCxEr/yUbImF9eFfwVBbs7HCV1xdmaEZkJP2dNWtIV+1xHeZtQfhL80xs4/rPKxvdFT0wrNwf+wBdYvs3MfKrHu7sPnVAvtJ/LPkuAWK9JKXUcI9oJouQ6ibA1P0aTyJwT5KiJ+oDEZqhsAfjDJw0sa3ZRwa0Rc23v/Q5K1disCOF7EuemlhkH6kwaCIgEGXTahLY+gc8V50jomwwn5k01qF3Od8G7GGR0wfWaKiF8b7L+BXbt9RSIjAQvFjM94oxVzIsWqL1XxYQ+erRuMm6Sdd2Ie7BraE1Xu4/9mIZKPkw3i/A6Sm5OvrjyIbwAient4XM6GFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kWcGsv5KWBLzWKub0KgtxdiKf7sTl06c+cZt7U9KN8=;
 b=tKaHWARr2BroKQ+uufRj00GvI3m8vFokYpfEIfpIgoCgu77EPNdgBlYPFPwvHaT+vmJeqSCnkOWQwSrNkBxGffsunLi062cvlYRbCP5QVm8gbmtE0d8+1TEoHiEahs81p2bOe7KGSYEzFBFOgBrOvm+IVl+3uuxEqROZPbwuaZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 13:07:57 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 13:07:57 +0000
Date: Fri, 16 Feb 2024 14:07:51 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 3/3] lib/firmware_table: Provide buffer length
 argument to cdat_table_parse()
Message-ID: <Zc9eJ4-WZZo5-a8O@rric.localdomain>
References: <20240209192647.163042-1-rrichter@amd.com>
 <20240209192647.163042-4-rrichter@amd.com>
 <20240214173927.00002d20@Huawei.com>
 <20240214174444.00006c9f@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214174444.00006c9f@Huawei.com>
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 97155de4-5a2e-4a2f-85de-08dc2ef04ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iWqJzeJo3WSnsI5R6q0v1w17OVvqNZspxlOza4j1smsgYz9T4qr8D2nqKOyfA8CR2FjFUNVxCa/2jEAbdq6tNS144P31RCS93V0e/QgFyPykIjoFRmFYIBmOApo0VH+V8TSFMiIyjz1Y5cEkMz4zIb4QUXbU2mr/oMXLTBUctWXnM4t9nRBfKOiVjtV+QEcNCz2ahs8da8z+gGrkXHmbp4+YuenfwuXuW5VH7cF+vobuj1XDTxccd/kRjOOXdSFPcgNBWglaClbCNJlebD4bGvocsRQT6a141KePZaLO1+T/qnQwg9s9h/govg6mtlSuDsT6zLZ5KxmYdZujjzIY6tSe/bzV/iPgeBaaEFsYZ2plZKs+4sx8rbPsNfwOO2p9u2mXf/yr9BOODc0A9FjyxXFT/VWO2O5uQUeFhZqiY6BHSi8ZRWz1uvm1Qv5CvlUZxvEqBVMSbH1eqgwqyhwCkm8vGS0PLHM9DrdwfDHHIba+togQrAtRWDoqPjuV2Kn812qDCU0kXvlx/iTAjKCWSXx9SFKoKblTaQc9yfln7FjKYkqK4h6TSFdnji4XlH90
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(26005)(41300700001)(4326008)(6666004)(316002)(8676002)(8936002)(54906003)(6916009)(66476007)(66556008)(66946007)(6486002)(6506007)(6512007)(966005)(9686003)(53546011)(478600001)(38100700002)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WNDbrFwWq99xNnQqQESyhCYtEwJBprzfEs8+eG1OzV4QZrf9WBUGfIOjJmja?=
 =?us-ascii?Q?R9WbTpfGI3R73KDqIJVODdzOEjm4ETIhG72yFCZmVQ6nYMT+oJVVRyAYDvgM?=
 =?us-ascii?Q?6NLNtwSeI6eBAWhEGm68n+cstRnM2y1prhRrSn4cg79k6naJN25XqPDleJpI?=
 =?us-ascii?Q?ngJaIgKqUgl2A2OE8HfOsWcnCynmOdBGB3J9VvJ3JgbdbUnlwBqNunAFfehY?=
 =?us-ascii?Q?xfCqblv+AjWPLjXXM4XDuIdxOj6i7kjSt2YiF678rNBiFCAHe+4nByMoWVio?=
 =?us-ascii?Q?wCzKl++XP5+nM4vyT4urzzArm3wzmO/u0z2Brx0s9u0UZMc9kaecGq5vN8Hj?=
 =?us-ascii?Q?H0LEEl/3xXCCt/+MtM07T8G6zQ4a6yN7vxBZkOuMQs8L1lO7XtvBnqNOJ8Ir?=
 =?us-ascii?Q?kLsRoLPlS52S1sSan3VWn1KktBdKksz62LO4QJ+K0Rcm6QOz9E8igthTjWD7?=
 =?us-ascii?Q?EwCXA1pBYus+I+ag2Svq5F7lVAm3t2ME80pc8fjvFSy1BDKz1e0D2tgztyDc?=
 =?us-ascii?Q?gN/8v4/z4CO0PMb6rNcC0Eocz5ymi7fXfba51ClbUTnNdoODPQYMs+eMqQFC?=
 =?us-ascii?Q?mbI6UR+GaAQTbsr7AvNhLV+7Z+7N8jIKG/xVcOOizdQ/rNn/qy21Bu1Q25kA?=
 =?us-ascii?Q?5tRdDUGHKrB+xkp0oQ821M2CsyallLJ4l1zglyoKuPbzw+P3WKvdcZ1xe7DO?=
 =?us-ascii?Q?UbCXSgXGXDLdp2S1Sasz/8gDvoc2WrFda0oOWEQOf3GyyMkOacTa69yTyc7l?=
 =?us-ascii?Q?qQU7lNNazmFBpMDVX/DyLWnnaUt8jHc3jLCHPJViilsl3JKnJZiLse9fYkkU?=
 =?us-ascii?Q?CUOOLIFlVdiNz1SJVnHtQI+xbxnloZx6zo7wJGQvSDlXlRARB/nuKpNb2t8L?=
 =?us-ascii?Q?mvtNgc5QYbgENLkgBDxgKFWO2ZEr3KNj6r/AP/fUtWPBmkQSut6V5CWK2iPv?=
 =?us-ascii?Q?/m4NFvTf9qAKU5gcQ8DxkBRB24bRGiVl5TB3EadmVS3mkL4BMiAO7yEPWSgS?=
 =?us-ascii?Q?9LwBZZC4gVypVOYxk1C6vEaO+1uH1I1STy4YcO7Djh2BA3hxR2HYv/TFvSaE?=
 =?us-ascii?Q?7A4E8f+sZdY8WKYsO11TxcCiAFhYDyxSmr73t+uJ7urOGtiNo9Z7EByjyNmj?=
 =?us-ascii?Q?ACwiUY1Mnzy5dtgm4MBm1eUeE4M+uhjqcxiktCKoIWQXvIpX1MIaCWp+a1xS?=
 =?us-ascii?Q?QT8Vwx1piUMDvdkNqMRKdI8OLdjD3CYIVL1j5UYpxPeBTlKK+Ou/eTE6ZkJo?=
 =?us-ascii?Q?tjmbINiHUxRhYfepCS1ITxnjgvoGmVOIvIIveakuiDj8Dkbj6ekUXaRaS4ng?=
 =?us-ascii?Q?0Ntt7gozwnmos1Bfuyn756uTwoKVKS2P1Wacjj9T6CV226vW1lKRjQcHhW35?=
 =?us-ascii?Q?uB76d3v7XL8vGLreLjUH9h+pazyk+69/Q5sw8liYUtPI6bZCrxhk82ANKXu5?=
 =?us-ascii?Q?l1tTyCEdXM+XplUq6fYrI+WopNgBk0JpOOzJOyDNYj0rgjdeTwjuL82wiyM5?=
 =?us-ascii?Q?ZYc64Ry//8vZFRc7BBh0lBZihdlYBS9N7e5Shrz3D3uOlNKnzYW3un8kBvfu?=
 =?us-ascii?Q?FQooXFpdRLSNdk/inpJiADpWB63FwMWX21d6GWFc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97155de4-5a2e-4a2f-85de-08dc2ef04ba1
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 13:07:57.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PX3ife/oCyPDsU0c/2oXNO0lnqkW8gNEi7ggUwnhr296qP3QPnpnPYM3+jbbPWiArTpTeMhAzcZObF//XHcmVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344

On 14.02.24 17:44:44, Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 17:39:27 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Fri, 9 Feb 2024 20:26:47 +0100
> > Robert Richter <rrichter@amd.com> wrote:
> > 
> > > There exists card implementations with a CDAT table using a fix  
> > There exist ... fixed size buffer,
> > > buffer, but with entries filled in that do not fill the whole table
> > > length size. Then, the last entry in the CDAT table may not mark the
> > > end of the CDAT table buffer specified by the length field in the CDAT
> > > header. It can be shorter with trailing unused (zero'ed) data. The
> > > actual table length is determined while reading all CDAT entries of
> > > the table with DOE.
> > > 
> > > If the table is greater than expected (containing zero'ed trailing
> > > data), the CDAT parser fails with:
> > > 
> > >  [   48.691717] Malformed DSMAS table length: (24:0)
> > >  [   48.702084] [CDAT:0x00] Invalid zero length
> > >  [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22
> > > 
> > > In addition, a check of the table buffer length is missing to prevent
> > > an out-of-bound access then parsing the CDAT table.
> > > 
> > > Hardening code against device returning borked table. Fix that by
> > > providing an optional buffer length argument to
> > > acpi_parse_entries_array() that can be used by cdat_table_parse() to
> > > propagate the buffer size down to its users to check the buffer
> > > length. This also prevents a possible out-of-bound access mentioned.
> > > 
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>  
> > 
> > I think we should scream a bit about this if we see it
> > as I'm unconvinced the spec allows for an implementation like this.
> > 
> > If the spec is unclear, lets seek a clarification.
> > 
> > I'm fine with this as a defensive measure, I just don't want
> > device vendors to keep doing it! 
> > 
> Scrub that - I got around to checking the CDAT spec. It can
> change length whilst we are reading it due to DSEMTS entry
> counts being allowed to change.
> https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.03.pdf
> (it's in the description of the Sequence field)
> 
> Sure we'll notice that the checksum fails and the sequence number
> has updated but that doesn't help us if we went out of bounds
> before we knew that.
> 
> Definitely good to check this as I think we can hit it even
> if we don't have a potentially buggy device.
> I'd still like to moan if we get inconsistent sizes and it
> isn't a race though. Can we find a clean way to detect this
> at a point where we know we have a valid complete table?

I will add a warning about a length mismatch.

Thanks,

-Robert

