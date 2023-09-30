Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56237B4393
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjI3Uen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjI3Uel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:34:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD7C4;
        Sat, 30 Sep 2023 13:34:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03ABC433C9;
        Sat, 30 Sep 2023 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696106071;
        bh=WBx4sFK18Fvo2S9P2auh13kr8VRYgzO7eZmEq+kqyWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j1nqOqtt6jC1dwe86YXIZVFQZsG2VmabaoizcZO21AvbJ1GyOBSwJhPE2j2eioK0T
         BH3jsQxXJG7ekz5TgA5O5JTiWcZSMFvHpbT+wcAKNd5Wl64NqMBCso7diExqTAe/ws
         xZ792XGOnFE1xHUcIEGrbfK+/pjJolhA777/W13okG7w/HSFHgK6k7md2x1HuwVPMz
         82/OwS1gcm9EPH1hDPCSNOp/M7q0vptm5oiZWB0sLmX+qdbKguY1tLFkMFt6lqTXWj
         c/UD9AIokH4NhelkduRGDgQ5pJ9sDjae8g73/4whKzCSFuoU45UND29AfVz5DjmRFE
         wFxRSd5s/mmlg==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6c4bad60a1aso6904636a34.2;
        Sat, 30 Sep 2023 13:34:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YzeBMIIawbyWIqXo4YC/tcKvWQSV/s6+GyTmJ+9M7j+6EkPlGS/
        6iVyMddMrCJwQAXS7OG8BD6dLhYIJ19+VHtobNM=
X-Google-Smtp-Source: AGHT+IHrXBSzbwXTQkT3E30hfUQzyDv378uXN61B0R/8LnQAs5ioVJp/xHOUWBfyHzX9U7bIpOu33vkZBhijouDtbXs=
X-Received: by 2002:a05:6870:611f:b0:1be:e6d6:15c4 with SMTP id
 s31-20020a056870611f00b001bee6d615c4mr8149346oae.9.1696106071106; Sat, 30 Sep
 2023 13:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230930165204.2478282-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230930165204.2478282-1-u.kleine-koenig@pengutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 1 Oct 2023 05:33:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATyRg6Hc-fnTETERj-tdMFGaBDt0Fyhy9+jKCzAvzQ6Pg@mail.gmail.com>
Message-ID: <CAK7LNATyRg6Hc-fnTETERj-tdMFGaBDt0Fyhy9+jKCzAvzQ6Pg@mail.gmail.com>
Subject: Re: [PATCH v2] modpost: Don't let "driver"s reference .exit.*
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Leo Yan <leo.yan@linaro.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>
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

On Sun, Oct 1, 2023 at 1:52=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Drivers must not reference functions marked with __exit as these likely
> are not available when the code is built-in.
>
> There are few creative offenders uncovered for example in ARCH=3Damd64
> allmodconfig builds. So only trigger the section mismatch warning for
> W=3D1 builds.
>
> The dual rule that drivers must not reference .init.* is implemented
> since commit 0db252452378 ("modpost: don't allow *driver to reference
> .init.*") which however missed that .exit.* should be handled in the
> same way.
>
> Thanks to Masahiro Yamada and Arnd Bergmann who gave valuable hints to
> find this improvement.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>


Thanks.

If there is no objection from anybody, I will apply this
to my fixes branch and send a pull request.


Then, I hope you (or somebody) will volunteer to fix broken drivers.





--
Best Regards
Masahiro Yamada
