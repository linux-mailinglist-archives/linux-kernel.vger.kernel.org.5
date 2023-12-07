Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8483D808625
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378992AbjLGJ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjLGJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:25:51 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE7ED4A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:25:57 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso888782a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20230601.gappssmtp.com; s=20230601; t=1701941156; x=1702545956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56T1M3RkgkEvFsKEJLHWcohTkirOLnD7I3rdsoTC1yI=;
        b=jxZvrCWikWieZRTpVZsMw0cQ03wEvaQTxcNTvw4DfWpvkIt9LPDYqZX2Wb3g92JuuW
         SmEA+Q2Z7utaNpoVC/HUjbKqMtAIvz/tJ5bTQyLXI74t2r31cg+JKAUJsSmTcJ1bTMfB
         3+JffSCf4FmOOuDxrSddrGTe4hyF5PP6T/+9pvxzo6VOYj8NrlSpj0Uz+mkdT5DlwXSH
         0B9wdmRFjwx3DVSKVr37rYdKIaQzQv3EndZlS/7kR6fQ7sB0lALLALBf/F0hckoY4a7s
         UhYycfhYxt/LQ1FlWrzdLUiphRZKk5T82+ymkKOf6lmnZOw4452GNPzjY97yGINvTnfV
         3Qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701941156; x=1702545956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56T1M3RkgkEvFsKEJLHWcohTkirOLnD7I3rdsoTC1yI=;
        b=EWJ86sgoD5T2txK5l91/NSBX+DvZCzCMk8caAIPDzv/qU3Rojw2McQv5bSS6jF0Y5V
         KF4getPdZc0k01+4XHpuQQWP040xypZRoqMCo+1SAaGtcLWcykUpF+VOJlTX9Xf+Wk2m
         m9vb9MdtFRETcRT3mTbeN0DSe6uXnKUvtd1Bq+FaPCaB5ID8LQtJe58gVirCBW0KueUe
         5kdtyXc0XrC/BhSx2ambQ6lFlZLjtrMDiEStu7HPgSdut2vUhBno8V99L9a/H9j6ids/
         1MYlQAP24Nf3rcjXyCoOLzPaalviV78Hiqt9uot7OpnwzVBF8tlsH41KErlAh8+I6VCc
         +eEA==
X-Gm-Message-State: AOJu0YztQX9d3vI+DZCW1o9r4G7IuzB3ofoxQ60r+4PbvWDl+phfFQUW
        nXkUUf01QpNtbM3ael24corlEoPvSm9OWsmXytDv9A==
X-Google-Smtp-Source: AGHT+IFtB80x1RKWaoiFQnsZTz44KpZp+e8iynF5WtfXkFTzjLVGH8RiUrf6aQvX2/TyBvWbzs9E6CfhsZ3FrmAGZcc=
X-Received: by 2002:a50:8a97:0:b0:54c:d8f6:3f with SMTP id j23-20020a508a97000000b0054cd8f6003fmr1476412edj.56.1701941155885;
 Thu, 07 Dec 2023 01:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20231207082200.16388-1-jensenhuang@friendlyarm.com> <ebf6cf8ec3b5befd673d295061fa2738@manjaro.org>
In-Reply-To: <ebf6cf8ec3b5befd673d295061fa2738@manjaro.org>
From:   Jensen Huang <jensenhuang@friendlyarm.com>
Date:   Thu, 7 Dec 2023 17:25:44 +0800
Message-ID: <CAMpZ1qHUnTDQ78gdrQF9Sx_-XfLM-B+H-0bL1-+twKsno+JOvg@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: rk3x: fix potential spinlock recursion on poll
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Benjamin Bara <bbara93@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 4:37=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> On 2023-12-07 09:21, Jensen Huang wrote:
> > Possible deadlock scenario (on reboot):
> > rk3x_i2c_xfer_common(polling)
> >     -> rk3x_i2c_wait_xfer_poll()
> >         -> rk3x_i2c_irq(0, i2c);
> >             --> spin_lock(&i2c->lock);
> >             ...
> >         <rk3x i2c interrupt>
> >         -> rk3x_i2c_irq(0, i2c);
> >             --> spin_lock(&i2c->lock); (deadlock here)
> >
> > Store the IRQ number and disable/enable it around the polling transfer.
> > This patch has been tested on NanoPC-T4.
>
> In case you haven't already seen the related discussion linked below,
> please have a look.  I also added more people to the list of recipients,
> in an attempt to make everyone aware of the different approaches to
> solving this issue.
>
> https://lore.kernel.org/all/655177f4.050a0220.d85c9.3ba0@mx.google.com/T/=
#m6fc9c214452fec6681843e7f455978c35c6f6c8b

Thank you for providing the information. I hadn't seen this link before.
After carefully looking into the related discussion, it appears that
Dmitry Osipenko is already working on a suitable patch. To avoid duplicatio=
n
or conflicts, my patch can be discarded.

--
Best regards,
Jensen
