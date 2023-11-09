Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED687E6185
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjKIAnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKIAnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22705C6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:43:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32fe1a29010so147250f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 16:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699490593; x=1700095393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDS+AzSQ7ROcFvu02J9hTzJvbPaGYAH/Q9+ic4s479k=;
        b=TrFXn2IJB9BzBPTbBfIVZGxgzQY4wkQJ4nq470wCFh05oOjFlGzglPv1y7oWjWLET1
         LHhTxbusTBWIXqFsBAGr5naSEMdcvzmUVyjRmO5LtvsfmlInElC35bWiIIaole7yx3yW
         2IROsqAccyEdL2NlLjZn2zMgXB18ArRdcTCpy9QNNh/tQFHYRS6sNR8k4llzmTRm82nR
         IdwjMYxGBrK8KQfHhnckMPKdb4NcHa5oJB3I4vDHsaCCQvkVnRtDvS4Rr5oMsI2EXjQN
         7ReaPa0OUqGQKnzNvWtooFwbxKGnqRztJcY5h/HnEM0qMMZbnkT/q9QWeJvK0I0gG374
         d0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699490593; x=1700095393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDS+AzSQ7ROcFvu02J9hTzJvbPaGYAH/Q9+ic4s479k=;
        b=eYiU9OlJhIkhbTud/9xJVFFmJyNGdMsuvM72HlzKHo5Pr4m2yF69As4VaHhxJ3QWLg
         xXhll+26he7vC9K370t1TpoPovKTVomDnnlirnbKRPWz953BgT/rIu97wNS2zDnpRHt9
         /LLqKwTOFmxnNgz+TBsrGkIe/9ElaE6utecW91BxU94n4T12xT4nEZead7yhR/HVOJZI
         HAtGQ7HBnCH9FVB9dZ6WEtGtohDNaOpWGqVrvCUqGvf1DS7JB+VqGgdzqQzc56gq2q44
         kGc/2y90rcTI4J8BGA6aW6LyAqj+l+mjb8ikYlMEa3ieZvpDs9c0p06k7RmP2PlgmZvB
         lcGQ==
X-Gm-Message-State: AOJu0YyGcU1NeKFuDPiOyKYkjQgLsyCoAV72ORplQAM15GLkryGDFAkU
        PC32ZCEDLXPjuiipAVFhB0JJXQ==
X-Google-Smtp-Source: AGHT+IFGDuWjTK1PWl6WHmyHh8Yqh1u9jcFcsFPyVsDFPvbJo81Vs/TkaKWzTniqYq/XUzGf8Ju97Q==
X-Received: by 2002:a5d:64a9:0:b0:32f:7f09:160f with SMTP id m9-20020a5d64a9000000b0032f7f09160fmr3211448wrp.12.1699490593540;
        Wed, 08 Nov 2023 16:43:13 -0800 (PST)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d4ad2000000b00323287186aasm6099238wrs.32.2023.11.08.16.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:43:12 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH 0/1] Switch on USB as a wakeup source on sm8250
Date:   Thu,  9 Nov 2023 00:43:10 +0000
Message-ID: <20231109004311.2449566-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in wakeup-source to both USB controllers on sm8250.

I tested that the rb5 gets into and stays in s2idle, subsequently resuming
when a key is pressed on an attached USB keyboard for both Type-A USB 3
ports and via the TCPM controlled Type-C port.

Bryan O'Donoghue (1):
  arm64: dts: qcom: sm8250: Add wakeup-source to usb_1 and usb_2

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.42.0

