Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF5767978
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjG2AZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjG2AZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA953C33;
        Fri, 28 Jul 2023 17:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A395E6221E;
        Sat, 29 Jul 2023 00:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAACC433C7;
        Sat, 29 Jul 2023 00:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690590345;
        bh=xoYh6nl7Ymq+oEY+0iyKXVVHHgnEX73mQRAcXMXhUfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BCiqoZRADYsp7o6W43xzzcFifZX/tdqC4zkUqVu6R4lkllSL+7EE0vp6+VLek8YBq
         Y6dJlZmalMnKiLu/4TKlRrBiBnAI1qDC+3pVNkOD6JbfGasZ4MjshJkm09OWQFFays
         VpfMI6e3Um+iCDfsKebGSboT8UH4PO70WLFF880LAlBfYz9N57xl17hAkBY+gDf7D3
         1SchvxhtDTIocM1Fm8VJhpuwLhdq0GALw0ftDZ77FZ4oFBr144+3vD+etwu9NhSLiO
         iD6f/vTZMcWLuHAZ/RAnCe4VoWRS88niwBzOycLaSGvIE24lo7GMJ1Fcs3wfcp7H4r
         aczenDH6y1PNg==
Date:   Fri, 28 Jul 2023 17:25:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v12 06/10] net: ti: icssg-prueth: Add ICSSG ethernet
 driver
Message-ID: <20230728172543.2d5f5660@kernel.org>
In-Reply-To: <20230727112827.3977534-7-danishanwar@ti.com>
References: <20230727112827.3977534-1-danishanwar@ti.com>
        <20230727112827.3977534-7-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 16:58:23 +0530 MD Danish Anwar wrote:
> +/* Classifier helpers */
> +void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
> +void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac);
> +void icssg_class_disable(struct regmap *miig_rt, int slice);
> +void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti);
> +void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr);
> +
> +/* Buffer queue helpers */
> +int icssg_queue_pop(struct prueth *prueth, u8 queue);
> +void icssg_queue_push(struct prueth *prueth, int queue, u16 addr);
> +u32 icssg_queue_level(struct prueth *prueth, int queue);

If you create the prototypes when the functions are added there will 
be less need for __maybe_unused. Compiler only cares about prototypes
existing, not whether actual callers are in place.
