Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E776A1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjGaUcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGaUcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:32:13 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FED1BC6;
        Mon, 31 Jul 2023 13:31:43 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bb29b9044dso4491417a34.1;
        Mon, 31 Jul 2023 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835503; x=1691440303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qCimbpyIfGRqpmV/wxa7E/CJwE+sDC0dWUhviOuN9M=;
        b=dFjoSJYX10+MwJ7p+0J6i8Fljr+zv6PUYJFxStQMrrxpwimDPx7DW4KGwZzMiWCh2j
         bGAwCcnaAx/++gyRc7NneN8wU+zVdcg3WieMXXbIX64R67QksII3rbR/9DS0hzEUsxf6
         YLrHOBfF9Ed3gOOM8j5VQEYi5gbUYT7rQyIK126plBiDCDDQIdT08HoXk7Z96BvcNeed
         91+qStpS54igOLQmwPs7lUnRSjBTaa7HSm+YzcUeSG9aW0d1tY/WvsWXrEPKxsZ3lL5s
         a/g38OuKmkwJYNd2AzLKNYJEhMMqK/gGmPVW3k+S60Bl9oDalqzHMLxVEJyEVld4D38p
         15fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835503; x=1691440303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qCimbpyIfGRqpmV/wxa7E/CJwE+sDC0dWUhviOuN9M=;
        b=iYWOqXogYhnebxWD7i+udXcZ3C9r4J0FbD9hdOvLOl6U9a68auMKLwt4Dv4TUGXQD0
         yKsOF5H0/h2XNYhNPnJQsbbbFVNLVsI1Zq7kzSprrUCA8BiBOSpzMEJvn3zZUjBhsJsO
         HK+JTskCFhojUXwRICjNg9jnq1/Wj9voQH6xfnjvGPTxZQX1yJwl18sUo+hwdjnNQgpQ
         qLZ9jD4v9w28xCsMvOZdaU6xj+velmLbORZX1nC+rQ+VASPfswk9HxmGkmSwjdgFfLKK
         avpAt3H7DXj2+2luop0VTdfc6MwgzZ0wP+2km0SQ3wWJBvMwtrg6dUFfI+D5QWojeuCz
         fXTQ==
X-Gm-Message-State: ABy/qLbT/qvv6yvx8GeqitmSbekp6Jk9CTGKmYkF6r18nJukl8mJ2U8+
        gAXHnOCPsQMIpRIV6VpJNd0=
X-Google-Smtp-Source: APBJJlEn5XAuVZeUcUehmhnrAyqZ2PS5vjEJIGNfljpHQRYM53oAsEdNiyKi6gVI66+7VMxXoFz0nw==
X-Received: by 2002:a05:6830:1e52:b0:6b9:3ecb:db8f with SMTP id e18-20020a0568301e5200b006b93ecbdb8fmr11573145otj.10.1690835503110;
        Mon, 31 Jul 2023 13:31:43 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b006b9848f8aa7sm4498841otj.45.2023.07.31.13.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:31:42 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH 0/8] hp-bioscfg: Overall fixes and code cleanup 
Date:   Mon, 31 Jul 2023 15:31:33 -0500
Message-Id: <20230731203141.30044-1-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Submit individual patches to address memory leaks and uninitialized 
variable errors. 
Addressed several review comments making the source code more readable.
Removed duplicate use of variable in inner loop.

Changes were tested with a HP EliteBook x360 1030 G3

Jorge Lopez (8):
  hp-bioscfg: Fix memory leaks in attribute packages
  hp-bioscfg: Fix uninitialized variable errors
  hp-bioscfg: Replace the word HACK from source code
  hp-bioscfg: Change how prerequisites size is evaluated
  hp-bioscfg: Change how order list size is evaluated
  hp-bioscfg: Change how enum possible values size is evaluated
  hp-bioscfg: Change how password encoding size is evaluated
  hp-bioscfg: Remove duplicate use of variable in inner loop

 .../x86/hp/hp-bioscfg/enum-attributes.c       | 24 ++++++++----
 .../x86/hp/hp-bioscfg/int-attributes.c        | 15 +++++--
 .../x86/hp/hp-bioscfg/order-list-attributes.c | 39 ++++++++++++-------
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  | 27 +++++++++----
 .../x86/hp/hp-bioscfg/string-attributes.c     | 13 +++++--
 5 files changed, 82 insertions(+), 36 deletions(-)

--
2.34.1

