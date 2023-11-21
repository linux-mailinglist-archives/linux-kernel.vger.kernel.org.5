Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D67F2867
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjKUJLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjKUJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:11:02 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74FC100
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:10:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a02ba1f500fso19005566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700557857; x=1701162657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7xc71/uWCWZaMJ73tDTNpkDmxDDi7teb0OVK/0/j5w=;
        b=dOE6k9H0BTRL/ckfIn/y2t5c5N8r/rO7R0+srDRY492q4LDf5Tk+A/WcRrkdCdourQ
         fhU/pTrGQAdYyqaiJtqCVg2Go1sIckihAHNEl1gnICv42zB/t/FRVqV/9UGZUypaSLVr
         LF+jXWaumI5oMI0DEv2C0KIevo1kwAzn51kGT21qxDN3X6PPbGAmWpavSUmPsFo6k4Jd
         1LpajFzfszHvYJof8rJxEHmzMAzWNDsfOaWlo30EfUfHwvmrR3QFLZTgSug5bIPF9eri
         TeKncy5D1cGTIAth/TpLTY/k+MmRTPwygtbQxfNrk/e7eD9ydg6cINXM9HA0NnDm2elk
         0oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700557857; x=1701162657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7xc71/uWCWZaMJ73tDTNpkDmxDDi7teb0OVK/0/j5w=;
        b=fWPgOlcjRk2+qbI21XbC5PeI5E3kEgVN8S0iiDhbFpVrz1g/pjsRwvVr7TuPi1LjY8
         f0ipSLABjCgdcNTuZ5lIWWL/Hzni+8J8f+Uwez45mNgFr9ms9gfaWMtx4oXU2cIR2wom
         ukRmoj30SWRWq79wnj7SD2AQy6KmOl7Ak7R5xqL9qa5RKoiijx772LSQgndlWG5mlK3A
         nPxnP9oBzhzD/CwLj+hD7QR3rY1F+fndKvY/mGD1/Cflq1cxFyf3migaqyHmZsRQ6iQN
         0On54tKGYyxlTKCa0a3rTM2/19WtWI50QYvllm6RtOC9fu7yjkODgaJEtFzk6QFNUn3a
         Se6A==
X-Gm-Message-State: AOJu0YwpkJbEMSMWs/GG5aHJR2y0gce/B8VxboGw04IBYV1Un41kZ2LP
        iKJZtc8d5ehW1u/aWeQFKg9irg==
X-Google-Smtp-Source: AGHT+IH1uDCwryO04lmdqWRd8gjR6p5Oa5n6BLcA4LHrrRRD9n0nBAu5Ct36TUC532zjlwcKEemCQg==
X-Received: by 2002:a17:907:d311:b0:9ae:4776:5a3a with SMTP id vg17-20020a170907d31100b009ae47765a3amr8755878ejc.39.1700557857256;
        Tue, 21 Nov 2023 01:10:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id gq16-20020a170906e25000b009fca9484a62sm2808152ejb.200.2023.11.21.01.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:10:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        dmitry.osipenko@collabora.com, Ashish Mhetre <amhetre@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 1/2] memory: tegra: Add SID override programming for MC clients
Date:   Tue, 21 Nov 2023 10:10:54 +0100
Message-Id: <170055785090.12509.16016411464441236858.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107112713.21399-1-amhetre@nvidia.com>
References: <20231107112713.21399-1-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Nov 2023 16:57:12 +0530, Ashish Mhetre wrote:
> For some devices the bootloader/firmware may set up the device in
> bypass. Memory clients like display needs kernel to program SID after
> resume because bootloader/firmware programs the SID of display device to
> bypass. In order to make sure that kernel IOMMU mappings for these
> devices work after resume, add SID override programming support for all
> memory clients on memory controller resume.
> 
> [...]

Applied, thanks!

[1/2] memory: tegra: Add SID override programming for MC clients
      https://git.kernel.org/krzk/linux-mem-ctrl/c/fe3b082a6eb8b1526ed7397c849d6b2a6baeb6a1
[2/2] memory: tegra: Skip SID programming if SID registers aren't set
      https://git.kernel.org/krzk/linux-mem-ctrl/c/0d6c918011ce4764ed277de4726a468b7ffe5fed

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
