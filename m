Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934DF7802A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 02:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356697AbjHRAOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 20:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356710AbjHRANh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 20:13:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE73C20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:13:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c54f4e2a2so4338137b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 17:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692317588; x=1692922388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ianHlaeGGVo41LRlcmtAPCjIJRAwN1rKOhIOWUMMnS4=;
        b=FFtvZfjto+HUZKdrpzKVGQ4sG4/q3DvDS+tVQYO8EDGyGLDvzq0skRui7L6VFBiRVm
         6iSlz/o2C2oWk/CdPxQlEF/CGI3NJPwohaXeJNbhLhtcrzxqNKSG4yOG5SpcOd7nl7v/
         +NJ2Fz0Eap+FsZx9O2EogukQPbYttMtAOx5drc3e6lQoKW0x43btmV6SkWEFqLJOlEAo
         xgiEGQJR6GpJzqsBhPRo+tKp2hnOd1nrPz8TOcyXOXjZYzvWvLIlDgDFQ1BN+OnI1rtI
         JcqRmZQybPZgLqFOg7EDDmPoyJGXQd6GjtGpMCQtnZFaAi+Ugdw1q51NxmEcN3BAG6c+
         FUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692317588; x=1692922388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ianHlaeGGVo41LRlcmtAPCjIJRAwN1rKOhIOWUMMnS4=;
        b=F2z+mqy32gA8kcF1ZWeTWsIBawrBhVdgDaB5IQkwrZfDtFTjADFXVtrFQKxygMePqt
         5bGxgnQ5w9LZZ7ALjIPu0A72Nl4HlMEeJXyVVehUXmAlj6uXD2KLj6wQ7XQeKjjbXDRH
         hx9dP2hqzvIVCFz+f4RsgwuhjvHD0eIedSDPRQqAgPFHh4dJrJeNvRVGhTNnrBum8Nsg
         7pE5pL6+jz6xQSoEBa7ycPNvHq3x5QV8XzhJGc+ljXvaS3Vheu7pqEOZkURn1trQ+t5L
         46W0h7K59qsgiVmCexCijdrQ2AMPNhFpYZroBzjmH86iy5If5d2vJ22nyFga63De9yuj
         GwxA==
X-Gm-Message-State: AOJu0Yzq/Z1KHRViugR48k51aIkxg7lrt5IF+2g73O8wrZ+tIRWrODHn
        70jrVahq97zHeteSb0/sRyvx2cFBxs4=
X-Google-Smtp-Source: AGHT+IHd2DZM7r8IazPazNxp74KJytDoWq+Lb7iTKSCWmTB1nToqcZFRT42anxwhw/TzArfWQfcKXpJpNEo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:5096:0:b0:d3d:74b6:e082 with SMTP id
 e144-20020a255096000000b00d3d74b6e082mr12982ybb.9.1692317588472; Thu, 17 Aug
 2023 17:13:08 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:12:45 -0700
In-Reply-To: <20230808233132.2499764-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230808233132.2499764-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <169229717704.1238257.9648036828002106857.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: SVM: Set pCPU during IRTE update if vCPU is running
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "dengqiao . joey" <dengqiao.joey@bytedance.com>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 16:31:30 -0700, Sean Christopherson wrote:
> Fix a bug where KVM doesn't set the pCPU affinity for running vCPUs when
> updating IRTE routing.  Not setting the pCPU means the IOMMU will signal
> the wrong pCPU's doorbell until the vCPU goes through a put+load cycle.
> 
> I waffled for far too long between making this one patch or two.  Moving
> the lock doesn't make all that much sense as a standalone patch, but in the
> end, I decided that isolating the locking change would be useful in the
> unlikely event that it breaks something.  If anyone feels strongly about
> making this a single patch, I have no objection to squashing these together.
> 
> [...]

Applied to kvm-x86 svm, with a massaged changelog in patch 2 to state that the
bug "only" delays IRQs.

[1/2] KVM: SVM: Take and hold ir_list_lock when updating vCPU's Physical ID entry
      https://github.com/kvm-x86/linux/commit/4c08e737f056
[2/2] KVM: SVM: Set target pCPU during IRTE update if target vCPU is running
      https://github.com/kvm-x86/linux/commit/f3cebc75e742

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
