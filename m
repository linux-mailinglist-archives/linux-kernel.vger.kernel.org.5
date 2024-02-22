Return-Path: <linux-kernel+bounces-76099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF185F2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34A21F2464B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792681B5B7;
	Thu, 22 Feb 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpTbwESL"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A93182CF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590506; cv=none; b=aHhbJUaZLBA3Fs/ATdnGUe6p4HkZqfC5y14a9veZ/p2B9BrCcni/2Daz99c0zUOnofNpt58/SS36TatZOr8f/0iY/H5BemtA9J0QDaE9K0vTDvrin04IAjXjXcCCiuqGnFp+4qo5APYmRxqFklIe+ACA6GecAkwGrec3h8xVUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590506; c=relaxed/simple;
	bh=EvteK50wyl2kprR8zyPWEQOJdijQCkbQp/sp4jSnARc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LqYG2J4sOtUEQpK7hEL61pyxMEDGrQ6Ah45tQz3/bqhfs1NY7hX5oWld0p2IN5Vs0B8i4tdly6qeRXbzRf+TZtbB85MWnO7myC422caPjw/ztcumKaL5WNQDsPSQ+8iFG1seJUaSpWPDvdvva7FHELhIUV8pq6ONvo+RWqwHbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xpTbwESL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so1045842766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708590503; x=1709195303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0K0y7mMwQ6eINvxBjtceE3os6xVsWexBerMPUbtyFps=;
        b=xpTbwESLemYSup/R3juAirb3bJPYOF7B1ZcUO1Z2OE7nUNBJkfUSywLntAEKPiOxU3
         GSEzjwIM979u9w0J7uIwRwKqnm/9yKmVnVNRj64ouQb7WvRPp1Ckrw/3xbMJ9cUGEPQM
         WD3J+X9GCXGVvYE1XP1ehgqgmqkv0cb14pWvTlRUxcWXzS03b4yBxcixk3oJfgfoQwuh
         3WTRbNnbNvuWAon1BIG5ro23l/L7YKe36nVCn4J2/FOJhV91z9S9xaLbTsTCDMsaQyUc
         ikbRBdXpMB72cubkJu5RJWKsbax9sT7hfAsBwVICPHju4u6GlJ45WAq3ZdU1mHz+Y67b
         EvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590503; x=1709195303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0K0y7mMwQ6eINvxBjtceE3os6xVsWexBerMPUbtyFps=;
        b=m3aPSne8kBt01sHxfMcvyeDw9NFYU+x5PCGZJfZy/m4cjCXCPESA7qxLC3Pxlbk2fQ
         I+SWvqdegUyo5XPlzcugvimhNoRt6o2sS3bAANNHtVwzuacBTo8hI0lFo1K+mbM6ow1h
         4HhkUcOom25pQIbRweEh9j9X+89rnLXjUOpqTPCLUupkhTVk04oEWoUcJQW1ZBy9Coeb
         L+3wrVY8o0Dr81n0udLmik1vFv0dt4aTBb9QFWdHcBw056gUFt8PPHi7+14zTdgqDchP
         Q7A2sCIEl1wkXGTtW3ObZEyChotbAImlFeYL3104CrskgICouSB+O5mIRDvLuReLiV+J
         ogmg==
X-Forwarded-Encrypted: i=1; AJvYcCXrgCvcPjdctbHYRUYYz5ccsSefQwUXq/d082vnYsm+GmfiHseu4QfaixfKJQY5vnUubIlhS8Eb/p31nBgyQBPwuqjqmMpTWSRpzMKb
X-Gm-Message-State: AOJu0YwSvTw3JPsiA9KcN4XkEYYZ7SpS2O30KI9isYHsgeSPPNOwoydY
	t7e/P1BPT1FFzkyEHgIBKVqjPqd3dmh5MJIm1eZRH3WwfFAyYpvEmXfFKCJ2qBY=
X-Google-Smtp-Source: AGHT+IH7dW5lx5ijk4XY4dgNzFesrot5udC3LHg/4tTUdJiIgWdnAJqUyV96hgU+dShciHbxpbF27Q==
X-Received: by 2002:a17:907:375:b0:a3f:6b7f:11fe with SMTP id rs21-20020a170907037500b00a3f6b7f11femr1200803ejb.66.1708590503535;
        Thu, 22 Feb 2024 00:28:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id vh8-20020a170907d38800b00a3f28bf94f8sm1600210ejc.199.2024.02.22.00.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:28:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Xin Ji <xji@analogixsemi.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] dt-bindings: usb: analogix,anx7411: drop redundant connector properties
Date: Thu, 22 Feb 2024 09:28:19 +0100
Message-Id: <20240222082819.10321-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The binding references usb-connector.yaml schema, which lists all
allowed properties and ends with unevaluatedProperties:false, so we can
simplify analogix,anx7411 binding by dropping everything covered by
usb-connector.yaml.

Suggested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/usb/analogix,anx7411.yaml   | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
index e4d893369d57..3f5857aee3b0 100644
--- a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
+++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
@@ -23,24 +23,11 @@ properties:
   connector:
     type: object
     $ref: ../connector/usb-connector.yaml
-    unevaluatedProperties: false
-
-    description:
-      Properties for usb c connector.
 
     properties:
       compatible:
         const: usb-c-connector
 
-      power-role: true
-
-      data-role: true
-
-      try-power-role: true
-
-    required:
-      - compatible
-
 required:
   - compatible
   - reg
-- 
2.34.1


