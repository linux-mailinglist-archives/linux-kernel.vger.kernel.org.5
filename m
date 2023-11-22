Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449407F4EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjKVRvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:51:00 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A549A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:50:56 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41ea9c5e83cso5801cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700675456; x=1701280256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=944Y4e21RaB9HA2cqLWsnWZbFjFcU9l0VtpXNUcZliY=;
        b=2g3tr+XRefn0ScANIyCKKLcHKnsVja+8Ab2cIlnbAED+Bdnvu2+yHMJpsGT9UpgAVG
         Lmr+5IKb4CNbeuEBER7sat/FDCy9eIT4laKtMqbWQp0qgyeL3pzELdMZgD3M+v8/0f0H
         cn2K68AEzK8f4TIRpdQbHdRsTWvQyDNguiEel/PZjxjUu1zyxEe3/FLoCH+om9XMVeV/
         DEIuh1es0C21+YEfG1Qm+Gx4G+0fzncTIPQjKp1/E6o5Ajg46vmDElRHQzc11CNZK+O4
         LxY+3uNHmVXbhSmbfJPKq2cz6ew2e13Vaapj4zlwmlTEFjXlnNwUHBD6JCJS1zPZvBQO
         I3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675456; x=1701280256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=944Y4e21RaB9HA2cqLWsnWZbFjFcU9l0VtpXNUcZliY=;
        b=Kc38NtzO2oi9Dww4pgCSXHTpP4PnCv/+ujM1jxK2ERKNu8q/cjatmWvfocVMXYyTqN
         X7h1FLuLXnYKn5qvfDQ3EL+EzYpKreDnz4Nx8Yk6k5CCy5Wolli4xxcZsmiQNWlDqsC9
         TPaOTkkO+XPmw8xpmu8GowqI37BV7fRvDrKEarK0nf64rCztuHxv4kbHGxXZL8vTLKbg
         D5RdJRtyeEWa6GN0RUYYV9FpAV5BLMbceu4C7olWWU8iClGLxNUsE11UPJericbgL8tJ
         rZ8Orl3RpSCFwAMQCgaGniuAmZ2/p9GFG/hX9+7U/fxHI4AJrNFbsh67p2/PLhJ33M5Q
         /TSA==
X-Gm-Message-State: AOJu0Yy/cQlynVk9nubsWjpDw9Rp0C4KGG6nTNhH+awGYoG0yuMMSOr+
        Aw39TCEyH4wvI4p68zqmJvcEkyp+sdm77nwecAqFfQ==
X-Google-Smtp-Source: AGHT+IHDkWNVVO6N6h2GZtnFeGzjflej9Oui9kVs5UX4STTG30WhnX5qkn7ECzfu0u5DoeF6Y+Zh1J7z6MMJLdcTCDo=
X-Received: by 2002:ac8:5786:0:b0:41c:e345:1da2 with SMTP id
 v6-20020ac85786000000b0041ce3451da2mr192297qta.11.1700675455817; Wed, 22 Nov
 2023 09:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20231108171656.3444702-1-jackmanb@google.com>
In-Reply-To: <20231108171656.3444702-1-jackmanb@google.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 22 Nov 2023 17:50:43 +0000
Message-ID: <CA+i-1C0tp6qdkNbaOu6Na1VjfNpxA_1gMLUSS44t3-vfHRr3-Q@mail.gmail.com>
Subject: Re: [PATCH v3] x86/entry: Avoid redundant CR3 write on paranoid returns
To:     luto@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        dave.hansen@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, laijs@linux.alibaba.com,
        yosryahmed@google.com, reijiw@google.com, oweisse@google.com
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

On Wed, 8 Nov 2023 at 17:17, Brendan Jackman <jackmanb@google.com> wrote:

>     v2->v3: Clarified the commit message per Dave's suggestion and renamed the
>         macro. I did not carry PeterZ's ack since I have made some changes.

Hi Dave, Thomas, others - any further thoughts on this?
