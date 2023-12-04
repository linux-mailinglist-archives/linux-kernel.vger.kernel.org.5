Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA79803C84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjLDSNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:13:33 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DC5FF;
        Mon,  4 Dec 2023 10:13:39 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f0ecdaa50so64240885a.3;
        Mon, 04 Dec 2023 10:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701713619; x=1702318419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv5W8UxLCR/5ceJa4BXZdc/7xUY5p3Shixmo6OvaNl8=;
        b=dv/oxZfYlx4nuvpHT/5eW4EEnM39xupw+h9W+mKjMbeuYujEKDcibzt876zmAUkpwR
         ++saqFFDQbJSe0dVBzhI7ApLPqdKnYjHNF80IroFFSToRiYsXgCvbOH+1B9QIbn+t4kE
         3sCKul2QSF3A5pjoPHVKXhFjAWhGwaj9UBJbaO+V9bGriC30sHXh4PkpjvInuUP4VdrZ
         u1lzVt1KHNP+wXFXlamHT6dPPn56ENNfgbxdcH7eEvUxa4QM4BJTryXKvuY2KOwGQ4ob
         PWdelQgld1a8f8jlxzUAxrMCp3Z2l/lNh0MACOmEVoZu+MvZvxGg9KWkRxaiYYWY6MF2
         emjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713619; x=1702318419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cv5W8UxLCR/5ceJa4BXZdc/7xUY5p3Shixmo6OvaNl8=;
        b=Vt46soV7AiO8EFr5YheCXM4MI1sJtSBK30vGwPItqVR7C6oURC1wGrNWL9K40mRAOh
         ALNv+LibA8VVkhEjCJ8cfYsF0wa3H57XCpXon5dbRoxUU8KSyhg6QrA3FhSJlaThvbtC
         EneVhuSJ6p/2wzEwCxqv2RhAO6ZKpGe/p8EFfWvYHLVLfbauGu5UUrxMc/gT+6duXyKy
         XI4l5c/ig2sS68UWQBF3H+pLC2njirK50ku7lQcY0RT+VucGA9caP0JIT38qH7mITumP
         4mkmkykdJvulilTMD0UpfmhzP3wQhvYVE/7RHRgaISytScpMQD9/xnxoz1wS+4HGeWmR
         Pz8g==
X-Gm-Message-State: AOJu0YxfrorewW+WXm3cT8nCwRQLAPjv6uvsUh0zHJUpeloPBQi0ermE
        j7wUBOuYLD82+wNIFBeyow2PXtAN5jGdqgkGbXM=
X-Google-Smtp-Source: AGHT+IHDD5RoF3kCsuQM1b2t3YZgwiiRD95GHo5n9uXPGJLfvqKzVllX46OCHT8qfyQ/Iw/ykvNMOOKfu8qZWH64NAc=
X-Received: by 2002:ad4:4384:0:b0:67a:d891:fd75 with SMTP id
 s4-20020ad44384000000b0067ad891fd75mr567320qvr.129.1701713618841; Mon, 04 Dec
 2023 10:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20231204180603.470421-1-gnstark@salutedevices.com> <20231204180603.470421-3-gnstark@salutedevices.com>
In-Reply-To: <20231204180603.470421-3-gnstark@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Dec 2023 20:13:03 +0200
Message-ID: <CAHp75VdxB+qEjLBq1M3Zfrh4_gnJOv70BRb1RR7+KeDWcPE6jg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] leds: aw2013: unlock mutex before destroying it
To:     George Stark <gnstark@salutedevices.com>
Cc:     pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hdegoede@redhat.com, mazziesaccount@gmail.com, jic23@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 8:07=E2=80=AFPM George Stark <gnstark@salutedevices.=
com> wrote:
>
> In the probe() callback in case of error mutex is destroyed being locked
> which is not allowed so unlock the mute before destroying.

Sounds to me like this is a real fix, hence the Fixes tag and being
first in the series.

You free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
