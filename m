Return-Path: <linux-kernel+bounces-163629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1438B6DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4691C22880
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA6129E89;
	Tue, 30 Apr 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoJY76Qb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE42128828
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468364; cv=none; b=ScsSYdplyOtCL1sWcSTKdod0r7DG/IDFJlY85GVPbOH+mH+z38fP5HfQfve6Lx7HXC4XbuNm9lgqo2VnAhE9FwSbGZReVDGgdbcOweY1iERQ9LsmADbGNQLT6MepQ1FD6JkjjiljjzZM3MANiMlxLqEkclYRUE+V/zkviW03N4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468364; c=relaxed/simple;
	bh=SHxwssk01XHpOXYKIXAbzMd+9S78I9qD20VjCWGfqXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Si/iK5Zo3wSHQoeb7Ud2G55AVNeSfljF07tPX3nLPB/75nZADFPHqmqOw2gOXHaP9JAcM+dNtw1TjHc99opbszRh3sOOYeGCuecoWLg7CAYiA2bavSsHhDLryN9BN/Y453s8aJjxb9jJPqt4rAWT74TqyjqTdlDLY/UtufiBC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LoJY76Qb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b7a26326eso31706435e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714468361; x=1715073161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPsx5rellbUV4m6wrqLm/a5ApPnyZnXbC2P7C09mxGo=;
        b=LoJY76QbnuK2tJlBiiQGJoAgg4GyktRZhbr7PQ9F3Nr699TLd/sQmGicuu5lqHzNkD
         quPCwqhoZPFFgJbgYS+XKfukKjoNOHf62vsjUBwMe2K1CCw1rV/ZvYJjB8CrspFRNjte
         HEHa06AJH5uhNRW8c6ZzrQy3GE/vwIKSNVIbR9pQ+MJZOPc3T6ao3M8MNAgMZzGcwQjz
         Ntm8EPhnfDD4slnlq8wznLks7YTtelJ5X6qLNq2rNFUd4sC0kh+NbuEpfK3T6GS0ks4o
         8OpozPXMi5cZZ55iwnMsO62rg8AFq2gyHKgVSGM8nSknvVEAsDWzMGj2G6zQhERkCgbb
         Y8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468361; x=1715073161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPsx5rellbUV4m6wrqLm/a5ApPnyZnXbC2P7C09mxGo=;
        b=wfTKRY77eyaN7QJFgNPVhE6vn/iixM6t0qu64piBqucc1CFlIRZUHezSNTMtUZ/GwW
         m1c8LKQ/NfNjGVq2uHwIq4H919Kr1L6FPBtZFUepNcr0gBB7/L9x8Qt9nyCON3H6q9Kc
         tFoPRlbWDwHdU2eqR2Cc2oCAhoHY5w9Alm63baQGcUzH6CqVgUtJYQI+7iXCpxJEKmQA
         /ER8/sc8irMfMHV20G48Ov/1TYYx6xdkp64+FBJ9oNHN6FvtJIqRY55+ZndxzWQNspvQ
         XCCWw/pwFZZ7tEdYvADTvUly90KvHUxfzZLB0haS2AklJlnnN33Ch8ol1ppuiqUCkaIH
         /+tQ==
X-Gm-Message-State: AOJu0Yx4Xz3d/pHeUFU7t8V2ekrP09I9DdoIErnG0WMl+XOrqa2KDNXk
	LwDNzPPS6tfmL7W0lZJRerPPQ0ybPoJWEgQkwScc5VmagRePNaCb/iW0HZZr1X12azfOuila3HQ
	S
X-Google-Smtp-Source: AGHT+IFHaUGPrI8aIMPqogUlvxJBg9iWMjIH3dxYrEfPOtTbnWvrcsTN8xNDfyqkoNNbo/RJdQFzTw==
X-Received: by 2002:a05:600c:4ecb:b0:418:b9fa:43e9 with SMTP id g11-20020a05600c4ecb00b00418b9fa43e9mr11655168wmq.29.1714468360924;
        Tue, 30 Apr 2024 02:12:40 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b004182b87aaacsm44334164wmq.14.2024.04.30.02.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:12:40 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/1] slimbus: fixes for 6.9
Date: Tue, 30 Apr 2024 10:12:37 +0100
Message-Id: <20240430091238.35209-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=325; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=6rXmYmmzgEEsdmZysDowglOEMtRhazLOf6MZcX1403U=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLYGQBjP4zv6Iu9x24EsctEc5DTi605KoUEME S58qEY6XGmJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjC2BgAKCRB6of1ZxzRV N5eeB/9cy9vjClch10clICgIwwQos5K15uGB/rX05zh7wL/NxHgh1CB08uaPDUOo8jXMilNtEzg mOcgpLPXT+5YEklDYShTHWSYsfGPlXy84jDQcmWbpA9wLfxhaYJuqSTbLq/F5rLCh/D6SQHpk9m f/rvItzejqGpnihNjQUDQaaz3OCWmIijIV1kWub6IefO+zcLygy5Ikj9BdUnyrhN5kNIrUqS2bL QrlJR/ZizSvVCdUAYbq7riapIEtLw48QDd6uw1AjsCRgnATcCfnyQmQZoX9XUPJKXGNwrl1xxKI D44I/WvojPpSSu+uoYdF0MJdpyE1R52GVxSW6aY5jjy6VjEM
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here is a fix in slimbus that can go to next possible rc.

Could you please queue this one for 6.9

thanks,
Srini

Viken Dadhaniya (1):
  slimbus: qcom-ngd-ctrl: Add timeout for wait operation

 drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.1


