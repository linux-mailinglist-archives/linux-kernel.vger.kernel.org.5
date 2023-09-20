Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761FD7A8089
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjITMhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjITMhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE62B99
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48G0tj5zzQRFiALYPkyRPndfaCR4k/8e83lXW3c50mA=;
        b=hNGarVuNQTYpHu0dIy6D7DkVZ3BtBsKZP+rAkR2t+qQCK7txZUDtHcgk8ud0h56wRapW4h
        CIK6IaZzuC73wEPeNG+uvt8cA8vfe+qhMzmmEa7LuhM+YffQrKy1UddzXUtPSiH/7mHNnu
        J0dZMxRpBAZ/ChyUVBDcj5cp8ugr7Mw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-6trbgUiSNQOB526Ip8sphg-1; Wed, 20 Sep 2023 08:36:50 -0400
X-MC-Unique: 6trbgUiSNQOB526Ip8sphg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso154936466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213409; x=1695818209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48G0tj5zzQRFiALYPkyRPndfaCR4k/8e83lXW3c50mA=;
        b=uofIbssM0MyI1vTVryopLkvlkj7ynySuqXAki8rAvITsirgxpkfL1HYHx3RfgOe5AZ
         NGv+Q5A3TIOQoj0uaNphvoadZ2oVF7YcPAv9aO78vezTBVL6SLA30cm2rH9vp0wdwLQS
         up8T8c1MzcJYGk/CKPVdFGm6DH2GppNjTL8Sky0VUJij/2Z8m8rubgx81xXNElpYVmPC
         d+x7U8Bdzd0QXEbIsimt0/Uz/8DuQH3gqqBnfrnFg96khaenDjJqmCpjhC6CYrxcFAAr
         4JdnEqc+KTITkZvy40yx6tP7pMQjKxSCm8jPr2eLIRqEU2pRFgnNUVBgs0s6q5VHSAbd
         rvYw==
X-Gm-Message-State: AOJu0Yw7lfwCBkd8muEAvCHU2BkP6sTVu6bldlaQYJO5KulWPFmkW0+W
        B0HrpSPXLFq5hOHvx8xMMfoLg9DuGUJIZhVPKgysWyJMwDyX1V5meX8kzvyNPbV8w0vtXhJtfB2
        BD///p3IccCJ6tNI7li+kZNdC
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr1444624ejc.6.1695213409774;
        Wed, 20 Sep 2023 05:36:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmJTym5YvZ4MH52qjmmgnlm70HGxEIyE84IZpdWdDkioxeqQ+sBFeg2a5b+qpjuhd9RNuOjA==
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr1444608ejc.6.1695213409547;
        Wed, 20 Sep 2023 05:36:49 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709064ad100b0098ce63e36e9sm9447247ejt.16.2023.09.20.05.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:47 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/5] kernel: kexec: copy user-array safely
Date:   Wed, 20 Sep 2023 14:36:10 +0200
Message-ID: <20230920123612.16914-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 107f355eac10..8f35a5a42af8 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -247,7 +247,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.41.0

