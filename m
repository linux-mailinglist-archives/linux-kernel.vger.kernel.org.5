Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0DE772AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjHGQeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjHGQeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8251FCC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691425974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSJyklWcOYLh1Y7SYk3LyH530BHSBws8fX+6+9YjAp4=;
        b=igZuQeFqf5k5ijkDO6jpmgVZYxEegmCdOr8j6dMigsLxETSDUrlP3ubmDPwxUqJFFSoMSY
        mU7JQqUO7HGlXBHYjKuXqJE/f4/0pgdmfmULJAVpTVat3KC3Dp6c9rOJIweGcWzaHs0gR0
        R8GkRa8iLW5x/G64VnkXALCSvgrY6mA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-iA2jRbI6N9yeRXxyAE1Otw-1; Mon, 07 Aug 2023 12:32:52 -0400
X-MC-Unique: iA2jRbI6N9yeRXxyAE1Otw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe2631f5a6so4479056e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425971; x=1692030771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSJyklWcOYLh1Y7SYk3LyH530BHSBws8fX+6+9YjAp4=;
        b=UwhqhTb0VBOHDfdZx0LtTwicKENFRlzniWWr2u8mTM4weUMT9+rI+vtflPyNu42qMO
         oTim800UAIKSiPLZ9EWXIHGzXyq55wGQn967X5mDSXCppwRrWToQ+93W8dLDUtyftOg1
         LJyDEc6TsbgAalNtU1rUhK8D0Zycpr4fsHmQEPJ7E/RspPPKCyRF2Nfz8aHYtw8KKt6r
         i9xoOBpzjJB/t5WPBI6Quv0eG3Kxt5+/xNQabMQhOL8n0RbS71eKcva/8AFCOSLLnwoW
         0hou7t+yMSJHguHqr523gfWN5nvgIchJSw3ENbRavajK5EVALErderP5Kvv454n/1nsQ
         UhXw==
X-Gm-Message-State: AOJu0Yx2hgVVhT8LsZT5E3YQaXLefRe4hMqxNKQBpFOzIvsQdnaG42QR
        vzL/I7ZqQxw5Hz9vCd4N2sfA9CkK1U/lE4F0zHPgHl1QJjjAUDfYcXkUv7WHH5Gtldn5rhlWCit
        mSCi+9tLra6yu1tD+pviNhy5j
X-Received: by 2002:a05:6512:280c:b0:4fb:744e:17db with SMTP id cf12-20020a056512280c00b004fb744e17dbmr7711102lfb.1.1691425971024;
        Mon, 07 Aug 2023 09:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFTmw8BlSLd66bLQQphUvYc14k91eYxq6U+Y6ebxxfanOvKoolnZuNuEXZTLdCuMfe0V95eA==
X-Received: by 2002:a05:6512:280c:b0:4fb:744e:17db with SMTP id cf12-20020a056512280c00b004fb744e17dbmr7711084lfb.1.1691425970741;
        Mon, 07 Aug 2023 09:32:50 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id e26-20020a50ec9a000000b0051873c201a0sm5377862edr.26.2023.08.07.09.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:32:50 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, bskeggs@redhat.com,
        kherbst@redhat.com, lyude@redhat.com, sfr@canb.auug.org.au
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH drm-misc-next 2/5] drm/nouveau: nvkm: vmm: silence warning from cast
Date:   Mon,  7 Aug 2023 18:32:23 +0200
Message-ID: <20230807163238.2091-3-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807163238.2091-1-dakr@redhat.com>
References: <20230807163238.2091-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast the integer to a pointer-sized type first to keep the compiler
happy.

Fixes: 6b252cf42281 ("drm/nouveau: nvkm/vmm: implement raw ops to manage uvmm")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c
index 38b7ced934b1..46cbd4cedb78 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c
@@ -399,6 +399,8 @@ nvkm_uvmm_mthd_raw_map(struct nvkm_uvmm *uvmm, struct nvif_vmm_raw_v0 *args)
 		.no_comp = true,
 	};
 	struct nvkm_memory *memory;
+	void *argv = (void *)(uintptr_t)args->argv;
+	int argc = args->argc;
 	u64 handle = args->memory;
 	u8 refd;
 	int ret;
@@ -418,8 +420,7 @@ nvkm_uvmm_mthd_raw_map(struct nvkm_uvmm *uvmm, struct nvif_vmm_raw_v0 *args)
 		return PTR_ERR(memory);
 	}
 
-	ret = nvkm_memory_map(memory, args->offset, vmm, &vma,
-			      (void *)args->argv, args->argc);
+	ret = nvkm_memory_map(memory, args->offset, vmm, &vma, argv, argc);
 
 	nvkm_memory_unref(&vma.memory);
 	nvkm_memory_unref(&memory);
-- 
2.41.0

