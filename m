Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE10752CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 00:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjGMWKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 18:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjGMWKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 18:10:17 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510202719
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:10:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b9de3e7fb1so5801355ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689286216; x=1691878216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gogTPYXLafipe4IJKLi8OWwxTihyvKkXkU2xENddLLA=;
        b=1K8OGQlOcob1VgQdPzcGoytN+L/KRaX4Y/HBOpcGL7kWPNn9RNw9JgP1mOrSTOEEO6
         gvR8cI2i85f2Umwo6f1HeslwyYD8R1JP2lyMc8EdeaIWRYrKB4/+VoLYOnWTfWSN69Jf
         5h84/eOwMNndzs/wiac+jyKQR26gi01fIW214lh4wXvNn84jvebBpjsDhGtoWxNxmg8B
         iteQ+h19RpXAUNatWnXUuoRi/y9oKljW+OIsS6ccCT9HDU3aabhLgQrTgsXix94rYiwC
         PCiBTEdmvu52n7ObZnUx44SnTnKs2zusczwZOnx5FoppnzwauGCib16Ht5Nk1IzU3PgI
         v+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689286216; x=1691878216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gogTPYXLafipe4IJKLi8OWwxTihyvKkXkU2xENddLLA=;
        b=BGDHfwZLVl9/KoI9GvMyf/vm641uDG9CD1rWVlor8439QZrVlE5WOzdgRuzop/mfIW
         E0SL0kiC2XAs+/sxSvQyD+2/TqUz+K7zekp3dtX1YMIpArkYIzB7p+Nas8boYw3yxS4S
         +QJo/jEZzqj0wzMC4Nwp/3nb0gs0MV+YYpROwauPIuFN4Y4jvihrmU3eqr4fKz3TAt+i
         xJZC2NNbLRb+GL8jebu5zT1boo8y7MKutIn43ZFUqGEYGk4ZY+kaS3IcmPbkea/8/XWH
         2bZtPQQWIaey3yeG3hvJ+hX1ddU1Cm7GWn0Empt4EXL8zlc0TnRszUmmnOHQM2MWWqhu
         9xOw==
X-Gm-Message-State: ABy/qLZeSwQq845V0PzIq7rhgFIWICbPbmQl1npCvlbXGRJzhtThURcC
        avhh6k81Dpm8+fj6+uGskqb1/0ylUsY=
X-Google-Smtp-Source: APBJJlFKBTGdsU9w5fXlOdzBJ3H1Wj190qbeOOztvGOvOIo9NINmHgA6U0s9w6S48to8L8SQgUj82tMSHIs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:cecc:b0:1b8:866f:6fc1 with SMTP id
 d12-20020a170902cecc00b001b8866f6fc1mr10059plg.0.1689286215874; Thu, 13 Jul
 2023 15:10:15 -0700 (PDT)
Date:   Thu, 13 Jul 2023 15:10:14 -0700
In-Reply-To: <bbd17dbe371d6b12b2e7670bef6a4f080267c300.1687991811.git.isaku.yamahata@intel.com>
Mime-Version: 1.0
References: <cover.1687991811.git.isaku.yamahata@intel.com> <bbd17dbe371d6b12b2e7670bef6a4f080267c300.1687991811.git.isaku.yamahata@intel.com>
Message-ID: <ZLB2Ro55dKGElB9B@google.com>
Subject: Re: [RFC PATCH v3 09/11] KVM: Add new members to struct kvm_gfn_range
 to operate on
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        linux-coco@lists.linux.dev,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Yu

On Wed, Jun 28, 2023, isaku.yamahata@intel.com wrote:
>  void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 1a47cedae8a1..5ca0c8ee4292 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -260,7 +260,13 @@ struct kvm_gfn_range {
>  	struct kvm_memory_slot *slot;
>  	gfn_t start;
>  	gfn_t end;
> -	pte_t pte;
> +	union {
> +		unsigned long attributes;
> +		pte_t pte;
> +		unsigned long callback_arg; /* needs a better name */
> +	};

Making the union needs to be done in a separate patch.  And coming back to this
with fresh eyes, I think it makes sense to give the union a name.  I think an
anonymous union is actually worse in the long run, and there aren't _that_ many
instances to update.  E.g. that way a single build-time assertion can capture
all uses, and it makes it more obvious that the usage is poking into a union.

I'll post a patch separately so that it can be picked up for the MGLRU series
(and maybe even merged ahead of both).
