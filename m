Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49582792EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbjIETa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbjIETaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:30:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9820F1AE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:30:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52c74a2e8edso4236679a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693942232; x=1694547032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DbvE2l6qu6o8lwEp1aweLnrA/XOcH4sUpdaaPXX6k2k=;
        b=iNxLwB3U/BgY76UslSj9MNwvwppW4+BgACHff0Y6VR1Q92f/dazv5equ/1WckTi7s9
         6FhXm3VTYKzUus7s619+2o/X4Kea/y6R4tJORQsB8v/uE9LQaeNpKtdmtgu/dRiiqELY
         ykqnRRNftH6rdy2+FAX5sODHNY8uOUJVI+qUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693942232; x=1694547032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbvE2l6qu6o8lwEp1aweLnrA/XOcH4sUpdaaPXX6k2k=;
        b=AfC1GsAbxjIQQfn4eni1Q5eXQSoNOqIbNv6qsQhO9QV/w40qQWAq+WMR9AXrF9gVLW
         4bB8pTkkcFmQlDW1VS2xqV22UVqN5/CNBt3gYj3CLjmDnBjQoPvZW3XRPhnY6ONy1YNS
         jxNsDlYUDYTQsQgaygSBD5nuMp98oCpZbJo+vRCAed3eyWW8O4zBUxc+vGqWdtkrpXnl
         vgCt6hcwkjO2qIVNQIWHb5vqrIPDtIlmTGES6CuUECsclPek7UDTPcFborcByZ413skL
         DuTcnN6efx/CSYGJwz1Ai+H0Ah2flSmZxsSv99rp1NYEBp1Lc7W4V5Sc6RYLGijhP9KK
         wDIw==
X-Gm-Message-State: AOJu0YzD6s79tyluJPSJpaHCLBZagT2NMPHjf1S50oXb3HvPawKNX9+U
        ukP8j8qasIds+xiTtWPqO+8vI6VlLrTAsdpzkQ2MsJM2
X-Google-Smtp-Source: AGHT+IHzsHik+eBd3lHZAQSpsy8SfGFqZ/e598paM0uLT0hRAd5oVc3C6SD+QpPgd8PL9WoHAQnofw==
X-Received: by 2002:aa7:cd09:0:b0:528:88f5:eafc with SMTP id b9-20020aa7cd09000000b0052888f5eafcmr690570edw.23.1693942232627;
        Tue, 05 Sep 2023 12:30:32 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id n18-20020a056402515200b0052a3aa50d72sm7512905edd.40.2023.09.05.12.30.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 12:30:30 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so4255823a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:30:30 -0700 (PDT)
X-Received: by 2002:aa7:d316:0:b0:52e:33ad:4031 with SMTP id
 p22-20020aa7d316000000b0052e33ad4031mr515378edq.40.1693942230448; Tue, 05 Sep
 2023 12:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230808085056.14644-1-yan.y.zhao@intel.com> <ZN0S28lkbo6+D7aF@google.com>
 <ZN1jBFBH4C2bFjzZ@yzhao56-desk.sh.intel.com> <ZN5elYQ5szQndN8n@google.com>
 <ZN9FQf343+kt1YsX@yzhao56-desk.sh.intel.com> <ZPWBM5DDC6MKINUe@yzhao56-desk.sh.intel.com>
 <ZPd6Y9KJ0FfbCa0Q@google.com>
In-Reply-To: <ZPd6Y9KJ0FfbCa0Q@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Sep 2023 12:30:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFUBOOhOpvwkuH_hs=pTPLEf4YvOj1z2vudB3XFHpXJA@mail.gmail.com>
Message-ID: <CAHk-=wgFUBOOhOpvwkuH_hs=pTPLEf4YvOj1z2vudB3XFHpXJA@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: .change_pte() optimization in TDP MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 11:59, Sean Christopherson <seanjc@google.com> wrote:
>
> IMO, rather than copying from the original memory, swiotlb_tbl_map_single() should
> simply zero the original page(s) when establishing the mapping.  That would harden
> all usage of swiotlb and avoid the read-before-write behavior that is problematic
> for KVM.

I don't disagree, but the argument at the time (I think from
Christoph, but I might be barking entirely up the wrong tree) was that
the swiotlb behavior should match hardware DMA, and we had known cases
where the hardware only did partial IO.

Honestly, even pre-zeroing sounds silly (and *much* too expensive,
even if less so than copying), and we'd be better off if we only zero
the rest once we have seen a partial DMA result, but I don't actually
know if we have that partial size knowledge.

            Linus
