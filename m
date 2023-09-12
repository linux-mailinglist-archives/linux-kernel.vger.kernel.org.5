Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7F79CEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjILKuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjILKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:50:37 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0E4B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:50:31 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d776e1f181bso4732284276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694515830; x=1695120630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1zhy1UCOP1ljrKVhLiacaxWhwvSH+VCp0kMLxhoeYk=;
        b=KGO4rmyNgT3MbvGcXtZJWfne4zfxWs9WFVyf5rMhUGn/hCCcnqfIUVsZgeq+3pFKiE
         DrSDf0kjuI1eF5fCGr9kfZslf1fd9384ubuxn8E6A6QH2hD2PD62p0G2pfSUju8xk5++
         Owf14hbibSTMuVTHKGNvBDAV6vmopbe3/fT0ORAzgDJTPSMuox7QRBeoN4coIiBnZwpO
         gWB9BAwFghuLcW+UKOYW5OMWG9evtCWjTv6VttlH6JTirV1n3VZHPgB0rDB+eZw/8CzY
         fvsMsQRscD/NEAP8olPTXupS4hWrD2Iz/l/LvnQ0SRaEJutPZhJv62Xltnk7adir0Jr2
         VNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694515830; x=1695120630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1zhy1UCOP1ljrKVhLiacaxWhwvSH+VCp0kMLxhoeYk=;
        b=RC9QDwQEvHj6rEEUldQm6yKWV5ugHVGQyyByM7WICXb9h8JaW2OUzcdtnqbG9Mu3+Y
         /r7QC6he6Yz2y693pp5A9Q9BAi3OkvEnXyDuaAelOYLtPXl3uWER3wVyNW0PgWV979Nd
         gwZX68iVojQLf/lH/UhHuBQeUjQrwzQsqPZZKbQqfzGDr0Op4gu3YVsH/1MgCUfu4i/Q
         wp6K67o81TZxTRAnzV9KYHIePj5FkXTjMcOxNgDE2Mpjj0a+SgtdMfjl/KUM3liwnCBz
         4lw2GgBN3QbHWaDmsCM3LTs7GfP0yvM2URLz16Tem/30jO50JYygnDWzqsYPi0mad6iI
         umaQ==
X-Gm-Message-State: AOJu0YzOBg2IWJW2jCEGrFA3n9aSUHRKANiBQ731yxkwe99wPzTndxtY
        aPGRGlz6AZfHrw1bnuTLLQ9H81o54uc+eUyFN0bjaQ==
X-Google-Smtp-Source: AGHT+IF07zf9UK//ddp32dWpF4Y9JXdGQlakVWNajAly9WIIg0061on0AU2876ifTbnQDu3Gsm2uIBLaneAG2d7vX6I=
X-Received: by 2002:a5b:d05:0:b0:d78:98f:4aa1 with SMTP id y5-20020a5b0d05000000b00d78098f4aa1mr12462208ybp.7.1694515830489;
 Tue, 12 Sep 2023 03:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230912081527.208499-1-herve.codina@bootlin.com> <20230912101458.225870-1-herve.codina@bootlin.com>
In-Reply-To: <20230912101458.225870-1-herve.codina@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 12:50:18 +0200
Message-ID: <CACRpkdYFuqQYhB7dOnRnUo8kfRiVZFzYBQuWCpEPLLKVSzKkJg@mail.gmail.com>
Subject: Re: [PATCH v5 27/31] net: wan: framer: Add support for the Lantiq
 PEF2256 framer
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:15=E2=80=AFPM Herve Codina <herve.codina@bootlin=
.com> wrote:

> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
