Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB07D407A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjJWTvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJWTv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0AB4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698090637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=BZb3Bi9C2CsxxaJsgQZxAvcW9+sG5uBGA13Qc4GB1N8=;
        b=LbjR1RQKm06wxVwtUJDuK1UtnS6RiaP3vsyYQeiZJ7BVCxwhwAmM2Wu8DmBMOHut6m6iWD
        Gvsf80mgkhNKA8z9uMvz3gjxLBq4j7Ydd1kSY9DlVe0abHgTEcBvZATh31QO80BBLWj2dX
        iFnGA9FqNPDF5d6X9tOfDu32B+JaVHg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-Eua95rmQOKqKtfnOmOYvQA-1; Mon, 23 Oct 2023 15:50:35 -0400
X-MC-Unique: Eua95rmQOKqKtfnOmOYvQA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-774382db0a5so408620685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090635; x=1698695435;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZb3Bi9C2CsxxaJsgQZxAvcW9+sG5uBGA13Qc4GB1N8=;
        b=mT5EzhvzdGHb8qjS1DTCl0OG0gJmlGKGKNKWBks+aeLkG8kdZ2K6p5v7vo9OUlkUIs
         b9r0O4meAyZqRJDzLtcZ77YEpSemUGet9PC5pTy0Xn0bjtCaSFUynvlXy1yRmWNLdYoJ
         YCprWI8Gd1+HMyQ7Yxh/WP2/nFZQcw8RlXIjsB5acrhg0j7+GZE7A8XBPwfN5hP4OP81
         Yyf0yZxbJZGLGlQBn70fsaXTxDyzKY3ufFFP+vZhXlvC/SU9fe1PGTaztaMXIrwFpYOG
         lJG09d0uEuKBVjyzaYWmysCwBk1REQ1dksPgu3hHSIxTWYhesrZg47QZz5B1HujiPnXq
         I98A==
X-Gm-Message-State: AOJu0YwEtRh6OdNeV+lglMu0BXZJj3O+C/XBRRGEZWra0XLq3CbbCKhu
        G2AJdHW42SaHeyfiYBqz8WuiGkjoWLGaKzuAKQxeo2RE9yjqnQDMPC2F9wjl/w8v3RTxv3XvEEG
        D1be2hJWccuEe73U/VRC/tM1h
X-Received: by 2002:a05:620a:3189:b0:778:8fa5:41b7 with SMTP id bi9-20020a05620a318900b007788fa541b7mr10578540qkb.53.1698090635281;
        Mon, 23 Oct 2023 12:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqdKoOkFy85HOQxGcepY4wCuviyrgecHE5HdSiaJC1NprkLTzZPHhjSkCaS/h73ih1dsisQg==
X-Received: by 2002:a05:620a:3189:b0:778:8fa5:41b7 with SMTP id bi9-20020a05620a318900b007788fa541b7mr10578524qkb.53.1698090635030;
        Mon, 23 Oct 2023 12:50:35 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id s13-20020ae9f70d000000b007756c0853a5sm2921616qkg.58.2023.10.23.12.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:50:34 -0700 (PDT)
Date:   Mon, 23 Oct 2023 15:50:33 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: give more time to udpgro nat tests
Message-ID: <t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzrzkwtj@toz6mr4ggnyp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some conditions, background processes in udpgro don't have enough
time to set up the sockets. When foreground processes start, this
results in the bad GRO lookup test freezing or reporting that it
received 0 gro segments.

To fix this, increase the time given to background processes to complete
the startup before foreground processes start.

This is the same issue and the same fix as posted by Adrien Therry.
Link: https://lore.kernel.org/all/20221101184809.50013-1-athierry@redhat.com/

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 tools/testing/selftests/net/udpgro.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 0c743752669a..4ccbcb2390ad 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -97,7 +97,8 @@ run_one_nat() {
 		echo "ok" || \
 		echo "failed"&
 
-	sleep 0.1
+	# Hack: let bg programs complete the startup
+	sleep 0.2
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	kill -INT $pid
-- 
2.41.0

