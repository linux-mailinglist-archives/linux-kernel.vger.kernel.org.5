Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F8378313D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHUTN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjHUTN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:13:28 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7684312A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:13:26 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-570e88ee36aso405413eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692645205; x=1693250005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7EstROD8uz4uXiA68mQeo6YsgbGEyVjJFFa0L6CFnaU=;
        b=WeNU4B2leSXZINpoiOYo8M+EyED7N1MfX5Y+vkoESrlM1nFR+RD5C0wdRitIhYzCST
         mc8DnukMp2pUkdRPrfo30/q8Db1GkkNvZlLNy2MwXMnHOPm8oZQsCtGYyVgf4Hrfmyz3
         GDhuYnYZF+12GwzeItkqKtDvEtWkKSQmpph81Jii/DyESm6res8fpXp1AZdT7L7EWEMH
         eCczWuQXVZjiPgbWdA51sHdklKVT3LYzvF6lWOBNNzS0t5cCoTSSInaoSVqYUeMDCB4p
         s+rH4e9WzUirWp3bG+gP/TkIXClFmkJlh0GpVSV3FJMwllGChhEUU4cuyWrT03OdXdIs
         jNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692645205; x=1693250005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EstROD8uz4uXiA68mQeo6YsgbGEyVjJFFa0L6CFnaU=;
        b=abxpFy9L9qTgGZ5gNdQ5xMd6sDmHUHhxSbH+ck2dK1WJa2Newqg8R432O5pfRkkZ+t
         XIUyr3onTXlIGy8BKwpzPdZ15qtSu6eMziLz0frsGTndec4vn2KSFVzLoxQIFid9BhG7
         EK8hdPcx96lcm7zdLW6QUbp/wS+yVRlLavSnKa6iS+yd47KNjZrVJTSf4yYqBqjZO+5u
         C1LSFAhGp1OTUi1oCVCVxKpRhRqwGVPg8rvlqEvlmnLkHYUBU4usdzfa4g050uiQOSoR
         Ly5NXh3Yzx6xMyqjuWmabbTdONtIvKuhmt5ZftdntWhj7icusxRcSILptY4zs0c0vcc7
         igJw==
X-Gm-Message-State: AOJu0Yx8JUYKfB4SiyYAutezRiO74sUzTtAG9DqNtD/Yf/OCcr+A0+b0
        ItaIITvsDOt6Gg7Xb4naEEa58A==
X-Google-Smtp-Source: AGHT+IEIpzubud6XDJgv1HqN7u4ViOWnVR9zgI1WOqzLodQnTZjuSlUIlftwEu67GCUftVFHsrV8qQ==
X-Received: by 2002:a05:6358:98a9:b0:139:be3d:d047 with SMTP id q41-20020a05635898a900b00139be3dd047mr5662531rwa.17.1692645205677;
        Mon, 21 Aug 2023 12:13:25 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id ih14-20020a05622a6a8e00b00400a99b8b38sm2482011qtb.78.2023.08.21.12.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 12:13:25 -0700 (PDT)
From:   Jamal Hadi Salim <jhs@mojatatu.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        shaozhengchao@huawei.com,
        syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net v2 1/1] net/sched: fix a qdisc modification with ambiguous command request
Date:   Mon, 21 Aug 2023 15:13:05 -0400
Message-Id: <20230821191305.68275-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When replacing an existing root qdisc, with one that is of the same kind, the
request boils down to essentially a parameterization change  i.e not one that
requires allocation and grafting of a new qdisc. syzbot was able to create a
scenario which resulted in a taprio qdisc replacing an existing taprio qdisc
with a combination of NLM_F_CREATE, NLM_F_REPLACE and NLM_F_EXCL leading to
create and graft scenario.
The fix ensures that only when the qdisc kinds are different that we should
allow a create and graft, otherwise it goes into the "change" codepath.

While at it, fix the code and comments to improve readability.

While syzbot was able to create the issue, it did not zone on the root cause.
Analysis from Vladimir Oltean <vladimir.oltean@nxp.com> helped narrow it down.

v1->V2 changes:
- remove "inline" function definition (Vladmir)
- remove extrenous braces in branches (Vladmir)
- change inline function names (Pedro)
- Run tdc tests (Victor)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/20230816225759.g25x76kmgzya2gei@skbuf/T/
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_api.c | 54 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index aa6b1fe65151..4c51b8bef1b8 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1547,10 +1547,28 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+static bool req_create_or_replace(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_REPLACE);
+}
+
+static bool req_create_exclusive(struct nlmsghdr *n)
+{
+	return (n->nlmsg_flags & NLM_F_CREATE &&
+		n->nlmsg_flags & NLM_F_EXCL);
+}
+
+static bool req_change(struct nlmsghdr *n)
+{
+	return (!(n->nlmsg_flags & NLM_F_CREATE) &&
+		!(n->nlmsg_flags & NLM_F_REPLACE) &&
+		!(n->nlmsg_flags & NLM_F_EXCL));
+}
+
 /*
  * Create/change qdisc.
  */
-
 static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			   struct netlink_ext_ack *extack)
 {
@@ -1644,27 +1662,36 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				 *
 				 *   We know, that some child q is already
 				 *   attached to this parent and have choice:
-				 *   either to change it or to create/graft new one.
+				 *   1) change it or 2) create/graft new one.
+				 *   If the requested qdisc kind is different
+				 *   than the existing one, then we choose graft.
+				 *   If they are the same then this is "change"
+				 *   operation - just let it fallthrough..
 				 *
 				 *   1. We are allowed to create/graft only
-				 *   if CREATE and REPLACE flags are set.
+				 *   if the request is explicitly stating
+				 *   "please create if it doesn't exist".
 				 *
-				 *   2. If EXCL is set, requestor wanted to say,
-				 *   that qdisc tcm_handle is not expected
+				 *   2. If the request is to exclusive create
+				 *   then the qdisc tcm_handle is not expected
 				 *   to exist, so that we choose create/graft too.
 				 *
 				 *   3. The last case is when no flags are set.
+				 *   This will happen when for example tc
+				 *   utility issues a "change" command.
 				 *   Alas, it is sort of hole in API, we
 				 *   cannot decide what to do unambiguously.
-				 *   For now we select create/graft, if
-				 *   user gave KIND, which does not match existing.
+				 *   For now we select create/graft.
 				 */
-				if ((n->nlmsg_flags & NLM_F_CREATE) &&
-				    (n->nlmsg_flags & NLM_F_REPLACE) &&
-				    ((n->nlmsg_flags & NLM_F_EXCL) ||
-				     (tca[TCA_KIND] &&
-				      nla_strcmp(tca[TCA_KIND], q->ops->id))))
-					goto create_n_graft;
+				if (tca[TCA_KIND] &&
+				    nla_strcmp(tca[TCA_KIND], q->ops->id)) {
+					if (req_create_or_replace(n) ||
+					    req_create_exclusive(n))
+						goto create_n_graft;
+					else
+						if (req_change(n))
+							goto create_n_graft2;
+				}
 			}
 		}
 	} else {
@@ -1698,6 +1725,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		NL_SET_ERR_MSG(extack, "Qdisc not found. To create specify NLM_F_CREATE flag");
 		return -ENOENT;
 	}
+create_n_graft2:
 	if (clid == TC_H_INGRESS) {
 		if (dev_ingress_queue(dev)) {
 			q = qdisc_create(dev, dev_ingress_queue(dev),
-- 
2.34.1

