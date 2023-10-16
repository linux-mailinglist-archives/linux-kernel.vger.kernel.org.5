Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24187CA051
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjJPHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjJPHPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:15:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4ECE3;
        Mon, 16 Oct 2023 00:15:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b64b98656bso648743166b.0;
        Mon, 16 Oct 2023 00:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697440536; x=1698045336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SXJ/teZkpiPlXm12c1rchEF2JTtWTmUCymdd9gFkMo=;
        b=Y+RH/DoLfByuwuFaOni30TpooegvzeJLreToniAOrlBs9tJIBfEM8MV+0skhN3iH3M
         hPnXLydgYi19q3yCBwmKHWOtHXkCNgMnmapjqExsvR3mHlTrhP/f65kqkXGFKSNM2Fps
         Q4Mf3jQ0JjX52+1DxNrJIBiVAWexVGsegihH2Ix9DWLmmxTOMTaCFL58J8FNMYv8k/Yb
         Sk2k7X5w4WftCfdRmxMxFWxsfSlFmpeqco8ZhVsiOmFiAijug/Jiz5f1nVS41Yrc22Mm
         X3CnEedmr4Uw7cqjZ1jv+BVZsKbbkqfzEKyGzm4IxtsLGlq8i+aVJF0RR9mmdBnecY+Y
         NOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440536; x=1698045336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SXJ/teZkpiPlXm12c1rchEF2JTtWTmUCymdd9gFkMo=;
        b=SAkvH9RYs1gUW0Q9mI9SPRl3E7nVGcpIaT5iOZmhR8m/s/Z0yk3tbJMI/DDGorIisy
         LkX0MxINn2cnyy4b2eQ/0iiERYuYDfESL+cDDSw+RwcrHwYcRcmem6/aJGE9DmgPYFCj
         2XQvz5oWjdVTFDWYPpwvHZEiiBxXhi9I/JyV7FRbainUuWpmwEqAzuM5aUoCVgPWvnAc
         2pJx44d8+nm/W4+ChAb7OS9dRhjlnzHoNKnK+76Pncr3ZZs/Xhuo9dsrax/VufskYetR
         SEe07Ho3Xk7BvziqNnWTo3NgCXlsaq/EI38Vi9oCsa9Gvh88rj+qZzZ74UpMSxdydO8a
         IVYQ==
X-Gm-Message-State: AOJu0YzXqPf2o6umpAGqqXrbLL3YadquVKByr24ZNm9W/wShzRV73EQO
        /sZ0y43O5hebwG0zuG+E/0/sQ72bb1s=
X-Google-Smtp-Source: AGHT+IF8aMTTdrbzUsZ86oDuz8S8Q8916kvXJ5I5fNtStoU9wppVSmKMKaqQam5al3zGfDKaLz83ZQ==
X-Received: by 2002:a17:907:96a0:b0:9be:ddad:61db with SMTP id hd32-20020a17090796a000b009beddad61dbmr4496535ejc.56.1697440536359;
        Mon, 16 Oct 2023 00:15:36 -0700 (PDT)
Received: from tp.home.arpa (host-79-55-64-40.retail.telecomitalia.it. [79.55.64.40])
        by smtp.gmail.com with ESMTPSA id jl25-20020a17090775d900b00992e265495csm3419471ejc.212.2023.10.16.00.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:15:36 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/7] ipv4: use tunnel flow flags for tunnel route lookups
Date:   Mon, 16 Oct 2023 09:15:23 +0200
Message-Id: <20231016071526.2958108-5-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016071526.2958108-1-b.galvani@gmail.com>
References: <20231016071526.2958108-1-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 451ef36bd229 ("ip_tunnels: Add new flow flags field to
ip_tunnel_key") added a new field to struct ip_tunnel_key to control
route lookups. Currently the flag is used by vxlan and geneve tunnels;
use it also in udp_tunnel_dst_lookup() so that it affects all tunnel
types relying on this function.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/udp_tunnel_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 494685e82856..a87defb2b167 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -232,6 +232,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 	fl4.fl4_dport = dport;
 	fl4.fl4_sport = sport;
 	fl4.flowi4_tos = RT_TOS(tos);
+	fl4.flowi4_flags = key->flow_flags;
 
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
-- 
2.40.1

