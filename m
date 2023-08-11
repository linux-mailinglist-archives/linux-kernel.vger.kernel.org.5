Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA207790FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjHKNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AEED;
        Fri, 11 Aug 2023 06:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 340F564DB0;
        Fri, 11 Aug 2023 13:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA918C433C7;
        Fri, 11 Aug 2023 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691761555;
        bh=PrLAN+PGrV3ZLZn47Uvte1I9dCtyNavw8JBu8sftjNk=;
        h=From:To:Cc:Subject:Date:From;
        b=adDQjMQ4bDeU4DvWR3BNNYReZyacWrVEGHAOf1NpTtZYkICZo0mW2CLacA4z52QWV
         u5ia/HrShnKJNvbsOOFedZQyFxju+oXGLOo7B1ejbIxqYBCawXfyqg9hRIMkiG+K6P
         +RcwcbJquhdUDfxhPGd0lUkGPeVIk/C/9/waNI5HQVJTZYYJGvqDJd/dpDLZTW7UIS
         TZdDJn3WWFq/BFlbRnmjZTr6R3pKDxuhGmvfTC6pwogHRiiVhCqI5A6NAjCksvGi1V
         xd4nUp6GRvddc+Pg8ZJs5K8H8YW1PWhOzJJtuEMQjVi7SJX3hR7sCSqFfnCfLYZrxu
         pXoQ4zdSbb+Dg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] bus: mhi: host: remove unused-but-set parameter
Date:   Fri, 11 Aug 2023 15:45:41 +0200
Message-Id: <20230811134547.3231160-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang warns about a parameter that is decremented but never evaluated heere:

bus/mhi/host/main.c:803:13: error: parameter 'event_quota' set but not used [-Werror,-Wunused-but-set-parameter]
                             u32 event_quota)

Remove the access to the variable to avoid that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bus/mhi/host/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 74a75439c7130..dcf627b36e829 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -938,7 +938,6 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 				if (!mhi_chan->configured)
 					break;
 				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
-				event_quota--;
 			}
 			break;
 		default:
-- 
2.39.2

