Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971A57D2455
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjJVQUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjJVQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:20:21 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA09119;
        Sun, 22 Oct 2023 09:20:19 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-457c7177a42so787733137.2;
        Sun, 22 Oct 2023 09:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991618; x=1698596418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MM3mqVThapC2gHr48TgRVIKUoeAj5E3tYfQaohXgAZg=;
        b=f/7XzPTsoNyydOVsd15eZrR1Hwws2wN9ugWha0PZApPO99aK+6RxV/uV/zyO0QAO/c
         YyM+2PbX/BPqeuXqboSXaO41pBtH7jSlGxkXTg6qm4nCH4uQjHPw0Afe3O9WMKvwrvsZ
         BNew1OCjO1k2NVD+7i/4UvM3WyhyXdkzix8KUp3j221xi7TGp95CiX/62LPlOv4xW2hM
         gc1D5mGmwtNNtHCBySfz9YkNSuHL2Tq7GjsgO3TfaqYY6kXJ2DhQVg7jmJdiD+Z4qh8n
         d16q5IHi+0Yf63PT6yn8sssOxwar8TnivMgDQxxR5I9H9X9YjrVM1GP1liucz75ebCor
         Vowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991618; x=1698596418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MM3mqVThapC2gHr48TgRVIKUoeAj5E3tYfQaohXgAZg=;
        b=u5QmuJ9S19A6FcPBEyc1A0v4qAOJ8cGLguarI0237hGXJHOlWGg/yPIBTLZnScoFOY
         CQmvl7HNqBwou8FQPI+iWWe6HejcEBt2wQHhFX+J+tqDbLVaHxoZuwUe0gE3L+NshLG2
         Xsh9YR37kfMnDhFlv0egRt3lYEcY8hc1J76f5qZIIx/5ltbQhyed/Y1awsn1bbZPuvED
         klKSeAdGD7XJRJiHdEFGjlo/fk/j+BsMqeb30yhGUNvav9uLbX3v9kSES3P8Wl4r79RY
         SOmhaD1Ql83nddObdQxiMUQcUFnI02f2LsW43pE3Ue2VqT5+JyejdMsCMHVsn6dFfHuG
         2m0A==
X-Gm-Message-State: AOJu0YwLTJHvEKE9vvGjvQcEjiNC/Aku37QkvBG4Hd7B5RHqu/+aZtAY
        kLC0666YNaSx7kJmacb0TzhO+whaYww+KZP4
X-Google-Smtp-Source: AGHT+IFaOU06a1tpLIDo3MFwPjTNyXj3Q6RHjgLutG/eUiaGz2WOYsTJepzxpZW0+lhGUoeDWLkCLw==
X-Received: by 2002:a67:e1d2:0:b0:452:60c5:20b with SMTP id p18-20020a67e1d2000000b0045260c5020bmr5668459vsl.15.1697991618166;
        Sun, 22 Oct 2023 09:20:18 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id l15-20020a05620a0c0f00b0077892023fc5sm2103369qki.120.2023.10.22.09.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:17 -0700 (PDT)
Date:   Sun, 22 Oct 2023 12:20:17 -0400
From:   Oliver Crumrine <ozlinuxc@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.n
Subject: [PATCH net-next 03/17] Change cork in ipv6_pinfo to a pointer.
Message-ID: <6b25cdc64a066e1a214020d0452fff10a33495ac.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual change to make inet6_cork a pointer in the ipv6_pinfo struct
itself.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 include/linux/ipv6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index af8a771a053c..0c707ce9e776 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -290,7 +290,7 @@ struct ipv6_pinfo {
 	struct ipv6_txoptions __rcu	*opt;
 	struct sk_buff		*pktoptions;
 	struct sk_buff		*rxpmtu;
-	struct inet6_cork	cork;
+	struct inet6_cork	*cork;
 };
 
 /* WARNING: don't change the layout of the members in {raw,udp,tcp}6_sock! */
-- 
2.42.0

