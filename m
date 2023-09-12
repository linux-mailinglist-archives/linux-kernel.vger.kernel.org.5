Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAED79C6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjILG3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjILG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:29:15 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F859AF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:29:11 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79277cfc73bso165142439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694500151; x=1695104951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzZ0g5ZlS6sJREICVBNJdNjzNdZ31/yPMuU7RoyizV0=;
        b=NvpZI33dysrZjhXxacf0vhiOtd97teOYu+sBX/T9hmJbhggDY6hxshaRCQo8sRFo9F
         To4Zd7cqtjmsFzkF5JcepUZrqzO6wWuGQ79GB+4N+LTPBunbnzUqUP1ILmnAZI6J5Z5K
         xzdQsLlA+m85ydJ6FGzYz+LKuV3wuO3B8+sSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694500151; x=1695104951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzZ0g5ZlS6sJREICVBNJdNjzNdZ31/yPMuU7RoyizV0=;
        b=aOJRNDjk6Y3jl7LBcm5h+ztbDx61N2LOigHTsZIh94neVmRQXRwBsL4PV7URSJtUuF
         C9QlOwy3xI8+n1cw1XAyafxOYbiR5CP8OVkzlqDJVspt6z1N80G3pc0f9ZL6Azih/igq
         2VIS9J57TfjdrGKARPaKiTGRCpf+Ts4D+rteNdmrUVkMGvRJ+Df/3QviOhX0gpH8X11i
         aN4/VKdrSa1iOEbBn3CrpGTd5UbFMILYF3KxmEL2AdBxydT27ntTNwoe6/p6jbEG7hZC
         JrrVIk+58nJ5Tiu9OYs199bOtZF/P9/vtiDEXzIxIxInRzda46W67/fR43foNe4heryx
         1iBw==
X-Gm-Message-State: AOJu0YxLPFF4PFEz+EFbnLe8AEaOPd5VDz8QguvcidZP0OoSfjSYbOGh
        vaPPg8WirQqbHXnYAYWYqeL9aKMPeQjuE7DPZ08=
X-Google-Smtp-Source: AGHT+IHYQU6qkAh5w9h3T+vA7IttMY0pqMGkB8YHTRnrdb0utIM7pX/1fN2XPrU5p69INU74Uv904A==
X-Received: by 2002:a6b:e014:0:b0:792:70f2:a8ed with SMTP id z20-20020a6be014000000b0079270f2a8edmr12407819iog.4.1694500150778;
        Mon, 11 Sep 2023 23:29:10 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d8042000000b00786fd8e764bsm2736176ior.0.2023.09.11.23.29.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 23:29:10 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-794cd987ea6so164882239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:29:10 -0700 (PDT)
X-Received: by 2002:a6b:610a:0:b0:786:25a3:ef30 with SMTP id
 v10-20020a6b610a000000b0078625a3ef30mr13376283iob.7.1694500149823; Mon, 11
 Sep 2023 23:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.5.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
 <CAC=S1niYAC3PFQoAmwVc=1FcK29uu5sC9c1pGo-mku__y7eHcA@mail.gmail.com> <CAD=FV=VT8ZQkcLn4nsxCygC5SG16qYW5igFfwM762jEK42p12g@mail.gmail.com>
In-Reply-To: <CAD=FV=VT8ZQkcLn4nsxCygC5SG16qYW5igFfwM762jEK42p12g@mail.gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Tue, 12 Sep 2023 14:28:32 +0800
X-Gmail-Original-Message-ID: <CAC=S1njNfjOaSidUHSGPKC+-625Ysx66wx9Sk02ZXGvpUKYBbA@mail.gmail.com>
Message-ID: <CAC=S1njNfjOaSidUHSGPKC+-625Ysx66wx9Sk02ZXGvpUKYBbA@mail.gmail.com>
Subject: Re: [RFT PATCH 05/15] drm/mediatek: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:11=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
[...]
>
> That makes sense. I had based this series on drm-misc-next which
> didn't have those, but now that a new -rc1 is out it then
> drm-misc-next should rebase shortly. I'll make sure that the next
> version includes Uwe's changes as much as possible.
>
> That being said, I also wouldn't object if the maintainer of this DRM
> driver wanted to resolve conflicts themselves and land the patch
> without me needing to resend. The conflict is trivial, there are no
> dependencies and no reason to land the series all at once, so landing
> this patch early would mean less spam for the maintainer since they
> would no longer get CCed on future versions. :-P Just sayin...

Oh then feel free to ignore that if the changes weren't in the tree at
that time... It was just a gentle reminder. Thanks for clarifying.  :)

Regards,
Fei

>
> -Doug
