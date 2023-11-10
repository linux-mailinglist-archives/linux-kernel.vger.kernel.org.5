Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67317E7627
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbjKJA6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjKJA6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:58:47 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C748B3A97
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:58:44 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d31666d89cso8608a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699577924; x=1700182724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJVrXuXFcu3DgtWdnbXpFzASR1Czvt1UEeVrRTmaZPQ=;
        b=V5c558bwpJbS+RsMjl+81BnZskU9iA2PziT2KM/lWdWWWu9sF61J7xxbkit5dKirS2
         r46y3F7gdM+v0QWicY8k7FIYJb5Dw3lpnFUDM3m4L8n8WniI4rH9r8J2k99Wtdjlx3Fb
         cwZB48T+NKxPi43z6rvgfk/gCXdrlX5dBOCqrgDLWe5aYioerEi22D0WnIYhJA53bF61
         2Wt2HG7wPkxoF3tCC0mKbYrB8/JhenDUbnG+eH0+lc2Y4Db7+Gy38b34eL/xGguoIOwW
         3M3hrwMEaHFE2CBRj16ppDuBnYjw4ba78bTRKl83sEIGAc3ygF8yvXkwM6qFYWp3ifyr
         /Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699577924; x=1700182724;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJVrXuXFcu3DgtWdnbXpFzASR1Czvt1UEeVrRTmaZPQ=;
        b=qy0XqHVh4j5P4+G4BTnW/4iFcTbnAFYI05C61w6KGrXhnNODTFJg1gDd4Yk0OF55D7
         DW5Fa3TrpwuFmNmHt1K5mY/lkDJeaGieqJRHOmV68JxBqmdEFx6//eUudpS9QUFVfqYb
         14qNhlbjqyoGbeakrTbTFLXs2lPJVyJd9YpfUyqkYH/vjQrVxozLMK75qa5RPid85bYV
         97pmO5bSqnSjcX1dRIt0DthMLA5q7JCQmT4vNi3uRMlT2K376WfPE5SvfNJGqX4Joqvj
         tQ7X/NkiIQpdWvMR4rSBzMRt7HQg4A6rJc07AS1ya5ki+cPI/F5bBkusEgDAkqJ3biDi
         Zeaw==
X-Gm-Message-State: AOJu0YzmUr7vSsd8Mu5r486OneuaHyBnamWntonTQysMB/p2TVd4o2P2
        FluvqQL3ZCobGJpY9W1EQ/Hm9g==
X-Google-Smtp-Source: AGHT+IFCGAq9uOJ74nOCEa1XdXbPO22Qfscitoj00Gqwgxzjx8UkOGK6WexDGU679wSnRWP4OZnOBw==
X-Received: by 2002:a9d:6f16:0:b0:6b7:36af:1937 with SMTP id n22-20020a9d6f16000000b006b736af1937mr7501364otq.0.1699577923984;
        Thu, 09 Nov 2023 16:58:43 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:f2ee:7d90:a86d:610])
        by smtp.gmail.com with ESMTPSA id s4-20020a655844000000b005bdf596164fsm1746007pgr.94.2023.11.09.16.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:58:43 -0800 (PST)
Date:   Fri, 10 Nov 2023 09:58:39 +0900
From:   Takahiro Akashi <takahiro.akashi@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Message-ID: <ZU2AP7leDcIZIN+b@octopus>
Mail-Followup-To: Takahiro Akashi <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
 <CACRpkdYW-xmejyOo9H9XSkcabvYgBqPvpjppvNe_RF6RLxyxKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYW-xmejyOo9H9XSkcabvYgBqPvpjppvNe_RF6RLxyxKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arm folks,

Do you have any comment?
I expect that you have had some assumption when you defined
SCMI pinctrl protocol specification.

On Mon, Nov 06, 2023 at 02:12:36PM +0100, Linus Walleij wrote:
> On Fri, Oct 27, 2023 at 8:28???AM Oleksii Moisieiev
> <Oleksii_Moisieiev@epam.com> wrote:
> 
> > +                keys_pins: keys-pins {
> > +                    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
> > +                    bias-pull-up;
> > +                };
> 
> This is kind of interesting and relates to my question about naming groups and
> functions of GPIO pins.
> 
> Here we see four pins suspiciously named "GP_*" which I read as
> "generic purpose"
> and they are not muxed to *any* function, yes pulled up.
> 
> I would have expected something like:
> 
> keys_pins: keys-pins {
>   groups = "GP_5_17_grp", "GP_5_20_grp", "GP_5_22_grp", "GP_2_1_grp";
>   function = "gpio";
>   pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
>   bias-pull-up;
> };
> 
> I hope this illustrates what I see as a problem in not designing in
> GPIO as an explicit
> function, I get the impression that these pins are GPIO because it is hardware
> default.

If you want to stick to "explicit", we may rather introduce a pre-defined
sub-node name, "gpio", in a device tree binding, i.e.

  protocol@19 { // pinctrl protocol
      ... // other pinmux nodes

      scmi_gpio: gpio { // "gpio" is a fixed name
          keys-pins {
              pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
              bias-pull-up;
              // possibly input or output
          };
          input-pins {
              groups = "some group"; // any name
              input-mode;
          }
          output-pins {
              pins = "foo1", "foo2"; // any name
              output-mode;
          }
      }
  }

It would indicate that all the succeeding nodes are for gpio definitions
and *virtual* gpio pin numbers will be assigned in the order of
appearances in "gpio" node. Then a client driver may refer to a gpio pin
(say, GP_2_1?) like in the current manner:

  foo_device {
       ...
       reset-gpios = <&scmi_gpio 3 ...>;
  }

-Takahiro Akashi

> 
> Yours,
> Linus Walleij
