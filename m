Return-Path: <linux-kernel+bounces-113490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF78884B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A971C24123
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F41B7F58;
	Sun, 24 Mar 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5FxAHOy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD41B6777;
	Sun, 24 Mar 2024 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320291; cv=none; b=jERVFhierBE2/GBf8UEKKYUO0LivfefTnNsNhrgiNQ8IFaliOFBlUBoNX7hj9oCL3Y9QzOOqgHFailCJEew6IiuxfkDK6S1tMQNZOcwJQvrug+EwY3ErOZddjyuJLFLVLQsqJAvaqfXKzdgyCCd290rEOHoRAftZ449DpeVhZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320291; c=relaxed/simple;
	bh=ISYVX+LC3q7RoVBh1EY6ctQ+cVqU1BUoD9/guDypAa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOUbftQmgOMBTl5onvxDQVZVrp8YVYOSv25jy+4tXfKOnayEmasb5f1z5FmE4GfudI5347u8g20fbn5vp1WhOCIhBl/UjRii78GhUyCMKYsTc0cNK1vcKt/lkvYhJ9riAmDt4xIAXzGZ3VFWdTtNwPKbNOzBYef6lpjBU6Mc9kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5FxAHOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CABBC433B2;
	Sun, 24 Mar 2024 22:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320291;
	bh=ISYVX+LC3q7RoVBh1EY6ctQ+cVqU1BUoD9/guDypAa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5FxAHOyJT3kL3KIOHYOJ74J3nxJYFu99v7/tk2WtWpfsIwhlH0BYJ96Oyc08cuNH
	 4WkiQPu+c33S7iZm1XNiSN9DWeGD+Hnb97jfy0VCf0Ry/IG8+AVLQeP+LIfMs2KxAk
	 QpmIcFM1/WJnbTwl92f4MYh0/pTB/0eagEryWDxOPrnL/baeagpiX/3Cfbw+Bx1Khl
	 7kkbwQMoPrVDS75mxMcCRUlSpjWP24fXsaw4cqOXnoAXe1igkKMRG7BlB80sMAiJMy
	 QZX3ThVVKEy5IGiYmEZ5dQ6ds6dHtCN42jFOBaK5NAXd/AhtaRGA7rzDDw4M0hCxEQ
	 PNd9d02QvCg4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 599/715] cxl: Fix the incorrect assignment of SSLBIS entry pointer initial location
Date: Sun, 24 Mar 2024 18:32:58 -0400
Message-ID: <20240324223455.1342824-600-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 99b52aac2d40203d0f6468325018f68e2c494c24 ]

The 'entry' pointer in cdat_sslbis_handler() is set to header +
sizeof(common header). However, the math missed the addition of the SSLBIS
main header. It should be header + sizeof(common header) + sizeof(*sslbis).
Use a defined struct for all the SSLBIS parts in order to avoid pointer
math errors.

The bug causes incorrect parsing of the SSLBIS table and introduces incorrect
performance values to the access_coordinates during the CXL access_coordinate
calculation path if there are CXL switches present in the topology.

The issue was found during testing of new code being added to add additional
checks for invalid CDAT values during CXL access_coordinate calculation. The
testing was done on qemu with a CXL topology including a CXL switch.

Fixes: 80aa780dda20 ("cxl: Add callback to parse the SSLBIS subtable from CDAT")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/20240301210948.1298075-1-dave.jiang@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/cdat.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 08fd0baea7a0e..0363ca434ef45 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -389,36 +389,38 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 			       const unsigned long end)
 {
+	struct acpi_cdat_sslbis_table {
+		struct acpi_cdat_header header;
+		struct acpi_cdat_sslbis sslbis_header;
+		struct acpi_cdat_sslbe entries[];
+	} *tbl = (struct acpi_cdat_sslbis_table *)header;
+	int size = sizeof(header->cdat) + sizeof(tbl->sslbis_header);
 	struct acpi_cdat_sslbis *sslbis;
-	int size = sizeof(header->cdat) + sizeof(*sslbis);
 	struct cxl_port *port = arg;
 	struct device *dev = &port->dev;
-	struct acpi_cdat_sslbe *entry;
 	int remain, entries, i;
 	u16 len;
 
 	len = le16_to_cpu((__force __le16)header->cdat.length);
 	remain = len - size;
-	if (!remain || remain % sizeof(*entry) ||
+	if (!remain || remain % sizeof(tbl->entries[0]) ||
 	    (unsigned long)header + len > end) {
 		dev_warn(dev, "Malformed SSLBIS table length: (%u)\n", len);
 		return -EINVAL;
 	}
 
-	/* Skip common header */
-	sslbis = (struct acpi_cdat_sslbis *)((unsigned long)header +
-					     sizeof(header->cdat));
-
+	sslbis = &tbl->sslbis_header;
 	/* Unrecognized data type, we can skip */
 	if (sslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
 		return 0;
 
-	entries = remain / sizeof(*entry);
-	entry = (struct acpi_cdat_sslbe *)((unsigned long)header + sizeof(*sslbis));
+	entries = remain / sizeof(tbl->entries[0]);
+	if (struct_size(tbl, entries, entries) != len)
+		return -EINVAL;
 
 	for (i = 0; i < entries; i++) {
-		u16 x = le16_to_cpu((__force __le16)entry->portx_id);
-		u16 y = le16_to_cpu((__force __le16)entry->porty_id);
+		u16 x = le16_to_cpu((__force __le16)tbl->entries[i].portx_id);
+		u16 y = le16_to_cpu((__force __le16)tbl->entries[i].porty_id);
 		__le64 le_base;
 		__le16 le_val;
 		struct cxl_dport *dport;
@@ -448,8 +450,8 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 			break;
 		}
 
-		le_base = (__force __le64)sslbis->entry_base_unit;
-		le_val = (__force __le16)entry->latency_or_bandwidth;
+		le_base = (__force __le64)tbl->sslbis_header.entry_base_unit;
+		le_val = (__force __le16)tbl->entries[i].latency_or_bandwidth;
 
 		if (check_mul_overflow(le64_to_cpu(le_base),
 				       le16_to_cpu(le_val), &val))
@@ -462,8 +464,6 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 							  sslbis->data_type,
 							  val);
 		}
-
-		entry++;
 	}
 
 	return 0;
-- 
2.43.0


