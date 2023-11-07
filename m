Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61D7E373E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjKGJJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjKGJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:09:06 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E719B7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:42 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c5194d4e98so58917341fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348120; x=1699952920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGeD84+hJd1e2F5c9+bd3H9nCk4ZlrwAx/OTD8OZ/cY=;
        b=iEUfASqDINCgBB/t3KyBMsou7Ni+zam+fWfwAdWmpQEro0vAibAcg+JpU4PDlFnyEc
         AwoI+MtqUoIlC7D//njpzEkyRZRH+/oANghI/L7m8DlsNCgAJlcGhBC0rXcIiiTU/2yC
         SHYsWodX+ywI7uM5JUl2nbhjv7neZeDEaqpZpf6arTPzFlUJ8LmxKc4yumGSwdQBU+Vr
         lrPEsGEFHyURm2vhc5cODfsL/7L5rW8e+1io/JeLOfxcNfPSmPAuufiWA8Ef6O1XBPAF
         guufP/CedLwSbyEWF84KvSdI+9hSwEldOInuuKcTYrsUFQZMcJjeEQQTQ31712kgKZl8
         QkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348120; x=1699952920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGeD84+hJd1e2F5c9+bd3H9nCk4ZlrwAx/OTD8OZ/cY=;
        b=mGOX3cHze2/r1DUTn1QAfD9oppasYzG9QqhgcBoB28p81hDw6HWAGmI+dyh8YZCenJ
         TlJqL/wor0hnyki4WyI0gORIS9Dsfw+c/C1OYJHPJ95g/4Ph7gARxzC9afyGtOsv7c3C
         zuxZRH8P4Mnt5Rvyk4q4jRx9j+fL8Cotmcyf1ya3KZawOpYrl2lG9T1iwaAG4LXgixX/
         /nrduc0iweblZkm9Gc6cp4IqVNips6HPDRzdp1e0Igof0hzcK1/svdwzMmOddP+B3hHE
         4dKLlwe5Xam1XprXgazohkhN9Jb+Sum7sGzVlH5bbYf7LZAK5467jRQ1LMSLIdRQPPZh
         f82A==
X-Gm-Message-State: AOJu0YyIowax0ZF9J9UhA2wsrLKPVc3Zp/n94Qwsv0KbD3jdM80iK+c9
        MluV1lh/0j2Pr/A4K469AwKhTWCAPr2q854=
X-Google-Smtp-Source: AGHT+IH1g8u+va3RNZnMNkWHKjqLI2EALqkzguZ6gsN0uNIu/Y8WPDNiencaGuhED7ccDpmQJIoVGtYbzpK0OOk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:5d6:b0:500:c703:3f4c with SMTP
 id o22-20020a05651205d600b00500c7033f4cmr305938lfo.2.1699348120636; Tue, 07
 Nov 2023 01:08:40 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:38 +0000
In-Reply-To: <20231102185934.773885-18-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-18-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090838.260730-1-aliceryhl@google.com>
Subject: Re: [PATCH 17/21] binder: malloc new_buffer outside of locks
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
> Preallocate new_buffer before acquiring the alloc->mutex and hand it
> down to binder_alloc_new_buf_locked(). The new buffer will be used in
> the vast majority of requests (measured at 98.2% in field data). The
> buffer is discarded otherwise. This change is required in preparation
> for transitioning alloc->mutex into a spinlock in subsequent commits.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

You also need to free the new buffer here:

	if (unlikely(!best_fit)) {
		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
				   "%d: binder_alloc_buf size %zd failed, no address space\n",
				   alloc->pid, size);
		debug_no_space_locked(alloc);
		return ERR_PTR(-ENOSPC);
	}

Other than the above, this looks correct to me.

Alice

