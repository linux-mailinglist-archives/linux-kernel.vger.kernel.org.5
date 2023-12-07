Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5A808EC4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjLGRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:20:31 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916B1703
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:20:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2a444311so9650105e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701969634; x=1702574434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJZmz+Xu31RsK3yOUZORHxWDqDtm9lOUD8SdzkJgnz0=;
        b=pMnlYoYBy+mj2rR3/EpiYBOyI5lboZ9sN1UVqJqvK1tCZNObhLFt+HC3VPjwwyHH1n
         zVPApKrWTNhwC0QkXHqALz4UDUt5g83S0lyqkwb4QvUURp3j+FhOkT0Y4rD+IFo1QVat
         rt/y3aMsqp72tCBxnVIDCgIxoI6p+1geAXDLYDcoEVO8+xUn7pPALt1mSkZO6qTF1RzP
         sS6MtiKVzfNp27bLqyejx2bagwN124HFxiVADW7KQ5QVhGCuSmHns++jWXlm/mA5d1TT
         9MHf+btuiuCxjULGDUmdw9YyZ+FKmSp9SBNpG2V5CasvWGG9vedneau/4YG+Fz5BDmnM
         KGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969634; x=1702574434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJZmz+Xu31RsK3yOUZORHxWDqDtm9lOUD8SdzkJgnz0=;
        b=bvUJyK1jvO+P3c9uyGdPrxlheMvqNLc06kRxt6Vz7lU/CkveKoktVvgpBxwvDJRc3d
         UUORR+N+lwx/3lmMWgTd0VNwZeiqcqvTNnYwGkTfpT/odu+IKaajXmhMT15pJcxLuqd9
         2ulcxeJqrCwFtYphdMCYm+472ZTowqvoyVio9CaBC6jNfpNO1dBSyHQCH3POSch65YqD
         72ak/r++F4kg5rPwvccuYLmXoktRGYT2giUFpVtgSXAFdOJW9Ndw7Qsl+EvyK0B0YNjB
         g02iyE5OiF2AMp/UW9y/6IWZDJ0g25GbSWatjq6vV8Ze5a6NAW/IzLa3ChJIs4k1oSwF
         +Enw==
X-Gm-Message-State: AOJu0YwyQQQlRceb2tufYZIkjD/VDXHfSJc0iQg2IGCqMUPNwKSzoh9D
        uTZLMRj6/W7JUzcmdxAPORL1LA==
X-Google-Smtp-Source: AGHT+IHBoX8I60F64oLKl/3IeE8m25oA1jeZ3zTmZ1x7KOkD6L2XcMtJGWBkxLiOkWToPoUqFUixhw==
X-Received: by 2002:a05:600c:6009:b0:40c:251a:101a with SMTP id az9-20020a05600c600900b0040c251a101amr697747wmb.311.1701969634537;
        Thu, 07 Dec 2023 09:20:34 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id bd19-20020a05600c1f1300b0040839fcb217sm318562wmb.8.2023.12.07.09.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:20:34 -0800 (PST)
Date:   Thu, 7 Dec 2023 17:20:32 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Message-ID: <20231207172032.kto27hfdxa4juq7b@airbuntu>
References: <20231203011252.233748-1-qyousef@layalina.io>
 <20231205162043.GA2558193@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205162043.GA2558193@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/23 16:20, Joel Fernandes wrote:

> I think a better approach is not do an anti-CONFIG option and instead do
> a shorter parameter "rcutree.lazy=0". If CONFIG_RCU_LAZY is set, then we can
> just default to keeping lazy on. I'd like to avoid proliferation of already
> large number of RCU config options and more chances of errors.

The issue is that we don't want to ship with default on :-)

> I also want lazy to be ON for everybody configuring it into the kernel by
> default (those who don't want it just set CONFIG_RCU_LAZY=n), this is what

This is still the default behavior.

And all or nothing approach is not practical. You're telling me if I can't ship
with default off, then I must disable it altogether. Adoption will become
harder IMHO.

> tglx also suggested that's why we made changed of our initial prototypes of
> call_rcu_lazy() and instead we made call_rcu() to put everyone on the lazy
> train and not add more APIs (thus causing more confusion to kernel
> developers). This was a bit painful, but it was worth it.

I think implementation details make sense, but orthogonal to the problem of
enabling CONFIG_RCU_LAZY=y but still ship with default off. It is a risky
change and we want to start staging with default off first. Not allowing this
in upstream means I'll either have to resort to keep it disabled, or carry out
of tree patch to get what I want. Both of which would be unfortunate.


Thanks!

--
Qais Yousef
