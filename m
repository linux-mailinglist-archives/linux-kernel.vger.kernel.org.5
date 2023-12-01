Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8468E800153
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjLAB4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjLAB4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:56:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343BC131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:26 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3f951af5aso5538287b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395785; x=1702000585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=31js9qP/L46pgHFjemKc+qNJa9+LzUjP7nJw2eJvfNA=;
        b=VhnFzZC1vuQA9w+/ZoBMDiavFXdToIxJ+aHqESCMzVGuGrngV0aX0gu+yn2Gjldwj+
         sErCpZsJtRcmR3yw7J0QMgqTzuniNZXiNjpBSRMr1yvJGnYF5Qs7W9/ZrhXXWlVQtbFU
         +Odgfidd6kShpWW2SND1pbka7K+vyRKxcwy/EsZGqqR2fZhmEfky0JLS2JbviopR0g0u
         d8Cx2tKljaDLBiqDoCpvGrPT1PEM8Ag/WnRB9JCYLne+yTJfokub3uAkLWLLw09x9Dlo
         VJuLyxtPXWQ6CSsVf4uB69enNph++TO70IEJBneRNr9zd0TDNwTj4aSqk0axyC7qdo5A
         pYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395785; x=1702000585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31js9qP/L46pgHFjemKc+qNJa9+LzUjP7nJw2eJvfNA=;
        b=mLH8TGEOzl0BToZs8KoVCXCHBwKs2Ex3vhyITsYfxBf86NZAYyKjSSUs0ebScglXYS
         RK4ZLmHmow54j3ZEx7Sr6tqQAPBMFOk/9KXMcy7y8asf18z5C1wgPwTrCieorQ650IRE
         gsMWPZa3LYO9VKHrJlr6MBidNN97BQXLbP+FCNIACwsbZcolgoAjj1hwF+0dbwtwh8ql
         FycwoW0xPL2yZSPsRnGc6cM6DsW+Hn6YWDDUvsts15/q1LXvgPRUA0Ox5IE+mHlqwv8f
         Wkg+5djWqT8hSFUyVpAOSOBvqPw/11rYzSFzRudd3LyHYRrbXdAngaKKCYJ8MVk11xmX
         lDKA==
X-Gm-Message-State: AOJu0Yw+LnL7MAr+gfBhcxVfkSm0m9zBicRIBnGMBA4zC0H0Z7dHrfrM
        gg/k1sqfDoQqgD/AJWd3Crp+HAnO/zs=
X-Google-Smtp-Source: AGHT+IEpsxjrpo5dTWYsiMfs2Wswpo7gotPD8xGYw/M6BtLdhSTmn9pvuQrwa7V44iHovIX+bRzNfIdxd54=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2fc1:b0:5d3:43cf:1727 with SMTP id
 ex1-20020a05690c2fc100b005d343cf1727mr130450ywb.5.1701395785385; Thu, 30 Nov
 2023 17:56:25 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:26 -0800
In-Reply-To: <20231018194104.1896415-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231018194104.1896415-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137744449.663393.12077331618615208281.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: TLB_CONTROL / FLUSHBYASID "fixes"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Sterz <s.sterz@proxmox.com>
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

On Wed, 18 Oct 2023 12:41:02 -0700, Sean Christopherson wrote:
> Two "fixes" to play nice with running VMware Workstation on top of KVM,
> in quotes because patch 2 isn't really a fix.
> 
> Sean Christopherson (2):
>   Revert "nSVM: Check for reserved encodings of TLB_CONTROL in nested
>     VMCB"
>   KVM: nSVM: Advertise support for flush-by-ASID
> 
> [...]

Applied to kvm-x86 svm, with a comment as suggested by Maxim.

[1/2] Revert "nSVM: Check for reserved encodings of TLB_CONTROL in nested VMCB"
      https://github.com/kvm-x86/linux/commit/a484755ab252
[2/2] KVM: nSVM: Advertise support for flush-by-ASID
      https://github.com/kvm-x86/linux/commit/176bfc5b17fe

--
https://github.com/kvm-x86/linux/tree/next
