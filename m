Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3C7781BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjHJToV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbjHJToT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:44:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA56196
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:44:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686e0213c0bso1021986b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691696658; x=1692301458;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+FbpAtHPUABM4eAiy3YPzIyaKzeCCm/09lBqGQ4yV8=;
        b=Yk4TJt50lDbjVId45AC5YtKAuY6cRDJE+BO8A/AFC9hXEQXQTN2Qs3C7KDj5/flxXf
         gJfO+XZ89726FWVAYt86Wy2r3TKOFSitBHyyEaadHYDzfYi6m3QMO09GX7/MPsSalRGH
         MFZTu+LF81IYl6IgyBrk1ywpkpvIYIw1GZXO6sPvoBBL2Urb4xondmWLWryVbtTVzQxb
         1XL5p2rzl4QlNKgec32nV3YRJfn2Goi9eHMYEc1q0pO+ZlV6dIuNBNPy8JbFnHWMW5Ha
         7sG1c1aGvfrJZ8wDn4h3btd2qWaLAYevZbkmrSXmXDU1waqh2ASWbGf/ZvQmPHf8ubVl
         IA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696658; x=1692301458;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+FbpAtHPUABM4eAiy3YPzIyaKzeCCm/09lBqGQ4yV8=;
        b=AaRa4KximZe/UPpdfVNaMtABsAd9UQ6b1jY2jYobC+KguREUlbxJnsYXvfpduRBAdu
         elsBSdGGSbYlMiuCQNF9ij6iGjYPb2+vv700iLWnNOVi5XmGh5uFD5lJMDJPAqrjACGy
         iJUbiJ2gbsGhocIAhjxBZ/H/QyqPVX2athhrLsuQTvFpykg9ADORW004pIQ7yHinFzC2
         HzFKpDhUOQFq3bYGz7LSK0XIESGnAoqPRqOuo96UORodNFttz2IvnMQkSglUQ1yVUjpc
         HdlJRnaEpA0b8NjSDwYh+DGhnEkFxpPFIllj+4r+4aPCLC9mbQqY4ESkl453WSO5pzpy
         rSJg==
X-Gm-Message-State: AOJu0YxsijkNErqY+yOJwCXNfuLmXuWh4zZbc5lZRpg5eQPys1LGTaeH
        A1iMHaYD+EcLJAlkQsNOISWelg==
X-Google-Smtp-Source: AGHT+IHwQJyy3tTIOLcii0QzFTx0UFblIsQi/LSCVJjWL9ha9IVmDEK7kqFVshdhgyQVfYwH3WLrGQ==
X-Received: by 2002:a05:6a00:22d4:b0:687:2be1:e335 with SMTP id f20-20020a056a0022d400b006872be1e335mr3854943pfj.2.1691696658225;
        Thu, 10 Aug 2023 12:44:18 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n25-20020aa79059000000b00682a908949bsm1725479pfo.92.2023.08.10.12.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:44:17 -0700 (PDT)
In-Reply-To: <20230803042738.5937-1-parri.andrea@gmail.com>
References: <20230803042738.5937-1-parri.andrea@gmail.com>
Subject: Re: [PATCH v2] riscv,mmio: Fix readX()-to-delay() ordering
Message-Id: <169169664358.3729.13203537465035049812.b4-ty@rivosinc.com>
Date:   Thu, 10 Aug 2023 12:44:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-901c5
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Andrea Parri <parri.andrea@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Aug 2023 06:27:38 +0200, Andrea Parri wrote:
> Section 2.1 of the Platform Specification [1] states:
> 
>   Unless otherwise specified by a given I/O device, I/O devices are on
>   ordering channel 0 (i.e., they are point-to-point strongly ordered).
> 
> which is not sufficient to guarantee that a readX() by a hart completes
> before a subsequent delay() on the same hart (cf. memory-barriers.txt,
> "Kernel I/O barrier effects").
> 
> [...]

Applied, thanks!

[1/1] riscv,mmio: Fix readX()-to-delay() ordering
      https://git.kernel.org/palmer/c/4eb2eb1b4c0e

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>

