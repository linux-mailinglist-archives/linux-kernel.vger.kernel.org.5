Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D555D7EDA78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjKPDuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKPDui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:50:38 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB71B6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:50:33 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso523975e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700106632; x=1700711432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVLnet6UeJJKAgG9HzM7O27P98+CfXEuM0uNw2AJ9I4=;
        b=WPxF+FSvOsi8pl2EB0D4Ygca9eryMDyUbjIceGmtisNDzl8zWbRbNI2/raXlZ0bmyh
         B1L2pak3fdxshCRdP/FdMW9XMtVAGaa/z3QybvB/Ezxsc+U1aQRN3lkcLGfj/6i8Aw7A
         /XHkMlAQjkRYQ6BF9gCDrlKY5JPVkX0BVi52M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700106632; x=1700711432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVLnet6UeJJKAgG9HzM7O27P98+CfXEuM0uNw2AJ9I4=;
        b=IGa/vQW1ejgmhqT0gS0QK/fkpkt16XjP3zW3XrdIgZA/gLUGmwvn8CQH0Gh5/6G5TY
         hAVoqfP07Q5oTI4Ha8WIuyX+Ue+BEXHFMdYK4nRfojnRP+A1MAJsfWOrPfJUJ/fU3H82
         3jFIFIjNgi1T5v9gCPcuq94cKSZwhcYtunYgMDP8SwYNsjOgcHKZhxDetBHKF6yUU3Hp
         O5+ct/BIhXeL3Y+4xSnN2NUH4/S/LL468bp46GcdgcBA+tILjvbfuqPu9GAPbJIx44FN
         O7mNffbm/fkmrbiAON+s7FnpVYF+l1M/RRLXplP12IjVhNVMzX8ZM41L4C2y8CTJ4qUk
         nN+A==
X-Gm-Message-State: AOJu0YyRdzTesr9xG2d/2BXDhOBD2bGOFo9xMLVLAk84FxSlOpj/2Ons
        ygtkeW0gpyZxLOwQ5fNSXBqiJS79aT4DtSOmaxbR+5r0QRmbz0Pp7eY=
X-Google-Smtp-Source: AGHT+IG/HPn5kbZcT3Q0iuyPk7qJavc3LozqD5Z4W7c9maxr4cL7n62LD0Sl69ivAeU3gezgeKzgoerfVPGQMrrf94Y=
X-Received: by 2002:a05:6512:684:b0:509:4439:9b57 with SMTP id
 t4-20020a056512068400b0050944399b57mr1030248lfe.38.1700106632004; Wed, 15 Nov
 2023 19:50:32 -0800 (PST)
MIME-Version: 1.0
References: <CAKpemQKo2gigO44amj=eFUXgUnUeSmiOoTbS8GdXMx3O07N1vg@mail.gmail.com>
 <638afac6-0d2f-4bb1-8101-b58fdc03e303@sirena.org.uk>
In-Reply-To: <638afac6-0d2f-4bb1-8101-b58fdc03e303@sirena.org.uk>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Nov 2023 11:50:20 +0800
Message-ID: <CAGXv+5GHSK7nAagZ3iuSvcfbjFHJ1F+OYUr8KmaPbp6RyCgUhg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] regulator: mt6358: Add output voltage fine tuning
 to variable LDOs
To:     Mark Brown <broonie@kernel.org>
Cc:     Bret Joseph <bretjoseph@gmail.com>,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, zhiyong.tao@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 4:15=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Nov 15, 2023 at 06:52:12PM +0200, Bret Joseph wrote:
> > *In mt6358-regulator.c*
>
> I only have patch 3/3 from this series, what's going on with
> dependencies and so on?

You already applied the series in September and the changes are already in
v6.7-rc1.

I'll take a look at the report by Bret.

ChenYu
