Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD57D43E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjJXAZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjJXAZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:25:25 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C7C10D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:25:22 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-27d0a173c7bso3048145a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698107122; x=1698711922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWHz1xqzDxYD9+2i5v6SK4a1uaV9iTpi5M+TWlqOotc=;
        b=MFmCHNsmdyIBqdk+4C2iw+qYybxCOhwo9VKfTMR2x/E21VATr79UCdlwGOta1vjVb4
         tu5AClHeCz8Logj3Gi9zCjtqJSYQoEKJQtwpbFNRCyRr8i4+4xLtqJrYXr2cY2sKZagO
         cXGjTSJgxhI+1qxkxiQpRL6JSXfxYUn1Tn9rZG2CuHf+cqjgP8sI7VNc7tdrLx6QoNrF
         /9T6ykc7MApXoEgL910EfNxywas3kmGLr9lx+P9jLD2CTticMh36wkqgZFToCJIL7M88
         lILIkQBcqRzCOlbDDdq+xqwA9Bn9rxuxXWWefRmnyMiE0xKgj1YzMuOwWVSkEY4KcwxY
         WGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698107122; x=1698711922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWHz1xqzDxYD9+2i5v6SK4a1uaV9iTpi5M+TWlqOotc=;
        b=nC2Z5Z9KoTaLs2XTupVmDCXQ0e76adOxACepIpREkusb9yE8dalStIbg2ZHptgijYo
         2BDBNz/RsMKqPVsyibFBZgp2c4kZDs3HXKWbig0n0hIuXq+/iL6iK39PfOa07XgBhb2c
         ACiYcN0wqrVaXrpJeYWrd08CTbA5xBUVC2XuPPmfP/MEZzUcLu7gHTSUN4op15ix9Sk8
         FKeYP/0DjUDaMI9v1xXWET7RQ6WfE1pO1WJ0TzASIadDjIHW1uSBWoHMs9PFjSccjANg
         TnzlHB0qhzX/vgvyvmytWuBqUParZV9qwa2Gpf/tG/L8pPSgrfq28XdlZTR4Ht/48mMi
         copw==
X-Gm-Message-State: AOJu0YxIp73Lq9V6thSAEgio1kuSWXCKec9nIIx1VR+9QqKelBkCo0Fx
        XFNVqFL6XFm/Fb59Z30/DvbQllCR8M0=
X-Google-Smtp-Source: AGHT+IERVP40ibj2QvNPZHlcK/iNwPR3JZUcKqn6YP/CcGabDhaZPbxLiowmyl60pgUPchkHXu4EtKRjlxY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6548:b0:1c9:c95e:6b2d with SMTP id
 d8-20020a170902654800b001c9c95e6b2dmr192625pln.4.1698107122205; Mon, 23 Oct
 2023 17:25:22 -0700 (PDT)
Date:   Mon, 23 Oct 2023 17:25:20 -0700
In-Reply-To: <20231024001636.890236-2-jmattson@google.com>
Mime-Version: 1.0
References: <20231024001636.890236-1-jmattson@google.com> <20231024001636.890236-2-jmattson@google.com>
Message-ID: <ZTcO8M3T9DGYrN2M@google.com>
Subject: Re: [PATCH 2/2] KVM: x86: Use a switch statement in __feature_translate()
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "'Paolo Bonzini '" <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023, Jim Mattson wrote:
> The compiler will probably do better than linear search.

It shouldn't matter, KVM relies on the compiler to resolve the translation at
compile time, e.g. the result is fed into reverse_cpuid_check().

I.e. we should pick whatever is least ugly.
