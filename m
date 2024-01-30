Return-Path: <linux-kernel+bounces-45476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7B684313A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1D41C21B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8505F7AE64;
	Tue, 30 Jan 2024 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="hxZ1fDQS";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="EsSP+gR7"
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663F78B71;
	Tue, 30 Jan 2024 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.138.35.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657212; cv=fail; b=EY5dlY+vJOSS/vsYDxpNB1UYXO5NU27kaqNB5541Xm4CU3U6/0GK/J4bwuWNpGhZJ+kyN7ZrUt3lSntHKV6THkAhkIGChGoFWZLgYjYDv6DkDGNnoUe8JnfhxaoivUAgvDp4U/Cg7AQ8VBtsoCfn0uRzYZ7VuhcAPUFv1roEA4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657212; c=relaxed/simple;
	bh=nJP9IIj5h1Q95MJ5UjYhAvRPqilBUF+6v8pRNeIRICc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QeXmAMsPPbEToKdEOjNnxCQeAm5gJwgZX6Az2uNSM1IObUpzgYjEAX0sAfegjnku0FPXWFx2vrIeQ5p8mIGovUwnJF4o0SM0m54k24goczq6vehHxYgBKpUbstQS5B+uK9+Z/Kw7ibRnpNHhqcX2TvIa4Ik0/fK5qmsXskoQK9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=hxZ1fDQS; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=EsSP+gR7; arc=fail smtp.client-ip=139.138.35.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1706657209; x=1738193209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJP9IIj5h1Q95MJ5UjYhAvRPqilBUF+6v8pRNeIRICc=;
  b=hxZ1fDQSEpcb3BGeUbjOqaCaNW4WhOD8ZIl2i9deVbtleY0VQeDXLrOF
   xUfi2hjQ6p2OxTk9Qt/aT4IxIql5irC/Ox66nnLPgTSwkKGzcHrs1ST+q
   SAux2Wyr07XAGjq6DPQSbBgWJmVoHxKZDbtf2d5e7ndKbMp6gLLyXpr/0
   g=;
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 15:25:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJpAL5txBuIxNH592uHXUt+tx/AQxDjXRqgTIGxAZSM01hFF6+ZODmFmDhl5E+PYw7IaIvJXgzWc0W2U3DGd8x/CvmyGcff8ITu2CyGY9As2E0fZI0nm3DRa330FTsxzhgzGDMWIahSS3yucqkxPnlstPmLk0Z02YO2IJhA3lfutnjd+c/KN1hRvrfx6CDmPalX35bC3uPF6YfSvIiCweOsYM5KTxMGElmxX64nxMJxSSKmXlft/lOc1EvBaz6lMrF3GW1L6csLggxvfPYkTLC6fmLeBSdStD/btfOAe49cQ+0CoKuBndW94BM7UQA8TiNAhzuwcWxdPLj4t9801RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJP9IIj5h1Q95MJ5UjYhAvRPqilBUF+6v8pRNeIRICc=;
 b=X78XFdTL8wrxQ42BtU8SmhCekP+2DnqHUnVq59dHG7huTGmge2yTX71KvCz97IZErR8xMxgZsmx02K79C2+rp3OM1HNY6r/Dq0iUOrZCCgAbPmYzx7zPnHfqVkRxiBcKwAc5xSGgHrGhelIfy6+BbTLpZ+e7cejI6JTHs2ZntqU7O+OVZGNchTpmxFlS5TpcF47xx2XeZmbR+kigoaWGOWfZeLjIO2BJeZ4tvcHu+hYGOlQbN40a479QWfDw31nJMErFXGv60IuvheLX3wO0ZoG3DlX4aVM29Gu2AtVhkUYl6TdYqG6nzt6ah2FfF4AlVH0CjYdRO7rB8dcpKPSAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=seagate.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=seagate.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJP9IIj5h1Q95MJ5UjYhAvRPqilBUF+6v8pRNeIRICc=;
 b=EsSP+gR7yImJmuKbzel+jdEFeG28Gw3ErHaIolRz+K5xvOrOrpBJ0SiTKlot6Zp831wImWRS+KdvR+ijFJFCaIfQwWeuFZ4eeYOUXbTMaAIZ3bGXQC8VDhAoPjbAzsPmHPx+CUdvYSO3YxzxngfNVBdvgE9sAS/dJBB7lXGXfao=
Received: from BN0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:e4::15)
 by SJ2PR20MB6722.namprd20.prod.outlook.com (2603:10b6:a03:53d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Tue, 30 Jan
 2024 23:25:37 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::26) by BN0PR02CA0010.outlook.office365.com
 (2603:10b6:408:e4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 23:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 23:25:35 +0000
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
  by lcopzesaa002.seagate.com with ESMTP; 30 Jan 2024 15:28:53 -0800
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="96026012"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO nick-desk.colo.seagate.com) ([10.4.50.11])
  by lcopiesaa001.seagate.com with ESMTP; 30 Jan 2024 15:26:39 -0800
From: Nick Spooner <nicholas.spooner@seagate.com>
To: rafal@milecki.pl
Cc: dan.carpenter@linaro.org,
	evan.burgess@seagate.com,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicholas.spooner@seagate.com,
	srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v2] nvmem: u-boot-env: improve error checking
