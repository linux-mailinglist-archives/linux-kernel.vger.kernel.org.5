Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55D77B3AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjI2UJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjI2UJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:09:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D761DE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:09:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68bed2c786eso11868133b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696018193; x=1696622993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m25Yzr9CC4eZhfakx0oo78KGRAEAUVnUwgN8BxtgWcU=;
        b=U5IDW8MP9cWFq4BwF3NGZLk0OqFeHft2BlTd78wPmHQGddSdC5oTBZ5t463dc+9yhV
         qNIrqdrx/TZISb15ebHJMmXZeNCWszYq6CgIrS0cx+jDzi/E4Y/J8e+yGwbn/YZ0NHWx
         vd85YI5pSOJ5Zsv4HPAgOKnlae3ZbUtHxy/7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696018193; x=1696622993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m25Yzr9CC4eZhfakx0oo78KGRAEAUVnUwgN8BxtgWcU=;
        b=jEdrq0fZ1a1YvDRCeCYEgF1TcU8UNwuXhFQY0cZPthdXVDiJlKHWUHSecmZwxoXxzR
         fjHTEJHZtWd7ZW2CaRWl7w7d2OnWaCFmA129KLKv4aExSR+CLX5n5mNqC8aFss3jtRoS
         W2aSSHHkz9ZDBVEBwa/HCFU5aNUiHSW4LrgAQXa187Ky+/Dy+uoeAe4wYabxjAQqAxW2
         nKPwkhDMZsT3gUo5rWe+H2RKb6O4GnkGTz/q6cT0aGhF0Eid1SOc7ihP2dLGqjL570Px
         sUAzQdpVdBtA1MFH7TMWLtJ3GartqLZlHnHu4bJVAFBgysY/HBdTBQLtKkpegLchCAlu
         DD6A==
X-Gm-Message-State: AOJu0YzNZKOM2nKrnIIDPV9WLkig7NkTkrtM7vgOB2NvI9Xrd+LHXuHF
        M8ZwWfN5zRHF+8td/z49G7uEsw==
X-Google-Smtp-Source: AGHT+IE1RFfQHH0BBOO/TIffLvVMKk8urNLd/YKLeiWFeZq9Sj+X8wfEw4kxAhBT2KxBy+k/oJkN0A==
X-Received: by 2002:a05:6a21:19f:b0:13c:988c:e885 with SMTP id le31-20020a056a21019f00b0013c988ce885mr6001485pzb.56.1696018193583;
        Fri, 29 Sep 2023 13:09:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e22-20020a62aa16000000b0068fba4800cfsm15307592pff.56.2023.09.29.13.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:09:53 -0700 (PDT)
Date:   Fri, 29 Sep 2023 13:09:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid: Allow frozen userspace to reboot from non-init pid
 ns
Message-ID: <202309291304.9AC4F5CFB@keescook>
References: <20230929174442.1635558-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929174442.1635558-1-bgeffon@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 01:44:42PM -0400, Brian Geffon wrote:
> When the system has a frozen userspace, for example, during hibernation
> the child reaper task will also be frozen. Attmepting to deliver a
> signal to it to handle the reboot(2) will ultimately lead to the system
> hanging unless userspace is thawed.
> 
> This change checks if the current task is the suspending task and if so
> it will allow it to proceed with a reboot from the non-init pid ns.

I don't know the code flow too well here, but shouldn't init_pid_ns
always be doing the reboot regardless of anything else?

Also how is this syscall running if current is frozen? This feels weird
to me... shouldn't the frozen test be against pid_ns->child_reaper
instead of current?

-Kees

-- 
Kees Cook
