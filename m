Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33C8806FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378249AbjLFMhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378286AbjLFMhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:37:18 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0AED3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:37:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3333074512bso381753f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701866243; x=1702471043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jz+VDB9IuC8ai+mZOJOJXmrBtxu8BlNDpDW3sPbwSdg=;
        b=TxQ8Mjo+LbP/ynwQnqWNEY3XvKx/uhIVob6xcE9KMNRyaoc/o5PL+KKE3Iic9NJ/OI
         TtQjSOTucUAKyBs+4TK64U7TvPbd6UVEc2Ftops4WrPZ4oIJXPsig8qwn4jaEo3oJIC2
         MKlbuRKw4rfAUEqdUMtPQTwrZdAsZnZ7E0UXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701866243; x=1702471043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz+VDB9IuC8ai+mZOJOJXmrBtxu8BlNDpDW3sPbwSdg=;
        b=pMZMaJ3IE2LHCe+6tI9nuVh0bxKQIsyvvAcnSbM5atv7PcI8PuVK2EOE3oQOuIeKDe
         DHfmB4TeEKKWO8xuotJtYp6QJPjxFBvXBg2pLTiRijTfZIz+rirgbX8o0nLGOQf2swpD
         z3GEHDA14hS+UD+a3MZwQ7qGORjlnCt2cafNcC8p9d9U5NSsb4e/keqrB/hZ2PE6E2vA
         HFAQBSjx7bWJviiGOvAR6jIG6IJgmIS/XvR5pxLWClFBCKYbUdDioQ0n2T/Pt372R1EP
         CVeOm+1hlrbJTkTGv/lNwJv+VHUPbW6sBmb4/9ZYjxFlgWtkve0A5RDZvJQ0eY7U3/1t
         Bc9g==
X-Gm-Message-State: AOJu0YzlnGuRwoP2OsdRUKqEtvjOFlrHCOYuxP8L2gaDH0l5YNLyX78f
        et9Io+DRo1uDCF0TO8JocLXgnQ==
X-Google-Smtp-Source: AGHT+IEbEl3hPWVlP/0jGUWl2nFn7sZhfzLO6OUH1KO/RKEZwzndAZVUa4pZ+va7kn+WQ26dPSmoSg==
X-Received: by 2002:a5d:424e:0:b0:333:2fd7:95f5 with SMTP id s14-20020a5d424e000000b003332fd795f5mr496465wrr.48.1701866242861;
        Wed, 06 Dec 2023 04:37:22 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:628b:53d7:2bbf:7988])
        by smtp.gmail.com with ESMTPSA id q15-20020a056000136f00b0033332524235sm14005573wrz.82.2023.12.06.04.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:37:22 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH] team: Fix use-after-free when an option instance allocation fails
Date:   Wed,  6 Dec 2023 13:37:18 +0100
Message-ID: <20231206123719.1963153-1-revest@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __team_options_register, team_options are allocated and appended to
the team's option_list.
If one option instance allocation fails, the "inst_rollback" cleanup
path frees the previously allocated options but doesn't remove them from
the team's option_list.
This leaves dangling pointers that can be dereferenced later by other
parts of the team driver that iterate over options.

This patch fixes the cleanup path to remove the dangling pointers from
the list.

As far as I can tell, this uaf doesn't have much security implications
since it would be fairly hard to exploit (an attacker would need to make
the allocation of that specific small object fail) but it's still nice
to fix.

Fixes: 80f7c6683fe0 ("team: add support for per-port options")
Signed-off-by: Florent Revest <revest@chromium.org>
---
 drivers/net/team/team.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 508d9a392ab18..f575f225d4178 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -281,8 +281,10 @@ static int __team_options_register(struct team *team,
 	return 0;
 
 inst_rollback:
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
 		__team_option_inst_del_option(team, dst_opts[i]);
+		list_del(&dst_opts[i]->list);
+	}
 
 	i = option_count;
 alloc_rollback:
-- 
2.43.0.rc2.451.g8631bc7472-goog

