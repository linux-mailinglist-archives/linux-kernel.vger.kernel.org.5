Return-Path: <linux-kernel+bounces-95032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8416E874868
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E31F21DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D291F94C;
	Thu,  7 Mar 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7lsQXAl"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11C1D529;
	Thu,  7 Mar 2024 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794882; cv=none; b=i70S09rL9BoqnPyxKCnDP2/nwTyUYOryZxedWpwzm7AMrfDOBdxCPH4t4CT0twI/yJyNdeIjUAgytXrhBt106VHzk5zUWZzcqaqoUgtx4gPLqrdKCwpKwMSNig/LFLoBUSm/A3oU2F/xFh7L/S0lbdDSO9KLt4lX1ncJQT3gozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794882; c=relaxed/simple;
	bh=43aEq9C39A8hDzjssPpDD+NB6N195l1L/QFKz3eMy3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PARDgnTSbiryT/Ihety3KoJarEx9g/ETqIdWXBe09ZycB/etPBc8Crs95t7vFC8joVvWOiclV4eL+3b0x5NB94CL5XENhttV/EdZKHvIGIIgv1mt4kPSdkRqoLkQJ38BYfQbar9tIBjH5Tu2Lej2+2hVrGCZNP5V3bBgZjbkIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7lsQXAl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e64a9df6c3so388419b3a.3;
        Wed, 06 Mar 2024 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709794879; x=1710399679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeJ+JntwKW4wdQtAHs36UWp64DtpgAOAPqSLV/Dt1Q0=;
        b=X7lsQXAlfi7dOtHpxJ81nlpz7UG77bYVcrR9x4Wd2MIGuYdmQf0D93ACe1jmNu6q5E
         ARKgrbUd6UI/gzQQz5ge+6OeH5Vg+M5ETi5QzCIlmC/jVwSVDTV7bDpXdHZ/Kst5ILaL
         /16Fi7IQOwEX+a+5ryKxtgQu9h2mmc5TNHd24lzA6OG/PLCbFH3+sK/pYLufLkL7HNRU
         JAKuNN1rD/PbtxfFoBi/iLqvv/v0wIFcxCRzPiDmz3WdcKpTZZEUVmLAucVCoSPR9Vwh
         lxLn6cW/viYQgfqjSUwPWBbQXKXKPjvea7Y8yChKL9V+AMx0dDunFKKuurzb7IqvW8Dk
         uYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709794879; x=1710399679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeJ+JntwKW4wdQtAHs36UWp64DtpgAOAPqSLV/Dt1Q0=;
        b=CBCAG84X63lZ3/t9wdzokA9NPambieXMpGkFLsnd/LDWYJoBida3k83J9Tj7uA9CxH
         rHsPUgN2b70ufNJ8IC9Ci1XxQoCG6Kis54VbyoYImt9RqmHpxnQt5B5Q2x1LtjWW7JKs
         zSQcelJHkOZfyM5I+UndNuK/tSnNWN+ddz1Ryan5rw6UcUaTvESZi0BX+RsmAkiV6lPt
         kV2vztJSimNlRhWTd41+9V4Slkwly7ZUaFibnLoneQxTSHOFTF6GWdMkZQajJ8xGffE1
         RFtpxNasfnddgisci41l/PA1pQuDeauJJfThi/zBkwUpneH9UbFOns7enZ6hYXn+GkJg
         yNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN1Vn3LEE6eITtQnx1H+LkothMH+BuNAI0xSQPNH0nKnq9zM+/KMuB5CT3ow9Vh5IBzxhNeyc2Jzo3SzvgiuifXUtjh3PCD8auEhjB
X-Gm-Message-State: AOJu0Yy59DR+iMhVMhWfMWBNGkqdVy+iZBnWUj53igMNk9imFZCapRRN
	5OmmxMRNH2Y4afE7wEpHIWgSbnkR+IGtmp4Dp7kO9UrWbyQXkQNMOkAU+Sm8SWo=
X-Google-Smtp-Source: AGHT+IFqMEll30/fJhZZ6rDkCi3tTt4kyBuoteYxhg1Q6Sx0Bctg+bVk2O5ur1zhrC4aokS4SgXGZA==
X-Received: by 2002:a05:6a21:999d:b0:1a1:5144:79ab with SMTP id ve29-20020a056a21999d00b001a1514479abmr7352893pzb.10.1709794879369;
        Wed, 06 Mar 2024 23:01:19 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b001dcdfcbf245sm13246885pli.119.2024.03.06.23.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 23:01:18 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] Doc: netlink: support unterminated-ok
Date: Thu,  7 Mar 2024 15:01:06 +0800
Message-ID: <20240307070106.1784076-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ynl-gen-c.py supports check unterminated-ok, but the yaml schemas don't
have this key. Add this to the yaml files.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      | 3 +++
 Documentation/netlink/genetlink-legacy.yaml | 3 +++
 Documentation/netlink/genetlink.yaml        | 3 +++
 Documentation/netlink/netlink-raw.yaml      | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index c58f7153fcf8..7094d619cbb6 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -208,6 +208,9 @@ properties:
                   exact-len:
                     description: Exact length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  unterminated-ok:
+                    description: Allow the string to not use terminator.
+                    type: boolean
               sub-type: *attr-type
               display-hint: &display-hint
                 description: |
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 938703088306..aceb72175365 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -251,6 +251,9 @@ properties:
                   exact-len:
                     description: Exact length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  unterminated-ok:
+                    description: Allow the string to not use terminator.
+                    type: boolean
               sub-type: *attr-type
               display-hint: *display-hint
               # Start genetlink-c
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 3283bf458ff1..f6d5ea44bf86 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -175,6 +175,9 @@ properties:
                   exact-len:
                     description: Exact length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  unterminated-ok:
+                    description: Allow the string to not use terminator.
+                    type: boolean
               sub-type: *attr-type
               display-hint: &display-hint
                 description: |
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ac4e05415f2f..0e105f21080b 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -270,6 +270,9 @@ properties:
                   exact-len:
                     description: Exact length for a string or a binary attribute.
                     $ref: '#/$defs/len-or-define'
+                  unterminated-ok:
+                    description: Allow the string to not use terminator.
+                    type: boolean
               sub-type: *attr-type
               display-hint: *display-hint
               # Start genetlink-c
-- 
2.43.0


