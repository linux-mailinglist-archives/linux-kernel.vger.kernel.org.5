Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160197772EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjHJIcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjHJIcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:32:15 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B3ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:32:14 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-48727371106so274604e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691656333; x=1692261133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HF11CqYi6NhL1F8GJzpfBHOcQOn7pKc9CrEEDQPOQak=;
        b=I0fKn04m8+Eyq0QX1m7Kkl9rGpbcEnD86MqXqh7egTNhVO2uUjrA87G/6hJcmnV7jp
         tYp5fjDk+XvCkFJZtgm9LVtiNBCLHbAiTZLAGLucAQdv7X3CU2A1dmqrA6g/UYm6JfFM
         9pVjj7WoW0+Vdsf8isGAEja7UdoHzvETea4nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656333; x=1692261133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HF11CqYi6NhL1F8GJzpfBHOcQOn7pKc9CrEEDQPOQak=;
        b=eQZKV+k8m2ysS1Aij+5EtQSPoIE0xEy20ZJM56GyMqq8nMcneAwF3gdtVInb3o3wE2
         +pcAtEsltC+AM64JIzu70qzOGBlPduGygfD8CyVYFmqdLNgLVzXrPeonLlGgCtl23FGD
         cLZfVHDpVnUH3VIMaWLKXrtIfsnPShSNCQvrDU0q8bGBXCHUt7I1yOzcuZiCtfxMyC5j
         NHl1RcVgrfKJFtMFpPde7kbUJJkh6MrP41fewIX1922I5oX1Vf89WAFZETCQpTTTicMS
         7WbvVTfCZJpqsa5hBfkd7MRsdTXmQR66Wq4HBTtnRjaF5xdwrAl4nm46u30lkGsaaiy6
         aYKA==
X-Gm-Message-State: AOJu0YxinPWOArSQyPpdjTcJ+C1XieRq3p826Two4D8n/Q9PXCub/sEd
        ej5WxaSYh1GidhHHm0dJLGbnsnsfL4EBRRi6HMMpDTtFx1Qwq7/A
X-Google-Smtp-Source: AGHT+IFZUfyXIrF6NX6XHtpQ1aRnF9OycIBf0Ukf4jcjAWkHaOt4TORLmdHUVCNyTHszLlmzibhIj00QuOu2mU1+FY4=
X-Received: by 2002:a1f:bf58:0:b0:486:4b43:b94a with SMTP id
 p85-20020a1fbf58000000b004864b43b94amr1593934vkf.6.1691656333217; Thu, 10 Aug
 2023 01:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230810082333.972165-1-harperchen1110@gmail.com>
In-Reply-To: <20230810082333.972165-1-harperchen1110@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 10 Aug 2023 16:32:02 +0800
Message-ID: <CAGXv+5EOwT4ZvTLkvT_26UFk4Eg1Hi0iERp=NpmtQ63g3dZ+qw@mail.gmail.com>
Subject: Re: [PATCH v2] media: vcodec: Fix potential array out-of-bounds in
 encoder queue_setup
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
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

On Thu, Aug 10, 2023 at 4:23=E2=80=AFPM Wei Chen <harperchen1110@gmail.com>=
 wrote:
>
> variable *nplanes is provided by user via system call argument. The
> possible value of q_data->fmt->num_planes is 1-3, while the value
> of *nplanes can be 1-8. The array access by index i can cause array
> out-of-bounds.
>
> Fix this bug by checking *nplanes against the array size.
>
> Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video E=
ncoder Driver")
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
