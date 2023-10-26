Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29627D888F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjJZSwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJZSws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:52:48 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE51A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:52:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1034332a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google; t=1698346363; x=1698951163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3el8K7l4KhSfOh7Yq5Ci32FysUQLtgWxtCBTApe7bRI=;
        b=ZYP3ZBefHBIWq0gwuH/s4GV+NIu5HbdVNedrPnEbNJrfl22tWKn7+9itIxnOykOgBI
         5lru6z5KBjG1Rv9iSeQ6/6duVdte6t5vRjaauq1/w+rk4bJFrZNeVUbJ/YekChh4FGJH
         pbPGPRvVnwEn7nRHENRt5BE7Pi7+nhP6Z2BWgqlkT7HGbpyC6b8UvMsGiO3fyLHJ9hT2
         dIY7+P9UX8wxk5KSIuVjev3MTfiBhesFkMesIlqgEkFmKV9pyJoWhApnzVhtSYhx/GG8
         3I/qOGMa6K7WodeRalJyxntmyAmGF/hLH0fJRMds0FzfUFsTgXWlIDBXjTvF5EM3k8NC
         CpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698346363; x=1698951163;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3el8K7l4KhSfOh7Yq5Ci32FysUQLtgWxtCBTApe7bRI=;
        b=Bhs7AL1EUKg6ppLNTTLhWr58lodx/9YgbE361wU6hSWEAbd2ZlmYMglA9DZ8we2mgi
         Euu1W1MjJ2J38t8Ua3KwtJSymahYGhbdpaexKIhoqLEnTDdUZTVh+Kkce6HvGXSdV5iP
         74pIi+9HfpX2+3e1J4SVmorQrXpU8i4NLteKPNgexc58GQS2oZ1KMKSd/1Uz5vKQWlwm
         9K3Rac2576X03j7W+BOBJUd/77v+xsd9rJFqeBo8zAlHpmCMZd95YKYbQrNiq7i6H8Dl
         79AbTaBPXHmlsrERY65d9Sj4fiLkhd7y3e2Q5p1wyhNDiG/U5JuBzDh2VjkECir5tiLp
         q+/Q==
X-Gm-Message-State: AOJu0YwjK1coaw0Ifr8A5j9ShFKr7JtL15LmOpMg+YS8IHc7ljpHGDNK
        u6Lm3O+1BPWb2EM5SWZ/dcWlkUfB5Jo2PbX19kI7Sw==
X-Google-Smtp-Source: AGHT+IHMyLz/O9mIstfEUzlFO6V+kzmAteEEKojn1pFAGUXXd/4x9PgPtTfqdgya/2WMjzl0tc9RqAwPf5Mdx/2wxn8=
X-Received: by 2002:a17:90a:f2d4:b0:27c:f845:3e3f with SMTP id
 gt20-20020a17090af2d400b0027cf8453e3fmr448846pjb.1.1698346363180; Thu, 26 Oct
 2023 11:52:43 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Black <daniel@mariadb.org>
Date:   Fri, 27 Oct 2023 05:52:32 +1100
Message-ID: <CABVffEPthUzEHS4xCdYWMvjSK8EjjqVzsekxEuMaB_j2or1QOw@mail.gmail.com>
Subject: Re: [PATCH] sched: psi: fix unprivileged polling against cgroups
To:     hannes@cmpxchg.org
Cc:     bluca@debian.org, cerasuolodomenico@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        stable@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you,

Reported-by: Daniel Black <daniel@mariadb.org>
