Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD077EF868
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbjKQUQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjKQUQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:16:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CCF19B2;
        Fri, 17 Nov 2023 12:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCbgZKzi3Mb9Ca5HWws7uqi6LWnBrAHq5mIA2cuRtRV9aU8I9YfkArJJcVZxNZi1Pc4Oo9tMK5/GZ+8C1kZ3cdfsYsvq3GAGF2MVRd5YvtM/+KmMATkZVJveTs+Zkez0tVM/MB5QTniU89kiSG/NtSyCaRxiEWUDrYnMrzeG1W80g69wI3lpuTRdvOuzawZ6Bxj0vXlh9ChirUZretTi3y8hG3W38iRN9gWO3ThkSwtQAUZRoxw1H8kbnvCH1I9D6EH28rs76uHbUF/bQk7NGhzdgC46tZdAdmJT+BY0UZEY5SaegqwkRdl7Cthc5HU5BeWGn7Y+VvJsNQlzzWn+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mhMu3XVa9U34TEQSnw8CdH2MCgx1O5RDKfbMFTwQSU=;
 b=kvgmF40c/i0ORw57cRKHxFGaJRIil8KKNhivMuQQ7M60S1P/WeyFz8aZFDzn+jCpBuAsXZZY/lb13OzcNJgTWtzKX6CJNF3siJ9DlPuVXrLiCjxeeX4vs4iBtipNGzcUo8IueYYlFq3NUpiexaYt/n70MzRn+10UXgJYrjlyZELxtd8kQgyMGw0rKiNsKfuvEQIhBB0T8K325M5kuZjGzx23itr9IhKfCH4/GQTkMAgVFVZbFgznrTH6w8gIAYE4JRtmjpLFWPA5bluaisFsP8AUZtznc/UBVLYgj/JgeodjPpkb8el6jSnGf0fWAYHD801NhZ/UiGXFqNoaDZaSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mhMu3XVa9U34TEQSnw8CdH2MCgx1O5RDKfbMFTwQSU=;
 b=frFgT9tPWkXehoAZw3lqht/sma+JutpBLYUy6bP6sW0qLH/ZO20p8VA8Rlst7PGwRIrI2NF14geh0h0NrgU8M2WrcfkFAuhrWexObpXBjU3/bWRW7e53636EBhUE+pQ+5nMLe/EXjAre3yyJXtRXto0cH5ON8VZ6T3IS1dNhrAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 20:15:42 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 20:15:42 +0000
