Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8904808FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443736AbjLGSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443688AbjLGSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:24:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B8AE0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:24:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso1726805a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701973449; x=1702578249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRjWkx56RHR1r5cAwUPqSGXDNsuGHCsvk8l76pBIe10=;
        b=lsS7VigTxlTl7B1gH9qKau2sYxd3c57rqG5xdDTbB3WBwIyK8vWb0lbeKS+u6DJQhO
         39o8lbtNmWvysJvRgew+hAKve0MO7bondvlZ70kEDEUq1/MZPBBU92Rg6WEyThL5TM3o
         ujT4Pt0idVw5/qTHC6BM6H17pG+GWiAKUiEl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973449; x=1702578249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRjWkx56RHR1r5cAwUPqSGXDNsuGHCsvk8l76pBIe10=;
        b=H68bIK9LAf7WxSAJBThCBf7VfPYg0fQqFTugna2OWMHsQI83k/Lv58NjVtp+TvY3Vf
         Q1OUuqXukNSmQDrzBKcyaNNE2m/oL6nDZzomopMKxzu/BuGX48HOFzxdcovIKO+DS46b
         Yqp28BaW+hT0KeUymllwdQlwcbpIYaChIoDSSdDC0Daic8xeF46WKaSDED4QG/FOlf5j
         QyGk1GlTiWHHhcJ2kaHlWcyuec2wfzaiLWLQmk6SFeWb4vryUcoxlH15cDC8ABjAZqvc
         a85XA1jRCfcL2Qj2H0IAPWd8l1WGHCxDzSbjbHxVpQwR6uDlzAdfPor3dM6ziE1WRJtB
         S2MA==
X-Gm-Message-State: AOJu0YzgGeAuaEywPhheKOhvJ1ocgV6CrQxC72c7yDyqgBayivCYNueH
        Tp1TorxgGvLM1R7Y5aqwJ8dsOZuAxtwGoN2cS0lzvBLb
X-Google-Smtp-Source: AGHT+IFTXuEyk2sJw+I9aqcOh7qthvlAQJtcsvY+F5E2J8RI0/y7EkPyupR90mK1SH+nOSN6328ung==
X-Received: by 2002:a17:906:203:b0:a1d:da25:1ad5 with SMTP id 3-20020a170906020300b00a1dda251ad5mr704767ejd.162.1701973449078;
        Thu, 07 Dec 2023 10:24:09 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id hd10-20020a170907968a00b009fcb5fcfbe6sm49592ejc.220.2023.12.07.10.24.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:24:08 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so3775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:24:06 -0800 (PST)
X-Received: by 2002:a05:600c:54cf:b0:40c:2399:d861 with SMTP id
 iw15-20020a05600c54cf00b0040c2399d861mr175294wmb.6.1701973446020; Thu, 07 Dec
 2023 10:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20231207081801.4049075-1-treapking@chromium.org> <20231207081801.4049075-5-treapking@chromium.org>
In-Reply-To: <20231207081801.4049075-5-treapking@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Dec 2023 10:23:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U6M5rpQXmjC+iGf0BGtiyjRAAcMfo4Fr3pDyYVp3m4aQ@mail.gmail.com>
Message-ID: <CAD=FV=U6M5rpQXmjC+iGf0BGtiyjRAAcMfo4Fr3pDyYVp3m4aQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/panel-edp: Add some panels with conservative timings
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 7, 2023 at 12:18=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> These panels are used by Mediatek MT8173 Chromebooks but we can't find
> the corresponding data sheets, and these panels used to work on v4.19
> kernel without any specified delays.
>
> Therefore, instead of having them use the default conservative timings,
> update them with less-conservative timings from other panels of the same
> vendor. The panels should still work under those timings, and we can
> save some delays and suppress the warnings.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/panel/panel-edp.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Repeating my comments from v1 here too, since I expect this patch to
sit on the lists for a little while:


This is OK w/ me, but it will need time on the mailing lists before
landing in case anyone else has opinions. Specifical thoughts:

* I at least feel fairly confident that this is OK since these panels
essentially booted without _any_ delays back on the old downstream
v4.19 kernel. Presumably the panels just had fairly robust timing
controllers and so worked OK, but it's better to get the timing more
correct.

* This is definitely better than the very conservative timings and the
WARN_ON splat.

* I don't love the "Unknown" string, but it doesn't do anything other
than print to dmesg anyway and at least it conveys to anyone else
reading the table that the timings may not be quite as tight.
