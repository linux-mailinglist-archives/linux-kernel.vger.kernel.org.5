Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CFD7AB2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjIVNb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjIVNbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:31:25 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3A194
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:31:18 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57354433a7dso1063399eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695389478; x=1695994278; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ji/l+kqDrSYCE8DpK9z+5z+WRklc8aec4o8DdHLKrCQ=;
        b=VZue6HsZLg65T2YAOmlrmCN1UPtxkVf29nKbcrzCQDYuWBzqfoJmqUrBmFUytWe0sF
         7v2SVzoNO9uW7wNKnq2OhuGEuRUM43iS8xa5D+LHnEF3QRfjTIvm+R6xWTorisjx7dtI
         aA0TGvVl0mnLMA0PrvhXJmAdRUdXYeD+ufFGfTw8qOqhBzJlkUhWds+UvSRFHw42SljP
         PHiBqdRW+uzOqjFX4xGFkdOBB2ME6RJ8GGbhxYe20ssExnLA8oYgSA38MNYVZ2I2dzeG
         NlAoRO8ObuzKtyneeynqnUimE5i7RPFzC4cTY6sBO+3n3PB6uHO2WvUqJRr/zduqNs1V
         L2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695389478; x=1695994278;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ji/l+kqDrSYCE8DpK9z+5z+WRklc8aec4o8DdHLKrCQ=;
        b=F862zBR2RlRqX1iCTtcs5uG9/6iRL90xdTYg6Ocf/X2V/hcfCzt9oGi3UL3lkGF1IB
         LIqHhJ4uORhPCA6dKRGe+lep6oBOffOIm/3m1H7ItrKgMBIKQcrcw7abHieYET8oslpJ
         xw03gIW2j6hbafgDW684t9vKuUzgMwbU+fcVQsrAwq9OS3SmzYqbr7JuE5klkFjNmTJn
         fF1cvAs5X6v2fsjvoJINuFUFedyXP4tAreFc/TLgUNUxKh3wS4WTUqafJQ3QxsBnQmf0
         FvEkQbK/0hVn+NVFMNdgFYm/epJ8MRtV/2tMnH04gyvAc/I9YJzzJpY5FIQxhqVyssfl
         bt2A==
X-Gm-Message-State: AOJu0Yx/CxUMOcJUM2jf2D640JU1tQHoE1AHx0OEGpUxY0jDuDf1gK95
        ilIJ3h2BW7McUkIBLn/3xijeswO1r+QdvegowysS7jUC
X-Google-Smtp-Source: AGHT+IEWAz4jq1VLWA0Mk3JUet3WQPp9RyoFWkLLqpevEKDMzU+KX5SPzSKaZRfXDWmVfbmqnCLP0hb0rliviT0Hr2E=
X-Received: by 2002:a4a:d086:0:b0:57b:40c8:d296 with SMTP id
 i6-20020a4ad086000000b0057b40c8d296mr6326707oor.3.1695389477986; Fri, 22 Sep
 2023 06:31:17 -0700 (PDT)
MIME-Version: 1.0
From:   Dzmitry Sankouski <dsankouski@gmail.com>
Date:   Fri, 22 Sep 2023 16:31:07 +0300
Message-ID: <CABTCjFCe0-Ghy4roZHnuXpRataQVd3OOaPDH-ZvDQxZu11Uvxw@mail.gmail.com>
Subject: Right place for pmic powermeter code
To:     linux-kernel@vger.kernel.org
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

I'm working on pmic s2dos05 driver. It's basically a voltage regulator
with ADC capable
of measuring current and power. It is used in portable electronic
devices, like smartphones,
for example powering display and touchscreen in Samsung Galaxy S9, so the phone
is able to estimate display power consumption. In the vendor kernel,
it just has a bunch of
sysfs attributes, and the measuring code in the regulator folder.

Where is the right place to put regulator power code, and where to
expose it in sysfs?