Date:   Fri, 17 Nov 2023 21:15:36 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fan Ni <nifan.cxl@gmail.com>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Message-ID: <ZVfJ6Fxidvw_gz7r@rric.localdomain>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
 <ZVfIaNhiSc-yQZo5@rric.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVfIaNhiSc-yQZo5@rric.localdomain>
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 929f79f5-2e92-478c-1dac-08dbe7a9f975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpgSZGPJjiWF6U86nmbiKcWtyfp/qe4vV/Xl2oLW6RVHZR5YPqLEsrmjcInIwlch1BUtOsZi1PlgBB/Ec//k24r9eRC9gtqc4DYYWojH2PSgR3z0+VhCUwhCWulWsAo3T8thRFk/DfjsjFBfYk49JEGCtNmamVMwJCwfZsK3TcRp3oNr4qvjdMbL2jgOzF2ulYQAFuIK6e24HOPN2ixk0Jh5aufezgS42YGFU5JWUvVOcmmb/T6R4SpT20sa5I2DNMPUYbvht98GEy8/kfcGA1IjJeWfjXocjQYyWGXidUquX3g5nFkGlILyNs/QlmJJVVKFWiXSW+DTqpQH3wgVfEeHK1ZtpWP7Q04vQoLDvWedFTOJjWsSZa7o1jAxVw75Q9wz2RfKkIuaQXZoG1LLbYLq4uKgsc6B/ua+8A/VdMYhoL2rpqtL9jbgiNj08x2MiXx/k2WR1HldOoF3oCrJTdqa61oEK4uW1Mlkhr30i4jq8QOIs86G8xtNk4s7So7AEcalq280Eg6K0VNSk/3u8No7XtiMEnr6p5lJlQngMIVg3sFbxZCNi8DCqOKeb5WlvjOE6HO7SvNkAO7exN0eVowpbEB0rTm2kcjLUVPpGjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(54906003)(66946007)(66556008)(66476007)(6666004)(316002)(6916009)(83380400001)(478600001)(6486002)(7416002)(5660300002)(6506007)(53546011)(38100700002)(2906002)(41300700001)(26005)(9686003)(4326008)(6512007)(8936002)(8676002)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gEGK2qZZKSIiKLkob5Z4ttEaPvJcrPE+E38VZULwh0ioT0cDS0KHJ5YV80sk?=
 =?us-ascii?Q?66H8bZmIg8AaHn2hIdRT2oewvww56fNnyGx9UZNZ6a4aBiV6BeFfJ2QGi8cr?=
 =?us-ascii?Q?3c8QEaaXcbU2VIX7GGb6yKswX/9R2tdBWng6vWlMAZUlTSD8B1KlxWnhHuvA?=
 =?us-ascii?Q?eRO7nFbChT1t0NcdXAc1cuD/VQhNPT582lFqd7TFlIRTqiHLEjuJrOjiSjbm?=
 =?us-ascii?Q?xGU2OAecsohXVedrf9WsCBZ1EDrmjH8lScO5LwGxZFzBnX0x6MX3Ka9UsOEM?=
 =?us-ascii?Q?UVkFhqbfA42a5aRLqLNibFpujuzlCqYnM+5utgh7cTrr70di5YgOGzx8sf3G?=
 =?us-ascii?Q?T3PoMSZ38QcTuB36z1s3sWAOPBU0XmmdgBrlJ4R9sZ29UEQXAbzFKIEZLU/W?=
 =?us-ascii?Q?KGubilhovD87QAXwB5EGBx6PwksTY93E8QTGfPZP+jmEpog/sp8rhu9xd8bW?=
 =?us-ascii?Q?HN9Ki+XSTR4ALGi0xkFDp/9851+sKObNcTOVKzl2CeJsButSVxn7z0RkdMat?=
 =?us-ascii?Q?L0QTFjIz2ANjA9Q+pbYg7P00I9KKPR6sInB9BAqyWhJOokDNYdr6bynIE9+l?=
 =?us-ascii?Q?mgisV8CxvPFNBnxk+sWeXulf/OEJO2itm14XADVVzR/0oouXwD6IVKFENIFi?=
 =?us-ascii?Q?qytUp7FFtrf8r9XBDIyuaOwfZHzGkcbjXpKv9pUjW/1WlgcD6GucRe6lK1bE?=
 =?us-ascii?Q?G8382tZumP3A9Aj8/cxtCrGXCylhCxUVNvdkWMqX4fR24vIRHk770xe0fPvG?=
 =?us-ascii?Q?q9Op13eGMh4A+k63dBliDXah/Gq3i3r1uLXdqKXfLWr1933VW9ngpZDrb9YF?=
 =?us-ascii?Q?TtcmmcwzfrTxejjiM+5xH6nPRjEvKxcGgHaHJzheWw4bNt9kr7NdOwQVW6KV?=
 =?us-ascii?Q?NpIDUNGc5JSHQrB1RCmofLCIaJ/i6cRzcUVJhDJpK7QQh5A3cPFCt+IPmsjR?=
 =?us-ascii?Q?Q9qTq4e+1MAws9TWqiVhcdnZi8s7wkTj4z9O2Tq5U8uhpJ2fFM4FATqYq6rM?=
 =?us-ascii?Q?pz4v/9VN+htnW6TwUHUWkUCCcm0bx2WeTN6rRoTBokA41n3gWAAOUUU14a3f?=
 =?us-ascii?Q?sqAch7PyTTDh7kfoKjHlOcWtVtDuW9ESClRZlMv9Sr8rNNKbNnze2qIWdSyq?=
 =?us-ascii?Q?vdpWZqW9teNv0vfDq3VU9cxBlllNEo7qAmkw/WSSjvzSRBqmVYKExhFHaJdW?=
 =?us-ascii?Q?H22L/gR+YWpI00afTvNeGk4s9BVtBGbVAgIPQjOfv2cnWdyoiEjvhBesuZmu?=
 =?us-ascii?Q?yiuufXJ+W0d6PemJmPpZdwEj8M7296NiPrDI8fTTyNXSZaUqdf9lOf1D2iSR?=
 =?us-ascii?Q?837iH7txLGNLShr5bBVDeDI1rEMqMbjhUOVsVfaA1a+ONc9Rb2iAt2gZd/nY?=
 =?us-ascii?Q?nlbgxnS4nEX6Xgi+Wub3jMWSyX6+aLPWK595cYrV97xtnsbhA82z2LtEve+R?=
 =?us-ascii?Q?QXSyyh590QdNtdt87NswTmVhAJxwwtRD0s0/KoOJsOhPS8Rx/oCiioDtkfqI?=
 =?us-ascii?Q?trzwkvOa64u3xdg9bMUmLktS3oQdLaxBeuLbmL0rsuBttRj6+3w4+m/Cr6If?=
 =?us-ascii?Q?x1UW31LC2u4Z08rrb10XBoo1TwSrlOEwxzmTHY9o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929f79f5-2e92-478c-1dac-08dbe7a9f975
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 20:15:42.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb0S2ibHdmehFoYEiqQNTe9nZMzGW3tLpt9dqvvw7LUKFC58y5n5du8FA82I7N6jvbMqpLT+VtrQBR4eVVCIBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

