Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6C78C442
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjH2MaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjH2M3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:29:36 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97914A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:29:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdca7cc28dso34432665ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693312173; x=1693916973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a8bCRf85vT2T3nuNmNFbFtWzJQK+a8A+XqepNxDEiGM=;
        b=jxG+CTfSa8OPZYJjnmwWh20KleW6+Uk8SCqmYuNjByhcxVCOnj7HDnqZbvZoelPp4y
         Hxb4EODeqG96zSejKKGi/bAZTOrFEyrk41RIGQ1m3Wg/gKaKjzLA0Zh5ZaZsjzbj8f+n
         Mmk6phkD0KoCpc5IVQLkDnNFstW2Q1uz/oUNyeUW3xRcYOS1svo5KpsElHEsNTcHAKVw
         LvVMJN7PxOWGOFVKwcc9DoS/LYYgospdJhAEYVmyIZdaXRkL6qNkJHiHNu49fQqI5uZS
         Q0G01rneJ9LF6njD1wwrsV+rqW0RTxtkBJq3Go6/cxzknoHDByj4OvArULMTBNz0pZ+o
         o58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693312173; x=1693916973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8bCRf85vT2T3nuNmNFbFtWzJQK+a8A+XqepNxDEiGM=;
        b=Dg9KR4ScKZGDdLo+JG8jOCs1PTigkYNiGawOMd+oIGSNS9V58ICSHAutUdrwILXLw3
         zxpKTbsQCsHp9AmxjwwgsQ/87+8SR5GqIStjqhvHNYIpIjdX/zZ6Hk7MpX8RfyEx+iI8
         silsl3fIIYVmQih6v7FVkgKaDG5xqPMFp2Vro89QvKl80ExZS4tyDxjj7d1PNd6ulZk0
         jsaMUiu78p2MUp1UFo04nwLwGtN5BvOBihIcUeMN4CkfjKNshRHnLjOB1Gqmblp2vfq+
         N/1ekovgDfQn/JSnsKxmKUdw0Fd9nm9xZJfYgj88JNk+lNOCNP555Xb0r1RT9qzGWKGa
         SOvw==
X-Gm-Message-State: AOJu0Yx04xKS8VwgwZaQ5UlL2pxFy9EyodaLoZVxqxhUl1nT9+68mwP+
        cAsbxBdQrwhxCjrOCeoLcqN9OQ==
X-Google-Smtp-Source: AGHT+IFj8Mbp9xBFjeOn69lgOEFyDk+KCIk0EkFVH95JvNRVdOnz7az8b9wKq9djZKmXzDrEULiLqQ==
X-Received: by 2002:a17:902:d342:b0:1bf:6ad7:228b with SMTP id l2-20020a170902d34200b001bf6ad7228bmr28303356plk.8.1693312173031;
        Tue, 29 Aug 2023 05:29:33 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001bdc8a5e96csm9260099plg.169.2023.08.29.05.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:29:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH 0/2] xen: privcmd: Add ioeventfd support
Date:   Tue, 29 Aug 2023 17:59:03 +0530
Message-Id: <cover.1693311370.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Now that irqfd support (backend to guest interrupt) is already merged, this
series solves the other part of the problem, i.e. ioeventfd (guest to backend
interrupt).

More details inside the commits.

--
Viresh

Viresh Kumar (2):
  xen: evtchn: Allow shared registration of IRQ handers
  xen: privcmd: Add support for ioeventfd

 drivers/xen/Kconfig               |   8 +-
 drivers/xen/events/events_base.c  |   1 +
 drivers/xen/evtchn.c              |   2 +-
 drivers/xen/privcmd.c             | 385 +++++++++++++++++++++++++++++-
 include/uapi/xen/privcmd.h        |  18 ++
 include/xen/interface/hvm/ioreq.h |  51 ++++
 6 files changed, 458 insertions(+), 7 deletions(-)
 create mode 100644 include/xen/interface/hvm/ioreq.h

-- 
2.31.1.272.g89b43f80a514

