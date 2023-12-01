Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210F8800149
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376547AbjLABzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjLABzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:55:03 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB8612A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:55:09 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cbe0378d0eso2158422b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395709; x=1702000509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7iAppoCIGt7sEqxpQhMef/LhAid+9ah/Ift0A0NOXg=;
        b=o1lnoNZ3sSVYOnyXW7F4b6fXUKQAgHDcYo1Ukq1zIIN6AO7T9+iirDjPyxiHO54BLr
         H77nORb/laJ8NJ3PdDZ7CkRxMI/tMgyjo42eqc/891x1zxb3J7bauDHLop/QpJRvcMLN
         hH7Y8cxTeSM6AiIeebGxADeRD0yYClEa3p1x7fX60FGGG9RMdtfdYHZGC/MoYTMuI+DM
         unhbNrqPC6TVRXMq9lf1lel7btY01mY9N1B5V5VhWtkiVARvoxPgMhYxgyTsEKOPBXRt
         c3Od2oWlOc1a3r2AQ2fPvE7k83KY2DGQuIj4HoHMOH+bydfpd/KC+pRwrYQIagS6Ks/m
         NRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395709; x=1702000509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7iAppoCIGt7sEqxpQhMef/LhAid+9ah/Ift0A0NOXg=;
        b=Z0wZ/E9sHVUUD8mqNArF04saagxwsYeIfz6lQWJ+dhicLp6nivzKxZbgxNwLQzcraU
         TBYV4AWDvpKaNTWC+blfTDJ5FwrAUJwpj7ElNmyB75IEQCU3SssktU5Phhib0v9kwGmk
         tL8wlBzB/0UUDffqqHBOyCHw12DlEJ+vqBF+D7m9EUarn++MLsb2ea63eaKVGXTCsq4Y
         E/0lAp9OjKcKp2t/Z4sE1hup0BNypOEOhdbn0BeFG3IvfX9pYG17hKncFt2k7zPhDhBz
         0VT6K2IAfzYozLDeTba2eMGpQFV40kGlLoe3kqdRZ4IGi/CEK3lR9TswiIZCX6M95MM/
         iakw==
X-Gm-Message-State: AOJu0YylWp5jAzK18BNyq+ROYm+8CKikhSwGrE9jrEDBFziMu9QFVooJ
        /MG3/0hAOIczwO8HetQSJnNOMblU3xU=
X-Google-Smtp-Source: AGHT+IEAAUZzAhU1ZcFzkmNbSmg/hBxjb42tO8EiKmbuAykScu2XpQrFmEp3XB/fXKQEpskqi5B2wKBq8U8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1888:b0:6cd:da30:4d75 with SMTP id
 x8-20020a056a00188800b006cdda304d75mr1200740pfh.4.1701395708904; Thu, 30 Nov
 2023 17:55:08 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:14 -0800
In-Reply-To: <20231018151906.1841689-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231018151906.1841689-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137374226.619180.12045832358402230622.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Turn off KVM_WERROR by default for all configs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
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

On Wed, 18 Oct 2023 08:19:06 -0700, Sean Christopherson wrote:
> Don't enable KVM_WERROR by default for x86-64 builds as KVM's one-off
> -Werror enabling is *mostly* superseded by the kernel-wide WERROR, and
> enabling KVM_WERROR by default can cause problems for developers working
> on other subsystems.  E.g. subsystems that have a "zero W=1 regressions"
> rule can inadvertently build KVM with -Werror and W=1, and end up with
> build failures that are completely uninteresting to the developer (W=1 is
> prone to false positives, especially on older compilers).
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Turn off KVM_WERROR by default for all configs
      https://github.com/kvm-x86/linux/commit/75bedc1ee90b

--
https://github.com/kvm-x86/linux/tree/next
