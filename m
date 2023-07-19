Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1327592F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGSK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjGSK1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:27:24 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9497213F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:26:32 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78360f61ba0so330484339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689762390; x=1692354390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDKpzyl715FXpvBs//brcAoLgtj+1UL6KkC6I4T68sU=;
        b=oQJ2CxIW4tsldI/cUWFdXbWkbYNYGGRppQlvoyZO5Jkx4G6fK3t4l7Zr0zvd82wVuz
         9A90SIKHVhvb+ceyh2cdCltMNQ1ppUzYOaMArxGRa7I/BRp957XL64wLc+K2RgciTLA1
         BYqLXYCcynfHXt2l5g7t0QX4GbIsNk2JVMRIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762390; x=1692354390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDKpzyl715FXpvBs//brcAoLgtj+1UL6KkC6I4T68sU=;
        b=SbR8IQR7NMSAyg/aatTv+g1TSTpNbgvU1JH+VDSDaHb56TcDhEeh8sx/ajo9ArL9Hs
         Oqm0asugsgyTPEnQoH7H75P6RdcXfgQnxF5JVBipEvmRsv2rct1hfjg+4tMMdiYFNPPt
         KZxjbULzQsGJmbGP6La70o4hLlEHOwZPkPBoaNwR2x6tf/ONSlzcH6KIgP8gqiRrRigf
         ZBwgwSTjdLJEettC4forwgAI22rjMnUtSjSb6qMZLz77tDv7SETvtJrgSh5pDjsXjfeb
         3deDnS5aTCCf9LLBez3teduJ0rt0n6OT59qewfXATIoIKC331IzWDB5bjfpv8j2WVLZD
         h6qA==
X-Gm-Message-State: ABy/qLbEmaG4anE3pasfi6Pzx2RvbNDEwNQbNx0uN0wCS2p4fFrOQnx5
        s9utRIQn47rFqPppwU1hBLLAJZM3K5qyKD3GmEE=
X-Google-Smtp-Source: APBJJlFS8pSsJhzeVmIeYPi5XBS32/NYpbWNbnl0gWjmsszN8fLOCYvEBD3NHROxyEY4uNveWDJHvw==
X-Received: by 2002:a5e:8804:0:b0:787:230f:55b1 with SMTP id l4-20020a5e8804000000b00787230f55b1mr4968784ioj.2.1689762390160;
        Wed, 19 Jul 2023 03:26:30 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id z23-20020a02ceb7000000b0042b4b1246cbsm1153928jaq.148.2023.07.19.03.26.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:26:28 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-78374596182so331296139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:26:28 -0700 (PDT)
X-Received: by 2002:a6b:f10c:0:b0:780:c787:637d with SMTP id
 e12-20020a6bf10c000000b00780c787637dmr5094711iog.17.1689762388259; Wed, 19
 Jul 2023 03:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com> <20230719075056.72178-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719075056.72178-6-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 19 Jul 2023 18:25:52 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhHKCZoh2Q4Fou-WmEB=Kn+kNzj344UaJEXhoG56k3-hw@mail.gmail.com>
Message-ID: <CAC=S1nhHKCZoh2Q4Fou-WmEB=Kn+kNzj344UaJEXhoG56k3-hw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] drm/mediatek: mtk_dpi: Use devm_platform_ioremap_resource()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 3:51=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Instead of the open-coded platform_get_resource, devm_ioremap_resource
> switch to devm_platform_ioremap_resource(), also dropping the useless
> struct resource pointer, which becomes unused.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
