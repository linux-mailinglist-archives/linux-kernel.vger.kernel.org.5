Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468297A4612
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbjIRJf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjIRJe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:34:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABABCD3;
        Mon, 18 Sep 2023 02:34:21 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3567177a12.1;
        Mon, 18 Sep 2023 02:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695029661; x=1695634461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6G1xYyE1NNaqnfLS7CDtUFGpGb/0lIiK2Jwl5R5oxI=;
        b=fB5b5XaVmPEj+anElM7/wARYMiej2CFGCiFQ7koRr9/WklRncxwWPtYKZD9VOcUtjD
         DuUJ63etBtX+ZYcdS3C6qm4zMP/kDlrs+0Zvy35fQ0QeJjCoWIAdJQvzmLn1ojgpq17i
         AIoqbfiNsJs4LSabnihuGW5gDkkP2FdjVlkzpzRuTbbdOQWc3cBhDjHvwuVsTvh4NTyu
         8NpC+oXkthRIzfV96vr3jAc4wsBNv7NT/vfnh6SpcILbXukhQPoGXYxkLDVfPA/Vs6iz
         C4J8jnDke3w0+xqzMn6MdlW/2banLViybg9OswQbOpD81dE9Bx2IHkNQyaiPPFS8Fya1
         fiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029661; x=1695634461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6G1xYyE1NNaqnfLS7CDtUFGpGb/0lIiK2Jwl5R5oxI=;
        b=ItbXMURHcMJnM8+3jwCFZSHvKpsy2TM9gd2fjGVqQd8dJQPAi8A/rGosjPbv4BXc/s
         N77fhXU7Mcl45N1OhSCEsJKohTZ4FmZjl+UMDn/zcEpaW81f0NunOuQkHHS5lR77zbQt
         ZytHyXLD9A0xHH+PkXj8Vp2etTI60qIel1nrxa+9XrRQv66yplj2JB07J8svwldmCltk
         t+fxVttjaJWNmCchXQat3ylrbsZML7d2q2pPiItCWATze7ZJBUWm/GccTBSOlvviApMq
         pAhu0ewsJedbXu9gtdGUMWyRiyYg1z6oewNoIRx2mosAqx+YIddOYjwvpUon0jrhWcqX
         6Ehg==
X-Gm-Message-State: AOJu0Yyg7tzhi6HqmOJ9akIHPKTkVWIRfxsi9aFWfOhhHhyaodhBZ3bb
        ChLNRKNaII2UUO9A0IZnSDU=
X-Google-Smtp-Source: AGHT+IFm99M0Df9AumnbyiG39jt6iyYrSQnDBT8geb5vG0E10iYCc342KUEf8lOfcQXeizvJ+WLjyQ==
X-Received: by 2002:a17:90a:fb92:b0:274:6a79:17c1 with SMTP id cp18-20020a17090afb9200b002746a7917c1mr7507752pjb.15.1695029661068;
        Mon, 18 Sep 2023 02:34:21 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a19de00b002694fee879csm9353848pjj.36.2023.09.18.02.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:34:20 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] Documentation: dpll: wrap DPLL_CMD_PIN_GET output in a code block
Date:   Mon, 18 Sep 2023 16:32:39 +0700
Message-Id: <20230918093240.29824-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918093240.29824-1-bagasdotme@gmail.com>
References: <20230918093240.29824-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=bagasdotme@gmail.com; h=from:subject; bh=uj4JKbL5vY/lq6EfpVPwFUuyIVX3awrGKWlV163bhVM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkckiYxXIbvJlx1u1HmtObVG6tMcYHsNwk3KpI7rp/9v 74mxU2go5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPRvsTI8FUgttGj5vvrCRbs p7fEd4axbVfb9vTR045aFYu9c2Ml7BgZppcqi0r4mXGLNDAuYzi5YuVbW4ffMs1rlt66UBy05ck 8DgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPLL_CMD_PIN_GET netlink command output for mux-type pins looks ugly
with normal paragraph formatting. Format it as a code block instead.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/dpll.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index 01eb4de867036f..69670deb8c4e09 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -119,19 +119,19 @@ with.
 If a pin was registered with multiple parent pins, they behave like a
 multiple output multiplexer. In this case output of a
 ``DPLL_CMD_PIN_GET`` would contain multiple pin-parent nested
-attributes with current state related to each parent, like:
+attributes with current state related to each parent, like::
 
-'pin': [{{
-  'clock-id': 282574471561216,
-  'module-name': 'ice',
-  'capabilities': 4,
-  'id': 13,
-  'parent-pin': [
-  {'parent-id': 2, 'state': 'connected'},
-  {'parent-id': 3, 'state': 'disconnected'}
-  ],
-  'type': 'synce-eth-port'
-  }}]
+        'pin': [{{
+          'clock-id': 282574471561216,
+          'module-name': 'ice',
+          'capabilities': 4,
+          'id': 13,
+          'parent-pin': [
+          {'parent-id': 2, 'state': 'connected'},
+          {'parent-id': 3, 'state': 'disconnected'}
+          ],
+          'type': 'synce-eth-port'
+          }}]
 
 Only one child pin can provide its signal to the parent MUX-type pin at
 a time, the selection is done by requesting change of a child pin state
-- 
An old man doll... just what I always wanted! - Clara

