Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78B7E3735
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjKGJIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjKGJI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B3110FB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d99ec34829aso6314824276.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348098; x=1699952898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBcZUl9VXze3+KhrR4iN899rqGd/s4WBv1U2hyYvnkM=;
        b=i/ivfe22bf/fULdnfryvV2FU6SXBD5TBeYiEcXT+hK3CRo/7wlWy9hSwqthZUKHoqO
         spkG6O6iv05d/2DBGwqVkxwHPJIhYDogNOzR5Vizc/jti2AGZ1HGvN27ZUvUIxI2t78w
         4xMnNTindJSNs8MW9useUN1/u6mT2yyQNWgBMBdACp8trLodiQFQ0i2S9j9Tg+bXlvtp
         AkthJ9hQ9XAIDfS/LnJY4iHR1RbEB6+OPR27OX1Wf9sw4NxA6cXlCRxzfZJjCEbmCVl7
         arUGC13eOrQLtbqMGmCekPi4kJ+FPxMsDBNy4S+vFAUvjdpqvBLob5OlGASpmuObmJNo
         azBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348098; x=1699952898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBcZUl9VXze3+KhrR4iN899rqGd/s4WBv1U2hyYvnkM=;
        b=fHJb6K9deGP1Y/Azi7IDDuNqsf885YaxylflMWVfjfVl33xrWQriP9yFsGhrwPbxba
         9LZrkoww6ToFgjkR2ohVsvWnJOkXO303pISJCczezagZEbbecWAUGri5lqjk52M6Ttp9
         xg5sDjUgegEZMQP5sEMKR6wSabs+rY0IubgtJh6dWrGAjEZOwhyzd28J0HoHhfpmnSOG
         pv3rLHktOySa5mU2CdCLnWx4++oMPiwZVSQxdLub7rjBj9X5NOtp4OVkanapz7Vry3Vn
         mNjCRvnkQJpQrGphhqmkny3tMmaFqvy9QWqO2QAxFmhs15nkmRQrcLq5cTatRZhLVdDK
         BhGA==
X-Gm-Message-State: AOJu0Ywj/J7g0oDRtm7X1KpZb4r4KlPgnDlb0ukEL15ftrwYRXPMsdn4
        8sZfm57gHAeHcchOtFHq0uHANHaGcBMZEwk=
X-Google-Smtp-Source: AGHT+IEIP+O2fpQmtpYnBdQj2LwK3Y69TS+b7MCHCio3BwySUFi7KZa7we1QjlUuMrCmLhZ0DG5z4ESgeDiPVvc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr723853ybu.7.1699348098295; Tue, 07
 Nov 2023 01:08:18 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:15 +0000
In-Reply-To: <20231102185934.773885-10-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-10-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090815.258324-1-aliceryhl@google.com>
Subject: Re: [PATCH 09/21] binder: split up binder_update_page_range()
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
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

Carlos Llamas <cmllamas@google.com> writes:
> The binder_update_page_range() function performs both allocation and
> freeing of binder pages. However, these two operations are unrelated and
> have no common logic. In fact, when a free operation is requested, the
> allocation logic is skipped entirely. This behavior makes the error path
> unnecessarily complex. To improve readability of the code, this patch
> splits the allocation and freeing operations into separate functions.
> 
> No functional changes are introduced by this patch.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

The part below err_vm_insert_page_failed was a bit tricky, but I agree
that this is correct.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

