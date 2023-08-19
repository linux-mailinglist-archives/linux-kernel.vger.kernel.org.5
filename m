Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4EB781B93
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjHTALL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHTAK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B6E83181;
        Sat, 19 Aug 2023 13:20:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-565e387000fso1444266a12.2;
        Sat, 19 Aug 2023 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692476445; x=1693081245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV81kcD9vzqzEmQhBftWFfOiwm9XqB0HTp7lUGKFHuQ=;
        b=hZnuQQISbxby46D/lP+4Ei7dHYxRBhQic/eRN5kTkc9V6JZF29YKmpDTdaqO90yJJA
         EYfSIcO/LOPLEq/LryJpbmRKk1pANHtcF52CDEGEEzTwQ7V1I+1xp/sM81IlwNVFBwVz
         dafywa9Yd7Sp3koKHAQruHj7YLmXlH6EoyymrHyMCzJi8/kpCGSvjGKSXDI2uuSzKs9n
         c7/OAxWLuWY7G2UqXpJxyy/13i6rPI8Yfr9kF/rPgMiKr7pgPHC2lnGQaWD4xdPKZR4A
         ICUXRCijQfOfMnCyH6RFSn18f6fVgwXQoi0ABLTU/y1Oa+8xIxYyjKE1hBHYweAiN/Sa
         U5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692476445; x=1693081245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lV81kcD9vzqzEmQhBftWFfOiwm9XqB0HTp7lUGKFHuQ=;
        b=dxjWc0Q84yk/9pmLok2fna0f6Sm/S2CJBccZSZKOPN67jr2LP0SGdAJVEYehOzrhq5
         3PO3PG2vjPZhF2poph1QGtAI0peW0B931f/JkXfhspNQ6D/Vl+PWeyPxuQuF/d29byEl
         vWqo0wmkd9rCIhZm83W6DPZ6+Ku0ezTLRpLPLV6lh6JIY7Ob7+rQmwOUWjC96IOsxBco
         8/jG5QXj0xZR1rDmVZ7wlX+GOLxj3Ux0QVAXCLcbYEo+TSIu/uY3/7dz0eF7NCf2uUet
         /CwkW3M6B9opq6zg6K2cJbm3++w8+0ApFHlmPEvEQW8vATIHeJ//T9IMT5G7VR8GMYN+
         y+LA==
X-Gm-Message-State: AOJu0Yz5pqT9mSK2uqXfhZtS0EdqgaR8VTDh27RsgLZrRNoHlfCVKN93
        T82CskxkeHIhscWIU+Dk7uc=
X-Google-Smtp-Source: AGHT+IG7kGC5rBg79iPGG+ZJMpC1r0dYR+YIh6HwAHWdpK/oApVWvQK46aSWG7nYxgm3nf66BzKAUA==
X-Received: by 2002:a17:90a:4dc6:b0:26d:2fe5:ff2a with SMTP id r6-20020a17090a4dc600b0026d2fe5ff2amr2356147pjl.29.1692476445535;
        Sat, 19 Aug 2023 13:20:45 -0700 (PDT)
Received: from DESKTOP-7B1REV8.localdomain ([2001:569:5755:c600:f49d:4018:e752:1f22])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b0026b26181ac9sm5695245pjc.14.2023.08.19.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 13:20:44 -0700 (PDT)
From:   Qingjie Xing <xqjcool@gmail.com>
To:     edumazet@google.com
Cc:     davem@davemloft.net, dhowells@redhat.com, fw@strlen.de,
        johannes@sipsolutions.net, keescook@chromium.org, kuba@kernel.org,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
        xqjcool@gmail.com
Subject: [PATCH] netlink: Fix the netlink socket malfunction due to concurrency
Date:   Sat, 19 Aug 2023 13:17:16 -0700
Message-Id: <20230819201716.2430-1-xqjcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iJCDYteM_1SQ-h2=htUAE4FqrBAak0kHt_Z990XYZThzQ@mail.gmail.com>
References: <CANn89iJCDYteM_1SQ-h2=htUAE4FqrBAak0kHt_Z990XYZThzQ@mail.gmail.com>
MIME-Version: 1.0
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

This piece of code has been present since the Linux code v2.6.12 was
incorporated into Git management.
I believe this modification could potentially address the concurrent issue
we've been discussing.
In netlink_rcv_wake(), as described in [2], the socket's receive queue is
empty, indicated by sk_rmem_alloc being 0. At this point, concurrent
netlink_attachskb() calls netlink_overrun(). In this critical state, the
sk_rmem_alloc of the socket will not instantly transition from 0 to a
value greater than sk_rcvbuf.
