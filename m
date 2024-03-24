Return-Path: <linux-kernel+bounces-115870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A78889858
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549501C31B12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA8B2655D5;
	Mon, 25 Mar 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utFVvUp9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28131535B6;
	Sun, 24 Mar 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322046; cv=none; b=TQGCaKw8qoKC3xC2cr5MR4WlFnrbtJGAlqRMHJiPh2H5sN3lNmE3zxAic9IVv4wNs4oPa9GwHi7bMTBaUWTj9jJxitXpYLxWRpLkE9kU2w1/yIjYAxvgvf56nN+nrC84pko8ehWb5dYKFooCcSDQWnXwpTjyZs8AjdqLaHNICfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322046; c=relaxed/simple;
	bh=5U0eUZZUNHAgCzjs8VzSGTtjfKcCAcG5sjFRe2C/4hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WusP5FUsLJ9s+BYEs9blsJWZ5oUZFqi0sHwaUWsGy76GDIv3WOAX+PLcqBPSLqO1ve9WyR4nwvZJJ+JQaJ7MORF8flr4XjlETRPjVE/AHl0iOa9KWdHVDzgfEfsM5ys+S2vFQNpdxpcZyYMWUrldfdTXRX0FH0uRRu/dDKD3/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utFVvUp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5063DC433C7;
	Sun, 24 Mar 2024 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322046;
	bh=5U0eUZZUNHAgCzjs8VzSGTtjfKcCAcG5sjFRe2C/4hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utFVvUp9IxH4j4wYOECCLsbZeb1HcVzlHzXQ+N2SHG26wRmr4LcMj89cjsJ8Ca5P7
	 zOa8XcIRJJfWJk+4D7mn0IyRyFV2xz6RuEEUK5RE/I+UOkEBuHutcCH/h8fYjMXIln
	 dNmshgRVeuYF9i8Z8RP97/m7i6wNPLj7DDDrTYvbKUGkuXHogLJjxWJ53Z0vPJi9qM
	 T+nYA+mYUTQd15prqWqEQ6XLwyinlHHxLsg61tbEFOutaqowN/HnTX6ZZuMW2MRLYN
	 Jg4pc38C/BcE20f5XwjrL4Dp/jhw0h1M0JfUZDUXyR9z9G/gjCjV0HiSy4HWotwMet
	 ImDEyjop9rG3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 118/451] wifi: iwlwifi: fix EWRD table validity check
Date: Sun, 24 Mar 2024 19:06:34 -0400
Message-ID: <20240324231207.1351418-119-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit c8d8f3911135921ace8e939ea0956b55f74bf8a0 ]

EWRD ACPI table contains up to 3 additional sar profiles.
According to the BIOS spec, the table contains a n_profile
variable indicating how many additional profiles exist in the
table.
Currently we check that n_profiles is not <= 0.
But according to the BIOS spec, 0 is a valid value,
and it can't be < 0 anyway because we receive that from ACPI as
an unsigned integer.

Fixes: 39c1a9728f93 ("iwlwifi: refactor the SAR tables from mvm to acpi")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://msgid.link/20240129211905.448ea2f40814.Iffd2aadf8e8693e6cb599bee0406a800a0c1e081@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index f5fcc547de391..235963e1d7a9a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -725,7 +725,7 @@ int iwl_sar_get_ewrd_table(struct iwl_fw_runtime *fwrt)
 	 * from index 1, so the maximum value allowed here is
 	 * ACPI_SAR_PROFILES_NUM - 1.
 	 */
-	if (n_profiles <= 0 || n_profiles >= ACPI_SAR_PROFILE_NUM) {
+	if (n_profiles >= ACPI_SAR_PROFILE_NUM) {
 		ret = -EINVAL;
 		goto out_free;
 	}
-- 
2.43.0


