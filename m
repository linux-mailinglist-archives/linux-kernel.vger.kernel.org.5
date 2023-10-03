Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248417B708D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbjJCSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjJCSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:09:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219C8AC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:09:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c6185cafb3so20855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696356552; x=1696961352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5ADml8UEYFyYxVl60KXFq6v7496GwJKAXl/Dq0m1dI=;
        b=RRxdlsuQc0jVRVXE9oQ6YyG4Q3I6bHV4f9kTbEr9/AvfmyMEOr8eYivSIsuF0T4Gh8
         eHH05eftwvm8/ZFQxEaP0+NKz5xNZ6BGeOETtoW1oacstw2MbGly5G24p1L4ANK0tX8r
         Ay4NdgBNv+5fWg3DE5mAHbt/b3Rs4sYRXyL3Rt7n2dOTpyiMLwUH97p40WQKFFwxmgVJ
         coPZ6CSJXV2wYzsSvr+L37xwnmSO3HqLt5RHlCuGqudkBynYUsRVI7CbbQndnhy6+NH9
         vn/fdXPgmdM3+wOpxM1aKESOKV5+VNtxC3kTCUEnpxqQiDnfxLZV/ehQOMUIjX5ys3Tf
         skZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696356552; x=1696961352;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5ADml8UEYFyYxVl60KXFq6v7496GwJKAXl/Dq0m1dI=;
        b=M38jGhvrl6Ees/ervdjpw4ZpqYaLxCtEqiz6IclmgH24PvoDs/78BaUsY3xLa15FD9
         qrTDWIcjO2QoU33USG+YBz33PNBSUmWUdOEH7Qxx1ewK/efGINdoA//OMJaGzkAP7wuq
         90sDKf+lZnKTRrv4Fmi37NNxFtl7i0q7YqRHwPwAc21QWYJbVcQc+mViyv1wD9nxIP4K
         OFjMjRMzbbeLNGDclSUJwupa8apr0HPF5KoCkYZ88MYcMIhbQ86XeRLJR0NYQZW9+DfM
         qpb72P8B5A9AQhJDesLQpp7FKYhIDT9HNzUot+jd48y8zsI2aFrL50arF8i1/3gp4Oo9
         Lt3g==
X-Gm-Message-State: AOJu0YwDhGIPz3rFnYaoH2+V6HtgOsOr8MXQ31tZPFi2hTmbJpThYu82
        BKmlRzrY1Zx4mFP5qpH0WBveBa07yfvlDg5IcT2V
X-Google-Smtp-Source: AGHT+IEl6IJ3DsIw7oyXRf7R7HS8s4r59Isc2f9JN+K4IY+u/eiaCuHNxh0RznXZ+FmVCsNdWoBLHGhb923Bp4V1USc=
X-Received: by 2002:a17:902:dad1:b0:1c6:1e4e:b770 with SMTP id
 q17-20020a170902dad100b001c61e4eb770mr19311plx.28.1696356552314; Tue, 03 Oct
 2023 11:09:12 -0700 (PDT)
MIME-Version: 1.0
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Tue, 3 Oct 2023 11:09:01 -0700
Message-ID: <CA+ddPcPS8oUsMk0ziumwdTTWetekE37cK0Gkt9x5w2ig1m2pXQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] drm/mediatek: Add interface to allocate MediaTek
 GEM buffer.
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, drinkcat@chromium.org,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Sung <shawn.sung@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>
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

You can remove the DRIVER_RENDER flag from this patchset. That should
not be upstreamed. The IOCTLs are still needed though because of the
flag for allocating a secure surface that is in the next patch. If
that flag wasn't needed, then dumb buffer allocations could be used
instead.

Thanks,
Jeff Kardatzke
