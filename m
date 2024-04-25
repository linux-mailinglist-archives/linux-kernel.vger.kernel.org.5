Return-Path: <linux-kernel+bounces-158831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 820E88B2574
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CF31F21C53
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0514BF9B;
	Thu, 25 Apr 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=florommel.de header.i=@florommel.de header.b="s8o6289M"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93AA12C466
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059851; cv=none; b=pJzuTviQ0KvYtFNSdy02Bp8O7sYkdO5EfpKbGny5uSfHKwSltG/8O4YqISt16HaTBoIlr6qZBClS/X4vbb6gphBQvJc+I4gOBDtirmI5fcl4MqX0nxKhCRLqTKetgX7cGm/gSlGNVrsiq2d+QhQ1F6gjr1tn0Ehsa3ZnFxcg4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059851; c=relaxed/simple;
	bh=rKhcjnXo7EOIqnD76pPnNap0PU85LBwHgM50XLVgpJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ite8XJvVNUJ3obyePGGE4h2zkY8DCuU57gfQGGwxiqe7vOYJrHCaUenR1QsNLcFm1Knl3i5LTCxM9/UniW6+5zTQmXiICnNevB2Hn3JW7cAZZaD8lg78L3e8SihUYN1efj4R6WMZ2FMzg4c/1fPYuOFOIVeF0I+4wP8UKm3S23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=fail (0-bit key) header.d=florommel.de header.i=@florommel.de header.b=s8o6289M reason="key not found in DNS"; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 30677 invoked by uid 990); 25 Apr 2024 15:36:37 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Thu, 25 Apr 2024 17:36:37 +0200
From: Florian Rommel <mail@florommel.de>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Cc: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Florian Rommel <mail@florommel.de>
Subject: [PATCH 2/4] scripts/gdb: Fix parameter handling in $lx_per_cpu
Date: Thu, 25 Apr 2024 17:34:59 +0200
Message-ID: <20240425153501.749966-3-mail@florommel.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425153501.749966-1-mail@florommel.de>
References: <20240425153501.749966-1-mail@florommel.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: ----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999346) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) SUBJECT_HAS_CURRENCY(1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -4.599346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=rKhcjnXo7EOIqnD76pPnNap0PU85LBwHgM50XLVgpJw=;
	b=s8o6289MZARO/X/Z0VB9amQLyMNS/bZtWfozd/ZPxw5DbaHlseMDtTsKmEpcwgCav6cUJchfu/
	Xt60+GOWgYMi5rbp33stbGgmvADMzLo7hyBV3R+oHqxKQKzJyVvUtoPgy4BZae2XHIo+X1gyu2Kr
	vhI5fY7bm7+dOz4dftXM0lqdTjhBjR+qwS2XN15jdC45eSRSf1sn4+G0+Yl20FPnQPIWansL6l0r
	FI7gDjIbP22PUUO9ZDSO/w8o2K6LKGWQ0Hv9KdI29E/ZjY0K9SvNvhs/B+1J+vbEJDp1QFKqz7Gg
	YXlTF9uhowo9UCC4LmW/HcRqtL07jvT0kaiekINKMIEb+RddhkA69YSrYnLvcB4TGtZEsOlb+wwZ
	z5Iy00uRvr6Vj0t0IgRys0zv3HhD2imd6uGMCW+9+ix3dMCKba5SQyN338OEZPck8fu0xd0Q+SV7
	IxXGpFu1evMeceEQTKI9o5Vd9bD8s8ZdoQxJbZ7RWx6CKmo614G8rCUxbjmBAuXc34aLgtiRwHvJ
	APcTHZQeK8fUidtGeQo0Co3UHro/LdoS9yiMW9EmxqmXJNRm9wYT3Rcd9nGz/x2rYenuVoQfHm6B
	SmqeEzMoMguT78ITakw4c9EMeDjshewNvJXSMiG9eV+0lVz5X+KxinDTV5xoZDAPyYAsUsdjINVJ
	s=

Before, the script tried to get the address by constructing a pointer to
the parameter (by name).  However, since GDB now passes the parameter as a
GdbValue, we cannot get its name.  Instead, we retrieve the address through
GdbValue's address attribute.

Before:
>>> p $lx_per_cpu(cpu_info)
Traceback (most recent call last):
  File "./scripts/gdb/linux/cpus.py", line 152, in invoke
    var_ptr = gdb.parse_and_eval("&" + var_name.string())
                                       ^^^^^^^^^^^^^^^^^
gdb.error: Trying to read string with inappropriate type `struct cpuinfo_x86'.

Signed-off-by: Florian Rommel <mail@florommel.de>
---
 scripts/gdb/linux/cpus.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index cba589e5b57d..2b51a3abd363 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -152,9 +152,8 @@ Note that VAR has to be quoted as string."""
     def __init__(self):
         super(PerCpu, self).__init__("lx_per_cpu")
 
-    def invoke(self, var_name, cpu=-1):
-        var_ptr = gdb.parse_and_eval("&" + var_name.string())
-        return per_cpu(var_ptr, cpu)
+    def invoke(self, var, cpu=-1):
+        return per_cpu(var.address, cpu)
 
 
 PerCpu()
-- 
2.44.0


