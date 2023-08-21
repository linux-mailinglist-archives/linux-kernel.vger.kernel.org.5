Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B163782ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjHUQvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbjHUQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:51:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25CF123
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:51:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bcc0adab4so458458466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692636681; x=1693241481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa3ckcVx6ipoG3jTmuVEQ3LyBGo5W15jbdVg5c4xR2E=;
        b=hfHdDQNHWfSA8dcit8PsyYQuHGg8y9RxNjVUtJFSuJIMM7Pek/r7lWEQ0JU2HCPMCy
         lDxnoMcVOSKTjI9q/HetyTAseHe6/W8DsMiV+rCE+NDQQ/fBGbEmMiRaBla4JHczXHrr
         m3jhn2IHEzVp8gY6TzFPgqiJ80DJYeYiXhHfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636681; x=1693241481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa3ckcVx6ipoG3jTmuVEQ3LyBGo5W15jbdVg5c4xR2E=;
        b=LOFfKUWeJDzMSw5RMd22+A61aHi0SKR9g0sSfUxIa6vwuTgcehgczAEsVvhMz01iXM
         r5ATDBQM/D/kwjfxrakOZrWPd6e3ref8tZSh4//MCteNsNefN/8qVrxH/39dCCmKK2lB
         4eJVrQllgA735RryhX7LHZrunXAwIymdBcmDXC1fbWnIeipz3WzPNqiUrCd+KojTVZWx
         E63auQX+csrCbpMtZT2a396TwuRYtsoqp3a3hq8SwWXfUI0GnKHuL43QeHPmakaf9dU+
         1FbA+VEBge5UnLtkxDzvxznUzxIJPPo9LvOQJNvdQb8hcdSyTNLtZ6I8xvWF8SN7lI5f
         R97Q==
X-Gm-Message-State: AOJu0YwGvstbuhAPda3IMje1XRk/pKolNzdWju3Td0kZS6ReEqE1Y5T0
        i8PW7IxkEgOJQee16Q6k2RhIRwIF2mwwr5yRjpZCo4hj
X-Google-Smtp-Source: AGHT+IFn1lOQoFqGEK0Mp4imwEHT8tXjEf2OzoM+GwxORsdqfGsA6sMEea6rCwny40Lz1w7WHYbv9g==
X-Received: by 2002:a17:907:7792:b0:9a1:af6f:e375 with SMTP id ky18-20020a170907779200b009a1af6fe375mr375825ejc.35.1692636681490;
        Mon, 21 Aug 2023 09:51:21 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id sa17-20020a170906edb100b00997d76981e0sm6738515ejb.208.2023.08.21.09.51.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 09:51:20 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so2815e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:51:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba0:b0:3fe:dd72:13ae with SMTP id
 n32-20020a05600c3ba000b003fedd7213aemr6540wms.0.1692636680659; Mon, 21 Aug
 2023 09:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl> <682e260d8cb75c34f79ff7fcc3c4bb8586140cc4.1692484240.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <682e260d8cb75c34f79ff7fcc3c4bb8586140cc4.1692484240.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 09:51:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbfBf9y1sdt9T=81cTCRcRUbVqo3oKrHvBQZC+hHQpCQ@mail.gmail.com>
Message-ID: <CAD=FV=XbfBf9y1sdt9T=81cTCRcRUbVqo3oKrHvBQZC+hHQpCQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] regulator: core: simplify lock_two()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>
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

Hi,

On Sat, Aug 19, 2023 at 3:46=E2=80=AFPM Micha=C5=82 Miros=C5=82aw <mirq-lin=
ux@rere.qmqm.pl> wrote:
>
> Make regulator_lock_two() shorter by observing that we have only two
> locks and when swapped earlier the retry code becomes identical to the
> normal (optimistic) path.
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)

This is quite nearly a direct revert of commit 37473397b852
("regulator: core: Make regulator_lock_two() logic easier to follow"),
which was requested by Stephen in:

https://lore.kernel.org/r/CAE-0n53Eb1BeDPmjBycXUaQAF4ppiAM6UDWje_jiB9GAmR8M=
Mw@mail.gmail.com

I don't personally have a strong opinion, but do prefer not to flip-flop. ;=
-)


-Doug
