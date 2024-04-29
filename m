Return-Path: <linux-kernel+bounces-162332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206A8B598A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA8FCB243A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2627A745F0;
	Mon, 29 Apr 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ezLsVoiC"
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BE54900
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396190; cv=none; b=LkJZXDFYErZXw/JLMkNW2yR8es8joJ7oAU+GHtkf/4miFxH4WHXNeIeHj83qdZZsM2IrFJ/1uJmyN/F7CthPqhOaDs7N0cbjHk2++iTbbDVMhLfsqYLUkR/uKm4lFudkI9MKIZ2ybVer7CH4pd7J0vaC1Vx6FDYnzCKb1AAaXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396190; c=relaxed/simple;
	bh=IpmTWCvbM5Y1BZCTiLdiFP10tZDAQxPRcR3dUY7GJf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVBJAzXuE77PoP5WPZE17MMMmu1X0H45HpBLzhMPKbp/w91tsr+TelGjenGrBqt57FKBbUNG+hoSCJ5XgFDtnhArTYywoZn28casYbDX33Rjoqx0tLX7xPsp5xopseJ2wdm+eWJuXMBD7euAbqTCioHuhsYu2Z4n9q5fyf1ESxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ezLsVoiC; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VSkFJ1jbczDkv;
	Mon, 29 Apr 2024 15:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714396179;
	bh=IpmTWCvbM5Y1BZCTiLdiFP10tZDAQxPRcR3dUY7GJf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezLsVoiCFzgvsCgCrNXZ8hf/DCYlSzatU9p4feD05MUOMMS8F4/1lf64/SPzedaHc
	 UNYNKmbodTv+L26KKSM3epkhgPsdng4AlsGCF2Sw7vn9hiNeihS6pHER5wWCXzFSbs
	 HB5BF0JG3Yt1FKQe6MG0ZWeFDgP2EZWLpZM7QaOk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VSkFH3GSvzLbZ;
	Mon, 29 Apr 2024 15:09:39 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 2/9] selftests/landlock: Fix FS tests when run on a private mount point
Date: Mon, 29 Apr 2024 15:09:24 +0200
Message-ID: <20240429130931.2394118-3-mic@digikod.net>
In-Reply-To: <20240429130931.2394118-1-mic@digikod.net>
References: <20240429130931.2394118-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

According to the test environment, the mount point of the test's working
directory may be shared or not, which changes the visibility of the
nested "tmp" mount point for the test's parent process calling
umount("tmp").

This was spotted while running tests in containers [1], where mount
points are private.

Cc: Günther Noack <gnoack@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Link: https://github.com/landlock-lsm/landlock-test-tools/pull/4 [1]
Fixes: 41cca0542d7c ("selftests/harness: Fix TEST_F()'s vfork handling")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429130931.2394118-3-mic@digikod.net
---

Changes since v1:
* Update commit description.
---
 tools/testing/selftests/landlock/fs_test.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 9a6036fbf289..46b9effd53e4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -293,7 +293,15 @@ static void prepare_layout(struct __test_metadata *const _metadata)
 static void cleanup_layout(struct __test_metadata *const _metadata)
 {
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	EXPECT_EQ(0, umount(TMP_DIR));
+	if (umount(TMP_DIR)) {
+		/*
+		 * According to the test environment, the mount point of the
+		 * current directory may be shared or not, which changes the
+		 * visibility of the nested TMP_DIR mount point for the test's
+		 * parent process doing this cleanup.
+		 */
+		ASSERT_EQ(EINVAL, errno);
+	}
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	EXPECT_EQ(0, remove_path(TMP_DIR));
 }
-- 
2.44.0


