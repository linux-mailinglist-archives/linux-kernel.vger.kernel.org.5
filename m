Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF5E803203
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbjLDL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjLDL6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:12 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2511BCD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:43 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d064f9e2a1so61052847b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691062; x=1702295862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOrDUl1Keip1tl5m5OmM/8Js28UuLPBIxfmZpg+tVRY=;
        b=M+PomashyYwJRj+IVCmGBpr5nXqrFGF7a+h+GhLWrmR0MJDdZgsKOdgQTgylexSsfG
         Hc+axp9GQvcHO4Q0yP1ZNb743ACYg0p0jM2eyU9RCrYBAawUjZognbSs/uGubhFycYLt
         xRqIgHCj873wZAzphhidE7QksgnE5fN9Mh8vnis+oL17sjEifpihAlvkbsJsyHBB2a8c
         uMSBnFOVGV1dmjx+k1HlTp6AjNR1XvEzgLMN3j8SjUsA/WWYLGOzBOebs+yi+znudyA3
         3e7D0qJ0rUXlXPB6GU6mWvrxRi//KRvfJ4+9p/xp1sQbY1WBIcT1mOvw07NxVcLNJSxU
         AyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691062; x=1702295862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOrDUl1Keip1tl5m5OmM/8Js28UuLPBIxfmZpg+tVRY=;
        b=u+/QDLeavtwsCWfdM+4UV1I33a6RLDFg24SGe/sIzs8HkIMB0eEFGAkHny4zZDgXOA
         zSTkC4/lhQaWm6dBbza6yZh8H3WIyjcJGWqV0qxhsipru8s/tvlLHwN71GSTvCerhk3r
         q61P8oxGfEzfO6CNeqxYIXKFq0zf+gc08owVD2xlGcNARHYSk2xTqPqEgDiKo90Po4SM
         3gjUhFlxOlKp2J/lp2I4uOR93f6QQZR1m8lGRQVH93HKqQN9CX/JIr4lufqftsVFBqGG
         7ubwwm16OvpLP4fqIecLWILdTI9c1XTxlvaHLdhGAmF2UdUFkjf6vBEQowhKS11S+nU/
         ORHA==
X-Gm-Message-State: AOJu0Yw371iilLfzB0yqxx37bz4rjfzko6I5rBqgtajpUDgtps0mMtC0
        22pbgRQ8RLCPJChtjCwGijArAjBthJ5PlTI=
X-Google-Smtp-Source: AGHT+IEyZiwlX6Dqa6atQrSIMCt4wupcLy34l1LF0MpyLnNCpOTreSxfxUpfu75lzQ/yRhJSRjchAbtv72o1wdA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:2509:b0:5d8:5d2c:121d with SMTP
 id dt9-20020a05690c250900b005d85d2c121dmr59294ywb.7.1701691062674; Mon, 04
 Dec 2023 03:57:42 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:38 +0000
In-Reply-To: <20231201172212.1813387-27-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-27-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115738.43282-1-aliceryhl@google.com>
Subject: [PATCH v2 26/28] binder: avoid user addresses in debug logs
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

> Prefer logging vma offsets instead of addresses or simply drop the debug
> log altogether if not useful. Note this covers the instances affected by
> the switch to store addresses as unsigned long. However, there are other
> sections in the driver that could do the same.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
