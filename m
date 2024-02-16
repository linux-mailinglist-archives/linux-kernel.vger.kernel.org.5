Return-Path: <linux-kernel+bounces-68128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7229857645
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FABF1C22777
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDE91CFBE;
	Fri, 16 Feb 2024 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID/5JZuI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCF1CFAC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066456; cv=none; b=Hq9QitiMXs46Bxaf2D5FBc45QbStMBGncT24mHLO8KXJyheMvTh7MwtxI4s8RSElxFGY/rG2rn1Gu3If1g0/cZ1AMqZit0h4gv9sdnu3Hlax4CXhEwsw3lL2FB9dlkcRb/j2sUhTwjqJQn4TpuCLi8C/3tpgyl8QpON04j3bqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066456; c=relaxed/simple;
	bh=SXyIHpFd6ET8iufV6ZRXcOFvDY4mmrBUfCieGBadR0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkvilpDNA75YggB2auqpWZBaq99DW3w+a0Mqcs93fG+FPjznZxcqFQ5G5bv36W8n5uT/aorr1u4h8NsrW0c4ivDGc0tviPNUZzJoUg03dXcM25ezXp5LzfusMnq04W/Ducq7MmN7fLWd2ZJOctA2OiPqDRZtJriqUODZcLRc50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID/5JZuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2631C433F1;
	Fri, 16 Feb 2024 06:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066456;
	bh=SXyIHpFd6ET8iufV6ZRXcOFvDY4mmrBUfCieGBadR0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ID/5JZuIbZ7qR1aXjg2e0yERBM7vDBtiMaOKDAbabO1Cz1Sqt7sMoMOR+AZLRcshz
	 KkpjdY7DmWTACjfEIrMqmLPmj82z/2aToB1WKxmewUwew8c8scMtgIhCX6olwQU+CY
	 uXrphMLBWfGRsiB7m2y3U1qPgVZiU31qxJutPxz3dHx8YG0Rli7Q+5S/0z+APoqq9k
	 Ak0PWXsjVwt0wqvttbAY1bFcDhRafgqlO3ILJlUQk3fkZCqsAKSVuyBqEH+JOSnLj6
	 cI8IXozf1s30jEkneAMJBPzzNCgaAiz0oAFEaFXySEv340/YXVnqJTXGYAcX/mkYAN
	 lGBIgQ2vH3fOw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 14/21] drm/i915: remove intel_vgpu::intx_trigger
Date: Fri, 16 Feb 2024 07:53:19 +0100
Message-ID: <20240216065326.6910-15-jirislaby@kernel.org>
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

intel_vgpu::intx_trigger was never used since its addition in commit
f30437c5e7bf (drm/i915/gvt: add KVMGT support). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/gvt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 8e5d696fc79c..b8b8ffe4d566 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -221,7 +221,6 @@ struct intel_vgpu {
 
 	struct vfio_region *region;
 	int num_regions;
-	struct eventfd_ctx *intx_trigger;
 	struct eventfd_ctx *msi_trigger;
 
 	/*
-- 
2.43.1


