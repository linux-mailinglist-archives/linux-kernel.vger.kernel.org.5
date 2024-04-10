Return-Path: <linux-kernel+bounces-138055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF4B89EB9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514CD1C215CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEDA13CABD;
	Wed, 10 Apr 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="KQsi6+NL"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178313CA94
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733303; cv=none; b=g+ScVgzAnMEFdn77X8R9PnUROxpvjOz4K9Kns/FTgQuCyI3vXAU43o7OHXYKViTHrKA36kzLwAZz4c6eJI5/2srLY2Uf6sn9XvLSmXP66I3oJlEFRLCB0Yttdx35N6RtKsnuGRzpxQocO0CnVSMqNVX3vSAW2G4aRDOxS1HwLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733303; c=relaxed/simple;
	bh=VBE4WFggwSMhbNyCrAt1elo5p2W/hqusK1q1y8tuwKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8rr6+o4rg8UEt+O7kaZ+ee40z3D+2tPVYzCQyDpLl19zCqfkCIK8sRWFan65LkLBet3RtoUu/MR5+3M4onwwwZCdJuR1aKbNJ82TmlS6xxSpDHvimN+XnoplDXYsUpGTkSTsM+wZ957DKk+s8UL5iGVYViCTn25md1FKE4ECmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=KQsi6+NL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0bec01232so52520225ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1712733301; x=1713338101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMgN1wGlJBkfHf6qhNjS/iN/zmrqgeoHgJDlTShDEmw=;
        b=KQsi6+NL/2SBYDV2SpNFvOcfNBtUXRz7rG+eVoKpB4FTHizGXP7j336rZz3+1W35eu
         aGGeT75ulEf4ynX+xHxLsmsB9iCCXoFlXknk5rnmyDqhcpTkmFwuy3IgVsmr5+c1Puei
         ORCHcdcYWGjDe8HQ2mlBw3rWY5rmcxL2lXg1xdJs+3ZUet5IiU5Chq/G82+RJGdxihOs
         /p43KNaELdi8Bur73OqKfAC06rsFoHnqbiUD5FP05khyP4XWdY2I5cMlYcn1YDb6v8yb
         96F6+V3BovIWbxv2RlCJofN4l0fZWujAB+gXU/iKVaKTkOeE7f9d/n1w6AkJ1Fzoc5tL
         YXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733301; x=1713338101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMgN1wGlJBkfHf6qhNjS/iN/zmrqgeoHgJDlTShDEmw=;
        b=ihLwK6junPlmuZLXSPPu0CxaMsnEc1LBS6peL2Aoe5/IvkCq+DkEhEfp9y88CS98pL
         4lAN0K0m3JI1vIwZ0mC2RPb5E3i6BMeY2thJlHqkHSiC32mXxPoZ+fI7F9p9efatlMm4
         QnO3qbnbdwddVqWkO9+n8KneCAfYVNM5Pw4a43gKSHqUl5EXSfJKCzN/4COLBJpvcMgb
         UZlBLmuA0XX1CooCIZPj4C9j33KY0W5SjzSvLO5U8L3wp0rvfa68CDTqqO7t9HUlItSD
         jmRv73tgXN9TcHxbu9Agg/QTQO/c+ps6VUEvaQVwgXdnf1DeaNnrtE4oCbLHqz6Z6Chj
         zXyA==
X-Forwarded-Encrypted: i=1; AJvYcCWmSzW7BS9DJFWaeOlIwAkWMkLsEwNfYMOIZuICmQypCIwwaCxqc39j2rmCIhcSAut/EUmc+cuCfbNjdIM5rre4kiBXesjjl99yR3Fu
X-Gm-Message-State: AOJu0YxLrLqbMg06iUVtbvJX72GU5wZftqIUcmt0uvfxsOEWUEXRXIDq
	4Kxeekkwk8+LtRADHMxT4sPN6Vf0r25MJVC9cG2gbzxWaTg7Egr9i/I1NQBBeAo=
X-Google-Smtp-Source: AGHT+IFGbsYgF5UbyKw/0YINggk2A28D2EI8l1L+dqGsTasJL7COTt62tjxZ8TKej65BKBde0GIyIg==
X-Received: by 2002:a17:902:fc48:b0:1e4:4887:74f0 with SMTP id me8-20020a170902fc4800b001e4488774f0mr2348799plb.36.1712733301495;
        Wed, 10 Apr 2024 00:15:01 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903409100b001e264b50964sm10107975plc.205.2024.04.10.00.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:15:01 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	airlied@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/4] dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
Date: Wed, 10 Apr 2024 15:14:36 +0800
Message-Id: <20240410071439.2152588-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in nicely
with the existing panel-boe-tv101wum-nl6 driver. Hence, we add a new
compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 906ef62709b8..50351dd3d6e5 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -36,6 +36,8 @@ properties:
       - starry,himax83102-j02
         # STARRY ili9882t 10.51" WUXGA TFT LCD panel
       - starry,ili9882t
+        # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
+      - boe,nv110wum-l60
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.25.1


