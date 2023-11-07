Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C667E372C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjKGJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjKGJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D4114
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:07:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dae71322ed4so709655276.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348079; x=1699952879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q790Yzm/LOg58iq7Db8FbD2kRXLwrY5Ed6jpsrOc3Vs=;
        b=FET8fC0gvojSXEnqbtCsH0uOPrL9C6vUQssMnS/4bsFb4U4xBERYnno4Ml2ZuNMMQH
         ffxSheCWySBRxRD40r88sFRfnk2DF2jI3knTMdm2Hpbp9qQrIn+dmg1AN4IWBhucProF
         ggV8xne0feHMglxqVLggWCXlCgXsDh6kELw8ksJE+GwtwXV1Fp/27crRjdNM2beOXhn4
         Ze4Cmnc8n+vX8q8c1fDeaFoNv4IB1Aw2E50eJUXUc1p+/eA0oNLKsUbe22QTX7lCymxY
         TeE1O2I+jTqMpMv6RwqhQb735IDXG0RwxPrJU5Rbdu66Sh7XZSTX1hTZt9Fp34k8w7tY
         9Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348079; x=1699952879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q790Yzm/LOg58iq7Db8FbD2kRXLwrY5Ed6jpsrOc3Vs=;
        b=ePNNbr8kYncMnSwccE40UlgeypoWL3poL5r1/4eQyn9ANFsNk9IPc+q+uei7JB6wwU
         gZMgQAQ5vLDZQSje0yap3/3QLFwhUdSjnR26+3vkmtpy63efhY6hjEbNt8NyvhstUH2M
         R/4L/imO0CwqPni8rqX4vK4xIq1/rY+oWBF7/4WPbImGkMFSbsLlaWu247Yh8Kz2IPRW
         QOu1/VbCn80p34f3ZDo4eVE7cPa5wpUpkkmcow297MT73kvXameje+PIdj0u6VKE9Mw0
         FPM2pOYVXZ/95AJQvkLXyO+Rtj8Tv6YlprIU/lFQHt60rgx9KllB3i+TfFA5F8LGycEb
         Ra1Q==
X-Gm-Message-State: AOJu0YxSwBmtpRiJcjBoOpmiMuwGtuIHPP8zuKhKoUdnl4k66MyJLKB/
        el+6qXIjCIrjT0jR8TOJ6FVEhdqfw3/8IoM=
X-Google-Smtp-Source: AGHT+IGz0mDj6T1euvZTWiXeAoqw05hiXvl8br7LMII0HAUGwC7OmXVCv6BqCbTYEijhSUeSSq2m08bV5R3WG+4=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:e082:0:b0:d9a:ec95:9687 with SMTP id
 x124-20020a25e082000000b00d9aec959687mr608285ybg.11.1699348078929; Tue, 07
 Nov 2023 01:07:58 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:07:56 +0000
In-Reply-To: <20231102185934.773885-3-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-3-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090756.256039-1-aliceryhl@google.com>
Subject: Re: [PATCH 02/21] binder: fix use-after-free in shinker's callback
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "Liam R . Howlett" <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Martijn Coenen <maco@android.com>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:
> The mmap read lock is used during the shrinker's callback, which means
> that using alloc->vma pointer isn't safe as it can race with munmap().
> As of commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in
> munmap") the mmap lock is downgraded after the vma has been isolated.
> 
> I was able to reproduce this issue by manually adding some delays and
> triggering page reclaiming through the shrinker's debug sysfs. The
> following KASAN report confirms the UAF:
> 
>   [...snip...]
> 
> Fix this issue by performing instead a vma_lookup() which will fail to
> find the vma that was isolated before the mmap lock downgrade. Note that
> this option has better performance than upgrading to a mmap write lock
> which would increase contention. Plus, mmap_write_trylock() has been
> recently removed anyway.
> 
> Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
> Cc: stable@vger.kernel.org
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

This change makes sense to me, and I agree that the code still needs to
run when the vma is null.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

