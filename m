Return-Path: <linux-kernel+bounces-79533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2228F8623BC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DECB23141
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FC6199C2;
	Sat, 24 Feb 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oD5+EDKs"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BF125B7
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765963; cv=none; b=i3uN1OLJ8CPqQlvVovkZaTfVzD6vt9yFFjh1q4ttTP3ZN1pFKtEbkLdHAa796R3hDMAGEpCZTLrheAnTHsAPY1rJJKxMduthBOvV95AiPTqSr4qIZebqdoARJdCT+p2p0BDoVqwx3SmLhZ1qHLSiFhI0YDPsacW5HroqlgZb9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765963; c=relaxed/simple;
	bh=QJHaYzPY+m0OHtHiflvDg030t6MnJOuacu/PCuwm03k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ia78yjOfPMPfauAJHgf8k6zV6smjxoyRLwPjrMHIRYr54ad0bwv1PhP0aubrdV6i7m4v0Dkr+zaXCDPBxF9D0ZFN/EOlQVlgXlldVUQ26tWpIX1CQ4ahgU55YMyOOdP75WfxpYslobJl/KRXCrRrcGBTad4SI4ghLUFhFfLZz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oD5+EDKs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so1754980a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708765960; x=1709370760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rSJ+PeO4x72bs3AUvmTEqtOywxqrxagbi+uMUHWuQSQ=;
        b=oD5+EDKsCqSB++cRrpFfBwCb/J82G2d3Svs5NOnwqgpBw2c4bdZZLqjT+s4MSzUB94
         rFNbBcYCdI99RLoP7k27BF0R05ZHlADbtTZTcIjdSr5oAEzvDQX2BAvObAaSA+yLXf5d
         cKxaMlELTaZuyypcleWFJ/iVp2RvfvzRjmHFJU23hbHZiof5ICfJJ9itaBgfxUOdXSMm
         Jn2nmIGfWWn2nj1bmcgeELrJv9/ap7CMkqq7cFm4tLznsIUU0rmmMRL0t7iYHFMyQ7ri
         UMXDgVW4nyilih9oGpZ6z+0PpTPj7cImysWeOavYYrDtyhAmt1lRno24aSU/pvWpF3+e
         wYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765960; x=1709370760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSJ+PeO4x72bs3AUvmTEqtOywxqrxagbi+uMUHWuQSQ=;
        b=pFwmVWBZmxRYurM4J/36btvO5HpQ1xX8j7+3EBxkNAYoPCWLnzX4/edCKxS33FXM6U
         JMeBLT0f1ZzLsZsq1HRx/bzdP3Pxx6BPrhpp+qWy1IzZP9w07Sx95aSasFBlGkaAU2Q0
         vbmjbFww63UcmdSuiNuQUlbrh+XQGkTcGmeaZMLB9/sfkBjE2phpxY9J3BrIuJNCcVA6
         L9gDFyXzRVkkZxs3PuWe/juEQT3lPX5UixlE8SW+k3fHmo0Jg59llSfhmYCBlQvMmOtg
         nCE69dcLWHbRrmounAhzAi62cMQx9Vlx6a7n6+r5JwO7IuC+DQfGN06cRiLzQa+v2zrI
         WrCg==
X-Forwarded-Encrypted: i=1; AJvYcCVIpCpjkLT5a5zBqfZmJP2ikW8ScL/xgOoF9587KwjlkOoRySud3bR04tWUho83ZJ5gg5lzC7xozDU6oOMU4ZRDSpNtWsBpy+7nb2da
X-Gm-Message-State: AOJu0Yw8xM8xQIboXNokYF6lyI7JY9ciBds2eV+6h+SkRjGSCR9etm+6
	7ggyNNpe3E6qed4ysfmcUoZQGHlat+gHHDbxJdoSqOtghOGMGNnLZorEoCusXQk=
X-Google-Smtp-Source: AGHT+IHG9kPQkhg3JSWWrcuHi1+sLlRaO9d5IHwbE6um4kWNgdiD0lDhIkh1bAKYCo23+kRRc/aVwg==
X-Received: by 2002:aa7:d591:0:b0:565:af2e:d016 with SMTP id r17-20020aa7d591000000b00565af2ed016mr295203edq.32.1708765960266;
        Sat, 24 Feb 2024 01:12:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s8-20020a056402164800b005652f6a9533sm363120edx.74.2024.02.24.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:12:39 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: clock: keystone: remove unstable remark
Date: Sat, 24 Feb 2024 10:12:34 +0100
Message-Id: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keystone clock controller bindings were marked as work-in-progress /
unstable in 2013 in commit b9e0d40c0d83 ("clk: keystone: add Keystone
PLL clock driver") and commit 7affe5685c96 ("clk: keystone: Add gate
control clock driver") Almost eleven years is enough, so drop the
"unstable" remark and expect usual ABI rules.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/keystone-gate.txt | 2 --
 Documentation/devicetree/bindings/clock/keystone-pll.txt  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/keystone-gate.txt b/Documentation/devicetree/bindings/clock/keystone-gate.txt
index c5aa187026e3..43f6fb6c9392 100644
--- a/Documentation/devicetree/bindings/clock/keystone-gate.txt
+++ b/Documentation/devicetree/bindings/clock/keystone-gate.txt
@@ -1,5 +1,3 @@
-Status: Unstable - ABI compatibility may be broken in the future
-
 Binding for Keystone gate control driver which uses PSC controller IP.
 
 This binding uses the common clock binding[1].
diff --git a/Documentation/devicetree/bindings/clock/keystone-pll.txt b/Documentation/devicetree/bindings/clock/keystone-pll.txt
index 9a3fbc665606..69b0eb7c03c9 100644
--- a/Documentation/devicetree/bindings/clock/keystone-pll.txt
+++ b/Documentation/devicetree/bindings/clock/keystone-pll.txt
@@ -1,5 +1,3 @@
-Status: Unstable - ABI compatibility may be broken in the future
-
 Binding for keystone PLLs. The main PLL IP typically has a multiplier,
 a divider and a post divider. The additional PLL IPs like ARMPLL, DDRPLL
 and PAPLL are controlled by the memory mapped register where as the Main
-- 
2.34.1


