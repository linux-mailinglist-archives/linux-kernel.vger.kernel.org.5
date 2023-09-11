Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE72279C4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjILEVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjILEV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:21:27 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483A8F90D2;
        Mon, 11 Sep 2023 16:23:27 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6c0f4ad9eb1so629500a34.1;
        Mon, 11 Sep 2023 16:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694474467; x=1695079267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeh7PAP1bDfU/ByWs4XqsTralpUOih5UTW3jDedZc7E=;
        b=aWk6fP5B+l6NF8pnFBNWJhgtm5EXC/EQdepQUjZlgCTJxlX8y2+9R1c7JvDsmljY3x
         slSGvgrBGDk5MRfCNBUvF6xyaagvjHaqEI/zoFUuD7nrQ0u2coHoO77XeU/KAADDtnKQ
         EWYcRbzbNP22BJUJYw8UlPrZYJaea57l5cT2eHc6lt/JdUlr0A8rEZqekiVd78+S/Nwd
         7kDKRqSTYVqPNFlyGm8YO1lq3UvtfP4sZ8HUF7C4L4ae/ifLaddLLOE6bkzy0TLJaRnT
         UOqHDHNccBLnq7ZyhRBdT57sf1Ak9SsY+dUBHT+oPf3fbfVkXCDjxSjafRj4JYmLsSHf
         gLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474467; x=1695079267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeh7PAP1bDfU/ByWs4XqsTralpUOih5UTW3jDedZc7E=;
        b=kkWrNKy7HtZuajMmNEHRVfWyVjmPhNlxTXZDjuZRzKza9JSm9QHqlMAsbJojeFdMud
         yTtKsybUOQ6JHYg2BXQdvpPtaeetnT2ZlNkEvJ6BwhJW0Kx88bJFRxaf0OQWjcX3ZtSy
         1exzrgpmbzHA+rO3tcly4663vn+b3iRJkS0f9vw3HXz7ygXHm9VnQpEUDrPqDtRrHzms
         B7RmTZX/ZOzS4yPKuAVZz0LxfKWeiBRYC5ZqgDw00kSN0KL7TpCQiznuSfU8xrS1gYDi
         Bx0TRSaNIHuYu2xFh+SitKhRSl4M73KnPaVoFR7G+fWh9vLFqeCjVIS7SzKArLNDCsJa
         l9rQ==
X-Gm-Message-State: AOJu0YxoAzAAeDcy9dXWYowboUkTcIcLOIjQuvlWBm3wLKLBosc2ABO9
        Ce8Hb1A49rJ0pMFvkSJfn/18q7p5yWjfbg==
X-Google-Smtp-Source: AGHT+IFOVUo/VwcxfVY8ZADs8CkL6phLCtLh6KlZ/IQ/cX8VOt/0wmLERhDHtLnKqrozckRxSOEdzw==
X-Received: by 2002:a05:6e02:1053:b0:34c:f665:861e with SMTP id p19-20020a056e02105300b0034cf665861emr12027086ilj.21.1694473745039;
        Mon, 11 Sep 2023 16:09:05 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:09:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 18/22] dyndbg: reserve flag bit _DPRINTK_FLAGS_PREFIX_CACHED
Date:   Mon, 11 Sep 2023 17:08:34 -0600
Message-ID: <20230911230838.14461-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911230838.14461-1-jim.cromie@gmail.com>
References: <20230911230838.14461-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve bit 7 to remember that a pr-debug callsite is/was:
- enabled, with +p
- wants a dynamic-prefix, with one+ of module:function:sourcfile
- was previously called
- was thus saved in the cache. NOT YET.

Its unclear whether any cache fetch would be faster than 2-3 field
fetches, but theres another factor; the 3 columns in the __dyndbg
section are highly redundant and compressible, but to get the
compression, we need field accessors, which will rebalance the
tradeoff.

So, for now, its just the bit reservation.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 15edac27cb56..bdb0d12b13ec 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -38,6 +38,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
 #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
+#define _DPRINTK_FLAGS_PREFIX_CACHED	(1<<7)
 
 #define _DPRINTK_FLAGS_INCL_ANY		\
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
-- 
2.41.0

