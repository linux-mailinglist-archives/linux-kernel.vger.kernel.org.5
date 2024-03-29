Return-Path: <linux-kernel+bounces-125131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7A1892072
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4DA1F2E505
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7E1C0DD5;
	Fri, 29 Mar 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z8Ryn5eB"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ABF1C0DC6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726198; cv=none; b=glyUTMquu6UIXbHdsM/yF5TgSfaNS+9Sl5UoVm8wvt931hE9fkXwo0bbD57KxRlEOlLy6MQ3RFxaVvaSsXGmF+ErbXnkVJ/NLCULtpFkdit0dE6CpEw7GRXjw6GhCa6ehz+sFHflsLKCRUVqvFDKm9Q3YZ6aGrxL6ubLWoHQ3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726198; c=relaxed/simple;
	bh=H/eGfiCoPpDQTvPeEIon83ZcTYLiotzPPecPoDgU+tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCbquuOV+46LFlw3Ppiisz13SvrsAXCA/im3+1uolTnR7bsCAZ2xXpYdlRAu52DEXkyljxE4FrHm8Q72JmL3PjLYBbAbH0klBKLKJRSODdQDna6x48qI7gCl0hazj3LlaLtPSy62LzD6efBCq2Zo0PMCRv3rNBCdvsrQN0/c36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z8Ryn5eB; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dc8b280155so1280028a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711726195; x=1712330995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzNSZ6G1qWiFUQSQyVJPr7JWiuaZBzmUWG+3hwZo+Pk=;
        b=Z8Ryn5eBpINZnhhRqMNTW8m7RO9oWGQNSP67gljQ7JlSO9/I1XFtfQAcu5GZMTurAn
         sGjP7FdWof1blfj1SVJxBbWkIz8NuxAbFkd5VK++NmrGbhIXRsG4rktUfAfxSL/uH0p2
         aK0rWRvrI5PEslQtp4aAz8C0TH5fDUUvq0p8XobcVaIZhWRtbEaImMWGVEmvcRjws662
         tuaY2tPj0TwX47aCw/5UCrmvDZqG2wMK7KPqV15zp7hxsccD8YKiOvkCBir4BWxBT4+1
         IooQmabP8aITSTmOTYNp6N2/5r1vAvX43TP5KjnPTX/D71KBZ1+X4rJfq8mbqh27x3tB
         BZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726195; x=1712330995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzNSZ6G1qWiFUQSQyVJPr7JWiuaZBzmUWG+3hwZo+Pk=;
        b=kvqbg+VxN44EtiIiz+c7XWuNQ8LuWLcEmR9J3RuBUvnzce2ooWmnNMVQo74zg0uzs3
         GuKkvoK4LgkogPahwrTEhJa3hzETmg+IJ2KeXbWvyX3SLJZTejWoqa1FN2c/2lzR9H1R
         PHLgXqg/guH2xHjXsmTMgpKA5Jtbc2EIhq2PrQ0N/x+iUBHH76RDi1IRX+p+gkUZfykq
         YW6h8DculCF95G3BLJiFodxK12QDxIk42LCJ4YMY781j6gV9WQhLy9A71mmHDW7KutzC
         +OJQzMIX/kBkO2AomX0AEDeDxoEl+spGuTJm4s7gLb/XJtWkG/V+gNwT2uw19q1tvPWq
         yx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHkxu3PQwEGbIQnESCth2Y0shERSG6UbMWHQ0+SywiVAVXpr30Ceg5ZqjgTl8VuQxtEPwfAaFkreWc6SXN/lVrry/dZGbwxhyFFgjG
X-Gm-Message-State: AOJu0YzAVMTfi2xkaYc+t05qiLmDyj5Bx3MuJAQXhfwfUrkSauPPrPRW
	wjdNe7S+YJzPHTlccmD0NXVaHMu1nGSB1CfGBBTPOKSc5w2mrfK4lKGmLr4dAzw=
X-Google-Smtp-Source: AGHT+IFR2fMOFIk1UfXLrPnEC1CztADEvHc1ABiWkLvqjwKnCTR2YYBFRmBwhz7IIBv/kRjlDulqlg==
X-Received: by 2002:a05:6808:11cf:b0:3c3:84c5:173e with SMTP id p15-20020a05680811cf00b003c384c5173emr2529550oiv.50.1711726195157;
        Fri, 29 Mar 2024 08:29:55 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id cr4-20020a056808368400b003c1e577140asm602225oib.25.2024.03.29.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:29:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: bpf@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix typo in uapi doc comments
Date: Fri, 29 Mar 2024 10:28:46 -0500
Message-ID: <20240329152900.398260-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a few places in the bpf uapi headers, EOPNOTSUPP is missing a "P" in
the doc comments. This adds the missing "P".

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/uapi/linux/bpf.h       | 4 ++--
 tools/include/uapi/linux/bpf.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3c42b9f1bada..f83a4de0ac30 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5020,7 +5020,7 @@ union bpf_attr {
  *		bytes will be copied to *dst*
  *	Return
  *		The **hash_algo** is returned on success,
- *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
+ *		**-EOPNOTSUPP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
  *
  * struct socket *bpf_sock_from_file(struct file *file)
@@ -5506,7 +5506,7 @@ union bpf_attr {
  *		bytes will be copied to *dst*
  *	Return
  *		The **hash_algo** is returned on success,
- *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
+ *		**-EOPNOTSUPP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
  *
  * void *bpf_kptr_xchg(void *map_value, void *ptr)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3c42b9f1bada..f83a4de0ac30 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5020,7 +5020,7 @@ union bpf_attr {
  *		bytes will be copied to *dst*
  *	Return
  *		The **hash_algo** is returned on success,
- *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
+ *		**-EOPNOTSUPP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
  *
  * struct socket *bpf_sock_from_file(struct file *file)
@@ -5506,7 +5506,7 @@ union bpf_attr {
  *		bytes will be copied to *dst*
  *	Return
  *		The **hash_algo** is returned on success,
- *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
+ *		**-EOPNOTSUPP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
  *
  * void *bpf_kptr_xchg(void *map_value, void *ptr)
-- 
2.43.2


