Return-Path: <linux-kernel+bounces-77142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C727A86019C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045B51C249A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7091D13BAD2;
	Thu, 22 Feb 2024 18:29:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A69137923;
	Thu, 22 Feb 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626548; cv=none; b=fI7/oXZJsE/3h0hGBRnNX/dUu0kD4t2j5bcz/TJ9VLsPgbr1bl8+fu+7igKcMwQ9vcVyxjrZ4nEb7b3fXzmN2hOew5LgmOKbPwcjhz47YmesdDqkWCGZiOorCo4lsSwHvxfN1coTeqpq3l/BH8w/6/zNIityso+/9GHvtmFqDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626548; c=relaxed/simple;
	bh=pBekZ+WsAj+6n/8strTHjSgCBwuZw+ZZ7K+e+nZzKYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=F8tI2NmIuiDAoXlden6hm+wB5PkTGq7UiZ79tObuFZ8raj0vUcOvcFgLmHXMBIkhRssFZclIz+unGCHowEKQVEaKVfh+wzDOjhqwsv6WGNHpRL011IPevvg34x1y5fyHtn+RXiTNVUDMOyo9IXHn4+puA3nuGeN1jc0o2IYeit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E11C433F1;
	Thu, 22 Feb 2024 18:29:06 +0000 (UTC)
Date: Thu, 22 Feb 2024 13:30:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, "Ville =?UTF-8?B?U3lyasOkbMOk?="
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, David
 Airlie <airlied@gmail.com>
Subject: [PATCH] drm/i915: Add missing ; to __assign_str() macros in
 tracepoint code
Message-ID: <20240222133057.2af72a19@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

I'm working on improving the __assign_str() and __string() macros to be
more efficient, and removed some unneeded semicolons. This triggered a bug
in the build as some of the __assign_str() macros in intel_display_trace
was missing a terminating semicolon.

Fixes: 2ceea5d88048b ("drm/i915: Print plane name in fbc tracepoints")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/gpu/drm/i915/display/intel_display_trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_trace.h b/drivers/gpu/drm/i915/display/intel_display_trace.h
index 99bdb833591c..7862e7cefe02 100644
--- a/drivers/gpu/drm/i915/display/intel_display_trace.h
+++ b/drivers/gpu/drm/i915/display/intel_display_trace.h
@@ -411,7 +411,7 @@ TRACE_EVENT(intel_fbc_activate,
 			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
 									 plane->pipe);
 			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name)
+			   __assign_str(name, plane->base.name);
 			   __entry->pipe = crtc->pipe;
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
@@ -438,7 +438,7 @@ TRACE_EVENT(intel_fbc_deactivate,
 			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
 									 plane->pipe);
 			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name)
+			   __assign_str(name, plane->base.name);
 			   __entry->pipe = crtc->pipe;
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
@@ -465,7 +465,7 @@ TRACE_EVENT(intel_fbc_nuke,
 			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
 									 plane->pipe);
 			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name)
+			   __assign_str(name, plane->base.name);
 			   __entry->pipe = crtc->pipe;
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
-- 
2.43.0


