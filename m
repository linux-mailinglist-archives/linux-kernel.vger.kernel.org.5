Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7E7F39FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjKUXC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjKUXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:02:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1B8D40
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700607741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35Vx+tN6z+QqmLpji6c9JPBO8+KdiIzwgrs9kWGJbWw=;
        b=GTAJiTzPWY5N4+vv9rEherPEx/KRuyw8wk6bGp+pv7OipwlNsqh9GahGHeqDMn8vJu+JtY
        CZAdGpa0V+jwr+L/yO/xXWsGAhlnPapsg8H0amAInkVn5Wtea2LEKv3BmHnp3mVghlFaS0
        Dgm5F+vBSZ9ss9+72saTX/3+rh6uaNI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-Az5llB5LO1yk1phc6CuFDg-1; Tue, 21 Nov 2023 18:02:19 -0500
X-MC-Unique: Az5llB5LO1yk1phc6CuFDg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc2be064b8so2700185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607738; x=1701212538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35Vx+tN6z+QqmLpji6c9JPBO8+KdiIzwgrs9kWGJbWw=;
        b=Dlmo6cj/ugR2ZFDGpneJ0eY85Lk326pCXf1mf7uzYhj02NEvnhNWhH5qEAU6dJl46r
         8Xb1qbwwPVLy3BL3xN6s36dTorZnNkKDefxNEWJPa7K9b0mEBu0q49V4XeZDcv4790Tb
         Mvk60vz45klmC9+/UJkX/iyKCffrJWeafhQ+Fo/DwX9uNXD8awb3gAERah2BoDVGd77B
         PhbbF1Rrh1DOjdJE1hiawrjKwyM0aGhq7CwkSEjb4JhDkFpsd6yPccRim0Gf8tQHJN/s
         TtF/INmaZepZseVKNGR4vNt5U+fE8zs6YUwsRtkO5fdpQBxqr0ZmwoHItMW4JF5eMFn8
         wcFA==
X-Gm-Message-State: AOJu0Yxt5Ahc4DBcnaRn7nWYh9IrxsO6ZsBU2dNMORc67HjhUfdkQYtg
        ejTz8de1tT2og4j4I+qmeI0qWerYqVJ/YLVlDelqx1rPvaLMxhnkj6AHZFF3MCFlcALv0bUBJQ2
        ycS0cyfBm2etCjj6vUJaM/cbj
X-Received: by 2002:a17:903:2341:b0:1cf:6832:46c with SMTP id c1-20020a170903234100b001cf6832046cmr903762plh.6.1700607738117;
        Tue, 21 Nov 2023 15:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQxNfDN/exMbNG8sxIbSIBwzNNSjvkEf3+l7v4sDzQROVAcylsUK1QJbli5gsAuBDSBNwd9g==
X-Received: by 2002:a17:903:2341:b0:1cf:6832:46c with SMTP id c1-20020a170903234100b001cf6832046cmr903742plh.6.1700607737739;
        Tue, 21 Nov 2023 15:02:17 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id l14-20020a170902f68e00b001ca4ad86357sm8421321plg.227.2023.11.21.15.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 15:02:17 -0800 (PST)
Message-ID: <647efdf8-66aa-4ea3-8625-bf657839f6f0@redhat.com>
Date:   Wed, 22 Nov 2023 09:02:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/kvm: fix compilation on non-x86_64 platforms
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     broonie@kernel.org
References: <20231121165915.1170987-1-pbonzini@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231121165915.1170987-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/23 02:59, Paolo Bonzini wrote:
> MEM_REGION_SLOT and MEM_REGION_GPA are not really needed in
> test_invalid_memory_region_flags; the VM never runs and there are no
> other slots, so it is okay to use slot 0 and place it at address
> zero.  This fixes compilation on architectures that do not
> define them.
> 
> Fixes: 5d74316466f4 ("KVM: selftests: Add a memory region subtest to validate invalid flags", 2023-11-14)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tools/testing/selftests/kvm/set_memory_region_test.c | 12 ++++++------
>   1 files changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

