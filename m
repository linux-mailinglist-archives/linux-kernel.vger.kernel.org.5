Return-Path: <linux-kernel+bounces-73675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5594285C5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0722B2857E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F56314AD11;
	Tue, 20 Feb 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4AaXhcj"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8814A4E6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460735; cv=none; b=cXpUyEgpxxRzcw2pfGDfAy6NT45O/AqTQjfc7gpM9PyBr8IIs5S4hrZYvHcJ/uaKYG/lP+TbAZ5PIFVqfR4MaNZBhHZyQuspJ9e3nMcV2WtFvsZIrnp10tSZCfiHJjxeKEG5T7vJ8rSAvpsZuR8KJs3XQzns5UISx+qflNae24k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460735; c=relaxed/simple;
	bh=Yjw4CQZg24TKMtDrtR8nHj5ynpIP/Mmr+w0gohlWeZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ILKa13PagdfVWraeqFJBjwPhT+y1SMJwkdkoiR093HohupjJTJOGEGM8UFmywSPpkGnYWq8hgmg7xVJQilHzgPCEqrwPq7Od6uY8qWCgez/hG1WERzI9y/VdJZHSPivFj9RFRyLNEfaM6MQGEwswpNF4FU0UapCYzgMaXDuHZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4AaXhcj; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1d746ce7d13so40141325ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708460733; x=1709065533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xdhZJ9DhrvAcXGwq0nzlagkVpHv12NVQ7HVU66ltWM=;
        b=h4AaXhcjXwN3GvfMBpt7z7XhEAzgs7fuUgW4ppcQLzA+2bNgQXKtH4yoVpk6GQIs4y
         sRnGISTKUdcRZc/XL/4sreaWLbJleQmQ6S+8QH9UBZkndBNghhSLu6mI2Oor4sFonz9c
         FS/+hnwa2bBSky14wT/4WyzAxqi856a2MdZDpu+lMNFL8H7CIB+thNtTjAR4ezHpshb3
         jbwafLyvOziGoFPOnzgPdiciFwM2RUnAb44RYlfzN4TwBUKMaPpnHwEHKsl2hGdIHwIv
         IYJA8s/9DgfYxYrmCQvAOmjJc/ZQPPpNKV38qoRuM6A2WK+pweme1tcmS5sxK5xbOPW1
         X0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460733; x=1709065533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xdhZJ9DhrvAcXGwq0nzlagkVpHv12NVQ7HVU66ltWM=;
        b=YYEfEo1GNjxAEgf9jvVorThIQclO4nKMQfOy27xKYO5wq2SP/zkVBU7zMsTwBabcnJ
         0JBoKq0go+f+QHPwQfCoy40OR0S9u7HD/el6MFh3MazrzDgUdRCxIWopuYGkdPZgwc+t
         iBPHNc34WzFm1DAw/70f93+nAHea3TlYJXotVF8q2JpmAsXoI+x/4JhBLs70nrcdlkx4
         4TG6bfRHSEHr3dLDFPYiZVJtWWYG79rgqlzq0ylkQpycjwhnywIcL5fL1LALmyh1T2Ri
         y8vtfalMye7jTwjXceiNeLjfEYlm/UFxt6B6OAcuRh5moHqmSmEBxdfp0Yti5QmOsd+0
         dccA==
X-Gm-Message-State: AOJu0Yzvn9nCmNiRP2Bqf23PJIT385VcdTf9LacRCeltQtQUSFQE8lAu
	xGnmeiHAwRmYQJSGEWflcs4CtAR+7jum3Ur8Cu86f5KYBvSYj60=
X-Google-Smtp-Source: AGHT+IG5oDu0VthkmfK5qe+5KaMyp+DKjw7HA8sYTjEb/1xCwf3PSGKEt9Uo5htIB5nWDb1IErXfdg==
X-Received: by 2002:a17:902:ec89:b0:1db:aa46:4923 with SMTP id x9-20020a170902ec8900b001dbaa464923mr15547816plg.40.1708460733597;
        Tue, 20 Feb 2024 12:25:33 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id je13-20020a170903264d00b001db40c0ed33sm6696678plb.61.2024.02.20.12.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 12:25:33 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	ying.huang@intel.com,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: [RCF 0/1] mm/mempolicy: weighted interleave system default weights
Date: Tue, 20 Feb 2024 15:25:28 -0500
Message-Id: <20240220202529.2365-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Weighted interleave added a sysfs interface for users to change
the interleave weights based on user input - with a default value
of `1` until reasonable system default code could be agreed upon.

This RFC series will suggest and solicit ideas for how to generate
these system defaults, and lay out some challenges in generating them.

Future work on the CXL driver (drivers/cxl) will introduce additional
code which registers HMAT information for hotplug memory provided
by CXL devices. This RFC does not presently provide that integration,
but will after it is upstream.


Interfaces introduced:
- mempolicy_set_node_perf
  Called when HMAT data for a node is reported to the system

Integration points:
- node_set_perf_attrs - for reporting bandwidth info to mempolicy
- get_il_weight and weighted interleave allocation interfaces to
  provide system defaults when applying weighted interleave.

New data in mempolicy:
- node_bw_table - cached bandwidth information about each node
- default_iw_table - the system default interleave weights


Note that because there are now multiple tables (default and sysfs),
the allocators fetch each weight individually, rather than via memcpy.
This means if weights change at runtime (extremely unlikely), the
allocators may temporarily see an "incorrect distribution" while the
system is being reweighted. This is not harmful (simply inaccurate)
and a result of providing a clean way to revert to the system default.


v1: Simple GCD reduction of basic bandwidth distribution.

Approach:
- whenever new coordinates are reported, recalculate all weights
- cache each node's min(read, write) bandwidth
- calculate the percentage each node's bandwidth is of the whole
- use GCD to reduce all percentages down to the minimum possible

The approach is simple and fast, and operates well under reasonably
well if the numbers reported by HMAT for each node happen to land
on easily reducable percentages.  For example, a system presenting
88% of its bandwidth on DRAM and 11% of its bandwidth on CXL (floored
for simplicity) will end up with default weights of (8:1), which is
a preferably small number assigned in each weight.

The downside of this approach is that it is susceptible to prime and
co-prime numbers keeping interleave weights large (e.g. 89:11 vs 8:1).
We prefer finer grained interleaves to prevent large swaths of
contiguous memory from landing on the same device.

Additionally, this also hides the fact that multi-socket systems
experience chokepoints across sockets.  For example a 2-socket
system with 200GB/s on each socket from DDR does not mean a given
socket has an aggregate of 400GB/s of bandwidth.  Interconnects between
sockets provide less aggregate bandwidth than the DDR they provide
access to (e.g. 3 UPI lanes vs 8 DDR channels).

So this approach will reduce multi-socket interleave weights to (1:1)
by default if all sockets provide the same bandwidth.

Signed-off-by: Gregory Price <gregory.price@memverge.com>

Gregory Price (1):
  mm/mempolicy: introduce system default interleave weights

 drivers/acpi/numa/hmat.c  |   1 +
 drivers/base/node.c       |   7 +++
 include/linux/mempolicy.h |   4 ++
 mm/mempolicy.c            | 129 ++++++++++++++++++++++++++++++--------
 4 files changed, 116 insertions(+), 25 deletions(-)

-- 
2.39.1


