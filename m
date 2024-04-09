Return-Path: <linux-kernel+bounces-137309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11A89E039
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172CE2893F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326313DDDE;
	Tue,  9 Apr 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNtj7sO3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0F13DDD4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679621; cv=none; b=P6c6kGeaDKFk/aAywLYJmLssXp8dBiAkP1ZR0rmChp7pOHfebzpA+4RFKy5v12ABO7xEFZzkt5CO01NCu0b0Ppb4yJDeAg8Q8sfPdNi7E4GdnnFCaEHMaUCG+zpmTV8CmoteK0oUKnqe/5sCJ0m9RbzvVq6Qhnm2VmIH7aepybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679621; c=relaxed/simple;
	bh=vA77VMKw+Zk+qUpi/Fg+f2xXCoVaVTSiTo5V6KCtvCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESTZJa9xRTw4mTz9LGkNaYsVu3yi+gkH4jCWe4ARr0irT5BRaHVkq/dDSIMfisjkVGFx7lWvYXfkdJiYIQCfYlpGZSR8skVmkSRMZKI4pbuoMuGtUmJhHW8SDl6SF5KtXiUwX7qYySVlWXFdsT5+L4H7cwDlzIogTx7iy3QSkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNtj7sO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BB1C433C7;
	Tue,  9 Apr 2024 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712679620;
	bh=vA77VMKw+Zk+qUpi/Fg+f2xXCoVaVTSiTo5V6KCtvCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNtj7sO3rQIpfn7QUaprFA1g3UWIIxL0NL6ByQZMXWZrTUHPiQrGqkuVWnQDAnd7t
	 AyDZ04EA6A1ZmCCaYCfE76Pkhqy9RfgMX220ZsVPAa4YJD3TBF9yymnDmW+RQ2Q3i6
	 nYdlHaTTgxeSXkKZg+xuba5X83crSBpnmozVuLHS87OLewcnKDakM1Gj3gI6goYQWh
	 M//PFgqny4MeN70sgzKnS5yp1fakYvyjMqeqtvCascOLmOXXWYSCVoeEAjQkPa4peA
	 Jk0QL8uJXuRI5rNenaJOHcz1F9jaBqBhzVGTL2J/5iq+97uNsvrV+nyFeyf/xb3vsn
	 sJPJWGARlCw4w==
Date: Tue, 9 Apr 2024 16:20:19 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Light Hsieh =?utf-8?B?KOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
Subject: Re: [PATCH v2] f2fs: don't set RO when shutting down f2fs
Message-ID: <ZhVqwwCesxWOfbOA@google.com>
References: <20240404195254.556896-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240404195254.556896-1-jaegeuk@kernel.org>

Shutdown does not check the error of thaw_super due to readonly, which
causes a deadlock like below.

f2fs_ioc_shutdown(F2FS_GOING_DOWN_FULLSYNC)        issue_discard_thread
 - bdev_freeze
  - freeze_super
 - f2fs_stop_checkpoint()
  - f2fs_handle_critical_error                     - sb_start_write
    - set RO                                         - waiting
 - bdev_thaw
  - thaw_super_locked
    - return -EINVAL, if sb_rdonly()
 - f2fs_stop_discard_thread
  -> wait for kthread_stop(discard_thread);

Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - use better variable
  - fix typo

 fs/f2fs/super.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8ac4734c2df6..df32573d1f62 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4159,9 +4159,15 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	if (shutdown)
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 
-	/* continue filesystem operators if errors=continue */
-	if (continue_fs || f2fs_readonly(sb))
+	/*
+	 * Continue filesystem operators if errors=continue. Should not set
+	 * RO by shutdown, since RO bypasses thaw_super which can hang the
+	 * system.
+	 */
+	if (continue_fs || f2fs_readonly(sb) || shutdown) {
+		f2fs_warn(sbi, "Stopped filesystem due to reason: %d", reason);
 		return;
+	}
 
 	f2fs_warn(sbi, "Remounting filesystem read-only");
 	/*
-- 
2.44.0.478.gd926399ef9-goog


