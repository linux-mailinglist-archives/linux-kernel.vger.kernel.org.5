Return-Path: <linux-kernel+bounces-151601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DE68AB0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0221C224A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D19512F378;
	Fri, 19 Apr 2024 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oATss3xu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4A7BAF7;
	Fri, 19 Apr 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538079; cv=none; b=jGyd5omjLLuRvJ2ZpHbZ+NLd3mcwd3QUA0gTagOP8LgcLhYON7xU3boMqFDLT0nUK5eq0fTOp/fWxD6TYqTu6Sgi4IIfnG30qLJeLdYf5s7e4yBos4WW4NdXLM7diZAmvcpARHtVqwOq0PDfw9ytNrATxpskuoidx706ScYSdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538079; c=relaxed/simple;
	bh=Vmc6uljHRntJBts9DEApBMq9kJrVnjN559MuPl/JPvY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sSJ8KxG8MHYuB10xuWEFVMN+R/ZdC6H1Q3gVECK8JFky9+sE1jj70LG7OqQb8ZMIxrDIfQx4J/pCkZotNpwzGsbYbcqtaPcjnsULRx3X3v3CedJtuy4UfBJ2Qer6DskaqJwJeaHmGCXal5PW4HHrABfvFqkj8r7Cpang3nLKmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oATss3xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE23FC072AA;
	Fri, 19 Apr 2024 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713538078;
	bh=Vmc6uljHRntJBts9DEApBMq9kJrVnjN559MuPl/JPvY=;
	h=From:Subject:Date:To:Cc:From;
	b=oATss3xunmgNT0u+8ornpkeuTAS/jWOhja5fjOtkoDuudOlKwTYa1K/3CPo14wWCY
	 Re72jJhjB7BR/3RqdSFBBLmZ46OLn8iuFIwvc/qAZ361fwKoanDawnLuOOiB8Ax88U
	 WuPIudjokUNlVVYPYnE/Jv9ew7crTZtmvkM6zYrMx9ELJLgcYQ9f6Lq9MaPhID2DMQ
	 wQ3rKamAevyBk1ed2gcR/n7m8RU0bgnFNawwsqG77HYYXu5KQoBUWH5CN85/gpTePf
	 k0f6o36ZiG7W6PHioQlVh8HQTmtFCPqTDo9ewtbuLc0uUQfadOMYCz3v98ivArFSuy
	 BuMljNR3kUcZw==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/3] HID: bpf: some fixes for pre-loading HID-BPF
Date: Fri, 19 Apr 2024 16:47:50 +0200
Message-Id: <20240419-hid_bpf_lazy_skel-v1-0-9210bcd4b61c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABaEImYC/x3MTQqAIBBA4avErBMspLCrRIg/Yw5FhUJU0t2Tl
 t/ivQwJI2GCocoQ8aRE+1bQ1BXYoLcZGbliaHkruGgkC+SUObxa9XOrtODKtOGu64U1Qhoo3RH
 R0/U/x+l9P3XeqdFjAAAA
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713538077; l=1241;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Vmc6uljHRntJBts9DEApBMq9kJrVnjN559MuPl/JPvY=;
 b=dH+Tb8LcFr6PErY4tmh5SeDIfBbGra62JhiR8cw22cbSx/zh8+1beYHqxpoQkMieF9/GIO7zs
 WJYH006XLlrArLWrJuwQyMLdqxxkAVQ99cOyptgpNM6OzA3rH44PK1E
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

As I am working on the next functionalities of HID-BPF, I realized that
I had a few issues while preloading the skeleton at boot.

None of the errors are terrible as they are not inducing a kernel crash,
so it's not super urgent IMO.

Regarding the last one, I'm not sure what makes RHEL behave slightly
different than upstream. But I am not sure also that the code matches
upstream everywhere, so lazy loading it seems like a sensible idea.

Furthermore, that also means that the code will not be available until
requested by user space, which fits well in the whole idea of HID-BPF:
if the user doesn't want it, then it shouldn't be it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (3):
      HID: bpf: fix a comment in a define
      HID: bpf: fix return value of entrypoints_*__attach()
      HID: bpf: lazy load the hid_tail_call entrypoint

 drivers/hid/bpf/hid_bpf_dispatch.c  |  6 ------
 drivers/hid/bpf/hid_bpf_jmp_table.c | 17 ++++++++++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)
---
base-commit: b912cf042072e12e93faa874265b30cc0aa521b9
change-id: 20240419-hid_bpf_lazy_skel-ab0d674cb49b

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


