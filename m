Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CE77EB5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjKNRy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNRy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:54:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005FC10A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:54:22 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-282e3beb418so5664383a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699984462; x=1700589262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hrdY1ZR4Q+Pjc1+HNhPiQ63BW1u99aeTKPRNswitFCA=;
        b=G0Y1WEErvqFZ5kwwfTRYJGzNXa+waDKEFT1sUQAe3DTEPWUH99hkkJkLarVDFqkWcA
         UknWMEM39XkJR9GO0uk3g5a+/dMIwBwYCzdFZsDU02qdbUwVmvtp6K6BcXrgEe6WqAk3
         Iv5OREkXfbWMQS/9+khFTm2CWvmzKlwrHAURY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699984462; x=1700589262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrdY1ZR4Q+Pjc1+HNhPiQ63BW1u99aeTKPRNswitFCA=;
        b=ZZ9AlWTU0I/jpY1CeZvEdL1uhNwTOxLqGed2tyQl+y7XxDiOoUqWua3jhEgAZBIevT
         Ih89V2HXrZHOh6MC5SX0FKEdaW6x3nM/90tH3+/N8zjL2VbBQBX7TNaMmei0BVWAidmN
         AJiRO3/4mAGm9Gm+bnu9s3ECuL0uwsDi/OUhjX7cq9fyU8WKtL5RdM9dt8zaqSlw4i2z
         2yiQSmtQd2HU41AvXZ5XQnmihTM/IITOnIEnqBmB5DlWfMvJIH+jkNfq5K8JJW55bfEI
         YLqxsYe8P0PVv+7y0EhJq0IM0Y50kiQQHpQXveWJMvmcO9RNXJkgpQO55LRIoNmpEYfp
         P8Bg==
X-Gm-Message-State: AOJu0Yyv2Fxg8edW/Ua5eMdZJn8nq1TClGq26hofeOUiQH1NKO4cQ/S0
        jil+BKMxMxh2ypyVuMvd9sZ5MQ==
X-Google-Smtp-Source: AGHT+IFUg+J09TcZCAJhZoHFTswXcZ10hiFJJUZnrS3jp9RzlcKeX5fyatdA/gCrVkIunDwikzW6QQ==
X-Received: by 2002:a17:90a:9109:b0:280:3911:ae02 with SMTP id k9-20020a17090a910900b002803911ae02mr11509167pjo.16.1699984462429;
        Tue, 14 Nov 2023 09:54:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a1f0500b0026f4bb8b2casm8312670pja.6.2023.11.14.09.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:54:22 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] SUNRPC: Replace strlcpy() with strscpy()
Date:   Tue, 14 Nov 2023 09:54:18 -0800
Message-Id: <20231114175407.work.410-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378; i=keescook@chromium.org;
 h=from:subject:message-id; bh=N1VPITobY/yI/va1G46nkZ1pGxdXDMzA+jiQpmZmNmU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlU7RK5LNw3u7eJ2oo5PdL/9L9IGtDYl8K0Xoal
 HDPpqOj/oWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVO0SgAKCRCJcvTf3G3A
 Jq0iD/sFKbf7i/qmgj179OWaA7SkQjsqK3tB8NKWxC56IEin7jNT157s5tBxpsHoe85q4wwLdXd
 5bDZy7lUuU7V7J0ohvwzqBpmTex/LrvSpybfaa3ZsfUzpIhUPpW1N+CnsepiCq1Zi2//QySsP68
 Wfr4f7fqlsmctP6WDblmEkQyLINhf86wgrvBm5jiJLtIA1ZoAo6u6btEaJG5mZt1cD1HOQoXuPz
 BmgOBw9EPbhJJZebaogHcNZJoB5EvPDecsUs1ZBNw0R3cqZ+la4e5bZbnHM/NwRM6Po16jfuV2r
 rW4ypkFb33NuOtEPUtqY7/CDJVTiSCMc5zxwT6PJLaEVbs5a5LLzQo8ipRlQKoCGeZu9I423Iua
 zlnHWrG5u5CafmpvzBfcsCL88FXrx0+xLuIb5iZ4qLl3RwQFvXONPnE2B8Lv6o3tIKXoFx7nqR+
 49SAzhHsjtCTvpCnI/QhpjAL4k4HPdouprILdMs0t2W7CBpchwCEvdvfeCwHiATC4yVAoWgLE7i
 5EWKQl0GLLXV8WHKkZntpXq3FGr0vJqodboDwZDQeik6mcJ9bI8qFSOyNxP4L8cI8AL9UUwpzAl
 5p9/TnjzBNghRnm7FkDUMhQ8zTXZVRDsl1RaDZmpW9JZAl/T2VYnbRA3Eei5XkeWxD4h3zTOZC2
 xZQZEk3 At+o907Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
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

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Explicitly handle the truncation case by returning the size of the
resulting string.

If "nodename" was ever longer than sizeof(clnt->cl_nodename) - 1, this
change will fix a bug where clnt->cl_nodelen would end up thinking there
were more characters in clnt->cl_nodename than there actually were,
which might have lead to kernel memory content exposures.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>
Cc: Olga Kornievskaia <kolga@netapp.com>
Cc: Dai Ngo <Dai.Ngo@oracle.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-nfs@vger.kernel.org
Cc: netdev@vger.kernel.org
Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Co-developed-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/sunrpc/clnt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index daa9582ec861..7afe02bdea4a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -287,8 +287,14 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
 
 static void rpc_clnt_set_nodename(struct rpc_clnt *clnt, const char *nodename)
 {
-	clnt->cl_nodelen = strlcpy(clnt->cl_nodename,
-			nodename, sizeof(clnt->cl_nodename));
+	ssize_t copied;
+
+	copied = strscpy(clnt->cl_nodename,
+			 nodename, sizeof(clnt->cl_nodename));
+
+	clnt->cl_nodelen = copied < 0
+				? sizeof(clnt->cl_nodename) - 1
+				: copied;
 }
 
 static int rpc_client_register(struct rpc_clnt *clnt,
-- 
2.34.1

