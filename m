Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E38001CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376972AbjLAC6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLAC6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:58:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B81711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:58:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54b7ef7f4d5so1861799a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1701399534; x=1702004334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GKRqMkMuSnteVCR9/jJT3xFVtsM844NAUYbg1NFX8Fg=;
        b=MzRsQKWoCrhLaIyniY0ihpSk2sYqCUOLwlOhYYAGeW2BqB6PSCBbdDwkEqO/FjiF/6
         Y6KwhSlASaEzBsXAmFCZBzqUUQoKgWxsKzc5JwjtvlNl4jM1HYR0KhDDx5qXVRhrMsPI
         FEatlklCNfRor5qkKQKexMr+0EFmvAGRlkU4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701399534; x=1702004334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKRqMkMuSnteVCR9/jJT3xFVtsM844NAUYbg1NFX8Fg=;
        b=mjQadQ15Wndo3xygmWsYS/AziJfiS4Mdj3f+3yZI7yzO1CAW8VFDImhx/fQzkEQk0v
         LlEwbTu2/8TY6KSgIC7kPv0I3p9X6IkCoQAOVpNiZClu6kNmXpgY7BS+A04ZmIYYxs2y
         SWbS6bqvruj1LhVIuW2XqVflSKW2QXnwvQy0h9D4xEkFtfbk7QilKj6rmeVkIXK3CsWV
         wzITnDdVWAOazLV91b3NuBATdX0+g0WIYVC8UR53xWBgkebVVmHmJnAbjGDWjGrI40O3
         dLaSWv+E5jdOGS8Nrf/jp3G3QVIFyXKzRyfk2GRk8wuguCY/Kr9LCYuQkzOqULbhW24A
         XFdQ==
X-Gm-Message-State: AOJu0YzuPadRUNlOSKm6SEVYfN+pUQ7TLTLJmBde7B6Hn8QuuN3wcc9Z
        HJESNMCp84dwEkqMe0Ju8iDzdTufIUP60YBnU5g+eQ==
X-Google-Smtp-Source: AGHT+IGltQE34zLV/o2J8TJkA+UJh6sdCF8BER8QY3BRlRgvhxsMOswMsZKUe+8tETbN94/ejBfZ0hDgH0cbuYrvUgM=
X-Received: by 2002:a17:906:21a:b0:a12:5dd2:4649 with SMTP id
 26-20020a170906021a00b00a125dd24649mr349956ejd.43.1701399533780; Thu, 30 Nov
 2023 18:58:53 -0800 (PST)
MIME-Version: 1.0
References: <CAMVG2stxMYZbDoAHeVQjgJ7f+Td7+VJrLNRbY8au68ZVkzhb0g@mail.gmail.com>
 <20231201015055.pn5qqbsk42jlfsoc@moria.home.lan>
In-Reply-To: <20231201015055.pn5qqbsk42jlfsoc@moria.home.lan>
From:   Daniel J Blueman <daniel@quora.org>
Date:   Thu, 30 Nov 2023 21:58:42 -0500
Message-ID: <CAMVG2stS=W4d+XxxHzLb+31Dn7pnqjTE25pDwLSv_14rcqsc-g@mail.gmail.com>
Subject: Re: bcachefs page fault oops after device evacuate/remove and unmount
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 at 20:50, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Thu, Nov 30, 2023 at 08:47:33PM -0500, Daniel J Blueman wrote:
> > Hi Kent et al,
> >
> > On upstream bcachefs (master @ evilpiepirate.org/git/bcachefs.git) SHA
> > f8a1ba26, I was able to develop a minimal reproducer [1] for a page
> > not present oops I can provoke [2]. It appears we need further
> > synchronisation during unmount.
> >
> > Let me know when there is a patch I can test, or for debug.
>
> There was a device removal that was just fixed, I've already sent the
> pull request to Linus but in the meantime try this branch:
>
> https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-for-upstream
>
> If you still hit it, I'll turn your reproducer into a ktest test and
> hunt it down.

This did reproduce on the second cycle on bcachefs-for-upstream SHA
415e5107b0dc; let me know if you can't trigger it and I'll make some
adjustments.

Thanks,
  Dan
-- 
Daniel J Blueman
