Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB447B71BE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjJCTbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:31:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1D9E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:30:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so359881a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361458; x=1696966258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91yxhS2lgEwwop+CsexGsRQMQPau+YfssFyd0l/2CIU=;
        b=RezoU9P95yBAHeEKEsww+jbHPLYCJyGsLJL9CEVsJm4lbLwKWgs03doh8Kt8bJL6Z1
         yi7jp89/aNRuLeVKxy0JQAp8U+4hOnyaU+njyEwBTVCcY1FQChCOxJ65q/2RVEzhH8Ve
         0ax5XETfIEhemkYhZGeSY8Kvc/fwhgAcskeSqAap3diz3WYRmvUk3dR8ftW5BnQ3G5vK
         Ee1qOGI5TZYQQZQhJH9vqSf5p+5wm3WM2/lmudJGdbLGIEjB71X2MwQEu/H/Ip65fSQS
         63FQlHzWZMWHkLB79BTRe6Kh/L3cy8zreo56HkaEyjc5riujO3ZrkOFYE1l3yC33Ako4
         gqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361458; x=1696966258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91yxhS2lgEwwop+CsexGsRQMQPau+YfssFyd0l/2CIU=;
        b=vaso2K2soHdyYzeg6ZPTQWwJADYg0egvM7qc/kY170haggEH8rhoNbF73XdOoOCzO5
         CXN3pkpcicY33D4LNaz7OHb3SbCLb+cQo7oOpMRhZkF9tx+/x7wxSLu8n6xn9nrUJlNi
         6mfzgOwAMe0aA83OzzcuGMlFdGcJSUvFvdRMqntXIMlaLctmAswVG7EvZwvsssWRee5F
         npwDnIhjMAbbwsI9LIcU+PKUGI+wccfmAtTCjDtL8VwO+Z+Gs4QCyPCPh/sl8v/YNLg6
         KBGkJ70XKEKdzYUpdPHibXgsQmqZxo7i/m+B1D8Z7speR5Bn55zP+dZ6837WPTradXIm
         3S5g==
X-Gm-Message-State: AOJu0YywbbwEVW8GgpqWYMBo5Kt+PRzO0RqehytXm77oVSQwGgD/ATyB
        BbO0gnf/JO7OTDXoX2YexIVxtotdSAw=
X-Google-Smtp-Source: AGHT+IEwuKnW6JFgwcK0SW/P7J4WJQMRSoyN3PjGvqEbVs8gd9BBgqxDf+wz9x1lE1RTCwQ0vhPMtw==
X-Received: by 2002:aa7:d393:0:b0:523:2e23:a0bf with SMTP id x19-20020aa7d393000000b005232e23a0bfmr241076edq.11.1696361457966;
        Tue, 03 Oct 2023 12:30:57 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id j15-20020a50ed0f000000b0052ffc2e82f1sm1320552eds.4.2023.10.03.12.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:30:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 21:30:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86_64: test that userspace stack is in fact NX
Message-ID: <ZRxr79i5PAXRXjqr@gmail.com>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
 <1d5223b8-0275-619d-db1c-e2aaaddb173e@intel.com>
 <d468d13c-6c4b-4d8d-8e2d-e4314b4bb1a7@p183>
 <f972d59c-40dd-2a68-ff13-a2658513a25b@intel.com>
 <ZRxmS/3nr6pDa1+z@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRxmS/3nr6pDa1+z@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Because not having NX in 2023 on any system that is threatened is a
> big security vulnerability in itself, and whether the vendor or owner
> intentionally did that or not doesn't really matter, and a failing
> kernel testcase will be the least of their problems.

BTW., it's also questionable whether the owner is *aware* of the fact that 
NX is not available: what if some kernel debug option cleared the NX flag, 
unintended, or there's some serious firmware bug?

However unlikely those situations might be, I think unconditionally warning 
about NX not available is a very 2023 thing to do.

Thanks,

	Ingo
