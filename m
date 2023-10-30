Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891877DC233
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjJ3V5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjJ3V5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:57:34 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA01F7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:57:32 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d2de704f53so2253444a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698703051; x=1699307851; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4F0aTRBcZ7fBrQao5GQkvnUof+5v+oaXX1zm7ulzMs=;
        b=NMGXQk1g/D5/logC/cy+BHn3YXlzpANevJTzmdaCj0q52LmF6q4mX2y/URchJlkfcF
         7/NIRh0NEwluUfIxypQgAZUpwsWYTN4cj26ePrR2PDIOmJZ1+iEbH4wUQpytl271rwEn
         OCx5UtpU8dH7kQubPfNhOjQFxVRoIDaVuwl/oPkceOGXJhSZkZypkH8yAN8zchBckAz+
         O5qOkowElKQfFId6cJlPX4mPJSuAHgO2c/VPVrrljXxXZE0ByBHqg9TSTP97odmfw0wt
         uGUsCmvVHJh0RmntwJxgBfWIXjv8vj9kNqD5E8lQhfdlk2OXLPA7I5t8lgnUHM3b+Dn5
         eVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698703051; x=1699307851;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4F0aTRBcZ7fBrQao5GQkvnUof+5v+oaXX1zm7ulzMs=;
        b=Tmz0ILDfsabRTP1i/xCQHwTqfOMhacIJ2SXPrfEJT57Fb0dIUxTLfowgnGn4lFio3j
         Mxa4MgY3IxOsaxINhif0N6ZWMN1Ya9O9ndA55/gxs3kekn2caW4J/75iDu+oy7rNR8bb
         /s6oZA5Z0vPrnRMArpTlfGul/9krslJdNCN+VwcJTKYB5qk/1ZzAl204Lwn3QgBh/oSS
         GwSP5PGirzxyIzA4b+p82hgOWKE/47IkZcKHCWnWswSF/GdCgrfbwQUaAnRlS8gO819b
         6I2mtPcrMtbe+8rNSpTW7qK8OtEw3iAyS7hMOPD6HxtvoYY5/Jm8Md4IpZ9aG84zjISx
         d4DA==
X-Gm-Message-State: AOJu0YyotNXMKknRPlvLT+lV9WjYGDXMZ2OzwykYaJiNfkfryX2L4svM
        DYrgleiceNubx+sA2Xu5+2rWa/MUTkw=
X-Google-Smtp-Source: AGHT+IG9roxjl6N0gDzotVZBlBu2U2nCtzJcY+vTqhZkhZjFKpCd3cTOWiR06kFJti+zBRyPIQCcgA==
X-Received: by 2002:a05:6830:90a:b0:6c4:ae52:9599 with SMTP id v10-20020a056830090a00b006c4ae529599mr12639047ott.7.1698703051496;
        Mon, 30 Oct 2023 14:57:31 -0700 (PDT)
Received: from urola ([208.184.224.238])
        by smtp.gmail.com with ESMTPSA id d17-20020a056830045100b006c4d6a06a94sm1563651otc.76.2023.10.30.14.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:57:31 -0700 (PDT)
Date:   Mon, 30 Oct 2023 14:57:29 -0700
From:   Frederik Deweerdt <deweerdt.lkml@gmail.com>
To:     kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] Add missing NULL check in `tls_strp_check_queue_ok`
Message-ID: <ZUAmyb44sy309V6H@urola>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We see `tls_strp_check_queue_ok` running into a NULL deref when
evaluating `TCP_SKB_CB(skb)->seq`.

This commit attempts to address the issue by exiting the loop if
skb->next is NULL, and has proven stable under load.

That said i don't understand the code enough to convince myself that
the NULL check is indeed required, and i would be happy gather data if
that's useful.

Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
---
 net/tls/tls_strp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index ca1e0e198ceb..cabac0db6445 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -441,6 +441,8 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
+		if (!skb)
+			return false;
 		if (TCP_SKB_CB(skb)->seq != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
-- 
2.42.0