Date: Tue, 30 Jan 2024 16:25:36 -0700
Message-Id: <20240130232536.1194952-1-nicholas.spooner@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3292ae5e-07e2-49df-81f7-74e1b5e8dfb3@milecki.pl>
References: <3292ae5e-07e2-49df-81f7-74e1b5e8dfb3@milecki.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ2PR20MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5c8e17-5826-4d7c-dfac-08dc21eac2e1
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8tQMUvTb1SviOTkFLvqvslFmooZrOYMOMUfD7zqzQbx9HsMWhyK/q1PNPHl/jrhWU03uZyXfWevb1DvxJBqY7U/9g/fv4JvLB8UxbOIrWs/v3l0AbBkJhwXSh+ymBALTyAhYCBk0aUvC9fJh3azlgCAKEkaoYJzaNINZNDsYuBOPxzsp0E/AYpu8Eem5T2SRVYvBb3LwN8rtQ64M/ewnS+8F3i9ZnCNAg+SSXc/+mGqbXfmBlIh+iWrznl5c2Hutcz2TvZQ0Q4+D/WUWHvVSbsWw3tQSxFEYV2GdiMe/PSP9H5tpvAPTUeCD3Di4aK/SlnY3Rn0iq8COQUEG5mZm7QCT8CUKA8z7cbSU7rUEL7lVom1leLPppU+1JTFQc2FMq8Gk2CCqVlZPESumNxxwM+QwPKRpExW4K/+xl9c4KylCc60UuWwR9dsR19u8XTYt+z9YLn1iOuYJXSXIwliKzmz+DPBCd9ZZawYAJdM2IhbtdwX7+mkgzEPtoA6IwlGgjJoe6+jq2dl0aA5KrjBod7o+oo9PD+KgTGDbFffk6xmt1rs3/KyWiRKHG75cdW+xDYu2B8oa1a6lbO4+avITxpsbG6oxCnm/3IG1v3JjexVcMTK26QHAik4UnD+485bXj12MR65ZzQWkkavQSexMbNurKLbwqciFsS6bHlYmu0GeaJ865LI7/iFL3B9BRSL9BHczLPVwUt1n+YXLdqxzad75aMLq+Vy3M4Q1J2O4HsV0i2pT5AegCq1ine8LP6QUm4bw4/RqaOFVhiZPiJho5Q==
X-Forefront-Antispam-Report:
	CIP:134.204.222.53;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:lcopzesaa002.seagate.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(2616005)(7696005)(6666004)(478600001)(8936002)(1076003)(47076005)(107886003)(26005)(426003)(336012)(4326008)(450100002)(2906002)(70206006)(83380400001)(5660300002)(70586007)(8676002)(316002)(36860700001)(81166007)(356005)(82740400003)(34206002)(86362001)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CIRJDzW82qPFmtRtorlPlCZS+y+R5UaDE2v9g09Cp8sQlApMb2wqSTOa2niToE0xOgrZpQizl8kiDnUD/a4EoGqyiYUMYIS8cfPNMWw/eH1ZIt9s2mVu3QI/ow4ewRPgAzYs0NrWb1t6xegBwloLzDhLtHm6h1DOgy1BSeFBbPHqAGgn2RT23xD5lvUSMOKBa3AhlRAqOQoAFqlwVQIp3BrLsmKminLc9xYP8FUZBuqrlnP1mdoelt6XjclGlIGObUNFPyAYcWr/mqfTuXeO7mUUFhmas2g+sI/ha/5UpuxaCnDvB+2gHW0zYoBQe4y+sqxL7oq9zjyVGxStsoIOvkgpSsMANJzMIlLy4/lXR8AWI0pWdfVovSDlPSEbe2/KXs5oam2QyoxkwV1nOIYOcJ5ovGd7j0EjXU4+6I86YJrBkyfuZgHKQmtxLVh7ZnGafFQz7h93foN0H2pNrOY3Aw7wQCnqvybVWGsjIMkQHgZ1cCoACW06B/SN4VLwe6aIzZj+ph/f1NwEL3jWXzJuokW38xX8KHbklEt3hLkEOKGfJ7m76sq/MX8wI0U5BzJkhxLV1gLbFMJsjQljupASJ6bnAUK9qsEEjO9QjJA5yQOd9FUpxlgxxlOBwSg5O1VQ
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 23:25:35.2914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5c8e17-5826-4d7c-dfac-08dc21eac2e1
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe;Ip=[134.204.222.53];Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB6722

Hi Rafał,

> I'd appreciate description why do we need this change other than
> addressing some Coverity report.

I've been looking at Coverity for bugs to fix when it was brought up on
the kernel-janitors mailing list as a way to gain experience with the
kernel tree. This issue stood out to me specifically because all other
instances of nvmem_add_one_cell (in core.c, onie-tlv.c, and sl28vpd.c) are
checked for errors. I figured I'd add a check for the one in u-boot-env.c
so that they're all covered, but I understand if this is a case where we
don't want to try to fix something that isn't necessarily broken.

> Should a single nvmem_add_one_cell() failure result in not registering
> NVMEM device at all? Why?

I see that the only place where the return value of u_boot_env_add_cells
gets checked is in the same file on line 192, where u_boot_env_parse sets
err. The only time err won't be 0 is if info.name causes u_boot_env_add_cells
to return -ENOMEM. So is that the only case where err should be set, or
should err report if any cells failed to register? I followed the logic
backwards and found that .probe is set to whatever u_boot_env_probe return,
so I'm guessing it's a matter of what .probe should include or not. Let me
know if my logic is incorrect anywhere.

Thanks,
Nick Spooner

