Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556BE77379F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHHDWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHHDV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:21:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B821BF5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:21:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bba04b9df3so45869755ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464872; x=1692069672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNrm/+UjyC6jP3361KhAbnju37DBvc3v6PBY22LsM1M=;
        b=khfL3k+d/CGznwaO5bu9+cRGuRQ6fYxlH9gn4KFfrTBbf9tNYQ6PkS2QLz2ndsXr7u
         ZZFyAYrq4pkWZ2egL0T8+F1oRE2BdqG2AchQKzk5rpmHiJn7brKTCQ8ATfQT7sFIWFge
         +wJcsLzJca4mkXRRBfJXZfKyNTBPlv+eL9czPa03R4sohsTcUYnfsQxbhSXxU25FemRt
         iejLrUhpyeo72CMnzwLsp9SuIrXP3m4KaE4DHI1lDQX6YY5lFuWPo3Vo9fSW3SuO+lAg
         gxB6SIK1coQKqnReEqyCG/Z1l38wetEMXmr5Avzcf+u4KBASxQT7KEpJWvcaZOhS10vC
         fb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464872; x=1692069672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNrm/+UjyC6jP3361KhAbnju37DBvc3v6PBY22LsM1M=;
        b=IL9/TDscc15cJUqsiI109PGIQxKuybvEbLZxx4RtkUSaieN6R9mWBk7sP0IgmAmRl5
         3i8pyr0wcwFCFoj/e/H3a9HXmjJ63PN0FQoBv3xTecfjI+SzEfzuoL1apXQAfPpTCDxq
         z01oT9dta/a4/80/2icWLgNVmujoDpG5UVhe4NrccWIzQMjPMILgKnbqVc1hb0i78fqk
         oz/IEYSi2ZgHJoKn/Trutlth6rrezWn0L5qq+LkBc5rQRc5Cvzy/hPR3w4CGs3CLBEDP
         YJHRIBdmSNv1reZU2EOoNlQ6PdFMTl8Hs3auY70RSw8MaFqo48uFE/EnZVaz1OU2Los7
         e9Vg==
X-Gm-Message-State: AOJu0YwxrylECoJ+mGIpZG5Fy0qriRSCJEKqRe1yliGlX38shn51NUyI
        OQ62vP7UEWWJmWbVjMWPrnKRvQ==
X-Google-Smtp-Source: AGHT+IEf+1UGY33nl/NwIi62HwrnmxDbqQr/9EwPpV2GjIISAPneNKJbTvSnXmVCy/syiT18tgdayw==
X-Received: by 2002:a17:902:6909:b0:1b8:9461:6729 with SMTP id j9-20020a170902690900b001b894616729mr10585584plk.2.1691464871774;
        Mon, 07 Aug 2023 20:21:11 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:21:11 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 7/9] sk_buff: add destructor_arg_xsk_pool for zero copy
Date:   Tue,  8 Aug 2023 11:19:11 +0800
Message-Id: <20230808031913.46965-8-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this member is add for dummy dev to suppot zero copy

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 include/linux/skbuff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 16a49ba534e4..db999056022e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -592,6 +592,8 @@ struct skb_shared_info {
 	/* Intermediate layers must ensure that destructor_arg
 	 * remains valid until skb destructor */
 	void *		destructor_arg;
+	/* just for dummy device xsk zero copy */
+	void		*destructor_arg_xsk_pool;
 
 	/* must be last field, see pskb_expand_head() */
 	skb_frag_t	frags[MAX_SKB_FRAGS];
-- 
2.20.1

