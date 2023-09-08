Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D896798E62
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbjIHSqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbjIHSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:46:30 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6698B1BD3;
        Fri,  8 Sep 2023 11:45:53 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bf01bcb1aeso1771980a34.3;
        Fri, 08 Sep 2023 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694198687; x=1694803487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK+qTZg63UeRXq6H+6hjsRVwDxx7PLtIZ61jN3+rKNo=;
        b=dFAn8hHPQTHgpaGUJw9tV0tMUu5cD0nn6qV0178n30RenD1/stNNZBjMKX9caicr5l
         cUAo2gIxqCb0/o9u9RVG58XkBkyxgkA8br2C2Urth42+ae7DXSoVAVA1gnntlJWECo8z
         MnkghCKA2FBMukAlbtGEkp1yLJJ9/DZLEVGifLpZh3gexKPhdDbLwn23hsEJa2Yu7xSZ
         aWR+y5fL6IZefA44zdBMZzh6bw4dNyKPb02xx3aEBBdGgmnma8ylnAJ5HU/ZRlIsQdYh
         3yKvpiG9MNgB/odQe5KeuWmrO8ANLzOFQjlVGcSlbgDga4dd4/4+sZXvYqMWPljtnCoT
         EYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694198687; x=1694803487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK+qTZg63UeRXq6H+6hjsRVwDxx7PLtIZ61jN3+rKNo=;
        b=ZT0Mdp/H/I71iP5wBCjW3Jyn2kBi4Fd2sMaUSE4eEAwTin7tD7jddvbPTlYf8AgnRG
         F1vdDoVn/uaVUdHov9dZUN+XlVlCgHg0yFtRR45YRorMPlGaFNwGPUNBc1RCd/Dsq4Kl
         AT0bZoh1FF8UIw6BwBZuDs0f6w9KDKxc046/kp9GamgznlV0iElhZ9oCMjAtLbGbSW5G
         cKeKJryT6hRO0NRGMrV/jByB3v+WL3ndAF5maqpK2k5t2krfbfmVWc6s2uHoRYiJcO0j
         f6i3VaNzmTdvivSeqBWUgorpa6WQ/3NBs7EeeuVBnBEjMR0+akFon31haRXzRhksRUdj
         7gbw==
X-Gm-Message-State: AOJu0YzAtHDFi2/wkR8cUQaOZKaNaR9kS/2KTl6kPTrb1Yx9hM+OJRqD
        fnHrjFNdzmaLzhUcm8t81aEBqHfGWxh682cpLh+H66ms
X-Google-Smtp-Source: AGHT+IE7Hf6pI9i2oR/fInpOPqa1zyFn18b1m/6jy6kYRYF8gmlCNbUbSxm2BUrf+7OcT2RdgNeQVa3NyCOiv2gcjJc=
X-Received: by 2002:a05:6830:1117:b0:6bd:bba9:2d63 with SMTP id
 w23-20020a056830111700b006bdbba92d63mr3131811otq.9.1694198686805; Fri, 08 Sep
 2023 11:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com> <20230818151220.166215-3-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-3-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 Sep 2023 14:44:35 -0400
Message-ID: <CAEjxPJ7YwHVjkOerYcDuSWLEFrxv01V4C9osvDt-1AXR+as+3g@mail.gmail.com>
Subject: Re: [PATCH 4/6] selinux: simplify avtab slot calculation
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Instead of dividing by 8 and then performing log2 by hand, use a more
> readable calculation.
>
> The behavior of rounddown_pow_of_two() for an input of 0 is undefined,
> so handle that case and small values manually to achieve the same
> results.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
