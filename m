Return-Path: <linux-kernel+bounces-42004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7A83FA93
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C88E283F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8019645959;
	Sun, 28 Jan 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8L+KE9R"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837452F91;
	Sun, 28 Jan 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706482387; cv=none; b=kBXzHFxTeNv9EdchmN2END//1RRLwMiYpsumNpzKKixOSoIFQcA+dbGxYQ1mZJ85zvUevRcXTvMX29Bl0jJFW/5jDgl2MqeBWTzvaIvgMqbJDsU03wW8oin6nRDb1zJT4eT7lfqV09I3uTnnBe4elAcgfD/Pj0M0nA9lXjxAwXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706482387; c=relaxed/simple;
	bh=w3X5ynGmtXaOeXoU0AhqBVrv6QF8ibOUb17yYFx8ZB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eiIqNkNK+8EHSQcAa4IPbPo4KqUCYQoc7PiY28tIhLAdq14tQxwR/B2TdY9qGYw9KrC7tqHTsRnaVEq4bRi98dM+FiXeWTwDac4BaPHDWf/dkxyHscVTEbAOej/SunwmuhNVTsFBlr2Lwiubynq8+SLxOnrUsTFLRlXrVKALSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8L+KE9R; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783d84ecb13so241796785a.0;
        Sun, 28 Jan 2024 14:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706482385; x=1707087185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SHEJz7lhB+IAerhrVnhDVBAqG+Jxmcd4Fdf1GvCvEOA=;
        b=d8L+KE9RxpqJb0fL8dxhLVhzrhNyJGMHBhmPu4ccnHFaEIuKoJ0ke3XN74ZQ+j2OYZ
         uPMgfT50aGqo0iYQiuRKnNWGw8Clw+ehaYraUrHXe7Baajq/qKV2Xsu+Fc4Df9ROe4Sf
         3YSXfX6/xnXYVKopQK7L5tTfJEryiBD0FyfeCvOE9GEfS2CIltQLiy7AkHqfDufX1dqV
         OtlKIV54m4/Mmria88gJvSKlzIlw7RMggZmq5F82y/0Y2pJxYC7m9lIei3izyInW1SHS
         /fHJIlRhJa+GPkXNNfsL098xIRryfXLJh+RLy38toSsb0QzkEgWKt9p5isjfVeLAbpe+
         1t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706482385; x=1707087185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHEJz7lhB+IAerhrVnhDVBAqG+Jxmcd4Fdf1GvCvEOA=;
        b=BG3U//VQb/vY8snwOwHK6s8fMp9orev8BOSTGes979jTf33ijfxKiIIC5c6k3fmZYt
         VivpkgGarXzz3RRFX5OUrrQCQ1lRB0buPc6NZSqSDiO4Eh3WBPfawcOUvMnqJ5wMg+7j
         0q+HlYki+QN21/ZWNmUld5JfFC5nAn+ci8IIwi3O4/3jx54YenqFgeeUIyeFisuuei/1
         WJ52Dp+OvDEB4TNmW/WrvYdGi3zYmOzC8mhYycmwEuj+1oEkFw/RQhms0/4LE5JNz0uu
         usiCkhxJ7cLlfQs1qCfJ7gI7KnqUp3De/nWARLBr0beGvMyfuwqEW7xbKkan5Jm/Zjgi
         LAcA==
X-Gm-Message-State: AOJu0YxhGHtEzAtqIsZeGK0qAr3Lss2wJKJBj+s6n0bUKQFHjKbXD/hL
	XqP4HPx4NvgGYTR6G2l38MusHvG8779GejujxMhcw2p+gdmWGgdB
X-Google-Smtp-Source: AGHT+IEdTY/eWJZvlD4EQYw6AswvY87543msgJIyxR6XRvQcfJ+yyYdFG/GfF+lCqFI7CXkglqnhMQ==
X-Received: by 2002:a05:620a:4013:b0:783:fe00:950e with SMTP id h19-20020a05620a401300b00783fe00950emr1254567qko.148.1706482385079;
        Sun, 28 Jan 2024 14:53:05 -0800 (PST)
Received: from kohshi54-ThinkCentre-M715q.. ([2404:7a80:c880:6500:7f79:d78c:e8ac:f086])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709027c8200b001d7726c4a40sm4069560pll.277.2024.01.28.14.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:53:04 -0800 (PST)
From: Kohshi Yamaguchi <kohshi54.yam@gmail.com>
To: sakari.ailus@linux.intel.com,
	bingbu.cao@intel.com,
	tian.shu.qiu@intel.com
Cc: Kohshi Yamaguchi <kohshi54.yam@gmail.com>,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] doc: ipu3: Fix UAPI header doc warnings
Date: Mon, 29 Jan 2024 07:52:58 +0900
Message-Id: <20240128225258.50375-1-kohshi54.yam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ipu3_uapi_acc_param struct in the IPU3 UAPI header mentioned
reserved1 and reserved2 fields, which are absent in the actual
structure definition. This mismatch led to Sphinx build warnings
due to inconsistencies between the documentation and the code.

This patch removes these non-existent reserved field references
from the documentation, resolving the Sphinx build warnings and
ensuring the UAPI header is accurately documented.

Signed-off-by: Kohshi Yamaguchi <kohshi54.yam@gmail.com>
---
 drivers/staging/media/ipu3/include/uapi/intel-ipu3.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
index caa358e0bae4..926fcf84e33c 100644
--- a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
+++ b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
@@ -2485,11 +2485,9 @@ struct ipu3_uapi_anr_config {
  *		&ipu3_uapi_yuvp1_y_ee_nr_config
  * @yds:	y down scaler config. See &ipu3_uapi_yuvp1_yds_config
  * @chnr:	chroma noise reduction config. See &ipu3_uapi_yuvp1_chnr_config
- * @reserved1: reserved
  * @yds2:	y channel down scaler config. See &ipu3_uapi_yuvp1_yds_config
  * @tcc:	total color correction config as defined in struct
  *		&ipu3_uapi_yuvp2_tcc_static_config
- * @reserved2: reserved
  * @anr:	advanced noise reduction config.See &ipu3_uapi_anr_config
  * @awb_fr:	AWB filter response config. See ipu3_uapi_awb_fr_config
  * @ae:	auto exposure config  As specified by &ipu3_uapi_ae_config
-- 
2.34.1


