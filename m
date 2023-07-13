Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209BD7525EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjGMPBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGMPB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:01:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA18710D4;
        Thu, 13 Jul 2023 08:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E06D618B3;
        Thu, 13 Jul 2023 15:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955B5C433CA;
        Thu, 13 Jul 2023 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689260484;
        bh=hMwzdjfenrzCe8aNIV6vaSfgaTnzYR9NztGPNMqWikc=;
        h=From:To:Cc:Subject:Date:From;
        b=gYS9wL2Qwq09HRFZjN/NxnzMo/H/lxYhTckgFIJG9hIKl0KIY9ap4bAxpIShtgv8O
         XEq1b/RYz40KVrZuhP+k4N5AyNOMon1wqk7wtJ0tjrJ0EaZjHJNkeB1tJoyB3ZLiUN
         Kp5OUxkUyo5EWniB0uomh0gbpAogqdiUViJyC2kfJrL28AMNUakbTD2JyPpQ1++Sc9
         EJzHFiMBKubs9ffEdyP+efCcr47PHfUMzTgXqilg4Lh/EIzIR16DUNWjMDN/y5kiRf
         uE5o9ICu0JMrTRp6BtIcPJsGNOE0yd7wDASplqMbMa7SDq+WYk6odGytv0f4fvsuIz
         7rPAngGcc6mrQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qJxor-0007vi-07;
        Thu, 13 Jul 2023 17:01:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] PM / wakeirq: fix wake irq arming
Date:   Thu, 13 Jul 2023 16:57:38 +0200
Message-ID: <20230713145741.30390-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the Qualcomm serial-driver suspend implementation I
noticed the odd runtime PM state update which had snuck in. Turns out it
was added to work around a bug in PM core which prevented drivers not
implementing runtime PM from using dedicated wake irqs.

This series fixes the wake irq arming and drops the unused wake irq
enable helpers before dropping the bogus runtime PM state update in the
Qualcomm driver.

I suggest that Rafael takes all of these through his tree.

Johan


Johan Hovold (3):
  PM / wakeirq: fix wake irq arming
  PM / wakeirq: drop unused enable helpers
  serial: qcom-geni: drop bogus runtime pm state update

 drivers/base/power/power.h            |  1 +
 drivers/base/power/wakeirq.c          | 61 ++++-----------------------
 drivers/tty/serial/qcom_geni_serial.c |  7 ---
 include/linux/pm_wakeirq.h            | 10 -----
 4 files changed, 9 insertions(+), 70 deletions(-)

-- 
2.41.0

