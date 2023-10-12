Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04AD7C69FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjJLJsj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJLJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:48:37 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3E2A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:48:36 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6c6591642f2so173045a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697104115; x=1697708915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8jbtR6EIJYN3cjl7B8IUxCMmgUNZl5HM9s4d0S8FKU=;
        b=f8Ojq+rwdQ7vTeHQNIkLLAMDZrx+3sMMme/q07yLL1V+7LtERGr28waCSYUYkJKJ3Y
         DeelTQk18XN+06F/wF40lu/q783Lh1tTuAfauRbFMmEXL1SMoknUhvmfMONChIoyecAA
         oQrz9IJwi7u1tO7raoQPPdOmL7LRSdXNAI8xWZzmZn5ScaRBtUE5e4EXrhYVCzZ7EOb1
         tTYNl8WN9jqk5YJJMshwkf/UuqStjnuEeqryMEzN6UvOiFR+Jj1Bo0+bcJfc5WCbgOHt
         eUSoPmjlHJZcxbQCjqxUyda8UP6gGVg7ff0BS+d7W0ezW03fl//75KmvnXKsSCr06Hgj
         Of2A==
X-Gm-Message-State: AOJu0YxAjssR18NPR+LoAFG+sQ70lyMJCflFpcq+ZJYJzpodbu5Kushz
        c2G+1ttnATf5pGPhhozHanoQF5+/jYCF0IxNVzo=
X-Google-Smtp-Source: AGHT+IFJsNRp/SJBQPV/ihjFMsqVZtF8CCaLdXIsRTAMH0LJmkC+CiTHzfgURtuijL9H4D73IQs2rFDcowit2lJ8Ixo=
X-Received: by 2002:a4a:b807:0:b0:57b:3b64:7ea5 with SMTP id
 g7-20020a4ab807000000b0057b3b647ea5mr21393293oop.1.1697104115565; Thu, 12 Oct
 2023 02:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230929174442.1635558-1-bgeffon@google.com>
In-Reply-To: <20230929174442.1635558-1-bgeffon@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Oct 2023 11:48:24 +0200
Message-ID: <CAJZ5v0g6160NYtRQun0D_qS-R6NfoXrX47muWt+sTN3wnNyHeA@mail.gmail.com>
Subject: Re: [PATCH] pid: Allow frozen userspace to reboot from non-init pid ns
To:     Brian Geffon <bgeffon@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 7:45 PM Brian Geffon <bgeffon@google.com> wrote:
>
> When the system has a frozen userspace, for example, during hibernation
> the child reaper task will also be frozen. Attmepting to deliver a
> signal to it to handle the reboot(2) will ultimately lead to the system
> hanging unless userspace is thawed.
>
> This change checks if the current task is the suspending task and if so
> it will allow it to proceed with a reboot from the non-init pid ns.
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Reported-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

If the report is public, which I think is the case, having a Link: tag
pointing to it here would be nice.

> ---
>  kernel/pid_namespace.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 0bf44afe04dd..4a93a5063eda 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -321,6 +321,15 @@ int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
>         if (pid_ns == &init_pid_ns)
>                 return 0;
>
> +       if (current->flags & PF_SUSPEND_TASK) {
> +               /*
> +                * Attempting to signal the child_reaper won't work if it's
> +                * frozen. In this case we shutdown the system as if we were in
> +                * the init_pid_ns.
> +                */

Is the system guaranteed to be in the right state for a shutdown at this point?

There is a system-wide suspend-resume or hibernation in progress, so
system_transition_mutex should be held and that should cause reboot()
to block anyway.  Do you know why it doesn't block and why the suspend
task has any reason to call it?

> +               return 0;
> +       }
> +
>         switch (cmd) {
>         case LINUX_REBOOT_CMD_RESTART2:
>         case LINUX_REBOOT_CMD_RESTART:
> --
> 2.42.0.582.g8ccd20d70d-goog
>
