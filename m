Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A1F7AE469
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjIZEJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjIZEJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:09:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A03F0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:09:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-69101d33315so6194917b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1695701348; x=1696306148; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXZM3t7Vot72kzO5qEhlUVk+47BaITOgjLbty7qmKqk=;
        b=Kc4dslsUyp2iF6NZco+dB26n0Y2TD2+0tXBqozL/5Mq3BwNOqfG73XA9N0GH8NWEcL
         2C1USneJ7IqWLkuykNR9RlTxxbgGJ4w5TRkEPfPTU9nYJ6vtp3yzyERE8QmA/kMEdKcs
         0bRBEkCjP2VQh8osYEQ9hlqoA5O/CQiITcBjPVOpj9S0YoHsgjUClw+FL3zjDeVfIDxN
         f6WChi8He37sBnKWZtBbYGoiGz6IFv5UsVN+P4xuhU/zyXzpclJJYy4mmFbU4kqoPbiy
         /qn3n10uJ9kcQINxk22bTXmwN+HsNSTNgZ1GEwf9k4UYEWyWwnyaz3XfzgZsqJyhKXwb
         LoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695701348; x=1696306148;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXZM3t7Vot72kzO5qEhlUVk+47BaITOgjLbty7qmKqk=;
        b=YW1qWwQA9AnWSmS/dF77wybJ0zCD5zJD+odChedaZ+EewgzKPWsWywu1NOWa7s2hKB
         qszW3HZ1BcirdhW8Lsf/G5O5OzTj7FfjyegkbJf6uCSpArmCm+IHaBzd+WQiReYdF7ZV
         5Sk5EF268Ry88AuSS302D1fOQNjcnUJ+XObeFLRSgKiAt/awULCNxFfgBnLlg/g5+cHy
         RBXDi5fYxEBn4PwZgH2aFB+bgtJuNfRNQ+Iod812Ck5RQHqK9AN+TjmcbIhODEl7yZaG
         go/M7iGqTK6g/IvWzUrLswpIsmYL0FFO4N3X0ejU3k92HnKodazC66yUm3PQsI734HaZ
         WC/A==
X-Gm-Message-State: AOJu0YwfPhCfcRvYCx5PawYAxPKVGmiqEbYhyVM4oXoKIAZ41WcozTci
        Mkek01uUDCrEjz2tj3S0wRL54ZlGBLdYuY68Shw=
X-Google-Smtp-Source: AGHT+IHvbM72jhxZ89SI81WyE4fvEpRvEDerJok1wsO4XJLuvjqRPTmSiem+y6GcAbfaA+vlEsD4FA==
X-Received: by 2002:a05:6a00:812:b0:68c:2be:67bb with SMTP id m18-20020a056a00081200b0068c02be67bbmr7115105pfk.20.1695701348557;
        Mon, 25 Sep 2023 21:09:08 -0700 (PDT)
Received: from ubuntu.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b00682669dc19bsm8824907pfa.201.2023.09.25.21.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 21:09:08 -0700 (PDT)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, trevor.wu@mediatek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v2 0/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Date:   Tue, 26 Sep 2023 12:08:59 +0800
Message-Id: <20230926040901.20338-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use RT5682S as the codec and MAX98390 as the amp, add a new
sound card named mt8188_rt5682s.

Changes in v2:
- PATCH 1/2: Modify mt8188_rt5682 to mt8188_rt5682s
- PATCH 2/2: Modify all string "rt5682" to "rt5682s" and merge code 
             in mt8188_fixup_controls
- Link to v1: https://lore.kernel.org/all/20230925083847.1496-3-xiazhengqiao@huaqin.corp-partner.google.com/
              https://lore.kernel.org/all/20230925083847.1496-2-xiazhengqiao@huaqin.corp-partner.google.com/

xiazhengqiao (2):
  ASoC: dt-bindings: mediatek,mt8188-mt6359: add RT5682S support
  ASoC: mediatek: mt8188-mt6359: add rt5682s support

 .../sound/mediatek,mt8188-mt6359.yaml         |   1 +
 sound/soc/mediatek/Kconfig                    |   1 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     | 141 +++++++++++++++++-
 3 files changed, 141 insertions(+), 2 deletions(-)

-- 
2.17.1

