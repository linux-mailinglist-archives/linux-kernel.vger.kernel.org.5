Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E2980014B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376554AbjLABzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjLABzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:55:21 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D98E13E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:55:27 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c62c98f682so60874a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395726; x=1702000526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMhvVnG1xtueP/HsDnRWK/I1MYO4nqN51Oj+ODgatFE=;
        b=2uAaqd9yZSN2hL5czgo7m5dqLQft1E30C6ao4gy5jTa07sXGvDDQ+h/XR4PadhLClP
         sJphvnO4aE4otECQkYfVPBNZctV3nUwla6KMBKau5KZv0RVRI85Pb/jGbgTSyE8NrWnG
         FcpuTPjAbAjcu0Ub5fWEtoR3aPHUJX+8ZYmL7d0tFd8ajcO6ateI2b7XwQdPil/H3TS8
         4xo4ZQ2cGMKBayaW5mY1qpDjki3sjXS+5eEE3UJeRVBTqKOdZfLuVodwU0xqKfsNmWr0
         dU+O+/YxN4Tr7ooP/Spmpf9S9tWe3rVc7pHopPnm6sRpV5SQNrlI70I/AafHKnGBFVNp
         0LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395726; x=1702000526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMhvVnG1xtueP/HsDnRWK/I1MYO4nqN51Oj+ODgatFE=;
        b=cocNNJeqhsnO9ayZW8iNl3wOXUBYb6A9v2x32vfL2UkHOkPMl9odczyeSj0KJ30bgI
         YTUeqtxKZ7yG9856JiGQGVFtLEdanQrTAHAKzJw36kZQ6Khyu5ozmehHygVbIh4SnC1N
         54nX5KyANdSObei+nz5wA+QAwb6gvQkcB2Ssgvdmj9pEpx9lrRjtKfyU5Z4KKmuQYD44
         YxEPEHu1QavCyJEortCH94FkupFe/Cn6T/d21lNnF9O/iyzfEQHw/7Wiz1VQB4WevckN
         oBNa7H+nGQSK8ANxBXxqBD5eEp67+QiAGxsmYvzA76BIlSDQUXqfhYjGFEkFxq4/6jrT
         EQbA==
X-Gm-Message-State: AOJu0YyEr/tVUYW3SOw7UBLpsmyzcwbw3FTcvpJqDyw4DqoLejx5e1wG
        DEBymM+M6YEH3/vicgBvwmQ7ulJsIw8=
X-Google-Smtp-Source: AGHT+IFZDuq2QNjNPRnHN4aVQNGYUElwPt9YjKngMF6v5aNOkCANgF0oTZK/lZARZLlAwxkfL96Likvx8ys=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:1143:0:b0:5be:3925:b5b7 with SMTP id
 3-20020a631143000000b005be3925b5b7mr3791544pgr.5.1701395726312; Thu, 30 Nov
 2023 17:55:26 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:16 -0800
In-Reply-To: <20231031075312.47525-1-ubizjak@gmail.com>
Mime-Version: 1.0
References: <20231031075312.47525-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137839626.665770.1806442754055441040.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM,VMX: Use %rip-relative addressing to access kvm_rebooting
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 08:52:40 +0100, Uros Bizjak wrote:
> Instruction with %rip-relative address operand is one byte shorter than
> its absolute address counterpart and is also compatible with position
> independent executable (-fpie) build.
> 
> No functional changes intended.
> 
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: SVM,VMX: Use %rip-relative addressing to access kvm_rebooting
      https://github.com/kvm-x86/linux/commit/15223c4f973a

--
https://github.com/kvm-x86/linux/tree/next
