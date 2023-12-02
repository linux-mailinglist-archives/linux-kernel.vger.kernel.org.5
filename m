Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E73801EA2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjLBVWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:22:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E82FA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:22:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28659b38bc7so1787870a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552139; x=1702156939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6q9rxKV/doUXKLjycqqgPKowk2OvJvKvEALIpKz5kcY=;
        b=kHs9wlopJ9gWPHAgN+0LZcpZoEF1b2s6VHwOD8or5m8w60stKKdekaLU279U/0tvvl
         nlzDo714yQgH9eYTWO3gtSRt6/mi3Q8iEcMBOTrXt/7FuZ/ToLytKnm9IEqd7K3MppnR
         aXc30wKNGyUaygFgAbyeUi0IiN5ms8GbnaMUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552139; x=1702156939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q9rxKV/doUXKLjycqqgPKowk2OvJvKvEALIpKz5kcY=;
        b=LCjyZHhuSD/wXuKXQeH7CV4oImFJ1bxGo8cchHZzxNrXS/8BQQjwu4yQ1v5sKwCz/b
         mQd+B6lOC4q6thfzuA1G7DOV/i2N/8YLXdPkphnM3sdNkGn+aasr2KpfM+GUg8DPkXmD
         p/Ce8unu8OvblQlHZy7U8lzTt5FYVV4BLR6Q7m1oeDVxOPbSy/cyVbw3oImSWecic8k5
         VAh/UUMblSXlfiPQB1KbzCYmzIFQsIa1xF9PmAMwALIv5iibulguiESAhfN4FcKm5uxg
         m803CJjGXlWeIYVvsEgkCUs7urhWQocMa5KWKvuu1WepXFs40dvYkk7ws8X34qoZzd8Y
         QZfA==
X-Gm-Message-State: AOJu0YyogxN0ifW4oFOZcOXByX17wEgxZZkt1KT0uJf6b5Zrd9T0e2bW
        XyblPtI2Mx/d0PEFyHQ8flUSb3dNhCgd0DZ2MkA=
X-Google-Smtp-Source: AGHT+IGwdZyNrYkF0JkXUehoyBhB49FcgaPQH5ljbn8bJURYFny7K2GwkFNcA9nQkamR1wf/yUNoHQ==
X-Received: by 2002:a17:90a:4dc7:b0:286:6cc0:cae8 with SMTP id r7-20020a17090a4dc700b002866cc0cae8mr1174330pjl.95.1701552139339;
        Sat, 02 Dec 2023 13:22:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902748800b001c9d6923e7dsm1825013pll.222.2023.12.02.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        Christian Brauner <brauner@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] pstore: Initial use of cleanup.h
Date:   Sat,  2 Dec 2023 13:22:10 -0800
Message-Id: <20231202211535.work.571-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=764; i=keescook@chromium.org;
 h=from:subject:message-id; bh=OkDdOwhG1YDg/PhDeGCQ9MLDBDYk/GZl+EOkqpfwlJY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGcFq7mh0j/SHF6DRy6dTOljcIUt/3e8KiD
 O4m31aHYA6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A
 JrS0EACDNa5cDFv8v98syV/CLw45XT9+6rkHlsnLPV6CO+qqH3XWas/PukrFwEtySggzDLfJSVO
 KMG1z1EhLkxTZ0yEZSb8MPm/gPAVBgorAHz+XxvwVvnd7AK93xAywzkoJJdKlVhw9dwTwnC68wg
 ocH77HFxf0URgyLGb1o83VKRWc0C7lwcHAjYCFfdj7IhVzAyWTIAclxdIj9A6B0MkMPZH68hKcA
 HJoMt1GUIvh1/JZvMXedDEC50I/yvOxfvaQQSV1xAIJGbxIsFYCRftyx2RAEn9exGmlOAOKIKOx
 NGTJTJZokqBFTZUvnv9v3scP9NtfpC2H3xvH0cGgHtC3UszM8Z0X+HIZW2AL8AlI9uz1WcXh69w
 RjiAzLTbByaoAroGs4Al0Imk2lPjgQ8wEEzsWRpRl+Uff4hKOeEK0F5qex9i245ZUvZg/65ugNK
 X1rZArEyldUwLgtO58KLapZ9WYAMzCkxOwLq2GjMqT4wazJ1vNCvP72m5odQyMEm3UGN45Qbkot
 oooPjw0Jpctobyq9xCglh/gJEAu0AJX/artOjUYjLAgXpQ/71dj9QQfn7GD2sLMSFHyk8uy0fWJ
 ydg392bMXkgv6tAbniE6m6aMoiGi0+Y1kzj0J05WDQsZvnfYj7jJM3rbZszjLwkOJ+aKdo9sw0G
 l3EdSM5K iUdlLSA==
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

Mostly as practice for myself, I rewrote a bunch of the error handling
paths in pstore to use the new cleanup.h routines. Notably, this meant
adding a DEFINE_FREE() for struct inode. Notably, I'm enjoying this
part: "44 insertions(+), 65 deletions(-)"

It also passes basic testing. :)

-Kees

Kees Cook (5):
  pstore: inode: Convert kfree() usage to __free(kfree)
  pstore: inode: Convert mutex usage to guard(mutex)
  fs: Add DEFINE_FREE for struct inode
  pstore: inode: Use __free(iput) for inode allocations
  pstore: inode: Use cleanup.h for struct pstore_private

 fs/pstore/inode.c  | 107 ++++++++++++++++++---------------------------
 include/linux/fs.h |   2 +
 2 files changed, 44 insertions(+), 65 deletions(-)

-- 
2.34.1

