Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1675304D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjGNEBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjGNEA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:00:57 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF31172C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:00:57 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-564e4656fecso1017159eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689307256; x=1691899256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTZJyJNrNsnTJoZ6pMSnfeTnYDCP+/B8VhZBixHLWGI=;
        b=JdJesVToWjK7nwS/DLOk6n0JQRPhcQM27Jx08NI/Ctm5K4BPo0i7S6Nzi8M4HT7Z3d
         zc1NJ4E/oJkBw+K/0Rf8EgqjgAYtgMiA2Wqj1r/4dP1dvmDtso/bYldPfBpApIBqrVjq
         4scllsOHNgqPHZVQhp+nFe1+4eBUTNGW6Ql0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689307256; x=1691899256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTZJyJNrNsnTJoZ6pMSnfeTnYDCP+/B8VhZBixHLWGI=;
        b=PCvMwpXQIvHmtMVX49/QA+O3DJfz9w0o0ebJBR3MjOA9T+ICYeKECH3gN0fv/c86BK
         s7evbIpcAER8p42+B1Giq3NziP+fn2Cf0evjxx2E4Olcl1pwdSD6pUMOUh+fumN3mYqw
         JA/oUF4kvvldiGhfSJZLWZZbxUS6GgF1l4pSEkedlXRNd3CaNMkyWT1k2IE3wywIM9Ef
         oe22Ommg9P4I5HhFYlH3RINnGzURGaOB8BiY1KzsWTAsDpCSxIVpxP6X4MHIjt2rpSd/
         S0pYYnLAQKBzYeEgg60bgzrGa0umcAW/nwrRnlWDbOBwYoJQKomiqgc72X8RBkH6sNSP
         yVWA==
X-Gm-Message-State: ABy/qLYB+xnH9S30Dfu79jgjR3n3c4TwPS1vvD+9RPArLLgrjlS8mBAa
        M/6rDVKZMlUId4jklmWrNDmeKA==
X-Google-Smtp-Source: APBJJlEI+S5ilDDwjyQL7jv635Ny5eUpeo0Dqyx861m5EA7MeVgoJcf86sOHtuLLtgrxJ4hYEvb1bA==
X-Received: by 2002:a05:6358:280d:b0:12f:2573:45b4 with SMTP id k13-20020a056358280d00b0012f257345b4mr4457182rwb.26.1689307256206;
        Thu, 13 Jul 2023 21:00:56 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b00678afd48250sm6071772pfi.218.2023.07.13.21.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 21:00:55 -0700 (PDT)
Date:   Fri, 14 Jul 2023 13:00:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/5] printk: Add NMI safety to
 console_flush_on_panic() and console_unblank()
Message-ID: <20230714040049.GA81525@google.com>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-3-john.ogness@linutronix.de>
 <ZK14p-ocWuuHkSAQ@alley>
 <878rbkrg16.fsf@jogness.linutronix.de>
 <ZLANiK_1YoBu1YpU@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLANiK_1YoBu1YpU@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/13 16:43), Petr Mladek wrote:
> 
> Simple removal of console_trylock() in console_flush_on_panic() would
> cause that other CPUs might still be able to take it and race.
> The problem is avoided by checking panic_in_progress() in console_lock()
> and console_trylock(). They will never succeed on non-panic CPUs.
> 

In theory, we also can have non-panic CPU in console_flush_all(),
which should let panic CPU to take over the next time it checks
abandon_console_lock_in_panic() (other_cpu_in_panic() after 5/5),
but it may not happen immediately. I wonder if we somehow can/want
to "wait" in console_flush_on_panic() for non-panic CPU handover?
