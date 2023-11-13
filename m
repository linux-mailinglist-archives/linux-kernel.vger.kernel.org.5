Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB7F7EA6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjKMXRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjKMXRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:17:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAA61702;
        Mon, 13 Nov 2023 15:17:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523BFC433C9;
        Mon, 13 Nov 2023 23:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699917422;
        bh=W0b3gyn44KcNCBO6UUaZ6j/sKJtPmQfYULhtG6WJYqo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nb/M7yWVUm1sNmkoRbJKG/C+OzPukvvt+bk50xwnwG3hAxNEPIX3qHpd//mulyEEC
         2pschryKCij7vGHecHbFBxMR4akdqQrO+muyh0ldD0Qxn+sO4GfGa9dOoJxOthMV9Z
         znRGqDrWBe0NZuFBWxZN4oVmyY87T3BvZ7sI5I6beW4f3d6ijxbQK1rzv/EoUkQtyz
         eOZ+X22Z2GCYoIJ0RTM6jjKqIv3okl2yw0JE7K5DJXTh7bjjGtCSbJ12xoF/dLgyFv
         B5snkAKLsuWpVgQDu+SKPRVbxToyB9eVd3BWlRssZgBMyHWxxikTMYuksoy4on83sU
         D757dO9dyhlhw==
From:   Matthieu Baerts <matttbe@kernel.org>
Date:   Tue, 14 Nov 2023 00:16:16 +0100
Subject: [PATCH net 4/5] mptcp: fix setsockopt(IP_TOS) subflow locking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-4-7b9cd6a7b7f4@kernel.org>
References: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
In-Reply-To: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-0-7b9cd6a7b7f4@kernel.org>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Poorva Sonparote <psonparo@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pGUcGEjXJfFkLWEJhM/HAjyXejyxjQ+RM/5QKnxNKLo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlUq5aSKHTJBWyN67lqxuWcs30vPDduo09h2qxF
 iS1s9AGWJOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZVKuWgAKCRD2t4JPQmmg
 c0n6D/9EtGTPQOu6+y+C+gD0tZW1tXp+SwlDwByKowUFh9faPZJKImn6tNpf1WF7mBHFNkmskoi
 nfHH6DzgCev+0xD/Dgytfz/b0nOSoLc46Bg59GySj9YBU3cuMshs8X3YQsWN8WoMEwZrMMHZSL5
 rX50bjvbZUHsfJpniwbS419CtzHwO1fSz4i9JuSQObSuRRe6zmYXWgrWGFVbVx7Zw+2h5hK1cTy
 GAL1fqI5E1oFmGfymAtW6zU4XOolSMUbxNOKGv27bLhKMB8Ifb5v4mhcBG6PbszA7Ju+bcpQ/v4
 tBPwvptoSPQTC0+s0LgfeXkexwQPMxUnWXVPVIhbc3QyFKZBi4ELBJVcg1SMn3AwG+ZvEhJiRxQ
 UOXd3+r0Hbyq5cILSrtJDdFnwJkkn7suxvYt0zSI0JUntO31po3qof9HO7LCsWlIgxk8Ywz7Itz
 CS5sYwemEcT3fVxirExCrHsMRf+hCj+9FB7qimQqy8ACYawckRLxOcd6E31s2d/3QS4ZcVrk+pj
 QwK+QcSIz1jNrjj4jcCrXpBXY46qs771Qob/jz5tGkVn0w5rtQM0LzVR9h8sLvOZObnK51PNVt9
 LI3FQH8SAf8waY/hTWnoy4AZBfZAOOtFtMpc0s4/nffEaeSSdyjHdYxFH5ttfjCZafxRyxpIQCi
 zs6yIRsZaIbJd/Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP implementation of the IP_TOS socket option uses the lockless
variant of the TOS manipulation helper and does not hold such lock at
the helper invocation time.

Add the required locking.

Fixes: ffcacff87cd6 ("mptcp: Support for IP_TOS for MPTCP setsockopt()")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/457
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 77f5e8932abf..353680733700 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -738,8 +738,11 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	val = READ_ONCE(inet_sk(sk)->tos);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
 
+		slow = lock_sock_fast(ssk);
 		__ip_sock_set_tos(ssk, val);
+		unlock_sock_fast(ssk, slow);
 	}
 	release_sock(sk);
 

-- 
2.40.1

