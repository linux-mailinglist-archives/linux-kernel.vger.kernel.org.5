Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504F7781DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbjHJTya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjHJTy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:54:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29C82720
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:54:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53482b44007so882875a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691697265; x=1692302065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AzFyigJ847Mx7E2oFBB8SMRyOnv8+4md/Rgc3rIkTY=;
        b=EhymeSt9AwGdnLF38z1BWoMcYtzxxbOkqvwmhWp/GRcUvwylg9CoK26H1e3AGke8+B
         RPety8gwpWVVuXWVCYQ3s1K3sd50189fikQk3mSOocuvNuuiO5MVVxnZBq2+8Iy3GSEr
         GVH5i8CrUQaibx4+voYbDmJYrn6UTF1rIVDow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691697265; x=1692302065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AzFyigJ847Mx7E2oFBB8SMRyOnv8+4md/Rgc3rIkTY=;
        b=O3PZ50XKXmZHFSpcCacc80Or0b1PQhXGqjq5fxjLeQT2uwVvdtzaXBBbg7gpoSVPXa
         YEAQPEpDpRJ4b53+TjaqeKBu2+KUcH38XNR+Wdi0NnZNuTjYNxpHUbQJdg69jz603TUh
         wlj2EwMDHVTVkR75nK0SyTEL6JNbjp+xtR5nLVSz0bKIlVHYM8e8GywkG/C5H+YyqHNe
         /jl5nI/RKXzX7ftv9+oC4Gm12JJhvvtCyfZxnc+wRaJwM/eQzksciksfUg7gCZqb2but
         zgW6Xa5YzrZpJfLFGrnMOYrdZ19Ro9a/9YFZWUPV70sKn0yQy4WlMsZBh0S3Cb1WaA2L
         UcMA==
X-Gm-Message-State: AOJu0Yx6oHpzaZEpf9k6YJ5yKzHWQ75axP+JA1GZSkXiojG+A+YwqcBK
        8sTpWCgSzrmXZA9Cxjl/BC7UJA==
X-Google-Smtp-Source: AGHT+IHf7dBPbEfSl1xqIGQRGLihbjGL2keEOoa4x4FFnpIIuQxIh6x560I9zGOiV02ODZa7GkaZmQ==
X-Received: by 2002:a05:6a20:4424:b0:140:54ab:7f43 with SMTP id ce36-20020a056a20442400b0014054ab7f43mr4680369pzb.52.1691697265119;
        Thu, 10 Aug 2023 12:54:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u9-20020a62ed09000000b00668652b020bsm1890241pfh.105.2023.08.10.12.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:54:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: ptrace: Restore syscall restart tracing
Date:   Thu, 10 Aug 2023 12:54:18 -0700
Message-Id: <20230810195422.2304827-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810195141.never.338-kees@kernel.org>
References: <20230810195141.never.338-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=keescook@chromium.org;
 h=from:subject; bh=PM9VbACsiruUm736SKU4lZ4ZDYtSsZTBmd3nctTMIWk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk1UBrSDo2U2GotGsBMY+sQ1nnEqac9N2ubUHNK
 geMLpezF8yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZNVAawAKCRCJcvTf3G3A
 JgEwD/4/PU3jZw0GGsDb1rhpeL2CWa374R86q0eGZC9bP7yNGHj2MZNotCIzG1ln7HnfvVYFEqj
 ImnJ1VEoF2kur2GameknXgNcAnswvPigS2VhmBQwdreCXLTctILVJ6xaNWv9zI7s/o8S2qRk3jx
 tLChRFwN5bYukIbOiCVJi0/ZlsEbrkv9KJ28UEoH+l52omPYycquPtuUAyyXjd/xqDSxNe8GHTg
 QPQTl40snYaEBVFrg4IYKAEqDn3MrTuaQh30+kT0is+AlcENKEFbC83w8dijgS+NDGYtqPW1Pum
 9wi3XC+PwGwDRMC2GBeIx/DMCWEE70iElmjUXaljFYAS2/Qn59GFtgeFca3bYN5R9VPBhI1UrBv
 /guxuT6h9WK0dK80nUqcPeAJyfQt9pOUleFh3lRAEYjCPJF3/eM0JRLofpZ/eJrvoqypt5ON8Vp
 90Qs6Yt1qvpF1b1kQqdrGNrG6NR1t1KmrcvoK/FvdJiLQh1uQ/P0sCJsv0sU8HL0XA3/KSORI7L
 vwl03qLaPkhHsbWxFWQKV+VGlVfniPDjLaDUiFEMiAkAXx3mla223m6DGkZex8RIy7IzHKQiLZ2
 6kZsj36XGm95XXJXq84VUgZfPu0oxDYeq5c+v0dlZgj2Vz4UqwZB9lEef1mWbHm8S64fjs1a/g4 2hN+/trZF0WnbKA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store
thread_info->abi_syscall"), the seccomp selftests "syscall_restart" has
been broken. This was caused by the restart syscall not being stored to
"abi_syscall" during restart setup before branching to the "local_restart"
label. Tracers would see the wrong syscall, and scno would get overwritten
while returning from the TIF_WORK path. Add the missing store.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store thread_info->abi_syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/entry-common.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index bcc4c9ec3aa4..5c31e9de7a60 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -90,6 +90,7 @@ slow_work_pending:
 	cmp	r0, #0
 	beq	no_work_pending
 	movlt	scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
+	str	scno, [tsk, #TI_ABI_SYSCALL]	@ make sure tracers see update
 	ldmia	sp, {r0 - r6}			@ have to reload r0 - r6
 	b	local_restart			@ ... and off we go
 ENDPROC(ret_fast_syscall)
-- 
2.34.1

