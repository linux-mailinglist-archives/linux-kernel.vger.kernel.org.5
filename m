Return-Path: <linux-kernel+bounces-106834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31AA87F446
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323821F23565
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75385FB81;
	Mon, 18 Mar 2024 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kuFAKYCf"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33695F86F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806134; cv=none; b=QIs7dI5zn+R00wPkWdy1nzKnoQ6eV+OzY0nG+ddRPrOUvDWb+ZlBCLOP8DduMWxmHvB/J4hKAuXEh7Zcpms94aLcvxo+gE0ywlPYSV+hltJRnt+ZrjnasY+EHRNCW1m2DJVWXA6NOiHkGdVPvPRTDM+cqmJXKRlUS2IOgFqHF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806134; c=relaxed/simple;
	bh=cNoHLLQvJGEdRJ/fXGpe0t7q5Pac3xLinizI/oUYWCI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GhA8FGDn7zt1itNiWgBhadXvdyr6Uxh5xC/srFT8NRzXRn9fqdHBHoow4nNMxES+cZwtWbS/tBo6cVahjBsM73ikLqGxFf0WRe2HE/gKutJMIaFo0uoQoP2zCo0eDMO2ErseYWGhFBjrq21seR06/AXMSkudmjy1wlwO8npid7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kuFAKYCf; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78822e21a9dso221251385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710806131; x=1711410931; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HH164PWpqmWsxknEeMAJyub736cK5Z2OEMFfDMtcc0Y=;
        b=kuFAKYCfjwmGmqGlpzDFDcey0dsNPxschPwQgzON18poiwYsMCIYqT32rCK1BTBgUT
         bOsoGyFXnTK2dLxPUWtAo8ampMvFQLIQSMSDexGPdarQi1LUyFXZdsY+5zOtAJYq0GQy
         K4a8raqnQeW5DaF7UPY2uVHyAQzGC+x63wLy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710806131; x=1711410931;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HH164PWpqmWsxknEeMAJyub736cK5Z2OEMFfDMtcc0Y=;
        b=NSEkfmf01HUJOAaKJWHsmKxwUYyYgYhUGkQSOA50VCbrsTGIICzgTCzW0Pkmkmb60o
         hzmvjLlMmx4a2QFvTQot5/LiXHsWMP/Pj2eS5PuTSaDPGlCWgMkQJv+XV2QGaMZYLO9L
         xj8SRw6aOeZcPsl9/JRz/CT+0n5d2RhY/JtIq1n8hWDdNMM9w1v2eggZI17fEy68tI9m
         PYi0HqqnJtwRx9vQ1ZqJ681wG5mp65m0sZ2ZxGkGagkEsao5kgi74Tbe2o62STkKUhoC
         brqylhUQB1E76AlzID5S3aCBCBiqE/yTZVLcxvLJl9CWnXux9o2uTZpW7WaCgOP7po1a
         1Zng==
X-Forwarded-Encrypted: i=1; AJvYcCX6rB/AUxssAUb16vwvWtc/QIdn1q5apewdhTSERJb8Mf7yqaP4SXj5Qnc/olcAhI2Te+WEfmOB2AKjO7/73HSqyD2QJ3ENuQmQKd2U
X-Gm-Message-State: AOJu0YwFXgqynhj0JeM+Qvged6JjDiwh0FxUnZje7+VcdXjKHROnM1wG
	W/Qz6zVQtTfCleyKrw7u+bYRQ5JIH7OeZipmkUqY4OFvR/+vwPcJumXzpCLl2VOJYxLoFtt2qqk
	=
X-Google-Smtp-Source: AGHT+IHxInxRNV6IqZh9cCvDPHVqyxnR81Scsj5aqtqnwOcJMSH57AaJel1+HzXIfNAQdV5Ou8PR9w==
X-Received: by 2002:a05:620a:2e9:b0:788:2fc4:c3ff with SMTP id a9-20020a05620a02e900b007882fc4c3ffmr14008745qko.31.1710806130967;
        Mon, 18 Mar 2024 16:55:30 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id h15-20020ae9ec0f000000b00787930320b6sm4991690qkg.70.2024.03.18.16.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:55:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/5] media: uvc: Probe PLF limits at start-up
Date: Mon, 18 Mar 2024 23:55:22 +0000
Message-Id: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGrU+GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Nj3aTMnBygGl3TJKNEE9O0RAuzNBMloOqCotS0zAqwSdGxtbUAXaF
 yhlkAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

The UVC standard descries the values for the PLF control for its
versions 1.1 and and 1.5, but it does not describe which values MUST be
implemented.

So far, we have been adding "device quirks" to provide proper limits for
the control, but this is failing to scale.

Add a function that during probe-time checks the capability of the
control.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (5):
      media: uvcvideo: Allow custom control mapping
      media: uvcvideo: Refactor Power Line Frequency limit selection
      media: uvcvideo: Probe the PLF characteristics
      media: uvcvideo: Cleanup version-specific mapping
      media: uvcvideo: Remove PLF device quirking

 drivers/media/usb/uvc/uvc_ctrl.c   | 173 ++++++++++++++++++++++++-------------
 drivers/media/usb/uvc/uvc_driver.c | 122 --------------------------
 drivers/media/usb/uvc/uvcvideo.h   |  61 ++++++-------
 3 files changed, 143 insertions(+), 213 deletions(-)
---
base-commit: b14257abe7057def6127f6fb2f14f9adc8acabdb
change-id: 20240313-billion-5b2a45fa86f4

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


