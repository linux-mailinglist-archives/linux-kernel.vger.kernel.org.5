Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CEC76D797
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjHBTRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjHBTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:17:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD8E7D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:17:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bbb34b091dso1721285ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691003839; x=1691608639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5AxzMJt2bPtQ5EtgIZk5VAn4zi3P8u/m47CM4UEy2c=;
        b=otyFsoOWrDv/6quxj7rv1dBisZkPIHW25XiWS61ikCc26s5v4I/9nBXA1oJjynx9qj
         jNIGL+Jz2jE4ig8tFtvgMRuYhMGJxFaot/Prin4LvEfpaaDSo1OLLbDNPX05jP0+LdD0
         RgD5OJ7OQcVmKydTDl252DSnJzMS8CXBkBhhkKummSxUw/gH0pDqJY08GezKCznvlAXK
         KhNVE0jTcz0QWnU4Nlp/b9Z9TgxuW4FYcsXLbp5m7yifdJS4fY3N0GmHMn4FWl8DpEmG
         pY8R3bIbhrc4agsPhXa6TukWkiOj91Kc3H/nUe4mIqPmaUBEH4xCf+RAYnpp6oNzqEYL
         nZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691003839; x=1691608639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5AxzMJt2bPtQ5EtgIZk5VAn4zi3P8u/m47CM4UEy2c=;
        b=lONRbKCNGe9g/+JteTTwBrDj9TFCpTAfeqbkGBn7kIK2WAeMyY6L5ZZF0PLsOQmYmL
         W7FNs0PnofcQGlE/Ai9i8/Ei/M/bJBQ7coGwgJlBnChNEojg9qQOqe5VDDfliLZP+1UV
         yTarNz3KSlgGapwnBNZQ07OAIQu27LJ/wNEulWPG1m3H3O5dOSB4HGJ9+vmYXzRAasn8
         T9d5ntA0h4O0sCkmBhiy4JzBCcWeimdjelaurcomiGPqvBByEBjLfTUspz5O9EDGBtmL
         GBHQPo9JzUcb5Is37M3lGlh50oZN60wCDARj2Qlxi5+k0cmQ+WtGVv5EHqd2Z55otglB
         FcJQ==
X-Gm-Message-State: ABy/qLZold7907gY8iVTVpn5OTZ2g6O+euONJYQ9UBUPPCrhINXD9lLc
        D5+kDtoyG7rtLnF3VCDXPP57GtzQcac=
X-Google-Smtp-Source: APBJJlEt3F1TDnvY60IyT+FoT26q8CLH3ut/dc5dW9pmDBlNh4ZY44w+hmm826e7yfostQ8cCFb9ZPlBkgo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2d2:b0:1b9:e8e5:b0a4 with SMTP id
 n18-20020a170902d2d200b001b9e8e5b0a4mr89849plc.8.1691003838751; Wed, 02 Aug
 2023 12:17:18 -0700 (PDT)
Date:   Wed,  2 Aug 2023 12:16:44 -0700
In-Reply-To: <20230625073438.57427-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230625073438.57427-1-likexu@tencent.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <169084277743.1259368.2404878435563785686.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Use sysfs_emit() instead of sprintf()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2023 15:34:38 +0800, Like Xu wrote:
> Use sysfs_emit() instead of the sprintf() for sysfs entries. sysfs_emit()
> knows the maximum of the temporary buffer used for outputting sysfs
> content and avoids overrunning the buffer length.
> 
> 

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Use sysfs_emit() instead of sprintf()
      https://github.com/kvm-x86/linux/commit/1d6664fadda3

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
