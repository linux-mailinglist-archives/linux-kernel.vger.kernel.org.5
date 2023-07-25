Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A915B762477
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGYVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjGYVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2711FDD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690320602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eI0IPJDYPNrVyX0XGlXeCaRs7mSlaEbPza1/eXegfXE=;
        b=boc96nmbkFc/9hziR7sX7IXXg2xGgTW+XC67V4u92RQ4aqGbdSyaHSk5OmkEIcJis5WF5O
        cu4bN6wmcl7Su4FOUhIRQ8DfAizfGVExHl3SXc8BnU7mMuLCg20/Kyr3BSvDyMqapVO+7J
        OHqhiE7b9x/Y98KqUH/hG1yOR/ixHSM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-M39sG54PMTCxhAaKf_7n-g-1; Tue, 25 Jul 2023 17:30:00 -0400
X-MC-Unique: M39sG54PMTCxhAaKf_7n-g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76ad8892d5dso594433785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320600; x=1690925400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eI0IPJDYPNrVyX0XGlXeCaRs7mSlaEbPza1/eXegfXE=;
        b=U7clMv+2RkFymZowoJRoQ9B8ZJU0qUbV/dILtdmXIEpQwjavvQ/4X0l16wGLKghh4u
         QZ6DO5Pp5afZ2YeUoJfEHhc1UMGE2XB4G7wxJRhX8nXGbFWcTnw0Z/KEdf4UHrLY7PZf
         xtIeg5sliHJ54DZ8hnSEs4pWuImgre6LK9MEzsvgj8u4aG9MmufIbaI9CTvXEqa/w6MI
         mhqlPwLCP9oSNSXdNMqf4d9yAbn8JatBfl+SG+kt04wcqjo244Q2Q7vr2kkyMdad6Um0
         kg2WYf2EVOxLNxVQTfVyIJHzBhngqwaatyk4mXelkazJtIhAYOiqVzMHQswOYvkzBYZy
         iwwQ==
X-Gm-Message-State: ABy/qLb6j4aAwSctksNWdGUvTl4K0/VqYacNfh90JB4BdMMse/J2qHgh
        lwwyX7bYTLwhhqs0Eg3aTplmLF6YQJ5QQRo1uhtS3LOl/x+CbKsDqSUiC12Mr7GpEZnHUUJG6nV
        8m6V8mShhlIX/JSR140Uc+c/WeVlUlnaMnx10IAhxleUfkupMMrpkHuVQYf8QAHoHkGKClHY1X0
        +kL2S2hDEw
X-Received: by 2002:a05:620a:f05:b0:767:1241:54b5 with SMTP id v5-20020a05620a0f0500b00767124154b5mr181014qkl.1.1690320600198;
        Tue, 25 Jul 2023 14:30:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF24tMAjJjYlaklb00gjuYXYzEgTXG7QQEk+fVvTcFB3Y0hqtiYP0Qq5YM3YPRmvMFNY0tH+g==
X-Received: by 2002:a05:620a:f05:b0:767:1241:54b5 with SMTP id v5-20020a05620a0f0500b00767124154b5mr180977qkl.1.1690320599711;
        Tue, 25 Jul 2023 14:29:59 -0700 (PDT)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id j3-20020a37c243000000b00767d7307490sm3943067qkm.34.2023.07.25.14.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:29:59 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     ahalaney@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, jsuraj@qti.qualcomm.com
Subject: [PATCH net-next v2 0/2] net: stmmac: Increase clk_ptp_ref rate
Date:   Tue, 25 Jul 2023 16:04:24 -0500
Message-ID: <20230725211853.895832-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to increase the clk_ptp_ref rate to get the best
possible PTP timestamping resolution possible. Some modified disclosure
about my development/testing process from the RFC/RFT v1 follows.

Disclosure: I don't know much about PTP beyond what you can google in an
afternoon, don't have access to documentation about the stmmac IP,
and have only tested that (based on code comments and git commit
history) the programming of the subsecond register (and the clock rate)
makes more sense with these changes. Qualcomm has tested a similar
change offlist, verifying PTP more formally as I understand it.

The last version was an RFC/RFT, but I didn't get a lot of confirmation
that doing patch 3 in that series (essentially setting clk_ptp_ref to
whatever its max value is) for the whole stmmac ecosystem was a safe
idea. So I am erring on the side of caution and doing this for the
Qualcomm platform only. See v1 for an approach that would apply to
all stmmac platform drivers with clk_ptp_ref.

v1: https://lore.kernel.org/netdev/20230711205732.364954-1-ahalaney@redhat.com/
Changes since v1:
    - Collected Reviewed-by tags (Simon)
    - Dropped RFC/RFT, dropped patch 3 that implemented this rate
      change at a stmmac platform level

Andrew Halaney (2):
  net: stmmac: Make ptp_clk_freq_config variable type explicit
  net: stmmac: dwmac-qcom-ethqos: Use max frequency for clk_ptp_ref

 .../net/ethernet/stmicro/stmmac/dwmac-intel.c  |  3 +--
 .../stmicro/stmmac/dwmac-qcom-ethqos.c         | 18 ++++++++++++++++++
 include/linux/stmmac.h                         |  4 +++-
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.41.0

