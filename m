Return-Path: <linux-kernel+bounces-138509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03C589F26B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7DA286AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF4615ECC5;
	Wed, 10 Apr 2024 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ti0IwACB"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6ED15E1E3;
	Wed, 10 Apr 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752620; cv=none; b=sw7F2v4e/D6A+O1YsgyuzNQzpDlqIxtkIJzyjlZ1KU/YvjUPV3S1rFhDQuen3CIgPgq6ZB6YR+mjmKDH5/RAQEHCKWAdwmRUFJMghMevQcn4Pl1fDXsFB4Zaj/7pnWyJyPabCt9WejCXyv3b37LBZ9BxUIJ8M5S+5qDhtO6NLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752620; c=relaxed/simple;
	bh=QbS01gh08Z29YLX90ucmDSlHlDaT/1Vd3a+BixCTC3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PGvO53/bRrgfJU9o5Sioxhg2pSHDkdea+kSUA6TVR970HozQqMMaYJqvN6u7z2ji+vrRBz3bIEKdMhLPhrKeJtVFYj1lMPtAjk5XMmnnpAZTG0FjTAlycD9aBYGXgYqOj8tSoMi/DB0tfb2pm5ky6AV+fI/SRtcvnm5Zenaa46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ti0IwACB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 31DCEFA8;
	Wed, 10 Apr 2024 14:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712752570;
	bh=QbS01gh08Z29YLX90ucmDSlHlDaT/1Vd3a+BixCTC3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ti0IwACB4yMM+jIbzp9ex2FSa7cdhllxoWwgGFmC4ic8hxtVJxrNHYalOzoXOdsNz
	 xjYKekmDSEsIX4xD7SIJgQ67UxgUUtpCUNOyNeGPJizfzf+jqZh3qTOlV8vtEQ9lR+
	 N0PA9KOMmhzNFKzl3u2ZotqOfLpFXxkiVDG9WpNU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 10 Apr 2024 15:35:51 +0300
Subject: [PATCH v3 4/9] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-enable-streams-impro-v3-4-e5e7a5da7420@ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=QbS01gh08Z29YLX90ucmDSlHlDaT/1Vd3a+BixCTC3g=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmFoffBg3+O+EyAwS4Y/OqJrjkc58dNzc4GB72N
 eic9jsvg0iJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZhaH3wAKCRD6PaqMvJYe
 9WwWD/9al7iNCgWc4n800zPVJjUQm7LeiH0WkcsHRhAiFunjZTeP2QHQaTwof0zzRxskrIyrBv8
 2udRWffFp13TQGWm5UGq5u5A+Q2P5mmmqfKkOZlNrJ4mo+uH2wlikb42P1Wrctxev4d9k6FviAP
 9yNjLeYKYfpwB/a2oWjOPGJCpfiyKKtjXvQKGN+VGduT0phj+YkQ2BjHjK3IOMC+2BtKGh2kEJU
 1qjoITgmYN9vST7+tKTQKaY+Qf2IeWtUBH3aIhVjsjr0VQ8HW5/jApzOvlfxSUnY76MlGJUWvph
 J9aprsIaYw2ovYhnmPCAmS5G74N4x/z8LyKBHik4JQqKCopIOdtFo8m6g3uaK8poMCHWCKABfAb
 SYGR/sWXQTje0E9VjK8+ZgqYA/24Dvbzf/b4mwcbH/i6OhGhXTEPuKy929er2Jv4yjkXHj/1BZ9
 T84/+sFPhrIqyppqGRdA+S7BgofozO6WWhhMhog4Lcp041b7RQQq80p000XRkVnZ3NJMAehp9xT
 TAdn4fkVN+5xqa0Y2Ts//dN5vS1DZ+3EBUl9QqH88jgJlhkoOtE2vNudLuwEtysf30XKOGGVycu
 9CxL8c4xXdQz2w2KRSgszV0fdqqZ48J6p8bFrBEzyZK1Zio1AqvEWjFlazs1N/EIfjonRp6ZQb8
 aW/wxb3K3nEcgKA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

call_s_stream() uses sd->enabled_streams to track whether streaming has
already been enabled. However,
v4l2_subdev_enable/disable_streams_fallback(), which was the original
user of this field, already uses it, and
v4l2_subdev_enable/disable_streams_fallback() will call call_s_stream().

This leads to a conflict as both functions set the field. Afaics, both
functions set the field to the same value, so it won't cause a runtime
bug, but it's still wrong and if we, e.g., change how
v4l2_subdev_enable/disable_streams_fallback() operates we might easily
cause bugs.

Fix this by adding a new field, 'streaming_enabled', for
call_s_stream().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
 include/media/v4l2-subdev.h           | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 606a909cd778..6cd353d83dfc 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -421,12 +421,8 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	 * The .s_stream() operation must never be called to start or stop an
 	 * already started or stopped subdev. Catch offenders but don't return
 	 * an error yet to avoid regressions.
-	 *
-	 * As .s_stream() is mutually exclusive with the .enable_streams() and
-	 * .disable_streams() operation, we can use the enabled_streams field
-	 * to store the subdev streaming state.
 	 */
-	if (WARN_ON(!!sd->enabled_streams == !!enable))
+	if (WARN_ON(sd->streaming_enabled == !!enable))
 		return 0;
 
 	ret = sd->ops->video->s_stream(sd, enable);
@@ -437,7 +433,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (!ret) {
-		sd->enabled_streams = enable ? BIT(0) : 0;
+		sd->streaming_enabled = enable;
 
 		if (enable)
 			v4l2_subdev_enable_privacy_led(sd);
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index a9e6b8146279..f55d03e0acc1 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1043,6 +1043,8 @@ struct v4l2_subdev_platform_data {
  *		     v4l2_subdev_enable_streams() and
  *		     v4l2_subdev_disable_streams() helper functions for fallback
  *		     cases.
+ * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
+ *                     This is only for call_s_stream() internal use.
  *
  * Each instance of a subdev driver should create this struct, either
  * stand-alone or embedded in a larger struct.
@@ -1091,6 +1093,7 @@ struct v4l2_subdev {
 	 */
 	struct v4l2_subdev_state *active_state;
 	u64 enabled_streams;
+	bool streaming_enabled;
 };
 
 

-- 
2.34.1


