Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF947D2C32
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjJWIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWIGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:06:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D6A6;
        Mon, 23 Oct 2023 01:06:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-27d8a1aed37so1006501a91.1;
        Mon, 23 Oct 2023 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698048396; x=1698653196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qRIXdf5CP5zvIEAZi7GHLHlgb7w/UotV/3iHHaEc8qo=;
        b=TVXDWHT0PvaM8OfkV0TrTCQrxE91NP01J2YxpQjWuPF9Tcz+wpJnVv3dozCz/zGP74
         kv1qXO7WD5rrJjjtHMeahvZtgPTTySKYE18AOHR/aV3Jem/QcnFfdqMg57uiNicfuN7K
         vRxTkDbLiyda5tAs1FADNe1o9mzGLCINTb1q1KoTUQ4Q1/7NzomVys2JA/+v6sIlJ9Z0
         nefdhpGJ7OgoUIfx3d+HHzyV0LK42UHzzxUVWBMX7eBPfUMZHDIUFwITA0eJ2rSRxYXp
         8VCB7f5oTt9C1V1lBmOCTiohex8cjEUjsIxXLHaupr5YFV2Rc5hu2qGRh404QfRoNl86
         UrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698048396; x=1698653196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRIXdf5CP5zvIEAZi7GHLHlgb7w/UotV/3iHHaEc8qo=;
        b=dxm+Z++BZ8rhqnOI+8OJG/x4GFCGxNkfYUs8PeOIk8sIuWssqzgVUUQQJRUiL2RKeN
         52u/Wb0sHs3yzdM2tMMS0IMoWo/AHUNd/KffdXJcxJteNmhWJKtOzmWlRywQxM3nGGB4
         wLX7ENhp026bKExGdt9PsMJkmh5j9m+M42xF+AB6Owm0Zn8JXlvnNMHwNpiDhsD/rXyr
         6VRzGLNehkNkMXqWKfuQsPnMrLEH1siYE0Reg0AGF/TqPCKDPJkPEsq0izyB0MeXJisZ
         wEP8A28+5gtisOD4iHwFmCWJUK05ORNtoAZyLPRxxBH4di12I4xHe2lRSR+EM8vftySP
         Q7dg==
X-Gm-Message-State: AOJu0YzNLZ63vwC4smQEYRnwv/dAGmtGb5hl3WCYeXuJdggeoY6LqqZO
        ba45cp5NLggb8Fz+Zjtnt/JBEp4g0xWkHVM8
X-Google-Smtp-Source: AGHT+IGBTbnGthBAJRHZkDEaadnOunpMjviyIJfUVy0JU+Q/OPGx90xydi3/YKHR3zLDSVkRc01qOg==
X-Received: by 2002:a17:903:3313:b0:1c0:bf60:ba82 with SMTP id jk19-20020a170903331300b001c0bf60ba82mr7867245plb.5.1698048395706;
        Mon, 23 Oct 2023 01:06:35 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902d51000b001c9b8f76a89sm5422634plg.82.2023.10.23.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:06:35 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] net: tls: Fix possible NULL-pointer dereference in tls_decrypt_device() and tls_decrypt_sw()
Date:   Mon, 23 Oct 2023 16:06:11 +0800
Message-Id: <20231023080611.19244-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
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

tls_rx_one_record can be called in tls_sw_splice_read and tls_sw_read_sock
with msg being NULL. This may lead to null pointer dereferences in
tls_decrypt_device and tls_decrypt_sw.

Fix this by adding a check.

Fixes: dd47ed3620e6 ("tls: rx: factor SW handling out of tls_rx_one_record()")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 net/tls/tls_sw.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e9d1e83a859d..411bf148f707 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1612,7 +1612,11 @@ tls_decrypt_sw(struct sock *sk, struct tls_context *tls_ctx,
 	struct strp_msg *rxm;
 	int pad, err;
 
-	err = tls_decrypt_sg(sk, &msg->msg_iter, NULL, darg);
+	if (msg == NULL)
+		err = tls_decrypt_sg(sk, NULL, NULL, darg);
+	else
+		err = tls_decrypt_sg(sk, &msg->msg_iter, NULL, darg);
+
 	if (err < 0) {
 		if (err == -EBADMSG)
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSDECRYPTERROR);
@@ -1686,7 +1690,8 @@ tls_decrypt_device(struct sock *sk, struct msghdr *msg,
 		off = rxm->offset + prot->prepend_size;
 		len = rxm->full_len - prot->overhead_size;
 
-		err = skb_copy_datagram_msg(darg->skb, off, msg, len);
+		if (msg != NULL)
+			err = skb_copy_datagram_msg(darg->skb, off, msg, len);
 		if (err)
 			return err;
 	}
-- 
2.34.1

