Return-Path: <linux-kernel+bounces-118606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3BE88BD27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EC128426E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60856CDD4;
	Tue, 26 Mar 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKRv3eIo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EC25D478;
	Tue, 26 Mar 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443697; cv=none; b=pks+exN1K1khIC/JG7ivBA4/ovak87z7aaBjjHf5daBv49wdu/IznBQj5luAfvDTTeySJ3C8NZVZbaoydggIKCiYQfQz2JywazoBP/FUJ8qrWFSq4K1042t4WoBI7eG+t7NWD6Ay96oMnYcZ9c4v2d3EzdOh2i9SScLjJd7wBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443697; c=relaxed/simple;
	bh=YpGyFKWRZ8sW4yOOzeIlv+ObrG8dhHVBUJkwxWnaI3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OOlTqeEMvZnuvQHBc39S3YTqoqON0qEw3RGLHaMvbHJ+DHIWUMbcK6ppbLTjH1wcYjG8bD1tKhpFhZsFcoZsFMlEmx06Aa66jyBWTc885g4BqUp1116yygtOxbV7B9BhsuCAc7+ySemfWyuVHLsMO10X5by8OucSHIVbMvDyX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKRv3eIo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711443695; x=1742979695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YpGyFKWRZ8sW4yOOzeIlv+ObrG8dhHVBUJkwxWnaI3U=;
  b=CKRv3eIoMbYgO6Bu3Pf6JVm4E5XkL2XIK49LeYJjqKBc/PZWudsi0AiA
   xCHIGU5chiw6Bs9SpVyeCVjj2jr4wuOR7n6MRMlJa2UK7wVBFU2Ax23d8
   KvZM6eYexP5rnbCTAnquL+gA1xFSmjxdSWA06Hb+RA09AZCMvMqqK3Zcq
   r2YHokjPJhP1AItZ7u3SBk15OZZHjc/WkDWhMmziZ3wRnP3DOGXMvF9z0
   F7w1QthVB3nxLClSiTpoIDfz3yYoTD3e9ua6Kau2cJia1vf+eMnxSsQL0
   ewYA+kXeD3JQleeFSOeMdtwEY7UVN08wATiJ/W9RBZ3oLWcUmhu3Buq9u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6343362"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6343362"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20614522"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 6/7] soundwire: debugfs: add interface to read/write commands
Date: Tue, 26 Mar 2024 09:01:21 +0000
Message-Id: <20240326090122.1051806-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We have an existing debugfs files to read standard registers
(DP0/SCP/DPn).

This patch provides a more generic interface to ANY set of read/write
contiguous registers in a peripheral device. In follow-up patches,
this interface will be extended to use BRA transfers.

The sequence is to use the following files added under the existing
debugsfs directory for each peripheral device:

command (write 0, read 1)
num_bytes
start_address
firmware_file (only for writes)
read_buffer (only for reads)

Example for a read command - this checks the 6 bytes used for
enumeration.

cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
echo 1 > command
echo 6 > num_bytes
echo 0x50 > start_address
echo 1 > go
cat read_buffer
address 0x50 val 0x30
address 0x51 val 0x02
address 0x52 val 0x5d
address 0x53 val 0x07
address 0x54 val 0x11
address 0x55 val 0x01

Example with a 2-byte firmware file written in DP0 address 0x22

od -x /lib/firmware/test_firmware
0000000 0a37
0000002

cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
echo 0 > command
echo 2 > num_bytes
echo 0x22 > start_address
echo "test_firmware" > firmware_file
echo 1 > go

cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
echo 1 > command
echo 2 > num_bytes
echo 0x22 > start_address
echo 1 > go
cat read_buffer

address 0x22 val 0x37
address 0x23 val 0x0a

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/debugfs.c | 150 ++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index 67abd7e52f09..6d253d69871d 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -3,6 +3,7 @@
 
 #include <linux/device.h>
 #include <linux/debugfs.h>
+#include <linux/firmware.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -137,6 +138,145 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(sdw_slave_reg);
 
