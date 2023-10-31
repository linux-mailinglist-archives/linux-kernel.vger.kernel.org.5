Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482307DC565
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjJaEkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjJaEka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:40:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D9EC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:40:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afacc566f3so43570747b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698727227; x=1699332027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B+4M8qUb5+K1a/FyErFSr70ByarKTZl/dAflxdGEIYs=;
        b=JzMzwDj5rCwDFltmypSuAq/A9ZtimnuGg2cEStD9jOCqE4t+vwow2ZEltyfT/lW7h4
         zgZsfhxNsegXqwIhGmV2ha1Yo3vaeWvr2Cyo3bKaguvr+SJszL61TzIpP0cCRyYJ2Bt0
         3viXEXhHMyI9QYnMvFLw+87DoHlFIzFi0xaHdJCicUHgq6meC2kNQXbGcRu83L9MsvMq
         vO0IWxb1iuwCJbHT63rpnFv1UsrOyIYKVrao1SDrO39dck7XzPanC3wHxNFuDnwN0JSY
         9XrIKQuzssN9+J4fMBoFPpHeLqgfjsTibrealaKVyiT2Gy4CI3lJd8TkcOcFZqkA8yfb
         0Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698727227; x=1699332027;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+4M8qUb5+K1a/FyErFSr70ByarKTZl/dAflxdGEIYs=;
        b=s1w14rk2lb1lZDSaTIcG+i6mkvYYCoN/trbNceGcU7f12Jx37ZBq/6BvQJqMD4Juxn
         rB5gw/sRONF4lN/el3lN8mgf0/18mFKGoPjGkbVIBAaIgJlePLmizW9WRe2+yyvqF6a9
         RKmkPI9wrclylhl6A2csdPsZGh2nLWCvMNc0s3urLY6RvxgF/3p3nUOTgELSTdkTBUag
         KUFAZbJs5dVVciifWb5PmPFCbaw9xJ4XGtxwjiAzIojlT/v/TgqTMZJ1sD3OC0a8VgkS
         IAXWmOZfCteoGaidasWWIbbzJugnDMyJct6ugIzr/7NiItKkEIO83Ru9f5j1mc+RJLbK
         OZBw==
X-Gm-Message-State: AOJu0YxU/x4eSR0KfKVOsDDKjfAIVcqjP4pXGvxHPKKX2f17r/VKh+hB
        JzvhIo9KBZqASCG78FSp8jI40yrj9dVM
X-Google-Smtp-Source: AGHT+IFmi1MxN7IGA0HwSD8daE7NbfCukvyuvVk1gsK7/fnUQW91z567nVv1UgqB+zjOJBkLtdh1RavIrgGp
X-Received: from mnkumar0.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:313a])
 (user=mnkumar job=sendgmr) by 2002:a0d:ca12:0:b0:59b:f138:c845 with SMTP id
 m18-20020a0dca12000000b0059bf138c845mr224715ywd.2.1698727227457; Mon, 30 Oct
 2023 21:40:27 -0700 (PDT)
Date:   Tue, 31 Oct 2023 04:40:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031044021.1162403-1-mnkumar@google.com>
Subject: [PATCH 0/2] Add a quirk in xhci-plat for parent nodes to specify no
 64 bit support
From:   Naveen Kumar <mnkumar@google.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        royluo@google.com, Naveen Kumar M <mnkumar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar M <mnkumar@google.com>

This patch aims to expose the XHCI_NO_64BIT_SUPPORT flag to the parent
nodes of xhci for clients to specify if they can not support 64 bit DMA
memory pointers. This issue was observed with a Google SoC that uses
a DWC3 controller where the virtual address's higher order bits are
truncated

Naveen Kumar M (2):
  usb: host: xhci-plat: Add quirk-no-64-bit-support
  dt-bindings: usb: add no-64-bit-support property

 Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
 drivers/usb/host/xhci-plat.c                        | 3 +++
 2 files changed, 7 insertions(+)

-- 
2.42.0.820.g83a721a137-goog

