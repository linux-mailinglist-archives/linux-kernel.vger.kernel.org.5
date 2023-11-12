Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A97E9355
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 00:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjKLXMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 18:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 18:12:41 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72647D4C;
        Sun, 12 Nov 2023 15:12:36 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso3278770b3a.1;
        Sun, 12 Nov 2023 15:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699830756; x=1700435556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kINOohyUI5UBn47vUF3tJOP4oDKGMiC1TLYt+h+N9h8=;
        b=cKtLILqHeL+pnYUEEgjKI5t2rrlkKtdgqnc3nWqDn5V7aTjmt2zGXJEcaW95X9bDPO
         h4RHuLYLQYFf+NWleGptfxCZmr78JchXQWe0qyyFZDovrcIzFbcQYdSeF5PjdCrqNbXG
         tfGp1b1aH8m5UUCfPcCPxCbTQpeJQFkVS3e0ob58FbdyiEYsUxRJRYUe7twKw3CKe4H7
         hFJJYGla5pC4Q3gr7K6gBpq96GIyRvLBCxDBKchmYDA86IwwlVsuxntyOdK1RGLusqCL
         Z73JReRUIxeUYKQZ+pyjMZVcezBjIRxp6Tgr4zKg2M7kVncxUGvfCLuoW17BNOC4ATjN
         ZMQg==
X-Gm-Message-State: AOJu0Yyd1zZVUM1YyvQpf8ozZOu0sS379Re/WcRhaMRmnN8jmWatnuFc
        zwPGTNqe0wrdKQZ0Usph/FU=
X-Google-Smtp-Source: AGHT+IHM1xHv6Bya3xnKdXlAB4GGDEjoopo7t48S2k9vh/N7JJhUB7QT9lDd1A0TcBVCTEHnRb9f5w==
X-Received: by 2002:a05:6a00:13a8:b0:6be:2bfa:6290 with SMTP id t40-20020a056a0013a800b006be2bfa6290mr3248217pfg.8.1699830755833;
        Sun, 12 Nov 2023 15:12:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id n3-20020a6546c3000000b005b8f3293bf2sm2554422pgr.88.2023.11.12.15.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 15:12:35 -0800 (PST)
Date:   Sun, 12 Nov 2023 23:12:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nischala Yelchuri <niyelchu@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        drawat.floss@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, deller@gmx.de,
        mhklinux@outlook.com, mhkelley@outlook.com,
        singhabhinav9051571833@gmail.com, niyelchu@microsoft.com
Subject: Re: [PATCH] Replace ioremap_cache() with memremap()
Message-ID: <ZVFb4f8IRJeCFmYD@liuwe-devbox-debian-v2>
References: <1698854508-23036-1-git-send-email-niyelchu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1698854508-23036-1-git-send-email-niyelchu@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:01:48AM -0700, Nischala Yelchuri wrote:
> Current Hyper-V code for CoCo VMs uses ioremap_cache() to map normal memory as decrypted.
> ioremap_cache() is ideally used to map I/O device memory when it has the characteristics
> of normal memory. It should not be used to map normal memory as the returned pointer
> has the __iomem attribute.

Do you find any real world issues with the current code? How do you
discover these issues?

Thanks,
Wei.
