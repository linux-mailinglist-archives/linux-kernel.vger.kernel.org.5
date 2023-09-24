Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB2E7AC9FC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjIXO1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjIXO1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:27:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D333CFC;
        Sun, 24 Sep 2023 07:27:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7765CC433CD;
        Sun, 24 Sep 2023 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695565648;
        bh=bTCoYBjr017l6wFXONnZTUqQscIlTsYc71hdwazXlvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gUGAWIfW7vC1NooiXlxXAW77CGrUMiNfl1d0Cb+Ur1u6pV9vKzFjnH/HrDXCQPWpz
         VzQhp79Iu77tCMpohvzqwhU2VI6jFcTxIl/PwmgQ/zqrNiGUG5qfp5VPuAEfVezs98
         3JuLWuvfWl/1R0GAoVToJO3SKOdkdJ68ol7Yk4vODF97IuaSALUuTCxXSPBNEin0jO
         Uxy2F55OVFSNNiLGrA7Sy+pLvTK3RAka01exn8c0wABlLEzPyTKFwC7xju9Cj3sqOJ
         KNmno5TjgU1f3Ab9oAHE4z2RHFYTqAfnWTtwjjlz/nm/HbFxIvZgYnHc8dnRdf2+sA
         Cqd5Eki0be9Lg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c12fc235fbso56150171fa.0;
        Sun, 24 Sep 2023 07:27:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YyemvH/kfC2Sd1cNrULgtVy+CLzTF922+gZLnFQ5e8Jix7Rzugy
        azwSLQbpeJNIRjyMHjWnqZJQaAtM4bO7C5Ij6A==
X-Google-Smtp-Source: AGHT+IHf5vWm0GIZ1hkeawxAEZsjJHRSUs4KnxlkvgtCc373prUzNyF256grHwvaFc81Egmx7IoRA+c1Jovfx/Fg9VA=
X-Received: by 2002:a2e:b81c:0:b0:2c0:b37:a1cf with SMTP id
 u28-20020a2eb81c000000b002c00b37a1cfmr2571604ljo.22.1695565646665; Sun, 24
 Sep 2023 07:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230914131058.2472260-1-jani.nikula@intel.com>
 <20230914155317.2511876-1-jani.nikula@intel.com> <CAGXv+5GJxEobJKKWuc_UN+Gf_z8g6eb6KWTz-L+RqtyLYKK3Jg@mail.gmail.com>
 <87cyyetohx.fsf@intel.com> <CAGXv+5FvmwMW+bxJ9d_ULbOJA9qpd-vybn0VyE5iyQLHCET1=A@mail.gmail.com>
 <87o7huo840.fsf@intel.com>
In-Reply-To: <87o7huo840.fsf@intel.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 24 Sep 2023 22:27:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY__MYub=0Qkf8rn1W=O0MHSOD7wziO5ipCQEJRSK-EawEg@mail.gmail.com>
Message-ID: <CAAOTY__MYub=0Qkf8rn1W=O0MHSOD7wziO5ipCQEJRSK-EawEg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix memory leak on ->get_edid callback
 audio detection
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
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

Hi, Jani:

Jani Nikula <jani.nikula@intel.com> =E6=96=BC 2023=E5=B9=B49=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 19 Sep 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > On Tue, Sep 19, 2023 at 7:02=E2=80=AFPM Jani Nikula <jani.nikula@intel.=
com> wrote:
> >>
> >> On Fri, 15 Sep 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
> >> > On Thu, Sep 14, 2023 at 11:53=E2=80=AFPM Jani Nikula <jani.nikula@in=
tel.com> wrote:
> >> >>
> >> >> The sads returned by drm_edid_to_sad() needs to be freed.
> >> >>
> >> >> Fixes: e71a8ebbe086 ("drm/mediatek: dp: Audio support for MT8195")
> >> >> Cc: Guillaume Ranquet <granquet@baylibre.com>
> >> >> Cc: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> >> >> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
.com>
> >> >> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> >> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> >> >> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> >> >> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> >> >> Cc: dri-devel@lists.freedesktop.org
> >> >> Cc: linux-mediatek@lists.infradead.org
> >> >> Cc: linux-kernel@vger.kernel.org
> >> >> Cc: linux-arm-kernel@lists.infradead.org
> >> >> Cc: <stable@vger.kernel.org> # v6.1+
> >> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >> >
> >> > Looks correct to me.
> >> >
> >> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >>
> >> Thanks for the reviews Chen-Yu and Guillaume. Will you push this to
> >> drm-misc-next or shall I?
> >
> > Patches for the MediaTek drm driver go through their own separate tree,
> > maintained by CK (Chun-Kuang).
>
> Chun-Kuang, can you confirm picking up these two patches, please?
>
> MAINTAINERS does not list a separate git repository for MediaTek drm
> drivers, so I don't know where that would be. It should probably be
> added to MAINTAINERS.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Thanks,
> Jani.
>
> >
> > ChenYu
>
> --
> Jani Nikula, Intel
