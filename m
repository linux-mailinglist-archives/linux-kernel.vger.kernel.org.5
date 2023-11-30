Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14CC7FFD18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376330AbjK3UvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376474AbjK3UvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:51:16 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DD71710
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:51:22 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cdd214bce1so1393610b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377482; x=1701982282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfXrVytW8Y4xCjr3/gaeCHfvnpxnYpvkHqeDQcGVwOI=;
        b=dJ9R1pwJMTPVhzdrYhLbJ8W9lwde+dJ/qNBb5KcVjm6+EceGXJOIt2sE2+QzauhBHL
         TRW4jQ61YcLTBFINAKki+zpg0qWVYOKX6SwjITD9pKYVCNjTJv+HZJyApoxgWzpdRbGK
         RGFfglNHb4e9DgGKT/j+Bpz5p2awanneFpP7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377482; x=1701982282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfXrVytW8Y4xCjr3/gaeCHfvnpxnYpvkHqeDQcGVwOI=;
        b=WOsfaSl00+uHBH+3A6VsP1btdc59e+gYehxJp1klfmsmGJ41ggaDMctqngZBXS0Hhl
         DznH75Ddj+k3hKzDkudFjfNJ9nszgH1ggCsjR6t92Bip975FlQ1XJjvzOWnwcCb6LVbO
         vvk1u2734xfcmCt/0ZS0ASJ6WPN5jPfWXP5zikicxszVfr2pz3cQ3C/V6+f7268DzVF/
         BnCNj5Q2R9UB0+0O00E5tDHBb6nVcANLU8LeHIp/HbBqrLUsZPXvB7QJqO34Sl6eE4oy
         rH1nybZ1+OIkqjIZdyWqHgG1xGsOMZlot95Bx6ngiI5/9JDFcITBWC1VkPYUFPQBT/kS
         hQgQ==
X-Gm-Message-State: AOJu0YzCpOcHOqrOC3L9KiHlPbPHT0GMgJ+Cx3NTBD0XqKk+AyHobVaG
        wRM8sWXiecBrCfZqN2nwqTdpBQ==
X-Google-Smtp-Source: AGHT+IFqQ2tMvaFz5HmonZHOZSdJGdUZgkkSvItnHyFbJfzglgm0Nzd641pdSg4DyaQY2ZQSUPU1Aw==
X-Received: by 2002:a05:6a00:8017:b0:6cd:e35f:997f with SMTP id eg23-20020a056a00801700b006cde35f997fmr4212615pfb.6.1701377481968;
        Thu, 30 Nov 2023 12:51:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h22-20020aa786d6000000b006cde4523767sm1644052pfo.22.2023.11.30.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:51:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Anders Larsen <al@alarsen.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] qnx4: Avoid confusing compiler about buffer lengths
Date:   Thu, 30 Nov 2023 12:51:17 -0800
Message-Id: <20231130205010.it.412-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0qK/8Psz3/9NxX1Im3q4MPGhQi0CsgBgrOpGBgXV7zA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaPXHiFovd++oDnR0c7ouJGNE/dKwiifPcyLlf
 BxYEhZAN/CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWj1xwAKCRCJcvTf3G3A
 JpZqD/9ccxMmnau5U6ctKyloMELcYhn18hIIYhEld/95TcvsFCH8Xn1gWf4jnM6fBhzjbMHL7vM
 FdZMtQ1r7pJgY9xAOy6BUbX+ujkp89xA1lREEil7ioxgGsQIFhfQTCyBDgLxOiuM+ZTzDWe8jI9
 P7X3F1lxG0o53OU9wmVZKaPnXgAZS2DZaFrXUFOrHJmBMLcCt1MJFkYqY3p4xQ2AaUiStQZWVd+
 O1cLTqWf1BP1FKuPMkHk/ioYCEl9ZVHOCu+mzOVp6xZXSUErstM4qf9cKLT2Sw5dAlg1Pzt0WH7
 9+17k/UEqMfBfiM77PhiNXvGof8gv8/q+MG1jmWXiBSZo4+tUO2nL9STnwBfXCB1AE6FMYHcmEN
 ueCb92HCmY6Xa9k7CD5EBSZJvJQ6gwXD0Vgmr+Ono8U+TjQL/n9SFwv+T2xELITi9xvd4Luq0NT
 BiHXq+BQA5x0lP0epsz0rZVgdFhxmu6WIpf0bE2sHw273x6XsoAPhblPDuMmMsmjVKLe+OCgDbw
 foI51L8vJEfoh+HJxo7S1R61w3Lr94N7oU6iN9YU1PUsGMBl2jL6xpxtnPwQiX/bQyqdUpxv7xY
 sWOmaVksXt+PQO8fm00bzGkqo7rGSqZ39kq1avwTyOZKBrHgE3bVbm5SAL49wC5AP8zPzHrc26U
 xWEewmde 3L/xIsg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
too-short struct buffer when reading the string, by using the existing
struct union.

-Kees

[1] https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmail.com/

v2:
 - Use BUILD_BUG_ON() instead of _Static_assert()
v1: https://lore.kernel.org/all/20231118032638.work.955-kees@kernel.org/

Kees Cook (2):
  qnx4: Extract dir entry filename processing into helper
  qnx4: Use get_directory_fname() in qnx4_match()

 fs/qnx4/dir.c   | 52 ++++++------------------------------------
 fs/qnx4/namei.c | 29 +++++++++---------------
 fs/qnx4/qnx4.h  | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 63 deletions(-)

-- 
2.34.1

