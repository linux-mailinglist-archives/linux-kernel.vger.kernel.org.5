Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2841D80A789
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574302AbjLHPfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574357AbjLHPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:35:08 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5639C10F1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:35:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce831cbba6so1414221b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702049714; x=1702654514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMnlzmKg9DyRCjTIo9NWw3OAfaXxDlGMMCmq8eYBwns=;
        b=4etOjFNbpPoHS28boUs7sYRfWkdQ2tCUS9pvXwumN8uZlSsec3Um/o/V9VEM3fUad+
         g8T1idhFVN/aeHE4Os97MT2/pQb9kJCL19UweaZRH2fPU2mfhtOKuAlsogwOSYCxA41W
         dtpK/aedkwBbBCDUrOcJ0TS5/6PyjSDdSnTjv2Mv/q1WHKDtnsqcGa1ld3kVguDxzdPV
         kUU5K6BWS0M1M+n1HPRuvR5+iFhSO366VDvIOvOEO8pLP8KUaE0uDpOF2JGHy3sZLQ/l
         1lvVpYOX/wFJv7qa9t5wvAXsGjR+/vZekeb0AuKtGaFkijbv9hQBV5WUzhn9ig6S8N4m
         zWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049714; x=1702654514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMnlzmKg9DyRCjTIo9NWw3OAfaXxDlGMMCmq8eYBwns=;
        b=GwzWd85iUAJWeqdVrFEY8hhK/EzlKBgZK0aRqjmjx5U1s61F2721wTPKH5iU5NTcEk
         vJHuTLXzdL/R39D+SWVdwnIlO9ZlyXXKeOvuv4+VVp+sJPjAHEpT1kasLZkdm/yOq1F2
         CfBoVVlsD/oWLkHwlwbyr7PlIpJAAzI21PAZRNYGCw0tVwVd6bYOka5rDpWqXMr/Pr1N
         L3Mg0DJ7vK3w5C8brjK8BVwTt3lVQu/qzTqfw6aZCgUfiexnY50FVFVBP+UIkF769Bo4
         YN19dKwmZimnH0xPVAxRUwzekDkHQBIIYRaSNTjlLHPxOlxCRCimU+wCn0Nz4d18vMDD
         KRIA==
X-Gm-Message-State: AOJu0Yy1iSBBqL2NEO+FJSBESAzjoEIK76LGM46Awwbh+wtN0Etf7It2
        KKvnm5d0OHKfCV0YnjRzDlwEQQ==
X-Google-Smtp-Source: AGHT+IESf1k2n13MqKMWia14nJinAeLSzbt4CtMuDPySehvv8O/Fb5ljzWIN2rcZTIGwCXb+V2Y9mQ==
X-Received: by 2002:a05:6a20:f388:b0:18b:251d:d6fb with SMTP id qr8-20020a056a20f38800b0018b251dd6fbmr206420pzb.1.1702049713574;
        Fri, 08 Dec 2023 07:35:13 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id r3-20020a655083000000b005aa800c149bsm1496119pgp.39.2023.12.08.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:35:12 -0800 (PST)
Date:   Fri, 8 Dec 2023 15:35:09 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Suren Baghdasaryan <surenb@google.com>,
        Li Li <dualli@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] binder: use enum for binder ioctls
Message-ID: <ZXM3rXugrgWCqqgP@google.com>
References: <20231208152801.3425772-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208152801.3425772-1-aliceryhl@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 03:28:01PM +0000, Alice Ryhl wrote:
> All of the other constants in this file are defined using enums, so make
> the constants more consistent by defining the ioctls in an enum as well.
> 
> This is necessary for Rust Binder since the _IO macros are too
> complicated for bindgen to see that they expand to integer constants.
> Replacing the #defines with an enum forces bindgen to evaluate them
> properly, which allows us to access them from Rust.
> 
> I originally intended to include this change in the first patch of the
> Rust Binder patchset [1], but at plumbers Carlos Llamas told me that
> this change has been discussed previously [2] and suggested that I send
> it upstream separately.
> 
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-1-08ba9197f637@google.com/ [1]
> Link: https://lore.kernel.org/all/YoIK2l6xbQMPGZHy@kroah.com/ [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Acked-by: Carlos Llamas <cmllamas@google.com>

Thanks,
--
Carlos Llamas
