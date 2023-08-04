Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B7C770543
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjHDPw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHDPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD18C170F;
        Fri,  4 Aug 2023 08:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 516CA62083;
        Fri,  4 Aug 2023 15:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1E7C433C7;
        Fri,  4 Aug 2023 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691164344;
        bh=FdnqWNnt/KLue5iwoRINTU7dPEeEYzcdppDVtVSWJUc=;
        h=From:To:Cc:Subject:Date:From;
        b=iZ3e9X50J5OpfLFGQmS8Bczskw/enFW3kQ7KGJSzFIuW5IkrI+a++vZS1hSmCiH8g
         2dpUf2si0kgIz7ZwFbI+EzhMA4UC5WfHbj0vqyW6jEMfr7f7tXFhZr+CvCnb4disRt
         5kWYWTpwR4+nAoq8GEmG9W0wT1NgT1f5+wA1QUARcpKA9lWGsX5YARkR8jCeK0hECh
         BUi6h7CQ1oxhEDSP3mq/n8jlmnmGVNdPMvYB1lu1XB4bJd4LCRi214Eb116VaIap3P
         5+CeJJzPBcZ5+nMikcIyOcrivul3XWCdh/Op6W8AUGvQ59ix9o8WELAmX20GpgKXSR
         wZibxBUdo3Umw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] rtla fixes for 6.5
Date:   Fri,  4 Aug 2023 17:52:10 +0200
Message-Id: <cover.1691162043.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some fixes for rtla timerlat auto-analysis.

The first one zeroes the variable that accounts for the amount of
thread interference when a new cycle begins.

The second fixes an imprecision on the IRQ delay account when
the value is near 0.

The last one fixes the case when an IRQ interference for the
next activation is considered for the previous one.


Daniel Bristot de Oliveira (3):
  rtla/timerlat_aa: Zero thread sum after every sample analysis
  rtla/timerlat_aa: Fix negative irq delay
  rtla/timerlat_aa: Fix previous IRQ delay for IRQs that happens after
    thread sample

 tools/tracing/rtla/src/timerlat_aa.c | 32 ++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.38.1

