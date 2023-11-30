Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8AE7FF842
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbjK3Raw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3Rau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:30:50 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D511E0;
        Thu, 30 Nov 2023 09:30:57 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b842c1511fso725499b6e.1;
        Thu, 30 Nov 2023 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365456; x=1701970256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5YRUv/f6nb2mEoxA9rov/7w4nJ9wOVnYZN9JamrwUs=;
        b=iWA41sSnAvNYx51mJyPXszdWm7Q0uCOrDFlFKhS+ypwcndpE4qeSdlYrQFwiyNsVOQ
         qOnzxrCVCYaDu3VMF0PIbUcUEjX3EtrqEDOMmG3ObBbkZfEywgzraOFEuvX7GxUXMbyq
         FbMVYcrfT6Yw675gIst5btvue/nmgvYGJeBK9+o1tbP4NZg9kY964tmL0Bh4sFulcK4v
         oqoGfjtwCvOxDhwDO5A3pdxB+tVatp7aHy8Ak9SreO8ACAjlQS532vKRtAvULbVmPH1h
         MQx3jzlGyzlmEsqQ2QiKZYoKQctn47DgBwWI/I2NezeaMuNOFPbrlL+RFrviD9cso/ly
         SuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365456; x=1701970256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5YRUv/f6nb2mEoxA9rov/7w4nJ9wOVnYZN9JamrwUs=;
        b=wZFajKsNYMe59cT8ljwkKMpCTQM8HcpmGkgS2D4ww1G+WRZon4yDT2qOH2W7v0c53z
         xt0DfcCQdQ+TrbmJAkOV4Lp5m9jmRdNPrp2okl6Ys575oLOybcfnjaH+VB1c6eLs6SyV
         /QOg+GYxjbnQszCPus41w6dYoN+5i8C3alK3RtfAKNlw5Q466eEl3Mnlh9a+mQRjSl7F
         hfrdwIHOPOlIVgU6hn+bSLpTcCACKGXpUijDhe0My6GGp2emoyTIup7+DsOwXKLg/1Ha
         E/7Ekxg0oHL03Q9AGbiWsmh4xDfDSjgNJjaUwnC902LJayGKufhFZ6idrhrwCM830tib
         OYPw==
X-Gm-Message-State: AOJu0YwC/t++G4KbXMXdqNnUtuMWGVLYvkxJcY7Q4L5C9Q7n/s9gnqrB
        jS6Pz+eii6nHg2WQ2Q4xwwhUx8lOTRg=
X-Google-Smtp-Source: AGHT+IEnsEy4DAK9uP7174pLgRWpsJcBmvH7Opw9P5zmGTO/iRNwRfk0QxYcClZGaY4qfeqbBCi45g==
X-Received: by 2002:a05:6808:3a0d:b0:3b6:d639:35b0 with SMTP id gr13-20020a0568083a0d00b003b6d63935b0mr287110oib.50.1701365456518;
        Thu, 30 Nov 2023 09:30:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i13-20020a54408d000000b003b2e2d134a5sm243807oii.35.2023.11.30.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:30:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Nov 2023 09:30:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     deller@kernel.org
Cc:     linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] parisc: Reduce size of __bug_table[] on 64-bit
 kernel by half
Message-ID: <ef74368d-1fd6-4fd0-81dc-bcf04892cc13@roeck-us.net>
References: <20231124144158.158993-1-deller@kernel.org>
 <20231124144158.158993-16-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124144158.158993-16-deller@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 03:41:13PM +0100, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Enable GENERIC_BUG_RELATIVE_POINTERS which will store 32-bit relative
> offsets to the bug address and the source file name instead of 64-bit
> absolute addresses. This effectively reduces the size of the
> __bug_table[] array by half on 64-bit kernels.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

With this patch in mainline, parisc:tinyconfig fails to build.

ecurity/commoncap.c: In function 'cap_capset':
arch/parisc/include/asm/bug.h:71:17: error: invalid 'asm': operand number out of range
   71 |                 asm volatile("\n"                                       \
      |                 ^~~

and many similar errors. Bisect log attached.

Guenter

---
# bad: [3b47bc037bd44f142ac09848e8d3ecccc726be99] Merge tag 'pinctrl-v6.7-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
# good: [98b1cc82c4affc16f5598d4fa14b1858671b2263] Linux 6.7-rc2
git bisect start 'HEAD' 'v6.7-rc2'
# good: [f1a09972a45ae63efbd1587337c4be13b1893330] Merge tag 'ata-6.7-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata
git bisect good f1a09972a45ae63efbd1587337c4be13b1893330
# good: [090472ed9c922e699dc61dd601a9b376a64f4390] Merge tag 'usb-6.7-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good 090472ed9c922e699dc61dd601a9b376a64f4390
# bad: [2cc14f52aeb78ce3f29677c2de1f06c0e91471ab] Linux 6.7-rc3
git bisect bad 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
# good: [4892711acee0915a8a4ae02e1af3dc70ce000024] Merge tag 'x86-urgent-2023-11-26' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 4892711acee0915a8a4ae02e1af3dc70ce000024
# bad: [43266838515d30dc0c45d5c7e6e7edacee6cce92] parisc: Reduce size of the bug_table on 64-bit kernel by half
git bisect bad 43266838515d30dc0c45d5c7e6e7edacee6cce92
# good: [07eecff8ae78df7f28800484d31337e1f9bfca3a] parisc: Mark jump_table naturally aligned
git bisect good 07eecff8ae78df7f28800484d31337e1f9bfca3a
# good: [c9fcb2b65c2849e8ff3be23fd8828312fb68dc19] parisc: Ensure 32-bit alignment on parisc unwind section
git bisect good c9fcb2b65c2849e8ff3be23fd8828312fb68dc19
# good: [e5f3e299a2b1e9c3ece24a38adfc089aef307e8a] parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes
git bisect good e5f3e299a2b1e9c3ece24a38adfc089aef307e8a
# first bad commit: [43266838515d30dc0c45d5c7e6e7edacee6cce92] parisc: Reduce size of the bug_table on 64-bit kernel by half
