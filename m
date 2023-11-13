Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F357EA6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjKMXRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjKMXRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:17:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4621729;
        Mon, 13 Nov 2023 15:16:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6682EC433AB;
        Mon, 13 Nov 2023 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699917418;
        bh=6NjuMMfupABGOprM2E0ZdnQVNhlyr/LPmz4PlYvGCTc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HC7HNDCcy5FHfuZzRQGhnvg1b7giJxLSyvVUv6vL/nLouZlkcd2kcIUiWw5sEHcW2
         c3SZpked9FZlIJByQH7LiT5VqRKstbTuVa0q99QJjOL2acUcLGw3EnhPWxnE0k6vzN
         c7mNnRRdDvDpMwySXdYbVnb5fCzXnZ9ZtESY6Z3HzTZkXcWSWKlvuzJKaTkzIywdyQ
         yypjOiuqOw9Ov0FZBnlFVYStT6CltQ0KpbNpKZBSOV+C2x2n5voyaaB6XO4gm6ISfL
         N7Z5DRbK0jDYpZmatXq1fsD5fLF7KL74o4tCcMnv1wzLSjfJ899G+b9fxprt4VEvnC
         objWKes5MwC6Q==
From:   Matthieu Baerts <matttbe@kernel.org>
Date:   Tue, 14 Nov 2023 00:16:15 +0100
Subject: [PATCH net 3/5] mptcp: add validity check for sending RM_ADDR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-upstream-net-20231113-mptcp-misc-fixes-6-7-rc2-v1-3-7b9cd6a7b7f4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=De6XueuAtSX4KlkXPDBKo4EbKmfgtMyfgEamAykmwTo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlUq5aj1GKYa5rYyWGNMRIArHYv1uqvRXCYxJ8m
 bGU4Tz4AXeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZVKuWgAKCRD2t4JPQmmg
 c9A1D/9BunX1yiZIGndUkzDF+IhU6xLrvv3v1GoZFnmZpv463cDEqV+c42hHDi8CHBsXCq/pbc/
 OpKxNAGhp9DOGyAHZIsE9gH9SYDvsgoDtBtiKdQpNZVaJ4XDzAQ4Gt+r2CKHWRN80wgJSnNRUae
 Ucgds34h46cZMmg8VyaRNAtQud1sWnNRLPrdUpfoSN39aQgPXSmkuYSNoY1VY9krPIHwf3Pry6B
 8tg6HG4gIQCx/WHhUI3gxc0ramKniKa+NuSlAcuYpdcOYqMSP7mujp0Y28wcZf12UCOfFR/wGq+
 MaEfOfOvRi5oGy2Cqc4tcMMZ4mOF5bRecyNU7WplDRHec6z2oL9I0Sx/MP8fUk0pz9STCpu5mAw
 LZaUBDtDz37p49hmfLdLGbNtKKIswWOCZe//hvW4pXXUU5AASNm5SFSNA2UZYryUNMFjispNAdB
 IMfYM/0Z4wPyCl5hKsL28SvRFBxwaR9zSFtRLpgPGPFanuvPGpZAWa9Ecj4pU80RXZ4TH6Prnon
 QnbipvsqtnbUWY5MtlprzzSZjwEDlQbf2I5U5vCZbarEoelVh8ZhzKi2ftmUR+/1NciWYJfZlB7
 aiz4YSvCVA7QT3xXiQ/DzVntFiXuyKjykMYH6W5Ve7h9dNH3D+FjmMKWf+azVEe1TyP7QCxbBpe
 p+3kIxCkw3RMt4A==
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

From: Geliang Tang <geliang.tang@suse.com>

This patch adds the validity check for sending RM_ADDRs for userspace PM
in mptcp_pm_remove_addrs(), only send a RM_ADDR when the address is in the
anno_list or conn_list.

Fixes: 8b1c94da1e48 ("mptcp: only send RM_ADDR in nl_cmd_remove")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1529ec358815..bf4d96f6f99a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1515,8 +1515,9 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		remove_anno_list_by_saddr(msk, &entry->addr);
-		if (alist.nr < MPTCP_RM_IDS_MAX)
+		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
+		     lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) &&
+		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 

-- 
2.40.1