On 17.11.23 21:09:18, Robert Richter wrote:
> I will send an on-top patch for 6.8 that reworks that code area to
> remove the pointer arithmetic.

Here it is:

From 13787f72c20b8c54754ae86015d982307eae0397 Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@amd.com>
Subject: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table

Reading the CDAT table using DOE requires a Table Access Response
Header in addition to the CDAT entry. In current implementation this
has caused offsets with sizeof(__le32) to the actual buffers. This led
to hardly readable code and even bugs (see fix of devm_kfree() in
read_cdat_data()).

Rework code to avoid calculations with sizeof(__le32). Introduce
struct cdat_doe for this which contains the Table Access Response
Header and a variable payload size for various data structures
afterwards to access the CDAT table and its CDAT Data Structures
without recalculating buffer offsets.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Fan Ni <nifan.cxl@gmail.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 80 ++++++++++++++++++++----------------------
 drivers/cxl/cxlpci.h   | 19 ++++++++++
 2 files changed, 57 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5aaa0b36c42a..f900740c6dea 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -517,14 +517,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
 	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
 
 static int cxl_cdat_get_length(struct device *dev,
-			       struct pci_doe_mb *cdat_doe,
+			       struct pci_doe_mb *doe_mb,
 			       size_t *length)
 {
 	__le32 request = CDAT_DOE_REQ(0);
 	__le32 response[2];
 	int rc;
 
-	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
+	rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
 		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
 		     &request, sizeof(request),
 		     &response, sizeof(response));
@@ -542,56 +542,54 @@ static int cxl_cdat_get_length(struct device *dev,
 }
 
 static int cxl_cdat_read_table(struct device *dev,
-			       struct pci_doe_mb *cdat_doe,
-			       void *cdat_table, size_t *cdat_length)
+			       struct pci_doe_mb *doe_mb,
+			       struct cdat_doe *doe, size_t *length)
 {
-	size_t length = *cdat_length + sizeof(__le32);
-	__le32 *data = cdat_table;
+	size_t received, remaining = *length;
 	int entry_handle = 0;
 	__le32 saved_dw = 0;
 
 	do {
 		__le32 request = CDAT_DOE_REQ(entry_handle);
-		struct cdat_entry_header *entry;
-		size_t entry_dw;
 		int rc;
 
-		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
+		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
 			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
 			     &request, sizeof(request),
-			     data, length);
+			     doe, sizeof(*doe) + remaining);
 		if (rc < 0) {
 			dev_err(dev, "DOE failed: %d", rc);
 			return rc;
 		}
 
