Return-Path: <linux-kernel+bounces-154236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197F38AD9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4946D1C20FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB7158A16;
	Mon, 22 Apr 2024 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAf5XJqc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDEC158870;
	Mon, 22 Apr 2024 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830079; cv=none; b=rdL7UXseNcOYWCiveY0PLzY5Vfr6yWvqDKdwJPPahNKEwZxAS1Rkqnnlvs7zB0Shj9V6gdimAazhiBystleW46DvA+l/LCNQ9OWCfhTbDCRmpmY5ETAIOqD0xFCYLN6Fv6dYJXbC1VEWQ1ZRslXa4YtoRb+LrmbLUdcxKTldhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830079; c=relaxed/simple;
	bh=7liINkEU1emdMgsHVMwI/aHr5XR3muay1ef3hai/zVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agjtZcwoa1/vj9ZTF9EUK648cDcPYVXE+fhMh1VoeC90M8qLanVlPvJApujVLc0Gwvj33TMSv1fBaLaQNscVhO3Zlkfi4HWvSpNTQwq6BHUzFujWpbhJopgFtlzlQRJ29CwpqJFBz5U3E2IpyK6jx68fKTvJVBd6XhJ3sm6pAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAf5XJqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2212BC32782;
	Mon, 22 Apr 2024 23:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830079;
	bh=7liINkEU1emdMgsHVMwI/aHr5XR3muay1ef3hai/zVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAf5XJqc6EiEqLxSSoFuvAowUmfCX32Qb1UjCxFzcmwfJYn7rOIflHOB5G+Nrlxf5
	 DtXw7ax3joZ1N7sAWA5qEetpPF3AS/z3fM5W0dQOZVmquTBhYPwbJzDHYoH9rS0keI
	 c1BFq3e+eZz5+PNaWOd6kfRuW5T5f8LecDtGAGYCanyfuriSkS2xK7eu7gCz/aDPEP
	 UOVhWVwV15iEWXaaLII2OGOjONPsxTZVe9KfnfwwdqKvg5W6yqr2pH9Vt317cmtIfL
	 F4bXyNPoN5wC+hbinNYDBrA+oPBEaiRDpdZAW5lF4im7g9DykolPzXe82MHfmUNt8+
	 5OFadbQAtUwaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	stanislaw.gruszka@linux.intel.com,
	ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 19/43] accel/ivpu: Fix missed error message after VPU rename
Date: Mon, 22 Apr 2024 19:14:05 -0400
Message-ID: <20240422231521.1592991-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

[ Upstream commit 0d298e23292b7a5b58c5589fe33b96e95363214f ]

Change "VPU" to "NPU" in ivpu_suspend() so it matches all other error
messages.

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240402104929.941186-8-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 2d706cb29a5a5..64618fc2cec40 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -62,7 +62,7 @@ static int ivpu_suspend(struct ivpu_device *vdev)
 
 	ret = ivpu_shutdown(vdev);
 	if (ret)
-		ivpu_err(vdev, "Failed to shutdown VPU: %d\n", ret);
+		ivpu_err(vdev, "Failed to shutdown NPU: %d\n", ret);
 
 	return ret;
 }
-- 
2.43.0


