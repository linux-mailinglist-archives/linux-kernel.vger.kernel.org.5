Return-Path: <linux-kernel+bounces-68131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D835857648
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5AD1C22711
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A67B1F94C;
	Fri, 16 Feb 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD9yVN3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D11EB4F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066465; cv=none; b=W+hrX6t77Qwut/fZVPMXJlUY7WV4sERYum0DIKQoqEsEmvZ6VUiUspOt1mi46coW5lqVmRgWpu+/r6ieEiBjL6r9XiZCgrSmxzvU172UeuGj/BatLqCGoAx6TQPiffWRh4a7qS14jfVbqczhEqGl2V4J6QlJ6DWbvCtvOnpF/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066465; c=relaxed/simple;
	bh=guZaFSqSf3MqQt8V36466MzszKjuXHWltT0kqFLvhWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB8MW+S/9oQm2PPpLid9r7LDW3zExIuCAzDNfMlGX2vNDK/zHg4qSR36OJV3+3GvAC/didU7h0JPKkt/G+OF0XV2SIVQBhyCToSOeI6RU/nH5zWoBgaJIz8fC6Vaa6b3SzfP5PhFKgXFc8vKui65ZKws2mMOkTD78fCRRHEmkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD9yVN3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF8CC433C7;
	Fri, 16 Feb 2024 06:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066465;
	bh=guZaFSqSf3MqQt8V36466MzszKjuXHWltT0kqFLvhWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CD9yVN3+t6Oxc4Su6jO9CPZk5HJwbk1hnn9GS0N9rM148G0KprQN5AW+JnV49jYzM
	 Vy1se9Y35OI1KnxNf8NkYYyTMb1AP7/PAEe0d8Wt186IepDpbl2ApTLK4CXigB3mTe
	 5QJDpTfy6FvqP/w7B+wbF/I+v2b50yEclWqyQ1T2L1Dpo59qQu7k7jlI+XRU9br8X3
	 pco+MMsyC+qsoDJtNAp+Z2Ni5C/FOEqLgZZeB5JC3nuJ80Scwa7ig5Z3fGG1dOrPVb
	 LHHjT4UoQWO4CxvjoIo6pT1s22I+pGeB/OWDTbqqYM46jxc8cUxRm+LfWLj3Ycs+rG
	 d6XkQFoG5UK4A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 17/21] drm/i915: remove intel_gvt_event_info::policy
Date: Fri, 16 Feb 2024 07:53:22 +0100
Message-ID: <20240216065326.6910-18-jirislaby@kernel.org>
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

intel_gvt_event_info::policy was never used since its addition in
commit c8fe6a6811a7 (drm/i915/gvt: vGPU interrupt virtualization.).
Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/interrupt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/interrupt.h b/drivers/gpu/drm/i915/gvt/interrupt.h
index e60ad476fe60..b1fd6ed4e34a 100644
--- a/drivers/gpu/drm/i915/gvt/interrupt.h
+++ b/drivers/gpu/drm/i915/gvt/interrupt.h
@@ -177,7 +177,6 @@ enum intel_gvt_irq_type {
 /* per-event information */
 struct intel_gvt_event_info {
 	int bit;				/* map to register bit */
-	int policy;				/* forwarding policy */
 	struct intel_gvt_irq_info *info;	/* register info */
 	gvt_event_virt_handler_t v_handler;	/* for v_event */
 };
-- 
2.43.1


