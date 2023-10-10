Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3ED7C0153
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjJJQNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjJJQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF84BB6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696954355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HwWBmshMoiCixnS99NmNTL6QgwlkX3WoE8OY6VxV+Dc=;
        b=OShGrNw4v6m/0y6YNHO24dhkxs9gQxHqj3TQjFDbE3zgTpYZS7E78fPVjQepb7VQSGI2iE
        jW0a3ZbipjfugtQ1b2o6+m52eMSE+SKASWIUpach60+U7qiC285blpVxObZ2S+I6FHB0Wc
        0BNO6mxpnzZhyqPpFIGMhEPQua69GkA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-KVsebjJPNZ299DwP4N7h3A-1; Tue, 10 Oct 2023 12:12:29 -0400
X-MC-Unique: KVsebjJPNZ299DwP4N7h3A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3247f646affso2728660f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696954348; x=1697559148;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwWBmshMoiCixnS99NmNTL6QgwlkX3WoE8OY6VxV+Dc=;
        b=dQsBaNDKhvPGDj84AlRRVsw+3UBLfl67ESgmCS8vbgZyCsU/JIBaMfRQVFcD8Il3QC
         r+R2F18iS26BNZPIgCoB6Q7gixLAgjMpIM7KIOUXs3SNldrY6hnhkmj4gCeZ4ZLclPwt
         KKreEp6IO1Hxp+L3o/TijOw26Iw268wShVhPEKiAX9+etKZ/0Bc1SBy1YWv4F8dWQaZ9
         EcPLY73ievoU0u0AADNTtcqfJSdy5F7etN70zXAR437JvcJ6Y6z2q/ocP69sLqJX9FfB
         U3x9l8lxds6gHbDUNma7PxhvM307BK9QGOJYQ66OuhmKfXoFJhmSUc8PpFQquz0L7aVf
         pvVg==
X-Gm-Message-State: AOJu0Yy7tJWYXEFP9Nnzyiod7TjrMhwiLBJ8D5B33S3WTWYPLKR9vGN3
        gc1bYj277ALhjx56LGs+5qKPTvuaev1GSB7CrC71xKXNNthwaYcmk6/SfiWUD8kDPanXp4f6UMe
        hB50uGM+Xvw2RclJlISvfje91
X-Received: by 2002:a05:6000:243:b0:329:6b53:e3ad with SMTP id m3-20020a056000024300b003296b53e3admr10803404wrz.34.1696954348427;
        Tue, 10 Oct 2023 09:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES8Q9DWNOpjBqrp2V2Cl2LKRigDk4U8DPwzTgvqENIa2+Gt/O7S7D3nvy1sb4iqw39jOi8+A==
X-Received: by 2002:a05:6000:243:b0:329:6b53:e3ad with SMTP id m3-20020a056000024300b003296b53e3admr10803382wrz.34.1696954348022;
        Tue, 10 Oct 2023 09:12:28 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id f23-20020a7bc8d7000000b003fe1c332810sm16769821wml.33.2023.10.10.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 09:12:27 -0700 (PDT)
Message-ID: <e4d6c6a5030f49f44febf99ba4c7040938c3c483.camel@redhat.com>
Subject: Re: [PATCH] KVM: x86/xsave: Remove 'return void' expression for
 'void function'
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Like Xu <like.xu.linux@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Oct 2023 19:12:26 +0300
In-Reply-To: <20231007064019.17472-1-likexu@tencent.com>
References: <20231007064019.17472-1-likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У сб, 2023-10-07 у 14:40 +0800, Like Xu пише:
> From: Like Xu <likexu@tencent.com>
> 
> The requested info will be stored in 'guest_xsave->region' referenced by
> the incoming pointer "struct kvm_xsave *guest_xsave", thus there is no need
> to explicitly use return void expression for a void function "static void
> kvm_vcpu_ioctl_x86_get_xsave(...)". The issue is caught with [-Wpedantic].
> 
> Fixes: 2d287ec65e79 ("x86/fpu: Allow caller to constrain xfeatures when copying to uabi buffer")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fdb2b0e61c43..2571466a317f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5503,8 +5503,8 @@ static void kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
>  static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
>  					 struct kvm_xsave *guest_xsave)
>  {
> -	return kvm_vcpu_ioctl_x86_get_xsave2(vcpu, (void *)guest_xsave->region,
> -					     sizeof(guest_xsave->region));
> +	kvm_vcpu_ioctl_x86_get_xsave2(vcpu, (void *)guest_xsave->region,
> +				      sizeof(guest_xsave->region));
>  }
>  
>  static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
> 
> base-commit: 86701e115030e020a052216baa942e8547e0b487
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

