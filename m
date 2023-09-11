Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BB779C26E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbjILCMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjILCMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:12:12 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9CDE9D8D;
        Mon, 11 Sep 2023 16:19:37 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d7cbcfdf137so4361902276.2;
        Mon, 11 Sep 2023 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694474244; x=1695079044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPgMplOaghCKoaw6KVIn3I1GwgTSwBS4ON0Ej0Rg2ww=;
        b=jc7BIF6NZU8mIj2C313YafIAlP1V7KMkKA671ff3rlJy/gC6vfzRfXeiPyKFuEUb5j
         lx1Y1xJntmBmyoV41xefDnuBWSWYiSlWdrY9I8J02ZRby4cNxELseEaNpTok8ejPMlTX
         LrE0jTANl2Jmu+iUW/B0JF2E/nHGifwf6eHZ/nZ441/8WT5d7vdZX+pf4r3YwK+HQCwM
         bQSGjYSxpv15M3166EtLbr84J691yw6nbYFPnN6JN2YYXK77jmDGuji4XUYn6x5RvyhC
         qGbCK1zvsbMGi3WGdrvnx7pdRl0UgnzaiQTR/zNT8HYxDsaw+EgqI4kA0LNV0mgASuN4
         aejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474244; x=1695079044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPgMplOaghCKoaw6KVIn3I1GwgTSwBS4ON0Ej0Rg2ww=;
        b=ewmGvTXJJt1aQHE0JhAMqKH2i6iU11RL6sJc0fggrpBfXTwGa2mU6y12SS/UF4Ojtp
         h2JPdPFEJ2SGwPebKoxQXNb6ZcPPZ9ZntTLoGOpPxZm/ibsFiw6K0pubVQlsW9SVHtDN
         KYMXmfT9bDj6FCfEcwiyCAxcgoi9lrg7z3w3tZDgKll1cqiVzpFPpPzBR3DJV7BgHtls
         GaCdAw4o0X78D9yodNH4vDh5xAGDl9rHih2yy4egNO1cvtwE2gayIaOEDizaksZxsrqG
         /MjAr+VD9W5V++Hz0V9AqyvrBHAfFAVwiN2BR1fVAfj+mmlDfSRDRTQ2mVsq5ad5jjoU
         WQuw==
X-Gm-Message-State: AOJu0YzWzCwj4kmEjQyKh1AYClVrrwcguV7WH241ysQ8lWDDsvRmyxw3
        GFAroiiD1pf50BUtWIOkBgryz4Fjv9UKig==
X-Google-Smtp-Source: AGHT+IHX0TSt+caD80mtO3zdFhx13hIWLdOMsQp29S6Hbbwm3vaZvIW2jLmwTNt0GjAv/TclECpUsQ==
X-Received: by 2002:a05:6602:2776:b0:790:9f0c:3069 with SMTP id l22-20020a056602277600b007909f0c3069mr13263726ioe.9.1694473749038;
        Mon, 11 Sep 2023 16:09:09 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:09:08 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 21/22] drm: use correct ccflags-y spelling
Date:   Mon, 11 Sep 2023 17:08:37 -0600
Message-ID: <20230911230838.14461-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911230838.14461-1-jim.cromie@gmail.com>
References: <20230911230838.14461-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
which broke builds with:

CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_DYNAMIC_DEBUG=n

Also add subdir-ccflags so that all drivers pick up the addition.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 7a09a89b493b..013cde886326 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 drm-y := \
 	drm_aperture.o \
-- 
2.41.0

