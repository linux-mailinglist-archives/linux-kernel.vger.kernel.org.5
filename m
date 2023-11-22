Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7C7F453F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbjKVMA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjKVMA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBA8D4A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:00:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C4AC433C7;
        Wed, 22 Nov 2023 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700654423;
        bh=yLbsIndVEu9nwXZGIk3y4ZbcjJ+wx0rGSOC9LYLvqkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLv9C4UHg1F32f03vhMzZZoVyMETeNhdIkamILbfGRdlfAsC3UXIrJ4JoERKSfODc
         3foeqgG6MUhB7falkOPj5do7txjUSJs66D4jh58XmjwmuOyLDvqdsInRnkopMmMh/E
         OE3YCMv2VbMW4qAr3LpbNqWSFvJLVOa0ymYYahhah1j1FpiG8vcSGwgjxAh979rElW
         UDoi2FtRbOYQ8oJiF27nx6MH0g7zYrOrd77z7RhFvYxvdw3nlE8AJoZFq38y86oVj6
         UQQGAC9F+sWpNkpdl3PZflHsc6oZm8VGQcMC3gtoDH5JlucBOSztUXuyepO3Q4Vmrg
         pzrnzWOP0FTYQ==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2 0/2] soc: sifive: ccache: Add StarFive JH7100 support
Date:   Wed, 22 Nov 2023 11:59:22 +0000
Message-Id: <20231122-vocalize-splotchy-1cb4f171dda0@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031141444.53426-1-emil.renner.berthing@canonical.com>
References: <20231031141444.53426-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=763; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=WfkmwEoyD3fGvlSTinUXdzHlQ+oJRv+XCNHDd7CpSRc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmxbyXCdY+2Tj9huPV1j/BlK0/bKVnmcz9OCj63a1G72 rJD3mxGHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIaSDDX6nPkj3iTawJCyMm CfMvTM0vmSW4SJed65blKyGH3kPnFjL8s1mWFZ6Z/JFT/vzL6YysWsn2pZzG0WH6MsJb3p7onVn IAwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 31 Oct 2023 15:14:42 +0100, Emil Renner Berthing wrote:
> This series adds support for the StarFive JH7100 SoC to the SiFive cache
> controller driver. The JH7100 was a "development version" of the JH7110
> used on the BeagleV Starlight and VisionFive V1 boards. It has
> non-coherent peripheral DMAs but was designed before the standard RISC-V
> Zicbom extension, so it neeeds support in this driver for non-standard
> cache management.
> 
> [...]

Applied to riscv-cache-for-next, thanks! I still need to figure out how
I want to put things into linux-next as Arnd wants these cache driver
things in a PR of their own.

[1/2] dt-bindings: cache: sifive,ccache0: Add StarFive JH7100 compatible
      https://git.kernel.org/conor/c/3d70b9853b44
[2/2] soc: sifive: ccache: Add StarFive JH7100 support
      https://git.kernel.org/conor/c/0d5701dc9cd6

Thanks,
Conor.
