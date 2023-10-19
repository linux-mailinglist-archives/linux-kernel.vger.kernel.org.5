Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD877CFC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbjJSO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjJSO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:28:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7C13E;
        Thu, 19 Oct 2023 07:28:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so12225749a12.2;
        Thu, 19 Oct 2023 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697725708; x=1698330508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTGCaGePaO+9xY5Tx4NqZIcO6UcmmZco/d5DUOPNM2A=;
        b=DnEgBy1Days82XnEMGxOnKZALrfxbXDdkUKx5oqCcmoemvha3927xapo8iQNwTWNzq
         7AZ2Uys16o0nLnABsl2WasdVuUUDSGaxAsA3sFz4wMzQhupU9TQWFyRVwBWfzRO3yRQw
         iEi/23If6rwNkFlmgUU3Q3+X+vyCdpmtnx5tsz50JT45RAlZHI5RIfKFQ7Z3U/HYomci
         S4Yj2bGC4nXjZjj9oVP2ghiUnUtze09Elk3jrreZiYsUolyxYpjpYHGc55j/HmffZAH1
         nhVkRtnub7ZSdyEsbHA9HYu4/OBybwQFlFYdpqGd4cX6w+7cLIAwCQwP8QwMXaiyB07h
         hbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725708; x=1698330508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTGCaGePaO+9xY5Tx4NqZIcO6UcmmZco/d5DUOPNM2A=;
        b=hWvXdg2nlztK/wQRklk84To1IvrPHc91+2ED9GstEfaIlOPAKflInvbHaqNRB5lmN6
         kOqp4hQB0q7mhZLSw/T7iKoISrY37u2aU+OkkO7L+WxYsXMFQ6DdJbQv0+wVfSdUv81H
         kncnHAjik7fmR6EhlYz/SKGtf6AsyCBSuZe8XOXZsAfDK8RwtvIo5qqKf5AiqinFXuv6
         FhCzuw+NN/2oUWrJMiBO3iNGzmPFi9nWVt7Bv4r+82UF4dYuN+oRaex70h/p66670MrF
         8dZcnDjOdwJ7kAa9GQ4tZHLNtdjhpmfFfjLO/TAhXhxUubfM3dJv4ztwvLNuHmY8DPK0
         DuEg==
X-Gm-Message-State: AOJu0YyFw05WYHp8zJQtY60cO1ZZ6FT4zZg2fwG1bFjZzRzHVVM1a417
        hCB0anA+JuzKdotG+/BXk4U=
X-Google-Smtp-Source: AGHT+IHom2P5D/0ZCoU/BMAaPNaN+h3pYDSCNkHiYeQf1bafHxtKXFkptLe7DunokV8KOxjJVdYYaQ==
X-Received: by 2002:a05:6402:42c6:b0:53e:7a2d:a4a2 with SMTP id i6-20020a05640242c600b0053e7a2da4a2mr1693439edc.39.1697725707781;
        Thu, 19 Oct 2023 07:28:27 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id e17-20020a50a691000000b00534e791296bsm4685447edc.37.2023.10.19.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:28:27 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:28:25 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/7] dt-bindings: net: mvusb: Fix up DSA
 example
Message-ID: <20231019142825.6ue2lceckxejt7vi@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-2-3ee0c67383be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-2-3ee0c67383be@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:03:41AM +0200, Linus Walleij wrote:
> When adding a proper schema for the Marvell mx88e6xxx switch,
> the scripts start complaining about this embedded example:
> 
>   dtschema/dtc warnings/errors:
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> 
> Fix this up by extending the example with those properties in
> the ports node.
> 
> While we are at it, rename "ports" to "ethernet-ports" and rename
> "switch" to "ethernet-switch" as this is recommended practice.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
