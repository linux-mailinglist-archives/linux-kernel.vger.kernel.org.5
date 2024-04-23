Return-Path: <linux-kernel+bounces-155850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824F68AF7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610A71C228DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA6142903;
	Tue, 23 Apr 2024 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxzSRujX"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0F142627
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904052; cv=none; b=cI0Jy0XI/0C7BcIFhXaC25oD6In2hWe45atf9jVyBGrB8AA+6E/sC5/v8ZHVBTNBovWaDVDq5+x9/nizdrDnb3sebVRDRNUNyxEXqJR0g9QoRCJEOwNgbdlMh3xv0WO4IIIlKBBX6JPia977luMfE7ypgkyxiN8gEb6p8Nb01iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904052; c=relaxed/simple;
	bh=lcfcr+1GhRDv8IVeIRF9u5dA/5mCN9+AaIerErbLA3o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tyM0KcGIChH1hUGr1ADOCVF1T52c2jGjtq6YbpbM2QqLnXM+Pk/8PZ32e7ZBFjIFEZx+ZD/DHcnqiVIvUiqUQXm4w/bXMnCy6Xi0RC90naDdw9xYYHwP8ukfAA0yGIXK8mgw3FqLepQrYa425yVo15j3a1MmzOVKd+TGPzoNDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxzSRujX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150e36ca0dso101373567b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713904049; x=1714508849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2i8rOHeh5RKwXjYUcNtV4zB/YO7tGxfhWF0DF/1cLZ4=;
        b=KxzSRujXX2yYda3YGKTnIy4ApWTa4qKhWwlWg//ZHW5l4swE9CP/orGArRxdf368/O
         pBBLbK/K6VEGFGs2H2+i3jF9jJvz8RHRiPF8aC9Q2NRbBGJPoOyTni1hRySUOOtc8poW
         rT++3yfRe9vEWaC/9u7pZfJzg50pKYER8LB3gr7SjGmu4nIZbZdoEXdDiPdx2DqAAKmM
         mtJlZC8rZGo3oNkf8r9LSY7zBKRkLSqj9vsoKIubLriW2yHO509yawS/sW3fOW1KkPeU
         S5/fUxmKaBpI3Ss15GyXmXuWtOzLEZwtrV1eXm96eOVcKVE8vvdxIm/8jQDVVOs1bPpa
         N7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713904049; x=1714508849;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2i8rOHeh5RKwXjYUcNtV4zB/YO7tGxfhWF0DF/1cLZ4=;
        b=a9Yb0bFBJ59UeG4ZxbwWl7PYRXIqlsu/Fof+j8GQXdFxOmgK8c6X2Pq3T5mRXaixJG
         xvOyxB6TVOwiDAtVUBpqa84oupfiMsZJoAtGxsrCLNQ3UZ2ZCuRdB3OqlaLfGiAAepEO
         WOOlFi5TtNZoGESHpGoaJIbfKPJZzQyWOWhA8M43H0rAi1/EwOAuBMHuF8JplvBBNP2Y
         jFzbrHGql2h6iN70xTVuNLD+2OzQmZvzdtfDYPNG8ogg1sbICNVgXCxoQQycDEgK1YwW
         Ob3ECguLftr3PucOa/vK2JW4+Q8RwJ6tsin1h+h0UpjoBfRD6MQvsuSyhAX/Igi0shvj
         EAtA==
X-Forwarded-Encrypted: i=1; AJvYcCVrQafJI4Iu462ec14nyVmyVuBd+7pibGKpWeGWxzbtSoH9ythulQk7wsOVxh4kDzbn5Iy9MkCWSXJ4/UbPseFVGsOXsyYLWyfEyalu
X-Gm-Message-State: AOJu0YxQn5fZF0XDqDWmA1DstkdebqvSozcsjiN9TbdTMLxrcPhifThE
	NER/5qO6K/ifNRkVWKjo6L6gcxI2BqMTpi8VWq4Yi2yarNtZTtQk48oiFdOgyJTrylmNu7kubEV
	hargPlYONqtrKWQ==
X-Google-Smtp-Source: AGHT+IGarbd5K4uaWj4S1ITDwyHkqJfj0ZEmFs6fdBZvTxtKNXxpMjldoEZN/YiLU+j9pn2g704onWkB6aCSgp0=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a0d:e288:0:b0:61b:649:ac90 with SMTP id
 l130-20020a0de288000000b0061b0649ac90mr124315ywe.9.1713904049585; Tue, 23 Apr
 2024 13:27:29 -0700 (PDT)
Date: Tue, 23 Apr 2024 20:27:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=rdbabiera@google.com;
 h=from:subject; bh=lcfcr+1GhRDv8IVeIRF9u5dA/5mCN9+AaIerErbLA3o=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDGkakktYYi6sPmxr55z1O2bjw5mSD3P+1X0pFLqfL/96v
 8/dl7MmdJSyMIhxMMiKKbLo+ucZ3LiSumUOZ40xzBxWJpAhDFycAjAR5xZGhg2H9BSsfP9eF0o+
 +Divb9I6wVnFqtt737R8nrG5I5T9BBfDf5+IG96xxirbVl8r7rUtrZ4d2bdi06enZ1wYKqIiPrY xsQMA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423202715.3375827-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: tcpm: clear pd_event queue in PORT_RESET
From: RD Babiera <rdbabiera@google.com>
To: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a Fast Role Swap control message attempt results in a transition
to ERROR_RECOVERY, the TCPC can still queue a TCPM_SOURCING_VBUS event.

If the event is queued but processed after the tcpm_reset_port() call
in the PORT_RESET state, then the following occurs:
1. tcpm_reset_port() calls tcpm_init_vbus() to reset the vbus sourcing and
sinking state
2. tcpm_pd_event_handler() turns VBUS on before the port is in the default
state.
3. The port resolves as a sink. In the SNK_DISCOVERY state,
tcpm_set_charge() cannot set vbus to charge.

Clear pd events within PORT_RESET to get rid of non-applicable events.

Fixes: b17dd57118fe ("staging: typec: tcpm: Improve role swap with non PD capable partners")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c26fb70c3ec6..6dcafbaf10a2 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5605,6 +5605,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PORT_RESET:
 		tcpm_reset_port(port);
+		port->pd_events = 0;
 		if (port->self_powered)
 			tcpm_set_cc(port, TYPEC_CC_OPEN);
 		else

base-commit: 684e9f5f97eb4b7831298ffad140d5c1d426ff27
-- 
2.44.0.769.g3c40516874-goog


