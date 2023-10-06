Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4267BB0C3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjJFEVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFEVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:21:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFFDDB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 21:21:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c877f27e8fso13736335ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 21:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696566089; x=1697170889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=31a7+5f+dKEUOjTapfT2dmGxD91zYjZdh7R9akPGW1Y=;
        b=XnQhiNzTpVp1s3lQ4cNxN7gDMaIo8+CKS5Qu9MWe7VHjPsNAsw01dzkM35kyDCYpPd
         SJQh23ZKJ9WSbeLCAp5iZJSwUSEnIbse8IPv7ab0URZYdexztqDRISg1Jz4/Najhe64P
         GLCMJzDEyAO7VjLo5UvjJCZ7mIJu5B13bAJYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696566089; x=1697170889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31a7+5f+dKEUOjTapfT2dmGxD91zYjZdh7R9akPGW1Y=;
        b=cfBULixvwby2ZO0WOlqs+sapmI0UoISPKV/8hx2n/NQtNxhqN79H+D3E4xN3JqUlk5
         6iN52VzYuuLXAn3a/32g1PaRcWB4dy5KSfbHNG7gochRo7g5BiF8LfQWn7QpZ/eY+Wgj
         K8LWjTdv0W6Cq/QE4ew7fmPsYZrB1afXOUjRjPXuvoi3nQ57rQdw0eq7J9zbSZ5Y5yaI
         skb0IPWc83Ohun4YQy7I2FTzan7DvTJ7rGaNWMoXGtwyl36IA5M3zlbWgzrvG2kh1cTj
         ydkvqbEmr/l8imvoRk7lNqDFm4hHSzC/9hgM6XRUMMf2OmE3Il6bjPzUaDQ0qLu80vcW
         TeRw==
X-Gm-Message-State: AOJu0YxJ1tsTexBIuS+d0mE3zaRnocsI87Rd/bloBNL/CBg0ZqazlgK4
        5vTqahAhHBg2NnAby0nK5lgdXg==
X-Google-Smtp-Source: AGHT+IGopr7FkMNaDgBjublbZIBMMlQiWD+3JIFSW0Wg9pUK8sYj3ONwZZMOK+8xPV5llqQjeKeInA==
X-Received: by 2002:a17:902:8649:b0:1bb:9c45:130f with SMTP id y9-20020a170902864900b001bb9c45130fmr6189953plt.69.1696566088853;
        Thu, 05 Oct 2023 21:21:28 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4afa:2f75:6a8f:b6ea])
        by smtp.gmail.com with ESMTPSA id jb17-20020a170903259100b001c8836a3795sm2619729plb.271.2023.10.05.21.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 21:19:56 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:18:37 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Anil Altinay <aaltinay@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKLM <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] apparmor: global buffers spin lock may get contended
Message-ID: <20231006041837.GA17924@google.com>
References: <YO2S+C7Cw7AS7bsg@google.com>
 <cfd5cc6f-5943-2e06-1dbe-f4b4ad5c1fa1@canonical.com>
 <Y19GhTg8Q/3ym/VD@google.com>
 <dac1c2d5-367f-c8a7-c61e-c1774d98d602@canonical.com>
 <4595e7b4-ea31-5b01-f636-259e84737dfc@canonical.com>
 <Y+9aoFjrYkpFSvuE@linutronix.de>
 <f3fd5dd8-9d78-43be-fc5c-bf990ad3a64d@canonical.com>
 <CACCxZWOK6=mHNQrWEhjw4pC2i3qBKYdn9joiaaCNE7ge8FAz0A@mail.gmail.com>
 <CACCxZWO-+M-J_enENr7q1WDcu1U8vYFoytqJxAh=x-nuP268zA@mail.gmail.com>
 <31d6e8d6-0747-a282-746b-5c144a9970bb@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31d6e8d6-0747-a282-746b-5c144a9970bb@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/26 17:31), John Johansen wrote:
> On 6/26/23 16:33, Anil Altinay wrote:
> > Hi John,
> > 
> > I was wondering if you get a chance to work on patch v4. Please let me know if you need help with testing.
> > 
> 
> yeah, testing help is always much appreciated. I have a v4, and I am
> working on 3 alternate version to compare against, to help give a better
> sense if we can get away with simplifying or tweak the scaling.
>
> I should be able to post them out some time tonight.

Hi John,

Did you get a chance to post v4? I may be able to give it some testing
on our real-life case.
