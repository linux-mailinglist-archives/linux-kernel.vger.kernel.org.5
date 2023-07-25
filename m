Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099A7605D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGYClj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGYClZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:41:25 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C82D7F;
        Mon, 24 Jul 2023 19:40:45 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76714d3c3a7so502404985a.3;
        Mon, 24 Jul 2023 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690252770; x=1690857570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJ6MWJZ0PC07PoDab55truxx6wk6LB1vHJirFaivjEk=;
        b=k1SaRf9xDpelbVpuB1CI1Ozbc0EYvC+4BU5dF8fyOwbC6a/BzeldZ/EkvTm4nnpmfb
         qUabCzAN4YhhBChgnnwMf0YQy2mFnA9N5Zp9nCTD4odeF8woCmLEzNkIbJrTGIZmpoJx
         9BW+03UVwscMoyMpMt5LW8/rDuoknO0jVY9+BtUw4/vpJv48QRcECjt0d/1KWpx3dzg2
         ChpDvCFI4cV20+a9POXDVdo8WypdtqXjJhu1JH06C9nsOj5dGNXUKT25OEfWcVYcjwSn
         6olUhTkw9ER9gXJlh3x+TSJlq1Xt8v9DIPsWRd7mnI/Eyrhttek8upHui+Q/lQplCVQr
         JYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690252770; x=1690857570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJ6MWJZ0PC07PoDab55truxx6wk6LB1vHJirFaivjEk=;
        b=bdxikRjwSj0hoG7EosXR7buPM90P/O3/mJgLev4Jg32tUlIhl/wRpdqiBzpN3vVO3B
         6MqCbbTphAIIYgS9Hf9fZTdz3H1MENwCQb+1RDCJBFXaVCGvuDTxT+33FXesBWEfUUXE
         CGLZoftFkEFd91ppTJIQ92YJXou4J5aJ+ak5Hdyfgm4Tj+Um6x9xo3HaccXtov8nMjCQ
         cxN/SoEhyC0sR3CZQTSV6vAasRjUMRTIScH8xWLrHcMGH7IIa0XVabYVX0VBLVzq6yp0
         zCVlEAWxfBBSOC8SixXZLDk/9N3RbCmAregmCfmW8T4uvb0gXRzIS8KozXsSUzGDGRvU
         K2pw==
X-Gm-Message-State: ABy/qLaufm3+n3bRIWI6sMhxs4Hj7VxmXn8m9Xcr7ukXmWd7dPH8VjcL
        bpNrlAZn5pJvMTNOI9kieBery/9clpoWJfqlVfQ=
X-Google-Smtp-Source: APBJJlGbzCceXXZGYpzojvXa7GlTxNMmTvGIq5seI5fTYefVBMGEt+6FlhhSnc7yH3p4aMv4UA53vftYGs+9Xk+o4dg=
X-Received: by 2002:a05:620a:444c:b0:765:6584:b033 with SMTP id
 w12-20020a05620a444c00b007656584b033mr2041395qkp.50.1690252770283; Mon, 24
 Jul 2023 19:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230707092414.866760-1-zyytlz.wz@163.com> <03449762-33b9-3e86-c65f-4bb9e0e917c6@collabora.com>
In-Reply-To: <03449762-33b9-3e86-c65f-4bb9e0e917c6@collabora.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 25 Jul 2023 10:39:17 +0800
Message-ID: <CAJedcCxG+LC1M1LiQOL33DB+fsZ_2ancQP+kMXAbOd6+1o6umA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there any follow-up about this issue?

Thanks,
Zheng

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
=E4=BA=8E2023=E5=B9=B47=E6=9C=8820=E6=97=A5=E5=91=A8=E5=9B=9B 15:45=E5=86=
=99=E9=81=93=EF=BC=9A
>
> Il 07/07/23 11:24, Zheng Wang ha scritto:
> > In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> > and mtk_jpeg_enc_device_run may be called to start the
> > work.
> > If we remove the module which will call mtk_jpeg_remove
> > to make cleanup, there may be a unfinished work. The
> > possible sequence is as follows, which will cause a
> > typical UAF bug.
> >
> > Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> >
> > CPU0                  CPU1
> >
> >                      |mtk_jpeg_job_timeout_work
> > mtk_jpeg_remove     |
> >    v4l2_m2m_release  |
> >      kfree(m2m_dev); |
> >                      |
> >                      | v4l2_m2m_get_curr_priv
> >                      |   m2m_dev->curr_ctx //use
> > Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decod=
er Driver")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
>
