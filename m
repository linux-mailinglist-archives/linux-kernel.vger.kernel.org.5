Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651787FB2C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbjK1Hd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjK1Hd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:33:27 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69540197
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:33:34 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso4131456b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701156814; x=1701761614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH1Rb27yFHn7O/0T0PrrTfYL/mFxyCVzddNEwA2dw8s=;
        b=KLZaUZ0wyKje0eDTTCguX+4Vxup9WAMzREfClWxVq32mA0iA/zo3K0Mdav4N9q4XKX
         4ilK5QPXtJEtYn6K91RB5eqB4vl5nFm4o7oNoX4c0u0C4FrwMuje0wQLKeFhCmCzijgU
         IwXWm0TkS1GI+dq2OZ62+3mOBWapShyghFWZxGqYEJCaVNrms1HEwCiI+jFY88BiESRC
         H2APJVuWwXshlfSTUXt/G+m9+uNalS2K154fwTJOFFojy0vmxd1dCKw0hOpn7oJLmGhH
         gMK77wDW2NlsHQuDoMAzyHs2XYz/prV9iHjvISVzV+eGjwybde6FZAkt3JSrXwgEpSIt
         Hsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156814; x=1701761614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH1Rb27yFHn7O/0T0PrrTfYL/mFxyCVzddNEwA2dw8s=;
        b=UvMdSyQ1zoypXRaTt6u5kLRORgdUO5SxtuIuJFBUYnygbfM9ckDmrI748UVew2sMNU
         vEMeE/GPyk9we/e+FdDb6W6ozI3Z/wuYKaOGwk5nWn8ogpFQqA0YjDW1f0W++emLvDht
         tIi2BqcmbjyHGzxL0P66B/nErNMx37mqFXO8ClmPmge1hIBE7yQ3Gt9Lz1ZFResDs/z0
         hcmJlKhpX8EGIfzkwPg5OwJ5MooDlLz3CKL/rrQdf/srSPHBUyX9DSgcmxrJsUdJSiRr
         COGR/4cWv9b90F8KJ9cvdrypJyF167OytondPnhCzl7MaLOzcVxiXwv9NBJ8l5NtgBTI
         6PRA==
X-Gm-Message-State: AOJu0YygTeRqU3sZYlsAHCrLQdqS9qwyOUS5vknrqFPmbUkwaG1+0u7W
        k0Qbzhef9eNmipXBSzzyfrk=
X-Google-Smtp-Source: AGHT+IEexFVKzHb/6CiIvmjINFN9eF6KzNFopoAPNeC4egDMT8Q1P7EdUjMYDSDft99pcEnAbx6mLQ==
X-Received: by 2002:a05:6a20:4419:b0:187:4ee0:e95e with SMTP id ce25-20020a056a20441900b001874ee0e95emr16729514pzb.52.1701156813729;
        Mon, 27 Nov 2023 23:33:33 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:6e62:da63:8968:8aec])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902864b00b001cfdb0d4268sm2310821plt.165.2023.11.27.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:33:33 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     ryan.roberts@arm.com
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, david@redhat.com, dvyukov@google.com,
        glider@google.com, james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown
Date:   Tue, 28 Nov 2023 20:32:54 +1300
Message-Id: <20231128073254.37870-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163018.1303287-15-ryan.roberts@arm.com>
References: <20231115163018.1303287-15-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
> +static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep, int full)
> +{
> +	pte_t orig_pte = __ptep_get(ptep);
> +
> +	if (!pte_valid_cont(orig_pte) || !full) {
> +		contpte_try_unfold(mm, addr, ptep, orig_pte);
> +		return __ptep_get_and_clear(mm, addr, ptep);
> +	} else
> +		return contpte_ptep_get_and_clear_full(mm, addr, ptep);
> +}
> +

Hi Ryan,

I feel quite hard to understand the code. when !pte_valid_cont(orig_pte),
we will call contpte_try_unfold(mm, addr, ptep, orig_pte);

but in contpte_try_unfold(), we call unfold only if pte_valid_cont()
is true:
static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
                                        pte_t *ptep, pte_t pte) 
{
        if (contpte_is_enabled(mm) && pte_valid_cont(pte))
                __contpte_try_unfold(mm, addr, ptep, pte);
}

so do you mean the below?

if (!pte_valid_cont(orig_pte))
	return __ptep_get_and_clear(mm, addr, ptep);

if (!full) {
	contpte_try_unfold(mm, addr, ptep, orig_pte);
	return __ptep_get_and_clear(mm, addr, ptep);	
} else {
	return contpte_ptep_get_and_clear_full(mm, addr, ptep);
}

Thanks
Barry


