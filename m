Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD88031D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjLDL45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjLDL4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:56:55 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACDEFE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:01 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-50bfda09704so358596e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691019; x=1702295819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMojC0XetKgNgROc6KyVduhanNyLbztP/wH6+z7tfDs=;
        b=J+NGLoaX34iLStO3w5hhQ/024n7mIOWc999rrCSovurAXxyrpoU17iyoi1RX363ulN
         IL9K+lvvbFwAosPbwFwGqaS0PyNt/TDmGLOj0aHLTuCikwYWz0tbProPNAKRFptztffb
         I8hWhem+0wpUPopSHff2EHQemaXc9Vooz749WAGibJCqAJ40jJFh9Az9dkWhR9AZbF9t
         eTzIcDG6Z4+Besdg+3VkIEpMnZngbbWT5R4vNE+ySqrG17heUC/peGmJORkRR9tu258U
         BJVmXfXgidVNkrrI956Zx8MMSGDkbusRGU0qs7JD3WQ3RFsh8oHkt65VbylIdL6bG0p2
         ZSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691019; x=1702295819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMojC0XetKgNgROc6KyVduhanNyLbztP/wH6+z7tfDs=;
        b=A0jgBvGVTHj9Sx8uX9jP2MOj6JSp5yCrlyp2rIca+gqAmi/3r4EuidkiuhiFqyVGU2
         0YP/Z5Zv2g8WjRptOKS0AuM5HYXeabuG8Wy1d6iDKsToOqKdLFFuZyw9Gfrnh+ADvDoW
         G+vX2DcTdHFbp2gp6HZz47Mp2hmI+kR7Spa7Hym8FPBSDTfiu1MnM7hQ923031eNMaR7
         obPus24qVx6Hn+RzbASFAKz+oRyJNuUTV+tg9KdRjo0gv6gmJVcfcJqf0yJxrRhegxN4
         qPrBAF38xUiraHvpGCtwxOfmfjTGRmYh6SBMuGtEJcJMtXBVencI8RcWqpNo9WYds/3r
         cr/Q==
X-Gm-Message-State: AOJu0YxqwjXbzXmZeQoM02xMD+Gfbl7MUvmHZoDMwMgQchbmbRoihGRO
        9+Uoyyoyn+a/ooSXepaKP32YqkzTfsM6pkw=
X-Google-Smtp-Source: AGHT+IEBsE2UZSoezn1uFnP/LS3lzX5qJtDr9UegHm0cbXoH+RlHhXpQAoUBczSiOLK/k3wV7ETbM3uxE9u6wu0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:33d3:b0:50b:fefb:f2fd with SMTP
 id d19-20020a05651233d300b0050bfefbf2fdmr2637lfg.1.1701691019555; Mon, 04 Dec
 2023 03:56:59 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:56:52 +0000
In-Reply-To: <20231201172212.1813387-6-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-6-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115652.39783-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 05/28] binder: fix unused alloc->free_async_space
From:   Alice Ryhl <aliceryhl@google.com>
To:     cmllamas@google.com
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com,
        sherryy@android.com, surenb@google.com, tkjos@android.com,
        Alice Ryhl <aliceryhl@google.com>
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

> Each transaction is associated with a 'struct binder_buffer' that stores
> the metadata about its buffer area. Since commit 74310e06be4d ("android:
> binder: Move buffer out of area shared with user space") this struct is
> no longer embedded within the buffer itself but is instead allocated on
> the heap to prevent userspace access to this driver-exclusive info.
> 
> Unfortunately, the space of this struct is still being accounted for in
> the total buffer size calculation, specifically for async transactions.
> This results in an additional 104 bytes added to every async buffer
> request, and this area is never used.
> 
> This wasted space can be substantial. If we consider the maximum mmap
> buffer space of SZ_4M, the driver will reserve half of it for async
> transactions, or 0x200000. This area should, in theory, accommodate up
> to 262,144 buffers of the minimum 8-byte size. However, after adding
> the extra 'sizeof(struct binder_buffer)', the total number of buffers
> drops to only 18,724, which is a sad 7.14% of the actual capacity.
> 
> This patch fixes the buffer size calculation to enable the utilization
> of the entire async buffer space. This is expected to reduce the number
> of -ENOSPC errors that are seen on the field.
> 
> Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
