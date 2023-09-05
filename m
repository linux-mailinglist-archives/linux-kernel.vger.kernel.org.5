Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF2792A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354578AbjIEQ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354334AbjIEKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1530F199;
        Tue,  5 Sep 2023 03:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DAC66068B;
        Tue,  5 Sep 2023 10:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7864DC433C7;
        Tue,  5 Sep 2023 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693910849;
        bh=s7bezVMuronD8AnPMbbw+I84vvlIIOq2qxIuhKy2z2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=PWOY0VLH5P7VHEKlqoZ4BQJC+35/X8ZmeCcrhJAZn/3qJC8XM8pwMkR6jmbHOzU3i
         z0qGV3eNLjPfHrwvdC1uC9USBmbEAJFiomM8Ma8Nb5wwrugycNcfhwdV0BPdSEvQ61
         VoNlzCUuO4c98ykWC+h3igiQHUg/cobnCyc3FAfuMyigSdlw+WYbBVPsWXJyfqt7L9
         9rCMxKu20XhCAyD+Ki9CTeevl1vwd5HOg5+KPZF2EW+MNinKl2JisRWKb/aAKNAERl
         p3n0pac9B0+VCKgvYO8+Of+gibWwcY3hsNdgAVDXEswkmFh5WujV2igUxcOBq0Rd38
         osxnuGvI5hapQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 0/2] irqchip/gic-v3: Enable non-coherent GIC designs probing
Date:   Tue,  5 Sep 2023 12:47:19 +0200
Message-Id: <20230905104721.52199-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv3 architecture specifications provide a means for the
system programmer to set the shareability and cacheability
attributes the GIC components (redistributors and ITSes) use
to drive memory transactions.

Albeit the architecture give control over shareability/cacheability
memory transactions attributes (and barriers), it is allowed to
connect the GIC interconnect ports to non-coherent memory ports
on the interconnect, basically tying off shareability/cacheability
"wires" and de-facto making the redistributors and ITSes non-coherent
memory observers.

This series aims at starting a discussion over a possible solution
to this problem, by adding to the GIC device tree bindings the
standard dma-noncoherent property. The GIC driver uses the property
to force the redistributors and ITSes shareability attributes to
non-shareable, which consequently forces the driver to use CMOs
on GIC memory tables.

On ARM DT DMA is default non-coherent, so the GIC driver can't rely
on the generic DT dma-coherent/non-coherent property management layer
(of_dma_is_coherent()) which would default all GIC designs in the field
as non-coherent; it has to rely on ad-hoc dma-noncoherent property handling.

When a consistent approach is agreed upon for DT an equivalent binding will
be put forward for ACPI based systems.

Lorenzo Pieralisi (2):
  dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent
    property
  irqchip/gic-v3: Enable non-coherent redistributors/ITSes probing

 .../interrupt-controller/arm,gic-v3.yaml      |  8 ++++++++
 drivers/irqchip/irq-gic-v3-its.c              | 19 +++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.34.1

