Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010647A27EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbjIOURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbjIOURZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:17:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA173A89
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:14:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so22852155ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808898; x=1695413698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2adzcEiFT17X0tMOdRHOC+4xSYu7V9ABPtDWz0mCD/0=;
        b=J+2qPFbR6NPi/lK36YaaEC2g7PZyp9zwCLefboI4JRP0GTtDspwegZ299UymSfEEdx
         VTHlzOOOtOfXoj6QW6He9icCoRrS6Ln/09oAgHTFyIqNxUIWu+M4gIdgddj+iIzMdf5x
         Hm7ZAVdXwNz1FhWIfw2ZTfpDx/QYeunL3e1Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808898; x=1695413698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2adzcEiFT17X0tMOdRHOC+4xSYu7V9ABPtDWz0mCD/0=;
        b=HaOPSB4En8aruEM4T5JEPw6CpIw7tPCKzbGmv4tfguqhpfmsDTmUmeW1wDw8TzBOIF
         R8D3KpVYKGA0Z/blqdKnf6692Vea0daueGSvIi0bOI05mlgCJATw3fKkyD9HhrVQKrQP
         zcx1VfFArp9zKOM4+Osvhs5FHIW8N97wTWclt+7lLW3SKIPvpdpsYASSeSamlC094LPA
         vaoacuw7sW7Y2bKU8azIhvSlPbogVLONzb0HXabjBXZmVZWtITaE7iiIE+kdh0WXW9nI
         zn8Z2QQmNEJILuW4kbiwdsWGaHAUQRJ/rHFlg0iVWxrnz9Vy3UNKSwhm6SsmKwj8N/Tp
         Cz/Q==
X-Gm-Message-State: AOJu0Yzzznq5YK3uFU0tjcdBHPRihXKf4K2gfGNJX+YY9nELrtO/KH1Z
        468JHk0UzBTQEYp1bIy+X1gpEA==
X-Google-Smtp-Source: AGHT+IFl5ZOAgVGqBoYurT+RiGDKwf2m+mMLCPmLDws6lMZeLSgdeHZqG1yi5Xh/qs1zbtBogZWowg==
X-Received: by 2002:a17:902:e882:b0:1bf:11ce:c6ae with SMTP id w2-20020a170902e88200b001bf11cec6aemr3250482plg.18.1694808898073;
        Fri, 15 Sep 2023 13:14:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b001c43307f87asm1837631pln.91.2023.09.15.13.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:14:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] afs: Annotate struct afs_permits with __counted_by
Date:   Fri, 15 Sep 2023 13:14:56 -0700
Message-Id: <20230915201456.never.529-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=keescook@chromium.org;
 h=from:subject:message-id; bh=C30Tpce9LuvDnPhShi9VewRUfa54HHSLTSiinU7ab60=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLtASGYM643odAtTW+2uVzG0JxIaa//Ye+Bts
 GG3+SOU75WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7QAAKCRCJcvTf3G3A
 JmQ5D/939BFdVcrl8LsWHb25cdDVwqzcQu0ePiQa21qI3gkIx7d/C8DZ2qrX3QrHPyxnky+ufgQ
 9Zl9fn6bdqHc6imsnBAAkRegAyTuYMtUmp6zi8w2Bzf9dT8r/xuT8GtAkMlo336a7xveH3luRbO
 MTr9lMWq4ZJ3GCh0FTdJmckVsF1hybn6tpSNZL4Y/I+pDLjDduYV0/VAwzRB5SWlre0mug2WBNk
 XgGKTUWr6zml7tQhaxlp2r8rgMuLcQTuwTty++KM6qyaDw4HNfJ5wfSF9UDjeJHS489LFQbaKMf
 JD0csUlqzQK9Azl1Fqed6jTMZL4924e8MnjWmZD7SgMa2mzDlFzDMenajpdoBypMvFqQwQKAXwo
 X4BSZvbaAg22gLUsQHDBNNqKLkhjYfvhE7AvGLCXu+f1m7P0zrjNKuX2YoEnYrj1M+n3+AJCO3j
 ix5OuhOhpXAJNFqJsHsVoS62xM2i4ui5ZpF9HMLGUNANCkwQeTKYk69PXhuZIu0M4aEfDKphuBt
 KMJdwM3G8URutOHI00MxVT7g14ZllYBBq5BmjfNgn8YKUPI+iARkBV+anvIM3LIKGKsU48jFCH9
 2y3kY1IkkyCqw+M212bqRFmBVg18HbLa4Q0zv7sPzuZUf2DdSubfdtYc/RRjRx3oKgnwxo90i8o
 ZlTc3RO ZPK5Fl1w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct afs_permits.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/afs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 07433a5349ca..469a717467a4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -705,7 +705,7 @@ struct afs_permits {
 	refcount_t		usage;
 	unsigned short		nr_permits;	/* Number of records */
 	bool			invalidated;	/* Invalidated due to key change */
-	struct afs_permit	permits[];	/* List of permits sorted by key pointer */
+	struct afs_permit	permits[] __counted_by(nr_permits);	/* List of permits sorted by key pointer */
 };
 
 /*
-- 
2.34.1

