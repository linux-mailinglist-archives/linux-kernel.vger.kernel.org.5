Return-Path: <linux-kernel+bounces-87299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150B086D26C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391751C22A28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFAC7D08D;
	Thu, 29 Feb 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eeg5ydFc"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F8383B0;
	Thu, 29 Feb 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231766; cv=none; b=bR7W/DCZOfN3LqnwS9nwJ4Jo+wme+9cLFp4BUPmHW7/CJqzqsdaGSYt7vff5pneLnRPl27cGwLtH8bFLeZc5vzeUzhj+yUObMGhJjVkCACvqAkFMOF0YTgIp+IQiXwbYQWmksq/TcCbeuvXK5v6t4c9osq9hZmfxOkijdXVOHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231766; c=relaxed/simple;
	bh=MTQ2Zp10v4EFATTAdn8YTq6PqucoTKlCqk+EsJm56cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjSf9yGLOZVoxTFBJdvUPXGpZ1q/K/11GLNt0eMBgP038MoeZ0WYij2gUUwIt813sGjaXy2v09DaT1P5UhSe+gPxV07Z4AGkoBtRtjCehc3J6w7KvjzvY8b1aVjRmSLG/7qRimVvFRrx0d4cN8If3uTaNcd6eKUf9srNAVYiM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eeg5ydFc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so815694b3a.1;
        Thu, 29 Feb 2024 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709231764; x=1709836564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+gMaEJ0wh9SI3Z0iigxIJILHIqBzk3ZTRAx3N1QiYM=;
        b=Eeg5ydFcSY54VaJ6RhfgXfB1a6w5OLQjCpzkM9P9ETX9onS+XapskhBo7cgReiEixY
         V/zrNjvohFapiWsTwm5QXBOv+7uaRdWfnCaxczgNnm4FkbhqCfEMJShecEdzzqPRMM67
         ZNvjn4PuYuOPUdVYbZh8TjKL1UdfA+op40GcPem4cSTY3sawObb0Cps1RZ03n3WlbDjy
         W0rAgFBzuZrHEzuRehiuB2pbM1RjLp5Id9si/mzapnEMwI7RlXd+uYbN4I/WFYsmUE4W
         hu3Z4PgJZglRYnNJN5hPQ55/N2TiZkNVzpKU0LPWu9LUCavvWvmcE2fu0BER8pf0Hovh
         BAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231764; x=1709836564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+gMaEJ0wh9SI3Z0iigxIJILHIqBzk3ZTRAx3N1QiYM=;
        b=T5ZCPPqELB1h4K1gNN1D1llZsVlutTC+Yo2WG1rCT/cpGxMhncK0T5ax51Hze0VnNw
         G+xyyCgiF/IJVeXxywRYhffXx0M4QZbruCX4NZ7xM2HWlfnazynQ66uqct67TjpWOSSE
         hRaA60wHLGjHgtHZp5jYTQovz5PcAXFN344+IEcDRB9RsMZX5VZIlfgB5m0QAfQ1QjOr
         RxUqmWhjLofmTMurQDKl6AkzUjQItlFouYplyhs00qEyk5oijBYRyAVxaw4+9FkjZchk
         pATbAS+L2TThdpBNOMyKxmgtWZq32AoPAiBLSzIXGcTgXXm2doQncKKvWhn7IshHtIOh
         H05w==
X-Forwarded-Encrypted: i=1; AJvYcCXJnMDkLjvqkq+XC2xomdfZfqKaGDHIQQIZiodTnu/+ac8/9NP6YH78QxepvhaYpun2ewgWmfy4C8Ut1muc/1bCC8bHOPIBnb/pmJP0vJ6aUPlVIebgvJZh/UdoNa7//rIjGMOqLJ/s
X-Gm-Message-State: AOJu0YxSj3s0gfPfczn0o2bxuoXa/uu3BTaGJk97+SP/M6d8DX+fWQZp
	ik2sBhv67ipEwfhvJbVEyzjaEaErPWiqRiAZ10F7Uh2h0q4l1VOu
