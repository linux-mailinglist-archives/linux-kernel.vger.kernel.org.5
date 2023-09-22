Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FFB7AB7E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjIVRmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIVRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:42:22 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E05899
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:42:14 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57361de8878so1297140eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695404534; x=1696009334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aju3+JSf6eGUIv+LcbKwNlrE4eQbXi+VM+zVoGclrt0=;
        b=IDfbgNZxe2wGlp4dphr/NIwpb4Fi76oZ7dicLJyK52GUDOJHBljWuoM57DtqMU8D99
         /h/Wacf72gDdfu3yT02N28QDBV0T9WEWPBQ5yXu+yn21FnrGegWRODzOx0Du1iPPfiiU
         bJL0ZqTYwM7reW2uU+qFUManJ2FRY9z+hrBQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404534; x=1696009334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aju3+JSf6eGUIv+LcbKwNlrE4eQbXi+VM+zVoGclrt0=;
        b=EHgN7n6pBOMiZfFSQzIVYV92rLh3vKjjuk+YSDXUayCUnGV4LbVQ+FHcGvBPKUC0mr
         994XLSIHykJdmSSEEeyUW7kgvb/H0zm00qr4PNAYDxyXvx666NYlsZ9EuHwLxRYNfsVa
         cOeh6U/AyUgZN/VCBrih3ZV5ebFZ/RngckRggs2l+l94+yIR+iyGICLPRO1U9H3NmnNa
         dVMEEoy+Hhv6e4TjYN1t8Hyu/SO2oF1u29+PBdNNC5nflkpGx4qn1fozeTd5DtXKicKl
         l/N390rijoN/dJU9brxEvJnxtg95ACoLb4DJqEkBwT/vtEtlq/tDf6Knej1oztTjv36G
         Gucw==
X-Gm-Message-State: AOJu0YypCHWp2t/ega9SJQRYlyUXFC6F0Q4N2KDP3W58nS5lUQw3ljdO
        Z1CLTgSh73xRAHpHUjltitL9qw==
X-Google-Smtp-Source: AGHT+IEB7Uya0pjQSb5rvbW6cOeUYseQfbC+/qu/95o4dNfLB8KpYlxWTd9ON1NPF1LX/xhEFubnCA==
X-Received: by 2002:a05:6358:5906:b0:143:935a:a096 with SMTP id g6-20020a056358590600b00143935aa096mr389953rwf.2.1695404533707;
        Fri, 22 Sep 2023 10:42:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y10-20020a63b50a000000b0057412d84d25sm3385998pge.4.2023.09.22.10.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:42:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Airlie <airlied@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Emma Anholt <emma@anholt.net>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        John Harrison <john.c.harrison@Intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Melissa Wen <mwen@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Le Ma <le.ma@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Prike Liang <Prike.Liang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 8/9] drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
Date:   Fri, 22 Sep 2023 10:32:13 -0700
Message-Id: <20230922173216.3823169-8-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=keescook@chromium.org;
 h=from:subject; bh=arqXb+Ta6Sc7/P6cgbiuTW33qm7tl3AbrpWLIpWMOrs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+eMheJSZWlkxEjVkQYSxOb48cD+nN4OVb7V
 LKQ+3uUqo6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PngAKCRCJcvTf3G3A
 JrX8D/4u4mGTNY0H31raYIAy39e0MQyr+8F7lCaJtmz2p55bHTGxLREiFkYdiEpuailORE0wwsW
 BdlQDhRjLTf2KU9T7kldf6gcsBqFx5GS03UQDFirRowApSq5fh8IhxpEuGCuARDeUQrxNtmKCN0
 kN+bcH9BoSyxbEJQzpBBCbp5RMSt4XXDDkDi3oSsbZuZRkPmbszcp8iXrqUoFv7S/Vb8X5tGSRw
 nMO+fGglPvpNerLuaODEVbqAcj6XsI5FnEUPAbqIRdOyr/vAf4ZrHXXTeukSN6uOcb1w6XAw9GC
 4wnO7W4eW8CaLB6Kn2OhET6y8+h69ft05VnFFrnCTVxxJScjLTXrSCCsV544YFnE9eWFcjVivpW
 F3KuWexvi43Nc986ga140ka16uCaP//Thnt3s311iQsr5hvWJH4fkl32zdBPXWCwGX4ceRWSch2
 JEogxta26Yvy5CIJRHdU1z5humCdNzFVvMxbgMwQIRSKyKG1M7mMT/nBOIMfytjgY8S0vaBALVu
 EciVOC1nl86GXTm1b+MB9R8ZKZyOZPrX7vK8PyRCASDUnCN/37sg23Cq5Aqn4UUJ+sZeFPAF+11
 o0r5FyrPrmPW3O3hQUprUGrQsd68XMRpXTFcnKOPsEaG9G23VqHiDSPPILF+sczZ20HKQ+LMyhP 63vfZbPCZqHgx8g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct vmw_surface_dirty.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Zack Rusin <zackr@vmware.com>
Cc: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5db403ee8261..2d1d857f99ae 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -77,7 +77,7 @@ struct vmw_surface_offset {
 struct vmw_surface_dirty {
 	struct vmw_surface_cache cache;
 	u32 num_subres;
-	SVGA3dBox boxes[];
+	SVGA3dBox boxes[] __counted_by(num_subres);
 };
 
 static void vmw_user_surface_free(struct vmw_resource *res);
-- 
2.34.1

