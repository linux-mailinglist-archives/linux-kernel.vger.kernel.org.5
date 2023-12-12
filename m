Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8780F8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377569AbjLLVRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377485AbjLLVRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:17:39 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06DCE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:17:44 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d67870032so38897045ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702415864; x=1703020664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Zc6KTpAZSdY8QpoD6ndRxHT3SVEvXG+4LeuNbqJOvg=;
        b=L4UAFUOZAH3mEUJ0dYkraext6N+7dmrPBKQ07Zrkvg0EipGpro+00z8Kf/u6eTav0e
         ce0D3+DrURn7ueMVVDjugihrDkYrnlD+QKI9UKTbV2XHjM6LOsa7wtRs4TNUKXRf/Ei+
         Ofe/ZfWwt4z57P1hMbbpm/rviheqp6NahsHM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702415864; x=1703020664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Zc6KTpAZSdY8QpoD6ndRxHT3SVEvXG+4LeuNbqJOvg=;
        b=KRnVo3a+WfimTTsrBQYvFaCwCcAVFBVMWUYvvibJ6jGnmnczQnyESKoSrH5jZqQ3EY
         sFCVxTQf+NKcggGMt7x7PvyBqF0f2+4NXU7tAo0pnueCst4+3t/1SvGHRBkbpS5rZT3F
         hPhVFB9ZoYAP+NvfiDq2QLsDexcktzvFn4/RegHCuorEypOpw3OYO1TanBQk1CIhpybk
         tG0Nl+QR/nnTudxOXgiyC4Y9wimdIr5/I/PuSaVfcUBbEMv6wcz4vlthX9XBHcXTrVRZ
         Pnq4LU7hwwqqIKUdfnO+n3d4fVkojqNShvog6ERSnZ9oQS/FA5r7hNTKL3+nWzsGFKxo
         BzXg==
X-Gm-Message-State: AOJu0Yx4NJp2SFth1LVT1HMoudqbXPGFnQ2Msb+BelEz0B5FI0+vDOBQ
        3WThdp0or3RwnYFYHr5+bej4/Q==
X-Google-Smtp-Source: AGHT+IEvDlyQAlbj5kZpcUy0l69R3KnPJJrpfmKzdIY3kCQw6u1d63ztJ2FRYEW2wthGdpMi+t5zWQ==
X-Received: by 2002:a05:6e02:1526:b0:35d:59a2:2bb with SMTP id i6-20020a056e02152600b0035d59a202bbmr10427390ilu.91.1702415863911;
        Tue, 12 Dec 2023 13:17:43 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm8681954pgg.50.2023.12.12.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:17:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/3] kernfs: Convert from strlcpy() to strscpy()
Date:   Tue, 12 Dec 2023 13:17:37 -0800
Message-Id: <20231212211606.make.155-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=keescook@chromium.org;
 h=from:subject:message-id; bh=25MytgNAUZhUM008DbLRMGuucWR15FZ+JfVwwxo9GpI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBleM3zNEJ6ozMonZeoBQXI8on6XfsVYmsQsgluk
 o1wQ+Ga48OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXjN8wAKCRCJcvTf3G3A
 JsNPEACp/RHtIqnnV4mPRZIPFgXSZFVF1HvucA+ryrSi+/fpmEwvxufPyzuDwgNvNgXbvTi2AHk
 SyV/uJMDv/6gbhfFVhyvE60Wb0MqH5vRCJJkLHJjqd5QmFaLOZwMgbdsX0BkMhwE3sgnXH0+x/0
 rBmVvY+oMp2+nxQqmUeUCHg9v7ohxjEDc7cJUXQw1ohErQHEFgL/I3+etO2/t/XqLDC4b7/iZAW
 uCV5mIOpBOml+3+QYCaRLL5sIvpTOB8uzkgoELY+dOPfkH9qz0qTf6rW3lq/Hl8O756SsZdAf9s
 piPFzMgt6R6FoK+gsbWiO9pnRYVYVhXp6ZWdpx3zI4ftuMvbuqrfrrqRhAwt5igfahudw4qarQg
 npD/uktNC5EBbJc1DBbpHxukXKawE2ANI7oarahhLNx5r5hhSeW24mhApPa/Y4wz/Oo4to/4SqR
 C9JNMxmVvt3cIVjg1bq+4Z+qCQVzVEa5pJsYt1OvmtJXUonqsX8/8D2GSOFwReXk64SVsPoLIEl
 8V5SbrwZWj9Yswt1XA+josJR+CoAiZYQPNx2CbO5yc3xQNJNkg1bnVzy81o0+xQVtI/ZFtTit3n
 Ra2HxpF7JkjcUUDSwLJMq72OZMpGQ/NaMYcgjfrL+eD8X/C2kAShjRuuqk+UCSbcgiIA/+7ZknX
 KxURH9O 1QW+s3Sw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of the last users of strlcpy() is kernfs, which has some complex
calling hierarchies that needed to be carefully examined. This series
refactors the strlcpy() calls into strscpy() calls, and bubbles up all
changes in return value checking for callers. Future work in kernfs and
sysfs will see the replacement of open-coded string handling with the
seq_buf API, but we need to do one thing at a time.

Thanks!

-kees

v3: don't need to account for scnprintf() returning negative (christophe.jaillet)
v2: https://lore.kernel.org/all/20231130200937.it.424-kees@kernel.org/
v1: https://lore.kernel.org/linux-hardening/20231116191718.work.246-kees@kernel.org/

Kees Cook (3):
  kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
  kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
  kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to
    strscpy()

 fs/kernfs/dir.c           | 50 +++++++++++++++++++--------------------
 kernel/cgroup/cgroup-v1.c |  2 +-
 kernel/cgroup/cgroup.c    |  4 ++--
 kernel/cgroup/cpuset.c    |  2 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.34.1

