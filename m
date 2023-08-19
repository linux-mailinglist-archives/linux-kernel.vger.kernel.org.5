Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6B0781BBD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjHTAaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHTAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:30:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFCD50364;
        Sat, 19 Aug 2023 16:06:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68730bafa6bso2152360b3a.1;
        Sat, 19 Aug 2023 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692486409; x=1693091209;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fb9Y6wH9ksGJCEUqC+kmWyIMYQd6L4KE7WhXYSmxnbs=;
        b=OI95oC8rlOies9+I40KRe3Gga1tSHOWCEfkyfjKNgp3TY0gIkO/Wa2DPgYMmM7ln5A
         7maMdSfKBgnyig5e0vpt6GbOOHFhvyU6K9AOpBjLkA5pGmF2NgvVdglZDgtzN24cCJan
         bXMeNZoeSl18J1etM8gezYANwkGs+5O0IX+FUFx4qBoF1Ia0beUaUFyW8XftQwpwyX4a
         /v9NDEdLJiYl7jaS5XTpeJLIV0NFe5yRjSv4TlRn66LdNRU2nSw1ekmdT73O2Q/NfTs1
         T8E5qKpOytLFkuNkheMeiT8ovEs+K/vDahimFJQZfnQFh/IT1zPG7dBkkAAwV9Jn5KrT
         Iwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692486409; x=1693091209;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fb9Y6wH9ksGJCEUqC+kmWyIMYQd6L4KE7WhXYSmxnbs=;
        b=QvrLbPTlt0FLc4ThgT2lLxLQR4wkg718fVG9NnA9/l4iozDmp5tfLAQ8wd25H+StYS
         ObxRPtLjKB2Sep9SI6BLy4XRjv5JcfpWfSc9elHULivWn00RFEfH/TbS6AmcrtFJszAK
         KRwacDvetC+XVyVk/TZVVkW3NbFzwyJxWOT58v5oe4sEUjUYuBlnOMf2lwOLTtbSXaAq
         A6XjsOePnWNvN64Su7x1ye6KwtsbEayZLc21bIC7x6CFT/Kh7N8CdiEyjuURcNhcwVFk
         FkNtbcqOB8JPTvQbBKdvxE3qh0y5ozxsGMbBOm1qatIcoreycmT5hLHZcau+2igxRGe2
         apoA==
X-Gm-Message-State: AOJu0YyaREYrEGhARy3njWwZ07lQTrEU1/1UCFTqDR3lqPuC55IwbnMO
        2vi6MoFQ3+2KyxPDQXtxr0ZpiwJMN29fhkYLtW4=
X-Google-Smtp-Source: AGHT+IHVocQOG1jCLX2t08Zt6mZuAQ2CQP+zjUcLtMW/pZFcCUsPvopPfmVwcaHOmyjZaBBull8QpatEID7PoILDkQQ=
X-Received: by 2002:a17:90b:3748:b0:268:b54:7c13 with SMTP id
 ne8-20020a17090b374800b002680b547c13mr4517075pjb.9.1692486408828; Sat, 19 Aug
 2023 16:06:48 -0700 (PDT)
MIME-Version: 1.0
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 20 Aug 2023 01:06:38 +0200
Message-ID: <CA+fCnZfePUVqSJWBsPsBghiDQ165FhkaC38aR9GSrnY0BML5Sw@mail.gmail.com>
Subject: dwc2: calls disconnect instead of reset on port reset
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

I have been testing Raw Gadget with the dwc2 UDC driver and stumbled
upon an issue related to how dwc2 behaves during USB port reset.

The problem is that dwc2 calls the gadget driver's ->disconnect()
callback when the port to which the device is connected gets reset by
the host (via SET_FEATURE/PORT_RESET). My expectation was that the
->reset() callback should be called instead.

I grepped the source code of dwc2, and it looks like dwc2 never calls
the ->reset() callback of the gadget driver, not via
usb_gadget_udc_reset() nor via call_gadget(..., reset).

I was wondering if it would be possible to add proper reset handling to dwc2?

This would make it possible to write UDC-agnostic gadgets with Raw
Gadget without adding special handing for this dwc2 behavior.

Thank you!
