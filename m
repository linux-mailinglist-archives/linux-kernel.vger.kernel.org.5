Return-Path: <linux-kernel+bounces-105848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6011687E56B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FD0B213C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E728E0B;
	Mon, 18 Mar 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DLf/Pa1n"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F628DB3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753048; cv=none; b=Df7Bs88urhF84lRXyzzw2wywNUzozcM8GrhYorp4+jUXWSiXDpFsEv6kJmvPpDx3UZZ0z7e1W4kwe50z40rWVl3U78p6CyAzxawIxFnCmlPhLYgtvxYTa+GaU6nll04u7LkAJwSUCeP4HvKfBgPVOuE0bWJL8hNfL4/Q7HmTfJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753048; c=relaxed/simple;
	bh=GMZ677o8MXMXiSv4h8mvXL5gZjYj5c1FwMqptPvTaEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4MIppVs3tx8ENsR8mTow7COE9AwrK5gNzSROOXjLMwIZlKVMO76obhnfRTze2BPZj7z6caF4A1KcLOlnD6ia9uN4LeKrhU0zICSUuPa4s5Aisg/5GzAHlxGb5IBEHNwobOFMdUdyUeubxwNlrmVz853QCDdrDuXwfnGCfZfhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DLf/Pa1n; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3662feb90a8so30877375ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710753045; x=1711357845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgQV9frW8RnICjhCsBOh9fiyAly3vsXKMsPIiymkwaQ=;
        b=DLf/Pa1nakucNoxiQta7N9uay6nDaNJ/R8cLZRFfVe5emAfTQRImEw+mtZZgHv/zaX
         K6B9DLGIaxsJmsGiOU3U0BhNQ2rsDHUticwPz5YK70HRas7J1yOOBJefcjzIh8wu7Oo0
         /9kDuBKLpkmj0cOdwP1EfTUfVfDmtONxCO8zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753045; x=1711357845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgQV9frW8RnICjhCsBOh9fiyAly3vsXKMsPIiymkwaQ=;
        b=rcHhvsO3GaOPe2ILjHJ9Mo4Enl9jcbu96RUrPWonCIx+HV0bhXssbA/dp6AJDr7nn1
         k8eOifJbsyfkxC/UqM2zAPvZyYGHkX2SV5xQlPxGtRO/z5Dq/Dl1aptph0/8+bJK11Ti
         T9FQ0Hx575FjgGfsR+2HLN9r5CVllBCoSQq0bxYr+NoeqdY+LwfIdMcITrl60jqjFRMY
         1fX565mRM0br8APwzIEzwqol1TFy+BON4vBDK9aJ9aLCUOKlqXlvAP1j4/25DWS4W/C5
         G0cGndNRxxomrDKmcnByAPUvr2Jae3qnmxVyng/mxaxodcqWUTc5A8y5mQ9h3fAug2Pm
         uPEg==
X-Forwarded-Encrypted: i=1; AJvYcCVEFLItka22SQ2sYdaP1A9B38Two0vwlLAOXpgg00U56o0LyTH0Ty0rfNy3/IdWHT27rqy51ACGM3+T9iuN6f1XybvfFLxi012r0s5B
X-Gm-Message-State: AOJu0YzRAi36VswmXvZsS3it5YXtpwv8mKLv/ZbSdErM1nFopJDY4//F
	pQSw/KsoTf7awktIy/ihlYyjWUwBpn5MaO3ovQb21uG5Bd625ERXJWCSHD6bZg==
X-Google-Smtp-Source: AGHT+IG0cB7zGyiKSLMYQArEsPlbj+Pzce168Z3n8zBAgOe+pLyNBhxXOnjnY5ntbeL3bLG/AJUWYQ==
X-Received: by 2002:a92:6c03:0:b0:366:c678:599 with SMTP id h3-20020a926c03000000b00366c6780599mr1857042ilc.13.1710753045597;
        Mon, 18 Mar 2024 02:10:45 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:171e:5cf4:dcfa:390f])
        by smtp.gmail.com with UTF8SMTPSA id f35-20020a635563000000b005dc884e9f5bsm6638068pgm.38.2024.03.18.02.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:10:45 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH 0/2] Improvements to virtio_balloon pm
Date: Mon, 18 Mar 2024 18:10:32 +0900
Message-ID: <20240318091034.535573-1-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

The virtio_balloon driver uses wakeup sources to allow the guest to
enter system power management sleep states (e.g. s2idle) without running
the risk of becoming unresponsive to cooperative memory management
requests from the host. This series fixes an issue where wakeup sources
for inflate/deflate were improperly shared between drivers. It also
closes a race where stats requests that come in immediately before a
sleep state transition could fail to be handled in a timely manner.

David Stevens (2):
  virtio_balloon: Give the balloon its own wakeup source
  virtio_balloon: Treat stats requests as wakeup events

 drivers/virtio/virtio_balloon.c | 76 ++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 29 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.291.gc1ea87d7ee-goog


