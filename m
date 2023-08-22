Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C08783DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjHVKNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjHVKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:13:03 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3E7CED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:12:45 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7a01d654111so1433954241.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692699165; x=1693303965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VdZpkYqMZd8jYgQ8zt+isMWg0vXbOV3HajplaszoCmg=;
        b=RzYmvDvGKPT0jr2gAtZoNfiwKJFimQorxyD/r/qaSEBwCVXwXhebHPJDb36M72j4dg
         3DCQix8gzOrPlqTghYZMD3S/jk/PjrP/82r9kDhECyi8moIfmvlW4dXk6uPXL0ULwhLi
         NTf0eyW0BcUrvBTYgikeyqyvNhaZ09qKZaZYp4E5iIqCQthV36EFwagupRDVpBvysuCd
         qKxmOdR+outGtv3/OCnKPmzbufHE0IwFX/QGR2xi6eIwvi19M0Q9eyv/uXEBdCsNugPH
         Y39EEHF+Rj6xCBO+WqNiwvBBFKFBevmX3u/MzJqV8I7CxFHj0SO8TeglnO1s2eK/6ONZ
         BAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692699165; x=1693303965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdZpkYqMZd8jYgQ8zt+isMWg0vXbOV3HajplaszoCmg=;
        b=USjwXDnhnK/ziDIRN+xUsO+JqNHEHnd3V83QyAeC3UAeKHEYXlt6ix27h/M2Idj5uz
         JKpa3rI3GshNiFXK42Ej+VaPyplQV5XTGsO+8mlipY0+yk8+EtY4QLqoq6BIYN8Mbe+P
         pBCzcrlz09NNqaOiWx5CghNgM8TVPz6/HKQMF34Dq/g8Y5xucsT6fWaA4PIqwvg4X7E3
         W9r+l1ioKUVbd8w7DrK8Iw/scwkWr07I33AwhiLYKHG2KXiQ5eIXoGj8/f3AEXwNFssi
         MpXlZblfS+9pqJg3t4c/+25DeylcYzutB+V1ldej1eZ6cqTUe6KV1FB/K12ksQjKG0Gj
         A+vQ==
X-Gm-Message-State: AOJu0Yz0CPe9jaJ64/3/VxziveLDkPW1eSSNZPnPinRkRgsHLmxYAFKd
        pCddLqfwB+UdaXMhnFqqGUKRvA==
X-Google-Smtp-Source: AGHT+IFL4KGEbDTuSflTu82ubRx/NN7LM0n9QHtg5wJftK+dznd4x4/UNEZ1TPlulMd1eRJ+ymJcQw==
X-Received: by 2002:a67:fbcb:0:b0:44d:547d:4607 with SMTP id o11-20020a67fbcb000000b0044d547d4607mr2903528vsr.35.1692699164898;
        Tue, 22 Aug 2023 03:12:44 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id u16-20020a0cb410000000b0063d588c4111sm3705734qve.82.2023.08.22.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 03:12:44 -0700 (PDT)
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
Date:   Tue, 22 Aug 2023 06:12:31 -0400
Message-Id: <20230822101231.74388-1-jhs@mojatatu.com>
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
v2->v3 changes:
- dont break else/if (Simon)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/20230816225759.g25x76kmgzya2gei@skbuf/T/
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_api.c | 53 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index aa6b1fe65151..e9eaf637220e 100644
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
@@ -1644,27 +1662,35 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
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
+					else if (req_change(n))
+						goto create_n_graft2;
+				}
 			}
 		}
 	} else {
@@ -1698,6 +1724,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		NL_SET_ERR_MSG(extack, "Qdisc not found. To create specify NLM_F_CREATE flag");
 		return -ENOENT;
 	}
+create_n_graft2:
 	if (clid == TC_H_INGRESS) {
 		if (dev_ingress_queue(dev)) {
 			q = qdisc_create(dev, dev_ingress_queue(dev),
-- 
2.34.1

