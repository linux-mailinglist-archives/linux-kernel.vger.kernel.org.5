Return-Path: <linux-kernel+bounces-122432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F86888F75A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79AE1C26049
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1844C600;
	Thu, 28 Mar 2024 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsJJA0BQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8A46424
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604367; cv=none; b=qqNIflfigQdbxOxHuD+ATQQkp2/zVC8OwmtjGulWREDNVqNc2BQLageTzZyvfjK/9F4O/yarmFoHp4U+Jzra+WU/mi1sDCacXaKfa9PNSmOkVybXas9rptDXjMyke9hNYE2WDGe/s4QkkwexhWnWfTKk6Y7LCnCNIRED42TcMZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604367; c=relaxed/simple;
	bh=/C7YmCyi76cdNCIgLJ4s57sUTMiGolVuUEfTdswA5OA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBA7NVR8tfEYnZqwXvw5xMNZoCcgMr7tiZJVEmPovxtgFtdjuWSr09nblL7ojZchqyuYsX5+bhaxwFfMHZFi3jPcY+i+tnBnifZknLSzVyEsEPk+KNJ5KAGw38Y/xDd/4884DTvFXKXR6DHN1p9UH7/bjUHshV4OnwHBLmPTweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsJJA0BQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802AAC433C7;
	Thu, 28 Mar 2024 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711604366;
	bh=/C7YmCyi76cdNCIgLJ4s57sUTMiGolVuUEfTdswA5OA=;
	h=From:To:Cc:Subject:Date:From;
	b=lsJJA0BQFpjBJ/AIVnZp3PZ7R6Rsil/YIxYzapWmqG56QfWTLGYxC5NDByRPT4fqu
	 vpH0UGpc9qIcotajnq/UrvUFM96yOivI215SHgtrXPxZ9orSMn0ANKhwhWuXmm7Pib
	 fH6DB+Tor9Nb6/wNTnljJ/BqudDZuc4f/r+dTbVjY5EbEw/1G2eaGu81PD5iYHQ98z
	 OSx755d9/clcut6n1Z/dOK4QAX01uO9Mihz8PNsurssSXKNQHwbL4XFUxB3Aqb6VAC
	 jMzvRgOjzqPZxJTe1gi8ELoopz4YCcGc1wcma/cqCYMKQ4/a9vw4nB5KV/mXngqHSI
	 k4wkXZvrbG4gw==
From: Vineet Gupta <vgupta@kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 0/2] ARC minor fixes
Date: Wed, 27 Mar 2024 22:39:17 -0700
Message-Id: <20240328053919.992821-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some fixlets for ARC.

Vineet Gupta (2):
  ARC: Fix -Wmissing-prototypes warnings
  ARC: mm: fix new code about cache aliasing

 arch/arc/Kconfig                 | 1 -
 arch/arc/include/asm/cachetype.h | 9 ---------
 arch/arc/include/asm/ptrace.h    | 2 +-
 arch/arc/kernel/kprobes.c        | 7 ++++---
 4 files changed, 5 insertions(+), 14 deletions(-)
 delete mode 100644 arch/arc/include/asm/cachetype.h

-- 
2.34.1


