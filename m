Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC87A43A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbjIRHzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbjIRHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:54:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DAC1FF5;
        Mon, 18 Sep 2023 00:52:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9DBC433CA;
        Mon, 18 Sep 2023 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695023549;
        bh=JpRQj+CS1LIqG6RxrH0LFqYOg4M7sfDK2bw5TGAmPjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DiCFZttO/1LGzwn/74BSriJkG66LPqKOPVJlGdd2jcUCLPb9ACaJG06N8MW6eI/5R
         m0sg957uKn9KsPzp+hc2vD1Hfx6g9NP0uJA3AFnW5mr3GR2MSgGycPzP7p3J0L9z1H
         IDitOlkeQw4eopY6eX6/w3itdWMUZgZo2NzO/a0rAJcT6COpD2pPUKLA1oElFctQ3J
         UUbg89tpOyizK4zliUygfwEu7WDTar24Rijg8qdrxdUexrVBGtLar2F/AeRh3qrDMu
         F18cYooFM1Q/3lVdNCBLeJbLdXDxydYuphSblAAgW45AwKJJ49usmzr1PiAcSATn5y
         1aDtgboA73DmQ==
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-450f977a2eeso1486647137.3;
        Mon, 18 Sep 2023 00:52:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YzKqLPU+RYAz+WfhwWyAfhdR2rvdpNngWLmg49zXv44Qtkha22c
        ZGvkUKzRXSryu6KBXE/0mfgsJXIr5mb8tmCmA74=
X-Google-Smtp-Source: AGHT+IG9StBg3ebnKnehHNUgY0wdwNcbSqnJu80Bw9fzTMW636VcC+o0IvC9AC/K8X4Jubw7Cog0n7XUMSPqoHVe+t8=
X-Received: by 2002:a05:6102:668d:b0:452:67b7:42be with SMTP id
 gw13-20020a056102668d00b0045267b742bemr1977559vsb.4.1695023548157; Mon, 18
 Sep 2023 00:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230823-strncpy-drivers-accel-habanalabs-common-habanalabs_drv-v1-1-147656947586@google.com>
 <20230825091856.GB3748525@linux.intel.com>
In-Reply-To: <20230825091856.GB3748525@linux.intel.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 18 Sep 2023 10:52:01 +0300
X-Gmail-Original-Message-ID: <CAFCwf11afiokfGubENdOggb6VvmWAyakeAqJAR-JQN66QHOpAA@mail.gmail.com>
Message-ID: <CAFCwf11afiokfGubENdOggb6VvmWAyakeAqJAR-JQN66QHOpAA@mail.gmail.com>
Subject: Re: [PATCH] accel/habanalabs: refactor deprecated strncpy
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:19=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Wed, Aug 23, 2023 at 12:23:08AM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy`!
> >
> > There is likely no bug happening in this case since HL_STR_MAX is
> > strictly larger than all source strings. Nonetheless, prefer a safer an=
d
> > more robust interface.
> >
> > It should also be noted that `strscpy` will not pad like `strncpy`. If
> > this NUL-padding behavior is _required_ we should use `strscpy_pad`
> > instead of `strscpy`.
> >
> > Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on=
-nul-terminated-strings[1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>
Applied to -next
Thanks,
Oded
