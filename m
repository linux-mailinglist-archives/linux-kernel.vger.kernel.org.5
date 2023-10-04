Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AC97B86A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbjJDRea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243696AbjJDRe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:34:28 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFA6B8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:34:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a234ffeb90so213437b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696440863; x=1697045663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVYE1f5AKKSdXEUAuRkbKCyNykYeN1CpN0+yLpATvIs=;
        b=xjeNhHOSXvemlkdQmRAltZ5THz2AxH/HM0mXY5BXuKnwP79vkCMqCjymAsTw6CdtEW
         teZwbD2wceUvDysE1Q9LBiFXxl8u5xr6iVMtJjWjSMtnFUBiqiTpP3OyKZCB92AroHQy
         MFuDuzYzaBIkT8RzKWZP9/Cjybbkhv5DvWAMEshSVVp8zrhIvY6M1KUhwl8LcNMAoj0Y
         0H3vXSHlEx8ogVmPw8QPE9D1BH5NnJcZ21+nkTSWwdxq69lZ5n1gyadNmCCAyhozA0kP
         UY7fvQtKAM69VtcrgMv/Crt0RBWSUtbs83BbqupVV25eXgyGny7YKWjDDGEjKdPPW4UO
         7Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696440863; x=1697045663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVYE1f5AKKSdXEUAuRkbKCyNykYeN1CpN0+yLpATvIs=;
        b=smXFmdETF7S32WXjdG3R0BljJDUapcSLulc4nuaJyNnISyB+iAvBhjC4N29frcT8g/
         Z6zynu+d5668cwQlX0wtEmlQxexNr1fEaiDYPSXaBIPWUkclxf0MjF4v0M1bvdSWiugF
         dinH8fjIh/5Rmjn4iM3J4mwmsQIaJl73co/ej51o5MonY1I3K/mlpoCfG83+mD6deczh
         Xg0Sl9CNkWuJoIQd8z8bEBTw+Tfx5B4HQoFSh1Z50hzPI6yS+AGa8CMFO9Gzs41+Ca4V
         kA7rNA8k9uKyuhNBcrrXeD3Sd3m1hZpBmYXaJlog/rJtNTj9INdEUzNbpBtWfd1do9rc
         qp3w==
X-Gm-Message-State: AOJu0YyIrh4JNpHsPIFAJXPfMhhlv5+t6WYrmXkZxO4tRrIAjsG+0OJv
        rufRZtUwfGSvsxqbka5IS/2sW4jO+WA=
X-Google-Smtp-Source: AGHT+IHeVIrOY+AVAtMfBE9HZToW2CdMvxYltSIAO3hwng2/XfKB6+JUeZfCkr5f1cH1ai9srVu5OR/Fl8s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:bd08:0:b0:59b:c811:a702 with SMTP id
 b8-20020a81bd08000000b0059bc811a702mr54351ywi.6.1696440863056; Wed, 04 Oct
 2023 10:34:23 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:34:21 -0700
In-Reply-To: <f5e08c03f6815945588f3eaf47dcee9ff166800e.camel@infradead.org>
Mime-Version: 1.0
References: <20231004171102.2073141-1-paul@xen.org> <f5e08c03f6815945588f3eaf47dcee9ff166800e.camel@infradead.org>
Message-ID: <ZR2iHd18_FsyeWxP@google.com>
Subject: Re: [PATCH] KVM: xen: ignore the VCPU_SSHOTTMR_future flag
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paul Durrant <paul@xen.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Durrant <pdurrant@amazon.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023, David Woodhouse wrote:
> On Wed, 2023-10-04 at 17:11 +0000, Paul Durrant wrote:
> nit: I think the commit title should probably be 'KVM: x86:' and then
> mention Xen somewhere in the rest of the line?

I would also be ok if we start doing "KVM: x86/xen:", because it seems like y'all
are sending enough Xen specific changes that differentiating would be useful.
