Return-Path: <linux-kernel+bounces-40811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2143C83E65E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB33288DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203E5B5BA;
	Fri, 26 Jan 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjYlVpoV"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953B5A7A9;
	Fri, 26 Jan 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310844; cv=none; b=MHA1/MVcahNJWucmtdtUhBGTG1rIaowhPDxpAjqxPGpNJge1ZYtyzciZq1tLhOytMu9LhX3NH8APNNS7olW81PZnAznLe/g0YL2Q0KirnYTm+LUNpfZjAaHQEDofUymmPWNvY2bO7wFYP75WIwva9fBc9eC5GLJmr0Kh//nTCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310844; c=relaxed/simple;
	bh=JUBz4HV56EeU4/nPAgND0SO1KSnQD6Dq6LeiFiNVnDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOjtZ0PXo4b0f/lQNdOeUeibmms/GvmNcytq3Yv2pCr3hJj40EEj/MNPvSrgni7CGpNCnIKbj3DFIudGam8sY8SpefM+VjU9/wOoHPfFOSp+6gAvd2lPran+biyknm3nZAIrnlwP4rbLmKU3RK5zbMpLWYG1c3F0Y77wR3FCOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjYlVpoV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d71e184695so6162055ad.3;
        Fri, 26 Jan 2024 15:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310841; x=1706915641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gneFCt4ceG2iUK09c51bLYD/2KQfSVJ2BvbrNzbdXrk=;
        b=gjYlVpoVAcTPdVotSYVxzOP2J18W/qtl/RzfofHdUILoNuZz31r2dW1vhg43RE25qC
         Fnypm6L1SJT8SMj3XuwSGDD1Oc2rfzsg/b80idoFlzTz3FDLzBs4mRMFzyjutZXaSxN7
         ddp3EbGkt+DTd8X/qn+/7APBnopKhy3kjd6bXU8wj6MhoJzL+tKjUVBZF1oRlPb7BB1w
         lB+EizqwLfT27i+lPXnX4LJH1TIMJOLmsf41wCa7lMbfwceCdcM5gkVwoDDYsxRLsJbq
         cOZWy+HJvJ1ESTJd2EtHed8var8EZH18diZb0EzuuNITkDMXO1rgjCqZbGU660zojxsg
         vAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310841; x=1706915641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gneFCt4ceG2iUK09c51bLYD/2KQfSVJ2BvbrNzbdXrk=;
        b=vX6utjTi8tIpO5WSUgNA+YfXzTjqimyyAHcD2xc/Be51+7KuaOw7qbM7qvqkWjWNKI
         2VQqp3zkuZfzF1xpimn2n/4LKRvNCKX3akPyWnd+WUJQiKN2t8HDS89XPs2qh+DIjPCZ
         lb+L0Bv8QyDFVBoE/bERJr1Se0YqgYZJgps+zs6Yeuuek0vZgul5m1QAkVMu6dG+ip5l
         UHG59L1PK+n+urywPJiv5Uh+Z424rbmTGs9UsYfUZQE8pooaPVlrFRCyA3aYWTojaNd1
         Ut+yOpgF8FF41bNMBzKiNt2jqyZhuFeZqu5RFgOvwnjwhlhzfsZvE/LRnWaRy7ajF8yM
         aKsQ==
X-Gm-Message-State: AOJu0YzV62rrugyW96IUYEyeumRNmkTwVS7+KgIn80r1fRox8R9pasv0
	d+ZF+wDg6C/IwsESWfF+RzIJih55B00rbZnoYwYsylsa5xc7ZMBJ
X-Google-Smtp-Source: AGHT+IEo92Gmz/anXbxo/lMXdH5mYbm+3w9cOfWNDx6wvuQgfmscDCs7yHOGdgkXT5QeLd5pubpufA==
X-Received: by 2002:a17:902:9f88:b0:1d7:7b3d:99b7 with SMTP id g8-20020a1709029f8800b001d77b3d99b7mr743822plq.132.1706310840741;
        Fri, 26 Jan 2024 15:14:00 -0800 (PST)
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902e19400b001d71923136csm1431251pla.211.2024.01.26.15.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:14:00 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: leitao@debian.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/8] net: netconsole: add docs for appending netconsole user data
Date: Fri, 26 Jan 2024 15:13:39 -0800
Message-ID: <20240126231348.281600-5-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126231348.281600-1-thepacketgeek@gmail.com>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new User Data section to the netconsole docs to describe the
appending of user data capability (for netconsole dynamic configuration)
with usage and netconsole output examples.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 Documentation/networking/netconsole.rst | 68 +++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 390730a74332..54f072f47921 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -15,6 +15,8 @@ Extended console support by Tejun Heo <tj@kernel.org>, May 1 2015
 
 Release prepend support by Breno Leitao <leitao@debian.org>, Jul 7 2023
 
+Userdata append support by Matthew Wood <thepacketgeek@gmail.com>, Jan 22 2024
+
 Please send bug reports to Matt Mackall <mpm@selenic.com>
 Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
 
@@ -171,6 +173,72 @@ You can modify these targets in runtime by creating the following targets::
  cat cmdline1/remote_ip
  10.0.0.3
 
+Append User Data
+================
+
+Custom user data can be appended to the end of messages with netconsole
+dynamic configuration enabled. User data entries can be modified without
+changing the "enabled" attribute of a target.
+
+Directories (keys) under `userdata` are limited to 54 character length, and
+data in `userdata/<key>/value` are limited to 200 bytes::
+
+ cd /sys/kernel/config/netconsole && mkdir cmdline0
+ cd cmdline0
+ mkdir userdata/foo
+ echo bar > userdata/foo/value
+ mkdir userdata/qux
+ echo baz > userdata/qux/value
+
+Messages will now include this additional user data::
+
+ echo "This is a message" > /dev/kmsg
+
+Sends::
+
+ 12,607,22085407756,-;This is a message
+ foo=bar
+ qux=baz
+
+Preview the userdata that will be appended with::
+
+ cd /sys/kernel/config/netconsole/cmdline0/userdata
+ for f in `ls userdata`; do echo $f=$(cat userdata/$f/value); done
+
+If a `userdata` entry is created but no data is written to the `value` file,
+the entry will be omitted from netconsole messages::
+
+ cd /sys/kernel/config/netconsole && mkdir cmdline0
+ cd cmdline0
+ mkdir userdata/foo
+ echo bar > userdata/foo/value
+ mkdir userdata/qux
+
+The `qux` key is omitted since it has no value::
+
+ echo "This is a message" > /dev/kmsg
+ 12,607,22085407756,-;This is a message
+ foo=bar
+
+Delete `userdata` entries with `rmdir`::
+
+ rmdir /sys/kernel/config/netconsole/cmdline0/userdata/qux
+
+Beware of `userdata` entries with newlines since values are printed with
+newlines preserved. A userdatum value with a newline could cause the
+netconsole message receiver to interpret a value as a new userdata key::
+
+ cat userdata/foo/value
+ bar
+ bar2
+
+The `qux` key is omitted since it has no value::
+
+ echo "This is a message" > /dev/kmsg
+ 12,607,22085407756,-;This is a message
+ foo=bar
+ bar2
+
 Extended console:
 =================
 
-- 
2.43.0