-		/* 1 DW Table Access Response Header + CDAT entry */
-		entry = (struct cdat_entry_header *)(data + 1);
+		if (rc < sizeof(*doe))
+			return -EIO;
+
+		received = rc - sizeof(*doe);
+
 		if ((entry_handle == 0 &&
-		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
+		     received != sizeof(doe->header[0])) ||
 		    (entry_handle > 0 &&
-		     (rc < sizeof(__le32) + sizeof(*entry) ||
-		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
+		     (received < sizeof(doe->entry[0]) ||
+		      received != le16_to_cpu(doe->entry->length))))
 			return -EIO;
 
 		/* Get the CXL table access header entry handle */
 		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
-					 le32_to_cpu(data[0]));
-		entry_dw = rc / sizeof(__le32);
-		/* Skip Header */
-		entry_dw -= 1;
+					 le32_to_cpu(doe->doe_header));
+
 		/*
 		 * Table Access Response Header overwrote the last DW of
 		 * previous entry, so restore that DW
 		 */
-		*data = saved_dw;
-		length -= entry_dw * sizeof(__le32);
-		data += entry_dw;
-		saved_dw = *data;
+		doe->doe_header = saved_dw;
+		remaining -= received;
+		doe = (void *)doe + received;
+		saved_dw = doe->doe_header;
 	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
 
 	/* Length in CDAT header may exceed concatenation of CDAT entries */
-	*cdat_length -= length - sizeof(__le32);
+	*length -= remaining;
 
 	return 0;
 }
@@ -616,11 +614,11 @@ void read_cdat_data(struct cxl_port *port)
 {
 	struct device *uport = port->uport_dev;
 	struct device *dev = &port->dev;
-	struct pci_doe_mb *cdat_doe;
+	struct pci_doe_mb *doe_mb;
 	struct pci_dev *pdev = NULL;
 	struct cxl_memdev *cxlmd;
-	size_t cdat_length;
-	void *cdat_table, *cdat_buf;
+	struct cdat_doe *doe;
+	size_t length;
 	int rc;
 
 	if (is_cxl_memdev(uport)) {
@@ -637,40 +635,38 @@ void read_cdat_data(struct cxl_port *port)
 	if (!pdev)
 		return;
 
-	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
-					CXL_DOE_PROTOCOL_TABLE_ACCESS);
-	if (!cdat_doe) {
+	doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
+	if (!doe_mb) {
 		dev_dbg(dev, "No CDAT mailbox\n");
 		return;
 	}
 
 	port->cdat_available = true;
 
-	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
+	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
 		dev_dbg(dev, "No CDAT length\n");
 		return;
 	}
 
-	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32),
-				  GFP_KERNEL);
-	if (!cdat_buf)
-		return;
+	doe = devm_kzalloc(dev, sizeof(*doe) + length, GFP_KERNEL);
+	if (!doe)
+		goto err;
 
-	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
+	rc = cxl_cdat_read_table(dev, doe_mb, doe, &length);
 	if (rc)
 		goto err;
 
-	cdat_table = cdat_buf + sizeof(__le32);
-	if (cdat_checksum(cdat_table, cdat_length))
+	if (cdat_checksum(doe->table, length))
 		goto err;
 
-	port->cdat.table = cdat_table;
-	port->cdat.length = cdat_length;
-	return;
+	port->cdat.table = doe->table;
+	port->cdat.length = length;
 
+	return;
 err:
 	/* Don't leave table data allocated on error */
-	devm_kfree(dev, cdat_buf);
+	devm_kfree(dev, doe);
 	dev_err(dev, "Failed to read/validate CDAT.\n");
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0fa4799ea316..d12ed9d8dec1 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -85,6 +85,25 @@ struct cdat_entry_header {
 	__le16 length;
 } __packed;
 
+/*
+ * Response contains the CDAT only response header of the DOE. The
+ * response payload is a CDAT structure (either CDAT header or entry),
+ * it may also mark the beginning of the CDAT table.
+ *
+ * Spec refs:
+ *
+ * CXL 3.1 Table 8-14: Read Entry Response
+ * CDAT Specification 1.03: 2 CDAT Data Structures
+ */
+struct cdat_doe {
+	__le32 doe_header;
+	union {
+		u8 table[0];
+		struct cdat_header header[0];
+		struct cdat_entry_header entry[0];
+	};
+} __packed;
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
-- 
2.39.2

