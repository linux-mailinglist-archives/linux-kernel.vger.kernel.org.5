Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D857C7BF11E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441905AbjJJCxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441862AbjJJCxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:53:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75EB93
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:53:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5855333fbadso3208490a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 19:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696906423; x=1697511223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bGujVwsvCoOKNsC6D7rt1W6/PQU6Z6f8F949D2Rxbr0=;
        b=XPxpW0L7YJ7aKjzYK4zHlyHgNzmo0v5wk0D14mWKGLuT4kBHrNvYvQJZEiAk50SfXC
         EQCHBa6M5TSD9xc1IR5N5keiCfObj3JY5yc8fPl4oPjWLAxOTSo1h123AxaKXktxDiEG
         9apeioZcB4NmiRCcFSpAXfNml+LVhVWvPYAYjGWTTazDCchW/7xzNRzM7F10b1uaLh8e
         nSrRm7wV4WKqp7+IP7j0DJ3XNfWRDWuVECmLsYDuabmFbF8sdrHItIDOmnM513CenNcN
         85TWSPc+/X12S5fOGi4TrqF6GYLesm9CJF+el+6STSivIIuTpex/EFHC9Fzaen0xMLZ1
         Tb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696906423; x=1697511223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGujVwsvCoOKNsC6D7rt1W6/PQU6Z6f8F949D2Rxbr0=;
        b=k7CtISl5HqIL/b2dVyadaB3Lhzx/h1uF6GqClUIoLQv9XFWGIvitpPtcxZxtqTNouB
         tQt10ClAfF2rtmYFMJGLIMbbwKw/qXzVYHztZ1T1dL3nyEK+JcA9rNmv36eHozTdCwny
         5IBiRqOOnC3ZNdnVu8kNwClarO8hNNCpum9iawfJhmXgPXvNCMduSjJ65/N4xFAyy0oz
         gYoZsW0rclD29dKMmnynDEtCuuZiIz58d0YQpDOjqGvkMsxhy/O14dGqPErzJFbH7S5j
         4TiNdwMubWWbeHLu9YwicFrdPNlT+2tWBMaPs9xlW31Y864EvMEVVdSMO9ZZ0tQ+Es7s
         rz7A==
X-Gm-Message-State: AOJu0YwbpL8ETvvDM+lZP+eXiXNTJjMldOUHDqms+W+L9VRaRFi+3xT4
        zfPV1vzEawf4D8JVYtZNbSBF/nH0slVF7zPmhoU=
X-Google-Smtp-Source: AGHT+IEjmYikvHwIb3GzGvRon36WVMjQpGyQrSq28NYD6Z7GbndIRlqF5eOYGGQMy5B0mb4kabj1HQh89GIVQmbhK1s=
X-Received: by 2002:a17:90a:fa06:b0:274:8249:a85f with SMTP id
 cm6-20020a17090afa0600b002748249a85fmr13720053pjb.21.1696906422878; Mon, 09
 Oct 2023 19:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231007113541.8365-1-qiang.zhang1211@gmail.com> <ZSQuWl_B_7i0ZW7Z@slm.duckdns.org>
In-Reply-To: <ZSQuWl_B_7i0ZW7Z@slm.duckdns.org>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Tue, 10 Oct 2023 10:53:31 +0800
Message-ID: <CALm+0cUU3nvzk-A6+4zF5fCrkQ_dDY6GE81L97qU-xyCHCsaww@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Use the kmem_cache_free() instead of kfree()
 to release pwq
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Sat, Oct 07, 2023 at 07:35:41PM +0800, Zqiang wrote:
> > The pwq objects is allocated by kmem_cache_alloc(), this commit therefore
> > use kmem_cache_free() instead of kfree() to release pwq objects and also
> > make use the correct tracepoint("trace_kmem_cache_free") to trace the
> > release of pwq.
>
> This isn't wrong. kfree() can be used for memory allocated with
> kmem_cache_alloc().
>

Yes, that's not wrong.  but pwq is allocated by kmem_cache_alloc(),
usually should use kmem_cache_free() to release, correspondingly, we can
use 'trace_kmem_cache_alloc/trace_kmem_cache_free' to track, not using
'trace_kmem_cache_alloc/trace_kfree'.
And in rcu_free_pwq(), we use kmem_cache_free() to free pwq.

Thanks
Zqiang


>
> Thanks.
>
> --
> tejun