X-Google-Smtp-Source: AGHT+IESfJPaPW4XdZ0Mu53/VQlgf7pW8jpNwrPcnJhzbPBfRKKNRO4uibv22o8d82QjfHXgqirXXQ==
X-Received: by 2002:aa7:87d3:0:b0:6e5:5cc4:3fef with SMTP id i19-20020aa787d3000000b006e55cc43fefmr3166438pfo.11.1709231763675;
        Thu, 29 Feb 2024 10:36:03 -0800 (PST)
Received: from localhost ([2601:644:9381:2f20::119d])
        by smtp.gmail.com with ESMTPSA id c2-20020a62e802000000b006e1463c18f8sm1595604pfi.37.2024.02.29.10.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:36:03 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: netconsole: Add continuation line prefix to userdata messages
Date: Thu, 29 Feb 2024 10:36:01 -0800
Message-ID: <20240229183602.321747-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a space (' ') prefix to every userdata line to match docs for
dev-kmsg. To account for this extra character in each userdata entry,
reduce userdata entry names (directory name) from 54 characters to 53.

According to the dev-kmsg docs, a space is used for subsequent lines to
mark them as continuation lines.

> A line starting with ' ', is a continuation line, adding
> key/value pairs to the log message, which provide the machine
> readable context of the message, for reliable processing in
> userspace.

Testing for this patch::

 cd /sys/kernel/config/netconsole && mkdir cmdline0
 cd cmdline0
 mkdir userdata/test && echo "hello" > userdata/test/value
 mkdir userdata/test2 && echo "hello2" > userdata/test2/value
 echo "message" > /dev/kmsg

Outputs::

 6.8.0-rc5-virtme,12,493,231373579,-;message
  test=hello
  test2=hello2

And I confirmed all testing works as expected from the original patchset

v1 -> v2:
- Calculate 53 byte user data name from: entry length - formatting chars - value length
- Update docs to reflect 53 byte limit for user data name (director)

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 Documentation/networking/netconsole.rst | 8 ++++----
 drivers/net/netconsole.c                | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index b28c525e5d1e..d55c2a22ec7a 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -180,7 +180,7 @@ Custom user data can be appended to the end of messages with netconsole
 dynamic configuration enabled. User data entries can be modified without
 changing the "enabled" attribute of a target.
 
-Directories (keys) under `userdata` are limited to 54 character length, and
+Directories (keys) under `userdata` are limited to 53 character length, and
 data in `userdata/<key>/value` are limited to 200 bytes::
 
  cd /sys/kernel/config/netconsole && mkdir cmdline0
@@ -197,8 +197,8 @@ Messages will now include this additional user data::
 Sends::
 
  12,607,22085407756,-;This is a message
- foo=bar
- qux=baz
+  foo=bar
+  qux=baz
 
 Preview the userdata that will be appended with::
 
@@ -218,7 +218,7 @@ The `qux` key is omitted since it has no value::
 
  echo "This is a message" > /dev/kmsg
  12,607,22085407756,-;This is a message
- foo=bar
+  foo=bar
 
 Delete `userdata` entries with `rmdir`::
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0de108a1c0c8..46e447ea41b8 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -43,9 +43,11 @@ MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
 
 #define MAX_PARAM_LENGTH	256
-#define MAX_USERDATA_NAME_LENGTH	54
-#define MAX_USERDATA_VALUE_LENGTH	200
 #define MAX_USERDATA_ENTRY_LENGTH	256
+#define MAX_USERDATA_VALUE_LENGTH	200
+#define MAX_USERDATA_NAME_LENGTH	MAX_USERDATA_ENTRY_LENGTH - \
+					MAX_USERDATA_VALUE_LENGTH - \
+					3 /* ' ' '=' '\n' characters */
 #define MAX_USERDATA_ITEMS		16
 #define MAX_PRINT_CHUNK		1000
 
@@ -671,7 +673,7 @@ static void update_userdata(struct netconsole_target *nt)
 		 * checked to not exceed MAX items with child_count above
 		 */
 		complete_idx += scnprintf(&nt->userdata_complete[complete_idx],
-					  MAX_USERDATA_ENTRY_LENGTH, "%s=%s\n",
+					  MAX_USERDATA_ENTRY_LENGTH, " %s=%s\n",
 					  item->ci_name, udm_item->value);
 	}
 	nt->userdata_length = strnlen(nt->userdata_complete,
-- 
2.44.0


