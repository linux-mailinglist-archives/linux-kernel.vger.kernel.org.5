Return-Path: <linux-kernel+bounces-138484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5489F1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683B7B22F50
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C515DBBA;
	Wed, 10 Apr 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgKr42tu"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04215B549
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751884; cv=none; b=RRXBnkPrrui5ka7zvc/YSb8bMHf/fXxOKjBcHmQGd7uJnlRdgpt/vLfYG3XQ2+8dFOfCvjXw3MLorX6BLmspx9B/U0FLKCtBJvKin2xUrgX/gO0p5+DuazXj/Gw9KQguPfrWA00Dv3gw47ciPDvrLVYKSHf6+XIddvlfQEg7PAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751884; c=relaxed/simple;
	bh=tqy5RaJiXteDvdC/cyKO+b2613HwrFfwHfeUjkXSy8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BrGRwm3IwDmF/Wa9ftHO7nZO7q5gXnlYIqvzCKWmoRYjnsDVcV4TsXrPLeCAu0CtASoSfBfIwC1lhwQhlgR0HIh2/1FjW/Y3zlOCWF0kc49cQ8GtbJ3pxHRKm+CiIHY03aifn6DG/DX+NYUgNTxG7Ds8K7qqnLNqM7eHjrm6JlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DgKr42tu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-434b7ab085fso24137581cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712751881; x=1713356681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfpAXz8Bcfy/TLkzFPLD2yYUR7bPCnwgt9TJrWa9s1U=;
        b=DgKr42tuIiVRjo3s/bmAVguAs4KQ8U0+lvepaCv2uiJcNXVIgBEpsbS7Y8Y9ytc7yJ
         shZi0m7M9iW/9pBYnSn6NfjjLyCd2jp9e3xttu4eoMGAnrINhIy/s0ncNDExPvyj9Zlm
         Qhq0YIcCcyslyR9ZSS2C7BTBSdin+Ql9f4exc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712751881; x=1713356681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfpAXz8Bcfy/TLkzFPLD2yYUR7bPCnwgt9TJrWa9s1U=;
        b=DuEafAJqgzqAcG6rAr9bGpCBeoHT9gg60s2j75OFnCw+T5+u0Dy7cbHAWsoDFZhcaU
         nMjn9gvU6IOVyMTOkS21vKZVa7eV+rGW5it1Hf4aZCtCWBYNLrHOfPc4PrN+zZQQw6uM
         TLqaAp9lw1d7uWgwRJ3+FSthNl95vNkV5poapveKXJoxeqo8CJfnrpr3XzRF+rwq9QpN
         rw9lUldQ/3J9l6lrYsL6MzO6UrkNEc7OXW4PPYz2/lNcXCOgtZvzCro0FKlCQGvW3X+i
         9crJU55QLtbOmMwnZp11dRh26kxYwGhPrdljkHf6WvzHEKd+gjxVGpv8y4FObqra0gIT
         sMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEly2ModdBNlhrpKUMqH19UCEmHKBJV9Kiw8qCp8r8Xk+X+FQV0oNxnxjDCuZtzzi4Nrf/Di+mtjgmnEwIjeXemtUKLNF6iU6ynn39
X-Gm-Message-State: AOJu0Yw8usX+0xr2263IE2hJQK+sB3KfwRHarM22j95zsrRWHYHK0oVK
	2gIVGLLPslNW66K1kFrYC8G1VggD1wxBOpBgYHdGCEmxCJ8J8g4DYc7Y0YzjDw==
X-Google-Smtp-Source: AGHT+IHniFHijne50ct4dDiCfXqrYaE0q7Ul3bSD5D/xopuvSqykSDUiWPdCd6gCi40hRkdVKi8rNg==
X-Received: by 2002:a05:622a:19a1:b0:434:6fee:5983 with SMTP id u33-20020a05622a19a100b004346fee5983mr8687083qtc.7.1712751881654;
        Wed, 10 Apr 2024 05:24:41 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id jy14-20020a05622a818e00b00434ce53c664sm1921579qtb.80.2024.04.10.05.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:24:41 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 10 Apr 2024 12:24:39 +0000
Subject: [PATCH 3/3] media: videodev2: Fix v4l2_ext-control packing.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-pack-v1-3-70f287dd8a66@chromium.org>
References: <20240410-pack-v1-0-70f287dd8a66@chromium.org>
In-Reply-To: <20240410-pack-v1-0-70f287dd8a66@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The structure is packed, which requires that all its fields need to be
also packed.

/include/uapi/linux/videodev2.h:1810:2: warning: field  within 'struct v4l2_ext_control' is less aligned than 'union v4l2_ext_control::(anonymous at ./include/uapi/linux/videodev2.h:1810:2)' and is usually due to 'struct v4l2_ext_control' being packed, which can lead to unaligned accesses [-Wunaligned-access]

Explicitly set the inner union as packed.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/uapi/linux/videodev2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 2663213b76a49..bf12860d570af 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -1842,7 +1842,7 @@ struct v4l2_ext_control {
 		struct v4l2_ctrl_hdr10_cll_info __user *p_hdr10_cll_info;
 		struct v4l2_ctrl_hdr10_mastering_display __user *p_hdr10_mastering_display;
 		void __user *ptr;
-	};
+	} __attribute__ ((packed));
 } __attribute__ ((packed));
 
 struct v4l2_ext_controls {

-- 
2.44.0.478.gd926399ef9-goog


