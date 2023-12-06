Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D02807B45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377533AbjLFWVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377254AbjLFWVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:21:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437BB12F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:21:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso1610a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 14:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701901308; x=1702506108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V1+2VP/wFbYzasrbqfZWyaWxSqng1qwhzdOg/39SQxE=;
        b=rDyHX45reXp7S4s7uMXOdXhrQqv+IV3a+HG37OnVOVtC5pv+7rn+q5AaZB9jcyCpG/
         2RT9LLnqxm8wOLz2JjBxx4iyRC9DbUqDq/7pFSF30SfIg0k0bOJo5Ym4gOmTcg6b6wvL
         IOv5X+2bSDOK/vUSMTtv3nL8eT+0fRjdVKhYx3RC0Azx2F6S+kfRdC4aogkFkrECwDDM
         wXi9O7JORrVybX5ev+z01oPxwseUw3EeWPRbW9gW9Jh4jdP0SUdCHaPaGSeRgccTLMNt
         keyHKCphYXvGWeiIWB1+ghx3vb3cHTaIUPw3eAnTPvmkw6ckSKCXExYNzFB4QY8IGZBI
         r+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701901308; x=1702506108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1+2VP/wFbYzasrbqfZWyaWxSqng1qwhzdOg/39SQxE=;
        b=NMomKAazDdpxIPfj9kCslv+EyN1FwQvgjteJjb4frDceHG5M07We4foFA0ih0h7dTq
         gcM+jLnNvvKJBJnzr+GA20qWdwUOyC16CA328q0vy5vfeYJm+h90h408QPHa3eF7yyi0
         Tpq8E4mPpwMHNMk4GJ3fQ4+fubrpm4sarXxFHBvgoLAqbO6DOqJXB9UOTjv94ZDj8aod
         EDCdyYnSXKRF1YmMlVm77SNAAeXNLuv8wUuN2wAm0tc0lMpCVOUO6yNXIFi10zcwPmuW
         h6z60uurqx7us9GEbIxZIezMra/LBSNxaKBnentyMUg1hX6wz2jua7KeWHO1UxMya+CW
         ai6g==
X-Gm-Message-State: AOJu0Yxb4wzIT0HscWNU76C5XE+i7iD2wAyzdCnhePAVwdFw8JBB9G0/
        PkVa5C5iwr7qlTgfzH0E9A47SAvJTTRfaEPGixOiEA==
X-Google-Smtp-Source: AGHT+IGzMRLtgB4wQ1v5jCsfc6jBdJJXze82uCu85GqXCz1YiMep4yTLPkTMw7hh/R5DN2wxBEAqHmnBe3RIVlzWsqI=
X-Received: by 2002:a50:c35d:0:b0:54c:79ed:a018 with SMTP id
 q29-20020a50c35d000000b0054c79eda018mr150424edb.2.1701901307626; Wed, 06 Dec
 2023 14:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20231128125959.1810039-1-nikunj@amd.com> <20231128125959.1810039-7-nikunj@amd.com>
In-Reply-To: <20231128125959.1810039-7-nikunj@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 6 Dec 2023 14:21:33 -0800
Message-ID: <CAAH4kHZ0fQJDiZaAhVQ31KXths5n3g1dYdfivyR-HEXcOFOY5g@mail.gmail.com>
Subject: Re: [PATCH v6 06/16] x86/sev: Cache the secrets page address
To:     Nikunj A Dadhania <nikunj@amd.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> +static void __init set_secrets_pa(const struct cc_blob_sev_info *cc_info)
> +{
> +       if (cc_info && cc_info->secrets_phys && cc_info->secrets_len == PAGE_SIZE)
> +               secrets_pa = cc_info->secrets_phys;
> +}

I know failure leads to an -ENODEV later on init_platform, but a
missing secrets page as a symptom seems like a good thing to log,
right?

> -       if (!gpa)
> +       if (!secrets_pa)
>                 return -ENODEV;
>


-- 
-Dionna Glaze, PhD (she/her)
