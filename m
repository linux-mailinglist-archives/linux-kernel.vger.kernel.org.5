Return-Path: <linux-kernel+bounces-127196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771218947E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74DB1C20EB9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6257867;
	Mon,  1 Apr 2024 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JrpymfoI"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4F5D46C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015136; cv=none; b=YIrjbXQRcjFel44OwRmSvbAXcp84by653Cxl3jTIX9Xf8fcv1Zwr49HQRYnezsVfTZZuTBu21OUojGMURwKdHAOkXJhH0/uuxjC1ZAvtEbkibjW+L01fKt6dA66GcVhjh7yxFlC5NYozr0O6sx9FxE2AcVv5Ze6RFZ5EcqTPyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015136; c=relaxed/simple;
	bh=q5uE5iIpFjbvKfuGGktEA4wK8XXiUacQzrox64rZSzo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HqKAIhvHjdTtCqoFHDNEeRCSqRWWoZmoYuqlt3cwSUBBDLNd1sNBAD1Brzc+U9aFpx8xEGYqVls/meQFU/nqeRbuyconW7CUfOVy5/5+2DGuaT/hIQzqWd2IhzSPOJFHxWV+O55XWtz1bRkaBDx2dhoqhJx68cJRTUeeQG8kYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JrpymfoI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e20578b997so34176965ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015134; x=1712619934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0lch/oP7Pyow2mOgtViPyCMQBf/BJiF1sWKaTfWLjhE=;
        b=JrpymfoIeC7PsFSRE8cTyJXIV+gXNy1fhszAW0VGEKgLBCky8ImPpBXTKAnWrEIo35
         AC5gL0o9H5ubxA0mlDyfihXRgpW8L6mPMNiIjksMZYcwi/CXNXx6aAy45iThexRxdjuW
         NotCtmj9K1NTZPi7hgIuB+p33ShnzkOQHcEaC032z/qcUmLWRGsMkwl3SPZLxrTX2PzM
         J/IU+CIdy34NegvlIpBZAX8T8+1kLsBrgTAQNKrfZRYPgb+E3mr51xUBjlY+LSgg59S8
         klUUbz7FeJTREAyGAJ3lE6pG8dvUpJVZOSPFVr3ZzqfIGYQuAGsj//UXS26cbF5hgXVq
         oIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015134; x=1712619934;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lch/oP7Pyow2mOgtViPyCMQBf/BJiF1sWKaTfWLjhE=;
        b=QmytqIfmY16ckKwu4HOCVi36oF6vzs41fyIJckZxsXg2RHhroz7vsYS4F+3qOcHKSQ
         tZ1lgvMKoFFwyZ7nADuADQMnRtfKm9/IpMH6qkSCRg+RdtR20Hhvdngh91bCRTRiToaP
         EHG9jm0QCkIeWu61c7Q3CnF6eubbzHKPtr7L2k7P68k0OvanPK1HhSKrHiTFCzXI9XU+
         niOSvbY39iWAZREgTJ9XjqQLgjhs6x8PTk5YXkSbG4E9kS9Vt7Y8lNGHpwK6V5dF0WE3
         dVnJNRPwvSK+BiPLqIMIS3NqiCPwV3zFXobSIAPlK/eXDgfE64xTJ8VdYtwy44ogHT7w
         LCpA==
X-Forwarded-Encrypted: i=1; AJvYcCW1IsO4okbI9A90PkjoNfLhNkUWgy7BAe3tq2LAmc2eJ2CFipbPFsrVBd9Bs7A7lLPaLZblvJ8xDS7mOQqwNMN7B2O6eadVdYMAor1l
X-Gm-Message-State: AOJu0YyLLP4hO3CrQzMocgbN5EWTKJAUY9jliWOmww+Q4jb2g5B4iQqi
	PhzUcjbuAuJEo1L95SCXhhY8YxxcLQhfLt8NhGJs7j/kQ1EXjK6/I+9sTYsQpavGvDWrfbzinVa
	WoJfW1ejb7KKeii8Mid3kSw==
X-Google-Smtp-Source: AGHT+IGKCrhOkLN2VTUrJY6La4PQSYEAiXiUKfPlWl7BZjDzITPI7XOz0p+SS0KSUbrF9v0Y8Bb6t1E0+u9AuN7qDA==
X-Received: from hramamurthy-gve.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:141e])
 (user=hramamurthy job=sendgmr) by 2002:a17:903:2288:b0:1e2:45bf:abae with
 SMTP id b8-20020a170903228800b001e245bfabaemr111761plh.6.1712015134632; Mon,
 01 Apr 2024 16:45:34 -0700 (PDT)
Date: Mon,  1 Apr 2024 23:45:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234530.3101900-1-hramamurthy@google.com>
Subject: [PATCH net-next 0/5] gve: enable ring size changes
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

This series enables support to change ring size via ethtool
in gve.

The first three patches deal with some clean up, setting
default values for the ring sizes and related fields. The
last two patches enable ring size changes.

Harshitha Ramamurthy (5):
  gve: simplify setting decriptor count defaults
  gve: make the completion and buffer ring size equal for DQO
  gve: set page count for RX QPL for GQI and DQO queue formats
  gve: add support to read ring size ranges from the device
  gve: add support to change ring size via ethtool

 drivers/net/ethernet/google/gve/gve.h         |  35 +++--
 drivers/net/ethernet/google/gve/gve_adminq.c  | 146 ++++++++++--------
 drivers/net/ethernet/google/gve/gve_adminq.h  |  48 +++---
 drivers/net/ethernet/google/gve/gve_ethtool.c |  85 +++++++++-
 drivers/net/ethernet/google/gve/gve_main.c    |  30 ++--
 drivers/net/ethernet/google/gve/gve_rx.c      |   2 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |   7 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |   4 +-
 8 files changed, 235 insertions(+), 122 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


