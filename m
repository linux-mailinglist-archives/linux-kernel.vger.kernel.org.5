Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E17A1904
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjIOIjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIOIjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:39:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12168E7E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:39:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so2313565a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694767146; x=1695371946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcJ0YF656Gqyw4TwkIVu38nmGFD+TIOI6rP0TNwnO88=;
        b=clNxTyQ5UaX4sduvcLtOwZ4T+xFPeU4spPyN8oeyHFZXcHN+TU1jX4hkYAqjN6C83T
         /s23TuM7wVoRFOn+oYq0idSOSdESx//wPZ8gvo5/xMMTTmYDDqGY2JP4Yjvn+b8OX4VE
         l7q2tFpH77CWPYhI0bcGi0NgVg1moGkffyH9uNXB0EcDcfDB8L4GAAGat1EIc+iyyOim
         XaINFGVedtyecUnaVcCkD7B3CnvdYOD5w8waafxs+pKxz3Ho61/OT0CwfogtA2+a0khs
         cr+Q8TcqfOnIzkJbTwN9Oi7gee5EQI3RQB8QP7beTX5qnCWymN9QFJu71k8DksLBpIeE
         PtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767146; x=1695371946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcJ0YF656Gqyw4TwkIVu38nmGFD+TIOI6rP0TNwnO88=;
        b=jkn7XI+R0xFUVBczkJQtf9X1za8/m1LxRxRcktb90U+Qs+qn/HK9nD805ttT32fEua
         cjMkcESsVGPHdmBMVM6g6V+Y7C3M9ealOkrqVubV1bN4I4bbjBTYEpKQrxP3Gvh1C6ku
         9jrcR24iOoVxb7gnZCVR3VHodmEeWFa/Mh0YvN87qvvBdjLzocViBASiM51AIuT0XZmo
         GbJCq0HqehhgN86CuI+C0xdZIeO2PkD8xKh6cDi4uCLEQ7FK4XkA8EeX2S44hllCVjhu
         ol5v/JvHjCLXFH9vmh34Ls1TOgXNQNCOL+ZZFYu+qdw+Qkab83Rzkj4giP6WZE33dYtF
         5w7A==
X-Gm-Message-State: AOJu0YzCbHOH2/ojTsze3EAJkaAw/rTwkup3f3ihjkJYjPM6HX2qijgz
        dsBuhy2a8hlciYCKE5sqXg0OnaIcGgwn6A+ttDc=
X-Google-Smtp-Source: AGHT+IFqWx5uj2DHjRauIvxPCOhENMc7x02MgQj1RmKhG/d1C1fdZNN3IRf0HXHut2+w8tXTNZoGQcO6LcoXjI6pYko=
X-Received: by 2002:aa7:cd57:0:b0:52d:212d:78e8 with SMTP id
 v23-20020aa7cd57000000b0052d212d78e8mr847795edw.34.1694767146186; Fri, 15 Sep
 2023 01:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <1694757731-18308-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1694757731-18308-1-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 15 Sep 2023 11:38:54 +0300
Message-ID: <CAEnQRZAU01qbeVjcEVnL0emc3ovo+NSs_N5=xUB2fVaswnjVqg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-audmix: Fix return error with devm_clk_get()
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 9:38=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> The devm_clk_get() can return -EPROBE_DEFER error,
> modify the error code to be -EINVAL is not correct, which
> cause the -EPROBE_DEFER error is not correctly handled.
>
> This patch is to fix the return error code.
>
> Fixes: b86ef5367761 ("ASoC: fsl: Add Audio Mixer machine driver")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
