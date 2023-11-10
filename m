Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2857C7E80DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbjKJSSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346058AbjKJSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F343A205
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:56:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0c7d27fb0so2527803276.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699628219; x=1700233019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1V/300+xWnAnwKdMsbjGUliUN30rs1/xBn5NBDIxfI=;
        b=dOSmT82877Rp1xmkoDaltiaoVgfV1JBFKfR3Eazpe3jGvGKNM96J+PViP74iIk62bU
         3HxZIHHcwnhsfVyY9yUrYz65+uLzSBblO6zNFrMt1Rh58haC6Oqs/tlMBh3oqFF7gahk
         HwUBdVbwzP33OB0J78BkAqL2wSs7dYFR79caMaxLYmXvH7xv2t3gloSY+QuV/Vb6cKxx
         kY0Boc74vaAR1N74n2QWblXDkY0jMHdrRWmwKM9b27kY49Cl0rTmEYcKwwdzRC1e/76W
         NZ4PnOSr77vF1sCG/x3vTozhizfKXPz/OjcSrj5lr2JEMcjvB6poqYWHFDC6oupm2+O2
         AIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699628219; x=1700233019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1V/300+xWnAnwKdMsbjGUliUN30rs1/xBn5NBDIxfI=;
        b=PY4ckmR1zClVVBUAJhUi43ONeGz0nItiCGpf46egSVeq12Zn++109Bn+Dw5Fl1oXQ8
         tD3Vb7tlijYwz0tFM81jf1teb68XA0WxPomymyTnnNA6z9WSHaPS7TJUEUE6w0/Rb9Bm
         z+r/zQAC5csV5/rrzKrWUzz7vOITuFz5dX1EtAoeQecq7lqLTOTO9u4QE9dJU40jsq79
         5arDCspuzxMb7DJfNr46LGLHVT5j0uKuARtcmzF8u1N9J2PQjcplM/yGbxpap5Ly+deh
         26FeKvbOcyokTRihxscWo8kjghjPPi9PoJpO9U2iPLySD+x//vLO/YZfO2LzlQezE6Ep
         T+3g==
X-Gm-Message-State: AOJu0YweL5AoZ9c9l+Ld96lC5WvJsqC0OcSnWC+Lf+tDDGDNr9EHgpPl
        WbiFLoDFT1SpVKem9A1Jq2jbb5R46zk=
X-Google-Smtp-Source: AGHT+IGQQ94Jip81SrrWdG7OjYYcza9XRu3pKVZNh6sGbJ1fShKRc5nNwka3brsZBy1qO94ybUhnFiOwTFo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:24c:b0:da3:ba0f:c84f with SMTP id
 k12-20020a056902024c00b00da3ba0fc84fmr216147ybs.4.1699628218895; Fri, 10 Nov
 2023 06:56:58 -0800 (PST)
Date:   Fri, 10 Nov 2023 06:56:57 -0800
In-Reply-To: <6e101707-f652-73f8-5052-b4c6c351e308@oracle.com>
Mime-Version: 1.0
References: <20231110022857.1273836-1-seanjc@google.com> <6e101707-f652-73f8-5052-b4c6c351e308@oracle.com>
Message-ID: <ZU5Euc29B_UjiUot@google.com>
Subject: Re: [PATCH 00/10] KVM: x86/pmu: Optimize triggering of emulated events
From:   Sean Christopherson <seanjc@google.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023, Dongli Zhang wrote:
> Hi Sean,
> 
> On 11/9/23 18:28, Sean Christopherson wrote:
> > 
> > base-commit: ef1883475d4a24d8eaebb84175ed46206a688103
> 
> May I have a silly question?
> 
> May I have the tree that the commit is the base? I do not find it in kvm-x86.
> 
> https://github.com/kvm-x86/linux/commit/ef1883475d4a24d8eaebb84175ed46206a688103

It's kvm-x86/next (which I failed to explicitly call out), plus two PMU series
as mentioned in the cover letter.

  https://lore.kernel.org/all/20231103230541.352265-1-seanjc@google.com
  https://lore.kernel.org/all/20231110021306.1269082-1-seanjc@google.com
