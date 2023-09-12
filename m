Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA9079D29D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbjILNq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjILNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:46:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8F10CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:46:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so743067466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694526379; x=1695131179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jepfeoNOxEjzjxCx4a1HfCNQ7Fn9JfA8nF0tCrt92S8=;
        b=gCwKRJEs3M6OPni0CtceBrE9cCicBCuAoOPAnhP8HWgw2Wsn3kijbjlaZAv9hjS3g6
         sKmy5Sao1zO9hF9wXZ8Bnm+V/9ozMrGTYgP0JldZDbzUQgC1/CZDzoZJCskTl+SfGMlo
         QGu81p6rj9hvd0rEJ4EKcjsJprgcnFMWH/05hJx1eD3fuiKJ1qSo46vNkenbw5QyIkGa
         1kdZFCbN8OpPPQPkG29JZd7TNS3U241YzwiiemwE85mCBQ7ZaffFnyUvHJeRfiz+mCIf
         8QyLtJqXHm0pasVIlzzvwyU1WeTBGCMuTnxiMOyOhUUFgqupHFtPsikQ6qxGiI66OZMK
         Ku2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526379; x=1695131179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jepfeoNOxEjzjxCx4a1HfCNQ7Fn9JfA8nF0tCrt92S8=;
        b=EtEKZroNvT6UbSpRC7y3VlNE8kwd2sFO2/NjGhDe6iyFkWOJDT1RZYxOOPJFQIM1s5
         YklGgC0jX96FiysnaJ7uKP1aRmRaZxdlNmaoiQsu85bLvcA9JrQqTj27EwMN8vjEWHS9
         D4XKhHHOYx+EfUyoz6OFKxeqW4WlEFZUpK5XEZP3JWT6fVvHN1CT0tHFHS1UKhPrh2Re
         NP74wAiuta/EoyiE4Gl3k1jyUJYMFd3C2gsny+UaWtJdYvUGHHq7Fk/U/6I1EN2+7bea
         8vaxv2hvc7LmcxnqHEcbDU2O5TjXuDWntzwYRTcnU9q4CaNTldaWegOcaxqdbuNb0A8f
         EhhA==
X-Gm-Message-State: AOJu0Yx4mwtWlSImGc1/LMsZq+xFN/wM7hl/0erKleCubKmJfkrTSSex
        37uYZ7ZIYcEqYDe6gGztWpbxfA==
X-Google-Smtp-Source: AGHT+IGaw/MFk//2QGkYQG2/NKydmCFKZT0TrVz2+njlEajzVppplZmYjOHO+YlLC5nAZSzsAD+1YA==
X-Received: by 2002:a17:907:762d:b0:9a1:ec3d:9004 with SMTP id jy13-20020a170907762d00b009a1ec3d9004mr11419584ejc.9.1694526379364;
        Tue, 12 Sep 2023 06:46:19 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:82a0:6611:d59a:8ba3:9a66])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906118c00b009a5f1d15642sm6868756eja.158.2023.09.12.06.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:46:18 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:46:17 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Riabchenko <d3adme4t@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: regression with 33140e668b10 thermal/drivers/mediatek: Control
 buffer enablement tweaks
Message-ID: <20230912134617.jwonuolt56nofifz@blmsp>
References: <trinity-6713557b-fe0a-4dae-84aa-1aa86f7619fa-1693473911557@3c-app-gmx-bs12>
 <trinity-f3e7d8e0-2e93-4e84-a489-3993c819d2c3-1693488871086@3c-app-gmx-bs12>
 <07a569b9-e691-64ea-dd65-3b49842af33d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07a569b9-e691-64ea-dd65-3b49842af33d@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank and Daniel,

On Tue, Sep 12, 2023 at 02:57:45PM +0200, Daniel Lezcano wrote:
> 
> Hi Frank,
> 
> thanks for reporting and investigating the issue.
> 
> 
> On 31/08/2023 15:34, Frank Wunderlich wrote:
> > Hi,
> > 
> > looked a bit deeper into it and it looks like i only need to add the fields in the mtk_thermal_data struct
> > 
> > --- a/drivers/thermal/mediatek/auxadc_thermal.c
> > +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> > @@ -690,6 +690,9 @@ static const struct mtk_thermal_data mt7986_thermal_data = {
> >          .adcpnp = mt7986_adcpnp,
> >          .sensor_mux_values = mt7986_mux_values,
> >          .version = MTK_THERMAL_V3,
> > +       .apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
> > +       .apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
> > +       .apmixed_buffer_ctl_set = BIT(0),
> >   };
> > 
> > in my quick test the temprature can be read again and i'm near room temperature...i though it was a bit higher before, but as far as i understand the code, the values were fixed before and only made it configurable.
> > 
> > if someone can confirm that i'm right, i can send official patch.

Sorry for the delay, this was in my inbox but somehow not on my todo
list.

The patch looks correct. I think I simply missed adding the fields for
MTK_THERMAL_V3 chips. Sorry!

> 
> At the first glance, it seems the proposed change is correct and could be
> proposed as a hot fix.
> 
> However, the conditions with the version and the apmixed_buffer_ctl_reg
> looks a bit fuzzy.
> 
> Markus, can you revisit this part of code and consolidate the configurable
> approach ?

Yes, it indeed looks like I broke another condition there. I will give
it another close look and send a fix.

Best,
Markus
