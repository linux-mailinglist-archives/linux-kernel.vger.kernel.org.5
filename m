Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB757DD95E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376901AbjJaXtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376891AbjJaXtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:49:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EBBE8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:49:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8486b5e780so5910870276.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698796148; x=1699400948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LNHoFTQ3VJWlwRzthV25hP0hFBYO6DrUYoMIghO42k=;
        b=WGRwVOPj0lbAoJC34Jpa4EoUm0Ogaw6HBbY9W8SOnwiTBJINN4/gSv7oDnwMlZvq+u
         PMpzEt6iW4jwZfdZqccFe87ikhnP0vFVT2F3JUKmxA+iXB7VwI9SDDVoyI27bpzCSP99
         9bp8mVUgnvYWGqRv++dM2i8OrZHf1yWjrkKa6kxkDxa62iNX0g93cI68BW9DCsothqrl
         sqp7T4ZHo9midCmH/08gCH1Upx+nO+bV/Uup2WhyjxaHraB11VksKm5V9YOiniiz7IuG
         +pzmqWoinwe2JFx6m5QvlyxZseALxcOs9ShFWRLOy0qA/KSytF0PlQ1ZoU11EzVybkv9
         z0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698796148; x=1699400948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LNHoFTQ3VJWlwRzthV25hP0hFBYO6DrUYoMIghO42k=;
        b=nRW9jA1ADac6N9AgTZwJbBM9qgp1ls2oRYzADgf3QblhLyEh/2V+Jbu/D0Fc8g+km7
         eb9/tbGdZJE6bDhuCdsoE+xt1gw+FA8grBGx0D7mhghyhOGud8lGxDpsT+Cqi0EsYJSt
         tr5tfXu+4RoQ4F0PXbyLOPjZyjmCbVIxDy+63m118WGFJU2W7MRrHKrbVda/170OqV4J
         oz2sXHl4ox4H9+pU8HpU/b56bvaUnKipFsuGln6QPO3CbOeofmPWM6dg83MQjvPjxKwG
         Z0P2rh4B8OIYSPB2nNKkbLUJV+dEqXZKPA9GNBBjwoSfvo1avApzUvrqmpr4qh790sLh
         42iw==
X-Gm-Message-State: AOJu0YylBp+QF5E3SaJZ5WqSPUyqx5F4yrpa0K183L675qU8e7PHvXnr
        5P5a7nNRBZ08rGMloLWDl322KZ40BtE=
X-Google-Smtp-Source: AGHT+IFMMXBTUxEcJ82/VuE2Gov3A80kz7vJZDrGFYO1Kznjt1NhqJ9Sh0hqXhm0/QN0ekH8AywEzg4Q8ck=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:da0:567d:f819 with SMTP id
 v3-20020a056902108300b00da0567df819mr329941ybu.10.1698796148691; Tue, 31 Oct
 2023 16:49:08 -0700 (PDT)
Date:   Tue, 31 Oct 2023 16:49:06 -0700
In-Reply-To: <20231002095740.1472907-6-paul@xen.org>
Mime-Version: 1.0
References: <20231002095740.1472907-1-paul@xen.org> <20231002095740.1472907-6-paul@xen.org>
Message-ID: <ZUGScpSFlojjloQk@google.com>
Subject: Re: [PATCH v7 05/11] KVM: pfncache: allow a cache to be activated
 with a fixed (userspace) HVA
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <paul@xen.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Durrant <pdurrant@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023, Paul Durrant wrote:
> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index 6f4737d5046a..d49946ee7ae3 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -64,7 +64,7 @@ struct gfn_to_hva_cache {
>  
>  struct gfn_to_pfn_cache {
>  	u64 generation;
> -	gpa_t gpa;
> +	u64 addr;

Holy moly, we have unions for exactly this reason.

	union {
		gpa_t gpa;
		unsigned long addr;
	};

But that's also weird and silly because it's basically the exact same thing as
"uhva".  If "uhva" stores the full address instead of the page-aligned address,
then I don't see a need for unionizing the gpa and uhva.

kvm_xen_vcpu_get_attr() should darn well explicitly check that the gpc stores
the correct type and not bleed ABI into the gfn_to_pfn_cache implementation.

If there's a true need for a union, the helpers should WARN.

> +unsigned long kvm_gpc_hva(struct gfn_to_pfn_cache *gpc)
> +{
> +	return !gpc->addr_is_gpa ? gpc->addr : 0;

'0' is a perfectly valid address.  Yeah, practically speaking '0' can't be used
these days, but we already have KVM_HVA_ERR_BAD.  If y'all want to use the for the
Xen ABI, then so be it.  But the common helpers need to use a sane value.
