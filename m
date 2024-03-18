Return-Path: <linux-kernel+bounces-105655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF187E222
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4E3282412
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790281E521;
	Mon, 18 Mar 2024 02:30:01 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82531BF3F;
	Mon, 18 Mar 2024 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729001; cv=none; b=Tyl3WgcV48KFGLCit6/VwXw6wRetJs2EmZkPHNBBSpfuDSUf27FhTO7prZwXdCTyjAkhoeOzRY/WiByQMBPAHScp8QHMcyxYB6uq9pZnVS6dVc5tvwJ3ocGw1x+GcIFCA0URHOB//kVF2n8JmSPffWsHNeyXs4QwH6KZu3kXyoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729001; c=relaxed/simple;
	bh=clJ0oy2fGlHZm/PyoJHfpz/AVMlAOf5UN7F76o3tYxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+UAfHTxRSkTibHwBDRH39ictnIj+OzQdHVTb4c2DS1gvJgI6mwosDNCyN0C4l7RNN8t6rt10rc7ni/GkChmG/oJbDl5BUCLx56mxfrovW0neN6YByCRHxeDzt2l7Uu+r0n88bPWA52HKxmK40PV7bJfTu7QZ5bq/fQhty6zfSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3PrYVp_dltrdHDg--.31911S2;
	Mon, 18 Mar 2024 10:29:41 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDXXNEPp_dlAEUAAA--.183S3;
	Mon, 18 Mar 2024 10:29:36 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: ira.weiny@intel.com,
	jonathan.cameron@huawei.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v2 0/1] cxl/mem: Fix for the index of Clear Event Record Handle
Date: Mon, 18 Mar 2024 10:29:27 +0800
Message-Id: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDXXNEPp_dlAEUAAA--.183S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAGAWX0ougA6QABs1
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Xr4kGF1rXrWxCF17JF4Dtwb_yoWktrb_XF
	WkKa97u340v3Z5Z342yFW5Zry2q3yDuryF9ay0gr4jqr13Ar15Ja92kF93Cry3WrW5uw42
	yr98Xa4qqrnF9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

This is a simple fix for the index of 'Clear Event Record' Handle. The
print content of dev_dbg from Clear Event Records mailbox command would
report the handle of the next record to clear not the current one.

The problem was found when I was doing the debug of CXL Event Error on
Qemu. I injected an individual event through QMP 
'cxl-inject-general-media-event':
{ "execute": "cxl-inject-general-media-event",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "log": "informational",
        "flags": 1,
        "dpa": 1000,
        "descriptor": 3,
        "type": 3,
        "transaction-type": 192,
        "channel": 3,
        "device": 5,
        "component-id": "iras mem"
    }}

Then the kernel printed: 
[ 1639.106181] cxl_pci 0000:0d:00.0: Event log '0': Clearing 0

However, the line 36 in 'hw/cxl/cxl-events.c': log->next_handle = 1;
It will set the actual handle value of injected event to '1'.

With this fix, the kernel will print:
[  122.456750] cxl_pci 0000:0d:00.0: Event log '0': Clearing 1
which is in line with the simulated value in Qemu.

Yuquan Wang (1):
  cxl/mem: Fix for the index of Clear Event Record Handle

 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


