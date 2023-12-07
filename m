Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26A380867E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378893AbjLGLPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjLGLPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:15:04 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC2FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:15:10 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4b2c2e77777so161138e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701947709; x=1702552509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1zKx8JGuByRmZeIzOLjwU47rnrPjKnk2Jj1ReloFCE=;
        b=JBhbQp65tjURrxy7jmLaTYH5H7RZYPGivQV66Ihw3eg3+U4XT9wuuyp0/FO8ZwidaD
         ewvbJ8nk3qU75sXVmmROHDio1NZtH0UL/J5BTyjN1YPZo9LWaSY6DfC8gtPhs/Bb0K+6
         FKwxmYWTtZdv8CN2OEAx9CglbZl2lskU++SK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701947709; x=1702552509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1zKx8JGuByRmZeIzOLjwU47rnrPjKnk2Jj1ReloFCE=;
        b=eUfx/A5hb392ZCTU5F4NEQndsRQ/qrY5FsFU9syU7E1rPlWsvU7jptqOoSUWlmKMYF
         ykTVOn1Ocj9udhHYC5zK3yN5Lf0hFa8fkkEI10GeMk+jf0uHTA/YyPFhtqeIpZLUBGQ+
         058m82xeaE2pZnxB3QgltfW1Pk3RrIzC7BrL8QlbgEdaab36+ikcu4n5uGmqrZm1wFnr
         d76six8CCLKyBr9S+YXCLWT7ZL446Y2LOZmL5C1Ati2pjVNHfBGlhl+WgpLmy0P4bJ5L
         MQkQacinqJEfRCvR2sO4ndj7riqzA+09/7wmMbq5PyjWYK4lh2ZbGfXGrPn/CHUfbEm2
         ePcA==
X-Gm-Message-State: AOJu0Yzl4AIj9mkFDt0m2JqTC3EA1BctskeS4trZ1kXWCyF0syCNj271
        eCtYgp/ntGIP/SJVrEfgBwG24TB1Fm/T1wjEUJM=
X-Google-Smtp-Source: AGHT+IHh+dzyGX92NJv7uBnWDcDBdn4BgX4FgKTJgHe/cuD9nQjOLvkdyNzJp5c7BVvRxJXrwZCQXQ==
X-Received: by 2002:a05:6122:987:b0:4b2:d37e:16c8 with SMTP id g7-20020a056122098700b004b2d37e16c8mr2645372vkd.7.1701947709476;
        Thu, 07 Dec 2023 03:15:09 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id x23-20020a056122119700b004b28dec2935sm51100vkn.20.2023.12.07.03.15.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 03:15:08 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7c471449998so200663241.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:15:08 -0800 (PST)
X-Received: by 2002:a05:6122:30a2:b0:49a:6dc0:5a89 with SMTP id
 cd34-20020a05612230a200b0049a6dc05a89mr2860131vkb.5.1701947707983; Thu, 07
 Dec 2023 03:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20231113123049.4117280-1-fshao@chromium.org> <20231113123049.4117280-3-fshao@chromium.org>
 <3528639f-85a3-4756-b04b-c233f6c84276@collabora.com>
In-Reply-To: <3528639f-85a3-4756-b04b-c233f6c84276@collabora.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 7 Dec 2023 19:14:31 +0800
X-Gmail-Original-Message-ID: <CAC=S1nibsNfo7Ans2J0aiXqJSz5-iTPh2NwTEuUL8-HUM0AJdw@mail.gmail.com>
Message-ID: <CAC=S1nibsNfo7Ans2J0aiXqJSz5-iTPh2NwTEuUL8-HUM0AJdw@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: mediatek: vcodec: Drop unnecessary variable
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Wed, Dec 6, 2023 at 6:19=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 13/11/23 13:26, Fei Shao ha scritto:
> > It's unclear why only mem->size has local copies without particular
> > usage in mtk_vcodec_mem_alloc() and mtk_vcodec_mem_free(), and they
> > seem removable.
> >
> > Drop them to make the code visually consistent, and update printk forma=
t
> > identifier accordingly.
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
>
> That's probably just about personal preferences, as mem->size is not expe=
cted
> to change during the flow of those functions.
>
> That said, as much as you, I prefer not having this local copy as it's us=
ing
> (a very small amount of) memory for no real reason anyway, so:

Yes, and I think I should have mentioned this in the commit message...
I'll revise that in the next version.

Thanks,
Fei





>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
>
