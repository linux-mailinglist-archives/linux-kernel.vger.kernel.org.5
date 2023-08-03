Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CAD76EBDA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjHCOHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbjHCOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:07:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACE546BC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:06:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8ad356f03so6965685ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071592; x=1691676392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg+CmrWjgB1kgvmO7SAfesuSxaP3dPOXxrKbkUe7IUY=;
        b=XrqyvZDxSgiavPWsBCbSRHg+ou1GVyTzy2qzcAS64qQGp+5sGIgEphDFf+c7iQsHOn
         sZUqX8uA285/7n1CGhGV341ljQbfmvQZRJA2l/46yYxYNTZNY//6jbTn4Sz5r00eY15x
         uP68lQ9F0N2yR9rt4u2yYkcTx+bCa4Z5wEMIUI8iFf5eXqYrRcPeDEfmOkp7L+DROPOW
         49sQrOMYJDe2u70gPeP+xU/GOuRU3LH+bIrm3AOp+0kMDIpIgOwC7BAiBy+nnWtFq7XK
         uOJx0krx1qjTykH3Pfsu4sp+nJH4RWaU59BpMVaGHqHStjFrTTCi4SYIYS+lZoPloPYZ
         yZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071592; x=1691676392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg+CmrWjgB1kgvmO7SAfesuSxaP3dPOXxrKbkUe7IUY=;
        b=lxFxFIaxc4ZV3mqu8hTD5uAoKx8MDVOIwVzl14vPEWQ+SO/jXes56loXU+3U9IPfXr
         hEhY4yTN9WaByW7lUxrwQphSK4mKFLUGTm5PObDZGQj0VTfoEVS64RgtvxTGAYjY0Z0t
         UfizUkopdeTac0+WoIx3YEKXZB1/s7IPI/0e4uXkJU5HJuHOElZpPBgdedYE1RwfPGQC
         AOV8S9tKR2zjFnffpTQpot4FH7xl5hdbI+ud9DTqQpH/8WR/xkj1oJQyyufhOUyfUsJS
         5YbxeFdbZB221k332DfAeEWVKY2DOD8eXy1OscEYUM789OIGGEsIgPprGK0gUiEM6KpQ
         kImA==
X-Gm-Message-State: ABy/qLaedCLlZrgl9t1pZfHdPATxOJXZNOk9/wvjFYdv8N7xe6SSqfTt
        tyiE0Yus1Ps6wMlwHJSjwD8Ybg==
X-Google-Smtp-Source: APBJJlEBtUTtysA9ORUwLWAkRadcMVE68MWA/AhiBT1iIGdjrvwOYA4w2MgmmH5jyHDtduyS/gd0Mw==
X-Received: by 2002:a17:903:120a:b0:1bb:9bc8:d230 with SMTP id l10-20020a170903120a00b001bb9bc8d230mr20412138plh.23.1691071591969;
        Thu, 03 Aug 2023 07:06:31 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:06:31 -0700 (PDT)
From:   "huangjie.albert" <huangjie.albert@bytedance.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 07/10] sk_buff: add destructor_arg_xsk_pool for zero copy
Date:   Thu,  3 Aug 2023 22:04:33 +0800
Message-Id: <20230803140441.53596-8-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this member is add for dummy dev to suppot zero copy

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 include/linux/skbuff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 16a49ba534e4..fa9577d233a4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -592,6 +592,7 @@ struct skb_shared_info {
 	/* Intermediate layers must ensure that destructor_arg
 	 * remains valid until skb destructor */
 	void *		destructor_arg;
+	void *		destructor_arg_xsk_pool; /*  just for dummy device xsk zero copy */
 
 	/* must be last field, see pskb_expand_head() */
 	skb_frag_t	frags[MAX_SKB_FRAGS];
-- 
2.20.1

