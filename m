Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568F77D8D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjJ0DVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0DVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:21:15 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEDA192;
        Thu, 26 Oct 2023 20:21:13 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so1378578a12.1;
        Thu, 26 Oct 2023 20:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698376873; x=1698981673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOrCwkVqAlNg8XVEkShhR/7wXoZRdI3BqowEgZUE1O4=;
        b=g0quwld0z1luK9L41eHrVxqC9I4m0j22pE44IL1XxLqhsl99HfJ0vnVRYbIvltD0nl
         XxreSnJxoi8Q9nnnO0zC11IUcciA1iBiBgfyFJBC4XiT8iKXiZ6Id8N059efF7cS7rST
         c0LmwVCizpj1YD2Sna9a+l5DKoopY5CMwh1+gEB0h8Pyq/9zDjjU3qaXm2WtxTBpDgCs
         hdEE5qypBjtxqd5qUkwHT0knkOBIvavm/cpfU6s2e+T6CzpMXqmu1721of0uGAYbJGur
         EELxlrCTseF/XxKvv3wsBi8WC1ddrgf4QYnITOAQfKGhbMM1ItrTaHNt65pMZNV6sEdx
         mQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698376873; x=1698981673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOrCwkVqAlNg8XVEkShhR/7wXoZRdI3BqowEgZUE1O4=;
        b=cBAjNUz5nIqjD1TnWzSPnwX/s9xPR4pWmdxKF72R1icWMeRWAKerekUBPKr1pYPOsz
         LmFewH4xHIcj8WHg7lq09YLPVt2AcvYmirQz3qHE7wVn+/cOSO8Tm0bRpntRh47S1eQp
         q7KvGf20g+64/gVailCXZHt7K6EuP4wDMtt8zROMRJk75mhVgE5pImb+9r7+vRJ0jB7S
         NHw9IbJ5IBniTgdOSsANVKk//sMPNt4J7HQtt3t42EamBdlXBIZmnb8xOJnYw5n4ihzp
         khF+L1r2Mgprw5c8vGBDQVFANDwaPbRxJBOcuLyWDuiD4tbPlMLU1uBk9oCiwTxQjXaW
         wGaw==
X-Gm-Message-State: AOJu0YxMZ7SUljgrfILVV3Blsvy8LYS6eq0ctt9OQ8Z1cx6237ByyTtD
        CmOBx+LYE7vh7XdPmko5HSc=
X-Google-Smtp-Source: AGHT+IF8GaXXXaQ/WstxXLpkxPjYdO2zjaPFKSKhpF7yx6Jep1hBAhsv1xFt67SGFv5fu3Se3+hWkg==
X-Received: by 2002:a05:6a20:8417:b0:16b:f4ca:e3d9 with SMTP id c23-20020a056a20841700b0016bf4cae3d9mr2091859pzd.27.1698376872720;
        Thu, 26 Oct 2023 20:21:12 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001c41e1e9ca7sm409771plg.215.2023.10.26.20.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 20:21:12 -0700 (PDT)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     yakoyoku@gmail.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     gregkh@linuxfoundation.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH v2 2/2] samples: rust: Add USB sample bindings
Date:   Fri, 27 Oct 2023 00:21:03 -0300
Message-ID: <20231027032106.155493-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027003504.146703-3-yakoyoku@gmail.com>
References: <20231027003504.146703-3-yakoyoku@gmail.com>
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

This was missing in the patch, but you get the point...

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c41eaab4ddb2..845cdd856981 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/errname.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/workqueue.h>
