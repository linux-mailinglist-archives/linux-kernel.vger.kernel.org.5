Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86177E173
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbjHPMXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245210AbjHPMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:23:04 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1E109;
        Wed, 16 Aug 2023 05:23:03 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1F0C08E2;
        Wed, 16 Aug 2023 14:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1692188580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EHiNxjeUrAwzOphGHu0eZkI/pOqktqiZVERvri1bSWI=;
        b=o9R+3sm3pMwFG3qh3EzYHeTUHgjbIgTu8lM7an1cb+HYmwazI823tRZETHJIxMPBexoUPn
        vd/LVkxhgcSSt66PqNTUGxJo6BAe+9pO/fsrhRRrpWad/F+sd7Esa9097f5ALhX8Yk8lec
        RXlQNPwZ9Zo8v/Yh1nKCCEm8P7hFHGN8qXMahnr91zS0+arIA/Jlf4TMjXl8ymmPJ30+et
        SkfSfq4YAQ4SGue9Z4DtVr/EQ9WzrUcshtuupvENfeTzZskiwq35yXaDgZepLf9MeNXRRs
        2pygHBc6ovZ2wg2+Ha0gocKYgll3FMhxcqBrht2XxswRQ4jmfDuBPFwpwhgEaQ==
MIME-Version: 1.0
Date:   Wed, 16 Aug 2023 14:22:58 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2,1/2] mtd: spi-nor: giga: gd25lq64c: Disable quad mode
 according to bus width
In-Reply-To: <5911201a-f703-abbd-3c7b-769f70df08a8@linaro.org>
References: <20230816104245.2676965-1-hsinyi@chromium.org>
 <6702bac712daab13698b9bb9ad81d49e@walle.cc>
 <5911201a-f703-abbd-3c7b-769f70df08a8@linaro.org>
Message-ID: <80ec748f37f40ae5c3c3c5d1602681b3@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> like a fundamental problem and that commit 39d1e3340c73 ("mtd: 
>> spi-nor:
>> Fix clearing of QE bit on lock()/unlock()") is broken in that regard.
> 
> what's wrong with the mentioned commit?

         } else if (nor->params->quad_enable) {
                 /*
                  * If the Status Register 2 Read command (35h) is not
                  * supported, we should at least be sure we don't
                  * change the value of the SR2 Quad Enable bit.
                  *
                  * We can safely assume that when the Quad Enable method 
is
                  * set, the value of the QE bit is one, as a consequence 
of the
                  * nor->params->quad_enable() call.
                  *
                  * We can safely assume that the Quad Enable bit is 
present in
                  * the Status Register 2 at BIT(1). According to the 
JESD216
                  * revB standard, BFPT DWORDS[15], bits 22:20, the 
16-bit
                  * Write Status (01h) command is available just for the 
cases
                  * in which the QE bit is described in SR2 at BIT(1).
                  */
                 sr_cr[1] = SR2_QUAD_EN_BIT1;
         } else {
                 sr_cr[1] = 0;
         }

"We can safely assume that when the Quad Enable method..". We cannot, if 
we
don't have 4 I/O lines. The quad_enable is just the op how to do it, but 
not
*if* can do it. It seems to be missing the same check as the
spi_nor_quad_enable(). But I'm not sure if it's that simple.

-michael
