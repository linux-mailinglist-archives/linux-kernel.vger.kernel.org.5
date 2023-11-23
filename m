Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186BE7F6222
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345956AbjKWOzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbjKWOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:54:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46418A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:55:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc2b8deb23so1702255ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700751303; x=1701356103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2L9RZQCLrY6hnoGQSRaHIShkzJvXSmWVmVciwD8dPI=;
        b=ar4QBzlNYkzcOWXQuhmlEgBDYF/iHx2Cmt4RcKpNyeqS757vPEyBbhfNUw7WhN/60D
         wdBM+7+YJKxgESmQb/xSrdg/66XMrUxKrVL8F4VCDMXtuRocvuJbiqPE2Lj/t22usN3k
         7qUBbucC26s/tAIeUOOtbNmec9PcWO2ugNlodoDD760vbuxoMWhkem3sKmtDaGYImAbt
         97lg9m2NQtCEC1WXUdzZMCUS+IY3Gwt65zBPAxg9fUew93vLTrGXvd8omy1htKdC53Ew
         LB8WZFaHWWFVS5LxJnOE3umEj6OXk4MugjhnDRrqM9OD39QEmutdXu4khJE0lfxg9F2b
         Irdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751303; x=1701356103;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2L9RZQCLrY6hnoGQSRaHIShkzJvXSmWVmVciwD8dPI=;
        b=FPsHxEbCoXyd98CmkbZBdhTbDKF+uU+P9AdwLgbP/HmSjG8M+fJ8sGKIxqhN2JtaRB
         nIC4JsRBrlZm5u9SW5XsTRPGt77NfrGexr7oVcnTl8yhOGroFqTISCr1x/x+ovGHBhBy
         8wkzPvqH+IlsayR1eFYeT9NULzdcobnAtjs1WtV5aGIiN1FrFjvuRchKAeFeOcLDu4z3
         Z6Yc/QFJBOQcK/r5L91eymLxuDTRygVOk2RUDjkgEVVU1FzdUyHXwvRFvJpRN/cHWhr2
         AX/gqRQAYwg9hzMoMeTfhGh/RTiC0O22aiay8d9tg8knD/o9hwyY/9migTnoo+BuRY1K
         YRFA==
X-Gm-Message-State: AOJu0YzsBwrWpuMyFZn7lxtZzKKofG1WEcMU99W/woudiSK8THjHzg7D
        2lLZDjQUsfc4FENHT60dVhIQRA==
X-Google-Smtp-Source: AGHT+IFQYMG+AU20J3AxvuSv1xousG7ERMkfwLb9nS1M6laQRLzK1D3gA3xh7TZXiTiUPbrUtQ9S6A==
X-Received: by 2002:a17:902:e808:b0:1cf:732d:fc0d with SMTP id u8-20020a170902e80800b001cf732dfc0dmr6296045plg.1.1700751302634;
        Thu, 23 Nov 2023 06:55:02 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001acae9734c0sm1443035plg.266.2023.11.23.06.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:55:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-nvme@lists.infradead.org, Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
References: <20231122224719.4042108-1-arnd@kernel.org>
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Message-Id: <170075130149.89858.13911253468594961473.b4-ty@kernel.dk>
Date:   Thu, 23 Nov 2023 07:55:01 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2023 23:47:16 +0100, Arnd Bergmann wrote:
> There are still a couple of link failures that I tried to address
> with a previous patch. I've split up the missing bits into smaller
> patches and tried to explain the bugs in more detail.
> 
> With these applied, randconfig builds work again. Please either
> merge them or treat them as bug reports and find a different fix,
> I won't do another version.
> 
> [...]

Applied, thanks!

[1/3] nvme: target: fix nvme_keyring_id() references
      commit: d78abcbabe7e98bb4baa4dea87550806944790ed
[2/3] nvme: target: fix Kconfig select statements
      commit: 65e2a74c44ddfa174b700f5da2d1d29b4ba6639b
[3/3] nvme: tcp: fix compile-time checks for TLS mode
      commit: 0e6c4fe782e683ff55a27fbb10e9c6b5c241533b

Best regards,
-- 
Jens Axboe



