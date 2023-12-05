Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93CB80569F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbjLEN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjLEN60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:58:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5490
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:58:33 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1c7b20f895so75156766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701784711; x=1702389511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5Oze3/1RDszWMpciOU5HHEZVBDC8CTTQ6maphqjCpk=;
        b=zE3+v8Pl4FyaKTnJaicGogKNVZWUgSOQesuO5YGvmZsC+42Am0sTtc4D767AqauTgJ
         xN6Pjkh89fTr0Fit/O0zO+O581bbn3GuQM3Ibgfw4vGlgGAI09EkfsgR8/nwkbNZWT12
         te/rkQ5ZqHVdFwcIOtcAmmcukIAzIOTM+60pYDyMU6Hc/uOb2UDYKpUL1HoC8YSgVr+a
         FdrS6Urd4qNUHJ4mKlKgP+ncv9p8qFh9PIXJzeOLorGk+QLxd++SA9/K+9Txd/4chkS1
         BZP4j7LQ22nqCIub16+Fne5dUt8dndUPxQbC4UacBczRcVPyxxpNxZRou3fkUo2NZNjJ
         8nLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784711; x=1702389511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5Oze3/1RDszWMpciOU5HHEZVBDC8CTTQ6maphqjCpk=;
        b=Q2Xx+y3wGioiUCIr6TCpLKxytKttOdsSEUxz6hI8LlqPnjoWV6EU/tW+xx7IBPWWeq
         DolRSRsn+Ny45pr1DeXlrYyRch3/zJnbxM8PRqYkIkzAJ2lhLreI7e3CM2tiD3X/S0Mm
         UaGM1WfOI46RP6CvBZ3bZ+MzoDJZdAYYs3EN8dM9vgmlD1pZfkJN3oal/E0DdQANM2FK
         067L16BdTrsHdTYzT8uckoirXTmjEsFiMV0Y3eCX1gQ2n6lolBm1dRYnhHcjYOh0SVCP
         TIcPAdEp/aEMAViIZRtUVTUIDSBx9Oh8I2biq63/0jBvkMQBTHawBL8iBlPxybKL5fjG
         bAUQ==
X-Gm-Message-State: AOJu0YzapsU2V3trMXjp2cF1WSGqsBBLzLqyyEYH+nUTEWfhXx+h9omD
        dUGZM3y3TrXeQ7LIIPfPxOKQoA==
X-Google-Smtp-Source: AGHT+IH8wju8GD5Zx60pHtilWQSmGAaG7mcnh/RhurUSWf5JLiDlXK8tl9XAaYjvFRrkmybVIUDznA==
X-Received: by 2002:a17:906:811:b0:9fe:3d74:2b62 with SMTP id e17-20020a170906081100b009fe3d742b62mr3713369ejd.12.1701784711500;
        Tue, 05 Dec 2023 05:58:31 -0800 (PST)
Received: from hackbox.lan ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id e20-20020a1709062c1400b00a1c7b20e9e6sm833583ejh.32.2023.12.05.05.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 05:58:30 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, abelvesa@kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: clock: support i.MX93 Analog clock module
Date:   Tue,  5 Dec 2023 15:58:23 +0200
Message-Id: <170178465116.22654.4507616023393071038.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121063446.155300-1-peng.fan@oss.nxp.com>
References: <20231121063446.155300-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Nov 2023 14:34:45 +0800, Peng Fan (OSS) wrote:
> Support i.MX93 Analog module which contains PLL and OSC for Clock
> Controller Module
> 
> 

Applied, thanks!

[1/2] dt-bindings: clock: support i.MX93 Analog clock module
      commit: d24ffddd1071dd3bb348b010f1f9b780722ae90f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>
