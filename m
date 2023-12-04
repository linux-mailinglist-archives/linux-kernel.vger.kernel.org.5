Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991688031F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjLDL5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjLDL5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:25 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914A8D60
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:24 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50bf87fcb29so690258e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691042; x=1702295842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4y4PXLMbbM5gC9PlYGmfvYBH1e0YhV18QBtSChJHwEY=;
        b=hzDZMS0kR45DnDxoay+U3NZuJ+V3WTRrltNajA/wD8jPQsQoyms5uXJZaYs9vxO2eR
         2CHyfNWMHKEVccbI7FCKuGLKFACr2unu0TOvKKYOADCDmy3T62WVHYAMFG1vs9elGP1N
         KDD5sKVpja8d7DjbQkmmSm6qWLdol8yGgUqlmeN2IqGQ6cf6p/SLnXS1nqyAcjtSGF5S
         9cmUMhyJpOs07p7AcNH/zBt/A2lttXENJJNEwesX+dZhI9kgEG2Mj2vbcNEUVgscL38I
         gwPwx1mwXMVCbwuvaoGuqRnNO3ir1WaMP3iXcXYUCDcL9hTfdH/VcPHS+wSITv9pkVFA
         ATfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691042; x=1702295842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4y4PXLMbbM5gC9PlYGmfvYBH1e0YhV18QBtSChJHwEY=;
        b=e+5aKGEO11IDlEdStRMwqeQNhi+rwQ1ZgqOgi0RPM5mC/WaGnxM7HPy7smPYO2FIOY
         ru+9LfonvASKCSkgVnl5oHz632K/6xtQnjDG4bhRNsVT3t1xTVOOvDGxIrHEQrlFd+96
         ZfBtS7aJenTN+HdXgDsbj8G/Fh4Y2qdVUKmDlgKbe2riu8OnTHirMz+z8TivbEdGgDEE
         tvEOdP6j7one7Os3OVDlLVr5dKLYoykIJCcUrW4v08Hcssc1thBeSmGOUbcRT+xBlKGq
         iW3xwZwp4HYpw5xB3I8+11rQYoDGWsGt/7LTylBtr8s0bqQRk5tRlyimT88O2iAK2IWg
         9zzg==
X-Gm-Message-State: AOJu0YwjwqHRqpwoqsMT5gV277BR4CGJ47CGMzH+B0h5w7BWX3gMj5J9
        J7PUDw0SC5enSINuI/pyiJFCIfGxY96/KVk=
X-Google-Smtp-Source: AGHT+IE4FSGt5ByAblRy/phTdFiv12wXrz4Pb499N142YO4v2jISihL6btP5JvoH5Q3aviLeZw9LeYzrJZBh1ME=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:446c:0:b0:50b:e8ef:5553 with SMTP id
 y12-20020ac2446c000000b0050be8ef5553mr59361lfl.12.1701691042763; Mon, 04 Dec
 2023 03:57:22 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:19 +0000
In-Reply-To: <20231201172212.1813387-22-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-22-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115719.41739-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 21/28] binder: make oversized buffer code more readable
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

> The sections in binder_alloc_new_buf_locked() dealing with oversized
> buffers are scattered which makes them difficult to read. Instead,
> consolidate this code into a single block to improve readability.
> 
> No functional change here.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Tricky, but looks ok.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
