Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA97E8272
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346017AbjKJTVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjKJTVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:21:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034CA266;
        Fri, 10 Nov 2023 00:45:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9b7c234a7so16146035ad.3;
        Fri, 10 Nov 2023 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699605940; x=1700210740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQwwNNq0rca7smlg942N55FBCyeR6HoarsSMcpeyXfo=;
        b=ZMwJjeZvE/UqZXGnDXB+IF0qnRFhsAXO7cMnOvnye1ASnHOpnRyNURZ9tIEe6dnA+C
         i9C7NB+9gFMofBNu5/rcReHHJDUQAoupQSbQbU9+iHPYKhQu7yOYbYQG7/uWyGU/WV8x
         fvGSobFmfvb0GngGYYQO+BFaSWhZ90Ghnbae1TdO7c5GFpY9d4nFXkUqVjCFexD32l4O
         qw1DfxRNWF9lD7rx2dXfuehwg0Yps3Gbh85x023fLDwGEqIw0fJ0nJbDMuwbak+b7c5I
         Mi4HPXoyMh9r+6X1FGxEpdYqlc33cObbNu5IDNHaTTAq84GxgC0tjtUzTAklZyriDKel
         EG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699605940; x=1700210740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQwwNNq0rca7smlg942N55FBCyeR6HoarsSMcpeyXfo=;
        b=M17YhdGFoqKeH7zkFqHeDxyzzGjFNlZk3d3loBgUjtECKEoec9kzoKcWdcYfpuYOTz
         nIxb3BljkeyU218dlR7y/Q52I2gqtxX3GLzEiNaEwIzEBoRrB+Rsrr4DU0TEcGls9GWr
         D7DE36qQbS2ESqa5dhn75OUKgmrfYFfOdfuo76NYX8Ttxufea46bJFH2qcxRY24Vy16n
         7rnft99/L1wmDCris/bROtSF7crAFw82V5YJuAPNBZjmZkBUPtXGFqXrsu2c+FtWf03f
         wGQc6zSrcxmozjFYsh5gH+UAujPKv3qkaGj8sEsg2EuONHIpGJO7hDGuXrrP+rw/R3Xg
         IgzA==
X-Gm-Message-State: AOJu0Yy0y31oz0CCOPzqihvCvlIu29iONEPu5Ms4eDLV6vTFWdFdle6N
        XNxHc7TIAh8dskcpGN7hNmI=
X-Google-Smtp-Source: AGHT+IEGsLh5TZE/KmGOm61zWeBJcHj83BW7ZKiroop3egiA5LcitDOFLwDoJxqbVdZ2nNAnhTue6g==
X-Received: by 2002:a17:902:6803:b0:1cc:d981:a3a4 with SMTP id h3-20020a170902680300b001ccd981a3a4mr5920416plk.31.1699605939651;
        Fri, 10 Nov 2023 00:45:39 -0800 (PST)
Received: from ubuntu.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id y7-20020a1709029b8700b001c611e9a5fdsm4839413plp.306.2023.11.10.00.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 00:45:39 -0800 (PST)
From:   Dipendra Khadka <kdipendra88@gmail.com>
To:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com
Cc:     Dipendra Khadka <kdipendra88@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Subject: [PATCH] Fixes the null pointer deferences in nsim_bpf
Date:   Fri, 10 Nov 2023 08:44:26 +0000
Message-Id: <20231110084425.2123-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller found a null pointer dereference in nsim_bpf
originating from the lack of a null check for state.

This patch fixes the issue by adding a check for state
in two functions nsim_prog_set_loaded and nsim_setup_prog_hw_checks

Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com./bug?extid=44c2416196b7c607f226

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/netdevsim/bpf.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index f60eb97e3a62..e407efb0e3de 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -97,7 +97,8 @@ static void nsim_prog_set_loaded(struct bpf_prog *prog, bool loaded)
 		return;
 
 	state = prog->aux->offload->dev_priv;
-	state->is_loaded = loaded;
+	if (state)
+		state->is_loaded = loaded;
 }
 
 static int
@@ -317,10 +318,12 @@ nsim_setup_prog_hw_checks(struct netdevsim *ns, struct netdev_bpf *bpf)
 	}
 
 	state = bpf->prog->aux->offload->dev_priv;
-	if (WARN_ON(strcmp(state->state, "xlated"))) {
-		NSIM_EA(bpf->extack, "offloading program in bad state");
-		return -EINVAL;
-	}
+	if (state) {
+		if (WARN_ON(strcmp(state->state, "xlated"))) {
+			NSIM_EA(bpf->extack, "offloading program in bad state");
+			return -EINVAL;
+		}
+	}
 	return 0;
 }
 
-- 
2.34.1

