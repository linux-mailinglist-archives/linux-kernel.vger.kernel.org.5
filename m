Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57A47816D1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244373AbjHSCrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbjHSCrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092193C00;
        Fri, 18 Aug 2023 19:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC88163AFF;
        Sat, 19 Aug 2023 02:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3ADC433C7;
        Sat, 19 Aug 2023 02:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692413221;
        bh=oU+6WMg6c2UrnTMLgklxjc7ykpSmhNqopEee8qwkVPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UA/UNvXwmLrhSEAhg7lPYmOjNAVVkUkN9pybSImmVxT+0lHuWrCcaZDmCSoYrvjyf
         YhhI8bWGwgB+/99XZjtcruhpCWdBrpxn6MzuLWby7GqJRFG8rl8Cp+0RQ1VUqQk3jF
         mEoMvMZpzs2YDyofEWA2JeQE+79wztJn67eSs7aVEPegNN3LeoWHQEXUhIZblTGeku
         CuQQZAb6wJZuVe6I1lmEZcIgOQSfklhXfzmvPyJ2w9ky5Jtg3bfDWdjkqgDwrb5fbq
         HkwvaKBtm+RCRcUr1M0AFhFV57+Nb9oY7HsEgtMxvTIkF/G+3ZTn+MWUggMWo2BOeq
         9NRqhAAGGxXfw==
Date:   Fri, 18 Aug 2023 19:46:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 21/28] net: wan: Add framer framework support
Message-ID: <20230818194658.369da77a@kernel.org>
In-Reply-To: <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
        <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 18:39:15 +0200 Christophe Leroy wrote:
> From: Herve Codina <herve.codina@bootlin.com>
> 
> A framer is a component in charge of an E1/T1 line interface.
> Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> frames. It also provides information related to the E1/T1 line.

Okay, progress is being made, now it builds patch by patch.
Still some kdoc warnings remain (W=1 build only catches
kdoc warnings in sources, you gotta run ./scripts/kernel-doc -none
explicitly on the headers):

include/linux/framer/framer.h:27: warning: Enum value 'FRAMER_IFACE_E1' not described in enum 'framer_iface'
include/linux/framer/framer.h:27: warning: Enum value 'FRAMER_IFACE_T1' not described in enum 'framer_iface'
include/linux/framer/framer.h:35: warning: expecting prototype for enum framer_clock_mode. Prototype was for enum framer_clock_type instead
include/linux/framer/framer.h:47: warning: expecting prototype for struct framer_configuration. Prototype was for struct framer_config instead
include/linux/framer/framer.h:60: warning: cannot understand function prototype: 'enum framer_event '
include/linux/framer/framer.h:89: warning: Function parameter or member 'notify_status_work' not described in 'framer'
include/linux/framer/framer.h:89: warning: Function parameter or member 'notifier_list' not described in 'framer'
include/linux/framer/framer.h:89: warning: Function parameter or member 'polling_work' not described in 'framer'
-- 
pw-bot: cr
