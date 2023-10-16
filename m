Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E857CB4D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjJPUm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:42:26 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849FE9B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:42:22 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4197fa36b6aso29280621cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697488941; x=1698093741; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dG6puU4CvEV7aF+U/Mag7WkzVmM3GpbFWar+GBiCglc=;
        b=nvbQRF3t8YegiB+0SJGyM8G0tkCsCdwHErFqtRJEnemzQyc1dqhDEUT8LpcSNK+tv6
         evc3eMD/KfGZzvc9gRHAqPMHXdXn8WnzN3xhd+hMhUqoz+brdktJelPHJWox6vddFhXe
         ZBNwfL8QOpJBVbc7jLZKCXVVRm1LkPIMnH2jPV5YdGs9JzJeeNvuz5OQJlWyguAu3t7/
         KZ3rtyb49PR0uzjsu6GoUIZuvUZenjR7XeEMvN3GU7r4xq/QEhxgk1juWAHfyQVFtTm4
         MqLVA2VjcFNoRGuPTMovdGtkbNB5Vj9hllhoXVDw1hxN35gjsnefHUHVjFKvEbJBR2LX
         fqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488941; x=1698093741;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dG6puU4CvEV7aF+U/Mag7WkzVmM3GpbFWar+GBiCglc=;
        b=OmjOYijXl1f9NESqJ009VM8qCh1RpqPnSrL/gtdGTXP2Sv/UNZ/QOxtpaZwrrG3FKm
         hjXaEQ0gLul5WqbD/SKx42eJD9U7IW0EzFD0Nu6JUusn6V2Yk3MSNaGBxmGLWT7hJAvZ
         rKzoFY1jTeslDjg85NgZem5wwz9B1UlAxkRq5sRXix8n5kOHusCSoWdZiQNMMcgd5fpo
         zG1tYECtGW89fzjmvg1J3we6sYmSlebo0AsfFfS89OzDbF71DSbj5GeTxDK+gxcYHpWR
         4K4AD+mryb8T+utn26tJaLTh9QDXMGNh4JT/3yCcdj2/rgBWBsDrVPPygIwqDlnucTyq
         +GJQ==
X-Gm-Message-State: AOJu0Yy9jl+8f1v2X45c5Nf4S2+cUxnoRPwoxB0u9LK3598QqiT+OuZy
        W06reufbr8nR3YEVALAOhMFSHNTaRBxCl5c6NHrvFOUEdqVI/ZeAWUYVTQ==
X-Google-Smtp-Source: AGHT+IGF7iPg1Hiq6NhMvRzrdMr23M5AG/64g5y4mc0Q3T+MCjqAdXGcmSazqjBhQXhC3p0NqRfJsBe/KGDKnRMiVAA=
X-Received: by 2002:a05:6214:508b:b0:66d:4db7:4b6d with SMTP id
 kk11-20020a056214508b00b0066d4db74b6dmr595558qvb.24.1697488941498; Mon, 16
 Oct 2023 13:42:21 -0700 (PDT)
MIME-Version: 1.0
From:   enh <enh@google.com>
Date:   Mon, 16 Oct 2023 13:42:06 -0700
Message-ID: <CAJgzZorfiG26TCfwNBVYJkkkVBAQowJhRUtX4EzWSxwZbfNoyw@mail.gmail.com>
Subject: [PATCH] scsi_status_is_good() uses __KERNEL__ constants.
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this missing #ifdef, userspace code trying to use this header
directly won't compile. glibc manually removes it, bionic removes it
using a script. If we add this, the preprocessor can remove it instead.

Signed-off-by: Elliott Hughes <enh@google.com>
---
 include/scsi/scsi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index ec093594ba53..a585e2067373 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -186,6 +186,7 @@ enum scsi_disposition {
 /* Used to obtain the PCI location of a device */
 #define SCSI_IOCTL_GET_PCI 0x5387

+#ifdef __KERNEL__
 /** scsi_status_is_good - check the status return.
  *
  * @status: the status passed up from the driver (including host and
@@ -216,5 +217,6 @@ static inline bool scsi_status_is_good(int status)
  /* FIXME: this is obsolete in SAM-3 */
  (status == SAM_STAT_COMMAND_TERMINATED));
 }
+#endif /* __KERNEL__ */

 #endif /* _SCSI_SCSI_H */
-- 
2.42.0.655.g421f12c284-goog
