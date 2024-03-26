Return-Path: <linux-kernel+bounces-118244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E0B88B6AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FAB2E83B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA51CD0C;
	Tue, 26 Mar 2024 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5ZpkSP7"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D91D559;
	Tue, 26 Mar 2024 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415702; cv=none; b=AtI8IhqB8O/+TX4RXG4Apcvk9K04CzAdzS3M2BG1uTsmvy1nLWhB/VF9yihV8ZiGPQIK7OHWhuPTU1KFfTPxZnRbEMoBgLBOD9B6qMEQGqp5TsDi7OxS8E/pTth3v9iHxR3gg3qUFtcR0YAAocx338wis2bI/skOPt64XTOLxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415702; c=relaxed/simple;
	bh=/jeoDp3vy66EH4yWjouOvq6LjAc/tE2jC0AC/sCGCgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5+BDe8XWWbwB/v9xWQgUtn25wKYRw4450P52KtQYenMCPGNpO+CLjIXD/lZpnpqPVZSXTieDyG224n9iklwqcoU3V/Hn0uFTUMUzNXBw68pyV34a42l2TepffXychiukE5713aV9pc02dupYW05wtmmMfR/0ngXYhsdrJAgCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5ZpkSP7; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6967e656fdeso5554156d6.0;
        Mon, 25 Mar 2024 18:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711415700; x=1712020500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3McBefS0GNuytNG8zXk6mlYlPk717ppRvRvudwS38bY=;
        b=S5ZpkSP7qDZ/4PsWvqGbMX7bV5C64yYYgsrsUt/WFLSF3yHUz7JA0ZhwCqtQl8/j7G
         rxGdEIsO77ULCDHofSkJaby5PRIq++XZk7JvBnZtkEoDTAMnsyBLVwZhoyQdGmFzZud1
         atc9tVkVs4gI6/SAfwAq/R7bdY+mGBcIdqaqVT2JCd1ya1tWwRgwA2AqlsCRbrowptw+
         Wf4VZMXkzRZa0wdG1JxhUSDgXPkdVlmi/sTHTwBm2L6cAyWqjJbCv3TSsgYZ/VyG8Rx6
         bugiSb3cZ82nYvxEBOcJTRBne5Yea9R5d/B8fqTu9N1qcBRt6WIYymYVAM5/HCtRCq5B
         qmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711415700; x=1712020500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3McBefS0GNuytNG8zXk6mlYlPk717ppRvRvudwS38bY=;
        b=AJlRgVCHgVWbQpPkxWH8xJF7W9yqws2BZUvMnVhUN2ZFA/S6nMqJl1LKh+MTUU7JjA
         2iPS+JW0i3w3jqq0jkJMO1Vont7/xVrd6PDC312tfZ6J3roZ12wU1jdcvWzrQ/DaIJhD
         cDCqdDvgam4Y6/X+M6xi8yae71QlFko3W6MpzQe/IKKxyhQVdwp30PSyOZ74Ka02YJ3t
         V/SMrJFT9gjSuKQLb1Ftz2m20oVfunDRPtYc1cdd0bkQwbBx253qo6Sh6eKPE++Cynge
         yUd4arVALbH0Yg5CnJWmWBlHEX8V69NksXe81tLpTLKfz21fTE46djVBmaaQ7AyRVcj9
         y/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEH1r+3QLnchzq2h6TAFHKRy1i9oqHoEkYmVU/ViBBzXVU+YjEpL4sOXB5JliLJfH7pHK7pMHK/F5tDevJdP+z0n86TQS3SPdcJqNjkC2m7AiF7v2LenZ1+xUl0jekOfyqPMnXtrWvW3vBD8DvMxVlHtfthsKBcN2sthuQUw==
X-Gm-Message-State: AOJu0YygacC4U5l4VjPireflIS+GmXCCp3a38vrWS0ETcDusw2PP+1M7
	cJZ7J0WY54STL+Q1TG+zrsQ/xar/WJiiVaf6gfqfLRDMvcPqxaqFGr1EDjtVNec=
X-Google-Smtp-Source: AGHT+IEDYN1p1Ejz5uDuIbgSh4SFV11bXXrqvgBcuT0L7mAYmVLFZrgQ2Oa4MLglrle/kIutQPpxvg==
X-Received: by 2002:a05:6214:21ce:b0:691:4eaf:ffeb with SMTP id d14-20020a05621421ce00b006914eafffebmr10343373qvh.44.1711415699918;
        Mon, 25 Mar 2024 18:14:59 -0700 (PDT)
Received: from l1441l.lan0.xorvpn.com (pool-98-116-41-146.nycmny.fios.verizon.net. [98.116.41.146])
        by smtp.gmail.com with ESMTPSA id c5-20020a056214224500b006968d8f1c05sm1697208qvc.26.2024.03.25.18.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 18:14:59 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: hodges.daniel.scott@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	lee@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz
Subject: [PATCH v2 3/3] leds: trigger: Add documentation for ledtrig-bpf
Date: Mon, 25 Mar 2024 21:14:47 -0400
Message-ID: <fd8c1022eda25ff80b27ff3bf7fa15dbd6947ebf.1711415233.git.hodges.daniel.scott@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711415233.git.hodges.daniel.scott@gmail.com>
References: <cover.1711415233.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation for led triggers to include the BPF LED
trigger.

Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>
---
 Documentation/leds/index.rst       |  1 +
 Documentation/leds/ledtrig-bpf.rst | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 Documentation/leds/ledtrig-bpf.rst

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index 3ade16c18328..2af52a19d6bb 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -10,6 +10,7 @@ LEDs
    leds-class
    leds-class-flash
    leds-class-multicolor
+   ledtrig-bpf
    ledtrig-oneshot
    ledtrig-transient
    ledtrig-usbport
diff --git a/Documentation/leds/ledtrig-bpf.rst b/Documentation/leds/ledtrig-bpf.rst
new file mode 100644
index 000000000000..391a305f69d1
--- /dev/null
+++ b/Documentation/leds/ledtrig-bpf.rst
@@ -0,0 +1,13 @@
+====================
+BPF LED Trigger
+====================
+
+This LED trigger is useful for triggering LEDs from the BPF subsystem.  This
+trigger is designed to be used in combination with a BPF program that interacts
+with the trigger via a kfunc.  The exported kfuncs will have BTF names that
+start with "bpf_ledtrig_".
+
+The trigger can be activated from user space on led class devices as shown
+below::
+
+  echo bpf > trigger
-- 
2.43.2


