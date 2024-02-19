Return-Path: <linux-kernel+bounces-70757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7EB859BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F621C20DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1BF200C3;
	Mon, 19 Feb 2024 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsAtvYQL"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832211CD0F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708323062; cv=none; b=ZKD+tFVoJ3la2JSyM83wblkJgedSrX4cDKkPRCtYW6aQQoPBTQN7KIWcYDUrH3MkeEqanpg1oXw+3lZOol9P9a+aEEg3kixT/7N2cL2y6h9h2ENLdAsIls/6dSOpz7eihKPtQO//VA8k26YjeAoid25vgJxAa6iqoQ2MTNCL/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708323062; c=relaxed/simple;
	bh=jKHsvnkpUXR50TFr/Z3xsxv3/NQO7e19eRb0+AeBW30=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bl6cqhFfOKN6r1F0NwwJb0pJZxStzk431PNA5PpYogWMNHWNUu34ExT0vLkevTKZ8SdfphUUb3uw/fVrH25WmelWINV5eMW5nSsFxsPaUZeyOa030ZsiyPZPUZLOIePdBFDgedSS2WJSWsyJNfegcef3Qj5CfRk0SS0kC0NQE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pumahsu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsAtvYQL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pumahsu.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f38d676cecso61733797b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708323059; x=1708927859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hHHSh71VeE7R522+653gkjpIftZNNCvUqKd1gyCW278=;
        b=lsAtvYQLzBprysin85a+8rdSd0P4CrzOjKzmnpJadR/2rNyrm0GSl+1msRvDbTEb97
         orCoYL/2AhABQWPtbeFaTdeWs22wKxJqPviFItRSJMLVHB2VhCYVhyC850w2wgKzyu8S
         poYHFzXixpJyC8L1P7NYyJPMOwAaBWxgUm+cRa66bmcQFCJhphTHOkZr2yn9C5c8ODYP
         iDse4ylOtPhan6TXzRoahd4AtLVBygPWI/bfLl1HuX8Coaj+DkmyGm8EjK4fyKu2tUMI
         9RMkadd0E928dhQmtZ0s7Zi8AJ9IngnZ1OBBtESHSE3aAlI79B0shh4+AqgvutTocIog
         u8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708323059; x=1708927859;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHHSh71VeE7R522+653gkjpIftZNNCvUqKd1gyCW278=;
        b=eGcDFqG0gdG+SvkmEDsuc+ydlLVwZ8OILdgadkC1/aAm65xnGb52Trv6o5GB0by/MI
         KEwZ7dJuTVt1DIOOSpG0h2X9Q2LQHvt9NPjVlZZtJCNoPsvqGdhRRdLCXtFE6FqMpQGC
         Qo3K2iDH4w0Yli7rVsR1DkhncfZyxWUvKFX1x33reS0T0S2ojiNslR61gZ3fCROXqVlv
         gLR5iyEq/af1XCDecYQxngEzttiiHohxQMCVGucAFwdNhCpHgjhQ7Y6ZhWE97wNVvvhf
         i9QdxStO4LdWBXSpQmX2lMmgnlPznfQeBmj5b1+A4ZmJjrD8C0pQpfqZNNhvKZS5Q0Ka
         We+g==
X-Forwarded-Encrypted: i=1; AJvYcCUmCls6OtYDcnahI4dOji9FW5KJmmc3ZFH9e5Iqpwi99od23jY7yXv5tjYtLjXePQI86plJdEqWZ8MU3fBySJ04lQ214yAv7WE5S6as
X-Gm-Message-State: AOJu0YxdTziloGvporo0izGJo4gT9D5pZJI9nE7UAFVcMSbwmWrVryCo
	lFbMHyBE/iQsk0s2Hh+AT6taFZi/M6JvtN1MQ1v3W+jKX+5ptuzctl57ShUfMM0k2Mn9VB3mETW
	I5SjWSg==
X-Google-Smtp-Source: AGHT+IF4FAq8CQ+60Ppo/C7DeJ6W8sdQY3v/8/5n+ADTzFoAlRf6z1Kg7N2L5Y+XKqjxUxsAWchRREtwCljZ
X-Received: from pumahsu-p620linsp01.ntc.corp.google.com ([2401:fa00:fc:202:c8b2:b71:a506:971a])
 (user=pumahsu job=sendgmr) by 2002:a25:eb07:0:b0:dc6:b7c2:176e with SMTP id
 d7-20020a25eb07000000b00dc6b7c2176emr2679115ybs.4.1708323059705; Sun, 18 Feb
 2024 22:10:59 -0800 (PST)
Date: Mon, 19 Feb 2024 14:10:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219061008.1761102-1-pumahsu@google.com>
Subject: [PATCH 0/3] usb: xhci: Add support for Google XHCI controller
From: Puma Hsu <pumahsu@google.com>
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	Thinh.Nguyen@synopsys.com
Cc: badhri@google.com, royluo@google.com, howardyen@google.com, 
	albertccwang@google.com, raychi@google.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"

In our SoC platform, we support allocating dedicated memory spaces
other than system memory for XHCI, which also requires IOMMU mapping.
The rest of driver probing and executing will use the generic
xhci-plat driver, so we introduce a Google XHCI glue driver.

Besides, we support USB dual roles and switch roles by generic dwc3
driver, but the dwc3 driver always probes xhci-plat driver by hardcode.
We introduce an alternative for probing a XHCI glue driver.

Puma Hsu (3):
  dt-bindings: usb: Add xhci glue driver support
  usb: xhci: Add support for Google XHCI controller
  MAINTAINERS: Add maintainer for Google USB XHCI driver

 .../devicetree/bindings/usb/usb-drd.yaml      |   7 +
 MAINTAINERS                                   |   6 +
 drivers/usb/dwc3/host.c                       |   8 +-
 drivers/usb/host/Kconfig                      |   6 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-goog.c                  | 154 ++++++++++++++++++
 6 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/xhci-goog.c

-- 
2.44.0.rc0.258.g7320e95886-goog

