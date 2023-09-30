Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437747B3F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjI3JAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3I74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:59:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA951A4;
        Sat, 30 Sep 2023 01:59:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE8BC433C8;
        Sat, 30 Sep 2023 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696064394;
        bh=1NZBpNaePwgZyqTYVZzHQMy6LAwMcDHJLc2HBjoXiRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYJJKganbX3CrwsaFP6Ya8fNmRlm6VYhCesgYNknoAOLq8CD4oGZUiwDQ6ZjAwIN6
         hvdS6pG4aY0zkjIvgcHpAbH/sQ+HGzTatB8CWL7TyJpQOj05lqp5ZJsAA99t9njbed
         WLwdRMkHIanVfLmwzkGpWvoM6wZqeMY+vBmrNSe2JhD1Prcwsc5VHC0U/8O7yJ3JHU
         +HSqmMJXWATQdAguQ/8pl9BQuTUsy6+1EbowQYbsr0AFjl3ZgnBuQ+CJDd+79mGRgw
         rDxrTbnMqQMx2FHPrapN7Euy0nHFRHRxj3sVVcJ6IMgSWuu0jmK+bD7KGPXxxI1FEu
         BplZmUREXbPag==
From:   Conor Dooley <conor@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org,
        William Qiu <william.qiu@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: (subset) [PATCH v3 0/3] Change tuning implementation
Date:   Sat, 30 Sep 2023 09:59:36 +0100
Message-Id: <20230930-unmoral-mutiny-e3f91c0dfee9@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230922062834.39212-1-william.qiu@starfivetech.com>
References: <20230922062834.39212-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=614; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=oc9r++Iw46ON8c3zQoZkFVZiJ95/zJVfIOBlU0YyBzE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnij8s6zJ/s40s25vz64se9FoHD5w+FbtqR3RRnwFZmU Rplp8/UUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIlcfMnwzzp9Qkx6jBCfwY71 YdME/p75tHjKXvv0H88OhCrP0GIWPcjwV5Tb9V6c3p77qyteaCa0qE+7HtmbanpwB1+q2Ot/0o8 aWQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 22 Sep 2023 14:28:31 +0800, William Qiu wrote:
> This series of patches changes the tuning implementation, from the
> previous way of reading and writing system controller registers to
> reading and writing UHS_REG_EXT register, thus optimizing the tuning
> of obtaining delay-chain.
> 
> Changes v2->v3:
> - Rebased to v6.6rc2.
> - Dropped redundant criteria.
> - Keeped "starfive,sysreg" in dts file.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[3/3] riscv: dts: starfive: add assigned-clock* to limit frquency
      https://git.kernel.org/conor/c/af571133f7ae

Thanks,
Conor.
