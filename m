Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370167F2367
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjKUCB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUCBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:01:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4810C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40839652b97so19539715e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532080; x=1701136880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx+xbR7vEy8WvypRwvrmxjfGzTQ6Jn5Kk2hdbYBJd1Q=;
        b=fL8c107bXMmME29r9Xb1RTi6RMMSXEhkw+rLp7U2zQhu85/QVhH71RNmBuK2EBpkYd
         ygdJ7KiN9QhI3AC+kjseww52CcUhpmq2z3Q5uCigxgCzPPjPkoH/G45Bzfz398/VNi3N
         ulNxk/tW03fAmU7852yNBIoF+YwauXcmDzmNW/gbYp09XYOI5lhV9bCuYf8+F9l+reNU
         zS04aatpJSkHZ6p2bPTTnFikRrSoatV+Hw6ZdvRAy7aryd4lbv9kH/tLCiC3uQL4/BO3
         nOmlFMFrqvl/QYn8cdbOmpAEvYWAVQDu8H/LdoG7s8HuATOU9ZGm47o8B6ljyH1u90Jr
         3/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532080; x=1701136880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx+xbR7vEy8WvypRwvrmxjfGzTQ6Jn5Kk2hdbYBJd1Q=;
        b=cNvDStBPDIaS0MP+XDn15RMCLuypimQz0g1RugQJ52PYbJ+tJ5FtTs2WW2Yos+Wh30
         ybHGHlmoqWxVwXgCPpQuu6NjChJo+tnGPhrCK1lUlhhJ/Gg8kAzKz8QDzEkyMHaakV8Z
         fZ16r9wup6g4jCIkDOkdoHIwZh8ClCnPQbCz7wiDl2CMyo9H8MrO7GtW9fdaCLFP5YOO
         o1qedSaUhjfphEmp5xs4aUXjEQ9/9STA9DYNs75ATjgaUa9nPYKIkSHEXYOzVMjYTwsX
         U3AM7IB73MjytPhlX9ZliOxL0kAqV8PvnITcYfKECd7PJmkRJxYu/vp4985G0/6sie/x
         ofpA==
X-Gm-Message-State: AOJu0YxGFkGzpy7LR4omhsqyNmMTHlmP+HHaWypIjCGsPBg1EZxqSRxj
        bPK4DqyxJXhUDCAeeX0/L3aSSA==
X-Google-Smtp-Source: AGHT+IFKYDDZbYD7cqEdBrYbT7HZyrZmC0KpUYqH0Iwjou5g1nBYVJ4Qi5oQbDlIMr0oJ/5Pz+iE2Q==
X-Received: by 2002:a05:600c:4fcc:b0:408:5ba9:d707 with SMTP id o12-20020a05600c4fcc00b004085ba9d707mr8592956wmq.16.1700532079960;
        Mon, 20 Nov 2023 18:01:19 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:19 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 1/7] Documentation/tcp: Fix an obvious typo
Date:   Tue, 21 Nov 2023 02:01:05 +0000
Message-ID: <20231121020111.1143180-2-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121020111.1143180-1-dima@arista.com>
References: <20231121020111.1143180-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, my VIM spellchecker is not good enough for typos like this one.

Fixes: 7fe0e38bb669 ("Documentation/tcp: Add TCP-AO documentation")
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reported-by: Markus Elfring <Markus.Elfring@web.de>
Closes: https://lore.kernel.org/all/2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/networking/tcp_ao.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tcp_ao.rst b/Documentation/networking/tcp_ao.rst
index cfa5bf1cc542..8a58321acce7 100644
--- a/Documentation/networking/tcp_ao.rst
+++ b/Documentation/networking/tcp_ao.rst
@@ -99,7 +99,7 @@ also [6.1]::
    when it is no longer considered permitted.
 
 Linux TCP-AO will try its best to prevent you from removing a key that's
-being used, considering it a key management failure. But sine keeping
+being used, considering it a key management failure. But since keeping
 an outdated key may become a security issue and as a peer may
 unintentionally prevent the removal of an old key by always setting
 it as RNextKeyID - a forced key removal mechanism is provided, where
-- 
2.42.0

