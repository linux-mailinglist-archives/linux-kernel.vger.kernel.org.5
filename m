Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E628031F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjLDL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjLDL6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:00 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7391981
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:36 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c892080ad3so33242961fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691054; x=1702295854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AM2Sh86xzKI1s/s4gT3W7JO435xJLZFx8kMi2OG0HNQ=;
        b=oXhpdjGpl3dhdpNTHGP+k1QjPi8IEtCQJQT8S7t4AANxFo2LgVcwNzYOXcC5QTsvi9
         xy2P4iZtLb6iSFbnK+0nr+vciFKEDtRdlKpNU5Buv0qhQfD/78J9llILuHTjFiQ9e+ef
         LQ+GF0b/+BOVMpLprx6t9Gq5Wepp4zv2bluKZ82tMAIGKm2BMDcO0lqguGkAHRwWvzkb
         9vJ8vtHvPExj4VAErGNqzgcsDSQ2GPpfBJFQKs3M4w3LCfQL05UHzqqlpLeSeyc+YLVE
         wOlAym1a4l0USA+YBGU63A8zqEg19qc7o4BGEk21hdkAgwke8qi9Uu5YHlhxX1yO8Arp
         tjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691054; x=1702295854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM2Sh86xzKI1s/s4gT3W7JO435xJLZFx8kMi2OG0HNQ=;
        b=kpfTvEL2iG3FzcTXuKGab8cqOiVF1ge9TazVRaTAQMfcVGb465i3FB3mdxdi2fOFzw
         c9m72EheDhwNgraKnwafuzvH+/EJ7O/IfUtRSfJkztBTgiROEi6TkAU7YwDSQaEvwkMt
         PKubDFqX4uTGtV+b5ZRVUyIcz3YKuZ+bgMHJzcR9DzG2D7Cs6ZyPyQVKA32pWj6t7aMM
         kRjhPKvmHtyLCkr+Ievvr1MzTqnMCIaJOKIIwPlj4ABX7XfdG1NbRNfhZ0O96/BEGzHv
         BNwUq0X1ttcRI7vd13lEEWsDXOe7l0xCPlxVYH6Yo4OqwfOP6xJnmq2lRoF3rbvMBEIM
         Jx0A==
X-Gm-Message-State: AOJu0YzED3XRvvkzm/JmRAPGgWaznrXiOVozOMQrBMFdlJjMzcxCxClL
        9knlRpqlMZARUoIHxKtuBG3S3jHVLuPsRnI=
X-Google-Smtp-Source: AGHT+IEWxtaV9caGJJ8TZSZfRDnWbhXNTE6kKZ+jYnU0bAyM1Vo4HDWIhFc2tdn+kEj8O+K9USPmrXC1J9oxEyw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:2048:b0:2c9:f281:975e with SMTP
 id t8-20020a05651c204800b002c9f281975emr115785ljo.2.1701691054414; Mon, 04
 Dec 2023 03:57:34 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:30 +0000
In-Reply-To: <20231201172212.1813387-25-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-25-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115730.42663-1-aliceryhl@google.com>
Subject: [PATCH v2 24/28] binder: collapse print_binder_buffer() into caller
From:   Alice Ryhl <aliceryhl@google.com>
To:     cmllamas@google.com
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The code in print_binder_buffer() is quite small so it can be collapsed
> into its single caller binder_alloc_print_allocated().
> 
> No functional change in this patch.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
