Return-Path: <linux-kernel+bounces-77256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC7D8602A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFBF286B54
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D3154901;
	Thu, 22 Feb 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJmXB1rI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39963FE2C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630009; cv=none; b=YutHN62hgObom3nEDCBXOySjcpKqmUhJkK2sSu6+TyohkQ7AdQ0mYPTtVF5O8XIktfJUpoYcm6xxwwKSgDdjmOiOBmEE/GMILVCLH/Gh1H199lEe5ScondHeR/OiIILY3I4R/RWkYVJAEwo1FEeC5tVj5Q52T7gZFw5ecrP2E+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630009; c=relaxed/simple;
	bh=91aDpj0J1suQKpEMGdpopPbtClBGYCSdmwQ3drsbMQU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=bqjROLnOJGfamXURGJ3ukso8RoEA0y6r0iNETkmi3AjXwv7jS7p43ct8IZ1ifZpIrt/+leDZsWjBOoRuApImuZ/p0ILcDiDPWRW1RwW3Q9xO2VIE+Mf9EXjmG2qfP5DKMrrFVXdFCGkw51KFmCJgQg4aaZvIMPT64jcQne3bWsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJmXB1rI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso48077276.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708630005; x=1709234805; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4GkCuqwCSEAB8nvds1ZFkf95AtYbW9zdNmctGggYMc=;
        b=bJmXB1rIhKzm0Tlh+MTlxUSfthKI7xUAUtrKzie9Oqnu9GpKxrXI7Nk39tlWvdFU5z
         B6HWkC/N2KSdp9w3obmcpTNfMbGNw5fi17xvetMNlxQvVQ+TnYW+VGr+Y5q9v9CpcM1X
         Je4Oncl1VL6YCA1egmQ+fufz53WvMIH7qf9iXy5enCN7QYbKQNGWNeuqQo6llEVWcKeZ
         9iRbJ6fpoRBqMwM11MP0bYaBOaUtUrb7Aum+LudU3aDVWntyb0WKM7YlqPMR7bOy0JeU
         kFMDCYbXb8kexYCmx75Tk3dRagnJnN4eUDRR9NW8lvH17/vOSqSAJRc1Fl/Amps51298
         pGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708630005; x=1709234805;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4GkCuqwCSEAB8nvds1ZFkf95AtYbW9zdNmctGggYMc=;
        b=TWsGIx2nDrE5GExuReofhwWi8o7rT1IFIlx68MMkOl/WcEpldIEAsaIwxTWHbgqQDJ
         c7Z2wxOfoxLC8yzC7NKPPCYf7nH2IvkxL3QIJlcGRJ80Gf3z1MWXpFlm3rLIKs5cGnXl
         dJ+hAxSOXSsWUV9SXHHmXVRyHC6FxscENAQU7TDIpOtySc9S8rOaGYj5zTfgeIUhPNf3
         vrmgTuMZrFImvJm7FZCP+h5q6WTRs+pkUQcpLEqBV9u6owcEcBKHnK8WJrgTMW50Z7ev
         OeQmBSuhmc66L79nNdVyg3OMy9qzl/nA6von9c9G+5M2eZ8eA71X1pR8FZT3fOm8FOSk
         024Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlo4pgN+KZANGyBIus31HXKsN7OZ4OV5T8a/RDllcyxH+7sYHAxG6AU93opLrXIYrQlzI6oh8jUibuyLuAVo77ib1VEIOq0Ynuq/Tx
X-Gm-Message-State: AOJu0Yy88JrhzPwdfI4d8udEdTxuDdOoPes8VPba8ptJCV8pxkKuxjdn
	+/7Bs/whpSH74rFR72fkU9pIzFN72dMfUHKOcZEA0xuW/KIm5kOj6+PoviHxyX2hfQ==
X-Google-Smtp-Source: AGHT+IEPTCoweL32yIVLMQ5Ekqsq7q2DSUkOe3t5EWJqj+LBbv7Z1eeSfkvDbIFHGrbMPsAjyVNsE3c=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2d3:205:26c7:da00:ce0c:dbd5])
 (user=pcc job=sendgmr) by 2002:a05:6902:1141:b0:dbd:b165:441 with SMTP id
 p1-20020a056902114100b00dbdb1650441mr28329ybu.0.1708630005724; Thu, 22 Feb
 2024 11:26:45 -0800 (PST)
Date: Thu, 22 Feb 2024 11:26:34 -0800
Message-Id: <20240222192635.1050502-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH] serial: 8250_dw: Do not reclock if already at correct rate
From: Peter Collingbourne <pcc@google.com>
To: "=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When userspace opens the console, we call set_termios() passing a
termios with the console's configured baud rate. Currently this causes
dw8250_set_termios() to disable and then re-enable the UART clock at
the same frequency as it was originally. This can cause corruption
of any concurrent console output. Fix it by skipping the reclocking
if we are already at the correct rate.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I2e3761d239cbf29ed41412e5338f30bffe1efc70
Fixes: 4e26b134bd17 ("serial: 8250_dw: clock rate handling for all ACPI platforms")
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_dw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 2d1f350a4bea..c1d43f040c43 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -357,9 +357,9 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	long rate;
 	int ret;
 
-	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, newrate);
-	if (rate > 0) {
+	if (rate > 0 && p->uartclk != rate) {
+		clk_disable_unprepare(d->clk);
 		/*
 		 * Note that any clock-notifer worker will block in
 		 * serial8250_update_uartclk() until we are done.
@@ -367,8 +367,8 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 		ret = clk_set_rate(d->clk, newrate);
 		if (!ret)
 			p->uartclk = rate;
+		clk_prepare_enable(d->clk);
 	}
-	clk_prepare_enable(d->clk);
 
 	dw8250_do_set_termios(p, termios, old);
 }
-- 
2.44.0.rc1.240.g4c46232300-goog


