Return-Path: <linux-kernel+bounces-68118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C654C857636
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFA4286B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647A1B279;
	Fri, 16 Feb 2024 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZfOy8AS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6C1AACF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066425; cv=none; b=PpCgHPb9LglTOExvlYii0gIm5IeBWxP7C9W+eTm/8F+535E43qChkaOKiauStnqQtYqBw99TiRlEysCyJu4KXyzupg7P/lGUbpwpoKXowEbpgiJDDihfXKYKtvz1SyR8CHxPkXPMzoNs2zJParLMX/jaqFT8TnyfmitQTrGelqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066425; c=relaxed/simple;
	bh=sH0FzSylb4GHpKMjELKxOSqoIZwIATsF0+uo2uRnxfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQeU1QnNHcBeP/jH1TVpk17YEZVc5zTv1EB0Z2zUGleWvhLiu3Yx3MhjABQMPOzODHVs7EqqV5eRj9q/lyjPvh9IyfmK3GsEA1FB1fUwxux8UEuiG4I0cZR7ESKAl55a0Y1Kf18hbf/Wf3/7RuL/mxoGXpmyAGuuZ1m6s7X2HtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZfOy8AS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932E8C433C7;
	Fri, 16 Feb 2024 06:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066425;
	bh=sH0FzSylb4GHpKMjELKxOSqoIZwIATsF0+uo2uRnxfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZfOy8AS1VK794BqL6EDv6yN4/raYXNT5U7KlgAdOJiZS4GPNDzMCLba4+68d/6CH
	 fQweIQd5bMxXv8H33HHDsDkqEnikj528gOFmAc3ypAnDT2qYip7vOoZOqlYZuRGorc
	 xeiSKoxWi7pPX0S3hJF9YETECd9RujLyhyKZqqV/lcAQOClVYwOFp9EnO39LsUSKG1
	 aFFlIuiXlycxCnHFJ26ihTzCPz7pfYIiERAKyExjotKbiIzg9VuxrVuoFvvaac2nFj
	 0M07qcJK7luruzbR+Ai8jXgBVZcXkYWynqFyfjqq4KEm4LqbG8gpdPvoIp/BxqfDug
	 RfX7JfabFHc0A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 04/21] drm/i915: remove intel_gvt_gtt::{mm_alloc_page_table,mm_free_page_table}
Date: Fri, 16 Feb 2024 07:53:09 +0100
Message-ID: <20240216065326.6910-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216065326.6910-1-jirislaby@kernel.org>
References: <20240216065326.6910-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_gvt_gtt::{mm_alloc_page_table,mm_free_page_table} are not used
since commit ede9d0cfcb78 (drm/i915/gvt: Rework shadow graphic memory
management code). Drop them.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/gtt.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index 4cb183e06e95..fb96ea454fd1 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -93,8 +93,6 @@ struct intel_gvt_gtt_gma_ops {
 struct intel_gvt_gtt {
 	const struct intel_gvt_gtt_pte_ops *pte_ops;
 	const struct intel_gvt_gtt_gma_ops *gma_ops;
-	int (*mm_alloc_page_table)(struct intel_vgpu_mm *mm);
-	void (*mm_free_page_table)(struct intel_vgpu_mm *mm);
 	struct list_head oos_page_use_list_head;
 	struct list_head oos_page_free_list_head;
 	struct mutex ppgtt_mm_lock;
-- 
2.43.1


