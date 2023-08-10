Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552B5776FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjHJFgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHJFgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:36:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D87610C0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:36:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-790ca0ed6d3so16024839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691645774; x=1692250574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EslHdHq3bNylyhIFtlknMEJBi77orec+gHJpWqTOmeI=;
        b=K4keDQSP/3U2u7hxvZVjvxEjldSgp5MMCthaOwh+Wnk+OQEYA0zl85zPmtk4ClTXq8
         UsvGm1ms/3SS7kCKPdKqSdYYUwAa+u5QtNap8G/gC9Ywi+m4unJSas73ZZpml4vukU87
         4ruzDPC0wzjCIBqRIQb5aP/zUg++jShfPYlJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645774; x=1692250574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EslHdHq3bNylyhIFtlknMEJBi77orec+gHJpWqTOmeI=;
        b=U76As80tj2j7+Y0tuTp40gZ9rOqvvZjPi9i+wtVUhYDj8TkdbW9Au97NrFRfZAelv+
         mmcElhnLrLskk+JCJKl2OHnwrmFVTQAejX+/TU45IeCqFasNO0PvVOPhVZO2xYuC7yiy
         poN9Rg7XovM4LOq1ozjs7xUzupeHICeShEmv4NGfFJvYM4NiQmaOLke72tXE+6cNi8wh
         KLHkH0K2GXayc2sJRSRmX7M4EdyDvI9hVNKCJ398mM9t5tlol0PTSNyhYunKn9q14uAG
         /R1Hjd8hGcNifdwOKTfCsDnirL2WF11v7U2A8ProuJOF5zNtyukmIexd/eLLU8pOVhh1
         eahg==
X-Gm-Message-State: AOJu0YxV4+KD9t9FKmJ5B8pbyQi3oRC4o4qgeW+UZ/D89I229Nn1d9ys
        KICuHf2qn4lm3t1zCIi3D7YtsUXMYxEhMTGBbYg=
X-Google-Smtp-Source: AGHT+IHeZnsQEt3GbWFj5YWKuDxQCr8jWy/dIfuYOWYxZ/OD66Ks8BVBuUTo6wH0EL24eVuTHEym+A==
X-Received: by 2002:a5e:8917:0:b0:787:1697:1b3b with SMTP id k23-20020a5e8917000000b0078716971b3bmr2155222ioj.8.1691645774543;
        Wed, 09 Aug 2023 22:36:14 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id d19-20020a6b6e13000000b0077e3acd5ea1sm245340ioh.53.2023.08.09.22.36.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 22:36:13 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-790ab117bd5so16774839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:36:13 -0700 (PDT)
X-Received: by 2002:a6b:db15:0:b0:786:71d0:ff9b with SMTP id
 t21-20020a6bdb15000000b0078671d0ff9bmr2208984ioc.10.1691645773129; Wed, 09
 Aug 2023 22:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com> <20230809181525.7561-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20230809181525.7561-3-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 10 Aug 2023 13:35:37 +0800
X-Gmail-Original-Message-ID: <CAC=S1njMfS4LBxXg85b4oiwfhXNv5-Bm9+S-ZqupfiWUTs0ssA@mail.gmail.com>
Message-ID: <CAC=S1njMfS4LBxXg85b4oiwfhXNv5-Bm9+S-ZqupfiWUTs0ssA@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] drm/mediatek: Add crtc path enum for all_drm_priv array
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 2:15=E2=80=AFAM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> Add mtk_drm_crtc_path enum for each display path.
>
> Instead of using array index of all_drm_priv in mtk_drm_kms_init(),
> mtk_drm_crtc_path enum can make code more readable.
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Tested with MT8188 and the internal display is up and functioning.

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>
