Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E20770C1C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjHDWrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDWrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:47:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8DC11F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:47:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586aca4586aso8934447b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691189266; x=1691794066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tuWqEnyJSC5e6pWov8J90I61X00yfI6yYMjidRy0tQ=;
        b=g7Yvrn8iSMnCj4SuV2yrtZRX2OpYiJGTlIhSEmmtv8ehUJHaNA9hhBocjtXpUpgbxN
         vhFfvXm6x3FsM6AlfhY2Kwyj2q/MN9VrNdTpIKw7tIANs0Zg/j/0D1qc4t5QR8Q81FK4
         9/54nfjgATi5+rPXrlNFoaJxIjFDn2iNNZQ4qdKPShZdW7QS67Gsor8MpFhCLAm1hYAY
         acdCN9Oo9Z7LMVFmGDIkNHaZRpGT3SR370RM4nYUWvyO3cGGQcD+VmseCdnCRbNUwgNR
         n22aG/2qshigvW9vFtHcBSrIWq48Yw7Hgpkx+lbFJnrOXFpot8IRhMWuprCSU4u4wUGN
         lFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691189266; x=1691794066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tuWqEnyJSC5e6pWov8J90I61X00yfI6yYMjidRy0tQ=;
        b=hp3oH/ipAuMEZ6LPfLdawfBTO3sLwxd3+DrhojycMe+QRIX9KR1ajijAjjzlCXR/gs
         6KGM5YTotWEWytr8b+7EtiGS6TURO3ht3FwLskKC21Bdde2fQq1It1QKhdFidOVTjQHG
         QfDcb8EtsYytDmE1kg2zTkLI4JA5OBQYKob6TYKxi4Tkxi+c3Ph7x/QpSca/1kfIsH8X
         tStpFfIBjmy76/ovpsuBfHWWLycFqMx7rJOybk3JUt6vweoKagLv0yRQUcwtOyrQs7c2
         Xggm70g3+6lYgZZrnkrCB/jkUO9WhcuGviQnXG81k4K1X1OdYNqMCIYvujb6sjauIc8n
         XM4A==
X-Gm-Message-State: AOJu0YzdXou55KqVspRdfh3JXQYrilY/dWLuij+MJ1X2Nx7iTwrEBzLO
        4dnJs36iVllQQfFT+LzGJII8IfU4DzA=
X-Google-Smtp-Source: AGHT+IEBfvSRHnqgnE9fKrdfP2e064b06EXPO0wfS8+MrpP9vX1HNlA898i1TT0tgMr1PpybIT4/siTf2gk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ca0c:0:b0:56c:e0c5:de88 with SMTP id
 p12-20020a81ca0c000000b0056ce0c5de88mr21466ywi.1.1691189265819; Fri, 04 Aug
 2023 15:47:45 -0700 (PDT)
Date:   Fri, 4 Aug 2023 15:47:43 -0700
In-Reply-To: <20230704075054.3344915-1-stevensd@google.com>
Mime-Version: 1.0
References: <20230704075054.3344915-1-stevensd@google.com>
Message-ID: <ZM2AD26Mp31tHuH9@google.com>
Subject: Re: [PATCH v7 0/8] KVM: allow mapping non-refcounted pages
From:   Sean Christopherson <seanjc@google.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> This patch series adds support for mapping VM_IO and VM_PFNMAP memory
> that is backed by struct pages that aren't currently being refcounted
> (e.g. tail pages of non-compound higher order allocations) into the
> guest.

Aplogies for the slow review, I'm done with feedback for this version.

FWIW, it's probably too bit late to catch 6.6, especially since we need acks from
ARM and PPC, but 6.7 should be very doable unless someone outright objects.

Thanks for being persistent!
