Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BFC8031FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjLDL6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjLDL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A1D1717
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daee86e2d70so3285302276.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691047; x=1702295847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tppnGOhtTvsuvPN9KvhqraD0X5gXXSNxqn5e/U41jc=;
        b=F7eK3EEINrw7pP+24k9+pe9Vlk2CRPvZ1RpKNvLj9X0WB0HQtUrAlZt3Rc8gl28Ald
         uHhRgUEZ288+GpWqKQgni6G+yyFD8+yfIHMQu/nhE/1kjEvGIhlGQEDyIxuy63yz9HXP
         XmvmBYQeqzUpbnRABbL4aY7YmQHw30x3bYL9aZ10PLDFZQYFMl8OVS7mGEM0uDdoiHCr
         7Y0G4MCGzkK8Pyh5RMS6JlY8vELG3nryrENM2hNkNX15xxRuh2XU+0vgXfAn54gC9shC
         Dx8oW41+NowdfI0aa7IthxwZQ6X3s+BbpPW2WBcoLsdRYpGVUEHt7p3riBg9Pb5YHTrh
         WaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691047; x=1702295847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tppnGOhtTvsuvPN9KvhqraD0X5gXXSNxqn5e/U41jc=;
        b=Fk82Y0SPMP1yR14DI/SHPipH+eVdMPfUXF9Wz/UaR065tgmf8vFENkMHyRi2H8QiO1
         H7+vaVkl6q74gWDTMf2loijI6dT4Pi77tU5zWjFGi08oz+n3qIW4bwUd85XqbtdYebFf
         y81aY9BecB7e4wqmbnRh2ba522oOtGS9Fw3wErNoJUx8wPjM6XHcLNtKl4/qmrvpjKHV
         OiYRdpQClGAU0tnAt+PhsCfNu5zMwkDhByQf61yjn861bg7Q7DTgBfGXatidcQHEtfjZ
         PTBow/6L3gurni6cXQfo/Nm4Jwsi2r/CFOEwb3X+K0EQVbzCppUmr0brJNIk2e3wUU7N
         ufaQ==
X-Gm-Message-State: AOJu0YzFwCHwOpTyVNwUKJ5Ry47glcJz034No4al0zBxCszDN2A9lMj+
        uFc2YJsiSPhAiLbh2MUxd4Mx5St/xBwIkII=
X-Google-Smtp-Source: AGHT+IFzb6MVJo9bQLu1sveT4tG0Akf6YDlZvuqpTWYPFG/jGQ0QcRuMUrrM3obomYBP1Ch+eArRiHSyAhx4YgQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:3006:0:b0:db3:5b0a:f274 with SMTP id
 w6-20020a253006000000b00db35b0af274mr1066339ybw.0.1701691046878; Mon, 04 Dec
 2023 03:57:26 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:22 +0000
In-Reply-To: <20231201172212.1813387-23-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-23-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115723.42036-1-aliceryhl@google.com>
Subject: [PATCH v2 22/28] binder: rename lru shrinker utilities
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

> Now that the page allocation step is done separately we should rename
> the binder_free_page_range() and binder_allocate_page_range() functions
> to provide a more accurate description of what they do. Lets borrow the
> freelist concept used in other parts of the kernel for this.
> 
> No functional change here.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
