Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C837BB041
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 04:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjJFCVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 22:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjJFCVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 22:21:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC58EDE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 19:21:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8997e79faeso2452786276.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696558909; x=1697163709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6shvDX0+qx3XslC2HibD1yD0G0VEB9xcs/tREVEeh0c=;
        b=UsK9jHx9MG01pCvqnSfU8S/bGIHYP5UVE+8+tLK72+HoaF43+Zdw5bNXO6EVfOeWO3
         4OduypqjW0LPDJkSts5Mlh5oK//xnFMBtVKEYvSRWD+5uNfj4EjL3vqfRogzyveaGTpj
         MdFtQ8wjUPhPrr4PDOYmXR8Min4MK3M8/4B+hMzHJSWmkmbYbAC2SDd2aExxZlECwn8P
         T64e0g3DqeiyCp537hyPKJxkzu9iE+OvbnQalsaaAEqTk04F2mHrJu1vGVQdIKelorAZ
         shL5i2GsNEHhamwjclvVXdRxsBuRHtdxFqJMDLErm3GpTLQ14VNhh6BAv872il5Eg9uB
         pvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696558909; x=1697163709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6shvDX0+qx3XslC2HibD1yD0G0VEB9xcs/tREVEeh0c=;
        b=cuPGAWQuEjbe+NsCiCe+RaA813SpD36cjMWSdaRwm4Q+UcksKqfBxzpSlfAZPXEE3E
         ROgmT5PO9gOWQxscQLoTc/o5aW2jlsaDTQMhvDu2K3fOXBQrpSwq2HJ8OKdRolP2LmR5
         h+vXCiufJp6xnPlrrPLipP/wiLcfX2OqFysKStNDw4OYzD0CBjMsKUEeo/tZ8/ek3Iy+
         plippDXc8CvHxDKlRTmk65pbrdVNtdMzmB9YxklxlwRulvmSUCzyCBshdtLrxCVdtBED
         sxGtXFzBDp3t2NHDdymda2wYQXOBARnf2jEg5fFR3pX2MojlXCKCwcuBDrWHmdw5YeVC
         wcpw==
X-Gm-Message-State: AOJu0Yxw0L31Ayl+gN1D6lAFJO61BW7g5R2bk/qnXiKM9P0nkR9JIo69
        JBh4MebnnEPzq5v8DovxhVYq45mnH6w=
X-Google-Smtp-Source: AGHT+IHtWjaEqEjc2Bujlu2v05hlvj4CO9Qua7kCiMdHq6Gj8Qv3Qh2MeUfYMV1nZDMnq2NRALUFDxbXxQg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:abaf:0:b0:d91:1147:3379 with SMTP id
 v44-20020a25abaf000000b00d9111473379mr86463ybi.1.1696558908928; Thu, 05 Oct
 2023 19:21:48 -0700 (PDT)
Date:   Thu,  5 Oct 2023 19:20:08 -0700
In-Reply-To: <20231002133342.195882-1-michael.roth@amd.com>
Mime-Version: 1.0
References: <20231002133342.195882-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <169655697171.3533982.9527317906469089174.b4-ty@google.com>
Subject: Re: [PATCH gmem] KVM: Relax guest_memfd restrictions on hugepages
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023 08:33:42 -0500, Michael Roth wrote:
> Rather than requiring an entire memslot's gmem binding to be
> hugepage-aligned to make use of hugepages, relax the check to simply
> ensure that a large folio is completely contained by the range the
> memslot is bound to. Otherwise, userspace components like QEMU may
> inadvertantly disable the use of hugepages depending on how they handle
> splitting up regions of guest memory for legacy regions, ROMs, etc.
> 
> [...]

Applied to kvm-x86 guest_memfd, thanks!

[1/1] KVM: Relax guest_memfd restrictions on hugepages
      https://github.com/kvm-x86/linux/commit/e7af8d17224a

--
https://github.com/kvm-x86/linux/tree/next
