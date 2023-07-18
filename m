Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5FB75721F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGRDS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGRDSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:18:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D02E6C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:18:52 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55adfa72d3fso2931144a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689650332; x=1692242332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qocaf1Ps72Y5X78MMqEBO1Mf3QN4QabQiTaMiLaTMtw=;
        b=ONjclki5nvVeHG0HQUbxOSuwrcQZelNicBRPkz+i3ubokewQamj3zUXhYTrt/NBIHp
         /6CLjsvSg0goevOLAHTXSPr67sxp0sfcVDFecwpdUUZS9KsyamsZspNgoGGcclDAkPff
         5jHe1sX2KRGY4yMEojm6fg2LsrxTaTQ4xTrTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650332; x=1692242332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qocaf1Ps72Y5X78MMqEBO1Mf3QN4QabQiTaMiLaTMtw=;
        b=ZIJhZLXuIGGizIZxKx2TJHruE1m2YXj/j0dPI32Rb1dJFgx0wA3GiEaPPnElM7gCIG
         8c2G/OKsM21ehWIlIPdTHyZ2WEuO3luaNEm/K79aoSeARHZQzfv2P9KRARLk9Ya6TMQl
         cmEGOj+KRhvlgDtEKql//cirrDf5EA5gZdweJsMvlXuK79LxkPEPtbXeqxHUTCv0sOMB
         ZcsDr6IT2es0SNoHOOmiWiq0ae3teKJdQJa6FEZhMz038qjJx//ceFnE79XJrIc8NDwf
         RcNN7ZW2QMneIqJhHUPDXmZwZZ5fMcWNoospPVxx8oC6tV2YgTbNy66bii96Oyi5QiMu
         UDcA==
X-Gm-Message-State: ABy/qLar6VJ1oZ2T+0Kn6cOCc6+tL76QJLfL688uMclxNnfYKEYS/qn6
        gnxGbkQ/7y3jxpBvtTj9i8t8VQ==
X-Google-Smtp-Source: APBJJlGUXNK5h3Xud1a4INFphWinfJKPRBPaoWo7exwOd9TI/NWDXBxA41Z1wq6jLs5HjF+dh13PoA==
X-Received: by 2002:a17:90a:e693:b0:25e:7fdd:f39c with SMTP id s19-20020a17090ae69300b0025e7fddf39cmr11817276pjy.16.1689650332180;
        Mon, 17 Jul 2023 20:18:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:49d1:35f7:f76f:e7b1])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a1a4400b00263f8915aa3sm5966598pjl.31.2023.07.17.20.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:18:51 -0700 (PDT)
Date:   Tue, 18 Jul 2023 12:18:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 4/7] printk: Do not take console lock for
 console_flush_on_panic()
Message-ID: <20230718031847.GB955071@google.com>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
 <20230717194607.145135-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717194607.145135-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/17 21:52), John Ogness wrote:
> 
> Currently console_flush_on_panic() will attempt to acquire the
> console lock when flushing the buffer on panic. If it fails to
> acquire the lock, it continues anyway because this is the last
> chance to get any pending records printed.
> 
> The reason why the console lock was attempted at all was to
> prevent any other CPUs from acquiring the console lock for
> printing while the panic CPU was printing. But as of the
> previous commit, non-panic CPUs will no longer attempt to
> acquire the console lock in a panic situation. Therefore it is
> no longer strictly necessary for a panic CPU to acquire the
> console lock.
> 
> Avoiding taking the console lock when flushing in panic has
> the additional benefit of avoiding possible deadlocks due to
> semaphore usage in NMI context (semaphores are not NMI-safe)
> and avoiding possible deadlocks if another CPU accesses the
> semaphore and is stopped while holding one of the semaphore's
> internal spinlocks.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
