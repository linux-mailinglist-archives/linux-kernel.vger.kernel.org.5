Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7186B7DCA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjJaJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjJaJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:56:09 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12D2C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:56:06 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-419b53acc11so192221cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698746166; x=1699350966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AiYZVx3GOT8EznjFnDKfN8wW+8MrAYI+JYHj3fNOMU0=;
        b=eD0XQvywf+yWTJ+9LgOXQ851gThJeUgu0mtAt0xFEWBji3f5AbBUA/pv6Otr8G7PeN
         m99d9hAsR8Ds+Ru09JePhHEb0b3UsoLS8L8jXnYUCXUmwRo+temRgiUQdT5XMytL9yqv
         dMIIKqNEPpq8d0cWull9/ZGtoLWXWwgfEas0YJfPgptIZPSt/qAFXJifJ//gAkHGchCL
         Kh28lVGRWA/lVViFbuCUw+x7kTNyMMt2UwouBghRdUi6RvUoN0qP7CSOp2++B4xhpxhv
         J7sJ51hHXBMlCtMzjEmq3867JqbpUWGaEcih7BXgpyktUkBSPJZE9UqZcGTAUBQAd6Oe
         Uphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698746166; x=1699350966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiYZVx3GOT8EznjFnDKfN8wW+8MrAYI+JYHj3fNOMU0=;
        b=vyEAzRGBJnzLzn/7zlWLHtqrF/IqnAasPWNUbVHmA6MB/OsZ697nLrYc13xxboKtvc
         QJFnyReET8UQdNMllsSo8Fc/BEQwA4A63w9Ja7rc1lur43PfiZ8kA05cBRSDjv9HG3/M
         jg6vBFvFn0ps0LZFnAvXNIv2QXG6daEBa0f/ckVhCGNxTkCthNzrBZhnVfHDOZHNfq2T
         6mQAD6RIZUd0HxzGqiAGQEuL0dMjxhnEq3rFgY447noRfWvIMWB03yorYf6kkHXDzI91
         xhUB8t7G+6bok0c8lhZyDuP7XmcmTlZX04FiOxvaW/WGBVIQOOWRXqmxmRF0ZLBuWoOc
         caOA==
X-Gm-Message-State: AOJu0YwFD1Uwn+68JX+VldfBgtlemvCX41KOK7dOGamqwkHN/JItF10z
        grwtdl3Dhf9AhRTODHPF3ouAXNS84JzJglAfp7bEBQ==
X-Google-Smtp-Source: AGHT+IF3CAN6Pa617blo0rAnZTTxemLpYjAi6/2Dms/IOENx7/lhUesrjuRK16Khtd/8N6rjgSgV4E+NaqE8pNLaOyc=
X-Received: by 2002:a05:622a:2898:b0:3f0:af20:1a37 with SMTP id
 ke24-20020a05622a289800b003f0af201a37mr139557qtb.15.1698746165645; Tue, 31
 Oct 2023 02:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231027132213.3817924-1-jackmanb@google.com>
In-Reply-To: <20231027132213.3817924-1-jackmanb@google.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 31 Oct 2023 10:55:53 +0100
Message-ID: <CA+i-1C2-SWWhWRszFvu3o+mAQea_ziEe4HDyvURGaRiAbHWuLg@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: Dedupe some memcg uncharging logic
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 at 15:22, Brendan Jackman <jackmanb@google.com> wrote:

> Signed-Off-By: Brendan Jackman <jackmanb@google.com>
> Change-Id: Ibe0f9941b6b24fc98ea2510a75d0a0d1066a2a2e

Agh, sorry, it just jumped into my head that I neglected to run
checkpatch and of course the commit message is garbage. I will leave
this a few days in case there are other comments before I send a v2.

FWIW I did at least run the mm kselftests via QEMU, results are the
same with and without the patch.
