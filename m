Return-Path: <linux-kernel+bounces-40572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BA683E29C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E638F1C2374A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3EF241FE;
	Fri, 26 Jan 2024 19:32:16 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D22375D;
	Fri, 26 Jan 2024 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297535; cv=none; b=CPb76cG332f6I+CgC4tb9rIX2CA5EdJtZs37b7y8pUFTYbSIsbEF1t7XtTX/+8hGVGJxswOx6Syg4217xZjU3HCVi1cHKaKyyu5BSI5FYTOw6f1PzabRdYIh5kSQQpMbdP9JhoP6tkuVaYU+9OGUirnPGX8fTv0mJllYi/YXX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297535; c=relaxed/simple;
	bh=/hxB9mWKi9mgLDpS2dW9KVNxf5L9+nCnH/rGPcZKBWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PhN2NowXya16d6cPaW3+xQxQI2hkjmtZY5rLaGieBOdQRXHWdg5TXHxzNx8zhKTD43mmWVcuPdR90JxA49L2gfyH95TPNk/EBLvhrYWWhNVs4BSyw2wKtCmiiimnGvy7jSw1q2gBoMxsNMoV3QIjoUy9cEvFC+pUErI8Gm35AJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 17B3C2F2023C; Fri, 26 Jan 2024 19:32:09 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 59C002F20236;
	Fri, 26 Jan 2024 19:32:04 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: keescook@chromium.org,
	sfrench@samba.org,
	corbet@lwn.net,
	natechancellor@gmail.com,
	ndesaulniers@google.com,
	kovalev@altlinux.org
Subject: [PATCH 0/2] smb: client: fix "df: Resource temporarily unavailable" on 5.10 stable kernel
Date: Fri, 26 Jan 2024 22:31:41 +0300
Message-Id: <20240126193143.245122-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After mounting a remote cifs resource, it becomes unavailable:
df: /mnt/sambashare: Resource temporarily unavailable

It was tested on the following Linux kernels:
Linux altlinux 5.10.208-std-def-alt1
Linux fedora 5.10.208-200.el8.x86_64

The error appeared starting from kernel 5.10.206 after adding
the commit [1] "smb: client: fix OOB in SMB2_query_info_init()",
in which the buffer length increases by 1 as a result of changes:
..
-      iov[0].iov_len = total_len - 1 + input_len;
+      iov[0].iov_len = len;
..

[1] https://patchwork.kernel.org/project/cifs-client/patch/20231213152557.6634-2-pc@manguebit.com/

Error fixed by backported commits in next two patches  adapted for the 5.10 kernel:

[PATCH 1/2] stddef: Introduce DECLARE_FLEX_ARRAY() helper
[PATCH 2/2] smb3: Replace smb2pdu 1-element arrays with flex-arrays


