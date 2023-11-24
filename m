Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E77F6CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbjKXHbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjKXHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:31:35 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3401B10C9;
        Thu, 23 Nov 2023 23:31:39 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso1310354b3a.1;
        Thu, 23 Nov 2023 23:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700811099; x=1701415899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFxWesjSbh6aPkk26uaeIMhL8HRb0v8T1NPm7HDO0SQ=;
        b=M0yqrWDI8f1O2KvxkcEuoKyPmoubsykQZaBUPqOq+jVbKCuoz8K4cdd4R/+kOV19El
         BBw2E6m09mIc4fG7/nQDJMtT5bDeRB8JFR13c9OPmEmyV5GmZEic/X0NPa98U+tqBkUd
         kX0uDS+HAqG41upl51ZAGt8vsLDW0KgK67wLqZH+/ZLORo/Jkp8FgWlNog6l2dv1OM27
         tqw81Wr+UIU7eXaWwHqfXmwC2TUW1AUKngzLTJe/kpEEyIdvQzN7QndXbb0LGF+qcSXn
         m/yFM1uV4Xb+7bOTmPoUgSmwelVBlTUfo9jBPGBBF8YtvirrLXOKi3rYxelEfkgu/vu4
         VviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700811099; x=1701415899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFxWesjSbh6aPkk26uaeIMhL8HRb0v8T1NPm7HDO0SQ=;
        b=kh7rQFJDaqqf97hdmx4W/OHzrfxQMitil7C+VnUD8xo9umMynrTZ+M32HnolFuknXc
         m1CH4O4mXI4unuoOikPrCEyqo/Zu8q/F9ndyj3Z9hJ1witk9BVQOf/GKiEobLoolRypa
         pwwXGgJEDkROcOmVEk2IRfy8fE412f5FJy/ue/cGuO+XJQ556cGaE965JvU+rnZejyFV
         uS72rO5VoMfakQGb6l9kMf8ZFrqTHXUHCBGDwDswGdka2iR0C0EnFPx1A2vU0cquM665
         Ajb6KApcHUCMpSIzt56zllmE+7iUdP7jQNycXmSSGM26E8T8o6fkDZCqaIaEPwdwi5/9
         pfkg==
X-Gm-Message-State: AOJu0YwLe/d+vEGUQ4JNeVXxe576g8ieDx+SBfXyvXH7KPhrc+urEQuN
        KuOnD6DaWHUafgnSf4hly90=
X-Google-Smtp-Source: AGHT+IEUuxk6O9HR7RzPpWMcDtGQiK9lwkln1/Lk6avSdkpxqUoxV4w6/tPI87i/RCTAESAQaa46lw==
X-Received: by 2002:a05:6a20:3c8b:b0:187:fbe3:b4d7 with SMTP id b11-20020a056a203c8b00b00187fbe3b4d7mr2227736pzj.9.1700811099268;
        Thu, 23 Nov 2023 23:31:39 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s23-20020aa78d57000000b006cbb18865a7sm2279388pfe.154.2023.11.23.23.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:31:38 -0800 (PST)
From:   xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To:     tung.q.nguyen@dektech.com.au
Cc:     davem@davemloft.net, jmaloy@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
        ying.xue@windriver.com, zhang.yunkai@zte.com.cn
Subject: RE: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in tipc_rcv
Date:   Fri, 24 Nov 2023 07:31:34 +0000
Message-Id: <20231124073134.2043605-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DB9PR05MB9078EEC976944CACEC531C1388B9A@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <DB9PR05MB9078EEC976944CACEC531C1388B9A@DB9PR05MB9078.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>Happy to see your reply. But Why? 'delete' is false from tipc_node_timeout(). Refer to:
>>https://elixir.bootlin.com/linux/v6.7-rc2/source/net/tipc/node.c#L844
>I should have explained it clearly:
>1/ link status must be protected.
>tipc_node_timeout()
>   tipc_node_link_down()
>   {
>      struct tipc_link *l = le->link;
>   
>      ...
>     __tipc_node_link_down(); <-- link status is referred. 
>      ...
>     if (delete) {
>        kfree(l);
>        le->link = NULL;
>     }
>     ...
>   }
>
>__tipc_node_link_down()
>{
>    ...
>   if (!l || tipc_link_is_reset(l)) <-- read link status
>    ...
>    tipc_link_reset(l); <--- this function will reset all things related to link.
>}
>
>2/ le->link must be protected.
>bearer_disable()
>{
>   ...
>   tipc_node_delete_links(net, bearer_id); <--- this will delete all links.
>   ...
>}
>
>tipc_node_delete_links()
>{
>   ...
>  tipc_node_link_down(n, bearer_id, true);
>   ...
>}

Could we please solve the problem mentioned above by adding spinlock(&le->lock)?

For example:

(BTW, I have tested it, with this change, enabling RPS based on tipc port can improve 25% of general throughput)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 3105abe97bb9..470c272d798e 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1079,12 +1079,16 @@ static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool delete)
                __tipc_node_link_down(n, &bearer_id, &xmitq, &maddr);
        } else {
                /* Defuse pending tipc_node_link_up() */
+               spin_lock_bh(&le->lock);
                tipc_link_reset(l);
+               spin_unlock_bh(&le->lock);
                tipc_link_fsm_evt(l, LINK_RESET_EVT);
        }
        if (delete) {
+               spin_lock_bh(&le->lock);
                kfree(l);
                le->link = NULL;
+               spin_unlock_bh(&le->lock);
                n->link_cnt--;
        }
        trace_tipc_node_link_down(n, true, "node link down or deleted!");
@@ -2154,14 +2158,15 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
        /* Receive packet directly if conditions permit */
        tipc_node_read_lock(n);
        if (likely((n->state == SELF_UP_PEER_UP) && (usr != TUNNEL_PROTOCOL))) {
+               tipc_node_read_unlock(n);
                spin_lock_bh(&le->lock);
                if (le->link) {
                        rc = tipc_link_rcv(le->link, skb, &xmitq);
                        skb = NULL;
                }
                spin_unlock_bh(&le->lock);
-       }
-       tipc_node_read_unlock(n);
+       } else
+               tipc_node_read_unlock(n);
 
        /* Check/update node state before receiving */
        if (unlikely(skb)) {
@@ -2169,12 +2174,13 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
                        goto out_node_put;
                tipc_node_write_lock(n);
                if (tipc_node_check_state(n, skb, bearer_id, &xmitq)) {
+                       tipc_node_write_unlock(n);
                        if (le->link) {
                                rc = tipc_link_rcv(le->link, skb, &xmitq);
                                skb = NULL;
                        }
-               }
-               tipc_node_write_unlock(n);
+               } else
+                       tipc_node_write_unlock(n);
        }
 
        if (unlikely(rc & TIPC_LINK_UP_EVT))