+#define MAX_CMD_BYTES 256
+
+static int cmd;
+static u32 start_addr;
+static size_t num_bytes;
+static u8 read_buffer[MAX_CMD_BYTES];
+static char *firmware_file;
+
+static int set_command(void *data, u64 value)
+{
+	struct sdw_slave *slave = data;
+
+	if (value > 1)
+		return -EINVAL;
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "command: %s\n", value ? "read" : "write");
+	cmd = value;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(set_command_fops, NULL,
+			 set_command, "%llu\n");
+
+static int set_start_address(void *data, u64 value)
+{
+	struct sdw_slave *slave = data;
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "start address %#llx\n", value);
+
+	start_addr = value;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(set_start_address_fops, NULL,
+			 set_start_address, "%llu\n");
+
+static int set_num_bytes(void *data, u64 value)
+{
+	struct sdw_slave *slave = data;
+
+	if (value == 0 || value > MAX_CMD_BYTES)
+		return -EINVAL;
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "number of bytes %lld\n", value);
+
+	num_bytes = value;
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(set_num_bytes_fops, NULL,
+			 set_num_bytes, "%llu\n");
+
+static int cmd_go(void *data, u64 value)
+{
+	struct sdw_slave *slave = data;
+	int ret;
+
+	if (value != 1)
+		return -EINVAL;
+
+	/* one last check */
+	if (start_addr > SDW_REG_MAX ||
+	    num_bytes == 0 || num_bytes > MAX_CMD_BYTES)
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(&slave->dev);
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_noidle(&slave->dev);
+		return ret;
+	}
+
+	/* Userspace changed the hardware state behind the kernel's back */
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	dev_dbg(&slave->dev, "starting command\n");
+
+	if (cmd == 0) {
+		const struct firmware *fw;
+
+		ret = request_firmware(&fw, firmware_file, &slave->dev);
+		if (ret < 0) {
+			dev_err(&slave->dev, "firmware %s not found\n", firmware_file);
+			goto out;
+		}
+
+		if (fw->size != num_bytes) {
+			dev_err(&slave->dev,
+				"firmware %s: unexpected size %zd, desired %zd\n",
+				firmware_file, fw->size, num_bytes);
+			release_firmware(fw);
+			goto out;
+		}
+
+		ret = sdw_nwrite_no_pm(slave, start_addr, num_bytes, fw->data);
+		release_firmware(fw);
+	} else {
+		ret = sdw_nread_no_pm(slave, start_addr, num_bytes, read_buffer);
+	}
+
+	dev_dbg(&slave->dev, "command completed %d\n", ret);
+
+out:
+	pm_runtime_mark_last_busy(&slave->dev);
+	pm_runtime_put(&slave->dev);
+
+	return ret;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cmd_go_fops, NULL,
+			 cmd_go, "%llu\n");
+
+#define MAX_LINE_LEN 128
+
+static int read_buffer_show(struct seq_file *s_file, void *data)
+{
+	char buf[MAX_LINE_LEN];
+	int i;
+
+	if (num_bytes == 0 || num_bytes > MAX_CMD_BYTES)
+		return -EINVAL;
+
+	for (i = 0; i < num_bytes; i++) {
+		scnprintf(buf, MAX_LINE_LEN, "address %#x val 0x%02x\n",
+			  start_addr + i, read_buffer[i]);
+		seq_printf(s_file, "%s", buf);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(read_buffer);
+
 void sdw_slave_debugfs_init(struct sdw_slave *slave)
 {
 	struct dentry *master;
@@ -151,6 +291,16 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
 
 	debugfs_create_file("registers", 0400, d, slave, &sdw_slave_reg_fops);
 
+	/* interface to send arbitrary commands */
+	debugfs_create_file("command", 0200, d, slave, &set_command_fops);
+	debugfs_create_file("start_address", 0200, d, slave, &set_start_address_fops);
+	debugfs_create_file("num_bytes", 0200, d, slave, &set_num_bytes_fops);
+	debugfs_create_file("go", 0200, d, slave, &cmd_go_fops);
+
+	debugfs_create_file("read_buffer", 0400, d, slave, &read_buffer_fops);
+	firmware_file = NULL;
+	debugfs_create_str("firmware_file", 0200, d, &firmware_file);
+
 	slave->debugfs = d;
 }
 
-- 
2.34.1


