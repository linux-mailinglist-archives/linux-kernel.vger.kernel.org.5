Return-Path: <linux-kernel+bounces-104289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA387CBA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20541F22721
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358F1A28C;
	Fri, 15 Mar 2024 10:54:40 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224A1862B;
	Fri, 15 Mar 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500079; cv=none; b=rDFkKKhwP0qRZNKSXUWnwD/PYl6V4LC7MPTWKK10p0lBX4FtZrKL6/nETiRYoDpmw5X2iwAD/i1xCtMZP75D/J/Kd4J4Q8z/t7L9yHh3Lg47Ns6w/NPrTNQZyb1RNbNkngreg1e6DH7AdNilrwL+MleWvuyox+zLSqs4Dfvjwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500079; c=relaxed/simple;
	bh=dXHuXCkXUJiI6TEDccoU2vMsUevP7Iip43Z2ctrjkRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZlntWi+khBQx8arjMPqyYGymiuBMSkdgZw4LdytHcfm82RxwL1NLVVRajUmhH9GJ2bWF65cseLyHdyKHYvynyk8PGzLne9cReYfY5DQB5gmdf4gslrpNEL622KOLcsECBzRkm28K0Qi2M8Gdmuu/azPRsmcMN0LDookDAO68e10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBnb0faKPRlEQ2yDQ--.33987S2;
	Fri, 15 Mar 2024 18:54:18 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBHuUHUKPRlaIwAAA--.853S3;
	Fri, 15 Mar 2024 18:54:14 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: ira.weiny@intel.com,
	jonathan.cameron@huawei.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 0/1] cxl/mem: Fix for the index of Clear Event Record Handle
Date: Fri, 15 Mar 2024 18:53:35 +0800
Message-Id: <20240315105336.464156-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBHuUHUKPRlaIwAAA--.853S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWXzUXsD5wAFsY
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Xr4kGF1rXrWxCF17JF4Dtwb_yoW8Jr17pr
	yfKwsIkFWDJasFgF15A3WxXFy5A3s5tF45Ga93Gw48J34UAF1UXr1Ik3WSvF15XryfXFW8
	A3Wjqr9xK34jyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

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

 drivers/cxl/core/mbox.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.34.1


