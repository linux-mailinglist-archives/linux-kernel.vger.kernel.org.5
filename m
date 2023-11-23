Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5169C7F5754
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjKWEKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjKWEK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:10:27 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067E0199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:10:34 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so347253fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700712633; x=1701317433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDuyynkQJjhNuDv7Y3RcwbZVUcM2IlduXLPOC7/Q8To=;
        b=n22IZv1oUO26hmpRIoRT7d57BXsTeyF6VuKMyu3YEuUbM1h7V8Gvg6ZxrwYGom2lya
         ZobsT/XhQgOpiwV4+jgsjHY3JdzNRBBdr9TP6xfKe+K+LBg0KKPbARysiRxSpnLpgt3A
         slCWX3oMlF15OArV8ZuxXhtZJuTkrTNvv6cXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700712633; x=1701317433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDuyynkQJjhNuDv7Y3RcwbZVUcM2IlduXLPOC7/Q8To=;
        b=VQCkuvI13FD+nM2n92CxGUKEEqRQEF1saTPaNYq5K7P+XIGYdn7sy7jVQ6bkxtoaso
         F0NdNoP7N2mS5uL64CfrXL09C2sGsQVSPx9kiw1T6I8yBL+8IUgkfTB1ePzwfVNoTP0p
         B6VfHAHj9xyIBcFsw1ePKCp8hyAf6rTaJcdCvukIaUeubvckQIazk5azM9srYry2axtG
         05Xmb2VtLTAIyvy/vP45zUrW+IPcDXuYSMsv569qNPQ2/bpiC1zCO0BofPy4RxTcu5Os
         s8F8DXKo9WinqvQJZrlPp35h+O38A76M/101b0e+MrCgGW4RUU/u4C3VtDTGhjz+VGxt
         iLFg==
X-Gm-Message-State: AOJu0YyOMLbJXHYaR5WhfxXNs7HH9QQUHYQ2/Aln5fGKDAoeBbOeGQ+M
        pLwCnh1PCIUKtJ0x1TvXYi9eIx4gjruCwg7DXSW3KA==
X-Google-Smtp-Source: AGHT+IFtJFcT4z5+F5AkMyiV7vcRbH3czMAgiLb5dbcOK8a0nTaXWsfuZiv0FoiKXFA+/7fiwFk+Bw==
X-Received: by 2002:a05:6870:249d:b0:1f9:6e05:ff80 with SMTP id s29-20020a056870249d00b001f96e05ff80mr5442495oaq.29.1700712633248;
        Wed, 22 Nov 2023 20:10:33 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id qj14-20020a0568702f0e00b001efcb7b4717sm127977oab.53.2023.11.22.20.10.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 20:10:33 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce2988d62eso296903a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:10:32 -0800 (PST)
X-Received: by 2002:a1f:dac4:0:b0:496:2282:5c2f with SMTP id
 r187-20020a1fdac4000000b0049622825c2fmr4788680vkg.6.1700712315456; Wed, 22
 Nov 2023 20:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com> <20231103102533.69280-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231103102533.69280-3-angelogioacchino.delregno@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 23 Nov 2023 12:04:39 +0800
X-Gmail-Original-Message-ID: <CAC=S1nimsor1k+sRXw67OrM8U_kANgLdnn6E++gR_O6S_tisLQ@mail.gmail.com>
Message-ID: <CAC=S1nimsor1k+sRXw67OrM8U_kANgLdnn6E++gR_O6S_tisLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clk: mediatek: mt8195-topckgen: Refactor parents
 for top_dp/edp muxes
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        wenst@chromium.org, msp@baylibre.com, amergnat@baylibre.com,
        yangyingliang@huawei.com, u.kleine-koenig@pengutronix.de,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 6:25=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The top_dp and top_edp muxes can be both parented to either TVDPLL1
> or TVDPLL2, two identically specced PLLs for the specific purpose of
> giving out pixel clock: this becomes a problem when the MediaTek
> DisplayPort Interface (DPI) driver tries to set the pixel clock rate.
>
> In the usecase of two simultaneous outputs (using two controllers),
> it was seen that one of the displays would sometimes display garbled
> output (if any at all) and this was because:
>  - top_edp was set to TVDPLL1, outputting X GHz
>  - top_dp was set to TVDPLL2, outputting Y GHz
>    - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
>      - top_dp is switched to TVDPLL1
>      - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
>      - eDP display is garbled
>
> To solve this issue, remove all TVDPLL1 parents from `top_dp` and
> all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
> clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
> able to use the right bit index for the new parents list.
>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>
