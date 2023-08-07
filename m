Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41B77233C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjHGL72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjHGL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:59:23 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E292106;
        Mon,  7 Aug 2023 04:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1691407284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ijYexI5QmdWQ0kvS0dVtdtyvZPj2CtQpyXkKIil5a8I=;
        b=zHVPC15KEWG1gbOY+NqxDYvWE6TtwuWRG1btnF/NDRyQnbKSEQ3h24ruJ8yS81DSkW58dd
        g5UgpThZwHpHfj4YPDwYGj/Wb9FFOuktHD2FuDzhq7GlAoDJp8r9vfxmFI9flk4iefN1Im
        AiXkuWvvjdWOYrDqkcwt0Q1bg/LoPoA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 0/6] iio: Add buffer write() support
Date:   Mon,  7 Aug 2023 13:21:07 +0200
Message-Id: <20230807112113.47157-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[V3 was: "iio: new DMABUF based API, v3"][1]

Hi Jonathan,

This is a subset of my patchset that introduced a new interface based on
DMABUF objects [1]. It adds write() support to the IIO buffer
infrastructure.

The reason it is not the full IIO-DMABUF patchset, is because you
requested performance benchmarks - and our current numbers are barely
better (~ +10%) than the fileio interface. There is a good reason for
that: V3 of the patchset switched from having the IIO core creating the
DMABUFs backed by physically contiguous memory, to having the IIO core
being a simple DMABUF importer, and having the DMABUFs created
externally. We now use the udmabuf driver to create those, and they are
allocated from paged memory. While this works perfectly fine, our
buffers are now cut in 4 KiB chunks (pages), non-contiguous in memory,
which causes the DMA hardware to create an IRQ storm, as it raises an
interrupt after each 4 KiB in the worst case scenario.

Anyway, this is not directly a problem of the IIO-DMABUF code - but I
can't really upstream a shiny new interface that I claim is much faster,
without giving numbers.

So while we fix this (either by updating the DMA IP and driver to
support scatter-gather, or by hacking something quick to give us
physically contiguous DMABUFs just for the benchmark), I thought it
would make sense to upstream the few patches of the V3 patchset that are
needed for the IIO-DMABUF interface but aren't directly related.

As for write() support, Nuno (Cc'd) said he will work on upstreaming the
DAC counterpart of adc/adi-axi-adc.c in the next few weeks, so there
will be a user for the buffer write() support. I hope you are okay with
this - otherwise, we can just wait until this work is done and submit it
all at once.

Changelog since v3:
- [PATCH 2/6] is new;
- [PATCH 3/6]: Drop iio_dma_buffer_space_available() function, and
  update patch description accordingly;
- [PATCH 6/6]: .space_available is now set to iio_dma_buffer_usage
  (which is functionally the exact same).

Cheers,
-Paul

[1] https://lore.kernel.org/all/20230403154800.215924-1-paul@crapouillou.net/

Alexandru Ardelean (1):
  iio: buffer-dma: split iio_dma_buffer_fileio_free() function

Paul Cercueil (5):
  iio: buffer-dma: Get rid of outgoing queue
  iio: buffer-dma: Rename iio_dma_buffer_data_available()
  iio: buffer-dma: Enable buffer write support
  iio: buffer-dmaengine: Support specifying buffer direction
  iio: buffer-dmaengine: Enable write support

 drivers/iio/adc/adi-axi-adc.c                 |   3 +-
 drivers/iio/buffer/industrialio-buffer-dma.c  | 187 ++++++++++++------
 .../buffer/industrialio-buffer-dmaengine.c    |  28 ++-
 include/linux/iio/buffer-dma.h                |  11 +-
 include/linux/iio/buffer-dmaengine.h          |   5 +-
 5 files changed, 160 insertions(+), 74 deletions(-)

-- 
2.40.1

