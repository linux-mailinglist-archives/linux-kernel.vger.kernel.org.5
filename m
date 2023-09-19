Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3C17A5BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjISH5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjISH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:57:48 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A02E116;
        Tue, 19 Sep 2023 00:57:42 -0700 (PDT)
Received: from localhost (60.red-80-35-249.staticip.rima-tde.net [80.35.249.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6DA425BF;
        Tue, 19 Sep 2023 07:57:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6DA425BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1695110261; bh=wC0RalQCJ2SPYgn3eMQzRu/gY5GMsIhrB97dd9iyhNI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FC5COKGeQjFHBXFuBcxXkLJ+5JqVDNEMYQ2rGnUh6lSiykzqxaOWJYPG6e6DoEwcz
         mf7d8NyNQTi9XtqNnO6y0YZGqfd4WKQolCx6px9xBBX9IYdo14/zwjCYbG4Tvu1bTn
         RlLRROyCOcnySY/Fo1TgjBnP2110TrkQ0xPmP8pbTjh7oRvEU+8SvAdKqACYyB3TVC
         PhqUuh3o606/hSXneBc5Z4ApYsJl4DKAKOdApzSmKq2frX93J7nfI+8/mL99+7Uspm
         aBStcLQ1VND1fTyTC2C3GAMzIW7rEQX0nm49Ah1wVXPFxifH3pggfmLeoG/KC+LGtX
         0rNNYMOeRN2kw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz,
        tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] ALSA: docs: Add Marian M2 driver documentation
In-Reply-To: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
References: <20230918181044.7257-1-ivan.orlov0322@gmail.com>
Date:   Tue, 19 Sep 2023 01:57:38 -0600
Message-ID: <878r92bnnx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Orlov <ivan.orlov0322@gmail.com> writes:

> Add documentation for the new MARIAN Seraph M2 sound card. It covers
> current development status, available controls of the card and
> information about the integrated loopback.
>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
> V1 -> V2:
> - Remove redundant documentation fix from the next patch in the series

One quick comment below...

>  Documentation/sound/cards/index.rst     |   1 +
>  Documentation/sound/cards/marian-m2.rst | 104 ++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/sound/cards/marian-m2.rst
>
> diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
> index e68bbb13c384..e873592d8d00 100644
> --- a/Documentation/sound/cards/index.rst
> +++ b/Documentation/sound/cards/index.rst
> @@ -19,3 +19,4 @@ Card-Specific Information
>     serial-u16550
>     img-spdif-in
>     pcmtest
> +   marian-m2
> diff --git a/Documentation/sound/cards/marian-m2.rst b/Documentation/sound/cards/marian-m2.rst
> new file mode 100644
> index 000000000000..bf12445e20d7
> --- /dev/null
> +++ b/Documentation/sound/cards/marian-m2.rst
> @@ -0,0 +1,104 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +MARIAN Seraph M2 Driver
> +=======================
> +
> +Sep 18, 2023
> +
> +Ivan Orlov <ivan.orlov0322@gmail.com>
> +
> +STATE OF DEVELOPMENT
> +====================
> +
> +This driver is based on the driver written by Florian Faber in 2012, which seemed to work fine.
> +However, the initial code contained multiple issues, which had to be solved before sending the
> +driver upstream.

Sticking to the 80-column limit is best for documentation, especially
when there is no reason to go over it.

> +The vendor lost the full documentation, so what we have here was recovered from drafts and found
> +after experiments with the card.
> +
> +What seems to be working fine:
> +- Playback and capture for all supported rates
> +- Integrated loopback (with some exceptions, see below)
> +
> +MEMORY MODEL
> +============
> +
> +The hardware requires one huge contiguous DMA space to be allocated. After allocation, the bus address of
> +this buffer should be written to the hardware register.
> +
> +We can split this space into two parts: the first one contains samples for capture, another one contains
> +play samples:
> +
> +CAPTURE_CH_0, CAPTURE_CH_1, ..., CAPTURE_CH_127 | PLAY_CH_0, PLAY_CH_1, ..., PLAY_CH_127

You should really use literal blocks for this (and a lot that follows)
or it won't render the way you want in HTML.  The simplest way to do
that is to use a double colon ("...samples::") and to indent the literal
text.

(OK, two comments, sorry about the off-by-one...:)

Thanks,

jon
