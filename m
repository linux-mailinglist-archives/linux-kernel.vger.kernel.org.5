Return-Path: <linux-kernel+bounces-112918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0146887FBF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5891C211BB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9A6EB74;
	Sun, 24 Mar 2024 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R83V/4X2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A316EB5C;
	Sun, 24 Mar 2024 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319730; cv=none; b=jDDOFvdAhRdreEIdq32+ceYjvpegIDMiXrB+W4ltB4L7BYzn2Ax9ZWCsD77TV3F4kX/WQYp4VeVzYMlie2VXzDTsQPHkGhRBapz/ARzfXWFRCD8zV4CUX/MDg8VKgv2H8Pe/O1/pHyUCgUB75xicsVHKsr8rj+BkpfCHsbOtIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319730; c=relaxed/simple;
	bh=5Ds3TB7+/SF9s/aIHH6qhACfJy7hakZs8cM0naRFrrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMIHqAzkAy5I4vStZUFRPImoRflHzz2/m4eL6iEBK7t/E2SNi3IY4lWpwcWpf+/8NRM06lyYslqE+UwLNhHWZiv8ao8Dhc+4CB8ki4QR0OaDZ6hkLEk2jonE/ILe+1Bjv7FWI4Og8Om++L6v35wmdtMFiIdw+zIWaPlIrXd8IYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R83V/4X2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8E1C43394;
	Sun, 24 Mar 2024 22:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319729;
	bh=5Ds3TB7+/SF9s/aIHH6qhACfJy7hakZs8cM0naRFrrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R83V/4X2i+aESD0ce3KNHtXQMeXsd7gMZJ/s6Rd6ZLjSbqVT32SgCyY/74YPIsEfU
	 5FphGNcRqpfh84BxbquJegfF30fWnmqBZviIvoaBZrFpnUOEKhQA11K3qyAfnc0fmv
	 TeV75fNAWg+9xdOm251Iu8l+v3md5wiNnTNf6TwYnsBlVlcMe2Kvzd/uDr5aBVUNDS
	 F/V/d+PXvQOabQBoUh+N/uNOq6AfZZ624fIMRO30lq2gF3uzrgKlU3Zl4oFUDOzmuu
	 NZm+nJj3yS5a7rFSi+a9YjdH69AiBeEg+pBnN9YdCzkFI3tOwCeuN3OltKmwa1M+9Q
	 9i1uU5O9fsafA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 031/715] time: test: Fix incorrect format specifier
Date: Sun, 24 Mar 2024 18:23:30 -0400
Message-ID: <20240324223455.1342824-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Gow <davidgow@google.com>

[ Upstream commit 133e267ef4a26d19c93996a874714e9f3f8c70aa ]

'days' is a s64 (from div_s64), and so should use a %lld specifier.

This was found by extending KUnit's assertion macros to use gcc's
__printf attribute.

Fixes: 276010551664 ("time: Improve performance of time64_to_tm()")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/time_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index ca058c8af6baf..3e5d422dd15cb 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -73,7 +73,7 @@ static void time64_to_tm_test_date_range(struct kunit *test)
 
 		days = div_s64(secs, 86400);
 
-		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %ld", \
+		#define FAIL_MSG "%05ld/%02d/%02d (%2d) : %lld", \
 			year, month, mdday, yday, days
 
 		KUNIT_ASSERT_EQ_MSG(test, year - 1900, result.tm_year, FAIL_MSG);
-- 
2.43.0


