Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16A17A6093
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjISLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjISLEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:04:36 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A307612F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:04:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502b0d23f28so8998496e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695121468; x=1695726268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnnQ3s+GwRKjZuujvx+iDfiO0JJCCFMA1JGV0fiu7C8=;
        b=Y25Ynrg+KyPHCA01uhdr9ovphvWPABddImerfSPBg0T1FjL/j3CAUMv/ZzD/Aj3eyk
         +F/Dg+lLjnGK+QRq5qFN/SAQHccLle7hRx/srcQy+SftZWYjZJvmDYdCg3M6ff/7iznP
         Vpur+0SeNYcELZCFat0QBszT1GhY11dZU7ufk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695121468; x=1695726268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnnQ3s+GwRKjZuujvx+iDfiO0JJCCFMA1JGV0fiu7C8=;
        b=LE/LQMbvuJOE4HibiB9oEeHS1dqX+O3aK2iMIMcfsST7keBW71Sls5HN2+6KKPdooZ
         NEXMJc5P+CSfRBjiwumF9sBbLrl3F7Hy9SFPh6fK6fNgDrKkij1MeIMZvb8CG8XH65Xa
         UXjLb4r+39096TqXaOOLpzDkTn1vJ+eqHAqiJ05alsb3MGZo9Pz107afbLyOqfKlA6Uu
         QUub3iLNhcDDgEUaMeLZ/M+TtZCysFPdafVhcbAjcXJGUcaxoGVz1kRT6zjyhGho2eSr
         +EYBwlMu3X2IguXPvHA51I/f50TYicRERafXP7VkKO/0tgjuJM2Og+nbaLS5iGQ8ntbY
         L8kg==
X-Gm-Message-State: AOJu0YzuQKIe3M3pddvnVsY1QAlvJGTXZQrnYQG+vbcQvWrwG/ESoq55
        Vreb3nBwb4+SiFuAL5DTVSv0UB0XVcFBhmTpiFnlZg==
X-Google-Smtp-Source: AGHT+IGcV1dfcbMagRfMyNyQcnzYkHiXYtQedB3yY9VjknrAYCXYI60T/bUj3J0z+oKX3RZLt4u29SWWXZup/QVezkM=
X-Received: by 2002:a05:6512:312d:b0:4ff:9aaa:6e3e with SMTP id
 p13-20020a056512312d00b004ff9aaa6e3emr8647917lfd.41.1695121467746; Tue, 19
 Sep 2023 04:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230914131058.2472260-1-jani.nikula@intel.com>
 <20230914155317.2511876-1-jani.nikula@intel.com> <CAGXv+5GJxEobJKKWuc_UN+Gf_z8g6eb6KWTz-L+RqtyLYKK3Jg@mail.gmail.com>
 <87cyyetohx.fsf@intel.com>
In-Reply-To: <87cyyetohx.fsf@intel.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 19 Sep 2023 19:04:16 +0800
Message-ID: <CAGXv+5FvmwMW+bxJ9d_ULbOJA9qpd-vybn0VyE5iyQLHCET1=A@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix memory leak on ->get_edid callback
 audio detection
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

On Tue, Sep 19, 2023 at 7:02=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> On Fri, 15 Sep 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > On Thu, Sep 14, 2023 at 11:53=E2=80=AFPM Jani Nikula <jani.nikula@intel=
.com> wrote:
> >>
> >> The sads returned by drm_edid_to_sad() needs to be freed.
> >>
> >> Fixes: e71a8ebbe086 ("drm/mediatek: dp: Audio support for MT8195")
> >> Cc: Guillaume Ranquet <granquet@baylibre.com>
> >> Cc: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> >> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.co=
m>
> >> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> >> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> >> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> >> Cc: dri-devel@lists.freedesktop.org
> >> Cc: linux-mediatek@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: <stable@vger.kernel.org> # v6.1+
> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >
> > Looks correct to me.
> >
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Thanks for the reviews Chen-Yu and Guillaume. Will you push this to
> drm-misc-next or shall I?

Patches for the MediaTek drm driver go through their own separate tree,
maintained by CK (Chun-Kuang).

ChenYu
