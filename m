Return-Path: <linux-kernel+bounces-68121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EFB85763E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50FEB23FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F29E1BDC4;
	Fri, 16 Feb 2024 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/L6YYR8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2831BC46
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066434; cv=none; b=WFrKtU5R5TnUloWziHUQekR1C3B/RvCk0T7ly1Hk0w+5G5DcCZGA6rdKIJukFDOyGrUI5rt/85p2AoKakIgsLiv7+a80uuhHVVNgZAw22QPLzL+CyPTzW33lh1tJZaQ7GHdTQGZHECxu3gxdVfXLsXC4uRFVuf9zDRyYah8PJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066434; c=relaxed/simple;
	bh=OMwiUGzZhHIC9yKcus+0Ro/4xBOBkZGCI2WykwcHxec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqmAt8zXBz8fiWG/guapbmx3JoTt9SCL3YWsvMWDvQ4zLguqr5qz38KOGeKT985nBI6n2rOt29L0vMqT+LqoxkKKxzrrNueVdP6AEhCWHa9tEEbCSquc9M/eaObR4b+F1Ty9BlpUhy2YB9Lym3zGvqyWHvzoN+IqoxoTiX/y+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/L6YYR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1638AC433C7;
	Fri, 16 Feb 2024 06:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066434;
	bh=OMwiUGzZhHIC9yKcus+0Ro/4xBOBkZGCI2WykwcHxec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/L6YYR8D3lmY2K9Pmpzprip1CG/noGquvl9fgyT0V71zUn97O8v6rljtSk+IB6+U
	 I6MTnvOhmBybARhB1manPvdvX8CtCUXLKkouXx/66VqqGWwKhofjSM4HmVxm0SASjK
	 0o/AbW2l+iWAo1n1e1s1qUp5WqKnjl7mFUQG787geHYKWyyFp7T8xYgDSNjBDZKS34
	 rCyGoBCD6K2FeRfef2OBdrTBvhEJOdy+nhwxClQUssTqziUTPx6gmGXiW+WRXpMkIo
	 URd4BsUqbJsoKZstUGmrXFEwBHvS8LDAMe91AO2SQeRsMo2LyLC1b+uBhFe9/Nq4o/
	 79nI9WRxWH2fQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 07/21] drm/i915: remove intel_vbt_panel_data::edp::initialized
Date: Fri, 16 Feb 2024 07:53:12 +0100
Message-ID: <20240216065326.6910-8-jirislaby@kernel.org>
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

intel_vbt_panel_data::edp::initialized is not used since commit
9f0e7ff4b366 (drm/i915: fetch eDP configuration data from the VBT).
Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 01eb6e4e6049..e0d291dd7d2d 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -327,7 +327,6 @@ struct intel_vbt_panel_data {
 		struct edp_power_seq pps;
 		u8 drrs_msa_timing_delay;
 		bool low_vswing;
-		bool initialized;
 		bool hobl;
 	} edp;
 
-- 
2.43.1


