Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA4780ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378068AbjHRPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378072AbjHRPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:12:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242D6420F;
        Fri, 18 Aug 2023 08:12:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c47ef365cso136754466b.0;
        Fri, 18 Aug 2023 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692371547; x=1692976347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZnmcLyRXXMZRHPXrv6ePuzpP+/82gvSRdg+zxUbEoY=;
        b=PR6E/gu5dWaAGyXOLnmhr0dRrUQhWYq4G4mzcZDo6w4A5ZQo1LzuAqJh0orL5nMZGU
         CqMLt8bjwvOc/sRD0auPZ7jwc67DB5DmFMAueyJJUW6G2sp9gZHm1ZpDXT65CYvoWOZL
         E99LnOjVDA7+ZkvC6hcyZpMqTnbkmwh50V9l8t0tlC3PRWzFxslZeg6Aw6fzq3TkSumU
         EHkcjI0JFQo6oo9MwSQQp/ckZFmypzYOlU0GRxeG0cpneHRX1Am893WIjEGyQ0snW/b5
         xeDDq8L6SLE37QIf/7vy+G5GRid7LPsjYCvWlNYbKoQnJUAuLEHfWidU/lCoCbvcaLgL
         HHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371547; x=1692976347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZnmcLyRXXMZRHPXrv6ePuzpP+/82gvSRdg+zxUbEoY=;
        b=KtdQrs+mZlKXtZ+h0iMQQH6GAYaeQ2QrNB1CQZlgQ0637peFlFpar19xGZCbh07ZuN
         iyIbBhNO60L/h6rvGLo9LccQQ3C7KZnXVA51CgC0sNtuq2iKqitwGEo6NuiFXA6lPMEu
         +AAujJeJJr94G/cgg7SsXaJzqhB0BX/IZORzZ30E9rV/2SWpJdEUZV/5Dla0l25D3nOp
         yUMhEW5ew4A9zSiW9GpJurVeL9zPytRZiCObOfrnshVUL12p1PTfQoNnVjrDWK6Jcuks
         dpX1fqmvgiQiTLgeSANWhjzLIkwZiibmOcdkMNSlsCBEgZNWZfAvanDHsn82bS8FyKTh
         kBJw==
X-Gm-Message-State: AOJu0Yy/6Qarv6NIvAOaPbqvNHR+KnxErQ5VJLYKMjl2Bl6/rfzwsdkL
        KqqIQud7IhvZL8/KE9VddydDn3CNR/p0xA==
X-Google-Smtp-Source: AGHT+IG8jWZ6cYQXclRyWxtIZ9h6mMLk3fFHxvoLhY9num9K8nCMXsx7+gnX543S9aZ9GZDWfVBamw==
X-Received: by 2002:a17:906:74d7:b0:994:56d3:8a42 with SMTP id z23-20020a17090674d700b0099456d38a42mr2235318ejl.27.1692371547308;
        Fri, 18 Aug 2023 08:12:27 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-071-217.95.116.pool.telefonica.de. [95.116.71.217])
        by smtp.gmail.com with ESMTPSA id sa19-20020a170906edb300b0099ca4f61a8bsm1285913ejb.92.2023.08.18.08.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:12:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] selinux: improve debug configuration
Date:   Fri, 18 Aug 2023 17:12:14 +0200
Message-Id: <20230818151220.166215-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818151220.166215-1-cgzones@googlemail.com>
References: <20230818151220.166215-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SELinux debug configuration is enabled define the macro DEBUG
such that pr_debug() calls are always enabled, regardless of
CONFIG_DYNAMIC_DEBUG, since those message are the main reason for this
configuration in the first place.

Mention example usage in case CONFIG_DYNAMIC_DEBUG is enabled in the
help section of the configuration.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/Kconfig  | 10 ++++++++++
 security/selinux/Makefile |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index d30348fbe0df..61abc1e094a8 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -77,3 +77,13 @@ config SECURITY_SELINUX_DEBUG
 	  This enables debugging code designed to help SELinux kernel
 	  developers, unless you know what this does in the kernel code you
 	  should leave this disabled.
+
+	  To fine control the messages to be printed enable
+	  CONFIG_DYNAMIC_DEBUG and see
+	  Documentation/admin-guide/dynamic-debug-howto.rst for additional
+	  information.
+
+	  Example usage:
+
+		echo -n 'file "security/selinux/*" +p' > \
+			/proc/dynamic_debug/control
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 836379639058..c47519ed8156 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
 
 ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 
+ccflags-$(CONFIG_SECURITY_SELINUX_DEBUG) += -DDEBUG
+
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
 	     netnode.o netport.o status.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
-- 
2.40.1

