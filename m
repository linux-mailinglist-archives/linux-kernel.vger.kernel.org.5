Return-Path: <linux-kernel+bounces-51937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63384919F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFDF4B20E40
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C0134D2;
	Sun,  4 Feb 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpI8B8u1"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E512B96;
	Sun,  4 Feb 2024 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089279; cv=none; b=q1+2FxlKSVhHTZCtvioYZ2uhJAtj3qTA4kpe8IbHqALhwypecVBCrosaNpsNiJpXcU49pIdKu3TzPN90Wfy12IF2ieUrgBkfEJHke9jpifDkjQFY/UoKq1EZISHKQj1SsmniAbTzUUjpuM+JRysPhbhzoHKOI6ow3DQR1bfelz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089279; c=relaxed/simple;
	bh=/n7gte7+g5iz4O3gD/aRaektVHW/cg++aK2ocK/HCRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAPcW5VFtUCTMgQZyXhjkhy4MlId/q2lg1yO8ncmmtE2Yas9lyrQ6zhBEHfaKS0vtK67vFZbyYFPw7J7b2+OUUxcu52H8+v8F33HKJKxhZjUiGwu1b9jWO0sZPREs8DUhgbiGhmx26YsB2vH95ivKvGwDgPugJzG5PPPPNIRb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpI8B8u1; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21920f89441so1599589fac.2;
        Sun, 04 Feb 2024 15:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089275; x=1707694075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUUoKdZN1IuRsIaFfQ05cFLLrwH0tLTS4XTxE2edstM=;
        b=SpI8B8u1khiz/lkWadE5Bv5yLDamClLhTKLXYEa29+Q53cazsGIiKCetJHWgUDJg4g
         3z0Rm00ToXSSJGr3sYeFDguHddNZ/aWdTLnNzJ+xifWKCKhwYtwnVKIkL4xQgeLc+Zkc
         xtDwWkNCFcG4D7mlpcnHzgzpR67AClRZUsVcfoHgIwhu9MsJKEgLsShXEJbUO1YQFynP
         jh9qyzaH7BCfK/JP0OW2TTCPbKOKr31gFLlu4XxqVrYhR44plQCUTedfaNKbIHS5K/7L
         jHQagtSeGcBurEUDJKpHkyS2oWKLkk1HG64J+AlFjES59gkVzFTqaqwt2L8uWU2SMmoj
         QyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089275; x=1707694075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUUoKdZN1IuRsIaFfQ05cFLLrwH0tLTS4XTxE2edstM=;
        b=d67b5ETlOUEwsjJ4NG+hMqx4hrZwKUY5NGDS0KFGocN+F11Ws3T3pVZsY45DV2lXd/
         yBqTbBK6fjb53VFus/OrGe078qxLkZ66I6Qy+tGlBhndJ4eIt012V5ZDqSVddRAXfLFX
         0X2x9vbSZgdVPpthkufM8iIKJS3tF3TWWldxiOI5Mh7ESo2OQNyvOlpHhJj90mvFv4rn
         xbxIRsRDjkNjaNlpJtaiPXc9f9JqIwupxMq+3Z+R1zjJPdcNXNNfEtEvQsL+1n4/jptI
         lQou/tevvV0yHHFQqFUzmvkUXfe9cuutX+CFDNLXjwi77S16W0i6PRLx0Wf7IHcMuNVm
         09ZQ==
X-Gm-Message-State: AOJu0YyS1Myw+5q7otRkJIP525qzkw3+CDp8rCvN/DKveZ3VqOnQtcU+
	Hbqxwr/ZCN40YSWm/jb1Y83YyAE63MRPAf4Rw9yIMhgIcpIUc+Ov
X-Google-Smtp-Source: AGHT+IFZmh15qIq8LdNHtaeWiziOTdE+EjvKRKzLYiRjNumjhoTSYbQivN+YD2lMCmV7fuUOa3QHWg==
X-Received: by 2002:a05:6871:e717:b0:219:6ced:9500 with SMTP id qa23-20020a056871e71700b002196ced9500mr3396519oac.56.1707089275316;
        Sun, 04 Feb 2024 15:27:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTKeT1GHDnGjlk8MnbVTUCDxJMW8cZox1BLrs21FZvkB3rWtj2e2NcosF+j2XFwGOheh+Ia3ZBIRCqooMv3HaIeAO224SkFsqSLnON1CyeJNicJweVJrOCJ4GaH/hEMPCe3A6hX+enN3Zr3TBRF3wPEwE/9qvCMAIYU7Cv/EcU72fDS84zGvgmxQhbQ/gSBidbOI2OcQl0M04egfButJdmwG2KsNYEumyWbDtQYnHf8+oBSYRNIWMV6bGwODmg18zycIhpHa2Q6g==
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id l37-20020a635725000000b005d66caee3d0sm5612417pgb.22.2024.02.04.15.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:27:55 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/8] net: netconsole: add docs for appending netconsole user data
Date: Sun,  4 Feb 2024 15:27:35 -0800
Message-ID: <20240204232744.91315-5-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204232744.91315-1-thepacketgeek@gmail.com>
References: <20240204232744.91315-1-thepacketgeek@gmail.com>
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
 Documentation/networking/netconsole.rst | 66 +++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 390730a74332..b28c525e5d1e 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -15,6 +15,8 @@ Extended console support by Tejun Heo <tj@kernel.org>, May 1 2015
 
 Release prepend support by Breno Leitao <leitao@debian.org>, Jul 7 2023
 
+Userdata append support by Matthew Wood <thepacketgeek@gmail.com>, Jan 22 2024
+
 Please send bug reports to Matt Mackall <mpm@selenic.com>
 Satyam Sharma <satyam.sharma@gmail.com>, and Cong Wang <xiyou.wangcong@gmail.com>
 
@@ -171,6 +173,70 @@ You can modify these targets in runtime by creating the following targets::
  cat cmdline1/remote_ip
  10.0.0.3
 
+Append User Data
+----------------
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
+.. warning::
+   When writing strings to user data values, input is broken up per line in
+   configfs store calls and this can cause confusing behavior::
+
+     mkdir userdata/testing
+     printf "val1\nval2" > userdata/testing/value
+     # userdata store value is called twice, first with "val1\n" then "val2"
+     # so "val2" is stored, being the last value stored
+     cat userdata/testing/value
+     val2
+
+   It is recommended to not write user data values with newlines.
+
 Extended console:
 =================
 
-- 
2.43.0


