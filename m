Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9708F79BE56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbjIKVZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242527AbjIKPqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:46:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB8CE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401187f8071so29246435e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694447154; x=1695051954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bdQljBM9G3jopTFDsO9g16l4ONvm8vQqmOSRCzAnEo=;
        b=p/lQDiEE6RtEeQ6xzME5pJZJEoG1FqEPwkevKvh8oOPCxkEI/UzbIdoWyd/f5+ET4x
         YiJ+sbrES87AmSgNmrICKuK0fl3CzLg9iRXlB5NptNe4PHzTb5B0hmWZ8bCHzJcdNdy/
         t3Tnfw1sUb1hUWFRoey8PJpyNed6SQIePQLYI31eZuE8PJTfPbIL6+WjKDfr8Yahcd0V
         MOCkC5kV46dNa9y8CGzkaEPf/qEyRp2I+ROTBndt+uFHZcu/GrieKSrLrCbChAmwAAiv
         vjyNT8eV9g7OLECNs4lyg3e4C/lt5obxHCBy6nya9uCcoGrO8yxDFNxDpmxLoLAWU/ZM
         QYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694447154; x=1695051954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bdQljBM9G3jopTFDsO9g16l4ONvm8vQqmOSRCzAnEo=;
        b=F3RvkGE6JEmuqRsWlm9CUp5QR5zeUt4abQiA/Kgw1CGksDwtOGJxuQiUyP9LY1f9UA
         F7aXZCK2+5XP30if27628MTgTnavExFL6JihrLdOJ9xTBtKSsekBOXNPS9NBJoRNowMa
         Mf57a9oG3xu60Jp8nxNcSQEdHURkTS5+Uc4YiUWIdJ7zkTk/ckp5R4k3ExSuOy2OJVcQ
         bxOFjCku9VQB8LCP1bZK+7TzZEfFpKpxyFzLI/Gc0vLZNO2y8oECwUJp30ZxGnA9IJDw
         6e31dPo/75sTrzof3xzAgYa0TQegZ7Ds/KZbL6quu0kuu4Qt/BMO6Eo54BcKFxjPDdh1
         j0AA==
X-Gm-Message-State: AOJu0Yxk7qwu7y9D8uyGtSRdfokWHbBJ66wK7wf6AtfVcinZ+jPIwCSP
        N6O2OFsJRU2oGLEeHvhKSN4b+Q==
X-Google-Smtp-Source: AGHT+IHSlCpiA67RcBqWVu/yNJspToPqKhBDsN+U4vD1E3RtnOz9o0ZpI5rtn7YZWGnKnmMXksiGeg==
X-Received: by 2002:a05:600c:49a3:b0:3fb:f0b2:20eb with SMTP id h35-20020a05600c49a300b003fbf0b220ebmr22361wmp.1.1694447154131;
        Mon, 11 Sep 2023 08:45:54 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:55be:8f7e:5f59:7ed1])
        by smtp.googlemail.com with ESMTPSA id q12-20020a05600c040c00b003fe539b83f2sm13616255wmb.42.2023.09.11.08.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:45:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 2/5] arm64: dts: meson: u200: add missing audio clock controller
Date:   Mon, 11 Sep 2023 17:45:38 +0200
Message-Id: <20230911154541.471484-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230911154541.471484-1-jbrunet@baylibre.com>
References: <20230911154541.471484-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio subsystem will not work if the audio clock controller is not
enabled.

Fixes: cfae4eadb7cd ("arm64: dts: meson: add audio playback to u200")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 8fa17a62534c..2380d237d220 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -286,6 +286,10 @@ &cpu3 {
 	clock-latency = <50000>;
 };
 
+&clkc_audio {
+	status = "okay";
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
-- 
2.40.1

